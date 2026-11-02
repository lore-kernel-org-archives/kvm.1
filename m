Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641308;
	b=Ma5rdMObUZtFXmXhMv976ILJ/KnfqJCNF6YTTb8BkjKw5LppjVmJ4L30vrjStQ6zR838
	 5KKPlxRuF11nugnMe6yL/3LaoDR62ukbreh0cd9mgrKusI4l9RGssjddz/OSLU+r2iCvo
	 YIUoU1EFfQy95QlmGqVS9gwtN11NSo1Mmgs2u38chCOIbWEFWQx1D9ar3r0eOTyRmKoiX
	 lZNs69IO1yoxB1Yf2913fTe0Ruzc7aMYDEMivsSO8otM0MS8SAyyCqsrrZgMc1fzn+nLN
	 lVL5yGx2u3FsTjU3QXi1tTJzq4TpuUWSR8fkAv0j4MXdMftYVcOoV1Q8xzT0jUB881Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641308;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=oR7ZcEBZ2uCS6fsotuLYhfpaNZc9tC2TAXHqT1bx+zI=;
	b=szWb+EMHHekjBtiFLFZKiENY1E0D+SgwskIg/sRPl4RJnXSMRWz1e0sXu5qWfMu/nMLD
	 175V3gDqwEcXJH8JYues0enVmn6Hp1jP7tgTlSoBW5t5znCyGLMhP+/K+AQzuAwoDiG2f
	 P1uM9gZz//psHiwZDjgejfJYq8PBCL4ADFa6CL2L4aSLB8UA8Yi2dPSmJhCXMsG3RmL05
	 +nVD8Pk9+4UZGGfo8k5vjwVjFlRGzd3Ytmlaab1Yib+uI5LDMfeAbXE9oHhRH4qYHulcB
	 MWyCDmvx1Sahr54NpC/EgR7gi1GPkE9yNt8LAqvo19Tq8TQlzn/IC9/Xd7prEYcG1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25D607222C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD25D607222C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oR7ZcEBZ2uCS6fsotuLYhfpaNZc9tC2TAXHqT1bx+zI=;
	b=VBU5CEVodNfdtR3XLa3u7rGAR7yML4c8juJMbEk7ry6KoUnRJAgS01fMH83a9WH+EXDyuf
	MD/9/eCs6ROSE+oeMszpS9ED6W5bTkPDwfW9IQdSH6ksGdP9AJ2GHOvP6NYoTo9v1drbuW
	j/yizG2Q5w/ZX6LYI+3XLYnpNKkLVLo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-syg0cX10PwOh9lXufVcDzQ-1; Mon,
 02 Nov 2026 12:41:38 -0500
X-MC-Unique: syg0cX10PwOh9lXufVcDzQ-1
X-Mimecast-MFC-AGG-ID: syg0cX10PwOh9lXufVcDzQ_1793641297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9669F1800BE6;
	Mon,  2 Nov 2026 17:41:37 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25084180057F;
	Mon,  2 Nov 2026 17:41:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 10/45] KVM: x86: Introduce memory fault on invalid hypercalls reads/writes
Date: Mon,  2 Nov 2026 12:40:54 -0500
Message-ID: <20261102174130.8779-11-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Allow userspace to perform arbitrary actions when a hypercall refers to an
invalid address, by exiting with KVM_EXIT_MEMORY_FAULT.  This will for
example allow userspace to perform a VTL call.

Co-developed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-7-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst  |  19 ++++
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/hyperv.c           | 157 +++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c              |  34 +++++--
 include/uapi/linux/kvm.h        |   1 +
 5 files changed, 173 insertions(+), 39 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7123d021bdbb..d0f91687bdb9 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9186,6 +9186,25 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_HCALL_FAULT_EXIT
