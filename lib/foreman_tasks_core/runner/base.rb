module ForemanTasksCore
  module Runner
    # Runner is an object that is able to initiate some action and
    # provide update data on refresh call.
    class Base
      attr_reader :id
      attr_writer :logger

      def initialize(*_args, suspended_action: nil)
        @suspended_action = suspended_action
        @id = SecureRandom.uuid
        initialize_continuous_outputs
      end

      def logger
        @logger ||= Logger.new(STDERR)
      end

      def run_refresh
        logger.debug('refreshing runner')
        refresh
        generate_updates
      end

      def start
        raise NotImplementedError
      end

      def refresh
        raise NotImplementedError
      end

      def kill
        # Override when you can kill the runner in the middle
      end

      def close
        # if cleanup is needed
      end

      def timeout
        # Override when timeouts and regular kills should be handled differently
        publish_data('Timeout for execution passed, trying to stop the job', 'debug')
        kill
      end

      def timeout_interval
        # A number of seconds after which the runner should receive a #timeout
        #   or nil for no timeout
      end

      def publish_data(data, type)
        @continuous_output.add_output(data, type)
      end

      def publish_exception(context, exception, fatal = true)
        logger.error("#{context} - #{exception.class} #{exception.message}:\n" + \
                     exception.backtrace.join("\n"))
        dispatch_exception context, exception
        publish_exit_status('EXCEPTION') if fatal
      end

      def publish_exit_status(status)
        @exit_status = status
      end

      def dispatch_exception(context, exception)
        @continuous_output.add_exception(context, exception)
      end

      def generate_updates
        return {} if @continuous_output.empty? && @exit_status.nil?
        new_data = @continuous_output
        @continuous_output = ForemanTasksCore::ContinuousOutput.new
        { @suspended_action => Runner::Update.new(new_data, @exit_status) }
      end

      def initialize_continuous_outputs
        @continuous_output = ::ForemanTasksCore::ContinuousOutput.new
      end
    end
  end
end
