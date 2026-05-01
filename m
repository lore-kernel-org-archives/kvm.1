Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB640F8DF
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653446; cv=pass; b=AzAFTYuTLdAOpiP5MYCRy7xjTnH1xi58xXz/OnBJRN9BhWv69GudvL3qhErXUE2HXkIk681JCZH7ObFvY+Pc/3jVBY8b/1IxdfCDWioufFwvcdo5NDiO/FkKLeDBmt76s9p94Z2BrBKyT5E3tLCexrBI+w4pW2LmzH7H+0UhHOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653446; c=relaxed/simple;
	bh=w9ooVH2aWTdqsPWomPiWr/2emsHoCr0nSyf2HqpKRiA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5LDnRhmR8VIrrst4puYbnDBShJF3J7TmVY7g/KiUHudeXbUYXaqb2hDeWA9Y2TAdUibn+mEE53obK4EpZC8zR6BPqOmtx8AYGSXfslf75BPN9uTc6LjNghAHnUA43R3WzxBzD8owp2oWMUP9HKaAHqEeiKkiM+SuBEClelnvSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzBpD3s8; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzBpD3s8"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-60904a76e63so1057524137.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 09:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777653431; cv=none;
        d=google.com; s=arc-20240605;
        b=Ov9gzwgARsdv1+stHk+bl2ZCkb5L1uVitJq24WnrSZT7oA/IYSeT+WlKwj2bfL3bp9
         AloDw/GVa+t4iBsXNTQYGheTmYpPWaP0CdVyS44CymXR46JvRNL5i2BwFEGMm2qs7+8P
         5uNtWhCsDSI00arXvCTKFW38F/KOu4adFCR/MHP8a073d70/Bj3h+Mu0wgDbLnQQ+s0f
         qLbkYZ/KlvT8PKW2j+0RwSB6h8g/HXg50+T1iRgSZ2ZxsEV+45dqJZlKQsTLaKZNbr0p
         IPLKFlhVEtZ2r19eqPkQL9fLlXmpaQjRXco0A1WYG1+K82u6E3eGm693x6iGo4vyLPnW
         r50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nLFs9eB4QSuzMXlNmTajx3twQGrJqXq6Mmw1sgch1Dc=;
        fh=WsvHi375ZUAC5GJL7KK0vq3DEpjFDLgcydiHJcr0ooQ=;
        b=LMalG6P8/MB0GVadv/eYe1UjoABu0o2zBxcL+cZ3hlmybo9uvlwVW7Fddois0dBymo
         YFjdAJHIRGxPq2yZyQEgTaEgyNshv9aPPcIBODTFLfOKXTBursU7Gfq4I/yNtwHhzB09
         RZbsKdfxXV9L09XGPbgUk4vTBiZMaRFzc8VSZogdFdyw4r59eFVE+mMDqGSgbb/Eq82Q
         yE5I1y+CCpw1ALUyf+HoxKHP8YtSNjnCcvGMtWvGm+C3UsRgmcez2c/KfBba0qnrcqS2
         Bpnp6ybpyzVe+AHt0rmMoxYFWwUC7mPVuDkN4g7kRiRUMBcWRIe8s017nd5ZDdLVVc83
         2oww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777653431; x=1778258231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLFs9eB4QSuzMXlNmTajx3twQGrJqXq6Mmw1sgch1Dc=;
        b=dzBpD3s8S9heQZQqYydWwH8DRb//MDRDU0VdMAX6F+suExplLhSUN7mbnfJdOr3WJ7
         V/NV8hUvklwHsI/AIRirPiMFkTQJeFehw9r+KIbn8KfgmZqzKx1uDYLe8a7cXjqjuryc
         urwhoYpx1cpmUApuOv6H6tcY6DD6+pPYZeH9iYuzMr4Ry/br34NHXIjiuPn0KYmrQxcM
         ZAgrSNqxKiuUrKxShE5+VjPMHzBSxNdxBAVAfhA+hJwoqS+1L0sgLooWgcJJBojH8fp8
         7Fg8SCh0POxu/WbFHeIg3w6/1V8eipzSsBGqGMhSeHwuypVWFMUz0VpKbdwz5aptnNB4
         s6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653431; x=1778258231;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLFs9eB4QSuzMXlNmTajx3twQGrJqXq6Mmw1sgch1Dc=;
        b=f5/LSZm4hChfAyLwc3r/QoXW+IpFe+ijZKNzSzrDEh13vwzefyDej+WyNKyZNAJi79
         yLmN9IBJ0zDCkr/0vAzZfKw/+fNAOXlN09Oe1a3PZjcyMD2Uzqq+TzLob8RKEM7OrNpJ
         XRwbVL9aUHN2uCFWxUSGQzGmbKgD/XCJqKuZ4Yy83iUMxvToRDKpwSddQjIPAcQkQuuI
         CH0YWNn8X3rBOvT9rpzQzJwGOOianOBE9xo+srkOkhqlDUwY1HMPEzVJIio//GvQ1CY4
         cMsd9jzLnARua4Yi1QAg8ejeBEWqyR9Ah5ULNPlIsVuyAJ4XEBlgd9c0M3FGoLLSsXfX
         giPg==
