

<!-- README.md is generated from README.qmd. Please edit that file -->

# Quarto Research Blog

## Research Wokflow

This is an example of a research workflow using
[Quarto](https://quarto.org) and
[`targets`](https://books.ropensci.org/targets/).

### Explanation

- [My
  blog](https://kazuyanagimoto.com/blog/2025/0426_research_workflow/)
- [Zenn](https://zenn.dev/nicetak/articles/workflow-research-2025) (in
  Japanese)

### Replication

1.  Install R, Julia, and Quarto
2.  Set Julia path in .Renviron `PATH_JULIA="/path/to/julia"`
3.  Install `renv` in R console
4.  Run `renv::restore()` to install packages
5.  Run `targets::tar_make()` to run the workflow

``` mermaid
graph LR
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Graph
    direction LR
    xa60862c4ab4296bb(["raw_accident_bike"]):::skipped --> x034caa8952fea0bc(["accident_bike"]):::skipped
    x6d55c198484f4a32(["demand_supply_file"]):::skipped --> xce43a680ab7f20d8(["demand_supply"]):::skipped
    x6b88c7f0a7cfeae2(["res_model"]):::skipped --> x6d55c198484f4a32(["demand_supply_file"]):::skipped
    xae87dc67ba338d4f(["equilibrium_file"]):::skipped --> xa24c4be63b494044(["equilibrium"]):::skipped
    x6b88c7f0a7cfeae2(["res_model"]):::skipped --> xae87dc67ba338d4f(["equilibrium_file"]):::skipped
    x02d319b13cb530b9(["jl_file_main"]):::skipped --> xad77b747e8ecd697(["jl_main"]):::skipped
    x693460ba53a4c0cd(["jl_file_model"]):::skipped --> x25bf76549192ec22(["jl_model"]):::skipped
    x034caa8952fea0bc(["accident_bike"]):::skipped --> x9470f51581cb7d73(["logit_hospital_death"]):::skipped
    xce43a680ab7f20d8(["demand_supply"]):::skipped --> x24abe6175c545e8a(["manuscript"]):::skipped
    xb033ae8b49095a26(["num_accident"]):::skipped --> x24abe6175c545e8a(["manuscript"]):::skipped
    xa24c4be63b494044(["equilibrium"]):::skipped --> x24abe6175c545e8a(["manuscript"]):::skipped
    x9470f51581cb7d73(["logit_hospital_death"]):::skipped --> x24abe6175c545e8a(["manuscript"]):::skipped
    x5b3deba9281c9212(["fns_graphics"]):::skipped --> x24abe6175c545e8a(["manuscript"]):::skipped
    x41180a2d7b7b3c28(["parameters"]):::skipped --> x24abe6175c545e8a(["manuscript"]):::skipped
    xb033ae8b49095a26(["num_accident"]):::skipped --> xb7f5b6c7e9273aa9(["manuscript_book"]):::skipped
    xce43a680ab7f20d8(["demand_supply"]):::skipped --> xb7f5b6c7e9273aa9(["manuscript_book"]):::skipped
    xa24c4be63b494044(["equilibrium"]):::skipped --> xb7f5b6c7e9273aa9(["manuscript_book"]):::skipped
    x9470f51581cb7d73(["logit_hospital_death"]):::skipped --> xb7f5b6c7e9273aa9(["manuscript_book"]):::skipped
    x5b3deba9281c9212(["fns_graphics"]):::skipped --> xb7f5b6c7e9273aa9(["manuscript_book"]):::skipped
    x41180a2d7b7b3c28(["parameters"]):::skipped --> xb7f5b6c7e9273aa9(["manuscript_book"]):::skipped
    x034caa8952fea0bc(["accident_bike"]):::skipped --> xb033ae8b49095a26(["num_accident"]):::skipped
    xfeeaf8513320133e(["parameters_file"]):::skipped --> x41180a2d7b7b3c28(["parameters"]):::skipped
    x6b88c7f0a7cfeae2(["res_model"]):::skipped --> xfeeaf8513320133e(["parameters_file"]):::skipped
    xee0a5a7de02f740f(["dir_raw_accident_bike"]):::skipped --> xa60862c4ab4296bb(["raw_accident_bike"]):::skipped
    x02d319b13cb530b9(["jl_file_main"]):::skipped --> x6b88c7f0a7cfeae2(["res_model"]):::skipped
    xad77b747e8ecd697(["jl_main"]):::skipped --> x6b88c7f0a7cfeae2(["res_model"]):::skipped
    x25bf76549192ec22(["jl_model"]):::skipped --> x6b88c7f0a7cfeae2(["res_model"]):::skipped
    x034caa8952fea0bc(["accident_bike"]):::skipped --> x5a3744590d99f661(["website"]):::skipped
    x5b3deba9281c9212(["fns_graphics"]):::skipped --> x5a3744590d99f661(["website"]):::skipped
  end
```

## Quarto Research Blog

This is also an example of a research blog using the
[Quarto](https://quarto.org). You can find a
[website](https://kazuyanagimoto.com/quarto-research-blog/) and a
password-protected
[website](https://kazuyanagimoto.com/quarto-research-blog/).

- username: `abcd`
- password: `1234`

### Explanation

- [My blog](https://kazuyanagimoto.com/blog/2024/04/05/)
- [Zenn](https://zenn.dev/nicetak/articles/quarto-research-blog) (in
  Japanese)
