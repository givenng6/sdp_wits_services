import { ONE_SIGNAL_CONFIG } from "../config/app.config.js";
import { SendNotificationService } from "../services/push_notification.services.js";

export const SendNotificationToDevice = (text, playerIds) => {
  var message = {
    app_id: ONE_SIGNAL_CONFIG.APP_ID,
    contents: {
      en: text,
    },
    included_segments: ["included_player_ids"],
    include_player_ids: playerIds,
    content_available: true,
    small_icon: "ic_notofication_icon",
  };

  SendNotificationService(message, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      console.log({
        message: "Sucess",
        data: results,
      });
    }
  });
};
