Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2338837B
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410223; cv=pass; b=jOWXgGDs29MJlJyMIrnOqqz2fUdu7OsKDFYQi+xU+gnmYXXUNGJCkOjQOuquLz/Zyey5qt6rBLBRC3YMTbhTQEDDp5oNSMJpUg9EpU72ct5rFffQfxPBQjHnM3bIuS4swjziiWnENFcO2/g6L0mNrt9dRtyoqWGN3oCSxS+uMME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410223; c=relaxed/simple;
	bh=8lWU4cpgiMq9YnX7HwrBm5P/hF6ii9HNA+L6UIhaR9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8bqVv77CtlfOkp29UavTXe+ZSMG856LABfZicsrj10hz8YdtWDyXXuInrIqrjsnphBYWmfAirEaNIsInC+fDCJ8OSY6oFKxVW8LzD/4AX8nsE0Sd/jJ0DEfu1x5uMyUrvzOl/fSzsHxHhrSw9rkbfNl6muRbpuzkApdeOquH7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBcuBtHs; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBcuBtHs"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so463131cf.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789410221; cv=none;
        d=google.com; s=arc-20260327;
        b=EIrrKO766HA/20Z5GjtyzSXdP6ixKIUjeoSbcdxHZTIWi5Bd3nGmP4EWNr4AIJRCyV
         9jMoUScH4xfTxJDHeRoBUTzI+ds25mYUMH/G7LVNhGQfPY+T6uNIcFw49DAAF7yBzWTk
         LKaAFwLvmJ3lfXLYsv+COQgM4TUc9cKrBf4LMG/aYE9xiYBNMfS913usaYintQ6qHkzb
         nSJvdM97Pxjb6XUjexOk5JuupidtqjZHN+xNimhoBS5Vzm6RDpdrThfTHQpvCSjVGsOz
         Hjp4M+/ZO0nhGxDF68M2+8KuJhoqPLwerNm3/+PEXCde60EwS4tXN9PHD/lka+QCXH5+
         XJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PjIDVmk73Nhw9gfQkfS5b5SQrCZ0nuN3PgiMSVCIJiM=;
        fh=2DOHfuYuyeEWDAw3/qkSHzguGLwTCivl5VNMyVTIraw=;
        b=PjXQ9lKVP+xWZuZHyNGLjqUCcf2v/GDeqWDmoqQZfTiLSzSuIDgPTfDeThiNU0JKYe
         oiFuO1oWVbrlIsH937W/dKn1LYoh2ruPucMauLsQfxU6+CqbL871r7p7GmhhHifRTEU/
         WqB9MkoOQNpShquK5ZdP8Y3Q8NJnJHRa8FPPihGYEX1DsSQdwngqqGW3bupOGVb3ET+A
         lCF67Qj/es8ron8kiT1xbdcMoDgrOIjuTTrsg76HcSsuvwetMNZvyyX0Hu4c0DyXk88s
         1KZo36O4NVIcnrh70H2bw4gffXal7cHkAZC0UgWa6M86deR8Dj/rRfSre3wqfR1Ep1o6
         aSvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789410221; x=1790015021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PjIDVmk73Nhw9gfQkfS5b5SQrCZ0nuN3PgiMSVCIJiM=;
        b=fBcuBtHswraFAoDPVNem5zLBRYQcuGx3Z131RujWN9nJZY8NvQFooChx4qbV5qYxno
         56fIAJCEqDhDyFee9QFwUD0Vc3CqfS00s2MZKd88s1sq2I5AOEKMYBrMWlqlCFpAVArC
         m7cRS/OpBzprSav5Jf3WOBzXSHCDLIt5H/FJCLvUefndBmXNyCd2M6mdL2tUjqafHmfd
         dSot1TVTI6b0ye3utDyg/QXAdr5pDLFIvCRWpmje8tMn7hWX1Kca1gndZ2V9rKnlEdP7
         ufHtVu0MuvXShu6v8g414mGYwJU3ylfeQ/ssTuM2lekSdhviYNIgUp01VlrgTQpsUvkH
         eTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789410221; x=1790015021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjIDVmk73Nhw9gfQkfS5b5SQrCZ0nuN3PgiMSVCIJiM=;
        b=G8AeYYvfC2APw44M4ibAirQQ0yRCC0di4beItZiwIDfndXlTY5+Trci0haits+0cVt
         lp+m8wBP2sbHrASXfBJNLnlO879jZgg9X8yJpbJ0HEEzNqPJMCVx4hFtGZR8E2YJww5n
         ZnY1Q8rARmRcDvYv9G+qBxrwxpOFw6BjWB13lShaQULML3QExSm5bUfnOuCVN7R5hXHo
         scFfvMweranzBEXi2dxM0SofF/N1EEqjeqzh9O/c0ct9aGK4GNS8IC+cW3mXbtmWgizK
         ir2IrUrerW46ytwDUt9MG9NrgtNfHa9sj0p+/kX7Km8mW56Vw8Tsno6ahEBrTdblru6z
         aX/w==
