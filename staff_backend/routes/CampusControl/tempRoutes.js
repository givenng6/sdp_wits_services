import express from "express";
import { db } from "../../firebase-config.js";
import {
  getDoc,
  collection,
  updateDoc,
  doc,
  addDoc,
  arrayUnion,
  arrayRemove,
  setDoc,
  deleteDoc,
} from "firebase/firestore";
import {data} from './tempData.js';

const router = express.Router();

router.post("/addVehicles", async (req, res) => {
  const { vehicles } = req.body;

  await updateDoc(doc(db, "CampusControl", "Original"), { vehicles });

  res.send("Done");
});

router.post("/addRes", async (req, res) => {
  const { residents } = req.body;

  await updateDoc(doc(db, "CampusControl", "Original"), { residents });

  res.send("Done");
});

router.post("/addCampus", async (req, res) => {
  const { campus } = req.body;

  await updateDoc(doc(db, "CampusControl", "Original"), { campus });

  res.send("Done");
});

router.post("/AddStudents", async (req, res) => {
  const { campusName, students } = req.body;
  const ref = doc(db, "CampusControl", campusName);

  if (students.length > 0) {
    for (const student of students) {
      var email = student.email.split("@")[0];
      await updateDoc(ref, { [`students.${email}`]: student });
    }
    res.send("");
  } else {
    const {students} = data;

    for (const student of students) {
      var email = student.email.split("@")[0];
      await updateDoc(ref, { [`students.${email}`]: student });
      // console.log(student);
    }
    res.send("");
  }
});
export default router;
