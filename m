Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7641372685
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380774; cv=none; b=B97usxQEEF2fNJHbSXxw8QpPx2X6ZyZuWG+10wFSrRtKuhZXs/X9bPNwHkdvaMmrifei34ko4c68K0mxBul25090eX1D8xioQeUUCKIYP7EToCC1ec0tDo9rzlvwENqTtpZh114SJOEGI/WNWq8U7GnzcWxbHQc2d17nl4z0IOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380774; c=relaxed/simple;
	bh=YYxTrPw1rAzTk1je6agvo1wNjJPe9fIYuc/7fnjENXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifdJllSiw6vkY1AScnZei1hvCdH1MejHRcrz1Kxi02vzXg4xO6dv+K1bx61AMMTFA8ncmmhqq2IIQQlnYMyTBhNYnqrG9BgnLcRuyYmv/WlJYVZiUdsfeBGxk0H+ML4c94VPUlDUrAjB5rYAK3Gjo2g9JjdIwwavxqxnSWXLmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=GeCaCG+Q; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="GeCaCG+Q"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c58e6eb3edso59965167b3.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1779380770; x=1779985570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rt+eccmcXgWHzcJLFH1t7pO8Lp6Bcln3NkX+SnzPS0=;
        b=GeCaCG+Q9cPzQD+TbmPSRtEQzmGaGKW1vq8T6wNqDvFjWWYo5+8kmYVJFB/zuZBlRN
         7NI7nN8YvMO/tY21uLKciTSwBnjpFTgEqM18YXydVi6XSSZ/P5HEXJqYHNGHEzmsojwH
         wSoCgI0GRbitwRjEHyBetwNnSd8lcyDo5LxLy11mYDIVcoQ+EsU1p8MNdG0W3vTWpnEa
         qQL5knFg/5ZSpGYSWxGlM5AHCGRIwFZ9JlqimfahPqmfJLoZ56dbKMp3VgH2iV2u2KZe
         3YcM3ZpVwzphyKq0njCNfVgw0c5kART9iLnavmh0XnLX9/q9KKo0sWa5j9foeNnmBlWG
         yRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380770; x=1779985570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Rt+eccmcXgWHzcJLFH1t7pO8Lp6Bcln3NkX+SnzPS0=;
        b=PsitETQpZ3WejGcLp0PwLXzVki6QtvL3SlFBkl+wRpsYlsF9FayUT6IVHuyfu9f/ZR
         8G7l4b5lURIoyzZ5YgfUTUWrOhiHtnp1IeZJCZmpBS62yJ+Tl17VAxfknmN7fzvNhmSV
         XAiE4PiTZzLfKVrzgTNxZiDW+4IDi1GkRIejkGB0q9We3RLvTMrCXzoSw83YtQnmJAt/
         sCbpcsQ4X+kepbeyVfW/LA24Y9cZUdb6bwWTP8towWI2/PJ1CYRGj0kExxotvMA8/k9T
         PhGjl+UHnvEZcwvdHl4PV3UTJOYmwQ3o9xUdjhwpTYEYBYMArYCmS0QXo6OlVtYWT1OZ
         Ry2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+X9MJc6niR3S7u2xyBnB2jgShrlcj3RWGKzpyRsabjSGIdCl+p+tE/r3tq6WsNK1pn6zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ8q3SqJOhdwBUVLUMGoEvbPApNLKznxvzge/17M+u5POK3LS
	SCMl4zUX7XLWpTQ29Ktn8lDyE2Ups14a8JVuwCs8iNUrR3Y+87bD8kQ9kWesQUUrqLg=
X-Gm-Gg: Acq92OGGX/Z9Q6MbWKOn4UmTYXGYhKp8Rlm9ZgUm2vg0mKn30PT9M7nTa2O5DBamAa9
	3lM8CKxbuYeTZjgkV9pIO4117e0xJW2ckxYd39SPi/XK97Bj+2BV3q2MRPpLZK5WPcF9iriOqsy
	SxIVa+hzpDhB0G/OQvG/gNybpcjRUWH8YWjZy5YbooOt5pZqlLZ4/VFvEPPBSgjNPS0nzQ0eMqI
	VlLlfWHOsZj5FXW6CAiyRlisF7nx1Fm0UjlLcsEuKkloPKGovGehjQ0pzlhBPP0pXVAZsRfApA6
	+HemcSmxsfuYAC6u1tqh5Dz3BHcGPU50y2AZ2TSv5l6lhvlAZV4hW9Z9Zxn3nZ1/DJCK4IaYy0d
	/i8g7PPj4VfFf5kOEd/e5us4a5tZ63fzHmjPbflvJ7H6M3v9UZ3ETJ2+epep9YQO9d7wNvrrwZ/
	B1dZzephTvdZTvibS1naRyipbcrs1NrDybcA3xTLQDVrTxqP5zHBI9nFK8
X-Received: by 2002:a05:690c:368d:b0:7b1:2c46:9480 with SMTP id 00721157ae682-7d20c54d17dmr41525137b3.34.1779380770084;
        Thu, 21 May 2026 09:26:10 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2ca76a8cbsm4822007b3.32.2026.05.21.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:26:09 -0700 (PDT)
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
	bjorn@kernel.org,
	greentime.hu@sifive.com,
	vincent.chen@sifive.com
Subject: [PATCH v3 1/4] riscv: vector: refactor vector context operations
Date: Thu, 21 May 2026 11:25:17 -0500
Message-ID: <20260521162521.188629-2-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521162521.188629-1-tchiu@tenstorrent.com>
References: <20260521162521.188629-1-tchiu@tenstorrent.com>
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
Changelog v3:
 - new patch since v3
---
 arch/riscv/include/asm/kvm_vcpu_vector.h |  8 +++++--
 arch/riscv/include/asm/vector.h          | 15 +++++++------
 arch/riscv/kernel/kernel_mode_vector.c   | 27 +++++++++++++++++++-----
 arch/riscv/kvm/vcpu_vector.c             |  8 +++----
 4 files changed, 40 insertions(+), 18 deletions(-)

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
index 99972a48e86b..b612793d6979 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
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

