Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705238DC62
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054132; cv=pass; b=ij197XDmjVSpKniO1QOVf6P2TiR6b0mdcTCwzxd3YJF9OyL16lX3AIK+JsNg87fJSCW1IKEqfSNlh9NBJA4O4DXnfoVP3MZgCSRke/I3roriOKKzYWtO4cRcHZ4Dsiz6gAQmvGTPNlMq+ucqgWl8NaceI4T2W83wh9r1jaXLIFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054132; c=relaxed/simple;
	bh=sK5LSHGIGZlB9DMKSpDtTjwOaQaXmlgy6xbFtQvnkdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4if9sDLKYrTSGKYX9wa/uTZigtOqhW+S3/IUzqsAxnbzwnur8pd+NPIrjKg3Kz4vfgmppy8H+s5uCqZ/4TUVFIXcsMrmHlofu9vTn1PpKc7BYX0Yh31kEF1fol2PP4pBakDsQ+tkynwI2FO2gg3m7XybYw2g0BagI/QcnVsmcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijIzt/fi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S70WqCOS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijIzt/fi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S70WqCOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789054130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=076K/ng/C7NGSTThkWi9CGLJINd0G0+FkkGArXx2vNw=;
	b=ijIzt/fi7DZCcODYk5K6n2uh1zEUjPX9ejmvXqh37YVIgxUEhjR2OOhEVXrmTh+YFFbDeO
	uLLbwcEOBk/kDT0XROVm0BC+3ZJwAWISC8Ae/TcqEn1lIws0YMcxdCcGxIx6DmBxttirBo
	MptdGrvT70+DmMf0LLKLqh3Q0a0Zats=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-qFmOiiNTMi2LK1yzHxarZg-1; Thu, 10 Sep 2026 11:28:48 -0400
X-MC-Unique: qFmOiiNTMi2LK1yzHxarZg-1
X-Mimecast-MFC-AGG-ID: qFmOiiNTMi2LK1yzHxarZg_1789054127
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4855e47d062so4758901f8f.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789054127; cv=none;
        d=google.com; s=arc-20260327;
        b=iPhh3QBX7y+4h3J9EJkJVqMYjbc5N9uMc53WEsfjqCz0XxznXSqAhJkDEnXvl3Q5Cp
         gJVlT57VPPkXwbm1tNVJLGrilphdkMv6C3KcVIjMqoxF5NwaTA8/r88Tt+Z42PkuQrz2
         bvICXK8kHGJseWw/ykvKrFI/Y+y6RwAWnPxKuVwq2HsNFZXuNYIl6/x7o1CrnnLXoLog
         YwRh/xuFgKpxUJe4qoffZ1lxDO9pCdm5uxQkV9E6CoUeZIVwu6PBO8KCvchczbyJz5Ax
         U5CAxL2p2pfwKI4QuxXHW0x2TbKnjue3y5mCe2rJk2xgM068a/M/CwkynMuHcHzbTWpH
         qRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=076K/ng/C7NGSTThkWi9CGLJINd0G0+FkkGArXx2vNw=;
        fh=1Ln8ZJmiRhv85jqMwYwSYR7hDaaDKN+ozq+H+vuX6FY=;
        b=e74hMSaABUi27aY9JeygYvzpLa5Dpa71HtUm57SVlGFdfqf5AstCUe02kKgrLU1sFD
         U84JuKoaPG+IGjW6k6jAMEa23YP158tHisiIP3qjlqqhOEj3QuO93n+7UMkhFcR2Nsoc
         zQBVLHYhmXAgsqTdDvPf6wOFF1y+X/4YnG13+3nYodjMK512ZXc/Nt243t/QGq7HlBQM
         7880hQ2N6wwos2x9lrEfT62aabP2HTjxRKmi7FPqxfoWCJaux2qjBt9wevb5KNcwO0B3
         6voOINrsnJHyXCRH5KXtMe/joHR/HeKWK+tOgXjjlBrRGGlBsr350M6YBs/Q+Yps8Xwe
         eZmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789054127; x=1789658927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=076K/ng/C7NGSTThkWi9CGLJINd0G0+FkkGArXx2vNw=;
        b=S70WqCOSp0PhjD0L8G8aKplL/JV0pBKnbEdklY+9IN1LXVzMn164Fuee6feCoenYNY
         AbLbWhy58DTl12eV3HsxqZhHUePFO50wt+ToHevQgT5rMQiRnatQhCe7SjHI797g5NPX
         uOCDAGYC7APoczWwGJECGG9aXlG+cWD/zW6YTif8f6HA98m0I0amrYZHuyN6vW/HiUeZ
         p+l34fOSqyohyoERso1zCFwccWcSi5ZqcUfeuEXiS9cjK/nh7iJHwzn4j488NiFSldvN
         +eD9iE6oqUVS3MrnT5ia+Uc85Gg30t9ydRTHRUq2kou6F6sjcxjoCuVIYWB7UTscb2RF
         Ij/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054127; x=1789658927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=076K/ng/C7NGSTThkWi9CGLJINd0G0+FkkGArXx2vNw=;
        b=XdW7n949siKETt8HYwg+BYk5eB0g/9zPfeio2BAU5kIlOou/9MWinPkiNMlN7TO5+u
         +heOJGTqgfj6pGaRBikWLtVLFvO+YsdT9D67JY/223F7Vs1snXPfgxK7L30ocIfmjqEv
         NzCkEXiZNcsjiSKGPiBLsYRlb73sQaqT0Lj1mlEMg3t6Qdv/kbUg+Er6fHpimLMn2pZf
         ebiVfApmhaI++O6+lx/13FS2wzQ1Cj3GYfqGoQZ9qC1LkQDRgu8k3fpgSGYD9qFXGZNP
         HHUOUrBdhQk3zwOIlJFwhkeMIufCFbDLnRdTe7k8XXTYmVecxJwafTal9NNQap3gMktx
         jJNw==
