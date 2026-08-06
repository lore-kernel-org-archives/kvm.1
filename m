Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67048C3ED
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037151; cv=none; b=BmnZF17oUrSrQUJGD7Rn+l7R7V+ul2d5iKvIBMf42RQP5pJQ4jJ3D6M3PqENM4U9Jp9RHYX5QQQXQtu5audJmPohCPuiRPNWy7IFqBve/mX8VzdchxUfWUNi5O4Ot73EdLqUZJdXQQ2HG+kFRp1X0Fw+1WezYjAJKAsNk6thXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037151; c=relaxed/simple;
	bh=fMEVTGK6K1hgW6OeXkzUz8Gf2rV+XY1snoSgw4vG104=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9mGrbrxPKCG2mqSkRR7XWK4KBm8CA8IhdsU/kIoEt8heU8/WV1hAkDNyinUU5gDRKAyxdkjTCe/o3afW+ZFI080ppMkgTvddJgBNFoDe1cmbmkipRWyrxnK2mdjS3zIpQw1AJmGEQe0H2bfJAkryks4XSIg9fTKu4mPrdiTVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCZ0ASri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCZ0ASri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A9E1F000E9;
	Thu,  6 Aug 2026 17:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037149;
	bh=rgvdiAcdpJNCfAWYIfRntHft87yXZnT4lW0fAqfsV/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCZ0ASrivmVpy5ok2OMrUVcjJ+0WCC8nWOHa6aGsQ3qX7VnAuBCTH+MC98BoiaSYO
	 VD0XLur8n/jq+pEFYtTwCuvHxu4bzl2CHr1LaRuRRStgDcFJJzPmGOhS41ISqqq1qu
	 7oUkClfR2HTxEMuEoP8Z2GNspvvUNdwg2xuu8p1FT90AkNUEeMTlrFpuzIqkgwvZsp
	 n7UaRuhmj5JInXD68ui8IMsWq8iAyDA0pRX4EXVzqF3gG6E8GnS0YZcjW2Nu0PTm0L
	 UWVdgpgqkJNNdY5xwWD5tsswEqGxBwLE8XnWV2i9y+33V3hJ7yFOXr+BFYE8rpvdsn
	 OyQvroKgUehvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806170645.11892-3-amachhiw@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:25:48 +0000
Message-Id: <20260806172549.50A9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM_CAP_PPC_COMPAT_CAPS incorrectly advertises support on non-nest=
edv2 pseries hosts, but KVM_PPC_GET_COMPAT_CAPS unconditionally fails with =
-EINVAL.
--

--- Patch [2]: [PATCH v7 2/4] KVM: PPC: Book3S HV: Implement compat CPU cap=
ability retrieval for KVM on PowerVM ---
commit 7fc253c4f6dbfb301a4c2d7a89c141048079da6c
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

    KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM =
on PowerVM
   =20
    On POWER systems, the host CPU may run in a compatibility mode (e.g., a
    Power11 processor operating in Power10 compatibility mode). In such
    cases, the effective CPU level exposed to guests differs from the
    physical processor generation. This patch exposes host CPU compatibility
    mode capabilities to userspace for nested KVM guests via a new ioctl.

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

[Severity: High]
Does this code break guest initialization on non-nestedv2 pseries hosts?

In arch/powerpc/kvm/powerpc.c, kvm_vm_ioctl_check_extension() advertises
KVM_CAP_PPC_COMPAT_CAPS support on all pseries hosts:

    case KVM_CAP_PPC_COMPAT_CAPS:
        r =3D 0;
        if (hv_enabled && kvmhv_on_pseries())
            r =3D 1;
        break;

But here in kvmppc_get_compat_caps(), if kvmhv_on_pseries() is true and
kvmhv_is_nestedv2() is false, rc remains -EINVAL.

When userspace (like QEMU) sees the capability is supported, it will call t=
he
KVM_PPC_GET_COMPAT_CAPS ioctl. Receiving an unexpected -EINVAL here causes
QEMU to fail VM initialization, breaking guest boots on standard pseries
hosts.

Should the check extension logic be updated to also require
kvmhv_is_nestedv2(), or should this function handle non-nestedv2 pseries
hosts without returning an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806170645.1189=
2-1-amachhiw@linux.ibm.com?part=3D2
