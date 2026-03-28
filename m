Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCA38F9C
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774709411; cv=none; b=dSXA2bNJMCFc+XVG+BdzuWrGRu+1jxBf+n99kIhIvGOdHRswoHUzPUv1oBO0ENhN+LsgWqxS/sIc2tZx8n8JcRzIrAzaDWsvCsRFuIoj1xOrL4h5KpVQlYyJI60zosSvJ+41MvEbt3swaoJAaqswl89SwYBxJSojYbx6O+dfoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774709411; c=relaxed/simple;
	bh=W/dF5TM5llUTLZ/uWOcqXpRf3oDbfH+06zQyU1PsRSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsUY/rSb28k8a1iy7mj9TkutB7qeEDJ1y/tL+L/gdRY41Z1L8eusbDe7C6TSqz4X2TnTbBsMMn529dHB+IhAnRx51k3q21TyhmBtAHDGiGcRalRR6pA6IdCkM45fk8VGc+vPeD/mqKAdxSuYT/cgw9oU9a66PGAh/ITmWyUQ/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkbdHUep; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkbdHUep"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so30277005ad.2
        for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774709409; x=1775314209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smegvq7/E5Ae3Bgud8MEFapuzExHDZ3+vLTBeNIrvmw=;
        b=TkbdHUeppERc8GuW6hPFX384DR1OZDbU6oIjF5XI+VwxnPItmKFW1iVoP0/8KNN+ki
         dVT+eTLuPQFxlxWTCA95n0RVJVMia55FXtJIZUR+n/0w7WDkfPKuNfNucuSn9aQkhpQw
         LyfySx6MZlslrA0CsufpXQeLhYHaOT9sRBQ9yMtgO+NEUjTlkfzV/XcsAelFcOPbjtPe
         1SyMNmdwvWfFzf9XeaXtHqGWFhp1UmCCQP5yJnGtO7oCji3jqrd4E9zsRlMFyBUBq33K
         IAd3Jk/LibntiiuM85YIjxIVTEqixh4InQEAfxDQFXODPN+hYQUK8N+pl3SKlYTfKkWl
         06Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774709409; x=1775314209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smegvq7/E5Ae3Bgud8MEFapuzExHDZ3+vLTBeNIrvmw=;
        b=HLb5Wt7FtgaiphjJipdjAosk8imvrTbHjvqZY5SUHowjyYCL6mGAnXYa1kOmhQOSUP
         f4eXm/GQqteXpRJvggLfWRfclSna91JYce2VHjg31dlOwKn5JMH02guSwa8dr8351cP1
         +rYXm4Yyg0DKins/9u0uTyxZsuF1KAMdGogw7W3UBVZdAuRp3chqSUQ2IIDSzkpbyJfI
         NPVtQ27mWCK0N/vi3BcO/jQN4ZHT8h6Xht4W6LC8bVjLKrr0+ZmpVQpmbyqzzhgNjjAc
         LhB/6qBkgCW1J/3VSXu3mekhLtYqAVDID4JEbHZFXhctW5MebjfEIikxTSt1RMegDkrH
         a/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUgX50Y6uptDk8yZTV0H22UYtsx7bLKJaSy4pnM9u35B0dFMlM0usUFpxtKzU+ac4u84c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcc60ZZgIIcH0vMueU2b8xTgTEn/wDUxBqXEeWuOa5bS9eVkB
	soDpHnM5nyHThaLz8uW0owlFgIpKM0XYTVV9KvERqvkpR15DWB14x7RlvxfBTRvI
X-Gm-Gg: ATEYQzy13Jkwd5ClAp2HO7tdpweP2p0DEhBWmGKXfdiXFXIoeICEcuFuH/XVWZA6E/j
	ByngGblF/dP+wcf/25J8jGeGlTbpaAHjArjaEHiVIT8NXOXvrLLblsTg0X7w3cEKFvxYOxd37UJ
	OXwQrfXcIkYadeDaSy4uxdO0BUWvsck6Vd8mz+LD3A8BqvlxquGSVDC9EzoHx3T6lovspwknGeC
	C+UVrXhz39V1naK01wazTfkcCcxJdxjz/T4lpVBQ9i3hHmjz4Da7tE1l6Oj4GeTVWil6oxIlslO
	nrZJFi6dUGXv9E3S+qY9bqczZkNsHHUJxlWCxAPnYFrB5nZvdDxblNrYujigAQKla7Av7fn7Dye
	GBMqcZf+yS5WA2ugJTRDgqZyOvV1Q1xJ6PSyIUIW7DgbtmOucV2BjlnfkapFUBEZSjSTvfG40vo
	5nDC/8ri/gt6/EAGZMrEmFvoJm