X-Forwarded-Encrypted: i=1; AKwUvByr393wHeW+5c3BOKNoM2Zh0OAWzpeFIoV5rGKnrd2OmPRpE3Xiysvfq7cnyjca5epudAg=@vger.kernel.org
X-Gm-Message-State: AFuF++kYFDIgub7OO8E62YeCA6P2fM/LDmxkn8wqykQbirX3c9eVY9X2
	kL8jGcJNnH0ml1dq/vYBRMzkP3N0Jcys/k8ZODA8KyVJ9DDCejRXdSD7SHpOj9UhC/9r1oMbz+p
	m01BkSSduj3KyeQxTH/DjgXXL6MRH770kC+bQzyyc4QsuOj9gfeTyR8I0yNXDBB0TWHC2UrQefE
	uvAqr2yrsTYGyqDGVtEO50FVFSfMeA
X-Gm-Gg: AYBFou19pTn4HrVXFpxTK3ceYZyISxR2E/YHZYanSFrUmnW5wzu3IRC91izAE8j7jlZ
	udjxKVoQCwVooRI0f/OlmBQU7txhBRAYoqkQXDvkfJ31/WpAhA4p17CvHvuSThbxKpMGPW32/Qs
	166qTbgIUCanj3KxQIXpuqY4ap7cJwXZdcfh6QWZPzHoYuFCzfsByZv/HcVSvMZf8G+1JTCsELZ
	wNM9GxgWORhr5OOybtjZgK9WBzLBB4AoS+zAL8NWAcOUZZMlk7tSQ+AENbTKQ==
X-Received: by 2002:a05:6000:144d:b0:485:b067:c685 with SMTP id ffacd0b85a97d-485b067c8d1mr9124015f8f.33.1789054127049;
        Thu, 10 Sep 2026 08:28:47 -0700 (PDT)
X-Received: by 2002:a05:6000:144d:b0:485:b067:c685 with SMTP id
 ffacd0b85a97d-485b067c8d1mr9123973f8f.33.1789054126556; Thu, 10 Sep 2026
 08:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910112027.34581-1-flyingpeng@tencent.com> <aqLBQ8AXe189POtS@google.com>
