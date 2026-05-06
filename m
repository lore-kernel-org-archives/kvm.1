Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A8329C6B
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106464; cv=pass; b=X9YibO1xvcjIDaXeASshFJTcBPTKaZgeIV+gV0GRTxzxg58ojWrc8RnhefvKLXfuqCF1qJMVvxBTJwBf5xprBxfhsMXcw0iSvwztK8YGs6S2jbXz1ynvvzOdZty6HS9iYTyULfxGPOvQUlPhx6TtUL4prKKJxDDYtRlbhWLTY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106464; c=relaxed/simple;
	bh=OFxur1GhFZVWQMFt33G6qqBEblfHMDr8zmYAB9sah6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSoXIir87yxHmQblDBaWEDDxYWra6NcAPZjHzzpOOqMyRePzwaO2oEi2d7tzj6kxE8ENepU46/vPCm3K1cDXvbO255/QspZW2bGLGg8rxs4y435rHUb/ksP4XcVTQ05oY5lRB/OHy0zWSx1cPPiy+wj3U+CMjStEL8RuBsjtA2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiHvC/t3; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiHvC/t3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso2013a12.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 15:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778106460; cv=none;
        d=google.com; s=arc-20240605;
        b=PxqFhUt4oB3knZvh24T9htuToVN0S/GYQj16qQTxWv3WXBOUaaK0XNZPEprKmKRHMT
         qDq5ffVG2KKPzziyDkXMGd7euavq0PzqorTrU82j7Qys7X6fNYxnuKLFUdpLqm8MSZAM
         osWoEt5r5/OzOTxtenqvhMQIaseRvwSNpxenGK+DVT44fD18RBpmhgwzbKLpCo9LYawH
         v3jKhRagVgs32ZUYTJGAL2W9Y95miP6+3qZNPoX+6y/AAa4sMwvDW9vWFEPSLR1yDz8C
         BLEtavP1+hrAgAkH+nqHB4MJRY1yRCRwBgDsZb4aSMJ5ZMSLpNfnSn1xjLoM7vST3z9N
         X+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v2IrwpP7KxqGE27hDJZDtz9djCHbFpjKlwdFeLloPxI=;
        fh=Nj1RtEOlU3PsZ4t72tPB7a6wfs/LrqYGCBBT+VSdjvs=;
        b=GQh/kZalFnZZLH12V11YDEIZnVjj8WxGLBiqIKudNVOf0TrY/oknUpkzvxlefijax4
         kcYMvKRUwDUL4/qMPDESF4f7aiZjT6F9AEPFqYW4skb5STHKYQ75J9StPjec9OeT+hk4
         8hgyB4wVNakcqNJtA2iGRiYqV/9e+wCsgOHNgVlEKxaP/zdMT7q1XoDU7+2H3USK+Lfz
         HSyiJOShlZpWHZ2Raw5LAcCX77xfrvvuX3nm7fSMH4KZ+QT6K9tLLa36RiZklmlKqkrs
         31I6cYgVcTG3RkI5JDabDVNb3j9nL44mlgHcy8lpBKOkozY3/9ZnKUssqhPLmjeK6cfH
         7xNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778106460; x=1778711260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2IrwpP7KxqGE27hDJZDtz9djCHbFpjKlwdFeLloPxI=;
        b=tiHvC/t3XQozQPRvB/CO7suDzXnEARgeC4pkCnSDEI9tdRHllr6HzEoBWBp+mdZW+P
         C0HXNXNXGZxv7XdgocEOZUFKpgglbIOh19WJOUrYuET8MEQDA6AkwEMGyxyZlZmID3FH
         jMZ6ivbc/P0KS1bgBje73RGkvsqDc4qntB4dPDTq6IxCBdyoTmOgtOPY27hhhn0tuXwz
         QSRPNXjQ+0aR/bEmY4e0DN7Oe3v/RWOVvF5am8kGJ2jlqdFNeg38onjxWgYu/D8sDAFe
         CombWiLuxDv2HB+xNH5ViyYEn+SmYXS3dEfDBsEfSivNkHZc1i/p+YeCCjjoid7d36Z+
         +QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778106460; x=1778711260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2IrwpP7KxqGE27hDJZDtz9djCHbFpjKlwdFeLloPxI=;
        b=mpwPYqrxnpbCqtjn8NbMYHC5IbQiVa2eQWHlaMeh02EBIvHKJ/z6dR52q6jk230WXo
         vp1229Fn/V7Wd7D1Fn9i7IlfBAbiCdETZmX7qk+G1WpgN7+u3JF9+ytqVjqASNiJdgse
         dDIkY/1aIxwOoBDVYeUM0ejdUA3PYn3ZpL24fec+ScUdMxwyziw7hRMrwzAQZINrz0T7
         OfhvrxbGSBOcJ5/l3IahKYcct/l5vKV48bc2jXxQB4r4/k+RkFHJOu5OQ9yDizIfs7SL
         L8yzn9/os7xqS2/HJMei0R8rfJcWJfUTpdaB8RbE8tDqoFVocVN/DngaLJmiwtXwHeZV
         1VSA==