+------------------------------------
+
+:Architectures: x86
+:Parameters: args[0] is 0 to disable, 1 to enable
+
+When enabled, KVM checks the memory that is read or written by
+hypercalls (including slow Hyper-V hypercalls and KVM_HC_CLOCK_PAIRING).
+An inaccessible input page causes a KVM_EXIT_MEMORY_FAULT with
+KVM_MEMORY_EXIT_FLAG_READ.  An inaccessible or read-only output page causes
+a KVM_EXIT_MEMORY_FAULT with KVM_MEMORY_EXIT_FLAG_WRITE.  The reported
+range identifies the page containing the parameter GPA.
+
+Hypercall parameters that are unused by the selected hypercall are not checked.
+
+For Hyper-V, unknown hypercalls are passed to userspace without checking their
+parameter pages.  The fault GPA is in the physical address space of the
+VM managed by userspace, after nested GPA translation.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0378577d9d8b..25256d59cfde 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1178,6 +1178,7 @@ struct kvm_arch {
 	bool has_protected_eoi;
 	bool has_protected_pmu;
 	bool pre_fault_allowed;
+	bool hcall_fault_exit;
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
 	struct kvm_possible_nx_huge_pages possible_nx_huge_pages[KVM_NR_MMU_TYPES];
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 798baa9eaafb..ee5189815a06 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2034,7 +2034,68 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 	return -ENOSPC;
 }
 
-static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+static int kvm_hv_hypercall_check_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
+				      bool write)
+{
+	bool writable = true;
+	gfn_t gfn = gpa_to_gfn(gpa);
+	unsigned long addr;
+
+	addr = kvm_vcpu_gfn_to_hva_prot(vcpu, gfn, &writable);
+	if (!kvm_is_error_hva(addr) && (!write || writable))
+		return 0;
+
+	kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
+				      write, false, false);
+	return -EFAULT;
+}
+
+static unsigned int kvm_hv_hypercall_mem_access(u16 code)
+{
+	switch (code) {
+	case HVCALL_SIGNAL_EVENT:
+	case HVCALL_POST_MESSAGE:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
+	case HVCALL_SEND_IPI:
+	case HVCALL_SEND_IPI_EX:
+		return KVM_MEMORY_EXIT_FLAG_READ;
+	case HVCALL_POST_DEBUG_DATA:
+	case HVCALL_RETRIEVE_DEBUG_DATA:
+		return KVM_MEMORY_EXIT_FLAG_READ | KVM_MEMORY_EXIT_FLAG_WRITE;
+	case HVCALL_RESET_DEBUG_SESSION:
+	case HV_EXT_CALL_QUERY_CAPABILITIES:
+		return KVM_MEMORY_EXIT_FLAG_WRITE;
+	}
+
+	return 0;
+}
+
+static int kvm_hv_hypercall_check_params(struct kvm_vcpu *vcpu,
+					 struct kvm_hv_hcall *hc)
+{
+	unsigned access;
+	int r;
+
+	if (hc->fast || !vcpu->kvm->arch.hcall_fault_exit)
+		return 0;
+
+	access = kvm_hv_hypercall_mem_access(hc->code);
+	if (access & KVM_MEMORY_EXIT_FLAG_READ) {
+		r = kvm_hv_hypercall_check_gpa(vcpu, hc->ingpa, false);
+		if (r)
+			return r;
+	}
+
+	if (access & KVM_MEMORY_EXIT_FLAG_WRITE)
+		return kvm_hv_hypercall_check_gpa(vcpu, hc->outgpa, true);
+
+	return 0;
+}
+
+static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	unsigned long *vcpu_mask = hv_vcpu->vcpu_mask;
@@ -2054,6 +2115,19 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	struct kvm_vcpu *v;
 	unsigned long i;
 	bool all_cpus;
