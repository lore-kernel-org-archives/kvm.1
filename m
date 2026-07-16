Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DB3DA5A6
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244333; cv=none; b=YaNLJD8nppnlFbcg17EUfXvYeIxU2CoYrO5YZmyAU9KgWydxrf9AJVN1ZrepQSmakxOJeDur9HCXJ4HQjNol73+izv+PordZ8aaWEuf30We+akSXBPhGjD27v8ER2/JEp5yBKguLy9Nh9x8V0Bkfi/IxKZg5rY2DgV7e08IhaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244333; c=relaxed/simple;
	bh=N7k7nRZ7X+HEd00d66ArV9Fpc5fcbJ83wf1fPnVO2WE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l4kaz+tLYlR+maSDTeTP4wKBEcEOD4SYJYutTvmH2p2lALm62o0CMhIzEtaAhHTiWp559sNIPlkTAKyd14InYoLqEn++8wLAce6IAXgrvudF0+JSLpZ1IiUJgmwlNJdaWQgPCZnK9gWHQyBCWTvBgBK63dd98BwKJ6UlvD567Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHQP02V1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHQP02V1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84854c2f888so12884639b3a.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784244331; x=1784849131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2AV1TuatuiRxTJrVBjLhjQytptdMoHyejJoiV1JJ3U=;
        b=gHQP02V1BEA/7aM//izczPw0vi5qQc1CvFKnuWJ9M8ZiEzwExK9++H8wF7p5hLGsgs
         F0L4OiHse10ReOoEZ/AqQg/iVc0rWxW6IOrMRwVPM0UsU/oje4Vss0iQZ4an7uWvVE1+
         MBRRFitI8y5gqVd7ns/1AdJwp9zllhyP7yR92gTfl/pKC6KlujrBs5iAUPdXdt0hb0Qx
         h37wNei87q25hW8dFfNQDCNNMYKQzc8Gus9pOMpjs0asfSc/dobxgdf406ioxjrowF7P
         3Nn+u2upXcPrpeH9EOYsy3Ovla7P5Ys/O9uTkh75y+SNSe0E/uECiYZdS7Ncn4wjye7N
         vHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244331; x=1784849131;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2AV1TuatuiRxTJrVBjLhjQytptdMoHyejJoiV1JJ3U=;
        b=af811eMGB+SAS3jXjmbDc2y+yaNTvs5AlhxhR4K99QNLlV+rtOD1wJOFLMXKXhJAzL
         oARTyNUCRG5B/A8dE25mcjvSj6FYTHzJRkYuJKDRQEo67WD/sdkTJCiapIM/2Wb/XfmO
         NUdGjKlerhPhM/hVD+JA8JYs2L1P7qvXwXzhnRYcK9sQQ0be/Lrkxoge455r8Q66VJRX
         SO8uKvtrQvITtExofDT8HYXC0wFFMqC+4xOVRD9Lvx8+rHKnTlNDtwsEmgan7HAFEkgi
         Nhex2duViqoN/LXku+VAjXEPGoUIjta7NmSPNaJYjvxRlkq/wLb9+yEmc5L0rqV2R9s4
         vFIA==
X-Forwarded-Encrypted: i=1; AHgh+RoGC6Ri5TiS+Qo9ta7+PdYbrumGuHj4kZp2x0CQGCVUPEb779kDeqV0OWmHvdKe8vgdL6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn92pylTS0vcDxxVSPYIM6NvSsl7MlmNc4bQN1HEwFaLUxZ3Ll
	o9wAMOoYrXbMVUDNa8ro7MI9KfjevfVk/M+AZX+RKvAs6nAW34pXvrQmXtg3itxnkzFV14bSvZT
	FT2Koc6KVQqxb+Q==
X-Received: from pfbgx10.prod.google.com ([2002:a05:6a00:1e0a:b0:848:46e6:1aac])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c1:b0:848:2f7a:2e5b with SMTP id d2e1a72fcca58-84c294fb6demr20129b3a.74.1784244330805;
 Thu, 16 Jul 2026 16:25:30 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:25:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716232524.2092085-1-jmattson@google.com>
Subject: [PATCH 0/3] KVM: x86/SVM: Fixes for AMD ERAPS virtualization
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@amd.com>, venkateshs@google.com, yosry@kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes three issues in KVM's virtualization of Enhanced Return
Address Predictor Security (ERAPS):

Patch 1 moves ALLOW_LARGER_RAP configuration from init_vmcb() to
svm_vcpu_after_set_cpuid(). On initial vCPU creation, init_vmcb() runs
before guest CPUID is configured via KVM_SET_CPUID2, leaving the BSP
without ALLOW_LARGER_RAP. Configuring ALLOW_LARGER_RAP in
svm_vcpu_after_set_cpuid() handles all vCPUs in one place.

Patch 2 moves ERAPS dirty tracking into svm_flush_tlb_asid(). AMD ERAPS
architecturally requires clearing the Return Address Predictor (RAP/RSB) on
all implicit TLB invalidations. Centralizing dirty tracking in
svm_flush_tlb_asid() ensures that local/current ASID flushes
(e.g. same-value CR3 reloads under shadow paging, CR4.PAE/SMEP toggles,
single-context INVPCID) correctly mark ERAPS dirty and clear the RAP on the
next VMRUN.

Patch 3 adds a KVM_REQ_TLB_FLUSH_GUEST request to kvm_mtrr_set_msr() when
MTRR MSRs are written via WRMSR. Per AMD APM and Intel SDM, MTRR writes are
implicit TLB invalidations. Requesting a guest TLB flush restores x86
architectural compliance and ensures ERAPS RAP clearing on MTRR writes.

Jim Mattson (3):
  KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()
  KVM: SVM: Dirty ERAPS register on all ASID TLB flushes
  KVM: x86: Flush guest TLB on MTRR MSR writes

 arch/x86/kvm/mtrr.c    |  1 +
 arch/x86/kvm/svm/svm.c | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

