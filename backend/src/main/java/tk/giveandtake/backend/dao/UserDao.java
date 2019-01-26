package tk.giveandtake.backend.dao;

import org.springframework.stereotype.Repository;
import tk.giveandtake.backend.entity.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public class UserDao implements Dao<User> {
    private List<User> users = new ArrayList<>();

    UserDao() {
        users.add(new User(1, "andre.nho@gmail.com", "André Wagner"));
        users.add(new User(2, "joaosilva@gmail.com", "João da Silva"));
    }

    @Override
    public Optional<User> get(long id) {
        for (User u: users)
            if (id == u.getId())
                return Optional.of(u);
        return Optional.empty();
    }

    @Override
    public List<User> getAll() {
        return users;
    }

    @Override
    public void save(User user) {
        users.add(user);
    }

    @Override
    public void update(User user, String[] params) {
        user.setEmail(Objects.requireNonNull(params[0], "E-mail cannot be null"));
        user.setName(Objects.requireNonNull(params[1], "Name cannot be null"));
    }

    @Override
    public void delete(User user) {
        users.remove(user);
    }
}
