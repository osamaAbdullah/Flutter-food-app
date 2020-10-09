const functions = require('firebase-functions');
const cors = require('cors')({origin: true});
const Busboy = require('busboy');
const os = require('os');
const path = require('path');
const fs = require('fs');
const firebaseAdmin = require('firebase-admin');


const { v4: uuidv4 } = require('uuid');



// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// Imports the Google Cloud client library
const {Storage} = require('@google-cloud/storage');

// Creates a client
const GCService = new Storage({
                                 projectId: 'flutter-test-8ae0a',
                                 keyFilename: 'functions/private_key.json'
                               });

firebaseAdmin.initializeApp({credential: firebaseAdmin.credential.cert('functions/private_key.json')});

exports.storeImage = functions.https.onRequest((request, response) => {
  return cors(request, response, () => {
    if(request.method !== 'POST') {
      return response.status(500).json({message: 'Not allowed.'});
    }
    if (!request.headers.authorization || !request.headers.authorization.startsWith('Bearer ')) {
      return response.status(401).json({error: 'Not Unauthenticated.'});
    }
    let idToken;
    idToken = request.headers.authorization.split('Bearer ')[1];
    const busboy = new Busboy({headers: request.headers});
    let uploadData;
    let oldImagePath;
    busboy.on('file', (fieldName, file, fileName, encoding, mimetype) => {
      const filePath = path.join(os.tmpdir(), fileName);
      uploadData = {filePath: filePath, type: mimetype, name: fileName};
      file.pipe(fs.createWriteStream(filePath));
    });
    busboy.on('field', (fieldName, value) => {
      oldImagePath = decodeURIComponent(value);
    });
    busboy.on('finish', (fieldName, value) => {
      const bucket = GCService.bucket('flutter-test-8ae0a.appspot.com');
      const id = uuidv4();
      let imagePath = 'images/' + id + '-' + uploadData.name;
      if (oldImagePath) {
        imagePath = oldImagePath;
      }
      return firebaseAdmin.auth().verifyIdToken(idToken)
          .then((decodedToken) => {
            return bucket.upload(uploadData.filePath, {
              uploadType: 'media',
              destination: imagePath,
              metadata: {
                metadata: {
                  contentType: uploadData.type,
                  firebaseStorageDownloadToken: id,
                }
              }
            });
          })
          .then(() => {
            return response.status(201).json({
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' +
                  bucket.name +
                  '/o/' +
                  encodeURIComponent(imagePath) +
                  '?alt=media&token=' + id,
              imagePath: imagePath
            });
          })
          .catch((error) => {
            return response.status(401).json({error: 'Not Unauthenticated.'});
          })
    });
    return busboy.end(request.rawBody);
  });
});