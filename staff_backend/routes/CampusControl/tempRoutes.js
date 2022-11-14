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
  deleteField,
} from "firebase/firestore";
import { data } from "./tempData.js";

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

router.get("/AddStudents", async (req, res) => {
  const workingRef = doc(db, "CampusControl", "Working");
  await updateDoc(workingRef, {
    unavailableCars: arrayRemove("KSD 731 GP"),
    takenCampus: arrayRemove("Business School"),
  });

  const { students, campusName } = data;
  const ref = doc(db, "CampusControl", campusName);
  for (const student of students) {
    var email = student.email.split("@")[0];
    await updateDoc(ref, { [`students.${email}`]: student });
    const ridesRef = doc(db, "Rides", student.email);
    await setDoc(ridesRef, student);
  }
  res.send("");
});

router.get("/RemoveStudents", async (req, res) => {
  const { students, campusName } = data;

  const ref = doc(db, "CampusControl", campusName);
  for (const student of students) {
    var email = student.email.split("@")[0];
    try {
      await updateDoc(ref, { [`students.${email}`]: deleteField() });
      const ridesRef = doc(db, "Rides", student.email);
      await deleteDoc(ridesRef);
    } catch (err) {}
  }
  await updateDoc(doc(db, "Users", "a2355285@wits.ac.za"), {
    department: "CCDU",
  });
  res.send("");
});

router.post("/RemoveDep", async (req, res) => {
  const { email } = req.body;

  const ref = doc(db, "Users", email);
  await updateDoc(ref, { department: deleteField() });

  res.send("");
});

export default router;
