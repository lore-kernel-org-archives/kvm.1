Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9A4E5339
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661391; cv=pass; b=ik5DacgTRYlDFxs+wtQcw5fH/tsOa4vXVO0pddHMJhRRRF7/KNb2bzaD1xgjCfBYxDdJfJZuZUXIAh5srcVtgFKgCab52tzghwJSMrbV12f0uJVXimwPxNVRW4/qP1E0BTfjqOQvz6tbexiaDRpodZd5vqJ7VK1CtTFJ7BKpDog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661391; c=relaxed/simple;
	bh=ugZh4GgKslcLNl0O673R9MytQRmFBsqXx+iT5KnQwnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umFvAy4k9V9iTd8rkq9mbizDioS9eITKfjo178XbCCh9yXX3Vxn83AebwO79k90C5WFovsOiEkMR+foB080zE6PeMxEozY/Ejd7rqWej/wVfS/VPOMC3ycIjT9MC4yBVesd3muyqwLMWFWGhXIPh8/fsrOyo97oJisWebQLqxlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfHiR6MR; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfHiR6MR"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2c0356so673525b6e.2
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 09:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789661388; cv=none;
        d=google.com; s=arc-20260327;
        b=X/QLIT7KnZhR9UwcvfNu2i3tQGS4crxKgquIIlDSVZkISG2Jpnc7wEUrrnrS0uE6VH
         7vbAji7tCOZ5DKto2BUV527t6DrIll4o2xXvHS/Q+Yfg6Qj2G+fXpOEwVAOdpL8gwavn
         JasEy5t7LLNlwnK08/mwmw9TWtCjvlAgkWw4JRpRNqNGs+8wp5BECPpNoLFQy5kKY38X
         hy+ieR+QFgKkDYmqoX+5EI1dRk8Z0mHlkF4l3BBJ+++1Ggae8IAc1nvb4UEY/ikcLWjg
         rFvzRkMN+F32KZ1iaWwXzcYjiHQxXxKx/m8axqhXVmTcF6Iv2/QlvB02NS7sIWSQjzhJ
         bMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f7RdKSG2IUiwE/yK67KGbXGnksiJyoZcwGK33ti4lCg=;
        fh=IJA83JNlmtw5p4K2pyx5gdyAFPGwC28hiYQx6fxGtak=;
        b=kbJf0oXJsq44JzgRu9Ulz5jwjoC5K+13cILlP7XddkmdxFu/Mnd4E1yvC6ZkiBMOxM
         qXiciXSiIJD3ruew/JZFI07CyHOP5DKMG3RFTD6cW9tF3HVWWSYYKk3jXlBlAlWPUfN5
         WXUA8b5p+I2OMZc/lnw5Xtilk+SCKEnvgEVgFNjs6p9eBVMayjHEq2upamVY3UUGMLKb
         rolcxPL1tCJhHOjQwNSw2OOt0Z/DvxhgYh+LfjTl0quB88+H6bKJW4+eL4mN7cA0MI4k
         3MfDv1t7AMD9/U+1S+D7OAJ9MoTRbF9P22j513HCdhO8MMI7AiRPSLLSB2TkHWEA0Ivh
         WbAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661388; x=1790266188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7RdKSG2IUiwE/yK67KGbXGnksiJyoZcwGK33ti4lCg=;
        b=WfHiR6MRfIFbu0A4Y6SXm2M8zSdgO+mexbW86ZJW76tR3S4fypouEtinXp5LxREVsd
         4v7aYunZ3xq+l+PkC81L6vCkRfh9P983sZ57QzufwKfDm9WSLIK705FoAft7o7bu6aci
         HSUUrmUyZ/n9KjosqwC4Ulb/srjShxs07VF+dE0im5aMYXv/Qlpd7mk1IlLs57/ERg3d
         u4G2xOQVYKLa8sQM7wU+FbGJ9T4t5mDAW/BUit7Eafrp1MqKxPeYTnh7V2N/PiaDLuRo
         w2pOiBsjW0Xz+/MeuS0zUUc5FcvYlrrFvMf7mlJKOXcKA4VJlGP7bTpi/t6XdLJJ5MDt
         wnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661388; x=1790266188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7RdKSG2IUiwE/yK67KGbXGnksiJyoZcwGK33ti4lCg=;
        b=kw/qRio31dSwtjBe50p7POvWVfZuzDxFy31rLPXH3I9ETlYvPL1RbN++md7AfCKzfP
         Idk8cw59qYL9/2aSxTyRdgvlMu+5tT6kKReQaxeIV0KOOh2L1jYN2IxNyZpajIl2NUkO
         UnNtpWda6ll5qqeg/10obXvZiO800gC5SyJLyytb6FMJEWV7AZa/bf2V/pem7+UUd+BS
         uYPrr5VZLbVyARmWVNTRHLjsbH9tULLQN+sTRxT6mNqCm7dZ2BIXaF9CoNuaRBp3j0Y4
         vnOPCksidZ5Qp99ZcDdm4ikkycFN8J/2wvpMJH7gnLm63Bt0UmdrokFNcnWOQGszyRFE
         0lIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlZPl0hv3YoU10W4u3J6WFjDlLnxDpxQJZaoQesbQ2AjVnp7G6lp2ovAzOocxFPz+vh2g=@vger.kernel.org
