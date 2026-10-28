Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212899;
	b=ZJeZEBK/XxvvaxEVGqj6UM6sBazz8n1EoLiNjLE9jSN3086F+1kdbTZvJ2Qjq0NmCo8G
	 Vrnf9giMJCGP2dc5WatL5hcTPDGsea7d9ApQM6xffTO3rzPtIETKYR6EXgLKYxRWNerYm
	 175yGAs15QZosZBTTLDEtvlq38YmQ1WCbuzAtbTARXvEMN5Kcq6s/XaxTb2pXuaN60TPU
	 vQ70HtDUKG3mFySmYj1ekuJ4SR4e/5A04R0/bpj8+geFRwS1OD0uNJbWTVhHBHRADzTVh
	 vdwxB+fdrFw3aEWN9VxOCMYuriMQgU3i5ZJjjoWvCVYGvdzla8hZXiBGW1OcOt3lO+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ppoKODV1UhbNltjW3IQuhV5+KabDhhTDl+rZiEljMwo=;
	b=WLeKkArY2u3YUdcmpjWmZbTTa6V5/UCStgBpfH+g86M7ysjT0KrRieKt98xDOqL5e9W8
	 B41cwRCjseMqhRMf9bff/nezXx96fx3tmKcdpJ4AadtXxTPh+Ap3dCTsSnpLLsuuj54Fy
	 GuuD24aKOrbyeyUBubrYVHsc8F0TRJ15SJWDx8Nuww0Z6UKwgce5VuCjREycv3acMksK+
	 Gy8D/VWOsQxI21laLvBj80JAky7DNoOgN2//Eu9YbwxgzOEuRoelOKU1ZwmxBVxbafMwB
	 sDlYtu+QvOLzRtkT3pxNTRcnVyDA9z4F7AFRd8nqrlWtnjmGZgtQeWnUjrKhDai6LLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HMsak6XA;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B920606A32D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B920606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HMsak6XA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e60770381cso12908245ad.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793212899; x=1793817699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ppoKODV1UhbNltjW3IQuhV5+KabDhhTDl+rZiEljMwo=;
        b=HMsak6XAjahIQ+LEKCC+rZrmDK4B/+vpatSxwxO+JllAfvTsiTsopS7lvmiepxhVwf
         c05kenmvnbFxbr4RmVB1imcsLrMjno2LO5z1JWvrlnTY3XvaS5CsQvLk6DGlkhkTZk4O
         wUl4WL9NCf70L7Y29NsbK7lrY/iLtsXDq2mMwcL4BQV1M+IkQS6g0X1snjAok9LM8gk9
         GiDrWddyyg7N2SY0nrm2hKiCushd5iIiPU8jsXDQDtACRHOgah/55BNyPe667kg+O0R8
         0Z6zVzQIQUO2OBHYZUuqfvxzWHLg3fJnx0i5fTbqCfR5KU1eOF/CHRzgB6MgbjaOPnLv
         AX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212899; x=1793817699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ppoKODV1UhbNltjW3IQuhV5+KabDhhTDl+rZiEljMwo=;
        b=xUo6Jr6Ra8BzBHkGFC1Y+6ow71AAvPJG0Jw8a7Wu3O37MHLns2Qeww8Vpk/7LQRyCF
         JEthIbcfa3j9/EiJM6NdHWIq9PTKE9jahGvrt9apkYqC/wmGZvRVBHCexFJNJ0AtE4k9
         sJt1wE08MTg2aLECAWmzrszkPBmqpmaF/y2IvN33yvV/rU1tZR3WOHnz3KfUHcftSM4k
         5cwuQew7iYe1M6m0qe75lbMoHfTeYpwJ7D5zBET9QTxAhNe3oE/rYp8ZFjJ6lQy/aOUG
         lze5IOhyIeyqQnPwEt5F8fScQ4935A5pB6wpOC/JyCMBvUftonqH4HjpD43C1IJFZ/Qs
         thRA==
X-Gm-Message-State: AFq9FYJNNl8soFc1bMO2QyfOHuctOYk3nurQJZAKNjVVjiir4x14Naif
	x91tD92P2RmPuplCD8mTpvltqU/Ipp1oY94UUBRaFRb8vcN8W/H1JdI9HmzwxVoOtQJwF7RGaNy
	nT6Djpw==
X-Received: from plbmt12.prod.google.com ([2002:a17:903:b0c:b0:2e5:db9c:f03f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d504:b0:2e8:3d48:4d92
 with SMTP id d9443c01a7336-2eb003bf1dfmr27341215ad.33.1793212898727; Wed, 28
 Oct 2026 11:41:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 11:41:35 -0700
In-Reply-To: <20261028184136.1803336-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028184136.1803336-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028184136.1803336-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: x86: Convert WARN_ON(preemptible()) to lockdep assertion
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Use lockdep_assert_preemption_disabled() in the local APIC code instead of
open-coding a rough equivalent that would likely do more harm than good if
it were to ever fire (the non-ONCE WARN_ON() would likely spam the kernel
log and hang the host).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ecf611845fb1..61bf09badb5a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2270,7 +2270,8 @@ bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu)
 
 static void cancel_hv_timer(struct kvm_lapic *apic)
 {
-	WARN_ON(preemptible());
+	lockdep_assert_preemption_disabled();
+
 	WARN_ON(!apic->lapic_timer.hv_timer_in_use);
 	kvm_x86_call(cancel_hv_timer)(apic->vcpu);
 	apic->lapic_timer.hv_timer_in_use = false;
@@ -2282,7 +2283,8 @@ static bool start_hv_timer(struct kvm_lapic *apic)
 	struct kvm_vcpu *vcpu = apic->vcpu;
 	bool expired;
 
-	WARN_ON(preemptible());
+	lockdep_assert_preemption_disabled();
+
 	if (!kvm_can_use_hv_timer(vcpu))
 		return false;
 
@@ -2322,7 +2324,8 @@ static void start_sw_timer(struct kvm_lapic *apic)
 {
 	struct kvm_timer *ktimer = &apic->lapic_timer;
 
-	WARN_ON(preemptible());
+	lockdep_assert_preemption_disabled();
+
 	if (apic->lapic_timer.hv_timer_in_use)
 		cancel_hv_timer(apic);
 	if (!apic_lvtt_period(apic) && atomic_read(&ktimer->pending))
-- 
2.56.0.313.g2479322e68-goog

