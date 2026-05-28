Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB1342530
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995470; cv=none; b=NkOCQpQJuNUmI1zsRQKGxiN9+oQaROuSrSBrfJy0jCg5qtXOAzkPtpSao65WP7fUwK4IavEhw+QGlVC9vb3R6VQQldX09ByMT8zUduvTOlIW9rRx0mg73mtj4S/2MonVZzkEGkkinDZd8FfCFRJufSQk9KSxtLrAQ+pvOoytXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995470; c=relaxed/simple;
	bh=vPyZ643zKQiz0piuEBXqRqzraKn79YnKz+0B65W7KKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0R0dRpR+eJreEaDjHFKGg/54wGOuJDR/i6RwLZNZBQQM9hgKVrxR5VmudlbQqhceAwYlFJTT1+RJ0xF+NX5IKEC7oxXRfUjZylxUVHudamTNJVTg9W/o5vrfm5G75ky1Z4u3dDUCeTrNYhSFyVYlD61X3JwoRaXDREKlKNiUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ck5JifuI; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ck5JifuI"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e36bb16a92so6732680a34.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1779995468; x=1780600268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So1Dot4XH9WMIAQdwvqn+C0MDAzA9ANdxsQAk9WKwiw=;
        b=ck5JifuImrZYroe3bPyPR0aKMxo0VG3Yl9IL3R0wM2LhGLnHOPol27QGF0n2DOz3pw
         ZPtKiW5eRiFGb8WUoW52i09/SaCdcHW+C1eXOsZ1pevF9a2ytC4ZdqodKkOHTh0VYouW
         kz49MvC3h3v4m2ndg6jHrpPylCpvUwQO+ZGtVzMvGsfQoDjnBccndm8Wo9DaZBdB9yEc
         1GhaAYK3WIg4tiASgiTEwqtCTq0uZ/Abne7ueQD5EsxDzNk8BMunf57Zm+uAxZwMfXJn
         U2UM8xqTEINJl8QjHOhsDVYUcKD0BbvYTdazIbVpxfVMpCQQccRmD0jihOPTutPxU093
         77dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779995468; x=1780600268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=So1Dot4XH9WMIAQdwvqn+C0MDAzA9ANdxsQAk9WKwiw=;
        b=qdPOY0ymLdg4Fs8twhXyhY1XwpJGyG+in8dlyHIMN5KBz8+ntb6IR7Zsns2omnnSgK
         0oeqwIsuUnNicJApc1WWV4B/ZCc7delITa0cdRvKOmomdabZgkb6WRRSrdL+iIlO1ojZ
         rtufVJjHJb3TyLH6vXvJ/E41zkrRJTZLqRPNM12l4azSCTHhlupuL5xqY7eForhYoswl
         jntrCKqkWTEMG7XQnto3BY+52T5ysmQmmsG1ygwuz8CSxL7/8bwJHoXPjdHl5UV+Al0a
         ICk7dume29sPvojlKWmpiShhGyuLkgdbmRuVNn3e8uq62GkylFwPaqMUxtGPOnfJ+pfb
         jThQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JwPgAmLstD4M6QvM/Ji6580gGiq1TEnP3kmDOS9n1KJcX/Axg+7inkpMpnm3cQ4PMlwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQEa+b2cgyWOoVxnO5Z3LQcAJIS2c8SJbsJ3XPeILCGvdgxCH
	TbqlUBitHRjRfGF1iaSjyrFBMEoNlRcpQ7Xm6DhH3rTmMnME7iD4nH42bHJXs8+unlU=
X-Gm-Gg: Acq92OERmRYhCe+/L0JmdMtKEvA9iC/gjxZogj/Q/l0n/BctCf9G/noop5EeCQ5ddBw
	qHrgmv6IKbQe1KZxG07n2FyrIDgaxrO6Q16p3N0CTs4KTERScFxxrLpYe0XlRagw/m1dY9qHBQP
	LT9r6j4NEgsnwZj4xU2lEghPNrIcKcvjFZhrMIerUZ0CT7xDPh0swnRWnvgeLcZ6thZqjEwl5Kj
	JQEqtHmlHuUyn3vPhrjQuBWwKRAcM+xL2+i4s6PNL0hxkdQjxirloDSSPVVJFv4V3dlj1PkNNFn
	/i0qD8jjGUSN4MavzvAxSGGQHTmk85CCWyPStyHgLRPINlUYU0skGeXUdiDYfgQ7GuyGkhHtFCl
	qsOCCokuWGzaWsq5zuN7do81Pcx5BbvWnXguibrw21ohXtsXkGrK8peX0EbPhvmjmrYrmRSwI1p
	rWztXX+btur661UGqfr7+QqSUUzAhk4monpCBBke79Il6Nu4EH8IO/cqPfOVJCdRrt86w=
