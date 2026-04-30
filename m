Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF732727F3
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558642; cv=none; b=KRy75CJiJvgHQL2nyb5xLFSu637/yf5BTGiDvMGGmfyMZlnNadX354IAHm8pvxNq1P7D2JQTaflBgUW7KqYzmpCC7A897KMafbO5jwNFriw7VmQ9NR0bjQWvBHzxxWMitvGqVLoPSC0bW729Ni2dgv0y38xGNc+DDh96LiD2NM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558642; c=relaxed/simple;
	bh=ap3Tz4ybv2MDZswqwqwbN/beE13fYJb9L/7GcoYsorY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXqlAzHsabblmo+iTPn2cQJBTVRJRYztuTOhabOTxZQvv5lTzxPUCOfL2e8NtSfOFXIYZrOvtQAKLYr2fiP7AR01Dq/8HbP89CdkddGfYEvmV2+oxj2mebDlYtjU6pjaAgXHW2TxHS+BW0M8U3STk0F1cV8ZZFFMd2RMhw1JvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOojQPZq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOojQPZq"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-362e50b4641so580554a91.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777558639; x=1778163439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnGB2EwUnXNoeP6sM/wyCp0a9lWSmlC/c3BKgkuVX08=;
        b=UOojQPZqcvP6Tm1KxxPpOd6cvx0tisu0cB21Kpd39Y9AtngoUnB+Z1OD939slgkuXy
         2pTXpRyYj4I7ZLnDAQMR/3k1gkieZ7j7ZD+TckDWHhO1GUHwAyl2DsrIxkEc2e3wqONk
         05sK3kGEsOVSlEUiVgPx4iaM3d9QcuA4RkAyP8HbH/IoVFXSTeXSbRv+h2RO3qa3QiwI
         2uGiTbPNUsf9zKt3F0WO561d3ypvdlGYNaNOMJmoJ+4g0DPor2HAKlqawuAUq3kAk9Ve
         lO/Facjzs3L+nfBgJ++yqPBBxgfoRm24ayar+gWATFRR6XH9rKEijny+V8/4/nuOzXjR
         LUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558639; x=1778163439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnGB2EwUnXNoeP6sM/wyCp0a9lWSmlC/c3BKgkuVX08=;
        b=l1hfur++Su9SIB1pqYYRB5jOOemzWJAqLuoauzjgYN/7+G1ykhiPZBO2wCdlMEIYGn
         Bu6nmx7dfahgwqVPTXKY2tZTOX6KMNwIbeMWiWq5GxjSpo6/pJ8jx82CVU7tbwkiBkDY
         YFkmh/RpBHhlTDcC0SGE1rPJ7QHSadMwEsEnsJXY07KUwtHzNLjAjUTdx84GXHO69OJm
         Hd+j/IRx9yVszS0wa3araWXvPHQa2Q+9ACFqjdbmJU5gCTHDOKnnlmRBGFOMyRbASMMM
         MTS+Aqg5J4fN52Fzd4+2vDfcPWR6CqGRYgg8nkdTzCKxEF4MkABGltpmSVcgci3RiHU8
         r5ew==
X-Forwarded-Encrypted: i=1; AFNElJ9CdZRkFsBaNrIwMWewlHX5QvmL6y9x9KViiX22hlZcUj6Jb16tvbP8xioEkXNY8K6ccCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwH1ZZjwKqZdzrln4fp11lEtsuaAac5mdARzYZmX9OWnhBlNW
	yj4R1s95wNmJcO5zTb2xHACRpGEVIU93dLql0Q3W/j7DBy/jaZV34pzQ
X-Gm-Gg: AeBDiesAL4+uxuX8sCkDQ9dgvBNJLkCMzTx5zKHoZdasYrij+JEXqmcW68qVChPO1B0
	0IRhw87l5vCbYjZFyXpjrCMGACDPPjrDSBxH4w9jeaKia2eOKAXq8SeWHEEKBlLZv7TRUzqiP+j
	qHUJjRRweGGF/LkknDM3by8rKSgl4CR3K8JGrN3222/X98auQ8BW2c4Tq6WNBjKAcWry77RER7a
	QsxgxR0yyx2Sea6bZMtEd/eVaaiWI+Xrw12JmsVhBtFnmV+4LAH/rvOKCrJLnDSK5GXxICD29as
	Bp+Ovh6YiNqZMJe73ZlEN19MSgeckk/5wLUDf5HmExa2z0VAz6uv3nQPamqqWin5o3/uhjHaRhz
	sZ6gTbRURlc55InQwghPGMakufcHfv5bdK9YyANcr3a1TisUL9tQh+6YIkxa5hfSeeSUx5z23qg
	uGqE/unNa1uyOK1w2zVESUxrPawJUuw/8em+BmbEFo8kzkB09r+/M=
