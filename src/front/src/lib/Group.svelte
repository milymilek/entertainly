<script>
    import Eliza from 'elizabot';
    import {beforeUpdate, afterUpdate} from 'svelte';
    import {getAccessTokenFromCookie} from './common.js'
    import EventForm from './EventForm.svelte';
    import EventOrganizer from './EventOrganizer.svelte';

    export let group;
    let chat_selected = false;
    let selected_option = "chat"

    let div;
    let autoscroll;

    beforeUpdate(() => {
        autoscroll = div && (div.offsetHeight + div.scrollTop) > (div.scrollHeight - 20);
    });

    afterUpdate(() => {
        if (autoscroll && chat_selected) div.scrollTo(0, div.scrollHeight);
    });

    const eliza = new Eliza();

    let comments = [];

    function handleButtonClick(value) {
        selected_option = value;
        console.log(value)
    }

    function handleChatButtonClick() {
        fetch(`http://localhost:8080/chat/history/${group}`, {
            method: "GET",
            headers: {
                "Authorization": getAccessTokenFromCookie(),
            },
        }).then(response => response.json())
            .then(data => {
                data.forEach(d => {
                    const text = d.content
                    comments = comments.concat({
                        author: 'eliza',
                        text
                    });
                })
                // connect()
            })
            .catch((error) => {
                console.log("Error: ", error);
            })
    }

    function handleKeydown(event) {
        if (event.key === 'Enter') {
            const text = event.target.value;
            if (!text) return;

            comments = comments.concat({
                author: 'user',
                text
            });

            event.target.value = '';

            const reply = eliza.transform(text);

            setTimeout(() => {
                comments = comments.concat({
                    author: 'eliza',
                    text: '...',
                    placeholder: true
                });

                setTimeout(() => {
                    comments = comments.filter(comment => !comment.placeholder).concat({
                        author: 'eliza',
                        text: reply
                    });
                }, 500 + Math.random() * 500);
            }, 200 + Math.random() * 200);
        }
    }
    //
    // function onMessageReceived(payload) {
    //     var message = JSON.parse(payload.body);
    //     console.log(message)
    // }
    //
    // function onConnected() {
    //     stompClient.subscribe('/topic/public', onMessageReceived);
    //
    //     throw fetch(`http://localhost:8080//username`, {
    //         method: "GET",
    //         headers: {
    //             "Authorization": getAccessTokenFromCookie(),
    //         },
    //     }).then(response => {
    //         console.log(response)
    //         var chatMessage = {
    //             sender: response.body,
    //             categoryName: `${group}`,
    //             type: 'JOIN'
    //         };
    //         stompClient.send("/app/chat.addUser",
    //             {},
    //             JSON.stringify(chatMessage)
    //         )
    //     })
    //
    // }
    //
    // function connect(event) {
    //
    //     var socket = new SockJS('/ws');
    //
    //
    //     stompClient = Stomp.over(socket);
    //
    //     var header = {
    //         "Authorization" : getAccessTokenFromCookie(),
    //     }
    //
    //     stompClient.connect(header, onConnected, onError);
    //
    //     event.preventDefault();
    // }
    let myEvents;


</script>

<style>
    .chat {
        display: flex;
        flex-direction: column;
        height: 100%;
        max-height: 100%;
        /*max-width: 320px;*/
    }

    .eliza {
        text-align: left;
    }

    .scrollable {
        flex: 1 1 auto;
        border-top: 1px solid #eee;
        margin: 0 0 0.5em 0;
        overflow-y: auto;
    }

    article {
        margin: 0.5em 0;
    }

    .user {
        text-align: right;
    }

    span {
        padding: 0.5em 1em;
        display: inline-block;
    }

    .eliza span {
        background-color: #eee;
        border-radius: 1em 1em 1em 0;
    }

    .user span {
        background-color: #0074D9;
        color: white;
        border-radius: 1em 1em 0 1em;
        word-break: break-all;
    }
</style>

<!-- <input type="radio" class="btn-check" name="chat_or_group_options" id="chat_option" autocomplete="off" value="{true}" bind:group={chat_selected}>
<label class="btn btn-secondary" for="chat_option">Chat</label>

<input type="radio" class="btn-check" name="chat_or_group_options" id="event_option" value="{false}" autocomplete="off" bind:group={chat_selected}>
<label class="btn btn-secondary" for="event_option">Wydarzenia</label> -->

<!--<input type="button" class="btn-check" name="chat_option" id="chat_option"-->
<!--       on:click={() => handleButtonClick("chat")}>-->
<input type="button" class="btn-check" name="chat_option" id="chat_option"
       on:click={() => handleChatButtonClick("chat")}>
<label class="btn btn-secondary" for="chat_option">Chat</label>
<input type="button" class="btn-check" name="events_option" id="events_option"
       on:click={() => handleButtonClick("events")}>
<label class="btn btn-secondary" for="events_option">Wydarzenia</label>
<input type="button" class="btn-check" name="my_events_option" id="my_events_option"
       on:click={() => handleButtonClick("my_events")}>
<label class="btn btn-secondary" for="my_events_option">Moje wydarzenia</label>
<input type="button" class="btn-check" name="options_button" id="add_event_option"
       on:click={() => handleButtonClick("add_event")}>
<label class="btn btn-secondary" for="add_event_option">Dodaj wydarzenie</label>

<br/>
<br/>
<h1>{group}</h1>
<br/>
<!-- {#if chat_selected === true} -->
{#if selected_option === "chat"}
    <div class="chat m-auto bg-opacity-50 bg-gradient">

        <div class="scrollable" bind:this={div}>
            {#each comments as comment}
                <article class={comment.author}>
                    <span>{comment.text}</span>
                </article>
            {/each}
        </div>

        <input class="w-50 m-auto" on:keydown={handleKeydown}>
    </div>
{:else if selected_option === "events"}
    <EventOrganizer {group} myEvents={false}/>

{:else if selected_option === "my_events"}
    <EventOrganizer {group} myEvents={true} />

{:else if selected_option === "add_event"}
    <EventForm {group}/>

{/if}
