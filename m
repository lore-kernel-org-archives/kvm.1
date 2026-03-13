Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9E36D516
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385842; cv=none; b=cDOre4OrKR7GDoRteWMmUBj6iNbNpq0FZyC5FmmdjFgLZyU/2J7qp6AU5YZkWGf1ftIIcj1eiazt31h31YXCjD9Ya/QRpuMbeyDJpQK0DVd/IfydW/kotV9UeTX9hyvht8mbxsVmFOXH4/7Da3Tx6GvomOZ9swwO8Od/5Uv65Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385842; c=relaxed/simple;
	bh=zEieePgVikfqHjkpa0n5I3vuISbE49oCD0CeCAd8nWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rlARhuOlBAgwbrk24lLLEzMcZmVt1e2C0iTE5dUkVV/oeGkvPgzXeELJOSB9dMkoBF3hy+NFKpvf/aLNwgml1qiw4nN7A8bKLlPk8oZRDW0fJPPucLYj3iM1wdF4Pm5gN6xkXJYDVtV0H/1UBicqnDjXi7U8mL21g+h81kNm4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/KF92Uh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/KF92Uh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a07f4597aso752954b3a.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773385840; x=1773990640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMnjMyqVdWNANGnVMI3Si7Uw5YgsWHlFIfWWP9yjF3Q=;
        b=o/KF92UhsWxr4VPk0TlyiOLhHqipKGRVD/Wig8TQEk7naiAEabGbyLGZ/JT4hsYwXk
         lazZs33o8I10brmqmKjyBItWGLXKsCRwDf3ms7Z293KirH/CPbyXI9KiHWsiDQ6GhQGP
         Xo1bqxP94HwjP+Gcl9klePdXh3v8qgvgE9gwtXZYyjpwMGfEeBZxjkfGw4k24PWJ4fYn
         IZY5JpqXK7J35kFvDXlYpxVrdipdj2jTbLnglNw4gz2qPpKo7ma8Nd1IN1XqkNOdLGU1
         m5jzSIt5PUaDaW50gj4MNKmEP0vA+65VX2fQBKmDxDjB4xOL6Xe87Ae1e6XSe6W7FUgz
         M8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385840; x=1773990640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMnjMyqVdWNANGnVMI3Si7Uw5YgsWHlFIfWWP9yjF3Q=;
        b=TAmoM/wOd87bM1pKAF0wmk97aCays0E7lDkTZQiF8LZmW+mABwcbVlZ9SHOt+wwyJn
         iUL6BlH9/vHLwpLw/vP51EUEJYN3kqdlS97khn+kwDiU99UfAQsgA60HKyJMfdJLeq23
         iIDp3iyBHPAY1Yp6x9RcsLYbRPtSL8JzH9uSgY3Rzp3nKrElAz+JhtoSPcFnb+SMvnI/
         kzPPjqGKd2JfiYfuyX3t5z9HB6gduBuhHB1gRSp39qvWCF9zSlMGjCa5ymX39SoZhtA9
         cOfwR/EGF4oTjxzIX/GJFDYgLksxoVdu1oTomwHCykcpEZPLa1IN5ba9z4cmvfxoY30q
         SCqA==
X-Gm-Message-State: AOJu0Yy55oHz7DfiTvgCYliOxrltAvD5HvOkEDX0VfVblnlxsWXqMyeY
	mXXnBLASzGMHWl8PQW8mS6kMHy7xR+rjvsrxDbNDj9IlxxbG+fMEz1eb91EYg+fihreZ6333sxU
	LMjxZPNSVzMRb6g==
X-Received: from pfuv11.prod.google.com ([2002:a05:6a00:148b:b0:829:84db:97d8])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:278a:b0:81f:61d2:84a9 with SMTP id d2e1a72fcca58-82a198c4368mr1672419b3a.35.1773385839766;
 Fri, 13 Mar 2026 00:10:39 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:10:31 +0000
In-Reply-To: <20260313071033.4153209-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313071033.4153209-3-chengkev@google.com>
Subject: [PATCH V3 2/4] KVM: SVM: Fix nested NPF injection to set PFERR_GUEST_{PAGE,FINAL}_MASK
From: Kevin Cheng <chengkev@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, yosry@kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix nested_svm_inject_npf_exit() to correctly set the fault stage bits
(PFERR_GUEST_PAGE_MASK vs PFERR_GUEST_FINAL_MASK) in exit_info_1 when
injecting an NPF to L1.

There are two paths into nested_svm_inject_npf_exit(): hardware NPF
exits (guest_mmu walker) and emulation-triggered faults (nested_mmu
walker). For emulation, the nested_mmu walker knows whether the fault
occurred on a page table page or the final translation, and sets the
appropriate bit in fault->error_code via paging_tmpl.h. For hardware
NPF exits, the guest_mmu walker cannot determine this. Only hardware
knows, via exit_info_1 bits 32-33.

