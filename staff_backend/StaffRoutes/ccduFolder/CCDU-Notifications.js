import {
  query,
  where,
  onSnapshot,
  setDoc,
  collection,
  updateDoc,
  doc,
  addDoc,
  getDoc,
  deleteDoc,
  arrayUnion,
} from "firebase/firestore";
import { db } from "../../firebase-config.js";
import { SendNotificationToDevice } from "../../controllers/push_notification.controllers.js";

export const main = async () => {
//   console.log("In main");
    // SendNotificationToDevice("Some text", [
    //   "f5afcf0c-6db1-4c3c-8283-2129ebf7fb9e",
    // ]);

  const q = query(collection(db, "Appointments"));
  onSnapshot(q, (snapshot) => {
    snapshot.docChanges().forEach((change) => {
      if (change.type === "added") {
        // console.log("New : ", change.doc.data());
        if(change.doc.data().counsellor !="")handleAdded(change);
      }
      if (change.type === "modified") {
        // console.log("Modified : ", change.doc.data());
      }
      if (change.type === "removed") {
        // console.log("Removed : ", change.doc.data());
      }
    });
  });

  const handleAdded = async (change) => {
    const ref = doc(db, "Users", change.doc.data().counsellor);
    const userSnap = await getDoc(ref);
    if (userSnap.exists()) {
      const deviceIDs = userSnap.data().deviceIDs;
      if(deviceIDs !== undefined) {
        SendNotificationToDevice(
        "New appointemt",
        deviceIDs
      );
    }}
      
  };
};