+	int r;
+
+	/* Slow direct hypercalls from L2 provide a nested GPA. */
+	if (!hc->fast) {
+		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, hc->ingpa,
+					      PFERR_GUEST_FINAL_MASK, NULL, 0);
+		if (unlikely(hc->ingpa == INVALID_GPA))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
+
+	r = kvm_hv_hypercall_check_params(vcpu, hc);
+	if (r)
+		return r;
 
 	/*
 	 * The Hyper-V TLFS doesn't allow more than HV_MAX_SPARSE_VCPU_BANKS
@@ -2062,20 +2136,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > HV_MAX_SPARSE_VCPU_BANKS);
 
-	/*
-	 * 'Slow' hypercall's first parameter is the address in guest's memory
-	 * where hypercall parameters are placed. This is either a GPA or a
-	 * nested GPA when KVM is handling the call from L2 ('direct' TLB
-	 * flush).  Translate the address here so the memory can be uniformly
-	 * read with kvm_read_guest().
-	 */
-	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, hc->ingpa,
-					      PFERR_GUEST_FINAL_MASK, NULL, 0);
-		if (unlikely(hc->ingpa == INVALID_GPA))
-			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-	}
-
 	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
 	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE) {
 		if (hc->fast) {
@@ -2243,7 +2303,7 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 	}
 }
 
-static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 *sparse_banks = hv_vcpu->sparse_banks;
@@ -2253,6 +2313,11 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	u64 valid_bank_mask;
 	u32 vector;
 	bool all_cpus;
+	int r;
+
+	r = kvm_hv_hypercall_check_params(vcpu, hc);
+	if (r)
+		return r;
 
 	if (!lapic_in_kernel(vcpu))
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
@@ -2433,11 +2498,16 @@ static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
 }
 
-static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 	struct eventfd_ctx *eventfd;
 	u64 conn_id;
+	int ret;
+
+	ret = kvm_hv_hypercall_check_params(vcpu, hc);
+	if (ret)
+		return ret;
 
 	if (unlikely(!hc->fast)) {
 		int ret;
@@ -2551,11 +2621,30 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	return true;
 }
 