X-Received: by 2002:a05:6830:3698:b0:7dc:e37b:b5d3 with SMTP id 46e09a7af769-7e694499e54mr8407a34.7.1779995467759;
        Thu, 28 May 2026 12:11:07 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606482b65sm14849267a34.10.2026.05.28.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:11:07 -0700 (PDT)
From: Andy Chiu <tchiu@tenstorrent.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Andy Chiu <tchiu@tenstorrent.com>,
	dfustini@oss.tenstorrent.com,
	greentime.hu@sifive.com,
	daichengrong <daichengrong@iscas.ac.cn>,
	Han Gao <rabenda.cn@gmail.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [[PATCH] v4 1/4] riscv: vector: refactor vector context operations
Date: Thu, 28 May 2026 14:09:12 -0500
Message-ID: <20260528190927.886558-2-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528190927.886558-1-tchiu@tenstorrent.com>
References: <ag_N8H3e3YzjRb8j@chonkvm.lixom.net>
 <20260528190927.886558-1-tchiu@tenstorrent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lift riscv_v_{enable,disable} out of __*vstate_{save,restore,discard} so
that we can reuse some functions without repeatedly turning on/off
vector.

Also, refactor and document about the user context save in preempt_v to
make code more readable.

Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>
---
Changelog v4:
 - fix an unused variable warning (Olof)
Changelog v3:
 - new patch since v3
---
 arch/riscv/include/asm/kvm_vcpu_vector.h |  8 +++++--
 arch/riscv/include/asm/vector.h          | 15 ++++++------
 arch/riscv/kernel/kernel_mode_vector.c   | 29 +++++++++++++++++++-----
 arch/riscv/kvm/vcpu_vector.c             |  8 +++----
 4 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 57a798a4cb0d..e679869e2ba3 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -16,14 +16,18 @@
 #include <asm/vector.h>
 #include <asm/kvm_host.h>
 
-static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_context *context)
+static __always_inline void kvm_riscv_vector_save(struct kvm_cpu_context *context)
 {
+	riscv_v_enable();
 	__riscv_v_vstate_save(&context->vector, context->vector.datap);
+	riscv_v_disable();
 }
 
-static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *context)
+static __always_inline void kvm_riscv_vector_restore(struct kvm_cpu_context *context)
 {
+	riscv_v_enable();
 	__riscv_v_vstate_restore(&context->vector, context->vector.datap);
+	riscv_v_disable();
 }
 
 void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 00cb9c0982b1..45820cd900d6 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -198,7 +198,6 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
 {
 	unsigned long vl;
 
-	riscv_v_enable();
 	__vstate_csr_save(save_to);
 	if (has_xtheadvector()) {
 		asm volatile (
@@ -227,7 +226,6 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
 			".option pop\n\t"
 			: "=&r" (vl) : "r" (datap) : "memory");
 	}
-	riscv_v_disable();
 }
 
 static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_from,
@@ -235,7 +233,6 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
 {
 	unsigned long vl;
 
-	riscv_v_enable();
 	if (has_xtheadvector()) {
 		asm volatile (
 			"mv t0, %0\n\t"
@@ -264,14 +261,12 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
 			: "=&r" (vl) : "r" (datap) : "memory");
 	}
 	__vstate_csr_restore(restore_from);
-	riscv_v_disable();
 }
 
 static inline void __riscv_v_vstate_discard(void)
 {
 	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
 
-	riscv_v_enable();
 	if (has_xtheadvector())
 		asm volatile (THEAD_VSETVLI_T4X0E8M8D1 : : : "t4");
 	else
@@ -291,14 +286,14 @@ static inline void __riscv_v_vstate_discard(void)
 		"vsetvl		%0, x0, %1\n\t"
 		".option pop\n\t"
 		: "=&r" (vl) : "r" (vtype_inval));
-
-	riscv_v_disable();
 }
 
 static inline void riscv_v_vstate_discard(struct pt_regs *regs)
 {
 	if (riscv_v_vstate_query(regs)) {
+		riscv_v_enable();
 		__riscv_v_vstate_discard();
+		riscv_v_disable();
 		__riscv_v_vstate_dirty(regs);
 	}
 }
@@ -307,7 +302,9 @@ static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
 				       struct pt_regs *regs)
 {
 	if (__riscv_v_vstate_check(regs->status, DIRTY)) {
+		riscv_v_enable();
 		__riscv_v_vstate_save(vstate, vstate->datap);
+		riscv_v_disable();
 		__riscv_v_vstate_clean(regs);
 	}
 }
