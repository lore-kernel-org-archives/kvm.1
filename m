Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182303955CC
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492428; cv=none; b=PMJgR+QLgdthpCkB8nqvoh4Xc8o6pANqDmrvttcRRIidjtZHBr2WmvGMp1e/M1YfBoMUmn0QYTFJiPX3DgR5D9AuSXItiv+o6AWLlbTgyMWi7c0esK4Dxe5xzEAJ6PigMUI5aa/vF+MXkLMskgxiSIAHk2G6ucGPBuXhBnbUnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492428; c=relaxed/simple;
	bh=0xDc9Sj2KquCH8xt5Xkpdt4RhnhgzgrZ6M7yAba7slc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yr5qu55XE+n8S8gKhCncpUT1r6IO3P6V2efq44FXmX/lnESNunH3Nb4gSSseD3G2eJ/1iscKui2j15FbUjQVq9axTvRA4hEpVQ8W70/T7biJFBrkg/sUXAkYLLeeT8pDFVG8TEb7ioOp8SxxdTlEBoHNZs3jU54PQ++A2w+DNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJq20X0g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJq20X0g"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367f715cbd0so7750523a91.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779492426; x=1780097226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu9a/Wr16frEyZPr2UhLBVScqdRmqcTkSaOGh95mR3o=;
        b=OJq20X0gbi4RGr03CUtXntdRcZp3dOrCYM0Ao4CLUuxSaEuIYkHeT+PtGjztrMSJVM
         fgq2FqP1DDAfnhP5V7bXdCN0EHjzCbIo51u3Et1Ja+djnSav/lcfsbgfdbgT5ipjLh8j
         H6cGVRuyjdqyvpshXzf4uRO+4H7ZomoxuetivtBEhU5HmR72VljIvmh4y6hMXLnKn1lC
         UO4LDX4vy5XLt1UyHzTUyP4YMJJnfGV4FRM6rq0y6PaSn4nZF/p2ek4TN6dxcxwqfyzg
         nhlIYnpN4QzLA1Jt34+rCOYRQEVJgrKiUKqzPzyXSVMY3W2mrW/SxdyU0ESCqSN1eLLU
         3I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492426; x=1780097226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hu9a/Wr16frEyZPr2UhLBVScqdRmqcTkSaOGh95mR3o=;
        b=Q9niOUpmA4AQUBqXi7K/UGO3fEEVjV5Nt0X3aAcsqVAnFLikx+dmztMomlrtP13not
         ydYkAVpJFscxP4KrE8ixBJAoz6Nl3cqgZ2MqlpzBSzCtAhqML7D350xuttdfVCCuqKuo
         YYzinTCzUQirvq0TLK2ZzISRacT2q5PcJtG5QxKzJi9T1YXwjmbTg4t6DojVhBV9lUTz
         Q3x7UpigXmff/MTMc5XUp8gtN0i6l1q+9PPp1ZP92LvWchjcfTpjFo+2IS4tacIuXLUa
         f6XNzXmr7dGdyq/PrCaPN6VdXqjRmfCEVL8gOpCSTzjEMvwyid+BB9kp5OxgJVkTO2ZH
         df2Q==
X-Gm-Message-State: AOJu0YwZy0Q4M0iTJD/HsESm+gfRu7I+3QWdhFLjpMfhH3YdkYvbuHs0
	0xCHgxZOJTDtxwvLZ1uLE0LxqZzx/v2ttNM8yi8IguknHtbQX3C5/JmPrjPirTS/etUDj4GGbtg
	zxpccYQ==
