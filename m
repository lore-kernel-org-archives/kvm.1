Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619731;
	b=kJd3uYuXq2sWtDsgYdFelqObUccTb4Sv46QubpFM/XTFT4iSYNiwZW/xNhSdVqxFct6x
	 +i8OElkcAeHl4XCAohWCYYr6+pZHG4QfXA5BxV3PdMe2Fphpyo1qQCz1Dv8NGmbQTWqhB
	 hvbKFNcMv1xXgftdXJ6x9jOnoh0M0O0tS+csevunvhCd2R09kXgFarrceWsMgYvaAW35O
	 b4MjSYQDSOZn9RdMi+2iDQUWoiUQ4GOEM+wTwmrwyGXRquVuErVC2c4+HShlu9c8OtE7d
	 sEQRuqUigK8aITNV1buxWcHQi2C69cStNM5akY0wNIiGLOeV/iSaiOdm/CZkHASE8MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619731;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TEU2WoAEETIO1KA1ci4BU3Q44LkzMYCz5O8+st3qozg=;
	b=uglohwT6zTMq5gbVOGad6s7tXIovXS/vdOtvAj/Khrvd8MDny7yRlANGAZwq4pkk6x47
	 i0bQQM2PygKT2+l8EJ7LoX1eR+5JHApqIMBFcupOD6xVQaiwvZ5Dv0AGd+gHOxUCTHA2C
	 Mux4owF4pZ9xjt8hQlyBw+4lhc92zbS5NikH7BQf0PE8LwhItpgGyJ4jhsL1Vg8pgE24r
	 V0qs2HpfQGyiagfydVwO6ivMxbuUzMYH5i416lzqdvSQhhi+j5QMgh4moYl5Mrn3CpamI
	 kEP4Ix0ZvZaG8c68N7v7mCyWuTWYozf5UHf0hfzSBfmBIyq3DjEtyikUb7SehI6zFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8001606A334;
	Mon,  2 Nov 2026 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8001606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 84E4B243AB0;
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
Subject: [PATCH v3 4/8] KVM: SEV: Add direct VMSA capability
Date: Mon,  2 Nov 2026 12:41:33 +0100
Message-ID: <20261102114137.1198982-5-joro@8bytes.org>
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

Direct VMSA mode is currently selected implicitly when userspace installs
a guest-owned VMSA on any vCPU.  That makes the launch model a side effect
of per-vCPU state and applies it retroactively to every vCPU.

Add KVM_CAP_SNP_DIRECT_VMSA as a VM-scoped settable capability.  Require
userspace to enable it on an SNP VM before creating vCPUs, and reject
nonzero arguments.

When enabled, skip allocating KVM-owned VMSAs during vCPU creation and
skip generating and measuring KVM-owned VMSAs at launch finish.  Keep
legacy allocation and measurement behavior when it is not enabled.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/sev.c             | 28 ++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.c             | 22 ++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h             |  1 +
 arch/x86/kvm/x86.c                 |  5 +++++
 include/uapi/linux/kvm.h           |  1 +
 7 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 4dde4e3e608a..c853dc65fb53 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -23,6 +23,7 @@ KVM_X86_OP(vcpu_after_set_cpuid)
 KVM_X86_OP(vm_init)
 KVM_X86_OP_OPTIONAL(vm_destroy)
 KVM_X86_OP_OPTIONAL(vm_pre_destroy)
+KVM_X86_OP_OPTIONAL(enable_vm_cap)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_precreate)
 KVM_X86_OP(vcpu_create)
 KVM_X86_OP(vcpu_free)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ee4b127004d..be758e0d55aa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1524,6 +1524,7 @@ struct kvm_x86_ops {
 	int (*vm_init)(struct kvm *kvm);
 	void (*vm_destroy)(struct kvm *kvm);
 	void (*vm_pre_destroy)(struct kvm *kvm);
+	int (*enable_vm_cap)(struct kvm *kvm, struct kvm_enable_cap *cap);
 
 	/* Create, but do not attach this VCPU */
 	int (*vcpu_precreate)(struct kvm *kvm);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9681ff0aa5d3..09e1c2da546d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2541,8 +2541,15 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct vcpu_svm *svm = to_svm(vcpu);
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
+		u64 pfn;
+
+		if (sev->snp_direct_vmsa) {
+			if (!svm->sev_es.snp_has_guest_vmsa)
+				svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+			goto protect_vcpu;
+		}
 
+		pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
 			goto out;
@@ -2562,6 +2569,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 			goto out;
 		}
 
