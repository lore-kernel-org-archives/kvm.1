Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E813F6C4C;
	Thu, 11 Jun 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181363; cv=none; b=sLtUI0Ij4L6rQ2mc0WqBYcv6vatQ4ZsRnqQn5eRDvHVxP13tsVq+75D67kdHr8P9j01DEOM/e8WnFC7Rxm1VSjZO/NwfJrHvJGrLe+20fGT3E+9GMekWDbpzzM92IasqycNOg5bGXZ98JPyYwcay8vF5q92gQwSxO1M6VT/nQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181363; c=relaxed/simple;
	bh=UZDTy2pSdJGcAOutuoi2oLJz4CCybpjRVTOdadb0mJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvFsyptH4cZtBRxXxPI3nELkCEpqHX75d2LoyBKrckYY204hG9UJqFsZ/22TCOt+PlRrwMfkLqCy00THdrvzDUtOpJgBBcBWl/MT1dAFvyHOEqwMwwBZ/acnuNC6Apq2tsvfdqV3mfYo+vDm/j9kKOFsDqD2+7devpYyWBgCpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B58481C0EDB;
	Thu, 11 Jun 2026 14:36:00 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 2/4] kvm: svm: Defer VMSA allocation to LAUNCH_FINISH stage
Date: Thu, 11 Jun 2026 14:35:26 +0200
Message-ID: <20260611123528.572255-3-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611123528.572255-1-joro@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Do not allocate a KVM-managed VMSA for all VCPUs on VCPU creation,
defer it to the LAUNCH_FINISH stage of SEV-ES and SEV-SNP. At this
stage the VMSAs get used for the first time.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9b1280222e20..350bb97c32c0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1095,11 +1095,11 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
-	struct sev_es_save_area *save = sev_es_vmsa_ref(vcpu);
+	struct sev_es_save_area *save;
 	struct xregs_state *xsave;
 	const u8 *s;
+	int ret, i;
 	u8 *d;
-	int i;
 
 	lockdep_assert_held(&vcpu->mutex);
 
@@ -1110,6 +1110,12 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
 
+	ret = sev_es_vcpu_alloc_vmsa(vcpu);
+	if (ret)
+		return ret;
+
+	save = sev_es_vmsa_ref(vcpu);
+
 	/*
 	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
 	 * the traditional VMSA that is part of the VMCB. Copy the
@@ -1196,7 +1202,7 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 {
 	struct sev_data_launch_update_vmsa vmsa;
 	struct vcpu_svm *svm = to_svm(vcpu);
-	void *vmsa_ref = sev_es_vmsa_ref(vcpu);
+	void *vmsa_ref;
 	int ret;
 
 	if (vcpu->guest_debug) {
@@ -1209,6 +1215,8 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 	if (ret)
 		return ret;
 
+	vmsa_ref = sev_es_vmsa_ref(vcpu);
+
 	/*
 	 * The LAUNCH_UPDATE_VMSA command will perform in-place encryption of
 	 * the VMSA memory content (i.e it will write the same memory region
@@ -1237,6 +1245,9 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 	fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	vcpu->arch.guest_state_protected = true;
 
+	/* VMSA encrypted - put it into the VMCB */
+	svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(vcpu);
+
 	/*
 	 * SEV-ES guest mandates LBR Virtualization to be _always_ ON. Enable it
 	 * only after setting guest_state_protected because KVM_SET_MSRS allows
@@ -2689,12 +2700,14 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct vcpu_svm *svm = to_svm(vcpu);
-		void *vmsa = sev_es_vmsa_ref(vcpu);
+		void *vmsa;
 
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
 			goto out;
 
+		vmsa = sev_es_vmsa_ref(vcpu);
+
 		ret = sev_es_vcpu_vmsa_make_private(vcpu);
 		if (ret)
 			goto out;
@@ -2710,6 +2723,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		}
 
 		svm->vcpu.arch.guest_state_protected = true;
+
+		/* VMSA encrypted - put it into the VMCB */
+		svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(vcpu);
+
 		/*
 		 * SEV-ES (and thus SNP) guest mandates LBR Virtualization to
 		 * be _always_ ON. Enable it only after setting
@@ -4914,22 +4931,11 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 int sev_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	int ret;
 
 	mutex_init(&svm->sev_es.snp_vmsa_mutex);
 
-	if (!is_sev_es_guest(vcpu))
-		return 0;
-
-	/*
-	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
-	 * contain the encrypted register state of the guest.
-	 */
-	ret = sev_es_vcpu_alloc_vmsa(vcpu);
-	if (ret)
-		return ret;
-
-	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
+	if (is_sev_es_guest(vcpu))
+		vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
 
 	return 0;
 }
-- 
2.53.0

