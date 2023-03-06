<script>
    export let stage, max_questions;
</script>
<div class="navbar navbar-expand-md navbar-dark bg-dark my-3 bubble">
    <nav class="container-fluid d-flex" style="min-height: 30px;">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTopContent" aria-controls="navbarTopContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse align-self-center justify-content-end mt-2 mt-md-0" id="navbarTopContent">
            <div class="d-flex justify-content-between my-2 container-fluid">
                <button class="btn btn-primary p-1 p-md-3 m-1 m-md-0" type="button" on:click={() => {stage = max_questions + 2}}>My hobbies</button>
                <button class="btn btn-primary p-1 p-md-3 m-1 m-md-0" type="button" on:click={() => {stage = 1}}>Discover hobbies</button>
                <button type="button" href="cart" class="btn btn-primary p-1 p-md-3 m-1 m-md-0" on:click={() => {stage = 0}}>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-person" viewBox="0 0 16 16">
                        <path d="M12 1a1 1 0 0 1 1 1v10.755S12 11 8 11s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
                        <path d="M8 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                    </svg>
                    Account <span class="badge rounded-pill bg-danger" id="basket_count_span">0</span>
                </button>
            </div>
        </div>
    </nav>
</div>