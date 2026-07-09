Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888A17BB21
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631725; cv=none; b=eTyVhqMxQiPYmWp+sdzjulDZKFi/zSD+DrZOBjMwXXFzEDvO/HMMeDOJQX7JGbJ3doPsnWiQd1/qEc6tvcZHR22YpnLtRNN92Y9mHUDyJnW4Aasyw7W5IzvAbP74xGCJumcKa/d3x29oCmgw+bg7pa/ZhHQ5XopgZ4GSpFUJCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631725; c=relaxed/simple;
	bh=STD9flTj2gMau+c84J+3j5+oOCwBwwQgn7qdCLrZQYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPX+WNnBhu6nGXUw0RGgKxx2lpgxyG6J5J1YRFP7XPwB926sNWoQOn44jmOoPGa1cWV6jk1QqVz+FAql4yn0h2hkXMqdcXxs93Xh5dVf6rpIeimg/PZ96SZKOl5HuPwW8uR5/owiGBjbn3RvhYdTaoD5G12SRwoG0mbJ8OhVo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7wlfqu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7wlfqu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE3F1F000E9;
	Thu,  9 Jul 2026 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631723;
	bh=V7p5Kp+v6xT+2MLsJwRb80+bjSNcVAqT/1B15GGPPm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7wlfqu70yfT3HppcKQ6/Q9JUBcy1DOnTRiqetIWLgbACb61FquFFOzAl04CBsUfL
	 I7IALSu89Js7hklGmdv2j/kNUrij0zLIvcFxqa+cJrSk7he0uauUVB/koCCKT7ez+S
	 CwJpp5lHuqgciysyYKFeZzTAvTaTs16R0qEYqf7+DySOAe8m4XPbn6FUR6YfDjL9fn
	 po4xRKn/WjdlPGrJhCxtf/vLB+ImfMBfDxDD//21B9Fp4GFWtIIuXL8nsLLiynWdel
	 hJv96Q45LMzGJkQzbuBfg5Q9tIKHjh40MAD8VPWVhpESxOXuj9+Kn0RV0A9LNyDARD
	 WakTpqJL3F1Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/18] KVM: guest_memfd: Align the gfn as well as the
 pfn when "preparing" a folio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-18-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-18-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:15:23 +0000
Message-Id: <20260709211523.8BE3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Aligning GFN down without validating memslot boundaries introduc=
es host out-of-bounds physical memory access when preparing huge folios.

Pre-existing issues:
- [Critical] Concurrent execution of KVM_GMEM_POPULATE and vCPU page faults=
 allows unprivileged userspace to trigger host hardware crashes and guest d=
ata corruption.
--

--- Patch [17]: [PATCH v4 17/18] KVM: guest_memfd: Align the gfn as well as=
 the pfn when "preparing" a folio ---
commit 5debe95f8712f79807df583e8d5e927a97b4c012
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Align the gfn as well as the pfn when "preparing" a folio

When preparing a guest_memfd folio, this patch aligns the gfn as well as
the pfn to preserve the effective gfn+pfn pair. This prevents a mismatch
set and unintentional guest crashes due to assigning the pfn at the wrong
gfn for huge folios.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index cd7a795834cb6..4082cde3f3fca 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -87,8 +87,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, stru=
ct kvm_memory_slot *slot,
>  	 * checked when creating memslots.
>  	 */
>  	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, nr_pages));
> +	gfn =3D ALIGN_DOWN(gfn, nr_pages);
>  	index =3D kvm_gmem_get_index(slot, gfn);
> -	index =3D ALIGN_DOWN(index, nr_pages);

[Severity: Medium]
If a userspace caller creates a guest_memfd memslot with a base_gfn that is
not aligned to the huge folio size, will computing the index from the align=
ed
gfn result in a misaligned index?

When passed to kvm_arch_gmem_prepare(), couldn't this cause the iteration
to go past the end of the huge folio, resulting in an out-of-bounds host
physical memory access?

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential race condition
between KVM_GMEM_POPULATE and vCPU page faults in this same file.

Looking at __kvm_gmem_populate(), the folio lock is dropped before calling
post_populate():

virt/kvm/guest_memfd.c:__kvm_gmem_populate() {
    ...
	folio_unlock(folio);
    ...
	ret =3D post_populate(kvm, gfn, pfn, src_page, opaque);
    ...
}

Could a concurrent vCPU page fault on the same GFN call kvm_gmem_get_pfn(),
acquire the folio lock, see that it is not uptodate, and clear the page
while the populate thread is executing post-populate updates like
KVM_SEV_SNP_LAUNCH_UPDATE?

virt/kvm/guest_memfd.c:kvm_gmem_get_pfn() {
    ...
	if (!folio_test_uptodate(folio)) {
		clear_highpage(folio_page(folio, 0));
    ...
}

Would this allow unprivileged userspace to trigger host hardware crashes
(Machine Check Exceptions) and guest data corruption simply by running a
vCPU thread concurrently with the population ioctl?

> =20
>  	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
>  				     folio_file_pfn(folio, index), nr_pages,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D17
