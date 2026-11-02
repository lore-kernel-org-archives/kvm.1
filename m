Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619731;
	b=sqk1Wgv/yLCbL7XpJxW22W6mO7Ej2oNCfUyySm9jwR7vZDc6XrS5+j/hMLbBdAnubEkN
	 0EUts1yMP0GdvnuxxqWqtSOvJe0ndp7brBaprA2gal6QkEkaQr6mJcjXmb+6p/KGu/oSC
	 6g4gwqntX5Bdw2yj1Tpk7Nhfh1AnSlXN4tcp3l+oi8xGLvRQ6TaaZJJbaQYX4Hhpa7tfw
	 BZMC0lbqHyUvn3N7U7656KbWO0SeIKoXaql4xdNYcUILMEWqKDhjos1c6506z4QCMwMMO
	 DD66U5RC0RQFB6pM1EEJ8eTsHY91hkXNT7/lsBEe/dCH3JJZZKz0AZXMe9YTrbnRTHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619731;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XfqbgcmUIK+2Zk7EPOWKeSkE+vUNrYIyxGFj5yeMr7U=;
	b=IyR89s0s9zM57uWE5laYEWS4MFR4aJsU8glnro+oTcFE86gxr4TWi3NerdUYxh1EojTT
	 2p0CVylBZ4/QG2fBD4K3bRR+rUsa34BuQ5IfU3FELFWGSKCwj1uJINB3k7MXzrXHVfYMA
	 OmVolaXJDEl88TJ9iEX7vt3WZXPxe5dNIPeVvhsxSDEPIkE/j+wdJkdgd4wz7cz5ATXFM
	 fssfhrw+aRkEqzMPhFkSc6gtGFeTabpxPbM4UF8qx+xbzdq+VLzVmhTt8vanPSLb51vDX
	 PnzMGmPPQhmuhGMGSSfhPlb1qBE/3nqWpvy2Z+cKDsurcMZa4cAB3hAoZ9wOvKHvl7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC6606A333;
	Mon,  2 Nov 2026 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FC6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 357BE243AD2;
	Mon,  2 Nov 2026 12:42:04 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joro@8bytes.org
Subject: [PATCH v3 2/8] KVM: SVM: Implement GET_AP_APIC_IDS NAE event
Date: Mon,  2 Nov 2026 12:41:31 +0100
Message-ID: <20261102114137.1198982-3-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102114137.1198982-1-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Advertise and handle the GHCB APIC ID list feature so that SNP guests can
discover the vCPUs for which they need to create VMSAs without relying on
INIT-SIPI.

Return the required page count for undersized buffers.  For sufficiently
large requests, validate the GPA range and use KVM's SRCU-protected guest
write path to copy an exact snapshot of the online vCPU APIC IDs.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/uapi/asm/svm.h   |  1 +
 arch/x86/kvm/svm/sev.c            | 67 ++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 01a6e4dbe423..c041f85dfd5c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -136,6 +136,7 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
+#define GHCB_HV_FT_APIC_ID_LIST		BIT_ULL(4)
 #define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
 
 /*
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index e80676185092..c9c85891971a 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -118,6 +118,7 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_GET_APIC_IDS		0x80000017ull
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018ull
 #define SVM_VMGEXIT_SAVIC			0x8000001aull
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b90c5f14c1ac..f690edaf8b69 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -40,7 +40,9 @@
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
 
-#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATION)
+#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | \
+				 GHCB_HV_FT_SNP_AP_CREATION | \
+				 GHCB_HV_FT_APIC_ID_LIST)
 
 /*
  * The GHCB spec essentially states that all non-zero error codes other than
@@ -3517,7 +3519,8 @@ static bool sev_es_are_required_ghcb_fields_valid(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_AP_CREATION:
 		return kvm_ghcb_rax_is_valid(svm) ||
 		       lower_32_bits(control->exit_info_1) == SVM_VMGEXIT_AP_DESTROY;
-		break;
+	case SVM_VMGEXIT_GET_APIC_IDS:
+		return kvm_ghcb_rax_is_valid(svm);
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE:
 	case SVM_VMGEXIT_PSC:
@@ -4235,6 +4238,63 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 	return 0;
 }
 
+struct sev_apic_id_desc {
+	u32 num_entries;
+	u32 apic_ids[];
+};
+
+static int sev_snp_get_apic_ids(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
+	struct sev_apic_id_desc *desc;
+	unsigned int nr_vcpus, size;
+	unsigned int i;
+	gpa_t gpa, end_gpa;
+	u64 pages;
+
+	nr_vcpus = atomic_read(&kvm->online_vcpus);
+	size = sizeof(*desc) + (nr_vcpus * sizeof(desc->apic_ids[0]));
+
+	pages = vcpu->arch.regs[VCPU_REGS_RAX];
+	if (pages < PFN_UP(size)) {
+		vcpu->arch.regs[VCPU_REGS_RAX] = PFN_UP(size);
+		return 1;
+	}
+
+	gpa = svm->vmcb->control.exit_info_1;
+	if (!PAGE_ALIGNED(gpa) ||
+	    check_add_overflow(gpa, size - 1, &end_gpa) ||
+	    !page_address_valid(vcpu, gpa) ||
+	    !page_address_valid(vcpu, end_gpa & PAGE_MASK))
+		goto invalid_buffer;
+
+	desc = kvzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!desc)
+		return -ENOMEM;
+
+	desc->num_entries = nr_vcpus;
+	for (i = 0; i < nr_vcpus; i++) {
+		struct kvm_vcpu *listed_vcpu = kvm_get_vcpu(kvm, i);
+
+		if (WARN_ON_ONCE(!listed_vcpu))
+			goto invalid_buffer_free;
+		desc->apic_ids[i] = listed_vcpu->vcpu_id;
+	}
+
+	if (kvm_write_guest(kvm, gpa, desc, size))
+		goto invalid_buffer_free;
+
+	kvfree(desc);
+	return 1;
+
+invalid_buffer_free:
+	kvfree(desc);
+invalid_buffer:
+	svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+	return 1;
+}
+
 static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
 {
 	struct sev_data_snp_guest_request data = {0};
@@ -4539,6 +4599,7 @@ static bool is_snp_only_vmgexit(u64 exit_code)
 {
 	switch (exit_code) {
 	case SVM_VMGEXIT_AP_CREATION:
+	case SVM_VMGEXIT_GET_APIC_IDS:
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 	case SVM_VMGEXIT_PSC:
@@ -4710,6 +4771,8 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (sev_snp_ap_creation(svm))
 			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
 		return 1;
+	case SVM_VMGEXIT_GET_APIC_IDS:
+		return sev_snp_get_apic_ids(svm);
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 		if (!PAGE_ALIGNED(control->exit_info_1) ||
-- 
2.53.0

