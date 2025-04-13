fact <- tar_plan(
  num_accident = compute_num_accident(accident_bike),
  logit_hospital_death = compute_logit_hospital_death(accident_bike)
)

compute_num_accident <- function(accident_bike) {
  accident_bike |>
    summarize(n = n(), .by = c(type_person, gender))
}

compute_logit_hospital_death <- function(accident_bike) {
  list(
    "(1)" = fixest::feglm(
      is_hospitalized ~
        type_person + positive_alcohol + positive_drug | age_c + gender,
      family = binomial(logit),
      data = accident_bike
    ),
    "(2)" = fixest::feglm(
      is_hospitalized ~
        type_person +
          positive_alcohol +
          positive_drug |
          age_c + gender + type_vehicle,
      family = binomial(logit),
      data = accident_bike
    ),
    "(3)" = fixest::feglm(
      is_hospitalized ~
        type_person +
          positive_alcohol +
          positive_drug |
          age_c + gender + type_vehicle + weather,
      family = binomial(logit),
      data = accident_bike
    ),
    "(4)" = fixest::feglm(
      is_died ~ type_person + positive_alcohol + positive_drug | age_c + gender,
      family = binomial(logit),
      data = accident_bike
    ),
    "(5)" = fixest::feglm(
      is_died ~
        type_person +
          positive_alcohol +
          positive_drug |
          age_c + gender + type_vehicle,
      family = binomial(logit),
      data = accident_bike
    ),
    "(6)" = fixest::feglm(
      is_died ~
        type_person +
          positive_alcohol +
          positive_drug |
          age_c + gender + type_vehicle + weather,
      family = binomial(logit),
      data = accident_bike
    )
  )
}
