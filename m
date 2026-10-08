Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81F41A8F
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419429; cv=none; b=MFzyYefEmEGLrQ3O9pO/DFyOSlDb2QZ1g2zltku2YqjmCU+SbFvIkmzaUNHB/w3P0vdHrjif578472xeiWzc1Lef+5UUVkofr92AF8BB223twRR4HyHhvW9SOFunS0+9VMFMjp/yK9VjthTfHTHG9vWF5gIuBaNh71/oTHDJLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419429; c=relaxed/simple;
	bh=aeBvEzJzsgGIFKUoR+FHCaUKjiMDEOzEb2s71FImJMo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZBcXrGtmyYXJ4TYEIz/BsTzxPLRMBvGHwgjJ424lMXCsouCQF5ME6Eb2e3Ea3hzyxes2TOg+pZamyxtbF/pXnr710dJYwTBu3WpCoUdonqOUtLUROnYZ1Gri3/ri4KPUowWQy638Gi0+cUqv9WbWfsz29AABrWKGVRo6dRToZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdevCi+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdevCi+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A11F00898;
	Thu,  8 Oct 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419428;
	bh=1uYCJLVF5hGsss2MvSDS+WwKz0ViotsHCOTPOpnDb1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdevCi+buT/Zr+im9zlUT+znSzljtGw+cVDoN7JqRVJ0CKHDsu/NOpECBQ7jTggA1
	 pCb4LPesDrB5LTKSwg+dpm5NRZSVP78T6lwNERFojwzt3lhGDDP28AocVgvJJPdQL3
	 orLYa99blEc/3oOQ1RGtWRDrF91nV6kYcto09Q7E5gjh6+AFCofT3i2HuaQJrwbuhF
	 qd4MtT1XySumWGaz3bPlCTjZZuweyYIuTCGEHJQwrzBUYDR8otExHb67x4KyAPAAPt
	 VG7oI2SNf0qWFsqEfdNmL88OdexnPTmNmkUFYcc4IwYj1238pBTDaPVM1JnP+IpNJF
	 SPTS5rsHCYBEw==
Message-ID: <sashiko-outbox-163472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/29] KVM: VMX: Generalize VPID allocation to be
 vendor-neutral
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-4-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-4-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:30:27 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: x86: memory leak of tlb_tags.bitmap on TDX setup failure
--

commit e4dabbc78aa00d0293ef8965888f054d5ea676ef
Author: Yosry Ahmed <yosry@kernel.org>

KVM: VMX: Generalize VPID allocation to be vendor-neutral

This commit generalizes the VMX VPID allocation code to a common TLB
tags allocator and allocates the bitmap dynamically. It also bounds the
number of allowed tags to VMX's hardware cap and introduces wrapper
functions for initialization and destruction.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index aadd5bdc2c97a..97d49247d9d82 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -8178,6 +8178,84 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
>  }
> =20
> +static struct {
> +	spinlock_t	lock;
> +	unsigned long	*bitmap;
> +	unsigned int	nr;
> +} tlb_tags;
> +
> +int kvm_init_tlb_tags(unsigned int nr)
> +{
> +	/*
> +	 * Limit the number of TLB tags to VMX's hardcoded maximum of 0x10000
> +	 * to avoid wasting memory for the bitmap in the unlikely scenario the
> +	 * CPU supports an inordinate number of ASIDs (on AMD).  If userspace
> +	 * wants to concurrently run tens of thousands of vCPUs, they'll likely
> +	 * need a solution that works for both Intel and AMD.
> +	 */
> +	const unsigned int MAX_NR_TLB_TAGS =3D VMX_NR_VPIDS;
> +
> +	if (!nr)
> +		return 0;
> +
> +	if (nr > MAX_NR_TLB_TAGS) {
> +		pr_warn_once("Number of TLB tags capped (%u instead of %u)\n",
> +			     MAX_NR_TLB_TAGS, nr);
> +		nr =3D MAX_NR_TLB_TAGS;
> +	}
> +
> +	tlb_tags.bitmap =3D bitmap_zalloc(nr, GFP_KERNEL);
> +	if (!tlb_tags.bitmap)
> +		return -ENOMEM;

[Severity: Medium]
Does this code leak the tlb_tags.bitmap on TDX setup failure?

The patch converts the static VPID bitmap to a dynamically allocated
tlb_tags.bitmap in kvm_init_tlb_tags(), which is called by
vmx_hardware_setup().

In arch/x86/kvm/vmx/main.c:vt_hardware_setup(), it sequentially calls
vmx_hardware_setup() and then tdx_hardware_setup():

arch/x86/kvm/vmx/main.c:vt_hardware_setup() {
	ret =3D vmx_hardware_setup();
	if (ret)
		return ret;

	return enable_tdx ? tdx_hardware_setup() : 0;
}

If tdx_hardware_setup() returns an error, vt_hardware_setup() returns the
error directly without invoking vmx_hardware_unsetup() to undo
vmx_hardware_setup()'s allocations.

KVM's generic module initialization explicitly skips calling
ops->hardware_unsetup() if ops->hardware_setup() fails.

Does this permanently leak the newly dynamically allocated tlb_tags.bitmap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D3
