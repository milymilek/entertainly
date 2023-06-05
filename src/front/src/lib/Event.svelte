<script>
    import { createEventDispatcher } from 'svelte';
    import {getAccessTokenFromCookie} from "./common.js";
    export let id;
    export let eventCreatorId;
    export let startTime
    export let endTime;
    export let address;
    export let description;
    export let category;
    let participants;
    let isRegistered = false;

    const dispatch = createEventDispatcher();

    async function saveEvent() {
        const token = getAccessTokenFromCookie();
        if (!isRegistered) {
            isRegistered = true;

            const response = await fetch('http://localhost:8080/signup', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `${token}`,
                },
                body: JSON.stringify(id),
            });

            if (response.ok) {
                console.log("Saving ended succesfully")
            } else {
                // Dodatkowa logika w przypadku błędu
            }
        }
    }

  </script>

<div class="event">
    <p>{description}</p>
    <p>Start: {startTime}</p>
    <p>End: {endTime}</p>
    <p>Address: {address}</p>
    <button class="save-button" on:click={saveEvent}>Zapisz się</button>
</div>
  
  <style>
    .event {    
      border: 1px solid #ccc;
      padding: 10px;
      margin-bottom: 10px;
    }
  
    .p {
      font-size: 10px;
      font-weight: bold;
    }
  
    .save-button {
      background-color: #007bff;
      color: #fff;
      padding: 5px 10px;
      border: none;
      cursor: pointer;
    }
  </style>