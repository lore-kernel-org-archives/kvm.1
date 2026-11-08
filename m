Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098635;
	b=xO6S1qJ/CrWQk0K5FWeSp0PCyLgzIO8YpeiRszW9MP5rVH0vV74rjl3W6wTSxGZWJZtJ
	 snMnEuumyRCJonaULJIclE5ugNaHWUXPCoBRJf34Gl2xAsNI+nbgA5t7srh8RkG11xy8U
	 BFkKN7eq750MZvqKm6ZXJnMgmvgIJmtVKUG4mX87q/3TFWyG4mHRthsV6jAJK2PlX2Voo
	 yh1tSjwpuzSx4FAKRWdA7i/NToBKnJtARNvsmyGPON7EPMgkn5BbhQaRkIzwuPdJ1dTIq
	 Ez/thq71uXpjp8FzYztrrqxqWsJtG6JRsGXANwMCCQusHEedr+upf88RVthz045/weg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5lTFbTp8SX1BqlpqFeKD2Roy979BsH+gPIoXkiOvO60=;
	b=IevJHDj6ktbBcfgFe+JJKGLTBUQ7HxD9WWrH7BxsdIcvqOMxEZYGlTP+yLejB/PbrI4V
	 tkYmhVeBscHCPXKDa0lTeP/A7abdJ97bV97/Ocu89AvUnL1SlwOAuTIJCggPkMMMvX4xw
	 mQe29WSTDbEi3xFPkxW1RkxFsIAQYc/X7J+Ubx2w2/kGT/9VL8cmNN9NaLzcEi/qPacHC
	 BQgxFSYuK/Qj+3Y7AtyBaX6+CyBOSqNil9Mgrswg2cN4FcwR+iHJW0wlnnIlw8WpFsZ9B
	 toUMxQQECBkCa1LkSJ6jI/WnXRSKf30CUxpIENB0OgVbZIctJFM/DD2e6/DOpwpoCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lX8TDov4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6F606A33D
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lX8TDov4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A61F008A2;
	Sun,  8 Nov 2026 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098634;
	bh=5lTFbTp8SX1BqlpqFeKD2Roy979BsH+gPIoXkiOvO60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lX8TDov4ULNLvQ10fcrEqtKKu13fip9QIJo5CePbMJ8NETJvjJ9S2FNv+jKFHoe7g
	 VQcOypSIbAzMrdXoS7G/+mRnuOSnPPULxsRuJsZP4yBmcGDtcvERXSNV3yxSdEuHsn
	 Qr/2wmoUgCoN64RU7558YaG2EwPhCMeZhvO70rncM9rBbq1lGnTDI8c+ptucVqFtjL
	 JCZLF2On7pd3qK4rtv+jNkWXu+rYnOoiA9c9N+QIP+NpU+E4mAQkMmFKQtLKaJU8WC
	 utj+TXwK5Hi48SMtGqZ61YvZckB/NEh9hzl1RkhLa2WQJjHhOHdJjTjmZ0zzJog0L5
	 Fu/00n9BEhDEg==
Message-ID: <sashiko-outbox-203416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 05/88] KVM: guest_memfd: Support using resource
 provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-5-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-5-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] KVM: guest_memfd: movable allocation of unmovable
  tmpfs-provided folios
- [Medium] KVM: guest_memfd: fget_raw() mismatch with f_op in
  kvm_gmem_attach_resource()
- [Medium] kvm: guest_memfd: kvm_gmem_create() checks resource_fd when
  flag is not set
--

commit 120a9139413a4330ef86fed3c561aeed63c5587f
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support using resource provider

