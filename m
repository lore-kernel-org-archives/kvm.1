Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA43F787C;
	Thu, 11 Jun 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181363; cv=none; b=DRQx3s2OEgh66msnkPqVYSjumQHbEU4hGrZjYuwWXJLut+nSVbH0GBaeU7lTKDho6VJ3EwzXfIYhW1PTE5H5wvoaAucYx2+f4nwILT8HoA0tWQsl4ZWnaUODJcq1F2rYuxSEM2/aJc6aoTdE32rUEfMeUdnnAvtz6tCB1gskCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181363; c=relaxed/simple;
	bh=IbJn5HbW4xnXmoCqMJpY98KqkXZpeYSX3D4X1pk+WBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2ER6r3SV41LR3ABF+9sOlG/jMEyCCDFKqeLDD5WFGmGy8hrvwztYNgq7z95jlI3Mdsb+GQec2ib5UwFjZa1TeP09swRcsEB4UkqVDtZusXGH35g+6tywJl9lYhG3PIg/pog8oryMV0KS48Diz8HH5BlJVuaeCAPv5es1MHiuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E9D5C1C0EE0;
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
Subject: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
Date: Thu, 11 Jun 2026 14:35:28 +0200
Message-ID: <20260611123528.572255-5-joro@8bytes.org>
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

Support setting a VMSA in guest physical memory during the SEV-SNP
launch process. Only one VMSA can be provided which will then be used
for the BSP. All of the APs will not have a VMSA allocated or assigned
when this feature is used.

This ensures stable launch measurements on SEV-SNP which are
independent of the number of VCPUs the VM is launched with.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/svm/sev.c          | 44 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c              |  1 +
 include/uapi/linux/kvm.h        |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 5f2b30d0405c..fc87a5ba295b 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -885,6 +885,7 @@ struct kvm_sev_snp_launch_start {
 /* Kept in sync with firmware values for simplicity. */
 #define KVM_SEV_PAGE_TYPE_INVALID		0x0
 #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
+#define KVM_SEV_SNP_PAGE_TYPE_VMSA		0x2
 #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
 #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
 #define KVM_SEV_SNP_PAGE_TYPE_SECRETS		0x5
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 88db83b3ff8e..90399d5d0358 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2520,6 +2520,20 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return rc;
 }
 
+static bool snp_check_launch_vmsa(struct kvm_sev_info *sev,
+				  struct sev_es_save_area *vmsa)
+{
+	/* VMSA sev_features must match VMs vmsa_features */
+	if (vmsa->sev_features != sev->vmsa_features)
+		return false;
+
+	/* Must always boot from VMPL0 */
+	if (vmsa->vmpl != 0)
+		return false;
+
+	return true;
+}
+
 struct sev_gmem_populate_args {
 	__u8 type;
 	int sev_fd;
@@ -2532,7 +2546,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	struct sev_gmem_populate_args *sev_populate_args = opaque;
 	struct sev_data_snp_launch_update fw_args = {0};
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
+	gpa_t gpa = gfn << PAGE_SHIFT;
 	bool assigned = false;
+	u64 sev_features = 0;
 	int level;
 	int ret;
 
@@ -2550,14 +2566,27 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (src_page) {
 		void *src_vaddr = kmap_local_page(src_page);
 		void *dst_vaddr = kmap_local_pfn(pfn);
+		struct sev_es_save_area *vmsa = dst_vaddr;
+		bool accept_page = true;
 
 		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
 
+		if (sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_VMSA) {
+			accept_page = snp_check_launch_vmsa(sev, vmsa);
+			if (accept_page)
+				sev_features = vmsa->sev_features;
+		}
+
 		kunmap_local(src_vaddr);
 		kunmap_local(dst_vaddr);
+
+		if (!accept_page) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
-	ret = rmp_make_private(pfn, gfn << PAGE_SHIFT, PG_LEVEL_4K,
+	ret = rmp_make_private(pfn, gpa, PG_LEVEL_4K,
 			       sev_get_asid(kvm), true);
 	if (ret)
 		goto out;
@@ -2593,6 +2622,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 		kunmap_local(dst_vaddr);
 	}
 
+	if (ret == 0 && sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_VMSA)
+		sev->initial_vmsa_gpa = gpa;
+
 out:
 	if (ret)
 		pr_debug("%s: error updating GFN %llx, return code %d (fw_error %d)\n",
@@ -2620,12 +2652,22 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	if (!params.len || !PAGE_ALIGNED(params.len) || params.flags ||
 	    (params.type != KVM_SEV_SNP_PAGE_TYPE_NORMAL &&
+	     params.type != KVM_SEV_SNP_PAGE_TYPE_VMSA &&
 	     params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO &&
 	     params.type != KVM_SEV_SNP_PAGE_TYPE_UNMEASURED &&
 	     params.type != KVM_SEV_SNP_PAGE_TYPE_SECRETS &&
 	     params.type != KVM_SEV_SNP_PAGE_TYPE_CPUID))
 		return -EINVAL;
 
+	if (params.type == KVM_SEV_SNP_PAGE_TYPE_VMSA) {
+		/* VMSA page are allowed only once */
+		if (sev->initial_vmsa_gpa != INVALID_PAGE)
+			return -EBUSY;
+		/* Can only deploy a single page as VMSA */
+		if (params.len != PAGE_SIZE)
+			return -EINVAL;
+	}
+
 	src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_user_ptr(params.uaddr);
 
 	if (!PAGE_ALIGNED(src))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798..dc9abe62476e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4870,6 +4870,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
 	case KVM_CAP_ONE_REG:
+	case KVM_CAP_SNP_DIRECT_VMSA:
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..bf034435f98c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -996,6 +996,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_SNP_DIRECT_VMSA 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.53.0

