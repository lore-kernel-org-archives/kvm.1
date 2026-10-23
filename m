Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798306;
	b=P6U5kEXGEXogistAoEZAvBJdf6zkM+/5PgIPyangMhKCwEH+PuwLGFRSq38gGytSgDZ1
	 O5BWXhj63w2K2uiXwgpvqJRtTx+tDDS4QWuXtGOLgBhta2oFVcyxQBZQJTzsT5vApYUdw
	 Kd5qxBtJz+S4/igVc82/dY87NHGPAGB7o8j5sUHHIZZTg/BozAES45BT+UfROPdEh63+P
	 Uv4uEfy21fM+M4DTMTybs9thoeG/eymHq7R95YGI5xJXytnGeAgIXSHoOlZMVHRcNkpCO
	 vFKcl0vMCKXjQYp9Qj9nmXEo+ZjmDR1b1EkxmaOK7S+ERezxrF71JY3zHyOzZAbPygw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0U/WoSsaRNQO1MenTP79HZhjU0z0zPCOkKNFxINsepk=;
	b=HZBhkiT4iukMR0bHs7oJl2slFg0e279CJ5nbCdvFCO5vr+yK4tOph8g65PY57f28WW0O
	 E3wvuCSpaWBlAhjK0+kUpBaFBS1fhnCn+EAAMsGuxgYedI5PrUyQlETgp3SYgwq/mqKs3
	 I1D+Z2ix5cG/IDGo12q3IM+295qpfOnWUKkV+rmheKFwfOVL/zYYphWK79k9DT7TdUYKq
	 /o+P8UgxySbOBKyV9Qlwhmx3Gy1iVHrzJgOSBBrXZw+vozweDz0zsUOj2rDzQ0WOovKGC
	 lUP4VkegZAP4HmS9O8WPz1UAmIWwFa3Ez4NTL/GNwdo7cF8sHOtvqzr/fq6YNH3E9GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRfO36dC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EA606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRfO36dC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73851F01825;
	Fri, 23 Oct 2026 23:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798305;
	bh=0U/WoSsaRNQO1MenTP79HZhjU0z0zPCOkKNFxINsepk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fRfO36dCskEVIkZdUyz1AP4sFNn3Vdizzf4q1mkANHNr0FdRfC1cT1dkho/liIZbN
	 Tvuu8o4tSzh1vHr94+Zt0gcIf4ZdXsZt794ecvWRA+P8mt+KLYIJYFV83ddcdnb5hN
	 njwUawLRHpfyj4ByNrTHlkIF7XPYj9UzAORGXOqes9M/qkTnYpYVeo4EkYHh9/7PXv
	 RzzIOvkL0YkbaF2pZOQx/5LPLJ5yucMi8K/Z9P8PJ55pZi85u+YyZ0OB/auUMRG1dR
	 llmZq4eXCFuY/1elRHGeiU1MEfh7laZv+z2HD70/UJs83Mwty9jtekPaLmYhIS11d4
	 hFNkMl2rBAxaw==
Message-ID: <sashiko-outbox-183367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 03/50] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
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
In-Reply-To: <20261022-gmem-alternative-providers-v2-3-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-3-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:31:42 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: shmem: reference count leak on sbinfo->mpol in shmem_gmem_allo=
c_folio()
- [High] mm: shmem: shmem_gmem_alloc_folio() allocates unmovable folios as =
movable
--

commit 88b5d5c54fc1c479ad407c9b1ae1787c3dad600e
Author: Ackerley Tng <ackerleytng@google.com>

mm: shmem: Implement guest_memfd provider operations for tmpfs

This commit adds guest_memfd_provider_operations to file_operations and
implements tmpfs memory provider callbacks on shmem_dir_operations so that a
tmpfs root directory file descriptor can provide backing memory to
guest_memfd.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 848316eaa7f4f..2a9faf8be7382 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c

[ ... ]

> @@ -5237,6 +5245,124 @@ static const struct inode_operations shmem_specia=
l_inode_operations =3D {
>  #endif
>  };
> =20
> +#ifdef CONFIG_KVM_GUEST_MEMFD

[ ... ]

