Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7C36729A
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548256; cv=pass; b=k4a49TrIvD7wX2UkPe/XEKK2EmElKLlx4X+T50ZrcP+BENunjzxm4XHvIiCHQfzr0bFxDC5oDaeHKx/wSZIoHCXyse85EEY9QKJYqfxppgY4x9AX1jEoRDSDzjV9hLjdQr49+cw6IVjyF+gNPOHlbBjtrnn6UozmAnvfWRCFChY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548256; c=relaxed/simple;
	bh=SGy3J0ozgdMuRs5pQ4Nu5NhK4cKeYVbl3Kd6W+G+Fk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlLMQme5oWIQOac+LSnEvp7Z9lJAUO8nhP8C09uirzaefYTMVO657I9Unfbmnc/QMPhDnYPSUYY5756vnXJyDD7Yqc8o3KMtShp8qd4uIGk+VcqR/HyqvURzNBYH58CU8Wgzmp5y/1Bcsrsa87khNM4prWs7hFfUgDGybSmq8fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqWJDbBM; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqWJDbBM"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso1705a12.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781548253; cv=none;
        d=google.com; s=arc-20240605;
        b=k4chYHt6X61HmKyfpqHDNlQ4M1yVxkz10sFuKIWOaGPykkerZ83wr63KwD46OPEPws
         5kUWDtHTqhEQEDleeQ6CdV4i2ooqtDm6U3ljJc0iuDXDrzGO301Wql1vG1qoZ92Xjecm
         lK+hHMuCjJkisqpHXnk2vq3uOTaOezRpkkNjUVDu4M/VRJsGxZzRg/mBqu/8Adut9aHE
         fueoSiF65IkUkQRpkA3HoYqZxKbS9NXuj7vZppkyTGDah4Vvq6+1JYOuwLi1oRoZ/vyU
         fvHmM0QfKPM4Z7DjKmkvf0kj3zh48Cl+7srsOBT6L4zJHD+K/McnANE1IwbnD8EZgMPd
         deFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6o8Inkb8KziLvhd8Wzb7igVGiblrpi0PYark++fxhxA=;
        fh=wSy3pkdLeJpWi8kDtKBaeeyXPHEKiXtON77KR0GOs1w=;
        b=QFrIJMVElTuzNsvnHda4haiH9z81993ZssJyG5d58vRXfzyCyfsLN6NM6KmUvgg90C
         B4/+wJ7cSjD4SM1e9ddlbsMQEFW5h3I1e44AvCA5p/C9MEXgV2rDyqMrw7fbQK2EZQmz
         +5FYCHjzNrKwcLkmETjuxtfvFmNzOFWoQDJNNLiCjLMyRlsDkmBY+I8ouSlYMPvURAvy
         pMNd0Uplm23zyQ9yLvLtBYefAAbBuQ/5imCAAreuUHDFgar011MHsR1Z6pmWsyG6200l
         p9TDLwWvNSgmNJFJmUzjyiU9Npw9cXAkSj4oT1WbKyFbEj/Tl3L4D1k37o5QNMsZzi/l
         mdIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781548253; x=1782153053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o8Inkb8KziLvhd8Wzb7igVGiblrpi0PYark++fxhxA=;
        b=rqWJDbBMaxRDSt6ub0gwv7WfpFp3rcDmi8uthU8Nitlk+H/0AzmcvU13c05CJTdsfa
         d8pO/b/iPvcirgp4sKRFSK20Sy/VcU5tjUSg560G/WW1JSnYW+bcO4DVcLCbkyX2EANd
         vYgP2r8v4L/663x0sv3QwLMCbKun0+aOLD42O1GsNUETwryX81mWIdsn+NPn7ARcvBGr
         7CZABMlWwnwklWR94QiHTshXZM8Dy1ocf8KNCYnR3zvbIt8d+30bNg1km4tl5MJqGO+g
         qCDSsUyTfsjMmqz2rY3hgmNQQNfWlljmf+3cLXinVsRes4gB4tMG/ZuZ+kOYeCB3R4hG
         A7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548253; x=1782153053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6o8Inkb8KziLvhd8Wzb7igVGiblrpi0PYark++fxhxA=;
        b=IpQhpaJZexBxARdUoYguoq4LVG6ZYb0tUJQf4FBf2PtLl7d7IyvQixn8R/qwBQ5ffa
         1CBVsrUOzc/6OjL3KZ/6DnH8gNMOfb/1uT3bzP8dJDZ1GvfTvlpVn6JfytzQt/MipiaM
         H/h4VpaDHTc4m3DwFY9L+weJAvrRBfkTvpz7iOZvS1faMgRKSzepoP7S79aEHG89gLl6
         im/hoLvKdxJswW1NxCAsJ4vskGK1lyY3bZlgG3pTxNK/eo4Ly45ITE5eFrqTvVVJTugk
         tZryxu8rQkg30dUYHtzUl+hLogVPSa7Arb9TQKRwVVO+rK5XT3QCIYJzs12PcsUg3SV6
         U+ew==
