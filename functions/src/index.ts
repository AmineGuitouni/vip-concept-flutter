import {google} from "googleapis";
import {onRequest, onCall} from "firebase-functions/v2/https";
import axios from "axios";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const checkHealth = onRequest((request, response) => {
  response.send({data: "success"});
});

export const getLocations = onCall(async (request) => {
  const accessToken = request.data.accessToken;
  const userId = request.data.userId;

  const info = google.mybusinessbusinessinformation("v1");

  const {data} = await info.accounts.locations.list({
    access_token: accessToken,
    parent: `accounts/${userId}`,
    readMask: "name,title,websiteUri,metadata,profile",
  });

  return data;
});

export const getReviews = onCall(async (request) =>{
  const accessToken = request.data.accessToken;
  const userId = request.data.userId;
  const locationId = request.data.locationId;

  const headers = {Authorization: `Bearer ${accessToken}`};
  const res = await axios.get(`https://mybusiness.googleapis.com/v4/accounts/${userId}/${locationId}/reviews`, {headers});
  return res.data;
});
