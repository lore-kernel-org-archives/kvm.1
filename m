Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3528504D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883638; cv=none; b=jlPWuAW4ZO5PzVB817yge+x5ZNSl3/vx8EKJ6GFow0qV3WPyCbcIpqCuqJzQkylouxhnUiuPSklw0BJzmHUV4yHt8NV+HEui1HjnGU9i4VfmmXENVpWRRusUJm/ROAfnQKe8q+G4e66Gl7sUqpOreSKDpC03YKO3bcXXVUGN5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883638; c=relaxed/simple;
	bh=PtF9NP2jfSqBFIWOH4WP/WuMe7aOxq0WtkX3ft5O6kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dyuv8l5wqOCJA2R6fAYxmrSUn+/9SV57yVQeUSHtwUd6YC6XUDY2XpgrVWPNNr2W+5RWO+Zi9ukWsM/XvVGm/HUwCc9dboaTc4XXRiGOGXFf9gEdwzKqst8n9vcM8Yn+4gBqV9yZ7NOcQ4AD/rZ7+prNh8fydfU4YYwMSmI5Vxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSEOSk9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSEOSk9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E3A1F000E9;
	Wed,  1 Jul 2026 05:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782883637;
	bh=DCqsF9F+cgcf4prkqdU+JfrE3XVCLjDHwNm/RUacc38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSEOSk9yoRbdreDJUOieD73IGD8Hwz0yFu3DOMA1eQCXhXDzfeGl8+0Q5B8S/rNjW
	 Pt7CErXAwML7qifPTRvLUxRfk5IQLYN8WXjP7SnzROvO1DvbWf0Coqf6l8YUmZQHIf
	 slimbNVg4qAWcX06hfDWUEERQuDcCTXIiL8ZEa5Qe+2jZ1t8YKlhyAR62Gx5dRLV3Z
	 vN8/dhew33209+K6PF/99xr9sLkBiUTP85fMlqyaO6gVXuGgid2rGwLDiysBZYPTIJ
	 Q4O3mR4uQaJi0LGGNwRMC7gA9mtoCofzBkFWDmkK6mXdRyHCwivFb6vDZsCaQJ22OW
	 vUi2qQQ6z7P3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701051409.51820-4-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
 <20260701051409.51820-4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:27:16 +0000
Message-Id: <20260701052716.F3E3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Reading the `cpu-version` device tree property using `of_get_proper=
ty` without validating its length can result in an out-of-bounds read if th=
e property is malformed.
- [Low] Endianness type signature mismatch for `cpu_version` parameter caus=
es Sparse static analysis warnings.

Pre-existing issues:
- [High] An unprivileged host user can trigger a `WARN_ON_ONCE` in `kvmppc_=
get_compat_caps()`, leading to a host denial of service.
--

commit 0383e83d38076b8b273c1d04bf2b738d14a3bbc2
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on Pow=
erNV

This commit extends host CPU compatibility capability reporting to support
nested virtualization on PowerNV systems. For nested API v1, it derives the
compatibility capabilities from the L1 guest by reading the cpu-version
property from the device tree and mapping it to the corresponding KVM
capability bitmap.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 8799124b80960..70dcd370fd9ac 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

> @@ -6510,20 +6510,58 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
> =20
> +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> +				      unsigned long *capabilities)

[Severity: Low]
Is cpu_version actually host-endian here? The parameter is declared as
const __be32, but kvmppc_get_compat_caps() passes a host-endian u32 value
to it. Could this cause Sparse static analysis tools to warn about a
restricted __be32 degrading to an integer?

> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:

[ ... ]

>  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
>  {
> +	struct device_node *np;
>  	unsigned long capabilities =3D 0;
> +	const __be32 *prop =3D NULL;
>  	long rc =3D -EINVAL;
> +	u32 cpu_version;
> =20
>  	if (kvmhv_on_pseries()) {
>  		if (kvmhv_is_nestedv2()) {
>  			WARN_ON_ONCE(!nested_capabilities);

[Severity: High]
This is a pre-existing issue, but can this assertion be triggered by
unprivileged userspace?=20

If the KVM_PPC_GET_COMPAT_CAPS ioctl is called when nested_capabilities is 0
(for example, if the host hypervisor initializes nestedv2 but does not retu=
rn
the capability flags), would this trigger a WARN_ON_ONCE?=20

According to KVM guidelines, adversary-reachable WARN_ON assertions can be
host-side denial of service vectors if panic_on_warn is enabled.

>  			capabilities =3D nested_capabilities;
>  			rc =3D 0;
> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				prop =3D of_get_property(np, "cpu-version", NULL);
> +				if (prop) {
> +					cpu_version =3D be32_to_cpup(prop);

[Severity: Low]
Could this read out of bounds if the cpu-version device tree property is
malformed and less than 4 bytes long?

The pointer returned by of_get_property() in kvmppc_get_compat_caps() is
dereferenced by be32_to_cpup() without checking the length. Would using
of_property_read_u32() natively validate the length and securely handle
the endianness conversion?

> +					of_node_put(np);
> +					break;
> +				}
> +			}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701051409.5182=
0-1-amachhiw@linux.ibm.com?part=3D3
