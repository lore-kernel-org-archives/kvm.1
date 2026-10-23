Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798314;
	b=X4S4iHKDcGW+s4PZHXAPGCZitTUt5/pmiK9rB/krnCy/pP4or1ft36SjJMkUFyc1PIEC
	 8mY8CEuij1NnjJmNkZSvuDjRvtwRpfPGLjKgzoDDOldX85bvWR4gtY2Bxk0Vt87uNKIEs
	 UrIVMVVqhbZn6CPB8B6nd2ucbn/oMuH3r71VRFaWe4vgD5CZvtR3QcABjuaIolCI+NHgn
	 9jr48WEj1HZZxmjmxH5DakIavlqrqQD1zOz6+W5Px0d8SbgLgwM2FIfk8B1KLTzKn8/bj
	 +/Q6Dq4gwN60UsYNSH+UptzgSWn4HgyWQs0KRPVZgU1Tk8YYOb9Pa7wYleyyWgb5xLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798314;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5bjJFk+v2VM6jIzv5dqQrWQg9guvgZ0tXLyEbsXbjrU=;
	b=UhhyTjy9P5e7ayYEIEAdzvSOnXf2f6rSjyN1ImH86yDFB2uJdU2Z9elbptxAAjzPVVpB
	 7SSF7SPwqrt1I2subErM9Lb6E4qMlZiU32OfcrtxAn+lf5eZEdKEISnYfYJ2RqZCsfyOe
	 Bf75UVJNLwmbwy7Q0wtZezUcWWGgnfc2CO6Xsm0Z2o66HjRQKROHEWldowxilug6l3kQN
	 pu92b30l1/6fF1g5+Zcx6zyLb2X9DP6O7S3m+1zPXcfEDy87c1ckFiclkUN6SUliu2iF7
	 gKLDrWHAkMUzbX3tBN9yDXsxFW5GeZAgJ1/hGeGyd9DtVTOug793wvZGF0w/ftMuydg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3oHt3+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F002606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3oHt3+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F841F01829;
	Fri, 23 Oct 2026 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798313;
	bh=5bjJFk+v2VM6jIzv5dqQrWQg9guvgZ0tXLyEbsXbjrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3oHt3+w30ueiZQs0Jysx3UROGDXHub465LmDmz/W789N1UpFE7Ydn/+cCuhnCpX6
	 iKYf3vUg5IhxSRCljLS1HShJE170m9aRK4Z5pX3H7hQXaFPwg2HHw65ghKmFYqhuVn
	 vOPWLArfNRNWenZNnpBCk7cRnp9CwU4QHovKDLVN4p63B9SwpzN/hpRFDESGnnciDq
	 Acj+1ythwuezgC/pw0x+cmEnWO1ngSPeGYBvEBQL0ApdBurVjJTPmPSjSpDgrcVajx
	 XHj4QFaX8iicZD7avsCiNKjiBVf5FLJC4QGGRnOW77b3xMSZYjzizBMR1CAh0Es70C
	 Newgs+rcqDmzw==
Message-ID: <sashiko-outbox-183369@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 05/50] KVM: guest_memfd: Support using resource
 provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alex Williamson" <alex@shazbot.org>, "Alexander
 Graf" <graf@amazon.de>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexey
 Kardashevskiy" <aik@amd.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Ashish Kalra" <ashish.kalra@amd.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Baolu Lu" <baolu.lu@linux.intel.com>, "Bill
 Wendling" <morbo@google.com>, "Borislav Petkov" <bp@alien8.de>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Brauner" <brauner@kernel.org>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Fred Griffoul" <griffoul@gmail.com>, "Gregory
 Price" <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, "Hugh Dickins" <hughd@google.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Jianxiong Gao" <jxgao@google.com>, "Joerg
 Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John Starks" <John.Starks@microsoft.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Justin Stitt" <justinstitt@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Sean
 Christopherson" <seanjc@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261022-gmem-alternative-providers-v2-5-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-5-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:31:50 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kvm: guest_memfd: kvm_gmem_create() checks resource_fd when flag i=
s not set
- [High] KVM: guest_memfd: movable allocation of unmovable tmpfs-provided f=
olios
- [Medium] KVM: guest_memfd: fget_raw() mismatch with f_op in kvm_gmem_atta=
ch_resource()
--

commit 82719b2c47dfb94fadcdf6f025718ccc05e83332
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support using resource provider

This commit adds the GUEST_MEMFD_FLAG_USE_RESOURCE flag and resource_fd
parameter to KVM_CREATE_GUEST_MEMFD so that guest_memfd inodes can attach
to an external resource provider via resource_file->f_op->gmem_provider_ops
and release the provider on inode destruction.

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8dff2fc1972e9..f4108bf7e3192 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1674,11 +1674,14 @@ struct kvm_memory_attributes2 {
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_gue=
st_memfd)
>  #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
>  #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
> +#define GUEST_MEMFD_FLAG_USE_RESOURCE	(1ULL << 2)
> =20
>  struct kvm_create_guest_memfd {
>  	__u64 size;
>  	__u64 flags;
> -	__u64 reserved[6];
> +	__s32 resource_fd;
> +	__u32 pad;
> +	__u64 reserved[5];
>  };
> =20
>  #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_mem=
ory)
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
Why does kvm_gmem_attach_resource() use fget_raw() here when looking up
resource_file, and then read ops from resource_file->f_op?

