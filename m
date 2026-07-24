Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51F448CF4
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911827; cv=none; b=ExhhSqHze66iwdSIiPxpdAnY7vTzN7oLGHyiRBR0qM2ZOdTBClEBXcrC6PfcLV5x7EbM5YwWcu2xQh+E5VNPesB+jbTqy8HajuRs+e2CjXJAY0vfc59Bgcqw8Qe5dbYcH2NNo3EW5OKk8Kkcvw3qU6PT8Mz7wXcWita47eJYwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911827; c=relaxed/simple;
	bh=XIeBDuruzRdyW1CeGqh1ovv75r6lrWVviZnVXkHMv9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr8VSfRYjyz99OVuhlvK1LivPuZXP2TzEIs4dxeeTBdnJ6J+1fgcpwUMUJqM2KxMVG2hrEEIK/jmC6lQgGIrtpm2YW4uD8r3nhn9SVdiGKf7nIlBUGAff+UP4BoXZFggbAwAZR8zG6R9sTytrq/Hc88slQtIKM3cOjMW86+IV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=a2BKumpE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="a2BKumpE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7ee4f241f42so935610a34.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784911823; x=1785516623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKuUmlHudjWBXOh7u6EacXcROP7GrHIzAv/I/DwJ+pI=;
        b=a2BKumpEudbHBnBghDjMa6htnkAKiCo+l7vyk/1gx5JQ3cKKVyaGcqt0DUM9HgJsla
         Q+fMAyT6kRZSv1lXquh0BKmptCnMqDWEMNqPMbabnMULVOydloe787uZz1iFdSKq+Vxo
         L7lSwBaTkNLPRP9P3YXtZyhzEnPGSGTDkj7CDVb7cv99Zc/ozaxK6CS07kSWdvsYSbwc
         Nr3+YqrAUV0r5JoB4Esrxc1GV8Cv7Lx/H/3J2AKhnW1+H/RS28PERtSXa+r2N7SeGUck
         FQLLlH692angz5YiAIZH7X3ZN6WoDRwDzLbBMqto8VBK2KiMAa6WJV9AV0bsy0HnGCtu
         u7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911823; x=1785516623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKuUmlHudjWBXOh7u6EacXcROP7GrHIzAv/I/DwJ+pI=;
        b=bn2bJoPGGAHOzW4SAgj/rOnnYXX5m+CLqySXcTUpxRFI6mb8fZ/aYDNPZoKm4Zs2Je
         Qse6r9S40eUzBSnpG0/bL7TzD03ksBsCgoQ1w0CRG12ZfKTS4enPMBrTAv37i8B8EqGt
         V6h22Cv6ocyZK8LKedS1ePHQBM9dzQVuahNG0t+3JorvEx1PA6Qo30hjYHL94SJFJTJV
         3j/cfbrKBvtS2efpdOJAM4of8XuM1PSyUV9FAOuPfjQSeulVk/ThlGFjbyFhi+p1bZgM
         NJ1Pf7sOOAHxQFGNXpVaGZ9Ru0a8im1PobmuJJjgalhGXaKSvRFNvbcuwxct17B72zkB
         wUHg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+C6w46itke6VtNzFBT3VRgZXzM5wS4etUpgbwm+US+DvZxgSekdIFgGMoIiaCZOaiMbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrGW2cMFl7vkww4oM/zWCVewQo8byp3Hhvr8n3u+vYNHLpvU9
	4rJvbWNbXgs8SmoiP6irSe24todF6UwS/yDKVUO92+J7L7sOHE1hi0s1yx2fo3/QAGo=
X-Gm-Gg: AR+sD13WWZRV6wukjKogsGunWcKFbVvIec8fdoIDamPKockuZG9LkUUqLClfrjFujQG
	8jcloJaZgUV2HEuIvpP1GwQVBVPLALA1w6bCJmF45MuCW6iNTZ8pOmjZJQ5TccFgqBmhvOSq4HX
	mBKIrOmWtA9Z6P6NXk3aNq7g08G2c97cOep/KMmF2YOHWtLH/WhbUNqZ9riczgBkVivVwBYGjAT
	oGAv3eJ1zxndIqPdlNhQ7mxhjhWwZBMNhEci+bHBKryoXJZyntqH20ZfFBEcNlPZ/EE52T+m0JO
	HqH5hPNGwu4+n81B2CJBAU33tJ8KAybh9+hkxmKUsWUzNwoMCG6nLAMavlLjEuG9QYEAWlSLcGs
	/P0PWNZosFHO9QVJJ0P5OF0m9ElzJ5511cfVkBTcOk4mobnn6aI1G6HqKcNmYrc6QVlvncb2hwj
	8aJNjnu0dTNOUX0keXP2YZOhbSmm3O5xBVRMs=
