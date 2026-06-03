Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2B3DA7CD
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503327; cv=none; b=RrGt2h6Cu0ykv03pVHGZbZt46MQyca08JSORi2L8B+qKgegjXtjUDEy/TMOLHpyr/Sl2962sp5c9K1SDiKybnv+tjR+41gd2YYlFTkJySyzfAiTTa8FpsLIBHsYI5MA633Jz+uJE0wcM3x8ZUU5+BHsYvoV+bc0iQWRwpDMXpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503327; c=relaxed/simple;
	bh=2P3yAFtnTNONqfWjY4HaKhz8RT8H4EMtVQxHZmMBwqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXo4yyU1isTPVWX6NgU8QS1YBrPhmMher2il9Euk8w8+v6w8XKTbdxI1/9+8uFC0dvjSdt8h5z2s1xYO/BbLFnek8xC+Nr32tCqgaDXcA7YkWJScop3SnDGze1LAGVPCc3j6EkgAKvpwQKC92CR/QJRHwQHYOW3aeSX8+eCDbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ4Rn568; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ4Rn568"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E241F00893;
	Wed,  3 Jun 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503326;
	bh=fOcEbb8rfuWzrwp3RYtCoZY3xPjqQ7b51fCuwpCH3PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZ4Rn568P819810wfiQ/gzK8EzKv6DQ5iKSs8yHfL4ochEjOu5CHOZP0XGikYKr+N
	 S+hnNS2EMcAeTOj2EwkRpWdYe3KSPSsgLIKKhFK8qaw5Jv0cTe9XGV1oZP1qS4sdEY
	 OLUOe+mwMp4OaKRdNbi8LLcF/8m179dVB8gI09XyjkE2A7LKsiUjw0LPmZ4HBC/cdK
	 JCfekuV8JCiCULuwsATjMF0Nof2Qz/h6cg624+iiOFeRSx609YXed1RQwpCrD/Uzn1
	 0RSeTfrlpzStI//0Gmp7NNhE4WfP+HSTi6+3iK17mjgHVUqfQVS7Qh5xyZEit7fCbj
	 cNt0aG7gjw1YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:15:25 +0000
Message-Id: <20260603161525.D9E241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] guest_memfd memory allocation ignores page offset for NUMA interle=
aving, falling back to the task's global interleave counter.
--

commit ce4f65d7ee89d8194749cc615f30619f101248db
Author: Michael S. Tsirkin <mst@redhat.com>

KVM: guest_memfd: fix NUMA interleave index double-counting

This commit fixes a bug where the NUMA interleave index was being
double-counted by setting *ilx to the inode number instead of the full page
offset in kvm_gmem_get_policy(). This allows get_vma_policy() to correctly
add the page offset without duplicating it.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index bf9659a7b0f6d..65daef23c8390 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struc=
t *vma, struct mempolicy *mpo
>  }
> =20
>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> -					     unsigned long addr, pgoff_t *pgoff)
> +					     unsigned long addr, pgoff_t *ilx)
>  {
>  	struct inode *inode =3D file_inode(vma->vm_file);
> +	pgoff_t pgoff =3D vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT=
);
> =20
> -	*pgoff =3D vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	*ilx =3D inode->i_ino;
> =20
>  	/*
>  	 * Return the memory policy for this index, or NULL if none is set.
> @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct v=
m_area_struct *vma,
>  	 * can then replace NULL with the default memory policy instead of the
>  	 * current task's memory policy.
>  	 */
> -	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
> +	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does guest_memfd memory
allocation ignore the page offset for NUMA interleaving and fall back to
the task's global interleave counter instead?

While this patch fixes the index calculation for the policy lookup, it seems
the index is completely dropped later during the actual memory allocation.

In virt/kvm/guest_memfd.c kvm_gmem_get_folio(), KVM calls into the generic
filemap allocator:

folio =3D __filemap_get_folio_mpol(inode->i_mapping, index,
                                 FGP_LOCK | FGP_CREAT,
                                 mapping_gfp_mask(inode->i_mapping), policy=
);

But the generic allocator hardcodes NO_INTERLEAVE_INDEX in mm/filemap.c
filemap_alloc_folio_noprof():

if (policy)
    return folio_alloc_mpol_noprof(gfp, order, policy,
                                   NO_INTERLEAVE_INDEX, numa_node_id());

For policies like MPOL_INTERLEAVE, using NO_INTERLEAVE_INDEX causes the
allocation to use the faulting task's global il_prev counter rather than the
file index-based deterministic interleaving.

Doesn't this defeat the purpose of the shared policy, causing interleaving
to be randomized by the chronological order of vCPU page faults rather than
deterministically spread based on the guest physical address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0eff0a90667b900bee8=
37d06b5db5025e1f304b5.1780501924.git.mst@redhat.com?part=3D1
