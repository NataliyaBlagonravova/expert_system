:- initialization main.

main :- identify.

identify:- write("Привет, друг! Ответь на пару простых вопросов и мы подберем подходящий тебе вид спорта\n"),
  retractall(known(_,_,_)),
  sport(_, Name),  write("Тебе идеально подходит "),write(Name), write("\n"), halt.

identify:-
  write("Наша система не смогла подобрать интересный тебе вид спорта\n"), halt.

ask(Attribute, Value):-
  known(да, Attribute, Value),
  !.

ask(Attribute, Value):-
  known(_,Attribute, Value),
  !, fail.


ask(Attribute, Value):-
  question(Attribute, Value, Question),
  write(Question),
  write(' (да или нет): '),
  read(Answer),
  asserta(known(Answer, Attribute, Value)),
  Answer = да.


skill(speed) :- have(long_legs), !;
                can(quickly_solve_problems), !;
                like(sprint).

skill(coordination) :- have(good_stretching), !;
                       can(do_summersault), !;
                      like(act_on_public).

skill(endurance):- have(trained_heart), !;
                   can(work_long_and_hard), !;
                   like(marathon).

skill(strength):- have(strong_arms), !;
                  can(raise_weights), !;
                  like(go_to_gym).

category(cyclic_sport):- skill(endurance),
                         skill(speed).

category(speed_strength_sport):- skill(speed),
                                 skill(strength).

category(coordinating_sport):- skill(coordination),
                               skill(strength).

category(martial_art):- skill(coordination),
                        skill(strength).

category(sport_game):- skill(coordination),
                       skill(speed).

sport_type(water_sport):- type(olympic, summer),
                          like(water),
                          place(indoor).

sport_type(gymnastics):- category(coordinating_sport),
                         type(olympic, summer),
                         place(indoor).

sport_type(athletics):- type(olympic, summer),
                        like(physical_culture).

sport_type(skiing):- type(olympic, winter),
                     place(outdoor), like(snow).

sport_type(command_sport):- like(work_in_team).


type(olympic, summer):- status(olympic), season(summer).
type(olympic, winter):- status(olympic), season(winter).


sport(figure_skating, "фигурное катание"):- category(coordinating_sport),
                                            type(olympic, winter),
                                            place(indoor),
                                            like(artistry).

sport(synchronous_swimming, "синхронное плавание"):- category(coordinating_sport),
                                                     sport_type(water_sport),
                                                     gender(woman),
                                                     like(artistry).

sport(rhythmic_gymnastics, "художественная гимнастика"):-sport_type(gymnastics),
                                                         gender(woman),
                                                         like(artistry).

sport(artistic_gymnastics, "спортивная гимнастика"):- sport_type(gymnastics),
                                                      like(acrobatics).

sport(cycle_racing, "велоспорт"):- category(cyclic_sport),
                                   type(olympic, summer),
                                   can(buy_bicycle),
                                   place(outdoor).

sport(biathlon, "биатлон"):- category(cyclic_sport),
                             sport_type(skiing),
                             like(shooting).

sport(skiing, "лыжные гонки"):- category(cyclic_sport),
                                sport_type(skiing).

sport(mountain_ski, "горные лыжи"):- category(coordinating_sport),
                                     sport_type(skiing),
                                     like(mountains).


sport(swimming, "плавание"):- category(cyclic_sport),
                              sport_type(water_sport).

sport(long_jumping, "прыжки в длину"):- category(speed_strength_sport),
                                        sport_type(athletics),
                                        place(indoor),
                                        like(jumping).

sport(pole_jumping, "прыжки с шестом"):- category(speed_strength_sport),
                                         sport_type(athletics),
                                         place(indoor),
                                         like(jumping),
                                         have(desire_to_fly).

sport(running, "бег"):- category(cyclic_sport),
                        sport_type(athletics).

sport(weightlifting, "тяжелая атлетика"):- category(speed_strength_sport),
                                           type(olympic, summer),
                                           place(indoor).


sport(karate,"карате"):- category(martial_art),
                         place(indoor),
                         can(break_a_brick).

sport(boxing, "бокс"):- category(martial_art),
                        type(olympic, summer),
                        gender(man),
                        place(indoor).

sport(judo, "дзюдо"):- category(martial_art),
                       type(olympic, summer),
                       can(raise_human),
                       place(indoor).

sport(basketball, "баскетбол"):- category(sport_game),
                                 type(olympic, summer),
                                 sport_type(command_sport),
                                 like(play_with_ball),
                                 have(high_growth).

sport(tennis, "тенис"):- category(sport_game),
                         type(olympic, summer),
                         like(shout).

sport(football, "футбол"):- category(sport_game),
                            type(olympic, summer),
                            sport_type(command_sport),
                            like(play_with_ball).

sport(hockey, "хоккей"):- category(sport_game),
                          type(olympic, winter),
                          sport_type(command_sport),
                          like(ice).

sport(golf, "гольф"):- category(sport_game),
                       place(outdoor).


like(X):- ask(like,X).
have(X):- ask(have,X).
can(X):- ask(can,X).
status(X):- ask(status,X).
place(X):- ask(place, X).
season(X):- ask(season,X).
gender(X):- ask(gender, X).


question(have, long_legs, "У тебя длинные ноги?").
question(have, good_stretching, "У тебя хорошая растяжка?").
question(have, trained_heart, "У тебя тренированное сердце?").
question(have, strong_arms, "У тебя сильные руки?").
question(have, desire_to_fly, "Ты хочешь высоко взлетать?").
question(have, high_growth, "У тебя высокий рост?").

question(can, quickly_solve_problems, "Ты умеешь быстро решать любую проблему?").
question(can, do_summersault, "Ты умеешь делать сальто?").
question(can, work_long_and_hard, "Ты можешь долго и упорно работать?").
question(can, raise_weights, "Ты можешь поднимать тяжелые предметы?").
question(can, buy_bicycle, "Ты готов купить дорогостоящий велосипед").
question(can, break_a_brick, "Ты можешь сломать кирпич?").
question(can, raise_human, "Ты можешь поднять человека?").

question(like, sprint, "Ты предпочитаешь короткие скоростные дистанции?").
question(like, act_on_public, "Тебе нравится выступать на публике?").
question(like, marathon, "Ты предпочитаешь длинные дистанции?").
question(like, go_to_gym, "Тебе нравится ходить в спрортзал?").
question(like, acrobatics, "Тебе нравится выполнять акробатические трюки?").
question(like, artistry, "Ты артистичен?").
question(like, water, "Ты любишь воду?").
question(like, physical_culture, "Ты любил заниматься физкультурой в школе?").
question(like, jumping, "Ты любишь прыгать?").
question(like, snow, "Ты любишь снег?").
question(like, shooting, "Тебе нравится стрелять?").
question(like, mountains, "Тебя вдохновляют горы?").
question(like, work_in_team, "Ты любишь работать в команде?").
question(like, ice, "Тебе нравится кататься на льду?").
question(like, shout, "Ты любишь кричать?").
question(like, play_with_ball, "Тебе нравится играть с мячем?").

question(gender, woman, "Ты девушка?").
question(gender, man, "Ты мужчина?").

question(season, winter, "Тебе интересны зимние виды спорта?").
question(season, summer, "Тебе интересны летние виды спорта?").

question(status, olympic, "Ты хотешь заниматься олимпийским видом спорта?").

question(place, indoor, "Ты готов заниматься в помещении?").
question(place, outdoor, "Ты готов заниматься на свежем воздухе?").