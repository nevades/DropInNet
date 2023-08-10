/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Akash
 */
public interface AdminTypeRepo extends CrudRepository<AdminTypeRepo, Integer>{
 
        
    @Query("select `id` as `value`,`name` as `text` from `admin_type` where `name` like :search order by `name` limit 20")
    Iterable<SlimSelectDTO> getAdminTypeIdAndName(@Param("search") String search);
}
