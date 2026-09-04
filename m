Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DC501F57
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561275; cv=pass; b=Ptng/oKvAuqWa7XTimxQ7tJ1R4Uam+NS7STC53AlOvwGuzsXDdt6bEGd5M2V7ggg6Q0EBLVUbZbvMZUkMkaBhtJDFBbM1aBp7NzZtFbuvW5EdWs2iq9Y4ULt57e0qPPoYZQX24+p8mARRB+ZjHsZUztySxjxnZ/P+pIROtk7QGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561275; c=relaxed/simple;
	bh=zQzEewI4ZvoZshQfZVFvWPcbJeYMDctnRHy7ajATikE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmvdYuMEUR8TJiUCAScuRl06BhnKxxtnnNyMQ4P10Ce7KAfqn1Cq0pApXOhGgL0Zscppkq23vQT+nCaiVirsJNS2CgLXioZWV8vQ5MvYuqG3ccCWY2rFIqv4QXY0ZVA59+Sb+Ah+QUoPwkDaYrKjT0F5FJwjcs5fbq8jZeFBy8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5L5bfoR; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5L5bfoR"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d8dso1228a12.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 15:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788561272; cv=none;
        d=google.com; s=arc-20260327;
        b=TDp1la2fB8p/Kl6aaf4x1VnbfHq7F/Cy6d3GEtzBAsnfEsOoAtBcinRxQ65+4hAXmq
         DjwgcIaTj7WnmLzR5U0dK0Elea+HahnRCovSZABVLhIDnlq1e/8HKcGa5i3HgJbvTzWw
         Oy1dOrbvE/17kAhaKRzO84BRIQCCnRiCKE9WiJM7WJI0O06INS0hUmxkZ8HdYwzl3vlO
         0XBdhEuSweAYFCtgoXQjW0KHwaP+D0Sfk4McmsI1cj6NJvCAnzWrXHVvksSec5rs8x8o
         DYcIufYbudh/+PV9bYUS29CZqVQ94u/WL5PrpIBEmB0WLfLTlHzxbg6nVg0sXZiXBugl
         k6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWyLFB322c+K8udyWMay6dKIPqFbfWlPPY8Vkro08BM=;
        fh=99Ul+UKmRYuIeedfzFEWYJ/DI9fGFtvBZ7hujpViOEI=;
        b=d5Rc+1A7l/qUqVAzbVz3LE5tPeH6E+SV+hgbGFmP1BkCbbwh6OAKdyRAhCDgglrLeY
         OpvGiSNIu29lqEBhJlE6H91iDAyhC/IbeweQOC/IdaeVUZunRlE3UIEziHRZ+Soz9G9G
         0yCALcUB4D602RFr67x2shcQIYPM3qKhzO7VJE46x+jORkzuIU5lK0zxoihPZqnn4Z9c
         Pbh6+89QUTziJe2fVe61x76OaGSi2WYvLSyXYunTNKIceor17y/nXTO85IBFZJkqtuDE
         S6YLu37vtBjrX2Km3pMMNR9HHroB7rwe0GEYNEuaVknGPlSWeiXHiuGByHv2po/hkEM7
         ZSWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788561272; x=1789166072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vWyLFB322c+K8udyWMay6dKIPqFbfWlPPY8Vkro08BM=;
        b=i5L5bfoRS1hv4oOobsDflFsRUVPWpYm7PnaTb7K/SiND3QTD2asCSX6JMLk89t7gia
         Et0q2++NrSbsAmKON8ON/J7DlxIFzHbIOSVzqm4bE5C+ntGaN0GNPMrSxm/2MJaE9wci
         dhwnIFJm/hgGnFTmjB4AcV39R7IidOlxs81lxDxiS+OOxUizpmU0v/QWlE1IkvpBBNl6
         rK8q9i0BKxUVGn2BkMYB7tyY4dQb44Y1ZGZyl90LEEmv8g36gL58GKeirCd919NuMg/w
         9BzAVtdrjXjKhi+eXZ2UhWt+Z6VUu6P6eqZsUsls5GrXcGIMavLSeZMC6BrPb7tRMqo5
         6UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561272; x=1789166072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWyLFB322c+K8udyWMay6dKIPqFbfWlPPY8Vkro08BM=;
        b=BvZ6Q5PrWPA7EY0FRvzKfaZe4CjaAol4jlq7sYoil9DX6ZYPmGGuuR2jhEyr9I5DCX
         FfURIxnUH+5QL2JBveqsbDmwIXOZD1Ob0CtgwD/L7Z3xt8fSDzuYqRshd2Xk9yyBQXW2
         mdroMNo/3ZOVU3tLYdz88UzLEbHnyoMzIjl/UEZfdMgE5ykRHI4gZXH58o0h+4Zm0QvY
         BqVd943mE9VEhDkm7tSI6eoEw52E8VQl/85JfuSmqZf3ps6beGkyOxtNsAzI+WNSk7Hl
         SW6X+SfENZsQWEBw07lmY4lzcdi7Bm+DkDWBlVhEmhY7OfI8zq6SnEDduaVZl+qHcgks
         hjzg==
