Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97E3D7D70;
	Fri,  8 May 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264263; cv=none; b=jExWYWxQ6Oe34PrC0RdZJ/9zNx7FAEx9IDWKARQigfPfvpPAynMk++TS5JWeWsgfq9WG4uZ1647YnCvNsyknM7RGJm83HOQy7MUNv+X+LhYIyKEHABOZXSGMEPRZIUPT5cr8rUBF+++TFWY4NW7AgDfKTpsiVhAX3JJWf0Vfsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264263; c=relaxed/simple;
	bh=O27nyNn94du8Hn5Mi1rs15u7hoFsjfVlxvRcc/IoALU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocSdhJdo31rbx+PO21MvNOu3YA4kuY4Frr6/p57a8RwVJpha9rwviEzh2bmt9jPytSXJWv+k8+TNxue3ppHkn4fOIdnWgZbjb19bf0yKiLO+zF5w4WJ/a8wDg9BI4jqoIA0VxKTJcPpd2KNG5pA+f6QjOJp5+M5TWkOKWw2U6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HhoPIp8K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HhoPIp8K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=GvtBklbxsq8gFXeoqk09HOHNotOYiYTnyMZsSVGgNas=; b=HhoPIp8Kbtb2jmZCHXjBtfwmtQ
	GfpFGDBebHV2KFBO36zP3dpdW43WjoYvTc5G+QuFEaDjCiTpfI3YkapjePjeTa8Y1E/1Jtl1mlplE
	MsSEJqG50WcZdUDNdApGGsnm3JJKnLF78K6en3x6zN4GWGEopKhvkCbM+VtMKQ9+4CBvyQvu16Z1k
	l4ZyhJ3p7wftJgTb9IEprOSH/OjwhqNyvJA7rlnyJQuXkuX64zPfOe5psn9cNzPby0lNz+JEMQHQV
	1wriD2IDTJcJkunjGM/xYW+N9beCf8434JW9WCC8bIeToWZ2OX+YJ/U0/ez1zP92FIc5+PflR7Zpl
	4Ky4hDXA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlH-00000004XFG-1S2q;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYYg-0GPG;
	Fri, 08 May 2026 19:17:19 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	kernel-dev@igalia.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: [PATCH 2/7] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
Date: Fri,  8 May 2026 19:10:04 +0100
Message-ID: <20260508181717.3230988-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Carsten Stollmaier <stollmc@amazon.com>

This largely reverts commit 7e2175ebd695 ("KVM: x86: Fix recording of
guest steal time / preempted status"), which dropped the use of the
gfn_to_pfn_cache because it was not integrated with the MMU notifiers
at the time. That shortcoming has long since been addressed, making
the GPC work correctly for this use case.

Aside from cleaning up the last	open-coded assembler access to user
addresses and associated explicit asm exception fixups, moving back
to the now-functional GPC also resolves an issue with contention on
the mmap_lock with userfaultfd. The contention issue is as follows:

On vcpu_run, before entering the guest, the update of the steal time
information causes a page-fault if the page is not present. In our
scenario, this gets handled by do_user_addr_fault() and successively
handle_userfault() because the region is registered to that.

Since handle_userfault() uses TASK_INTERRUPTIBLE, it is interruptible
by signals. But do_user_addr_fault() then busy-retries if the pending
signal is non-fatal, which leads to heavy contention of the mmap_lock.

By restoring the use of GPC for accessing the guest steal time, the
contention is avoided and refreshing the GPC happens when the vCPU is
next scheduled.

Since the gfn_to_pfn_cache gives a kernel mapping rather than a
userspace HVA, accesses are now plain C instead of unsafe_put_user()
et al. Use READ_ONCE()/WRITE_ONCE() to prevent the compiler from
reordering or tearing the accesses, and add an smp_wmb() before the
final version increment to ensure the data writes are ordered before
the seqcount update — the old unsafe_put_user() inline assembly acted
as an implicit compiler barrier.

In kvm_steal_time_set_preempted(), use read_trylock() instead of
read_lock_irqsave() since this is called from the scheduler path
where rwlock_t is not safe on PREEMPT_RT (it becomes sleepable).
Since we only trylock and bail on failure, there is no risk of
deadlock with an interrupt handler, so no need to disable interrupts
at all. Setting the preempted flag is best-effort anyway.

Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
Co-developed-by: David Woodhouse <dwmw2@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/x86.c              | 126 ++++++++++++++++----------------
 2 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..6f26c68db4b0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -959,7 +959,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_hva_cache cache;
+		struct gfn_to_pfn_cache cache;
 	} st;
 
 	u64 l1_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..ae71f28cc1c5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3747,10 +3747,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 	u64 steal;
 	u32 version;
 
@@ -3765,42 +3763,26 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
-		     gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
+	read_lock(&gpc->lock);
+	while (!kvm_gpc_check(gpc, sizeof(*st))) {
 		/* We rely on the fact that it fits in a single page. */
 		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
 
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
-		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
+		read_unlock(&gpc->lock);
+
+		if (kvm_gpc_refresh(gpc, sizeof(*st)))
 			return;
+
+		read_lock(&gpc->lock);
 	}
 
