Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062428504D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883587; cv=none; b=Gn5T50jM77ThHhRI7AYK6xgtpv4LwL0c5mxtkDrTprX0NVKWf9YTHoQVWn8vjZNKAsA73kjNf0lz5XeIlbJir1BZk6ks0As1TfC1PuL30dUJN10H6b6cMkpbq2vlImWamvlzeleJcFd8jsVrfl1dOtWw7wsvAzbf4qyZa9gU98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883587; c=relaxed/simple;
	bh=VxIDoBs8vOktJ5hx9DEOPrfutA5pAN0Qw2gmc7ihgFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmmJmqOBxT3jTvU8pGMXE8QMcVxbtBmHHM4MWKdIjMEl3eoAiS0RmRG+XSdsA8DEPQl51rUteJ67fMN4zYI16lwTYveibOK5IQpYyLYBBqGNETvPfS3oP6o8oFAsCzss1qp4H7lPkLGepHZtQ0dlGANLsv9n+tvbUemFhr1vTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbOUne9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbOUne9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40ED1F00A3A;
	Wed,  1 Jul 2026 05:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782883586;
	bh=bDVf0wttyUWGuWXVheBtSHReTdn0hhF5x3fG3Q6VFcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbOUne9jLNL1x7q6OYqBImddIAaIuoAoC90pB0DEx7YIAmImXXMyzDmO1pia7ZkjC
	 VviGdFfnZ7ASLdT8H5jpEDTvItxURXUcTOoiAt7N/T1VGdBxdCsxjom+MWRSdGkKjU
	 3PJzCdlmZQevj3CchLod0AOPdKL+LbTSYrWQnOiTk5EyHrEkV0/jCiCMyBqvKLMFDu
	 ZndMOVtv7bTfHIo+AMhIdTWb0G1oXSP++hoFNuewxhUSXIcaVVlNnw1ZKlhKtm/gVC
	 ygB3+xqNLWEbuGvPC0Rhq5Q6uOnz6Yo1Jxw0HxokUYDjGyUgB2WMgV1XnhqFrpB0Fa
	 3Ot7CiRV0h1sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701051409.51820-3-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
 <20260701051409.51820-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:26:25 +0000
Message-Id: <20260701052625.E40ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An unprivileged host-userspace process can trigger a kernel WARN_O=
N_ONCE by invoking the KVM_PPC_GET_COMPAT_CAPS ioctl when the L0 hypervisor=
 reports zero nested capabilities.
--

commit 6f57063ca19824c71191d87b7d5e423ad8ddc900
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on P=
owerVM

This commit adds support for retrieving host CPU compatibility capabilities
for nested guests on PowerVM. It exposes these capabilities to userspace
via the KVM_PPC_GET_COMPAT_CAPS ioctl, leveraging a cached value populated
during module initialization to avoid repeated hcalls.

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

[Severity: High]
Could this WARN_ON_ONCE be triggered by an unprivileged host-userspace
process?

If the L0 hypervisor reports no recognized capabilities during module
initialization, nested_capabilities is set to 0. A user process with access
to /dev/kvm could then create a VM and invoke the KVM_PPC_GET_COMPAT_CAPS
ioctl, directly evaluating this condition.

Since a userspace-reachable WARN_ON_ONCE can act as a local denial of
service by flooding dmesg or crashing the host if panic_on_warn is enabled,
would it be safer to return an error to userspace or log via pr_warn_once()
instead of asserting?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701051409.5182=
0-1-amachhiw@linux.ibm.com?part=3D2
