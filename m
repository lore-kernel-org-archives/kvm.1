Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31102269D18
	for <kvm@vger.kernel.org>; Sat, 11 Jul 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783735176; cv=none; b=MZP1QTO4IfcUFrK3ly8M/WOUjU/ugMEj9yvIabaZf98qovsspX1aSyI972B7b2UZChy0RuAnN3rkO41de4n9dar/XM5QOmS98fFiLsTvdmh4QNJQzFCNijzzl8lweaD3UWzcNYAE5gcyyM3IqfShHDZD2CxGCGRnGeBY27w0tyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783735176; c=relaxed/simple;
	bh=7nj4qf3LuYIdIzKLkRClhuBjSImoX6DksVjwaqYE5kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJHex3conumET2EAyo7Ni2A91LbFZ8hjs6PurUum3Nc0IEAozDhWx5Tt1l7VApdMtXt3NIfovb5Ps3leRUtFOhQRBwISQsZA537m5yNjJbOScjhOuVukNa0bH//F7WCDA5rXIsVpFvGBAef3k32UpyySixZw604GaerOG57WZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=OzROhQ9d; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="OzROhQ9d"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80a123ef90aso25011617b3.0
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1783735172; x=1784339972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAtz+7gdOtw8EnUWorzepQXehi9D/YMfmkiiH01gHuw=;
        b=OzROhQ9dNzFR3FETsgmElUCq2sCGHyZdONLDO0+Z7VHyJr0HaBfYTqJKSWqDPkLSK5
         iFpSK1F8wO3P46re6kHQFUk2niorgxIPtiHFJ/Ht2o5WkQVLDYNlubw1ORbyIiJ5RmVS
         Wu5Vut++gbTadKquDxsJ/q3rl0EKQvRiN6nTh25qD6ycZRK/oecYK0SySa53RH6djkC6
         po6AuZ1h2sNxvRbMRlk16nagCpAin8PfBG2/IMOaNtSDx3ZqmrQlnB+WSFBHb6E5n4dE
         CX0i/IcwecGfPsswAdTxYs9gU8cbjxOjTu9ubclPa4OCWNJTOpCEpo87QuB3E867Hihc
         pZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783735172; x=1784339972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAtz+7gdOtw8EnUWorzepQXehi9D/YMfmkiiH01gHuw=;
        b=UDGqSvIrF41m60vXjRNjzEW3RokEGHq4LO796KFoUv6nLQNviKWjZ9ljGYhluyXWyo
         8uB7B+aMVoHgaTzqmck+ZKESa3Jut6kXfA4dbXIMpnttRfmfdhRCeSJ/Z6gmOTiJJ3yf
         mNakdJuTPC2c+GHbQrKo3xpGMNS17Ox61lxjsesphUgDbmOYCoOO0p61glIf/sUETGNo
         oeGqCJEh1JMOCgb13VXReDRTIf8hgkBY3HAQNZBL1UWCMpxO3su/5M9I1U2Li0QfINWK
         k1G3Z5BHM89Eted0uCuf6FYFlHQWUR5tw5+UJM61Y0Pg76WuXJJpd1MBTuQ+lEsckb1f
         wTdA==
X-Forwarded-Encrypted: i=1; AHgh+RoeaR0A+pcufFKc/cfTqZWFxfyT2S0kj4bZg/bfNFgDtQ4mGrdFGQKNrnRKh45iORhZ7QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpeFTzXdQTud/blrrGqzFXXvG+fg8DdiPrsZpeeJLFl+idtNWA
	t9XFJ0vTpONTYLkuGQhpxzSGwbrMFcMT05KYObwYarkYSqRkNwGwOymWTNmbNgMlwVk=
X-Gm-Gg: AfdE7cnZ5wHyDNZW8+LuKbJXl1gFVajj4zEuwPiVhZiTmo8zbCRH+kj+Ltp2UYHvjJn
	lDh1bhpFPFgVJBW6EOuk25rPxzGsjyehMJl3z3mjiDkQHKlkC+aZ4x0JQjienmKojnDf6q/XQW4
	bjU0MKxQmx6T35rPk8wPTZgpueDa+uWqnrPSP8zBoOeWeum9NhBucwg1ZwkQ1V+2siy2qxMX5sp
	IfgxW0AnmbPlZ5z0XG618jK8b7UW70Mij1XfZN1o3AOPkEP9G6se5LPj4T/GLY02STzwPCPIC+P
	OtBwiKVncaaNGuBaGVsJEofrTAwUKbvQ6kNB07Tu6O7WK2ugh14fsyyBl8Zq5WYKzKuVPtvGvG0
	nTv+ufraYlvIs1LQ9bAT15YEcM+FsK6d7/ho4qntYXw5J6x6/87ERQH5kTOmukIJOAJckFwjd0r
	zRRqLlSo/uco5SjoJnG65oA4nkHg6PDFeyZ9pgoM57cMQq37JxUsjTWkDw2/8oLiB3uWJNE6zgz
	COWaelIq8Cf1hKJHRYFE1sIN0QTa9rSWeZU7pys
