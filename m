Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A447315793
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547318; cv=pass; b=KgFUisQ0tu5m3L2eGTA+YiIq2YSHSnK+f9gjFrtF9bdRmQUXaRbOZ9kUcHBEk9na7xZiZWQuoouWs0y4Xnzj+G0/3XZYFppmV4UbHTC3dVDkH3tnGsDyPsghvKz/1OZYKQJgAg7+lMkD3m2saH5j0SLpG4UIX1m2ZmwmgVChJ3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547318; c=relaxed/simple;
	bh=PMWFd7lH3PyxlugrfH9VJU9edac4GTP1Fzq/6+S8F0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgc3zzOVFg1vDgKKsnYT2Zv/SUig8tEA/d09D0YTx4e+2xkWe4IqfApaE4FQ49SJc0BSvTK539tmWeLT17RFG0dhVJP+2QockBboILG5YmI5is4CQ/YpT4XrPIqBkBbYXz125DX2BBeIlmsRhQBq0hIeAxmVQfwyUPR/vajmIUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHqTTYLH; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHqTTYLH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765331535so39831cf.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781547314; cv=none;
        d=google.com; s=arc-20240605;
        b=aaNl2TDVaq9WZok0KEzjyArqZgiWaA32NeKkqWniA8iF67+ydaa7/Xu/Ah0ZXnFFIM
         POu44aIcoKBrbcQGRXeC2MMtsnsQ4lYUtG/FUbwBfKjKmz3gf+OsxKlnjQ/LrhBxckQw
         RL/FRyID1sSvEKGFW4md6Hi8G7mwHlBO2cf8vz1EzpgGO/BpZvlPF9rGVROJzWJH6SkX
         VqY8UU5Sg5ulhQcjlwzmmP7b1GPFoqNJSpVHDivbK+h15YgP4Z/CjIfmh5hrvMR4++Dw
         z9RzgRc4P6F5RFkoocxMSzSCHxSyH5Z1ECu+i/n6LH11nHFbc0SkD4/s7scrzD5fgm5K
         U1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K+AkmFmQVzlBcJC4LBJnW3G/SH8HLfjoJm32rEZ4r84=;
        fh=Lm4hcXrHrMzN8PXMXkmVoBmAe0n8mx5wkIzGtMgC61A=;
        b=bp/BJRjYb5qn9F98qUeXW3zuI+Ble3qHTCmBP7dBGC5VbGBY5xeeSnc2qCY5JtKMfV
         gt30tTZm+x37QP7YSE90vmZF1hN0y+3IrlECamVtCj0DMyw3rmtOkx2+68Ha1YNzNMND
         xsThlRpP4REW9jH4C7hMAg1qZmH9uFsO8uUHx5Qfz2PHwzEuDNB10MhNtHRHSzvCaF7c
         BYvN9gPxJlwQZIpZqpkPDJWhvjTcRaIjdfLKSMmkOOHDR5evGnOHMd6ectAdsN/HxV8w
         jX5MgAfUOjiSkcHXu1Zb0vXkAB2VNjlwAs71Og9zOtpINU7fRg/T5aUUwPsoLDf2gM/v
         XsGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781547314; x=1782152114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+AkmFmQVzlBcJC4LBJnW3G/SH8HLfjoJm32rEZ4r84=;
        b=qHqTTYLHJuzwS0XcmPvTaJ5M5q11Z3sxOoQpQwf0Mx/u2uLQtLefcDjPO5uMFEuhQ0
         X3RmQrmUPqaj11IsVLuUlhoDhY/rHu0wsTpDIp/1Px7L9N91n/uRO96wULmwwo9HWzr5
         uhzUGx1w/agt2sEFgSAsS+EsFA7QHjo65DqiJrGoQAwS3OrUOZtRFVSsAjmAJXHVjwc8
         S0BEEkEn3BBfzbpJkZ1oWtE+X8UtFzYlBHuOsNOZX/E5pUvAQBA6/E7RzHoWg/C/ELCZ
         Wjti6h7wn3i8YxbIVS0ejzkC2VEiFyf4tIclnS2wxEjvCQLmMibNoNp5zPlivfhfTmyV
         RsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547314; x=1782152114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+AkmFmQVzlBcJC4LBJnW3G/SH8HLfjoJm32rEZ4r84=;
        b=UhH9wYQ0e6ExdkpVXEh0xpI72Guz8NxYKErlP+Fu9ioMvH3CdtzA6hmKUVDFYknrg2
         LtpL9AIXmR4olZlIATsrR64FsEacTGJ1feDVgypNb0XbPR6erML3nHWJe1T4E9hMhI0+
         DLkmRLZEol/yDOLF6FOYkEJw6d4k7P8cvHDe7jOx/+z8JdKyAEj2qrn+jqDeKFCceq8z
         Hv9T2NAKxocZsLshJc0uz8r4NmYoy/DT3WcfmxKvH5966e597Taxlw6I3FvL1B+87gcZ
         9kLBxTfDxc2e2riEtmdohm04MRZJu6cSaH9d5tEOTgKw/Io9p6NY78NwyKsBiw2PWQzR
         jAUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9q4m/nEQBjwFrNnAb/U3XPAk1kW1fB41u6udu336aYG2xqzuE5jHj4E/qvY1UYJ42nj3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjDya8sKIIw7ujsCJCBw+mY/I2zFqqJRn1OQ5V/zgal+c+1cc
	IcWKBZCcoeKzp4MD+qwXrxsTDW4clMLtTuVbIbpUQjWVvU5w/kCHsCkVt3wmz4jSOxc0k3KrKKc
	1SoZVfejXGuHPlk8ecR9svIe3nwVAJ0YiSgt3t1kH
