<script>
    // This is done in a single file for clarity. A more factored version here: https://svelte.dev/repl/288f827275db4054b23c437a572234f6?version=3.38.2
    import { dndzone } from 'svelte-dnd-action';
    import { createEventDispatcher, onMount } from 'svelte';
    import Modal from "./Modal.svelte";
    import VideoModal from "./VideoModal.svelte";
    let video_modal;

    let timerId;
    const dispatcher = createEventDispatcher();
    export let columnItems, stage, max_questions;
    let show_modal = false;
    const flipDurationMs = 200;
    function handleDndConsiderCards(cid, e) {
        const colIdx = columnItems.findIndex(c => c.id === cid);
        columnItems[colIdx].items = e.detail.items;
        columnItems = [...columnItems];
    }
    function handleDndFinalizeCards(cid, e) {
        const colIdx = columnItems.findIndex(c => c.id === cid);
        columnItems[colIdx].items = e.detail.items;
        console.log(e.detail)
        if (colIdx == 2 && columnItems[colIdx].items.length != 0){
            columnItems[colIdx].items[0].visible = true;
            for (let i = 1; i < columnItems[colIdx].items.length; ++i){
                columnItems[colIdx].items[i].visible = false;
            }
        }
        if (columnItems[2].items.length == 0 && colIdx == 2){
            console.log(stage)
            show_modal = columnItems[2].items.length == 0;
        }
        columnItems = [...columnItems];
    }
    function handleClick(e) {
        alert('dragabble elements are still clickable :)');
    }
    function button_hold(e) {
        e.currentTarget.style.animation = "none";
    }
    let randomNumbers = [];
    onMount(() => {
        randomNumbers = Array.from({length: 10}, () => (Math.random() * 2 - 1) * 10);
        console.log(randomNumbers);
    })
    function timeout_video(fname) {
        console.log("timeout")
        timerId = setTimeout(() => {
            video_modal.show()
        }, 3000)
    }
    function clear_timeout_video() {
        clearTimeout(timerId)
    }
</script>
<style>
    .bubble_sway {
        animation: sway 5s ease-in-out infinite;
        transform-origin: center bottom;
    }
    .bubble {
        width: 10px;
        height: 10px;
        position: absolute;
        opacity: 0.9;
        border-radius: 50%;
        transform: translate(0, 0);
        background-image: url("public/bubble.png");
        background-size: contain;
    }
    .bubble_container {
        position: relative;
        box-shadow: 5px 5px teal;
    }

    @keyframes sway {
        0% { transform: rotate(-10deg); }
        50% { transform: rotate(10deg); }
        100% { transform: rotate(-10deg); }
    }
    .animate {
        animation: bubble 1s ease-out infinite;
    }

    @keyframes bubble {
        0% {
            transform: scale(0);
            opacity: 0.9;
            transform: translateY(0)
        }
        50% {
            opacity: 0.5;
        }
        100% {
            transform: scale(1.2);
            opacity: 0;
            transform: translateY(-1600%);
        }
    }
</style>
<section class="container-fluid">
    <div class="row w-100 h-25">
    {#each columnItems as column (column.id)}
        <div class="col-6 m-auto board_column" class:h-50={column.id == 3} class:d-none={column.id == 3 && column.items.length == 0}>
            <div class="column-title">{column.name}</div>
            <div class="d-flex flex-column" class:min-vh-50={column.id != 3} use:dndzone={{items:column.items, flipDurationMs}}
                 on:consider={(e) => handleDndConsiderCards(column.id, e)} on:finalize={(e) => handleDndFinalizeCards(column.id, e)}>
                {#each column.items as item (item.id)}
                    <div class="btn-light btn col-12 col-md-6 col-lg-3 border-2 rounded-circle my-3 mx-auto px-0 py-5 col-4 bubble_container"
                         class:d-none="{item.visible === undefined || !item.visible}"
                    on:mousedown="{button_hold}"
                    on:touchstart="{button_hold}"
                    data-toggle="tooltip" data-placement="top" title="{item.desc}"
               >
                   {item.name}
                   {#each randomNumbers as n}
                       <div class="bubble animate" style="animation-duration: {Math.abs(n) + 5}s; left: calc(50% - {(Math.random() * 2 - 1) * 10}%);"></div>
                   {/each}
               </div>
           {/each}
       </div>
   </div>
{/each}
</div>
</section>
{#if columnItems[2].items.length == 0}
<button type="button" class="btn btn-primary p-5" data-bs-toggle="modal" data-bs-target="#exampleModal">
   Done
</button>
{/if}
<Modal bind:show_modal bind:stage bind:max_questions message="Let's get to know you even better!" body="Or get your recommendations right now!"/>
<VideoModal bind:video_modal></VideoModal>