@@ -316,7 +313,9 @@ static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 					  struct pt_regs *regs)
 {
 	if (riscv_v_vstate_query(regs)) {
+		riscv_v_enable();
 		__riscv_v_vstate_restore(vstate, vstate->datap);
+		riscv_v_disable();
 		__riscv_v_vstate_clean(regs);
 	}
 }
@@ -378,8 +377,10 @@ static inline void __switch_to_vector(struct task_struct *prev,
 			prev->thread.riscv_v_flags |= RISCV_PREEMPT_V_IN_SCHEDULE;
 		}
 		if (riscv_preempt_v_dirty(prev)) {
+			riscv_v_enable();
 			__riscv_v_vstate_save(&prev->thread.kernel_vstate,
 					      prev->thread.kernel_vstate.datap);
+			riscv_v_disable();
 			riscv_preempt_v_clear_dirty(prev);
 		}
 	} else {
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 99972a48e86b..21127b33fea8 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -123,7 +123,7 @@ static int riscv_v_stop_kernel_context(void)
 
 static int riscv_v_start_kernel_context(bool *is_nested)
 {
-	struct __riscv_v_ext_state *kvstate, *uvstate;
+	struct __riscv_v_ext_state *kvstate;
 
 	kvstate = &current->thread.kernel_vstate;
 	if (!kvstate->datap)
@@ -134,20 +134,35 @@ static int riscv_v_start_kernel_context(bool *is_nested)
 		*is_nested = true;
 		get_cpu_vector_context();
 		if (riscv_preempt_v_dirty(current)) {
+			riscv_v_enable();
 			__riscv_v_vstate_save(kvstate, kvstate->datap);
+			riscv_v_disable();
 			riscv_preempt_v_clear_dirty(current);
 		}
 		riscv_preempt_v_set_restore(current);
 		return 0;
 	}
 
-	/* Transfer the ownership of V from user to kernel, then save */
-	riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
+	/*
+	 * Skip saving user's context if it is not DIRTY. We would have to start KMV in "dirty" if
+	 * this check is performed after KMV starts, to protect user's ctx. Then, we could waste
+	 * time saving already "clean" context once KMV is started in "dirty".
+	 */
 	if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {
-		uvstate = &current->thread.vstate;
-		__riscv_v_vstate_save(uvstate, uvstate->datap);
+		/* Transfer the ownership of V from user to kernel, then save */
+		riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
+		/*
+		 * Calling the guarded version of vstate_save to make the code cleaner. Also, the
+		 * vstate check within the call is necessary as context switch may happen between
+		 * __riscv_v_vstate_check and riscv_v_start. In such case we are not supposed to
+		 * save the context again.
+		 */
+		riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
+		riscv_preempt_v_clear_dirty(current);
+		return 0;
 	}
-	riscv_preempt_v_clear_dirty(current);
+
+	riscv_v_start(RISCV_PREEMPT_V);
 	return 0;
 }
 
@@ -180,7 +195,9 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs)
 	depth = riscv_v_ctx_get_depth();
 	if (depth == 0) {
 		if (riscv_preempt_v_restore(current)) {
+			riscv_v_enable();
 			__riscv_v_vstate_restore(vstate, vstate->datap);
+			riscv_v_disable();
 			__riscv_v_vstate_clean(regs);
 			riscv_preempt_v_reset_flags();
 		}
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 62d2fb77bb9b..da6c6db846c1 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -46,7 +46,7 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
 {
 	if ((cntx->sstatus & SR_VS) == SR_VS_DIRTY) {
 		if (riscv_isa_extension_available(isa, v))
-			__kvm_riscv_vector_save(cntx);
+			kvm_riscv_vector_save(cntx);
 		kvm_riscv_vcpu_vector_clean(cntx);
 	}
 }
@@ -56,7 +56,7 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
 {
 	if ((cntx->sstatus & SR_VS) != SR_VS_OFF) {
 		if (riscv_isa_extension_available(isa, v))
-			__kvm_riscv_vector_restore(cntx);
+			kvm_riscv_vector_restore(cntx);
 		kvm_riscv_vcpu_vector_clean(cntx);
 	}
 }
@@ -65,13 +65,13 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
 {
 	/* No need to check host sstatus as it can be modified outside */
 	if (!kvm_riscv_isa_check_host(V))
-		__kvm_riscv_vector_save(cntx);
+		kvm_riscv_vector_save(cntx);
 }
 
 void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
 {
 	if (!kvm_riscv_isa_check_host(V))
-		__kvm_riscv_vector_restore(cntx);
+		kvm_riscv_vector_restore(cntx);
 }
 
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
-- 
2.43.0

