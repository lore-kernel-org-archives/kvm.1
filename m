Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0747886E
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263063; cv=pass; b=tPynMiYebWbv+/KNoRdHhuw5bJhT+2Xhi5XegLd0Dwp3yeRB5H6mQUW2vO2gEOEiLxooiWw6+Jx1F4UU2KnD+Yzml3XKHJa+ALEXATEMQOHv/ZlSkF6VoQ9uKYIxu74+7iUsg+aF6dGm1o/niqYY0pgEj7c4+L1tlyRhSdSjqKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263063; c=relaxed/simple;
	bh=hiI4wPptPBBH2tS2eN5fMYRAqM6mpI9nbrlZA5EyOCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghYTtPkf80rPi4w4vf3PE1kz9BdXRFIV8huWLwFzOXxdWdiyJH2CaZq5nI1BwHYlP8U8IUSk+4W3+pjROhZksJsEb/dAyeyJL86dJbcuVSrWG3bxfULIQlxlUqhCuvIS/n2EPRiHldzn6z9kBUf6vJJMRLtfrKRCC46zyc6rq64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UGZQIoDW; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UGZQIoDW"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a05d236f53so1183631137.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 08:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790263061; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5bja0HLyGxGyjxoHIEYCiizyACsIFCw1ePkwRcMy6t1t7WjL73tU7c2TATiadKIft
         clizONcJdoBpkXUeLsniwE7ZmTNrrZy6zj8f5G3BjAS2IUl1vDn5sk7B4pJpN52dyl6w
         QKRJT5t8cX9m6gj2WFp8Qv3+cgMHWv0mHgVjrCIyGLidtG63MkJFkyE0x7eZsFWiUJ1n
         F9d2dedYhgQZwB9kuMCssd+l7yhKYWt2nHc+PtKIwRA4Ah1IqmZBEBTuJigiTTxTXS6q
         8+KfNAs6ibt20UxMWijP4sj0y3gQrrZRsHMQLRkuJIv3KcQ29hZQikgoAPRk67BvmhDE
         g9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UE3cBa1+vr7EU9XIxm+/iuwlg1RMwni+/YQSFj2++uw=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=npQ/v4RyJL2R876n9rGHEkmUuCgP77yvfpja/Isjj7dCwp7qZxGOSHYe0RDGTA5L6L
         5j48LpWUBzpUuCyrl2Rx0oz7XPj4060glMlPYdwciLbxd1fm/waG80UpNA6iPAONmPtn
         RZ3JDYCju4djJf19Qct7HgVbKZyzaiExeyiLU2Ou6+i6cgy73nTy/K+TBroHg3/ltQsu
         eghqbteYpO4fQKjIMXmg8OmdwPau4fPyekdJ9IUtRC2JinSsgJRwvKDQn9PUqHxP9udK
         2LN01Rc78iYGFrjlxKDyFOgs0T25z4sFyU9ciDm8vgKAHREs64CazRAmrdu70yksBywk
         vG2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790263061; x=1790867861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UE3cBa1+vr7EU9XIxm+/iuwlg1RMwni+/YQSFj2++uw=;
        b=UGZQIoDWWXy7WI4922fWj3/Gka3MRQ4MrIJ/D3zBg2OtpYqp5lG/mNiJPoW9pYT0TG
         PhQ8EH2AKLuNeodjFXwnmufj3xgcnYozarUFUMskJRy7npznO0U61YJGmlNS8daROGpd
         mOC2IoUuCDulDkEf937Ks8HacHn+EovNhi56RwQNWLijuEkMbF9OqilylGXxEbJsjN4w
         FhHqaT4jMHeT7aBrorXS7UDvqevXucN6xhcNHmgmrZzjeo2og9y13CbzLaUhxoFTJTTz
         ODjLvFZK3i2JGPls90lwfkjRQFoW5wcxAm3hFrdHUBUZ+lIlIzo6Y1zQ84chKJttzS9k
         y3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263061; x=1790867861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE3cBa1+vr7EU9XIxm+/iuwlg1RMwni+/YQSFj2++uw=;
        b=006r5+LntUUBke6VPN4JyApd7GAw6kl0qusubzIZ5KXONihOhxuZSdjTVKVXHs5KjA
         c55BHD7sjdumcM2b0yOfcaJpy2zJi6dr+wTqtM9LCcZI4JtpGy7FJ0goUWIUqrEWRjnX
         T6mOl643HYjtNcR9oMUCj285sUedSDdkRoxGJD+2UvUD0iYfKpeBvdYBsN+goR+Q3McA
         A4R2L/NJS1BsYck+otiMHV9/7f2XPY20eqH2eMaXlirqjOBUs5IUvRGFwLZYSj76Rmud
         VGfKg8+P3A9HJJNyGmOTNQoDbQwoafFF/eJYOaYNS81ewsJBsS84oBjK7mUyVZpjt7yw
         W9Fw==
X-Gm-Message-State: AFuF++lq0sKGml5Jr9CeqsgQ3qJ+eAIu4XlfZTTfuh/UZiAZMtDquf08
	aJc/PdsAvl1K1kef5saK4sSsY5kdPs4Q822/y1N2QapWl6/invVoji4r1ii4MJ6+k0EiZtOmS4M
	2Rl5ZWuaT0B/m5Wugm/pDsPNaaglM08aKBfdujmoqpNT/tJQddnXp+MEJhsXDRbE=
