Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226C37F74A
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413280; cv=none; b=TKh9sudLvL8wG6U3973HwV7XP2NM+38JkYiRAuSz3QLFfqvCASIO7lWlfR8FOOBgZVAXmMRylK19Bad0uSfZAjDLBghACyLGQrSgcaMsjSYbCtHo7tl2ikGzV6tuzP1pjOaHp6Hth+h3WKlh7hxTSkQTeg3Agr2GuIRmGQJf00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413280; c=relaxed/simple;
	bh=JFSz6ZFH1hrCcIn+hbHyzd9GMHo2jKI4ei6m+meP1PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmcAE6aFvBULbxVUEDB5hV7i8isdIWBx9sLG+qv9O7HaZwCM4w09zLb+D0kZImt1rI2q8Fj0ie6yOJpfHKMATV2zlrqIlvr02p/G2rBVZZhXm9VmWaJUmLA9qfHCM70Lc4ZI2a03653tJzoyFfhmRpF8myWm84BPXCexEuwUAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aYngFkMw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aYngFkMw"
Received: from fedora (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 663B020B7168;
	Mon, 10 Aug 2026 18:54:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 663B020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413253;
	bh=RiyFDBl4g7sqRbB0SrQpXFCXzcGCn8HxNGsDSg+oXnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYngFkMwyRal++UNoKSY34bnBMmVZSABSTW/PrclXHRt42mhzcVkNMToRuRr+pfx7
	 kg6WDC4jF3ekMpLKMNlA+PqoMR7bYYciQfSMWGqzjo4OYUVF0LWgWNJklc0Nno/snS
	 grCd9bSXcX0+p2QmbGHv0JRTrhMaGXkFpyXcIgt4=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 1/1] kvm: handle VM-plane configure/activate hypercalls
Date: Mon, 10 Aug 2026 18:54:27 -0700
Message-ID: <20260811015427.188876-2-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811015427.188876-1-snambakam@linux.microsoft.com>
References: <20260811015427.188876-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The guest plane bootstrap issues KVM_HC_VM_PLANES_CONFIG then
KVM_HC_VM_PLANES_ACTIVATE, which the host exits to userspace.  Handle them
here: CONFIG reads the per-plane vm_plane_config from guest memory, creates
the plane (KVM_CREATE_PLANE) and one sibling vCPU per plane-0 vCPU, and maps
the plane's RAM; ACTIVATE builds identity page tables, a minimal GDT and a
boot zero-page in that RAM and initialises each plane vCPU to enter the
loaded plane kernel in 64-bit mode.

The plane vCPUs are created and initialised on their owning plane-0 vCPU
threads (they share the plane-0 kvm_vcpu_common) and are left STOPPED.
QEMU never runs them: the secure plane boots lazily and in-kernel the first
time the normal plane issues a VBS/VTL call.

Enable userspace exit for the two plane hypercalls; KVM_HC_VBS_VTL_CALL is
handled in-kernel and is intentionally not enabled here.
---
 accel/kvm/kvm-all.c                       |  20 +
 include/standard-headers/linux/kvm_para.h |   2 +
 include/system/kvm_int.h                  |  20 +
 target/i386/kvm/kvm.c                     | 517 ++++++++++++++++++++++
 4 files changed, 559 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46a14ac0f4..0f42fb5b0c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -822,6 +822,26 @@ void kvm_close(void)
             close(kvm_get_plane_fd(kvm_state, plane_id));
             kvm_set_plane_fd(kvm_state, plane_id, -1);
         } while (plane_id != 0);
+        if (kvm_state->vm_planes) {
+            unsigned int i, j;
+            for (i = 1; i < kvm_state->vm_plane_count; i++) {
+                struct kvm_vm_plane_state *ps = &kvm_state->vm_planes[i];
+                if (ps->vcpu_fds) {
+                    for (j = 0; j < ps->vcpu_count; j++) {
+                        if (ps->vcpu_fds[j] >= 0) {
+                            close(ps->vcpu_fds[j]);
+                        }
+                    }
+                    g_free(ps->vcpu_fds);
+                    ps->vcpu_fds = NULL;
+                }
+                g_free(ps->vcpu_cpu_index);
+                ps->vcpu_cpu_index = NULL;
+            }
+            g_free(kvm_state->vm_planes);
+            kvm_state->vm_planes = NULL;
+            kvm_state->vm_plane_count = 0;
+        }
         close(kvm_state->fd);
         kvm_state->fd = -1;
     }
