Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113CD3B7759
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274352; cv=none; b=LI4wAueL8LRAjdNWCqX+3M93QvuF24N7R1ezJGtJwpYly2qS4uNHZgwwnBn5q1mb8qtkVEpvdx+F29S0M6AiwFzxR4WEVCHeQH5cGtvW7/OfRvL8yd+90sXgkXMxMF5AeK8baWDPoqfw3mj2MyL3ZaI7YjB/61897wQdd9SyMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274352; c=relaxed/simple;
	bh=5HpJ55oEun3MHpdz3QU5FkVZmM89Ct5Fyt/jU8NoWOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+QpU9ke3mwQO3rIK/8R7fMoCcUgQG4FvEMh5yd4z1OJbPYSlTQWf7LNq3cBkewFVqm0MYj7v42SfcwwmtnL9Zr3nPJJoHBW00xkK1mWQIKAKh6u0j3E3d4u60ChMIerNclUNO9nto5b5Sy5rVZsjH50qAoDKMQrsOdkSSOx2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jZX5ekNX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jZX5ekNX"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93A7A20B6F01;
	Mon, 23 Mar 2026 06:59:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93A7A20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274350;
	bh=jJHde85rrqP4JFlhsgAekskobRmJMJo3MVNFcALWQys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZX5ekNXnuKDmViDKWeLe6jPJW1ZxH4BagMdEbQpl9FVooJfy4oELFciJEKl/fD9N
	 r+HeF1+fyAGCc3DgLc/1h0q7baBYN2anFR+F+rJkawuEcIX5uwLavbaT+EqUHESexU
	 320eLM+0Fm/ybrVMxVA9wZAb6AXSpJpc7mBvTRrk=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 14/32] target/i386/mshv: move apic logic into own file
Date: Mon, 23 Mar 2026 14:57:54 +0100
Message-Id: <20260323135812.383509-15-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
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
 target/i386/mshv/mshv-cpu.c  | 66 +++---------------------------
 4 files changed, 92 insertions(+), 61 deletions(-)
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
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 56656ac0b0..54c262d8bc 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -919,7 +919,7 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
-static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
+int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
 {
     int ret;
 
@@ -932,39 +932,12 @@ static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
     return 0;
 }
 
-static int get_lapic(const CPUState *cpu,
-                     struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = get_vp_state(cpu_fd, &mshv_state);
-    if (ret == 0) {
-        memcpy(state, buffer, sizeof(*state));
-    }
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to get lapic");
-        return -1;
-    }
-
-    return 0;
-}
-
 static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
 {
     return ((reg) & ~0x700) | ((mode) << 8);
 }
 
-static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
+int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
 {
     int ret;
 
@@ -977,43 +950,14 @@ static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
     return 0;
 }
 
-static int set_lapic(const CPUState *cpu,
-                     const struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    if (!state) {
-        error_report("lapic state is NULL");
-        return -1;
-    }
-    memcpy(buffer, state, sizeof(*state));
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = set_vp_state(cpu_fd, &mshv_state);
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to set lapic: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
 static int init_lint(const CPUState *cpu)
 {
     int ret;
     uint32_t *lvt_lint0, *lvt_lint1;
+    int cpu_fd = mshv_vcpufd(cpu);
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
-    ret = get_lapic(cpu, &lapic_state);
+    ret = mshv_get_lapic(cpu_fd, &lapic_state);
     if (ret < 0) {
         return ret;
     }
@@ -1026,7 +970,7 @@ static int init_lint(const CPUState *cpu)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return set_lapic(cpu, &lapic_state);
+    return mshv_set_lapic(cpu_fd, &lapic_state);
 }
 
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
-- 
2.34.1

