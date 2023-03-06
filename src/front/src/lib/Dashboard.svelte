<script>
    import { quintOut } from 'svelte/easing';
    import { crossfade } from 'svelte/transition';

    const [send, receive] = crossfade({
        duration: d => Math.sqrt(d * 200),

        fallback(node, params) {
            const style = getComputedStyle(node);
            const transform = style.transform === 'none' ? '' : style.transform;

            return {
                duration: 600,
                easing: quintOut,
                css: t => `
					transform: ${transform} scale(${t});
					opacity: ${t}
				`
            };
        }
    });

    let uid = 1;

    let todos = [
        { id: uid++, done: false, description: 'Horse riding' },
        { id: uid++, done: false, description: 'Sotfball' },
        { id: uid++, done: false, description: 'Basketball' },
        { id: uid++, done: false, description: 'Yoga' },
        { id: uid++, done: false, description: 'Meditation' },
    ];
    let more_todos = [
        { id: uid++, done: false, description: 'Sewing' },
        { id: uid++, done: false, description: 'Netflix & Chill' },
        { id: uid++, done: false, description: 'Programming' },
    ]

    function add(input) {
        const todo = {
            id: uid++,
            done: false,
            description: input.value
        };

        todos = [todo, ...todos];
        input.value = '';
    }

    function remove(todo) {
        let new_item = more_todos.pop();
        if (new_item)
            todos[todos.findIndex(t => t === todo)] = new_item;
        todos = todos.filter(t => t !== todo)
    }

    function mark(todo, done) {
        todo.done = done;
        remove(todo);
        todos = todos.concat(todo);
    }
</script>

<div class='left row justify-content-center'>
    <h2>Recommendations</h2>
    {#each todos.filter(t => !t.done) as todo (todo.id)}
        <label
                class="col-12 col-sm-9 col-md-5 col-lg-4 gx-2 d-flex flex-col flex-md-row align-items-center justify-content-between"
                in:receive="{{key: todo.id}}"
                out:send="{{key: todo.id}}"
        >
            {todo.description}
            <button on:click="{() => remove(todo)}">remove</button>
        </label>
    {/each}
</div>
<button type="button" class="btn bubble p-5">
    Done
</button>

<style>
    .board > input {
        font-size: 1.4em;
        grid-column: 1/3;
    }

    h2 {
        font-size: 2em;
        font-weight: 200;
        user-select: none;
        margin: 0 0 0.5em 0;
    }

    label {
        position: relative;
        line-height: 1.2;
        padding: 0.5em 2.5em 0.5em 2em;
        margin: 0 0 0.5em 0;
        border-radius: 2px;
        user-select: none;
        border: 1px solid hsl(240, 8%, 70%);
        background-color:hsl(240, 8%, 93%);
        color: #333;
    }

    input[type="checkbox"] {
        position: absolute;
        left: 0.5em;
        top: 0.6em;
        margin: 0;
    }

    label:hover button {
        opacity: 1;
    }
</style>