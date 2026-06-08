Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31BC3F5BED
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932078; cv=none; b=EXH/KZHTity9rgXPG0uVKv4A+AyUyZbNQjc//oALz8G5DVfuJnRJCxt1vRWO1vHDCv5c/Lw+QJF4yMsm+MjQai45IDx9gTQ2WcCQsLowfxtd50ln1FA/aNujvwyP2zKcHgodeAiuTXvix8FqPdcsqVmlrAO0uJRDADs/zYzkyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932078; c=relaxed/simple;
	bh=0H8btrO3XE996UmD57wM0yZdPr07haD3RLlIh36Dgpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL6z4X/yj+R3X+JOf4Qt+rN/9dzHUQKf3lhoiGt51BpNgLKA63sudHtbs/IqzwcnBkRhtfxT3oYIlyUwHMbN3AUXF6S4oPWHmz00qMovWNkYqTXWrHwU4GNQXAGfXBxyrL2fILUqcMHUIiycuBRCAg3B/FIHrQsW+Vjhqu1+YLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1D402202944;
	Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 03/10] accel/kvm: Extend CPUState to handle Planes
Date: Mon,  8 Jun 2026 17:21:02 +0200
Message-ID: <20260608152109.356783-4-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Extend the KVM specific part of the CPUState data structure to handle
the FDs for multiple planes.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c      | 121 +++++++++++++++++++++++++++++++--------
 accel/kvm/trace-events   |   1 +
 include/hw/core/cpu.h    |  17 +++++-
 include/system/kvm.h     |   4 ++
 include/system/kvm_int.h |   8 +++
 5 files changed, 126 insertions(+), 25 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1a2f8e0f417c..7429e2be8ba9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -133,6 +133,7 @@ static NotifierWithReturnList register_vcpufd_changed_notifiers =
 static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
 static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
 static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
+static void kvm_alloc_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd);
 
 struct KVMResampleFd {
     int gsi;
@@ -429,10 +430,16 @@ err:
 
 static void kvm_create_vcpu_internal(CPUState *cpu, KVMState *s, int kvm_fd)
 {
-    cpu->kvm_fd = kvm_fd;
+    if (cpu->kvm_plane_state[0] == NULL) {
+        kvm_alloc_vcpu_plane(cpu, 0, kvm_fd);
+    } else {
+        cpu_kvm_plane(cpu, 0)->kvm_fd = kvm_fd;
+    }
+
+    cpu->kvm_plane = 0;
     cpu->kvm_state = s;
     if (!s->guest_state_protected) {
-        cpu->vcpu_dirty = true;
+        cpu_kvm_plane(cpu, 0)->vcpu_dirty = true;
     }
     cpu->dirty_pages = 0;
     cpu->throttle_us_per_full = 0;
@@ -450,8 +457,8 @@ static int kvm_rebind_vcpus(Error **errp)
     CPU_FOREACH(cpu) {
         vcpu_id = kvm_arch_vcpu_id(cpu);
 
-        if (cpu->kvm_fd) {
-            close(cpu->kvm_fd);
+        if (cpu_kvm_plane(cpu, 0)->kvm_fd) {
+            close(cpu_kvm_plane(cpu, 0)->kvm_fd);
         }
 
         ret = kvm_arch_destroy_vcpu(cpu);
@@ -501,8 +508,9 @@ static int kvm_rebind_vcpus(Error **errp)
                              vcpu_id);
         }
 
-        close(cpu->kvm_vcpu_stats_fd);
-        cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
+        close(cpu_kvm_plane(cpu, 0)->kvm_vcpu_stats_fd);
+        cpu_kvm_plane(cpu, 0)->kvm_vcpu_stats_fd =
+            kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
         kvm_init_cpu_signals(cpu);
     }
     trace_kvm_rebind_vcpus();
@@ -519,7 +527,7 @@ static void kvm_park_vcpu(CPUState *cpu)
 
     vcpu = g_malloc0(sizeof(*vcpu));
     vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
-    vcpu->kvm_fd = cpu->kvm_fd;
+    vcpu->kvm_fd = cpu_kvm_plane(cpu, 0)->kvm_fd;
     QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
 }
 
@@ -551,6 +559,34 @@ static void kvm_reset_parked_vcpus(KVMState *s)
     }
 }
 
