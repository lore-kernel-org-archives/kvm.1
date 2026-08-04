Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B43DB30C
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868039; cv=none; b=K9VNAK4aHTvhTDZVLeD91aeOJ/cR4gooAu5Z92byB7CGPkbquMBT2J0Q3gQrqt40KKGHZuMIqLxUkTiFcrATVC1L0ZQyAnbEvFRe9uwWYqQ3p3JLzbHm5TRTF2NpowTeEekvF2IWyWdhx0es8BrFZLXSluLpJ06DTWfo2fZ8HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868039; c=relaxed/simple;
	bh=w+vfHEeO4TTtzAmOgVv+fT/dQKIO5Qt9X86oohrZRUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZKA2ROLVtnoz2WicdjK3CRlriQo3pX1WLSURaTEEKpZriMJvSx1Ydzi3vq0cX+JUW3f7adsT8lOBI3Jfuz8jiU2l555STa6rhCfFmBwcPnRZD/+91YctnI9uGQHCTfqTvsQC1Naiw7Yj+vF4QpggJ8daQYETSmp+4TQrEXOuZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUf9wl+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUf9wl+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4581F000E9;
	Tue,  4 Aug 2026 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868038;
	bh=RGYmQVNi0lXqjpmeMS2BYusnZB3KdZvCHTXjcQKawPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUf9wl+u6YyOML5uV0MTZ7Zy5cTO2UA9m2+nl/gAJ6jZP2qsJII1zfNp0XcdllZe/
	 4ydukgtne0PI8SakDVq35/d/F6beC/46/nccH/p1rqkc9yqN+pJCaUJN0DmMoriszv
	 8ltW8VkBJQH568Qlu88HkY47aOKmGRnRFQ7c3mNC3A1Na6NXeiPnU1DYiGd/5aeuHm
	 EdIpqvF8+FPATLq1my0FbnER7+xNtfDit2tLTgEv5cj1yKaTvPeF6ISV4hFmPIQXCT
	 63UZ75CgOmamj9JxdVXfo+R+lNISV1Ca43f/DdbC8Z0TgA2cTXGiuD/b0sCtpr1m9u
	 NEL+gub5mD8sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804180705.59160-4-amachhiw@linux.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:27:17 +0000
Message-Id: <20260804182718.2B4581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `kvmppc_get_compat_caps()` incorrectly returns `-EINVAL` when the =
'cpu-version' property is absent, breaking the `KVM_CAP_PPC_COMPAT_CAPS` co=
ntract.
--

--- Patch [3]: [PATCH v6 3/4] KVM: PPC: Book3S HV: Add support for compat C=
PU capabilities for KVM on PowerNV ---
commit b4de9c28bb9d6eeb95ed5310169709b332b6f664
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on Pow=
erNV

This commit extends host CPU compatibility capability reporting to support
nested virtualization on PowerNV systems. For nested API v1, it derives
compatibility capabilities from the L1 guest by reading the cpu-version
property from the device tree and maps it to the corresponding compatibility
capability bitmap.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 8799124b80960..77558f6eed864 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

>  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
>  {
> +	struct device_node *np;
>  	unsigned long capabilities =3D 0;
>  	long rc =3D -EINVAL;
> +	u32 cpu_version =3D 0;
> =20
>  	if (kvmhv_on_pseries()) {
>  		if (kvmhv_is_nestedv2()) {
>  			WARN_ON_ONCE(!nested_capabilities);
>  			capabilities =3D nested_capabilities;
>  			rc =3D 0;
> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				if (!of_property_read_u32(np, "cpu-version",
> +							  &cpu_version)) {
> +					of_node_put(np);
> +					break;
> +				}
> +			}
> +			if (!cpu_version)
> +				return -EINVAL;

[Severity: High]
If an L1 guest is booted in native mode (e.g. without a 'compat=3D' setting=
 in
QEMU), the cpu-version property is intentionally omitted from the device
tree.

Doesn't returning -EINVAL here cause KVM_PPC_GET_COMPAT_CAPS to fail,
thereby breaking nested virtualization initialization for native-mode L1
guests?

Could this fall back to deriving capabilities from the physical native PVR
instead of returning an error?

> +			rc =3D kvmppc_map_compat_capabilities(cpu_version,
> +							    &capabilities);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804180705.5916=
0-1-amachhiw@linux.ibm.com?part=3D3
