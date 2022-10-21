import express from "express";
import { db } from "../../firebase-config.js";
import { doc, setDoc } from "firebase/firestore"; 

const router = express.Router();

router.post("/", async (req, res) => {
  const {event} = req.body;

  await setDoc(doc(db, "Events", `${event.id}`), event);

//   await update(ref(db, `Events/${event.id}`), event);
  res.send('done');
  console.log("updated");
});

export default router;