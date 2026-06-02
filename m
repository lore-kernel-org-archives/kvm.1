Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7D1D63F0
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366725; cv=none; b=pzziGKwLSLbFyT73gGK+nHnok68riyYgG7EGrP6y6x9g0TNHgFMfi3MVnqnUjc8oIZWbmnwtyGVICDynKfVwN4hGof2RIQzOLRav9F6+fZEk6ibAAJfYTU7mTtVovbqldxbg2Cbc38ZDnYBM/DSr+YPhZHM+LEVgKnFILWCSXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366725; c=relaxed/simple;
	bh=6qVlaqnfAZw84yP/G1u6y86Jj3q09+RxxRt3G+Dxg+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF9ePPboQ7PlX7DgITNkxHfRMJdfsEDdRz6j+WUTCHUH2KLryy+8Vt49b1K1QVtTtqfTbS9HZbbjGPmRkaTP97meA8YNU7DBx4eR1XuJMwDrkBuh/TLlXP4sfht4huj5v16my5un7xWSSXYRn4QfhmGF5eP5ii11psW63Zsegtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GEGjr/Fq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GEGjr/Fq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780366722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13cv9B9UR2kCYi2fpq7x8Yr3WT4jO7Q2B7L9URedqUw=;
	b=GEGjr/FqKNZ6Zwwbuix+pXDxJmowTHsw1tc6mVC8ge1FUC9+OtlfBGL2u1L1VCdaktoKqq
	uh/NNjApeVYsKzKhVAoD22YyvfcZsr/D40OKEwbB9XLEKckYdeQHU7Ve9P4H0V2IcUbZb3
	JfdWvl9dq+bcJHxsIa+qOdtNE4RCeKY=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 3/4] LoongArch: KVM: Implement guest-side PV TLB flush
Date: Tue,  2 Jun 2026 10:18:18 +0800
Message-ID: <20260602021819.2373404-4-cui.tao@linux.dev>
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

Add the guest-side implementation of PV TLB flush for LoongArch KVM
guests, complementing the host-side support added in the previous commit.

When running as a KVM guest, remote TLB flushes are optimized by
avoiding IPIs to preempted vCPUs:

- kvm_flush_tlb_mask() checks each target vCPU's steal-time
  preempted flag. If a vCPU is preempted, it atomically sets
  KVM_VCPU_FLUSH_TLB in the shared preempted byte via cmpxchg
  and removes that CPU from the IPI mask.
- Only non-preempted vCPUs receive IPIs via on_each_cpu_mask().
- When the host schedules a deferred-flush vCPU back in, it
  invalidates the VPID and flushes the TLB automatically.

All six SMP TLB flush functions (flush_tlb_all, flush_tlb_mm,
flush_tlb_range, flush_tlb_kernel_range, flush_tlb_page,
flush_tlb_one) are updated to use the PV path when the static
key pv_tlb_flush_key is enabled.

The feature is gated by KVM_FEATURE_PV_TLB_FLUSH and requires
KVM_FEATURE_STEAL_TIME (for the shared memory page). Per-CPU
cpumask buffers are allocated via arch_initcall.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_para.h |  8 ++++
 arch/loongarch/include/asm/paravirt.h | 21 +++++++++++
 arch/loongarch/kernel/paravirt.c      | 54 +++++++++++++++++++++++++++
 arch/loongarch/kernel/smp.c           | 30 ++++++++++++---
 4 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index 28e3fa3b4c0e..7956aeff2436 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -187,4 +187,12 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 	return false;
 }
 
+static inline bool kvm_pv_tlb_flush_supported(void)
+{
+	unsigned int feat = kvm_arch_para_features();
+
+	return (feat & (1U << KVM_FEATURE_PV_TLB_FLUSH)) &&
+	       (feat & (1U << KVM_FEATURE_STEAL_TIME));
+}
+
 #endif /* _ASM_LOONGARCH_KVM_PARA_H */
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
index acae1c5e5f88..6ce62b555a5d 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -5,15 +5,26 @@
 #ifdef CONFIG_PARAVIRT
 
 #include <linux/jump_label.h>
+#include <linux/cpumask.h>
+#include <linux/smp.h>
 
 DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
 DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(pv_tlb_flush_key);
 DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
 
 int __init pv_ipi_init(void);
 int __init pv_time_init(void);
 int __init pv_spinlock_init(void);
 
+void kvm_flush_tlb_mask(const struct cpumask *cpumask,
+			smp_call_func_t func, void *info);
+
+static inline bool pv_tlb_flush_enabled(void)
+{
+	return static_branch_unlikely(&pv_tlb_flush_key);
+}
+
 #else
 
 static inline int pv_ipi_init(void)
