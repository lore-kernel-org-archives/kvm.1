Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92E314B76
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226966; cv=none; b=DJcewIBxVZ59VMjMV4f509pDfTq7hnUki9lq4GuSoocxGy/K/UvfcZJzYQB7dFOimie+AhGeccYxDB40J3LQ0tOl6hE8lk6AZbuk7eNTy1TCIdUVX1F36uZwm/Ll/R/9Fn37pCbuQrPifBYrw8jt0GOuQJfk6VLQMIqUZpQ898k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226966; c=relaxed/simple;
	bh=nsunuy73daPfuh4F3WKyH2UkWImENDo5qrwLQEI/mxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEMSp+G9MVDNg79ycRyNToXqzaWOMHzgDUPDJK6zxsXeamaEjhmmdTyoU25RfRpQpDi8aCt0z5TdTeLbHz1csj76y8UP1SgeMkq80IJPk/ED8miTV98XastP2yGHDiOqj7cNLSK+uzgrpqrnxy84HI0YLZOFgd7DoHJvnx8P9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0dISaoq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0dISaoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126541F000E9;
	Thu, 16 Jul 2026 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226965;
	bh=tlWxPo49CDCoo4VEOn/9DyepZwPwhgPJitu7JfPO1d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0dISaoqvrK00AVCP2BSA7pXNfKQGoSDp+HcKjZYRu6lXQmV14RtkZSDSKRqtr+lD
	 ipk6GEBZxccsi+luj4Pt3nLN9mdMAJkPWiDVYeDpiXIgGnA1qAShnenoxM/1l/cVX+
	 7Tkm4Jg+3w9tjkY3NgFZXODm713Zny5lmPwnVq/3gMqc68VSC0StcqLcnJtgWakTsc
	 NPCxU9GS+36WDGzPyr7Ch1YLGtj4kbXq5jh02X3oqpbNxZAAc9APP7brvtNxOq+go1
	 fKVVSGpUeRDatQ1BZnF34mQGCb+sD+1WzkyIwdmmldnIZHHEjNvn11dHFbFra0aquy
	 OpbWfV3lTBbVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/24] KVM: Take memory protections into account in
 kvm_read/write_guest()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-12-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:36:04 +0000
Message-Id: <20260716183605.126541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Cached guest memory accesses bypass memory attribute protectio=
ns.
--

--- Patch [11]: [PATCH 11/24] KVM: Take memory protections into account in =
kvm_read/write_guest() ---
commit 2db3d9f175080ff067377dd7b0148b9955953e26
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Take memory protections into account in kvm_read/write_guest()
   =20
This patch adds memory attribute checks to the kvm_read_guest() and
kvm_write_guest() family of functions. It plumbs the kvm struct to the
internal page accessors so they can query memory attributes. If the
attributes do not permit the access, the functions return an error.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 56016aab0aad3..d920ce5b67392 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -3261,6 +3261,10 @@ static int __kvm_read_guest_page(struct kvm_memory=
_slot *slot, gfn_t gfn,
>  	addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
>  	if (kvm_is_error_hva(addr))
>  		return -EFAULT;
> +
> +	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
> +		return -EFAULT;
> +

[Severity: Critical]
Since memory attributes are now enforced for standard guest reads and write=
s,
do the cached memory accessors also need to enforce these protections?

Functions like kvm_read_guest_offset_cached() and
kvm_write_guest_offset_cached() appear to read and write directly using the
cached HVA without verifying attributes:

virt/kvm/kvm_main.c:kvm_read_guest_offset_cached() {
    ...
    if (kvm_is_error_hva(ghc->hva))
        return -EFAULT;
    ...
    r =3D __copy_from_user(data, (void __user *)ghc->hva + offset, len);
    ...
}

Similarly, host kernel mapping paths like __kvm_vcpu_map() use
kvm_follow_pfn() and map guest memory without checking attributes:

virt/kvm/kvm_main.c:__kvm_vcpu_map() {
    struct kvm_follow_pfn kfp =3D {
        .slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn),
        .gfn =3D gfn,
        ...
    };
    ...
    map->pfn =3D kvm_follow_pfn(&kfp);
    ...
}

And gpc resolving paths like hva_to_pfn_retry() in virt/kvm/pfncache.c also
rely on kvm_follow_pfn() directly.

Could a malicious guest bypass memory attribute protections (e.g., read/wri=
te
restrictions or private memory boundaries) by pointing a cached memory
structure, such as a virtio ring or APIC, to restricted memory?

Also, if memory attributes are dynamically updated, how do we ensure
gfn_to_hva_cache and gfn_to_pfn_cache are properly invalidated, given that
attribute updates don't seem to bump the memslot generation or trigger
gfn_to_pfn_cache_invalidate_start()?

>  	r =3D __copy_from_user(data, (void __user *)addr + offset, len);
>  	if (r)
>  		return -EFAULT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D11
