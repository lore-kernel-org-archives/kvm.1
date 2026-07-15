Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CC3C2781;
	Wed, 15 Jul 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101141; cv=none; b=kq5EEURJNigKjsYzSaM1nlfBSta2HrVGhDIxiciXq6gxixkjR9oca/Af+4zI5kz6nGkk8N7P9BKWfokxp+CzHwbXxUdLNEji7megbrdYkGhQLp/81+O6C2FRjyTrAJlQKz/ae5v0z3i13pFEf5x3+cEN3c8DEmZoHV2EMSNxZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101141; c=relaxed/simple;
	bh=ZAWtPoNkrkjuoF0Wt0S7hW91PWxOmbRnCU87DvMOglw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Fn81QEvtp06mEBAOzhWWqYs/fR5L9xQdLStCL48S7rYNywQtaqhD3tIoh3mZTpn2Sn4BXPjPCbrI95gs+w1fiYZUWMT93xvE2zxKiR+owWwexSTxTEMklvGekSz3NnpNGGEWG5rHiMd8HxhJH/ixKL13heTOHENsZmYoPuV4W70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J0Lj8TA9; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J0Lj8TA9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784101130; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=SEDCADsN3wGGdI8NmB27WoC70XTHKsbwEeRBRkVTtwI=;
	b=J0Lj8TA9x+hW/smugpRqOwX4sObRyvk8ggnrk/xZO6PMHgx9rFaUSedfQmx5s6yL3+WZiMBf2/blI4/YbsGHlw37FQFma94feLJm0MzVrmr8CPACdHCWteG7iQrkcbHpUVtumy+0SLRidk0Z0cokxCmjF3Jf9gAFCM0/x7wEs+s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X78KrOS_1784101127;
Received: from 30.221.121.144(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0X78KrOS_1784101127 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 15:38:48 +0800
Message-ID: <36863cf7-61b9-4885-946d-1608179fcab4@linux.alibaba.com>
Date: Wed, 15 Jul 2026 15:38:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 vkuznets@redhat.com, geert@linux-m68k.org, sammiee5311@gmail.com,
 lirongqing@baidu.com, schuster.simon@siemens-energy.com,
 kai.huang@intel.com, herongguang@linux.alibaba.com,
 shannon.zhao@linux.alibaba.com
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
From: He Rongguang <herongguang@linux.alibaba.com>
Subject: [PATCH] x86/kvm: introduce pv idle time
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, this patch introduces a PV mechanism for guests to publish their
vCPU idle status and accumulated idle time to the host. This allows
the host to efficiently determine whether a vCPU is currently in its
idle loop, and knows vCPU idled for how long. QEMU patch and ARM64
support patch will follow in a subsequent series.

The guest writes a GPA pointing to a struct kvm_idle_time via
MSR_KVM_PV_IDLE_TIME. When entering idle, the guest sets the flag field
to KVM_PV_VCPU_IDLE. On idle exit, it clears the flag back to
KVM_PV_VCPU_RUNNING and adds the elapsed idle duration to idle_accum
(in nanoseconds).

The host can read the flag at any time through
kvm_arch_is_vcpu_pv_idle() to make better scheduling or resource
allocation decisions. For example, host may overcommit those vCPUs
which are mostly idle. An in-guest agent may be absent, or may not
report the status in time.

The accumulated idle time provides visibility into per-vCPU usage for
monitoring purposes. An in-guest agent can report VM CPU usage, but
this PV mechanism allows the host to obtain guest CPU usage even when
no agent is installed. This is especially helpful when the hypervisor
enables exitless-hlt/mwait (for better guest performance) or when the
guest uses idle halt-polling, both of which make QEMU vCPU thread usage
deviate from the actual in-guest vCPU usage.

This feature is advertised via KVM_FEATURE_PV_IDLE_TIME in CPUID leaf
0x40000001. Guests enable it by writing the appropriate MSR during
initialization, similar to the existing steal time mechanism.

Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
---
 arch/x86/include/asm/kvm_host.h      |  7 +++
 arch/x86/include/asm/kvm_para.h      | 19 +++++++
 arch/x86/include/uapi/asm/kvm_para.h | 24 +++++++++
 arch/x86/kernel/kvm.c                | 76 ++++++++++++++++++++++++++++
 arch/x86/kernel/process.c            |  7 +++
 arch/x86/kvm/cpuid.c                 |  3 +-
 arch/x86/kvm/x86.c                   | 68 +++++++++++++++++++++++++
 7 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h
b/arch/x86/include/asm/kvm_host.h
index 5f6c1ce9673b..bc3fb4755d05 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -985,6 +985,11 @@ struct kvm_vcpu_arch {
 		struct gfn_to_hva_cache cache;
 	} st;

+	struct {
+		u64 msr_val;
+		struct gfn_to_hva_cache cache;
+	} pv_idle_time;
+
 	u64 l1_tsc_offset;
 	u64 tsc_offset; /* current tsc offset */
 	u64 last_guest_tsc;
@@ -2503,6 +2508,8 @@ extern bool kvm_find_async_pf_gfn(struct kvm_vcpu
*vcpu, gfn_t gfn);
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);

