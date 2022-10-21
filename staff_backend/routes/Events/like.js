import express from "express";
import { db } from "../../firebase-config.js";
import { doc, setDoc, getDoc, updateDoc } from "firebase/firestore";

const router = express.Router();

router.post("/", async (req, res) => {
    const { id, isLiking, email } = req.body;

    const snapshot = await getDoc(doc(db, "Events", `${id}`));

    if (snapshot.exists()) {
        if (isLiking) {
            snapshot.data();
            let likes = snapshot.data().likes;
            likes.push(email);

            await updateDoc(doc(db, "Events", `${id}`), {
                likes: likes
            });
        } else {
            let likes = snapshot.data().likes;
            likes = likes.filter(item=>item!==email);

            await updateDoc(doc(db, "Events", `${id}`), {
                likes: likes
            });
        }

    } else {
        console.log("No such document!");
    }

    res.send('done');
    console.log("Liked");
});

export default router;