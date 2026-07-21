Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45896374E6C
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652470; cv=none; b=h0+oQaIT8Vvhk/mn9IOs+bQM00XEuOI0tqY0KvcDXCpwtcSbRfMzG4KQgcYlOxHB5XkWqOLM/PGgIzuUt02oJY0pS5VK+xZOjHskXpNmKbRaD1V8iRPuLkKjY4YLdeh4Tu1fJKf97LEIWZcI4uDglK5vTWUKxAEQ2HODg/tMOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652470; c=relaxed/simple;
	bh=pYw4qJYEuIKXAeuRPdQmYxpzWhSWZPRkfjwhKHTgS20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XcaGnqst7lYbNe+Ib21vT5rXruXefBVo0xyt8LzXFVY1JrC8ufobAHhcGuT3BqjwVAbwBu6klzP1n5Tt10wXr1SdBKoiw6JfSNTFXnuu3U2sYpGiH5RYbarI3elQSRWzRz1a6pvkYOFOUdAq2ZJOHEddVvT9rq55fh/t6OESvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKfLAUmr; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKfLAUmr"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so2175931a12.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784652467; x=1785257267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=unwEFoUznbE0xbP8WwUDTc6RnsTSmOdGWxnp8ooVbH0=;
        b=rKfLAUmrpt3S1xlpCY086YrNJi3HkIFTu316nvuv8aoAoGzAu1VvUmInZgira7Epue
         BngnIazBsuS7Zn4o1iFY18OI0Abe/pPaLXaVaIi2iEA41L4LC0TsgUX8Mxli9599b/7W
         OU1K++OVapigTWloFTxFVevPhP9vzKc7JPlvd/Rof1f/p0gAEYoDvULFKIcUSmKW4LcK
         501VSEqttE+KziaJviqP15lGO2eIhpKdlsmn/m3jpSI3jILw2lpGoms/k3A9aXkSJCvo
         425SHs2+8QezINQHqWpbKl6DcAYkuxs0GgmO6wG/BFOPUdGMXJXbqfFUA2inhkieeG5v
         Xdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652467; x=1785257267;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unwEFoUznbE0xbP8WwUDTc6RnsTSmOdGWxnp8ooVbH0=;
        b=qu8nppuNbrdcZSHvqHx8/eUdN/73KaFIrKYA6AnvMZrS1873vyTw+ec9tFnneGaG3y
         +2UtpoUsNaB/YqCZawZK+jZUuP837qY3P0ZHPE2fTRywdrDR48sZuk26YWKIHLMZVpnr
         SsnSDzxpM+CAJlVxST5CcD+Plw3ldK2quyZuZkodxJ91Z/Nws0yHGtk4sOpKMEX/dyN0
         3rTapgUl7agaIiYTyvmRJdJNgudionHi136MQ5jz1UXVBG5abyTrpq8ButBAwAvt2MwT
         reEIR4d4A7tu4yxQdHcu4Le79YspbYiaUnzHtka7fU0/IKke2Woc1ZilwZP/FBVe1lFH
         QWfA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7e5zepabkn4BUrUFvEwDhpD93bsU6R845NDEcuiwcqZU9jimFidHlkT9bHjO0ERn7qLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1aXNLEt2grKNrB69zx/8vXI2TmIg3BQKOPw00XAxthsheIyf
	HhfVHYHhVIPqUGau4reuDSUgshUlcyIVr9GUirz63gD2hbVTHzMPeQsSyuTNlJI9xQ6KLv7yKLK
	77zkeig==
X-Received: from pfbgu27.prod.google.com ([2002:a05:6a00:4e5b:b0:84b:1607:a892])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12ce:b0:848:824d:aff4
 with SMTP id d2e1a72fcca58-84c2954bdafmr17836552b3a.56.1784652466889; Tue, 21
 Jul 2026 09:47:46 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:47:46 -0700
In-Reply-To: <f5552576fc749b4b453514f52921332cc104c6a6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720192221.72912-1-absandze@amazon.de> <f5552576fc749b4b453514f52921332cc104c6a6.camel@infradead.org>
Message-ID: <al-isty0nYjQEwqH@google.com>
Subject: Re: [RFC PATCH 0/2] KVM: x86/pmu: Let userspace disable SW accounting
 of emulated instructions
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Luka Absandze <absandze@amazon.de>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026, David Woodhouse wrote:
> On Mon, 2026-07-20 at 19:22 +0000, Luka Absandze wrote:
> > On hosts that run guests with an *emulated* vPMU -- guest PMU MSR
> > accesses trap into KVM and each guest counter is backed by a host
> > perf_event -- the per-emulated-instruction PMU accounting added by comm=
it
> > 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions") is
> > pathologically expensive.
>=20
> Given that the guest PMU MSR accesses are trapped... is there a reason
> we can't fold a *separate* count of emulated instructions into the
> value we return to the guest?
>=20
> I guess the overflow would come late... but isn't that tolerable?=20

Like ignoring emulated instructions entirely, it probably depends on the gu=
est.

> And we could probably impose a limit on how large the addend could be =E2=
=80=94 even
> if we only reprogram the PMU once every 100 times, that's still a win?

Hmm, yeah, that'd be better than ignoring emulated instruction entirely, an=
d
would give userspace far better control over how shoddy KVM's emulation is.=
  Off
the cuff, the change would be fairly trivial too?  E.g.

diff --git arch/x86/kvm/pmu.c arch/x86/kvm/pmu.c
index 7f777049d328..c5f436c6f83f 100644
--- arch/x86/kvm/pmu.c
+++ arch/x86/kvm/pmu.c
@@ -1084,7 +1084,8 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
         */
        if (!kvm_vcpu_has_mediated_pmu(vcpu)) {
                pmc->emulated_counter++;
-               kvm_pmu_request_counter_reprogram(pmc);
+               if (pmc->emulated_counter > pmu_something_something_toleran=
ce)
+                       kvm_pmu_request_counter_reprogram(pmc);
                return;
        }
=20

