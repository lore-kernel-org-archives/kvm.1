Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEDB70836
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217899; cv=none; b=Ty8RKMAdXymKWfhHymrHgniLdH2xNwMIDABucR5H8Vq+bCI4RNVw+wJ1/YaGSuP12vdVfDRNjC5m6jePDE4yXjXj4vXpBGnzIKCNNIVm46DWFyilHPVSFp43hTSYgtAKsMbYa1fw0SJZoX2mTa63fvTuLJEwXMpNd9hfx/KWono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217899; c=relaxed/simple;
	bh=SQcJj83DBljYAwLuDoEuZarYtC5os1vRPVjt8shq/mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwqXNljIVrUBTQcL5TzaXkNR+q5ishWzG7IKEi4jExLWYmrm4rr9Z3zZoxBIm8+FO5+RvhEiscRutVTrnzI2JDJ+MKKdVWF9H41jR7jGVG5C9BT+pBcBStiZ00Dbp81Wy/VcF7hLesFfWd5L7vLnHlnDB7nDcmqztiukKPW5duM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/CuZ8l8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/CuZ8l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBF41F000E9;
	Tue, 23 Jun 2026 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217898;
	bh=sRQD54I/EfIuwNIJbHb4BAMbgs8mLII/QnelNFY7VPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/CuZ8l8IZLc7hI4o2d7bvupHnTakq+OwRQGrokqO3DLqvJDR8X5pVtQueC9F2Gmh
	 ylY4wC/f8IHUE7hqqk4taxWPxzXt3afDt704IAxjDhS2Y6HEWpblwn95dhm1dhvvk9
	 UG10oCdPuTvqwdw0Ao/uVP5FkySBVC4LFVxFrC0Kcd40B+BboUXsq/Qzq5jaCZ/x5/
	 ibwrPqQU4mxTp5Wucbjsu/9V41Ecu3dJwa5cYlFQumnDJ61ApcBisWUsviB0odExBo
	 /1f0QbGQTvUZMWQhscPf0QUDF0sOwIPw3LQHRswgNtJkQcM05oDEATMy6kj2QSZd5H
	 cEfwk6jZx9WgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] RISC-V: KVM: Add the eager_page_split module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623121332.78514-6-wang.yechao255@zte.com.cn>
References: <20260623121332.78514-1-wang.yechao255@zte.com.cn>
 <20260623121332.78514-6-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:31:37 +0000
Message-Id: <20260623123137.CEBF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The `eager_page_split` module parameter is declared globally withou=
t the `static` keyword, leading to namespace pollution.

Pre-existing issues:
- [Critical] Dropping `mmu_lock` before flushing the TLB for newly write-pr=
otected pages allows the guest to modify memory without KVM recording it in=
 the dirty bitmap, leading to silent data corruption during live migration.=
 This problem wasn't introduced by this patch, but it was exposed in the mo=
dified code.
--

commit 775425d655f0c265e56c7d5ec6ecfe710e56385a
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Add the eager_page_split module parameter

This commit introduces the eager_page_split module parameter for RISC-V KVM
to control whether huge pages are proactively split during dirty logging.
Eager page splitting is enabled by default.

[ ... ]

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index d2d36a9dca06f..89f0dc237cf7b 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -16,6 +16,9 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
> =20
> +bool __read_mostly eager_page_split =3D true;
> +module_param(eager_page_split, bool, 0644);

[Severity: Low]
Should this variable be declared with the static keyword?

Because eager_page_split is only used in this file, omitting static pollutes
the global namespace and might cause silent collisions with variables in
other built-in drivers or subsystems. It can also trigger a
-Wmissing-prototypes warning.

[ ... ]

> @@ -165,8 +168,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
kvm *kvm,
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);
> =20
> -	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> -		mmu_split_huge_pages(&gstage, start, end);
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +		if (READ_ONCE(eager_page_split))
> +			mmu_split_huge_pages(&gstage, start, end);
> +	}

[Severity: Critical]
This is a pre-existing issue, but does dropping the lock in
mmu_split_huge_pages() without first flushing the TLB allow the guest to
bypass dirty tracking?

During KVM_CLEAR_DIRTY_LOG, the generic KVM core clears the dirty bit in its
bitmap before calling the architecture hook here in
kvm_arch_mmu_enable_log_dirty_pt_masked().

kvm_riscv_gstage_wp_range() makes the KVM page tables read-only, but its
return value (which indicates a TLB flush is needed) is ignored. We then
call mmu_split_huge_pages() which periodically drops kvm->mmu_lock to call
cond_resched():

mmu_split_huge_pages() {
    ...
    if (need_topup_split_caches_or_resched(pcache, count)) {
        ...
        write_unlock(&kvm->mmu_lock);
        cond_resched();
        ...
}

While the lock is dropped, guest vCPUs can still write to memory using
stale, writable TLB entries. Since the dirty bit was already cleared, these
writes silently bypass KVM's dirty tracking and are lost during live
migration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623121332.7851=
4-1-wang.yechao255@zte.com.cn?part=3D5
