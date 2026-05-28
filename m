Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F233F4DE5
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975406; cv=none; b=g4wW8K3x7BfrcRQIiJtESglHixMenyqDmrBTeqUEYrqV4btV1gQLZeKAJE+wBy9+9SMY5vuKeqM/ulD+gEndrfaFyYuaMTH6zPNnV67TR5gfJPQl3k97JbXSts4QVkfuFE6SkJIkJwHjGMHpqAGORq31QgkBxunJc/pwwpv+KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975406; c=relaxed/simple;
	bh=Qks/Vc/vtkX4XI/zevLwz+TN1qODtptVNzNx1TqwV/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at/2AZ6ald2lT+C5EYixZjRhf1BFBFfPQfrclHbPNxXHMQZDPOaB0t2grLnM4l+HPu0bgp9DErlCCYcKDxCoS8m5GPEDjDfYgRGgqKPpRXSResZDbuWoy9bVUnv/p7Dnj89LJa1DljyWCe/iLrOjS50GZtxhccgqyNFiSBxJU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f3a09fe5a9a11f1aa26b74ffac11d73-20260528
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:521ea024-41de-44aa-8f34-b59a4862b072,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:521ea024-41de-44aa-8f34-b59a4862b072,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:2252a580f0509bc471b34859825efcaf,BulkI
	D:260528213640ZB92G10B,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f3a09fe5a9a11f1aa26b74ffac11d73-20260528
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2132228035; Thu, 28 May 2026 21:36:35 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 2/4] LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
Date: Thu, 28 May 2026 21:35:56 +0800
Message-ID: <20260528133558.2196416-3-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528133558.2196416-1-cuitao@kylinos.cn>
References: <20260528133558.2196416-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement paravirtualized TLB flush for LoongArch KVM guests using the
existing steal-time shared memory page.

The mechanism uses the preempted byte in struct kvm_steal_time with an
additional KVM_VCPU_FLUSH_TLB flag bit:

- When a guest vCPU needs remote TLB flush but the target vCPU is
  preempted (not running), it atomically sets KVM_VCPU_FLUSH_TLB in
  the target's steal-time preempted byte instead of sending an IPI.
- When the host re-enters the target vCPU (kvm_update_stolen_time()),
  it atomically reads and clears the preempted byte via amswap_db.w.
  If KVM_VCPU_FLUSH_TLB was set, the host drops the vCPU's VPID,
  which triggers a full TLB flush on the next VM entry via
  kvm_check_vpid().
- For non-preempted vCPUs, the guest falls back to normal IPI-based
  flush, avoiding unnecessary VM exits.

This significantly reduces TLB flush overhead in multi-vCPU workloads
where target vCPUs are often idle/preempted.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_host.h      |  1 +
 arch/loongarch/include/asm/kvm_para.h      |  1 +
 arch/loongarch/include/uapi/asm/kvm.h      |  1 +
 arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
 arch/loongarch/kvm/trace.h                 | 15 ++++++++++
 arch/loongarch/kvm/vcpu.c                  | 32 +++++++++++++++++++++-
 arch/loongarch/kvm/vm.c                    |  3 ++
 7 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 903cb67ca817..a379868fb147 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -170,6 +170,7 @@ enum emulation_result {
 #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
 					 BIT(KVM_FEATURE_PREEMPT) |	\
 					 BIT(KVM_FEATURE_STEAL_TIME) |	\
+					 BIT(KVM_FEATURE_PV_TLB_FLUSH) |\
 					 BIT(KVM_FEATURE_USER_HCALL) |	\
 					 BIT(KVM_FEATURE_VIRT_EXTIOI))
 
diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index fb17ba0fa101..28e3fa3b4c0e 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -41,6 +41,7 @@ struct kvm_steal_time {
 	__u8  pad[47];
 };
 #define KVM_VCPU_PREEMPTED		(1 << 0)
