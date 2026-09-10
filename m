Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA75013A3
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057446; cv=none; b=Ssijo8jhHwJFvEsdyUybYczFoxuwECvkhny09ep+5d5LYsTqONV98CP4IOIxVMaw1jWRA/H6vUN7PPcWd+j8XAroejovotaFGa/AK4/mk5QccJIgIdAr9mHqVI558pF9eJby7Pxo2nHdi/SxcViE4AImIu756CihPWHp0wc9rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057446; c=relaxed/simple;
	bh=Dwq4yWxNTOPewjvgBHCVt6k8PpiEcRg1OwsQvoXmnaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kZtxGjkfvgVkU7gI2mGV6skjSFihwvu9qyrU0rluC8LNqyLS6KkpynfKgkZ+ciR9X/mkgYvcNbh3+e29pyuBShRRTGalN3uYoTqX/UZVtg0FluvRy8rfW0pTRTZmQdSxSBhUmc55bw1IK6WgcRid1fRmllsCgrg5tw0VDJNNW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ph6IZwIM; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ph6IZwIM"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486e9341847so44077f8f.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057441; x=1789662241; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uC0obBsMpYIPwDDLkx/VVIyvnyMYMqgtwKGzNKgjqas=;
        b=Ph6IZwIM2tdp+/TbYjMKGDXDoCwP2Tv4UEYk7QjLyD6z9P48xnWpUikLyCtxVev1A6
         LNSFBjAlBX65bS2jLV9fanv8Y+I2pIpML4O1fCo4OOq1KKyHbwmJGZgxd6ye13hXZ/5e
         iTeUjODlWl+sUVLL0yUsoKJNRbfN8Du74xk2z266tnKos0DPT3F6JJjPMsBCxKnOwYy3
         AOr7adylDXU366qV8fLTJjUIMvX7ltVMHSQlDMcsgUdTctn4673bToeeP1fQxx+4brIW
         zUatn+Qnw19RSVSOT5HZJ5o3AJ4gC4EZ6F7nD/u6t2sjPARD74H5ycdXJ6Xa42uYlJjy
         K9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057441; x=1789662241;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uC0obBsMpYIPwDDLkx/VVIyvnyMYMqgtwKGzNKgjqas=;
        b=feLbiMDu1+gX+mm5M2hUtHME5Bv+gWeW2SFEc4ou6LdveBt4x/rHvmEOZtgDcm979H
         ZcgRVKEDRIqAXauw+keB4PZrLlp5j+yJR7IF56lzsZe/jEJZltiwcdVfJuYup2woEXR8
         TD6kk8H+B5TW83a4wZjAgTBQVZBiK2s9sj1Igyu5onJj25ohO/9zcKWQNcFd8o4Gc2Wi
         aMTXsY0/R0Tortua2Yn9lb+BPSy7P0RufbDmSPDual3PgLrp2o/8xJ+nz1dr6vYNxfFl
         +PkLnTBUgtG9NAZR9RfPFDcOOdPnDCCBQvY33IVsb1XlTrfV2SV9sCx3tNAW+SBC2onn
         d6PA==
X-Forwarded-Encrypted: i=1; AKwUvBzIkDGtDl/NS9c5qaghj11G9l4hkcgjqEAkztzegXfQK9uKu48Hf43KyM+bsdBcEwptTYI=@vger.kernel.org
X-Gm-Message-State: AFuF++npuAC8YDjE+uMN9xsoxWf54Z0v5KyR7LnBNeNlutWZoAeoeJBq
	Pw9UB+VLBGYLheUwNdEeD5APRrAXci10NB34dSPYFcs90XfZW9wcrdSR2HL/cMKZ0ObCS11nXAn
	tpw==
X-Received: from wmht20.prod.google.com ([2002:a05:600c:41d4:b0:49d:659:548e])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:198d:b0:49c:fa21:1c7c
 with SMTP id 5b1f17b1804b1-49d1ed0b452mr135146635e9.17.1789057441100; Thu, 10
 Sep 2026 09:24:01 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:38 +0000
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-6-elver@google.com>
Subject: [PATCH RFC 05/10] KVM: Refactor kvm_handle_gfn_range() to avoid
 conditional mmu_lock
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor kvm_handle_gfn_range() to check for overlapping memslots
upfront via kvm_for_each_memslot_in_gfn_range() instead of tracking
found memslots inside the range iteration with a 'found_memslot' flag
and conditionally acquiring and releasing mmu_lock.

This simplifies the control flow by cleanly decoupling the search for
overlapping memslots from the subsequent walk, eliminating the
conditional locking and establishing a clean, unconditional lock scope
for mmu_lock, which subsequently enables Clang context analysis to
validate locking in this function.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 virt/kvm/kvm_main.c | 46 +++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f7bfa2d32507..f86e690a1798 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2485,14 +2485,13 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return true;
 }
 
-static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
-						 struct kvm_mmu_notifier_range *range)
+static __always_inline bool __kvm_handle_gfn_range_walk(struct kvm *kvm,
+							struct kvm_mmu_notifier_range *range)
 {
 	struct kvm_gfn_range gfn_range;
 	struct kvm_memory_slot *slot;
 	struct kvm_memslots *slots;
 	struct kvm_memslot_iter iter;
-	bool found_memslot = false;
 	bool ret = false;
 	int i;
 
@@ -2519,22 +2518,45 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 			if (gfn_range.start >= gfn_range.end)
 				continue;
 
-			if (!found_memslot) {
-				found_memslot = true;
-				KVM_MMU_LOCK(kvm);
-				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm);
-			}
-
 			ret |= range->handler(kvm, &gfn_range);
 		}
 	}
 
+	return ret;
+}
+
+static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
+						 struct kvm_mmu_notifier_range *range)
+{
+	struct kvm_memslot_iter iter;
+	struct kvm_memslots *slots;
+	bool found_memslot = false;
+	bool ret;
+	int i;
+
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		slots = __kvm_memslots(kvm, i);
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end) {
+			found_memslot = true;
+			break;
+		}
+		if (found_memslot)
+			break;
+	}
+
+	if (!found_memslot)
+		return;
+
+	KVM_MMU_LOCK(kvm);
+	if (!IS_KVM_NULL_FN(range->on_lock))
+		range->on_lock(kvm);
+
+	ret = __kvm_handle_gfn_range_walk(kvm, range);
+
 	if (range->flush_on_ret && ret)
 		kvm_flush_remote_tlbs(kvm);
 
-	if (found_memslot)
-		KVM_MMU_UNLOCK(kvm);
+	KVM_MMU_UNLOCK(kvm);
 }
 
 static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
-- 
2.55.0.1003.g10538fe699-goog

