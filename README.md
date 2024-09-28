# DAILY PLANNER APPLICATION

Ứng dụng ghi chú các công việc thực hiện bằng Flutter và Firebase

## Chức năng chính

- Đăng nhập - đăng ký để lưu thông tin người dùng. Sử dụng SSO để tránh đăng nhập nhiều lần.
- Thêm công việc/nhiệm vụ. Có thực hiện thông báo đến người dùng bằng Local Notification để thông báo trước 15 phút khi có nhiệm vụ sắp tới.
- Sử dụng Firebase để lưu nhiệm vụ, dùng StreamQuerySnapshot của Firebase để hiển thị nhiệm vụ theo thời gian.
- Chuyển đổi giữa các theme màu và chế độ sáng - tối
- Chức năng theo dõi hành động của nhiệm vụ khi có thay đổi

### Điều chưa làm được - hướng phát triển
- Lưu nhiệm vụ đa tài khoản. Một nhiệm vụ có thể có nhiều người tham gia
- Mở rộng thêm nhiều lựa chọn theme màu chủ đạo cho ứng dụng. Thêm chức năng đổi ngôn ngữ
- Trang thống kê những nhiệm vụ mới, đang thực hiện và đã kết thúc. Thống kê sử dụng biểu đồ trực quan 
