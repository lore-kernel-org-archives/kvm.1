Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7089395AE2
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936586; cv=none; b=mHjdnNy6mhdTmkUo4xoMrEYnjFitoMIGbO4eb/75OMh8pZRyANd6g+KQa4zqXjLD6J3MQfQ4OXQGrW0toFIRB/CURFTNayPJrqej+hly32QTceEUfw8u+ywDDzScQ/sbrTBBx5kE8LysSrjwlZJzoFO3jnWCf42eP2dWOkp7dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936586; c=relaxed/simple;
	bh=2Qfo1mE8wNpeyfoDzEnCqeGtUr1juI8OSN/sfUaQCvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCfcn7IRgJKn0IA+U+KQw0duTzTnsGGrFjS+Tzx2W7hoDaFql7uznG0zcZTIEpm9W7ohy8LubwaU5I4T9ZZuxfewSIqc1ssG8LwpEIGwfXX1b9rpszKrW1Sa1fdat186VGUXY3LBH3czTG6E9gdg6SmpBYvRcQbqCSLuHKKxlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVKkUoRW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVKkUoRW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c987913b08so13204815ad.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936585; x=1783541385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zS9s/5w9enyucVDs4i1VhSIv4uqANToyaiocSAVztyc=;
        b=ZVKkUoRW15wwMlC38XyzrS7e8BexpI/bJtkNsN917ugZKE28u01RF52ak1BNRDc+GD
         /WibBd6nVm0ELciJSgNyRFNZxt8OCVgXEAQmjhHgbBPI7Fs9Brhi6LGPVkCs3Eb5Qc+5
         tY3JKTldJaboszJAggTm33JTJdaQZD48idNOFyfyceZLK/T5Plgf+5i125H2PmEqRsg2
         kV53W3HrBaJPqlmwntHzb96LvcGdNrkgXeK5YExzW0nvIdvrmx/SAgjPLj75YvKDHQ1M
         u6XCckoH0qUp0ohKsqd2v+YQtzwAvhIHhsX4BE2WVwBBHgNAgevVJU4R0dS2Rk/tRqCA
         hSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936585; x=1783541385;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zS9s/5w9enyucVDs4i1VhSIv4uqANToyaiocSAVztyc=;
        b=Mq+7W1iXKtgDCRA5v1+et+0Kh6DGOsgV29sV2w7ihsfJa7PKffwUR/TsBGfjoChwPR
         xU28ttI100aDIAGSuquaePTCfx9TJzSc7nBxYU2Qi3bJPCDZz7K0gO8SU1855Qkv2ASj
         6G4HiggIEt6G8gZ7z5eul9yZN/xVKlT8xV7D+nEUMnBfjOTLa22cCbmXTWP/E/T8669y
         c3pbDsuC3QF2INAF06ZGGy6Pr2qpa70XWwt6VLzvD2D75szxAk97aEoqVl2HZSCvy/C0
         yT7a5hxtnCLfA911mU3jDHmW+BEt4SE4fGi9fPASi/WIkZfQRp+H2V4IgVnfH6+ZhSO/
         XRQg==
X-Gm-Message-State: AOJu0Yyy9zQUMe4vEwx3sqrTOKtKhLWrC/9WFI5EiW2/M3Hahaa1wbB3
	D2bTwJHaR641EwBtnIasJOrHLJCkuaWo9WyaCoRf7ssc/hETgJukpnzMgXQO16EIH9oIGv1QIxb
	PwRKAUA==
X-Received: from plbmk12.prod.google.com ([2002:a17:903:2bcc:b0:2c8:219a:17e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d2:b0:2ca:b8d:e65e
 with SMTP id d9443c01a7336-2ca7e90cb3cmr33810795ad.37.1782936584763; Wed, 01
 Jul 2026 13:09:44 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:09:44 -0700
In-Reply-To: <20260701195337.2E1F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-7-seanjc@google.com>
 <20260701195337.2E1F01F000E9@smtp.kernel.org>
Message-ID: <akV0CHxODhM4Q2zv@google.com>
Subject: Re: [PATCH v5 06/51] x86/sev: Don't override CPU frequency
 calibration for SNP's Secure TSC
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The patch removes the `calibrate_cpu` override to allow the CP=
U base frequency to differ from the TSC frequency, but fails to account for=
 `determine_cpu_tsc_frequencies()` which will forcefully clobber `cpu_khz` =
if it diverges by more than 10%.
> --
>=20
> commit 6d3b9e81661ead5f25434666266aec6514dadaa8
> Author: Sean Christopherson <seanjc@google.com>
>=20
> x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC
>=20
> This commit removes the override of the kernel's CPU frequency calibratio=
n
> routine when registering SNP's Secure TSC. It aims to decouple the CPU ba=
se
> frequency from the TSC frequency, as exposing APERF/MPERF requires an
> accurate CPU frequency.
>=20
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
> > =20
> >  	snp_tsc_freq_khz =3D SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets-=
>tsc_factor);
> > =20
> > -	x86_platform.calibrate_cpu =3D securetsc_get_tsc_khz;
>=20
> [Severity: Medium]
> Will this removal be sufficient to decouple cpu_khz from tsc_khz if they
> diverge significantly?

No, but IMO it's a step in the right direction.

> Looking at determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c, ther=
e
> is a generic sanity check that enforces a 10% limit on the difference
> between the two frequencies:
>=20
> arch/x86/kernel/tsc.c:determine_cpu_tsc_frequencies() {
>     ...
>     else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
>         cpu_khz =3D tsc_khz;
>     ...
> }
>=20
> If the true host CPU frequency diverges from the guest TSC frequency by m=
ore
> than 10%, won't this logic forcefully overwrite the correct cpu_khz back =
to
> tsc_khz, unintentionally undoing the fix for the APERF/MPERF calculation?

Probably, but this series is already boiling a pretty large lake, I think t=
he
ocean can be left for a future cleanup.