-	st = (struct kvm_steal_time __user *)ghc->hva;
+	st = (struct kvm_steal_time *)gpc->khva;
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
 	 */
 	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
-		u8 st_preempted = 0;
-		int err = -EFAULT;
-
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		asm volatile("1: xchgb %0, %2\n"
-			     "xor %1, %1\n"
-			     "2:\n"
-			     _ASM_EXTABLE_UA(1b, 2b)
-			     : "+q" (st_preempted),
-			       "+&r" (err),
-			       "+m" (st->preempted));
-		if (err)
-			goto out;
-
-		user_access_end();
+		u8 st_preempted = xchg(&st->preempted, 0);
 
 		vcpu->arch.st.preempted = 0;
 
@@ -3808,39 +3790,34 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
 			kvm_vcpu_flush_tlb_guest(vcpu);
-
-		if (!user_access_begin(st, sizeof(*st)))
-			goto dirty;
 	} else {
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		unsafe_put_user(0, &st->preempted, out);
+		WRITE_ONCE(st->preempted, 0);
 		vcpu->arch.st.preempted = 0;
 	}
 
-	unsafe_get_user(version, &st->version, out);
+	version = READ_ONCE(st->version);
 	if (version & 1)
 		version += 1;  /* first time write, random junk */
 
 	version += 1;
-	unsafe_put_user(version, &st->version, out);
+	WRITE_ONCE(st->version, version);
 
 	smp_wmb();
 
-	unsafe_get_user(steal, &st->steal, out);
+	steal = READ_ONCE(st->steal);
 	steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
-	unsafe_put_user(steal, &st->steal, out);
+	WRITE_ONCE(st->steal, steal);
+
+	smp_wmb();
 
 	version += 1;
-	unsafe_put_user(version, &st->version, out);
+	WRITE_ONCE(st->version, version);
+
+	kvm_gpc_mark_dirty_in_slot(gpc);
 
- out:
-	user_access_end();
- dirty:
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	read_unlock(&gpc->lock);
 }
 
 /*
@@ -4175,8 +4152,11 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		vcpu->arch.st.msr_val = data;
 
-		if (!(data & KVM_MSR_ENABLED))
-			break;
+		if (data & KVM_MSR_ENABLED)
+			kvm_gpc_activate(&vcpu->arch.st.cache, data & ~KVM_MSR_ENABLED,
+					sizeof(struct kvm_steal_time));
+		else
+			kvm_gpc_deactivate(&vcpu->arch.st.cache);
 
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 
@@ -5239,11 +5219,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 	static const u8 preempted = KVM_VCPU_PREEMPTED;
-	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 
 	/*
 	 * The vCPU can be marked preempted if and only if the VM-Exit was on
@@ -5268,20 +5246,41 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
-		     gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
+	/*
+	 * Use a trylock as this is called from the scheduler path (via
+	 * kvm_sched_out), where rwlock_t is not safe on PREEMPT_RT (it
+	 * becomes sleepable).  Setting preempted is best-effort anyway;
+	 * the old HVA-based code used copy_to_user_nofault() which could
+	 * also silently fail.
+	 *
+	 * Since we only trylock and bail on failure, there is no risk of
+	 * deadlock with an interrupt handler, so no need to disable
+	 * interrupts.
+	 */
+	if (!read_trylock(&gpc->lock))
 		return;
 
-	st = (struct kvm_steal_time __user *)ghc->hva;
+	if (!kvm_gpc_check(gpc, sizeof(*st)))
+		goto out_unlock_gpc;
+
+	st = (struct kvm_steal_time *)gpc->khva;
 	BUILD_BUG_ON(sizeof(st->preempted) != sizeof(preempted));
 
-	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)))
-		vcpu->arch.st.preempted = KVM_VCPU_PREEMPTED;
+	WRITE_ONCE(st->preempted, preempted);
+	vcpu->arch.st.preempted = KVM_VCPU_PREEMPTED;
+
+	kvm_gpc_mark_dirty_in_slot(gpc);
+
+out_unlock_gpc:
+	read_unlock(&gpc->lock);
+}
 
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+static void kvm_steal_time_reset(struct kvm_vcpu *vcpu)
+{
+	kvm_gpc_deactivate(&vcpu->arch.st.cache);
+	vcpu->arch.st.preempted = 0;
+	vcpu->arch.st.msr_val = 0;
+	vcpu->arch.st.last_steal = 0;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -12841,6 +12840,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
 
+	kvm_gpc_init(&vcpu->arch.st.cache, vcpu->kvm);
+
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	else
@@ -12948,6 +12949,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_mmu_unload(vcpu);
 
+	kvm_steal_time_reset(vcpu);
+
 	kvmclock_reset(vcpu);
 
 	for_each_possible_cpu(cpu)
@@ -13068,7 +13071,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	vcpu->arch.apf.msr_en_val = 0;
 	vcpu->arch.apf.msr_int_val = 0;
-	vcpu->arch.st.msr_val = 0;
+
+	kvm_steal_time_reset(vcpu);
 
 	kvmclock_reset(vcpu);
 
-- 
2.51.0