X-Received: by 2002:a17:903:2f85:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b0cdc207demr71113865ad.10.1774709409030;
        Sat, 28 Mar 2026 07:50:09 -0700 (PDT)
Received: from localhost ([27.7.157.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242677d3dsm29553965ad.29.2026.03.28.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:50:08 -0700 (PDT)
Date: Sat, 28 Mar 2026 20:20:05 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kvm <kvm@vger.kernel.org>,
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>, me@brighamcampbell.com
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
Message-ID: <acfqnRZ4A_aYnm09@acer-nitro-anv15-41>
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de>
 <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41>
 <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41>
 <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
 <acNwYsm4GfViqiJS@acer-nitro-anv15-41>
 <CABgObfb8POHRUmhu2yoH7B=m5eg_VQpmDcPoj=PttaRkN=dQTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfb8POHRUmhu2yoH7B=m5eg_VQpmDcPoj=PttaRkN=dQTg@mail.gmail.com>

On Thu, Mar 26, 2026 at 07:23:58PM +0100, Paolo Bonzini wrote:
> Il mer 25 mar 2026, 06:19 shaikh kamaluddin
> <shaikhkamal2012@gmail.com> ha scritto:
> >
> > 1. Added oom_enter callback to struct mmu_notifier_ops in include/linux/mmu_notifier.h
> > 2. Implemented __mmu_notifier_oom_enter() in mm/mmu_notifier.c to invoke registered callbacks
> > 3. Called mmu_notifier_oom_enter(mm) from __oom_kill_process in mm/oom_kill.c before any invalidations
> > 4. As per your suggestion, move existing kvm_destroy_vm() logic that already handles unbalanced invalidation to the new helper function kvm_mmu_notifier_detach() and invoke it from the kvm_destroy_vm()
> 
> This is not fully clear to me... It could be caused by a recursive
> locking, or also a false positive. It's hard to say without seeing the
> full backtrace, but seeing "lock(srcu)" is suspicious.
> 
> I wouldn't have expected deferral to be necessary; and it seems to me
> that, if you defer removal to some time after the OOM reaper starts,
> you'd have the same problem as before with sleeping spinlocks.
> 
> Can you post the original patch without deferral?
> 
> Paolo
>
Hi Paolo,

Here's the current implementation without deferral as you requested.

As you suspected, it causes an SRCU deadlock. The callback calls
kvm_mmu_notifier_detach() which attempts mmu_notifier_unregister()
while __mmu_notifier_oom_enter is holding SRCU.

Kernel log shows:
  WARNING: possible recursive locking detected
  lock(srcu) at __synchronize_srcu
  already holding lock at __mmu_notifier_oom_enter

Should the callback simply set a flag (kvm->oom_reaping) and have
invalidate_range_start check this flag to return early?

Current implementation (diff attached):
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 07a2bbaf86e9..bdc035242f13 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -88,6 +88,23 @@ struct mmu_notifier_ops {
 	void (*release)(struct mmu_notifier *subscription,
 			struct mm_struct *mm);

+	/*
+	 * Called when the OOM reaper is about to reap this mm.
+	 * This is invoked before any invalidation attempts and allows
+	 * the subscriber to handle the fact that OOM reclaim will proceed
+	 * in non-blockable mode.
+	 *
+	 * This callback is optional and is called in atomic context.
+	 * It must not sleep or use any locks that may block.
+	 *
+	 * Common use case: unregister the MMU notifier to avoid being
+	 * called back in non-blockable invalidation context where
+	 * sleeping locks cannot be used.
+	 *
+	 * This is called with a reference held on the mm_struct.
+	 */
+	void (*oom_enter)(struct mmu_notifier *subscription,
+			  struct mm_struct *mm);
 	/*
 	 * clear_flush_young is called after the VM is
 	 * test-and-clearing the young/accessed bitflag in the
@@ -375,6 +392,7 @@ mmu_interval_check_retry(struct mmu_interval_notifier *interval_sub,

 extern void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
+extern void __mmu_notifier_oom_enter(struct mm_struct *mm);
 extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 					  unsigned long start,
 					  unsigned long end);
@@ -402,6 +420,13 @@ static inline void mmu_notifier_release(struct mm_struct *mm)
 		__mmu_notifier_release(mm);
 }

+static inline void mmu_notifier_oom_enter(struct mm_struct *mm)
+{
+	if (mm_has_notifiers(mm))
+		__mmu_notifier_oom_enter(mm);
+
+}
+
 static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
 					  unsigned long start,
 					  unsigned long end)
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index a6cdf3674bdc..7c2259fabb6d 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -359,6 +359,27 @@ void __mmu_notifier_release(struct mm_struct *mm)
 		mn_hlist_release(subscriptions, mm);
 }

+void __mmu_notifier_oom_enter(struct mm_struct *mm)
+{
+	struct mmu_notifier *subscription;
+	int id;
+	pr_info("Entering :func:%s\n", __func__);
+	if (!mm->notifier_subscriptions)
+		return;
+
+	id = srcu_read_lock(&srcu);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist,
+				 rcu_read_lock_held(&srcu)) {
+		if(subscription->ops->oom_enter)
+			subscription->ops->oom_enter(subscription, mm);
+
+	}
+	srcu_read_unlock(&srcu, id);
+	pr_info("Done:%s\n", __func__);
+
+}
+
 /*
  * If no young bitflag is supported by the hardware, ->clear_flush_young can
  * unmap the address and return 1 or 0 depending if the mapping previously
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5c6c95c169ee..9b487b210980 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -947,6 +947,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	mm = victim->mm;
 	mmgrab(mm);

+	/* Notify MMU notifiers about the OOM event */
+	mmu_notifier_oom_enter(mm);
+
 	/* Raise event before sending signal: task reaper must see this */
 	count_vm_event(OOM_KILL);
 	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1bc1da66b4b0..ffa40ebab452 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -885,6 +885,43 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
 	srcu_read_unlock(&kvm->srcu, idx);
 }

+static void kvm_mmu_notifier_detach(struct kvm *kvm)
+{
+    /* Ensure this function is only executed once */
+    if (xchg(&kvm->mn_killed, 1))
+        return;
+
+    /* Unregister the MMU notifier */
+    mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
+
+    /*
+     * At this point, pending calls to invalidate_range_start()
+     * have completed but no more MMU notifiers will run, so
+     * mn_active_invalidate_count may remain unbalanced.
+     * No threads can be waiting in kvm_swap_active_memslots() as the
+     * last reference on KVM has been dropped, but freeing
+     * memslots would deadlock without this manual intervention.
+     *
+     * If the count isn't unbalanced, i.e. KVM did NOT unregister its MMU
+     * notifier between a start() and end(), then there shouldn't be any
+     * in-progress invalidations.
+     */
+
+    WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
+    if (kvm->mn_active_invalidate_count)
+        kvm->mn_active_invalidate_count = 0;
+    else
+        WARN_ON(kvm->mmu_invalidate_in_progress);
+}
+
+static void kvm_mmu_notifier_oom_enter(struct mmu_notifier *mn,
+					struct mm_struct *mm)
+{
+	struct kvm *kvm;
+	kvm = container_of(mn, struct kvm, mmu_notifier);
+	kvm_mmu_notifier_detach(kvm);
+}
+
 static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
 	.invalidate_range_start	= kvm_mmu_notifier_invalidate_range_start,
 	.invalidate_range_end	= kvm_mmu_notifier_invalidate_range_end,
@@ -892,6 +929,7 @@ static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
 	.clear_young		= kvm_mmu_notifier_clear_young,
 	.test_young		= kvm_mmu_notifier_test_young,
 	.release		= kvm_mmu_notifier_release,
+	.oom_enter		= kvm_mmu_notifier_oom_enter,
 };

 static int kvm_init_mmu_notifier(struct kvm *kvm)
@@ -1280,24 +1318,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->buses[i] = NULL;
 	}
 	kvm_coalesced_mmio_free(kvm);
