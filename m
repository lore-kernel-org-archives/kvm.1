Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1A22F388;
	Tue, 28 Jul 2026 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198968; cv=none; b=tY02aH74K3gTFHKuczCiIngTUaHO0qakj5JnuzvhnlgqZzRA6Q4FdtzAbjNHYVjTFEXnHw6FHYJn56y+AwG+qcMvPQzRm59Yp55Xjta9bkQsa4wsGTIgT75jeUqKwFeerEzlItzWqKWivQroQa2t+fKoNMZkiV4BRS35OQgHq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198968; c=relaxed/simple;
	bh=X+DmQd7D5va7G0hHHgXsOiJIUrhmhZvjxct/9QKfyK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhSVxXsNqQl6bc77bmthQOvGvQj38zAEIWsL5q4J5KnN4pJ7Drt0VelADavlBoXjmn5wJU7EV4yLZxkmrlp9ot/MfviZsZZM/SnICfjq6hVnNi3JXMAzy78F+FlYgLddWYG/no7T+XIClrp7qMHAJJvMfT2pVgYftX+eQr0GIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Wk0NkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Wk0NkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB571F00ACA;
	Tue, 28 Jul 2026 00:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198966;
	bh=h7jaYax/CIUFIfJutQBI5rm5o81rl9qGFc3zJCfbdKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q0Wk0NkEngvbpaq3htMMbYNnWQvOLgKXASXVW5IBND/jB5+IisDE/qqmaktKQOV/B
	 ooHUL7bJ/03e99ItgqNSB7TFt1u9OuMWgLvsWB9/UjLO0y7b9RkJk2J6McZTuc8q7R
	 vwstj+wSA3i2tBRiHWRee25HlJSo7MfpcMVxHing91UNIZPDYX7CAj+g8FwvGYOJ9d
	 xIVNFaCdu+O9wOF1E73Ezu11hoVouMRXVUja5kfTeg3MMK8/fRVkHIoWFOh2adti4L
	 dY50dn8M353KWGQlSHM4/S5azQuiM7MmdTthSuVZL7AsllG2CU3qrMla6llr5Kktui
	 tlC/S21jzn1hg==
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
Subject: [PATCH v1 05/28] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
Date: Tue, 28 Jul 2026 00:35:34 +0000
Message-ID: <20260728003557.1136583-6-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
index 75378feddb349..ef0326932c446 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -931,7 +931,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
-	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	vmcb_clr_flush_asid(vmcb02);
 
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 90a08d36d843d..d1f0e42c72b27 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3594,7 +3594,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 		return 0;
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	vmcb_set_flush_asid(svm->vmcb);
 	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d68cba12c772b..de90320a2e669 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4199,7 +4199,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
 	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+		vmcb_set_flush_asid(svm->vmcb);
 	else
 		svm->current_vmcb->asid_generation--;
 }
@@ -4612,7 +4612,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vcpu->arch.nested_run_pending = 0;
 	}
 
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	vmcb_clr_flush_asid(svm->vmcb);
 
 	/*
 	 * Unconditionally mask off the CLEAR_RAP bit, the AND is just as cheap
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a327bf751ecd5..e3cce839573d9 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -477,6 +477,16 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
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
2.55.0.229.g6434b31f56-goog