+bool kvm_arch_is_vcpu_pv_idle(struct kvm_vcpu *vcpu);
+
 void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				     u32 size);
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/asm/kvm_para.h
b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..cf2675d8c505 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -137,6 +137,22 @@ static __always_inline bool
kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 }

+DECLARE_STATIC_KEY_FALSE(kvm_pv_idle_time_enabled);
+void kvm_pv_vcpu_idle_enter(void);
+void kvm_pv_vcpu_idle_exit(void);
+
+static __always_inline void kvm_idle_enter(void)
+{
+	if (static_branch_unlikely(&kvm_pv_idle_time_enabled))
+		kvm_pv_vcpu_idle_enter();
+}
+
+static __always_inline void kvm_idle_exit(void)
+{
+	if (static_branch_unlikely(&kvm_pv_idle_time_enabled))
+		kvm_pv_vcpu_idle_exit();
+}
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
 #else /* !CONFIG_PARAVIRT_SPINLOCKS */
@@ -172,6 +188,9 @@ static __always_inline bool
kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	return false;
 }
+
+static __always_inline void kvm_idle_enter(void) { }
+static __always_inline void kvm_idle_exit(void) { }
 #endif

 #endif /* _ASM_X86_KVM_PARA_H */
diff --git a/arch/x86/include/uapi/asm/kvm_para.h
b/arch/x86/include/uapi/asm/kvm_para.h
index a1efa7907a0b..5a0ade391ce1 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -36,6 +36,7 @@
 #define KVM_FEATURE_MSI_EXT_DEST_ID	15
 #define KVM_FEATURE_HC_MAP_GPA_RANGE	16
 #define KVM_FEATURE_MIGRATION_CONTROL	17
+#define KVM_FEATURE_PV_IDLE_TIME	18

 #define KVM_HINTS_REALTIME      0

@@ -58,6 +59,29 @@
 #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
 #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
 #define MSR_KVM_MIGRATION_CONTROL	0x4b564d08
+#define MSR_KVM_PV_IDLE_TIME		0x4b564d09
+
+/*
+ * When the guest enters its idle loop it sets ``flag`` to KVM_PV_VCPU_IDLE
+ * and clears it back to KVM_PV_VCPU_RUNNING on exit.  The host can read
+ * ``flag`` at any time to cheaply decide whether the vCPU is currently
idle.
+ *
+ * ``idle_accum`` is accumulated idle time in nanoseconds of this vcpu.
+ */
+struct kvm_idle_time {
+	__u64 flag;
+	__u64 idle_accum;
+	__u32 pad[12];
+};
+
+#define KVM_PV_VCPU_RUNNING	0
+#define KVM_PV_VCPU_IDLE	(1U << 0)
+
+/* Alignment / reserved bits for MSR_KVM_PV_IDLE_TIME */
+#define KVM_PV_IDLE_TIME_ALIGNMENT_BITS	5
+#define KVM_PV_IDLE_TIME_VALID_BITS	((-1ULL <<
(KVM_PV_IDLE_TIME_ALIGNMENT_BITS + 1)))
+#define KVM_PV_IDLE_TIME_RESERVED_MASK	\
+	(((1 << KVM_PV_IDLE_TIME_ALIGNMENT_BITS) - 1) << 1)

 struct kvm_steal_time {
 	__u64 steal;
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dcef84da304b..42c2b7cd186e 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -75,6 +75,16 @@ static DEFINE_PER_CPU_DECRYPTED(struct
kvm_vcpu_pv_apf_data, apf_reason) __align
 DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time)
__aligned(64) __visible;
 static int has_steal_clock = 0;

+static DEFINE_PER_CPU_DECRYPTED(struct kvm_idle_time, pv_idle_time)
__aligned(64);
+static int has_pv_idle_time;
+
+struct kvm_idle {
+	ktime_t idle_start;
+};
+static DEFINE_PER_CPU(struct kvm_idle, kvm_idle);
+
+DEFINE_STATIC_KEY_FALSE(kvm_pv_idle_time_enabled);
+
 static int has_guest_poll = 0;

 #define KVM_TASK_SLEEP_HASHBITS 8
@@ -342,6 +352,61 @@ static void kvm_register_steal_time(void)
 		(unsigned long long) slow_virt_to_phys(st));
 }

