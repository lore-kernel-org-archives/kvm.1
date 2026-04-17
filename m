Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BA3B38AE
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423511; cv=none; b=dnCsOf2mLYYmYlOO80GIYxDYlUgfHDvknmdNK16a6Lpd1PP4iTjK+FQLsVICYG0ubryvEomgNkgzBUP/F2QAwas9tyupsa6ndOVhQxjv/LUCpoaucA2gEuQxFvofZwaRKVAbhWM6USDv/b4nUTgR0LAsKEFchUom4NjkrAnqnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423511; c=relaxed/simple;
	bh=7HpJKulwScL13okKvBUA2Ly8LNtCpDeAobFosxuOM/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtBNTRzHbDPxYrt0xwJPNODL6s+nAaiHJxIb0aUNi5BlSYV3HGa6vqsu8erVAdIe4hPkqxaTbwyj24By5LkaXeSg9AvLt5ddDXJVHKnByInJl5chxlU1T0rDgXKx0L2dfsa68Adz5Bls5CiXBx+fK2ryFJ3oghxm8h8EeTQr1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mxWuLjOE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mxWuLjOE"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id B45C020B6F08;
	Fri, 17 Apr 2026 03:58:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B45C020B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423509;
	bh=kvyTJIDUKe7YqJFl71haRQV2T+y2d3dK1b5PZUwcZ2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxWuLjOEjAUxvNIuLYImGpTmtpHsNR/BxLzlKu8IQOA72Xf3/D71fBE+NIq3Xv6v0
	 6mZ/NoXIThzSW8ZkS4JS0q4wtISOnoAOhS2Iv28M69oFJGEBaYpyM9p1AQJGJJGbx5
	 ce81SVv33BhYpGdjLCSXj08L3KI78573fswxroM4=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 34/34] accel/mshv: enable dirty page tracking
Date: Fri, 17 Apr 2026 12:56:18 +0200
Message-Id: <20260417105618.3621-35-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces the functions required to perform dirty page
tracking to speed up migrations. We are using the sync, global_start,
and global_stop hooks.

The sync is implemented in batches.

Before we can disable the dirty page tracking we have to set all dirty bits.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c          | 211 ++++++++++++++++++++++++++++++++++++++
 accel/mshv/mshv-all.c     |   3 +
 include/system/mshv_int.h |   5 +
 3 files changed, 219 insertions(+)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index e55c38d4db..820f87ef0c 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -12,10 +12,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "linux/mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
 #include "system/mshv_int.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "system/physmem.h"
 #include "exec/memattrs.h"
 #include <sys/ioctl.h>
 #include "trace.h"
@@ -211,3 +214,211 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
         abort();
     }
 }
