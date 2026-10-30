Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400889;
	b=G4c3Xo4nJSnEcOwYlAtm4VLFEIpYNV587H6bgY6si/AdfEQjZpW8T1DL09iU3IWhzoUJ
	 G513t242R3U8DLkKut5lfM3Kp36ND+K06Yvnj+5plpCmMI9d5RreutxVvBy6DwVJy9cRe
	 LMee+f1a1NXV+YH4kcVM4IfV9JcYah4u2S9GqSEuiUvnzRbpfBCx2RSV5Z9BHEN09WogA
	 lTnO9ueZLIi6MzzyneK4HuQ6yKx0KqRwHZnJg8l6+GuHsfMdc5gkFdg4udgeZnk1FHjs9
	 mzvZ3ERHIT3CpxY1/qmBzou38bIAtFRmTNwQcx06p/LIYQWjfYT3/ugUewvSIvw5HNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4Exs05TE2CTubRp7DwXuZyJSeW2aoHx0kxwgf2fsjv0=;
	b=j4qVbNo6MuC2ZvK4TAMbEywMAzkrsiLhJkKmjAieMnpjlWWfXdhIkPy878mRE9rM/9sS
	 4IsAtkl+2rlylIUhftU8XwKFx6FATcNTqumMvS4NwODkJy5Voo3jIZP5kNhzihm9VfyEV
	 pYGzoX+s7J0bR0FBeGdcVSnX1CdIwrU4gCqy1k2r0l1PSAU2VFR4F4szkWKDBBeJiq1u2
	 TXz4DBIFxWYmukvSdqSUj+IPCG2bc9M3hygvOyXJwCsNtOvqIQHP4t0oCuFZVdwNKbBAM
	 eR9ab75dShPJNrynEFyB/73r+VReH6KnwXvFJ5seW4QqcY26h0LXTcbsuuJUDMMClZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIzOw+V8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F719606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIzOw+V8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177241F000C1;
	Fri, 30 Oct 2026 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400889;
	bh=4Exs05TE2CTubRp7DwXuZyJSeW2aoHx0kxwgf2fsjv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VIzOw+V8HUas4cwEghfAuldw3v0NcVkuL9XY2h9Ke1bhzGhmlBOV7s3VgSZt7YoS2
	 PszAm/fr5qTQ0lshh8enTpwcgZ2ptF3LPS+BCg+5XMaOI/c3VKywclsx8N6wZIm6fd
	 l/c6KBkEz6Zz3NeIwSf/jaMtvuZFIouMjyJPirv0WuYhZRlezBMmsStn3XPYJZaJIs
	 oaxjv4pUY+nAS16H1HhaUw+FsKK56JQaqZizuxv4lx/McbkY2wU+5Kq3ETN+P3JB+t
	 op/0MdcRyx4Jh6tBLpqtx+996JMWoMUSrba2kIrwel4I34rRekmi/KMdP6TtLHYPsA
	 lVveGEWFGsFGg==
Message-ID: <sashiko-outbox-191606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/23] KVM: x86: Map a separate VMA for each address
 space for internal memslots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261030212112.2598640-11-seanjc@google.com>
References: <20261030212112.2598640-1-seanjc@google.com>
 <20261030212112.2598640-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:54:48 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] KVM: x86: deferred init of __free(fput) in __x86_set_memory_region()
--

commit cfd5ddf3a5baa5fbd0b9d7dc48b7ac7a5d553771
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Map a separate VMA for each address space for internal memslots

This commit maps a separate VMA for each address space when installing
internal memslots by creating an explicit shmem file via
shmem_kernel_file_setup() so both memslots' VMAs point at the same backing
page, allowing each address space's memslot VMA to be unmapped independentl=
y.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0b94f981a2e1c..8cb58040dd81a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -10047,7 +10062,8 @@ static int x86_set_internal_memslot(struct kvm *k=
vm, int id, int as_id,
>  void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
>  				      u32 size)
>  {
> -	unsigned long hva;
> +	struct file *f __free(fput) =3D NULL;
> +	struct kvm_memory_slot *slot;
>  	int i, r;
> =20
>  	lockdep_assert_held(&kvm->slots_lock);
> @@ -10055,37 +10071,31 @@ void __user * __x86_set_memory_region(struct kv=
m *kvm, int id, gpa_t gpa,
>  	if (WARN_ON(id >=3D KVM_MEM_SLOTS_NUM))
>  		return ERR_PTR_USR(-EINVAL);
> =20
> -	if (size && id_to_memslot(kvm_memslots(kvm), id))
> -		return ERR_PTR_USR(-EEXIST);
> -
>  	if (size) {
> -		/*
> -		 * MAP_SHARED to prevent internal slot pages from being moved
> -		 * by fork()/COW.
> -		 */
> -		hva =3D vm_mmap(NULL, 0, size, PROT_READ | PROT_WRITE,
> -			      MAP_SHARED | MAP_ANONYMOUS, 0);
> -		if (IS_ERR_VALUE(hva))
> -			return (void __user *)hva;
> -	} else {
> -		hva =3D 0;
> +		if (id_to_memslot(kvm_memslots(kvm), id))
> +			return ERR_PTR_USR(-EEXIST);
> +
> +		f =3D shmem_kernel_file_setup("kvm_memslot", size, EMPTY_VMA_FLAGS);
> +		if (IS_ERR(f))
> +			return (void __user *)f;
>  	}

[Severity: Low]
This isn't a bug, but in __x86_set_memory_region() the __free(fput) variabl=
e f
is declared and initialized to NULL at the top of the function and then
assigned later inside the if (size) block, whereas include/linux/cleanup.h
documents that __free() variables should be defined and initialized in a
single statement to preserve reverse-declaration cleanup ordering.

If the id_to_memslot(kvm_memslots(kvm), id) check is kept before the
declaration of f, could f be defined and initialized in a single statement,
for example:

	struct file *f __free(fput) =3D size ?
		shmem_kernel_file_setup("kvm_memslot", size, EMPTY_VMA_FLAGS) :
		NULL;
	if (IS_ERR(f))
		return (void __user *)f;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212112.2598=
640-1-seanjc@google.com?part=3D10
