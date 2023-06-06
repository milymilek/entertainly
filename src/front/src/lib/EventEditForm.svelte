<script>
    // export let user;

    export let group;
    let eventDetails = {
        startTime: '',
        endTime: '',
        address: '',
        description: '',
        categoryName: group
    };
</script>

<style>
    .create-form {
        display: flex;
        flex-direction: column;
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #fff;
    }

    .create-form label {
        margin-bottom: 10px;
    }

    .create-form input[type="datetime-local"],
    .create-form input[type="text"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        background-color: white;
        color: black;
    }

    .create-form input[type="datetime-local"]::-webkit-calendar-picker-indicator {
        filter: invert(100%);
    }

    .create-form button[type="submit"] {
        background-color: #0d6efd;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
    }

    .create-form button[type="submit"]:hover {
        background-color: #0b5ed7;
    }
</style>

<div class="create-form">
    <form>
        <label>
            Start Time:
            <input type="datetime-local" bind:value={eventDetails.startTime} required />
        </label>

        <label>
            End Time:
            <input type="datetime-local" bind:value={eventDetails.endTime} required />
        </label>

        <button type="submit">Zapisz</button>
    </form>
</div>
