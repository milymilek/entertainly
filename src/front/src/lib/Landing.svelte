<script>
    let login = true;
    export let stage;
    let username = 'user';
    let email = 'user@mail.com';
    let password = 'pass';
    let confirmedPassword = 'pass';
    // function submit() {
    //     console.log("xd")
    //     let creds = {
    //         username: document.getElementById("username").value,
    //         password: document.getElementById("password").value,
    //     }
    //     fetch("http://10.0.5.58:8080/signup", {
    //         method: "POST",
    //         headers: {
    //             //"Access-Control-Allow-Origin": "http://10.0.5.58",
    //             'Content-Type': 'application/json',
    //             //'mode': 'cors'
    //         },
    //         body: JSON.stringify(creds)
    //     }).then(function (response) {
    //         return response.json();
    //     }).then(function (response) {
    //         console.log(response);
    //     })
    // }

    function register() {
        console.log("register")
        if(password !== confirmedPassword) {
            alert("Passwords do not match");
            return;
        }

        let creds = {
            username,
            email,
            password
        }

        fetch("http://localhost:8080/signup", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(creds)
        }).then((response) => {
            if(response.ok){
                console.log("User registered succesfully")
            }
            else {
                console.log("Registration failed");
            }
        })
        .catch((error) =>{
            console.log("Error: ", error);
        })

        // fetch("http://localhost:8080/test")
        // .then(response => response.text())
        // .then(data => {
        //     console.log(data);
        // })
    }

    function signin() {
        console.log("login")

        let creds = {
            username,
            password
        }

        fetch("http://localhost:8080/login", {
            method: "POST",
            headers: {
                "Content-type": "application/json",
            },
            body: JSON.stringify(creds)
        }).then((response) => {
            if(response.ok) {
                let token = response.headers.get('Authorization')
                document.cookie = `access_token=${token}`;
                console.log("Logged in succesfully");
                stage++;
            } else {
                console.log("Login failed");
            }
        }).catch((error) => {
            console.log("Error: ", error);
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
                    <input type="text" name="password" class="form-control" placeholder="Username" id="username" aria-label="Username" aria-describedby="User Login Input" bind:value={username}>
                </div>
                <div class="input-group mb-2" class:invisible={login}>
                    <span class="input-group-text" id="login-email">#2</span>
                    <input type="email" name="email" class="form-control" placeholder="" aria-label="Username" aria-describedby="User Email Input" bind:value={email}>
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" id="login-passwd">#</span>
                    <input type="password" class="form-control" placeholder="" aria-label="Password" id="password" aria-describedby="Password Login Input" bind:value={password}>
                </div>
                <div class="input-group mb-2" class:invisible={login}>
                    <span class="input-group-text" id="login-passwd2">@</span>
                    <input type="password" name="password" class="form-control" placeholder="" aria-label="Password" aria-describedby="Repeat Password Login Input" bind:value={confirmedPassword}>
                </div>

                <div class="d-flex flex-column flex-md-row justify-content-between col-4 col-md-6 mx-2 align-items-end align-self-end">
                    <!-- <button class="btn my-2 my-md-0 btn-primary align-self-end" on:click={() => {++stage}}>{login ? "Login" : "Register" }</button> -->
                    <button class="btn my-2 my-md-0 btn-primary align-self-end" on:click={() => login ? signin() : register()}>{login ? "Login" : "Register" }</button>
                    <div>or</div>
                    <button class="btn my-2 my-md-0 bg-body" on:click={() => login = !login}>{login ? "Register" : "Login" }</button>
                </div>
            </div>
        </div>
    </div>
</div>