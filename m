Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F5272803
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156041; cv=none; b=KV74jx85tUbbJ9rFObO8orZ4s0F6JwEUENxXBlLAnVHQHrpoczDNqIJk4mgFunnWlWIm5h3fWxgtSNgsDhrFMba5v2PscvMiNqlo8Y1+AOihB8Jaqfro8aVwc6ttS4u7Vwxc9UGEODltkmQRtJWrXL2M+ucv5BOViBOoP36bOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156041; c=relaxed/simple;
	bh=GALoTTFXkSDU5vW3UI1/pY9lqRaXSmrN/FN/UJpAe/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sc0AAJ2bZETpggzpBRlJ7L4Tdfuk34kx3FG4qzJoKWMld30ur7BW3cacdUvqk1vzv7PHWOFyyKRAc3X4+zaAHP9HjYNUMsDF/Vk6mPG4nlqzjU/aHQ6JJG7ECHcfc7pfIESAwKrkB2SeXjy2VffDKl4CH3YFn9CsVLzvuOeTveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBPmdZXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBPmdZXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5301F000E9;
	Sat,  8 Aug 2026 02:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786156039;
	bh=l1TxX6kATGshx30+75r62NTB9xYXMcD0XUWpDEEcOEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBPmdZXhhIV2z0jSfF+N1BXj3PoYJkjN2PZ0cj6By2gDTz0cy33ew4ByyXR6C6tW2
	 3aJxc6eET8V4ogFKKix/UQwJjYc3xx92joPp4gRJBikrHmG3AFInDuYuT0VkNxfmzp
	 tJhVPTE7ig5Asa5J/+2xDB10J3nvpACAeIW8ldUalRGq8zDY8YBfnI6tiwJIfMzJ/B
	 TRm8sLJib5TPamRnoqVpb2i91Q14VxGjhWNqAqFQV5BFHnVcWJBlkKIKvk4wWTUlKp
	 wJ6i907Iv7vTSxrCxSlT9iilBUGV7cM7D90nlNWgEOIiZ6cb8gN23sb5A/J8+z4fBf
	 kFioLtOl5/QdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vduse: reject non-coherent iotlb entries in the
 coherent fault path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <yuz08559@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807022657.11318-1-yuz08559@gmail.com>
References: <20260807022657.11318-1-yuz08559@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 02:27:19 +0000
Message-Id: <20260808022719.9E5301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch fa=
ils to completely mitigate the pre-existing arbitrary physical memory read/=
write vulnerability because an attacker can map the VDUSE domain file descr=
iptor and use it to trivially bypass the new backing file check.
--

--- Patch [1]: [PATCH] vduse: reject non-coherent iotlb entries in the cohe=
rent fault path ---
commit f4c50be37a9ca120f63ebae4dfab39a075d198c4
Author: Yu Zhang <yuz08559@gmail.com>

vduse: reject non-coherent iotlb entries in the coherent fault path

This commit attempts to fix a vulnerability where non-coherent IOTLB entries
are treated as physical addresses in the coherent fault path. It introduces=
 a
check to ensure the backing file of the IOTLB entry matches the domain's fi=
le,
assuming only valid coherent mappings use this file.

> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index b6c958224b7ce..aee0ae1c408e0 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c

[ ... ]

> @@ -234,6 +235,17 @@ vduse_domain_get_coherent_page(struct vduse_iova_dom=
ain *domain, u64 iova)
>  	if (!map)
>  		goto out;
> =20
> +	/*
> +	 * Only coherent allocations made by this domain are backed by a real
> +	 * struct page here: their map->addr is a physical address and their
> +	 * backing file is the domain's own anon inode. Entries installed via a
> +	 * vhost IOTLB message on a use_va device instead carry a userspace
> +	 * virtual address in map->addr, and must never be fed to pfn_to_page().
> +	 */
> +	map_file =3D (struct vdpa_map_file *)map->opaque;
> +	if (map_file->file !=3D domain->file)
> +		goto out;

[Severity: Critical]
This is a pre-existing issue, but does this check completely mitigate the
vulnerability?

An attacker can obtain the domain->file descriptor via the VDUSE_IOTLB_GET_=
FD2
ioctl and mmap() it into their address space. If they use this new virtual
address in a VHOST_IOTLB_UPDATE message, vhost_vdpa_va_map() will assign th=
is
same domain->file to the mapping's vm_file.

When the attacker triggers a page fault on this IOVA in
vduse_domain_get_coherent_page(), map_file->file will match domain->file,
successfully passing this check. The kernel will then pass the attacker's
arbitrary virtual address to pfn_to_page(), allowing them to regain arbitra=
ry
physical memory read/write access.

> +
>  	page =3D pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
>  	get_page(page);
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807022657.1131=
8-1-yuz08559@gmail.com?part=3D1
