<script>
    export let columnItems;
    console.log(columnItems[0].items)
    console.log()
</script>
<style>
</style>
<section class="container-fluid">
    <div class="row w-100 h-25">
        {#each columnItems as column (column.id)}
            <div class="col-12 m-auto board_column myshadow" overflow="scroll">
                <div class="column-title">{column.name}</div>
                <div class="d-flex flex-column">
                    {#each column.items as item}
                        <div class="card mb-3 shadow">
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