+#define KVM_VCPU_FLUSH_TLB		(1 << 1)
 
 /*
  * Hypercall interface for KVM hypervisor
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
index cd0b5c11ca9c..e4cd4bbf8914 100644
--- a/arch/loongarch/include/uapi/asm/kvm.h
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -106,6 +106,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PTW		8
 #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
 #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
+#define  KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH	11
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loongarch/include/uapi/asm/kvm_para.h
index d28cbcadd276..8872839251cc 100644
--- a/arch/loongarch/include/uapi/asm/kvm_para.h
+++ b/arch/loongarch/include/uapi/asm/kvm_para.h
@@ -16,6 +16,7 @@
 #define  KVM_FEATURE_IPI		1
 #define  KVM_FEATURE_STEAL_TIME		2
 #define  KVM_FEATURE_PREEMPT		3
+#define  KVM_FEATURE_PV_TLB_FLUSH	4
 /* BIT 24 - 31 are features configurable by user space vmm */
 #define  KVM_FEATURE_VIRT_EXTIOI	24
 #define  KVM_FEATURE_USER_HCALL		25
diff --git a/arch/loongarch/kvm/trace.h b/arch/loongarch/kvm/trace.h
index 3467ee22b704..8556954fa196 100644
--- a/arch/loongarch/kvm/trace.h
+++ b/arch/loongarch/kvm/trace.h
@@ -210,6 +210,21 @@ TRACE_EVENT(kvm_vpid_change,
 	    TP_printk("VPID: 0x%08lx", __entry->vpid)
 );
 
+TRACE_EVENT(kvm_pv_tlb_flush,
+	TP_PROTO(struct kvm_vcpu *vcpu, bool need_flush),
+	TP_ARGS(vcpu, need_flush),
+	TP_STRUCT__entry(
+		__field(unsigned int, vcpu_id)
+		__field(bool, need_flush)
+	),
+	TP_fast_assign(
+		__entry->vcpu_id = vcpu->vcpu_id;
+		__entry->need_flush = need_flush;
+	),
+	TP_printk("vcpu %u need_flush %u", __entry->vcpu_id,
+		  __entry->need_flush)
+);
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index d82782b90457..3b505a1c0a9f 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -173,7 +173,37 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	}
 
 	st = (struct kvm_steal_time __user *)ghc->hva;
-	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
+	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
+		u32 old = 0;
+		int err = 0;
+
+		/*
+		 * Atomically read and clear st->preempted.  amswap_db.w
+		 * provides full barrier semantics and avoids the race with
+		 * guest-side try_cmpxchg().  Operates on the 32-bit aligned
+		 * word containing preempted (pad bytes are always zero).
+		 */
+		asm volatile(
+		"1: amswap_db.w %1, %z3, %2	\n"
+		"2:				\n"
+		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)
+		: "+r" (err), "+&r" (old),
+		  "+ZB" (*(u32 *)&st->preempted)
+		: "Jr" (0)
+		: "memory");
+
+		if (err)
+			goto out;
+
+		vcpu->arch.st.preempted = 0;
+
+		if ((u8)old & KVM_VCPU_FLUSH_TLB) {
+			vcpu->arch.vpid = 0;	/* Drop vpid to flush TLB */
+			trace_kvm_pv_tlb_flush(vcpu, true);
+		} else {
+			trace_kvm_pv_tlb_flush(vcpu, false);
+		}
+	} else if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
 		unsafe_put_user(0, &st->preempted, out);
 		vcpu->arch.st.preempted = 0;
 	}
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 8af874e0b36b..4be70e4f1279 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -54,8 +54,10 @@ static void kvm_vm_init_features(struct kvm *kvm)
 	if (kvm_pvtime_supported()) {
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_PREEMPT);
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
+		kvm->arch.pv_features |= BIT(KVM_FEATURE_PV_TLB_FLUSH);
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_PREEMPT);
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_STEALTIME);
+		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH);
 	}
 	kvm->arch.pv_auto_features = kvm->arch.pv_features;
 }
@@ -159,6 +161,7 @@ static int kvm_vm_feature_has_attr(struct kvm *kvm, struct kvm_device_attr *attr
 	case KVM_LOONGARCH_VM_FEAT_PV_IPI:
 	case KVM_LOONGARCH_VM_FEAT_PV_PREEMPT:
 	case KVM_LOONGARCH_VM_FEAT_PV_STEALTIME:
+	case KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH:
 		if (kvm_vm_support(&kvm->arch, attr->attr))
 			return 0;
 		return -ENXIO;
-- 
2.43.0

