Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A12882C5;
	Tue, 16 Jun 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570545; cv=none; b=eUDjIvIF+LIWYMQNtQuy5sKhgx3ZfapsFqHLv7vRiOy8jBeOAs+aFZVY5R/Nzu1zjk46EQtb4yBUbR5Yz4LpsOoX1CBXiWJ4CME2NAFjX9R+nCw66nUQKzOaHhmUJ8/ubKX52tX1DNvpN4yjIoYsvhuVEUjHdN9b2uiWtRGlN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570545; c=relaxed/simple;
	bh=qc9dtHkj5H77M6oTGkD3Ek/WhAskBu5VCED0+Z+SdhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMgO1Amj7ts7TqjwDHuPtSyoklgPKXJffBkvX2TlHCeEEp6WSKjCELU7/nEyin4HWIt+yD9CDj9EZGFqUTE2s2NNqGyxxreBYkQfSbZydCbFUtVKotFYY4Sw8JDAdQ8AGWdaxVE09qhIlJo5kj5q0Gd5UzfMiogZEORbcHMUSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKcgsDfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKcgsDfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F01F000E9;
	Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570544;
	bh=Gex4Ml1PwVgTt0nBP/NTTdw2bPEzPu1kB+qhKr0esUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKcgsDfgXSvaKmZs23vJfX+522LNPm6H4Utnbnutlgr4G3mx3uz/cO/F8hev7lCXv
	 l+sXjamaYh9DtoVRyTQKKZBii/bR8QuoI6SyhfeAwWkr+3EHi9FPQjKRgsfNpeBJUK
	 ZTl4n50wN428sWCNWYO+cFH7+Y4nA79OGc5kexlkV5NboDdG6zlYqM1kGxuY74nsrC
	 tnDIeZRY3emTb1y61zCh5Tyoh3giehafCoPdPV0jQ8onVSge/RGBt9amC9fUhatM2J
	 ovjG1pjspfWHNy4DGfBEcdNwo9a36WpjqOYFaZHiD0qph75Mayi6sor79qqi9jOchG
	 f0/8ZEppSfnEw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 05/25] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
Date: Tue, 16 Jun 2026 00:41:34 +0000
Message-ID: <20260616004155.1435766-6-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce set/clear helpers to set tlb_ctl to
TLB_CONTROL_FLUSH_ASID or TLB_CONTROL_DO_NOTHING. Incoming changes will
eliminate the use of TLB_CONTROL_FLUSH_ALL_ASID except as a fallback
when FLUSHBYASID is not available, so the helpers will create a common
path for this.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  2 +-
 arch/x86/kvm/svm/sev.c    |  2 +-
 arch/x86/kvm/svm/svm.c    |  4 ++--
 arch/x86/kvm/svm/svm.h    | 10 ++++++++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c85aa5cf670f4..f891299d278a0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -928,7 +928,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
-	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	vmcb_clr_flush_asid(vmcb02);
 
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83f..026b070522dac 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3569,7 +3569,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 		return 0;
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	vmcb_set_flush_asid(svm->vmcb);
 	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 526e0fdcd16be..a7cc3cb101e57 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4186,7 +4186,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
 	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+		vmcb_set_flush_asid(svm->vmcb);
 	else
 		svm->current_vmcb->asid_generation--;
 }
@@ -4599,7 +4599,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vcpu->arch.nested_run_pending = 0;
 	}
 
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	vmcb_clr_flush_asid(svm->vmcb);
 
 	/*
 	 * Unconditionally mask off the CLEAR_RAP bit, the AND is just as cheap
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba335..5b4613b4d7bc2 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -476,6 +476,16 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 	vmcb_mark_dirty(vmcb, VMCB_NPT);
 }
 
+static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
+{
+	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+}
+
+static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
+{
+	vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+}
+
 static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
-- 
2.54.0.1136.gdb2ca164c4-goog

