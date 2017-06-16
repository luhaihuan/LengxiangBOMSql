  childrenBOMLine:	
  select L.pitem_id,L.pobject_name,L.pitem_revision_id,L.rchild_itemu,L.item_rev_puid,L.child_item_id,L.child_item_name,L.child_item_revision_id,L.num,to_number((case when L.pseq_no is null then '0' else L.pseq_no end)) seqno, 
			    M.PFW9_CP_LBJREV_03,M.PFW9_CP_LBJREV_07,N.PFW9_LBJREV_01,L.install_location,L.remark,L.install_location || '|' || L.remark chsremark from 
			    (select distinct J.rchild_itemu,J.pitem_id,J.pobject_name,J.pitem_revision_id,K.child_item_id,K.child_item_name,K.child_item_revision_id,J.num,J.install_location,J.remark,J.pseq_no,K.item_rev_puid from (  
						 select distinct I.rchild_itemu,H.item_puid,H.pitem_id,H.pobject_name,H.pitem_revision_id,H.puid,I.num,I.pseq_no,I.install_location,I.remark from( 
							select distinct F.item_puid,F.item_rev_puid,F.pitem_id,F.pobject_name,F.pitem_revision_id,G.puid from ( 				  							  
									select C.item_puid,C.item_rev_puid,A.puid,C.pitem_id,A.pobject_name,C.pitem_revision_id from (  
										select puid,pobject_name,pdate_released from PWORKSPACEOBJECT where  pactive_seq=1  
									)  A join (   
										select A.puid item_puid,B.puid item_rev_puid,A.pitem_id,B.pitem_revision_id from PITEM A,PITEMREVISION B 
											where upper(A.pitem_id) = 'LB0112B2W-00001' and upper(B.pitem_revision_id) = 'A' and A.puid = B.ritems_tagu   
									)  C on A.puid = C.item_rev_puid   
								 ) F  
								 join  ( 				 
								 select A.puid,A.rbom_viewu,D.pobject_name,F.puid rpuid from ppsbomviewrevision A,ppsbomview B,PPSVIEWTYPE C,PWORKSPACEOBJECT D,PSTRUCTURE_REVISIONS F  where  A.puid = D.puid and D.pactive_seq =1 and B.puid = A.rbom_viewu and C.PUID = B.RVIEW_TYPEU  and C.PNAME ='view' and F.PVALU_0 = D.puid  					 
								 ) G on  G.rpuid = F.item_rev_puid ) H 
								 join ( select A.rchild_itemu,A.rparent_bvru,A.PQTY_VALUE num,A.pseq_no,A.RNOTES_REFU,B.PVAL_0 install_location,C.PVAL_0 remark from PPSOCCURRENCE A left join 
								         (select B.puid,B.PVAL_0  from PNOTE_TYPES_0 A,PNOTE_TEXTS_0 B,PNOTETYPE C where A.puid=B.puid and A.PSEQ = B.PSEQ and C.puid = A.PVALU_0 and C.PNAME in ('Fw9_InstallLocation') )  B on A.RNOTES_REFU = B.puid
										 left join 
								         (select B.puid,B.PVAL_0  from PNOTE_TYPES_0 A,PNOTE_TEXTS_0 B,PNOTETYPE C where A.puid=B.puid and A.PSEQ = B.PSEQ and C.puid = A.PVALU_0 and C.PNAME in ('Fw9_Remarks') )  C on A.RNOTES_REFU = C.puid) I  
								 on H.puid = I.rparent_bvru) J  join (  
								 select C.item_puid,A.puid,C.pitem_id child_item_id,A.pobject_name child_item_name,C.pitem_revision_id child_item_revision_id,C.item_rev_puid,C.PCREATION_DATE,C.plast_mod_date from (   
									 select puid,pobject_name,pdate_released from PWORKSPACEOBJECT where  pactive_seq=1   
										)  A join (   
											select AA.puid item_puid,B.puid item_rev_puid,AA.pitem_id,B.pitem_revision_id,D.PCREATION_DATE,D.plast_mod_date from PITEM AA,PITEMREVISION B,PPOM_APPLICATION_OBJECT D      
												where  AA.puid = B.ritems_tagu and B.puid=D.puid   
										)  C on A.puid = C.item_rev_puid    ) K on K.item_puid = J.rchild_itemu  and K.PCREATION_DATE = ( 
										                                                          select max(A3.PCREATION_DATE) from pitemrevision A1,PWORKSPACEOBJECT A2,PPOM_APPLICATION_OBJECT A3  
																								    where ritems_tagu = K.item_puid and  A1.puid = A2.puid and A2.pactive_seq=1 and A1.puid=A3.puid   ) 
										order by K.child_item_id asc,K.child_item_revision_id asc) L,PFW9_CP_LBJREVISION M,PFW9_LBJREVISION N
																			  where L.item_rev_puid = M.puid and L.item_rev_puid = N.puid  order by seqno  asc,L.child_item_id asc,L.child_item_revision_id asc
																			  
																			  
																			  
																			  
																			  
																			  
topBOMLine:																			  
								select C.item_puid,C.item_rev_puid,A.puid,C.pitem_id,A.pobject_name,C.pitem_revision_id,E.PFW9_CP_LBJREV_03,E.PFW9_CP_LBJREV_07,D.PFW9_LBJREV_01 from (  
										select puid,pobject_name,pdate_released from PWORKSPACEOBJECT where  pactive_seq=1  
									)  A join (   
										select A.puid item_puid,B.puid item_rev_puid,A.pitem_id,B.pitem_revision_id from PITEM A,PITEMREVISION B 
											where upper(A.pitem_id) = 'LB0112B2W-00001' and upper(B.pitem_revision_id) = 'A' and A.puid = B.ritems_tagu   
									)  C on A.puid = C.item_rev_puid left join PFW9_LBJREVISION D on C.item_rev_puid = D.puid left join PFW9_CP_LBJREVISION E on C.item_rev_puid = E.puid
																			  
																			  