X-Forwarded-Encrypted: i=1; AKwUvBy4WenV1RY+Vo2VTmA2auQvDZSfh9QhBkE5+SmitIWaXmIcN9zqmpzBHEh4UtkIJMaG4lg=@vger.kernel.org
X-Gm-Message-State: AFuF++kj/6SZVF+8//FmTQGZDu551+3RX2oZJRBDPM5UI56wrhJ+Ed2r
	L87hl209HdgCE6q5NpaSXJVq3u+zG/zcc3R+PbmhQaFz6IKFH4TKhfK2Nvloilk9brVarjmoOkc
	zX12iO9/SszPg3qhrkLAe9eFU0FM+WTIRUeWtO/fn
X-Gm-Gg: AYBFou2O4bSiEGwIsi9PZHHBkp9lgycaVc3xc0d5jeIKs64ss2u3Jahl1slPtlkHN5r
	S304S5y03JvJJ6XVPpHVBJxq4l0JdGcan3k/smIfHTNwyZgftLYkwskpJF7JqZKFN6xjRLMUv/I
	sEvBKmVI5lHjReQ6gcvQwK1qMeMlQ0HFXiumL99XRjbQVqMC57IfFXXb/EqItmdZxN/cOozQGAk
	vAkJsy9jyN4Ivlos+Hf6b+BtwV+l9IZhWTGQEHL+cjQ//xQ2zW+n+VcICSaN5VxkDM/mJ02ZSSv
	nDASyDqtSe/84MSfEcFEQBRITMFaW3j4SyBbkkqnhWR+
X-Received: by 2002:a05:6402:21c6:b0:6a6:96df:215b with SMTP id
 4fb4d7f45d1cf-6a7f682710amr11857a12.14.1788561271594; Fri, 04 Sep 2026
 15:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net> <20260824123954.315112-2-zhang_wei@open-hieco.net>
