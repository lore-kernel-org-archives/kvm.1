Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A52741B5
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933964; cv=pass; b=OHoW+7TcTWTdxpAzExoI69zaPqz4FhYhF3lqIUHojgTRvIfQ3sKxBMVuxLnJST+vHrOS6onj4tqSEwQi2Ko7g+0aSO/VwRBstGD+Rj9nHcwjyoz2WJ1/gvFY/zA15XzFfeD+cXPcJbsKT4+SqkRE+7/JBFXARV+6wWMjRLhaS4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933964; c=relaxed/simple;
	bh=TQFwr6Isdsk7wyDQLf0T/awtPOFlAVrDXC7LAOIHt5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFW+bX6pdGdTj+NgquKVUcvK4MPdWclIWuqZzHVg+dDD5kPQO/ZH8E9c8bu4ePiptPB//VHGWx34F7g9o4ogaGtBYWExqq7F6TMtx2gW7sV0oIfBq/dPGMqi+l6/+v4bzKDyOKsNVnlSyap9Wd9LwXIaLyCQ1DGgZyMZ56btZPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8cIR7jl; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8cIR7jl"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6606d5900dbso1425019d50.2
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 08:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933962; cv=none;
        d=google.com; s=arc-20240605;
        b=NM4OvvS8j6OEEKXRM5Um6d1B3yyWT34mYwUaxRxWkLrhNu5I29VCPwHi3tuez33IIf
         EAZ1c+nHONdDvH4ulcQhZqcN/k/ld5JXg6sEZKUMOsLZ4HYS01qodsp+AVZdsvSBUE27
         oVA8LaRHtD4Hkeez0iJdJQ1aHDstbWthu5nbr9UJxcXeXk3dOzaRuS3/pPPC1eMNxqmZ
         EgW2fvA0bXjitsXo+o+7WrIR9jr5JLy6gcm2rEIotG5a3lDPc3H5qFU2G1ZCJ1AXJSon
         J25LhR1Uq8dX/m79Jb6Orkk36kNHnLz+cEBq//YkdQCVYAPOVBb9HJVa/ciFQ+3HG1rJ
         Uh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2A/ODXUqcCzumdmhUofAw2RO0jI4B/EtNgbML1DrBSw=;
        fh=S7ICP7MgCpdREzsYxL5mArEnzEQ9Z6vuf4mokmDnDdY=;
        b=U7po4n9io5/0VuvcpiseUlC4QrhRRvegZ3XlQkLA6quAa+XPW03PvLf4634YIn3zUY
         UXcGSY1eKgeSoS9tncSOqQms2Jvt86wWga8m5PAC/73M77FUYgCE5FIGekPcAmK60JsK
         f8n/2KvgnMuezgBXeaPB8QPtK490iqunSfsmJPWR2DwRIJI1CBaL7Lo/TSL5/23gv6yo
         d1cLJSMDDN83L52Gq5W6ebP8z+3pdACRHlOhzoZ5Idq+LxBnbr5Fe/t0xGwzKITFsCuq
         5HMeZrxGwi/W3M52Y5XZ/VUMzO6fdNU4nomZRHuGzFBPecFVlUEIw5ubUlLJCS7/r8Qk
         S01w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780933962; x=1781538762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A/ODXUqcCzumdmhUofAw2RO0jI4B/EtNgbML1DrBSw=;
        b=h8cIR7jl0vIIQM3HytCXFT38sRkJmua0M0dkFriV6xfsgbaxSdtUvQXX/cJ1WJO+/0
         AYjnbEZN1/op1MwZAORit1mqnsc0IVrvLyrpRvifbzFCKold/1PIefuVitFR7nrttkSK
         DFVlyTY2krhtql4EiLyOhCulXMpA/zpMvmtoe++r+Z3k2X5alHvIdNWJikRmnxBFD+lU
         EvZkZf7qfHiAP+em+0IjLfcbAGnLIZR8DlbuSBINBalBZPM+aidmbBGZm4nlScGE6w7r
         oYOZr2mn9didAkotKFAmjErMaBBkeOogItZe/s+hy+pl4LDCHe6CbyxHLCgUlL7OWKZN
         BH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933962; x=1781538762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2A/ODXUqcCzumdmhUofAw2RO0jI4B/EtNgbML1DrBSw=;
        b=V/xFDccpaG0jT/B4mzxBr7AH3M4E1nJSn1GkRL6QaM+RmgJLJVeGH2BFez1peFi8C3
         7gTGfujeY+DEhttnWK5NDyRi85gZSndocGl3z7oR1aWVWUBWn6W2HAd4tcS8ozbCTd3n
         9cDeHFxf0FpMCfsNi1o3YzbHW4m1L94tU+ghTJpXIGlbp1zd1rKjLqW8ItribMOIbfJq
         mMI+L7KpMOAqC3V1XRRa731JNuKjhqzjJDPHZLCnYgZKi3Hm0w/4jZYe+AdZGSq06fkG
         hB3q4NJlCOR3wRp/P7rgtBmada1jwvQgXmvzN8BU2D/S/APFo6Vh7IqGS3krlTCW8O4c
         sRlw==
X-Forwarded-Encrypted: i=1; AFNElJ8IiqbpLCv+gs8Ga1P/FA7y+8ORDsfLHzJFlruB0Q8iaN5DC2l2Y1nUQoXKZoO2UrjX9T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XxoiA5Kzm/U+6MrXS39Wlyb/hhiidT1xyh/QMe3l/K/Wwl8I
	0tdSuyGbnQzbsbkZRcrzVIhSi/ypd5XEHELuSSiBjnMuWL/eQlmNJZpyJ4NdsZN/R9uA/NphJ1k
	P7RftL7160LJPZ75HXUWkTldYOERLXe9R31QXcYlrDg==
