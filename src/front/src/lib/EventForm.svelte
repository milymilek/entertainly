<script>
    // export let user;
    import {getAccessTokenFromCookie} from "./common.js";

    export let group;
    let eventDetails = {
      startTime: '',
      endTime: '',
      address: '1',
      description: '1',
      categoryName: group
    };

    async function createEvent() {
      console.log(group)
      const token = getAccessTokenFromCookie();
      const response = await fetch('http://localhost:8080/event/new', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `${token}`
        },
        body: JSON.stringify(eventDetails)
      });
  
      if (response.ok) {
        alert('Event created successfully!');
        eventDetails.startTime = '';
        eventDetails.endTime = '';
        eventDetails.address = '';
        eventDetails.description = '';
      } else {
        alert('Failed to create event.');
        // Opcjonalnie możesz dodać logikę w przypadku błędu
      }
    }
  </script>
  
  <style>
    form {
      display: flex;
      flex-direction: column;
      max-width: 400px;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 4px;
      background-color: #fff;
    }
  
    label {
      margin-bottom: 10px;
    }
  
    input[type="datetime-local"],
    input[type="text"],
    textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
      background-color: white;
      color: black;
    }

    input[type="datetime-local"]::-webkit-calendar-picker-indicator {
        filter: invert(100%);
    }
  
    textarea {
      resize: vertical;
      min-height: 80px;
    }
  
    button[type="submit"] {
      background-color: #0d6efd;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 4px;
      cursor: pointer;
    }
  
    button[type="submit"]:hover {
      background-color: #0b5ed7;
    }
  </style>
  
  <form on:submit|preventDefault={createEvent}>
    <label>
      Start Time:
      <input type="datetime-local" bind:value={eventDetails.startTime} required />
    </label>
  
    <label>
      End Time:
      <input type="datetime-local" bind:value={eventDetails.endTime} required />
    </label>
  
    <label>
      Address:
      <input type="text" bind:value={eventDetails.address} required />
    </label>
  
    <label>
      Description:
      <textarea bind:value={eventDetails.description} required></textarea>
    </label>
  
    <button type="submit">Create Event</button>
  </form>
  