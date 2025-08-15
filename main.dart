import 'data/repositories/formation_repository_impl.dart';
import 'data/repositories/player_repository_impl.dart';
import 'data/repositories/referee_repository_impl.dart';
import 'data/repositories/stadium_repository_impl.dart';
import 'data/repositories/team_repository_impl.dart';
import 'data/repositories/trainer_repository_impl.dart';
import 'domain/usecases/formation/get_formations_usecase.dart';
import 'domain/usecases/formation/get_recommended_formations_usecase.dart';
import 'domain/usecases/match/create_match_event.dart';
import 'domain/usecases/match/describe_match_event.dart';
import 'domain/usecases/player/CreatePlayerUseCase.dart';
import 'domain/usecases/player/get_all_players_usecase.dart';
import 'domain/usecases/player/get_player_by_player_number_usecase.dart';
import 'domain/usecases/player/get_player_by_name_usecase.dart';
import 'domain/usecases/player/get_player_by_nationality.dart';
import 'domain/usecases/player/random_player_generator_usecase.dart';
import 'domain/usecases/referee/create_referee_usecase.dart';
import 'domain/usecases/referee/get_all_referees_usecase.dart';
import 'domain/usecases/referee/get_referee_by_id_usecase.dart';
import 'domain/usecases/referee/random_referee_generator_usecase.dart';
import 'domain/usecases/stadium/create_stadium_usecase.dart';
import 'domain/usecases/stadium/get_all_stadiums_usecase.dart';
import 'domain/usecases/stadium/get_stadium_by_id_usecase.dart';
import 'domain/usecases/stadium/random_stadium_generator_usecase.dart';
import 'domain/usecases/team/create_team_usecase.dart';
import 'domain/usecases/team/get_all_teams_usecase.dart';
import 'domain/usecases/team/get_teams_by_city_usecase.dart';
import 'domain/usecases/team/get_teams_by_strategy_usecase.dart';
import 'domain/usecases/team/random_team_generator_usecase.dart';
import 'domain/usecases/team/search_teams_usecase.dart';
import 'domain/usecases/trainer/create_trainer_usecase.dart';
import 'domain/usecases/trainer/random_trainer_generator_usecase.dart';
import 'domain/usecases/trainer/select_trainer_usecase.dart';
import 'presentation/io/input/console_input_reader.dart';
import 'presentation/io/output/console_output_writer.dart';
import 'presentation/ui/fantasy_football_launcher.dart';
import 'presentation/ui/formation/formation_comparator.dart';
import 'presentation/ui/formation/formation_details_printer.dart';
import 'presentation/ui/formation/formation_diagram_printer.dart';
import 'presentation/ui/formation/formation_ui.dart';
import 'presentation/ui/match/match_ui.dart';
import 'presentation/ui/player/create_player_ui.dart';
import 'presentation/ui/player/player_printer.dart';
import 'presentation/ui/player/player_ui.dart';
import 'presentation/ui/referee/referee_ui.dart';
import 'presentation/ui/stadium/stadium_ui.dart';
import 'presentation/ui/team/team_ui.dart';
import 'presentation/ui/trainer/trainer_ui.dart';
import 'presentation/utils/match_utils.dart';

