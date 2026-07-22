Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A433B951
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729325; cv=none; b=Uz0flgLva5bUrbelAJXL3GOmAUc/PZqAUGjMCChPF25u0VSF7yowtzhv/d0p4x8Pwz9jhham+2m9xMsC8/4rq/723E/v2CB5cO1QdEp56K2NySu24cjV7a9E/uaS3vZVtW+Vi93Hz7yYbReDPpaVH0URmS65oNTJfz5EzlWjBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729325; c=relaxed/simple;
	bh=No6SdoQiYr9B/ryNMaWYgMU3mXiy1dvXLxFrP4NREg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TacJWdSbLh3elpCtw/WySV26yImrSRWzBwgYoF4OooGs2EPm+hoB1ixBEBRDT7NNq9AITJNNrwmJ46NheQvAfSpvsgCSHswiZdc6/dkjTL0rugdaO57KntVe9J1jqozApSdsbWZt/XSfRRBBrb40t2CR5WOM2FlVRuAlTTNKy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFG9wdiB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFG9wdiB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so46134345ad.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784729323; x=1785334123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3yARu6zIPkjRYLYFArLzUNGA0rAwOd58nNqNxGvnf8=;
        b=pFG9wdiBCqSUHte2dai03q5COkENlhWe2QvGOee1M8bCC5qpc0PawdEyhRSf0cMIuC
         mNnu8SVVm86vZe8IU/VHLeUPK6oUk0yQpmZ/SYjU5ckrHLQG9kSORlDxbOCMTiSk7vXY
         ITZYtx9NrnYYCxHRZX8r71VA9qesMArvaTQa9mfmZgFr8kj0+QfH2rTdY0jwFCnQ9vnr
         ia0Zhuw1ISYxFm9BbxjQIpQ9RxAaKN8FrHS7TfoLp5E7XW4BEuHk+pvQQ0FxKtnW5WEF
         SbNwN9lnEi8pPYF3x/5Sju6bmX9yEtrRuaftp05U0Gh67ENaITyLmAZVYVif8hkleRXL
         IUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729323; x=1785334123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3yARu6zIPkjRYLYFArLzUNGA0rAwOd58nNqNxGvnf8=;
        b=e3pcBOXtR5vc/+GSIArwuguyuGVcbYeVOz5RMgB85CaLqCAvq3FR/5K2TLXU0JdzLV
         a6WL1nqQWf96H0bH/WpnYa9dqLguLQ+xfSGQUw9FusGg98/pmWiu92XnWkXdp7YC1MR8
         vnG5csnUuSTkDZC/QRaC9gmjVIR84p1ICwjz4GtBLQ8nneGeMt4zYbI7A7Yvn9Z08PJX
         z4JSITX0aKTwVDZGt6VcItJpGkXtgEk3yEtWsGARMh4og8IwEVeQqDxuXrYyMXfzxV1l
         ky3j/Eg7TX4rZ1ZqM+7Y+JJUYkvsucakDXT6uDfgmrDHsokNO+p4zdHAptDgVrv/nh63
         u+8w==
X-Forwarded-Encrypted: i=1; AHgh+RomTrGimpsbN5UwgX8nASSwAgTIkgMkKv1i2DaFKf0DP69AS5+yFhCF4Y3AYaU600yCkCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQEWt+e6qbY2SHKjmt8pKM8Ftx+33tui4e3BR8fztPYNcajti
	+iFZJAuGtWWb7eoGbgD50C8tRRfMWCpfn5ScQrBWFv34AEF4Gthmxybq