X-Forwarded-Encrypted: i=1; AKwUvBwFK2Eu/RUxM2/S/IgBnbGOOfKh+hEhYXNdfT8XE6y9MczJNmaA6d1txWTM5bJ7Gp3HeMw=@vger.kernel.org
X-Gm-Message-State: AFuF++kyL/Hgd76sWjys9Z1uA7XQtR9loFPAHpRqWrFHPtljzeTHpHXy
	RgXIn5HVBrm5xUaCk0chyV4mmHXoOuzXlPmyryX+3/+PWLgkNSwkf1hfG6Vlll4HDG91jCdzklX
	bxBlujN6I7wfykHdRn/43SVWUW3I+7EO8fOxZktlI
X-Gm-Gg: AYBFou0FkvICV+1/E5/ZZlqL/1AlM8nwV6LNz+vSDNDvk/Ah4L//QQSa/Jj3oqR4X+g
	2qH9g718MZnDW+1RUwAgGhAlrakcxPLpB6f4HB0KZGlcNToHX4tQV8ydqkUs+DUPWqUfYotU/u8
	nfzjipVJfyKK4eWSXaIsenMzPsmWK3e3pZHYYSKNe/wcZA0KfVr6YZDkKAPDxrBQUrvHUEjJywI
	JDwoOvC+rvcxvQMmMY26jY2cOoAT0oOM8OB8aj8S+LK66t02tfjkK+mSkW4TdbSXVHufnSxZPlC
	NKwY/+WcqWhsD+3jehX/bQH3+Iaiqz8rpux6GeuC02GWg2wJ+/ktDNI=
X-Received: by 2002:ac8:5753:0:b0:530:e335:4ef with SMTP id
 d75a77b69052e-5311a5c4df0mr1673231cf.2.1789410215624; Mon, 14 Sep 2026
 11:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <fc88f299f41c99ddb5851c24d97970dc29584876.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <fc88f299f41c99ddb5851c24d97970dc29584876.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 11:23:21 -0700
X-Gm-Features: AcwNN1UnHluX96bH9TjpBlsi84Tfb92oWbyT3d0BFAVR9QTkBp-QT6Wu1rTqanY
Message-ID: <CALMp9eSv77sBcfYpPJm4Uk+9CePV7YMdYXhvBHKHSvacnnRBUA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] KVM: x86: Provide INVLPG linear address to
 intercept handlers
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> INVLPG's memory operand is decoded with NoAccess, and thus src_val does
> not contain the operand address.  Intercept handlers therefore cannot
> construct exit state that reports the linear address from the existing
> x86_instruction_info fields.
>
> Add get_invlpg_linear_addr() to compute the address through __linearize()=
,
> using the same flags as em_invlpg(), and pass the result through
> x86_instruction_info.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/emulate.c     | 18 ++++++++++++++++++
>  arch/x86/kvm/kvm_emulate.h |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8071b372d233..1dfece6af81e 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -410,6 +410,9 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
>         _fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
>  })
>
> +static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
> +                                 enum x86_intercept intercept);
> +
Nit: I would move __linearize() rather than add a forward declaration,
but maybe it all unravels if you pull on that thread.

>  static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>                                     enum x86_intercept intercept,
>                                     enum x86_intercept_stage stage)
> @@ -427,6 +430,7 @@ static int emulator_check_intercept(struct x86_emulat=
e_ctxt *ctxt,
>                 .src_type   =3D ctxt->src.type,
>                 .dst_type   =3D ctxt->dst.type,
>                 .ad_bytes   =3D ctxt->ad_bytes,
> +               .invlpg_linear_addr =3D get_invlpg_linear_addr(ctxt, inte=
rcept),
>                 .rip        =3D ctxt->eip,
>                 .next_rip   =3D ctxt->_eip,
>         };
> @@ -702,6 +706,20 @@ static __always_inline int __linearize(struct x86_em=
ulate_ctxt *ctxt,
>                 return emulate_gp(ctxt, 0);
>  }
>
> +static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
> +                                 enum x86_intercept intercept)
> +{
> +       unsigned int max_size;
> +       unsigned long linear =3D 0;
> +
> +       if (intercept !=3D x86_intercept_invlpg)
> +               return 0;
> +
> +       __linearize(ctxt, ctxt->src.addr.mem, &max_size, 1, ctxt->mode,
> +                   &linear, X86EMUL_F_INVLPG);

What if __linearize() fails?

> +       return linear;
> +}
> +
>  static int linearize(struct x86_emulate_ctxt *ctxt,
>                      struct segmented_address addr,
>                      unsigned size, bool write,
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index 3e375af15c03..d05558ef28ae 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -51,6 +51,7 @@ struct x86_instruction_info {
>         u8  src_type;           /* type of source operand               *=
/
>         u8  dst_type;           /* type of destination operand          *=
/
>         u8  ad_bytes;           /* size of src/dst address              *=
/
> +       u64 invlpg_linear_addr; /* linear address, if INVLPG */
>         u64 rip;                /* rip of the instruction               *=
/
>         u64 next_rip;           /* rip following the instruction        *=
/
>  };
> --
> 2.43.7
>
