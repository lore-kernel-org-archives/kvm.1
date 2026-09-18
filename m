Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4749CF4D
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719363; cv=none; b=e1dVK7eyjPKCU/tUb1G76M4/WP/9Q3umcowOGg8+KrGzMmPddPbUXDYRIGdp4CiKxj4MTWt9pqxbycxo5mo2KnyWWTXIM1UGUxFeOxw0OuwJ6sw7vRzryg8d68YcQD2WsP+rNsX/CO1o+knkL/5/tB70CiceFOk8RhAfbPrYFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719363; c=relaxed/simple;
	bh=v5wR7U5cYsBH/nkva/SeFYy3gKlLaPJXWaoMcHltJQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=areGzGNnqXGShrVb/zS9LiZyeBSa15DYHvGDV1OX0SxDI6xBoxRfpj33/rSZaDeN1+GQt603pbEWo19D6fhAlbTIe4IA8s8CtIYJZRbwsJ7mXO20G3zk/+krA1kW3Is5b3G8sixNleFydxhb+q/qmPsNW06ce1tBirOWJ+Bfg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMfGcMqA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMfGcMqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hVsZbuskpwJXUXR/rDnVL9ommRvM8B/74gs7hn/GOA=;
	b=fMfGcMqAyQbeYYMsifFY2mbzMIANzicVKo1Zsaga6ILOd8OqgqjacbIrMqmNpgQ3Bwu4WG
	LNf6ANC0pjW2pfzGaxcf7qjqagK5eepW0NDH9NO374Vy6IGZlfNq53Tscpv9YOfJJnP/hk
	LqyLH3uA6cwP4DteDt1saBrtMrZ40jM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-3QvOjbg8NxWxPre2Gi0oUQ-1; Fri,
 18 Sep 2026 04:15:50 -0400
X-MC-Unique: 3QvOjbg8NxWxPre2Gi0oUQ-1
X-Mimecast-MFC-AGG-ID: 3QvOjbg8NxWxPre2Gi0oUQ_1789719349
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD86A19772E3;
	Fri, 18 Sep 2026 08:15:48 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20E87180056E;
	Fri, 18 Sep 2026 08:15:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 05/28] KVM: x86: Introduce memory fault on invalid hypercalls reads/writes
Date: Fri, 18 Sep 2026 04:15:20 -0400
Message-ID: <20260918081543.139871-6-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
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
---
 Documentation/virt/kvm/api.rst  |  19 ++++
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/hyperv.c           | 157 +++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c              |  38 ++++++--
 include/uapi/linux/kvm.h        |   1 +
 5 files changed, 174 insertions(+), 42 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 37028ce019e3..abc2ff1f8c84 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8984,6 +8984,25 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
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
index 683bb8bf43a9..c08781bb0327 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1169,6 +1169,7 @@ struct kvm_arch {
 	bool has_protected_eoi;
 	bool has_protected_pmu;
 	bool pre_fault_allowed;
+	bool hcall_fault_exit;
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
 	struct kvm_possible_nx_huge_pages possible_nx_huge_pages[KVM_NR_MMU_TYPES];
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 604651cb2739..9f5adcd26cba 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2033,7 +2033,68 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
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
@@ -2053,6 +2114,19 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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
@@ -2061,20 +2135,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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
@@ -2242,7 +2302,7 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 	}
 }
 
-static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 *sparse_banks = hv_vcpu->sparse_banks;
@@ -2252,6 +2312,11 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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
@@ -2432,10 +2497,15 @@ static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
 }
 
-static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 	struct eventfd_ctx *eventfd;
+	int ret;
+
+	ret = kvm_hv_hypercall_check_params(vcpu, hc);
+	if (ret)
+		return ret;
 
 	if (unlikely(!hc->fast)) {
 		int ret;
@@ -2547,11 +2617,30 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
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
@@ -2619,7 +2708,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2629,7 +2721,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		goto hypercall_userspace_exit;
+		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
 		if (unlikely(hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
@@ -2641,7 +2733,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2654,7 +2749,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2667,7 +2765,10 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2688,14 +2789,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2704,14 +2805,6 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
index 2fbaa070f741..c10b3fd48b65 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2242,6 +2242,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
 #endif
+	case KVM_CAP_HCALL_FAULT_EXIT:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -4210,6 +4211,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
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
@@ -7191,25 +7196,27 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_vendor_exit);
 
 #ifdef CONFIG_X86_64
 static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
-			        unsigned long clock_type)
+			        unsigned long clock_type, unsigned long *ret)
 {
 	struct kvm_clock_pairing clock_pairing;
 	struct timespec64 ts;
+	bool writable;
+	unsigned long hva;
 	u64 cycle;
-	int ret;
 
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
@@ -7217,17 +7224,27 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 	clock_pairing.flags = 0;
 	memset(&clock_pairing.pad, 0, sizeof(clock_pairing.pad));
 
+	*ret = -KVM_EFAULT;
 	paddr = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr,
 				  PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK, NULL, 0);
 	if (paddr == INVALID_GPA)
-		return -KVM_EFAULT;
+		return 0;
+
+	if (vcpu->kvm->arch.hcall_fault_exit) {
+		hva = kvm_vcpu_gfn_to_hva_prot(vcpu, gpa_to_gfn(paddr), &writable);
+		if (kvm_is_error_hva(hva) || !writable) {
+			kvm_prepare_memory_fault_exit(vcpu, paddr & PAGE_MASK, PAGE_SIZE,
+						      true, false, false);
+			return -EFAULT;
+		}
+	}
 
-	ret = 0;
 	if (kvm_write_guest(vcpu->kvm, paddr, &clock_pairing,
 			    sizeof(struct kvm_clock_pairing)))
-		ret = -KVM_EFAULT;
+		return 0;
 
-	return ret;
+	*ret = 0;
+	return 0;
 }
 #endif
 
@@ -7385,7 +7402,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
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
index 15a3090f067e..c23f1ea62eaf 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1002,6 +1002,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
+#define KVM_CAP_HCALL_FAULT_EXIT 252
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.52.0