X-Received: by 2002:a17:90b:2804:b0:362:e7e5:a20a with SMTP id 98e67ed59e1d1-364c2f23636mr3137181a91.4.1777558639123;
        Thu, 30 Apr 2026 07:17:19 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.92.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a1213600sm2316777a91.3.2026.04.30.07.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:17:18 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: pbonzini@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Subject: [PATCH v2 1/1] mm/mmu_notifier: Add async OOM cleanup via call_srcu()
Date: Thu, 30 Apr 2026 19:47:01 +0530
Message-ID: <20260430141701.10859-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
References: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an mm undergoes OOM kill, the OOM reaper unmaps memory while
holding the mmap_lock. MMU notifier subscribers (notably KVM) need
to be informed so they can tear down their secondary mappings. The
current synchronous unregister path can deadlock on PREEMPT_RT
because synchronize_srcu() is called from contexts that cannot
safely sleep.

This patch implements the asynchronous cleanup design proposed by
Paolo Bonzini in v1 review: a new optional after_oom_unregister
callback in struct mmu_notifier_ops, invoked after the SRCU grace
period via call_srcu() so that no readers can still reference the
subscription when cleanup runs.

The flow is:

  1. The OOM reaper calls mmu_notifier_oom_enter() from
     __oom_reap_task_mm().
  2. mmu_notifier_oom_enter() walks the subscription list and, for
     each subscriber that provides after_oom_unregister, detaches
     the subscription from the active list and schedules a
     call_srcu() callback.
  3. The deferred callback invokes after_oom_unregister once the
     grace period has elapsed and all in-flight readers have
     finished.
  4. Subsystems waiting to free structures referenced by the
     callback can call the new mmu_notifier_barrier() helper, which
     wraps srcu_barrier() to wait for all outstanding callbacks
     scheduled this way.

after_oom_unregister is mutually exclusive with alloc_notifier
because allocated notifiers can have additional outstanding
references that the OOM path cannot safely drop.

KVM is updated to provide after_oom_unregister, which clears
mn_active_invalidate_count, and to detect via hlist_unhashed() in
kvm_destroy_vm() when its subscription was already detached by the
OOM path; in that case it calls mmu_notifier_barrier() and drops
the mm reference rather than calling mmu_notifier_unregister().

Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/all/20260209161527.31978-1-shaikhkamal2012@gmail.com/

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 include/linux/mmu_notifier.h |  10 +++
 mm/mmu_notifier.c            | 123 +++++++++++++++++++++++++++++++++++
 mm/oom_kill.c                |   3 +
 virt/kvm/kvm_main.c          |  27 +++++++-
 4 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 07a2bbaf86e9..0ccd590f55d3 100644
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
@@ -375,6 +383,8 @@ mmu_interval_check_retry(struct mmu_interval_notifier *interval_sub,

 extern void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
+void mmu_notifier_oom_enter(struct mm_struct *mm);
+extern void mmu_notifier_barrier(void);
 extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 					  unsigned long start,
 					  unsigned long end);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index a6cdf3674bdc..b8fa58fe6b7d 100644
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
@@ -359,6 +390,85 @@ void __mmu_notifier_release(struct mm_struct *mm)
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
+		cb = kmalloc(sizeof(*cb), GFP_ATOMIC);
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
+
+}
+
 /*
  * If no young bitflag is supported by the hardware, ->clear_flush_young can
  * unmap the address and return 1 or 0 depending if the mapping previously
@@ -1096,3 +1206,16 @@ void mmu_notifier_synchronize(void)
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
index 5c6c95c169ee..029e041afc57 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -519,6 +519,9 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	bool ret = true;
 	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);

+	/* Notify MMU notifiers about the OOM event */
+	mmu_notifier_oom_enter(mm);
+
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
 	 * is no longer stable. No barriers really needed because unmapping
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1bc1da66b4b0..a2df83d3b413 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -885,6 +885,24 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
 	srcu_read_unlock(&kvm->srcu, idx);
 }

+static void kvm_mmu_notifier_after_oom_unregister(struct mmu_notifier *mn,
+					struct mm_struct *mm)
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
@@ -892,6 +910,7 @@ static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
 	.clear_young		= kvm_mmu_notifier_clear_young,
 	.test_young		= kvm_mmu_notifier_test_young,
 	.release		= kvm_mmu_notifier_release,
+	.after_oom_unregister	= kvm_mmu_notifier_after_oom_unregister,
 };

 static int kvm_init_mmu_notifier(struct kvm *kvm)
@@ -1280,7 +1299,13 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
--
2.43.0

