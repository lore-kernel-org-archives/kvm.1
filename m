Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D60391E4C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973812; cv=none; b=Vhjz0gvmWDC8ESG+vY6mT0HTMUoqp6aAcDQ2naa5+4pJggFQXzEHoHKWVL15Bo067eLuvQR/z4XGS/FRDWMCJzOxiyI56uRiNz26BaQrHLtAviICfFO/XX7Ka/hOgGWm1tCerRXxLfhFGPTnpy16h3GWQBCAUcAyQrplwywTPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973812; c=relaxed/simple;
	bh=nasYBxxQBhtM49uNyZJAnEEjQtOJTV+QSFfn0KkXktY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=neoQMXTegDnfL7dFMMMUEFaQTLBj0Wn6dUARISfsv+9SnptetZr2CiGSnmZjv6pRfuXFpWzut7K8S54Ld1fIM3Kdw8c+IO1kuM4FUhallQzms7YvrsFrxW4PBbXFtT38PuGpEebGeFmG2nccdY3JAPs9DCzA8vI0R/L2JP8/Vr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5gZETno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5gZETno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456D51F00A3A;
	Thu, 28 May 2026 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973811;
	bh=Nv+sSHGK/7w7XSI+xK5P8FypgRkQwDYdhRz87xwQSOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5gZETnoAneUvfiLxASjyVKfDx//yh+uBTmEuE7b9z/ZONvnHfRcESp6+cAHeMkst
	 IZ6yOr8WPFd8xtPxQkUaVZQb1gBwvnOa2jEF0ZVv7P0Q4vAML9KnDUG+iyZeoaWEep
	 JECOgbsjoqFrc82es6pufx0Ezu3ZzkKm6GAI9zbxO3xPwtakyMJaibNT+nIq2pGlH4
	 2QnxbwUE0N1ft0WkI22GsVTqlFYTLPQqieupMM7yN5zSy5EOtEyJLd4JKRqFpRuUmI
	 OIesg+zjBfHzA6Qnd0zw5VLYGIHvi3ZGlxPa18nor7quSikQuISjCHsc7w4CvVvrfd
	 wsa/OMM4NNwRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] KVM/x86: Return -errno instead of "1" for
 Hyper-V related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528111357.264809-4-jgross@suse.com>
References: <20260528111357.264809-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 13:10:10 +0000
Message-Id: <20260528131011.456D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning negative error codes (e.g., -EINVAL, -EFAULT) from MSR h=
andlers instead of 1 causes KVM to abort the VM instead of injecting an arc=
hitectural #GP exception, creating a guest-triggerable Denial of Service.
--

commit 4122a3bbc2071f6540c3f278e39fcef59eeaf6c9
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for Hyper-V related MSR emulation

This commit changes the return values for Hyper-V related MSR emulation
handlers, replacing the literal "1" with standard negative errno values
like -EINVAL and -EFAULT.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4438ecac9a89b..809752a6d0ac5 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -167,7 +167,7 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *s=
ynic, int sint,
>  	 * allow zero-initing the register from host as well.
>  	 */
>  	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host && !masked)
> -		return 1;
> +		return -EINVAL;

[Severity: High]
In KVM's x86 MSR emulation framework, doesn't returning 1 from MSR handlers
signal an emulation failure that should be handled by injecting a General
Protection Fault (#GP) into the guest?

Looking at __kvm_emulate_wrmsr(), there is a specific check for negative
return values:

    if (r < 0)
        return r;

If we return -EINVAL or -EFAULT here instead of 1, won't the negative value
propagate all the way up the call stack (e.g., through kvm_emulate_msr_write
and vcpu_run) and terminate the KVM_RUN ioctl with an error?

Since userspace VMMs typically treat unexpected negative returns from KVM_R=
UN
as fatal, could a guest OS use this to intentionally crash its own VM proce=
ss
on the host by performing a WRMSR to an unsupported MSR?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528111357.2648=
09-1-jgross@suse.com?part=3D3
