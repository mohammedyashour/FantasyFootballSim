class UIMessages {
  // Main Menu Messages
  static const String welcomeTitle = '🏈 Welcome to Fantasy Football Sim! 🎮';
  static const String mainMenuTitle = '🎮 MATCH MANAGEMENT';
  static const String startNewMatch = 'Start New Match (Custom Setup)';
  static const String quickMatch = 'Quick Match (Random Teams)';
  static const String back = 'Back';
  static const String exit = 'Exit';
  static const String invalidChoice = '❌Invalid choice, please try again.';

  // Match Setup Messages
  static const String matchSetupTitle = '📋 MATCH SETUP';
  static const String homeTeam = 'Home Team';
  static const String awayTeam = 'Away Team';
  static const String stadium = 'Stadium';
  static const String referee = 'Referee';
  static const String trainer = 'Trainer';
  static const String strategy = 'Strategy';
  static const String formation = 'Formation';
  static const String totalPower = 'Total Power';

  // Match Status Messages
  static const String matchStarting = '🎮 MATCH STARTING';
  static const String liveMatch = '🎮 LIVE MATCH';
  static const String matchEnded = '🎉 The match has ended! 🎉';
  static const String matchSummary = 'MATCH SUMMARY';
  static const String winner = 'Winner';
  static const String draw = 'Match ended in a draw';

  // Statistics Messages
  static const String detailedStatsTitle = '📊 DETAILED MATCH STATISTICS';
  static const String statsDashboardTitle = '📊 MATCH STATISTICS DASHBOARD';
  static const String score = 'Score';
  static const String possession = 'Possession';
  static const String shots = 'Shots';
  static const String shotsOnTarget = 'Shots on Target';
  static const String fouls = 'Fouls';
  static const String corners = 'Corners';
  static const String offsides = 'Offsides';
  static const String saves = 'Saves';
  static const String yellowCards = 'Yellow Cards';
  static const String redCards = 'Red Cards';
  static const String goals = 'Goals';
  static const String substitutions = 'Substitutions';
  static const String eventsByMinute = 'MINUTE-BY-MINUTE EVENTS';

  // Event Messages
  static const String noEventsThisMinute = '⏱️  No events in this minute';
  static const String noGoals = '⚽ No goals scored in this match';
  static const String noSubstitutions =
      '🔄 No substitutions made in this match';
  static const String noEvents = '📅 No events recorded in this match';

  // Interactive Messages
  static const String viewDetailedStats =
      'Would you like to view detailed match statistics?';
  static const String yesShowStats = 'Yes - Show detailed statistics';
  static const String noReturnMenu = 'No - Return to main menu';
  static const String pressEnterContinue = 'Press Enter to continue...';
  static const String backToMainMenu = '🏠 Back to Main Menu';

  // Team Selection Messages
  static const String generateRandomTeam = 'Generate Random Team';
  static const String createCustomTeam = 'Create Custom Team';
  static const String customTeamNotImplemented =
      '⚠️  Custom team creation not implemented yet';
  static const String generatingRandomTeam =
      'Generating random team instead...';
  static const String invalidChoiceGeneratingRandom =
      'Invalid choice, generating random team';

  // Stadium Selection Messages
  static const String noStadiumsAvailable =
      '❌ No stadiums available. Generating random stadium...';
  static const String availableStadiums = 'Available Stadiums:';
  static const String generateRandomStadium = 'Generate Random Stadium';

  // Referee Selection Messages
  static const String noRefereesAvailable =
      '❌ No referees available. Generating random referee...';
  static const String availableReferees = 'Available Referees:';
  static const String generateRandomReferee = 'Generate Random Referee';

  // Match Options Messages
  static const String quickMatchInstant = 'Quick Match (Instant Result)';
  static const String liveMatchMinute = 'Live Match (Minute by Minute)';
  static const String invalidChoiceQuickMatch =
      'Invalid choice, running quick match';

  // Generating Messages
  static const String generatingRandomTeams = '🎲 Generating random teams...';
  static const String generatingRandomStadium =
      '🏟️  Generating random stadium...';
  static const String generatingRandomReferee =
      '👨‍⚖️  Generating random referee...';

  // Error Messages
  static const String errorCreatingTeam = '❌ Error creating team: ';
  static const String teamCreatedSuccessfully = '🎉 Team created successfully!';
  static const String teamNameCannotBeEmpty = '❌ Team name cannot be empty!';
  static const String noExistingTrainers = ' No existing trainers available.';
  static const String noExistingPlayers = 'No existing players available.';
  static const String teamMustHave11Players =
      '❌ Team must have at least 11 players! You currently have ';
  static const String playerAlreadyInTeam = '⚠️ Player already in the team.';
  static const String playerAdded = '✅ Added ';
  static const String randomPlayerAdded = '🎲 Random player added: ';
  static const String teamNowHas11Players = '✅ Team now has 11 players.';

  // Menu Options
  static const String manageReferees = '🧑‍⚖️ Manage Referees';
  static const String manageStadiums = '🏟️ Manage Stadiums';
  static const String simulateMatch = '⚽ Simulate Match';

  // Detailed Statistics Menu
  static const String detailedStatistics = '📊 Detailed Statistics';
  static const String goalsSummary = '⚽ Goals Summary';
  static const String substitutionsMenu = '🔄 Substitutions';
  static const String minuteByMinuteEvents = '📅 Minute-by-Minute Events';
  static const String  teamDetails = '👥 Team Details';
  static const String  fullEventLogToggle = '🗒️ Toggle Full Event Log';

  // Formatting helpers
  static String formatMinute(int minute) =>
      '[${minute.toString().padLeft(2, '0')}]';
  static String formatScore(
    String homeTeam,
    int homeScore,
    int awayScore,
    String awayTeam,
  ) => '$homeTeam $homeScore - $awayScore $awayTeam';
  static String formatPercentage(double value) =>
      '${value.toStringAsFixed(1)}%';
}
