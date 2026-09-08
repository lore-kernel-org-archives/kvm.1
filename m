Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8D517BC2;
	Tue,  8 Sep 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863632; cv=none; b=khjrc9DvQcUGyYvrItloRGWbb4kwYGOhiYjuZGmnuQx7+cVJI6DNmWHdE/HFAHK3K2E/PNq8kaVK5IlH+xLDF9TYTohiDiUVp7poO9IVc3DR0qK56gIZ0suhqDaik0Vhs36OOAh5LuiuyhXOk7CNYiDuLtqL05ahgpT6IS+lsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863632; c=relaxed/simple;
	bh=+gRjbFmylSVU56vMnxxJFlqZrnKw8hb2gp0SsY1Ae7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pO+OhaDSxHCfktRDsjlzc5DT7sWS9u79onuACXj++Bo4S5gZ9u2urM80NjhMtEJ3GyajCASmfu0pLmF0hrAeLF1CD9pscqUmj2cUOqV8Hrdg48aJRkzoWHa2Bxswy4R4X1mkP2O/2dykLfjhwqgynEBxh25IBHMo070QcQSptIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af085a00d84fb33a51badfd9.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:d84f:b33a:51ba:dfd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CB5FB20A1E0;
	Tue,  8 Sep 2026 12:33:41 +0200 (CEST)
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
	coconut-svsm@lists.linux.dev
Subject: [PATCH v2 6/8] KVM: SEV: Add SNP vCPU state get and set commands
Date: Tue,  8 Sep 2026 12:33:36 +0200
Message-ID: <20260908103338.427254-7-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908103338.427254-1-joro@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Add KVM_SEV_SNP_GET_VCPU_STATE and KVM_SEV_SNP_SET_VCPU_STATE as
vCPU-scoped KVM_MEMORY_ENCRYPT_OP commands and advertise
KVM_CAP_SNP_VCPU_STATE.  The shared, extensible argument reports the VMSA
and GHCB GPAs and has validity bits for both addresses.

For SET, validate the argument, launch ordering, VMSA alignment, and that a
valid VMSA is backed by guest_memfd.  Install or invalidate the VMSA and
GHCB as requested.  GET returns the currently tracked guest-owned VMSA GPA
and the GHCB address.

Require KVM_CAP_SNP_DIRECT_VMSA for SET.  The VM-scoped capability fixes
the launch model before vCPU creation; the per-vCPU command only selects
the guest-owned VMSA and GHCB addresses for that vCPU.

Route the commands through the locked vCPU ioctl hook.  The vCPU mutex
serializes the commands against launch finalization, which locks all vCPUs
before inspecting their state.

Assisted-by: LLM
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/uapi/asm/kvm.h |  12 +++
 arch/x86/kvm/svm/sev.c          | 164 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |   1 +
 arch/x86/kvm/svm/svm.h          |   1 +
 arch/x86/kvm/x86.c              |   1 +
 include/uapi/linux/kvm.h        |   1 +
 6 files changed, 180 insertions(+)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 69dcd044583f..5ae041e617b8 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -748,6 +748,8 @@ enum sev_cmd_id {
 	KVM_SEV_SNP_LAUNCH_UPDATE,
 	KVM_SEV_SNP_LAUNCH_FINISH,
 	KVM_SEV_SNP_ENABLE_REQ_CERTS,
+	KVM_SEV_SNP_GET_VCPU_STATE,
+	KVM_SEV_SNP_SET_VCPU_STATE,
 
 	KVM_SEV_NR_MAX,
 };
@@ -904,6 +906,16 @@ struct kvm_sev_snp_launch_update {
 	__u64 pad2[4];
 };
 
