Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D342DA29
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070637; cv=none; b=DFXOFqGR7N0XHmp8bKWOudI4i+IH32KrJgJzuwe0xm7/zUX9+XoI+6eVulfzmMHanDNEB5BeVO8XJzvaNDHqmr/BS1lwiJvo3eQl8RlPPl2zxQclcD4a2dxvSqJSp2clEny5mwGJTYYJ6UtjYbnrC9V4UhgKpROHKVZfn3KxmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070637; c=relaxed/simple;
	bh=VS5kLf1YHr+hxUl/0CfBAnuEHDyMwEcyfjPnCxppJuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qnV41HvVUE2YP2FFmGcsFHz35mew7FnmjyKnLmNeEw729pmrAeWDQWKs9GYK+Gjwak9BWtEBY6ESoGr9y9ibDtj4O7F912FwkBbM2NOx2GAHJpIMktwqMA4mPh5sCBn6Sn8Fj74V4dtHwYT1DuM1yJid3rcD5LAk7aK15sXDbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToLrMPnE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToLrMPnE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848d21bbb55so6182092b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070631; x=1784675431; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uQPpkuZ7+BAJNsSp57OZqehFLTzlDB+hdw9yVvivlTA=;
        b=ToLrMPnEQgrvy/6pElccCWUX7IDXos9ZdEmw9Z2zbpNnd/xvLiWZiigPIQUGhDTJXH
         x2U6xrz6GZCa9gg+X6ZQq0pqqn52YwibXqkrIqVkXURKNMNSxPxuXud+rxj/Kv8bo1bV
         wiGYrICOZoKcVv9GyofzkNit5CUN+Xm9v6AEPyEcOhD7Fc99GxNGk2WzDBia+x1tTuqv
         R0CHkxTGdy/iRJsXd+Bn15c1rW/au4hALMl5sNGBNuhs+oxMfi1eaGcd3Wg6rgMedcvQ
         u4Adj1M/W1RNf3XsQtD7dLQRltomPYan72DV1Foofno3NzhFadYW6EFRus5aveHx/nD1
         m80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070631; x=1784675431;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQPpkuZ7+BAJNsSp57OZqehFLTzlDB+hdw9yVvivlTA=;
        b=CU67bO8bXjZaqzT1OFqgx4KsCeW+ERBSvTDZ/jLC2BLqgs04zMdcl1wj7wl/6t/Wo7
         iD8o17hff+JEcvAT1JizOWnpjbnWgNNY+nY2g02BV8AarfBBESlVHkZdWchSdY22RPUf
         0S4YcvW3hdj50rxiTbJilBXh7km0Xu3T7P8nHE9q8o7MhrP+92Eo2icU0xXu6a1kvyiq
         mIGW3wmh61f6PUB5Y6UryFQkbn+G5sX8Eqz81le5Y4uCX50bWw6GIBi0zSmN3YXBxeB5
         k9oFyJFCPKs7S60txyK9y5rLvFEQupw6sBgdaTRODLPVx8skcO95F4hGfbW4doBdFIai
         dtEQ==
X-Gm-Message-State: AOJu0YwThqrtLv4XL3vZWZ3YoPiIPMRBntYjaOS2MikHaxRHGwODXxpy
	LYPv+nHSONAcD7yAdtTbDJ1CErQJOvEC+0c52h3QZ4qoAD1QwcPF5W47WqikUjmWrvbMkZ3QZxL
	qYeC3Pw==
X-Received: from pfnx11.prod.google.com ([2002:aa7:84cb:0:b0:847:a522:7e85])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d55:b0:845:4fec:3f8f
 with SMTP id d2e1a72fcca58-84a55894653mr4282637b3a.40.1784070630545; Tue, 14
 Jul 2026 16:10:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:12 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-5-seanjc@google.com>
Subject: [PATCH v5 4/7] KVM: guest_memfd: Fold __kvm_gmem_prepare_folio() into
 its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold __kvm_gmem_prepare_folio() into kvm_gmem_prepare_folio() and extend
the #ifdef guard to cover all of the kvm_gmem_prepare_folio().  Take care
to align the gfn _before_ computing the index, otherwise KVM would end up
with a mismatched gfn+pfn pair for folios larger than order-0 (this detail
was subtly handled by recomputing gfn in the helper using the aligned pfn).

Providing a single-use, ~2 line tail-call helper adds no value.  In fact,
due to having to reconstitute the gfn, *and* effectively hiding the
alignment adjustment for hugepages, the separate helper is very arguably a
net negative.

Opportunistically convert the existing WARN in the prepare flow to a only
fire once, e.g. so that a guest_memfd bug doesn't unintentionally Dos the
kernel by spamming the log.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 62c2c157f0c1..f9a1d6d64f6c 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -60,19 +60,6 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
-static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
-				    pgoff_t index, struct folio *folio)
-{
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	kvm_pfn_t pfn = folio_file_pfn(folio, index);
-	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
-
-	return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
-#else
-	return 0;
-#endif
-}
-
 /*
  * Process @folio, which contains @gfn, so that the guest can use it.
  * The folio must be locked and the gfn must be contained in @slot.
@@ -82,6 +69,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				  gfn_t gfn, struct folio *folio)
 {
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	pgoff_t index;
 
 	/*
@@ -97,11 +85,15 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * The order will be passed when creating the guest_memfd, and
 	 * checked when creating memslots.
 	 */
-	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
+	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
+	gfn = ALIGN_DOWN(gfn, folio_nr_pages(folio));
 	index = kvm_gmem_get_index(slot, gfn);
-	index = ALIGN_DOWN(index, folio_nr_pages(folio));
 
-	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
+	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
+				     folio_order(folio));
+#else
+	return 0;
+#endif
 }
 
 /*
-- 
2.55.0.141.g00534a21ce-goog

