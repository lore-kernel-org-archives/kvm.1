Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30624380FC7
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382720; cv=none; b=f+03uYgAnMqqgW0ehosPz1DxhedJBECtUCikagd49xjDraXDa3IOUbHfufTacxhknzTjiEyithajdK4iuOrr49BS6MobuLRpCT8yEu9gELyzwxTOMBDzDfplhqE3puIiVPecVCoKnas2Z98QXcPLE8hXXmm1vN4PD4TRfcJ+bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382720; c=relaxed/simple;
	bh=YDo5qCMggMlOvMLyOkHfzroHUfyr4wGF7FfUTBPlIMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQVMdPTAd/i1al7XkidhzAVjpN+TzKRjvKPSN9skgSTeYcZGCFA4WtHzochkXNF246t/X71SnKTy4iadVBjVke25lARgWTS/Xx1aPuuERLuwocV8u+fbDC216oIgbnaDaGv5MH+hXC/vjCur0JEHd2+No/aXAYoAlaoWAVaRtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=CBLETbTB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="CBLETbTB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2157806b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1786382717; x=1786987517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yXeCapJ8O6pFik/pQOiopBCAOlrWUSEybq5ZkCAQJg=;
        b=CBLETbTBoMUmcN3L5tzErCshvz+PLwd2ykwMLS1Rhz5ZSYFI0vGWNQJndPmNJEVFof
         mfB+9ZYZtoGtsYI3IgJU66jQ3EwkHAb8lBMvmeq3DZovEG2ehfBHBK4FTZ/jfOumwLRO
         F8QkM4BYRWMTDwucKzdPc3KDz2luaCBwYeloncXm04uBK26ge612VT3+z2zKOhTiX0ho
         JU0sCCF5+jR1/aLGkDNhxY7/su/zj2BSA+O8pVGjssj+ok1XOCLmdUIjEdvoa07a2enz
         mRPjaVMaE9iiNtBuI2Z8/z7k/yTpUErFpZUPKMN+E4/vfsL8RlgkF4wEel/MkzV7fc+L
         RbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786382717; x=1786987517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0yXeCapJ8O6pFik/pQOiopBCAOlrWUSEybq5ZkCAQJg=;
        b=eJ1K31O8wWyO3bbGfgylTlGo3wuK3XDmxkMBTioMoQlvHLkMNOi7ZD/zUo9buIzEM/
         poqcktSZfZ+j39pdmrJ/syHToZ8+474Q/tAqHbclXS7d0neWjKziPyq4RX/9KRq7U1Xj
         QerHlm5CnFQB6cNjP7gHk9U4K/dD7TGjJZssfEInf8adR5U0ziH4bjBJsS8KbgS3GQU2
         /RVLTKpMwN4SLWrOTtWsT+Fbmksg0I9QFD6qS4MaA00cjXfmOgddhSiaTc2E9bZFTBdA
         LxCa7x0kD36IYVHlJnMUUiG9SbT2Hl/VvlToiFVytD50W/JIl4rCZ6ZwG53T0kao4C/G
         R2fg==
X-Forwarded-Encrypted: i=1; AHgh+RrwjB5csO3tBRwrX6ItTa8ZZCwpjstaZltS8MZzTt07uA8Q+8+ULXKZO1+UKhO/7ciYDgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrjgqVR3fF1g92et467wiwZqS3Q2TN5LoFdJmB27YxuWkt+hP
	z6hQlR3MTfkfBIU3B70x8pybDXbOxEc+oJtXUIPkj5F5ugQf47CU1EQlcbSFCoN3//3FV60JsOi
	eaHrtkF+MsjYt
X-Gm-Gg: AR+sD11PxDkzvT0XOd4iRU5rrzRPpFu+7cCEkRMF5Mbg1kLeZ49ZAGAsdhSYEp/QE6l
	Y/LRUFIH+wimvhkPIWeIVbX25hsdBIU3r4fZAnpmivD1OE35TOHa3lQV5JHQoBHi3VtNP+AkZNQ
	2F/cQTgTTd8OVDBgIfEMpupwJD5K+UyHeXhwEIC0WPb0YXTF0OAeI6WPGlD7oVAp8ezsTfD9Itl
	ZGqXJ10eZMcP4kBEC+wHHRnh90gvaaTMvGDNVuNgwNI7zwRlkXHNjMD/MlTnQWZDdGE4twxs+Et
	rLTGQ/GZNypyhtuovFa0tSpC0hEMVIRyY+Ma8mA+NuPhTe0trbtLVaEt3cZE2jFCv3YTQy0t/69
	gPp0yhwY6CUM8WxcHaJSpuwDzlO2w6RtoIT261lDDJ8cZSaon9o3sIhEqUhKQPCE5ov/zu35f+b
	9Y80+rQMtulYywRFMYMrVCzByOrqx+6CPuR/WZcM4/AwbkvLmKqRRpqEXMFa88TBwM7Ktl5x4C5
	chf/aCTINYKh2+pO8hL3uoTyqyvaR8p1eJLgzWgTKqGZBkCgiZWPd/QriTgOkzmSQ==
X-Received: by 2002:a05:6a00:9295:b0:848:7552:3d86 with SMTP id d2e1a72fcca58-84f9c95fc09mr2998157b3a.23.1786382717228;
        Mon, 10 Aug 2026 10:25:17 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net (61-222-153-199.hinet-ip.hinet.net. [61.222.153.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5898f8sm4149949b3a.52.2026.08.10.10.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:25:16 -0700 (PDT)
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
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	daichengrong <daichengrong@iscas.ac.cn>
Subject: [PATCH v5 3/7] riscv: vector: refactor vector context operations
Date: Mon, 10 Aug 2026 12:22:30 -0500
Message-ID: <20260810172255.1532787-4-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810172255.1532787-1-tchiu@tenstorrent.com>
References: <20260810172255.1532787-1-tchiu@tenstorrent.com>
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
index fccf9edb4e6a..e7f9fce5ab43 100644
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
@@ -382,8 +381,10 @@ static inline void __switch_to_vector(struct task_struct *prev,
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
index 5ad93ddf6a10..369a0756d059 100644
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
index e2651808e1d3..3d2566647029 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -773,7 +773,7 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
 		current->thread.riscv_v_flags &= ~RISCV_V_VCPU_NEED_RESTORE;
 		current->thread.riscv_v_flags |= RISCV_V_VCPU_CTX;
-		__kvm_riscv_vector_restore(gcntx);
+		kvm_riscv_vector_restore(gcntx);
 		gcntx->sstatus = (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
 	}
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index ef2eee6ec308..6cfa5c0c7e6c 100644
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
@@ -64,13 +64,13 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
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

