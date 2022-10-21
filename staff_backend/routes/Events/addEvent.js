import express from "express";
import { db } from "../../firebase-config.js";
import { ref, child, get, update } from "firebase/database";

const router = express.Router();

router.post("/", async (req, res) => {
  const {event} = req.body;
  await update(ref(db, `posts/${event.id}`), event);
  res.send('done');
  console.log("updated");
});

export default router;