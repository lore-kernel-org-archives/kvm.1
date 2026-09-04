Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85472931FC
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481478; cv=none; b=riCDOIKeeXF4luXuIRKVpGbHedZsu4COLmgJpk4V+2ISfe2U2V+jYbV3YHzdGz80x3o8kUJI8xdXdkB0pGU4tcj80+rKfi2i+XGuMyP3csNHdSxeHzgW7UXIHUxUZxrUPVM58/goBfkMop5HT/MOt0XRMUkLf0sz9yAsz80kOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481478; c=relaxed/simple;
	bh=bL+/d2XsljvTdCWPxBEUMfQNuIdb2cAEkc/Lc8x6cmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c7k2EuF0SaMb9dUQASSF59ATBfRA6SaCGGUFhwPoGBOvANDwZRlgputpGJ+jO7iheAhV/7tq3GTzs5jVD6+lm8IxBbRsofXAH0/IIbWL1bNV2RUtFHVL6VD303dePVFZsEGhLT4psfmeH3TSpaixKZa5I2yvTouOtkotL4XnNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pf9toYf3; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pf9toYf3"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85326b426c0so497593b3a.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481473; x=1789086273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R1KMl6QKcbTWJGXOV2RsRhaC6Lo9OYh7u7lENzPYhXc=;
        b=pf9toYf3KgDnmJNpBfQz0fgyL8XI5Gyjp0P7+Z9+bl99FwLM6WrzSiqnZxk3tU+Xbr
         i/vZ+OSxOZ3T1vhiK9MsrBTmYJYpDp4gKvF1AAHLZk5J5LsNxfe5YPSSVeYxsDAMJUY4
         JGpVi4A87HtybVwE+r0OiNE1c8aR/NHMGVTGugWqHDxVwCYT+8bBxvquk4EPwIXsaSlK
         PO7BFRZQqb9kPmSu9lrurMRgMGGJxsjAeQtFUrSZbHijJH6Zs/7ScH07mUP8rmYx4Dqs
         nayFAUs2zxLwe+QOPaw7gZ0OQGFkknKTkaXXMuond3ZA4jdP1tVkHcaubyLdlgoBMSl/
         ZATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481473; x=1789086273;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R1KMl6QKcbTWJGXOV2RsRhaC6Lo9OYh7u7lENzPYhXc=;
        b=bgeHmsA6Ku1y0CSEJkmHTBXJJqLVYHJVdBDQVQY0moYYpaZUtLBXVScUTdM3vg5AU2
         /FCp4nfMp3xcD1Dds3/B+bzt4+Tbk+NQ5VtsppUgmUNTsn2z27llqStGiYhUc7JFXSxR
         4BS3Qz6jBBVPz+Bog9CAN3AK4tdFgP+bAQBuxgYCIH4kHoGLVJ+rUpOiCWvDxg26GjNE
         dsN8gnZ8xcJuiNcDv5p/WKb6X58Kb9M7pAUyVLnqJXNlYNr8rHJiSQ8jy+k7as5GzJ6S
         sjCniKSsfhaZsVzJls1Hbl3fZ8/gP83DtRpg/b0ywhPHA2aTawk2TcoJ6n/ynTRIewz9
         oPaA==
X-Gm-Message-State: AFuF++lwTYK+gKSS/FZOD41ZEVbJDIqMSCMiblS9ZAlSIy3VV6YfxX1U
	pEh5C8bJCb9mkk68ql0E5hrrZSqjDSiZekH6o3l4URsPrJ4bctseMI6dyB8BQW849rMleQY/oUC
	djJVGYg==
X-Received: from pfw10.prod.google.com ([2002:a05:6a00:a26a:b0:845:e386:e036])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3486:b0:851:804c:f4eb
 with SMTP id d2e1a72fcca58-86168099cb1mr3514654b3a.4.1788481472848; Thu, 03
 Sep 2026 17:24:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:12 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-7-seanjc@google.com>
Subject: [PATCH v4 06/17] KVM: selftests: Assert success in vmptrst(), kill
 off vmptrstz()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Assert success in vmptrst() instead of punting to the caller, as literally
every user expects VMPTRST to succeed (and because '0' is a valid physical
address).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 19 ++++---------------
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  4 ++--
 tools/testing/selftests/kvm/x86/state_test.c  |  8 ++++----
 .../kvm/x86/vmx_preemption_timer_test.c       |  2 +-
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index a161dbee7e04..04f638fcd3ba 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -366,27 +366,16 @@ static inline int __vmptrld(u64 vmcs_pa)
 	return vector ? vector : failed ? -EINVAL : 0;
 }
 
-static inline int vmptrst(u64 *value)
+static inline u64 vmptrst(void)
 {
-	u64 tmp;
+	u64 value = 0;
 	u8 ret;
 
 	__asm__ __volatile__("vmptrst %[value]; setna %[ret]"
-		: [value]"=m"(tmp), [ret]"=rm"(ret)
+		: [value]"=m"(value), [ret]"=rm"(ret)
 		: : "cc", "memory");
 
-	*value = tmp;
-	return ret;
-}
-
-/*
- * A wrapper around vmptrst that ignores errors and returns zero if the
- * vmptrst instruction fails.
- */
-static inline u64 vmptrstz(void)
-{
-	u64 value = 0;
-	vmptrst(&value);
+	__GUEST_ASSERT(!ret, "vmptrst failed");
 	return value;
 }
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index f953a9755a76..0c9cf620c87d 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -97,7 +97,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_evmcs(hv_pages));
 	/* VMPTRST returns -1 until VMLAUNCH with eVMCS ptr set */
-	GUEST_ASSERT(vmptrstz() == -1);
+	GUEST_ASSERT(vmptrst() == -1);
 
 	GUEST_SYNC(4);
 
@@ -123,7 +123,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
 	GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), NMI_VECTOR);
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == hv_pages->enlightened_vmcs_gpa);
 
 	/*
 	 * NMI forces L2->L1 exit, resuming L2 and hope that EVMCS is
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 4a1056a6cb8d..9d4e0c1f7c18 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -78,17 +78,17 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	GUEST_SYNC(4);
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, vmx_l2_guest_code);
 
 	GUEST_SYNC(5);
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(!vmlaunch());
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* Check that the launched state is preserved.  */
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index eb8021c33cd4..523aab667d85 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -73,7 +73,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
-- 
2.55.0.979.g7e5102b832-goog

