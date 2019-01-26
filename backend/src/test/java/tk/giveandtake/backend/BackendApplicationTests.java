package tk.giveandtake.backend;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import tk.giveandtake.backend.controller.UserController;

import static junit.framework.TestCase.assertTrue;
import static org.junit.Assert.assertNotNull;

@RunWith(SpringRunner.class)
@SpringBootTest
public class BackendApplicationTests {

	@Autowired
	private UserController userController;

	@Test
	public void contextLoads() {
		assertNotNull(userController);
	}

}