X-Gm-Gg: Acq92OEIqUhWFx2zUGjlqhafz9n8Jffp0VPQy7RvVrsmODFPQcVbtUy8FYQe2dGPAt5
	c/M4DZGu5i7iOAIaUXq9vvvQgp/JMlUjGGigVXRTcd6j/ClVevseiGvmgYhwLF7CFdEa8mYAlbu
	Bx1cWMJwu4JrhNxhSSe3bGT1V3ik6pomU30bocTuwTfuaSfUzR5mup3sZdbBY7CagWUvY5NcqvE
	4VnqoV8ePNAMrVCMX18sw5usA2VMlkKu+v3RyRsGbxEiNzXuQedjCLkW6ypatQ8kgBTjtS76bdr
	HHXrWB6OirfJGf1S/9rk8/Hr2EonjYBu7Tt7+OXeli/WrHU1KyaRX3uVJx5g/lKOoLJD2sY5vGc
	qGIDifVd+jU2z
X-Received: by 2002:a05:690e:484c:b0:660:eff6:fe03 with SMTP id
 956f58d0204a3-66106dea10dmr9651452d50.9.1780933961913; Mon, 08 Jun 2026
 08:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org> <20260529082948.363931-6-alex.bennee@linaro.org>
In-Reply-To: <20260529082948.363931-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:52:29 +0100
X-Gm-Features: AVVi8CcfaFhhN8VRcMbz6ELw1ChZd3Iu7P5Ocma_mwVS19e4rwVGcVZwIp4S5Dg
Message-ID: <CAFEAcA-cHPNPbWopCy0jrRZmMnMNp7g+oy_m5OjNFiShQbAhDQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] target/arm: implements SEV/SEVL for all modes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Remove the restrictions that make this a M-profile only operation and
> enable the instructions for all Arm profiles.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - fix alignment in a32.decode
>   - set bool directly, defend with QEMU_BUILD_BUG_ON
>   - s/instructions/profiles/
>   - share get_event_reg between translate/translate-a64

> diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
> index f2ca4809495..547aa2b1490 100644
> --- a/target/arm/tcg/a32.decode
> +++ b/target/arm/tcg/a32.decode
> @@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 .=
...      @rd0mn
>        WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
>        WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
>
> -      # TODO: Implement SEV, SEVL; may help SMP performance.
> -      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
> -      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
> +      SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
> +      SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
>
>        ESB        ---- 0011 0010 0000 1111 ---- 0001 0000
>      ]

> diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
> index 778fbf16275..9a8f89538ac 100644
> --- a/target/arm/tcg/t16.decode
> +++ b/target/arm/tcg/t16.decode
> @@ -228,10 +228,8 @@ REVSH           1011 1010 11 ... ...            @rdm
>      WFE         1011 1111 0010 0000
>      WFI         1011 1111 0011 0000
>
> -    # M-profile SEV is implemented.
> -    # TODO: Implement SEV for other profiles, and SEVL for all profiles;=
 may help SMP performance.
>      SEV         1011 1111 0100 0000
> -    # SEVL      1011 1111 0101 0000
> +    SEVL        1011 1111 0101 0000
>      # The canonical nop has the second nibble as 0000, but the whole of =
the
>      # rest of the space is a reserved hint, behaves as nop.
> diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
> index 49b8d0037ec..8ae277fe112 100644
> --- a/target/arm/tcg/t32.decode
> +++ b/target/arm/tcg/t32.decode
> @@ -369,10 +369,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 =
....      @rdm
>          WFE      1111 0011 1010 1111 1000 0000 0000 0010
>          WFI      1111 0011 1010 1111 1000 0000 0000 0011
>
> -        # M-profile SEV is implemented.
> -        # TODO: Implement SEV for other profiles, and SEVL for all profi=
les; may help SMP performance.
>          SEV      1111 0011 1010 1111 1000 0000 0000 0100
> -        # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
> +        SEVL     1111 0011 1010 1111 1000 0000 0000 0101
>          ESB      1111 0011 1010 1111 1000 0000 0001 0000
>        ]

> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index c744b163453..e1e5539f571 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3246,17 +3246,20 @@ static bool trans_YIELD(DisasContext *s, arg_YIEL=
D *a)
>  static bool trans_SEV(DisasContext *s, arg_SEV *a)
>  {
>      /*
> -     * Currently SEV is a NOP for non-M-profile and in user-mode emulati=
on.
> -     * For system-mode M-profile, it sets the event register.
> +     * SEV is a NOP for user-mode emulation.
>       */
>  #ifndef CONFIG_USER_ONLY
> -    if (arm_dc_feature(s, ARM_FEATURE_M)) {
> -        gen_helper_sev(tcg_env);
> -    }
> +    gen_helper_sev(tcg_env);
>  #endif

The AArch32 SEV encodings are only SEV for M-profile and for
Armv7A and above -- for v6T2 and earlier they are NOP hints.
We need a feature-check here.

>      return true;
>  }
>
> +static bool trans_SEVL(DisasContext *s, arg_SEV *a)
> +{
> +    gen_event_reg();
> +    return true;

The SEVL encodings only exist for v8A -- they are unallocated
must-NOP hints for M-profile and v7A and earlier. We need a
feature-check here.

> +}
> +
>  static bool trans_WFE(DisasContext *s, arg_WFE *a)

thanks
-- PMM
