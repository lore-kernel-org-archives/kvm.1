Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423658;
	b=qByfIMKKyQkQyGs2jqkq3TLcw5YDh0o8SITy0skUv0tSmN1Os6oiGZMG7bsHpnOwQuPm
	 IHRNIcDMA9h8+uP3ROT2jW+7BwyZt9673Upgw4ZO0uvk7DItbPAFM2rv7wWfaMtHfmW4e
	 WymlAlt+63ORK9PzfwCfehsmKlFxAoRmbagJphZ1lVTp2Ttyso4QsvMZ29n0oSru6i6Ev
	 Mf5Z6bRbVoctuz3y90mty7OeOz/rfYaetIopYnpZEj/SKXpWDtbOPvH6xNgr35WeNrMuo
	 rFibJHmUajtrjAYzYXZxobS5wF2an+FtxhuqTHotqsIsch5ZWU8mb0zhK/I57T35tZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=azizRUMCgRko1/GUha6IzG/UJcDkn0Qm2HTQ4Be0lk4=;
	b=h2i74RuYyOeDygX7bfsUkCRpd6+7qMbhmTvHMRN7K9/dCtnmuaBk0Om34ep95oSZ89PC
	 4JSoIbFhU9OG9aOekPZjXmah1U+sNR1PvUCl4gbo/8OrNIiLzFVffW+wvk46C7ki52jB6
	 l7Zi8mprXUcGlYHsiYzevAJWOhqKM1H1sGqLdE/KIkgxWymlWIQ5uXEMEMpsUJM+fvHZl
	 btYOfbpqIs8j8K0Co8Q7vmtvy06xpWMM80hoJHiqf20UFPqOjK+JBDtJ9/iur/4hjl1yi
	 gVBbchy6ZYD4l+dEi4lZeW3EyV72pFlkE6+NXyiO2pKf5dcIkcpHfESalwbRNOzRvrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tenstorrent.com;
	spf=pass smtp.mailfrom=tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b="Vl83y45/";
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB9606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63CB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Vl83y45/
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67be9601f48so194702d50.2
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1794423657; x=1795028457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azizRUMCgRko1/GUha6IzG/UJcDkn0Qm2HTQ4Be0lk4=;
        b=Vl83y45/AOsywyEpYq9Y8MkIKNxSH3ZGfTvkS9yLt51hHSJ8HcR7SY7nKDAXNNyGfD
         3qb+VwG0Qvu2sf9HhyAek6UEKwmNrwSoHpzqWeLkd4cFZ9Tlum6dFF4mEs+8+g8ArV5V
         g7vIV/hvT8yrHtQEy9BbjRJUSt5v28KqLaQmmZUM2dBH7fTLh73g+KAq/k00p/oSxgNt
         oO4zbIctL1eUmxVWTe4i9jgCr6k4yQwz5X6cwgF4a9L8/NrdEo/iti3e3esrprUplYkS
         n57bkiDOjlwXdldP3VhLiCOLW3ZB2sqkAlfwwVfzNYB/rV1GpRyEjdJSQXWE2xeX3etA
         FyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423657; x=1795028457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=azizRUMCgRko1/GUha6IzG/UJcDkn0Qm2HTQ4Be0lk4=;
        b=OA0q8HJ7TTRQISPOH3W74rNq9LTuIkVA4rXaQVx/v5lbM5M55L1E99dBK+HcFV+j83
         rTSn7oLjPuEcLlqT7acsaPWUevEpygyrF0wAytd9IQnQXqbniKVULoWC9eh4k+0nXgVq
         hTxguBG+uSScz58j0tppaE+CLPhlYmnNmO9t6Q18MYaJV6EGc5C5SuEIneEwGK10GRs6
         SHX+ZQvYkIyHpQlxNY6BbnGT1uyoG7tSmtWvDKNvkmBzuyRRU7KT0iiehUZOh7GROFD7
         j1A089FGv2YuqB9NkD8LgH+O+SiEjYBVyBW+gfyCl1WW2IJh7WBUskMcAOYs28BfpSDQ
         MSHg==
