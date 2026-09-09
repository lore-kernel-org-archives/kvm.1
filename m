Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B6471264;
	Wed,  9 Sep 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944485; cv=none; b=OoxNRqtZjDVDompPiz6ArncdVKBATLmuMG8+aZZi1vyiLhTwnS47paP/kyZaq51Xx5gm7+Qn6shZMWVgPTwc5c1tbHaiI3QkMOCqDeDE3Wt0Edqpvi5izP8jioNPtXvweZUBgbuSBrfZ9hRemy6ygjbabhAKPfgcxpZFn8YXxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944485; c=relaxed/simple;
	bh=CyYoOI2a3p8AL1Xo3Y6JDsu3Dhh9jRw9WWZiBJDlPTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e2Pqu4lZjuUyl5nUNalCRHc7VBzj+uMDu8mXnSN0Xe75X+iH9x8rsT5lCEmINe23zzScJ3U+mWtddtZ3ax9APmg6b6GUW/C7z4WtsIf2aKzolOqCCQHuUqzxN+CE9K1hAumQOqWAOjHubL4K6WW7r35abVZtxvY4aKKvpdoH4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxhvBcIKFqnR4KAA--.29153S3;
	Wed, 09 Sep 2026 17:01:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKs5XIKFqL9YdAA--.30784S2;
	Wed, 09 Sep 2026 17:01:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Add hypercall crash support
Date: Wed,  9 Sep 2026 16:53:50 +0800
Message-Id: <20260909085350.2046788-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKs5XIKFqL9YdAA--.30784S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Now generic pvpanic is supported in Linux kernel which will notify VMM
with VM crash event. There is some limitations with pvpanic, such as it
requires good kernel stack or CPU hardware context and panic() C function
is in health state.

Sometimes CPU hardware context or kernel/irq stack is corrupted. Hypercall
code is more direct and low-level crash method, which is useful in
exception entry with assmble language, here add one hypercall code to
support VM crash function, so that VMM can capture CPU crash context
in time.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h      |  1 +
 arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
 arch/loongarch/include/uapi/asm/kvm.h      |  1 +
 arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
 arch/loongarch/kvm/exit.c                  | 11 +++++++++++
 arch/loongarch/kvm/vm.c                    |  3 ++-
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 65d91c3ce313..96f9f1317cad 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -168,6 +168,7 @@ enum emulation_result {
 #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
 					 BIT(KVM_FEATURE_PREEMPT) |	\
 					 BIT(KVM_FEATURE_STEAL_TIME) |	\
+					 BIT(KVM_FEATURE_CRASH)	|	\
 					 BIT(KVM_FEATURE_USER_HCALL) |	\
 					 BIT(KVM_FEATURE_VIRT_EXTIOI))
 
diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index fb17ba0fa101..3b183bb1aaa8 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -14,6 +14,7 @@
 #define KVM_HCALL_CODE_SERVICE		0
 #define KVM_HCALL_CODE_SWDBG		1
 #define KVM_HCALL_CODE_USER_SERVICE	2
+#define KVM_HCALL_CODE_CRASH		3
 
 #define KVM_HCALL_SERVICE		HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SERVICE)
 #define  KVM_HCALL_FUNC_IPI		1
@@ -22,6 +23,7 @@
 #define KVM_HCALL_SWDBG			HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SWDBG)
 
 #define KVM_HCALL_USER_SERVICE		HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_USER_SERVICE)
+#define KVM_HCALL_CRASH			HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_CRASH)
 
 /*
  * LoongArch hypercall return code
@@ -161,6 +163,19 @@ static __always_inline long kvm_hypercall5(u64 fid,
 	return ret;
 }
 
+static __always_inline long kvm_hypercall_crash(void)
+{
+	register long ret asm("a0");
+
+	__asm__ __volatile__(
+		"hvcl "__stringify(KVM_HCALL_CRASH)
+		: "=r" (ret)
+		: : "memory"
+		);
+
+	return ret;
+}
+
 #ifdef CONFIG_PARAVIRT
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
index cd0b5c11ca9c..b222bfc48042 100644
--- a/arch/loongarch/include/uapi/asm/kvm.h
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -106,6 +106,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PTW		8
 #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
 #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
+#define  KVM_LOONGARCH_VM_FEAT_CRASH		11
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loongarch/include/uapi/asm/kvm_para.h
index d28cbcadd276..bf1a0c826ca6 100644
--- a/arch/loongarch/include/uapi/asm/kvm_para.h
+++ b/arch/loongarch/include/uapi/asm/kvm_para.h
@@ -16,6 +16,7 @@
 #define  KVM_FEATURE_IPI		1
 #define  KVM_FEATURE_STEAL_TIME		2
 #define  KVM_FEATURE_PREEMPT		3
+#define  KVM_FEATURE_CRASH		4
 /* BIT 24 - 31 are features configurable by user space vmm */
 #define  KVM_FEATURE_VIRT_EXTIOI	24
 #define  KVM_FEATURE_USER_HCALL		25
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 4f58e6e2cf86..3b6daa946c76 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct kvm_vcpu *vcpu, int ecode)
 		vcpu->run->hypercall.ret = KVM_HCALL_INVALID_CODE;
 		ret = RESUME_HOST;
 		break;
+	case KVM_HCALL_CRASH:
+		if (!kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_CRASH)) {
+			kvm_write_reg(vcpu, LOONGARCH_GPR_A0, KVM_HCALL_INVALID_CODE);
+			break;
+		}
+
+		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+		vcpu->run->system_event.type = KVM_SYSTEM_EVENT_CRASH;
+		vcpu->run->system_event.ndata = 0;
+		ret = RESUME_HOST;
+		break;
 	case KVM_HCALL_SWDBG:
 		/* KVM_HCALL_SWDBG only in effective when SW_BP is enabled */
 		if (vcpu->guest_debug & KVM_GUESTDBG_SW_BP_MASK) {
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 6dabb227a732..e5d10ceb5e67 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PMU);
 
 	/* Enable all PV features by default */
-	kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI);
+	kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI) | BIT(KVM_FEATURE_CRASH);
 	kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
+	kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_CRASH);
 	if (kvm_pvtime_supported()) {
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_PREEMPT);
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.39.3

