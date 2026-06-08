Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0F332621
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938787; cv=none; b=SvEpc0xoqkIh9TT8ySaRp/SBRbWdslsg77gAHkZSbDHtDQ0vy/pgnxYhd1W7Ka2UxHXLemKv5oz5+nEOMsDpPLaGL5F1NjVQi3btRKxlxNtkAaLfPl7Ix7An7f0YRFBf6cvRUhHeqgn+SdtzMjP4Thr8cipXFE+/j0tnZm3HkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938787; c=relaxed/simple;
	bh=8jDKeVmzrsw3XZYj1p6Iz/B/5LnokmtPlxwwHNum/HM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z6elN6gRcnUTbfYAkRMULGigxp/90E3l5FatrZQypieVcVPwEfNfEn96arWG+cKufraMgjpv83I7PSUxCybG8mC5T/HNxQlMYZOFQl//Mq71Lq0Dk+PE6x7Z12nWgz/k76EFXb+BAT0c8AF+HVn7eBtxnuObxuCfedAxRJsA2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS2AQndM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS2AQndM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2771F00899;
	Mon,  8 Jun 2026 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780938785;
	bh=kLfVeRXRCdwSsGQCdBopBknwTUlQHVXmPT6XfAvjMko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS2AQndM+ShovFVxRWZpGUzJpaZjfmxCPQiiV8ECj/Tk8NlPbE8my5kwpV/0awTky
	 6EMSxWtxY3ppLnDCkf0mquyTHuHGRyn3vmaAb/vuSNcfuvWBjBfbP9g1TmFoQ1/4+0
	 DVD62oM5+BaK1CyVxry2VDWOSVrX/uSMu0O+bsTpX62fzuDPX8Ne9WZDKbG7Ur1PsT
	 XoGZJUDbyoRbX+nHlkM1uwRYRAcPCMqcx03J1I0d1ukUiA1FT1nsqKCoUHLGqpKmgF
	 wjhV979QrV5bKckcRFI/2Vyn9UQmbXgerSbvfrX325hhmp9nLVB8vmN3fMM3+dnhrG
	 2GueSR4Zq0QGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/60] kvm: Implement KVM_CREATE_PLANE ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-30-joro@8bytes.org>
References: <20260608144252.351443-30-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:13:04 +0000
Message-Id: <20260608171305.4F2771F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Failed KVM_CREATE_PLANE ioctl leaves a dangling pointer in kvm=
->planes[id] causing Use-After-Free and Double-Free.
- [Medium] Mixing `guard()` scoped cleanup with `goto`-based error handling=
 in `kvm_vm_ioctl_create_plane()`.
--

commit b6872a36c29c142bcf253335bda2d600adade6a7
Author: Paolo Bonzini <pbonzini@redhat.com>

kvm: Implement KVM_CREATE_PLANE ioctl

Add a new VM ioctl to create a new plane. It returns a new file descriptor
which supports per-plane ioctls.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4dbb7659fa2b8..e5d941b1d6fd6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -5287,6 +5315,49 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *k=
vm)
>  	return fd;
>  }
> =20
> +static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
> +{
> +	struct kvm_plane *plane;
> +	struct file *file;
> +	int r, fd;
> +
> +	if (id >=3D kvm_arch_max_planes(kvm) ||
> +	    WARN_ON_ONCE(id >=3D KVM_MAX_PLANES))
> +		return -EINVAL;
> +
> +	guard(mutex)(&kvm->lock);

[Severity: Medium]
Does mixing a scoped guard with explicit goto-based cleanup labels violate
subsystem guidelines?

The subsystem documentation states that the expectation is that usage of go=
to
and cleanup helpers is never mixed in the same function.

> +	if (kvm->planes[id])
> +		return -EEXIST;
> +
> +	fd =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +
> +	plane =3D kvm_create_plane(kvm, id);
> +	if (!plane) {
> +		r =3D -ENOMEM;
> +		goto put_fd;
> +	}
> +
> +	kvm_get_kvm(kvm);
> +	file =3D anon_inode_getfile("kvm-plane", &kvm_plane_fops, plane, O_RDWR=
);
> +	if (IS_ERR(file)) {
> +		r =3D PTR_ERR(file);
> +		goto put_kvm;
> +	}
> +
> +	fd_install(fd, file);
> +	return fd;
> +
> +put_kvm:
> +	kvm_put_kvm(kvm);
> +	kvm_destroy_one_plane(plane);

[Severity: Critical]
If anon_inode_getfile() fails, does this error path leave a dangling pointer
in kvm->planes[id]?

Assuming kvm_create_plane() publishes the plane to the array before returni=
ng:

virt/kvm/kvm_main.c:kvm_create_plane() {
	...
	kvm->planes[plane_level] =3D plane;
	...
}

When the error path destroys the plane but fails to clear kvm->planes[id],
could this lead to a double-free later when kvm_destroy_planes() iterates o=
ver
the kvm->planes array?

virt/kvm/kvm_main.c:kvm_destroy_planes() {
	...
	if (kvm->planes[i] =3D=3D NULL)
		continue;
	kvm_destroy_one_plane(kvm->planes[i]);
	...
}

> +put_fd:
> +	put_unused_fd(fd);
> +	return r;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D29
