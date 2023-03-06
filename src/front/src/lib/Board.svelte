<script>
    // This is done in a single file for clarity. A more factored version here: https://svelte.dev/repl/288f827275db4054b23c437a572234f6?version=3.38.2
    import { flip } from 'svelte/animate';
    import { dndzone } from 'svelte-dnd-action';
    import { createEventDispatcher } from 'svelte';
    import Modal from "./Modal.svelte";

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
</script>
<section class="container-fluid">
    <div class="row w-100 h-25">
    {#each columnItems as column (column.id)}
        <div class="col-6 m-auto board_column" class:h-50={column.id == 3} class:d-none={column.id == 3 && column.items.length == 0}>
            <div class="column-title">{column.name}</div>
            <div class="d-flex flex-column" class:min-vh-50={column.id != 3} use:dndzone={{items:column.items, flipDurationMs}}
                 on:consider={(e) => handleDndConsiderCards(column.id, e)} on:finalize={(e) => handleDndFinalizeCards(column.id, e)}>
                {#each column.items as item (item.id)}
                    <div class="btn col-12 col-md-6 col-lg-3 border-2 rounded-circle my-3 mx-auto px-0 py-5 col-4 btn-primary" class:d-none="{item.visible === undefined || !item.visible}" animate:flip="{{duration: flipDurationMs}}" on:click={handleClick} a>
                        {item.name}
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
