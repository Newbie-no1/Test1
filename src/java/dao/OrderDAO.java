/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.*;

/**
 *
 * @author Admin
 */
public class OrderDAO extends DBContext {

    private int noOfRecords;

    //Phuong thuc de them mot don hang moi vao co so du lieu
    public void insertOrder(User u, Cart cart, String notes) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            //Theem 1 don hang moi vao co so du lieu
            String sql = "insert into [Order] ([user_id],[order_date],[total],[notes],[status]) values (?,GETDATE(), ?, ?,1)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, u.getId());
            ps.setDouble(2, cart.getTotalMoney());
            ps.setString(3, notes);
            ps.executeUpdate();
//Lay Id don hang vua them vao de su dung cho viec them thong tin don hang
            String sql1 = "select top 1 order_id from [Order] order by order_id desc";
            ps = connection.prepareStatement(sql1);
            rs = ps.executeQuery();

            if (rs.next()) {
                int oid = rs.getInt(1);
                //Them thong tin chi tiet don hang vao bang OrderDetail cho tung san pham trong gio hang
                for (CartItem item : cart.getItems()) {
                    String sql2 = "insert into [OrderDetail] ([order_id],[product_id]  ,[price],[quantity]) values (?,?, ?, ?)";
                    ps = connection.prepareStatement(sql2);
                    ps.setInt(1, oid);
                    ps.setInt(2, item.getProduct().getId());
                    ps.setDouble(3, item.getProduct().getPrice());
                    ps.setInt(4, item.getQuantity());
                    ps.executeUpdate();
                }
            }
            // Cap nhat so luong san pham trong bang product
            String sql3 = "update [Product] set [stock] = [stock] - ? "
                    + "where product_id = ?";
            ps = connection.prepareStatement(sql3);
            for (CartItem item : cart.getItems()) {
                ps.setInt(1, item.getQuantity());
                ps.setInt(2, item.getProduct().getId());
                ps.executeUpdate();
            }

        } catch (Exception e) {
        }
    }

    public boolean insertOrder1(User u, Cart cart, String notes) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Thêm 1 đơn hàng mới vào cơ sở dữ liệu
            String sql = "insert into [Order] ([user_id],[order_date],[total],[notes],[status]) values (?,GETDATE(), ?, ?,1)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, u.getId());
            ps.setDouble(2, cart.getTotalMoney());
            ps.setString(3, notes);
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                // Lấy Id đơn hàng vừa thêm vào để sử dụng cho việc thêm thông tin đơn hàng
                String sql1 = "select top 1 order_id from [Order] order by order_id desc";
                ps = connection.prepareStatement(sql1);
                rs = ps.executeQuery();

                if (rs.next()) {
                    int oid = rs.getInt(1);
                    // Thêm thông tin chi tiết đơn hàng vào bảng OrderDetail cho từng sản phẩm trong giỏ hàng
                    for (CartItem item : cart.getItems()) {
                        String sql2 = "insert into [OrderDetail] ([order_id],[product_id]  ,[price],[quantity]) values (?,?, ?, ?)";
                        ps = connection.prepareStatement(sql2);
                        ps.setInt(1, oid);
                        ps.setInt(2, item.getProduct().getId());
                        ps.setDouble(3, item.getProduct().getPrice());
                        ps.setInt(4, item.getQuantity());
                        ps.executeUpdate();
                    }
                }
                // Cập nhật số lượng sản phẩm trong bảng product
                String sql3 = "update [Product] set [stock] = [stock] - ? "
                        + "where product_id = ?";
                ps = connection.prepareStatement(sql3);
                for (CartItem item : cart.getItems()) {
                    ps.setInt(1, item.getQuantity());
                    ps.setInt(2, item.getProduct().getId());
                    ps.executeUpdate();
                }
                return true; // Trả về true nếu thêm đơn hàng thành công
            }
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
        } finally {
            // Đóng các tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace(); // In ra lỗi nếu có
            }
        }
        return false; // Trả về false nếu có lỗi xảy ra hoặc không thêm được đơn hàng
    }

