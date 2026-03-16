Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F534E747;
	Mon, 16 Mar 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645680; cv=none; b=jGer14xjnAQVOcNGLxbaSqExKVs7oeSfZT6bPfN1mw22EGtL+DGh955SXtTOkCsWnJUOQ2ZPCrFcHYmiLMQJiZuj10smo8SMvTq6PtC20xOfOpWudxaFoyXmRqW/F66YNk3Yo5ozVKzcWsHknJBdE55k1rRR0MMeo3XP2Y5F4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645680; c=relaxed/simple;
	bh=u4EewW1T835xJCeWziY7HUDKcLzWDWtXedVY8+agRvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Llg1bnuT6f/HOV0AO4FQeHMpnDYJr/SpdaXEPe+FpZrVieRyzaeIekmPcsohPXUvBkGnuG+8N26fy3yYx3rQ2B/TKMed5xqnNQETmyXcEpuphgR8PJW+0Mx8Zph8XwWlvrZqdeXRpOb1dh2kZ3CJ14uDd96gG07QyX8UjCOZk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPtO50/O; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPtO50/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645679; x=1805181679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u4EewW1T835xJCeWziY7HUDKcLzWDWtXedVY8+agRvA=;
  b=kPtO50/O5upVZwzHhQ/zg2LR5i9/6HdZCrIxccg90l9/nD668lPLYGF6
   oW/W97RzbJnt0Swdnf4bJFK175lRouX+txDWlZEDe6oF2aTppsJIHjKUH
   NfhFA+tD6jX9VW2tth8ekDYU2WvxYuTpTQZ9e771miN49rnJozPxc+qCx
   7+dIYYjn5Rfj9U8VnrSr+XecMmEriHdsBGLWaRpVg3hzDOZxg2Ir3elVv
   xHYXUaBFhn9fw6NtPfEH7Gz+a+cWvQd6924J16DsHaeAvhMI4msBcVXy7
   jMHilZ3GYxoUZz6ghgRAooN1r6FDuLJEUvw9jdiEFCt4b06dGPq+htZvU
   g==;
X-CSE-ConnectionGUID: bPN/9CeqQ9WZr7snvSb4fw==
X-CSE-MsgGUID: VmfyvNHYS1O7T0i4rLp2iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92038703"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92038703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:21:19 -0700
X-CSE-ConnectionGUID: fPCovMkbSCSxIqU7a/0q4A==
X-CSE-MsgGUID: 3+srmwiiR7KusuyAsbJ4Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226497303"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:21:16 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sonam Sanju <sonam.sanju@intel.com>
Subject: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync outside resampler_lock
Date: Mon, 16 Mar 2026 12:50:26 +0530
Message-Id: <20260316072026.908893-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irqfd_resampler_shutdown() calls synchronize_srcu_expedited() while
holding kvm->irqfds.resampler_lock.  This can deadlock when multiple
irqfd_shutdown workers run concurrently on the kvm-irqfd-cleanup
workqueue during VM teardown (e.g. crosvm shutdown on Android):

  CPU A (mutex holder)               CPU B/C/D (mutex waiters)
  irqfd_shutdown()                   irqfd_shutdown()
   irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
    mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock)  // BLOCKED
    list_del_rcu(...)                     ...blocked...
    synchronize_srcu_expedited()      // Waiters block workqueue,
      // waits for SRCU grace            preventing SRCU grace
      // period which requires            period from completing
      // workqueue progress          --- DEADLOCK ---

The synchronize_srcu_expedited() in the else branch is called directly
within the mutex.  In the if-last branch, kvm_unregister_irq_ack_notifier()
also calls synchronize_srcu_expedited() internally.  Both paths can
block indefinitely because:

  1. synchronize_srcu_expedited() waits for an SRCU grace period
  2. SRCU grace period completion needs workqueue workers to run
  3. The blocked mutex waiters occupy workqueue slots, preventing
     progress
  4. The mutex holder never releases the lock -> deadlock

Fix by performing all list manipulations and the last-entry check under
the mutex, then releasing the mutex before the SRCU synchronization.
This is safe because:

  - list_del_rcu() removes the irqfd from resampler->list under the
    mutex, so no concurrent reader or writer can access it.
  - When last==true, list_del_rcu(&resampler->link) has already removed
    the resampler from kvm->irqfds.resampler_list under the mutex, so
    no other worker can find or operate on this resampler.
  - kvm_unregister_irq_ack_notifier() uses its own locking
    (kvm->irq_lock) and is safe to call without resampler_lock.
  - synchronize_srcu_expedited() does not require any KVM mutex.
  - kfree(resampler) is safe after SRCU sync guarantees all readers
    have finished.

Signed-off-by: Sonam Sanju <sonam.sanju@intel.com>
---
 virt/kvm/eventfd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 0e8b8a2c5b79..27bcf2b1a81d 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -93,6 +93,7 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
 {
 	struct kvm_kernel_irqfd_resampler *resampler = irqfd->resampler;
 	struct kvm *kvm = resampler->kvm;
+	bool last = false;
 
 	mutex_lock(&kvm->irqfds.resampler_lock);
 
@@ -100,19 +101,27 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
 
 	if (list_empty(&resampler->list)) {
 		list_del_rcu(&resampler->link);
+		last = true;
+	}
+
+	mutex_unlock(&kvm->irqfds.resampler_lock);
+
+	/*
+	 * synchronize_srcu_expedited() (called explicitly below, or internally
+	 * by kvm_unregister_irq_ack_notifier()) must not be invoked under
+	 * resampler_lock.  Holding the mutex while waiting for an SRCU grace
+	 * period creates a deadlock: the blocked mutex waiters occupy workqueue
+	 * slots that the SRCU grace period machinery needs to make forward
+	 * progress.
+	 */
+	if (last) {
 		kvm_unregister_irq_ack_notifier(kvm, &resampler->notifier);
-		/*
-		 * synchronize_srcu_expedited(&kvm->irq_srcu) already called
-		 * in kvm_unregister_irq_ack_notifier().
-		 */
 		kvm_set_irq(kvm, KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
 			    resampler->notifier.gsi, 0, false);
 		kfree(resampler);
 	} else {
 		synchronize_srcu_expedited(&kvm->irq_srcu);
 	}
-
-	mutex_unlock(&kvm->irqfds.resampler_lock);
 }
 
 /*
-- 
2.34.1

