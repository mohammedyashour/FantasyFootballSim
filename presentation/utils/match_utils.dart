import '../../domain/entities/game.dart';
import '../../domain/entities/team.dart';
import '../../domain/entities/stadium.dart';
import '../../domain/entities/referee.dart';
import '../../domain/enums/Weather.dart';
import '../../domain/usecases/team/random_team_generator_usecase.dart';
import '../../domain/usecases/referee/random_referee_generator_usecase.dart';
import '../../domain/usecases/stadium/random_stadium_generator_usecase.dart';
import '../../domain/usecases/referee/get_all_referees_usecase.dart';
import '../../domain/usecases/stadium/get_all_stadiums_usecase.dart';
import '../io/input/console_input_reader.dart';
import '../io/output/output_writer.dart';
import '../utils/terminal_utils.dart';
import '../utils/ui_messages.dart';

class MatchUtils {
  /// Generates a complete random match setup
  Game generateRandomMatch({
    required RandomTeamGeneratorUseCase randomTeamGenerator,
    required RandomStadiumGeneratorUseCase randomStadiumGenerator,
    required RandomRefereeGeneratorUseCase randomRefereeGenerator,
    required OutputWriter output,
  }) {
    output.writeLine(UIMessages.generatingRandomTeams);
    final homeTeam = randomTeamGenerator.call();
    final awayTeam = randomTeamGenerator.call();

    output.writeLine(UIMessages.generatingRandomStadium);
    final stadium = randomStadiumGenerator.call();

    output.writeLine(UIMessages.generatingRandomReferee);
    final referee = randomRefereeGenerator.call();

    return Game(
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      stadium: stadium,
      referee: referee,
      matchTime: DateTime.now(),
      weather: WeatherCondition.clear,
    );
  }

  /// Displays match setup information
  void displayMatchSetup({required Game game, required OutputWriter output}) {
    output.writeLine(
      '\n${UIMessages.matchSetupTitle.withStyle(TerminalColor.BLUE)}',
    );
    output.writeLine('🏠 ${UIMessages.homeTeam}: ${game.homeTeam.name}');
    output.writeLine('   ${UIMessages.trainer}: ${game.homeTeam.trainer.name}');
    output.writeLine(
      '   ${UIMessages.strategy}: ${game.homeTeam.strategy.name}',
    );
    output.writeLine(
      '   ${UIMessages.formation}: ${game.homeTeam.formation.name}',
    );
    output.writeLine(
      '   ${UIMessages.totalPower}: ${game.homeTeam.totalPower.toStringAsFixed(2)}',
    );

    output.writeLine('\n✈️  ${UIMessages.awayTeam}: ${game.awayTeam.name}');
    output.writeLine('   ${UIMessages.trainer}: ${game.awayTeam.trainer.name}');
    output.writeLine(
      '   ${UIMessages.strategy}: ${game.awayTeam.strategy.name}',
    );
    output.writeLine(
      '   ${UIMessages.formation}: ${game.awayTeam.formation.name}',
    );
    output.writeLine(
      '   ${UIMessages.totalPower}: ${game.awayTeam.totalPower.toStringAsFixed(2)}',
    );

    output.writeLine('\n🏟️  ${UIMessages.stadium}: ${game.stadium.name}');
    output.writeLine('   Location: ${game.stadium.location.displayName}');
    output.writeLine('   Capacity: ${game.stadium.capacity}');
    output.writeLine('   Weather: ${game.stadium.weather?.name ?? 'Unknown'}');

    output.writeLine('\n👨‍⚖️  ${UIMessages.referee}: ${game.referee.name}');
    output.writeLine('   Experience: ${game.referee.experienceYears} years');
    output.writeLine(
      '   Strictness: ${(game.referee.strictness * 100).toStringAsFixed(0)}%',
    );
  }

  /// Selects a team with fallback to random generation
  Team? selectTeamWithFallback({
    required String teamType,
    required RandomTeamGeneratorUseCase randomTeamGenerator,
    required ConsoleInputReader input,
    required OutputWriter output,
    Team Function()? createTeam,
  }) {
    output.writeLine('\n$teamType:');
    output.writeLine('1. ${UIMessages.generateRandomTeam}');
    output.writeLine('2. ${UIMessages.createCustomTeam}');

    final prompt =
        createTeam != null ? 'Enter choice (1-2):' : 'Enter choice (1):';
    final choice = input.readString(prompt);

    if (createTeam == null) {
      return randomTeamGenerator.call();
    }
    if (choice == '1') {
      return randomTeamGenerator.call();
    }
    if (choice == '2') {
      return createTeam();
    }
    output.writeLine(UIMessages.invalidChoiceGeneratingRandom);
    return randomTeamGenerator.call();
  }