In-Reply-To: <20260824123954.315112-2-zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 4 Sep 2026 15:34:19 -0700
X-Gm-Features: AcwNN1W2CL3MX24WexOB2cU1f7wgDBrCrUSExLWQoABuDUy_PRYgrmgU2-Tp_bU
Message-ID: <CALMp9eQoMn5BxXfu9ut5EZVGipfiZzbQz32mpi3TCjA6fA7jCw@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] KVM: x86: Add helper to provide intercept linear addresses
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> Add get_intercept_linear_addr() to compute the linear address for
> intercepts that report one, and pass the result through
> x86_instruction_info.
>
> Handle INVLPG as the initial user.  INVLPG's memory operand is decoded
> with NoAccess, and thus src_val does not contain the operand address.
> Compute the address from the decoded segment base and effective address
> in the emulator, where the operand state is available.
>
> This allows intercept handlers to use the linear address directly
> without duplicating the emulator's address calculation.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/emulate.c     | 29 +++++++++++++++++++++--------
>  arch/x86/kvm/kvm_emulate.h |  1 +
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8071b372d233..a0e57b64cadd 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -410,6 +410,26 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
>         _fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
>  })
>
> +static unsigned long seg_base(struct x86_emulate_ctxt *ctxt, int seg)
> +{
> +       if (ctxt->mode =3D=3D X86EMUL_MODE_PROT64 && seg < VCPU_SREG_FS)
> +               return 0;
> +
> +       return ctxt->ops->get_cached_segment_base(ctxt, seg);
> +}
> +
> +static u64 get_intercept_linear_addr(struct x86_emulate_ctxt *ctxt,
> +                                    enum x86_intercept intercept)
> +{
> +       u64 la;
> +
> +       if (intercept !=3D x86_intercept_invlpg)
> +               return 0;
> +
> +       la =3D seg_base(ctxt, ctxt->src.addr.mem.seg) + ctxt->src.addr.me=
m.ea;
> +       return ctxt->mode =3D=3D X86EMUL_MODE_PROT64 ? la : (u32)la;
> +}

The linear address calculation here is replicated from __linearize().
Perhaps something like:

static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt)
{
        unsigned int max_size;
        ulong linear;

        if (intercept !=3D x86_intercept_invlpg)
                return 0;

        __linearize(ctxt, ctxt->src.addr.mem, &max_size, 1,
ctxt->mode, &linear, X86EMUL_F_INVLPG);
        return linear;
}



>  static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>                                     enum x86_intercept intercept,
>                                     enum x86_intercept_stage stage)
> @@ -427,6 +447,7 @@ static int emulator_check_intercept(struct x86_emulat=
e_ctxt *ctxt,
>                 .src_type   =3D ctxt->src.type,
>                 .dst_type   =3D ctxt->dst.type,
>                 .ad_bytes   =3D ctxt->ad_bytes,
> +               .intercept_linear_addr =3D get_intercept_linear_addr(ctxt=
, intercept),

Maybe:
+               .invlpg_linear_addr =3D get_invlpg_linear_addr(ctxt, interc=
ept),

>                 .rip        =3D ctxt->eip,
>                 .next_rip   =3D ctxt->_eip,
>         };
> @@ -520,14 +541,6 @@ static u32 desc_limit_scaled(struct desc_struct *des=
c)
>         return desc->g ? (limit << 12) | 0xfff : limit;
>  }
>
> -static unsigned long seg_base(struct x86_emulate_ctxt *ctxt, int seg)
> -{
> -       if (ctxt->mode =3D=3D X86EMUL_MODE_PROT64 && seg < VCPU_SREG_FS)
> -               return 0;
> -
> -       return ctxt->ops->get_cached_segment_base(ctxt, seg);
> -}
> -
>  static int emulate_exception(struct x86_emulate_ctxt *ctxt, int vec,
>                              u32 error, bool valid)
>  {
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index 3e375af15c03..9eda648a1314 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -51,6 +51,7 @@ struct x86_instruction_info {
>         u8  src_type;           /* type of source operand               *=
/
>         u8  dst_type;           /* type of destination operand          *=
/
>         u8  ad_bytes;           /* size of src/dst address              *=
/
> +       u64 intercept_linear_addr;      /* arch-reported linear address, =
if any */

+       u64 invlpg_linear_addr;      /* linear address, if invlpg */

>         u64 rip;                /* rip of the instruction               *=
/
>         u64 next_rip;           /* rip following the instruction        *=
/
>  };
>
> base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
> --
> 2.43.7
>

I don't really like special-casing INVLPG, but I don't see an easy alternat=
ive.
