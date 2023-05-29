<svelte:head>
    <link rel="stylesheet" href="node_modules/bootstrap/dist/css/bootstrap.css">
</svelte:head>
<script defer>
    import MyHobbies from "./lib/MyHobbies.svelte";
    import Landing from './lib/Landing.svelte';
    import Board from './lib/Board.svelte';
    import Dashboard from "./lib/Dashboard.svelte";
    import Navigation from "./lib/Navigation.svelte";
    import Chat from "./lib/Chat.svelte";
    export let stage = 0, max_questions = 2, group;
    let board = [
        {
            id: 1,
            name: "I AM",
            items: []
        },
        {
            id: 2,
            name: "I AM NOT",
            items: []
        },
        {
            id: 3,
            name: "",
            items: [
                {id: 31, name: "Outdoorsy", visible: true, desc: "Are you more of a go around type of person or do you prefer staying at home?"},
                {id: 32, name: "Spiritual", desc: ""},
                {id: 33, name: "Extrovert" , desc: "Are you into social gatherings or do you prefer staying at home?"},
                {id: 34, name: "Animal Freak", desc: "What is your stance on animals?"},
            ]
        }
    ]
    let dashboard = [
        {
            id: 1,
            name: "YES",
            items: []
        },
        {
            id: 2,
            name: "NO",
            items: []
        },
        {
            id: 3,
            name: "",
            items: [
                {id: 41, name: "Horse Riding", visible: true},
                {id: 42, name: "Table Tennis"},
                {id: 43, name: "Gym"},
                {id: 44, name: "Yoga"},
            ]
        }
    ]

    let dashboard_card = [
        {
            id: 1,
            name: "",
            items: [
                {id: 51, name: "Horse Riding", desc: 'Horseback riding is the art of riding a horse and controlling the animal’s movement and speed with maximum effectiveness and minimum efforts.'},
                {id: 52, name: "Yoga", desc: 'Gym isn’t just a place for exercise; It’s the place you go to unwind, socialize and work out. The gym is a whole experience.'}
            ]
        }
    ]
    function handle_stage(event) {
        stage = event.detail.stage;
        console.log("handle")
        console.log(stage)
    }
</script>

<style>
    :global(.bubble) {
        background: -webkit-linear-gradient(to top, rgba(100,78,255,0.8), rgba(47,35,141,0.8));
        background: linear-gradient(to top, rgba(100,78,255,0.8), rgba(47,35,141,0.8))
    }
    :global(.min-vh-50) {
        min-height: 50vh;
    }
    body {
        width: 100%;
        background-color: rgb(255,253,208);
    }
</style>
{#if stage == 0}
<Landing bind:stage/>
{:else}
    <Navigation bind:max_questions bind:stage/>
    {#if stage < max_questions + 1}
        <Board bind:stage bind:max_questions columnItems={stage < 2  ? board : dashboard}></Board>
    {:else if stage == max_questions + 1}
        <Dashboard bind:stage bind:max_questions columnItems={dashboard}/>
    {:else if stage == 10}
        <Chat bind:group></Chat>
    {:else}
        <MyHobbies bind:group bind:stage columnItems={dashboard_card}/>
    {/if}
{/if}
