Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943996;
	b=WsL7Sfb1eh/YnP94X9J7YXoHxmYQiTlFETzMFniN3jl7fh0dpCNBKNYEh5mJrAaM4jfC
	 5I77HBPb6yHym4Uk64kyR/i4nUdtWO/TmfCB8jJBufjJDnZzw/fPXOlUNanB4LS2YFvsY
	 5k71s+8SsWK2ehZC1uDEgkocmBSxLtbGEEHQVHc+vSpDTcGAFcjxDceqfXWa0bpSBvTEA
	 /rQGZjwXinVbRbMvd3LmBJL3EUEksIlEEvgcvDcjor/Ut+TFNseeeYsJO2LUWiOexWTJv
	 rTXR+e+jTaBxdUImiSzidYKrz5Kka9GYLdizwrZjBIA5JrTYhRrjxIT6gvNAQJFEdow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h95Wd8dgSYHxbfC6z+Nx/Ypr0Yw5ONkFOsz25MwqqRU=;
	b=4wPXUAIG+7ErV0P34xD5IsZP61NSINr90IBsdzjrdm5YuV3XaJc8LgBBX/HpXh0+PQ1N
	 i44dhgAKZbY5TIsb2tVCEtxgyT6dECOA+FdSKzeStcOuAudV0SaMnk5GdAx0tqveA1xj1
	 aWM3c8q0NFFJ/8CRVkpM+WV4x/t1m/NTADw0OXlmX6UdUuJ8pim5K4EkUfmnEIS7Bhj3b
	 WWZfFtT5X7JuyDIeQcNpjtty/NPh/kvkGrAYZxYCuMH2xB6wzA7FX/QaR6yudYyaxot2/
	 C09/FpG0qz6EEm8yxwpgtCsV3NExy1/uuSvMdq+NkTQEfrwEUZW/nHquRMgp7behY0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oSOafBdF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82836606D805
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82836606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oSOafBdF
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso2186a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793943995; cv=none;
        d=google.com; s=arc-20260327;
        b=cbn1wg2iwzhMtQSnBImrYB0S4serkpOPlEn9fq4xpdTU2JPue7++KqQjARQZ1XjIF3
         HuCFvYlkpWAJd8AT+AVb+ZSvnoGlwXcpJYY0Q8gzqBO2FB5zR9VOO9zih5OlOLUSN2tF
         /Cnz2nwTGLzX9m1BCfgriSYmg3nV+AriqtMDyske1erajdBxTlTl7Cca+6jE6eZJGfGE
         RlamsNh5aN40wvwkwf7TR8ayhYA++pTm+xPl9Maeth/NcXbQAUYuLFmffVp4MG1ED4WJ
         DgaM3riX6TSQVbbhQgoEFrCVljhCjekoK0cGgKefD8m4KbiaFt9oAJkr53M7RyxiXaAp
         Pb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h95Wd8dgSYHxbfC6z+Nx/Ypr0Yw5ONkFOsz25MwqqRU=;
        fh=OcmHojWZxOTjzh9bMr2h4j9u3x21IbsZIOJCXVcGYZw=;
        b=UAAbfS+GArcX2sIlcZD6Q7IDlMWii5JJRfx5rAP/B3diQY2JHvlB4+YrHwL65qSuAR
         p+OEsaQQermPXIGb5zzG51aHNOIWG5AFXIdJpta+wZmRl8M8grDBAOf7hYrowaHph0W3
         k9PouoTekx+hfAtTn0sN7PM223Xw0grs1gdbPuR3iAN6U/osvYRwTg6m270d8o9OEUnC
         4hLEjF5L0hOG8EAafYUnS9uieRBdDWIDhzkQ7UPB8t4Y3Rgr2d4/s8ujOL7zrijlwwQj
         RG1jtgcb7wgVSb2NzH8mhOlCKlKklTTinyRZaVr5czbmlYtMp96BFXyE5O0QqkJKifh7
         5QZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793943995; x=1794548795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h95Wd8dgSYHxbfC6z+Nx/Ypr0Yw5ONkFOsz25MwqqRU=;
        b=oSOafBdFlYCxZieg83Tnl7OAlhMtpFGmON/Kfb90GFk2V5J92jwS3i3zR3TyAOXnoZ
         TMIj12V7vL9ZGl1R3Jt8DSXQj7B+mp7BkqdH6OohIic/e/rhLX9flqtj4XdVzJuOLuc4
         WQCc/dQuDIQhVQYfIOGRLiQu5Orp6IJBaa4RfnqJRTcZM0JVujp7LTrZxXFxVUPmlmJc
         U6tf91WmrLGeyLmcIibR9K+X82Hh27c4RXyC4vGRe7LTarfWpy+/vxf6G9yTVUt5NV5r
         5yjY3uQ+5SrhVnIiR7NVzuwgBb4zJfow+tZvbC53R1xiwJ0gikWceHpVEpSbDMMR/hZd
         YZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793943995; x=1794548795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h95Wd8dgSYHxbfC6z+Nx/Ypr0Yw5ONkFOsz25MwqqRU=;
        b=FhlXbH/Czsb5mDIVjM0iYda8tpeHGNRN7wflmL+f6d/XnB3ujAisKtk9i574hCaU59
         rV6JgtdLT/Bp6ll3CMK/I71PMP6IX/IVFcZy8HdqK7P0cO/25H82QnK6nD78LLeGhV4p
         rrgI+ain1VuVaScExpdhm7ulPNwo8HxzKJ+a1HnzhT2eMQrzosp0IeRd6a1qDNcXYPwe
         11qG7wtGxREPcoc2EYPFgBHL70CfvHJPDV/aNnTSmhIvb2pjIqyzUE7uztNM55H8hax0
         XFuJ4b/DvX7nzi7OWcMzW0vkF6CV/OaXI1EQvbwirCddsszcJfHe6nL8bR5cy3bmNhww
         YWYA==
