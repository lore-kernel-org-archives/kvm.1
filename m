Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441822F1FC9
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945984; cv=none; b=Rj9Dt1zBdmlfh/8jvCdvewfmj2gh5MMinWpOWcFtrqSxgZRlD9I5Qzda1n6vpezgAS4usX8B229y9ons9A1a3zi4M/UWEka5JBC/kFpY1voGtBhd0js1X562/c+FJAQ2qLAaO8muiXRdyOp0DwEE3JrZhh4x2MLSEVB5U/1IAo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945984; c=relaxed/simple;
	bh=n+U9/ZsVB0qtudDcDGmCkgWV130Hri0x2rA7U6oxBgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AxAI23n6l/5igf1YNZjibSZZp1xR6+kEeCX4uiz881mI7nRosqKhW4Eug82jghQqGc//5ojphv0fIfnkgaB/FWlHX+VPD0fV6lL7xEfNstKRPFBijr0eBZ7f3FFP6+nf7LImV5reKtAdarlK9dRqNzf8Ow2gTVKJNV+v6wxnYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8E+f9GY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8E+f9GY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E91F00893;
	Mon,  8 Jun 2026 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945982;
	bh=tB5szGIub0ke/n97QC7OIDFqxadMNsz74eJRgkX6rLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8E+f9GYNl69VIjXBfUimHrmvhbY5E6X+mw0Go422jnsLtt10OGyz7ORU5ayipS+J
	 VsPLto5K/FNipL7yNqZyUITGIet0ExCzRVcLAyD6PAUyRwc7WweTjzaVckCfR+KUmx
	 6+3u+kd9o8U660xCnczEQkiX0iI63iWrujb5e9ZQonO9Nn7HBqdsYBnxdYqdyCCukX
	 zeKRwHTenGc0awPZttli1hW03x9wUqLrt/hF0tG/2RVpRupf1AuvF+inAnMd6lDAJZ
	 L7B7gWH3K251zaLmWtLQQ8qHKYPJDh218mUZ5Iugz84NFGf+xHOnikEDgmAzHOc+CG
	 KdNWKZauMR++g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 38/60] kvm: Make KVM_SIGNAL_MSI per plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-39-joro@8bytes.org>
References: <20260608144252.351443-39-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:13:02 +0000
Message-Id: <20260608191302.BB3E91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked dereference of `kvm->planes[0]` when handling the `K=
VM_SIGNAL_MSI` ioctl on a VM file descriptor.
- [High] Data race due to lockless, barrier-less read of `kvm->planes[0]`.
--

commit 0dc2d91e398b9b44dd20386b1d421b555712578a
Author: Paolo Bonzini <pbonzini@redhat.com>

Allow the KVM_SIGNAL_MSI ioctl for every plane instead of per VM.

This commit updates the KVM_SIGNAL_MSI ioctl to operate on a per-plane basis
rather than per-VM. It achieves this by moving the ioctl handling into the
plane-specific ioctl path and passing the plane level to the MSI handling
functions.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4907,6 +4907,17 @@ static long __kvm_plane_ioctl(struct kvm_plane *pl=
ane, unsigned int ioctl, unsig
>  	case KVM_CREATE_VCPU:
>  		r =3D kvm_plane_ioctl_create_vcpu(plane, arg);
>  		break;
> +#ifdef CONFIG_HAVE_KVM_MSI
> +	case KVM_SIGNAL_MSI: {
> +		void __user *argp =3D (void __user *)arg;
> +		struct kvm_msi msi;
> +
> +		if (copy_from_user(&msi, argp, sizeof(msi)))
> +			return -EFAULT;
> +		r =3D kvm_send_userspace_msi(plane->kvm, &msi, plane->level);

[Severity: Critical]
This isn't a bug introduced by this patch, but I wanted to ask about how we=
=20
handle the plane pointer here. If kvm_vm_ioctl() is called before any plane=
s=20
are created, kvm->planes[0] might be NULL. When that NULL pointer is passed=
=20
down to __kvm_plane_ioctl() as the plane argument, doesn't this=20
unconditionally dereference the NULL pointer when accessing plane->kvm and=
=20
plane->level?

> +		break;
> +	}
> +#endif
>  	default:
>  		r =3D -ENOTTY;
>  	}

[ ... ]

> @@ -5493,6 +5504,9 @@ static long kvm_vm_ioctl(struct file *filp,
>  		r =3D kvm_vm_ioctl_create_plane(kvm, arg);
>  		break;
>  	case KVM_CREATE_VCPU:
> +#ifdef CONFIG_HAVE_KVM_MSI
> +	case KVM_SIGNAL_MSI:
> +#endif
>  		r =3D __kvm_plane_ioctl(kvm->planes[0], ioctl, arg);

[Severity: High]
This is a pre-existing issue, but could this lockless read of kvm->planes[0]
result in a data race? Since kvm->planes[0] is read without locks or memory
barriers like READ_ONCE() or smp_load_acquire(), could concurrent allocation
and initialization in KVM_CREATE_PLANE result in the CPU or compiler
reordering the memory operations, leading us to observe a non-NULL plane
pointer but read uninitialized fields from the struct kvm_plane?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D38