+#define KVM_SEV_SNP_VCPU_STATE_VMSA_VALID	_BITULL(0)
+#define KVM_SEV_SNP_VCPU_STATE_GHCB_VALID	_BITULL(1)
+
+struct kvm_sev_snp_vcpu_state {
+	__u64 valid_fields;
+	__u64 vmsa_gpa;
+	__u64 ghcb_gpa;
+	__u64 pad[5];
+};
+
 #define KVM_SEV_SNP_ID_BLOCK_SIZE	96
 #define KVM_SEV_SNP_ID_AUTH_SIZE	4096
 #define KVM_SEV_SNP_FINISH_DATA_SIZE	32
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7a9ef1bc54e9..3e0727e251a9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2520,6 +2520,8 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return 0;
 }
 
+static int sev_snp_install_guest_vmsa(struct vcpu_svm *svm, gpa_t gpa);
+
 static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
@@ -2585,6 +2587,89 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int snp_get_vcpu_state(struct kvm_vcpu *vcpu,
+			      struct kvm_sev_cmd *argp)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sev_snp_vcpu_state state = {};
+
+	if (!is_sev_snp_guest(vcpu))
+		return -ENOTTY;
+	if (!to_kvm_sev_info(kvm)->snp_context)
+		return -EINVAL;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (VALID_PAGE(svm->sev_es.snp_guest_vmsa_gpa) &&
+	    VALID_PAGE(svm->vmcb->control.vmsa_pa)) {
+		state.vmsa_gpa = svm->sev_es.snp_guest_vmsa_gpa;
+		state.valid_fields |= KVM_SEV_SNP_VCPU_STATE_VMSA_VALID;
+	}
+
+	if (VALID_PAGE(svm->vmcb->control.ghcb_gpa)) {
+		state.ghcb_gpa = svm->vmcb->control.ghcb_gpa;
+		state.valid_fields |= KVM_SEV_SNP_VCPU_STATE_GHCB_VALID;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(argp->data), &state, sizeof(state)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int snp_set_vcpu_state(struct kvm_vcpu *vcpu,
+			      struct kvm_sev_cmd *argp)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
+	struct kvm_sev_snp_vcpu_state state;
+	int ret;
+
+	if (!is_sev_snp_guest(vcpu))
+		return -ENOTTY;
+	if (!sev->snp_direct_vmsa)
+		return -EINVAL;
+	if (!sev->snp_context || kvm->arch.pre_fault_allowed)
+		return -EINVAL;
+
+	if (copy_from_user(&state, u64_to_user_ptr(argp->data), sizeof(state)))
+		return -EFAULT;
+
+	if (memchr_inv(state.pad, 0, sizeof(state.pad)) ||
+	    state.valid_fields & ~(KVM_SEV_SNP_VCPU_STATE_VMSA_VALID |
+				   KVM_SEV_SNP_VCPU_STATE_GHCB_VALID))
+		return -EINVAL;
+
+	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
+		if (!PAGE_ALIGNED(state.vmsa_gpa) ||
+		    !page_address_valid(vcpu, state.vmsa_gpa) ||
+		    IS_ALIGNED(state.vmsa_gpa, PMD_SIZE))
+			return -EINVAL;
+	}
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
+		ret = sev_snp_install_guest_vmsa(svm, state.vmsa_gpa);
+		if (ret)
+			return ret;
+	} else {
+		svm->sev_es.snp_has_guest_vmsa = true;
+		svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
+		svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+	}
+
+	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_GHCB_VALID)
+		svm->vmcb->control.ghcb_gpa = state.ghcb_gpa;
+	else
+		svm->vmcb->control.ghcb_gpa = INVALID_PAGE;
+
+	vmcb_mark_all_dirty(svm->vmcb);
+	return 0;
+}
+
 static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
@@ -2781,6 +2866,35 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 	return r;
 }
 
