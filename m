Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C783E9C29
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867717; cv=none; b=do+BOULvT8We3vFNDM1cW6CnultftwBE0kOKAPrrxrJzjtlopF9AB1uiEllap3Hs6wIabRJmYg8ShImkSHtOEpewZyU6YruxpD/IaWdIOMLwtgvDGNQN6mrvVv2r/IUu2iao9YbnHAxKIg0iUYyJnzOABBYi7VfCnTTz/hP23pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867717; c=relaxed/simple;
	bh=oaJTSfrYViliM1aV1Z1D+NRbd83kG5w/JXrnawU4KNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bu2SM1mY1AG1RPmp60Y1CAkz1v1duE4l8OxIJSNT2iExvkicE3XizDGmJkTOKe5senTqeJ8O3Yke3+ULHAFW6OwlY8WQBfi4fYpwV18vg5MtBeGKGC0YPRQoq6hLyxj80plN/hn+94gnDIgKZFeEuIvm/aOvrBdViO9AvttYUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2D8Jq7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2D8Jq7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D511F000E9;
	Tue,  4 Aug 2026 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867716;
	bh=ZeGePvjUVyJTVqpm8d5A9T7i0xt5HxQNBwnEsz0VWcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2D8Jq7CZvQwBzF/Dnl7Quj/kO0Ojc//r2zdlzHd9/j0SFv6Jj721VPpnEnu9LC6Z
	 rf4fh7AAB1Ey8ocYrSWBoiHJQlLrVbY579pUkYqEDHJzNxLcVVQF3G9L69T/4rtSD8
	 FdXaSMvZaw3S3eEBJjJ5X+HBRCi6OkK1UCDyuiBLgmsVr7sH+YUBVWxxLjKPJkuw63
	 txxvfgcrHjZKdrpA8GwbpiYao2n3THo9ObZZDPxR16mfTIztMKD0fVWvG4Y9yC8pHv
	 N/Xp7wgimcjGBH70BwwHFVzHUL1JsnIO4kjC1t2+0obaS0jtVCaFzKjsYnFW2vMxHO
	 3V1DZXBudQAKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804180705.59160-3-amachhiw@linux.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:21:55 +0000
Message-Id: <20260804182156.62D511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mismatch between KVM_CAP_PPC_COMPAT_CAPS advertisement and ioctl=
 implementation for unsupported environments.
--

--- Patch [2]: [PATCH v6 2/4] KVM: PPC: Book3S HV: Implement compat CPU cap=
ability retrieval for KVM on PowerVM ---
commit 8305652489744988576b7fa55e0424452c48a633
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on P=
owerVM
   =20
This commit adds support for retrieving host CPU compatibility capabilities
for nested guests on PowerVM. The capability bitmap is retrieved from the
cached nested_capabilities value and exposed through the new
KVM_PPC_GET_COMPAT_CAPS ioctl.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..8799124b80960 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

> @@ -6510,6 +6510,25 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
> =20
> +
> +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +	unsigned long capabilities =3D 0;
> +	long rc =3D -EINVAL;
> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2()) {
> +			WARN_ON_ONCE(!nested_capabilities);
> +			capabilities =3D nested_capabilities;
> +			rc =3D 0;
> +		}
> +	}
> +
> +	host_caps->compat_capabilities =3D capabilities & KVM_PPC_COMPAT_BITMAS=
K;
> +
> +	return rc;
> +}

[Severity: Medium]
Will this return -EINVAL for pseries hosts when nestedv1 is used?

If KVM_CAP_PPC_COMPAT_CAPS advertises support by returning 1 for all pseries
hosts (which appears to be the case in kvm_vm_ioctl_check_extension),=20
userspace might query KVM_PPC_GET_COMPAT_CAPS and hit this path when
kvmhv_is_nestedv2() is false.

For example, if userspace checks KVM_CAP_PPC_COMPAT_CAPS and gets a positive
result, but kvmhv_is_nestedv2() returns false here, we return -EINVAL.

Since -EINVAL typically indicates invalid structure size or bad flags, could
userspace fail to differentiate an unsupported backend from invalid inputs,
leading to initialization failures?=20

Should this gracefully return 0 capabilities (or -ENOTTY), or should the
capability check itself verify kvmhv_is_nestedv2() before advertising suppo=
rt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804180705.5916=
0-1-amachhiw@linux.ibm.com?part=3D2
