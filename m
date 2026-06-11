Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA33A1E81;
	Thu, 11 Jun 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181364; cv=none; b=kaAp1GX9ZVJwiEQ4DKhz/TqgBJqM6oemQ9a56YsaOuHZx3OgGGowaJ41vDWJaWE0Ach2yqgcd4oNPuoXPr8kBiykhLUZMeaEOmBNNAt9G7iTneXHgJ19jF7VrezVXuuZSYE5l3mm0Dgsc7pMr++ctXums2RSfqlbinFGxmuvwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181364; c=relaxed/simple;
	bh=4FNlbdHpo0sikhvwvLnMuXfhy8tdottaEyu/sZaQcWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/UDYl4vTerlXct2wDkMwUNolCwq/nbvhyaMovyaMaddMjiebZLb9+oGVDRrLDQR88OuCR3HdK4K59qfUWqGPeHRLi283Rtn16wTloGMWsAicIWWET+0uwGn3TNGlbmNbiFeIpmHTHf3DtIw6eQ1BhfiClfEegQj6prSxfuuwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D047B1C0EDF;
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
Subject: [PATCH 3/4] kvm: svm: Support guest-provided VMSA for launching
Date: Thu, 11 Jun 2026 14:35:27 +0200
Message-ID: <20260611123528.572255-4-joro@8bytes.org>
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

Introduce a way to provide a guest GPA as the initial BSP VMSA and
avoid allocating KVM-managed VMSAs in this case. Only one
guest-provided VMSA is supported at the moment as IGVM also only
supports to set a single VMSA.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 62 ++++++++++++++++++++++++++++++------------
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 350bb97c32c0..88db83b3ff8e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -726,6 +726,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 
 	INIT_LIST_HEAD(&sev->regions_list);
 	INIT_LIST_HEAD(&sev->mirror_vms);
+	sev->initial_vmsa_gpa = INVALID_PAGE;
 	sev->need_init = false;
 
 	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
@@ -2680,6 +2681,46 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return 0;
 }
 
+static int snp_init_guest_vmsa(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
+{
+	/* Only one initial guest VMSA can exist (per IGVM) - so it belongs to the BSP */
+	if (vcpu->vcpu_idx != 0)
+		return 0;
+
+	/* VMSA already private and encrypted via LAUNCH_UPDATE */
+	sev_es_set_guest_vmsa(vcpu, vmsa_gpa);
+
+	return 0;
+}
+
+static int snp_init_kvm_vmsa(struct kvm_vcpu *vcpu,
+			     struct sev_data_snp_launch_update *data,
+			     struct kvm_sev_cmd *argp)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	int ret;
+	void *vmsa;
+
+	ret = sev_es_sync_vmsa(svm);
+	if (ret)
+		return ret;
+
+	vmsa = sev_es_vmsa_ref(vcpu);
+
+	ret = sev_es_vcpu_vmsa_make_private(vcpu);
+	if (ret)
+		return ret;
+
+	/* Issue the SNP command to encrypt the VMSA */
+	data->address = __sme_pa(vmsa);
+	ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
+			      data, &argp->error);
+	if (ret)
+		sev_snp_vcpu_reclaim_vmsa(vcpu);
+
+	return ret;
+}
+
 static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
@@ -2700,28 +2741,13 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct vcpu_svm *svm = to_svm(vcpu);
-		void *vmsa;
 
-		ret = sev_es_sync_vmsa(svm);
+		ret = VALID_PAGE(sev->initial_vmsa_gpa) ?
+			snp_init_guest_vmsa(vcpu, sev->initial_vmsa_gpa) :
+			snp_init_kvm_vmsa(vcpu, &data, argp);
 		if (ret)
 			goto out;
 
-		vmsa = sev_es_vmsa_ref(vcpu);
-
-		ret = sev_es_vcpu_vmsa_make_private(vcpu);
-		if (ret)
-			goto out;
-
-		/* Issue the SNP command to encrypt the VMSA */
-		data.address = __sme_pa(vmsa);
-		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
-				      &data, &argp->error);
-		if (ret) {
-			sev_snp_vcpu_reclaim_vmsa(vcpu);
-
-			goto out;
-		}
-
 		svm->vcpu.arch.guest_state_protected = true;
 
 		/* VMSA encrypted - put it into the VMCB */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 3d4799f09b23..cc7e84c230bb 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -117,6 +117,7 @@ struct kvm_sev_info {
 	struct mutex guest_req_mutex; /* Must acquire before using bounce buffers */
 	cpumask_var_t have_run_cpus; /* CPUs that have done VMRUN for this VM. */
 	bool snp_certs_enabled;	/* SNP certificate-fetching support. */
+	gpa_t initial_vmsa_gpa; /* Optinal GPA of BSP VMSA - SEV-SNP only */
 };
 #endif
 
-- 
2.53.0

