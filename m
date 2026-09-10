Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDF49BD6B
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068026; cv=pass; b=nfKer7EDRtlEJeuTopCqMg2JrRoxUkXZXy+0QqNzO3Q+Pap4edvnAYbgthPpJdaK9NeZ0RdyYltrylnSsqcPN3oxLJGxQ2mWSr5ZnFcKV+kkDNtRDZCj/kQVFO9D7SQhtZ4wbrH9xXi6Dod1VXeU3RbT9HT3KwYzdkq1S/S3i0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068026; c=relaxed/simple;
	bh=fiGuXF8pnYZgt9VLhaHvZD8ERe5p+iX/cvkRE6nZgx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtZ12fWQCNiaRUCKwfkMdFmOG3cEANrqVTbRC4GayMFr9wzXNH4UrIPlbeOqKEGK1xuaarSsABmq5QhZJWaDaUjmzVECP8ub+UFdyf0oGtdDbVySfLhVSExZAahBqaiLrDbEwW3PjwZMBRIJw7T4STpJ+0RRoTn2OsFmXYyqtF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2cliDoy; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2cliDoy"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-671061b015eso64279d50.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 12:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789068024; cv=none;
        d=google.com; s=arc-20260327;
        b=enylHl5Jf7zjnpY6Zu38Z0S832JHJs3vAIeFlIaweWatEHPNylMG0yekuDVdeLxNcm
         MQaUnja/0kVfZ2HjZvPuPucyGIkdncWjuDs/6PZ1c4eHpm9at2I3FsxE2MaBG4IzwJIk
         wiOBLLJWGcxoQnAydlHfIL4Nc4+bt0z+CaemLaCPNVju1/9V6qDZmk46k6wjnwPNOkRd
         hUsi5C2uK3EGE+NfJPod67SdHkwP1tZGNY+td1cPCDj1iKoEijWeIihCjVRA789BfymI
         kga+1U8KJyhdaZtU/HiJAcBw5HBKEDzhIDpTLWoxbq4Uz/5h7S54PYatf5hUuUDau0AG
         RyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b6AZ6dwl+nPhR9lRn8ryaNJ3HAjOQF7wNnV4eGAN9b4=;
        fh=S7g22fLGgVjpJGMfFUJUZRgA2/FFfTs/7rH+2iwkokc=;
        b=LMkCEVJgL2Tq5xRjMmH6wbdHp2RT6aWbrXeoJnOADTGu7ahKwLV702dnSP7dpJXfr3
         qb3WW8sMyBwPxwA7zAkwr004WyysXLMR2kQn5V6iERdvk3+M/9dQ7rPsUCxboR58f4Sf
         v7xeHLTGJ7OlWqtSXZ3SV4GAz0xk6Lc/qkKgfc+MqRgXJF7k7ZW87PYP00vYStVGoAw0
         +zFok+FEJmbIC4y7oun/YinwaptQ+bKJ61k0IshsZFeExtyjKuIbTrYZHtr8K0Nl1WZx
         WATKlOl3VC9R/eZbxqWWhVPcUsnZTruiLy3FxgJyRQpDyYtrM9nPH7pgxZBo3HtLrfMS
         dx2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789068024; x=1789672824; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6AZ6dwl+nPhR9lRn8ryaNJ3HAjOQF7wNnV4eGAN9b4=;
        b=J2cliDoyTkgg80jsWjGdwBZTk4xzKHYzUEYJLMIlEYq+eRQIxv1EcfV0W5LrGb0G8L
         daKbDeKtNSZl8Blo5/yHpNVU2PBal3O75AYKJXJ6yZ5eZOX3fRA49IEs3JiJinAMT9Fo
         IV6tZG9kFA1vmGu7lEUAtT0da/ScwQTAO2+Gq9tgBY7gVZ18DaGhPZ3CGRCqiiTLqM1l
         Tkbhw7IgRd6Hw4l153FTB9cYnxRMZlmU4egZW3Sjj0d3UiTfsg0quCBBys7OiFis6M3M
         PB0tmJR1luJyn2GsilfVLpYbuGgWsFwvuEqIHIjfQobC125FqW+hPl3inxfIsx+kC9td
         5EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068024; x=1789672824;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b6AZ6dwl+nPhR9lRn8ryaNJ3HAjOQF7wNnV4eGAN9b4=;
        b=CoZ0JVQYJhhPpHmqA10a1p39cr9aEa6nBNsFF5duYgAROOOtf00t+aWTK2J3LriMyI
         QAl70sHptJd3Dx5u6rPdxhyBDjXM5KhGnYHm62ejPVdSfOkHSkPNIMstjXRYHKiy2AQK
         cvRUMQS8YmyaxMTppk26ZQ3ECxGRsxGRpqWknkDPDrvXN85yXm/wSeV2R/fajykKnxwg
         CanZhzOLpR2TnLtrRDhIPWTCXBTxpIW6DPGDkI+aFj69La7mqYuqHEEMauogY8A8SzSH
         cpyG0haPzE5IQmDvgXSYFDQDnV40xqdaHRo2QwQsXjUx6szZnWgOhVpk/UT12JBD6atr
         fSNw==
