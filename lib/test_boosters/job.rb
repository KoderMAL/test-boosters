module TestBoosters
  class Job

    def self.run(command, profile, known_files, leftover_files)
      new(command, profile, known_files, leftover_files).run
    end

    def initialize(command, profile, known_files, leftover_files)
      @command = command
      @profile = profile
      @known_files = known_files
      @leftover_files = leftover_files
    end

    def display_header
      puts
      TestBoosters::Shell.display_files("Known files for this job", @known_files)
      TestBoosters::Shell.display_files("Leftover files for this job", @leftover_files)

      puts "=" * 80
      puts ""
    end

    def files
      @all_files ||= @known_files + @leftover_files
    end

    def run
      display_header

      if files.empty?
        puts("No files to run in this job!")

        return 0
      end

      TestBoosters::Shell.execute("#{@command} -p #{@profile} #{files.join(" ")}")
    end

  end
end
