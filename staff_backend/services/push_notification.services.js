import { ONE_SIGNAL_CONFIG } from "../config/app.config.js";
import https from "https";

export const SendNotificationService = async (data,callback) => {
    var headers = {
        "Content-Type": "application/json",
        "Authorization":"Basic "+ONE_SIGNAL_CONFIG.API_KEY
    };

    var options = {
        host:"onesignal.com",
        port:443,
        path:"/api/v1/notifications",
        method:"POST",
        headers:headers
    }

    const req = https.request(options,(res)=>{
        res.on("data",data=>{
            console.log(JSON.parse(data));
            return callback(null,JSON.parse(data));
        });
    });

    req.on("error",(e)=>{
        return callback({
            message:e
        })
    });
    req.write(JSON.stringify(data));
    req.end();


}