void main() {
  // Initialize core components
  final output = ConsoleOutputWriter();
  final input = ConsoleInputReader(output);
  final matchUtils = MatchUtils();

  final playerRepository = PlayerRepositoryImpl();
  final formationRepository = FormationRepositoryImpl();
  final refereeRepository = RefereeRepositoryImpl();
  final stadiumRepository = StadiumRepositoryImpl();
  final trainerRepository = TrainerRepositoryImpl();
  final teamRepository = TeamRepositoryImpl();

  // Initialize use cases
  // Player use cases
  final getAllPlayers = GetAllPlayersUseCase(playerRepository);
  final getPlayerById = GetPlayerByPlayerNumberUseCase(playerRepository);
  final createPlayerUseCase = CreatePlayerUseCase(playerRepository);
  final createRandomPlayer = RandomPlayerGeneratorUseCase(playerRepository);

  // Referee use cases
  final createReferee = CreateRefereeUseCase(refereeRepository);
  final getAllReferees = GetAllRefereesUseCase(refereeRepository);
  final getRefereeById = GetRefereeByIdUseCase(refereeRepository);
  final randomRefereeGenerator = RandomRefereeGeneratorUseCase(createReferee);

  // Stadium use cases
  final createStadium = CreateStadiumUseCase(stadiumRepository);
  final getAllStadiums = GetAllStadiumsUseCase(stadiumRepository);
  final getStadiumById = GetStadiumByIdUseCase(stadiumRepository);
  final randomStadiumGenerator = RandomStadiumGeneratorUseCase(
    stadiumRepository,
  );

  // Trainer use cases
  final createTrainerUseCase = CreateTrainerUseCase(trainerRepository);
  final randomTrainerGenerator = RandomTrainerGeneratorUseCase(
    trainerRepository,
  );
  final selectTrainerUseCase = SelectTrainerUseCase(trainerRepository);

  // Team use cases
  final createTeamUseCase = CreateTeamUseCase(teamRepository);
  final randomTeamGenerator = RandomTeamGeneratorUseCase(
    createTeamUseCase,
    playerRepository,
    trainerRepository,
  );
  final getAllTeams = GetAllTeamsUseCase(teamRepository);
  final searchTeams = SearchTeamsUseCase(teamRepository);
  final getTeamsByCity = GetTeamsByCityUseCase(teamRepository);
  final getTeamsByStrategy = GetTeamsByStrategyUseCase(teamRepository);

  // Formation use cases
  final getFormations = GetFormationsUseCase(formationRepository);
  final getRecommendedFormations = GetRecommendedFormationsUseCase(
    formationRepository,
  );

  // Match use cases
  final createMatchEvent = CreateMatchEvent();
  final describeMatchEvent = DescribeMatchEvent();

  // Initialize UI components
  final refereeUI = RefereeUI(
    createReferee,
    getAllReferees,
    getRefereeById,
    randomRefereeGenerator,
  );

  final stadiumUI = StadiumUI(
    createStadium: createStadium,
    getAllStadiums: getAllStadiums,
    getStadiumById: getStadiumById,
    randomStadiumGenerator: randomStadiumGenerator,
    input: input,
    output: output,
  );

  final playerUI = PlayerUI(
    getAllPlayers: getAllPlayers,
    getPlayerByPlayerNumber: getPlayerById,
    createPlayerUseCase: createPlayerUseCase,
    createRandomPlayer: createRandomPlayer,
    outputWriter: output,
    inputReader: input,
    createPlayerUI: CreatePlayerUI(
      createPlayerUseCase,
      input,
      output,
      playerRepository,
    ),
    playerPrinter: PlayerPrinter(output),
    getPlayerByName: GetPlayerByNameUseCase(playerRepository),
    getPlayerByNationalityUseCase: GetPlayerByNationalityUseCase(
      playerRepository,
    ),
  );

  final teamUI = TeamUi(
    createTeamUseCase: createTeamUseCase,
    createPlayerUseCase: createPlayerUseCase,
    createTrainerUseCase: createTrainerUseCase,
    randomTrainerGeneratorUseCase: randomTrainerGenerator,
    getAllTeamsUseCase: getAllTeams,
    searchTeamsUseCase: searchTeams,
    getTeamsByCityUseCase: getTeamsByCity,
    getTeamsByStrategyUseCase: getTeamsByStrategy,
    playerRepository: playerRepository,
    trainerRepository: trainerRepository,
    inputReader: input,
    outputWriter: output,
    randomTeamGeneratorUseCase: randomTeamGenerator,
  );
  final matchUI = MatchUI(
    createEvent: createMatchEvent,
    describeEvent: describeMatchEvent,
    getAllTeams: getAllTeams,
    inputReader: input,
    outputWriter: output,
    matchManager: matchUtils,
    refereeUI: refereeUI,
    stadiumUI: stadiumUI,
    teamUi: teamUI,
    randomRefereeGenerator: randomRefereeGenerator,
    randomStadiumGenerator: randomStadiumGenerator,
    randomTeamGenerator: randomTeamGenerator,
  );

  final trainerUI = TrainerUi(
    createTrainerUseCase: createTrainerUseCase,
    trainerRepository: trainerRepository,
    inputReader: input,
    outputWriter: output,
    randomTrainerGeneratorUseCase: randomTrainerGenerator,
    selectTrainerUseCase: selectTrainerUseCase,
  );

  final formationUI = FormationUI(
    getFormationsUseCase: getFormations,
    getRecommendedFormationsUseCase: getRecommendedFormations,
    input: input,
    output: output,
    detailsPrinter: FormationDetailsPrinter(
      output,
      FormationDiagramPrinter(output),
    ),
    comparator: FormationComparator(output, FormationDiagramPrinter(output)),
  );

  // Initialize and start launcher
  final launcher = FantasyFootballLauncher(
    output: output,
    input: input,
    onRefereeUi: refereeUI.showMenu,
    onStadiumUi: stadiumUI.showMenu,
    onMatchUi: matchUI.showMenu,
    onPlayerManagementUi: playerUI.showMenu,
    onTeamManagementUi: teamUI.showMenu,
    onTrainerManagementUi: trainerUI.showMenu,
    onFormationManagementUi: formationUI.showMenu,
  );

  launcher.start();
}
