<script>
    import { onMount } from 'svelte'
    import {Modal} from 'bootstrap'
    export let fname;
    export let video_modal;
    onMount(() => {
        video_modal = new Modal("#videoModal")
    })

</script>
<div class="modal fade" id="videoModal" tabindex="-1" aria-labelledby="videoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="videoModalLabel">Video Modal</h5>
            </div>
            <div class="modal-body">
                <img src="public/sample.gif" />
                <!--<video src="{fname + '.mp4'}"></video>-->
            </div>
        </div>
    </div>
</div>