package de.perprogramming.akshelloworld;

import de.perprogramming.akshelloworld.resources.HelloWorldResource;
import de.perprogramming.akshelloworld.health.TemplateHealthCheck;

import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

public class AksHelloWorldApplication extends Application<AksHelloWorldConfiguration> {

    public static void main(final String[] args) throws Exception {
        new AksHelloWorldApplication().run(args);
    }

    @Override
    public String getName() {
        return "AksHelloWorld";
    }

    @Override
    public void initialize(final Bootstrap<AksHelloWorldConfiguration> bootstrap) {
    }

    @Override
    public void run(final AksHelloWorldConfiguration configuration, final Environment environment) {
        final TemplateHealthCheck healthCheck =
                new TemplateHealthCheck(configuration.getTemplate());
        environment.healthChecks().register("template", healthCheck);

        final HelloWorldResource resource = new HelloWorldResource(
                configuration.getTemplate(),
                configuration.getDefaultName()
        );
        environment.jersey().register(resource);
    }

}
