/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.TicketType;
import fintrex.dropinnet.model.TicketTypeCategory;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Akash
 */
@Repository
public interface TypeCategoryRepo extends CrudRepository<TicketTypeCategory, Integer>{
    
}
