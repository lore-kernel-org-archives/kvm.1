Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E723CF677
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555356; cv=pass; b=Qkz+QkJDT9cW0iYNcS3tVOblG4WZHZYWW2pYJIloEimgqHhp9pKZqDJ1iv5bDdXRVyqY4xW0PsdVdn2j41Ra1Y69FxFIbwZAEYC4SR9n8wFh/mdfDgFCws2A9VJhwg5RTVQYNJMd3WtMQuSmIOBkr/hyHCt/P5FBOhEOSSmpdZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555356; c=relaxed/simple;
	bh=H3rnulMfl3DeILYXkuBtcVo0HBpok14PmwBuns7JPa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NswTG6RlZCxK7B/FKIWE7+ZGy06z72Nd4VzYDZWuCPWnE2VUX0m2q2+ZhdXqpUvT3iTyJXT6O5Z9qLqFT1n/LzJernGfQjw1Bv5R4QHsYwiGv5mtYjizB0H4SXiq22p1i13WKol01Oi3gY/e15555QCBVtHvTDZ0GfLh/DsE+R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXlvLZ8u; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXlvLZ8u"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6f586a0d5so116064a34.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 23:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780555354; cv=none;
        d=google.com; s=arc-20240605;
        b=IvxSkbEBe105Tn/u4X53X4au+6TWYv5GjxQjmNGWdaaBfyIZZTttu1uvX/Ok/tmy6R
         K6EqNs+S3YIpJhdC+ODIXdAFzMJGaRFc50GU+n4Q5Gf9QufG8bwBdcOsanBLlBTvFnDn
         ri6ffASe2eLfbOO+ClcpfqJk5Id2XfpwwOcClwfHyJLbxgA7VKY4nbzFarr3fCEQ9M8S
         5oGKgY9wO1LMy9TJ638KhSH2A+i+MeVnU6gV0UTKGm4+5co54MdoPQ9FGP0zj1awo7aT
         FJJjHZRWEaIsgVBs0ifp7Xj9nOKj/TvAH4eJDvFPAZO9QZXDAbfY10MUWAkqxrJr3wl+
         8smw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yfZQB52noCs/9R98yvRH4ThEmgKOXXjOByci/XdGgY=;
        fh=QfcTh0wJfLHP1QZBMZRnZ/OybELer8XYHKfbofkyCNs=;
        b=OklVEbnXsOTAZS91ZgaTIXPSSA95ZCmyqkBtNNHR4YD3Q+cmra+YSW5np/SHGqUpdj
         CWAtBV8tZv82a6WGMLYfOmS3plBveemrjIFBSq9bTOhyXNrEEqVWVwDSZq5tS2nc3T97
         Cr1p5FY4R0xUUtn79350Obrb7bPIICF7FT2q42/HmjIZzdLl5PsvWg3OIQ9QEnp6QunC
         oAs8Sxfb3pHY+bOjtSfstR709yhUlvnqsFMoOf4P2OSMNjgG8ddrlQ5VDQ2U06huVufn
         C2+D62QXpKtMfWpsKxHfRXGIALSHJxSYZjWGwM1tQAc+n5MUNJBHZyW0Jbpcxv03AoeR
         bnPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780555354; x=1781160154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yfZQB52noCs/9R98yvRH4ThEmgKOXXjOByci/XdGgY=;
        b=eXlvLZ8ui7sSGYpCke06+8h1Qgai2sl90b2578fC5hDPB8AApIz1f28pGiRVKW8ve2
         Y+hCzyp5fVkaTezhoLzu9+xSSbBSxQwRX2RpabmuTcidmDEV2lSnaL1u4BS0/18IMXuh
         TUA/hMcpt4s3cua0N9JvqsB1I2v5M0+MjIYUPpzp86s0xln1PoDhZlzb6Ob2mFXekmjw
         IrSStPc9FNfd2BZN5h2vVtWf49R/q4L8vREJCnEaqxeAlb/HBB1PI8yUxGt4oxBjCQG4
         em5uwa2/smD+epUa6c+Donp0v3poyN32qDENyY+zOmrtT7FepGGOblH3C5l7FvNVfmjH
         RP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555354; x=1781160154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yfZQB52noCs/9R98yvRH4ThEmgKOXXjOByci/XdGgY=;
        b=InKJhCgJhSCMhw9AKcJAuiwoelaZUeH0+37NwNp7ip/M/olW+09NNde8I6VRKWmOfv
         fUJMwW8jNvz6PpzfoOJBvE8FI2DAoDXMkBfwCgSAjuPr/svnGZ0bz6f2WwhmhyuR/FK7
         qOQHQIlusuZ4MUudHO6Wcku7ImH9jpb6SiqrIfLssvL6CxcXjMR8cq7xr2JY5FrrPu7l
         C9cLEvxZ3UeTfIiNpIVxyMvsI43T+Voa4ygwRT9fuZN3bQLftkEys7ky8NnhgWdrAPmU
         0LNszUtNupmsysONVTGyvz3DV8j8BD2+GKVA09VgU9UciZzxSoKN6GhcTbqj3ZBWNNXH
         vUMA==
