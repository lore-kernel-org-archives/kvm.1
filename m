Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497350B8A1
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797015; cv=none; b=gudqAZv07jVV6pM3GFLFvl+onJ5VpzwGqGbGJ/PKR5bKME4gotYbk0po2cgKbEgxqyFHfe8mKaaBoNF4+puiLodHN1fb5S5BMzViIhicaSBQcwK4BSMpj45VKlmlNnHni3L2b1n1G7AFz+iS4StjsGw7YQl7/UV3b3SuOmrSlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797015; c=relaxed/simple;
	bh=9/5VYKp+FpTlacyCJ0B7NN+WKgSUpEps0uP+5xXDmOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WxRBhGGVRdiThm+WPvBMoxTwhZ783vcZzsGkMqMKWpcxtCK7cLE8pGsQz5kD8S/YCIwum0XeYpW2WC5jMvXgjtsgpGasJFfvq+RiEx40HngiH5ruwNmQg4ynTVrSMHTEFEZ+/Edv2Cv49TZqUSjvV+9t8uPvF+A5Np8LEd7rF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3hA6kg+; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3hA6kg+"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so54423465ad.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797013; x=1791401813; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wtnEMbDhnNePMM9FVDMKnptaMxqEpAp14r/XB4S9VOI=;
        b=P3hA6kg+uz9qmQMrAddosrgvb1+pBzlVQXfiY+12vTMLEitMf0FRpGLseUBUjadcFU
         vPuvYyKMDAlJU4MLxhLrkM8pWJzocMwvgYHVLZk7cfuU+bZfT84TrTiTuVP+hRSLjgZ0
         rC5ycAy1ukn3EdUe0dXIt6FVLLc+i+RY61HBKQYwgEaNsmrPepQQdHBtMlS6mTDpZ5ao
         GgOKJegmD+6Pteaa/QtoetRBgYvLR2i1HIPPNiges0Oz0NN8VMa3kfx00ErDlkvXiE6q
         abcb52BipNCJFJxnVfC6xYPas8Gh0rduIQM+ACt3c5xm5XOvoRLwKme4zsburN2DmLem
         ylhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797013; x=1791401813;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wtnEMbDhnNePMM9FVDMKnptaMxqEpAp14r/XB4S9VOI=;
        b=cpBhCX2pnHEtjeSoVzijizEn+SlQ+8ro81zrP19R6uDbBr27XtbIqV+L46c6Io4TuX
         a7bggCf7dgtkB5RvOef3leRaW5jEIsl/w+Mk+r1ctgWqMkwwbZZ4gHeGyQ1FKyPCH2Su
         lO4fuRRrUTWXwtkQYwNdR+LQLt4TrVk8N9x+u86RtnJyEyaush6NBRhdQujpzIvc9clF
         h6jrRmwxLt7CgH+qHHK9V0rUvx3dgemI3M+qqPP6STx9OU093d8gZIreBqkPyrYzDqHK
         B8lBH+2qK/ZbxHRCV7Jge4qWpXqVmnTSMzQKn0Tw2oFO5L9o7z0LfzKDP/IRLarfkUzd
         oGeA==
X-Gm-Message-State: AFq9FYJliSgN5UIsi3uAfxWYyB2onVBzYDRfJQC5UJhklfrVQVKxqRDu
	STMtpouHAs++FQ6uDREBBPAtp93ZATquoyKr8IxL7nkpT5aZudl8vPrm4r0K91OTOAN9XyE2EC1
	aAcwPKA==
X-Received: from plbjh24.prod.google.com ([2002:a17:903:3298:b0:2e2:f334:4160])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e3:b0:2e2:e5b2:6451
 with SMTP id d9443c01a7336-2e2e5b26ad8mr21379495ad.36.1790797012040; Wed, 30
 Sep 2026 12:36:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:33 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-12-seanjc@google.com>
Subject: [PATCH v6 11/12] KVM: SVM: Add a vCPU-aware helper to get supported
 DEBUGCTL bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Replace DEBUGCTL_RESERVED_BITS with a vCPU-aware helper that provides the
set of supported bits so that KVM can handle bits that are conditionally
supported based on the vCPU model, e.g. for features like Bus Lock Detect.

No functional change intended.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
[sean: invert from reserved => supported, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 8 ++++----
 arch/x86/kvm/svm/svm.c    | 6 +++---
 arch/x86/kvm/svm/svm.h    | 7 +++++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c7a69e309a36..af0ef678433d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -818,7 +818,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		 * svm_set_msr's definition of reserved bits.
 		 */
 		svm_copy_lbrs(&vmcb02->save, save);
-		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		vmcb02->save.dbgctl &= svm_get_supported_debugctl(vcpu);
 	} else {
 		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
 	}
@@ -1207,7 +1207,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 }
 
 /* Copy state save area fields which are handled by VMRUN */
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save)
 {
 	to_save->es = from_save->es;
@@ -1234,7 +1234,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 
 	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
 		svm_copy_lbrs(to_save, from_save);
-		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		to_save->dbgctl &= svm_get_supported_debugctl(vcpu);
 	}
 }
 
@@ -2081,7 +2081,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5253c0143666..1e58ad8691e9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3210,7 +3210,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			data &= ~DEBUGCTLMSR_BTF;
 		}
 
-		if (data & DEBUGCTL_RESERVED_BITS)
+		if (data & ~svm_get_supported_debugctl(vcpu))
 			return 1;
 
 		if (svm->vmcb->save.dbgctl == data)
@@ -5164,7 +5164,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
 
-	svm_copy_vmrun_state(m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
+	svm_copy_vmrun_state(vcpu, m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
 	return 0;
 }
 
@@ -5204,7 +5204,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	 * used during SMM (see svm_enter_smm())
 	 */
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
 
 	/*
 	 * Enter the nested guest now
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ac6160d78e15..c3380d865b75 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -787,7 +787,10 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
+{
+	return DEBUGCTLMSR_LBR;
+}
 
 /* svm.c */
 extern bool dump_invalid_vmcb;
@@ -877,7 +880,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu);
 void svm_free_nested(struct vcpu_svm *svm);
 int svm_allocate_nested(struct vcpu_svm *svm);
 int nested_svm_vmrun(struct kvm_vcpu *vcpu);
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save);
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
 void nested_svm_vmexit(struct vcpu_svm *svm);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