+static void kvm_alloc_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
+{
+    struct KVMPlane *p = NULL;
+
+    if (cpu->kvm_plane_state[plane_id] != NULL) {
+        return;
+    }
+
+    p = g_malloc0(sizeof(struct KVMPlane));
+    p->kvm_fd = kvm_fd;
+
+    cpu->kvm_plane_state[plane_id] = p;
+}
+
+void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
+{
+    int vcpu_fd = cpu_kvm_plane(cpu, 0)->kvm_fd;
+    int plane_fd = kvm_vm_plane_ioctl(cpu->kvm_state, plane_id, KVM_CREATE_VCPU, vcpu_fd);
+
+    if (plane_fd < 0) {
+        fprintf(stderr, "Failed to create plane vcpu\n");
+        abort();
+    }
+
+    kvm_alloc_vcpu_plane(cpu, plane_id, plane_fd);
+}
+
+
 /**
  * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
  * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
@@ -676,7 +712,7 @@ static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp)
     }
 
     cpu->kvm_run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-                        cpu->kvm_fd, 0);
+                        cpu_kvm_plane(cpu, 0)->kvm_fd, 0);
     if (cpu->kvm_run == MAP_FAILED) {
         ret = -errno;
         error_setg_errno(errp, ret,
@@ -700,7 +736,7 @@ static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp)
     /* Use MAP_SHARED to share pages with the kernel */
     cpu->kvm_dirty_gfns = mmap(NULL, s->kvm_dirty_ring_bytes,
                                PROT_READ | PROT_WRITE, MAP_SHARED,
-                               cpu->kvm_fd,
+                               cpu_kvm_plane(cpu, 0)->kvm_fd,
                                PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET);
     if (cpu->kvm_dirty_gfns == MAP_FAILED) {
         ret = -errno;
@@ -747,7 +783,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
                          "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
                          kvm_arch_vcpu_id(cpu));
     }
-    cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
+    cpu_kvm_plane(cpu, 0)->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
 
 err:
     return ret;
