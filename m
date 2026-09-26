Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C723161BF
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384910; cv=none; b=r53IB9IkP9IY/7TYdmwz/xns7+RnQwcroAgozVEtSFq1MdoIqMBGqCryPjs2oeAuh93poJoKLqVUPkTLGAAm+UrI80rkhkdkFv/8oKlY611qOrBuANKiM8zr69GNr0c/JxOGDho1RTOtYlYHH3M/eIzps5dSk57KkREkeejopR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384910; c=relaxed/simple;
	bh=YQQdkftJd6plUXDIlOiQ93ljWKdo009KwL7ulJcLJBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2SP9XfaMFwu+4l+MBp4RijLG9ti/my8/Shz+z6yNoTzCBpjfQEoCfHCKgYDwDclvnYX+f4chWOy7waczNsZ0yUOoiMNCUwNGG/Fye6zehG4sMak3XYyRVqD4SkcFeJZFPRACsbGmdVeQnZg8U0Qy6F6vuTYCGeJ6wMnjV/kuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBSYDPzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBSYDPzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699111F008A1;
	Sat, 26 Sep 2026 01:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384908;
	bh=pvfeN6Q92YMBQ7Cmd4Gk3bTe4tbQIj/5krA7LLSl/OM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBSYDPzUhvjWXMv4MhmAZY/nsb22hrccjW78zYBVBtpN3DaUjeyaanOacNymhWD1i
	 T9KOdzmqoxffpoX7ULhReEvfy6m1C8gpr1SHe5/8OzLB81RElaDLK9hk7xn4pmLFyz
	 g337QBUd+sKKYiZFMQ5HY3Gdx5K636sMqw4RS/W/lYK79nQh7YdU7oz1TOjxIeYpNw
	 17sSrlMmobaVHb33eY8+NDsLKXeOBB9PEaEsBCdczptR4geexmk6OKRN9EkYwoMItt
	 U+SY7/BAe4BiNbYd8s+wPuLGL4PFS+t7nv8CSNnIjtCW2XJIDCmA3b4plHFJx498yV
	 PXWa4d1PdJZ+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/17] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-1-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-1-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:08:27 +0000
Message-Id: <20260926010828.699111F008A1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm: guest_memfd bypasses tmpfs disk quotas and overcommit limits
- [High] mm: guest_memfd zone contamination via GFP_HIGHUSER_MOVABLE
- [Medium] fs: missing mnt_want_write() causes TOCTOU race with read-only r=
emounts
--

commit aa746f432476f1dcdc507ac315f4952fd2b53724
Author: Ackerley Tng <ackerleytng@google.com>

mm: shmem: Implement guest_memfd provider operations for tmpfs

Implement guest_memfd provider operations to declare that tmpfs supports
providing memory to guest_memfd.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 897fa2b61346f..279f29a9861c1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c

[ ... ]

> @@ -5234,6 +5235,114 @@ static const struct inode_operations shmem_specia=
l_inode_operations =3D {
>  #endif
>  };
> =20
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +static void *shmem_gmem_attach(struct file *resource_file)
> +{

[ ... ]

> +	if (__mnt_is_readonly(resource_file->f_path.mnt))
> +		return ERR_PTR(-EROFS);

[Severity: Medium]
Does this check adequately protect against concurrent remounts?

shmem_gmem_attach() checks __mnt_is_readonly() without holding
mnt_want_write() or acquiring a VFS write reference. The mount could become
read-only immediately after this check, but guest_memfd would continue
allocating from it.

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

[Severity: High]
Does this logic bypass tmpfs user/group disk quotas and VM overcommit limit=
s?

While the global block limit is checked and charged here, it skips
both shmem_acct_blocks() (for VM overcommit) and dquot_alloc_block_nodirty()
(for inode disk quotas). Could an unprivileged user with write access to a
tmpfs mount evade limits and consume unbounded space?

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
Can placing unmovable guest_memfd pages into movable zones cause memory
fragmentation?

shmem_gmem_alloc_folio() allocates folios with the GFP_HIGHUSER_MOVABLE
flag. The __GFP_MOVABLE flag tells the allocator these pages can be migrated
or evicted, but guest_memfd pages are strictly unmovable. Does this break
memory management invariants and potentially cause large-order allocation or
memory hot-remove failures?

> +
> +	mpol_cond_put(sb_mpol);

[Severity: Medium]
This is a pre-existing issue, but does mpol_cond_put() leak the policy
reference count here?

shmem_get_sbmpol() returns a policy with an incremented refcount. However,
mpol_cond_put() only drops the reference if the MPOL_F_SHARED flag is set.
Since the superblock policy does not have MPOL_F_SHARED set, this operation
is a no-op, which appears to leak the policy reference.

> +
> +	if (!folio) {
> +		if (sbinfo->max_blocks)
> +			percpu_counter_sub(&sbinfo->used_blocks, 1);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return folio;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D1
