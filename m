Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9939A068
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774580; cv=none; b=uDG6ufJaJTrUlX1aFWbwWjdDyBM/+JGp+ygQEpBz478PETf9uE/sP1w3KtLH2o02PjPHdDgSPwbPpUEYGSuZ1hwMMp4JqQejzurNEEVj3RUl/nn2YQGBw1yZPaQKR2Ts2c2SUKpRpfKivvBLIa8fULaYbNG13IO7M3L/Iajztd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774580; c=relaxed/simple;
	bh=l2tksM2qxMIs0YsaAut7K8eN8vuMtiw3vlyXTQPw/No=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bvflfY3oO/RHF3BBVmqgqxHL6qLyuYy3oBImbmsa1MBWfY2OWPr0QYRjsZ6YHjZ1IUPEhV+w40BLT5h9MfUyLcWwK4ZDlKBR/Mbf2fkdPzOL+BIHvXpJdZlNuWVEUcSCGVw7e96XAyoPToLYczBmGzk68vm1VAjDF7WAJYXR2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pl83S6tT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pl83S6tT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ca8323edbso1387106b3a.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775774578; x=1776379378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tDN4tVJ6/vh7WLhGggTNs8OwwMerYRn5pnEFOX+nQmM=;
        b=Pl83S6tTd4UwI4wHXxgfOiJ7X2ue8aHp776IGXd+RzZx9HZ8diYl8iGu2Z/amTSHQg
         ysT41Kn+UbT0Ba2hHRQs6L5ara5JdHDis7k44tUvVCNWnO0NJC3VgAxTf0J2t474HCfm
         xZ4VAYTwY8MAl/Ojg1IVHgQEeS9L/m6Xx6oPs+/KcmXSPhNyc9R6s8/ulnxw5YUJVH/B
         hNUvhy1MOsZEoeUYANPUzk2aHzQ35vfwQ3O2ZVfiIoFq5w2QOfq9S3pj7IOWp620EksS
         i8v3NOolTUT5B5LwvCuHoHNsrpgJgNC9WCzJRZ8SulrrU9XrAtWOIp07rQp2EFfTfEDh
         k4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774578; x=1776379378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDN4tVJ6/vh7WLhGggTNs8OwwMerYRn5pnEFOX+nQmM=;
        b=SnB3qSofJRpUiZhAalxngDeIBym1x0Oo9heriogLIsQKgTTAU6mIXHwdv3Zd41tnsp
         NgyTOoN1LvqxjmvhwClDkrEXUnWE/dmpwDVDlm6clUCfbLmmU8DrO0QBAfczZwLH/Kv6
         oPnKbYHz3q9Te1gkUMKuwo0i0tkiCeF44Uet8YnjTTifyIDr/O59EgZ9MOqqtUABNZ6X
         RJ+isqjd+5m7bFtDWGhczgXRZgMBcC52SgNz3iCPNZRBZF2GBuorUUIG5gvLDonZlZNo
         /DNsojnv3PfSTkaiEM2bW6XpW+u7QdLZD48Irp2oWYhPmc1C5b+bYCdRt0MlRu+rhbNu
         O9kA==
X-Gm-Message-State: AOJu0YwY0IB7UtR9iD8NfJbP6/7PyWc0kIeN+3+o/DcxAtIMPEBV8hlV
	YENcPLF8nYxtKEg01qGW4MJF3XGhTezulZUjSJJK/hOgF7lpnEuxuq+t+Wd7XwpPrMJpRVMVIiW
	xujg4vA==