X-Received: from pgau15.prod.google.com ([2002:a05:6a02:2d8f:b0:c73:bdbf:6a66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4e:b0:35e:d015:d675
 with SMTP id 98e67ed59e1d1-36a67719220mr5979911a91.7.1779492425806; Fri, 22
 May 2026 16:27:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 16:26:59 -0700
In-Reply-To: <20260522232701.3671446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522232701.3671446-4-seanjc@google.com>
Subject: [PATCH v4 3/5] KVM: SVM: Fix nested NPF injection of
 PFERR_GUEST_{PAGE,FINAL}_MASK bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kevin Cheng <chengkev@google.com>

Fix KVM's generation of PFERR_GUEST_{PAGE,FINAL}_MASK bits when injecting a
Nested Page Fault into L1.  Currently, KVM blindly stuffs GUEST_FINAL into
L1, which is blatantly wrong given that KVM obviously generates NPFs for
page table accesses.

There are two paths that trigger NPF injection: hardware NPF exits (from
L2) and emulation-triggered faults, i.e. when KVM detects a NPF as part of
emulating an L2 GVA access.  For the hardware case, use the bits verbatim
from the VMCB, as KVM is simply forwarding a NPF to L1.  For the emulation
case, propagate the GUEST_{PAGE,FINAL} bits from the access field (which
were recently added for MBEC+GMET support).

To differentiate between the two cases, add "hardware_nested_page_fault"
to "struct x86_exception", and set it when injecting a NPF in response to
an NPF exit from L2.

To help guard against future goofs, assert that exactly one of GUEST_PAGE
or GUEST_FINAL is set when injecting a NPF.  Unlike VMX, there are no
(known) cases where hardware doesn't set either bit, and KVM should always
set one or the other when emulating a GVA access.

Signed-off-by: Kevin Cheng <chengkev@google.com>
[sean: use plumbed in @access bits, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu/paging_tmpl.h  | 15 +++++---------
 arch/x86/kvm/svm/nested.c       | 35 ++++++++++++++++++++++-----------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d11063c36f03..e1c4151d6693 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -284,6 +284,8 @@ enum x86_intercept_stage;
 #define PFERR_GUEST_RMP_MASK	BIT_ULL(31)
 #define PFERR_GUEST_FINAL_MASK	BIT_ULL(32)
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(33)
+#define PFERR_GUEST_FAULT_STAGE_MASK \
+	(PFERR_GUEST_FINAL_MASK | PFERR_GUEST_PAGE_MASK)
 #define PFERR_GUEST_ENC_MASK	BIT_ULL(34)
 #define PFERR_GUEST_SIZEM_MASK	BIT_ULL(35)
 #define PFERR_GUEST_VMPL_MASK	BIT_ULL(36)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index cc9c7deb34bc..66eee6914234 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -397,16 +397,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 					     nested_access | PFERR_GUEST_PAGE_MASK,
 					     &walker->fault, 0);
 
-		/*
-		 * FIXME: This can happen if emulation (for of an INS/OUTS
-		 * instruction) triggers a nested page fault.  The exit
-		 * qualification / exit info field will incorrectly have
-		 * "guest page access" as the nested page fault's cause,
-		 * instead of "guest page structure access".  To fix this,
-		 * the x86_exception struct should be augmented with enough
-		 * information to fix the exit_qualification or exit_info_1
-		 * fields.
-		 */
 		if (unlikely(real_gpa == INVALID_GPA))
 			return 0;
 
@@ -548,6 +538,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	walker->fault.nested_page_fault = mmu != vcpu->arch.walk_mmu;
 	walker->fault.async_page_fault = false;
 
+#if PTTYPE != PTTYPE_EPT
+	if (walker->fault.nested_page_fault)
+		walker->fault.error_code |= access & PFERR_GUEST_FAULT_STAGE_MASK;
+#endif
+
 	trace_kvm_mmu_walker_error(walker->fault.error_code);
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1c1a5e322d18..28ac5d5c990d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -39,19 +39,32 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
+	u64 fault_stage;
 
-	if (vmcb->control.exit_code != SVM_EXIT_NPF) {
-		/*
-		 * TODO: track the cause of the nested page fault, and
-		 * correctly fill in the high bits of exit_info_1.
-		 */
-		vmcb->control.exit_code = SVM_EXIT_NPF;
-		vmcb->control.exit_info_1 = (1ULL << 32);
-		vmcb->control.exit_info_2 = fault->address;
-	}
+	/*
+	 * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
+	 * available in the hardware exit_info_1, since the guest_mmu
+	 * walker doesn't know whether the faulting GPA was a page table
+	 * page or final page from L2's perspective.
+	 */
+	if (from_hardware)
+		fault_stage = vmcb->control.exit_info_1 &
+			      PFERR_GUEST_FAULT_STAGE_MASK;
+	else
+		fault_stage = fault->error_code & PFERR_GUEST_FAULT_STAGE_MASK;
 
-	vmcb->control.exit_info_1 &= ~0xffffffffULL;
-	vmcb->control.exit_info_1 |= fault->error_code;
+	/*
+	 * All nested page faults should be annotated as occurring on the
+	 * final translation *or* the page walk. Arbitrarily choose "final"
+	 * if KVM is buggy and enumerated both or neither.
+	 */
+	if (WARN_ON_ONCE(hweight64(fault_stage) != 1))
+		fault_stage = PFERR_GUEST_FINAL_MASK;
+
+	vmcb->control.exit_code = SVM_EXIT_NPF;
+	vmcb->control.exit_info_1 = fault_stage |
+				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
+	vmcb->control.exit_info_2 = fault->address;
 
 	nested_svm_vmexit(svm);
 }
-- 
2.54.0.794.g4f17f83d09-goog

