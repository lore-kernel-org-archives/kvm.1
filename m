Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69D33C19E
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124375; cv=none; b=pA+0PALeWKNmR1x8+2LHDESuREcq5KMfnMtP79ThN8NtADIroa9rRspW7/vj4rBZFvyMh67Cek0WpCjVRGpQGzF4tdvUJlBwiE8MC3EG235la1BJpUDJHLsE7ov4XhDi/TwEy6mHFf/6prsXCABAc5KTTi3FizlY9Gu9BkDS3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124375; c=relaxed/simple;
	bh=9f6d8rjZAqF9DhALLQkMieLUbr1MT3VbruhCJHbmpsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WV9xjXoqCcj0pzRRgKuUJ33m01aGeeED1SiANIZouSXmbtO5/y4avDDYZX6iGf2tzU+jQvlGKqP4+/19D3MSZ3bh1lA3qKC2LtGYHLxDC5gVugWYRCFvZYeXVhU2cwM4zRQ4+A9Gdoou91N9/AbWw4VQA9uhTcSZhCloha/9fp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUDWmm9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUDWmm9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5E01F000E9;
	Fri,  7 Aug 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786124374;
	bh=43o4LxqJDUPKYZfp0LhptXBJCNc1xJlBS2n9CuF7Rd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jUDWmm9YSr1AijRGMSnWeU/yJguzWSzhHtQDAkokR+Y4SkHUSrSa+PdRZGw4m833y
	 G7bHGmQftmN86nB7FJl8+O499XeEP8c2uGi+YmwwOAiYIgmCRQ5VSNeoBTWtY2LCm4
	 R18oYhhHKbWGRGgBT5ceOvfTTFtRtnqdGst5e8AC2PSwanP/+0SucQopKtQSM9cIKl
	 vxB5ENklx8ADOnNp70rcUWIgAR16V/d9/CEuWRLcJcIQdzcoxCwmlEcSfiOQwNVt2k
	 XTeFm+GfFU3pdUWxjVAX1Rb1GNYhwABH7GiBBQakug8Xu2izmfBpPbIyta8EAT55xH
	 waVkqmDxhNQuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807172433.82045-3-amachhiw@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
 <20260807172433.82045-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 17:39:33 +0000
Message-Id: <20260807173934.3B5E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM_CAP_PPC_COMPAT_CAPS is unconditionally advertised on all pseri=
es hosts, but the corresponding ioctl fails on non-nestedv2 hosts.
- [Medium] kvmppc_get_compat_caps returns -EINVAL for unsupported configura=
tions instead of -ENOTTY or -EOPNOTSUPP.
--

--- Patch [2]: [PATCH v8 2/4] KVM: PPC: Book3S HV: Implement compat CPU cap=
ability retrieval for KVM on PowerVM ---
commit 73749763b436fd33b42f2ac5536c1c5a4bf826ad
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on P=
owerVM

This commit implements the retrieval of host CPU compatibility capabilities
for nested KVM guests on PowerVM. It defines KVM-specific capability consta=
nts
and exposes the cached nested capabilities via the KVM_PPC_GET_COMPAT_CAPS
ioctl.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..8799124b80960 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6510,6 +6510,25 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
> =20
> +
> +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +	unsigned long capabilities =3D 0;
> +	long rc =3D -EINVAL;

[Severity: Medium]
Should this return -ENOTTY or -EOPNOTSUPP instead of -EINVAL when the
configuration is unsupported?

-EINVAL conventionally indicates invalid userspace arguments rather than a
lack of host support. This might complicate graceful fallback logic if
userspace cannot differentiate between malformed requests and missing featu=
res.

> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2()) {

[Severity: High]
If KVM_CAP_PPC_COMPAT_CAPS returns 1 for all pseries hosts (including
nestedv1) in kvm_vm_ioctl_check_extension(), will failing this ioctl here
on non-nestedv2 hosts break userspace?

Userspace might rely on the capability advertisement and fail unexpectedly
when the ioctl returns an error instead of succeeding with empty or base
capabilities.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807172433.8204=
5-1-amachhiw@linux.ibm.com?part=3D2
