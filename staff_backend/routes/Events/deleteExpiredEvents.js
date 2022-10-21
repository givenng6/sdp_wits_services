import express from "express";
import { db } from "../../firebase-config.js";
import { doc, setDoc, getDoc, updateDoc, deleteDoc } from "firebase/firestore";

const router = express.Router();

router.post("/", async (req, res) => {
    const { ids } = req.body;

    console.log("here");
    for(let i = 0; i < ids.length; i++) {
     await deleteDoc(doc(db, "Events", ids[i]));   
    }
    
    res.send('done');
    console.log("deleted");
});

export default router;