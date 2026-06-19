Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCE37AA8B
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875118; cv=pass; b=KHEuiT2o2phlVlWlIFiBV3enCc2ExqVRWJ6YOenoBbmjrxw5POjVsdLCqjFQT0/dbjJFjl0pAyflW6FOPNLGNvNjzCgnw6E8901IOTlpk3p/zOid+ZkL2vuUHB4SAwwL+4zpvL96SIGm8q5SRsYojj9xzm+DL72fNwVrIudbraU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875118; c=relaxed/simple;
	bh=TtTfJunX0gmDNwPXk2Buu8r54gKPY7unP7+hZJHM51s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh7iK5qYafTaqefa7lhtsJCz/3ylrVU9dX3HUz9bpmV4EvIDIZqfwJb3gwDYhdZEuFXM19XXReieNGZQfZhXigSdOCKMEYp+ppjzCdfOUm0L4S/RO01K5r7NLr8xXUdjhwUovhg3FODq2YVAD4qgXMOax74sxE70L8Y0wpeM2tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9ucpKRr; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9ucpKRr"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-660e9fef1d4so2223411d50.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875116; cv=none;
        d=google.com; s=arc-20240605;
        b=abEg5f0OepIIUhrKkmQz8kRnkTAV9hR4yr3hvdiuEgo4PfqxGgDkUJmT2ooA6rMHDj
         5tfjkNmbiU0bQMJOEz2viCYDi/KcTI0vkKNRydtc3Vcw9PGQ7M6OiAsRcnHFHtIzAOVv
         //RTEl4CAbgLLcv01fblagCQwuCF1zPN/yG6ZTvglOHEagMM18aCH8rZ8cEVJsGLM8aJ
         l/GwslVdcszUzsD8dXnOJlAAIyuRHyuhxqAJLt6G17hZeK7WSGF7XHOjEiIaNnlj8GR5
         5WEn9AHbF9afekypQfEDKQq/g86PQz+kqkOCofJFdAiN7z5Lr5cVNwL8b2vjKFSXT796
         6dvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmEY+cjbJNIBkK9rxxbzV7Ux6b6JpIZ3d2sXR3Gm4OQ=;
        fh=oGg+sDCB/2rikcsN6mEdGWd3BsWUaKRF76BVTucgdTQ=;
        b=QjWWdAjUCBJXDP3hiXVjKtNZi9eanqfPTSEC0Vm5652vVi0PJRK+p0sDJte3eDei83
         DQwpfEnsrMDrGaFX6mGoNXhCd11i2BxvYu5U61BcXFSKKR84eDT0ikxG2VoESW1Wa+k2
         saAV82uVmk3B+Arj0icPjBNsDNDNkl0XP4Qr+SCRnhKC3RKtrNr8dsc16LCScG0Vkt4X
         C4UgppLY2L+jtTxO0YKFaCGve6bf3pvnuU2kC6EKb/vZi28RnuYZrb1z17TmMvYwjfwG
         rCdtV0+b4clkQ7O7yMCEnTHr/0M6QhMVcAuWoa1cOp22ZtliNA+kZHbzknAa2Wy7OF/a
         AIWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781875116; x=1782479916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmEY+cjbJNIBkK9rxxbzV7Ux6b6JpIZ3d2sXR3Gm4OQ=;
        b=w9ucpKRrCuTqhzP5LcIe4ikuDAgZ2NmsdXMoaHNoK2WDwoAmOv/GpRcHTTB2aVRz2v
         pYSEctPQ5lOC41WK927GJIv+0AuP+zZcfZxStHG94YlLneEY8fu+EfdpWlyGRqnpkYcG
         umulPLSguAOUl15w8SkLxAMDZ2LSB+AgLcDxoG5x47Qb42l7+Ers08UcjLbL2IOkZqR5
         qVdoxaE5zaxIFENgjQcKgW5+9aSxCt0qcKvIgYqvilDH1pFdd6/dBYNsdgEiYM+0jPzf
         QsvtDlpFpaSRdfCsezKNcwiq9w1L19Pz01uchiZ/34+wuwpf4hD2T0HLX7/v47+kcK32
         Tvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875116; x=1782479916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmEY+cjbJNIBkK9rxxbzV7Ux6b6JpIZ3d2sXR3Gm4OQ=;
        b=FKb8oLTi0mMJjyjG7RD5LoqCcWZ8+ksNJTX/ZQeNGM/jDZQ7o1upiy3kxvHo16DeuH
         0IPOpJGAHjsGazsIJ7gmnnt/tG3GRk8omxsGOVg0FVAVIbPc8ClNf/9N77hXDZaXygJZ
         aLKCP2uEB3cyyOTlQm4zThj3yNDkbfUyrYUiyFSXOb0P5AR33y2WEnhhTMPhQQzMUzoe
         +fxMmxzDAW08SaFagmW4MvWDA2Di9ZjSIVEdVHVByFdzhoV/1x85BKJiKgbTWGNbOubq
         l5SHVtvqCnchj393O9lE8lCJBAKDEzCzcIxNf26bkOv0yH6yigFvHuYWW2Lvt1li8ZN3
         5Xrw==
