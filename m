Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299C03B8D76
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423437; cv=none; b=lv5vjMKtHsjzFdAas04TBtGdpBZ+pPPuUPMUpelHOk4tRxsPcP5L3SkwUKhb3zfrZHadCfoNmYBQX7xaoJGj1mjkqo6f/tUk+ilogN7/fXrEVonwHwIqQuNP5e/szI2Jt0GvaLsIbSmqxk9bDn17hU5n3L/tc/slCTwVU1wkXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423437; c=relaxed/simple;
	bh=/uO7CUoFaSv/6fdDD2kMuoohBFYaNAzROGJnXtWJuWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5RPpBFUq5S1qx4hwiJ8+2izVVtBrbpxqv/gYUuiSkc1e69oFU8xqQWwdQSdYdtY1ZZhVXX0cg3TzDXgNdfdNqDKVysnHZpH5kSU9nRShkrwWXPek1ey1cvM0e4s83pkuNHANaySHrAVbxEnqLmhu68TK41gPpikWMiBIuPMt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pCtQQ8/u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pCtQQ8/u"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id EFCDC20B7129;
	Fri, 17 Apr 2026 03:57:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFCDC20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423435;
	bh=kAv+LDx2C4ktwPdqcp1byyxTrJZIOpxr4ispcmeai88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCtQQ8/u06ztShHZMaxq6QkWoKHL8hHK02vn3C0K60/tUu5/7j8mcQQ+4Ok7atcFd
	 oVBtwIbsq5FDCg9Jvx4y3fTUd2b5lk3Om0/K4DVLd3uLOrEYYezvMV91aJ6Dhd7gsL
	 4zYPoIPWIAAiDTPD9b44kZQLNKrOS9yCfLN67oww=
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
Subject: [PATCH 14/34] target/i386/mshv: move apic logic into own file
Date: Fri, 17 Apr 2026 12:55:58 +0200
Message-Id: <20260417105618.3621-15-magnuskulke@linux.microsoft.com>
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

Use a new file to unclutter the vcpu code gradually from APIC related
logic.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv_int.h    |  8 ++++
 target/i386/mshv/meson.build |  1 +
 target/i386/mshv/mshv-apic.c | 78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 target/i386/mshv/mshv-apic.c

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 7af5bcf022..f86c7a3be6 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -16,6 +16,8 @@
 
 #define MSHV_MSR_ENTRIES_COUNT 64
 
+struct mshv_get_set_vp_state;
+
 typedef struct hyperv_message hv_message;
 
 typedef struct MshvHvCallArgs {
@@ -84,6 +86,12 @@ void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
+int mshv_set_lapic(int cpu_fd,
+                   const struct hv_local_interrupt_controller_state *state);
+int mshv_get_lapic(int cpu_fd,
+                   struct hv_local_interrupt_controller_state *state);
+int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
+int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state);
 
 typedef struct mshv_root_hvcall mshv_root_hvcall;
 int mshv_hvcall(int fd, const mshv_root_hvcall *args);
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 49f28d4a5b..5eb6e833a6 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -1,6 +1,7 @@
 i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
+  'mshv-apic.c',
   'mshv-cpu.c',
 ))
 
diff --git a/target/i386/mshv/mshv-apic.c b/target/i386/mshv/mshv-apic.c
new file mode 100644
index 0000000000..e0e8b8cacf
--- /dev/null
+++ b/target/i386/mshv/mshv-apic.c
@@ -0,0 +1,78 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/memalign.h"
+#include "qemu/error-report.h"
+
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+#include "linux/mshv.h"
+#include "hw/hyperv/hvgdk.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk_mini.h"
+
+#include <sys/ioctl.h>
+
+int mshv_get_lapic(int cpu_fd,
+                   struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = mshv_get_vp_state(cpu_fd, &mshv_state);
+    if (ret == 0) {
+        memcpy(state, buffer, sizeof(*state));
+    }
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to get lapic");
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_set_lapic(int cpu_fd,
+                   const struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    if (!state) {
+        error_report("lapic state is NULL");
+        return -1;
+    }
+    memcpy(buffer, state, sizeof(*state));
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = mshv_set_vp_state(cpu_fd, &mshv_state);
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to set lapic: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
-- 
2.34.1