X-Gm-Message-State: AOJu0Yxh7MydcL7kGrTUJTFbzItT4kLOvPBZIsdcBYEiJkvlLXxnli+Z
	QThvZzaljlfU4jseJI4aW1TNw5Bz8vBDl6C7mBs/2nag+pw4k/iA+9nkcJjY6dcfRfign6ZZXrF
	dxoz/qCP8XaEn9ThJBdWY9XW9dkBNfps=
X-Gm-Gg: Acq92OGfJ2nHBh2dQTujL3Hk7JLLORHMcfkfwK7UfQxy3UL3gN9rCzcr8/M3RcqFB9O
	wjvkz7jB39AuDZ/5diP7/XUeIvjcdzgYmYQhrPeuXKbTrlGBvML1Er5RzFCTvXG7HDN+A6mC6tW
	Uw6LOgjhVjxu1xYKznycQZlGvMLZxT26D7jEAWFmDlzQPwrthwRVNre6KAHqYb/VbdcubbJayHW
	XW5YzCTfbZf1XFtUAypLezQ5TzsSJ66BGOErEUMxsmxr33C3cZNFeCv3tBm2kzTSYDJjSWeSSxf
	JBBRJgoQvzEzzyZX0/BvBSM=
X-Received: by 2002:a05:6820:c3cb:20b0:69e:b8:ffe8 with SMTP id
 006d021491bc7-69e480cea9amr3162580eaf.52.1780555354372; Wed, 03 Jun 2026
 23:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com> <20260602232800.768311F00893@smtp.kernel.org>
In-Reply-To: <20260602232800.768311F00893@smtp.kernel.org>
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 4 Jun 2026 14:42:22 +0800
X-Gm-Features: AVHnY4I8rB9-WPj3dLhf7Mcp5Ee0Ym_vIrvBsuBkaWpxQWp0kj0HO6TjI-qUSM0
Message-ID: <CA+Ck9FbKRM0wjJMg1fQpdwmow8cf_zTfir7V6+T=CRxU+vomdg@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] riscv: Add Zic64b to cpufeature and hwprobe
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 7:28=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> > @@ -154,6 +154,23 @@ static int riscv_ext_zicbop_validate(const struct =
riscv_isa_ext_data *data,
> >       return 0;
> >  }
> >
> > +static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_data *=
data,
> > +                                  const unsigned long *isa_bitmap)
> > +{
> > +     /*
> > +      * Zic64b mandates 64-byte naturally aligned cache blocks; cross-=
check the
> > +      * cbom/cbop/cboz block-size device-tree properties to avoid inco=
nsistency.
> > +      */
> > +     if (riscv_cbom_block_size !=3D 64 ||
> > +         riscv_cbop_block_size !=3D 64 ||
> > +         riscv_cboz_block_size !=3D 64) {
>
> [Severity: Medium]
> Will this check erroneously disable Zic64b if a platform does not impleme=
nt
> all three CBO extensions?

Zic64b is mandatory in RVA22/RVA23, which also mandate Zicbom,
Zicbop and Zicboz, so all three block sizes must be present on any Zic64b
platform.

And architecturally, all the block sizes are one quantity: under Zic64b
that value is 64, so the three must all read 64.

Anything else is a misconfigured DT, and the kernel should not trust
the zic64b it claims.

BR,
Guodong

>
> If a hardware platform implements Zic64b but omits an optional extension
> like Zicbop, the riscv,cbop-block-size property might be absent from the
> device tree, leaving riscv_cbop_block_size initialized at 0.
>
> This unconditional check evaluates 0 !=3D 64 as true, which would spuriou=
sly
> trigger this error path and disable the valid Zic64b extension.
>
> Should this validation only enforce the 64-byte size if the corresponding
> block size variable is non-zero, indicating the extension is actually pre=
sent?
>
> > +             pr_err("Zic64b detected in ISA string, disabling as the c=
ache block size is not 64 bytes\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u64=
-hwprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D8
