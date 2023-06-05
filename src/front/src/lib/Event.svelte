<script>
    import { createEventDispatcher } from 'svelte';
    export let id;
    export let eventCreatorId;
    export let startTime
    export let endTime;
    export let address;
    export let description;
    export let category;
    export let participants;
    let isRegistered = false;

    const dispatch = createEventDispatcher();
  
    function saveEvent() {
        if(!isRegistered) {
            isRegistered = true;
            const event = {
                id: id,
                description: description,
                date: date
            };

            dispatch('saveEvent', event);
        }
    }
  </script>

<div class="event">
    <p class="event-description">{description}</p>
    <p class="event-date">Date: {date}</p>
    {#if !isRegistered}
        <button class="save-button" on:click={() => saveEvent()}>Zapisz się</button>
    {:else}
        <p>Already saved</p>
    {/if}
</div>
  
  <style>
    .event {    
      border: 1px solid #ccc;
      padding: 10px;
      margin-bottom: 10px;
    }
  
    .event-title {
      font-size: 18px;
      font-weight: bold;
    }
  
    .event-description {
      margin-top: 5px;
      margin-bottom: 10px;
    }
  
    .event-date {
      color: #888;
      font-size: 14px;
    }
  
    .save-button {
      background-color: #007bff;
      color: #fff;
      padding: 5px 10px;
      border: none;
      cursor: pointer;
    }
  </style>