X-Received: by 2002:a05:6820:2910:b0:6aa:eff0:7091 with SMTP id 006d021491bc7-6aaf583e356mr1052622eaf.20.1784911823141;
        Fri, 24 Jul 2026 09:50:23 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf96f4501sm210882eaf.12.2026.07.24.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:50:22 -0700 (PDT)
From: Andy Chiu <tchiu@tenstorrent.com>
To: anup@brainfault.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vincent Chen <vincent.chen@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Andy Chiu <andybnac@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Andy Chiu <tchiu@tenstorrent.com>,
	dfustini@oss.tenstorrent.com,
	Zong Li <zong.li@sifive.com>,
	Sean Chang <seanwascoding@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v3 3/3] RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector
Date: Fri, 24 Jul 2026 11:49:54 -0500
Message-ID: <20260724165001.2317788-4-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724165001.2317788-1-tchiu@tenstorrent.com>
References: <20260724165001.2317788-1-tchiu@tenstorrent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running vector workloads like perf + mcf on KVM can result in an
unexpected termination due to a vtype corruption. This happens because
the kernel-mode vector (KMV) misattributes the guest's vcpu context as
the user's context and source from a wrong status.VS.

The simplified call chain that results in this problem is shown as
follow:

__riscv_sys_ioctl()
    kvm_arch_vcpu_ioctl_run()
      kvm_riscv_vcpu_exit()
        kvm_riscv_vcpu_sbi_ecall()
          kvm_riscv_vcpu_pmu_ctr_stop()
            kvm_vcpu_write_guest()
              __copy_to_user()
                enter_vector_usercopy()
                  kernel_vector_begin()

kernel_vector_begin() should use the sstatus.VS from guest's vcpu
context instead of task_pt_reg(current). Also, it should not save
guest's v-reg into the user's context memory.

To resolve this, the vcpu context must be correctly saved when KMV is
serving a guest. However, invoking KVM functions directly from generic
RISC-V architecture code introduces a reverse dependency, breaking
builds when KVM is configured as N or M.

Address this by registering an RCU-protected callback for context
flushing. KVM registers this callback at module initialization and
unregisters it on exit. When KMV starts a kernel context, it can now
safely flush the vector context via the callback.

Fixes: ecd2ada8a5e0 ("riscv: Add support for kernel mode vector")
Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>

---
Changelog v3:
 - clears RISCV_V_VCPU_NEED_RESTORE flag in host restore to prevent
   leaking (Sashiko)
 - consolidates guest vector restore at returning to guest to prevent
   unnecessary save/restore between the preemptible window from
   vcpu_load to vcpu_enter_exit
 - Document the added riscv_v_flags
Changelog v2: address concerns pointed out by sashiko
 - encloses vcpu_flush_v_callback() with rcu_read_{lock,unlock}
 - put riscv_v_start before put_cpu_vector_context() to prevent
   redundant context save
 - protect v context operations against softirqs
 - apply bitmask when reading SR_VS out of guest's sstatus
---
 arch/riscv/include/asm/kvm_vcpu_vector.h | 24 +++++++++++
 arch/riscv/include/asm/processor.h       |  8 ++++
 arch/riscv/include/asm/vector.h          |  5 +++
 arch/riscv/kernel/kernel_mode_vector.c   | 51 ++++++++++++++++++------
 arch/riscv/kvm/main.c                    |  4 ++
 arch/riscv/kvm/vcpu.c                    | 12 ++++++
 arch/riscv/kvm/vcpu_vector.c             | 22 +++++++++-
 7 files changed, 112 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 57a798a4cb0d..6371d5ea5392 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -35,6 +35,22 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx);
 void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx);
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu);
+void kvm_riscv_register_vctx_callback(void (*func)(void));
+void kvm_riscv_unregister_vctx_callback(void);
+void kvm_riscv_vcpu_flush_vector(void);
+
+static inline void kvm_riscv_v_init(void)
+{
+	if (has_vector())
+		kvm_riscv_register_vctx_callback(&kvm_riscv_vcpu_flush_vector);
+}
+
+static inline void kvm_riscv_v_exit(void)
+{
+	if (has_vector())
+		kvm_riscv_unregister_vctx_callback();
+}
+
 #else
 
 struct kvm_cpu_context;
@@ -69,6 +85,14 @@ static inline int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 static inline void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
 {
 }