X-Gm-Gg: AR+sD13P19XBQmD+NmKZgfdbSnZqp4vXNOoJlisJUiuRgbmbbU41mIhimQ2zbxO8v0V
	4eCxAq4tyqLa+R1sHOfbg+evrv04PG0w/3frmi/0mfZEWS3yR70w1YR2LVAjpdXnF2CqbbB9IeY
	opxnsRbaPExwOS3dR+72sIXGC67QS8dghekBQOdmyy+JNlo27yB97K3ElwznMd+Q32W4ICwwNML
	YvBS7BazIejLaS0IlJ8T7rullJQRZqU6w6DMUL9+oXI027PrGZk0kNeXjs4tf0zFX7zEqSMbwRI
	vq5UCAtk9eNX/ZqecaoUsjmwuN7erEE9XhU3mVriDkWmUBtpA0v7LyUlIkWr2cjykvisX++jwqz
	AH2jJ5qliKmZ1xS8TFV2tErJKHTZEZN/hLC1p0oi2UVkaYxjFQIk4p0IK9yI1skuMhnUPob1jht
	+Rsv07x1+iJAb4TZ+QKEw0AaLV0EI8+ds=
X-Received: by 2002:a17:903:380f:b0:2c1:ea95:8297 with SMTP id d9443c01a7336-2cf3483687bmr238643635ad.7.1784729322524;
        Wed, 22 Jul 2026 07:08:42 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e65e6sm16026145ad.38.2026.07.22.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:08:40 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: seanjc@google.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mm/mmu_notifier: Add async OOM cleanup via call_srcu()
Date: Wed, 22 Jul 2026 19:38:03 +0530
Message-ID: <20260722140803.11421-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an mm undergoes OOM kill, the OOM reaper unmaps memory while
holding the mmap_lock in a non-blocking context set up by
mmu_notifier_invalidate_range_start_nonblock(). MMU notifier
subscribers (notably KVM) acquire sleeping locks in their
invalidate callbacks, which deadlocks on PREEMPT_RT where
spinlock_t is a sleeping rt_mutex:

  BUG: sleeping function called from invalid context at
  kernel/locking/spinlock_rt.c:48
  in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 40,
  name: oom_reaper
  Call Trace:
   rt_spin_lock
   kvm_mmu_notifier_invalidate_range_start
   __mmu_notifier_invalidate_range_start
   zap_vma_for_reaping
   __oom_reap_task_mm

Implement the asynchronous cleanup design proposed by Paolo
Bonzini in v1 review: a new optional after_oom_unregister
callback in struct mmu_notifier_ops, invoked after the SRCU grace
period via call_srcu() so that no readers can still reference the
subscription when cleanup runs.

The flow is:

  1. The OOM reaper calls mmu_notifier_oom_enter() from
     __oom_reap_task_mm(), before the non-blocking VMA zap loop.
  2. mmu_notifier_oom_enter() walks the subscription list and, for
     each subscriber that provides after_oom_unregister, detaches
     the subscription from the active list and schedules a
     call_srcu() callback. The reaper's subsequent invalidations
     therefore never invoke the subscriber's callbacks.
  3. The deferred callback invokes after_oom_unregister once the
     grace period has elapsed and all in-flight readers have
     finished.
  4. Subsystems waiting to free structures referenced by the
     callback can call the new mmu_notifier_barrier() helper, which
     wraps srcu_barrier() to wait for all outstanding callbacks
     scheduled this way.

Paolo's original sketch called synchronize_srcu() from
mmu_notifier_oom_enter() before invoking the callbacks. That
blocks the OOM reaper waiting for a grace period and can deadlock:
the reaper holds mmap_lock while waiting for SRCU readers to
drain, while an in-flight reader can itself be blocked on
mmap_lock. Use call_srcu() instead so the reaper never waits; the
callback runs asynchronously once the grace period elapses, and
mmu_notifier_barrier() provides the synchronization point for
teardown paths that need to wait.

after_oom_unregister is mutually exclusive with alloc_notifier
because allocated notifiers can have additional outstanding
references that the OOM path cannot safely drop.

Update KVM to provide after_oom_unregister, which clears
mn_active_invalidate_count, and to detect via hlist_unhashed() in
kvm_destroy_vm() when its subscription was already detached by the
OOM path; in that case call mmu_notifier_barrier() and drop the mm
reference rather than calling mmu_notifier_unregister().

