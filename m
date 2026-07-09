Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040CF41737E
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630209; cv=none; b=A9XCKTQEWNkptb2OQkkWPI9YfjjC7cO5S7vHKZQKnjbU8P5ObesuLC3HCLOwq7Mvob0mzigOUAZb0mRuuusc9bgEkLYdugdRGmqdu7tsMO8dqVstdzAj9j29f7Ljt9ykAWyVhQxlVyXgZEu2Ay9htET2Km4AGqDCXiEZR4+96PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630209; c=relaxed/simple;
	bh=BeQiwlmT0Hq+uW/6Ie65Yitpu7XubvMvczTiS73fOns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BnQgLfG+R+B6qNfEb1SyS3BCGrpvKV6XHiHXjzrEQIU+0lAdvYKlm6jQWWCfurf9HDbbQyQlU914zJmEl90dkb5d5SJAJLXbRWTV2tU8eW1Xu4nYaH7THy6Sg9j5QGFMJYItzhqRX+t7oIBe21ENFkE00cQnSYPHo12BAu0y+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJowJwoB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJowJwoB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccb6823efcso1463145ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630207; x=1784235007; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D+bCb/eL1hAXexbivtEb3cGhBRIg4Kgd+Kil3n1b/1g=;
        b=ZJowJwoBwH4C2r0m7s6wRVlaYu9Uq3e6Av/p+0djpDa9bsROHN9UMZuiO6fbFwVVoH
         xMZs9CVEzCWBvvp36Y4Aqk8EUdvFHrpYesGVV0nJe4ocFc5NxtZi1OeYC8N45NAtB5jD
         QVST4n8r8IXLDdxLeO0WGfAFJF9jMCzf6mXbMoA/23/MrkAKGP9R4ucg/G2UuJ3/T6Vx
         ZJUe+f1AzgHq0zVv5I2qIkXOnpXg9KGSHDlsXzgqIwaTO9IqdDO4+dvP7hsbt+sH7z/v
         3mIljaWyL88wCfbYawXhZP3mw1llp/k1UaUV3CXqvRx1IBADcgky6n8GBOAqo7bSQHLx
         LTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630207; x=1784235007;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D+bCb/eL1hAXexbivtEb3cGhBRIg4Kgd+Kil3n1b/1g=;
        b=VJDmbd/KLd2MDketHyb3QglQIc/g2GZtdjEa/5tNRAAcrejZV+PJm5XwN90P61TVch
         AdzB0w/FZAy08x3ua61wRpUA8kfzPoWH/odQ7BgvgR2LLWu4cErQGYNDC+Knn980K3Qr
         fXuKVnkD0b/xy/kOoJrUCrZxumSjd8CUeYUv33rOaGdfUkiY+8wUVj4qtCfFDYSKqhzX
         n8uG7QhtIpmc/98HMctnA1zLzpu/BDrHGROylNQ8I96ULGglNDABntVrO4AaOUYWid4a
         lvFFCNSvHxZbFnw6uc5qdgWal7YMrTaNPZRlO3OPpYZzKMpvC3Bc5Cc/BhejFnn6vuZS
         BEPQ==
X-Gm-Message-State: AOJu0Yw1bWMN33ZYQCyLmxaxRXDzwAtMNfaAgy7+6WJsefRs8CXqQo3s
	6asYWWHbeD6FeyGiwas1mpKrdd2cd7+bcUDeEDaXYzsC2cDEwuefvDBkUoT9RMZ5a9xqSfqKNcg
	D59zstA==
X-Received: from plpl20.prod.google.com ([2002:a17:903:3dd4:b0:2b0:5538:b55b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccd:b0:2ca:c68:c554
 with SMTP id d9443c01a7336-2ccea58f980mr81827205ad.38.1783630207275; Thu, 09
 Jul 2026 13:50:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:45 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-16-seanjc@google.com>
Subject: [PATCH v4 15/18] KVM: guest_memfd: Fold __kvm_gmem_prepare_folio()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold __kvm_gmem_prepare_folio() into kvm_gmem_prepare_folio() and extend
the #ifdef guard to cover all of the kvm_gmem_prepare_folio().  Providing
a single-use, ~2 line tail-call helper adds no value.  In fact, due to
having to reconstitue the gfn, the separate helper is very arguably a net
negative.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f4f8635d1a10..d5d3688eb1bd 100644
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
-	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn), pfn, folio_order(folio));
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
@@ -101,7 +89,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	index = kvm_gmem_get_index(slot, gfn);
 	index = ALIGN_DOWN(index, folio_nr_pages(folio));
 
-	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
+	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
+				     folio_file_pfn(folio, index),
+				     folio_order(folio));
+#else
+	return 0;
+#endif
 }
 
 /*
-- 
2.55.0.795.g602f6c329a-goog

