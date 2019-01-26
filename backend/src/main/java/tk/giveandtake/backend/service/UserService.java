package tk.giveandtake.backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.giveandtake.backend.dao.UserDao;
import tk.giveandtake.backend.entity.User;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    public User getUser(int id) {
        return userDao.get(id).get();
    }

}
