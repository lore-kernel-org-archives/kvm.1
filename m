Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D263FA5D5
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473251; cv=none; b=nyK8NJx5C52nWB1GJQBfEtOFxy92VxOP1zTq83A8UyU2ltlfUCnPRQcqt6g/2hehkQZ7BuuWu/H+SJG5OvdVEvd/rLebk2/QeqS8g4IVvAMBwWlu6tWIMwazfGABF/nb5wu9JFD3vWaUwGrv1oL3QqPX1k5VCF9mAQJRBfCkc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473251; c=relaxed/simple;
	bh=S2QAy8JGBHBhYNzVUR/eqWXKqiH6+PvTpBfJycTSUro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRxgbCAN5DE6l3jUrprMwPgW0M37nVHQbrOH1cK0j/QLhkPv6Q9Dd0yV3Ob6xdzRTp6Tn6HYOTtQgMX6MJk6T2bWKjRtP2IJwgZWnGhjK6+VmqHFJ7DnHLcxi/LlaeK//LS5j1CnJJDefCJxEepmoTBHtfVuFKAa4Fd44tLikm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhM69ETe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vzw1Dzjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhM69ETe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vzw1Dzjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9eorR7UoTPTGz5Wvsfk5p09xxUTODUibVzBiPFZnGM=;
	b=OhM69ETeWE8EV7tOagPfJPy/SjsjUl1aBfF0czY1CulpVS1naoLuqRPP1OI1+pYIkHCyEW
	cyyaZcLnborL2xXLFwHuQQFllTEGnnLrKnVJQoSZrVWspQYd3oFayVCpZg+3mWSDaur+5+
	KsDf7f+xVcPKWeNZf6zFusKOjyM/9Wc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-y3WCJUm-OM2lUZxHsm7vNQ-1; Fri, 26 Jun 2026 07:27:25 -0400
X-MC-Unique: y3WCJUm-OM2lUZxHsm7vNQ-1
X-Mimecast-MFC-AGG-ID: y3WCJUm-OM2lUZxHsm7vNQ_1782473244
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924314568cso7730965e9.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473244; x=1783078044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9eorR7UoTPTGz5Wvsfk5p09xxUTODUibVzBiPFZnGM=;
        b=Vzw1DzjpyJqd8aXZ+wduL4438dhi+M5WNyATKVlLNurMF6s/tVY5rlPuF9KG1YJN7p
         99v46euz6k8dkIfc+kl/GqcGtWrrI2a5uDOLcDF3D13tHhBcDPv6zVBHyQjkLqn3YXO5
         UqtmuH+d9xrQ8ng5004lZuM9NQXZv1B7RT5GI2oagpTjNB294Oe1YAHN1xYdSUkF98e6
         KnSppBDa+k3bN5SgPXLaRLx16jxBDB+AqVOIVrM17nkqCGyxlOXW3yAn0ULvrEzN89sL
         iNp0ytmh1kbWnsSsFkYcopCU2BJKcA5kWF435OO+iothPZmcmZ9khTlm3SBJhJ/rRbJV
         mFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473244; x=1783078044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9eorR7UoTPTGz5Wvsfk5p09xxUTODUibVzBiPFZnGM=;
        b=rbnv/R+UsjSY2G5N4y/1Zyq8fAlkpdy1w/vBZ5tVZ4oy7pwQnwkuYOJwnPDgSukHK6
         j7jJ5WLq+ONnVQgZkdMAm3sVaOhfkyQlYzmYKobCqXVZq23ELic/w0WL+OXs+mIqeHIu
         7sRtqDRVxtSA553mDFBEcXZWk5NyLJIUthcOstkQYW9rfgP+MzMFmuV2aQpTnPKoTMDG
         se/ocOATRYz0vha+Zh2Ditb86BIUeXiLTguh3Ndj4ETyCapE2UIVZTdjzddgKqc/NhFz
         fDI5O/8MsePvT9B44nifpUO7PioFOd4s6sCUUq4cD5qD4cverYjyVLYBBqJN1xDTWeMN
         LPpA==
