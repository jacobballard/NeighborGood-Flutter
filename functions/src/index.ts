import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

export const createUserEntry = functions.auth.user().onCreate(async (user: functions.auth.UserRecord) => {
  const {uid, email, displayName} = user;

  // Check if the user is anonymous, return early if true
  if (user.providerData.length === 0 || user.providerData[0].providerId === "anonymous") {
    console.log("Anonymous user, skipping Firestore entry creation:", user.uid);
    return;
  }

  const newUser = {
    uid,
    email,
    displayName,
    role: "buyer",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  try {
    await admin.firestore().collection("users").doc(uid).set(newUser);
    console.log("User data saved to Firestore:", uid);
  } catch (error) {
    console.error("Error saving user data to Firestore:", error);
  }
});
