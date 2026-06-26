Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281B37FF71
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515669; cv=none; b=GRvb+gkdmrFFi0ylDKWx1BJhPffKBLtoXoKiuFNvyp8YQtPxePxCwooviqDWoU4NlGW/Jusugvsgb/NxPOZ1FnGjqy26u3jT21VPPIAz8yjDUwYivtNjc90phADEuyxWIfBz8g+epgDXtFdQ2PkjENlK0ZSuWb/teTLXNgp+FVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515669; c=relaxed/simple;
	bh=HDQ0/SmUR8P2wrw6bDmFK3mTiMl9hE5SgQmyDRdNmmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3tqqKhEIAx8HHMHhvO7cGsbSjsWtm2Ake5ykHWfd/TQg9toX2SyGdOcRlK4TbAmd7jO/qIMiVTkS18KvppoBVwQ7dcsRMU+iXmwlYSv3yclbTukTEMFvVrQcwGcNveUcmwy1H7/Pe5+hI/u2fJOJFLBmYKFHUDObP8nc2ZV0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYKI//Iz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYKI//Iz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88d7a75507so1706794a12.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515665; x=1783120465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tXSuABEgv5B5SnKG+CshlgzGKdJtyzAKOpUfrHhhZAw=;
        b=WYKI//IzCJ7pqPIz5Ai+G5nWIN8HhANbt0JHRULHXmAvRxkhStQ63/H5qo+OkyRUr/
         S9K4rASregouoH0o3nSad6qj2F6GYs9CeADFlm9Reh/sbLPOtungz9wQesQSanqvW5R7
         G33PfERir/FvqpGMUQM3B6O2uSMiOL68vnoeq0/y1YDZRXfa28RslzoxDIdnoZxD7WUt
         /5C9TEVLxIYHu106G6wAtf7+NSPKEDLlTaDDna+oUkAHO2V4XtQRjFZIJ5xP5EJWgB3U
         4XSRCdhId/I6H+bBY9oo+jz6a8M8DFaOBrlVhR0QdBMxyRB2Ln+9sJGNREitvNKK5sJf
         FubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515665; x=1783120465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXSuABEgv5B5SnKG+CshlgzGKdJtyzAKOpUfrHhhZAw=;
        b=Kc9Hl533uQLGQdOwi4TRqRsGFeqSTyrPiKPeD31t8P22ejKxr+ljmD9M6pJdkNy8Kt
         so2jwilaBlAQrHdAA/o0MsqrgxND1Ybap3YExUPQLJPsm8Ne6FTWR5woi6V0HqKqN4Xt
         Ul4T+R26Y2Alm3slaJI3k0+2q8rOeSkvg6Q//3kWcQU/xkYTbGHaL1XLV/Ku3T9DsvRv
         1yPF9NzwCinixgbBRFBItvXWEQm/UogwWe+Gt4e1lFI46xH9fjwraGGkpCzUJiPkt1sg
         DIkDJ2VqEJOiLojbnWamtRpX/MtquyvhvAM6j/s2UXoB4CReAQBTn12RVhG2md51V3Oe
         dedQ==
X-Gm-Message-State: AOJu0YxzcBODV2p6NsxDWdNYbdwWoA6Fbr06U20MzhZfV6JbLLnAyf1t
	cuS1RkUwTsnRm5tVFcWDRCM/XYM9N9dwVepzT8CqABb0O3BdtXOD9kub7z1uE3YUVLHFTVWdb2e
	Uhup1dw==
X-Received: from pgah23.prod.google.com ([2002:a05:6a02:4e97:b0:c8b:18bf:75bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:407:b0:3bf:6c08:fba2
 with SMTP id adf61e73a8af0-3bf6c091439mr2064003637.54.1782515664771; Fri, 26
 Jun 2026 16:14:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:12 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-6-seanjc@google.com>
Subject: [PATCH v2 5/9] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
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