+static void kvm_register_pv_idle_time(void)
+{
+	int cpu = smp_processor_id();
+	struct kvm_idle_time *id = &per_cpu(pv_idle_time, cpu);
+
+	if (!has_pv_idle_time)
+		return;
+
+	WRITE_ONCE(id->flag, KVM_PV_VCPU_RUNNING);
+	WRITE_ONCE(id->idle_accum, 0);
+	wrmsrq(MSR_KVM_PV_IDLE_TIME,
+	       (slow_virt_to_phys(id) | KVM_MSR_ENABLED));
+	pr_debug("pv_idle_time: cpu %d, msr %llx\n", cpu,
+		 (unsigned long long) slow_virt_to_phys(id));
+}
+
+static void kvm_disable_pv_idle_time(void)
+{
+	if (!has_pv_idle_time)
+		return;
+
+	wrmsrq(MSR_KVM_PV_IDLE_TIME, 0);
+}
+
+/*
+ * Called from arch_cpu_idle_enter() when KVM_FEATURE_PV_IDLE_TIME is
enabled.
+ * Publishes the idle hint to the hosts
+ */
+void kvm_pv_vcpu_idle_enter(void)
+{
+	struct kvm_idle_time *id = this_cpu_ptr(&pv_idle_time);
+	struct kvm_idle *idle = this_cpu_ptr(&kvm_idle);
+
+	/*
+	 * The host reads this field with READ_ONCE-equivalent semantics.
+	 * No barrier vs. need_resched checks is required: the guest will
+	 * clear the flag again on idle exit either way.
+	 */
+	WRITE_ONCE(id->flag, KVM_PV_VCPU_IDLE);
+	idle->idle_start = ktime_get();
+}
+
+void kvm_pv_vcpu_idle_exit(void)
+{
+	struct kvm_idle_time *id = this_cpu_ptr(&pv_idle_time);
+	struct kvm_idle *idle = this_cpu_ptr(&kvm_idle);
+	s64 idle_time, idle_accum;
+
+	WRITE_ONCE(id->flag, KVM_PV_VCPU_RUNNING);
+	idle_time = ktime_to_ns(ktime_sub(ktime_get(), idle->idle_start));
+	/* only change by one guest vcpu, on x86 64 bit operation should be
atomic by nature */
+	idle_accum = id->idle_accum + idle_time;
+	WRITE_ONCE(id->idle_accum, idle_accum);
+}
+
 static DEFINE_PER_CPU_DECRYPTED(unsigned long, kvm_apic_eoi) =
KVM_PV_EOI_DISABLED;

 static notrace __maybe_unused void kvm_guest_apic_eoi_write(void)
@@ -391,6 +456,9 @@ static void kvm_guest_cpu_init(void)

 	if (has_steal_clock)
 		kvm_register_steal_time();
+
+	if (has_pv_idle_time)
+		kvm_register_pv_idle_time();
 }

 static void kvm_pv_disable_apf(void)
@@ -454,12 +522,14 @@ static void __init sev_map_percpu_data(void)
 		__set_percpu_decrypted(&per_cpu(apf_reason, cpu), sizeof(apf_reason));
 		__set_percpu_decrypted(&per_cpu(steal_time, cpu), sizeof(steal_time));
 		__set_percpu_decrypted(&per_cpu(kvm_apic_eoi, cpu),
sizeof(kvm_apic_eoi));
+		__set_percpu_decrypted(&per_cpu(pv_idle_time, cpu),
sizeof(kvm_idle_time));
 	}
 }

 static void kvm_guest_cpu_offline(bool shutdown)
 {
 	kvm_disable_steal_time();
+	kvm_disable_pv_idle_time();
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		wrmsrq(MSR_KVM_PV_EOI_EN, 0);
 	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
@@ -843,6 +913,12 @@ static void __init kvm_guest_init(void)
 #endif
 	}

+	if (kvm_para_has_feature(KVM_FEATURE_PV_IDLE_TIME)) {
+		has_pv_idle_time = 1;
+		static_branch_enable(&kvm_pv_idle_time_enabled);
+		pr_info("enable pv idle time\n");
+	}
+
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_update_callback(eoi, kvm_guest_apic_eoi_write);

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 85435044e33c..eb18a87a2dbd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -51,6 +51,7 @@
 #include <asm/frame.h>
 #include <asm/unwind.h>
 #include <asm/tdx.h>
+#include <asm/kvm_para.h>
 #include <asm/mmu_context.h>
 #include <asm/msr.h>
 #include <asm/shstk.h>
