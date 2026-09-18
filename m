Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749B52E063
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768420; cv=none; b=qiXvc9IMVdSQHJ44ENPQosJOJyG16D+v3vEI6ihLewK2zh6q4l39SyxSBmFjcYGbwFklv8IdT07tFoUX1hFHE14nIZX+BKqn34RA8c+fJg3IrXr+G3X3c1Xp0vxqknNHlUVtaLHYHcras9ioZHwkdrlFi4LOG7UfqaiXg4IoAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768420; c=relaxed/simple;
	bh=jSV+MNaygcuk4qFfL5JYmF1eZLswVhM8AYT+X3lr4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T50VqTvde3h9Olfco7xAkY5VR7aKx2CQtkUs0j+I2GNl0kSPHT7NaN5a8ECIXdmScacVax9pp4LK8tagm1LnG/4CxUdj78MlWnqB4YcP+0dxw5IM5C5c7j0eBAr6pG+2PyPNFoxMN40KvvbKTPmG2dysOkMBxelBggZCGXQD8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=IKUK9HA/; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="IKUK9HA/"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab2029eso1218822d50.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1789768418; x=1790373218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8AcazG5orY9zyVEiayUxMbZg1UyeKhBPuhiHnjK3rYU=;
        b=IKUK9HA/Eac0ENLYa8IuZgqAXVw9p8ZRl/cou229zQd+7GVOcrDJ9/QHdt+B1kCyi9
         rPeEHm6lYgny/UWHznqBJwA6HiqNv5HAgwTCqrrn8rHqFLxxuai36kgEqFDg+SmoRYe9
         vpf45D6ssItoRnF4ZFzzw/5GIfG4l5uk7iGVD4Tvgk0oOWwJwE5mZOciKTjmZSmuRXms
         1qFZOaZtLbYIS7NHJYDg1GPrrMp80gKnQp0QI8NNhZNJqBBXUteBDY7+EGykeslJQpCv
         4aFE4rU8n/Iyd+Dd6+q2JQhCIOEenko+hAttyAHHZjaR4fL8sfQt2Xf8R0WDlaDIV9gG
         /4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789768418; x=1790373218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8AcazG5orY9zyVEiayUxMbZg1UyeKhBPuhiHnjK3rYU=;
        b=wZuzd5NTPtixr9ucwJ7bCW4c0ju3EwanYqQolvgTvkvIyKuAVcwwJSXHq5yoJDhlbM
         u1KA+RFhTZxT13ecvTqn3LiFUMHMALWnJFXPxXE/7lyeTnnDYd06MWf5nxrEzd47G8Rb
         jSji4d4gJ1AMTMG3yihqe5yKcjdjHRhieZpji9dabo5AA1xy+3y3uSH5GOxW1Gwctroy
         Fl7+AJB5u1ibztwVkBb19yKN8CcVcLo9vzkDd2HFIna2ZWq+uFS7itkg86GSgq8UYBU5
         +b7xco4iHhIrgtc6AWS/aZT3AN1AOjRR+f7co+PuGVJ883oYU+zQe667a35iyJIjM1XQ
         50+A==
X-Forwarded-Encrypted: i=1; AKwUvBzcfHmD1EteUdrdZXP4Xt+99yBoww+JzT+k1cS61UkaOUn4opfTWvHxXinhWRUyK6m/aVQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nFaR1VFtDtI3ys9Ud6VOZFVLOBgbf7EvYE3ZZ8RIRIrjK/7HVN
	XYUNHBzm6cOJ6VQFz26zr30ocxRp40h6yf0bVh+sgaVdYCx14hiLYKkJryggPA+hks8=
X-Gm-Gg: AYBFou1ZEBI+kVrqbpLiRVTvyemmyGUnOmMjyxPFHFvYupMGPkt0G0cm4atWte9ikv6
	Jlw1l9dvaxrh2MU3O1R+QVc6gdZS45wy7zDcREQhuRRJ1KkI9EtXGPtyW6t0lkB7NLtzAT+Cdmi
	XxljyT5FvtOFNWgU6q2KpnZcPB9PHmctHeHyYCa09LI2WWvuEYkKgV3MTs4p7kqq/Mjx1hE+XrX
	MY8nuWrMVirdts+IZNbWh258YC/OpaYITFzOdvkmOF5zvF1opeuqIAeN/oBjL/Ix2Nar26GyE3b
	I4JW/NQ4Wh6U4TAMbqHWjuo5DJZ+wN56CeiGJAWmfvI251DmJiOrGEiaMt/7I2FS6OiogIO53a+
	mRlhmo6m+dO++oNjaeThu1humu6tTE/AsmL9IMCDne61MH6yyDeAN3W0q5s09MLi56H81+02uly
	Ls5/++Lm1KtEd11KeT9+dRGxz6ExHgAa4ImwtCuxWAZ9jhNFE39DuQ63MCqHRJ3IuALf92yFntq
	X5Hyv/iCqw1beUCak9Of+Xz+mVtqmLxMca8
