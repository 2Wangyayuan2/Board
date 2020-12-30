package com.easybasic.board.service;

import com.easybasic.board.dao.IBoardDao;
import com.easybasic.board.model.Board;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("boardService")
public class BoardService {
    private static Logger logger = LoggerFactory.getLogger(BoardService.class);

    @Resource
    private IBoardDao BoardDao;

    public Board getByPkId(Integer pkId)
    {
        try
        {
            return BoardDao.selectByPrimaryKey(pkId);
        }
        catch (Exception ex)
        {
            logger.error("“BoardService”类执行方法“getByPkId”错误", ex);
            throw ex;
        }
    }

    public int insert(Board website)
    {
        try {
            return BoardDao.insert(website);
        }
        catch (Exception ex){
            logger.error("“BoardService”类执行方法“insert”错误", ex);
            throw ex;
        }
    }

    public int update(Board website)
    {
        try {
            int re = BoardDao.updateByPrimaryKey(website);
            return re;
        }
        catch (Exception ex){
            logger.error("“BoardService”类执行方法“update”错误", ex);
            throw ex;
        }
    }

    public int delete(int pkId)
    {
        try {
            Board website = getByPkId(pkId);
            if(website!=null) {
                int re = BoardDao.deleteByPrimaryKey(pkId);
                return re;
            }
            return 0;
        }
        catch (Exception ex){
            logger.error("“BoardService”类执行方法“delete”错误", ex);
            throw ex;
        }
    }

    public List<Board> getAllList()
    {
        try {
            return BoardDao.selectAll();
        }
        catch (Exception ex)
        {
            logger.error("“BoardService”类执行方法“getAllList”错误", ex);
            throw ex;
        }
    }

    public List<Board> getActivityListForPage(String searchStr, String orderStr)
    {
        try {
            return BoardDao.selectListBySearch(searchStr, orderStr);
        }
        catch (Exception ex)
        {
            logger.error("“BoardService”类执行方法“getListBySearch”错误", ex);
            throw ex;
        }
    }
}