@@ -31,5 +42,15 @@ static inline int pv_spinlock_init(void)
 	return 0;
 }
 
+static inline bool pv_tlb_flush_enabled(void)
+{
+	return false;
+}
+
+static inline void kvm_flush_tlb_mask(const struct cpumask *cpumask,
+				       smp_call_func_t func, void *info)
+{
+}
+
 #endif // CONFIG_PARAVIRT
 #endif
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 10821cce554c..34e3ae2d2501 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -12,7 +12,9 @@
 static int has_steal_clock;
 DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
 DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
+DEFINE_STATIC_KEY_FALSE(pv_tlb_flush_key);
 DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
+static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool steal_acc = true;
 
@@ -208,6 +210,58 @@ int __init pv_ipi_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+void kvm_flush_tlb_mask(const struct cpumask *cpumask,
+			       smp_call_func_t func, void *info)
+{
+	int cpu;
+	struct kvm_steal_time *src;
+	struct cpumask *flushmask = this_cpu_cpumask_var_ptr(__pv_cpu_mask);
+
+	cpumask_copy(flushmask, cpumask);
+
+	/*
+	 * We have to call flush only on online vCPUs. And
+	 * queue flush_on_enter for pre-empted vCPUs
+	 */
+	for_each_cpu(cpu, flushmask) {
+		u32 *ptr, old, new;
+
+		src = &per_cpu(steal_time, cpu);
+		ptr = (u32 *)&src->preempted;
+		old = READ_ONCE(*ptr);
+		if (!((u8)old & KVM_VCPU_PREEMPTED))
+			continue;
+
+		new = old | KVM_VCPU_FLUSH_TLB;
+		if (try_cmpxchg(ptr, &old, new))
+			__cpumask_clear_cpu(cpu, flushmask);
+	}
+
+	on_each_cpu_mask(flushmask, func, info, 1);
+}
+
+static int __init pv_tlb_flush_init(void)
+{
+	int cpu;
+
+	if (!kvm_pv_tlb_flush_supported())
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		if (!zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
+					    GFP_KERNEL, cpu_to_node(cpu)))
+			return -ENOMEM;
+	}
+
+	static_branch_enable(&pv_tlb_flush_key);
+	pr_info("KVM setup pv remote TLB flush\n");
+
+	return 0;
+}
+arch_initcall(pv_tlb_flush_init);
+#endif
+
 static int pv_enable_steal_time(void)
 {
 	int cpu = smp_processor_id();
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 50922610758b..bb3451b057ed 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -727,7 +727,10 @@ static void flush_tlb_all_ipi(void *info)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
+	if (pv_tlb_flush_enabled())
+		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_all_ipi, NULL);
+	else
+		on_each_cpu(flush_tlb_all_ipi, NULL, 1);
 }
 
 static void flush_tlb_mm_ipi(void *mm)
@@ -743,7 +746,10 @@ void flush_tlb_mm(struct mm_struct *mm)
 	preempt_disable();
 
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
-		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm, 1);
+		if (pv_tlb_flush_enabled())
+			kvm_flush_tlb_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm);
+		else
+			on_each_cpu_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm, 1);
 	} else {
 		unsigned int cpu;
 
@@ -782,7 +788,10 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned l
 			.addr2 = end,
 		};
 
-		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd, 1);
+		if (pv_tlb_flush_enabled())
+			kvm_flush_tlb_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd);
+		else
+			on_each_cpu_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd, 1);
 	} else {
 		unsigned int cpu;
 
@@ -809,7 +818,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.addr2 = end,
 	};
 
-	on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
+	if (pv_tlb_flush_enabled())
+		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_kernel_range_ipi, &fd);
+	else
+		on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
 }
 
 static void flush_tlb_page_ipi(void *info)
@@ -828,7 +840,10 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 			.addr1 = page,
 		};
 
-		on_each_cpu_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd, 1);
+		if (pv_tlb_flush_enabled())
+			kvm_flush_tlb_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd);
+		else
+			on_each_cpu_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd, 1);
 	} else {
 		unsigned int cpu;
 
@@ -851,6 +866,9 @@ static void flush_tlb_one_ipi(void *info)
 
 void flush_tlb_one(unsigned long vaddr)
 {
-	on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
+	if (pv_tlb_flush_enabled())
+		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_one_ipi, (void *)vaddr);
+	else
+		on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
 }
 EXPORT_SYMBOL(flush_tlb_one);
-- 
2.43.0

