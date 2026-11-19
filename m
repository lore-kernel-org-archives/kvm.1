Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132623;
	b=pTZKeIYnqLjdIwnojMQPkqeZ19N3WkyHVQ05pK3o6e2O85WoJOut1hugHEbo73nb2hbe
	 VtAfzlzMznqjJ1TdJppCm7FiQdYhDZzkSG3lS7lNWtJDy00TMBPrb332gBJcYe9Uggr8/
	 wq/nrZhNssK72CD0uZhqYNxkzO4u+3C3o03wah9Xe44s1W5ZCEX5mSF8ah+auDCUP/Rq8
	 fXc4RpZJ3t8XTwmRCDJonAx5ldkhJg4knSHnXLbZRaDYbBsWb0eRBQviOTs3eZOHiQ4x3
	 qbXNfl3/+Y0Bot5JjQX3wMFuu9cJRFo227Mu2G8j0hQOpt1wR9ff58obtKpMSbl3lbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=1UMF/d6dH5AR6IZAi49o7hGEKd8lEIEJySIIOWnfd0g=;
	b=O4zqjslYtIZnkIYMZV1y93LIDmWFL/1uWPSHGUWAdnHmV7I1s/mHLlgB9EmkPk7FKy1f
	 rAOci0Zzd4xf5kQywu2WZrcEtkyhCSRjTLfhJ6fH7jlN5CGUUyYXrIUTIXNb4OJJHzf90
	 Xd3JN3SZ/3jAxsez6OmgFOI97RJaPvyvbVYeSkcEc4vPNCbkeZatno4c7LKDIuRUu2CMx
	 6eg6HQ2SoHqZ6YM5twzVwC3QAQfJSAIFhtMm4E+DHabF1Z1GyhO6ZfyV9eyvTrIDPBw9P
	 lfWcjqg9gMwLr3JYutVuGhsqahvOgnvkKQRiJEJrIUpy51Rn4tzXUF2TnVxfse/uk7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZu+pzr0;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FA606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 807FA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZu+pzr0
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed00709df0so2362885ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795132622; x=1795737422; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1UMF/d6dH5AR6IZAi49o7hGEKd8lEIEJySIIOWnfd0g=;
        b=ZZu+pzr09ebaZms0nwX8vEbo2zxm7kqYm1FXDDUo8hFkRm+el2EwKmaD0KurLU9HQS
         nLHHcvxdGeZJzBWhEO3jOrUTiaGOW3lpZFFgV/0MCPv0BZLb1oHrv+5JXs0N+JLJXxja
         7QLbZgsluC824mGMxpFjR9HFpb9AbpRkHXw887ZupR3Vm2etuvcwO9gz8W7jOUZKTd61
         gx3OBHPvfgaDhz57IOQfj5QKydo6YohjQJhxEtJzud50hmm0FG4NmAfGUoBFQwPheJg2
         l+OQMlCckh1cRiqedlDIAQ5lvJO1dXI8YeUvyzXliASCbyv8+4M5js4Ud+MkHd1StyGf
         bXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132622; x=1795737422;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1UMF/d6dH5AR6IZAi49o7hGEKd8lEIEJySIIOWnfd0g=;
        b=1itsgpQJG2qoZCvNZZgmY2cVf7CXQzpFsUZnPr00A3tEWbRGczQNLuNIvidpGbVwEh
         WSl+sg/Ple7jkvPmHaRiu9yyeBnbOnvdYzicZuPwd0bTzY2WoIO8/W9DaKah3DQdqVyl
         d6LQXEX2rHg5NcsQeQ7mDRmWkUdL/dFyMt4pCsU5oQHXu8tUgq6DP5FOFi1NJFb7DvfJ
         GAYsYcmMSXPEbi4V1mzoo06pFm8Bu0QLpyDXSwxh0+wPmHiap9AWGPUsuTWs23qgB65+
         KKP4IWb2PzgCZna6sNEPoQ0FMFPeZ1Ibt8zNxQMqfkuP3Of1a8GcTvgIsOzLRkYPv5JQ
         /dTQ==
X-Forwarded-Encrypted: i=1; AL+hErFTtlbXZ3yyBOA0zUcCSqeKwy7PUeiBEeBpLsRqPXiBLvStdyLMAugMQ5r82lIG4uFadSk=@vger.kernel.org
X-Gm-Message-State: APuU4Z931LrfgMHGf7oWdrj6GXnSCpqW6mDNIjOhM6R0MJHOmCuL4yVG
	XzgoGZuRHj5M24c4na7om1JwHs4lpaSq9DxCOWIemeD+csM5L+FRCYwNAeCFz9UvpPflYOOwJmc
	hzBR2vw==
X-Received: from plbkd12.prod.google.com ([2002:a17:903:13cc:b0:2f0:43fa:d088])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:607:b0:2f0:2c63:69b2
 with SMTP id d9443c01a7336-2f03f17d1femr9933105ad.16.1795132621632; Thu, 19
 Nov 2026 15:57:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 19 Nov 2026 15:56:50 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119235656.70315-1-seanjc@google.com>
Subject: [PATCH v2 0/6] KVM: Send reschedule IPIs for non-waiting requests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

My apologies to the s390 folks for dragging you into KVM's mess.  Y'all are
Cc'd because I want to use smp_send_reschedule() to fix a KVM bug, and KVM
can be built as a module on s390.  I'm hoping to get an Ack on patch 1,
definitely feel free to ignore the rest.

For the KVM changes, fix two bugs with using the SMP function call framework,
by switching to smp_send_reschedule() for non-waiting requests:

 1. Making SMP function calls with IRQs disable can lead to deadlock.
 2. Batching IPIs for SMP function calls using the per-CPU cpumask can corrupt
    the mask if KVM kicks CPUs from hard IRQ context, as arm64 does when
    handling KVM_IRQFD signals.

Sean Christopherson (6):
  s390/smp: Export arch_smp_send_reschedule() for KVM
  KVM: Add struct and helpers to handle kicking multiple (v)CPUs
  KVM: Add dedicated flag to track if multi-vCPU request needs at least
    one kick
  KVM: Don't kick offline CPUs when making a multi-vCPU request
  KVM: Send reschedule IPIs instead of SMP function calls for
    non-waiting requests
  KVM: Extract and dedup the kick code to check if a CPU needs an IPI

 arch/s390/kernel/smp.c |   1 +
 virt/kvm/kvm_main.c    | 101 ++++++++++++++++++++++++-----------------
 2 files changed, 61 insertions(+), 41 deletions(-)


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.708.g77570a6a1d-goog

