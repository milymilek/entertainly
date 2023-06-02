<script>
    export let columnItems, stage, group;
    console.log(columnItems[0].items)
</script>
<style>
    .pointer_shadow {
        transition: all 1.0s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    .pointer_shadow:hover {
        transform: scale(1.05, 1.05);
        cursor: pointer;
    }
</style>
<section class="container-fluid">
    <div class="row w-100 h-25">
        {#each columnItems as column (column.id)}
            <div class="col-12 m-auto board_column myshadow">
                <div class="column-title">{column.name}</div>
                <div class="d-flex flex-column">
                    {#each column.items as item}
                        <div class="card mb-3 shadow pointer_shadow"  on:click="{() => {stage = 10; group=item.name}}" >
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="{`public/${item.name}.jpg`}" class="img-thumbnail rounded-start w-100" alt="{item.name}">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">{item.name}</h5>
                                        <p class="card-text">{item.desc}</p>
                                        <p class="card-text"><small class="text-muted">Last updated {parseInt(Math.random() * 25 + 1)} mins ago</small></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/each}
                </div>
            </div>
        {/each}
    </div>
</section>