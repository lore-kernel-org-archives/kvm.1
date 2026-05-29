Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866F3DA7D7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073513; cv=none; b=Hb58FBK5+VMKSHlfCNOz/n1N2Dfg1tgL1NZNS/XnMY3okgMa4I3h8ORWs8niure55o6L2pw9jTootw53dSbsuql1xUKGCGyb3n8V5vdYUENOAMHpts1Myr0YqN8ZgFx6TTxZ1D1Vto6C2Oqy48IxIJUypxiyw1X0F0rWIjhWM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073513; c=relaxed/simple;
	bh=CuWNGtalLog0SQTqa1JAed3YyRpBsui1oqSsQSYcxxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LSIx09PX4R3riecIeU0ZM7SpZsY7+2dGs0pvEL/tP2TXotamJn2RoKaBOPQBkeHFeCF5c4tTlI0Qfm+fwKyPoPbeoCUlznf2c+9nCFbUcucdsX2ayyKTFTNniYpNkK9E+YA7MKDEJrhAx1ynnae0lw8z57Vc5YG6LHzFMjMj34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cx2vjLMS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cx2vjLMS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba718173d1so108533865ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073507; x=1780678307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9477XMVZOaF3Qg3+6qo6AFeB6OJQib8BfZbzYj/EN3k=;
        b=cx2vjLMS4rahiqlOkW70cfb0GWPjduyT2SL6ZIt/2J3a7dmLhGJGV9ou/uR5P2K9so
         NSyI6ZH0VzTCqBqs/BLmMRazkUDx+oOjILIk/N9fcd1BUt311wFtwSdAVhfJJcmSaB7D
         v2wsstyYZ47LPUyruuRA740C1pxHprBcxYux/QHRuCdUm/20BYmikc6lhgh8+iqavijW
         rXzmKAS0VRN3wxVDir68M4A2+/O23tq6KSa0Rkn5W9SG+KPCB6EBqvLQCMytMUTQMNZr
         v5fd0Jd2tpi/wQYjpaixYeyf3jByBCxKi6mqIQfTjgZ3QSMIO6BJgcUTrv9qZZIvN6JD
         arWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073507; x=1780678307;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9477XMVZOaF3Qg3+6qo6AFeB6OJQib8BfZbzYj/EN3k=;
        b=UESGZCy//fvqEpO+mluMyacsZPHMFb8FFn3ynpohDAK7VvRrUS0i5agF1kCUfRPsh/
         LYMHT3cMNAbdrl9Uo5ANlol0u/bgBVL30PTvj1+GtSC1iwlyItL6wAX5CEbdJG1LP//s
         fAVfb3aDf3xzEhenZ6sqv4u+1iNonJNq9yW53KdUnShfIYFzWN9nlOjQ1Xda8bn+2h6m
         Noaqf52ZI0wtXuoQyut0KH6NtUzvuBD7PNHbqSKOWCyzZkY6QANyV1B1eUCJOzpCX2bE
         7pNlMTUrDl6Vw5daYK8yvR3PKUnoysYw1f1g1oEMpbP9P2Wb6bUU8RA/yH04u9YT/A5S
         N/KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Qp1j8asFKli+rGYUCPqpnYfTGTaDQ+I6jyPLdicwc+XZrxeBqC8E/6/qhSAliZui6CGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuudjWM+6nBtJSfHA2/OJ3+6DCLbYu1ICrXuacHTD+V1pKD2C
	pfEnqzxuSnN1YpKK4hrutdzPW1iPHvuUErrQhIgkpwSXAzD6yir4hhMzbikehSs/WRdjBLxUudv
	V6/CocA==
X-Received: from plbjy14.prod.google.com ([2002:a17:903:42ce:b0:2bf:3684:64d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e785:b0:2bd:d7b5:83ed
 with SMTP id d9443c01a7336-2bf368d10d5mr7822785ad.39.1780073506459; Fri, 29
 May 2026 09:51:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:14 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-21-seanjc@google.com>
Subject: [PATCH v2 20/20] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
the seqcount update =E2=80=94 the old unsafe_put_user() inline assembly act=
ed
as an implicit compiler barrier.

In kvm_steal_time_set_preempted(), use read_trylock() instead of
read_lock_irqsave() since this is called from the scheduler path
where rwlock_t is not safe on PREEMPT_RT (it becomes sleepable).
Since we only trylock and bail on failure, there is no risk of
deadlock with an interrupt handler, so no need to disable interrupts
at all. Setting the preempted flag is best-effort anyway.

Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/x86.c              | 122 ++++++++++++++------------------
 2 files changed, 54 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 6ae7d539af90..9f652dcdda93 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -983,7 +983,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_hva_cache cache;
+		struct gfn_to_pfn_cache cache;
 	} st;
=20
 	u64 l1_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ea10ed4ab06f..1b27dd9ba0aa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3728,10 +3728,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb=
_flush_requests);
=20
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc =3D &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	gpa_t gpa =3D vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	struct gfn_to_pfn_cache *gpc =3D &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 	u64 steal;
 	u32 version;
