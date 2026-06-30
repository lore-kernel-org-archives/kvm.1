Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480533C1B4
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858385; cv=none; b=FR32N17zWlFdbMT8KI/1WDvOTUrGeccUmhOFWoiYqWl2Tg5pjcf2Y1N7H2wPMmwxy2WI2LdOASPzMM4vtZgMBfDiiZFf8GmHpM8xVDnBtrYmxD/LyeVGVnT9dls4L6ZsnUcvglExt2t0Fyk4+Wvj7KHUx0jqhaaBvPnke+odess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858385; c=relaxed/simple;
	bh=HDQ0/SmUR8P2wrw6bDmFK3mTiMl9hE5SgQmyDRdNmmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMqUaGb+IvpMXtbpBrutuKXi5klgE5mf6Oy5157CtvZOo78iq41YvET44SINlBlYxrsywfs5HFY6Sw/gyz+XDYIP3fhEYw6m5sBowTBJK8QiYuFkBzBGJQ/j0SECqcte7KCKguP2gVCCzJqfpl9sRHHBNASAGQ3BhTn1T9kG6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHRhfPRs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHRhfPRs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9e994869aso329475ad.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858377; x=1783463177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tXSuABEgv5B5SnKG+CshlgzGKdJtyzAKOpUfrHhhZAw=;
        b=wHRhfPRs9Bxf2dKufpBSSERTQ4OmlWXjgQQX32x56EeTVqjgijiGTjttExZ1/JucUI
         PiRQDvOgD6CA76qWFtRe9jqTEhdaMRIIJDP12IpKE/6iA2OAw6D7/kLuZhiYXLR1ZDUq
         2eHv957Wpc6LoJMn7BVmUO2K+A3XmP+LN9ZqjHeTel5nNe/ZRtI4UVzR4GuOqSuvM/Sr
         C6OSSwa4+NdQG5cdRl9HNQQvtyYlsQLUhT0S6D1mMDIZ9Jg4Y2y9ew4vyJg6ZFwMs2Yv
         NhH45wdYO+yC0wpkUeT9asBVLWhGaV6R0wnSYz1LkBFfy+6zu0mh2C6YHwCRu9ZuNGR8
         lFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858377; x=1783463177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXSuABEgv5B5SnKG+CshlgzGKdJtyzAKOpUfrHhhZAw=;
        b=cdxatba4MeBrTjuihwFBoKc74qeQZw1TKnHqUuGJJfXh+jlWO5VSjSsG5Kwv5F8M+F
         WYd3+mOjNgumwnYDPQVaWVN6EJgTnaBJdJplk5iL46v2Hc1UDp4d+Q9OyR3MCN7NT0OK
         BvD8WLerC+seboiSbBuPYC3XZoOnz3J7264e5YpOccFTdioif6wfLt5zc4tdJTaSZ0Xu
         Zb85Ghb0IcIjW5fDJA5EwIcxZqIPXRvC8iE/Dnx/fEdw7EprwNKmXhiFENrWUm22pUZ3
         ILVbf8FvhKNAUEmN2HeYFjTl3+GJ7FXRXa3HvFXGkied9iZBemxhoDNh7dmrX7BwFVzn
         OmFQ==
X-Gm-Message-State: AOJu0YyV1E/yHaYEPhPBKMfxYZiMqEPGJ9O7lKtkfPNy9AiLFR7twApw
	WAK+RjuspDPKiVyUxwZ3ZIEX40+sqJOZK3bo55BgQQK0+bJFbAwgjZubimOUStmEbOFRikqCd2e
	KKembkQ==
X-Received: from plog13.prod.google.com ([2002:a17:902:868d:b0:2c9:a286:684f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d588:b0:2ca:320:f74b
 with SMTP id d9443c01a7336-2ca2e4309a7mr44568505ad.21.1782858376482; Tue, 30
 Jun 2026 15:26:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:02 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-8-seanjc@google.com>
Subject: [PATCH v3 07/12] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold kvm_mmu_zap_memslot() into its sole caller so that its GFN range
structure can be used to trigger guest_memfd invalidations regardless of
whether KVM will do a partial or full zap of the MMU.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..223d80b12b9b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7560,8 +7560,14 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
 	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 }
 
-static void kvm_mmu_zap_memslot(struct kvm *kvm,
-				struct kvm_memory_slot *slot)
+static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
+{
+	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
+	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
 {
 	struct kvm_gfn_range range = {
 		.slot = slot,
@@ -7572,25 +7578,14 @@ static void kvm_mmu_zap_memslot(struct kvm *kvm,
 	};
 	bool flush;
 
-	write_lock(&kvm->mmu_lock);
-	flush = kvm_unmap_gfn_range(kvm, &range);
-	kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-	write_unlock(&kvm->mmu_lock);
-}
-
-static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
-{
-	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
-	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-}
-
-void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-				   struct kvm_memory_slot *slot)
-{
-	if (kvm_memslot_flush_zap_all(kvm))
+	if (kvm_memslot_flush_zap_all(kvm)) {
 		kvm_mmu_zap_all_fast(kvm);
-	else
-		kvm_mmu_zap_memslot(kvm, slot);
+	} else {
+		write_lock(&kvm->mmu_lock);
+		flush = kvm_unmap_gfn_range(kvm, &range);
+		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
+		write_unlock(&kvm->mmu_lock);
+	}
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

