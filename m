Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC947DD51
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576030; cv=pass; b=ocxpyGoOWme+yzxv5VbzQ/SgzeyT5zugZIlbqiBnsstldQDst/U24r9NZ4wMaJjUvbukfg0WdaIkMpMzCcCfAZSaCd9+a+1rO8l1u5/jhT1CHWlf5GDylC82n6pWjP5O6zeTCwvnbweeDVjsSA9H1GkkjKmWVzmw3MvxgE8eiNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576030; c=relaxed/simple;
	bh=lbKI88j24zL5a/G4P31XWejGAZvwD0yA7HjlaqItY/Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FooGQQAdR7/l3xAcmXPAlE8S7STib2DNRUB1xVnVRcv9WlgHDgq03G1aN+4p+0JvpzSuhGPmBv6iNsdY6JqxU3hxVgsiBr/bqKNOAI7rt7vWgwmWZ2aZ51L3s40xIXa2UOr3WHIIYNhzOxxJoDRHRFKCftnZgguBrBB8a4cdaqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1C6sevA; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1C6sevA"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-95ce0cf2d4bso126075241.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576027; cv=none;
        d=google.com; s=arc-20240605;
        b=BHBzR3X+r5mlQo/KzEEDr8e0W9p+nu6keJ0cJJsLqcYvnZAmRGstn6rps+veXNIsMk
         PRXZqviw4VaQQDQxRKPIkMGVTicmbc1he+QMiaVzXK1Pvq/zrGSqIg4VE6Bo+TnDpNwo
         Y1g1xV1DPTzerABMzcqb8byoxKTNlt7nWzy6OGgDiDas9V6mpNr3BaJH1XOJYp2/ZV9P
         CwkoAlK+4ueX1xOp70BFsYo7USqqnB5vN9tO2iXH49fZ+xYo9S1WfLATPcIJy5PP3RUl
         edT4hrR09vCumBP80PPtzZwxi1JL1GPXunqD+tTpxWshhnmin+zxrpZPTHaYU5JGtjjy
         ravQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wE/mzJ1slStIo/XImW9RMGfZLtcSrEsQfhXpy86FMIU=;
        fh=RTQHOBI0IZHFWszE9XoSMp76ltjOGhWND7ogHZParP8=;
        b=J72CfR9KBULYcSeMhTbmS1/t7d5taoblTpZjiv1+W62R8eTCVoh+68JgyXksEDtxmg
         +xcJK5Z7VIQswRUsHqddlFGGIXa9GP4iGUuq2w/IxR/F0tzwvQXbRaIBrdgyBJaRaMHi
         3PoL+2HPcPQSiQtPTCfguLdGnOqkJtASrBTvr5hAwKvIMPBqvTEdOYA6YBdAeqnHx0zz
         4jsA8jNUOmCCNrWS+6ah8JsTXJEtaHBRsx45XQ5z9HnzLrf/j9Xosw+wxB9sQ+1kn7WA
         OMk0A62h2LDYZg0vGvip7tSFtQom1qSTJqmb8Ze0Ounsry91tJrXKVfKxVG18vcm6GXX
         HVEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576027; x=1778180827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wE/mzJ1slStIo/XImW9RMGfZLtcSrEsQfhXpy86FMIU=;
        b=O1C6sevAiquG92RrO6aofEkcrn7yILoB9Ub41W9bosg4fXS1C5RVTxpppdxiVpYM8E
         a9hJVzKYjnnk1bCGKgjJY6XcvF7j4c37/o6uTB1AKfRFP+o/1MqFwOf3qf29Y4cgq7rC
         SsNJStZViI77pSq1ipM3HCUQXmXVhwo3djnKUJdgi/VZPSQeE8t3WUdc3tKp+vVIeWKx
         yP1m7q9pyxuzGJy8xoKvfH+6GhGedp2qNb+2qL3T8kg+KT8v+0MYSq2ai+CkyLNOfuSt
         ugDvjSzBbA22WocWSotFDfkDArDlrJ4HASh9zq/+dvQK8BSfiG5XNHTKP6yulSj8o9hQ
         /UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576027; x=1778180827;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wE/mzJ1slStIo/XImW9RMGfZLtcSrEsQfhXpy86FMIU=;
        b=m825lOjHMoq8sXmUSm3fpc9eN4HzzZSTNmhdTqeL1uLy/13G4xZ25maK+nvoE2qicR
         J/oPgeDptC3lntqUqNz9kecNOOd+L7kFMfFNVBDyxOz97i1XGmErPVJ4jWdH0RP7xZC+
         pdrQZH2KSASA5mX1QFKgEsNBAGHDXbhf/p9bfnJflonvsG8s0HK570OgGBCRhYJJGCR4
         slwLeMycvoIqA7/qPi9lVfYEpTWeZIj4fIGhzMEFvTABCVe0qiW1Tk46px+avYKbikpv
         JR5nLTxJ7rsu28mCYb7vpq7DsaKzWNUje9Bc2EoUtDnRnY3psftMWktEmdF/0ItiF7eF
         x0vg==