+int sev_vcpu_mem_enc_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
+{
+	struct kvm_sev_cmd sev_cmd;
+	int ret;
+
+	if (!sev_enabled)
+		return -ENOTTY;
+	if (!argp)
+		return -EINVAL;
+	if (copy_from_user(&sev_cmd, argp, sizeof(sev_cmd)))
+		return -EFAULT;
+
+	switch (sev_cmd.id) {
+	case KVM_SEV_SNP_GET_VCPU_STATE:
+		ret = snp_get_vcpu_state(vcpu, &sev_cmd);
+		break;
+	case KVM_SEV_SNP_SET_VCPU_STATE:
+		ret = snp_set_vcpu_state(vcpu, &sev_cmd);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (copy_to_user(argp, &sev_cmd, sizeof(sev_cmd)))
+		return -EFAULT;
+
+	return ret;
+}
+
 int sev_mem_enc_register_region(struct kvm *kvm,
 				struct kvm_enc_region *range)
 {
@@ -4055,6 +4169,56 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	return snp_do_psc(svm);
 }
 
+/*
+ * Install a guest-owned VMSA.  The caller must serialize against AP creation
+ * and destruction with snp_vmsa_mutex.
+ */
+static int sev_snp_install_guest_vmsa(struct vcpu_svm *svm, gpa_t gpa)
+{
+	struct kvm *kvm = svm->vcpu.kvm;
+	struct kvm_memory_slot *slot;
+	unsigned long mmu_seq;
+	struct page *page;
+	kvm_pfn_t pfn;
+	gfn_t gfn;
+	int idx;
+	int ret;
+
+	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
+
+	gfn = gpa_to_gfn(gpa);
+	idx = srcu_read_lock(&kvm->srcu);
+	slot = gfn_to_memslot(kvm, gfn);
+	if (!slot) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	mmu_seq = kvm->mmu_invalidate_seq;
+	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
+	smp_rmb();
+
+	/* Guest-owned VMSAs are backed by guest_memfd private memory. */
+	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, NULL);
+	if (ret)
+		goto out_unlock;
+
+	read_lock(&kvm->mmu_lock);
+	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
+		ret = -EAGAIN;
+	} else {
+		svm->sev_es.snp_has_guest_vmsa = true;
+		WRITE_ONCE(svm->sev_es.snp_guest_vmsa_gpa, gpa);
+		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
+	}
+	read_unlock(&kvm->mmu_lock);
+
+	kvm_release_page_clean(page);
+out_unlock:
+	srcu_read_unlock(&kvm->srcu, idx);
+	return ret;
+}
+
 static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 98c5cffe2c22..378d94409134 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5466,6 +5466,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_needs_initialization = sev_vcpu_needs_initialization,
 	.dev_get_attr = sev_dev_get_attr,
 	.mem_enc_ioctl = sev_mem_enc_ioctl,
+	.vcpu_mem_enc_ioctl = sev_vcpu_mem_enc_ioctl,
 	.mem_enc_register_region = sev_mem_enc_register_region,
 	.mem_enc_unregister_region = sev_mem_enc_unregister_region,
 	.guest_memory_reclaimed = sev_guest_memory_reclaimed,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 881d662aaab2..c920c797b7ec 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -983,6 +983,7 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 #ifdef CONFIG_KVM_AMD_SEV
 bool sev_vcpu_needs_initialization(struct kvm_vcpu *vcpu);
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp);
+int sev_vcpu_mem_enc_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
 int sev_mem_enc_register_region(struct kvm *kvm,
 				struct kvm_enc_region *range);
 int sev_mem_enc_unregister_region(struct kvm *kvm,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fb4857eca6c6..232507ae504a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2404,6 +2404,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_TYPES:
 		r = kvm_caps.supported_vm_types;
 		break;
+	case KVM_CAP_SNP_VCPU_STATE:
 	case KVM_CAP_SNP_DIRECT_VMSA:
 		r = !!(kvm_caps.supported_vm_types & BIT(KVM_X86_SNP_VM));
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 283e881b2634..8c6765f78c1c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_SNP_DIRECT_VMSA 252
+#define KVM_CAP_SNP_VCPU_STATE 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.53.0

