Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2F42BC36
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052461; cv=none; b=lRTEJHchpQ/VEJVAUDfnsSfuXwqLWZQgV7eCB8UZwEwvTl10sxqtAFIbMOBBTwL+PRKtxaUvdEeLi3sggwSsrznaEe6xjNb5DreCwBjvoaJN03wqwMHwYQ1EEcCysi9lQ0Y6RjCG36RG+h3Aw+3Qnsyjdib8Xat3dzMMAukNIu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052461; c=relaxed/simple;
	bh=+O/AF4uYXNVy99eduE1BlXJm9BGh+j38uEA3Ic0iCPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RRIWdE8Xi3lcGHFJI8DjuXzdvm1UlZS6wnxLC+LWSqTEUvDDRaP9qUC3TGX7FdbKE7gtRXmDhIwpFXFEnq+p82QY2mFesLmyTKz2/XSGYbO0RFQTa1xqAUlsOLrizt8erIY/BnIHqZUU1dVyvPHxWQpu2MTvUezr3Jbyv5QWnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEZ2akTh; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEZ2akTh"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so37054405ad.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786052459; x=1786657259; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RmJui4amYNqqPOSkRmfgD6DH/shD7OhU51lO1MsWx68=;
        b=HEZ2akThSvdZbk+7aA8vIV0ZBUMB17Xyb89fWg61TuLBrOYONMZvU2k8kSJ9tn6abU
         UjIwyMBqjmOLklWbLuhXuo+5fL2L3W+j/J7vRn41Yr3uFSlDA2hGFdl76jRa/DgsXkqk
         hDK+MhZWa1NgeTTMUIbvRiVymXVt7bglEYWHn0NjbCqQX6/QMw5WVogm62KxGNqXIzCZ
         I2z3EUeA+YN1eIYr1+cn/E9J4yQwRyXNddhfwOwveHsiuK+0fjQ3mY3Sa1bjyyLYqjQO
         jEXxw0491NUO657j7ZuZ1YWDPR0fyDxN0XMPFV+Vp4o+VXL48z/XVQygEwS87VngIt0z
         3OEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052459; x=1786657259;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RmJui4amYNqqPOSkRmfgD6DH/shD7OhU51lO1MsWx68=;
        b=fOzV7Ii29/wyrchlThi5Nnm566IwLm3ulZvTJOuzCxn6M/hjr2ew2ApY3pNkwGGPh9
         06M2Gcys+sAfV4MbDAyxx2tCNCijCKhdk8I4y4KID68hM1vJ8Hh0j1NlxR0uif5JYDHY
         cIaNQ/hlrKDtRJnN9ko9AXfBHfqgOOhzskF4osczzJCtzpvgLcfRzDVB2Bkfdf3RDx6V
         5BWE7EUsrCQZSYS2ft5+4haG2iTlYalL1llJyl6eLa9yWA07Ch8D2PWYkmHs5COlijoL
         USJlVd1DFWk23kFKP+WSlv2eubFKb+k0BzbO5HgQORFD4ubNO8cyAwwFu+VoaBrtN12+
         KjfQ==
X-Gm-Message-State: AOJu0YwWcB/JYHYmbTzaIffRPB0Ii/PQ6DuxG/2+Zwx7kq9TzLMaFvIk
	oOLK8VmW9pLjf9pJy5UkwPjdH0JxDGgw/KMIHY20uHy+81IsHUt1bQkH5MXlhnHYn7yF6U2xPPV
	aPeu6TA==
X-Received: from plbmm14.prod.google.com ([2002:a17:903:a0e:b0:2ca:cf09:91ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c7:b0:2c9:b48c:fdec
 with SMTP id d9443c01a7336-2d0ca75d2admr231460015ad.12.1786052459403; Thu, 06
 Aug 2026 14:40:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 14:40:50 -0700
In-Reply-To: <20260806214050.78058-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806214050.78058-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Harden the "map private PFN" flow against potentially-fatal bugs or future
KVM changes by checking for a stale "fault" prior to actually mapping the
PFN into the guest.  While it should be impossible for the "page fault" to
become stale, the sanity check is cheap, whereas a broken assumption would
have a high probability of leading to a guest-expoitable use-after-free.

Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
positives, even though doing so completely voids anys and all protection
against unexpected invalidations.  Pretty much the entire point of
kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
gifted by the caller, i.e. the caller would have to mess up its one and
only responsibility.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 379f570ef04f..76e3cd717324 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		 */
 		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
 
+		/*
+		 * Snapshot the invalidation sequence counter after acquiring
+		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
+		 * i.e. any concurrent invalidations are guaranteed to be
+		 * irrelevant.
+		 */
+		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
+		if (is_page_fault_stale(vcpu, &fault))
+			continue;
+
 		r = kvm_tdp_mmu_map(vcpu, &fault);
 	} while (r == RET_PF_RETRY);
 
-- 
2.55.0.679.g6767b8d81c-goog