X-Forwarded-Encrypted: i=1; AFNElJ8JSycZuEz0ESoCJt7wBJNrD+uWSnSzyM9wuBvMWMOvo2I4R3aT33gniCww5ngjRMOcZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Xsr0qTz4YitL9TJEFRSighSrhf+kCTrbpjRzARLqdldBUt+O
	nhMaBgwPPOecweTUTINi1Emh+e0hSoSUxYf9kG//9bUy3V8dQ9N8uo9Pt5k6fbxbfUqvEUDp1+N
	y8Ow5z+qvX44stN/wufsqkMHK//k+s41ejeVs3UgM
X-Gm-Gg: Acq92OEvNehc4RNuSRcVKMef9T4SsjwLqzWKevUKprPQQJt8knbi211dnF6jDYFZaN/
	q3YPINoMQzxb0FosppXSa8vtmg/qME/6G6orfHKI8ddHZW/cgtuWcT/kwNt6lBYMvzyTN7L5p27
	9uzvdfbbRLuFWO6nQhcBcd12oF0FHaYXXZIobL3tT4vYmh0fHTlZsbxJGz2MBF2LJzdlfiCzEk/
	3xK6S/ZLjDnRjK99YruAAZ0BfBEJbBcv4PTWcwReX3Iaq6KW75EV1UZAEvp3rMKlot2E1WGG3Wm
	M0ssFnw=
X-Received: by 2002:a05:6402:4144:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-69508634149mr8282a12.8.1781548252975; Mon, 15 Jun 2026 11:30:52
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-8-seanjc@google.com>
In-Reply-To: <20260612230113.684301-8-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 11:30:36 -0700
X-Gm-Features: AVVi8Cc5ekqDkj4eAIXH_20mRAloui5iOqdM8pY0IC6R_QliEKPkFl5lpFJHHVI
Message-ID: <CALMp9eTDfP908gH7OH8HAJKAsaixNfA5dHnPXBKFquQRFVCxFA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] KVM: x86: WARN if MOV DR emulation hits a "too
 late" #GP
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:02=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> WARN if ->set_dr() =3D> kvm_set_dr() fails when emulating a MOV DR write,
> as the emulator _must_ pre-check for #GPs in order to get the event
> priority right when emulating MOV DR for L2 on SVM (all exceptions have
> higher priority than the instruction intercept).
>
> Opportunistically update the comment as the blurb about "#UD" being
> checked is incomplete and misleading.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index b1799ed01939..e030ef9b9744 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3298,8 +3298,12 @@ static int em_dr_write(struct x86_emulate_ctxt *ct=
xt)
>         else
>                 val =3D ctxt->src.val & ~0U;
>
> -       /* #UD condition is already handled. */
> -       if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))
> +       /*
> +        * A #GP due to an illegal value should be impossible at this poi=
nt, as
> +        * such #GPs have priority over MOV DR intercepts on SVM, i.e. KV=
M must
> +        * manually check the value *before* emulating the write.
> +        */

This comment seems confusing to me. Isn't an illegal value impossible
simply because we already called check_dr_write()?

> +       if (WARN_ON_ONCE(ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val)))
>                 return emulate_gp(ctxt, 0);
>
>         /* Disable writeback. */
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
>
