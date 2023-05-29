<script>
    let login = true;
    export let stage;
    function submit() {
        console.log("xd")
        let creds = {
            username: document.getElementById("username").value,
            password: document.getElementById("password").value,
        }
        fetch("http://10.0.5.58:8080/signup", {
            method: "POST",
            headers: {
                //"Access-Control-Allow-Origin": "http://10.0.5.58",
                'Content-Type': 'application/json',
                //'mode': 'cors'
            },
            body: JSON.stringify(creds)
        }).then(function (response) {
            return response.json();
        }).then(function (response) {
            console.log(response);
        })
    }
</script>
<div class="card bubble col-12 h-100">
    <div class="row g-0 ">
        <div class="col-md-8">
            <img src="public/kosciuszkon.jpg" class="img-fluid rounded-start img-thumbnail" alt="...">
        </div>
        <div class="col-md-4">
            <div class="card-body d-flex flex-column align-items-center justify-content-between h-100">
                <h5 class="card-title mb-4">
                    {login ? "Login" : "Register"}
                </h5>
                <button class="btn my-2 my-md-0 btn-primary" on:click={() => {++stage}}>Browse anonymously</button>
                <div class="input-group mb-2">
                    <span class="input-group-text" id="login-login">@</span>
                    <input type="text" name="password" class="form-control" placeholder="Username" id="username" aria-label="Username" aria-describedby="User Login Input">
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" id="login-passwd">#</span>
                    <input type="password" class="form-control" placeholder="" aria-label="Password" id="password" aria-describedby="Password Login Input">
                </div>
                <div class="input-group mb-2" class:invisible={login}>
                    <span class="input-group-text" id="login-passwd2">#2</span>
                    <input bind:disabled={login} type="password" name="password" class="form-control" placeholder="" aria-label="Password" aria-describedby="Repeat Password Login Input">
                </div>
                <div class="d-flex flex-column flex-md-row justify-content-between col-4 col-md-6 mx-2 align-items-end align-self-end">
                    <button class="btn my-2 my-md-0 btn-primary align-self-end" on:click={() => {++stage}}>{login ? "Login" : "Register" }</button>
                    <div>or</div>
                    <button class="btn my-2 my-md-0 bg-body" on:click={() => login = !login}>{login ? "Register" : "Login" }</button>
                </div>
            </div>
        </div>
    </div>
</div>