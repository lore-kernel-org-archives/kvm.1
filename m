Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BAA3F5BEC
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932078; cv=none; b=kZ08dPr1q1SPd4KmApblSVBPC/kd4TtOxEMrS8ezKqinsHQSK34PFLhlp7g8yVBciqxXFEHGx+xDQE6ZgdECcPMC93OHaWLI6szA3vkgONqJsF1nIyUSD++zBDYOLUCpThkJhW/5rwdXQ+1u1m65V0wO0YQKh1dqepXRHXiMunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932078; c=relaxed/simple;
	bh=qNVohiNH33pygLZJYQAyaygk8Vidu5NGbTz6TPlpep0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFPcwiYGlC7C1FdRxC1Y8fByGP9dpsMB0snboHmJwGyLSGKNpBSH5rlmi3qjJoHfwYl1cuylxoWdbOid+wgTrZ+eRG5mCWpX/ds2ltMg1A7WdbD4IskLDd1gWDCtqCJ9w9umjcycBW0M4+0ZiVxN/FG3D5gQF6DwSjzKUKn2d4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E8939202943;
	Mon,  8 Jun 2026 17:21:14 +0200 (CEST)
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
Subject: [RFC PATCH 02/10] accel/kvm: Extend KVMState to carry fds for planes
Date: Mon,  8 Jun 2026 17:21:01 +0200
Message-ID: <20260608152109.356783-3-joro@8bytes.org>
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

Extend the vmfd member of KVMState into an array and rename it to
plane_fds. The vmfd will be stored at index 0.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c      | 97 ++++++++++++++++++++++++++++++++--------
 accel/kvm/trace-events   |  1 +
 include/system/kvm.h     |  3 ++
 include/system/kvm_int.h | 22 ++++++++-
 target/arm/kvm.c         |  2 +-
 5 files changed, 104 insertions(+), 21 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b1c..1a2f8e0f417c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -770,8 +770,12 @@ void kvm_close(void)
     }
 
     if (kvm_state && kvm_state->fd != -1) {
-        close(kvm_state->vmfd);
-        kvm_state->vmfd = -1;
+        unsigned plane_id = KVM_MAX_PLANES;
+        do {
+            plane_id--;
+            close(kvm_get_plane_fd(kvm_state, plane_id));
+            kvm_set_plane_fd(kvm_state, plane_id, -1);
+        } while (plane_id != 0);
         close(kvm_state->fd);
         kvm_state->fd = -1;
     }
@@ -2774,12 +2778,41 @@ static int kvm_setup_dirty_ring(KVMState *s)
 
     return 0;
 }
+static int kvm_create_plane(KVMState *s, unsigned id)
+{
+    int fd = kvm_vm_ioctl(s, KVM_CREATE_PLANE, id);
+    if (fd >= 0) {
+        kvm_set_plane_fd(s, id, fd);
+    }
+
+    return fd;
+}
+
+int kvm_get_or_create_plane_fd(KVMState *s, unsigned id)
+{
+    int fd = kvm_get_plane_fd(s, id);
+    if (fd >= 0) {
+        return fd;
+    }
+
+    return kvm_create_plane(s, id);
+}
+
+static void kvm_init_plane_fds(KVMState *s)
+{
+    int i;
+
+    for (i = 0; i < KVM_MAX_PLANES; i++) {
+        kvm_set_plane_fd(s, i, -1);
+    }
+}
 
 static int kvm_reset_vmfd(MachineState *ms)
 {
     KVMState *s;
     KVMMemoryListener *kml;
     int ret = 0, type;
+    unsigned plane_id;
     Error *err = NULL;
 
     /*
@@ -2805,9 +2838,14 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
     assert(!err);
 
-    if (s->vmfd >= 0) {
-        close(s->vmfd);
-    }
+    plane_id = KVM_MAX_PLANES;
+    do {
+        plane_id--;
+        if (kvm_get_plane_fd(s, plane_id) >= 0) {
+            close(kvm_get_plane_fd(s, plane_id));
+            kvm_set_plane_fd(s, plane_id, -1);
+        }
+    } while (plane_id != 0);
 
     type = find_kvm_machine_type(ms);
     if (type < 0) {
@@ -2819,7 +2857,7 @@ static int kvm_reset_vmfd(MachineState *ms)
         return ret;
     }
 
-    s->vmfd = ret;
+    kvm_set_vm_fd(s, ret);
 
     /* guest state is now unprotected again */
     kvm_state->guest_state_protected = false;
@@ -2846,7 +2884,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     /*
      * notify everyone that vmfd has changed.
      */
-    vmfd_notifier.vmfd = s->vmfd;
+    vmfd_notifier.vmfd = kvm_vm_fd(s);
     vmfd_notifier.pre = false;
 
     ret = kvm_vmfd_change_notify(&err);
@@ -2913,6 +2951,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
 
     qemu_mutex_init(&kml_slots_lock);
 
+    kvm_init_plane_fds(s);
+
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
@@ -2969,7 +3009,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         goto err;
     }
 