X-Forwarded-Encrypted: i=1; AFNElJ9P/a8M3a6XPA3p59lUck038uVgBnj1a4ZIdptSrue2XOMQ61f+861dkqo0qwAIMG81Brs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzbea+xlzltjQEOAdCO0YhC6KquUX6DBqx7NeB4hJHt5i05bZ0
	9w94yPYvFPJxmbyVJRwB8/2h0M1Qu8byNybXrLWgu4Fa3oQn4MA62Yw+A773AHrYu1jSaRcKuWT
	Pl3iXAYqJo92ZRFnKxn6xDzOiTig0JoaaLQtgMZCxnNNkJrovGs7KGnRy
X-Gm-Gg: AeBDieuYICncURGOH/KSZH12DyfOqYxbvncqG3MZMOJYMpySL4nhr4s85qFpGlEyp29
	Ebg1EY/X9zGRjeVumMgXrPdw4Ls9VWk7QTTYM8ESiW8Uzcq+QNXc/opRHSz8FlweZc7cD+MZuxu
	WX23nkjK57QkvI8eH+sogbcNox7OuplHay53QPl7RbIfWCip4QLVNYODJvQjEPAG6f3Bzgf47zN
	AS1IGrQyj5wSZ7v2CUtMGMfZs2WW56HFLP6gc5svPoB5p84s0wisIoy2NnAITsXqM8Vg/NsZWiZ
	JJ08RXhB5/bzu/+WZboDY3Tx9kaQcrJdnRV/4PpAtlmHexUcD2B7G52vcTj1r2xsaiIg6htaMXW
	a9G1xyXqPIB7XU2U=
X-Received: by 2002:a05:6102:8012:b0:608:d8be:da4c with SMTP id
 ada2fe7eead31-62afc506124mr1968314137.1.1777576026377; Thu, 30 Apr 2026
 12:07:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 12:07:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 12:07:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260428171541.1342335-3-seanjc@google.com>
References: <20260428171541.1342335-1-seanjc@google.com> <20260428171541.1342335-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 12:07:05 -0700
X-Gm-Features: AVHnY4Ks5Bm2PCziJ-syWgasNF85MyJs2TP5cmPUkTf-8K0QlT_PnzepmIRnslw
Message-ID: <CAEvNRgHqLcdO5j1X-nXXSjewOmnCDJmHtmPh=1jtQ3Tkf7+HMw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] KVM: guest_memfd: Move gmem function declarations
 to dedicated guest_memfd.h
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Extract the gmem function declarations out of kvm_mm.h and into a dedicated
> header, guest_memfd.h.  This will allow creating a MAINTAINERS entry for
> guest_memfd without having to rely on content pattern matching.
>

This also trims kvm_mm.h, which makes it easier to look stuff
up. Thanks!

Shall we do something similar for include/linux/kvm_host.h?

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c |  1 +
>  virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c    |  1 +
>  virt/kvm/kvm_mm.h      | 27 ---------------------------
>  4 files changed, 36 insertions(+), 27 deletions(-)
>  create mode 100644 virt/kvm/guest_memfd.h
>
>
> [...snip...]
>