X-Forwarded-Encrypted: i=1; AKwUvBxHkynPIb3BqVbjIP1sZnd02uYluWcKx9DeLh3VEDPfVFXuApSrDGy6rxBXSf32yDZtXME=@vger.kernel.org
X-Gm-Message-State: AFuF++kRQSsEW8RvTidNJud3BPiM6E66EVBRG8Lv6znHQD95vmipWTcB
	XKNRq/c/irpYXDL+1J8KD+kVnc4m436wsUI3d9gSkSTjMy39OCYFKkoOMm7v3raXQ24D/3bv1C+
	A8TcUrJnVWJC8ru9hIj9W+9wL1/vKn18SNc5wKS22
X-Gm-Gg: AYBFou18tPsilPW3efuEQldO6f9NVxbiqbNhB2txPYSLDqenKmQ+KYnVEY3ccnSZ1wC
	1wwPKEqBbv9CEcYQmYJju3wzdRHE9pn3pje4DtkFBBDtGr/amo9Xfy04tiRvL6hqT1HfbZ6C3Tj
	C/1/yOyCFHyZE+nHZl3mhBMZKSugfQRikSXngLl9vBcJBo9sdXnor6GQWsJl3h0UDBfAHsrUAxU
	Yxvnyi6t2pCUUlWsSeKOqu6vLfoPCbKm+Vtsiv84b2zEr4suFT7HA30th9jflIskOI/sPadL5DK
	2F5FErAV/NGJpvk6yqEkHB9rPKFWsiLXXWaeFs+X772pLEXY7guI8eYJO8/n2+G+AtCAvekjOFF
	bqKmc/b1PKak=
X-Received: by 2002:a05:690e:80b:10b0:66f:c1bc:c097 with SMTP id
 956f58d0204a3-6712476c288mr382065d50.95.1789068023584; Thu, 10 Sep 2026
 12:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com> <aqLhHOrXsa30PBVU@google.com>
In-Reply-To: <aqLhHOrXsa30PBVU@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 10 Sep 2026 21:19:46 +0200
X-Gm-Features: AcwNN1XEJG4HFWxM40HlnJmqF0_xrl9dxVW2S0hyaOIau8OztfJYTNDdG5jUhc0
Message-ID: <CANpmjNNF44Y_k-Jbx6TikXgTnhE3G_aRDFXAABosZexOkn0jeg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] KVM: Enable Clang Context Analysis
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sept 2026 at 18:55, Sean Christopherson <seanjc@google.com> wrote:
> On Thu, Sep 10, 2026, Marco Elver wrote:
> > Enable compiler-based static context analysis [1] for x86 KVM, along with
> > prerequisite lock annotations in virt/kvm.
> >
> > During the initial annotation pass, context analysis uncovered a missing
> > SRCU read-side critical section in x86 PMU filter lookups; patch 1 fixes
> > this bug.
> >
> > The remainder of the series is strictly non-functional: it establishes
> > basic function annotations, guarded_by annotations on core structs, and
> > straightforward refactorings in hva/gfn range walks and guest_memfd to
> > eliminate conditional locking patterns that cannot be tracked statically.
> >
> > Annotating the MMU (mmu/mmu.c, mmu/tdp_mmu.c), i8259, and Xen requires
> > more invasive changes and is deferred to follow-ups.
> >
> > [1] https://docs.kernel.org/next/dev-tools/context-analysis.html
>
> ...
>
> >  43 files changed, 745 insertions(+), 236 deletions(-)
>
> For me, there needs to be a _lot_ more explanation of what this buys us to justify
> the extra annotations and ongoing maintenance burden.  And to a lesser extent, why
> we should rework code to play nice with context analysis

Patch 1 is an example of what this buys: static checking shifts left
and prevents bugs from actually being committed. Context analysis can
be seen as an extension of kernel C, improving its safety, and the
nice thing is it can be enabled incrementally (no rewrites in other
languages needed, though yielding modest safety gains at a fraction of
the cost). A side-effect is compiler-checked documentation
(annotations), which helps humans and robots reading & writing kernel
code.

The question is simple: is the cost of ongoing maintenance with
context analysis greater than the cost of the bugs it prevents?

> (I assume we can simply
> opt-out on a per-function basis if we don't want to play nice?).

Yes with __context_unsafe(/* explanation */) attribute, or
context_unsafe(...) expressions.

> I'd also like to see what the MMU changes look like before committing to supporting
> this.

If you're not entirely opposed, a v2 can include that.