-	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
-	/*
-	 * At this point, pending calls to invalidate_range_start()
-	 * have completed but no more MMU notifiers will run, so
-	 * mn_active_invalidate_count may remain unbalanced.
-	 * No threads can be waiting in kvm_swap_active_memslots() as the
-	 * last reference on KVM has been dropped, but freeing
-	 * memslots would deadlock without this manual intervention.
-	 *
-	 * If the count isn't unbalanced, i.e. KVM did NOT unregister its MMU
-	 * notifier between a start() and end(), then there shouldn't be any
-	 * in-progress invalidations.
-	 */
-	WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
-	if (kvm->mn_active_invalidate_count)
-		kvm->mn_active_invalidate_count = 0;
-	else
-		WARN_ON(kvm->mmu_invalidate_in_progress);
+
+	/* Detach the MMU notifier before unregistering it */
+	kvm_mmu_notifier_detach(kvm);
 	kvm_arch_destroy_vm(kvm);
 	kvm_destroy_devices(kvm);
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {


Thanks,
Kamal
> >
> > Key Design Decision:
> > ------------------------------
> > Implementation point no 4, while testing, Issue I was encountering is a recursive locking problem with the srcu lock, which is being acquired twice in the same context. This happens during the __mmu_notifier_oom_enter() and __synchronize_srcu() calls, leading to a potential deadlock.
> > Please find below log snippet while launching the Guest VM
> 
