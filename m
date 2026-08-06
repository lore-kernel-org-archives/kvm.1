Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287A3242DF
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036834; cv=none; b=H9etYRsTcNaRGBTu25nUmoPmJhcXbevFvL8vzaXA7bw6aHRS/PX0ruSVUGjwMiwxP+tIxLXw5I92PJII9hRYtWTHFMBgBs2kDBl8Pnwmh/QjMs6qqw6mxSpKCck2pc0a84LEn0cc019raftu5T1NMC0/XsIIp+NuIPvXyMhi3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036834; c=relaxed/simple;
	bh=WY5x045dnncu4tY++U9KmZJGvhQFTnbuks7cncjkEWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9VNM+2y7DxPF7mYFZcMk64Dkv7u5LoPjbztg2JreWUIMN+UumjOiimJqabBmYPrfkecGdGAEkn51MRYaZhlGYzzy2/3uFAVOTZOhtU1lCM1wKaDLPML8BrtqL2zlUYM7slSrlZnUlL/cTnjkl5mDL0qsbQUBNZkJfTPLkTgxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHM6yAVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHM6yAVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2021F000E9;
	Thu,  6 Aug 2026 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036833;
	bh=wKo6VtHeBC5HRhA1zSdgLHKuJBizlq9RfhcLe3J2FSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHM6yAViyoC6xrabefXTGurIQP2eFF9FbUTOPeDPoMV/sDsB/oMVfZaTUNVMRdgqn
	 9mDCMt/d+beTXXZjdJE5WrAOXBRhOpSh51iq6qgnoMxkTmOa908KFHjbOZ5dytKD2V
	 39eV25c92uQix3+iGG15oS6uOnvYSwRtiUEt/4AqwJJ4U16y2e0Rw1Q0GVb7mwUCoL
	 FuVtOzgEjdxuNwfSyop3Oc4z0htKtimiRPThqC1OqXx4Z66FcVckgJr4ozgXeWlWnO
	 iR7aSrsHDl6kBolSNAApha+u/Zigris9A2gCJ8AXO6CC5E6WxY7wYa7Ilz1OFhDUZq
	 UyOCLnvNESsaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806170645.11892-2-amachhiw@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:20:31 +0000
Message-Id: <20260806172032.DC2021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM_CAP_PPC_COMPAT_CAPS capability is advertised but the ioctl bac=
kend is completely unimplemented, causing unconditional failure.
- [High] The KVM_PPC_GET_COMPAT_CAPS ioctl overwrites the userspace buffer'=
s size field with a value larger than the allocated buffer, creating an out=
-of-bounds read risk in userspace.
- [Medium] The manual validation block explicitly rejecting `usize > sizeof=
(host_caps)` defeats the standard forward-compatibility guarantee of `copy_=
struct_from_user()`.
--

--- Patch [1]: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS a=
nd wire up ioctl ---
commit 8c51e17a26cbffd727576c50f93a34eea2340547
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl

Introduce a new capability and ioctl to expose CPU compatibility modes
supported by the host processor for nested guests.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..ed0cd7b83b63f 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
[ ... ]
> @@ -2463,6 +2470,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
[ ... ]
> +		/*
> +		 * New userspace with a larger struct called an older kernel.
> +		 * Write back ksize in host_caps.size so userspace knows which
> +		 * older struct to retry with, then fail with -E2BIG.
> +		 */
> +		if (usize > sizeof(host_caps)) {
> +			host_caps.size =3D sizeof(host_caps);
> +			r =3D -EFAULT;
> +			if (put_user(host_caps.size, (__u64 __user *)argp))
> +				goto out;
> +			r =3D -E2BIG;
> +			goto out;
> +		}

[Severity: Medium]
Does this manual size check defeat the standard forward-compatibility
guarantee of copy_struct_from_user()?

Normally, copy_struct_from_user() verifies that any trailing bytes provided
by a newer userspace are zero. By short-circuiting here and unconditionally
returning -E2BIG, aren't we rejecting perfectly valid, zero-initialized
structs and deviating from standard kernel extensible UAPI patterns (like
clone3 or openat2)?

[ ... ]
> +		r =3D -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r =3D kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;

[Severity: High]
Will this ioctl always fail with -ENOTTY?

The capability KVM_CAP_PPC_COMPAT_CAPS is advertised as supported to
userspace (returning 1 on pseries hosts in kvm_vm_ioctl_check_extension()),
but the get_compat_caps backend function pointer is never assigned anywhere
in this patch.

If userspace attempts to use this ioctl based on the capability check,
won't it unconditionally hit this missing backend check and fail, causing
regressions in userspace startup flows?

> +
> +		host_caps.size =3D sizeof(host_caps);
> +		r =3D copy_struct_to_user(argp, usize, &host_caps,
> +					sizeof(host_caps), NULL);
> +		break;
> +	}

[Severity: High]
Is it safe to overwrite the userspace size field with the kernel's internal
struct size?

In a forward-compatibility scenario where an older userspace passes a
smaller struct to a newer kernel, usize will be smaller than
sizeof(host_caps). By setting host_caps.size =3D sizeof(host_caps) and
copying it back, the userspace struct will receive a larger size value than
it actually allocated.

If userspace trusts this size field for bounds checking or iteration, could
this regression lead to an out-of-bounds memory read in userspace? Shouldn't
the kernel preserve the originally requested usize?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806170645.1189=
2-1-amachhiw@linux.ibm.com?part=3D1
