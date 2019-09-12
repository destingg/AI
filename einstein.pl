:- use_module(library(lists)).
amateur(amateur(Nationality, Pet, Beverage, Color, Location, Cigar), 
    Nationality, Pet, Beverage, Color, Location, Cigar).

amateur_Nationality(amateur(Nationality, _Pet, _Beverage, _Color, _Location, _Cigar), Nationality).
amateur_Pet(amateur(_Nationality, Pet, _Beverage, _Color, _Location, _Cigar), Pet).
amateur_Beverage(amateur(_Nationality, _Pet, Beverage, _Color, _Location, _Cigar), Beverage).
amateur_Color(amateur(_Nationality, _Pet, _Beverage, Color, _Location, _Cigar), Color).
amateur_Location(amateur(_Nationality, _Pet, _Beverage, _Color, Location, _Cigar), Location).
amateur_Cigar(amateur(_Nationality, _Pet, _Beverage, _Color, _Location, Cigar), Cigar).

nationality([brit, swede, dane, norwegian, german]).
pet([dog, bird, horse, cat, fish]).
beverage([tea, water, milk, coffee, beer]).
color([green, red, white, yellow, blue]).
location([1,2,3,4,5]).
cigar([pallMall, blends, dunhill, blueMaster, prince]).

solution(Persons) :-
    Persons = [Brit, Swede, Dane, Norwegian, German],

    amateur(Brit, brit, BritPet, BritBeverage, BritColor, BritLocation, BritCigar),
    amateur(Swede, swede, SwedePet, SwedeBeverage, SwedeColor, SwedeLocation, SwedeCigar),
    amateur(Dane, dane, DanePet, DaneBeverage, DaneColor, DaneLocation, DaneCigar),
    amateur(Norwegian, norwegian, NorwegianPet, NorwegianBeverage, NorwegianColor, NorwegianLocation, NorwegianCigar),
    amateur(German, german, GermanPet, GermanBeverage, GermanColor, GermanLocation, GermanCigar),
    pet(Pets),
    beverage(Beverages),
    color(Colors),
    location(Locations),
    cigar(Cigars),
 
    %% clue 1: the Brit lives in the red house
    amateur_Color(Brit, red),

    %% clue 2: the Swede keeps dogs as pets
    %amateur_Nationality(Swede, swede),
    amateur_Pet(Swede, dog),

    %% clue 3: the Dane drinks tea
    %amateur_Nationality(Dane, dane),
    amateur_Beverage(Dane, tea),

    %% clue 4: the green house is on the left of the white house 
    amateur_Color(Green, green),
    member(Green, Persons),
    amateur_Location(Green, GreenLocation),
    member(GreenLocation, Locations),
    amateur_Color(White, white),
    member(White, Persons),
    amateur_Location(White, WhiteLocation),
    WhiteLocation is GreenLocation + 1,
    member(WhiteLocation, Locations),

    %% clue 5: the green house’s owner drinks coffee
    amateur_Color(Green, green),
    member(Green, Persons),
    amateur_Beverage(Green, coffee),

    %% clue 6: the person who smokes Pall Mall rears birds
    amateur_Cigar(PallMall, pallMall),
    member(PallMall, Persons),
    amateur_Pet(PallMall, bird),

    %% clue 7: the owner of the yellow house smokes Dunhill
    amateur_Color(Yellow, yellow),
    member(Yellow, Persons),
    amateur_Cigar(Yellow, dunhill),

    %% clue 8: the man living in the center house drinks milk
    amateur_Location(Center, 3),
    member(Center, Persons),
    amateur_Beverage(Center, milk),

    %% clue 9: the Norwegian lives in the first house
    %amateur_Nationality(Norwegian, norwegian),
    amateur_Location(Norwegian, 1),

    %% clue 10: the man who smokes blends lives next to the one who keeps cats
    amateur_Cigar(Blends, blends),
    member(Blends, Persons),
    amateur_Location(Blends, BlendsLocation),
    member(BlendsLocation, Locations),
    amateur_Pet(Cat, cat),
    member(Cat, Persons),
    amateur_Location(Cat, CatLocation),
    (CatLocation is BlendsLocation + 1; CatLocation is BlendsLocation - 1),
    member(CatLocation, Locations),

    %% clue 11: the man who keeps horses lives next to the man who smokes Dunhill 
    amateur_Pet(Horse, horse),
    member(Horse, Persons),
    amateur_Location(Horse, HorseLocation),
    member(HorseLocation, Locations),
    amateur_Cigar(Dunhill, dunhill),
    member(Dunhill, Persons),
    amateur_Location(Dunhill, DunhillLocation),
    (DunhillLocation is HorseLocation + 1; DunhillLocation is HorseLocation - 1),
    member(DunhillLocation, Locations),


    %% clue 12: the owner who smokes BlueMaster drinks beer
    amateur_Cigar(BlueMaster, blueMaster),
    member(BlueMaster, Persons),
    amateur_Beverage(BlueMaster, beer),

    %% clue 13: the German smokes Prince
    %amateur_Nationality(German, german),
    amateur_Cigar(German, prince),

    %% clue 14: the Norwegian lives next to the blue house
    %amateur_Location(Norwegian, NorwegianLocation), 
    member(NorwegianLocation, Locations),
    amateur_Color(Blue, blue),
    member(Blue, Persons),
    amateur_Location(Blue, BlueLocation),
    (BlueLocation is NorwegianLocation + 1; BlueLocation is NorwegianLocation - 1),
    member(BlueLocation, Locations),
    

    %% clue 15: the man who smokes blends has a neighbor who drinks water
    amateur_Beverage(Water, water),
    member(Water, Persons),
    amateur_Location(Water, WaterLocation),
    member(WaterLocation, Locations),
    amateur_Cigar(Blends, blends),
    member(Blends, Persons),
    amateur_Location(Blends, BlendsLocation),
    (BlendsLocation is WaterLocation + 1; BlendsLocation is WaterLocation - 1),
    member(BlendsLocation, Locations),

    permutation(Pets, 
    [BritPet, SwedePet, DanePet, NorwegianPet, GermanPet]),
    permutation(Beverages,
    [BritBeverage, SwedeBeverage, DaneBeverage, NorwegianBeverage, GermanBeverage]),
    permutation(Colors,
    [BritColor, SwedeColor, DaneColor, NorwegianColor, GermanColor]),
    permutation(Locations,
    [BritLocation, SwedeLocation, DaneLocation, NorwegianLocation, GermanLocation]),
    permutation(Cigars,
    [BritCigar, SwedeCigar, DaneCigar, NorwegianCigar, GermanCigar]).

%% get the nationality of owner of fish from the matrix:
ownerOfFish(Persons, Owner):-
    amateur_Pet(FishOwner, fish),
    member(FishOwner, Persons),
    amateur_Nationality(FishOwner, Owner).