X-Gm-Gg: Acq92OHzvjpA7fBmYL2g/k3QvTYfYqr2B33dLY+TCZn/tlEtkumGo2yB63Vq8gjc3BI
	kaEeKJSnhAWu6sXLCMxRA+mu4TjCXoofG5Fwjzkat9LrSRcofMPi6LTUzZOEJUrNIF8eM0NWl7P
	qOISG1SFThDMxg+p1T7zxsS4u2SI5qJWzgf6VLCy71UBkasQWYs7/AWIuCN4yaj59hYtcEINvo2
	P9AfULKkdI6LM0t5LP8MjjPLuwuHvnSiZbFzCSAE4FqW1GZnkZe/DKr2srQRPUcwyzV/ANJfpBO
	DNXtDas=
X-Received: by 2002:a05:622a:4d46:b0:517:99ea:ab80 with SMTP id
 d75a77b69052e-5199045ff2dmr773251cf.26.1781547313430; Mon, 15 Jun 2026
 11:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-6-seanjc@google.com>
In-Reply-To: <20260612230113.684301-6-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 11:14:59 -0700
X-Gm-Features: AVVi8CfOazGQpt_anh0Pwk_z8Pg77bwu8D9NbVYWTID_KZksSfGksftZNvh8PV0
Message-ID: <CALMp9eTc=mUWb15J_px59=LcTEC6Q8ec2UbnkpwBoWhunaeKFw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] KVM: VMX: Prioritize DR7.GD=1 #DB over CPL>0 #GP
 on Intel
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:03=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When emulating a MOV DR on Intel with DR7.GD=3D1 at CPL>0, prioritize the=
 #DB
> due to DR7.GD over the #GP due to CPL>0, as empirical testing shows that
> Intel CPUs (Skylake, Icelake and Emerald Rapids) prioritize the DR7.GD #D=
B
> over all #GPs, whereas AMD CPUs prioritize the CPL>0 #GP (but not illegal
> value #GPs) over the #DB.

Gnarly!

> Outside of the emulator, don't bother trying to provide the "correct"
> priority based on the virtual CPU model, as it's simply impossible to do
> so without intercepting *all* MOV DR accesses, which would result in a
> massive, unacceptable performance hit.  Note, getting the priority right
> when advertising Intel on AMD would also require intercepting #GP, as SVM
> prioritizes all exceptions over the instruction intercept.

No sane person would attempt cross-vendor virtualization! :)

> Note, neither Intel's SDM nor AMD's APM says anything about the relative
> priority, hence the empirical testing.  Arguably Intel's description of
> DR7.GD:
>
>   causes a debug exception to be generated prior to any MOV instruction
>   that accesses a debug register.
>
> implies that DR7.GD has higher priority.  But that's a fairly weak argume=
nt
> as the statement would still hold true if the #GP due to CPL>0 had higher
> priority, as the #GP would prevent any access to a DR.
>
> Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr regi=
sters")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c | 7 ++++++-
>  arch/x86/kvm/vmx/vmx.c | 6 +++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 127a21eeef66..b4dc57fe0bc9 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3834,6 +3834,7 @@ static int check_cr_access(struct x86_emulate_ctxt =
*ctxt)
>
>  static int check_dr_read(struct x86_emulate_ctxt *ctxt)
>  {
> +       bool is_intel =3D ctxt->ops->guest_cpuid_is_intel_compatible(ctxt=
);

Hmmm...Have you tested VIA? Or even Hygon? How compatible is
"<vendor>_compatible"?
