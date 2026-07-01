Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B8182D6
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883433; cv=none; b=E+isTo3774V6x7ZSP+tHinvREiwTVKfzhxynlfYUTsKByWSFXfSrgG9k//PFBRjbc1yrcQ+RQMMhMW0gPnDqtiVsya7mFbz5VNfnY8vZORkmAXJypb324S8ZplcT34Y0GPJHtxKLBhcUKhctN3rcYxWvAUGgBNHe6lLpdpXIMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883433; c=relaxed/simple;
	bh=GQHOLkhI77tWhqmVivETVRHVTQ2adL7mLLRUFJnxvbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5mBKcLn2OIpNnfU2Iq2OvlXnSrjF1f1aYW+4n4+DZJH7+S9z0s9Is4+KBMIVGNY3meHX3+g3GhHiBN5CcgLlLhQKcmVhkIP7j6qUT1O/23CCniJGarJT1PJQ3Bi+Uyl4AVBRZgDJf65i4C6fMSW6jAxiM3g/QMi3ubtBiDva0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIfviekt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIfviekt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9721F000E9;
	Wed,  1 Jul 2026 05:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782883431;
	bh=cMbaMRLz7wg7XbysvL9wSM/88otM/wGxJl0Mfha7j50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIfviekthjPE0yWZnS4ep0NyV2A+d5tQLEVAdK9xBuBOMa3YQ52cr8a9sl3Zq7YAi
	 gP/T/C1aVYX7inpbRYJUf5ffNSCuiTGJsaLDVryga4cPNVVJhrq/MXYJSnfcv6PnJm
	 VJKh/njtvU0pwYDidopDlxY6Mx8AOnIsCMyBsPZgc6uHQYE5WTLbDCBvN7nRXlsQbN
	 bS2m+nBL8ulMja/Lx5VOB5f7dlsm/DzddV2A77hzshYghKCWY1ty1kTR/L47InPhRJ
	 Eeze5zFZuP43oByUeinOn1nDXi2BfSDZp8ihYYI3LWf+46b6BB809s8Er+sPy+mQ9b
	 AJyZbmXkE+qxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701051409.51820-2-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
 <20260701051409.51820-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:23:51 +0000
Message-Id: <20260701052351.7B9721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The ioctl overwrites the userspace structure's `size` field with a=
 value larger than the allocated buffer on success.
- [Medium] The explicit rejection of larger userspace structs defeats the b=
uilt-in forward compatibility mechanism of `copy_struct_from_user()`.
--

commit d4727673391c2e4e3f4b9dd75bf4aeda3efb8249
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl

This commit introduces a new capability and ioctl to expose CPU
compatibility modes supported by the host processor for nested guests.
It defines struct kvm_ppc_compat_caps and adds ioctl handling via
KVM_PPC_GET_COMPAT_CAPS.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..8d6632c64ca5f 100644
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
> +
> +		/*
> +		 * copy_struct_from_user() handles forward/backward compat:
> +		 *   usize =3D=3D ksize: verbatim copy
> +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
> +		 */
> +		r =3D copy_struct_from_user(&host_caps, sizeof(host_caps),
> +					  argp, usize);

[Severity: Medium]
Does the explicit rejection of larger userspace structs defeat the built-in
forward compatibility mechanism of copy_struct_from_user()?

The copy_struct_from_user() helper natively handles larger userspace struct=
s by
succeeding if the trailing bytes are zero, allowing a newer userspace to
transparently run on an older kernel without manual fallback logic. By
unconditionally returning -E2BIG here in kvm_arch_vm_ioctl() when usize is
greater than sizeof(host_caps), doesn't this force userspace to implement
explicit retry mechanisms instead of relying on the standard behavior?

[ ... ]
> +		r =3D kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;
> +
> +		host_caps.size =3D sizeof(host_caps);
> +		r =3D copy_struct_to_user(argp, usize, &host_caps,
> +					sizeof(host_caps), NULL);

[Severity: High]
If an older userspace passes a smaller struct where usize is less than
sizeof(host_caps), does unconditionally setting host_caps.size to the larger
kernel size overwrite the userspace size field with a value larger than its
allocated buffer?

If userspace relies on this returned size field to process the structure,
could reading this larger size cause it to read past the end of its
allocated buffer?

> +		break;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701051409.5182=
0-1-amachhiw@linux.ibm.com?part=3D1
