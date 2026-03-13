Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC49370D4D
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385844; cv=none; b=QAV+0KHyCaFDGq8ZPhg/80T6rlPfhiY98u6O9+ow3+PANtMuk/t5yWxx7LaP/norxncFjtGi0LNDAzJ8qg5f+jYPBy0Lrfq//6p6piNsF8RRWCaN4iRY1ildlm7jeTZwhfFwbA4onpm6jDS196bfIJOlx9OL+dLWeD+Ou3izLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385844; c=relaxed/simple;
	bh=9LlIX91Z/ZvbbeR02bUtgeWebst4TFDOSn3cp2RnlTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koyST+ySZFEF2v46hT98QEdyobT8aGZ+xQ1nJ083SW4flR0MfyQMOT8RB8Jy+SVw6qA/NRgyNC1afkq7onDCG/Ck8ix5yJlOXpZulcauoqJPhkG0CAaPuAwFJwKOIG2Y3bzTjKj+sSHIbyjQxEtX/oBAmhOuXd8olvM4V2EEWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjdnolXt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjdnolXt"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c629a3276e9so7980751a12.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773385842; x=1773990642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMnmbravmc6HAY/hwiz+iRBLWQc+dimhfGrxweAepUY=;
        b=cjdnolXtWWmiXLLrLgVH5UsOGw7+samhtrbEMU5KJbQYnOCx4SIw/y5Uo6fXgDX1Ec
         x9khZsdb3VtsdvNoYx6quT8DX14O6mWGOqNSFql54YsYt9FTXsJP5mtph7cKZufgJc8H
         BIaEQBDxZ9p/XIPrJqt3M9BtSWW1wNLEa77NaDg+EbbSdtibIb1OVHh+7E30q9e6m31S
         2/xRvQ7V88pp0nMmZfLq9iTOHfqORc/MHjeIpVWZywtwU4fTuKcRvq++syZEoQwr+JYk
         kWpXfwDpZqsrEVgEhMQR514HxTXW08SAGgvjNhDP2TBgoNdS5ttnxqIsw3Txr7Zyj6yV
         2hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385842; x=1773990642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMnmbravmc6HAY/hwiz+iRBLWQc+dimhfGrxweAepUY=;
        b=jLQ+ot5RBabBTWq9Jqrpo2s9bE8g00NksafE7jBG/juEn1JEEUsNhnA+pMZ6Y70A9J
         X61G9R+1yqCsHJEMk2N8QTSABh/idga8uENNBSzqKUGpqNMvmAAhnU9GLfxQalwq/GtC
         iL/10BJaWgAbpslcjXI9hSsXzhhN95ypD1FtOROxwNPEE+dtrdT3FbU4BxUumsCYVEq/
         NvxZekXePdLahF4wbtyIqfWBmZ+94IFvwQx/ILGQ3XkuHKO9SXQDfIcdlkLARHBRH/jp
         ZIGo/AdZpPW0jSiLMnaE4sHaTre3Gv7sZZn07kXFkm4j/DKDgRbUIOgE/+7xRqTK5Y+w
         uGhA==
X-Gm-Message-State: AOJu0Yzx4r+nC+dhJgWOF0sA8AinEzEuUs/uKnKYxrT3kWoN5HhmT9oP
	9fCeDpWHjTS0CAgwxM51+uoGsiZbuejLGRoGfMSCbca2lhMVAiWB+7jnOTZvDur/NpgBFmfY51G
	m9DtSjCQK7fohhQ==
X-Received: from pfbhm21.prod.google.com ([2002:a05:6a00:6715:b0:824:ad09:9215])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4f8d:b0:81f:3f88:89ee with SMTP id d2e1a72fcca58-82a19704525mr2113077b3a.12.1773385841864;
 Fri, 13 Mar 2026 00:10:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:10:32 +0000
In-Reply-To: <20260313071033.4153209-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313071033.4153209-4-chengkev@google.com>
Subject: [PATCH V3 3/4] KVM: VMX: Fix nested EPT violation injection of
 GVA_IS_VALID/GVA_TRANSLATED bits
From: Kevin Cheng <chengkev@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, yosry@kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Make the OR of EPT_VIOLATION_GVA_IS_VALID and
EPT_VIOLATION_GVA_TRANSLATED from the hardware exit qualification
conditional on the fault originating from a hardware EPT violation
exit. The hardware exit qualification reflects the original VM exit,
which may not be an EPT violation at all, e.g. if KVM is emulating
an I/O instruction and the memory operand's translation through L1's
EPT fails. In that case, bits 7-8 of the exit qualification have
completely different semantics (or are simply zero), and OR'ing them
into the injected EPT violation corrupts the GVA_IS_VALID/
GVA_TRANSLATED information.