In fs/file.c, the only difference between fget() and fget_raw() is that
fget_raw() accepts O_PATH (FMODE_PATH) file descriptors:

fs/file.c:
    struct file *fget(unsigned int fd)
    {
        return __fget(fd, FMODE_PATH);
    }

    struct file *fget_raw(unsigned int fd)
    {
        return __fget(fd, 0);
    }

However, in fs/open.c:do_dentry_open(), any file opened with O_PATH (such
as a mount fd from fsmount() or open_tree(), or a directory opened with
O_PATH) has f->f_op set to &empty_fops rather than inode->i_fop:

fs/open.c:do_dentry_open() {
    ...
    if (unlikely(f->f_flags & O_PATH)) {
        f->f_mode =3D FMODE_PATH | FMODE_OPENED;
        file_set_fsnotify_mode(f, FMODE_NONOTIFY);
        f->f_op =3D &empty_fops;
        return 0;
    }
    ...
}

As a result, when userspace passes an O_PATH fd as resource_fd to
ioctl(KVM_CREATE_GUEST_MEMFD) with GUEST_MEMFD_FLAG_USE_RESOURCE,
resource_file->f_op->gmem_provider_ops is always NULL and attaching fails
with -EOPNOTSUPP.

If O_PATH descriptors are meant to be supported, should this read
gmem_provider_ops from file_inode(resource_file)->i_fop instead of
resource_file->f_op? Conversely, if O_PATH descriptors are not intended to
be supported, should this use fget(resource_fd) so O_PATH descriptors fail
with -EBADF (and drop the NULL check on resource_file->f_op)?

> +
> +	if (ops && ops->attach && ops->alloc_folio)
> +		provider =3D ops->attach(inode, resource_file);

[Severity: High]
When attaching a tmpfs resource provider via kvm_gmem_attach_resource(),
can allocating folios through ops->alloc_folio() place unmovable
guest_memfd pages into ZONE_MOVABLE or MIGRATE_CMA/MIGRATE_MOVABLE
pageblocks?

In virt/kvm/guest_memfd.c:kvm_gmem_init_inode(), guest_memfd inodes
configure GFP_HIGHUSER (without __GFP_MOVABLE) and mark the mapping as
inaccessible because guest_memfd folios are neither migratable nor
swappable:

virt/kvm/guest_memfd.c:kvm_gmem_init_inode() {
    ...
    mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);

    /*
     * guest_memfd memory is neither migratable nor swappable: set
     * inaccessible to gate off both.
     */
    mapping_set_inaccessible(inode->i_mapping);
    ...
}

Native allocation in gmem_native_alloc_folio() uses
mapping_gfp_mask(gi->vfs_inode.i_mapping) (GFP_HIGHUSER). However, when a
tmpfs resource provider is attached and populated via
kvm_gmem_get_folio() -> gmem_provider_alloc_folio() ->
shmem_gmem_alloc_folio(), mm/shmem.c allocates the folio with
GFP_HIGHUSER_MOVABLE before kvm_gmem_get_folio() inserts it into the
AS_INACCESSIBLE guest_memfd mapping:

mm/shmem.c:shmem_gmem_alloc_folio() {
    ...
    if (mpol)
        folio =3D folio_alloc_mpol(GFP_HIGHUSER_MOVABLE, 0, mpol, index,
                                 numa_node_id());
    else
        folio =3D folio_alloc(GFP_HIGHUSER_MOVABLE, 0);
    ...
}

Because kvm_gmem_migrate_folio() rejects migration with -EINVAL and
isolate_migratepages_block() / move_to_new_folio() refuse to migrate
mapping_inaccessible() folios, allocating these folios with __GFP_MOVABLE
pins movable and CMA pageblocks and can cause memory hot-unplug
(offline_pages()) to fail or loop when attempting to migrate them.

Should gmem_provider_alloc_folio() pass mapping_gfp_mask(inode->i_mapping)
(or should shmem_gmem_alloc_folio() use GFP_HIGHUSER instead of
GFP_HIGHUSER_MOVABLE)?

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

[Severity: High]
Could checking args->resource_fd when GUEST_MEMFD_FLAG_USE_RESOURCE is not
set cause a userspace ABI regression for existing KVM_CREATE_GUEST_MEMFD
callers?

Prior to this change, struct kvm_create_guest_memfd in
include/uapi/linux/kvm.h had __u64 reserved[6] after flags, and neither
kvm_vm_ioctl() nor kvm_gmem_create() verified that reserved[] was zeroed
(and Documentation/virt/kvm/api.rst did not require reserved[] to be zero).

Because resource_fd is carved out of reserved[0] and gated by
GUEST_MEMFD_FLAG_USE_RESOURCE, any existing userspace caller that allocates
struct kvm_create_guest_memfd on the stack and only initializes .size and
.flags (or initializes unused fd fields to -1) without setting
GUEST_MEMFD_FLAG_USE_RESOURCE will now fail with -EINVAL in
kvm_gmem_create(). Meanwhile, args->pad and args->reserved[0..4] remain
unchecked.

Should args->resource_fd only be inspected when
GUEST_MEMFD_FLAG_USE_RESOURCE is set in flags (similar to how
KVM_SET_USER_MEMORY_REGION2 only inspects guest_memfd and
guest_memfd_offset when KVM_MEM_GUEST_MEMFD is set)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D5