+protect_vcpu:
 		svm->vcpu.arch.guest_state_protected = true;
 		/*
 		 * SEV-ES (and thus SNP) guest mandates LBR Virtualization to
@@ -3583,6 +3591,9 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	 * a guest-owned page. Transition the page to hypervisor state before
 	 * releasing it back to the system.
 	 */
+	if (!svm->sev_es.vmsa)
+		goto skip_vmsa_free;
+
 	if (is_sev_snp_guest(vcpu)) {
 		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
 
@@ -4078,13 +4089,9 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	vmcb_mark_all_dirty(svm->vmcb);
 
 	/*
-	 * From this point forward, the VMSA will always be a guest-mapped page
-	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
-	 * theory, svm->sev_es.vmsa could be free'd and cleaned up here, but
-	 * that involves cleanups like flushing caches, which would ideally be
-	 * handled during teardown rather than guest boot.  Deferring that also
-	 * allows the existing logic for SEV-ES VMSAs to be re-used with
-	 * minimal SNP-specific changes.
+	 * From this point forward, the VMSA will always be a guest-mapped page.
+	 * If KVM allocated an initial VMSA, keep it until teardown to defer
+	 * cache flushing and other cleanup out of the guest boot path.
 	 */
 	svm->sev_es.snp_has_guest_vmsa = true;
 
@@ -4975,12 +4982,15 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 int sev_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
 	struct page *vmsa_page;
 
 	mutex_init(&svm->sev_es.snp_vmsa_mutex);
 
 	if (!is_sev_es_guest(vcpu))
 		return 0;
+	if (is_sev_snp_guest(vcpu) && sev->snp_direct_vmsa)
+		goto init_vmsa_state;
 
 	/*
 	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
@@ -4991,6 +5001,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	svm->sev_es.vmsa = page_address(vmsa_page);
+
+init_vmsa_state:
 	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..d84109394115 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5458,6 +5458,27 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
 	return page_address(page);
 }
 
+static int svm_enable_vm_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
+{
+	switch (cap->cap) {
+#ifdef CONFIG_KVM_AMD_SEV
+	case KVM_CAP_SNP_DIRECT_VMSA:
+		if (memchr_inv(cap->args, 0, sizeof(cap->args)) ||
+		    kvm->arch.vm_type != KVM_X86_SNP_VM)
+			return -EINVAL;
+
+		guard(mutex)(&kvm->lock);
+		if (kvm->created_vcpus)
+			return -EINVAL;
+
+		to_kvm_sev_info(kvm)->snp_direct_vmsa = true;
+		return 0;
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
 struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
@@ -5478,6 +5499,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vm_init = svm_vm_init,
 	.vm_pre_destroy = avic_vm_pre_destroy,
 	.vm_destroy = svm_vm_destroy,
+	.enable_vm_cap = svm_enable_vm_cap,
 
 	.prepare_switch_to_guest = svm_prepare_switch_to_guest,
 	.vcpu_load = svm_vcpu_load,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966dc8..1a94d0c1ef91 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -122,6 +122,7 @@ struct kvm_sev_info {
 	struct mutex guest_req_mutex; /* Must acquire before using bounce buffers */
 	cpumask_var_t have_run_cpus; /* CPUs that have done VMRUN for this VM. */
 	bool snp_certs_enabled;	/* SNP certificate-fetching support. */
+	bool snp_direct_vmsa;	/* Userspace provides and measures VMSA pages. */
 };
 #endif
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..0a96bdc7f869 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2415,6 +2415,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_TYPES:
 		r = kvm_caps.supported_vm_types;
 		break;
+	case KVM_CAP_SNP_DIRECT_VMSA:
+		r = !!(kvm_caps.supported_vm_types & BIT(KVM_X86_SNP_VM));
+		break;
 	case KVM_CAP_READONLY_MEM:
 		r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
 		break;
@@ -4254,6 +4257,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	}
 	default:
 		r = -EINVAL;
+		if (kvm_x86_ops.enable_vm_cap)
+			r = kvm_x86_call(enable_vm_cap)(kvm, cap);
 		break;
 	}
 	return r;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e..005c25263030 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_SNP_DIRECT_VMSA 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.53.0

