<script>
    import { onMount } from 'svelte';
    import Event from './Event.svelte';
  
    export let group;
  
    let events = [];
  
    onMount(async () => {
        console.log(group)
        try {
            const response = await fetch(`/api/event/all/${group}`);
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
        title={event.title}
        description={event.description}
        date={event.date}
      />
    {/each}
  {:else}
    <p>No events available</p>
  {/if}
  