Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB9328610
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858382; cv=none; b=VHH6v83Yn2/anoKCyRR0CBfn9TW5hhhGvsmzXk24jDJ8nW7u5HQoGfWXjDcO8C1NTRkqJGI1IlbupXomvPrLh3tbkPSymciDMFNfvkYH1amLYWmRY7wmnU51uVStg2XLZgcu2IF0iX28FNEFna6/qRPtW9/+8AISuLtpBUwiAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858382; c=relaxed/simple;
	bh=DfpuHd0TaA0GgqDWJl9pbNH0qXb5Lm2X4Nx8yduRal4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1RLbHidk5GHN+LrQLpUEPZvfdyVtMLnvEjO1fCmZMfUkNPX6QVI5TWUn+vMumMcr/I7OQDx+GrCjEG8Wn+Mr1eiZDqtylodN+152MENtWABDFHYxsgHNxdjcDOs2DkDwxp7qKzcAK/ldH2q0OicmhYZRdnffMtf7cJtFSo9KE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnZDjJYy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnZDjJYy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8969083f23so2814090a12.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858379; x=1783463179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0+OQWyaXGjZtp4FlDYBArcJJ0vLQ5n2BcbCSTzfTwAg=;
        b=ZnZDjJYyP9dtYOK4LUBiplt+faXFx9mjEnAfZlf+rMrg5FThkT+9h6kk3f60esEr2C
         EFrXquE491h0O5C+ZnH7c/8fHI+B0cSt+9N2c/0G0fB9Wg4xRaKn30Kn2CEAXvachlCh
         p1ipO3zb/bFQ0GAWVyP5rqDFy3xr23KKqYgCn62PcOJ1vsKB9HR9V+jPg71maie2DRMh
         TLgLDn9DZmzagGKXt/z+7Gk9EGt7dJ5WDkcGjFNcebfLrT+4TFtmas5uaUPOF4l63MIr
         HuJk1oh/5WfdrCdQj1DMWjfH//RffKRmMinb0MGN3FBhkwqMqs2gyNbi5Ct1Guyhm5w1
         IF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858379; x=1783463179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+OQWyaXGjZtp4FlDYBArcJJ0vLQ5n2BcbCSTzfTwAg=;
        b=Ox8xxpHqL0MkjEKw9kucsMu+D+0mNdSFia+bMXeZwzUqDI06wG2lJXSkQTyrrt5HCa
         +FaSIvF3Rrr0ofbycWss/3j07DENI2BATXsz8Ytp5WWJNMfBQP+KyJCkARi5dIcRLJir
         5O+feAnYejjYXuINcx72eE4UOwrDtIlROO/7DBaumaOmEbGL+D2WCsjv6eXP+bNfGvBD
         vu/rJiVIKwdTyjLsMrPRgotNlfibG3yOX1J6gghhFbW3Bh5AeIOrjEi/DRF56lc0DTyG
         ReZBuPAwmxIsoh1xxgKRuszR5YxBh5547DHqQaqdcr9aeoOAH0aGz+69M/XsmhyvPoMX
         K1ZQ==
X-Gm-Message-State: AOJu0YzNXoO1ruEUp+tJE/0SlxYsqpz+tRGTOcotHvO9W7jDnnf5Fmg9
	hrXixUEHe+QmiigA42GTNOF7iC9Bk8F9FZId/hdg8yugkUM96EEF1syu6BS547gMstvI6KVtRuK
	j0r5c2A==
X-Received: from pgl36.prod.google.com ([2002:a63:b24:0:b0:c96:d708:ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4593:b0:3bf:6c04:a812
 with SMTP id adf61e73a8af0-3bfdc803713mr1979487637.51.1782858378807; Tue, 30
 Jun 2026 15:26:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:04 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-10-seanjc@google.com>
Subject: [PATCH v3 09/12] KVM: x86/mmu: Use split "zap all fast" helpers when
 invalidating memslot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Manually invoke the front half and back half of the "zap all fast" flow
when invalidating a memslot so that mmu_lock is acquired at function scope
in kvm_arch_flush_shadow_memslot().   This will allow putting more code
inside the critical section without having to take mmu_lock twice in quick
succession.

Opportunistically open code checking whether or not to do the fast zap, to
discourage removing the local "zap_all" in a future cleanup, i.e. to ensure
the SLOT_ZAP_ALL quirk is queried exactly once.  Processing the front half
but not the back half of the fast zap (if SLOT_ZAP_ALL were disabled
concurrently) would result in KVM unnecessarily keeping invalid TDP MMU
roots until the VM is destroyed.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5c2a560a88a..3eb1f86593b1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7573,12 +7573,6 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
 	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 }
 
-static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
-{
-	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
-	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-}
-
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
@@ -7589,16 +7583,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 		.may_block = true,
 		.attr_filter = KVM_FILTER_PRIVATE | KVM_FILTER_SHARED,
 	};
+	bool zap_all = kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
+		       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
 	bool flush;
 
-	if (kvm_memslot_flush_zap_all(kvm)) {
-		kvm_mmu_zap_all_fast(kvm);
+	write_lock(&kvm->mmu_lock);
+
+	if (zap_all) {
+		__kvm_mmu_zap_all_fast_front_half(kvm);
 	} else {
-		write_lock(&kvm->mmu_lock);
 		flush = kvm_unmap_gfn_range(kvm, &range);
 		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-		write_unlock(&kvm->mmu_lock);
 	}
+
+	write_unlock(&kvm->mmu_lock);
+
+	if (zap_all)
+		__kvm_mmu_zap_all_fast_back_half(kvm);
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