@@ -762,11 +798,17 @@ void kvm_close(void)
     }
 
     CPU_FOREACH(cpu) {
+        unsigned plane_id = KVM_MAX_PLANES;
         cpu_remove_sync(cpu);
-        close(cpu->kvm_fd);
-        cpu->kvm_fd = -1;
-        close(cpu->kvm_vcpu_stats_fd);
-        cpu->kvm_vcpu_stats_fd = -1;
+        do {
+            struct KVMPlane *plane;
+            plane_id--;
+            plane = cpu_kvm_plane(cpu, plane_id);
+            close(plane->kvm_fd);
+            plane->kvm_fd = -1;
+            close(plane->kvm_vcpu_stats_fd);
+            plane->kvm_vcpu_stats_fd = -1;
+        } while (plane_id != 0);
     }
 
     if (kvm_state && kvm_state->fd != -1) {
@@ -3238,7 +3280,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
 
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
+    KVMPlane *plane = cpu_active_kvm_plane(cpu);
+
+    if (!plane->vcpu_dirty && !kvm_state->guest_state_protected) {
         Error *err = NULL;
         int ret = kvm_arch_get_registers(cpu, &err);
         if (ret) {
@@ -3252,13 +3296,15 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
 
-        cpu->vcpu_dirty = true;
+        plane->vcpu_dirty = true;
     }
 }
 
 void kvm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
+    KVMPlane *plane = cpu_active_kvm_plane(cpu);
+
+    if (!plane->vcpu_dirty && !kvm_state->guest_state_protected) {
         run_on_cpu(cpu, do_kvm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -3278,7 +3324,7 @@ static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
         return false;
     }
 
-    cpu->vcpu_dirty = false;
+    cpu_active_kvm_plane(cpu)->vcpu_dirty = false;
 
     return true;
 }
@@ -3320,7 +3366,7 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->vcpu_dirty = true;
+    cpu_active_kvm_plane(cpu)->vcpu_dirty = true;
 }
 
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -3478,6 +3524,7 @@ out_unref:
 
 int kvm_cpu_exec(CPUState *cpu)
 {
+    KVMPlane *plane = cpu_active_kvm_plane(cpu);
     struct kvm_run *run = cpu->kvm_run;
     int ret, run_ret;
 
@@ -3493,7 +3540,7 @@ int kvm_cpu_exec(CPUState *cpu)
     do {
         MemTxAttrs attrs;
 
-        if (cpu->vcpu_dirty) {
+        if (plane->vcpu_dirty) {
             if (!kvm_cpu_synchronize_put(cpu, KVM_PUT_RUNTIME_STATE,
                                          "at runtime")) {
                 ret = -1;
@@ -3725,8 +3772,36 @@ int kvm_vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, ...)
     return __vm_plane_ioctl(s, plane_id, type, arg);
 }
 
+static inline int __vcpu_plane_ioctl(KVMPlane *plane, unsigned long type, void *arg)
+{
+    return ioctl(plane->kvm_fd, type, arg);
+}
+
+int kvm_vcpu_plane_ioctl(CPUState *cpu, unsigned plane_id, unsigned long type, ...)
+{
+    KVMPlane *plane = cpu_kvm_plane(cpu, plane_id);
+    int ret;
+    void *arg;
+    va_list ap;
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    trace_kvm_vcpu_plane_ioctl(cpu->cpu_index, plane_id, type, arg);
+    accel_cpu_ioctl_begin(cpu);
+    ret = __vcpu_plane_ioctl(plane, type, arg);
+    accel_cpu_ioctl_end(cpu);
+    if (ret == -1) {
+        ret = -errno;
+    }
+    return ret;
+}
+
 int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
 {
+    /* Most VCPU IOCTLs (including KVM_RUN) must happen on the Plane-0 FD */
+    KVMPlane *plane = cpu_kvm_plane(cpu, 0);
     int ret;
     void *arg;
     va_list ap;
@@ -3737,7 +3812,7 @@ int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
 
     trace_kvm_vcpu_ioctl(cpu->cpu_index, type, arg);
     accel_cpu_ioctl_begin(cpu);
-    ret = ioctl(cpu->kvm_fd, type, arg);
+    ret = __vcpu_plane_ioctl(plane, type, arg);
     accel_cpu_ioctl_end(cpu);
     if (ret == -1) {
         ret = -errno;
@@ -4731,7 +4806,7 @@ static void query_stats_schema(StatsSchemaList **result, StatsTarget target,
 
 static void query_stats_vcpu(CPUState *cpu, StatsArgs *kvm_stats_args)
 {
-    int stats_fd = cpu->kvm_vcpu_stats_fd;
+    int stats_fd = cpu_active_kvm_plane(cpu)->kvm_vcpu_stats_fd;
     Error *local_err = NULL;
 
     if (stats_fd == -1) {
@@ -4746,7 +4821,7 @@ static void query_stats_vcpu(CPUState *cpu, StatsArgs *kvm_stats_args)
 
 static void query_stats_schema_vcpu(CPUState *cpu, StatsArgs *kvm_stats_args)
 {
-    int stats_fd = cpu->kvm_vcpu_stats_fd;
+    int stats_fd = cpu_active_kvm_plane(cpu)->kvm_vcpu_stats_fd;
     Error *local_err = NULL;
 
     if (stats_fd == -1) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 2f3bd9ba7052..1ca7be8a4b3b 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -5,6 +5,7 @@ kvm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
 kvm_vm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
 kvm_vm_plane_ioctl(unsigned long type, unsigned id, void *arg) "type 0x%lx, plane_id %d arg %p"
 kvm_vcpu_ioctl(int cpu_index, unsigned long type, void *arg) "cpu_index %d, type 0x%lx, arg %p"
+kvm_vcpu_plane_ioctl(int cpu_index, unsigned plane_id, unsigned long type, void *arg) "cpu_index %d, plane_id %u type 0x%lx, arg %p"
 kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
 kvm_device_ioctl(int fd, unsigned long type, void *arg) "dev fd %d, type 0x%lx, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04e1f970caf2..4025db67e13b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -36,6 +36,7 @@
 #include "qemu/lockcnt.h"
 #include "qemu/thread.h"
 #include "qom/object.h"
+#include "linux/kvm.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
                                      void *opaque);
@@ -545,13 +546,15 @@ struct CPUState {
     uintptr_t mem_io_pc;
 
     /* Only used in KVM */
-    int kvm_fd;
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
     struct kvm_dirty_gfn *kvm_dirty_gfns;
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
-    int kvm_vcpu_stats_fd;
+
+    /* KVM plane state */
+    unsigned kvm_plane;                                    /* Current active plane */
+    struct KVMPlane *kvm_plane_state[KVM_MAX_PLANES]; /* Per-Plane state */
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -596,6 +599,16 @@ struct CPUState {
     CPUNegativeOffsetState neg;
 };
 
+static inline struct KVMPlane *cpu_kvm_plane(CPUState *s, unsigned plane_id)
+{
+	return s->kvm_plane_state[plane_id];
+}
+
+static inline struct KVMPlane *cpu_active_kvm_plane(CPUState *s)
+{
+	return s->kvm_plane_state[s->kvm_plane];
+}
+
 /* Validate placement of CPUNegativeOffsetState. */
 QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
                   sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 885ed35b061a..16597333cfa5 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -172,10 +172,12 @@ typedef struct KVMCapabilityInfo {
 #define KVM_CAP_INFO(CAP) { "KVM_CAP_" stringify(CAP), KVM_CAP_##CAP }
 #define KVM_CAP_LAST_INFO { NULL, 0 }
 
+struct KVMPlane;
 struct KVMState;
 
 #define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
 typedef struct KVMState KVMState;
+typedef struct KVMPlane KVMPlane;
 DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
                          TYPE_KVM_ACCEL)
 
@@ -219,6 +221,7 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
 int kvm_vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, ...);
 
 int kvm_get_or_create_plane_fd(KVMState *s, unsigned id);
+void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane, int kvm_fd);
 
 void kvm_flush_coalesced_mmio_buffer(void);
 
@@ -251,6 +254,7 @@ static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_t
 
 int kvm_ioctl(KVMState *s, unsigned long type, ...);
 
+int kvm_vcpu_plane_ioctl(CPUState *cpu, unsigned plane_id, unsigned long type, ...);
 int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...);
 
 /**
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index bfac331949f9..70b381f1ba05 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -101,6 +101,14 @@ struct KVMDirtyRingReaper {
     volatile uint64_t reaper_iteration; /* iteration number of reaper thr */
     volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state */
 };
+
+/* VCPU per-plane state */
+struct KVMPlane {
+    int kvm_fd;
+    int kvm_vcpu_stats_fd;
+    bool vcpu_dirty;
+};
+
 struct KVMState
 {
     AccelState parent_obj;
-- 
2.53.0

