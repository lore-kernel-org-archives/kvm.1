Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7D37C93C
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334025; cv=none; b=igybLVGHIerA1P2tPZ3SA7jRn0W6WmaXZHmdaeiZWZqPqrfi8SkizyHAjBbWvIlkSg+z4hRaCKs6s2728ND5KVynqVUAYvZ+cWyHnH9RsrMCXN6wE8lfLlgQVuzU62sRITmVHuGlefZ8/Hb+P5CVbLibszCteyr6vSPfPx+2LRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334025; c=relaxed/simple;
	bh=n1PA9owpTZ7Jqfq2D7QLlqtwe0aB1WsJIMLujXEedfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=au7hi5Bv5jS1yN8DeIdLrCo6ryff5fystN8MfkIt3UrS3tjSGl11Y9jteXVHYKi3fOBx5vmMdwr9uuEVRDtKm5oysfJKSkeLKqdqNEZ/FZYPUF2E+ehyyX2nPJ0QlPDEEQpMMar/4h8YM/NwB3cXYXBW+ao0NnoMD8kES3QhNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYUzkYse; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYUzkYse"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso12939367a91.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777334023; x=1777938823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FmleA5+XDSAAmLpeNkNTx8pH2EmdrwU4HLNNd1Nj5U0=;
        b=PYUzkYseHLG2ShnmO/2wpIcfJDIRa4FT4wBOVNsORG/xcf8yyjVD2Nm5AV3XSUCO1X
         8eQNSORpYe0tsYjfgdISDvMgK+JGrhCGiCb3Kyl6zrISOanWlk/nPOJRV6mZeaMyonuA
         VrR/hhTHoiJjW+B/dtOkzfArQo9WPu+tLs/VkTEVA1FBFcfm1UQhBaNJnvuzQdpnRF2M
         MARDa7iTYjDzvG9d+5xbXbxCYk08toKeEgSZvSym26T+dNLWvGkw8youtPkHEf9i+5vn
         vRR1SCs0hWPy3ZAW5+K6cFSwIyPayrcXapamLDOHLQr3Y2lLXd+bPffzhMd9+GdtOgV9
         Ku4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777334023; x=1777938823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmleA5+XDSAAmLpeNkNTx8pH2EmdrwU4HLNNd1Nj5U0=;
        b=sDQKGNSXwsRPcY6EmlThPN5pvJYXF0WASS23lcQaCTqA+G7ZUvK7rORq52ZlPiZ5wr
         aOTL8+iXvJ8EED0oRKN7wF4GREVGTCzmgLFA/6Y9Kq1LvIs65rAzICEcpK/Uwkray6hs
         sB/963DqIdQNSiuDF1F9OlmxnOxPWTvFigUznQFLcMiU4jNST7CdLWMcWnOKkS9+bDRG
         9qXUk4iGNMG1jIvcKFC/vX1/O8qfIpTzeJJoN/EQ6SzlsDQ0nlWTQI6Uq5jlR4t7ZeR4
         nW6v5kUz5XS/Og/7NZLSHczBgihfkKPUmGy6FVJw5vD1UJhcyjauoxIjr95jGFJ7Oslx
         a7Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+ml7gIft8cFVsyyyJKKKnCUCQX4dn2pIAI8gAHaLV7L7VldkAj9p4deEOI0kfRufk9u6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hC2Na6r+z7A3axsIQJppze7EIvNQe479F6PuV0F25Maqu/BZ
	BXXDr/AH0drBWazcqpRnq1TVz/4GYYrOcS2hlBmXQ0T6Q1fGrYXbHCP5gAb5hySToYXb6FFKR/p
	wJVP0zQ==
X-Received: from pjtf15.prod.google.com ([2002:a17:90a:c28f:b0:362:bb4e:9fbe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590f:b0:35f:c1cc:fee0
 with SMTP id 98e67ed59e1d1-36491f00173mr571351a91.8.1777334023132; Mon, 27
 Apr 2026 16:53:43 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:53:41 -0700
In-Reply-To: <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
Message-ID: <ae_3BWwjHiYC3hzm@google.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > We can have our cake and eat it too.  Add svm_pmu_handle_nested_transition(),
> > but then also rename and rework reprogram_counters() to support both deferred and
> > synchronous operation, e.g. something like so:
> >
> > ---
> > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff,
> 
> I don't like 'diff', I think just 'unsigned long *bitmap' and pass a

Hard no.  I agree @diff is a weird name (I was literally just copy+pasting the
existing code), but I _really_ don't like passing a pointer, especially not to
an unsigned long.  The bitmap usage throughout the PMU code is mostly internal
implementation details.  But for what is reprogram_counters(), and what will be
__kvm_pmu_reprogram_counters(), the "counters to reprogram" is very tightly
coupled to the architectural layout of PERF_GLOBAL_CTRL and PEBS_ENABLED.  And
more broadly in the PMU, for the layout of GLOBAL_STATUS_BUFFER_OVF_BIT,
MSR_CORE_PERF_GLOBAL_STATUS, and probably at least one other MSRs.  That all
should be captured in the APIs.

The other reason I don't want to pass a pointer is so that even when the source
_is_ a PMU-internal bitmap, it's super duper obvious that the source bitmap isn't
modified, and that it's operating on a snapshot in time.

> bitmap in here like most PMU code?

FWIW, AFAICT, passing a bitmap as a function argument isn't common at all.  I
only see kvm_for_each_pmc() and kvm_pmu_trigger_event() taking a bitmap.  There
is a lot of bitmap _usage_, but rarely does KVM pass around a bitmap as a function
argument.

> >                                                 bool defer)
> > {
> >         struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
> >
> >         lockdep_assert_once(defer || kvm_get_running_vcpu() == vcpu);
> 
> Hmm why do we need this? Why not just pass in a vcpu? All callers have
> the vcpu and it should always be the running vcpu whether we are
> deferring or not.

No preference on my end (I was again largely just copy+pasting).

> >
> >         if (!diff)
> 
> Then this becomes bitmap_empty(bitmap)
> 
> >                 return;
> >
> >         atomic64_or(diff, &pmu->__reprogram_pmi);
> 
> and this unfortunately becomes aatomic64_or(*(s64 *)bitmap,
> &pmu->__reprogram_pmi);
> 
> >
> >         if (defer)
> >                 kvm_make_request(KVM_REQ_PMU, vcpu);
> >         else
> >                 kvm_pmu_handle_event(pmu_to_vcpu(pmu));
> > }
> >
> > static inline void kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff)
> > {
> >         __kvm_pmu_reprogram_counters(pmu, diff, true);
> > }
> > ---
> >
> > and then have SVM code pass in the reprogram_on_nested_transition or whatever.
