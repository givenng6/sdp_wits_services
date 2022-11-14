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

router.get("/Init",async (req, res)=>{

    const bookings = [
        {
            id:"test1",
            counsellor:"a2355285@wits.ac.za",
            counsellorName:"Sabelo Mabena",
            creator:"2355285@students.wits.ac.za",
            date:"07/11/2022",
            description:"Some description",
            location:"Online",
            status:"Pending",
            studentName:"Lindokuhle Mabena",
            time:"08:00-09:00"
        },
        {
            id:"test2",
            counsellor:"",
            counsellorName:"",
            creator:"2355285@students.wits.ac.za",
            date:"07/11/2022",
            description:"Some description",
            location:"In Person",
            status:"Pending",
            studentName:"Lindokuhle Mabena",
            time:"08:00-09:00"
        },
        {
            id:"test3",
            counsellor:"",
            counsellorName:"",
            creator:"2355285@students.wits.ac.za",
            date:"07/11/2022",
            description:"Some description",
            location:"Online",
            status:"Pending",
            studentName:"Lindokuhle Mabena",
            time:"08:00-09:00"
        },
    ];

    // const ref = doc(db,"Appointments",)
    for(var i=0;i<bookings.length;i++){
        const curr = bookings[i];
        const ref = doc(db,"Appointments",curr.id);
        await setDoc(ref,curr);
    }
    res.send({status:"Done"});

});

router.get("/Cleanup",async (req, res)=>{
    const bookings = ["test1","test2","test3"];
    for(var i=0;i<bookings.length;i++){
        const curr = bookings[i];
        const ref = doc(db,"Appointments",curr);
        await deleteDoc(ref);
    }
    res.send({ status: "success"});
});


export default router;