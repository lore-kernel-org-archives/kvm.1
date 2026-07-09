Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E33EB0E8
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630203; cv=none; b=lD7VG7+BXUf9pST+O2TG0w7ox43CPeFM7KC1sWbxMhj1SlKRJW30YxR+CZCvY/mJI/GqB8Wjkam88tqb5jB5Fxqpdce2dXc7645Pw4LpT48WiDrjXcJ3N4jK1JGl7leyEO8riQxwJEp4YKUAVieK1XP5XfurOtVrLNaUcacP66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630203; c=relaxed/simple;
	bh=I6cf1ipgAMfP2hWVj7O5rBXYIx5YxCt3YTk1+uufLmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IpNuaL8Y5C6fvneo9b8aQUmowJmxHTHZMswM5tcJcrUu9/YeUTHiSbeNHmvEI3rQRRtgd8E5Ul/Jm30azqYOPFgkDzkfzf5kmOXEKPO2LYIffxwSQ95XZ8LEbiFwZ7T2IxH936O+LTg4viksPfjhP4qMp8HQuqqiL4H/th4tles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmfmuzMe; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmfmuzMe"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84854c2f888so277456b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630201; x=1784235001; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TsRcXKumPg5adzlKIgjA7SyT7NQZsPMu5TrBeJka9aw=;
        b=kmfmuzMe1lMVizv47tbnn4qzookKB2s+73/vXz/8EFGAfvnyDJglgbL86dYVrY4BNg
         H8RIYAQlzckSYAEgvhQc/N8Yd2fPs3kwU1mBjObiTVhKDU9DZ7XF/JAAmgmX744s8Bex
         h11gygPwPgdy6y7vLVzHff/9ijzTvrCMZKMYKeKZ02xrXqQFq3X9wfCVdgxT4Eo1AB2j
         5q1MLbwnkz5WVg2aqCaZv+di78xmMufB2PEsmCc5IaNyBHZbtHLd9HIOCBUTZN2fhS9Z
         VLAXHJ0CB2jGhOBIIT/s9hZGoUUSQ6L/IMUR/wINqLepRm3tVTXJyqJSpDFY5gKFkwZh
         CPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630201; x=1784235001;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsRcXKumPg5adzlKIgjA7SyT7NQZsPMu5TrBeJka9aw=;
        b=DdeTac+teg8HRV8mmIujP45aF85MWdVm5IFpsSW9JloI14Gvc5IE7RUtnjh51GkmHI
         v2Rm04QOsG2OJeDP/wyAFdfpXMQ+cwpirRMyKdyK/M6Hq2ZQYTkCd09SSLy5LexdfYQK
         m+KMDOmtHwGviLOUCovEphvOFeruekDBeo9EV95H9yHjHjltWj1PBuOVtNltPmD5GsUx
         9POFTXICIKpplZ0wXosPXuNM6a2RBuYJUF34kqA6hxw2VCFwMnf4UF2L67Qv7jAsqEFK
         5oKDEMOJhpgzSXMLNtTzFRObCS3pgPXaef6Lupr54IEcO9BSs8I0GHE+lKRFR6flobkG
         BumA==
X-Gm-Message-State: AOJu0YzQQaZbaXlvrmpIHr3JzX1v38hcRC58nXRaMzv/lPLiX3/AxLmz
	5wMvuz2ACqCvbUX0LXIoDATttmpOc/xWCxibqDSXDhTCJoKFN7XPsUSt4Q58O0B5OM4XRJgB3sP
	TNyBXhg==
X-Received: from pfbg24.prod.google.com ([2002:a05:6a00:ae18:b0:847:a600:d064])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e12:b0:847:8107:1bd7
 with SMTP id d2e1a72fcca58-84843467bb7mr7202062b3a.53.1783630200555; Thu, 09
 Jul 2026 13:50:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:39 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-10-seanjc@google.com>
Subject: [PATCH v4 09/18] KVM: x86/mmu: Use split "zap all fast" helpers when
 invalidating memslot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
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
Reviewed-by: Michael Roth <michael.roth@amd.com>
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
2.55.0.795.g602f6c329a-goog

