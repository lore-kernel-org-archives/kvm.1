Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1370384233
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379243; cv=none; b=bi7SMw0Y8SDXBYimyLgTtKBh/ea8k4vLC7JVTqn1Z9QOmtzR7K85Ncir9tipHpNtbpiMRc1mmbj6qVDTx+OO6RApE9mOvvfKTHLrZTpnjtCjkc6kE9oX8E6e0gDMm9IXxJBVbdkdYGTb1/5gbr0qgIvVsLIV7o6oNLOs7os1UGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379243; c=relaxed/simple;
	bh=Ls1c7NBq74hyU0RwKRJnsrC02uIsy/RCQhfgWXWJGjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gue+auy+UgAX/67KvMa8N5AybgAcy7GHfFkc7VLmk7gNX+zpFxFJcUUSkGMIl7jGwEqIADVXQ+v8gQCVb3gobPpjc3YmiSvrNpWtPj1qUjt34Vnd7+TlBssA1shgHh8BAmxnkUW9bBKOFoXoz8IvKS/gBJ8ThLgAWVlfydLzhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eATKehdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eATKehdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0DA1F000E9;
	Wed,  2 Sep 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379241;
	bh=kSaRGxKXPUbjEbgbp3OOyMFKfZOW485p3QNHfthyefE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eATKehdB1NDA1U+EC05RKmHD0vXJFqli3pOgVoTc7O/wpv2eOj4IuhrPjidhBer2R
	 tZy3UYjm62NBHGBK51EvwTxswcelxdZZyqNGDdHBG3zwpnZOKehNlo0eOq6D7iHVG5
	 7aSYsCIQszcl3U7ASZthcYebzuy946pjdxRmCuARkIEzY2HfyKSAeTUcpMXFLcW2wQ
	 0DCQSf3LH8pQXRsiYn0ksgCki5pcZZbCTv+ElX3GOIcmRwewqFaMM4PGJ3HuT7Ko89
	 h+nYD0UkaYIPRqTTCUupuUzA6jdSzlaNKine7Kthv//OA5TrKdwIk6rVAy2NiAhDuZ
	 hThAeBWAikbvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] KVM: guest_memfd: bind backing memory to a NUMA
 node at creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902194657.79075-4-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
 <20260902194657.79075-4-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:00:41 +0000
Message-Id: <20260902200041.8E0DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Validation of flag-gated syscall parameters outside their flag=
 gate breaks ABI compatibility for existing userspace applications.
--

commit 431a72230c55ac38f268a69346922d329c315246
Author: Gregory Price <gourry@gourry.net>

KVM: guest_memfd: bind backing memory to a NUMA node at creation

This commit introduces the bind node flag to kvm_gmem_create, allowing a
guest_memfd to be bound to a specific NUMA node at creation time. It
replaces a portion of the reserved fields in struct kvm_create_guest_memfd
with node and pad fields. The node policy is then applied to the
underlying inode.

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index ac2d77d149635..8d3ae7e2ead8e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
> @@ -1658,11 +1658,14 @@ struct kvm_memory_attributes {
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_gue=
st_memfd)
>  #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
>  #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
> +#define GUEST_MEMFD_FLAG_BIND_NODE	(1ULL << 2)
> =20
>  struct kvm_create_guest_memfd {
>  	__u64 size;
>  	__u64 flags;
> -	__u64 reserved[6];
> +	__u32 node;
> +	__u32 pad;
> +	__u64 reserved[5];
>  };
> =20
>  #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_mem=
ory)
[ ... ]
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 625e62e1a0318..dc9f071dd969b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -593,6 +624,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_creat=
e_guest_memfd *args)
>  {
>  	loff_t size =3D args->size;
>  	u64 flags =3D args->flags;
> +	int node =3D NUMA_NO_NODE;
> =20
>  	if (flags & ~kvm_gmem_get_supported_flags(kvm))
>  		return -EINVAL;
> @@ -600,7 +632,15 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_crea=
te_guest_memfd *args)
>  	if (size <=3D 0 || !PAGE_ALIGNED(size))
>  		return -EINVAL;
> =20
> -	return __kvm_gmem_create(kvm, size, flags);
> +	if (flags & GUEST_MEMFD_FLAG_BIND_NODE) {
> +		if (args->pad || args->node >=3D MAX_NUMNODES)
> +			return -EINVAL;
> +		node =3D args->node;
> +	} else if (args->node || args->pad) {
> +		return -EINVAL;
> +	}

[Severity: Critical]
Could this strict check in kvm_gmem_create() on args->node and args->pad
cause a regression for existing userspace applications?

Since these fields were previously part of the ignored reserved array,
legacy binaries invoking the ioctl without the new bind node flag might
leave these stack or register slots uninitialized. Enforcing them to be
zero outside of the flag gate could cause these legacy calls to
unexpectedly fail with an invalid argument error.

> +
> +	return __kvm_gmem_create(kvm, size, flags, node);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902194657.7907=
5-1-gourry@gourry.net?part=3D3