+static int kvm_hv_hypercall_userspace_exit(struct kvm_vcpu *vcpu,
+					   struct kvm_hv_hcall *hc)
+{
+	int r;
+
+	r = kvm_hv_hypercall_check_params(vcpu, hc);
+	if (r)
+		return r;
+
+	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
+	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
+	vcpu->run->hyperv.u.hcall.input = hc->param;
+	vcpu->run->hyperv.u.hcall.params[0] = hc->ingpa;
+	vcpu->run->hyperv.u.hcall.params[1] = hc->outgpa;
+	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
+	return 0;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	struct kvm_hv_hcall hc;
 	u64 ret = HV_STATUS_SUCCESS;
+	s64 r;
 
 	/*
 	 * hypercall generates UD from non zero cpl and real mode
@@ -2623,7 +2712,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hvcall_signal_event(vcpu, &hc);
+		r = kvm_hvcall_signal_event(vcpu, &hc);
+		if (r < 0)
+			return r;
+		ret = r;
 		if (ret != HV_STATUS_INVALID_PORT_ID)
 			break;
 		fallthrough;	/* maybe userspace knows this conn_id */
@@ -2633,7 +2725,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		goto hypercall_userspace_exit;
+		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
 		if (unlikely(hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
@@ -2645,7 +2737,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_flush_tlb(vcpu, &hc);
+		r = kvm_hv_flush_tlb(vcpu, &hc);
+		if (r < 0)
+			return r;
+		ret = r;
 		break;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
 		if (unlikely(hc.var_cnt)) {
@@ -2658,7 +2753,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_flush_tlb(vcpu, &hc);
+		r = kvm_hv_flush_tlb(vcpu, &hc);
+		if (r < 0)
+			return r;
+		ret = r;
 		break;
 	case HVCALL_SEND_IPI:
 		if (unlikely(hc.var_cnt)) {
@@ -2671,7 +2769,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_send_ipi(vcpu, &hc);
+		r = kvm_hv_send_ipi(vcpu, &hc);
+		if (r < 0)
+			return r;
+		ret = r;
 		break;
 	case HVCALL_POST_DEBUG_DATA:
 	case HVCALL_RETRIEVE_DEBUG_DATA:
@@ -2692,14 +2793,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_OPERATION_DENIED;
 			break;
 		}
-		goto hypercall_userspace_exit;
+		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 	}
 	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
 		if (unlikely(hc.fast)) {
 			ret = HV_STATUS_INVALID_PARAMETER;
 			break;
 		}
-		goto hypercall_userspace_exit;
+		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
@@ -2708,14 +2809,6 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 hypercall_complete:
 	return kvm_hv_hypercall_complete(vcpu, ret);
 
-hypercall_userspace_exit:
-	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
-	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
-	vcpu->run->hyperv.u.hcall.input = hc.param;
-	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
-	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
-	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
-	return 0;
 }
 
 void kvm_hv_init_vm(struct kvm *kvm)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ec151374ca9e..1fcef4a8ac22 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2253,6 +2253,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
 #endif
+	case KVM_CAP_HCALL_FAULT_EXIT:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -4252,6 +4253,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+	case KVM_CAP_HCALL_FAULT_EXIT:
+		kvm->arch.hcall_fault_exit = cap->args[0];
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -7252,25 +7257,28 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_vendor_exit);
 
 #ifdef CONFIG_X86_64
 static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
-			        unsigned long clock_type)
+			        unsigned long clock_type, unsigned long *ret)
 {
 	struct kvm_clock_pairing clock_pairing;
 	struct timespec64 ts;
 	size_t offset = 0;
+	bool writable;
+	unsigned long hva;
 	u64 cycle;
 
+	*ret = -KVM_EOPNOTSUPP;
 	if (clock_type != KVM_CLOCK_PAIRING_WALLCLOCK)
-		return -KVM_EOPNOTSUPP;
+		return 0;
 
 	/*
 	 * When tsc is in permanent catchup mode guests won't be able to use
 	 * pvclock_read_retry loop to get consistent view of pvclock
 	 */
 	if (vcpu->arch.tsc_always_catchup)
-		return -KVM_EOPNOTSUPP;
+		return 0;
 
 	if (!kvm_get_walltime_and_clockread(&ts, &cycle))
-		return -KVM_EOPNOTSUPP;
+		return 0;
 
 	clock_pairing.sec = ts.tv_sec;
 	clock_pairing.nsec = ts.tv_nsec;
@@ -7278,6 +7286,7 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 	clock_pairing.flags = 0;
 	memset(&clock_pairing.pad, 0, sizeof(clock_pairing.pad));
 
+	*ret = -KVM_EFAULT;
 	while (offset < sizeof(clock_pairing)) {
 		gpa_t gpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr + offset,
 					      PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK, NULL, 0);
@@ -7285,12 +7294,22 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 				   PAGE_SIZE - offset_in_page(gpa));
 
 		if (gpa == INVALID_GPA)
-			return -KVM_EFAULT;
+			return 0;
+		if (vcpu->kvm->arch.hcall_fault_exit) {
+			hva = kvm_vcpu_gfn_to_hva_prot(vcpu, gpa_to_gfn(gpa), &writable);
+			if (kvm_is_error_hva(hva) || !writable) {
+				kvm_prepare_memory_fault_exit(vcpu, gpa & PAGE_MASK, PAGE_SIZE,
+							      true, false, false);
+				return -EFAULT;
+			}
+		}
 		if (kvm_write_guest(vcpu->kvm, gpa, (u8 *)&clock_pairing + offset, len))
-			return -KVM_EFAULT;
+			return 0;
 
 		offset += len;
 	}
+
+	*ret = 0;
 	return 0;
 }
 #endif
@@ -7449,7 +7468,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		break;
 #ifdef CONFIG_X86_64
 	case KVM_HC_CLOCK_PAIRING:
-		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
+		if (kvm_pv_clock_pairing(vcpu, a0, a1, &ret))
+			return -EFAULT;
 		break;
 #endif
 	case KVM_HC_SEND_IPI:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 229b3bdb7aed..4e0bab3db95c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1003,6 +1003,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_HCALL_FAULT_EXIT 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.52.0


