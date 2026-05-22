Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D67395ADF
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492429; cv=none; b=dWpIepQ7Q/njd44KbSXnzvEJz7K9JTtA4Txb+oALYmOPGTQKDCh+1+puS+YzoScFGPL9nMw8zM2cSfT1aAnFMnmQpl21FJ8rxiYJIk0SSMmKodaaSvhJDIlRJtV1rnelhRLKf2C0Z2Zyu9pz8BUXKQ8rvLZqZaINTr+ujyUE72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492429; c=relaxed/simple;
	bh=z2xNgW/14j2NPgBa0TWtlx4lBFbt/884PL7gTByiVMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=amDIHKqrnSc1HBt8Evjt+KTGGaUlmXJcxEUdkc7oYqG/q20Cd65z3pWVJ4aU90JzlkJfgLTXpR2fGZI/lPlMwUVx/SYDUZSTsLxWCnALt5lRc1Gg5yKk8tJxyDRaP6mxcOP/5FeGgvKcQJdbrJt3lwy4Rw9tZunhY9Pi/EEk8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2D0aXU6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2D0aXU6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so79716765ad.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779492427; x=1780097227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i8QjonP9W9SfQQUkeH+34C1UPlAz2jzujqbXDGUfkTA=;
        b=X2D0aXU6dog99pevYD7smMphIR1YUugLnfmCh6u3+1yTgAbYcnPCR7sZE+kmF/2krP
         vxaa10qJuXYIaSCHBSZnv3dDebqMtoJuWiCvXmZ6GDDxo0tIhW2OMlplAP9tpPyiiyag
         fhiEy2hp3tI1b8he+G5BOmW597vIeBJaYl4vLf6Ap2IkrsuZ9KakOohr+SWYF7OMqs7D
         BOljwB29KE0TP2gJ1w0CLSBU4k8dpZCIvgy4ldF+5yi0f6gCtfZ/8zyZc/28J+P/h7fZ
         Pe4LDG2+Tbr+kleEn45KUgeUZsyELC/TVw3q1Mfz3QCRDuP3OCemAmuYlaTBPQls7Uyl
         718g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492427; x=1780097227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8QjonP9W9SfQQUkeH+34C1UPlAz2jzujqbXDGUfkTA=;
        b=i18jGMpdxOKyteeKTnqNUR5v/ZB8Pr5YKsCecmc+TcSWibP8x0/CyvNXvSVLMENILr
         L6MJuD9H3EmKgufC/GBLKW9Ch/69KqdTH8AbUlfA5qXzBb0fP2dSwo1eWGORjwhCJd9X
         +2oGOca5Hc0aUqpjC7wg74NuMlPboAqoZ4i6f/zPRp+qkkHbTgRRun8Sgeo3fzxHV9YR
         YLo0w1Br4NvnT6VHz/ggFDpYC0aJ5mEfBmDEAFyxHJ+NjWenZq9DUlu55F7bdHaw0GV5
         lrrelhDGjBZ4773HU0seDky21Q2bKkwn3X8gUdVd8scM+ZtnjD1cFczt548+vJ59eSbM
         bATQ==
X-Gm-Message-State: AOJu0YxRTBdAX5tenNEHxfdICYWNzjOhnljXzy5IdRnZks43583VRkdR
	5yxzkxlhgRKCnyFpiq5f4FwyabyM/dmG7fWUan8FZDYwQvbDpQp/uprYZXl9EpyplVTtCP2L5qb
	2/QNn6Q==
