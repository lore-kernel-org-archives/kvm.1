Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7937B00E
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573432; cv=none; b=jvdzZAEya/Bsut567OTZpOwCTEU0aU7Otximd/JgGJq88dIXewPCF1jwYOlpgDz8JtEqpeOhiAoR0D22Kkl88PsmBNaP7NrSYH0dNz4Z0r0nHj8B7T/KvcBcH2sjyRrMpSyh8P6LtmQN9ZDqUIdGvj/tH4LdIbZnjO/Hxt/PzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573432; c=relaxed/simple;
	bh=42ms3LyzSBtOQcDtFJD9SCoXHgxddCaTmPrWTv07qkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NQelaHRlDtAKc1vRU1UTultIAA1Uxa1jwV+2a8FlGYaM8TINcfZWo2EBaLbi/M2YLzFCJyoVoLc4CxI6TYBQ+5Vkxv49YjjXCOE7ow7oSlNHL6vaJTk5Rj3rJ+sqhzTxOgJw00C1jEuzARGMqrTFpTn6p38VVcidOmKjjMlRsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl54k0ya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl54k0ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DAC1F000E9;
	Tue, 16 Jun 2026 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573431;
	bh=Ux1tUcYrQAwB+oa3bjt6cl0qI7/BP5RR2zAlmyhk6bA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gl54k0yaMcDOasMXLIqNz43JJxyhWL6+2x9gLyRe9Dyb/QDOfreox9YsRtr+mseuq
	 kdw15dzSkhmIiNLW1WHNWetRLH9oyl/YZ4hKDi9Qg9WLOCJyTF2uCKzez2I6JE9ZdO
	 bAg1sAr/Q+xFS03se5kGS4y6wM8Y1vfB+XnsD/sRP/l8XWBcuSww5CjtI2wxstXokc
	 k0qacqfcoXQYkL3Jlaf5rTAm/9kw0EGnNRkd8pveyLehojf7v0cZz5zhoNxxLW/+1Y
	 avTDbXs0i7VAYV8vxHG9NM9/X+5EpHYX8UpY+E+dNecZCOSWG7/s7owzIoNG1LxR+t
	 ltycYaBnclfCQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and
 L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616004155.1435766-25-yosry@kernel.org>
References: <20260616004155.1435766-25-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:30:30 +0000
Message-Id: <20260616013031.53DAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Failure to reset `svm->nested.last_asid` during nested SVM tea=
rdown allows L2 guests to run with stale TLB entries from recycled ASIDs.

Pre-existing issues:
- [Critical] Dangling pointer `svm->nested.vmcb02.ptr` leaked on the `svm_a=
llocate_nested()` error path leads to a Use-After-Free write during TLB flu=
shes.
--

commit 0fdb61625f72b8737a6f7fe184ab78e2c15d5576
Author: Yosry Ahmed <yosry@kernel.org>
KVM: nSVM: Use different ASIDs for L1 and L2

This patch modifies nested SVM to allocate a separate hardware ASID for L2
for each vCPU. It drops the unconditional TLB flushes and MMU syncs on nest=
ed
transitions, replacing them with proper tracking for L1 vs L2 ASIDs.

Link: https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuoz=
zo.com/

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index a226aca8f9108..56b769b603ca9 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -1539,7 +1532,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
>  	if (!svm->nested.msrpm)
>  		goto err_free_vmcb02;
> =20
> -	svm->nested.asid02 =3D svm->asid;
> +	svm->nested.asid02 =3D allocate_asid();
> =20
>  	svm->nested.initialized =3D true;
>  	return 0;
> =20
>  err_free_vmcb02:
>  	__free_page(vmcb02_page);
>  	return -ENOMEM;
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but does the error path here lea=
ve
a dangling pointer in svm->nested.vmcb02.ptr?

When msrpm allocation fails, the vmcb02_page is freed, but
svm->nested.vmcb02.ptr is not explicitly cleared. If a subsequent TLB flush
occurs on this vCPU, for example via MMU notifiers:

svm_flush_tlb_all() {
    ...
    if (svm->nested.vmcb02.ptr)
        vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
}

Could this result in a use-after-free write that corrupts the freed memory?

[ ... ]

> @@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm)
>  	if (WARN_ON_ONCE(svm->vmcb !=3D svm->vmcb01.ptr))
>  		svm_switch_vmcb(svm, &svm->vmcb01);
> =20
> +	free_asid(svm->nested.asid02);
> +

[Severity: Critical]
When the hardware ASID is freed here during nested SVM teardown, does
svm->nested.last_asid also need to be reset to 0?

If L1 disables SVM, svm_free_nested() is called, freeing asid02. This ASID =
tag
can then be reallocated. If L1 later re-enables SVM and uses the same L1-ma=
naged
ASID, nested_svm_entry_tlb_flush() will see:

nested_svm_entry_tlb_flush() {
    ...
    if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
        svm->nested.last_asid =3D svm->nested.ctl.asid;
        new_asid =3D true;
    }
    ...
}

This check would fail to set new_asid =3D true. Since this patch removes the
unconditional TLB flush on nested entry, would this regression allow the L2
guest to run with stale TLB entries from the previous owner of the realloca=
ted
hardware ASID?

>  	svm_vcpu_free_msrpm(svm->nested.msrpm);
>  	svm->nested.msrpm =3D NULL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.1435=
766-1-yosry@kernel.org?part=3D24