diff --git a/include/standard-headers/linux/kvm_para.h b/include/standard-headers/linux/kvm_para.h
index 015c166302..8810444285 100644
--- a/include/standard-headers/linux/kvm_para.h
+++ b/include/standard-headers/linux/kvm_para.h
@@ -30,6 +30,8 @@
 #define KVM_HC_SEND_IPI		10
 #define KVM_HC_SCHED_YIELD		11
 #define KVM_HC_MAP_GPA_RANGE		12
+#define KVM_HC_VM_PLANES_CONFIG		13
+#define KVM_HC_VM_PLANES_ACTIVATE	14
 
 /*
  * hypercalls use architecture specific
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 70b381f1ba..0ba5d8dacb 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -109,6 +109,22 @@ struct KVMPlane {
     bool vcpu_dirty;
 };
 
+/*
+ * Per-plane VM state managed by the LVBS VM-planes hypercall handlers.
+ * The plane fd itself is owned by the accel layer (kvm_get_plane_fd);
+ * only the plane's vCPU fds and memory description live here.
+ */
+struct kvm_vm_plane_state {
+    int *vcpu_fds;
+    unsigned int *vcpu_cpu_index;
+    unsigned int vcpu_count;
+    uint64_t load_offset;
+    uint64_t memory_size;
+    uint64_t entry_point;
+    void *host_addr;        /* host pointer to plane RAM */
+    char cmdline[512];
+};
+
 struct KVMState
 {
     AccelState parent_obj;
@@ -176,6 +192,10 @@ struct KVMState
     uint16_t xen_evtchn_max_pirq;
     char *device;
     OnOffAuto honor_guest_pat;
+    /* VM planes state (populated by the LVBS hypercall handlers) */
+    struct kvm_vm_plane_state *vm_planes;
+    unsigned int vm_plane_count;
+    unsigned int vm_planes_max;
 };
 
 static inline void kvm_set_plane_fd(KVMState *s, unsigned plane, int fd)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 13cfa60071..357410c159 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -70,6 +70,8 @@
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
 #include "exec/target_page.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "trace.h"
 
 #include CONFIG_DEVICES
@@ -3588,6 +3590,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
     }
 
