<script>
  import {createEventDispatcher, onMount} from 'svelte';
    import Event from './Event.svelte';
    import {getAccessTokenFromCookie} from "./common.js";
  
    export let group;
    export let myEvents;
  
    let events = [];

    const dispatch = createEventDispatcher();
  
    onMount(async () => {
      fetchEventList();
    });

    async function fetchEventList() {
      if(!myEvents) {
        try {
          const response = await fetch(`http://localhost:8080/event/all/${group}`);
          if (response.ok) {
            events = await response.json();
            console.log(events)
          } else {
            console.error('Failed to fetch events');
          }
        } catch (error) {
          console.error('Failed to fetch events', error);
        }
      }
      else{
        try {
          const token = getAccessTokenFromCookie();
          const response = await fetch("http://localhost:8080/event/myEvents", {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "Authorization": `${token}`,
            }
          });

          if (response.ok) {
            events = await response.json();
          } else {
            console.error('Failed to fetch events');
          }
        } catch (error) {
          console.error('Failed to fetch events', error);
        }
      }
    }
  </script>
  <div class="events-container">
    {#if events.length > 0}
      {#each events as event}
        <Event
          id={event.id}
          eventCreatorId={event.eventCreatorId}
          startTime={event.startTime}
          endTime={event.endTime}
          address={event.address}
          description={event.description}
          category={event.categoryName}
          isRegistered={myEvents}
          {fetchEventList}
        />
      {/each}
    {:else}
      <p>No events available</p>
    {/if}
  </div>

<style>
  .events-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
  }
</style>
  