This commit adds the GUEST_MEMFD_FLAG_USE_RESOURCE flag and resource_fd
field to struct kvm_create_guest_memfd so guest_memfd instances can attach
to and release an external memory resource provider.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ee823f2ef0368..84877beed6701 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -85,15 +85,26 @@ static const struct guest_memfd_provider_operations g=
mem_native_provider_ops =3D {
>  static int kvm_gmem_attach_resource(struct inode *inode, int resource_fd)
>  {
>  	const struct guest_memfd_provider_operations *ops =3D NULL;
> +	void *provider =3D ERR_PTR(-EOPNOTSUPP);
>  	struct file *resource_file =3D NULL;
> -	void *provider;
> =20
> -	if (resource_fd =3D=3D GMEM_RESOURCE_FD_NATIVE)
> +	if (resource_fd =3D=3D GMEM_RESOURCE_FD_NATIVE) {
>  		ops =3D &gmem_native_provider_ops;
> -	else
> -		return -EOPNOTSUPP;
> +	} else {
> +		resource_file =3D fget_raw(resource_fd);
> +		if (!resource_file)
> +			return -EBADF;
> +
> +		if (resource_file->f_op)
> +			ops =3D resource_file->f_op->gmem_provider_ops;
> +	}

[Severity: Medium]
Why does kvm_gmem_attach_resource() use fget_raw() and then read
resource_file->f_op->gmem_provider_ops?

fget_raw() only differs from fget() by accepting O_PATH file descriptors
(such as descriptors from fsmount(), open_tree(), or open(..., O_PATH)),
for which do_dentry_open() sets f->f_op to &empty_fops rather than
inode->i_fop.  As a result, any O_PATH descriptor accepted by fget_raw()
finds resource_file->f_op->gmem_provider_ops =3D=3D NULL and fails with
-EOPNOTSUPP.

If O_PATH descriptors are meant to be supported, gmem_provider_ops needs
to be read from file_inode(resource_file)->i_fop; otherwise, fget() should
be used so O_PATH descriptors are rejected with -EBADF.

> +
> +	if (ops && ops->attach && ops->alloc_folio)
> +		provider =3D ops->attach(inode, resource_file);

[Severity: High]
Does attaching a tmpfs provider place non-migratable guest_memfd folios
into movable pageblocks and ZONE_MOVABLE?

kvm_gmem_init_inode() marks inode->i_mapping with
mapping_set_inaccessible() and GFP_HIGHUSER because guest_memfd folios
cannot be migrated: kvm_gmem_migrate_folio() returns -EINVAL and
move_to_new_folio() rejects mapping_inaccessible() folios with
-EOPNOTSUPP.  However, when attached to tmpfs via shmem_gmem_provider_ops,
kvm_gmem_get_folio() calls shmem_gmem_alloc_folio(), which allocates with
GFP_HIGHUSER_MOVABLE before inserting the folio into the inaccessible
guest_memfd mapping:

mm/shmem.c:shmem_gmem_alloc_folio() {
    ...
	if (mpol)
		folio =3D folio_alloc_mpol(GFP_HIGHUSER_MOVABLE, 0, mpol, index,
					 numa_node_id());
	else
		folio =3D folio_alloc(GFP_HIGHUSER_MOVABLE, 0);
    ...
}

Allocating non-migratable folios with __GFP_MOVABLE pins MIGRATE_MOVABLE,
MIGRATE_CMA, and ZONE_MOVABLE memory, breaking CMA allocations,
compaction, and memory hot-unplug.  shmem_gmem_alloc_folio() should omit
__GFP_MOVABLE (or honour mapping_gfp_mask(inode->i_mapping)) when
allocating folios for guest_memfd.

[ ... ]

> @@ -1111,6 +1128,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_=
t size, u64 flags)
> =20
>  int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  {
> +	int resource_fd =3D GMEM_RESOURCE_FD_NATIVE;
>  	loff_t size =3D args->size;
>  	u64 flags =3D args->flags;
> =20
> @@ -1120,7 +1138,15 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_cr=
eate_guest_memfd *args)
>  	if (size <=3D 0 || !PAGE_ALIGNED(size))
>  		return -EINVAL;
> =20
> -	return __kvm_gmem_create(kvm, size, flags);
> +	if (flags & GUEST_MEMFD_FLAG_USE_RESOURCE) {
> +		if (args->resource_fd < 0)
> +			return -EBADF;
> +		resource_fd =3D args->resource_fd;
> +	} else if (args->resource_fd) {
> +		return -EINVAL;
> +	}
> +
> +	return __kvm_gmem_create(kvm, size, flags, resource_fd);
>  }

[Severity: Medium]
Does rejecting a non-zero args->resource_fd when
GUEST_MEMFD_FLAG_USE_RESOURCE is not set break backwards compatibility for
KVM_CREATE_GUEST_MEMFD?

Since 1a2b3c4d5e6f... wait - since a7800aa80ea4 ("KVM: Add
KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory"),
kvm_gmem_create() never validated that args->reserved[0..5] was zero.
Carving resource_fd out of reserved[0] and requiring args->resource_fd =3D=
=3D 0
when GUEST_MEMFD_FLAG_USE_RESOURCE is clear causes a regression (-EINVAL)
for existing userspace callers that leave reserved[] uninitialized on the
stack, or that initialize unused file descriptor fields to -1.  In
addition, args->pad and args->reserved[0..4] are still left unvalidated.

Should args->resource_fd only be inspected when
GUEST_MEMFD_FLAG_USE_RESOURCE is set (similar to how kvm_set_memory_region()
only inspects guest_memfd when KVM_MEM_GUEST_MEMFD is set)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D5