-    s->vmfd = ret;
+    kvm_set_plane_fd(s, 0, ret);
 
     s->nr_as = kvm_vm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
     if (s->nr_as <= 1) {
@@ -3109,8 +3149,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
 
 err:
     assert(ret < 0);
-    if (s->vmfd >= 0) {
-        close(s->vmfd);
+    if (kvm_vm_fd(s) >= 0) {
+        close(kvm_vm_fd(s));
     }
     if (s->fd != -1) {
         close(s->fd);
@@ -3646,9 +3686,21 @@ int kvm_ioctl(KVMState *s, unsigned long type, ...)
     return ret;
 }
 
-int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
+static int __vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, void *arg)
 {
     int ret;
+
+    accel_ioctl_begin();
+    ret = ioctl(kvm_get_plane_fd(s, plane_id), type, arg);
+    accel_ioctl_end();
+    if (ret == -1) {
+        ret = -errno;
+    }
+    return ret;
+}
+
+int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
+{
     void *arg;
     va_list ap;
 
@@ -3657,13 +3709,20 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
     va_end(ap);
 
     trace_kvm_vm_ioctl(type, arg);
-    accel_ioctl_begin();
-    ret = ioctl(s->vmfd, type, arg);
-    if (ret == -1) {
-        ret = -errno;
-    }
-    accel_ioctl_end();
-    return ret;
+    return __vm_plane_ioctl(s, 0, type, arg);
+}
+
+int kvm_vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, ...)
+{
+    void *arg;
+    va_list ap;
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    trace_kvm_vm_plane_ioctl(type, plane_id, arg);
+    return __vm_plane_ioctl(s, plane_id, type, arg);
 }
 
 int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
@@ -4266,8 +4325,8 @@ static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
 
+    kvm_init_plane_fds(s);
     s->fd = -1;
-    s->vmfd = -1;
     s->kvm_shadow_mem = -1;
     s->kernel_irqchip_allowed = true;
     s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 4a8921c632bf..2f3bd9ba7052 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -3,6 +3,7 @@
 # kvm-all.c
 kvm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
 kvm_vm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
+kvm_vm_plane_ioctl(unsigned long type, unsigned id, void *arg) "type 0x%lx, plane_id %d arg %p"
 kvm_vcpu_ioctl(int cpu_index, unsigned long type, void *arg) "cpu_index %d, type 0x%lx, arg %p"
 kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
 kvm_device_ioctl(int fd, unsigned long type, void *arg) "dev fd %d, type 0x%lx, arg %p"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda38..885ed35b061a 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -216,6 +216,9 @@ int kvm_on_sigbus(int code, void *addr);
 int kvm_check_extension(KVMState *s, unsigned int extension);
 
 int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
+int kvm_vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, ...);
+
+int kvm_get_or_create_plane_fd(KVMState *s, unsigned id);
 
 void kvm_flush_coalesced_mmio_buffer(void);
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d3..bfac331949f9 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -107,7 +107,7 @@ struct KVMState
     /* Max number of KVM slots supported */
     int nr_slots_max;
     int fd;
-    int vmfd;
+    int plane_fds[KVM_MAX_PLANES];
     int coalesced_mmio;
     int coalesced_pio;
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
@@ -170,6 +170,26 @@ struct KVMState
     OnOffAuto honor_guest_pat;
 };
 
+static inline void kvm_set_plane_fd(KVMState *s, unsigned plane, int fd)
+{
+    s->plane_fds[plane] = fd;
+}
+
+static inline int kvm_get_plane_fd(KVMState *s, unsigned plane)
+{
+    return s->plane_fds[plane];
+}
+
+static inline void kvm_set_vm_fd(KVMState *s, int vmfd)
+{
+    kvm_set_plane_fd(s, 0, vmfd);
+}
+
+static inline int kvm_vm_fd(KVMState *s)
+{
+    return kvm_get_plane_fd(s, 0);
+}
+
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id, const char *name);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b880..0bc869aa5d92 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -134,7 +134,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
         KVMState kvm_state;
 
         kvm_state.fd = kvmfd;
-        kvm_state.vmfd = vmfd;
+        kvm_set_vm_fd(&kvm_state, vmfd);
         kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
     }
 
-- 
2.53.0