X-Forwarded-Encrypted: i=1; AFNElJ9WO7pYBq5vG4HGZs5z1wMRMWlQIfwXKsLdIGlOcpxB9T8iw9YnbD+g/ZhLrzSOAhG/W8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/NnRfAuvl0PeE4YTNx0sHCyxh1ikXpELVNDqb9RI66JMVw9P
	DbFOcJEgQT00X28mgov+TrQX6HJmPNNHhOsAnHQcITcyttoZLHsg1Hne40FZ8LCkEZVfzO6LLZI
	NVx7iV+Qxa+UeoprwoP7DFSPBs5KycMHJaAduZyfPalY0Q8sJXeWOKk4z
X-Gm-Gg: AeBDietlP9SGg56DO+TIpGufN3V+IOCSIWkIqEBfUncIlq6wmP3zwKCQiY1zMAx+ITy
	JvHqjmsQdqyeIS1QzlURThn/NKbBJC0T08vW3XZ64R+vECHx32eKwWz9bTtEud+PN6g/u2ecyP3
	U6JPaIkKyLZRifuaPPkSaUqFBBiRzN3CzJRaOJrt+avY7Q4ZaXK/pM+VuK4nqJhsV+QKLdvuJn0
	aywzsQTrP3DxbxhGTrHgUsZvZbM47u5eAvxh229F/xMsosGHkZp5ioXhtUvmx7MMrv5Mt/Iw1G7
	nGD+8ib0nTo7F0zkMyRzWWcOK9Mw
X-Received: by 2002:aa7:d906:0:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-67d63d7e3a1mr70226a12.3.1778106459919; Wed, 06 May 2026
 15:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506213514.2781948-1-seanjc@google.com>
In-Reply-To: <20260506213514.2781948-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 6 May 2026 15:27:28 -0700
X-Gm-Features: AVHnY4Kp9F2JtfnRKYqHAH_8oMPl71G55GiKunMe6DyoNiaxJBPhrLQ9_4FsIMg
Message-ID: <CALMp9eSArSjiUq1CXxzHRRtaJX5u_nBXVJLhLnjb+UiX2ww3mg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Swap the dst and src operand for MOVNTDQA
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Eads <josheads@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:35=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Swap the MOVNTDQA operands, as MOVNTDQA does NOT in fact have "the same
> characteristics as 0F E7 (MOVNTDQ)"; MOVNTDQA loads from memory and store=
s
> to registers, while MOVNTDQ loads from registers and stores to memory.
>
> Per the SDM:
>
>  MOVNTDQ - Move packed integer values in xmm1 to m128 using non-temporal
>            hint.
>
>  MOVNTDQA - Move double quadword from m128 to xmm1 using non-temporal hin=
t
>             if WC memory type.
>
> Reported-by: Josh Eads <josheads@google.com>
> Fixes: c57d9bafbd0b ("KVM: x86: Add support for emulating MOVNTDQA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> v2: Suck less. [Josh]
>
> v1: https://lore.kernel.org/all/20260506185510.2723091-1-seanjc@google.co=
m
>
>  arch/x86/kvm/emulate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8c6cc0406d6..8013dccb3110 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4481,7 +4481,7 @@ static const struct opcode opcode_map_0f_38[256] =
=3D {
>         X16(N), X16(N),
>         /* 0x20 - 0x2f */
>         X8(N),
> -       X2(N), GP(SrcReg | DstMem | ModRM | Mov | Aligned, &pfx_0f_e7_0f_=
38_2a), N, N, N, N, N,
> +       X2(N), GP(SrcMem | DstReg | ModRM | Mov | Aligned, &pfx_0f_e7_0f_=
38_2a), N, N, N, N, N,

Ten Ns starting at 0x20 leaves you at 0x2a, so I buy it. :)

Reviewed-by: Jim Mattson <jmattson@google.com>

>         /* 0x30 - 0x7f */
>         X16(N), X16(N), X16(N), X16(N), X16(N),
>         /* 0x80 - 0xef */
>
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> --
> 2.54.0.545.g6539524ca2-goog
>
>