X-Forwarded-Encrypted: i=1; AL+hErGAY/fZ/GhUbvPpXJEHjOBP1N8DfX/A9znNu11cI5t8jnyu+UP3lyQHEgAgHiS/nppBCXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6tOVQpnBLHdeW9H3Z49iI14B4uFejHQHMkhmJSVu2XQhg8MEc
	s5JTJJ84h14FRnxVlBkNvkObv9YBB30aDNXwpSZSfLGAQrzD+7axY4vw+8DL9C6TIyc=
X-Gm-Gg: AYBFou1DRllF85tqa0oJENEY+O2GWhou7wZwA5Xbn87DmKgqk7h5zTu9HBAPLI4NeTT
	m/DcYo/ihatHQHTt2o17C0ytfiIgmXPZIlfyquc/8LignpTyjiqMsVRZzb0qx0jE7jeTqzmUP7E
	U88txcSRFsOK5PvtOGh1azM1C5hkcujmFAfuQCpbaveoLchmUB+T2SxnCYyjQvhRM5gfCiYY8An
	/yeF/j75trlhATDzUiC4AwqhfCJReFNuEtxsHLlhCFWU/WK9iGpaPrS8C8PhLl/k06J459MdNii
	hDOQ+EJtM63/AAyXNdn06Z9pB3G8swA17f353EmxjWmAbpftykKxYFrD+wTT+PRtfMmo6nu3QEN
	lpZUmcFYXis5i8NtEYGSKAKC2nTI7ngVQeikvm2cENKU2FLWqBeHCTwmT04X5eeZFHleevPwy6G
	Ak9Z+FSmM2NOKGvTOpmqhNEvFht9KO5nNCd9cjkOKa2Yy/rxHaHxob04fwhO+1yD5xVN2iGIbnO
	zzM+9RzOVAg13EmCGFsSjklomn6yO+Iszv/6zAgkbvFLWCIdk9PCs6BHkXKCA6WW5BfykRNce7p
	XPWt91r3QfGN/k65++DA3dBAoHN4OmYPJg6xdHQYJf0fVuEWvobzisIJYANvxmz5OsjyNwJ+7IM
	pMbbkkZP7smhWv30wTSF5gT1sJwbhGThWp3wwIBmE4lVtlx4=
X-Received: by 2002:a53:c685:0:b0:67b:fbde:ba75 with SMTP id 956f58d0204a3-67c67fe1b29mr1675254d50.71.1794423656063;
        Wed, 11 Nov 2026 11:00:56 -0800 (PST)
Received: from lima-default.tail89d63.ts.net (108-196-157-19.lightspeed.austtx.sbcglobal.net. [108.196.157.19])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a2354sm5209197d50.6.2026.11.11.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:00:55 -0800 (PST)
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
	Aurelien Jarno <aurelien@aurel32.net>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	daichengrong <daichengrong@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: [PATCH v7 1/6] riscv: vector: refactor vector context operations
Date: Wed, 11 Nov 2026 12:43:23 -0600
Message-ID: <20261111184359.1239821-2-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111184359.1239821-1-tchiu@tenstorrent.com>
References: <20261111184359.1239821-1-tchiu@tenstorrent.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index 50d4789b9cac..60fa28030944 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -16,14 +16,18 @@
 #ifdef CONFIG_RISCV_ISA_V
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
index 3381a535abb4..8c88a2258e61 100644
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
 			: "=&r" (vl), "+r" (datap) : : "memory");
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
 			: "=&r" (vl), "+r" (datap) : : "memory");
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
@@ -323,7 +320,9 @@ static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 	WARN_ON_ONCE(preemptible());
 
 	if (riscv_v_vstate_query(regs)) {
+		riscv_v_enable();
 		__riscv_v_vstate_restore(vstate, vstate->datap);
+		riscv_v_disable();
 		__riscv_v_vstate_clean(regs);
 	}
 }
@@ -385,8 +384,10 @@ static inline void __switch_to_vector(struct task_struct *prev,
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
index dd786f758eb7..caf6e0ad72ef 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -825,7 +825,7 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
 		current->thread.riscv_v_flags &= ~RISCV_V_VCPU_NEED_RESTORE;
 		current->thread.riscv_v_flags |= RISCV_V_VCPU_CTX;
-		__kvm_riscv_vector_restore(gcntx);
+		kvm_riscv_vector_restore(gcntx);
 		gcntx->sstatus = (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
 	}
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index fefc2857f753..730c32f7de50 100644
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