Use the hardware_nested_page_fault flag introduced in the previous
patch to distinguish hardware EPT violation exits from
emulation-triggered faults. For hardware exits, take the
GVA_IS_VALID/GVA_TRANSLATED bits from the hardware exit qualification.
For emulation faults, take them from fault->exit_qualification, which
is populated by the nested_mmu walker in paging_tmpl.h.

Replace the #if PTTYPE != PTTYPE_EPT preprocessor guards in
paging_tmpl.h with a runtime kvm_nested_fault_is_ept() helper that
checks guest_mmu to determine whether the nested fault is EPT vs NPT,
and sets the appropriate field (exit_qualification for EPT, error_code
for NPF) accordingly.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 10 ++++++++++
 arch/x86/kvm/mmu/paging_tmpl.h | 22 +++++++++++++++-------
 arch/x86/kvm/vmx/nested.c      |  9 +++++----
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3dce38ffee76..aabf4ac39c43 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5272,6 +5272,9 @@ static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 	return false;
 }
 
+static bool kvm_nested_fault_is_ept(struct kvm_vcpu *vcpu,
+				    struct x86_exception *exception);
+
 #define PTTYPE_EPT 18 /* arbitrary */
 #define PTTYPE PTTYPE_EPT
 #include "paging_tmpl.h"
@@ -5285,6 +5288,13 @@ static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 #include "paging_tmpl.h"
 #undef PTTYPE
 
+static bool kvm_nested_fault_is_ept(struct kvm_vcpu *vcpu,
+				    struct x86_exception *exception)
+{
+	WARN_ON_ONCE(!exception->nested_page_fault);
+	return vcpu->arch.guest_mmu.page_fault == ept_page_fault;
+}
+
 static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 				    u64 pa_bits_rsvd, int level, bool nx,
 				    bool gbpages, bool pse, bool amd)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ea2b7569f8a4..15be93d735ab 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -386,9 +386,15 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 					     nested_access, &walker->fault);
 
 		if (unlikely(real_gpa == INVALID_GPA)) {
-#if PTTYPE != PTTYPE_EPT
-			walker->fault.error_code |= PFERR_GUEST_PAGE_MASK;
-#endif
+			/*
+			 * Set EPT Violation flags even if the fault is an
+			 * EPT Misconfig, fault.exit_qualification is ignored
+			 * for EPT Misconfigs.
+			 */
+			if (kvm_nested_fault_is_ept(vcpu, &walker->fault))
+				walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
+			else
+				walker->fault.error_code |= PFERR_GUEST_PAGE_MASK;
 			return 0;
 		}
 
@@ -447,9 +453,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
 	if (real_gpa == INVALID_GPA) {
-#if PTTYPE != PTTYPE_EPT
-		walker->fault.error_code |= PFERR_GUEST_FINAL_MASK;
-#endif
+		if (kvm_nested_fault_is_ept(vcpu, &walker->fault))
+			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID |
+							    EPT_VIOLATION_GVA_TRANSLATED;
+		else
+			walker->fault.error_code |= PFERR_GUEST_FINAL_MASK;
 		return 0;
 	}
 
@@ -496,7 +504,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * [2:0] - Derive from the access bits. The exit_qualification might be
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
-	 * [7:8] - Derived from [7:8] of real exit_qualification
+	 * [7:8] - Set at the kvm_translate_gpa() call sites above
 	 *
 	 * The other bits are set to 0.
 	 */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 937aeb474af7..39f8504f5cf2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -443,11 +443,12 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
-			exit_qualification = fault->exit_qualification;
-			exit_qualification |= vmx_get_exit_qual(vcpu) &
-					      (EPT_VIOLATION_GVA_IS_VALID |
-					       EPT_VIOLATION_GVA_TRANSLATED);
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
+			exit_qualification = fault->exit_qualification;
+			if (fault->hardware_nested_page_fault)
+				exit_qualification |= vmx_get_exit_qual(vcpu) &
+						      (EPT_VIOLATION_GVA_IS_VALID |
+						       EPT_VIOLATION_GVA_TRANSLATED);
 		}
 
 		/*
-- 
2.53.0.851.ga537e3e6e9-goog

