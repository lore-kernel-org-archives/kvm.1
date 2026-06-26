Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABF38E8BB
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515673; cv=none; b=E2P6vZrWPz6Wm84evzWWPAXXPDDmna+d4zMRr4q3WMklsiChAFnrt+ecClSxrBxNkUrFsmrFi8pknjRDQ5/pNSesfAlolR3JCrduPymp3R5fgOUoOLsfqEjULvZy9dC0AdXn0YTP3pipOOIJ6JwUOC8QaBklsnqWTDtn9z3K+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515673; c=relaxed/simple;
	bh=DBIf3+VFDZYptvruqD6ltoPaucEpf3ClGhtQ8Sb8YIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5ZMqM92gW9I9mDIx3TaVSxUImTMH5vwNCFegHh7j9T6r8dpFmLtNnXeGpyktWtWEa24jxAmfZRYR6/lyWjKMJe/FhFvr1RX4pg1enMJuLMonNo/l2s86OKxWbITEyGek2V19ypXj1ngIjTHM16vFN5VRMYgouNTmAvWwX24e6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcRYWEZ1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcRYWEZ1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7fae22808so20633005ad.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515670; x=1783120470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=23IT/I8BFI3FVtFLLsXh6XFyUDIWbMpHRUduaQab4Hg=;
        b=XcRYWEZ1BnjfcqXl2GPzpOZTDxb+pE/JFMJJozO9kPzdjMekNT4aqjIpUE2862r2mJ
         7YXZP+yKFMAbd1ypuZEyedvgLC1Qs+yPiESxq/+l+ndxTwDEZxqpVPTupcY0KppOmATL
         ooXr7LLJEUR576SWjRfLv8lZKKOAA0aEc7lpfII7YvW2kK87pKcdSTK5tuejJrHc5/Bw
         JpALUpkUZQGsiAUhBQmIdNBzSr/N3qL60XMXEF8xX50sVP9HTEKV23cqz3M7yB8uSNH5
         Lm8PfkAWRXKIIf8m964M4ufRpryJPAc0ZWIVm4gzrJWjlGcuixaBCrNo8k7n84S8DaAz
         gfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515670; x=1783120470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23IT/I8BFI3FVtFLLsXh6XFyUDIWbMpHRUduaQab4Hg=;
        b=WTBzMA54x4JD52M5/BTdW7/1my/ziX8OH0OI2HNRJsAXw0wANSoJyCCPxx0Dljg7Hi
         3js94tMrkoMkCYeVMTnPOWuQAl0u1BvtE0gGJAdqeN8PZdXTiQOkGyakjOc54V5vNwA3
         gowaej/17d7lPnOeBHYxxXxskvrJrLyEOk9ZEOBisDhRYS+LzPbebC+7ppbvKwTkUCVp
         y0BMNf3ZuUU5b8uijpnEN30XFKUOpB9XrSysZ62kZcMp1wf6dXFZkO52djqA4iV4NWQ+
         0qP4Qa/ECfy4wMPs5ajlvqvNzgCxSfsX4V1j16wsKPeLAM/Rg8CP0ljfT8ZlhTwgUC+9
         E70Q==
X-Gm-Message-State: AOJu0YwRuxQfQr7jWRmgLG8a3wg1iMUaPTucb0K8thpmA3bYbRulQy4a
	CYXQLfrJjfpqf88AnbEerqXPPCfrXASsvYTwpVPyMlgOovj/UVNSOYU6KCEX7625Iof+lbpLaRP
	7srUd/g==
X-Received: from pgbo37.prod.google.com ([2002:a63:5a25:0:b0:c93:e04b:d9ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d045:b0:3a2:d838:bfdb
 with SMTP id adf61e73a8af0-3bd4ae979ccmr9780194637.29.1782515669661; Fri, 26
 Jun 2026 16:14:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:16 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-10-seanjc@google.com>
Subject: [PATCH v2 9/9] KVM: SEV: Mark vCPU has having guest-provided VMSA
 even if its invalid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the guest as having a guest-provided VMSA as soon as control.vmsa_pa
is invalidated, instead of waiting to see if the guest-provided VMSA is
usable, so that KVM doesn't switch back to the original VMSA instead of
exiting to userspace (due to an invalid VMSA).  By the time a vCPU tries
to load a guest-provided VMSA, KVM has already communicated "success" for
AP creation, i.e. KVM has committed to using the guest-provided VMSA.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 04be49b1af57..7e06ed16f474 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4001,23 +4001,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(gpa))
-		return;
-
-	slot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!slot)
-		return;
-
-	mmu_seq = kvm->mmu_invalidate_seq;
-	smp_rmb();
-
-	/*
-	 * The new VMSA will be private memory guest memory, so retrieve the
-	 * PFN from the gmem backend.
-	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
-		return;
-
 	/*
 	 * From this point forward, the VMSA will always be a guest-mapped page
 	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
@@ -4029,6 +4012,23 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	svm->sev_es.snp_has_guest_vmsa = true;
 
+	if (!VALID_PAGE(gpa))
+		return;
+
+	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!slot)
+		return;
+
+	mmu_seq = kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	/*
+	 * The new VMSA will be private memory guest memory, so retrieve the
+	 * PFN from the gmem backend.
+	 */
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+		return;
+
 	read_lock(&kvm->mmu_lock);
 	/*
 	 * Save the guest-provided GPA.  If retry is needed, then KVM will try
-- 
2.55.0.rc0.799.gd6f94ed593-goog

