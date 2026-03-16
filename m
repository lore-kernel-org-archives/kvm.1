Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DE3254AF;
	Mon, 16 Mar 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645089; cv=none; b=Bex3dfkQmKlXS5OuNwnKyxK6Fz4Xw9EK1ehQ4gHPy+r6w1pTj+InLbR1vQvRmR/4az8eh0O8F9w//l9vC9D3au3DTCJtvrXrB/X6lyAelfF1eCcMR22Y1d/GTPlFIcs0Owqz/7IWH5eGGXXXYn9uix2obUY0ZH/b89AkjdT+RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645089; c=relaxed/simple;
	bh=dNGtOUMHKQ1GDqYsIMk7L+Q2IIaKpFWQY20WqydYZRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZcpKgnTaMLgukmFddOR9+6v2j3cs5s6CLqbz9n9OUlT9AC5cmFTl5xeRDbk9am/Exf91BHhTtXzjYKDinnvBwLJ5rIu7TTYfwC7daH23R68Nbg7m4FBMJx00lZ1G/vZuc47N/XTlRJ1M7pG2gRajRDHtryYMf98gS5fo2z0sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzdBpibf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzdBpibf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645087; x=1805181087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dNGtOUMHKQ1GDqYsIMk7L+Q2IIaKpFWQY20WqydYZRM=;
  b=PzdBpibfLP8+klSdNO+tcaExou/TnJP47TXO57Q29GNtoQi8ox1MnCcn
   CM8IObSb0ImEnOhgEuZqWemaGjiAeaLhBMf+55ysMmkejBExN1M6jZX5u
   4SjLOCh3ULM6v0Bqx0PAmoCfwagG2uFqE9hJfAob/3cgATgWhL6ij/q0d
   oqVOV8iKcGC1A7x3q5cRhQkyi/1ci0/gbQ3S7B2DE4TkgQdQnJ/1TG/H/
   otxA23lWdT6iLiCt3MmzhSC4OTkrCeFAGpambgv4slFC5EFxxArzmklEu
   Jv5mAc94N5DP8QwS3fBOFcldlg65Pa7baMuegRj14mp8edSS6GRxmLwvy
   w==;
X-CSE-ConnectionGUID: STzMKc3nTYCDmO38QryU8w==
X-CSE-MsgGUID: U3QBKe4UQ32cwErOku0rNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86009292"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="86009292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:11:27 -0700
X-CSE-ConnectionGUID: SVCCzh7LTjKW/sgYzYqTUg==
X-CSE-MsgGUID: 4SEiWgZSRrGclVE+zaYhJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226290496"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:11:25 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sonam Sanju <ssanju@intel.com>
Subject: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync outside resampler_lock
Date: Mon, 16 Mar 2026 12:38:02 +0530
Message-Id: <20260316070802.903908-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sonam Sanju <ssanju@intel.com>

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

Signed-off-by: Sonam Sanju <ssanju@intel.com>
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

