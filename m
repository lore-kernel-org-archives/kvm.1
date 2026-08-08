Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9B339395
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206189; cv=none; b=Y3EGepjXsOWljjLt+qxCou5OyKiKE1XI2DBIzh1Is/zQ1n+Z0l02zG2VK+/aLgQPXnh4iccY4D8UcWHjaSu9DdLAibpX7EJsnndQff4NhwGhV82iySlzVU+C4czqDkY1KSNELXChjvj1WUzTpW1xvnUzqvu8GP9PdsKV3mgD21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206189; c=relaxed/simple;
	bh=ANO7FcLdQ9bMWy3dGeKvpg/c/CzcUp8EQZl7xB/Rknw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FS27s5uRetpdOLLhPcSDmU7q60sSX9zC5dk36KTmOCdQnda9CYfuikozZblIkMxsFtfjadEwXADKRObYZki4idVP1gFdWqRRv+Q9Oyy7vkqcJVCNzGdeNtdMTCIfyUXs4DN7kByYtasn8DuKkoFHvEOm4+vp9VVY6c8MqktR6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBiKRpsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBiKRpsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A4F1F000E9;
	Sat,  8 Aug 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786206188;
	bh=Xk0tdSVnKY71AvKp8gy7ehtBYgde1791IJHAVVFTZbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mBiKRpsyBirS+4M2Wf5pJ7MRAVO0j3vdF02Bdw8976+FSf4DLEIhDcE5F7ty/7VbH
	 NVZVVhyJdbO/PK+xWm9ffZ+VoyS0qkBWF5laR6XyBnVyLImD0SfKSLICshJNvTB/KY
	 +oircGgSj6S0vka2tfLyY3/oRgu4cKlMsy2hguNCKfFKk6G5Xn+l91/JxR7CVQ3O/x
	 f54Ca4bimZ/XAA2rYXk4UV0nPjuMC3y1JO3EBchynP/rOJrpQKQa1ibN7M5sEEN6eK
	 Je6Avs6pS+SbVhGikzeAeg4GR2fn+WyzAEpmP1nGFLak+bwZAscfg89HLc2j4DdMUN
	 QcFEsGzGZ5qZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260808161148.66673-2-amachhiw@linux.ibm.com>
References: <20260808161148.66673-1-amachhiw@linux.ibm.com>
 <20260808161148.66673-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 16:23:07 +0000
Message-Id: <20260808162308.59A4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature advertisement of KVM_CAP_PPC_COMPAT_CAPS causes bisectab=
ility breakages.
--

--- Patch [1]: [PATCH v9 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS a=
nd wire up ioctl ---
commit 92bc8045e2354b233ee21f84717a2a67b2fadcac
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl

This commit introduces a new capability, KVM_CAP_PPC_COMPAT_CAPS, and an
associated ioctl, KVM_PPC_GET_COMPAT_CAPS. It aims to allow userspace to
discover host processor compatibility modes for nested KVM guests.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..2fe4ea0ca4ff1 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
[ ... ]
> @@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  			}
>  		}
>  		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r =3D 0;
> +		if (hv_enabled && kvmhv_on_pseries())
> +			r =3D 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */

[Severity: High]
Will advertising this capability here break bisectability?

If userspace probes for KVM_CAP_PPC_COMPAT_CAPS, it will be reported as
supported on pSeries. However, since the backend for get_compat_caps isn't
implemented in this commit, the newly added KVM_PPC_GET_COMPAT_CAPS ioctl
will always fail:

[ ... ]

> +		/* Reserved fields must be zero */
> +		r =3D -EINVAL;
> +		if (host_caps.flags)
> +			goto out;
> +
> +		r =3D -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;

Could this unexpected -ENOTTY failure cause VM initialization in userspace
tools like QEMU to abort when checking this capability during a bisect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808161148.6667=
3-1-amachhiw@linux.ibm.com?part=3D1
