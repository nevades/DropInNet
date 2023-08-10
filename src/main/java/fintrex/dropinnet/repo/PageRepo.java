package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.GetPagesDTO;
import fintrex.dropinnet.model.Page;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PageRepo extends CrudRepository<Page, Integer> {

    @Query("WITH RECURSIVE pgs AS (SELECT j.page FROM `user_type` ut CROSS JOIN JSON_TABLE(ut.`pages`, '$[*]' COLUMNS (`page` INT PATH '$[0]'))j  WHERE ut.`id`= (SELECT `user_type` FROM `user` WHERE `id`=:uid)), p AS (SELECT `id`,`parent` FROM `pages` WHERE id IN (SELECT page FROM pgs) UNION SELECT pp.`id`,pp.`parent` FROM `pages` pp JOIN p ON pp.`id`=p.parent) "
            + "SELECT JSON_ARRAYAGG(JSON_OBJECT('name',`name`,'url',`url`,'icon',IFNULL(`icon`,''),'odr',IFNULL(`odr`,10000),'pages',(SELECT JSON_ARRAYAGG(JSON_OBJECT('name',`name`,'url',`url`,'icon',`icon`,'odr',IFNULL(`odr`,10000),'pages',(SELECT JSON_ARRAYAGG(JSON_OBJECT('name',`name`,'url',`url`,'icon',`icon`,'odr',IFNULL(`odr`,10000))) FROM `pages` l3 WHERE `level`=3 AND `parent`=l2.id AND l3.`status`='active' AND l3.`id` IN (SELECT id FROM p)))) FROM `pages` l2 WHERE `level`=2 AND `parent`=l1.`id` AND l2.`status`='active' AND l2.`id` IN (SELECT id FROM p)))) AS pages FROM `pages` l1 WHERE `level`=1 AND `status`='active' AND l1.`id` IN (SELECT id FROM p)")
    String getAllPages(@Param("uid") String uid);

    @Query("SELECT (SELECT JSON_ARRAYAGG(JSON_OBJECT( 'odr',`odr`,'id',`id`,'parent',`parent`,'name',`name`,'level',`level`,'url',`url`)) FROM `pages`)as `all_page`")
    GetPagesDTO getPage();
    
    @Query("SELECT `id`,`name`,`dashboard`,(SELECT `name` FROM `dashboard` WHERE id = u.`dashboard`) AS `dashboard_name`,(SELECT JSON_ARRAYAGG(JSON_OBJECT( 'odr',`odr`,'id',`id`,'parent',`parent`,'name',`name`,'level',`level`,'url',`url`,'state',JSON_OBJECT('selected',IF(a.access IS NULL,CAST(FALSE AS JSON),CAST(TRUE AS JSON))))) FROM `pages` p LEFT JOIN (SELECT j.* FROM `user_type` t CROSS JOIN JSON_TABLE(t.`pages`,'$[*]' COLUMNS(`access` INT path '$[0]'))j WHERE t.`id`=:utid)a ON p.id=a.access)AS `all_page`  FROM `user_type` u WHERE id =:utid")
    GetPagesDTO getSelectedPage(@Param("utid") Integer utid);
}
