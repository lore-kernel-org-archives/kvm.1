Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142741F34B
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342192; cv=none; b=pC5IPe4+rkU3SqhL+d+pwjRVhiEXE9AejrM3ixhDcuGPUSS6sUpPauaMJCiDFvfNzXfLxOnRIwCVmhsxfOFGU+Otdu/5L8eUHm5lQAWNsQwx1QFXcGBt/H6y7pbcvunp8Ba+kof0QjRb3dkk/H/0Wugj2XVkaLXBYw19ZR/K/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342192; c=relaxed/simple;
	bh=bQkuEx9Fsi8woEZZDOQJeRQHHPjSHRao6U3nQlsOc+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMc2GatvWTNjxGPb/SqFsow0P0CGa6CpK25SiHgKzyjXUXCP+h3V6L6YkyvHAWGKMrNxgKWgjAZ9OOiY6N9W0tSGVEDflCXltQ4Bf+N02xAYWHoOguCKlZEAYgxZRekVDLDbXbrHlqcQaoXxkUVEK8gWwU1gP3qG9Qa1dnbC9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SbM6RR38; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SbM6RR38"
X-Forwarded-Encrypted: i=1; AHgh+RphBfv/8ZqWUo5pi2nuNEC52inl9x77gb2/fLovpsetHzahSQwl6wvlNK3WnxtZVzH7EAs=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785342187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMLtrVM/U9qSXp5plNzWB51o+HabCaIHgg3jW0ozDVI=;
	b=SbM6RR380BVB+cN4m6swEcraZigNaK9qdXFgTsDBqg8UaFu8FL66Jl/HAe4EnHZoC2VWkX
	E1m+YneZKoWBYqd9dC/P5HHSPtn+JoxjFDyn0Z63PxRDEPDSQEISKPTjkrEHKzt/J/SbEF
	FkxKDe6b4nCh94F3wzWclg1kkxmR+iQ=
X-Gm-Message-State: AOJu0YxFmFgEJKgUBfmLT0FqnWWYypBXGuixAPqgAFFbeBBPZ9IJDxZ0
	JBGUGkKmdRxAlPI0hpm1tojSNRyH1hAgGA4+s48kQdKBgNc+SInNbaZKVq7/4ijB+YsZy35+fep
	khr2kMaSG29bLpRNRfko2ohvahqTrNNAlEatPul3t
X-Received: by 2002:ac8:7fc7:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-52b34cf718bmr2361851cf.0.1785342183266; Wed, 29 Jul 2026
 09:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
 <20260720-hybrid-v9-9-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720060101.764901F000E9@smtp.kernel.org>
In-Reply-To: <20260720060101.764901F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 17:23:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx20tDkJTZ0XhcA24YAeMh6v-vkX2UZvq4oCsk0CrdM5A@mail.gmail.com>
X-Gm-Features: AUfX_mxxDeMJ4xCCxcsT2q8AATvKiYo6RMjLeUaT7vMkk130Rzj2fLQiXM40oAA
Message-ID: <CA+EHjTx20tDkJTZ0XhcA24YAeMh6v-vkX2UZvq4oCsk0CrdM5A@mail.gmail.com>
Subject: Re: [PATCH v9 09/16] arm64: errata: Require Apple IMPDEF PMUv3 traps
 on all CPUs
To: sashiko-reviews@lists.linux.dev
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, kvm@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Jul 2026 at 07:01, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Critical] Permitting late CPUs with IMPDEF PMUv3 to boot without enabl=
ing hypervisor traps allows untrapped guest access to host PMU registers.

 The code path is real, but I don't think it's reachable on current
hardware: impdef_pmuv3_cpus lists both the P-cores and E-cores of
M1/M2.

> Pre-existing issues:
> - [High] Writes to control-plane system registers in CPU capability enabl=
e callbacks lack a mandatory `isb()` instruction.

No, exception return is a context synchronization event, which happens
before the effect is consumed.


/fuad


> --
>
> --- Patch [9]: [PATCH v9 09/16] arm64: errata: Require Apple IMPDEF PMUv3=
 traps on all CPUs ---
> commit 3e98f085c1f1b418fb0ec6e336b981ba1df07b03
> Author: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> arm64: errata: Require Apple IMPDEF PMUv3 traps on all CPUs
>
> This commit changes the ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS erratum to an
> all-early-CPU capability. It ensures the capability is only advertised if=
 all
> early CPUs match, aiming to reject late CPUs that miss the capability whi=
le
> permitting late CPUs to have it when the system does not.
>
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_err=
ata.c
> > index 1995e1198648e..a5ae628204a12 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
>
> [ ... ]
>
> > @@ -1005,7 +1005,7 @@ const struct arm64_cpu_capabilities arm64_errata[=
] =3D {
> >       {
> >               .desc =3D "Apple IMPDEF PMUv3 Traps",
> >               .capability =3D ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS,
> > -             .type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
> > +             .type =3D ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
>
> [Severity: Critical]
> By changing the capability type to ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
> does this allow a late CPU with IMPDEF PMUv3 to boot without enabling the
> hypervisor trap if the system lacks the capability system-wide?
>
> If an asymmetric system boots without the PMUv3 IMPDEF capability system-=
wide
> and a late Apple CPU with the feature is onlined, verify_local_cpu_caps()
> will permit the CPU. However, because system_has_cap is false, it skips
> caps->cpu_enable() which leaves HACR_EL2 bit 56 clear.
>
> Since KVM relies on this hardware trap to intercept these instructions an=
d
> inject an UNDEF exception, could this missing trap allow a malicious gues=
t
> scheduled on the late CPU to execute IMPDEF PMU instructions natively and
> manipulate host physical PMU state?
>
> >               .matches =3D has_impdef_pmuv3,
> >               .cpu_enable =3D cpu_enable_impdef_pmuv3_traps,
>
> [Severity: High]
> This is a pre-existing issue, but do the writes to control-plane system
> registers in capability enable callbacks require an isb() synchronization
> barrier?
>
> Currently, callbacks like cpu_enable_impdef_pmuv3_traps update SYS_HACR_E=
L2
> using sysreg_clear_set_s, and then return immediately without a trailing
> isb(). Other callbacks like cpu_enable_trap_ctr_access and
> cpu_enable_cache_maint_trap update sctlr_el1 in a similar way.
>
> Under the ARM64 subsystem rules, every write to a control-plane system
> register must be followed by an isb() as the very next instruction. Since
> sysreg_clear_set_s does not issue this barrier, returning immediately pla=
ces
> the return branch instruction against an architecturally undefined pipeli=
ne
> state. Should these callbacks issue an explicit isb() before returning?
>
> >       },
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-hybrid-v=
9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp?part=3D9
>