In-Reply-To: <aqLBQ8AXe189POtS@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Sep 2026 17:28:34 +0200
X-Gm-Features: AcwNN1U8O40Ww9hx_OcsSMWU6_zJWfhOZC5LvscRaRWGXLRPd7fZqQ78nZ6_Zj8
Message-ID: <CABgObfY+8Z8p4DDhfs0mBAshR22j03iEF047abKTsB-aDZeb2Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: Simplify backwards dirty ring batch check
To: Sean Christopherson <seanjc@google.com>
Cc: Peng Hao <flyingpenghao@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Sep 10, 2026, Peng Hao wrote:
> > The backwards coalescing path shifts mask left and back right to check
> > whether moving the batch base would discard set bits.  The shift fits i=
f
> > the distance is no greater than the number of leading zeroes in mask.
> >
> > Use that directly.  Convert delta to u64 before negating it so that a
> > positive delta, including one that wrapped to S64_MIN, is rejected by t=
he
> > unsigned comparison without invoking signed overflow.  Use __builtin_cl=
zl()
> > to match the unsigned long type of mask on both 32-bit and 64-bit build=
s.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>
> LOL, Paolo definitely has a different sense of "simple" when it comes to =
bitwise
> math.

I am not sure *when* I suggested that. I cannot honestly exclude it,
for the reason you express, :) but it probably was before
include/linux/overflow.h.  Because...

> > -                             /* Backwards visit, careful about overflo=
ws! */
> > -                             if (delta > -BITS_PER_LONG && delta < 0 &=
&
> > -                             (mask << -delta >> -delta) =3D=3D mask) {
> > +                             /* Backwards visit, but do not discard se=
t bits. */
>
> IMO, this really needs a more verbose comment.
>
> > +                             if (-(u64)delta <=3D __builtin_clzl(mask)=
) {

... I love it, but it's unreadable. The "mask << -delta >> -delta"
basically means no overflow on shift left. So just write

if (!check_shl_overflow(mask, -delta, shifted_mask)) {
    cur_offset =3D next_offset;
    mask =3D shifted_mask | 1;
}

and the clz magic, if desired, goes in include/linux/overflow.h. A lot
more complicated now:

i#define __check_shl_choose(_int, _ll)                                  \
        __builtin_choose_expr(sizeof(_a) <=3D sizeof(unsigned int) &&     \
                              sizeof(*_d) <=3D sizeof(unsigned int),      \
                              (_int), (_ll))

  #define check_shl_overflow(a, s, d) __must_check_overflow(({          \
        typeof(a) _a =3D (a);                                             \
        typeof(s) _s =3D (s);                                             \
        typeof(d) _d =3D (d);                                             \
        unsigned int _width =3D __check_shl_choose(32, 64);               \
        unsigned int _bits =3D 8 * sizeof(*_d);                           \
        unsigned int _dst_bits =3D _bits -                                \
                                 is_signed_type(typeof(*_d));           \
        unsigned int _adj =3D _width - _dst_bits;                         \
        unsigned int _clz =3D __check_shl_choose(                         \
                _a ? __builtin_clz((unsigned int)_a) : 32,              \
                _a ? __builtin_clzll((unsigned long long)_a) : 64);     \
        bool _overflow;                                                 \
                                                                        \
        BUILD_BUG_ON(is_signed_type(typeof(_a)));                       \
        BUILD_BUG_ON(is_signed_type(typeof(*_d)) &&                     \
                     sizeof(*_d) <=3D sizeof(_a));                        \
                                                                        \
        _overflow =3D (sizeof(_a) > sizeof(*_d) && _clz < _adj) ||        \
                (u64)_s >=3D min_t(u64, _bits, _clz - _adj + 1);          \
        if (!_overflow)                                                 \
                *_d =3D (typeof(*_d))_a << _s;                            \
        _overflow;                                                      \
  }))

(The BUILD_BUG_ON would be more restrictive than the current
implementation, but IMO would be a good idea anyway to avoid having to
think about sign extensions).

So yeah, I think I must pass on the opportunity and leave the current code.=
..

Paolo

