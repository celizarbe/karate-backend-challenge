package runners;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate runAllTests() {
        return Karate.run("classpath:features")
                .relativeTo(getClass());
    }
}