X-Received: by 2002:a05:690e:4850:b0:672:99e1:11f5 with SMTP id 956f58d0204a3-67299e11736mr155084d50.146.1789768418150;
        Fri, 18 Sep 2026 14:53:38 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a45d8fb3csm4017757b3.13.2026.09.18.14.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:53:37 -0700 (PDT)
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
Cc: andybnac@gmail.com,
	Andy Chiu <tchiu@tenstorrent.com>,
	dfustini@oss.tenstorrent.com,
	greentime.hu@sifive.com,
	daichengrong <daichengrong@iscas.ac.cn>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v6 4/8] riscv: vector: refactor vector context operations
Date: Fri, 18 Sep 2026 16:51:18 -0500
Message-ID: <20260918215154.2481482-5-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918215154.2481482-1-tchiu@tenstorrent.com>
References: <20260918215154.2481482-1-tchiu@tenstorrent.com>
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
Changelog v5:
 - rebase on top of the kvm fix[1]
Changelog v4:
 - fix an unused variable warning (Olof)
Changelog v3:
 - new patch since v3
---
 arch/riscv/include/asm/kvm_vcpu_vector.h |  8 ++++++--
 arch/riscv/include/asm/vector.h          | 15 ++++++++-------
 arch/riscv/kernel/kernel_mode_vector.c   |  4 ++++
 arch/riscv/kvm/vcpu.c                    |  2 +-
 arch/riscv/kvm/vcpu_vector.c             |  6 +++---
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 6371d5ea5392..f6aba7ade694 100644
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
index 6aa125d66ace..b9538ebd85be 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -203,7 +203,6 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
 {
 	unsigned long vl;
 
-	riscv_v_enable();
 	__vstate_csr_save(save_to);
 	if (has_xtheadvector()) {
 		asm volatile (
@@ -232,7 +231,6 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
 			".option pop\n\t"
 			: "=&r" (vl) : "r" (datap) : "memory");
 	}
-	riscv_v_disable();
 }
 
 static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_from,
@@ -240,7 +238,6 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
 {
 	unsigned long vl;
 
-	riscv_v_enable();
 	if (has_xtheadvector()) {
 		asm volatile (
 			"mv t0, %0\n\t"
@@ -269,14 +266,12 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
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
@@ -296,14 +291,14 @@ static inline void __riscv_v_vstate_discard(void)
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
@@ -312,7 +307,9 @@ static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
 				       struct pt_regs *regs)
 {
 	if (__riscv_v_vstate_check(regs->status, DIRTY)) {
+		riscv_v_enable();
 		__riscv_v_vstate_save(vstate, vstate->datap);
+		riscv_v_disable();
 		__riscv_v_vstate_clean(regs);
 	}
 }
@@ -321,7 +318,9 @@ static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 					  struct pt_regs *regs)
 {
 	if (riscv_v_vstate_query(regs)) {
+		riscv_v_enable();
 		__riscv_v_vstate_restore(vstate, vstate->datap);
+		riscv_v_disable();
 		__riscv_v_vstate_clean(regs);
 	}
 }
@@ -383,8 +382,10 @@ static inline void __switch_to_vector(struct task_struct *prev,
 			riscv_v_disable();
 			prev->thread.riscv_v_flags |= RISCV_PREEMPT_V_IN_SCHEDULE;
 		} else if (riscv_preempt_v_dirty(prev)) {
+			riscv_v_enable();
 			__riscv_v_vstate_save(&prev->thread.kernel_vstate,
 					      prev->thread.kernel_vstate.datap);
+			riscv_v_disable();
 			riscv_preempt_v_clear_dirty(prev);
 		}
 	} else {
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index b9481a3e40e3..280180114899 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -171,7 +171,9 @@ static int riscv_v_start_kernel_context(void)
 		WARN_ON(riscv_v_ctx_get_depth() == 0);
 		get_cpu_vector_context();
 		if (riscv_preempt_v_dirty(current)) {
+			riscv_v_enable();
 			__riscv_v_vstate_save(kvstate, kvstate->datap);
+			riscv_v_disable();
 			riscv_preempt_v_clear_dirty(current);
 		}
 		riscv_preempt_v_set_restore(current);
@@ -215,7 +217,9 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs)
 	depth = riscv_v_ctx_get_depth();
 	if (depth == 0) {
 		if (riscv_preempt_v_restore(current)) {
+			riscv_v_enable();
 			__riscv_v_vstate_restore(vstate, vstate->datap);
+			riscv_v_disable();
 			__riscv_v_vstate_clean(regs);
 			riscv_preempt_v_reset_flags();
 		}
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index bd723e1a685d..71207288a180 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -801,7 +801,7 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
 		current->thread.riscv_v_flags &= ~RISCV_V_VCPU_NEED_RESTORE;
 		current->thread.riscv_v_flags |= RISCV_V_VCPU_CTX;
-		__kvm_riscv_vector_restore(gcntx);
+		kvm_riscv_vector_restore(gcntx);
 		gcntx->sstatus = (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
 	}
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 536e1b9a8abf..f2d216fece81 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -47,7 +47,7 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
 {
 	if ((cntx->sstatus & SR_VS) == SR_VS_DIRTY) {
 		if (riscv_isa_extension_available(isa, V))
-			__kvm_riscv_vector_save(cntx);
+			kvm_riscv_vector_save(cntx);
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
 	riscv_v_flags_set(riscv_v_flags() & ~(RISCV_V_VCPU_CTX | RISCV_V_VCPU_NEED_RESTORE));
 }
 
-- 
2.43.0

