Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B9282F1B
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762571; cv=none; b=g8dKFYG2ZscjGS+6hnaNP4wrV07g+OFPddxs1ckcNJbXPEO6eDazCZCpcGiy8yWmS4Ioxie5Cx4hQGrzh6gkBiExV5EcoG7bfeyGRkmDqFODqvcbgjgA41wJ6NVe5l+HrgCXMWopDSb8YDYYgFiO2aEL8LYuXMQRiHxpRRDAjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762571; c=relaxed/simple;
	bh=N3KhGuurOfNAdflb4lT6TlTE27zh2L+SziWwZzTsYoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJOGcmzQcIyMCQnhVDHSJ7uG89OVBnXwnaIgalPQMMGaCKtylV2m/F6fdkaDYYtdcn8qQCXP7ez6UHGV3oBcz3MVgrz89FMoLip6vfmZK7BXWZ692OHMu5biauDBoG7VBIqdBBgdzkmXeKW6pjdBCG0GM7M3pmFPOpEmXRFU0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hV4FhYtr; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hV4FhYtr"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso856666a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787762540; x=1788367340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T9ggCE2s4lQUcVzu7FyWkmkWQene3zbgM9NYxUP0czg=;
        b=hV4FhYtrVsqpYlqspNSJ66iqkGEbPoQyqTF4n6VQx9xW490UO/LLkay7j2Gt7x5hzy
         7emkWgHDgGAJkupB0FNNMWSrJ9JQ37CkDZnnuO85308h2E7wD5SkBh8a71XMwWKVqbgs
         txTDshkMUgywBxKQqo4j1qg/ldAtXtFK60ZleQxBLlw6uhG/L8rP32a1NxdkDLCcfCd5
         1l6XcOxOn5esGWTblmW70lZb+xDILNTNRBhjrjc8gC5Nhj+AJXoHDftawRJrdPeT3+IN
         RXi6prRs+15dCTXYCIRPzocc5dQCiuM2nHQy8uGoYkUA8XKbMPx42lwgv0eceAE8Uodd
         cL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787762540; x=1788367340;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T9ggCE2s4lQUcVzu7FyWkmkWQene3zbgM9NYxUP0czg=;
        b=XHz4timpN4b0CBSeYWtgbx4YLuBqRd6x9jLhsG0XkWOcvmC0WZlQghrY7qJvjKAjcb
         w3fljV+eWgAanQw+7PNg2IrT6w9eEsdos0+GTPAv87DVYM08H8oSOZVmuS+09ufau+mI
         u+RV2SVHT1ledAIAg0dzZczZaX3CbgF+oynXw+dXy0lJr9AZcVW03Uy71CPNRRIqmP2K
         jKuHOBYNTnnYQr7bmaYMR07oXE7tYstRvrEKGuZEP/BsKqbRlV6i+pCN0GUFaWS3Y1fF
         xFWLwzfkz0wJKzPnkElRUA6K+W1EdlSm6KohSxy59lcPJ3fHPRDbJRUCvW9h3KEXNuiU
         fdng==
X-Gm-Message-State: AFuF++kNdTdWeljUMNFCquON8UXAbSlT3jpWxtasjSFG4xC5nFuXm2sc
	/lln7FQ3YeImfA7zEqUtcg67X1RNzU0V2kcrajdQ1bDklbwiXBcDgVw76usGXwNfpF3ZxiSDD16
	WQrSGKA==
X-Received: from pgbct7.prod.google.com ([2002:a05:6a02:2107:b0:cc1:d48e:146c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e210:b0:3bf:63af:855
 with SMTP id adf61e73a8af0-3cf762865fcmr14724358637.1.1787762539550; Wed, 26
 Aug 2026 09:42:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:42:13 -0700
In-Reply-To: <20260826164214.756512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826164214.756512-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826164214.756512-4-seanjc@google.com>
Subject: [PATCH v2 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When mapping a private PFN in TDX's post-populate callback, top-up the
memory caches on every attempt to map the PFN to harden against bugs in the
map flow that could consume cache entries even if mapping ultimately fails.
E.g. as pointed out by Sashiko, the in-progress Dynamic PAMT support could
consume PAMT cache entries on TDX-Module lock contention.

Harden KVM even though consuming an entry on failure is considered a KVM
bug.  Retry should only be encountered if KVM is buggy (the locks held by
the sole call path will prevent retries from being needed due to
TDX-specific details, and memory can be faulted in only once the VM is
TD_STATE_RUNNABLE, and KVM_TDX_INIT_MEM_REGION is only usable if the VM is
*not* TD_STATE_RUNNABLE), top-up is "free" if there's no work to be done,
and populating a TDX guest's memory is a slow path, i.e. there's no
meaningful downside to the hardening.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260718061050.E17B01F000E9@smtp.kernel.org
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1969c26861e5..19a501029f08 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5209,10 +5209,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
 		return -EPERM;
 
-	r = mmu_topup_memory_caches(vcpu, false);
-	if (r)
-		return r;
-
 	do {
 		if (signal_pending(current))
 			return -EINTR;
@@ -5224,6 +5220,10 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		if (r)
 			return r;
 
+		r = mmu_topup_memory_caches(vcpu, false);
+		if (r)
+			return r;
+
 		cond_resched();
 
 		guard(read_lock)(&kvm->mmu_lock);
-- 
2.55.0.860.g4b6b3295ed-goog