X-Forwarded-Encrypted: i=1; AFNElJ/uIuIr9XO9sfcnYSGtwAXO2tduKNKsfS8RLNZ7WZV7WEzdHHA217052pX9C0ZjuhK49x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnNRiX4rO75QXkyzhrN6itByXz/cb/xBB8wtikdhZ6lcO2DAI
	8pZj6uLZ15x8LW2Vutidv9+WZEJjQF5M5rAy5znGC4FnyA38lxW8IhJjlYOy6zoNG6wt4Q09+AE
	rhVA2Rz0+CWWekoB1qU5vHNfdVacARW4vC/UJroWslYNvVZkwPRK4oQ==
X-Gm-Gg: AfdE7clj4J/zSWIp7Fed+fh9chGPoeL2Y92AUIFIoBxPX9zAxOznTOZKL2owIfNPUxR
	4fEN0nSb5NiB2qz6j6Spqj6hnGakkbAIxbdjupcVAMd/6MciQI/6mF2STKyIDpu267TUY0ZwNox
	0bQ/mcUmOdOAQ5WNUaSrLo98YfJypKquXQ93tTznoAgvnZYChdx6IjgPbGgpX5plRuxlJmmebvG
	bYbsTuP5sRFLctYKdj0omKA/w9ZMLPXaCT843yvJxZLMlugq6ER/2wANiS1hBhifUmUdUVOXfde
	0+Xq4HHQq0DwUiLFv8THUJ0ig/VLvtdoBGaeo1ISwntu2kyJcgY2tcqBAvxIxcOwhocpqVuHv/Q
	xhkcoT3j6rIsA809CYluGC82O9wH1fujVktrkFEO6FJr/ARuPO2neh8Uj0K8iRqM+PEEQqrX+dG
	sajAT7xuyKWUjCs92Y
X-Received: by 2002:a05:600c:138e:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-49266832313mr93817695e9.3.1782473243933;
        Fri, 26 Jun 2026 04:27:23 -0700 (PDT)
X-Received: by 2002:a05:600c:138e:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-49266832313mr93817305e9.3.1782473243487;
        Fri, 26 Jun 2026 04:27:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ff9f40sm70920255e9.6.2026.06.26.04.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 16/17] KVM: x86/mmu: Pass the memslot to the rmap callbacks
Date: Fri, 26 Jun 2026 13:26:33 +0200
Message-ID: <20260626112634.1778506-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 0a234f5dd06582e82edec7cf17a0f971c5a4142e upstream.

Pass the memslot to the rmap callbacks, it will be used when zapping
collapsible SPTEs to verify the memslot is compatible with hugepages
before zapping its SPTEs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210213005015.1651772-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 276cf62eb94d..39186d695269 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1140,7 +1140,8 @@ static bool spte_wrprot_for_clear_dirty(u64 *sptep)
  *	- W bit on ad-disabled SPTEs.
  * Returns true iff any D or W bits were cleared.
  */
-static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			       struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1171,7 +1172,8 @@ static bool spte_set_dirty(u64 *sptep)
 	return mmu_spte_update(sptep, spte);
 }
 
-static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			     struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1235,7 +1237,7 @@ void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PG_LEVEL_4K, slot);
-		__rmap_clear_dirty(kvm, rmap_head);
+		__rmap_clear_dirty(kvm, rmap_head, slot);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1291,7 +1293,8 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn);
 }
 
-static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			  struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1311,7 +1314,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			   struct kvm_memory_slot *slot, gfn_t gfn, int level,
 			   unsigned long data)
 {
-	return kvm_zap_rmapp(kvm, rmap_head);
+	return kvm_zap_rmapp(kvm, rmap_head, slot);
 }
 
 static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -5298,7 +5301,8 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_max_root_level,
 EXPORT_SYMBOL_GPL(kvm_configure_mmu);
 
 /* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
+typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+				    struct kvm_memory_slot *slot);
 
 /* The caller should hold mmu-lock before calling this function. */
 static __always_inline bool
@@ -5312,7 +5316,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, memslot);
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5605,7 +5609,8 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 }
 
 static bool slot_rmap_write_protect(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head)
+				    struct kvm_rmap_head *rmap_head,
+				    struct kvm_memory_slot *slot)
 {
 	return __rmap_write_protect(kvm, rmap_head, false);
 }
@@ -5639,7 +5644,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
-- 
2.54.0