> +static struct folio *shmem_gmem_alloc_folio(void *provider, pgoff_t inde=
x,
> +					    struct mempolicy *mpol)
> +{
> +	struct mempolicy *sb_mpol =3D NULL;
> +	struct vfsmount *mnt =3D provider;
> +	struct shmem_sb_info *sbinfo;
> +	struct folio *folio;
> +
> +	sbinfo =3D SHMEM_SB(mnt->mnt_sb);
> +	if (sbinfo->max_blocks &&
> +	    !percpu_counter_limited_add(&sbinfo->used_blocks,
> +					sbinfo->max_blocks, 1))
> +		return ERR_PTR(-ENOSPC);
> +
> +	if (!mpol) {
> +		sb_mpol =3D shmem_get_sbmpol(sbinfo);
> +		mpol =3D sb_mpol;
> +	}
> +
> +	if (mpol)
> +		folio =3D folio_alloc_mpol(GFP_HIGHUSER_MOVABLE, 0, mpol, index,
> +					 numa_node_id());
> +	else
> +		folio =3D folio_alloc(GFP_HIGHUSER_MOVABLE, 0);

[Severity: High]
Should shmem_gmem_alloc_folio() allocate folios with GFP_HIGHUSER instead of
GFP_HIGHUSER_MOVABLE?

In virt/kvm/guest_memfd.c, kvm_gmem_get_folio() inserts the folio returned =
by
gmem_provider_alloc_folio() -> shmem_gmem_alloc_folio() into the guest_memfd
inode->i_mapping via filemap_add_folio(). However, kvm_gmem_init_inode()
configures that mapping as inaccessible and unevictable:

virt/kvm/guest_memfd.c:kvm_gmem_init_inode() {
	...
	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);

	/*
	 * guest_memfd memory is neither migratable nor swappable: set
	 * inaccessible to gate off both.
	 */
	mapping_set_inaccessible(inode->i_mapping);
	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
	...
}

Because mapping_inaccessible() is true, move_to_new_folio() in mm/migrate.c
and isolate_migratepages_block() in mm/compaction.c reject migration with
-EOPNOTSUPP, kvm_gmem_migrate_folio() triggers WARN_ON_ONCE(1) and returns
-EINVAL, and shmem_gmem_attach() requires sbinfo->noswap. Allocating these
folios with __GFP_MOVABLE allows unmovable and unreclaimable guest_memfd
pages to be placed in ZONE_MOVABLE, MIGRATE_CMA, and MIGRATE_MOVABLE
pageblocks, which can cause CMA allocations, compaction, and memory
hot-unplug to fail.

> +
> +	mpol_cond_put(sb_mpol);

[Severity: High]
Does mpol_cond_put(sb_mpol) leak a reference on sbinfo->mpol when
shmem_gmem_alloc_folio() is called with a NULL mpol on a tmpfs mount
configured with an mpol=3D mount option?

When mpol is NULL, shmem_get_sbmpol() in mm/shmem.c unconditionally takes a
reference on sbinfo->mpol via mpol_get():

mm/shmem.c:shmem_get_sbmpol() {
	struct mempolicy *mpol =3D NULL;
	if (sbinfo->mpol) {
		raw_spin_lock(&sbinfo->stat_lock);
		mpol =3D sbinfo->mpol;
		mpol_get(mpol);
		raw_spin_unlock(&sbinfo->stat_lock);
	}
	return mpol;
}

However, mpol_cond_put() in include/linux/mempolicy.h only drops the
reference if MPOL_F_SHARED is set:

include/linux/mempolicy.h:mpol_cond_put() {
	if (mpol_needs_cond_ref(pol))
		__mpol_put(pol);
}

Since sbinfo->mpol is allocated via mpol_parse_str() -> mpol_new() without
MPOL_F_SHARED, mpol_cond_put(sb_mpol) is a no-op and leaks a reference on
every allocation, preventing sbinfo->mpol from being freed on remount or
unmount (and eventually wrapping atomic_t refcnt). Should this call
mpol_put(sb_mpol) instead, matching shmem_show_options() and
mpol_shared_policy_init()?

> +
> +	if (!folio) {
> +		if (sbinfo->max_blocks)
> +			percpu_counter_sub(&sbinfo->used_blocks, 1);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return folio;
> +}

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D3
