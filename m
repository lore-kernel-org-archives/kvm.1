Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706144;
	b=5JixIi+0PSRonXsx9WrHEV1uYltK1OJZhPI8t4A9vfVO3CgibR5a28wXUmVKQZKKXF94
	 TNrtE8rxTPyuvdzyrsX4A6Gs5zzdsf/O3LLxyuHPJQmTELJ18axnaH8KhETrq2NjpGCaS
	 fjVAzkuoyqTdGB7RYuKlM9nhCEjufCIsRGvwAjhixiO1OuYabEnGRZ+yyLKzO4Ml7Dwi2
	 bjQEndFK8JEkPkXt2URUyYMSn1bNKNtz+b/6CBcRgNbaB2qLkR59aWhESEDZIkvgyJFtl
	 CVphwoR0uopg+a15jEdfqyoCedlL3a1a2UloN/CMmHdcQij0L8Va64dYW7HzzzEmkdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=d2GP3/xMpsIH5cpcG4RPrAfL3ezbI3nXC8h1MMuuxmQ=;
	b=ZxaQb1j7oYOFf//1dBrPmkcuToYUr4ZevUjkr97N6F13pt/4k84Ao7gFBzdMAiAV6XnD
	 OLRkETPPRZTQdX0Akb/UruNJOeba+p4vp7/HZCkuqTSA3BKVYDtHSSAPOdm1+dfRJ1IWu
	 X5K822f55CA742sw1/ARQuHlu7zo10wDi6AthH3nzpT3Q6zhQPUEvxVxfB9LXEBvEq1Xj
	 Ga/U6qYkbIGnTzdF5VKBFZ69euwQ94kCMmmKl6T/sJ9TzpBrI36MdAWwXUuEWCk45HnU1
	 LJyNuBLKoiyoWM2q2BGv2m9cDzrjxcZwkBIZlimEiXJ4QY6HdIUsEKJxCJ9oRasBKWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PfmhL7my;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71540606A32A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71540606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PfmhL7my
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e942b1cc86so1995815ad.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792706144; x=1793310944; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d2GP3/xMpsIH5cpcG4RPrAfL3ezbI3nXC8h1MMuuxmQ=;
        b=PfmhL7my2/tDj3qFFfdnQxBqCW8Fa+qNkCwDcxFtndharXdZcUtwwR1WNJdCNFn/XG
         fhhP4dtvarNcX+Q75XwT5SQZfgSeRbHayyis8gfU4KdLFvgAzI5034xE83DapJWB/KJH
         yTt+3pTiAp8/p+OlAVqONmeJAupORG46NGYD2oFxTuHDkkxwYhLHwMG7hPQ9LgirF6Ud
         1vrB9PxagWTaZlkVPERIgIMgw/4iHSZw2L4idi/EqUe/4x4Qp3FD4aBLTSjMolUsIRcc
         /UWKGSVZgchiWjC4jIrU+ZnTkKv7O/vt2i/rDSaST/CKMKWqgPb5vqnUTaFhJJd6ODKy
         QEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792706144; x=1793310944;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d2GP3/xMpsIH5cpcG4RPrAfL3ezbI3nXC8h1MMuuxmQ=;
        b=rG4XicoK/SQ4ZzzqmC1bjCb4vZTqAEL6RghR3qlcC14wHsdby4cRb3KtH/IdGOFGZm
         MY8tR6p1lsfSNZH8EY1qPfr1Nhl0kYlwgPof1uezqRhE9mk7zKZOu/d4IXH8sRZgx7oF
         XWE08i5K0m46hPnRPv/WSipiUs/OKi7WGlW/J60qYtXEC7U7CtHRUwAO8zXMUk5BrJq2
         HIBibdt/dfKZsn+XSXXWG3MGo2tIs8dKYrOBduYoYdHXNWXtp4AisajO8ZHIW0++mqYO
         85XGv7JQYe1gerDom+xwsH/KyymdAQaMr6WlCjEXDa0gNpwLw3H7ygbdmPgawGcT1IIT
         HyFA==
X-Gm-Message-State: AFq9FYInVitnc73erIEozn5ryGGrSV7snscZsSnlsMM2rJKexf1nzJM2
	nG29BVUQKw4yhidwpZKHXwQ+JwBm+Mh0eZqo9G2jKRfzjANawSm0RPKr3gn3btpKDW6P4Dgpu6q
	Dh+0hmA==
X-Received: from plxj18.prod.google.com ([2002:a17:902:da92:b0:2e8:43aa:1e5e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c5:b0:2e9:4e83:1979
 with SMTP id d9443c01a7336-2ea7cfffac2mr3985975ad.32.1792706143685; Thu, 22
 Oct 2026 14:55:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 14:55:40 -0700
In-Reply-To: <20261022215541.631694-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022215541.631694-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022215541.631694-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Convert WARN_ON(preemptible()) to lockdep assertion
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
2.56.0.257.gf7497c7d27-goog

