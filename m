Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418211;
	b=aOVbi7lvyF++8r2MUhxR8kqUV7HmD/1U3RpK3xcsdSuphj9YaAV8jHjc+uYobdwtB0ki
	 r4WOhX6bYFiH9Hxwh+hix55btFyeXWcPDa2P0kc9SfDgy+YzfhkdedU9mTi3XH6Nah11M
	 DydRkhrwXWkH+vSaI/rWs2/OMNjdtzEtq4wjUjki8EDrqZ8OiBLjDolC2H1xzeq0kiaBm
	 DiQc4hGb3CovWxQ9/JZUa5PCiEHIe/PgWD/KMO+YQxfzGGn3Bpwu6AjT4Ln1167oqJ38t
	 e4ZAhb6uCSqAOeoGGMxmgwjb57cyMdpEPZk3yx7B3KUGd4+Si+97tBz8IEkBXhpqTkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R8nnthYJtQcOqupos5IpMh/Cqigu81rJdCskRizSqvo=;
	b=Xjb+aUfy1zV4WzNK2ec2ICVo1RY0J1wKJncoxSM+EWRzibSLQPeee5CAil6R1hkGuRzB
	 G3ybFCRRWLRNCvxh/7oNO5BTEhIw8zgdkB7xSdQT5vFFZGz6gwZZF1kkMZXQUSStlNNzB
	 3UohvOrrY9x2j3SgBr/r/w8Qds0yVZAdEtll2GTMXhmlJ0zCtMGC2Nq6zeOGUZJEqvPaX
	 XEr5huEaoiqDy/9FiDk4H8wyH+HuK5T26bCD76TCLbFczUIIFvdj2c5tHjSM5HrZ5ujxM
	 jdKpTi0Kjom6n5OwwZ9424AZoM4lgAwRDK3CXGXYZ7cbSBSLxirHg6AFjauHDOwmAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on5nguRw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62A606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on5nguRw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5081F000CA;
	Mon, 23 Nov 2026 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795418210;
	bh=R8nnthYJtQcOqupos5IpMh/Cqigu81rJdCskRizSqvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=on5nguRw+dvQ0o0nVdXzFm7NSTjf36itqpRBUm6BvxGHhaVlxYUT9MwSVMiIq9zQW
	 lgYEwFbp9oJs+5GQiVYnR+CgjtxfB+hVTn3kvZ0PDfPSbLDMk1PoZU7mwxph22aYZb
	 BFkOG9peEYuiMDNgU0r8psZlXsEsN+0zfdzQp+lEfawaQHh2YHw1gcwj+MU/ashtbA
	 ZnRMGCjN4Qay7j5UVoVOcUT+u+OUen2UIeS9ik6RhABw5RsHmyRNbayS1g1ROn47FF
	 1FIYD29+E7sLnoTei2KBo0mff4z6aFuWQlzxZ7WaUfm8lCxr/H8gwIGRurt0/oii4E
	 9w7ORxh+BrbnA==
Message-ID: <sashiko-outbox-228803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: riscv: Allow rescheduling during G-stage unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Can Qi" <qican5708@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123064935.1608890-1-qican5708@163.com>
References: <20261123055036.1554937-1-qican5708@163.com>
 <20261123064935.1608890-1-qican5708@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:16:49 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: riscv: callers re-flush full range after batched unmap
  yields
--

commit 98e1340ab679b1cafbeb059326e3045e4ca36e66
Author: Can Qi <qican5708@163.com>

KVM: riscv: Allow rescheduling during G-stage unmap

This commit allows G-stage unmap walks to yield mmu_lock, flushing pending
TLB batches before rescheduling and stopping if the root page table is
detached concurrently.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index be70607a33ea0..47b906769f497 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -423,9 +423,19 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>  	bool found_leaf;
>  	unsigned long page_size;
>  	gpa_t addr =3D start, end =3D start + size;
> -	bool flush =3D false;
> +	gfn_t last_flush_gfn =3D start >> PAGE_SHIFT;
> +	bool pending_flush =3D false;

[ ... ]

> @@ -448,12 +458,21 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage=
 *gstage,
>  		/*
>  		 * If the range is too large, release the kvm->mmu_lock
>  		 * to prevent starvation and lockup detector warnings.
> +		 * Flush first so another invalidator cannot miss cleared PTEs.
>  		 */
> -		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < e=
nd)
> +		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < e=
nd &&
> +		    (need_resched() || rwlock_needbreak(&gstage->kvm->mmu_lock))) {
> +			if (pending_flush) {
> +				kvm_flush_remote_tlbs_range(gstage->kvm, last_flush_gfn,
> +							    (addr >> PAGE_SHIFT) - last_flush_gfn);
> +				pending_flush =3D false;
> +			}
> +			last_flush_gfn =3D addr >> PAGE_SHIFT;
>  			cond_resched_rwlock_write(&gstage->kvm->mmu_lock);
> +		}
>  	}
> =20
> -	return flush;
> +	return pending_flush;
>  }

[Severity: Medium]
Does returning only pending_flush discard last_flush_gfn and cause callers
to re-flush the entire original range whenever a PTE is cleared after the
last yield?

When kvm_riscv_gstage_unmap_range() yields and then clears a PTE in the
remaining tail, kvm_arch_flush_shadow_memslot() and kvm_unmap_gfn_range()
call kvm_flush_remote_tlbs_range() from the start of the full range
instead of from last_flush_gfn.  Because
kvm_riscv_local_hfence_gvma_vmid_gpa() falls back to a full-VMID TLB flush
when the range exceeds PTRS_PER_PTE (512 pages), any unmap of a range
larger than 2 MiB that yields and clears a tail PTE still triggers a
full-VMID flush across all vCPUs in addition to the intermediate batch
flushes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123064935.1608=
890-1-qican5708@163.com?part=3D1