Tested under virtme-ng with PREEMPT_RT, KASAN, and lockdep
enabled, using a minimal KVM test program (opens /dev/kvm, creates
a VM, registers memory, creates a vCPU, and sleeps) driven through
a CONFIG_DEBUG_VM-only debugfs trigger (not part of this patch)
that invokes __oom_reap_task_mm() on the target task. With the
patch applied, mmu_notifier_oom_enter() detaches the KVM
subscription, the call_srcu() callback runs after the SRCU grace
period, KVM's after_oom_unregister clears
mn_active_invalidate_count, and mmu_notifier_barrier() returns
cleanly in kvm_destroy_vm(), with no KASAN reports, kernel BUGs,
or lockdep splats across 20 stress iterations. The same setup
reproduces the syzbot-reported warning on an unpatched PREEMPT_RT
kernel; it is no longer observed with this patch applied.

If the GFP_ATOMIC allocation in mmu_notifier_oom_enter() fails,
the after_oom_unregister callback for that subscription is
skipped rather than retried, since retrying could sleep and
reintroduce the deadlock this patch fixes. The subscription is
still cleaned up later via the normal unregister path.

Fixes: 52ac8b358b0c ("KVM: Block memslot updates across range_start() and range_end()")
Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/all/CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605031109.uxckW5L3-lkp@intel.com/

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
Changes in v3:
- Rebase onto v7.2-rc3; v2 was based on stale v7.0 which the
  kernel test robot could not apply to current trees
- Add missing static inline stub for mmu_notifier_oom_enter() in
  the !CONFIG_MMU_NOTIFIER section of include/linux/mmu_notifier.h,
  fixing allnoconfig build failures reported by the kernel test
  robot
- Use kmalloc_obj() per current allocation idiom
- Add Fixes: tag identifying the commit that introduced
  mn_invalidate_lock

Changes in v2:
- Complete redesign per Paolo's v1 review: moved from a
  KVM-internal locking change to a new mm/mmu_notifier
  after_oom_unregister callback with call_srcu() async cleanup
  (hence the subject prefix change from KVM: to mm/)
- Add mmu_notifier_barrier() (srcu_barrier wrapper) for teardown
  synchronization in kvm_destroy_vm()
- Move call site to __oom_reap_task_mm(); use hlist_del_init() to
  keep hlist_unhashed() correct and avoid use-after-free on the
  stack-allocated oom_list head