+
+static inline void kvm_riscv_v_init(void)
+{
+}
+
+static inline void kvm_riscv_v_exit(void)
+{
+}
 #endif
 
 int kvm_riscv_vcpu_get_reg_vector(struct kvm_vcpu *vcpu,
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 812517b2cec1..a6a0c3d5a913 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -67,6 +67,12 @@ struct pt_regs;
  *  - bit 0: indicates whether the in-kernel Vector context is active. The
  *    activation of this state disables the preemption. On a non-RT kernel, it
  *    also disable bh.
+ *  - bit 1: tells kvm that the vcpu process has guest context saved in vcpu's
+ *    context memory and need to be restore upon returing back to the guest.
+ *  - bit 2: represents that the vector context has now loaded and belongs to
+ *    the guest kernel. Any non-scheduler context saving routing needs to save
+ *    the register file to vcpu's context memory. The bit is set upon returing
+ *    back to the guest and cleared after loading the host's vector context.
  *  - bits 8: is used for tracking preemptible kernel-mode Vector, when
  *    RISCV_ISA_V_PREEMPTIVE is enabled. Calling kernel_vector_begin() does not
  *    disable the preemption if the thread's kernel_vstate.datap is allocated.
@@ -97,6 +103,8 @@ struct pt_regs;
 
 #define RISCV_V_CTX_UNIT_DEPTH		0x00010000
 #define RISCV_KERNEL_MODE_V		0x00000001
+#define RISCV_V_VCPU_NEED_RESTORE	0x00000002
+#define RISCV_V_VCPU_CTX		0x00000004
 #define RISCV_PREEMPT_V			0x00000100
 #define RISCV_PREEMPT_V_DIRTY		0x80000000
 #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 00cb9c0982b1..fffe72a77208 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -58,6 +58,11 @@ static inline u32 riscv_v_flags(void)
 	return READ_ONCE(current->thread.riscv_v_flags);
 }
 
+static inline void riscv_v_flags_set(u32 flags)
+{
+	WRITE_ONCE(current->thread.riscv_v_flags, flags);
+}
+
 static __always_inline bool has_vector(void)
 {
 	return riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE32X);
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index f76e52de1117..be0f6c7f78da 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -12,16 +12,31 @@
 #include <linux/types.h>
 
 #include <asm/vector.h>
+#include <asm/kvm_vcpu_vector.h>
 #include <asm/switch_to.h>
 #include <asm/simd.h>
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 #include <asm/asm-prototypes.h>
 #endif
 
-static inline void riscv_v_flags_set(u32 flags)
+static void (* __rcu kvm_flush_vector_ctx_callback)(void);
+
+void kvm_riscv_register_vctx_callback(void (*func)(void))
 {
-	WRITE_ONCE(current->thread.riscv_v_flags, flags);
+	if (WARN_ON_ONCE(rcu_access_pointer(kvm_flush_vector_ctx_callback)))
+		return;
+
+	rcu_assign_pointer(kvm_flush_vector_ctx_callback, func);
 }
+EXPORT_SYMBOL_GPL(kvm_riscv_register_vctx_callback);
+
+void kvm_riscv_unregister_vctx_callback(void)
+{
+	rcu_assign_pointer(kvm_flush_vector_ctx_callback, NULL);
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(kvm_riscv_unregister_vctx_callback);
+
 
 static inline void riscv_v_start(u32 flags)
 {
@@ -86,6 +101,22 @@ void put_cpu_vector_context(void)
 }
 EXPORT_SYMBOL_FOR_KVM(put_cpu_vector_context);
 
+static void __riscv_flush_vector_context(void)
+{
+	void (*vcpu_flush_v_callback)(void);
+
+	if (riscv_v_flags() & RISCV_V_VCPU_CTX) {
+		rcu_read_lock();
+		vcpu_flush_v_callback = rcu_dereference(kvm_flush_vector_ctx_callback);
+		vcpu_flush_v_callback();
+		rcu_read_unlock();
+		return;
+	}
+
+	riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
+	riscv_v_vstate_set_restore(current, task_pt_regs(current));
+}
+
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 static __always_inline u32 *riscv_v_flags_ptr(void)
 {
@@ -129,7 +160,7 @@ static int riscv_v_stop_kernel_context(void)
 
 static int riscv_v_start_kernel_context(void)
 {
-	struct __riscv_v_ext_state *kvstate, *uvstate;
+	struct __riscv_v_ext_state *kvstate;
 
 	kvstate = &current->thread.kernel_vstate;
 	if (!kvstate->datap)
@@ -147,13 +178,10 @@ static int riscv_v_start_kernel_context(void)
 	}
 
 	/* Transfer the ownership of V from user to kernel, then save */
-	riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
-	if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {
-		uvstate = &current->thread.vstate;
-		__riscv_v_vstate_save(uvstate, uvstate->datap);
-	}
-	riscv_preempt_v_clear_dirty(current);
-	riscv_v_vstate_set_restore(current, task_pt_regs(current));
+	get_cpu_vector_context();
+	__riscv_flush_vector_context();
+	riscv_v_start(RISCV_PREEMPT_V);
+	put_cpu_vector_context();
 	return 0;
 }
 
@@ -219,8 +247,7 @@ void kernel_vector_begin(void)
 
 	if (riscv_v_start_kernel_context()) {
 		get_cpu_vector_context();
-		riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
-		riscv_v_vstate_set_restore(current, task_pt_regs(current));
+		__riscv_flush_vector_context();
 	}
 
 	riscv_v_enable();
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 0924c75100a2..da8a5f6d4b4d 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -14,6 +14,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
 #include <asm/sbi.h>
+#include <asm/kvm_vcpu_vector.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
 
@@ -76,6 +77,7 @@ static void kvm_riscv_teardown(void)
 {
 	kvm_riscv_aia_exit();
 	kvm_riscv_nacl_exit();
+	kvm_riscv_v_exit();
 	kvm_unregister_perf_callbacks();
 }
 
@@ -170,6 +172,8 @@ static int __init riscv_kvm_init(void)
 
 	kvm_riscv_setup_vendor_features();
 
+	kvm_riscv_v_init();
+
 	kvm_register_perf_callbacks();
 
 	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index cf6e231e76e2..e2651808e1d3 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -603,9 +603,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_riscv_vcpu_host_fp_save(&vcpu->arch.host_context);
 	kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
 					vcpu->arch.isa);
