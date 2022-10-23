import express from "express";
import { db } from "../../firebase-config.js";
import { uid } from "uid";
import {
  getDocs,
  collection,
  updateDoc,
  doc,
  getDoc,
  addDoc,
  arrayUnion,
  arrayRemove,
  setDoc,
  deleteDoc,
} from "firebase/firestore";

const router = express.Router();

//all pending appointents for specified(or unspecified) counsellor
router.post("/allPendingAppointments", async (req, res)=>{
    const email = req.body.email;

    const colRef = collection(db, "Appointments");
    let arr=[];
    try {
      const docsSnap = await getDocs(colRef);
      if(docsSnap.docs.length > 0) {
        //res.send("done");
         docsSnap.forEach(doc => {
            //
            if(doc.data().counsellor === email || doc.data().counsellor === ""){
                if(doc.data().status === "Pending"){
                    arr.push({...doc.data(),id:doc.id});
                }
            }
        })
      }
      res.send(arr);
  }catch(error){
    res.send(arr);
  }
}
)
//all accepted appointemts for specified(or unspecified) counsellor
router.post("/allAcceptedAppointments", async (req, res)=>{
    const email = req.body.email;

    const colRef = collection(db, "Appointments");
    let arr=[];
    try {
      const docsSnap = await getDocs(colRef);
      if(docsSnap.docs.length > 0) {
        //res.send("done");
         docsSnap.forEach(doc => {
            //
            if(doc.data().counsellor === email && doc.data().status === "Confirmed"){
                arr.push({...doc.data(),id:doc.id});
            }
        })
      }
      res.send(arr);
  }catch(error){
    res.send(arr);
  }
}
)

router.post("/acceptAppointment", async (req, res)=>{
    const {id,counsellor, counsellorName,link} = req.body;
    const ref = doc(db, 'Appointments',id);
    const docSnap = await getDoc(ref);
    if (docSnap.exists()) {
        if(docSnap.data().location === "Online"){
            updateDoc(ref,{status:'Confirmed',counsellor, counsellorName,link});
            res.send('status changed to Confirmed');
        }
        else{
            updateDoc(ref,{status:'Confirmed',counsellor, counsellorName});
            res.send('status changed to Confirmed');
        }
    } else {
      console.log("No such document!");
      res.send('No such document!');
    }//
  }
)
export default router;