v2: https://lore.kernel.org/all/20260429222548.25475-1-shaikhkamal2012@gmail.com/
v1: https://lore.kernel.org/all/20260209161527.31978-1-shaikhkamal2012@gmail.com/

 include/linux/mmu_notifier.h |  14 ++++
 mm/mmu_notifier.c            | 122 +++++++++++++++++++++++++++++++++++
 mm/oom_kill.c                |   3 +
 virt/kvm/kvm_main.c          |  27 +++++++-
 4 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index a11a44eef521..a1820a487854 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -88,6 +88,14 @@ struct mmu_notifier_ops {
 	void (*release)(struct mmu_notifier *subscription,
 			struct mm_struct *mm);
 
+	/*
+	 * Any mmu notifier that defines this is automatically unregistered
+	 * when its mm is the subject of an OOM kill.  after_oom_unregister()
+	 * is invoked after all other outstanding callbacks have terminated.
+	 */
+	void (*after_oom_unregister)(struct mmu_notifier *subscription,
+				     struct mm_struct *mm);
+
 	/*
 	 * clear_flush_young is called after the VM is
 	 * test-and-clearing the young/accessed bitflag in the
@@ -424,6 +432,8 @@ bool __mmu_notifier_clear_young(struct mm_struct *mm,
 		unsigned long start, unsigned long end);
 bool __mmu_notifier_test_young(struct mm_struct *mm,
 		unsigned long address);
+void mmu_notifier_oom_enter(struct mm_struct *mm);
+void mmu_notifier_barrier(void);
 extern int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r);
 extern void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *r);
 extern void __mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
@@ -643,6 +653,10 @@ static inline void mmu_notifier_synchronize(void)
 {
 }
 
+static inline void mmu_notifier_oom_enter(struct mm_struct *mm)
+{
+}
+
 #endif /* CONFIG_MMU_NOTIFIER */
 
 #endif /* _LINUX_MMU_NOTIFIER_H */
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 245b74f39f91..f30bf95f17c7 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -49,6 +49,37 @@ struct mmu_notifier_subscriptions {
 	struct hlist_head deferred_list;
 };
 
+/*
+ * Callback structure for asynchronous OOM cleanup.
+ * Used with call_srcu() to defer after_oom_unregister callbacks
+ * until after SRCU grace period completes.
+ */
+struct mmu_notifier_oom_callback {
+	struct rcu_head rcu;
+	struct mmu_notifier *subscription;
+	struct mm_struct *mm;
+};
+
+/*
+ * Callback function invoked after SRCU grace period.
+ * Safely calls after_oom_unregister once all readers have finished.
+ */
+static void mmu_notifier_oom_callback_fn(struct rcu_head *rcu)
+{
+	struct mmu_notifier_oom_callback *cb =
+		container_of(rcu, struct mmu_notifier_oom_callback, rcu);
+
+	/* Safe - all SRCU readers have finished */
+	cb->subscription->ops->after_oom_unregister(cb->subscription, cb->mm);
+
+	/* Release mm reference taken when callback was scheduled */
+	WARN_ON_ONCE(atomic_read(&cb->mm->mm_count) <= 0);
+	mmdrop(cb->mm);
+
+	/* Free callback structure */
+	kfree(cb);
+}
+
 /*
  * This is a collision-retry read-side/write-side 'lock', a lot like a
  * seqcount, however this allows multiple write-sides to hold it at
@@ -385,6 +416,84 @@ void __mmu_notifier_release(struct mm_struct *mm)
 		mn_hlist_release(subscriptions, mm);
 }
 
+void mmu_notifier_oom_enter(struct mm_struct *mm)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+						mm->notifier_subscriptions;
+	struct mmu_notifier *subscription;
+	struct hlist_node *tmp;
+	HLIST_HEAD(oom_list);
+	int id;
+
+	if (!subscriptions)
+		return;
+
+	id = srcu_read_lock(&srcu);
+
+	/*
+	 * Prevent further calls to the MMU notifier, except for
+	 * release and after_oom_unregister.
+	 */
+	spin_lock(&subscriptions->lock);
+	hlist_for_each_entry_safe(subscription, tmp,
+				  &subscriptions->list, hlist) {
+		if (!subscription->ops->after_oom_unregister)
+			continue;
+
+		/*
+		 * after_oom_unregister and alloc_notifier are incompatible,
+		 * because there could be other references to allocated
+		 * notifiers.
+		 */
+		if (WARN_ON(subscription->ops->alloc_notifier))
+			continue;
+
+		hlist_del_init_rcu(&subscription->hlist);
+		hlist_add_head(&subscription->hlist, &oom_list);
+	}
+	spin_unlock(&subscriptions->lock);
+	hlist_for_each_entry(subscription, &oom_list, hlist)
+		if (subscription->ops->release)
+			subscription->ops->release(subscription, mm);
+
+	srcu_read_unlock(&srcu, id);
+
+	if (hlist_empty(&oom_list))
+		return;
+
+	hlist_for_each_entry_safe(subscription, tmp,
+				  &oom_list, hlist) {
+		struct mmu_notifier_oom_callback *cb;
+		/*
+		 * Remove from stack-based oom_list and reset hlist to unhashed state.
+		 * This sets subscription->hlist.pprev = NULL, so future callers of
+		 * mmu_notifier_unregister() (e.g. kvm_destroy_vm) will see
+		 * hlist_unhashed() == true and take the safe path, avoiding
+		 * use-after-free on the stack-allocated oom_list head.
+		 */
+		hlist_del_init(&subscription->hlist);
+
+		/*
+		 * GFP_ATOMIC failure is exceedingly rare. We cannot sleep
+		 * here (would reintroduce the deadlock this patch fixes)
+		 * and cannot call after_oom_unregister synchronously
+		 * without first waiting for SRCU readers. The subscriber
+		 * will not receive after_oom_unregister but cleanup will
+		 * eventually happen via the unregister path.
+		 */
+		cb = kmalloc_obj(*cb, GFP_ATOMIC);
+		if (!cb)
+			continue;
+
+		cb->subscription = subscription;
+		cb->mm = mm;
+		mmgrab(mm);
+
+		/* Schedule callback - returns immediately */
+		call_srcu(&srcu, &cb->rcu, mmu_notifier_oom_callback_fn);
+	}
+}
+
 /*
  * If no young bitflag is supported by the hardware, ->clear_flush_young can
  * unmap the address and return 1 or 0 depending if the mapping previously
@@ -1144,3 +1253,16 @@ void mmu_notifier_synchronize(void)
 	synchronize_srcu(&srcu);
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_synchronize);
+
+/**
+ * mmu_notifier_barrier - Wait for all pending MMU notifier callbacks
+ *
+ * Waits for all call_srcu() callbacks scheduled by mmu_notifier_oom_enter()
+ * to complete. Used by subsystems during cleanup to prevent use-after-free
+ * when destroying structures accessed by the callbacks.
+ */
+void mmu_notifier_barrier(void)
+{
+	srcu_barrier(&srcu);
+}
+EXPORT_SYMBOL_GPL(mmu_notifier_barrier);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5f372f6e26fa..66adcd03f36a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,6 +516,9 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	bool ret = true;
 	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
 
