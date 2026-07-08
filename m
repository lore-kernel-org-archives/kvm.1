Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517D3E5EF5;
	Wed,  8 Jul 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492545; cv=none; b=fAXuv/njMIgKYAEut0tD51Td25O+lJWdi+pgQb7zy184SVtWViakblMQpuE3EG2xzDkBafnVfvbvzAQxOQYwl7HNYITdra6CG7IC4g6JFXoZlPAxWxuy1WqECcX+yoH2wWAzx2YCKHPRRyU5WxWDo+WA8NPq0tzBWL/FBFqTyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492545; c=relaxed/simple;
	bh=5DB7fm4qpVWvQuwPb2C/UTVsfRWy7o6pW4bY/w0JMvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0BfFkbmjhOSzxTPnHiea59blV8EFjo2BUeZx18poC/DLs5sfCqoJRFZ3CovfcspVQFPOqELIDneUWprAM2Ap3LLMzEDzl9J+XZb7dKaU/Hy0cMYpdbAXYLl5/gRw47CjYHOgCVFA3kOsjPGpaxj7pvSdbXb6o/1eKbIKmO2Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Mr6iYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Mr6iYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7911F00A3A;
	Wed,  8 Jul 2026 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492542;
	bh=Ytwr97rYs3nDuZ+tcDcZzArQgkLlVk+H6Mb1Asb+WbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5Mr6iYkEDh35jh79NtGqrj+Xxt+IRs8VIuer+eE3QoTmTXzYCisct+ksJEWdUmD5
	 gZI+N40jOw9SgCuFn48yWy84a/pJhupcsVwTbR8TNbq3yqH3XfMmer7yjDEXlP8t/e
	 rg2qkA07rTwu0AyUYzFaof9W5tTRgxLWxtTgWKwZK3VhEigEmQ8PrefvyWuG79ho5A
	 zXLT5e4P70v4wUJH8INiDxmkDhoa9nHn0hC+gVl3VTih0oBX/YzTWsM1hHYNmrJgQ7
	 pNXs3sraIq+LEFSCeOpAndQ45DpJ898Ko/rDaJGoC+udWQPm5lrZQNQbBsrrsBN/nC
	 Isa2elmzVJuBQ==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 23/27] KVM: SVM: Add support for injecting NMIs for Secure AVIC guests
Date: Wed,  8 Jul 2026 12:02:21 +0530
Message-ID: <5b5b40831e8d823e08dfe73b3e07eef3d82ed76f.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secure AVIC relies on NMI virtualization for injecting NMIs into the
guest. Similar to V_GIF, set V_NMI_ENABLE_MASK in the BSP's VMSA as this
is consulted by hardware instead of the corresponding VMCB field.

Since EVENTINJ is not supported for Secure AVIC enabled guests, KVM can
accept/pend at most 1 NMI at any point. Use this as the limit in
process_nmi(). Add a WARN_ON() in svm_inject_nmi() since we should never
hit this path. Always return 1 for nmi_allowed() since KVM can pend an
NMI at any point and does not have visibility into the guest NMI
blocking status.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 arch/x86/kvm/svm/svm.c | 8 ++++++++
 arch/x86/kvm/x86.c     | 8 +++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 06555dbec45b..707537ad7271 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1034,7 +1034,7 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 
 	/* Secure AVIC loads the below from the VMSA, rather than the VMCB */
 	if (snp_is_secure_avic_enabled(vcpu->kvm))
-		save->vintr_ctrl |= V_GIF_MASK;
+		save->vintr_ctrl |= V_GIF_MASK | V_NMI_ENABLE_MASK;
 
 	/*
 	 * Skip FPU and AVX setup with KVM_SEV_ES_INIT to avoid
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 63ee36501383..2cb38953c0cf 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3768,6 +3768,10 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/* We should never reach here for Secure AVIC - see svm_set_vnmi_pending() */
+	if (WARN_ON_ONCE(snp_is_secure_avic_enabled(vcpu->kvm)))
+		return;
+
 	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
 
 	if (svm->nmi_l1_to_l2)
@@ -4018,6 +4022,10 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
+	/* Assume it is always allowed for Secure AVIC (hardware gates delivery) */
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		return 1;
+
 	if (svm_nmi_blocked(vcpu))
 		return 0;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2609a2972526..7f5978cac5f5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7742,8 +7742,14 @@ static void process_nmi(struct kvm_vcpu *vcpu)
 	 * waiting for a previous NMI injection to complete (which effectively
 	 * blocks NMIs).  KVM will immediately inject one of the two NMIs, and
 	 * will request an NMI window to handle the second NMI.
+	 *
+	 * For protected APIC guests, NMI window isn't visible to KVM, so the
+	 * only thing KVM can do is to collapse all pending NMIs and inject a
+	 * single NMI. The guest is expected to scan all NMI sources as part
+	 * of handling the NMI.
 	 */
-	if (kvm_x86_call(get_nmi_mask)(vcpu) || vcpu->arch.nmi_injected)
+	if (kvm_x86_call(get_nmi_mask)(vcpu) || vcpu->arch.nmi_injected ||
+	    (lapic_in_kernel(vcpu) && vcpu->arch.apic->guest_apic_protected))
 		limit = 1;
 	else
 		limit = 2;
-- 
2.54.0