X-Gm-Message-State: AFuF++lCrWPk1cwaYki9Ls/Tsr1ZKtBaDBuPJQHTomXe/tbs+SdTjSY6
	YWMX5hFn3M4UtSCB0DLXLyGQfG2HO/OmDHmKkBxF4Uw/d9qmChJSbTGQMcgSJWCWx90xxWp0HXv
	DZ/NAEMklcJAmBNNfWwMUCYaWn1HEZS0=
X-Gm-Gg: AYBFou3HraE1MPo961hpHGCaeZzdkcJ0D50FYrzIPmdcZDuZeoTVxTUMRNvAcDVjK0C
	2Ftl76HSLQDNfTIYWIUvMTMaPM8GdIvUfa99kwB7rchpUxx/Q5dMZstnNAvxd/mnf0MJ3fH45O2
	jRfBI8qjDi/p9TBIxZPz2KkLclHRrxxGeqqj3x9jiCkQsof5FymOk0iPiLj3vlJYZBZjrYkb2Gt
	8Cwt5/rqVDpoaz2oFFFScfTv0X3mHKAcnnD495tAfvAHGgXvUxMlmR2tY/PC2RU3XFo9n2sB40Y
	890z8mHV6kSJwKpP8CGN0ug2n8hyJHWMSGEVmAbj5GcQZefqUV1BxtKO
X-Received: by 2002:a05:6808:1511:b0:4b2:8e24:799 with SMTP id
 5614622812f47-4ca4a3edb63mr8146728b6e.17.1789661387531; Thu, 17 Sep 2026
 09:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910112027.34581-1-flyingpeng@tencent.com>
 <aqLBQ8AXe189POtS@google.com> <CABgObfY+8Z8p4DDhfs0mBAshR22j03iEF047abKTsB-aDZeb2Q@mail.gmail.com>
In-Reply-To: <CABgObfY+8Z8p4DDhfs0mBAshR22j03iEF047abKTsB-aDZeb2Q@mail.gmail.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Fri, 18 Sep 2026 00:09:35 +0800
X-Gm-Features: AcwNN1WovPfVqvrU1FXxFIODAQBS9aPpTHbKjKF96pAYuWfJYpNUyrtlfq6CLpE
Message-ID: <CAPm50aLqEYTNNwJv6TUwpsxt9gbxjzDBvJ8sFK=4qPxYKY36xQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: Simplify backwards dirty ring batch check
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:28=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On Thu, Sep 10, 2026 at 4:40=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Sep 10, 2026, Peng Hao wrote:
> > > The backwards coalescing path shifts mask left and back right to chec=
k
> > > whether moving the batch base would discard set bits.  The shift fits=
 if
> > > the distance is no greater than the number of leading zeroes in mask.
> > >
> > > Use that directly.  Convert delta to u64 before negating it so that a
> > > positive delta, including one that wrapped to S64_MIN, is rejected by=
 the
