Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745C49BD67
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886179; cv=none; b=p1Bo4Tz+zlbuoAvmQOG28+vMwJuF+73B7HbX08+LYUt6Pvwp8NXS+BHWhQjdmnanlXhFJ4LLcsXYyzmPpnDrY8UuE/nBNXY4sLAigEk1KmQoZF78ZA7WeF/QjRmeyQEt8ySWg1Ghg7y0Bk+Nw75akxxZP7KyONhrTI9krOrtN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886179; c=relaxed/simple;
	bh=ezfobL2BEEGCUvHfYWOWOSisYtn6qKReOjPO01yUEQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gx8CJX9l6Mf3ZSLDDjzYxZpdOlU5AvDkyGt5QCkdClfS5Iky+4apCEGJl7/jLa4A6pQXNv+73hvanMGpFdSo/BYnluS/24zGWTxWUVO8F4efUJygve/DTkcAps7pGnbESbLZKgr9bUxpS9xn7Hci5Tir/c7yHYqagFEcwSCnru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qH5xoIgP; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qH5xoIgP"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-385d2703b64so1021429a91.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886169; x=1791490969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DkEUby8k1GuirLgDM70VkYF1zdud3CmFD1i1s3HAuxY=;
        b=qH5xoIgPGJXbocup38EMNjSxgKypSgMlfFLkpPAhhFmxUCzQhT6GXYXcBMTa4awz9Y
         pwYS8iSo6tNj+JDIR53dqSKL2ekClwKOwwIStUs92RPHMwSmG7XIUT9w51+y5MvHnSrB
         Tq3ZUJ7QdGvmBhCCaa7o2cvncQBaprpjej5BOllP5dS9qAnIJV9Jmkve4aBbqVym9H/b
         Edmw5XwhZD6tg8zC96PPbHf+TEFDeMSrv4D34pnpWV8X1VMTQjKyyV3Y2QfyuLVW5Ik9
         Y5YL0b0sIdyhGMWSaDEugbO65sUiw8GpbMqNB8u7qyxT+f1R+rTrZU6lSPQpWSR2qaqg
         XqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886169; x=1791490969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkEUby8k1GuirLgDM70VkYF1zdud3CmFD1i1s3HAuxY=;
        b=YRRmMcBv2UdnJ3Yg9pBbznEK1ltEW3rkhNt11BSrDzzBaV2ylF/u+1YPy03Yi3iov5
         Niu+Plea0sbaBd6oWb0XyDWY1WyMdHE0/ol5HTLqKJoWzhRtp8fzmAPmH3O8mwZF9p6O
         dh88c81h6SIGC7xfUpVY3OGWzGtdJ67XBIuniFxiURdL1DJxu2HS7bxSQsNGkHRpXRb3
         o3LZ1QnrfEIReWnya6cZrXG6jKaSNoHziXcOEMBveeFOnuIEiYMUqkIdPre+BMQCz9ff
         sDhcbJAoZCk9TtEQ4zk1Ef84LG5NkB9DUUQc1T2ZY0wIqOFHI5qn364jUtIJ5N90G81E
         aPXw==
X-Forwarded-Encrypted: i=1; AKwUvBz8inGSeF1QPYmq1Wk30c2/3DfN/bjILoG25BpuZkOqk1PRGUak5OSEL4fM67c5TbctzlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6G9wgIkgGYt+EEf4NVdnLxXiAAqXo2Y70cFctsPhSmXbUXYHp
	UmiJaoRQ/f0P3FVQnNkp6GywVjWc7wYEKhooX8U855kDNn3p7bHpHveh9xWVBqSORaHP8MHFodP
	u/nwWdw==
X-Received: from pjrz11.prod.google.com ([2002:a17:90a:bd8b:b0:3a4:740f:e86f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2d0:b0:3a4:7195:ecba
 with SMTP id 98e67ed59e1d1-3a6ceae19b7mr344412a91.20.1790886167964; Thu, 01
 Oct 2026 13:22:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:29 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-6-seanjc@google.com>
Subject: [PATCH v2 05/10] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Instally dummy, empty memslots immediately after unregistering KVM's
mmu_notifier during VM destruction to harden against accessing memory from
the wrong address space when tearing down a VM.  Because kvm_destroy_vm()
often runs when the associated VM's file is being released, current->mm is
often no longer kvm->mm, i.e. using the memslots to access userspace memory
is inherently broken/dangerous.

While KVM's APIs to read/write guest memory explicitly reject accesses if
current->mm != kvm->mm, taking away the memslots adds another layer of
defense and helps guard against rogue accesses that don't go through KVM's
standard API, or that do GUP+kmap().

Note, simply hoisting memslot destruction above kvm_arch_destroy_vm()
without installing dummy slots is not a viable alternative.  Doing so would
require auditing all the paths of kvm_arch_destroy_vm(), which is nearly
infeasible, and missing even one case would result in a NULL pointer
dereference and/or use-after-free, neither of which is a substantially
better outcome than the status quo.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f368240aa1cd..770a2c3bd445 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -955,23 +955,42 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	kfree(slot);
 }
 
-static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
+static const struct kvm_memslots kvm_empty_memslots = {
+	.generation = -1ull,
+	.hva_tree = RB_ROOT_CACHED,
+	.gfn_tree = RB_ROOT,
+	.id_hash[0 ... (ARRAY_SIZE(kvm_empty_memslots.id_hash) - 1)] = HLIST_HEAD_INIT,
+	.node_idx = 0,
+};
+
+static void kvm_destroy_memslots(struct kvm *kvm)
 {
 	struct hlist_node *idnode;
 	struct kvm_memory_slot *memslot;
-	int bkt;
+	int bkt, i;
+
+	/*
+	 * Install empty memslots to guard against memslot lookups while the VM
+	 * is being destroyed.  Consuming memslots at this stage is a KVM bug,
+	 * but "gracefully do nothing" is a much better outcome than "crash the
+	 * host" or "corrupt random memory" when there inevitably is a bug.
+	 */
+	mutex_lock(&kvm->slots_lock);
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++)
+		rcu_assign_pointer(kvm->memslots[i], &kvm_empty_memslots);
+
+	synchronize_srcu_expedited(&kvm->srcu);
+	mutex_unlock(&kvm->slots_lock);
 
 	/*
 	 * The same memslot objects live in both active and inactive sets,
-	 * arbitrarily free using index '1' so the second invocation of this
-	 * function isn't operating over a structure with dangling pointers
-	 * (even though this function isn't actually touching them).
+	 * arbitrarily free using index '1'.
 	 */
-	if (!slots->node_idx)
-		return;
-
-	hash_for_each_safe(slots->id_hash, bkt, idnode, memslot, id_node[1])
-		kvm_free_memslot(kvm, memslot);
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		hash_for_each_safe(kvm->__memslots[i][1].id_hash, bkt, idnode,
+				   memslot, id_node[1])
+			kvm_free_memslot(kvm, memslot);
+	}
 }
 
 static umode_t kvm_stats_debugfs_mode(const struct kvm_stats_desc *desc)
@@ -1302,12 +1321,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->mn_active_invalidate_count = 0;
 	else
 		WARN_ON(kvm->mmu_invalidate_in_progress);
+	kvm_destroy_memslots(kvm);
+
 	kvm_arch_destroy_vm(kvm);
 	kvm_destroy_devices(kvm);
-	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
-		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
-	}
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