@@ -790,6 +791,12 @@ void arch_cpu_idle_enter(void)
 {
 	tsc_verify_tsc_adjust(false);
 	local_touch_nmi();
+	kvm_idle_enter();
+}
+
+void arch_cpu_idle_exit(void)
+{
+	kvm_idle_exit();
 }

 void __noreturn arch_cpu_idle_dead(void)
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 591d2294acd7..f9bca6f7717b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1723,7 +1723,8 @@ static inline int __do_cpuid_func(struct
kvm_cpuid_array *array, u32 function)
 			     (1 << KVM_FEATURE_PV_SEND_IPI) |
 			     (1 << KVM_FEATURE_POLL_CONTROL) |
 			     (1 << KVM_FEATURE_PV_SCHED_YIELD) |
-			     (1 << KVM_FEATURE_ASYNC_PF_INT);
+			     (1 << KVM_FEATURE_ASYNC_PF_INT) |
+			     (1 << KVM_FEATURE_PV_IDLE_TIME);

 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..5453f7a7b964 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -411,6 +411,7 @@ static const u32 emulated_msrs_all[] = {

 	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
 	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
+	MSR_KVM_PV_IDLE_TIME,

 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSC_DEADLINE,
@@ -3875,6 +3876,31 @@ static void kvm_get_xstate_msr(struct kvm_vcpu
*vcpu, struct msr_data *msr_info)
 	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_R);
 }

+static int kvm_set_msr_pv_idle_time(struct kvm_vcpu *vcpu, u64 data)
+{
+	int ret;
+	struct gfn_to_hva_cache *ghc = &vcpu->arch.pv_idle_time.cache;
+	gpa_t gpa = data & KVM_PV_IDLE_TIME_VALID_BITS;
+
+	if (data & KVM_PV_IDLE_TIME_RESERVED_MASK)
+		return 1;
+
+	vcpu->arch.pv_idle_time.msr_val = data;
+
+	if (data & KVM_MSR_ENABLED) {
+		/* We rely on the fact that it fits in a single page. */
+		BUILD_BUG_ON((sizeof(struct kvm_idle_time) - 1) &
+			     KVM_PV_IDLE_TIME_VALID_BITS);
+
+		ret = kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa,
+						sizeof(struct kvm_idle_time));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u32 msr = msr_info->index;
@@ -4178,6 +4204,15 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu,
struct msr_data *msr_info)
 		vcpu->arch.msr_kvm_poll_control = data;
 		break;

+	case MSR_KVM_PV_IDLE_TIME: {
+		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_IDLE_TIME))
+			return 1;
+
+		if (kvm_set_msr_pv_idle_time(vcpu, data))
+			return 1;
+		break;
+	}
+
 	case MSR_IA32_MCG_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
@@ -4528,6 +4563,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu,
struct msr_data *msr_info)

 		msr_info->data = vcpu->arch.msr_kvm_poll_control;
 		break;
+	case MSR_KVM_PV_IDLE_TIME:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_IDLE_TIME))
+			return 1;
+
+		msr_info->data = vcpu->arch.pv_idle_time.msr_val;
+		break;
 	case MSR_IA32_P5_MC_ADDR:
 	case MSR_IA32_P5_MC_TYPE:
 	case MSR_IA32_MCG_CAP:
@@ -11801,6 +11842,30 @@ int kvm_emulate_ap_reset_hold(struct kvm_vcpu
*vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_ap_reset_hold);

+static bool kvm_arch_pv_idle_time_enabled(struct kvm_vcpu *vcpu)
+{
+	return (vcpu->arch.pv_idle_time.msr_val & KVM_MSR_ENABLED);
+}
+
+bool kvm_arch_is_vcpu_pv_idle(struct kvm_vcpu *vcpu)
+{
+	struct gfn_to_hva_cache *ghc = &vcpu->arch.pv_idle_time.cache;
+	struct kvm_idle_time idle;
+
+	if (!kvm_arch_pv_idle_time_enabled(vcpu))
+		return false;
+
+	if (!ghc->memslot)
+		return false;
+
+	if (kvm_read_guest_offset_cached(vcpu->kvm, ghc, &idle.flag,
+					 offsetof(struct kvm_idle_time, flag),
+					 sizeof(idle.flag)))
+		return false;
+
+	return !!(idle.flag & KVM_PV_VCPU_IDLE);
+}
+
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_apicv_active(vcpu) &&
@@ -13009,6 +13074,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool
init_event)
 	vcpu->arch.apf.msr_en_val = 0;
 	vcpu->arch.apf.msr_int_val = 0;
 	vcpu->arch.st.msr_val = 0;
+	vcpu->arch.pv_idle_time.msr_val = 0;
+	memset(&vcpu->arch.pv_idle_time.cache, 0,
+	       sizeof(vcpu->arch.pv_idle_time.cache));

 	kvmclock_reset(vcpu);

-- 
2.52.0

