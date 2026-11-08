Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098632;
	b=tsTPYZH7kjA72eqrM3zSlXyJWhu6P970wmH+aVcbXSMmmuycw/+zjxYzWgLAH4UYj3mt
	 y7929vyWY4s2XDLzsNGZ/vbiw+NGxkALdiF6JdDTvoSp0yIg+T2l+HD/F2FFNyQyDaeVF
	 hFWm+DANhEtWz4d55kBp/WmUuWCMbSNgz8eQxH4xsqSos+THRXVPfIYUMrJeMEBcb+EsX
	 KLGz8saScg6xj2I7Hx6pV/DnL8BMFNX1VcIpw9ggW12TRw3ggZ4wKcpv19SWUAaQDCRu9
	 Ef+qsSv5B8hceHQ/LHmBh/mTdrB5OcUr200jO0s3J4ACuWhz84Ob8pc7cBzLiv3uq5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098632;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=99AHfkNsSNOI9AkrucgD2vH4yfnn2CeIWT8FqF772VA=;
	b=yL5IaTnvR+B3IVgkjroQ98KH/1Io/+XgHTWAGYYCZGDSuBTUp0IWt9EEw55JiWXiIJua
	 vIIf7yeclcV+tdugpBBC9ONk4tC/2ZIXypO8NWvIjX0n4Z9Yt9UM9s4izwLIazSlNsh2a
	 nmLsgu8YEAbsCFD9FKJJztGKatTnryy0tex5XSnK7LjTn6rtr2A2wjTc7SEgYXotb4fR1
	 Q2bVtOL1QOX8vEImYxftuZRd8vYqyi6kKlJLuXRVSPKUVJ9/WMlDMHl0oXpnC0k6cYiQz
	 N83DWqYfnRFptIBUePJjxwVQM7P+GDOuS3P2ivKB+SE2MT35MBC4JyyAllOTwZu8G3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8vJZKHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24323606A32E
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8vJZKHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD43C1F008A2;
	Sun,  8 Nov 2026 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098631;
	bh=99AHfkNsSNOI9AkrucgD2vH4yfnn2CeIWT8FqF772VA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8vJZKHYJakO7f4cLsEgSxilcocWjesZCSYOx7AqR15RmgDcJEPpBb5tTLrkE1HH/
	 iFrXVHRBsM40Ve+TxN7GsHkoG30W3C18E0BkTuR77YzG5EIJENz+/quVzOBsoI9Gxa
	 ydPOKT7b8sNKag6/bRxL168Zo0Pu6H8WEb550DxI9yiYKMnsD97xWwhJc76V2olV1u
	 pZCgnYMSKG6XiWEdBRYhUxmRtFWX+K4OUVciuZxic2yvfpSWW1tUC3Rns83aI1hI9B
	 zIQgMAx5JJjSk/KHO40g5xHsx/f2K8LVi6SBoi/A0wSEER+VLbF7by5Tot2iurH0AW
	 5FZHKVnBQhniA==
Message-ID: <sashiko-outbox-203414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/88] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-3-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-3-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:50 +0000
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
- [High] mm: shmem: shmem_gmem_alloc_folio() allocates unmovable folios
  as movable
- [High] mm: shmem: sbinfo->mpol refcount leak in
  shmem_gmem_alloc_folio()
- [Medium] mm: shmem: uncontextualized sb_mpol and ref leak in
  shmem_gmem_alloc_folio()
--

commit bbcb85338583bc4b9f5ee5e619a3f55d643e1098
Author: Ackerley Tng <ackerleytng@google.com>

mm: shmem: Implement guest_memfd provider operations for tmpfs

This commit adds a guest_memfd_provider_operations pointer to struct
file_operations and implements the callbacks in shmem so directory file
descriptors on a tmpfs mount can provide memory to guest_memfd.

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

[Severity: Medium]
Can passing sb_mpol directly to folio_alloc_mpol() use an
uncontextualized nodemask?

mpol_parse_str() stores the parsed mount option nodemask in
new->w.user_nodemask without calling mpol_set_nodemask(), expecting it to
be cloned and contextualized later (as mpol_shared_policy_init() does for
regular tmpfs files).  Using sb_mpol directly bypasses
MPOL_F_RELATIVE_NODES translation and cpuset mems_allowed
contextualization during NUMA node selection.

> +	if (mpol)
> +		folio =3D folio_alloc_mpol(GFP_HIGHUSER_MOVABLE, 0, mpol, index,
> +					 numa_node_id());
> +	else
> +		folio =3D folio_alloc(GFP_HIGHUSER_MOVABLE, 0);

[Severity: High]
Should shmem_gmem_alloc_folio() use GFP_HIGHUSER instead of
GFP_HIGHUSER_MOVABLE?

Folios returned here are inserted into the guest_memfd mapping, which
kvm_gmem_init_inode() marks with mapping_set_inaccessible() (setting
AS_INACCESSIBLE and AS_UNEVICTABLE) and GFP_HIGHUSER because guest_memfd
memory is neither migratable nor swappable.  Allocating with
__GFP_MOVABLE allows the page allocator to place these unmovable folios
into ZONE_MOVABLE and MIGRATE_CMA pageblocks, causing CMA allocations to
fail with -EBUSY and memory hot-unplug to loop indefinitely trying to
migrate them.

> +
> +	mpol_cond_put(sb_mpol);

[Severity: High]
Does mpol_cond_put(sb_mpol) leak a reference on sbinfo->mpol on every
allocation when mpol is NULL?

shmem_get_sbmpol() unconditionally increments sbinfo->mpol->refcnt via
mpol_get(), whereas mpol_cond_put() only decrements refcnt when
MPOL_F_SHARED is set in pol->flags.  Because sbinfo->mpol is allocated by
mpol_parse_str() -> mpol_new() without MPOL_F_SHARED, mpol_cond_put() is
a no-op here, preventing sbinfo->mpol from being freed on remount or
unmount and eventually wrapping its atomic_t refcnt.  Should this call
mpol_put(sb_mpol) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D3