+    /* Exit to userspace for VM-plane config/activate hypercalls (LVBS). */
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_VM_PLANES_CONFIG) |
+                              BIT_ULL(KVM_HC_VM_PLANES_ACTIVATE))) {
+        warn_report("kvm: failed to enable VM-planes hypercall exit");
+    }
+
     /*
      * Most x86 CPUs in current use have self-snoop, so honoring guest PAT is
      * preferable.  As well, the bochs video driver bug which motivated making
@@ -6519,10 +6527,519 @@ static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
     return 0;
 }
 
+/* ========================================================================
+ * LVBS — VM planes configure/activate hypercall handlers
+ *
+ * The guest plane bootstrap (Linux init/vm_planes.c) issues
+ * KVM_HC_VM_PLANES_CONFIG then KVM_HC_VM_PLANES_ACTIVATE.  QEMU creates the
+ * plane and its per-plane-0 sibling vCPUs and initialises them to enter the
+ * loaded plane kernel in 64-bit mode.  It does NOT run the plane vCPUs: the
+ * secure plane boots lazily, in-kernel, the first time the normal plane
+ * issues a VBS/VTL call (handled by the host via KVM_HC_VBS_VTL_CALL).
+ *
+ * Guest struct vm_plane_config layout (see Linux include/linux/vm_planes.h):
+ *   off  0  u64  load_offset
+ *   off  8  u64  memory_size
+ *   off 16  u64  entry_point
+ *   off 24  u32  kernel_format
+ *   off 28  char kernel[128]
+ *   off 156 char cmdline[512]
+ * ======================================================================== */
+
+#define VM_PLANE_CFG_STRIDE     672
+
+/*
+ * Plane>0 vCPU creation and initialization must run on the OWNING plane-0
+ * vCPU's thread.  A plane>0 vCPU shares its plane-0 sibling's
+ * struct kvm_vcpu_common, including the single embedded preempt_notifier.
+ * KVM_CREATE_VCPU and KVM_SET_{S,}REGS all vcpu_load() the plane vCPU, which
+ * registers that shared notifier on the *calling* task.  If issued from the
+ * hypercall vCPU's thread while a sibling is concurrently in KVM_RUN on
+ * another host CPU, the same hlist_node would be linked onto two tasks'
+ * preempt-notifier lists -> list corruption -> host lockup.  run_on_cpu()
+ * forces the sibling out of KVM_RUN and runs the work on its own thread.
+ */
+struct plane_vcpu_create_ctx {
+    KVMState *s;
+    unsigned int plane_id;
+    unsigned int vcpu_id;
+    int fd;                 /* out: vcpu fd, or -errno on failure */
+};
+
+static void plane_vcpu_create_cb(CPUState *cs, run_on_cpu_data data)
+{
+    struct plane_vcpu_create_ctx *ctx = data.host_ptr;
+    int fd;
+
+    fd = kvm_vm_plane_ioctl(ctx->s, ctx->plane_id, KVM_CREATE_VCPU,
+                            (void *)(uintptr_t)ctx->vcpu_id);
+    ctx->fd = (fd < 0) ? -errno : fd;
+}
+
+static int kvm_handle_hc_vm_planes_config(X86CPU *cpu, struct kvm_run *run)
+{
+    uint64_t gpa = run->hypercall.args[0];
+    uint64_t plane_count = run->hypercall.args[1];
+    uint64_t plane_id;
+    unsigned int plane0_vcpu_count;
+    unsigned int *plane0_vcpu_ids;
+    CPUState *cs;
+    KVMState *s = kvm_state;
+
+    if (!gpa || !plane_count) {
+        run->hypercall.ret = -EINVAL;
+        return 0;
+    }
+
+    if (!s->vm_planes_max) {
+        int max = kvm_vm_ioctl(s, KVM_CHECK_EXTENSION, KVM_CAP_PLANES);
+        if (max <= 0) {
+            error_report("vm_planes: KVM does not support planes");
+            run->hypercall.ret = -ENOTSUP;
+            return 0;
+        }
+        s->vm_planes_max = max;
+    }
+
+    if (plane_count > s->vm_planes_max) {
+        error_report("vm_planes: requested %" PRIu64 " planes but KVM "
+                     "supports %u", plane_count, s->vm_planes_max);
+        run->hypercall.ret = -EINVAL;
+        return 0;
+    }
+
+    if (s->vm_planes) {
+        info_report("vm_planes: already configured, ignoring");
+        run->hypercall.ret = 0;
+        return 0;
+    }
+
+    s->vm_planes = g_new0(struct kvm_vm_plane_state, plane_count);
+    s->vm_plane_count = plane_count;
+
+    plane0_vcpu_count = 0;
+    CPU_FOREACH(cs) {
+        plane0_vcpu_count++;
+    }
+    if (!plane0_vcpu_count) {
+        error_report("vm_planes: no plane0 vCPUs available");
+        run->hypercall.ret = -EINVAL;
+        return 0;
+    }
+
+    plane0_vcpu_ids = g_new(unsigned int, plane0_vcpu_count);
+    plane0_vcpu_count = 0;
+    CPU_FOREACH(cs) {
+        plane0_vcpu_ids[plane0_vcpu_count++] = cs->cpu_index;
+    }
+
+    for (plane_id = 1; plane_id < plane_count; plane_id++) {
+        uint64_t plane_gpa = gpa + (plane_id * VM_PLANE_CFG_STRIDE);
+        uint64_t load_offset = 0, memory_size = 0, entry_point = 0;
+        uint32_t vcpu_count = plane0_vcpu_count;
+        struct kvm_vm_plane_state *ps = &s->vm_planes[plane_id];
+        char cmdline_buf[512];
+        MemoryRegionSection section;
+        int plane_fd;
+        unsigned int i;
+
+        address_space_read(&address_space_memory, plane_gpa + 0,
+                           MEMTXATTRS_UNSPECIFIED, &load_offset, 8);
+        address_space_read(&address_space_memory, plane_gpa + 8,
+                           MEMTXATTRS_UNSPECIFIED, &memory_size, 8);
+        address_space_read(&address_space_memory, plane_gpa + 16,
+                           MEMTXATTRS_UNSPECIFIED, &entry_point, 8);
+
+        /*
+         * joergroedel plane model: a plane has exactly one vCPU per
+         * plane-0 vCPU -- each is the sibling of a plane-0 vCPU sharing the
+         * same logical CPU.  The guest does not configure a count; QEMU
+         * mirrors the plane-0 vCPU set.
+         */
+        if (!memory_size) {
+            error_report("vm_planes: plane %" PRIu64 " invalid "
+                         "(load_offset=0x%" PRIx64 " size=0x%" PRIx64 ")",
+                         plane_id, load_offset, memory_size);
+            g_free(plane0_vcpu_ids);
+            run->hypercall.ret = -EINVAL;
+            return 0;
+        }
+
+        memset(cmdline_buf, 0, sizeof(cmdline_buf));
+        address_space_read(&address_space_memory, plane_gpa + 156,
+                           MEMTXATTRS_UNSPECIFIED, cmdline_buf,
+                           sizeof(cmdline_buf));
+        cmdline_buf[sizeof(cmdline_buf) - 1] = '\0';
+        memcpy(ps->cmdline, cmdline_buf, sizeof(ps->cmdline));
+
+        plane_fd = kvm_vm_ioctl(s, KVM_CREATE_PLANE, (int)plane_id);
+        if (plane_fd < 0) {
+            error_report("vm_planes: KVM_CREATE_PLANE plane %" PRIu64
+                         " failed: %s", plane_id, strerror(errno));
+            g_free(plane0_vcpu_ids);
+            run->hypercall.ret = -errno;
+            return 0;
+        }
+        /* The kvm_vm_plane_ioctl path looks up the plane fd via
+         * kvm_get_plane_fd / kvm_set_plane_fd, so register the fd. */
+        kvm_set_plane_fd(s, plane_id, plane_fd);
+
+        section = memory_region_find(get_system_memory(),
+                                     load_offset, memory_size);
+        if (!section.mr || !memory_region_is_ram(section.mr)) {
+            error_report("vm_planes: plane %" PRIu64 " GPA 0x%" PRIx64
+                         " size 0x%" PRIx64 " is not RAM",
+                         plane_id, load_offset, memory_size);
+            if (section.mr) {
+                memory_region_unref(section.mr);
+            }
+            close(plane_fd);
+            kvm_set_plane_fd(s, plane_id, -1);
+            g_free(plane0_vcpu_ids);
+            run->hypercall.ret = -ENOMEM;
+            return 0;
+        }
+        ps->host_addr = memory_region_get_ram_ptr(section.mr) +
+                        section.offset_within_region;
+        memory_region_unref(section.mr);
+
+        ps->vcpu_fds = g_new0(int, vcpu_count);
+        ps->vcpu_cpu_index = g_new0(unsigned int, vcpu_count);
+        for (i = 0; i < vcpu_count; i++) {
+            unsigned int vcpu_id = plane0_vcpu_ids[i];
+            CPUState *target = qemu_get_cpu(vcpu_id);
+            struct plane_vcpu_create_ctx cctx = {
+                .s = s,
+                .plane_id = plane_id,
+                .vcpu_id = vcpu_id,
+                .fd = -EINVAL,
+            };
+
+            if (!target) {
+                error_report("vm_planes: plane %" PRIu64 " no CPU for id=%u",
+                             plane_id, vcpu_id);
+                close(plane_fd);
+                kvm_set_plane_fd(s, plane_id, -1);
+                g_free(plane0_vcpu_ids);
+                run->hypercall.ret = -EINVAL;
+                return 0;
+            }
+
+            /* Create on the owning CPU's thread; see plane_vcpu_create_cb. */
+            bql_lock();
+            run_on_cpu(target, plane_vcpu_create_cb,
+                       RUN_ON_CPU_HOST_PTR(&cctx));
+            bql_unlock();
+
+            if (cctx.fd < 0) {
+                error_report("vm_planes: KVM_CREATE_VCPU plane %" PRIu64
+                             " vcpu %u failed: %s",
+                             plane_id, vcpu_id, strerror(-cctx.fd));
+                close(plane_fd);
+                kvm_set_plane_fd(s, plane_id, -1);
+                g_free(plane0_vcpu_ids);
+                run->hypercall.ret = cctx.fd;
+                return 0;
+            }
+
+            ps->vcpu_fds[i] = cctx.fd;
+            ps->vcpu_cpu_index[i] = vcpu_id;
+        }
+
+        ps->vcpu_count  = vcpu_count;
+        ps->load_offset = load_offset;
+        ps->memory_size = memory_size;
+        ps->entry_point = entry_point;
+
+        info_report("vm_planes: plane %" PRIu64 " ready — GPA 0x%" PRIx64
+                    " size 0x%" PRIx64 " entry 0x%" PRIx64 " vcpus %u",
+                    plane_id, load_offset, memory_size, entry_point,
+                    vcpu_count);
+    }
+
+    g_free(plane0_vcpu_ids);
+    run->hypercall.ret = 0;
+    return 0;
+}
+
+static int kvm_init_plane_vcpu(int vcpu_fd, uint64_t entry_addr,
+                               uint64_t stack_addr, uint64_t zero_page_gpa,
+                               uint64_t page_table_gpa, uint64_t gdt_gpa,
+                               bool is_bsp)
+{
+    struct kvm_regs regs = {};
+    struct kvm_sregs sregs = {};
+    int ret;
+
+    sregs.cs.base = 0; sregs.cs.limit = 0xffffffff; sregs.cs.selector = 0x10;
+    sregs.cs.type = 0xb; sregs.cs.present = 1; sregs.cs.dpl = 0;
+    sregs.cs.db = 0; sregs.cs.s = 1; sregs.cs.l = 1; sregs.cs.g = 1;
+
+    sregs.ds.base = 0; sregs.ds.limit = 0xffffffff; sregs.ds.selector = 0x18;
+    sregs.ds.type = 0x3; sregs.ds.present = 1; sregs.ds.dpl = 0;
+    sregs.ds.db = 1; sregs.ds.s = 1; sregs.ds.g = 1;
+    sregs.es = sregs.ds;
+    sregs.ss = sregs.ds;
+    sregs.fs = sregs.ds; sregs.fs.selector = 0;
+    sregs.gs = sregs.fs;
+
+    sregs.gdt.base = gdt_gpa; sregs.gdt.limit = 0x2f;
+    sregs.idt.base = 0;       sregs.idt.limit = 0xffff;
+    sregs.tr.base = 0; sregs.tr.limit = 0x67; sregs.tr.selector = 0x28;
+    sregs.tr.type = 0xb; sregs.tr.present = 1; sregs.tr.dpl = 0; sregs.tr.s = 0;
+    sregs.ldt.unusable = 1;
+
+    sregs.cr3 = page_table_gpa;
+    sregs.cr4 = (1u << 5);  /* PAE */
+    sregs.cr0 = (1u << 0) | (1u << 4) | (1u << 5) | (1u << 16) | (1u << 31);
+    sregs.efer = (1u << 0) | (1u << 8) | (1u << 10) | (1u << 11);
+    sregs.apic_base = 0xfee00000 | (1u << 11);
+    if (is_bsp) {
+        sregs.apic_base |= (1u << 8);
+    }
+
+    ret = ioctl(vcpu_fd, KVM_SET_SREGS, &sregs);
+    if (ret < 0) {
+        error_report("vm_planes: KVM_SET_SREGS: %s", strerror(errno));
+        return -errno;
+    }
+
+    regs.rip = entry_addr;
+    regs.rsp = stack_addr;
+    regs.rsi = zero_page_gpa;
+    regs.rflags = 0x2;
+    ret = ioctl(vcpu_fd, KVM_SET_REGS, &regs);
+    if (ret < 0) {
+        error_report("vm_planes: KVM_SET_REGS: %s", strerror(errno));
+        return -errno;
+    }
+
+    /*
+     * Do NOT issue KVM_SET_MP_STATE on a plane (plane_level > 0) vCPU fd:
+     * the VM-planes kernel only whitelists a subset of vCPU ioctls for
+     * plane vCPUs and KVM_SET_MP_STATE is intentionally excluded.  The
+     * kernel already establishes the correct initial MP state at create
+     * time: the plane BSP is left RUNNABLE and APs wait-for-INIT.
+     */
+    return 0;
+}
+
+/* Initialize a plane vCPU on its owning CPU's thread (see
+ * plane_vcpu_create_cb for why the shared-common vcpu_load() must not race
+ * the running sibling). */
+struct plane_vcpu_init_ctx {
+    int vcpu_fd;
+    uint64_t entry_addr;
+    uint64_t stack_addr;
+    uint64_t zero_page_gpa;
+    uint64_t page_table_gpa;
+    uint64_t gdt_gpa;
+    bool is_bsp;
+    int ret;                /* out: 0 on success, -errno on failure */
+};
+
+static void plane_vcpu_init_cb(CPUState *cs, run_on_cpu_data data)
+{
+    struct plane_vcpu_init_ctx *ctx = data.host_ptr;
+
+    ctx->ret = kvm_init_plane_vcpu(ctx->vcpu_fd, ctx->entry_addr,
+                                   ctx->stack_addr, ctx->zero_page_gpa,
+                                   ctx->page_table_gpa, ctx->gdt_gpa,
+                                   ctx->is_bsp);
+}
+
+static int kvm_handle_hc_vm_planes_activate(X86CPU *cpu, struct kvm_run *run)
+{
+    uint64_t gpa = run->hypercall.args[0];
+    uint64_t plane_count = run->hypercall.args[1];
+    uint64_t plane_id;
+    KVMState *s = kvm_state;
+
+    if (!gpa || !plane_count || !s->vm_planes ||
+        plane_count != s->vm_plane_count) {
+        run->hypercall.ret = -EINVAL;
+        return 0;
+    }
+
+    for (plane_id = 1; plane_id < plane_count; plane_id++) {
+        struct kvm_vm_plane_state *ps = &s->vm_planes[plane_id];
+        uint64_t stack_addr;
+        uint64_t entry_point = 0;
+        uint64_t cmdline_gpa, zero_page_gpa;
+        uint64_t pt_base, pml4_gpa, pdpt_gpa, pd_base, gdt_gpa_val;
+        unsigned int i;
+
+        if (kvm_get_plane_fd(s, plane_id) < 0 || !ps->vcpu_count ||
+            !ps->host_addr) {
+            error_report("vm_planes: plane %" PRIu64 " not configured",
+                         plane_id);
+            run->hypercall.ret = -EINVAL;
+            return 0;
+        }
+
+        address_space_read(&address_space_memory,
+                           gpa + (plane_id * VM_PLANE_CFG_STRIDE) + 16,
+                           MEMTXATTRS_UNSPECIFIED, &entry_point, 8);
+        if (!entry_point) {
+            error_report("vm_planes: plane %" PRIu64 " bad entry_point",
+                         plane_id);
+            run->hypercall.ret = -EIO;
+            return 0;
+        }
+        ps->entry_point = entry_point;
+
+        stack_addr     = ps->load_offset + ps->memory_size;
+        cmdline_gpa    = stack_addr - 0x1000;
+        zero_page_gpa  = stack_addr - 0x2000;
+        pt_base        = ps->load_offset + ps->memory_size - 0x10000;
+        pml4_gpa       = pt_base;
+        pdpt_gpa       = pt_base + 0x1000;
+        pd_base        = pt_base + 0x2000;
+        gdt_gpa_val    = pt_base + 0x6000;
+
+#define PLANE_HOST(g) ((uint8_t *)ps->host_addr + ((g) - ps->load_offset))
+
+        /* cmdline */
+        {
+            size_t cl = strlen(ps->cmdline) + 1;
+            memcpy(PLANE_HOST(cmdline_gpa), ps->cmdline, cl);
+        }
+
+        /* boot_params zero page */
+        {
+            uint8_t zp[4096] = {};
+            uint32_t cl_ptr = (uint32_t)(cmdline_gpa & 0xffffffff);
+            uint32_t cl_hi  = (uint32_t)(cmdline_gpa >> 32);
+            struct {
+                uint64_t addr;
+                uint64_t size;
+                uint32_t type;
+            } QEMU_PACKED e820 = {
+                ps->load_offset, ps->memory_size, 1,
+            };
+
+            zp[0x1fe] = 0x55; zp[0x1ff] = 0xAA;
+            zp[0x202] = 'H'; zp[0x203] = 'd';
+            zp[0x204] = 'r'; zp[0x205] = 'S';
+            zp[0x206] = 0x0f; zp[0x207] = 0x02;
+            zp[0x210] = 0xff;
+            memcpy(&zp[0x228], &cl_ptr, 4);
+            memcpy(&zp[0x0c8], &cl_hi, 4);
+            zp[0x1e8] = 1;
+            memcpy(&zp[0x2d0], &e820, 20);
+            memcpy(PLANE_HOST(zero_page_gpa), zp, sizeof(zp));
+        }
+
+        /* Identity-mapped page tables (PML4 → PDPT → 4×PD with 2MB pages) */
+        {
+            uint8_t page[4096];
+            uint64_t *entries;
+            int pd_idx;
+
+            memset(page, 0, sizeof(page));
+            entries = (uint64_t *)page;
+            entries[0] = pdpt_gpa | 0x3;
+            memcpy(PLANE_HOST(pml4_gpa), page, 4096);
+
+            memset(page, 0, sizeof(page));
+            entries = (uint64_t *)page;
+            for (pd_idx = 0; pd_idx < 4; pd_idx++) {
+                entries[pd_idx] = (pd_base + pd_idx * 0x1000) | 0x3;
+            }
+            memcpy(PLANE_HOST(pdpt_gpa), page, 4096);
+
+            for (pd_idx = 0; pd_idx < 4; pd_idx++) {
+                int j;
+                memset(page, 0, sizeof(page));
+                entries = (uint64_t *)page;
+                for (j = 0; j < 512; j++) {
+                    uint64_t phys = ((uint64_t)pd_idx << 30) |
+                                    ((uint64_t)j << 21);
+                    entries[j] = phys | 0x83;
+                }
+                memcpy(PLANE_HOST(pd_base + pd_idx * 0x1000), page, 4096);
+            }
+        }
+
+        /* Minimal GDT */
+        {
+            uint8_t gdt[48] = {};
+            uint64_t *gdt64 = (uint64_t *)gdt;
+
+            gdt64[0] = 0;
+            gdt64[1] = 0;
+            gdt64[2] = 0x00af9a000000ffffULL;
+            gdt64[3] = 0x00cf92000000ffffULL;
+            gdt64[4] = 0;
+            gdt64[5] = 0x0000890000000067ULL;
+            memcpy(PLANE_HOST(gdt_gpa_val), gdt, sizeof(gdt));
+        }
+
+        /* Initialize all plane vCPUs on their owning CPU threads. */
+        for (i = 0; i < ps->vcpu_count; i++) {
+            CPUState *target = qemu_get_cpu(ps->vcpu_cpu_index[i]);
+            struct plane_vcpu_init_ctx ictx = {
+                .vcpu_fd = ps->vcpu_fds[i],
+                .entry_addr = entry_point,
+                .stack_addr = stack_addr,
+                .zero_page_gpa = zero_page_gpa,
+                .page_table_gpa = pml4_gpa,
+                .gdt_gpa = gdt_gpa_val,
+                .is_bsp = (i == 0),
+                .ret = -EINVAL,
+            };
+
+            if (!target) {
+                error_report("vm_planes: plane %" PRIu64 " no CPU for vcpu %u",
+                             plane_id, i);
+                run->hypercall.ret = -EINVAL;
+                return 0;
+            }
+
+            /* See plane_vcpu_init_cb: must run on the sibling's own thread. */
+            bql_lock();
+            run_on_cpu(target, plane_vcpu_init_cb,
+                       RUN_ON_CPU_HOST_PTR(&ictx));
+            bql_unlock();
+
+            if (ictx.ret) {
+                error_report("vm_planes: init plane %" PRIu64 " vcpu %u "
+                             "failed", plane_id, i);
+                run->hypercall.ret = ictx.ret;
+                return 0;
+            }
+        }
+#undef PLANE_HOST
+
+        /*
+         * The plane vCPU is initialized (entry point, page tables) but left
+         * STOPPED.  It boots lazily and in-kernel the first time the normal
+         * plane issues a VBS/VTL call: KVM switches to the secure plane
+         * within the normal plane's KVM_RUN.  QEMU never runs it.
+         */
+        ps->host_addr = NULL;
+
+        info_report("vm_planes: plane %" PRIu64 " launched — entry 0x%" PRIx64
+                    " vcpus %u", plane_id, entry_point, ps->vcpu_count);
+    }
+
+    run->hypercall.ret = 0;
+    return 0;
+}
+
+/*
+ * VBS/VTL calls (KVM_HC_VBS_VTL_CALL / _RETURN) are serviced entirely
+ * in-kernel by switching to the secure plane, so they never exit to
+ * userspace here.  QEMU only handles plane configuration/activation.
+ */
 static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
         return kvm_handle_hc_map_gpa_range(cpu, run);
+    if (run->hypercall.nr == KVM_HC_VM_PLANES_CONFIG)
+        return kvm_handle_hc_vm_planes_config(cpu, run);
+    if (run->hypercall.nr == KVM_HC_VM_PLANES_ACTIVATE)
+        return kvm_handle_hc_vm_planes_activate(cpu, run);
 
     return -EINVAL;
 }
-- 
2.55.0

