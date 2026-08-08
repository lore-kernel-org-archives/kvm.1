Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826BA2EB5A6
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786207144; cv=none; b=GZRgnTwnUy/Zrt9yztPxNlPuO8yvq6plEpXm+WIJhVcry3C/qJkzRvgS1n0t76YFdR61h8U48WdcqG/TLoYDX904ft/NW48INlxN5ZzWezSdsy/xfsCNViUHoOath9xSnvwGMWHWsaufYpaTbxwGrtG+4Hr5x64noswxINWSy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786207144; c=relaxed/simple;
	bh=QXXonF6VhcN1pBmFD1lwRCCUyruaKdG6X+u3ws818Dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fe19R/cYCYidb+Ae7ZiWvl13CeEB7p2CbgtInZh03hLIOd5AuHQQp5ma/iBF6lG2quO94+IuJx0ZEbK9bPiVszmk/dICzX7Iz1zh8cXZPdZuNFcVnpIz9qZTD3aCYaRq4XTn2wfyH8KE80LL0ZDECkUZZ5HtsqlRhf14oN2E5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjE6RuP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjE6RuP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F4F1F000E9;
	Sat,  8 Aug 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786207143;
	bh=h7o1nC0DxpNnPx546UG6nVsXASrQ8v5bNXPJqt6d+TI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjE6RuP0dVMaXEip4FfoMab0EeVHXmf9sOlPwKBusycrRxt8cNsb9Y0MUWqQ4SVsK
	 Vqai35XJgd4lLwMyErFWcIVEO0YuJNBq5ZiPQu/Wytb9szyXBv8STOIaCbbq2jfhQt
	 BBzX4Jqyb/6pP+OETR+hvdK7jppkA75WJZ7/WOeYOhKeEU72qlvkm9Rv/k69CVJIry
	 phDRc03z3weAow20a/3qC4vC8MOZKRBGOOK5Vvz8SjKYvRCAsgp8IldKXNykKbSdm/
	 OJQfc0niXQM3tz/glkumEj/zW73cnh19xtCCkqGbriUP/mY9XIyXLW9IfyUnpCLr/0
	 jQU76ua8kaiYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260808161148.66673-3-amachhiw@linux.ibm.com>
References: <20260808161148.66673-1-amachhiw@linux.ibm.com>
 <20260808161148.66673-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 16:39:02 +0000
Message-Id: <20260808163902.E1F4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM_CAP_PPC_COMPAT_CAPS advertises capability support on all pseri=
es hosts, but the KVM_PPC_GET_COMPAT_CAPS ioctl fails with -EINVAL on non-n=
estedv2 pseries hosts.
--

--- Patch [2]: [PATCH v9 2/4] KVM: PPC: Book3S HV: Implement compat CPU cap=
ability retrieval for KVM on PowerVM ---
commit 48012da6c0966da1bf70f356cb9a87c22af64308
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on P=
owerVM

This commit adds support for retrieving host CPU compatibility capabilities=
=20
for nested guests on PowerVM via a new ioctl, KVM_PPC_GET_COMPAT_CAPS. It=20
retrieves the cached capabilities negotiated via the H_GUEST_GET_CAPABILITI=
ES=20
hcall for nestedv2 systems.

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

[Severity: High]
KVM_CAP_PPC_COMPAT_CAPS appears to be advertised for all pseries hosts in
kvm_vm_ioctl_check_extension():

	case KVM_CAP_PPC_COMPAT_CAPS:
		r =3D 0;
		if (hv_enabled && kvmhv_on_pseries())
			r =3D 1;
		break;

But here in kvmppc_get_compat_caps(), the ioctl returns -EINVAL for=20
non-nestedv2 pseries hosts.

Will this mismatch cause userspace (like QEMU) to fail during guest=20
initialization if it sees the capability is supported on a non-nestedv2=20
host, but the ioctl unexpectedly fails with -EINVAL?

> +	host_caps->compat_capabilities =3D capabilities & KVM_PPC_COMPAT_BITMAS=
K;
> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808161148.6667=
3-1-amachhiw@linux.ibm.com?part=3D2
