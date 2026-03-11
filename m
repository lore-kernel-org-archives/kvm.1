Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AE367F2E
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189245; cv=none; b=RE4steeLBbK/dRKXSHtNyPLnpfMkyfLQSNO/O+kXWwXpokY+RWTj9aCHZS4zvcc4E66tcTwMlSWZ7DtkWdzsAyR6FGaQhcs7Ejumal5T2cb/mquHcMRql5gYiSHvySdFsml3gavxrXjhk9qdg52y+qqChuP6+ZLquzbF9+16pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189245; c=relaxed/simple;
	bh=gUHJnfT47WA8UME9igHBxYTLndDdZjAEZkok6tr14PQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2Y0Q9fak2SS47JYkHtY4uuGoet0cswp2/C9fo6YRbY3PDKujOnI2e0zMvVaLUguh76XDwfYHhawvYW9MFl6Jf1bxXmrb9hGwmL0sjwVp6ayg3VA+RtWWnUUJiWiKhcC0rWL04HuTaWpbRFKVgzDXNiXf4hHKefKplnfav/vWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4BfCtqsM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4BfCtqsM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598733bec0so54321488a91.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773189243; x=1773794043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Q91qKTw/u2zRo/3uRL6c/7UREv+NiPYJeCn/l/Npduc=;
        b=4BfCtqsMVombrMmAGYgYubrEmDxpCfo6sscP5jD/++J7XaPVTlnh8MEu5InCr0O35c
         DIQDi0SDiZK8oLKUyZuErDFOowKB34TTHt1jy/2pnNvIp9cF0uDhZmTVa7AMXhey1duT
         k5AwKz6V8WHZX/LKty/WkskoIaloSccjb2ozezaLbqHF0o3g8cDc0bCBGcqm8ZhY1mfN
         Zoh0kldWJD+9gBKCOIusbbQ35EDliKrifN2MKOcn9HJLsQA1gDxvgYY4iFrQTU/bxXIN
         LAuu1xaUdzn5TEig98Y/X+vAmMsrNEowQEeTL7X2cWCaaj2owtSndfJyE1hnPZZiYfy2
         W+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189243; x=1773794043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q91qKTw/u2zRo/3uRL6c/7UREv+NiPYJeCn/l/Npduc=;
        b=ZEsDttiXBTmXNxDtcdN0OEHnMzxxnMGe57JD4Qxj8ZxrfVj6dBhsnvh6F51s/8aiic
         dg0M5lwYKIaR+yjaSHMMt+jVCDJ2qX/HMFPTeLEg8R6qPXjPp5XcTTuEPiLIzKOTq79J
         dUPIM+4MaRDhTtg60Jp/DHtjMXa5hqG7XNB8f6krTMUQ5Wg3wvi8L+nVTEXgVW1NWJVT
         j8XpDg9pLUpWBy6BTcg7sMa0uAAYqY2LlVQvtTufDAoFL6Ji/jVV/lS8dyJDH1VKwsR/
         tzSjH7VguCbfWMv1Wj7DDYz3V0fUtuWMnkoNKh10ou7CIIS8xIsatIWe4rmTUjE9pviW
         5s5g==
X-Gm-Message-State: AOJu0Ywb6odGys9SNF5Fvfwp5saqg1ZkjoVlEw+us5D03tKQw9sUpw4i
	mEnTM9oat7vxokxVg46bYQBXP+BEU8lkJ9ALnLFJGPWM6ufn86ZxnSosEZEWKaV4oD6L607vfMC
	OpKj2Mw==