+	/* Notify MMU notifiers about the OOM event */
+	mmu_notifier_oom_enter(mm);
+
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
 	 * is no longer stable. No barriers really needed because unmapping
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..79a4df8a337a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -875,6 +875,24 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
+static void kvm_mmu_notifier_after_oom_unregister(struct mmu_notifier *mn,
+						  struct mm_struct *mm)
+{
+	struct kvm *kvm;
+
+	kvm = mmu_notifier_to_kvm(mn);
+
+	/*
+	 * At this point the unregister has completed and all other callbacks
+	 * have terminated. Clean up any unbalanced invalidation counts.
+	 */
+	WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
+	if (kvm->mn_active_invalidate_count)
+		kvm->mn_active_invalidate_count = 0;
+	else
+		WARN_ON(kvm->mmu_invalidate_in_progress);
+}
+
 static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
 	.invalidate_range_start	= kvm_mmu_notifier_invalidate_range_start,
 	.invalidate_range_end	= kvm_mmu_notifier_invalidate_range_end,
@@ -882,6 +900,7 @@ static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
 	.clear_young		= kvm_mmu_notifier_clear_young,
 	.test_young		= kvm_mmu_notifier_test_young,
 	.release		= kvm_mmu_notifier_release,
+	.after_oom_unregister	= kvm_mmu_notifier_after_oom_unregister,
 };
 
 static int kvm_init_mmu_notifier(struct kvm *kvm)
@@ -1273,7 +1292,13 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->buses[i] = NULL;
 	}
 	kvm_coalesced_mmio_free(kvm);
-	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
+	if (hlist_unhashed(&kvm->mmu_notifier.hlist)) {
+		/* Subscription removed by OOM. Wait for async callback. */
+		mmu_notifier_barrier();
+		mmdrop(kvm->mm);
+	} else {
+		mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
+	}
 	/*
 	 * At this point, pending calls to invalidate_range_start()
 	 * have completed but no more MMU notifiers will run, so

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.43.0

