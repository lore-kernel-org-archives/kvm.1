Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E8361657
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073885; cv=pass; b=CMaZHrXm66zULzONit2jF0A1dsR6gJ3T9SyKTyO9QA2GaLp2AbHeqVLziBw3ZimHAvO3glalgxhgumimCqPw6TuK7ZwCaYbdVvTBwZWy5x+HPKwZaq9pdIXLiEj8iNxe/UKFKtiKdHSzIVzDut6NmwAMAy4xWhz1WvRKUR5P+7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073885; c=relaxed/simple;
	bh=spJmx0Vf6LcEPJZv1ISxZ1f0KJudMVM8BbedlmR9MNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA+dB1ditkCLzQlXhhII/sp+9q9jqjvOOxRweM6bc277lKzFkVDF2kGW6uNSEcDCdD7VHvRAM9ArHbNbGf6+qBlUiCIE4uOaG1sxvMZYT04u+V5fbZptkpsMUczH+UwF/E84xpOKAfeOBFBuN6EvTAgJL7GLb0Y2GZlK7A7cbmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFpSoQuU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNAZVWIn; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFpSoQuU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNAZVWIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776073883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGy/5GOvSEoxDwcOuXVLxPfPC6iBZJLsBp/6Ybjm+14=;
	b=KFpSoQuUlvCpA5PYpbn0wKw9XNiP9WaXUhnRGDjUzoW0TpadmId+XO8YFQVFHYHrsYBKQS
	rcKgBtVDS8oiIovg8uyhmTxzGZWzW1+ArQd9hgoeXSyWevuiXErgn16cMdFBSEFUUhbJ3S
	RAdgP0N8YGoZzAERaQuDiGkYC330hg8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-5l0_Y4NwM9ukgZbmUoEEhQ-1; Mon, 13 Apr 2026 05:51:21 -0400
X-MC-Unique: 5l0_Y4NwM9ukgZbmUoEEhQ-1
X-Mimecast-MFC-AGG-ID: 5l0_Y4NwM9ukgZbmUoEEhQ_1776073880
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4362197d1easo2939067f8f.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776073880; cv=none;
        d=google.com; s=arc-20240605;
        b=dxznbuuo1VXFx1qbW1JWJVgqZ5CyXe8vgtBt6t/U7ACD4BhCHQMcYuicnLJOTXcokV
         y5qEA9SDdI2XCMlGbhlKVYbxIiBTFI6PLqQX9qh8JDmi6t7Lb9TJgqrtIVT/L7wtd/U3
         lnSjRR5EYaesBY7gDjMmkbRrOTKw+i67Rebs+og0wMUGXvdMorsFtl6jFpv+s9k+urrz
         CbYNnBP+QCBKQ+qRewkMNZ2ddY1PxJBn7Mqf9p3P4QUuLf21SCq1u2PFpIK1FbraguhO
         G0r2IvdYTO2XWBwk5ygDFApBHvJXGtM4JwHLaJPiX1ZSgMJWh9rVVbXOeIsnAthuyrFe
         yJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGy/5GOvSEoxDwcOuXVLxPfPC6iBZJLsBp/6Ybjm+14=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=O76LqYKaEqyRy2VXwbCnHZPsOkpV0MqJjBdCwULoaUg+BN/ykY+EW13v2UqobP9kDp
         xDNPUDU3hyLH4TW7BqWIEr2BjWfiCOGctSiyptj/GYr4lwjp+937chfXVmOSF4JLKYX5
         kcBou6b+Pn3MiKPpBgsOkzzn1NyV/Tzk+NiCt59RiEXLGJoPselcfXfIbTx3oyFSvLvY
         6kAioCc8AiA9kjiulYJw8XnAhJmMXWqxTLi2yjoqgX8VyeS3XU7rkUJ5pnYmvoD9MX/b
         0u8CtrXJiyoAkX+3cH+s0IB00MHLRy7caXHLIsQJUOv74DvpHSvxbxXA6tZrDyJPNFsN
         TpCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776073880; x=1776678680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGy/5GOvSEoxDwcOuXVLxPfPC6iBZJLsBp/6Ybjm+14=;
        b=WNAZVWInyzFql+2u1U4Sq2G+XOs/o0ET/gpjJYOpE77YQFjk0RVr4qbLYIRcxT6Sj1
         CSMP0rJJxqE82rSsvOXzVF5DJG8PhC7odlGoTs+8CuP3+HRpQ1rDaklfKPP1uQYqh1Ob
         nuv01L9DP6nIwEmamPPCmZOF3vLxGGLSrGoLfDMM7+xJ3dq9YPi5sGqvliuGSz76Lf84
         xEmwGtsaeLqfQmLpGjAVbgH4MGDbprOiMVhWbyRjOBw98WUTWRYIZw6Aljy+2l0DDPl9
         sI3JtVAkFdLjNdwyF2YLjiWp1ktvRxXtshESB0aSu1KHCDOrSN86TwrZADuUOaEEcIWq
         hIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073880; x=1776678680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGy/5GOvSEoxDwcOuXVLxPfPC6iBZJLsBp/6Ybjm+14=;
        b=iaFgdCsT7B7CwZAPCtU9t1uGyPkc3hCLopEJkc4Jd6K8nT8seMp76dzN/QhPlG/pK1
         DHIiU4y9Tb1C0meXB9ZZJRoe6t96jc/h2Fri6XW9U1o+i5s0VhGWMukqguy9VuDV3ZqB
         AotdDqjygfHstYUvqDjjr7TtG+MfbCMYT2zLwWR8dQm1dLETC3tKAfhfy5EK2JvbameY
         V0OnrcAX6p+3atFBPtV1R7UoMnfI8Ucz3btEvo/UYyNvB1RAqYzOu5IRnA1/+V7cfPZV
         aNtd3D6biF3hBVdQ7KIr7vrjDwrdrvF3Egi2lLkkSV3ojhcddbIuQbMZzQAc7vxlZ+lg
         i7yg==