  /// Selects a stadium with fallback to random generation
  Stadium? selectStadiumWithFallback({
    required GetAllStadiumsUseCase getAllStadiums,
    required RandomStadiumGeneratorUseCase randomStadiumGenerator,
    required ConsoleInputReader input,
    required OutputWriter output,
    void Function()? openStadiumUi,
  }) {
    final stadiums = getAllStadiums();

    if (stadiums.isEmpty) {
      output.writeLine(UIMessages.noStadiumsAvailable);
      if (openStadiumUi != null) {
        output.writeLine('1. ${UIMessages.generateRandomStadium}');
        output.writeLine('2. Open Stadium Manager');
        final choice = input.readString('Enter choice (1-2):');
        if (choice == '2') {
          openStadiumUi();
          final list = getAllStadiums();
          return list.isNotEmpty ? list.first : randomStadiumGenerator.call();
        }
      }
      return randomStadiumGenerator.call();
    }

    output.writeLine('\n${UIMessages.availableStadiums}');
    for (int i = 0; i < stadiums.length; i++) {
      output.writeLine(
        '${i + 1}. ${stadiums[i].name} - ${stadiums[i].location.displayName}',
      );
    }
    output.writeLine(
      '${stadiums.length + 1}. ${UIMessages.generateRandomStadium}',
    );

    final choice = input.readInt(
      'Select stadium (1-${stadiums.length + 1}):',
      min: 1,
      max: stadiums.length + 1,
    );

    if (choice == stadiums.length + 1) {
      return randomStadiumGenerator.call();
    }

    return stadiums[choice - 1];
  }

  /// Selects a referee with fallback to random generation
  Referee? selectRefereeWithFallback({
    required GetAllRefereesUseCase getAllReferees,
    required RandomRefereeGeneratorUseCase randomRefereeGenerator,
    required ConsoleInputReader input,
    required OutputWriter output,
    void Function()? openRefereeUi,
  }) {
    final referees = getAllReferees.call();

    if (referees.isEmpty) {
      output.writeLine(UIMessages.noRefereesAvailable);
      if (openRefereeUi != null) {
        output.writeLine('1. ${UIMessages.generateRandomReferee}');
        output.writeLine('2. Open Referee Manager');
        final choice = input.readString('Enter choice (1-2):');
        if (choice == '2') {
          openRefereeUi();
          final list = getAllReferees.call();
          return list.isNotEmpty ? list.first : randomRefereeGenerator.call();
        }
      }
      return randomRefereeGenerator.call();
    }

    output.writeLine('\n${UIMessages.availableReferees}');
    for (int i = 0; i < referees.length; i++) {
      output.writeLine(
        '${i + 1}. ${referees[i].name} (${referees[i].experienceYears} years exp)',
      );
    }
    output.writeLine(
      '${referees.length + 1}. ${UIMessages.generateRandomReferee}',
    );

    final choice = input.readInt(
      'Select referee (1-${referees.length + 1}):',
      min: 1,
      max: referees.length + 1,
    );

    if (choice == referees.length + 1) {
      return randomRefereeGenerator.call();
    }

    return referees[choice - 1];
  }

  /// Calculates match prediction based on team powers
  String predictMatchResult({required Team homeTeam, required Team awayTeam}) {
    final homePower = homeTeam.totalPower;
    final awayPower = awayTeam.totalPower;
    final homeAdvantage = 0.1; // 10% home advantage

    final adjustedHomePower = homePower * (1 + homeAdvantage);
    final totalPower = adjustedHomePower + awayPower;

    final homeWinProbability = adjustedHomePower / totalPower;
    final awayWinProbability = awayPower / totalPower;

    if (homeWinProbability > 0.5) {
      return '🏠 ${homeTeam.name} is favored to win';
    } else if (awayWinProbability > 0.5) {
      return '✈️  ${awayTeam.name} is favored to win';
    } else {
      return '🤝 Match is too close to call';
    }
  }

}