X-Received: by 2002:a05:690c:6603:b0:81a:dc58:c299 with SMTP id 00721157ae682-81e7bc535ffmr51791277b3.23.1783735172080;
        Fri, 10 Jul 2026 18:59:32 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net (108-196-157-19.lightspeed.austtx.sbcglobal.net. [108.196.157.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6befb688sm61316497b3.14.2026.07.10.18.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 18:59:31 -0700 (PDT)
From: Andy Chiu <tchiu@tenstorrent.com>
To: anup@brainfault.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Chiu <andybnac@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Andy Chiu <tchiu@tenstorrent.com>,
	dfustini@oss.tenstorrent.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sean Chang <seanwascoding@gmail.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 2/2] RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector
Date: Fri, 10 Jul 2026 20:58:30 -0500
Message-ID: <20260711015835.767259-3-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260711015835.767259-1-tchiu@tenstorrent.com>
References: <20260711015835.767259-1-tchiu@tenstorrent.com>
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
 arch/riscv/include/asm/kvm_vcpu_vector.h | 24 ++++++++++++
 arch/riscv/include/asm/processor.h       |  1 +
 arch/riscv/kernel/kernel_mode_vector.c   | 48 +++++++++++++++++++-----
 arch/riscv/kvm/main.c                    |  4 ++
 arch/riscv/kvm/vcpu.c                    |  6 +++
 arch/riscv/kvm/vcpu_vector.c             | 18 +++++++++
 6 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 57a798a4cb0d..e36f46de7429 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -35,6 +35,22 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx);
 void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx);
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu);
+void kvm_riscv_register_vctx_callback(bool (*func)(void));
+void kvm_riscv_unregister_vctx_callback(void);
+bool kvm_riscv_vcpu_flush_vector(void);
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
index 812517b2cec1..e1b1948f4a4c 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -97,6 +97,7 @@ struct pt_regs;
 
 #define RISCV_V_CTX_UNIT_DEPTH		0x00010000
 #define RISCV_KERNEL_MODE_V		0x00000001
+#define RISCV_V_VCPU_NEED_RESTORE	0x00000002
 #define RISCV_PREEMPT_V			0x00000100
 #define RISCV_PREEMPT_V_DIRTY		0x80000000
 #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 307ac369c3d4..a83d5c26d3b2 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -12,12 +12,31 @@
 #include <linux/types.h>
 
 #include <asm/vector.h>
+#include <asm/kvm_vcpu_vector.h>
 #include <asm/switch_to.h>
 #include <asm/simd.h>
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 #include <asm/asm-prototypes.h>
 #endif
 
+static bool (* __rcu kvm_flush_vector_ctx_callback)(void);
+
+void kvm_riscv_register_vctx_callback(bool (*func)(void))
+{
+	if (WARN_ON_ONCE(rcu_access_pointer(kvm_flush_vector_ctx_callback)))
+		return;
+
+	rcu_assign_pointer(kvm_flush_vector_ctx_callback, func);
+}
+EXPORT_SYMBOL_GPL(kvm_riscv_register_vctx_callback);
+
+void kvm_riscv_unregister_vctx_callback(void)
+{
+	rcu_assign_pointer(kvm_flush_vector_ctx_callback, NULL);
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(kvm_riscv_unregister_vctx_callback);
+
 static inline void riscv_v_flags_set(u32 flags)
 {
 	WRITE_ONCE(current->thread.riscv_v_flags, flags);
@@ -80,6 +99,19 @@ void put_cpu_vector_context(void)
 		preempt_enable();
 }
 
+static void __riscv_flush_vector_context(void)
+{
+	bool (*vcpu_flush_v_callback)(void);
+
+	/* rcu_deference is protected by get/put_cpu_vector_context() */
+	vcpu_flush_v_callback = rcu_dereference(kvm_flush_vector_ctx_callback);
+	if (vcpu_flush_v_callback && vcpu_flush_v_callback())
+		return;
+
+	riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
+	riscv_v_vstate_set_restore(current, task_pt_regs(current));
+}
+
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 static __always_inline u32 *riscv_v_flags_ptr(void)
 {
@@ -123,7 +155,7 @@ static int riscv_v_stop_kernel_context(void)
 
 static int riscv_v_start_kernel_context(void)
 {
-	struct __riscv_v_ext_state *kvstate, *uvstate;
+	struct __riscv_v_ext_state *kvstate;
 
 	kvstate = &current->thread.kernel_vstate;
 	if (!kvstate->datap)
@@ -141,13 +173,10 @@ static int riscv_v_start_kernel_context(void)
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
+	put_cpu_vector_context();
+	riscv_v_start(RISCV_PREEMPT_V);
 	return 0;
 }
 
@@ -213,8 +242,7 @@ void kernel_vector_begin(void)
 
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
index cf6e231e76e2..60288bf6e9be 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -765,6 +765,12 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	kvm_riscv_vcpu_swap_in_guest_state(vcpu);
 	guest_state_enter_irqoff();
 
+	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
+		current->thread.riscv_v_flags &= ~RISCV_V_VCPU_NEED_RESTORE;
+		__kvm_riscv_vector_restore(gcntx);
+		gcntx->sstatus = (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
+	}
+
 	if (kvm_riscv_nacl_sync_sret_available()) {
 		nsh = nacl_shmem();
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 62d2fb77bb9b..3b94e6e7fec8 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -95,6 +95,24 @@ void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
 	kfree(vcpu->arch.guest_context.vector.datap);
 	kfree(vcpu->arch.host_context.vector.datap);
 }
+
+bool kvm_riscv_vcpu_flush_vector(void)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = *this_cpu_ptr(kvm_get_running_vcpus());
+	if (vcpu && riscv_isa_extension_available(vcpu->arch.isa, v)) {
+		kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
+						 vcpu->arch.isa);
+
+		if (vcpu->arch.guest_context.sstatus != SR_VS_OFF)
+			current->thread.riscv_v_flags |= RISCV_V_VCPU_NEED_RESTORE;
+
+		return true;
+	}
+	return false;
+}
+
 #endif
 
 static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *vcpu,
-- 
2.43.0