X-Forwarded-Encrypted: i=1; AKwUvBwbS2F+7hj54iukI7rHTMF9oqR0NKihQZT5500kPT43MFWcrTrcH+V9V2gvt8vd0P8iUiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cnlcNpKQy6bOz75vSWb/yUtrufXRsyjP341+AbvYgrjxOoHNp
	de6/9BJdUSjnJ9xdqalXAT9JUQ4ON/ukzcebp51QUPN5hO1IWfKyZiF7eVh5uP2avsZfWMXJXxt
	qUa9LGelfJ41Iq1+qq+eu9U0iY//NIw+HZAT1O9li
X-Gm-Gg: AYBFou10IPKD60OHfhpvsMIXyRy++r6lOBxWNktPqAFxjFHBK6YWnrnrN60i6y4tcWD
	BM9umPWXXXuPtBTIf7ZdlUHZsgaWOM0KSqAcgmGMAU71UZGhspUShRX0thMnKNzQfdng8q3GaKk
	5VjLCgepz3zgG3uLo9gnzz8dCv43O1I2R4HVKu4TJGlxTUsz9Z0HzsoeQq145UFCmVK8dzPr+0s
	YMpFsJ9mxDZ3hLG0/4QVxl3r8XxiEJb7xGpOFhs/2U63xZ2GjKB+xnn3zWhiy6oLXmVjIh3fvXZ
	vFoWioITpuXQ8/zXq+9gZ3DFcEKXK7wSXY1Ph2CjKEJ/AQz+C5gAHVFC02f7WNl/kS3hUPE5K20
	CrrxPsU0yO1Auxi+Afok6adI8Gqo6tXGGw9ZH5xpgah7n2Kl10iCfYTyMdJOLco6lWwmmswpQxZ
	4U1XvnAeir7QpJgNpz+N19NhXv
X-Received: by 2002:a05:6402:438c:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b6ddd37ddbmr21027a12.3.1793943994556; Thu, 05 Nov 2026
 21:46:34 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-4-chang.seok.bae@intel.com> <CALMp9eT1Wza=7s53Pu7ODcBRkYSbpv4A_y58xJNEhQeaJ6r1Rg@mail.gmail.com>
 <24be20bc-4089-4cf9-899b-8da1b2ee2825@intel.com>
In-Reply-To: <24be20bc-4089-4cf9-899b-8da1b2ee2825@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:46:21 -0800
X-Gm-Features: AclHuK86lBRoZvTHN2sTI_Cm6pPHXjUf-3uNzUP0x-2uebhLI0WlIb7-oz89UGs
Message-ID: <CALMp9eQOkFJrzN_ws-CKLj5BaDhXgLbHGDF9g6t8_gNTQvsU2A@mail.gmail.com>
Subject: Re: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:33=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> On 11/5/26 16:13, Jim Mattson wrote:
> > On Wed, Sep 30, 2026 at 4:02=E2=80=AFPM Chang S. Bae <chang.seok.bae@in=
tel.com> wrote:
> >>
> >
> >> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *bu=
f, u64 supported_xcr0)
> >> +{
> >> +       union fpregs_state *xstate =3D (union fpregs_state *)buf;
> >> +
> >> +       if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
> >> +               return 0;
> >> +
> >> +       if (!(supported_xcr0 & XFEATURE_MASK_APX))
> >> +               return -EINVAL;
> >
> > Sashiko is right that this early return leaves stale values in R16-R31 =
when
> > XSTATE_BV[19] is 0.
> >
> > In your reply to Sashiko, you wrote:
> >
> >    This matches the existing XSAVE uABI semantics. XSTATE_BV specifies
> >    which state components are being updated. If userspace wants to zero
> >    the APX state, it must include the APX bit in XSTATE_BV; omitting th=
e
> >    bit means "leave this component unchanged", just like the generic
> >    XSAVE copy path.
> >
> > That is not how XRSTOR or KVM_SET_XSAVE works. In the XSAVE architectur=
e,
> > XSTATE_BV[i] =3D 0 indicates that state component i is in its initial
> > configuration (typically zeros), not that it should be left unchanged. =
In
> > copy_uabi_to_xstate(), clearing bit i in xsave->header.xfeatures
>
> But copy_uabi_to_xstate() does not overwrite XSTATE_BV. Instead,
>
>         /*
>          * Add back in the features that came in from userspace:
>          */
>         xsave->header.xfeatures |=3D hdr.xfeatures;
>
> This means that even if userspace clears a bit, the bit in the kernel
> XSAVE buffer remains set if it was already set. Consequently, clearing
> XSTATE_BV[i] in the userspace buffer does not necessarily reset the
> state component.

Look at the lines immediately preceding the ones you quoted in
copy_uabi_to_xstate():

    /*
     * The state that came in from userspace was user-state only.
     * Mask all the user states out of 'xfeatures':
     */
    xsave->header.xfeatures &=3D XFEATURE_MASK_SUPERVISOR_ALL;

    /*
     * Add back in the features that came in from userspace:
     */
    xsave->header.xfeatures |=3D hdr.xfeatures;

All user-state bits in xsave->header.xfeatures are cleared before
hdr.xfeatures is ORed in. If userspace clears bit i for any user state
component in hdr.xfeatures, bit i in xsave->header.xfeatures is cleared,
and the component is reset to its initial state.
