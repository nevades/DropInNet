/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.model.TransferPromotionUsers;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Nevanjith
 */
@Repository
public interface TransferPromotionUsersRepo extends CrudRepository<TransferPromotionUsers, Integer> {

}