=20
@@ -3746,42 +3744,20 @@ static void record_steal_time(struct kvm_vcpu *vcpu=
)
 	if (WARN_ON_ONCE(current->mm !=3D vcpu->kvm->mm))
 		return;
=20
-	slots =3D kvm_memslots(vcpu->kvm);
+	/* We rely on the fact that it fits in a single page. */
+	BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
=20
-	if (unlikely(slots->generation !=3D ghc->generation ||
-		     gpa !=3D ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
-		/* We rely on the fact that it fits in a single page. */
-		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
+	CLASS(gpc_map_local, st_map)(gpc, sizeof(*st));
+	if (IS_ERR(st_map))
+		return;
=20
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
-		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
-			return;
-	}
-
-	st =3D (struct kvm_steal_time __user *)ghc->hva;
+	st =3D *st_map;
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
 	 */
 	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
-		u8 st_preempted =3D 0;
-		int err =3D -EFAULT;
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
+		u8 st_preempted =3D xchg(&st->preempted, 0);
=20
 		vcpu->arch.st.preempted =3D 0;
=20
@@ -3789,39 +3765,30 @@ static void record_steal_time(struct kvm_vcpu *vcpu=
)
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
 		vcpu->arch.st.preempted =3D 0;
 	}
=20
-	unsafe_get_user(version, &st->version, out);
+	version =3D READ_ONCE(st->version);
 	if (version & 1)
 		version +=3D 1;  /* first time write, random junk */
=20
 	version +=3D 1;
-	unsafe_put_user(version, &st->version, out);
+	WRITE_ONCE(st->version, version);
=20
 	smp_wmb();
=20
-	unsafe_get_user(steal, &st->steal, out);
+	steal =3D READ_ONCE(st->steal);
 	steal +=3D current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
-	unsafe_put_user(steal, &st->steal, out);
+	WRITE_ONCE(st->steal, steal);
+
+	smp_wmb();
=20
 	version +=3D 1;
-	unsafe_put_user(version, &st->version, out);
-
- out:
-	user_access_end();
- dirty:
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	WRITE_ONCE(st->version, version);
 }
=20
 /*
@@ -4162,8 +4129,11 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
=20
 		vcpu->arch.st.msr_val =3D data;
=20
-		if (!(data & KVM_MSR_ENABLED))
-			break;
+		if (data & KVM_MSR_ENABLED)
+			kvm_gpc_activate(&vcpu->arch.st.cache, data & ~KVM_MSR_ENABLED,
+					sizeof(struct kvm_steal_time));
+		else
+			kvm_gpc_deactivate(&vcpu->arch.st.cache);
=20
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
=20
@@ -5231,11 +5201,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int c=
pu)
=20
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc =3D &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	static const u8 preempted =3D KVM_VCPU_PREEMPTED;
-	gpa_t gpa =3D vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	struct gfn_to_pfn_cache *gpc =3D &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
=20
 	/*
 	 * The vCPU can be marked preempted if and only if the VM-Exit was on
@@ -5260,20 +5227,32 @@ static void kvm_steal_time_set_preempted(struct kvm=
_vcpu *vcpu)
 	if (unlikely(current->mm !=3D vcpu->kvm->mm))
 		return;
=20
-	slots =3D kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation !=3D ghc->generation ||
-		     gpa !=3D ghc->gpa ||
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
+	CLASS(gpc_try_map_local, st_map)(gpc, sizeof(st->preempted));
+	if (IS_ERR(st_map))
 		return;
=20
-	st =3D (struct kvm_steal_time __user *)ghc->hva;
-	BUILD_BUG_ON(sizeof(st->preempted) !=3D sizeof(preempted));
+	st =3D *st_map;
+	WRITE_ONCE(st->preempted, KVM_VCPU_PREEMPTED);
+	vcpu->arch.st.preempted =3D KVM_VCPU_PREEMPTED;
+}
=20
-	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)))
-		vcpu->arch.st.preempted =3D KVM_VCPU_PREEMPTED;
-
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+static void kvm_steal_time_reset(struct kvm_vcpu *vcpu)
+{
+	kvm_gpc_deactivate(&vcpu->arch.st.cache);
+	vcpu->arch.st.preempted =3D 0;
+	vcpu->arch.st.msr_val =3D 0;
+	vcpu->arch.st.last_steal =3D 0;
 }
=20
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -12819,6 +12798,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
=20
 	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
=20
+	kvm_gpc_init(&vcpu->arch.st.cache, vcpu->kvm);
+
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	else
@@ -12926,6 +12907,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_mmu_unload(vcpu);
=20
+	kvm_steal_time_reset(vcpu);
+
 	kvmclock_reset(vcpu);
=20
 	for_each_possible_cpu(cpu)
@@ -13046,7 +13029,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool ini=
t_event)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	vcpu->arch.apf.msr_en_val =3D 0;
 	vcpu->arch.apf.msr_int_val =3D 0;
-	vcpu->arch.st.msr_val =3D 0;
+
+	kvm_steal_time_reset(vcpu);
=20
 	kvmclock_reset(vcpu);
=20
--=20
2.54.0.823.g6e5bcc1fc9-goog

