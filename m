Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B73B840F
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794280; cv=none; b=ZNLg3ElLTrH0Ldi/MDaV1qPG/IP+KW6MlvNLQc5soV0LbmLrV6hQcNKy40UM4gCCzQ2QA6zLzKIRuHvCsV8a7jF1BGMrKzOlBP+EDQbMv3tRYDzDZv9WpalPyEjT+Atfz5KFJE+wYotVGW3NfTLZxPrxfoSaTI/Qi3cn6/bh4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794280; c=relaxed/simple;
	bh=Z8JM+GpfUvrSxHsKlo3ZGg09soLQyAUqQKlIc9LRRnw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BF859i7Z6HxiGpSwRyy8UB/6E5rLWYNVL87GQhu900UL5Q/lcJVTe556ec4kptaJTfWGPXrryenz8m4FgPaUzYQQrl/JNgmbMT8YZRK2e3Pe2a7c14xsiYEtPefS+5QeP4/5fWiua1/fvzASBhkoIi88w+yUK/dsvMSetYYYShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REUpMcKy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REUpMcKy"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so6218552b3a.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778794277; x=1779399077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBDwFph1fgL8JJtMFcY4wwaK5i0fyVyxn04k9bC39nA=;
        b=REUpMcKykOf6jp90JmmNUFjk5xJUF4bO+ZKDF0KCEILLRSPkwaL9qcNNDqxebZgNaH
         ml4PGnbdyWjTytXTTiEOsdum2uQiTUR6rXj0Wg2mgkD6KTRBt4FSMkMnEvvlxvy3USPq
         8dlCxF31YLIby+rHGfnjCXZs9pwEXZnRn4ydt8XZIpm0YeGT1INWHl9yjGs8fJAyalTV
         T6Lb0NS9BbR0UmtkUla96cQC8Dvgm2LbICvKykZI80mQV6+rdq5QhGVCNk08Dyk5gzln
         8pQQuVYi4hNB1aQb6pcV5KZjwjA+gNToxV9Bu90o86Hufiv5Vej2wViLfv4rckxTDLNF
         5WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778794277; x=1779399077;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBDwFph1fgL8JJtMFcY4wwaK5i0fyVyxn04k9bC39nA=;
        b=pT8OEjRODQV7kBJniWwdbpFPsxnNvTqlirF/9tGYGidV318fHVPfJud6SdDHHtxHGW
         bpL/eReDIekueIgv23YCpuAKmVM/2ci2v74QwmPRomdtyvt2eLPbKfkCCPATCFDl9p5B
         lUqfMyHW9QZU/lMjzmP7msi02jz2Sv9b/bUJoxC7gq9SGKNrp9Nj2CEFiN9wIia7qGfl
         gRkYNNdbTNs9wqJUWw455ncowO6XE16wMbBVH30haSIBESoKi+AWmcY1zT6HrXaFO1TM
         PFO5Jcsfrm0MsuGVzNsd9OZyH4KtwfaMrbjndz1idi0OhVdDkDh+QPQuO6pI4AhNUa+k
         tz1A==
X-Gm-Message-State: AOJu0YwXUa3WM6ctUDHkt5CKt/BqTOQ203wBvBptRVkyV6tutyxW868P
	9qtEeG3Z4NyI9v6iS7cflrTbr468Oi/tsl6vUWamYYBJXfHuA2XjdTtqZAJOY5C0umG3mavHqh3
	qGGQIHg==
X-Received: from pfbgc1.prod.google.com ([2002:a05:6a00:62c1:b0:838:27b2:c77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:418f:b0:82f:5576:2853
 with SMTP id d2e1a72fcca58-83f33d3a93fmr1275064b3a.30.1778794277178; Thu, 14
 May 2026 14:31:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:31:12 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514213115.1637082-1-seanjc@google.com>
Subject: [PATCH v3 0/3] KVM: SVM: Fix x2AVIC MSR interception issues
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of bugs in SVM's handling of x2APIC MSR passthrough for x2AVIC,
where KVM disables interception for MSR accesses that aren't accelerated by
hardware (pointless and suboptimal), and also does NOT disable interception
for practically any of the "range of vectors" MSRs, i.e. IRR, ISR, and TMR.

Note, I tagged all of this for stable, but I could be convinced these fixes
shouldn't be sent to LTS trees, as there are no functional bugs being fixed.

v3:
 - Consolidate list generation for APICv and x2AVIC RDMSR passthrough (and
   avoid the wonky post-iteration fixup in the process). [Naveen]
 - Collect reviews. [Naveen]
 - Drop the hacky selftest (it's still available in v2).
 - Massage the changelog for patch 3 to call out that at least one section
   of the APM does document that #GP has priority over the AVIC checks.
   [Naveen]
 - Document the impact on TMCCT in patch 2. [Naveen]

v2:
 - https://lore.kernel.org/all/20260506184746.2719880-1-seanjc@google.com
 - Actually iterate over the mask of readable regs. [Naveen]
 - Rewrite the changelog for patch 3 to more accurately capture what happens,
   and to avoid conflating "unaccelerated" with "fault-like". [Naveen]
 - Massage the changlog for patch 1 to describe the observed behavior of
   DFR and ICR2.
 - Test the #VMEXIT (or not) behavior with hacks (patches 4 and 5).

v1: https://lore.kernel.org/all/20260409222449.2013847-1-seanjc@google.com

Sean Christopherson (3):
  KVM: x86: Add dedicated API for getting mask of accelerated x2APIC
    MSRs
  KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually
    supports
  KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are
    accelerated

 arch/x86/kvm/lapic.c    | 21 ++++++++++++++++--
 arch/x86/kvm/lapic.h    |  2 +-
 arch/x86/kvm/svm/avic.c | 47 +++++++++++------------------------------
 arch/x86/kvm/vmx/vmx.c  |  3 +--
 4 files changed, 33 insertions(+), 40 deletions(-)


base-commit: a9512a611bd030088f13477258d1f8103cceaa40
-- 
2.54.0.563.g4f69b47b94-goog