X-Received: from plpf11.prod.google.com ([2002:a17:903:3c4b:b0:2b0:51f0:272d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a27:b0:2b2:4b4e:e4d2
 with SMTP id d9443c01a7336-2beb0758412mr58825745ad.15.1779492426948; Fri, 22
 May 2026 16:27:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 16:27:00 -0700
In-Reply-To: <20260522232701.3671446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522232701.3671446-5-seanjc@google.com>
Subject: [PATCH v4 4/5] KVM: VMX: Synthesize nested EPT violation
 GVA_IS_VALID/GVA_TRANSLATED bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kevin Cheng <chengkev@google.com>

When injecting an EPT Violation into L2 in response to a fault detected
while emulating an L2 GVA access, synthesize the GVA_IS_VALID and
GVA_TRANSLATED bits using information provided by the walker, instead of
pulling the bits from vmcs02.EXIT_QUALIFICATION.  The information in
vmcs02.EXIT_QUALIFICATION is valid/correct if and only if the fault being
injected into L1 is the direct result of an EPT Violation VM-Exit from L2.

E.g. if KVM is emulating an I/O instruction and the memory operand's
translation through L1's EPT fails, using vmcs02.EXIT_QUALIFICATION is
wrong as the semantics for EXIT_QUALIFICATION would be for an I/O exit,
not an EPT Violation exit.

Opportunistically clean up the formatting for creating the mask of bits
to pull from vmcs02.EXIT_QUALIFICATION.

Signed-off-by: Kevin Cheng <chengkev@google.com>
[sean: use plumbed in @access bits, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 13 ++++++++++++-
 arch/x86/kvm/vmx/nested.c      | 26 +++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 66eee6914234..df3ae0c7ec2c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -502,7 +502,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * [2:0] - Derive from the access bits. The exit_qualification might be
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
-	 * [7:11] - Derived from [7:11] of real exit_qualification
+	 * [7:8] - Derived from "fault stage" access bits
+	 * [9:11] - Derived from [9:11] of real exit_qualification
 	 *
 	 * The other bits are set to 0.
 	 */
@@ -516,6 +517,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		else
 			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
 
+		/*
+		 * KVM doesn't emulate features that access GPAs directly, e.g.
+		 * Intel Processor Trace.  Assume the GVA is always valid; when
+		 * propagating faults from hardware, KVM will discard this info
+		 * and use the EXIT_QUALIFICATION bits from the VMCS.
+		 */
+		walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
+
 		/*
 		 * Accesses to guest paging structures are either "reads" or
 		 * "read+write" accesses, so consider them the latter if write_fault
@@ -523,6 +532,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 */
 		if (access & PFERR_GUEST_PAGE_MASK)
 			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
+		else
+			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;
 
 		/*
 		 * Note, pte_access holds the raw RWX bits from the EPTE, not
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3bb7eaa7b2a5..a78ce0080963 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -445,13 +445,29 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			exit_qualification = 0;
 		} else {
 			u64 mask = EPT_VIOLATION_GVA_IS_VALID |
-				EPT_VIOLATION_GVA_TRANSLATED;
+				   EPT_VIOLATION_GVA_TRANSLATED;
+
 			if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
 				mask |= EPT_VIOLATION_GVA_USER |
-					       EPT_VIOLATION_GVA_WRITABLE |
-					       EPT_VIOLATION_GVA_NX;
-			exit_qualification = fault->exit_qualification;
-			exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
+					EPT_VIOLATION_GVA_WRITABLE |
+					EPT_VIOLATION_GVA_NX;
+
+			exit_qualification = fault->exit_qualification & ~mask;
+
+			/*
+			 * Use the EXIT_QUALIFICATION from the VMCS if and only
+			 * if the hardware VM-Exit from L2 was an EPT Violation.
+			 * If the fault is synthesized, then EXIT_QUALIFICATION
+			 * is stale and/or holds entirely different data.  And
+			 * conversely, KVM _must_ rely on EXIT_QUALIFICATION if
+			 * the fault came from hardware, because KVM only sees
+			 * and walks the faulting GPA.
+			 */
+			if (from_hardware)
+				exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
+			else
+				exit_qualification |= fault->exit_qualification & mask;
+
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 		}
 
-- 
2.54.0.794.g4f17f83d09-goog

