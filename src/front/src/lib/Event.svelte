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
    export let isRegistered = false;
    export let fetchEventList;
    let newStartTime;
    let newEndTime;

    const dispatch = createEventDispatcher();

    async function saveEvent() {
        const token = getAccessTokenFromCookie();
        const url = new URL('http://localhost:8080/event/signup');
        url.searchParams.append('eventId', id);

        const response = await fetch(url.toString(), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${token}`,
            },
        });

        if (response.ok) {
            console.log("Saving ended succesfully")
        } else {
            console.log(response)
        }
    }

    async function leaveEvent() {
        const token = getAccessTokenFromCookie();
        const response = await fetch(`http://localhost:8080/event/leave/${id}`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
                Authorization: `${token}`,
            },
        });

        if (response.ok) {
            console.log('User left the event');
            fetchEventList();
        } else {
            console.log('Error:', response.status);
        }
    }

    async function deleteEvent() {
        const token = getAccessTokenFromCookie();
        try {
            const response = await fetch(`http://localhost:8080/event/delete/${id}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `${token}`,
                },
            });

            if (response.ok) {
                console.log('Event deleted');
                fetchEventList();

            } else {
                console.log('Error:', response.status);
            }
        } catch (error) {
            console.error('Failed to delete event', error);
        }
    }

    async function editEvent() {
        // Pobierz token dostępu
        const token = getAccessTokenFromCookie();

        // Wyślij żądanie PATCH do backendu
        const url = `http://localhost:8080/event/update`;
        const body = {
            eventId: id,
            newStartTime: newStartTime,
            newEndTime: newEndTime
    };

        try {
            const response = await fetch(url, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `${token}`,
                },
                body: JSON.stringify(body),
            });

            if (response.ok) {
                console.log('Event updated');
                fetchEventList();
            } else {
                console.log('Error:', response.status);
            }
        } catch (error) {
            console.error('Failed to update event', error);
        }
    }


</script>

<div class="event">
    <p class="p-desc">{description}</p>
    <hr/>
    <p>Start: {startTime}</p>
    <p>End: {endTime}</p>
    <p>Address: {address}</p>
    <br/>
    {#if !isRegistered}
        <button class="save-button" on:click={saveEvent}>Zapisz się</button>
        <button class="delete-button" on:click={deleteEvent}>Usuń</button>
<!--        <button class="edit-button" on:click={editEvent}>Edytuj</button>-->
    {:else}
        <button class="leave-button" on:click={leaveEvent}>Anuluj zapis</button>
    {/if}
</div>

<style>
    .event {
        border: 1px solid #ccc;
        padding: 10px;
        margin-bottom: 10px;
        background-color: #f5f5f5;
        border-radius: 4px;
        /*width: 600px;*/
        width: 45vw;
    }

    .event p {
        margin: 5px 0;
        font-size: 1em;
    }

    .event button {
        color: #fff;
        padding: 8px 16px;
        min-width: 8vw;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
        text-transform: uppercase;
    }

    .event .leave-button {
        background-color: #b40000;
    }

    .event .leave-button:hover {
        background-color: #7e0000;;
    }

    .event .delete-button {
        background-color: #464646;
    }

    .event .save-button {
        background-color: #007bff;
    }

    .event .save-button:hover {
        background-color: #0056b3;
    }

    .event .delete-button:hover{
        background-color: black;
    }


    .event .edit-button {
        background-color: #ffa500;
    }

    .event .edit-button:hover {
        background-color: #ff8000;
    }
</style>