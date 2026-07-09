Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF03E6DC8
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630200; cv=none; b=ZQ9SlJlp5d9SeqNrylRZ2V2yx8EQv0ZKegv/qS/bdQfLws6EIntKJFhv4znKcQZnvSenogCrPtofV+Mb2akFma9sPoEF+hFUSt+30OkgvCHEcFzxYwuYKHqL/FSd0La+gDP78d8z1s//OQRJV7qdPhR1gW5KEPSRg0SWda6E4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630200; c=relaxed/simple;
	bh=k6MIBYPgc5BvxRuSwy52muPzNtxp4iSdtSsOMLQGP4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wke3+FpjC8FReMisGx/xvNMNUmPhONEZ+TzmVCCN9qccSle735MjvuXD04YY4vVFr39ASgsLx5SF7PWxvQWlGAIrlQmPif5gxifcFrALdLJ5QXt7wPmkiXXLff+2uP+g4sbTNPsVSepC4f3leHponZFrY86y4VXIPiCjqn9uPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weaxX1yv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weaxX1yv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cca3673560so2739065ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630199; x=1784234999; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LRCny9dqRzqQH6gwCJ1hTwUpUfXfR8aed5HGqy5DrYw=;
        b=weaxX1yvTbfxNaT0UGfwzXjd9CNo7WA52UvRjKLJp5UH9ZaPY1gjh2dGcIaTjDYVHC
         Q8C2QGw1oFs29gY/UpEu79diiOaj8b9lh/wCzaKJqYxp1gaOJIjYpwdQH/E7S4HpFHbi
         3ybxas0JYxLdqWlHTVD9hXmQEwFuwcwM9Hol7a+6vUVCwc+0JjZ2FxAS8MXicMwNDDYS
         KH2VBXtMfRHJxynK4ySl48B9owmrnrB7Jg8ZgyOCR5uEdFYzvzeYr6IchFFI5UzZEkeF
         8LK89NM8K51tVQFS7tgZRKFfRRU+FkQUpGjnk1yIKPJ3xj0VWyIo+IH0RumUepvDHsaV
         JpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630199; x=1784234999;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LRCny9dqRzqQH6gwCJ1hTwUpUfXfR8aed5HGqy5DrYw=;
        b=gYg5b+DEAPAaLvLpbf7o0thRPrctH+sGl+UARtTMP009FkNYN5hQJ4Ebr/7gf7Zcxc
         fFJj49waQczyahrXxj+zELSZbs6p+R2krYlNidL4KLH4wdQNLas/Yxu0EhJOgvhdCcB5
         UDgRZVNW6BZrFi+ue3rnNmmV8JpNaiHfNyvQoWoSWm/tWPxAKGpb2dXpVkN9u94tBOTB
         25YcT/OJpHwPk+yDIPEn3nwpgKylxpS5+jRwXFlXp+ZFgWJrL4FlCvxWgycrXW+WsDto
         yuv5buPNsQ2/KCMBpmrlS7pLCiyx2wNc3GJhsi7cPRR/36SUdVaHgcpzq3K9y0wWoFKc
         QQqg==
X-Gm-Message-State: AOJu0YyKKE6bsiKAYMJqyvjF6FpZSP46qQB9s0ui+WGRygOsfz5ZWMMM
	TnZypWgP7EA4zcZbpICn5BPWk/hWeOerQ6AmD94Q7NypekN1/xV5LIkLTgYjl2oboP6EYjGkY4m
	ZbdhRvA==
X-Received: from plbky16.prod.google.com ([2002:a17:902:f990:b0:2ca:ef0c:f8b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cc:b0:2c9:bf82:dd11
 with SMTP id d9443c01a7336-2ccea373128mr85802215ad.7.1783630198438; Thu, 09
 Jul 2026 13:49:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:37 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-8-seanjc@google.com>
Subject: [PATCH v4 07/18] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold kvm_mmu_zap_memslot() into its sole caller so that its GFN range
structure can be used to trigger guest_memfd invalidations regardless of
whether KVM will do a partial or full zap of the MMU.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
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
2.55.0.795.g602f6c329a-goog

