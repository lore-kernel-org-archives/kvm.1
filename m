Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13C431E5C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936597; cv=none; b=ujQnq/wjSuSH8898APYw4LEa1DG2XArdD8JHzo8rIKrXI4GzqsQ/MMVBmkS36AZAGMuR+l11tvoaM7gOknrLI0idqpfUgY4b4Ugo7gAkAWkrniko+V1nULPZjRWHeXnYDllsrxnBEzGLW/NCMtTws69blZ9xwVEsR2ukR5US6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936597; c=relaxed/simple;
	bh=1au6xaiF6Sb5/G4byv6O0JhmoOBtoV9mHNMnx3UpTRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAQ8seKhoqk75G1PD6OKC4i2ODM5dEdcNuso/WW8HY43CZ6y6zB3Ei1p248knULTrqA6l06SK86N9KQ/AxhYjceYUhRzDtHYhS9cD7P/DbCyRgd3lk6QUauZK7sD2c6z6Nnw6DhiAjIwTAfqR2WJvO4YeJIDdZGiM2+/f+q8duI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJDUwaBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJDUwaBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A771F000E9;
	Wed,  1 Jul 2026 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936595;
	bh=YEHLKq0j0vpWEUkxvQPA/aADrztXnIQno+6Zjy0mF8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJDUwaBX4miosR+X9tNQxWn0bxgGGiJuZEeW5dVvpOFZ30khDBdgCSQHVLXVfszts
	 uMBLfYAJ2NvJD7PFG3K6N0XW8oRfLPRpWpg86x4bengRq2bTUPPfD5I+SODiW5l6A+
	 gmME74242t1LuSWsFabBaQch6wvDeqk5zVe4VY3MFaQhE3/ifpk23ng+D/7O93KVIF
	 KqNIJrorkS3ALt085JnXIbes8d0heIPhALKWkN5h1vivom/NvjtWkxgxlTikqpIXnM
	 Fgrq7o7qtFNAu9J8ibTm52ndWQffWSzPPFWrUqxDxAmIMKlRy2h1z0y8P5qWPV5CH6
	 7IhvclvfjvHoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] kvm: reject unknown flags in device and dirty-log
 ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXbDoW4gRXplcXVpZWwgUm9kcmlndWV6?= <ivanrwcm25@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701194946.768731-2-ivanrwcm25@gmail.com>
References: <20260701194946.768731-1-ivanrwcm25@gmail.com>
 <20260701194946.768731-2-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:09:54 +0000
Message-Id: <20260701200955.77A771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Adding strict flag validation to previously ignored ioctl para=
meters breaks backwards compatibility for existing userspace applications.

Pre-existing issues:
- [Medium] The validation for `kvm_device_attr.flags` is incomplete and mis=
ses the VM, VCPU, and System ioctl paths.
--

commit c3cf74adec51cd659e1e4d1a49a36240977087b9
Author: Iv=C3=A1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>

kvm: reject unknown flags in device and dirty-log ioctls

KVM_CREATE_DEVICE only defines KVM_CREATE_DEVICE_TEST, but unknown
flag bits were silently ignored. kvm_device_attr.flags is documented
as unused yet was never checked centrally. KVM_ENABLE_CAP for
KVM_CAP_DIRTY_LOG_RING and KVM_CAP_DIRTY_LOG_RING_ACQ_REL requires
cap->flags to be zero per api.rst, but the generic handler did not
enforce it.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e44c20c049610..a2aecc06ab67e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4719,6 +4719,9 @@ static int kvm_device_ioctl_attr(struct kvm_device =
*dev,
>  	if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
>  		return -EFAULT;
> =20
> +	if (attr.flags)
> +		return -EINVAL;

[Severity: Critical]
Does adding strict flag validation here break backwards compatibility for
existing userspace applications? If userspace previously allocated
struct kvm_device_attr on the stack without explicitly zero-initializing the
flags field, won't it now fail with -EINVAL since the kernel used to
silently ignore it?

[Severity: Medium]
This is a pre-existing issue, but the commit message states
kvm_device_attr.flags is now checked "centrally". However, doesn't
kvm_device_ioctl_attr() only handle device file descriptors?

The same device attribute ioctls (KVM_HAS_DEVICE_ATTR, KVM_GET_DEVICE_ATTR,
KVM_SET_DEVICE_ATTR) can be called on VM or VCPU file descriptors, which
are handled in architecture-specific code like kvm_vcpu_ioctl_device_attr()
in arch/x86/kvm/x86.c or kvm_arch_vcpu_ioctl() in arch/arm64/kvm/arm.c.

Doesn't this bypass the new validation entirely?

> +
>  	return accessor(dev, &attr);
>  }
> =20
> @@ -4811,6 +4814,9 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
>  	int type;
>  	int ret;
> =20
> +	if (cd->flags & ~KVM_CREATE_DEVICE_TEST)
> +		return -EINVAL;

[Severity: Critical]
Similar to the issue above, does rejecting unknown flags retroactively break
applications that pass uninitialized stack memory in cd->flags when calling
KVM_CREATE_DEVICE?

> +
>  	if (cd->type >=3D ARRAY_SIZE(kvm_device_ops_table))
>  		return -ENODEV;
> =20
[ ... ]
> @@ -5061,6 +5067,9 @@ static int kvm_vm_ioctl_enable_cap_generic(struct k=
vm *kvm,
>  		if (!kvm_vm_ioctl_check_extension_generic(kvm, cap->cap))
>  			return -EINVAL;
> =20
> +		if (cap->flags)
> +			return -EINVAL;

[Severity: Critical]
Will this retroactively break backwards compatibility for applications
enabling KVM_CAP_DIRTY_LOG_RING or KVM_CAP_DIRTY_LOG_RING_ACQ_REL if they
haven't explicitly zero-initialized cap->flags?

> +
>  		return kvm_vm_ioctl_enable_dirty_log_ring(kvm, cap->args[0]);
>  	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP: {
>  		int r =3D -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701194946.7687=
31-2-ivanrwcm25@gmail.com?part=3D1
