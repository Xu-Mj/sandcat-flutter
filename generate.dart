import 'dart:io';

void main() async {
  print('Running build_runner...');

  // Run the build_runner to generate the drift database code
  final result = await Process.run(
    'flutter',
    ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );

  print(result.stdout);

  if (result.exitCode != 0) {
    print('Error: ${result.stderr}');
    exit(1);
  }

  print('Code generation completed successfully!');
}