X-Gm-Message-State: AOJu0YyE3FxQ+jFIxydDWA4MmmG6ijN19Nx6ru2vBogBBEs7dC4HeMi5
	WooV3oA1y1HS9bndTyHWs7yFysYWA9jAB54Vm05uN2xWquNflMFiRDddnF31hnQobPdB/xSThYs
	xyP41Ebet6cPhc+UZIDtJuH5wKU+Pz1ExLhOTWj/0OQ4BNaNXxialsA84zmqIX3r01KDF6YdkeY
	MJlbFKaa+DUOUT6U14M9Jsg2XZH1GD
X-Gm-Gg: AeBDievbO38+2LwCxZ6fqxXh92fGkEHewkdq8RZqmSV2halUAzSV9a0H/krjoc7feHz
	qYxGVKelnMBucy+asdP4GjDbIAKVauo7r/ACHiJIHs/mKMVhVVg6DyDpytpriiFSzyaJWWNMuT8
	Ybu928LKinrLHRXIegXswWZGJ6FvGEXf6Ab6GYzbETUiy7zyWe/VjTq5B1jldRCHhZn66buhKjB
	GhXKsRl6Skre/26RknPZgbpF6okW63clRymahfCze5bQUHEMaqBPYYp6WVkkmS2KyDsVsusPatv
	chD9
X-Received: by 2002:a05:6000:1889:b0:43d:7b51:48eb with SMTP id ffacd0b85a97d-43d7b514a94mr2431424f8f.36.1776073880151;
        Mon, 13 Apr 2026 02:51:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:43d:7b51:48eb with SMTP id
 ffacd0b85a97d-43d7b514a94mr2431384f8f.36.1776073879717; Mon, 13 Apr 2026
 02:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-3-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-3-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 11:51:07 +0200
X-Gm-Features: AQROBzBWtl2JS_gisWJ1od0uh_QfR_RUBntYfT6S5gIE3-jIwaC0Sr9hcqeCs80
Message-ID: <CABgObfaDvqaR5oMREhLU667w3gbSL7iDvx_0LmiGxSk4Z_6euQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: guest_memfd change for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> A single gmem change to not set FGP_ACCESSED, in preparation for in-place
> conversion.
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-gmem-7.1
>
> for you to fetch changes up to 6dad5447c7bfca26b5d72604b5378dca6dc58bbc:
>
>   KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios (2026-03-0=
2 14:51:10 -0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM guest_memfd changes for 7.1
>
> Don't mark guest_memfd folios as accessed, as guest_memfd doesn't support
> reclaim, the memory is unevictable, and there is no storage to write back=
 to.
>
> ----------------------------------------------------------------
> Ackerley Tng (1):
>       KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios
>
>  virt/kvm/guest_memfd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

