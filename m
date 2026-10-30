Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395289;
	b=l6gUGDfNscx6yPeCvae1KsNCh4Kd3HwSFYnzXKaWUI9s0/8Xj4WK30W9Dn/fzWJs3TZq
	 KRJ+Y+TghMvmdWKRC+MWAy+a8TktR7kCJGarBq4UIalwk+11G5G52NzTpCasD5BZBJTWb
	 ByX8EmaH2HvKJoMOQAfNsMky4+yIulVGGV0L6levgV5NNQH3xVdiN/5i+lbBgoezOceHz
	 8K3dgdhZqjLssMKoBEhTS1GzCf0KcgVnfrVGJOXZ41Lca6hHx7+GJuAI2AZ6mJF1c5uHR
	 5PWW8aVdTMUTRGOIy+5y3vWpcZmVb+cbTNfapVEsh1Tm8QQdTR8JP1wD+2n/JmP+YpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=RcX2YZRJWHg2bC94YnzCHmgguqsUuMXALdhLJOO1CSU=;
	b=tCULkAafAXOgXn99/pflB8r8ygEzRe6hgZ5JEYiA3W8pwPhw4t0u//Fbs4asUFkW+ds9
	 9QNghtyLkOgsjo7fF1AJfftcZKhEhVaELTXYnrfSXZZG9uaAEJ8wSeta8YjdlKYrFMD6O
	 mU1BWYxXjU/vw2ctC9JmXscjjiwFdvStugaCHbxQIX1+QLsrYXibTRz4OoSSdSuE8KXsq
	 nY/a8p7+yLhmU9sFgTdBRvEhzBy4Hllg2IFQ6GBz7+9aQPa2VVXZRwQ+BFTOyB79tC5Mp
	 UzzSObuxVDkBCSxwWNzk5RJp/Z4kFLl02CNkh0ixu/QcZ5UJ4Tx2fzvVmFAu89a0iWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o3SqJh5H;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AF606C31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042AF606C31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o3SqJh5H
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e8ad8c5f80so19140515ad.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395288; x=1794000088; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RcX2YZRJWHg2bC94YnzCHmgguqsUuMXALdhLJOO1CSU=;
        b=o3SqJh5Hj0Oct0vOoPUFXVsVMU3yye10P9R91YGVOyvMkxcAzuSMT4IK8Ui+bOYkL5
         MoLjf5r01aYWMjShUBCeFCECcxaSGb8xAjCaEVomZVeEVcdHla0zZVF/AMLPJRHb9ONt
         SS2s6iIAznd/vthvXVGTVXKidB1ek5aUSvqEUF0K2jBcxjSXeeknzYCOB2wTHXBOkYje
         +ouxxhGXK8HUaqEbBWQkDMdOuwuxOIV0Oo4WYhBU/r82BhIzCpamhYCeINS26Sl01Ncv
         L1yjKv0JrmZfaK0JPkkh7bnxU9wA9Y/LyRBEcxyeTdEV//gyRBrwPpHXtSP1pN4gzyJH
         q0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395288; x=1794000088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcX2YZRJWHg2bC94YnzCHmgguqsUuMXALdhLJOO1CSU=;
        b=Q+eTSqP0kT6D5Jz0htreLkgrZg0u2rysFeRKyzrqoieXSrjwZjQZZoODzM3j5WnMdv
         vbCBvv7BVqYgGKIr86g9yDXwBo45dZnyl+h5b0zzEecBxpY13i4R6fngw1UhSgEnfeZN
         LtjOOB77vm2nkWjmNIEOjFSHZNbL2AUGXIbtNxcUQe8pL9bqwAxqBPr+/0p33bLcrKTj
         UZDwas76F1Ac9Vf9TqdjZ2Zv0FaF7vZTn6ooueuFnZSnpwyFVMMLxIvucf7hsciDSB6s
         AM1SQ2rllTI4AmyYxHR7/Ti+EbXpx00MDUoFLeHCrDg0Wmwya+mhCW09Gt3Pj40ZtY9k
         9bNA==
X-Forwarded-Encrypted: i=1; AKwUvBx5QLYEt9g/2aNcYCodI4GeAYPFa+J24rvrWPHujS2ff8Isq7ZRS9T/coYsQIsBqFWRDHQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt97CWl2+4xMbcSCn9l0oGnPSsIOSWyFRlvOStqfBdf6Wn0d/2
	fjpnbss1FoZZFie7kwd5asuwj/AXw53CjdwmCiJ7GiMbKy99RHYWbKNT98jP8FH950AE2rQZu6w
	RV6nWqw==
X-Received: from plbkn5.prod.google.com ([2002:a17:903:785:b0:2e9:6e08:e249])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a30:b0:2e3:598:75b8
 with SMTP id d9443c01a7336-2eb364b0dc1mr36320905ad.27.1793395288251; Fri, 30
 Oct 2026 14:21:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:00 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-13-seanjc@google.com>
Subject: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
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
index fa548b12228f..2eda12a52bf4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -963,23 +963,42 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
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
@@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
2.56.0.385.gac671c819a-goog