> > > unsigned comparison without invoking signed overflow.  Use __builtin_=
clzl()
> > > to match the unsigned long type of mask on both 32-bit and 64-bit bui=
lds.
> > >
> > > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > LOL, Paolo definitely has a different sense of "simple" when it comes t=
o bitwise
> > math.
>
> I am not sure *when* I suggested that. I cannot honestly exclude it,
> for the reason you express, :) but it probably was before
> include/linux/overflow.h.  Because...
>
> > > -                             /* Backwards visit, careful about overf=
lows! */
> > > -                             if (delta > -BITS_PER_LONG && delta < 0=
 &&
> > > -                             (mask << -delta >> -delta) =3D=3D mask)=
 {
> > > +                             /* Backwards visit, but do not discard =
set bits. */
> >
> > IMO, this really needs a more verbose comment.
> >
> > > +                             if (-(u64)delta <=3D __builtin_clzl(mas=
k)) {
>
> ... I love it, but it's unreadable. The "mask << -delta >> -delta"
> basically means no overflow on shift left. So just write
>
> if (!check_shl_overflow(mask, -delta, shifted_mask)) {
>     cur_offset =3D next_offset;
>     mask =3D shifted_mask | 1;
> }
>
Yes, check_shl_overflow() expresses the intent much more clearly than
 the leading-zero calculation.

 I will use it together with an unsigned shift calculated directly from
  cur_offset and next_offset.  That also avoids evaluating -delta when
  delta is S64_MIN.

  Something along these lines:

          unsigned long shifted_mask;
          u64 shift =3D abs_diff(next_offset, cur_offset);

          if (next_offset < cur_offset &&
              !check_shl_overflow(mask, shift, &shifted_mask)) {
                  cur_offset =3D next_offset;
                  mask =3D shifted_mask | BIT(0);
                  continue;
          }

  Thanks,
  Peng
> and the clz magic, if desired, goes in include/linux/overflow.h. A lot
> more complicated now:
>
> i#define __check_shl_choose(_int, _ll)                                  \
>         __builtin_choose_expr(sizeof(_a) <=3D sizeof(unsigned int) &&    =
 \
>                               sizeof(*_d) <=3D sizeof(unsigned int),     =
 \
>                               (_int), (_ll))
>
>   #define check_shl_overflow(a, s, d) __must_check_overflow(({          \
>         typeof(a) _a =3D (a);                                            =
 \
>         typeof(s) _s =3D (s);                                            =
 \
>         typeof(d) _d =3D (d);                                            =
 \
>         unsigned int _width =3D __check_shl_choose(32, 64);              =
 \
>         unsigned int _bits =3D 8 * sizeof(*_d);                          =
 \
>         unsigned int _dst_bits =3D _bits -                               =
 \
>                                  is_signed_type(typeof(*_d));           \
>         unsigned int _adj =3D _width - _dst_bits;                        =
 \
>         unsigned int _clz =3D __check_shl_choose(                        =
 \
>                 _a ? __builtin_clz((unsigned int)_a) : 32,              \
>                 _a ? __builtin_clzll((unsigned long long)_a) : 64);     \
>         bool _overflow;                                                 \
>                                                                         \
>         BUILD_BUG_ON(is_signed_type(typeof(_a)));                       \
>         BUILD_BUG_ON(is_signed_type(typeof(*_d)) &&                     \
>                      sizeof(*_d) <=3D sizeof(_a));                       =
 \
>                                                                         \
>         _overflow =3D (sizeof(_a) > sizeof(*_d) && _clz < _adj) ||       =
 \
>                 (u64)_s >=3D min_t(u64, _bits, _clz - _adj + 1);         =
 \
>         if (!_overflow)                                                 \
>                 *_d =3D (typeof(*_d))_a << _s;                           =
 \
>         _overflow;                                                      \
>   }))
>
> (The BUILD_BUG_ON would be more restrictive than the current
> implementation, but IMO would be a good idea anyway to avoid having to
> think about sign extensions).
>
> So yeah, I think I must pass on the opportunity and leave the current cod=
e...
>
> Paolo
>