X-Forwarded-Encrypted: i=1; AFNElJ/uI8Afwed2Vv2DWtNfXPBbzq02MWb/oG2R279hWdrs6b91h5qkdDVgSZi4HMVDHcTOyO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvlemKDI6iyiw7LW/nlLHFa9gYsWBW8Nl6SAxa++4PhjTJxTxY
	zDB8OkWOrjmh+rfmCWW/05qPDiIKslmwqZchzODuw/rOXCPihTUp8VZ41FrzqQzBBpHiL6c/qU7
	GLzTnG1Qow2IiD/Iz8zIfRswwjHFGOeHe/4kDQjzkPg==
X-Gm-Gg: AfdE7cmhBUCLhbqtWZXQPKx/HnXDdYo6K5ukpIIv85uHTIzio5IR47+TmEQe0sbJNDN
	HXzQXwlc8NllqBMhthRcgkQmaQZlOG8w5Pz+zsH84hqnZZrcZDq0LxWBP9r7g4RRx+NFoLeIp5S
	SD7HmsVfOaGZEug7S4S/LKB05RQVLtSJLmvpaLYMRE6UinhwvoKM0BapjbpmyGmwFUAY3F/Wgff
	29DBOTnNhdugTvJImeb6w9z7tcGj6lFlWP0K13ptwFbt2LBPVDYeof7h/Rm4V1Ya28D7hAszJUg
	C3qauRx+vcnq6ncn0Nfm+vqv/Y/4lPLScFba/pJUVpMR1sidSgH3InEd
X-Received: by 2002:a05:690e:11ce:b0:660:d512:46dc with SMTP id
 956f58d0204a3-662fcbb0086mr4092145d50.57.1781875115603; Fri, 19 Jun 2026
 06:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619130537.820184-1-alex.bennee@linaro.org> <20260619130537.820184-5-alex.bennee@linaro.org>
In-Reply-To: <20260619130537.820184-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:18:23 +0100
X-Gm-Features: AVVi8Cf-7SRrv9WiiLBvbBYNyVc4TY8I_uOR2bV6pZJYEsQtlTzN9wdxrxv20oA
Message-ID: <CAFEAcA8QWor1P210Td1wHeot2npzga5_XfonNMpPSZeviYCTOQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] target/arm: ensure we create the wxft_timer for
 all modes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
	Steven Lee <steven_lee@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, Troy Lee <leetroy@gmail.com>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>, kvm@vger.kernel.org, 
	Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 at 14:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We don't want to just use it for timeouts as we will calculate which
> will comes first. Remove the wxft feature test in favour of the
> broader architecture checks.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v8
>   - new commit
> ---
>  target/arm/cpu.h | 2 +-
>  target/arm/cpu.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 31a5567c951..8aa7437a397 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -966,7 +966,7 @@ struct ArchCPU {
>       * pmu_op_finish() - it does not need other handling during migratio=
n
>       */
>      QEMUTimer *pmu_timer;
> -    /* Timer used for WFxT timeouts */
> +    /* Timer used for WFxT timeouts OR event stream events */
>      QEMUTimer *wfxt_timer;
>
>      /* GPIO outputs for generic timer */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 597e0626e7f..61945b6e6cc 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2269,7 +2269,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>      }
>
>  #ifndef CONFIG_USER_ONLY
> -    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
> +    /*
> +     * We use the wfxt_timer for timeouts and event stream so we
> +     * enable from V6K up. There is no event stream on M-profile.
> +     */
> +    if (tcg_enabled() &&
> +        (arm_feature(env, ARM_FEATURE_V6K) ||
> +         arm_feature(env, ARM_FEATURE_V7) ||
> +         arm_feature(env, ARM_FEATURE_V8))) {

This code runs after arm_cpu_propagate_feature_implications()
(which happens at end of instance-init), so you can rely on
the usual "feature X implies feature Y" stuff being true, and
just check ARM_FEATURE_V6K -- that is set for anything A or R
profile that's v6k and up.

>          cpu->wfxt_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                         arm_wfxt_timer_cb, cpu);
>      }
> --
> 2.47.3

-- PMM
