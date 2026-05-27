Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7253E8354
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898117; cv=none; b=ODuxmoA82KCnGl4I2mLNKzM/1cG0ZMeEcPaoe+lhfbKEV2Duhb/Wul7+eBa2ApdezEOqeJ6hSFtGPhVRiVkG2k9on6Xra2AZdzEP4ylaiyLTFWgaf8kdoOWen/D1OxMmpU5HmpHP2HbctHO5IAvKpM4jSwAxsnqs3ubK3yVhOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898117; c=relaxed/simple;
	bh=89MwsaT30SUmDSqOMjsQUHlaorigN0+SIrDdseQ/Wgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nc4hkWCKLLwwRfhuMpIdSdyAbfv+SQcVRJuizz0fKwS7GfkrCgVmpkUlWSmVIDwQaYSgJFk1zzJ7tNgLQ0miYLX6ykz86uCTHLJKRixfECmyqJWv/7s48FZyHJFmwyDEmy+rpJi4d73tSq6MjmW4PJq+hV6NPrFbl40s5QZ/cT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqr6OJgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqr6OJgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5251F00A3D;
	Wed, 27 May 2026 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898115;
	bh=GOPX5IARmJ6wI6rsLZCc+SqU4kdUXbdL9CQ8CbjdAx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gqr6OJgDAIAjozCoJ2WZPTQCj68CzUXGjuSVJP0f/jeJFQ37gXMNyr4EhXQ3Dved5
	 v2DD3gua0VQqtEawJQ0NCyiBPXL3KuII2DXymXZO7S6xoaR9p7Mb4CjDeyYh01H3cV
	 DshuAKfGdaqJKU10baxk2XIYOfCHAaLif6dzJMnpm4xbX5yJqSckIOfxZ/9ztZJTEF
	 hPmGx6NHJoSHRQORyOx63mLXB4tLvoJcqfSNPy5eCF6A51o6JD9nXABh+JfzF8ti+l
	 t2a35dt0PbWGOn85I6oiykBrgMM2YNVXS9aeTMbtvtF8anYDTQDLAEvEtOogVeymQ2
	 60c/J4H+gu1iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527144358.186359-3-imbrenda@linux.ibm.com>
References: <20260527144358.186359-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 16:08:33 +0000
Message-Id: <20260527160834.9D5251F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The error check `if (rc > 0) return -EIO;` is unreachable and fa=
ils to handle page table walk exceptions.

Pre-existing issues:
- [High] kvm_s390_faultin_gfn() incorrectly returns success (0) when it rac=
es with an MMU notifier, leading to silent memory skips in KVM_PRE_FAULT_ME=
MORY and potential leaks of uninitialized host memory in access_guest_page_=
with_key_gpa().
- [High] KVM_PRE_FAULT_MEMORY can trigger a deterministic host kernel infin=
ite loop if the requested GPA is within a KVM memslot but outside the gmap =
ASCE limit.
--

commit f2d2595771b18daab539c7480809ae63c3707ec4
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Implement KVM_PRE_FAULT_MEMORY

Implement and enable the KVM_PRE_FAULT_MEMORY ioctl for s390.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pr=
e_fault_memory *range)
> +{
> +	struct guest_fault f =3D { .gfn =3D gpa_to_gfn(range->gpa), };
> +	gpa_t end;
> +	int rc;
> +
> +	if (kvm_is_ucontrol(vcpu->kvm))
> +		return -EINVAL;
> +
> +	rc =3D kvm_s390_faultin_gfn(vcpu, NULL, &f);

[Severity: High]
This is a pre-existing issue, but does kvm_s390_faultin_gfn() incorrectly
return 0 when it races with an MMU notifier?

In kvm_s390_faultin_gfn(), rc is initialized to 0. Inside the retry loop,
if mmu_invalidate_retry_gfn() evaluates to true due to a concurrent MMU
invalidation, gmap_link() is skipped. But there is no else branch to set
rc =3D -EAGAIN. rc remains 0, the loop terminates matching else if
(rc !=3D -EAGAIN), and the function incorrectly returns 0 (success) while
dropping the page reference.

For KVM_PRE_FAULT_MEMORY, does this cause kvm_arch_vcpu_pre_fault_memory()
to falsely assume a huge page was mapped (since f.ptep remains NULL) and
silently skip up to 1MB of memory instead of retrying?

[Severity: High]
This is also a pre-existing issue, but can KVM_PRE_FAULT_MEMORY trigger a
deterministic host kernel infinite loop if the requested GPA is within a KVM
memslot but outside the gmap ASCE limit?

If userspace provides a GPA that falls within a valid KVM memslot but
exceeds the bounds of the guest physical address space limit (gmap->asce),
__kvm_faultin_pfn() successfully returns a PFN. When gmap_link() calls
dat_entry_walk(), it detects the out-of-bounds access and returns
PGM_ADDRESSING (5).

However, _gmap_link() blindly converts any error that is not -ENOMEM or
-EINVAL to -EAGAIN. Does kvm_s390_faultin_gfn() receive -EAGAIN and
continuously retry the exact same steps in its while(1) loop, causing an
unkillable infinite loop on the host CPU since __kvm_faultin_pfn() does
not yield or check for signals?

> +	if (rc =3D=3D PGM_ADDRESSING)
> +		return -ENOENT;
> +	if (rc > 0)

[Severity: Medium]
Is this error check unreachable?

kvm_s390_faultin_gfn() only ever returns > 0 for PGM_ADDRESSING, which is
already explicitly caught and converted to -ENOENT right above this check.
Any other PGM_ exception code from the page table walk (like PGM_PROTECTION
or PGM_TRANSLATION_SPEC) is masked by _gmap_link() returning -EAGAIN, which
then causes an infinite loop in kvm_s390_faultin_gfn().

Can rc > 0 ever evaluate to true here?

> +		return -EIO;
> +	if (rc < 0)
> +		return rc;
> +
> +	if (f.ptep)
> +		return PAGE_SIZE;
> +
> +	end =3D ALIGN(range->gpa + PAGE_SIZE, f.crste_region3 ? _REGION3_SIZE :=
 HPAGE_SIZE);
> +	return min(range->size, end - range->gpa);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527144358.1863=
59-1-imbrenda@linux.ibm.com?part=3D2
