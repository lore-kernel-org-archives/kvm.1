Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C703B14D9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251385; cv=none; b=ZY1qE7JbLjUj8BCdStWZVMBfidK2NXrduSgAzKoQipLFgWkghQuoi7uRD+7S3b1KX3b4nO/nHAXfMXu7AB6HlalyAnJhtWpJWi2PTLP7jkpQvN7HinkZKEucY1Q4EcMTSbP4U3EOiSgXH35zPfdUUAdt8u9ajOkXCjtnWgskdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251385; c=relaxed/simple;
	bh=JPf8Yzx59d1DEmKRLKS91lhQweNKyX6BAf8TdPXK1iE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hw30QF+9tLtD0UCgRRBJsB8FBjnX1H52U4G7RWx4T9yGdAJfFpq+sUFEPTylupM/kPKMdvo/VPseY/f0msqNjxLeuiuvW/rIBbCfy+DQ2HM0es04OHm08/ZgCtqAvRN7M9KHfI6yLMnPLdK/+jKil8BhFmjPq8xrMJgEl1ZInDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2otCrSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2otCrSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31FD1F000E9;
	Tue, 28 Jul 2026 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251383;
	bh=eJZHx+hZv4G9UTJKNYmSoje+JTs7AytE4pmPOMbK9vY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l2otCrSJtG+lQQteJbKskQKtvjd4ji+F5lRsa/u1bh6/203i38kyMejueVbUryI0i
	 eyDIk51Iwwy1O8si2A77Bw85q3XXTk1TXIZxS25oZvPEqUnM/KKXSFvGn4Y+8g3czE
	 V/46WPCOgGwaMEMhZn+CKLsTCQqDvRSngvRV+0eBgvhm5GsWGOogBizmWWXlykXYjX
	 W9gPRJtfuokWiMRq8VO882bgTW6SvP5b/yGqqH0nNIzzHffXDnBr1OM+gmRxbcjppQ
	 mA4vJLbLtcykBC4oyXGpC4ewi3xLmqEx199MWV5xy0qyiq3hvD05DiCpxD1gJUYVzz
	 r7HKsksdey0NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/36] KVM: x86: Kill last_tsc_{nsec,write,offset}
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-16-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:09:43 +0000
Message-Id: <20260728150943.A31FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The S4 backward-TSC adjustment corrupts KVM's master TSC synchroni=
zation variables by applying mathematically flawed adjustments, breaking TS=
C synchronization for vCPUs created after an S4 resume.
--

--- Patch [15]: [PATCH v7 15/36] KVM: x86: Kill last_tsc_{nsec,write,offset=
} fields ---
commit fe7a0a3f31b36e1ed842426f2ccc55e88a7c3fe0
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Kill last_tsc_{nsec,write,offset} fields

This commit removes the redundant last_tsc_* fields in favor of using the
cur_tsc_* fields as the single source of truth for TSC generation state. It
also updates the S4 backwards-TSC adjustment to apply the TSC delta to the
cur_tsc_* tracking variables so future vCPUs synchronize correctly.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -9778,13 +9774,18 @@ int kvm_arch_enable_virtualization_cpu(void)
>  			}
> =20
>  			/*
> -			 * We have to disable TSC offset matching.. if you were
> -			 * booting a VM while issuing an S4 host suspend....
> -			 * you may have some problem.  Solving this issue is
> -			 * left as an exercise to the reader.
> +			 * Adjust the TSC matching reference by the same
> +			 * delta applied to each vCPU's offset, so that
> +			 * future KVM_SET_TSC / vCPU creation still matches
> +			 * correctly against the adjusted TSC timeline.
> +			 * Scale from host to guest TSC rate.
>  			 */
> -			kvm->arch.last_tsc_nsec =3D 0;
> -			kvm->arch.last_tsc_write =3D 0;
> +			raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> +			kvm->arch.cur_tsc_write -=3D
> +				kvm_scale_tsc(delta_cyc,
> +					      kvm->arch.cur_tsc_scaling_ratio);
> +			kvm->arch.cur_tsc_offset +=3D delta_cyc;

[Severity: High]
Is delta_cyc correctly scaled here before being added to cur_tsc_offset?=20

delta_cyc represents host cycles, but it is being added directly to=20
cur_tsc_offset. If the guest has a different TSC scaling ratio, could addin=
g=20
unscaled host cycles to the offset cause desynchronization for newly=20
hotplugged vCPUs?

Additionally, does subtracting the scaled delta_cyc from cur_tsc_write shif=
t=20
the guest TSC reference too far backwards? delta_cyc in this context=20
represents the host's entire pre-suspend uptime. Because elapsed time relie=
s=20
on CLOCK_MONOTONIC_RAW (which pauses during suspend, preserving time=20
continuity), subtracting the entire pre-suspend uptime might artificially=20
shift the reference and break the 1-second synchronization window for vCPUs=
=20
created after the S4 resume.

> +			raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
>  		}
> =20
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D15
