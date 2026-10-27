Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139139;
	b=yLiexSl4qx1cbAgA6aNmtAn1jmaDah0MDhf1uwCFK8eJo7vfzwn8O/qXW7yrOGolgLGp
	 lT6O90rrQEehwP9aUutpnr996jW1YOZKj6yJq1V+4rdfUY4kizH4MnMMyin3UlZ+xfL5/
	 sreaDx/yyKn+40f95iq/3sF76GCoZ6lWmNuwKIyO59dv/CM7BiZUGGZ3RjkqzE3DE8Y6y
	 8IFf/+yJun6ke6LlwHyTUNxYEQwntlPBKyqUJxBmOpgpAPw74ttvBk65vgUA8zW31062e
	 mrdAD6nPaPGtKL/3LYH2HJod3uVlcES8je7imn2GTi/a50u9rhCqUtW153vvqDYIKyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=Na27bDyEPgeDt12EX7VPW4wAyW1QKigeaVHb8mXSq+Y=;
	b=VHYL9ZsCSe3C+in0vM+MCA9Z/6iTLGN51wH1edNgkSY/HqG0UeSJN/A9vD5A7Re+b1j8
	 BccerSMVbMyoNXeOrNW3M4hEFzruhLVK7kNTu2+iCPp6bpWNcsMgxa7ugexWa9EFmLrSE
	 EOhBe0Wrht8k2WAIGBn25hJjvLZABxrflGQXzGBaCC6i8WYm29x6YSYs5or2WNLmNOfiM
	 Xte13lbILMveUvHxojZgaonMt50JuYuGhsyxTwl7tBYyGiBbs2BL1/hPBcTFlBikHRTcg
	 ZF2iY/tWVR9DG1fVJD1+6glXjZoKuWyFS1T0QXSnNKMvw5OAKURk1qBeYyk2Of10ZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnDLvqpv;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AE606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnDLvqpv
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso419452a12.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139139; x=1793743939; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Na27bDyEPgeDt12EX7VPW4wAyW1QKigeaVHb8mXSq+Y=;
        b=cnDLvqpv2AlFcGcf+yETDVXeNTcHAyIafdS8hNDvkzqW7nwtZpQ//j85DRGLJMLhPv
         XUbiDZJe12lhy90pzYyJ0n27Oaf5mzbdzW0Iwboy0Jc53IjgYgtUWm1oq17uEC13rI0O
         MGFbsm6V7xH7BwIhhC5ZPaeL7TM6SkT9Ta3Z2eDu90isOYxfXRKtHRvDV/WsbjJNwde0
         Hfz6CvdPKhqpPL9KpsCh/IRrR/pbIuNIWpck+G5rn3vUfCl16inP0V0Tj2+lAfgENhhe
         YOFlGzvZDUuwSNrAKTquuciiuLvk7jOIsdP+pZD+od+DoV1Ehlc/BAiqCl8s6DqRPOtf
         ZVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139139; x=1793743939;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Na27bDyEPgeDt12EX7VPW4wAyW1QKigeaVHb8mXSq+Y=;
        b=23e3rkbysovtsDx9bWbUX0+tc4/TBVAHpOUrWlFxjDDYTp4cUl4GVIFFlWZlsTcVMz
         07nOIuwqh51pylj38Jp2Kz3urUxIcpw2j96rMrmLluz15RyeYTsC3oV/CSpKXLj5HE9C
         5+nkvR8VAg34MnECrlHfav+le42RFY1FCgk+S0siukfne3rtzfJI4dCKsmJ5jxNiAgAd
         aN766TE0+SqPUuDsjqsnYg5E2KrNUHoBEIyMEFZPMsHWN9N7LhqrFjvB/C3FeKyHTnir
         N1M5qdweE8JRDVHhcWuc4JJmOMiDqMfrrRGxYwjnuhvPtUL/LVBKM7E8x5u5Spx59VP8
         Gl9w==
X-Forwarded-Encrypted: i=1; AKwUvBwuCmaR0lnjJXmZAmGETitc+PMcXpYAjqb8XWM75A+CWG1Ri/h77UyMtf1Yx2gzQRz+bG4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8xSiT5A6hEl75WSIw9QWwhfH1UDL5ixoZopjr0ZA9oTThSDTd
	tJPTgZ1yE7t4eyfyYS79Gz/RdoI23q7VyjUjStLLamBIIZlgVy3+rrHLStLAlORBacw29MqQugD
	RbSMZfQ==
X-Received: from pgbcq7.prod.google.com ([2002:a05:6a02:4087:b0:cd5:f7a5:5490])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d48f:b0:3e2:4350:1527
 with SMTP id adf61e73a8af0-3e90232b765mr412509637.24.1793139138551; Tue, 27
 Oct 2026 15:12:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:59 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-7-seanjc@google.com>
Subject: [PATCH v3 06/15] KVM: Destroy memslots immediately after
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
index e7c89861632a..1058b864d427 100644
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
2.56.0.307.g5fe7bd680c-goog

