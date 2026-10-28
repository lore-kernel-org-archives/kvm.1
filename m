Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219173;
	b=h1VGmBuJU3yfhgFepe8gDyxLZB+70XKBt9NeSb3o3vZKAmPIZwol5XqSITuInsqesW73
	 X/uqjxNMQ2EFqOrkPnsGxT5k7WfXuJF8Rjrb7VZia6HANEyTbKhP1gjPHdV3m2XmgPJdR
	 g500ug1Bu8LU6XVDlEP4+0+WYvWqqP+MuLzgGBHKfHOgSblYCRQjWKkUPWj4U+/1Kl2ej
	 L1YH+MU15+wX6cmEFN9Dn6H5bJ4Bjddg13Jo0H7XeDwsHLB6TPGp4/Ho30jLfriMZrY9q
	 6Cx+vUF9qe05MH/o4xOBnke5a9YEnIxhLfSulyoGpDF7MyyK2aCdCMNcnLtohzFdi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=I90A0ub7CZlOqB7Gzh1KGrhjcbbRi8qHQguN02Pd4qA=;
	b=G4Ohsuu8tifclNOlLuVHDjo8j3gWyBDWAzx2fYG3i3KuxVOs9wt5tWAB985rsZtlvA56
	 +pCAi19rcnh/b5uselj6ob4mf/S/3iP95J0bqeIN+a7zlOnralRhjVsnKnpvxe3Zf5+Va
	 TUfgoPvANegEHzg8ar1x99eyCSc8kV10PLDCfFcJtvNRCe4ddrIBPoOoshXjmURKpexU5
	 vbeA7OEjPByDofUcatkW99vUZDV7kEkOvctAmcz9O6dweAsBU8rbEE2DVSOJLRtwTUOxM
	 MXLWC7M2U/U4i7EurdIRzCB9X7MBncnrRb4Z/T0HNnpa+CktKtEw+/FD/ZExAgiCo6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BCewmMe2;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D4606A32F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238D4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BCewmMe2
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso13781125ad.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793219172; x=1793823972; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I90A0ub7CZlOqB7Gzh1KGrhjcbbRi8qHQguN02Pd4qA=;
        b=BCewmMe2PRdRlnBL142IdsqTy5xn2mX8d084McTZBfCqXFq1CzT426uzZARTKdKmw6
         NLd+Heiv5BmQr/LLzP16pIvRSFbbNhEx36HvZYnpuk57iGs1UoBxUW1MwzEaEz2Qq2w/
         cxpIcmbmhWwO1RCY7/nXBiXOvG+JUNtwgcLxLHzuBa7zQ39bAwp0AFOblzEggbTVyJX3
         HrqR+MAEdl3RLnemUSblT35z2zC9n4rjKEqH+3gd3nJQH9WmQBzZdCVwPq0q0pdSv1zC
         NB4J2M+kP+dJq0uUoMEfLfwvNXlWNoVAlFPeA/m1Mjx2CILFZPlLysXvxRk8G3DvE7sZ
         d6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219172; x=1793823972;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I90A0ub7CZlOqB7Gzh1KGrhjcbbRi8qHQguN02Pd4qA=;
        b=G3taDTHyzwDTOnocvRAjTMN3jDCel+56ZGI6aTZ8jnDpL0fx4aQrZ4P2p74UjS5ezU
         VxBLDMbli6+nixEAqeaCPpf0G24Fl0L/8+HRywdOrEq/E8JriFWvEUENNF5awsDnIikF
         BCA1JqhDjdPFU2xfBqqN6axBYygMU1vOpjNHfEPyO3xO4wIl7gdoBrCeYWZgiu+HPQiD
         nzLTzMdGUg8OWnwAde+hCvtgOXr8t/urVYU20OIFYxeliz7NVABBPgyW2t4/VJLTUb3/
         dwrRzc7L3KsA0maitPTWkEMtoqI8E1ls9H5g4um0MlJeaw2Nqe0bvV8f6JVgrPdNc4nu
         0+Tg==
X-Gm-Message-State: AFq9FYLQ2OOmQzT62ckcR1NujBLJ7rYyqJraErbJ3ZmpIHz0ABoapLJl
	vxS5cFl/A1cRCs9a1zGzVsyBOMwkAzv9hssLjFuDpwnilTRdL7JYr0WmbJXZwk1CrsKcy3RTI3U
	ekyJz1Q==
X-Received: from pjblj14.prod.google.com ([2002:a17:90b:344e:b0:3ac:2cdc:a8ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22d0:b0:2e9:a651:eca
 with SMTP id d9443c01a7336-2eb003e124cmr29324645ad.18.1793219172278; Wed, 28
 Oct 2026 13:26:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 13:26:04 -0700
In-Reply-To: <20261028202607.1844883-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028202607.1844883-2-seanjc@google.com>
Subject: [PATCH 1/4] KVM: x86/mmu: Rework gfn_to_memslot_dirty_bitmap() into
 auto-prefetch helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Marangoni <mamarang@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Rework gfn_to_memslot_dirty_bitmap() into a more generic helper that takes
a memslot to check if said a memslot is suitable for auto-prefetch.  "auto"
in this case means prefetch that's initiated by KVM without a corresponding
action from either the host or userspace.  Taking a memslot will allow
using the helper for other prefetch flows where KVM already has the memslot,
i.e. will allow reusing the dirty logging logic in particular, without
introducing potential TOCTOU bugs.

Return error numbers that align with KVM's uAPI for prefaulting so that KVM
is consistent in the unlikely case prefaulting ever ends up being subject
to the same restrictions (prefaulting isn't "auto" in that it's an explicit
request/command from userspace).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a2cc6a17a9b..393feeaddfb1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -872,19 +872,19 @@ static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
 	untrack_possible_nx_huge_page(kvm, sp, mmu_type);
 }
 
-static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
-							   gfn_t gfn,
-							   bool no_dirty_log)
+static int kvm_check_memslot_usable_for_auto_prefetch(struct kvm_memory_slot *slot,
+						      unsigned int access)
 {
-	struct kvm_memory_slot *slot;
+	if (!slot)
+		return -ENOENT;
 
-	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
-		return NULL;
-	if (no_dirty_log && kvm_slot_dirty_track_enabled(slot))
-		return NULL;
+	if (slot->flags & KVM_MEMSLOT_INVALID)
+		return -EAGAIN;
 
-	return slot;
+	if ((access & ACC_WRITE_MASK) && kvm_slot_dirty_track_enabled(slot))
+		return -EACCES;
+
+	return 0;
 }
 
 /*
@@ -3231,8 +3231,8 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 	if (WARN_ON_ONCE(nr_pages > PTE_PREFETCH_NUM))
 		return false;
 
-	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
-	if (!slot)
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	if (kvm_check_memslot_usable_for_auto_prefetch(slot, access))
 		return false;
 
 	nr_pages = kvm_prefetch_pages(slot, gfn, pages, nr_pages);
-- 
2.56.0.313.g2479322e68-goog

