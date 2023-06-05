<script>
    import { onMount } from 'svelte';
    import Event from './Event.svelte';
  
    export let group;
  
    let events = [];
  
    onMount(async () => {
        console.log(group)
        try {
            const response = await fetch(`http://localhost:8080/event/all/${group}`);
            if (response.ok) {
                events = await response.json();
            } else {
            console.error('Failed to fetch events');
            }
        } catch (error) {
            console.error('Failed to fetch events', error);
        }
    });
  </script>
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
      />
    {/each}
  {:else}
    <p>No events available</p>
  {/if}
  