Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2942A148
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052459; cv=none; b=UIDTtY5O7eIXiq/2P93cXTMrmxpFQiBG541BYpo4oK+ukii8J2n0MwZyXPfh2nRt95w3V6xYFJo8Pkh/j9GAiTPqiFJRvQD7Vp28ITy9hXQg5CjZsr5Wag5tTEgM/xXZFr4rfxK1JgrpIMHfLhQCwoJx8k8sriwfkRC+xoJeC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052459; c=relaxed/simple;
	bh=vERuOJjKIwts7JqEB+ZkH11Qq/PmOdDg/7G+G2HrLeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XzQT3z4A/D/+DB64Erup368ySL4xf4M8CVibKvI5ytGgXEOA1orUV4QrM7Cgzh7wrNIW8DsbkcYM14Q1j1ju113cviGXjfH3mOs5VmEWt6qvaXfZPGPZDT0ozjuhbzynOpD432uNyIJyKunsRpQieZEj8hqCrAXv+y+3GXY8MJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFwWUEGh; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFwWUEGh"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e04598adeso2212389b3a.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786052458; x=1786657258; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DBP0D1Kh/01rtZWlznil3VMqkDCrOu4cEL69wfep54g=;
        b=sFwWUEGhs9CQN8ZEp7wgoDigZAp8Y66tmx1vxcMGzYGUnxJdIsVD7yHkuVa5euf4Vw
         1RAQBuV9/eKWIzCSohjdbb6J2BRBQAZ7/NbndPpP+TUcMWpWaE3p5tAXQE/cxOSdsXVq
         DrqG1UnJfuZWOjkH+nyH5qPom7SGTPDDmUbKLk8MFFW4P4p6oJX1/ubwaPf7kzbsPYGd
         z3K1fPqd02JhpKSOAsmZHhPynO/f6FybvtkRqklVhsuMzlmYk30OlJVLUGnfRrUvE9u5
         fZ92ZMsH446PxZ0sFb5R52+aCLfA3MknardJ58rMg4pf3c1oIkyJF3IDqe8yPnKbIxAo
         W/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052458; x=1786657258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DBP0D1Kh/01rtZWlznil3VMqkDCrOu4cEL69wfep54g=;
        b=LGd4/pQiZcqXQEzglD7iOWd9U24hky4XIDF1YsBhfqoVEfeE0XTQQ2KlIvUCNXtYbj
         xkpZiUIecBJAjR0UU4kgPy8d683fcNZloxvdbk9B7yyx62fb0hRcFqYVsNkm9yuQMlat
         UJ8s/Yn0nK0xUYgFcvaQcns6Y+WpjrcmfCaciUuyHKUqiri5w6b+tKHybmLAIGBl+ae8
         2wngmHNumevowPzlpftLSedRIiJBVHXohnG6HkulC1CR3t9oa0QsuTBrD1h7WcmvFzCE
         jynxt5ufpkMjvsfkPZ5A3v9GxdbugnW0ZvDWPg+3Kd0JLaWtUUFhMVFFfr3tgKrwJ4dc
         NgLA==
X-Gm-Message-State: AOJu0YwrOcLcu00LLz6y0/HGHVyLuIOEg488gGKanQd89WsARzhlaPon
	dLW2jCfx09YB5Bqc65MAG0uD7fJLDMQZtqPOwTNYum60Avn4QnmcCe+bP26GhERwwhz85j8DXHw
	mYAJUPw==
X-Received: from pfbde1.prod.google.com ([2002:a05:6a00:4681:b0:84a:3b69:a287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d1:b0:845:ba94:a56
 with SMTP id d2e1a72fcca58-84f4fd9f82amr4931166b3a.5.1786052457310; Thu, 06
 Aug 2026 14:40:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 14:40:49 -0700
In-Reply-To: <20260806214050.78058-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806214050.78058-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When mapping a private PFN in TDX's post-populate callback, top-up the
memory caches on every attempt to map the PFN to harden against bugs in the
map flow that could consume cache entries even if mapping ultimately fails.
E.g. as pointed out by Sashiko, the in-progress Dynamic PAMT support could
consume PAMT cache entries on TDX-Module lock contention.

Harden KVM even though consuming an entry on failure is considered a KVM
bug, as retry is uncommon, top-up is "free" if there's no work to be done,
and populating a TDX guest's memory is a slow path, i.e. there's no
meaningful downside to the hardening.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260718061050.E17B01F000E9@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c6cac893cbad..379f570ef04f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
 		return -EPERM;
 
-	r = mmu_topup_memory_caches(vcpu, false);
-	if (r)
-		return r;
-
 	do {
 		if (signal_pending(current))
 			return -EINTR;
@@ -5199,6 +5195,10 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		if (r)
 			return r;
 
+		r = mmu_topup_memory_caches(vcpu, false);
+		if (r)
+			return r;
+
 		cond_resched();
 
 		guard(read_lock)(&kvm->mmu_lock);
-- 
2.55.0.679.g6767b8d81c-goog