// phuong thuc lay danh sach don hang cho mot ngioi dung cu the trong khoang thoi gian nhat dinh
    public ArrayList<Order> getAllOrderByuId(int uid, String fdate, String tdate, int offset, int noOfRecords) {
        if (fdate.isEmpty()) {
            fdate = "1990-01-01";
        }
        if (tdate.isEmpty()) {
            tdate = "2990-01-01";
        }
        ArrayList<Order> ol = new ArrayList<>();
        String sql = "SELECT * FROM [Order] WHERE user_id = ? AND [order_date] BETWEEN ? AND ? "
                + "ORDER BY [order_date] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, uid);
            ps.setString(2, fdate);
            ps.setString(3, tdate);
            ps.setInt(4, offset);
            ps.setInt(5, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ol.add(new Order(rs.getInt(1), new User(rs.getInt(2)), rs.getDate(3), rs.getDouble(4), rs.getString(5), rs.getInt(6)));
            }
            rs.close();

            String countSql = "SELECT COUNT(*) FROM [Order] WHERE user_id = ? AND [order_date] BETWEEN ? AND ?";
            PreparedStatement countPs = connection.prepareStatement(countSql);
            countPs.setInt(1, uid);
            countPs.setString(2, fdate);
            countPs.setString(3, tdate);
            rs = countPs.executeQuery();
            if (rs.next()) {
                this.noOfRecords = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ol;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

    public int getTotalPage(int userId, String fdate, String tdate, int pageSize) {
        if (fdate.isEmpty()) {
            fdate = "1990-01-01";
        }
        if (tdate.isEmpty()) {
            tdate = "2990-01-01";
        }
        String sql = "SELECT COUNT(*) FROM [Order] WHERE user_id = ? AND [order_date] BETWEEN ? AND ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, fdate);
            ps.setString(3, tdate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int totalOrder = rs.getInt(1);
                return (int) Math.ceil((double) totalOrder / pageSize);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // Giá trị mặc định nếu không có đơn hàng nào
    }

    public int getTotalPageOfAllOrder(String fdate, String tdate, int pageSize) {
        if (fdate.isEmpty()) {
            fdate = "1990-01-01";
        }
        if (tdate.isEmpty()) {
            tdate = "2990-01-01";
        }
        String sql = "SELECT COUNT(*) FROM [Order] WHERE [order_date] BETWEEN ? AND ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fdate);
            ps.setString(2, tdate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int totalOrder = rs.getInt(1);
                return (int) Math.ceil((double) totalOrder / pageSize);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // Giá trị mặc định nếu không có đơn hàng nào
    }

    public ArrayList<Order> getAllOrder(String status, String fdate, String tdate, String search, int offset, int noOfRecords) {
        if ("".equals(fdate)) {
            fdate = "1990-01-01";
        }
        if ("".equals(tdate)) {
            tdate = "2990-01-01";
        }
        ArrayList<Order> ol = new ArrayList<>();

        String sql = "SELECT * FROM [Order] o JOIN Users u ON o.user_id = u.user_id WHERE (u.user_name LIKE ? OR u.phone LIKE ? OR u.address LIKE ? OR o.order_id LIKE ?) AND o.[order_date] BETWEEN ? AND ?";

        // Thêm điều kiện status vào câu SQL nếu status khác null
        if (status != null && !"".equals(status)) {
            sql += " AND o.status = ?";
        }

        sql += " ORDER BY o.[order_date] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        System.out.println(sql);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            ps.setString(4, "%" + search + "%");
            ps.setString(5, fdate);
            ps.setString(6, tdate);

            // Đặt giá trị status nếu được cung cấp và khác null
            int parameterIndex = 7;
            if (status != null && !"".equals(status)) {
                ps.setString(parameterIndex++, status);
            }

            ps.setInt(parameterIndex++, offset);
            ps.setInt(parameterIndex++, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ol.add(new Order(rs.getInt(1), new User(rs.getInt(2)), rs.getDate(3), rs.getDouble(4), rs.getString(5), rs.getInt(6), rs.getString("phone"), rs.getString("user_name"), rs.getString("address")));
            }

            // Đếm số lượng bản ghi
            String countSql = "SELECT COUNT(*) FROM [Order] WHERE [order_date] BETWEEN ? AND ?";
            PreparedStatement countPs = connection.prepareStatement(countSql);
            countPs.setString(1, fdate);
            countPs.setString(2, tdate);
            rs = countPs.executeQuery();
            if (rs.next()) {
                this.noOfRecords = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ol;
    }

    public ArrayList<OrderDetail> getAllOrderDetailByoId(int oid) {
        ArrayList<OrderDetail> odl = new ArrayList<>();
        String sql = " SELECT  p.*, o.* FROM [OrderDetail] o, Product p where o.product_id = p.product_id and o.order_id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, oid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), new Category(rs.getInt("category_id")), rs.getString(6), rs.getString(7), rs.getDate(8));
                odl.add(new OrderDetail(rs.getInt("detail_id"), rs.getInt("order_id"), p, rs.getDouble("price"), rs.getInt("quantity")));
            }
        } catch (Exception e) {
        }
        return odl;
    }

    public int getNumberOrder() {
        String sql = "  select count(*)from  OrderDetail";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public double getTotalProfit() {
        String sql = "  select sum(price*quantity) from OrderDetail";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateStatusOrder(int status, int id) {
        try {
            String sql = " update [Order] set status = " + status + " where [order_id] =" + id;
            System.out.println(sql);
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteOrder(String[] orderIds) {
        if (orderIds == null || orderIds.length == 0) {
            return;
        }

        PreparedStatement ps = null;

        try {
            String deleteOrderDetailSql = "DELETE FROM OrderDetail WHERE order_id IN (";
            StringBuilder placeholdersDetail = new StringBuilder();
            for (int i = 0; i < orderIds.length; i++) {
                placeholdersDetail.append("?");
                if (i < orderIds.length - 1) {
                    placeholdersDetail.append(", ");
                }
            }
            deleteOrderDetailSql += placeholdersDetail.toString() + ")";

            ps = connection.prepareStatement(deleteOrderDetailSql);
            for (int i = 0; i < orderIds.length; i++) {
                if (!orderIds[i].isEmpty()) {
                    ps.setInt(i + 1, Integer.parseInt(orderIds[i]));
                }
            }
            ps.executeUpdate();

            String deleteOrderSql = "DELETE FROM [Order] WHERE order_id IN (";
            StringBuilder placeholdersOrder = new StringBuilder();
            for (int i = 0; i < orderIds.length; i++) {
                placeholdersOrder.append("?");
                if (i < orderIds.length - 1) {
                    placeholdersOrder.append(", ");
                }
            }
            deleteOrderSql += placeholdersOrder.toString() + ")";

            ps = connection.prepareStatement(deleteOrderSql);
            for (int i = 0; i < orderIds.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(orderIds[i]));
            }
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {

        try {
            // Tạo một đối tượng OrderDAO
            OrderDAO orderDAO = new OrderDAO();

            // Khởi tạo các tham số cần thiết cho hàm getAllOrder
            String uid = ""; // Nếu bạn không có thông tin về uid, bạn có thể để giá trị này là chuỗi rỗng
            String fdate = ""; // Ngày bắt đầu khoảng thời gian
            String tdate = ""; // Ngày kết thúc khoảng thời gian
            String search = ""; // Từ khóa tìm kiếm, nếu không có thì để là chuỗi rỗng
            int offset = 0; // Vị trí bắt đầu của trang
            int noOfRecords = 5; // Số lượng bản ghi trên mỗi trang

            // Gọi hàm getAllOrder từ OrderDAO
            ArrayList<Order> orderList = orderDAO.getAllOrder("1", fdate, tdate, search, offset, noOfRecords);

            // In ra thông tin về đơn hàng
            for (Order order : orderList) {
                System.out.println("Order ID: " + order.getId());
                System.out.println("Order Date: " + order.getOrderDate());
                System.out.println("Total: " + order.getTotal());
                System.out.println("Status: " + order.getStatus());
                System.out.println("Phone: " + order.getPhone());
                System.out.println("User Name: " + order.getUserName());
                System.out.println("Address: " + order.getAddress());
                System.out.println("-----------------------------");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
