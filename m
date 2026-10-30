Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400651;
	b=quU7sBTuDaT86P9kRgevtACWT5UafnIfbHXXwE3Piwm0/Jocc0aI/AxtJ5J++piDHJoO
	 DdzpB3hqlWRSg+Borsu7iwl5D4B27j1y0O6Pl6XPMESQXu3mSjbveQErl1MrIkF17mBrM
	 U+6ohUbtJj3mcobe9A/aeFcYh0NI2bcXChnYzfBWoFvDQWTQTdyM5Lom05+T3N1c3bAX1
	 MCFsS816OWIuART9sOUcw2kOz7w1qXNUJSdwfPjO1d46bUh/FDvKkraaKASsZkRn+1txt
	 7ovhaezrVWnKcnTZhNoFcpotO9aRdsWTplJ+bzwAwV3yBLkQ9DbzQRgCGlnw8n15p2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sBPC9j3zYYvyNSvNwl5TgXeoPUFl8zAE6EN+zy9UWjw=;
	b=js5ujF57ETg5Amm3LgHOnjYc0l1ugsrX4tw2t2QgYFePShI3yIth21YE053VtO1BWQGt
	 lq+jDdkSgotNITYc58xqlnNyVv+z35jiz2gZ+LZP9LAeeJtt6caF8x9cUhDyJ4BKMr3OA
	 t3jbVQ9150eEdZ9tEw35/gMCGYsMuvy79sPaf7FzT2yfjqDOZg31DzaMcS7QcUjgij+CJ
	 CnI5+jV64Y968ZSQQcskvSQ2kG0fcrtRk5dGMqO3Wl0txw2LuWjhdDMjHi2ndyr1+2vVi
	 FB8LXEf18R9Icw68qcTf2NVLbCD7/LpHcgvxGBnJ5CjPA0EkJuFG1ugbeEQ14DXP5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixtaLoap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF0606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixtaLoap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CE71F000C1;
	Fri, 30 Oct 2026 22:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400650;
	bh=sBPC9j3zYYvyNSvNwl5TgXeoPUFl8zAE6EN+zy9UWjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixtaLoapanC//Ei4l2FFVPKAJXkO6rzu6G7KW+0XKHZwfj1PTzeIUvo6XuDFUvPaf
	 Pv73wQp8tQPY8/A7J7DKS/Ms67n70DltC0DortmN1n/mr9EULWj3OhT3YIeTUBv52e
	 t31sD7bC3Qv2Eh27V8+eSVQZpRAvuhmR5LFrDfc0iWlEbUoOcuAf2a23gOK4HdOjBL
	 WqvAx1bs2dkw838mG7oQzWOMLuI5mZNeiTUzk7+ANPI/SfxpKFj2YGc23BEZIJPmea
	 arvbmjyebDeaN8Ayl7THsdirS3fgl5sxp5BTgxan4E9GPdf2aMgNyoM1843awwXqt7
	 mvhqBgYCJYAdg==
Message-ID: <sashiko-outbox-191601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: reject VMA straddling the dirty ring on mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rik van Riel" <riel@surriel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261030183604.3e8e373c@fangorn>
References: <20261030183604.3e8e373c@fangorn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:50:50 +0000
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
- [Medium] KVM: false-positive overlap in kvm_vcpu_mmap() when dirty ring i=
s disabled
--

commit af0169eef51e967cdbe4222615548505445b40f5
Author: Rik van Riel <riel@surriel.com>

KVM: reject VMA straddling the dirty ring on mmap

This commit updates kvm_vcpu_mmap() to test for interval overlap against the
dirty-ring page range instead of only testing the VMA's first and last page=
s,
preventing MAP_PRIVATE or VM_EXEC mappings from spanning across the dirty
ring.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..97b944c77b347 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4178,10 +4178,16 @@ static const struct vm_operations_struct kvm_vcpu=
_vm_ops =3D {
>  static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct kvm_vcpu *vcpu =3D file->private_data;
> +	struct kvm *kvm =3D vcpu->kvm;
>  	unsigned long pages =3D vma_pages(vma);
> +	unsigned long ring_start =3D KVM_DIRTY_LOG_PAGE_OFFSET;
> +	unsigned long ring_end =3D ring_start + kvm->dirty_ring_size / PAGE_SIZ=
E;
> =20
> -	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
> -	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> +	/*
> +	 * An overlapping VMA is rejected when private or executable: a CoW
> +	 * fault hides guest writes from the VMM.
> +	 */
> +	if (vma->vm_pgoff < ring_end && vma->vm_pgoff + pages > ring_start &&
>  	    ((vma->vm_flags & VM_EXEC) || !(vma->vm_flags & VM_SHARED)))
>  		return -EINVAL;

[Severity: Medium]
What happens in virt/kvm/kvm_main.c:kvm_vcpu_mmap() when the dirty ring is
not enabled on the VM (kvm->dirty_ring_size =3D=3D 0)?

Previously, kvm_page_in_dirty_ring() checked:

virt/kvm/kvm_main.c:kvm_page_in_dirty_ring() {
#ifdef CONFIG_HAVE_KVM_DIRTY_RING
	return (pgoff >=3D KVM_DIRTY_LOG_PAGE_OFFSET) &&
	    (pgoff < KVM_DIRTY_LOG_PAGE_OFFSET +
	     kvm->dirty_ring_size / PAGE_SIZE);
#else
	return false;
#endif
}

which always returned false when kvm->dirty_ring_size was 0 or when
CONFIG_HAVE_KVM_DIRTY_RING was disabled.

With the new interval check, when kvm->dirty_ring_size is 0, ring_end equals
ring_start (KVM_DIRTY_LOG_PAGE_OFFSET), forming an empty interval
[ring_start, ring_start). However, the half-open overlap test:

	vma->vm_pgoff < ring_end && vma->vm_pgoff + pages > ring_start

assumes both intervals are non-empty. If userspace creates a MAP_PRIVATE or
VM_EXEC mapping on the vCPU fd that straddles KVM_DIRTY_LOG_PAGE_OFFSET
(vma->vm_pgoff < KVM_DIRTY_LOG_PAGE_OFFSET and
vma->vm_pgoff + pages > KVM_DIRTY_LOG_PAGE_OFFSET) on a VM with
kvm->dirty_ring_size =3D=3D 0, won't kvm_vcpu_mmap() falsely reject the map=
ping
with -EINVAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030183604.3e8e=
373c@fangorn?part=3D1