X-Gm-Gg: AYBFou2spWbeFlGYWCu+QkyVxzHnYL04Avspi+9L/xyMNGTKZ4WZGzoTkLyjbDFy4bf
	YzcQnY2mMzdHSkVBhzXTTlQ/a0EWbFOqnxWu4EKLGHIzyhQXQ5hiTCRbkW7mZr3FH+vSXdEnhYY
	V/ia7UehTyuaQ13vQVm7Sm5ORR5jGIqCgWMqN/iXQGYf0uU3If4+WY1hI0tbYr4AEqi78FZs+R+
	hZUPPL4xxwrvHNHhXlIRoGpqzBXGvhoYT+3rqnHICZMIWRHaHQZjrpkPeF3oJuQznxz4BjLAiGm
	ZvragCcApjljxUoSBRkVdcT/8OrKxMIOTWZsp3i2+tLWe1uOgknteQ/KOc0=
X-Received: by 2002:a05:6102:4412:b0:7a7:19aa:8a85 with SMTP id
 ada2fe7eead31-7af1eff69c0mr1510034137.32.1790263060699; Thu, 24 Sep 2026
 08:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924-kvm_fix_cbosize-v1-1-e57eec1b19cb@sifive.com> <20260924081658.53E8D1F000FF@smtp.kernel.org>
In-Reply-To: <20260924081658.53E8D1F000FF@smtp.kernel.org>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 24 Sep 2026 23:17:28 +0800
X-Gm-Features: AclHuK-8j0dV0FO6QI9Svv6Ns5n2LERm2Yo_GuvsvIQGRjQMmzoEaIAWt4LBROk
Message-ID: <CAMWQL2ggXYh+x__4GLZys22nN7FTo10euK22c7ZAVG5Gv0oWLw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: fix the Zicbo[m|z|p] block sizes in GET_ONE_REG
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

oh I misunderstood the kvm_riscv_isa_check_host(...), please ignore this pa=
tch.


On Thu, Sep 24, 2026 at 4:16=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] kvm: riscv: reversed logic in GET_ONE_REG for Zicbo block sizes
> --
>
> commit 66e4542b7a02ac3b1e7a491baa6d04283e1ccc3a
> Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>
> RISC-V: KVM: fix the Zicbo[m|z|p] block sizes in GET_ONE_REG
>
> This commit modifies the ternary operator logic used to determine the Zic=
bo
> block sizes reported to KVM userspace via GET_ONE_REG. It changes the
> previous behavior to return the block size or 0 based on host extension
> support.
>
> > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.=
c
> > index 877ba823fc747..f2b1255694491 100644
> > --- a/arch/riscv/kvm/vcpu_onereg.c
> > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > @@ -50,13 +50,13 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm=
_vcpu *vcpu,
> >               reg_val =3D vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
> >               break;
> >       case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> > -             reg_val =3D (kvm_riscv_isa_check_host(ZICBOM)) ? 0 : risc=
v_cbom_block_size;
> > +             reg_val =3D (kvm_riscv_isa_check_host(ZICBOM)) ? riscv_cb=
om_block_size : 0;
>
> [Severity: High]
> Does this change reverse the intended logic and cause a regression in the=
 KVM
> userspace ABI?
>
> Looking at kvm_riscv_vcpu_get_reg_config() in arch/riscv/kvm/vcpu_onereg.=
c,
> kvm_riscv_isa_check_host() returns 0 on success (supported) and -ENOENT o=
n
> failure.
>
> Because 0 evaluates to false in C, the updated ternary operator returns 0
> when the extension is supported, and the block size when unsupported (-EN=
OENT
> evaluates to true).
>
> This causes KVM userspace to receive a 0 block size for supported extensi=
ons,
> which can prevent VMs from starting or cause guest crashes when performin=
g
> cache operations.
>
> >               break;
> >       case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> > -             reg_val =3D (kvm_riscv_isa_check_host(ZICBOZ)) ? 0 : risc=
v_cboz_block_size;
> > +             reg_val =3D (kvm_riscv_isa_check_host(ZICBOZ)) ? riscv_cb=
oz_block_size : 0;
>
> [Severity: High]
> Is this subject to the same logic reversal as above?
>
> In kvm_riscv_vcpu_get_reg_config(), the ternary operator for the ZICBOZ
> extension similarly returns 0 when the host extension is supported.
>
> >               break;
> >       case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
> > -             reg_val =3D (kvm_riscv_isa_check_host(ZICBOP)) ? 0 : risc=
v_cbop_block_size;
> > +             reg_val =3D (kvm_riscv_isa_check_host(ZICBOP)) ? riscv_cb=
op_block_size : 0;
>
> [Severity: High]
> Does this also share the same logic reversal?
>
> For the ZICBOP extension in kvm_riscv_vcpu_get_reg_config(), the ternary
> operator evaluates to 0 when the host supports the extension.
>
> >               break;
> >       case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> >               reg_val =3D vcpu->arch.mvendorid;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-kvm_fix_=
cbosize-v1-1-e57eec1b19cb@sifive.com?part=3D1