+
+static int enable_dirty_page_tracking(int vm_fd)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING;
+    in.property_value = 1;
+
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to enable dirty page tracking: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+/*
+ * Retrieve dirty page bitmap for a GPA range, clearing the dirty bits
+ * atomically. Large ranges are handled in batches.
+ */
+static int get_dirty_log(int vm_fd, uint64_t base_pfn, uint64_t page_count,
+                         unsigned long *bitmap, size_t bitmap_size)
+{
+    uint64_t batch, bitmap_offset, completed = 0;
+    struct mshv_gpap_access_bitmap args = {0};
+    int ret;
+
+    QEMU_BUILD_BUG_ON(MSHV_DIRTY_PAGES_BATCH_SIZE % BITS_PER_LONG != 0);
+    assert(bitmap_size >= ROUND_UP(page_count, BITS_PER_LONG) / 8);
+
+    while (completed < page_count) {
+        batch = MIN(MSHV_DIRTY_PAGES_BATCH_SIZE, page_count - completed);
+        bitmap_offset = completed / BITS_PER_LONG;
+
+        args.access_type = MSHV_GPAP_ACCESS_TYPE_DIRTY;
+        args.access_op   = MSHV_GPAP_ACCESS_OP_CLEAR;
+        args.page_count  = batch;
+        args.gpap_base   = base_pfn + completed;
+        args.bitmap_ptr  = (uint64_t)(bitmap + bitmap_offset);
+
+        ret = ioctl(vm_fd, MSHV_GET_GPAP_ACCESS_BITMAP, &args);
+        if (ret < 0) {
+            error_report("Failed to get dirty log (base_pfn=0x%" PRIx64
+                         " batch=%" PRIu64 "): %s",
+                         base_pfn + completed, batch, strerror(errno));
+            return -1;
+        }
+        completed += batch;
+    }
+
+    return 0;
+}
+
+bool mshv_log_global_start(MemoryListener *listener, Error **errp)
+{
+    int ret;
+
+    ret = enable_dirty_page_tracking(mshv_state->vm);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to enable dirty page tracking");
+        return false;
+    }
+    return true;
+}
+
+static int disable_dirty_page_tracking(int vm_fd)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING;
+    in.property_value = 0;
+
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to disable dirty page tracking: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_dirty_pages(int vm_fd, uint64_t base_pfn, uint64_t page_count)
+{
+    uint64_t batch, completed = 0;
+    unsigned long bitmap[MSHV_DIRTY_PAGES_BATCH_SIZE / BITS_PER_LONG];
+    struct mshv_gpap_access_bitmap args = {0};
+    int ret;
+
+    while (completed < page_count) {
+        batch = MIN(MSHV_DIRTY_PAGES_BATCH_SIZE, page_count - completed);
+
+        args.access_type = MSHV_GPAP_ACCESS_TYPE_DIRTY;
+        args.access_op   = MSHV_GPAP_ACCESS_OP_SET;
+        args.page_count  = batch;
+        args.gpap_base   = base_pfn + completed;
+        args.bitmap_ptr  = (uint64_t)bitmap;
+
+        ret = ioctl(vm_fd, MSHV_GET_GPAP_ACCESS_BITMAP, &args);
+        if (ret < 0) {
+            error_report("Failed to set dirty pages (base_pfn=0x%" PRIx64
+                         " batch=%" PRIu64 "): %s",
+                         base_pfn + completed, batch, strerror(errno));
+            return -1;
+        }
+        completed += batch;
+    }
+
+    return 0;
+}
+
+static bool set_dirty_bits_cb(Int128 start, Int128 len, const MemoryRegion *mr,
+                              hwaddr offset_in_region, void *opaque)
+{
+    int ret, *errp = opaque;
+    hwaddr gpa, size;
+    uint64_t page_count, base_pfn;
+
+    gpa = int128_get64(start);
+    size = int128_get64(len);
+    page_count = size >> MSHV_PAGE_SHIFT;
+    base_pfn = gpa >> MSHV_PAGE_SHIFT;
+
+    if (!mr->ram || mr->readonly) {
+        return false;
+    }
+
+    if (page_count == 0) {
+        return false;
+    }
+
+    ret = set_dirty_pages(mshv_state->vm, base_pfn, page_count);
+
+    /* true aborts the iteration, which is what we want if there's an error */
+    if (ret < 0) {
+        *errp = ret;
+        return true;
+    }
+
+    return false;
+}
+
+void mshv_log_global_stop(MemoryListener *listener)
+{
+    int err = 0;
+    /* MSHV requires all dirty bits to be set before disabling tracking. */
+    FlatView *fv = address_space_to_flatview(&address_space_memory);
+    flatview_for_each_range(fv, set_dirty_bits_cb, &err);
+
+    if (err < 0) {
+        error_report("Failed to set dirty bits before disabling tracking");
+    }
+
+    disable_dirty_page_tracking(mshv_state->vm);
+}
+
+void mshv_log_sync(MemoryListener *listener, MemoryRegionSection *section)
+{
+    hwaddr size, start_addr, mr_offset;
+    uint64_t page_count, base_pfn;
+    size_t bitmap_size;
+    unsigned long *bitmap;
+    ram_addr_t ram_addr;
+    int ret;
+    MemoryRegion *mr = section->mr;
+
+    if (!memory_region_is_ram(mr) || memory_region_is_rom(mr)) {
+        return;
+    }
+
+    size = align_section(section, &start_addr);
+    if (!size) {
+        return;
+    }
+
+    page_count = size >> MSHV_PAGE_SHIFT;
+    base_pfn = start_addr >> MSHV_PAGE_SHIFT;
+    bitmap_size = ROUND_UP(page_count, BITS_PER_LONG) / 8;
+    bitmap = g_malloc0(bitmap_size);
+
+    ret = get_dirty_log(mshv_state->vm, base_pfn, page_count, bitmap,
+                        bitmap_size);
+    if (ret < 0) {
+        g_free(bitmap);
+        return;
+    }
+
+    mr_offset = section->offset_within_region + start_addr -
+                section->offset_within_address_space;
+    ram_addr = memory_region_get_ram_addr(mr) + mr_offset;
+
+    physical_memory_set_dirty_lebitmap(bitmap, ram_addr, page_count);
+    g_free(bitmap);
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index ffe84d6151..94ff9cdb49 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -546,6 +546,9 @@ static MemoryListener mshv_memory_listener = {
     .region_del = mem_region_del,
     .eventfd_add = mem_ioeventfd_add,
     .eventfd_del = mem_ioeventfd_del,
+    .log_sync = mshv_log_sync,
+    .log_global_start = mshv_log_global_start,
+    .log_global_stop = mshv_log_global_stop,
 };
 
 static MemoryListener mshv_io_listener = {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index c24efc8675..ddbdd76076 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -31,6 +31,8 @@ struct mshv_get_set_vp_state;
 #define MSHV_HV_INTERRUPTION_TYPE_PRIV_SW_EXC 5
 #define MSHV_HV_INTERRUPTION_TYPE_SW_EXC      6
 
+#define MSHV_DIRTY_PAGES_BATCH_SIZE 0x10000
+
 typedef struct hyperv_message hv_message;
 
 typedef struct MshvHvCallArgs {
@@ -128,6 +130,9 @@ int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
                          bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
+void mshv_log_sync(MemoryListener *listener, MemoryRegionSection *section);
+bool mshv_log_global_start(MemoryListener *listener, Error **errp);
+void mshv_log_global_stop(MemoryListener *listener);
 
 /* msr */
 int mshv_init_msrs(const CPUState *cpu);
-- 
2.34.1

