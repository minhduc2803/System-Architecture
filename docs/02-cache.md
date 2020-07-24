# CACHING

## 1. Vai trò của cache

Cache là một thành phần phần cứng hoặc phần mềm dùng lưu trữ dữ liệu để phục vụ cho các request tương lai, giúp các request đó lấy dữ liệu ra nhanh hơn.

Ví dụ như CPU cache, dữ liệu được lưu trong cache gần CPU sẽ được CPU lấy ra nhanh hơn là dữ liệu nằm trong RAM. Từ đó người ta có thể tăng tốc chương trình bằng cách lưu trữ dữ liệu hay dùng vào cache để giảm thời gian truy cập RAM của CPU.

![](../images/cpu-cache.jpg)

Đặc điểm chung là cache sẽ nằm gần nguồn request, lưu trữ các thông tin mà cache nghĩ rằng sẽ được dùng nhiều trong tương lai gần.

Tùy thuộc vào vị trí, nhiệm vụ, cache có nhiều loại khác nhau: web cache, disk cache, CPU cache,...

Như vậy vai trò chính của cache là tăng tốc chương trình, tăng tốc độ truy cập, giảm thời gian trễ. 
## 2. Các thuật toán caching

Bộ nhớ cache thường có tốc truy xuất nhanh nhưng đổi lại lưu lượng thường thấp. Thậm chí một số cache có thời gian truy xuất với các phần tử trong nó là khác nhau. Nên cần phải một thuật toán caching, thể cách lưu trữ, thay thế dữ liệu để phát huy tối đa khả năng của một cache.

### Kỹ thuật Least recently used (LRU)

Là một kỹ thuật loại bỏ những data cũ nhất trong cache (những data đã quá lâu không được truy xuất) để tạo khoảng trống cho các data mới.

Có nhiều cách để implement một LRU cache. Dưới đây sử dụng một cách quen thuộc.

Dùng một double linked list để lưu các phần tử . Khi một phần tử được truy xuất sẽ được mang lên đầu đầu list, dồn các phần còn lại xuống dưới. Khi đó ta có phần tử tail của list là phần tử ít dùng nhất, để loại bỏ phần tử này chỉ tốn thời gian O(1). Khi thêm một tử mới, phần tử sẽ được thêm vào đầu list, nên thời gian thêm vào cũng chỉ tốn O(1). Nhưng thời gian truy xuất tới một phần tử bất kỳ có thể mất tới O(n).

![](../images/list.svg)


Dùng thêm một hash map để lưu địa chỉ mỗi các phần tử trong linked list. Khi đó thời gian truy xuất tới mọi phần tử chỉ mất O(1). Nếu hash map được 
### Kỹ thuật Least frequently used (LFU)