X-Forwarded-Encrypted: i=1; AFNElJ+sx+Wb46m1fk4HHz5gsaDyZkLYieobixXa2wk7L+2nR2YFdRMBwZGCGm7Qux+72zZUYsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgTVcEy70wlUUTbGaabzDC7KBnOGerXDkn++0B7ATfgThIod4
	gcNHmWC9g1LAfxk5V8+I0dFh2rchXQRSSHuHECFcGiNmv+cfNTo0Fv9N3QSmTyRKR9sSn7KbVRv
	ouIKE/BcgacEGxU1wuecNpDuljTCXe26M2aJmNsGm
X-Gm-Gg: AeBDiev42sa4QJzLs9X1q/mwRiBAv7FsqXvxqwhVVu6aHZMbb9UKtTmrB3uM+2ylkcM
	SCEpOqPvJWZ6fqCvaStZnuKI5rvlSDzdNtP29qv6G/teLJMqxMAsfu8gc7EX0ajIQjPk/nOt/dp
	krurRcxqdnXoAS1TrVp3qhyZuDT2nM7Om454s0M3G1vd6AfYf3yzCZqtC39lZu3V//QT+++Zsvv
	twnVPjbgsSS+PEL8YbYmVfwXPvjkHmFHbVgTlma0pgw0GfZGi8we5m7CeL2B5sXwZ5ADICK1sr1
	9sOEZ4dohGihjwCWwYAlxHZonKMhmovkuHuSh5ET0zrl9FXwjYHZ3/8ML3oVU5yztg/yR9Ic1MF
	ebD2rIc3LPTqEIMA=
X-Received: by 2002:a05:6102:598d:b0:608:ad9c:4c36 with SMTP id
 ada2fe7eead31-62ad2b40002mr5011640137.11.1777653431060; Fri, 01 May 2026
 09:37:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 09:37:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 09:37:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <77153c889934972efcfc3d210251564f29abcf51.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <77153c889934972efcfc3d210251564f29abcf51.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 09:37:10 -0700
X-Gm-Features: AVHnY4IpT6Ecp0MRFZmqXjB5U2fV7hCMXRHDBLJWh2_PysSn9Xai8a1NAPY71Vw
Message-ID: <CAEvNRgGrdA8opRuvBncgmsyzZTo6JaP+gSKuK4ioFvnZBSKjiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] x86/cpufeatures: Add X86_FEATURE_AMD_RMPOPT
 feature flag
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ashish Kalra <Ashish.Kalra@amd.com> writes:

>
> [...snip...]
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dbe104df339b..bce1b2e2a35c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -76,7 +76,7 @@
>  #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
>  #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
>  #define X86_FEATURE_ZEN6		( 3*32+ 6) /* CPU based on Zen6 microarchitecture */
> -/* Free                                 ( 3*32+ 7) */
> +#define X86_FEATURE_RMPOPT		( 3*32+ 7) /* Support for AMD RMPOPT instruction */
>  #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
>  #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
>  #define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART) */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 42c7eac0c387..7ac3818c4502 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -65,6 +65,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_RMPOPT,			CPUID_EDX,  0, 0x80000025, 0 },
>  	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