The old code hardcoded (1ULL << 32) for the emulation path, always
setting PFERR_GUEST_FINAL_MASK even for page table walk faults. For the
hardware NPF path, it preserved exit_info_1's upper bits and replaced
the lower 32 bits with fault->error_code, which was correct but
convoluted.

Introduce hardware_nested_page_fault in struct x86_exception to
distinguish the two paths. For hardware NPF exits, take the fault stage
bits from exit_info_1. For emulation faults, take them from
fault->error_code. The lower 32 bits always come from fault->error_code,
which reflects L1's NPT state (L0's NPT may differ since KVM only
populates it when the full translation succeeds).

Add a WARN_ON_ONCE if exactly one of PFERR_GUEST_FINAL_MASK or
PFERR_GUEST_PAGE_MASK is not set in the final exit_info_1, as this
would indicate a bug in the fault handling code.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  | 26 +++++++++++------------
 arch/x86/kvm/svm/nested.c       | 37 +++++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d3bdc9828133..134394dc09e6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -281,6 +281,8 @@ enum x86_intercept_stage;
 #define PFERR_GUEST_RMP_MASK	BIT_ULL(31)
 #define PFERR_GUEST_FINAL_MASK	BIT_ULL(32)
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(33)
+#define PFERR_GUEST_FAULT_STAGE_MASK \
+	(PFERR_GUEST_FINAL_MASK | PFERR_GUEST_PAGE_MASK)
 #define PFERR_GUEST_ENC_MASK	BIT_ULL(34)
 #define PFERR_GUEST_SIZEM_MASK	BIT_ULL(35)
 #define PFERR_GUEST_VMPL_MASK	BIT_ULL(36)
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index ff4f9b0a01ff..e67982f4da40 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -24,6 +24,7 @@ struct x86_exception {
 	bool error_code_valid;
 	u64 error_code;
 	bool nested_page_fault;
+	bool hardware_nested_page_fault;
 	u64 address; /* cr2 or nested page fault gpa */
 	u8 async_page_fault;
 	unsigned long exit_qualification;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 37eba7dafd14..ea2b7569f8a4 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -385,18 +385,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
 					     nested_access, &walker->fault);
 
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
-		if (unlikely(real_gpa == INVALID_GPA))
+		if (unlikely(real_gpa == INVALID_GPA)) {
+#if PTTYPE != PTTYPE_EPT
+			walker->fault.error_code |= PFERR_GUEST_PAGE_MASK;
+#endif
 			return 0;
+		}
 
 		slot = kvm_vcpu_gfn_to_memslot(vcpu, gpa_to_gfn(real_gpa));
 		if (!kvm_is_visible_memslot(slot))
@@ -452,8 +446,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 #endif
 
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
-	if (real_gpa == INVALID_GPA)
+	if (real_gpa == INVALID_GPA) {
+#if PTTYPE != PTTYPE_EPT
+		walker->fault.error_code |= PFERR_GUEST_FINAL_MASK;
+#endif
 		return 0;
+	}
 
 	walker->gfn = real_gpa >> PAGE_SHIFT;
 
@@ -787,8 +785,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * The page is not mapped by the guest.  Let the guest handle it.
 	 */
 	if (!r) {
-		if (!fault->prefetch)
+		if (!fault->prefetch) {
+			walker.fault.hardware_nested_page_fault = walker.fault.nested_page_fault;
 			kvm_inject_emulated_page_fault(vcpu, &walker.fault);
+		}
 
 		return RET_PF_RETRY;
 	}
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5ff01d2ac85e..62904ec08dda 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -38,19 +38,34 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
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
+	if (fault->hardware_nested_page_fault)
+		fault_stage = vmcb->control.exit_info_1 &
+			      PFERR_GUEST_FAULT_STAGE_MASK;
+	else
+		fault_stage = fault->error_code & PFERR_GUEST_FAULT_STAGE_MASK;
+
+	vmcb->control.exit_code = SVM_EXIT_NPF;
+	vmcb->control.exit_info_1 = fault_stage | fault->error_code;
+	vmcb->control.exit_info_2 = fault->address;
 
-	vmcb->control.exit_info_1 &= ~0xffffffffULL;
-	vmcb->control.exit_info_1 |= fault->error_code;
+	/*
+	 * All nested page faults should be annotated as occurring on the
+	 * final translation *or* the page walk. Arbitrarily choose "final"
+	 * if KVM is buggy and enumerated both or neither.
+	 */
+	if (WARN_ON_ONCE(hweight64(vmcb->control.exit_info_1 &
+				   PFERR_GUEST_FAULT_STAGE_MASK) != 1)) {
+		vmcb->control.exit_info_1 &= ~PFERR_GUEST_FAULT_STAGE_MASK;
+		vmcb->control.exit_info_1 |= PFERR_GUEST_FINAL_MASK;
+	}
 
 	nested_svm_vmexit(svm);
 }
-- 
2.53.0.851.ga537e3e6e9-goog

