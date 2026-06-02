Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97F35E95C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366724; cv=none; b=h48r9fB+lePL1jc4QD5wXQBNrnVYPGQExbkijQXtwmV2R4Ebi4xaMDeebPALkjVZBQx2GJmF3kJOMnPwZSKewbkrV9n2lSkxYl0Pj3b5cnd7kH9jEgJzKLxZNlqH/apJX1nZl29W8RKx/MYmwan2Ywl2EraJJ2CtGs489E6/yzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366724; c=relaxed/simple;
	bh=CXisNRV+IpYGrnkxrtBNyl42doOMtpeUeLF+FCx5PiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG0atUB5DcHAUKSqiOeQGXeuRgYzS9zCyPpwx+wReze9QBGrbLuSO8N72kGGx+UdXnu8K3gd6URT5chAUl4XHOpBhxKgpKmAHjCLXRXGJpLJSejsxioeLksNTJVHtJ/TarWhB7lEe70qa6NGxu7AALjL/oQf3OUSiR84MjnDq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wg27wbHQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wg27wbHQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780366719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVM/quSkpj+xuQPQCkyfmMSkmBKHHCBJJPU+LokLOWU=;
	b=Wg27wbHQkzS1aWihz0s5142JiqGtl182BmsWaYJCfI2P0/737K6GY+pXARWG1InTT7s4ZJ
	St1XMmFlbp+nz5rT7fZtQ326s7Eor5/2ZybtYXZoyU9kAScMeSsEkF729gntiyJ6fKQaFJ
	6h1ayLK1ClRoN3zZy2JpR6ryvy5k4y4=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 2/4] LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
Date: Tue,  2 Jun 2026 10:18:17 +0800
Message-ID: <20260602021819.2373404-3-cui.tao@linux.dev>
In-Reply-To: <20260602021819.2373404-1-cui.tao@linux.dev>
References: <20260602021819.2373404-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Implement paravirtualized TLB flush for LoongArch KVM guests using the
existing steal-time shared memory page.

The mechanism uses the preempted byte in struct kvm_steal_time with an
additional KVM_VCPU_FLUSH_TLB flag bit:

- When a guest vCPU needs remote TLB flush but the target vCPU is
  preempted (not running), it atomically sets KVM_VCPU_FLUSH_TLB in
  the target's steal-time preempted byte instead of sending an IPI.
- When the host re-enters the target vCPU (kvm_update_stolen_time()),
  it atomically reads and clears only the preempted byte via amand_db.w
  with mask ~0xff on the 32-bit aligned word.  amand_db.w provides
  full barrier semantics and avoids the race with guest-side
  try_cmpxchg().  LoongArch is little-endian, so the preempted byte
  occupies bits [7:0]; this preserves pad[0..2] for future UAPI
  extension.  If KVM_VCPU_FLUSH_TLB was set, the host drops the vCPU's
  VPID, which triggers a full TLB flush on the next VM entry via
  kvm_check_vpid().
- For non-preempted vCPUs, the guest falls back to normal IPI-based
  flush, avoiding unnecessary VM exits.

Issue a normal load (unsafe_get_user) before the atomic amand_db.w to
avoid operating on stale cache data when the cache line was last
modified by a different core.

This significantly reduces TLB flush overhead in multi-vCPU workloads
where target vCPUs are often idle/preempted.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_host.h      |  1 +
 arch/loongarch/include/asm/kvm_para.h      |  1 +
 arch/loongarch/include/uapi/asm/kvm.h      |  1 +
 arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
 arch/loongarch/kvm/trace.h                 | 15 +++++++++++
 arch/loongarch/kvm/vcpu.c                  | 30 +++++++++++++++++++++-
 arch/loongarch/kvm/vm.c                    |  3 +++
 7 files changed, 51 insertions(+), 1 deletion(-)

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
index 47a59ce9e561..e4c19d0b8710 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -173,7 +173,35 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	}
 
 	st = (struct kvm_steal_time __user *)ghc->hva;
-	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
+	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
+		u32 old = 0;
+		int err = 0;
+
+		/* Issue a normal load to avoid stale cache data for amand_db.w */
+		unsafe_get_user(old, (u32 __user *)&st->preempted, out);
+
+		/* Atomically read and clear the preempted byte via amand_db.w. */
+		asm volatile(
+		"1: amand_db.w %1, %3, %2	\n"
+		"2:				\n"
+		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)
+		: "+r" (err), "+&r" (old),
+		  "+ZB" (*(u32 *)&st->preempted)
+		: "r" ((u32)~0xffu)
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

