<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Attention</h5>
            </div>
            <div class="modal-body">
                Let's get to know you even more! Shall we?
            </div>
            <div class="modal-footer flex-column align-items-center justify-content-center">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Let me think about my current choice.</button>
                {#if stage < max_questions}
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" on:click={() => {handle_stage(++stage)}}>Yes! More questions!</button>
                {/if}
                <button type="button" class="btn btn-primary" on:click={() => {handle_stage(stage = max_questions + 1)}}>No, give me my recommendations.</button>
            </div>
        </div>
    </div>
</div>
<script>
    import {onMount, createEventDispatcher} from "svelte";
    import { Modal } from "bootstrap";
    export let stage, max_questions;

    let dispatcher = createEventDispatcher();

    export let show_modal = false ;
    let modal;
    onMount(() => {
        modal = new Modal("#exampleModal");
    });
    $: {
        if (show_modal && modal)
            modal.show();
    }
    function handle_stage(stage){
        dispatcher('stage', {'stage': stage})
        if (modal !== undefined)
            modal.hide();
        console.log(stage)
        console.log("MODAL")
    }
</script>