X-Received: from pjbjx10.prod.google.com ([2002:a17:90b:46ca:b0:359:8f46:13ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d09:b0:359:9158:7459
 with SMTP id 98e67ed59e1d1-35a00f1bd24mr748529a91.0.1773189242920; Tue, 10
 Mar 2026 17:34:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 17:33:44 -0700
In-Reply-To: <20260311003346.2626238-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311003346.2626238-6-seanjc@google.com>
Subject: [PATCH 5/7] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

Convert regs_{avail,dirty} and all related masks to "unsigned long" values
as an intermediate step towards declaring the fields as actual bitmaps, and
as a step toward support APX, which will push the total number of registers
beyond 32 on 64-bit kernels.

Opportunistically convert TDX's ULL bitmask to a UL to match everything
else (TDX is 64-bit only, so it's a nop in the end).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/kvm_cache_regs.h   |  4 ++--
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/tdx.c          | 34 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.h          | 20 +++++++++----------
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3af5e2661ade..734c2eee58e0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -802,8 +802,8 @@ struct kvm_vcpu_arch {
 	 */
 	unsigned long regs[NR_VCPU_GENERAL_PURPOSE_REGS];
 	unsigned long rip;
-	u32 regs_avail;
-	u32 regs_dirty;
+	unsigned long regs_avail;
+	unsigned long regs_dirty;
 
 	unsigned long cr0;
 	unsigned long cr0_guest_owned_bits;
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 94e31cf38cb8..5de6c7dfd63b 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -106,7 +106,7 @@ static __always_inline bool kvm_register_test_and_mark_available(struct kvm_vcpu
 }
 
 static __always_inline void kvm_reset_available_registers(struct kvm_vcpu *vcpu,
-							  u32 available_mask)
+							  unsigned long available_mask)
 {
 	/*
 	 * Note the bitwise-AND!  In practice, a straight write would also work
@@ -119,7 +119,7 @@ static __always_inline void kvm_reset_available_registers(struct kvm_vcpu *vcpu,
 }
 
 static __always_inline void kvm_reset_dirty_registers(struct kvm_vcpu *vcpu,
-						      u32 dirty_mask)
+						      unsigned long dirty_mask)
 {
 	vcpu->arch.regs_dirty = dirty_mask;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index dea46130aa24..7010db21e8cc 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -460,7 +460,7 @@ static inline bool svm_is_vmrun_failure(u64 exit_code)
  * KVM_REQ_LOAD_MMU_PGD is always requested when the cached vcpu->arch.cr3
  * is changed.  svm_load_mmu_pgd() then syncs the new CR3 value into the VMCB.
  */
-#define SVM_REGS_LAZY_LOAD_SET	(1 << VCPU_REG_PDPTR)
+#define SVM_REGS_LAZY_LOAD_SET	(BIT(VCPU_REG_PDPTR))
 
 static inline void __vmcb_set_intercept(unsigned long *intercepts, u32 bit)
 {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d4cb6dc8098f..1e4f59cfdc0a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1013,23 +1013,23 @@ static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	return EXIT_FASTPATH_NONE;
 }
 
-#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_REG_EXIT_INFO_1) | \
-				 BIT_ULL(VCPU_REG_EXIT_INFO_2) | \
-				 BIT_ULL(VCPU_REGS_RAX) | \
-				 BIT_ULL(VCPU_REGS_RBX) | \
-				 BIT_ULL(VCPU_REGS_RCX) | \
-				 BIT_ULL(VCPU_REGS_RDX) | \
-				 BIT_ULL(VCPU_REGS_RBP) | \
-				 BIT_ULL(VCPU_REGS_RSI) | \
-				 BIT_ULL(VCPU_REGS_RDI) | \
-				 BIT_ULL(VCPU_REGS_R8) | \
-				 BIT_ULL(VCPU_REGS_R9) | \
-				 BIT_ULL(VCPU_REGS_R10) | \
-				 BIT_ULL(VCPU_REGS_R11) | \
-				 BIT_ULL(VCPU_REGS_R12) | \
-				 BIT_ULL(VCPU_REGS_R13) | \
-				 BIT_ULL(VCPU_REGS_R14) | \
-				 BIT_ULL(VCPU_REGS_R15))
+#define TDX_REGS_AVAIL_SET	(BIT(VCPU_REG_EXIT_INFO_1) | \
+				 BIT(VCPU_REG_EXIT_INFO_2) | \
+				 BIT(VCPU_REGS_RAX) | \
+				 BIT(VCPU_REGS_RBX) | \
+				 BIT(VCPU_REGS_RCX) | \
+				 BIT(VCPU_REGS_RDX) | \
+				 BIT(VCPU_REGS_RBP) | \
+				 BIT(VCPU_REGS_RSI) | \
+				 BIT(VCPU_REGS_RDI) | \
+				 BIT(VCPU_REGS_R8) | \
+				 BIT(VCPU_REGS_R9) | \
+				 BIT(VCPU_REGS_R10) | \
+				 BIT(VCPU_REGS_R11) | \
+				 BIT(VCPU_REGS_R12) | \
+				 BIT(VCPU_REGS_R13) | \
+				 BIT(VCPU_REGS_R14) | \
+				 BIT(VCPU_REGS_R15))
 
 static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d3255a054185..0962374c4cd3 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -623,16 +623,16 @@ BUILD_CONTROLS_SHADOW(tertiary_exec, TERTIARY_VM_EXEC_CONTROL, 64)
  * cache on demand.  Other registers not listed here are synced to
  * the cache immediately after VM-Exit.
  */
-#define VMX_REGS_LAZY_LOAD_SET	((1 << VCPU_REG_RIP) |         \
-				(1 << VCPU_REGS_RSP) |          \
-				(1 << VCPU_REG_RFLAGS) |      \
-				(1 << VCPU_REG_PDPTR) |       \
-				(1 << VCPU_REG_SEGMENTS) |    \
-				(1 << VCPU_REG_CR0) |         \
-				(1 << VCPU_REG_CR3) |         \
-				(1 << VCPU_REG_CR4) |         \
-				(1 << VCPU_REG_EXIT_INFO_1) | \
-				(1 << VCPU_REG_EXIT_INFO_2))
+#define VMX_REGS_LAZY_LOAD_SET	(BIT(VCPU_REGS_RSP) |		\
+				 BIT(VCPU_REG_RIP) |		\
+				 BIT(VCPU_REG_RFLAGS) |		\
+				 BIT(VCPU_REG_PDPTR) |		\
+				 BIT(VCPU_REG_SEGMENTS) |	\
+				 BIT(VCPU_REG_CR0) |		\
+				 BIT(VCPU_REG_CR3) |		\
+				 BIT(VCPU_REG_CR4) |		\
+				 BIT(VCPU_REG_EXIT_INFO_1) |	\
+				 BIT(VCPU_REG_EXIT_INFO_2))
 
 static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
 {
-- 
2.53.0.473.g4a7958ca14-goog

