Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241833655C5
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613911; cv=none; b=F2pB+z//yzxlzrIzXXl4iI8AnbroBWCPi7OPAlE/Hbzc/PVHR5pM2X3hMmWYzEbfsqbw5zuIp7aEsilYppF41cjD54Y2WpLhDsQEz2oQvLMSYTsutsyUFLjSLjsHsyC11ywFaEKOYoN2ZEl5tvWsmOgEMbAsZzFMvANqNYZ0Lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613911; c=relaxed/simple;
	bh=/awfyQ8VzQJmI+kOgJetY5Yx15nrhvtnb021dGR9Ilc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ONXpLH68y8MPeFinSVkLSYsitk1faBDBEzWYaFy35nWmqGl39mesb3B86OgI061a0cF9yRotKJJ1PBAXLICAqZn/fzsarPkUOQEq1QX1lL53DNrACPd5R2iQF9a5W2LI/R5eh6VVvzkvhSPpddObbMg7Xtc3Pm+RnIvJwJVU1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1b2jvpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1b2jvpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF561F00A3D;
	Tue, 16 Jun 2026 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613909;
	bh=z7X3bjMutwIVR76Pban3ra1CuNP/Wo5sZhJmiSMCf2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1b2jvpaJ1Lp3ln/FnnGTdTxeHVfx4JbqdA05cCmTzz/d5qcmwIc4WE906gCubABb
	 2b7FEZbrcJWtqJ+PcepZoH2IzexJ1Ak7nvfl47QBWiDN2oE3gaTFPRg5PpnJWzDpWt
	 MR+Fjc5YfrbhqbzwVDxbZh27tso+zDMyl4nfHVctrItbddLzeXpwUgWrJt+kfgIgfd
	 YYfNK43ajUBkNdk0sE7v3Nklg/8+RBCjmC5/EOL0eD50h2SXgdryEJoT+o7c3lSG4+
	 EMVHWD4BGB98dBYerb/Ck5zmP4jXf7/RNuRzLwZ9a64PdTOENQ24a1/jjdmBwa3xYC
	 c0uvWxDzyOYAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616123314.82721-2-amachhiw@linux.ibm.com>
References: <20260616123314.82721-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 12:45:09 +0000
Message-Id: <20260616124509.ABF561F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Backward compatibility failure due to strict size check and uncond=
itional copy size.
- [High] Incorrect `_IOR` ioctl direction flag breaks UAPI extensibility an=
d tooling.
- [High] Unvalidated reserved `flags` field prevents future use as an input.
- [Medium] Capability `KVM_CAP_PPC_COMPAT_CAPS` is advertised even when the=
 backend lacks support.
--

commit c1e1544ff6eb8d147eda5713932bdc47b539c526
Author: Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl

This commit introduces a new KVM capability and ioctl to expose host CPU
compatibility modes to nested guests. It adds the KVM_CAP_PPC_COMPAT_CAPS
capability and the KVM_PPC_GET_COMPAT_CAPS ioctl, which returns a bitmap
of supported compatibility modes via the kvm_ppc_compat_caps structure.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..2f72431b6ef53 100644
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
> +		if (kvmhv_on_pseries())
> +			r =3D 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */

[Severity: Medium]
Will this falsely advertise support if the backend lacks the get_compat_caps
callback?

It appears this unconditionally returns 1 when kvmhv_on_pseries() is true,
even if running on a backend like KVM-PR that might not populate
kvm->arch.kvm_ops->get_compat_caps.

Should this verify the backend capabilities before returning 1?

[ ... ]
> @@ -2463,6 +2470,34 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
>  		r =3D kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps;
> +		u64 user_size;
> +
> +		r =3D -EFAULT;
> +		/* First, get the size field from userspace to validate */
> +		if (copy_from_user(&user_size, &((struct kvm_ppc_compat_caps
> +		     __user *)argp)->size, sizeof(user_size))) {
> +			goto out;
> +		}
> +
> +		/* Validate size - must be at least the current structure size */
> +		r =3D -EINVAL;
> +		if (user_size < sizeof(host_caps))
> +			goto out;

[Severity: High]
Does this strict size check prevent backward compatibility?

If the structure is extended in a future kernel, sizeof(host_caps) will
increase. Older userspace binaries passing their original, smaller user_size
will be rejected with -EINVAL.

Could this be resolved by accepting smaller sizes and limiting the
copy_to_user() length to min(user_size, sizeof(host_caps))?

> +
> +		r =3D -ENOTTY;
> +		memset(&host_caps, 0, sizeof(host_caps));

[Severity: High]
Does zeroing the structure locally without validating the user-provided fla=
gs
prevent those flags from being used in the future?

Since the userspace flags aren't read and verified to be zero, applications
might pass uninitialized garbage memory. If a future kernel assigns meaning=
 to
these flags, wouldn't it interpret that legacy garbage data as valid input?

> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r =3D kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		/* Set the actual size of the structure we're returning */
> +		host_caps.size =3D sizeof(host_caps);
> +		if (!r && copy_to_user(argp, &host_caps, sizeof(host_caps)))
> +			r =3D -EFAULT;
> +		break;
> +	}
[ ... ]
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf3..1788a00686626 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
> @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
> =20
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat=
_caps)

[Severity: High]
Does using _IOR here cause issues for tracing tools and user-mode translati=
on
layers?

Since the implementation reads the size field from userspace via
copy_from_user(), it seems this should be defined with _IOWR.

Also, since _IOR embeds the structure size into the ioctl number, won't
expanding the structure in the future change the ioctl number and break old=
er
binaries?

>  /*
>   * ioctls for vcpu fds
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616123314.8272=
1-1-amachhiw@linux.ibm.com?part=3D1