X-Received: from pfoo1.prod.google.com ([2002:a05:6a00:1a01:b0:82c:9835:bf12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e0:b0:821:7d7e:41cd
 with SMTP id d2e1a72fcca58-82f0c1ea02fmr979859b3a.10.1775774578196; Thu, 09
 Apr 2026 15:42:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:42:35 -0700
In-Reply-To: <20260409224236.2021562-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409224236.2021562-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: x86: Use a proper bitmap for tracking
 available/dirty registers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define regs_{avail,dirty} as bitmaps instead of U32s to harden against
overflow, and to allow for dynamically sizing the bitmaps when APX comes
along, which will add 16 more GPRs (R16-R31) and thus increase the total
number of registers beyond 32.

Open code writes in the "reset" APIs, as the writes are hot paths and
bitmap_write() is complete overkill for what KVM needs.  Even better,
hardcoding writes to entry '0' in the array is a perfect excuse to assert
that the array contains exactly one entry, e.g. to effectively add guard
against defining R16-R31 in 32-bit kernels.

For all intents and purposes, no functional change intended even though
using bitmap_fill() will mean "undefined" registers are no longer marked
available and dirty (KVM should never be querying those bits).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++--
 arch/x86/kvm/kvm_cache_regs.h   | 20 ++++++++++++--------
 arch/x86/kvm/x86.c              |  4 ++--
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c47eb294c066..ef0c368676c5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -211,6 +211,8 @@ enum kvm_reg {
 	VCPU_REG_SEGMENTS,
 	VCPU_REG_EXIT_INFO_1,
 	VCPU_REG_EXIT_INFO_2,
+
+	NR_VCPU_TOTAL_REGS,
 };
 
 enum {
@@ -802,8 +804,8 @@ struct kvm_vcpu_arch {
 	 */
 	unsigned long regs[NR_VCPU_GENERAL_PURPOSE_REGS];
 	unsigned long rip;
-	unsigned long regs_avail;
-	unsigned long regs_dirty;
+	DECLARE_BITMAP(regs_avail, NR_VCPU_TOTAL_REGS);
+	DECLARE_BITMAP(regs_dirty, NR_VCPU_TOTAL_REGS);
 
 	unsigned long cr0;
 	unsigned long cr0_guest_owned_bits;
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 171e6bc2e169..2ae492ad6412 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -67,29 +67,29 @@ static inline bool kvm_register_is_available(struct kvm_vcpu *vcpu,
 					     enum kvm_reg reg)
 {
 	kvm_assert_register_caching_allowed(vcpu);
-	return test_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
+	return test_bit(reg, vcpu->arch.regs_avail);
 }
 
 static inline bool kvm_register_is_dirty(struct kvm_vcpu *vcpu,
 					 enum kvm_reg reg)
 {
 	kvm_assert_register_caching_allowed(vcpu);
-	return test_bit(reg, (unsigned long *)&vcpu->arch.regs_dirty);
+	return test_bit(reg, vcpu->arch.regs_dirty);
 }
 
 static inline void kvm_register_mark_available(struct kvm_vcpu *vcpu,
 					       enum kvm_reg reg)
 {
 	kvm_assert_register_caching_allowed(vcpu);
-	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
+	__set_bit(reg, vcpu->arch.regs_avail);
 }
 
 static inline void kvm_register_mark_dirty(struct kvm_vcpu *vcpu,
 					   enum kvm_reg reg)
 {
 	kvm_assert_register_caching_allowed(vcpu);
-	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
-	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_dirty);
+	__set_bit(reg, vcpu->arch.regs_avail);
+	__set_bit(reg, vcpu->arch.regs_dirty);
 }
 
 /*
@@ -102,12 +102,15 @@ static __always_inline bool kvm_register_test_and_mark_available(struct kvm_vcpu
 								 enum kvm_reg reg)
 {
 	kvm_assert_register_caching_allowed(vcpu);
-	return arch___test_and_set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
+	return arch___test_and_set_bit(reg, vcpu->arch.regs_avail);
 }
 
 static __always_inline void kvm_clear_available_registers(struct kvm_vcpu *vcpu,
 							  unsigned long clear_mask)
 {
+	BUILD_BUG_ON(sizeof(clear_mask) != sizeof(vcpu->arch.regs_avail[0]));
+	BUILD_BUG_ON(ARRAY_SIZE(vcpu->arch.regs_avail) != 1);
+
 	/*
 	 * Note the bitwise-AND!  In practice, a straight write would also work
 	 * as KVM initializes the mask to all ones and never clears registers
@@ -115,12 +118,13 @@ static __always_inline void kvm_clear_available_registers(struct kvm_vcpu *vcpu,
 	 * sanity checking as incorrectly marking an eagerly sync'd register
 	 * unavailable will generate a WARN due to an unexpected cache request.
 	 */
-	vcpu->arch.regs_avail &= ~clear_mask;
+	vcpu->arch.regs_avail[0] &= ~clear_mask;
 }
 
 static __always_inline void kvm_reset_dirty_registers(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.regs_dirty = 0;
+	BUILD_BUG_ON(ARRAY_SIZE(vcpu->arch.regs_dirty) != 1);
+	vcpu->arch.regs_dirty[0] = 0;
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac05cc289b56..b8a91feec8e1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12836,8 +12836,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	int r;
 
 	vcpu->arch.last_vmentry_cpu = -1;
-	vcpu->arch.regs_avail = ~0;
-	vcpu->arch.regs_dirty = ~0;
+	bitmap_fill(vcpu->arch.regs_avail, NR_VCPU_TOTAL_REGS);
+	bitmap_fill(vcpu->arch.regs_dirty, NR_VCPU_TOTAL_REGS);
 
 	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
 
-- 
2.53.0.1213.gd9a14994de-goog