+	get_cpu_vector_context();
 	kvm_riscv_vcpu_host_vector_save(&vcpu->arch.host_context);
 	kvm_riscv_vcpu_guest_vector_restore(&vcpu->arch.guest_context,
 					    vcpu->arch.isa);
+	put_cpu_vector_context();
 
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 
@@ -626,9 +628,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
 
 	kvm_riscv_vcpu_timer_save(vcpu);
+	get_cpu_vector_context();
 	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
 					 vcpu->arch.isa);
 	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);
+	put_cpu_vector_context();
 
 	if (kvm_riscv_nacl_available()) {
 		nsh = nacl_shmem();
@@ -765,6 +769,14 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	kvm_riscv_vcpu_swap_in_guest_state(vcpu);
 	guest_state_enter_irqoff();
 
+	/* sstatus.VS != SR_VS_OFF is guaranteed when NEED_RESTORE is set */
+	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
+		current->thread.riscv_v_flags &= ~RISCV_V_VCPU_NEED_RESTORE;
+		current->thread.riscv_v_flags |= RISCV_V_VCPU_CTX;
+		__kvm_riscv_vector_restore(gcntx);
+		gcntx->sstatus = (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
+	}
+
 	if (kvm_riscv_nacl_sync_sret_available()) {
 		nsh = nacl_shmem();
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 62d2fb77bb9b..ef2eee6ec308 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -56,8 +56,7 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
 {
 	if ((cntx->sstatus & SR_VS) != SR_VS_OFF) {
 		if (riscv_isa_extension_available(isa, v))
-			__kvm_riscv_vector_restore(cntx);
-		kvm_riscv_vcpu_vector_clean(cntx);
+			riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RESTORE);
 	}
 }
 
@@ -72,6 +71,7 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
 {
 	if (!kvm_riscv_isa_check_host(V))
 		__kvm_riscv_vector_restore(cntx);
+	riscv_v_flags_set(riscv_v_flags() & ~(RISCV_V_VCPU_CTX | RISCV_V_VCPU_NEED_RESTORE));
 }
 
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
@@ -95,6 +95,24 @@ void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
 	kfree(vcpu->arch.guest_context.vector.datap);
 	kfree(vcpu->arch.host_context.vector.datap);
 }
+
+void kvm_riscv_vcpu_flush_vector(void)
+{
+	struct kvm_vcpu *vcpu = *this_cpu_ptr(kvm_get_running_vcpus());
+
+	/*
+	 * Only reached from __riscv_flush_vector_context() when RISCV_V_VCPU_CTX is set, which
+	 * always have kvm_get_running_vcpus non-NULL.
+	 */
+	if (WARN_ON_ONCE(!vcpu))
+		return;
+
+	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context, vcpu->arch.isa);
+
+	if ((vcpu->arch.guest_context.sstatus & SR_VS) != SR_VS_OFF)
+		riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RESTORE);
+}
+
 #endif
 
 static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *vcpu,
-- 
2.43.0

