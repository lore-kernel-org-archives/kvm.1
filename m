Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0D3C1411
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182750; cv=none; b=BweXSPgOhX2wob+f8mlU6CEJsei5LyjkM+rHeKKLM/BF2QYMzlUKehwH7hUfGIRkmdzloSFUJdYGNOZyXChac5G/NYrXJ7Rq9mZn9lpCb7/bznnb5RmSnmvGo+9W1nkz9bz9a5d1DxrY1KIR2hNk5GhMYzw63oRIIaXjblPU7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182750; c=relaxed/simple;
	bh=UiDZyPILiokvJj7x6pDv27uZLG7WfkgrRuHt7hsg57Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hMdK21B+HS+AEu7oizlZVFrh/k4KwzomZdD68KNb5gSY+lLvY9q3nttpcowMocIhgMnmWTU0qGSGFeSrFYCCUOmognTeUknAr1+0qtGxoHH909kdG9nkd75pbwg+AyYbnxZxEy1AS3Tibm8kY0ZJMBHP34+wm+kZtyRNocqMDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbpg9tjv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbpg9tjv"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3595485abbbso12730769a91.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773182748; x=1773787548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8aHGomga6Ya0QcgOo8YBKT5lRlkBj7R2CU1fYSxPCI=;
        b=cbpg9tjvssTeoZmQWzGnbymTlJ343oJBnrNsymW2TfusHxI4tjIO1AbNwcYiJh6eAG
         gpr7L9gK6sxFuttMgtz+YM41SzasgbjoyCtPxgce032ZtlDLb7G69gqUl19K6Q4U6fXj
         WwAenyl+lIC1RicLrtKDSaEOEXt4cw8VuMPVVCaS15Ektd7MU6dkL1SpgwmiOBobz/Ek
         QZ/+ra+2prPtm18hqH8nDj0TulEMWsZ3d6Cbn5PYQm2CmmKIT5shyopaqjm+W9irZYCp
         9t0Rcl63MoN3PLpVmwMWBZy0aEpSOZoFT599Z+wnCkyFeGJdFIaN2H5xiy6mKE5jnfL0
         t8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182748; x=1773787548;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8aHGomga6Ya0QcgOo8YBKT5lRlkBj7R2CU1fYSxPCI=;
        b=Ntx06cO97hZE38Di7dlXh+lrlNKVGsoEYolBaa5jKXuBrdizfwYCBxP5Eu5K92NeZB
         FhpNYrGL05YjHhJDRpYT5pCIAztcNXTLsNPurH5EiOwTnIkEqCUaRImtjkXsv73NrRcm
         DERx5g4flSN4v7oX42PU2wplo2lY1TA2PZyNCMm1wi+CqqeRSiDfNvvUVs/hqfIdQL0T
         elq53CGn/02ex4pUJfTGo4a5lbs9E3swwVKc+BhmxFj4R77Ra04VrNvZTRX9HiOb/6dj
         Ir6SSB6KtcUW99U4UItvPEBMMuD9ZUixtjrFyLvK9d8AEP3QSCmMi4aiWT6HlLQ46k2C
         HLdA==
X-Gm-Message-State: AOJu0YxwxPQ9a9eruxJ50r6NL/rZsoie42u8DFgfMCgv2n3Ag9KNqT2r
	zgC9A3jos6/CHnYiaQ6v+Is5ZBgYVbvUtQrhi14wZ8G+4SkH85vYs8iZKbGDG0ciX7ghT8ddKoG
	bfyFJHQ==
X-Received: from pgla7.prod.google.com ([2002:a63:b47:0:b0:bac:6acd:818b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f45:b0:359:8d70:c4e6
 with SMTP id 98e67ed59e1d1-35a012866b4mr380516a91.1.1773182748130; Tue, 10
 Mar 2026 15:45:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 15:45:44 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310224546.2582118-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Syzkaller nested_run_pending defense
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Defeat syzkaller once and for all when it comes to nested_run_pending (yeah,
those words won't come back to haunt me), by treating nested_run_pending as
"untrusted" for the purposes of WARNs if userspace gains control of the vCPU.
I.e. don't WARN if userspace _may_ have stuffed vCPU state to force an
impossible VM-Exit.

We've reached the point where the signal:noise ratio for nested_run_pending
WARNs when syzkaller is fuzzing nVMX/nSVM is awful, and playing whack-a-mole
with syzkaller is doing more harm that good at this point.  While it's
possible syzkaller could find an actual KVM bug by stuffing vCPU state, if the
_only_ symptom is the nested_run_pending WARN, then in theory the bug should
also be hittable by stuffing L2 state prior to nested VM-Enter.

Sean Christopherson (1):
  KVM: x86: Suppress WARNs on nested_run_pending after userspace exit

Yosry Ahmed (1):
  KVM: x86: Move nested_run_pending to kvm_vcpu_arch

 arch/x86/include/asm/kvm_host.h | 15 ++++++++++
 arch/x86/kvm/svm/nested.c       | 23 ++++++++-------
 arch/x86/kvm/svm/svm.c          | 16 +++++------
 arch/x86/kvm/svm/svm.h          |  4 ---
 arch/x86/kvm/vmx/nested.c       | 50 +++++++++++++++++----------------
 arch/x86/kvm/vmx/vmx.c          | 16 +++++------
 arch/x86/kvm/vmx/vmx.h          |  3 --
 arch/x86/kvm/x86.c              |  7 +++++
 arch/x86/kvm/x86.h              | 10 +++++++
 9 files changed, 87 insertions(+), 57 deletions(-)


base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.53.0.473.g4a7958ca14-goog

