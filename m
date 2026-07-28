Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DF456DEC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251482; cv=none; b=RaBayD0ugZ8HuriIQqKbj5mFl1pj6dKkj6LgRCQz2FDVkgnQpKrYr6Os6ZKoRNjQhz66ZYMJogqDBon6oPjSKbztXK6Sav4L6FnGbFns74dfI/LMJYqHSTd31i+OgbJL+g//8+2FaqXKm02NGBTlvCyIKnyQV1klCA4SI8RMPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251482; c=relaxed/simple;
	bh=T1+PrX73TNg9HjUmByDTiJTaCAW5HduspwgCBIvKxK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nkqqqj2DCJdaickgPcIpAzlHKfgPFQT3ibdGAZSzq6n2kjqDNNUDmJz8LwfW67A8M31RXxU9W7Cp9CoQbJdgnFOoBjdAIdd0308j9WGS/tdI/h/tErESdKgRhhwrSHTUhnCszBl19K6AgPEHbXPa2EuieEOmus86CoQtCSb/fQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpLJITcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpLJITcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0931F000E9;
	Tue, 28 Jul 2026 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251481;
	bh=CaeyR39zCd+YkrZCKO54kgUztoSJDMLGJk1aumbeiw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpLJITcGgTkBhmR7UCaQK85CaQL6PHF4FhffiC75/pUG50bLdW59Supr929RRyYgH
	 nvl8GgGZlftYMpg119/mX9A76Vw5uLAKf01TD90qo0pEcbTtePb8isU+H0HDrPAByN
	 CVEFylQT/KppXoHnyL9eREDYHA7dlsgowOGyhXxf+Y93IHJDb5T2MZb3UHbunFwzow
	 +/FeYVVNvtqPKDtYV1Ot8opvZF4Df20bDnt3sRVO/FXr41eUTMXBGugjxzXQv46Afh
	 VK4Zrex55QA3kIINFgv83kkSvELRb/FsCeIRoQAfl0Yeyz1Na4j25l5GT7y293uqkG
	 WgKjnFtllSmrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/36] KVM: x86: Restructure get_kvmclock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-8-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:11:20 +0000
Message-Id: <20260728151120.EC0931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of `get_cpu()` reintroduces a race condition between `rdts=
c` and `cpu_tsc_khz`, and triggers a kernel warning for preemptible `__this=
_cpu_read`.
--

--- Patch [7]: [PATCH v7 07/36] KVM: x86: Restructure get_kvmclock() ---
commit c5c131ac2510f7641714a694b1cf0192a9da9749
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Restructure get_kvmclock()

This commit wraps the use_master_clock block in an ifdef for CONFIG_X86_64
to resolve 32-bit build issues with unused variables and host_tsc_clocksour=
ce.
It also refactors the master-clock success path to use continue, allowing
the fallback computation to become the common tail.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ee115dc6df6e1..d68d00cdbea73 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1636,34 +1636,38 @@ static unsigned long get_cpu_tsc_khz(void)
>  static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
>  {
>  	struct kvm_arch *ka =3D &kvm->arch;
> -	struct pvclock_vcpu_time_info hv_clock;
>  	unsigned int seq;
> =20
>  	do {
>  		seq =3D read_seqcount_begin(&ka->pvclock_sc);
> =20
>  		data->flags =3D 0;
> -		if (ka->use_master_clock) {
>  #ifdef CONFIG_X86_64
> +		if (ka->use_master_clock) {
> +			struct pvclock_vcpu_time_info hv_clock;
>  			struct timespec64 ts;
> =20
>  			if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
>  				data->realtime =3D ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
> -				data->flags |=3D KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
> -			} else
> -#endif
> -			data->host_tsc =3D rdtsc();
> -
> -			data->flags |=3D KVM_CLOCK_TSC_STABLE;
> -			hv_clock.tsc_timestamp =3D ka->master_cycle_now;
> -			hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
> -			kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
> -					   &hv_clock.tsc_shift,
> -					   &hv_clock.tsc_to_system_mul);
> +				data->flags |=3D KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC | KVM_CLOCK=
_TSC_STABLE;
> +
> +				hv_clock.tsc_timestamp =3D ka->master_cycle_now;
> +				hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
> +				kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
> +						   &hv_clock.tsc_shift,
> +						   &hv_clock.tsc_to_system_mul);

[Severity: High]
Does this code trigger a preemptible __this_cpu_read() warning?

If the host lacks X86_FEATURE_CONSTANT_TSC, get_cpu_tsc_khz() will call
__this_cpu_read(cpu_tsc_khz). Since previous changes dropped the get_cpu()
pinning protection in get_kvmclock(), this read happens with preemption
enabled, which violates __this_cpu_read constraints and triggers the debug
warning.

Can this also result in using a mismatched TSC frequency if the thread is
preempted and migrated to a CPU with a different frequency while servicing
ioctl(KVM_GET_CLOCK)?

> +				data->clock =3D __pvclock_read_cycles(&hv_clock, data->host_tsc);
> +				continue;
> +			}
> +
> +			/*
> +			 * Clock read failed (e.g. clocksource is transitioning
> +			 * away from TSC). Fall back to the non-master-clock path
> +			 * rather than spinning.
> +			 */
>  		}
> +#endif
> +		data->clock =3D get_kvmclock_base_ns() + ka->kvmclock_offset;
>  	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D7
