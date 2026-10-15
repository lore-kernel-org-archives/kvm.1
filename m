Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BC51DE1A
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066686; cv=none; b=l/6vMP5VZdiSUumcvKvOyXqhcOUJzk3ERos+2omTlGB8pswgzGZiEQgJB6p/9SAqvhmFmAR7sqgyN6OOcJrRIuSlDG9d2NJk46oki13ALjqBJLetTsg1ZS8jy/5bPbvC50DkFE+dmmt1lj17wJ2/x/h72qUfELlvcp/olxZXgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066686; c=relaxed/simple;
	bh=cFcjV70QdSb6H2Ydzx5baO+Xw0shQCN/kaaM7fD00Hc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=j+/TS+WcWXxj97AnoylHH5sBKPWvRvR/WSH+AcKhDT0dfez0k3Oh49LICjy8pu+edmdeQ9GAg6rNPhElvCa0D693QjVcUImDGkn/zvzkoYV07kD64mWFvxHQVExZpXaUJ48+TIHp924qKtuqMBkaUFwZ+W8gU+F2dP2FkRdk3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp4DUbzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp4DUbzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70331F000C4;
	Thu, 15 Oct 2026 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066684;
	bh=VXca//EGtTMC8XwtCPIQP5W2E+vU+2v3FBRHj3Yfubw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vp4DUbzKN6v5ecGoFAfsmMD6l92kj6BaMaOdEXjUwlN902T4ImdZ8imEiQqzWJyl+
	 ZCnxXR79lK4+KkFBp0wc2JAQUzUU1zkC2hvZEbAy2W/Fj6K//EtydNra2eF1f96oOf
	 GMQWL4KqLC0s384kQ2ZSX1wvppJPzXodgXy+3fbSdrhYgmrkgAkOUZcFuLVb1DAylr
	 LJUNplKxcgn/KcQ7BKjtqAt/XQ5IsU8mjF8+twAjU7S9mbZCK7flGMvMXgCqEGbCgX
	 ZmuHID6d8eco2UTTqAnyGLXwSZbmwsVvGaFFegsDAYckcfSy5V80sZvPqYFOU1sa4n
	 P9Wf6wicLCQ/w==
Message-ID: <sashiko-outbox-172789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks
 with RCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
References: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:18:04 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: ppc: UAF of spapr_tce_table due to missing rcu_read_lock()
- [High] kvmppc_clear_tce: pinned memory leak on partial IOMMU map failure
--

commit b9a581a90633de9f36c89acf2c46a11e7fade7c3
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU

This commit replaces list_for_each_entry_lockless() with
list_for_each_entry_rcu() inside an rcu_read_lock() block for
stt->iommu_tables traversals in TCE hypercalls. This ensures that IOMMU
table entries removed concurrently are not reclaimed while the reader is
using them.

Cc: stable@vger.kernel.org

> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index c5f3f5b29d89d..d8625488c3c5c 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -602,7 +602,8 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
> =20
>  	entry =3D ioba >> stt->page_shift;
> =20
> -	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {

[Severity: High]
Does this code leave the stt structure vulnerable to a use-after-free?

A guest VM can issue H_PUT_TCE or related hypercalls in preemptible virtual
mode. The handler calls kvmppc_find_table() to fetch the RCU-managed stt
pointer locklessly from the kvm->arch.spapr_tce_tables list. The handler
then dereferences stt multiple times before reaching this newly added
rcu_read_lock() block.

If a host userspace thread concurrently closes the kvm-spapr-tce file
descriptor, it triggers kvm_spapr_tce_release(), unlinking stt and queuing
it for deletion via call_rcu(). Because the hcall thread is preemptible and
holds no RCU read-side lock to protect the stt pointer itself, the RCU
grace period can expire and stt can be freed before the hcall finishes
using it here.

>  		if (dir =3D=3D DMA_NONE)
>  			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
>  					stit->tbl, entry);
> @@ -613,9 +614,11 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
d long liobn,
> =20
>  		if (ret !=3D H_SUCCESS) {
>  			kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl, entry);

[Severity: High]
Can this error path cause a permanent leak of host pinned memory?

If kvmppc_tce_iommu_map() fails partway through the stt->iommu_tables list,
the code calls kvmppc_clear_tce() on the failing table. kvmppc_clear_tce()
unmaps the hardware TCE using iommu_tce_xchg_no_kill(), but it discards the
old dir and hpa values without dropping the mm_iommu_mapped pin count:

kvmppc_clear_tce() {
    ...
    for (i =3D 0; i < subpages; ++i) {
        unsigned long hpa =3D 0;
        enum dma_data_direction dir =3D DMA_NONE;

        iommu_tce_xchg_no_kill(mm, tbl, io_entry + i, &hpa, &dir);
    }
}

Because the hardware entry is now DMA_NONE, future guest unmaps or VFIO
container teardowns will skip decrementing the pin count. Furthermore,
previously mapped tables in the list are left mapped without being rolled
back, causing hardware inconsistency and further silent memory leaks when
the guest abandons the failed mapping.

> +			rcu_read_unlock();
>  			goto unlock_exit;
>  		}
>  	}
> +	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015120137.2884=
3-1-nnmlinux@linux.ibm.com?part=3D1
