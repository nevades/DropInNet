/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import fintrex.dropinnet.model.TerminationUsers;

/**
 *
 * @author Nevanjith
 */
@Repository
public interface TerminationUsersRepo extends CrudRepository<TerminationUsers, Integer> {
    
}
