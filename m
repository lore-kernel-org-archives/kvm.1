Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32D2AE7A
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338839; cv=none; b=ebzCtBjXwDazka3ZW/JzZlvMjqXu2Fb4Fguwib2+nPbOuLZIctIs7hvmjlxYjPs+HiUvAQENKXNAvwncB1SpqxpypXqHvCkhkogyIw4QrhPI2APhrbi9A8RIVkome8IEqHiQ4i/AWsOAELpRNJ/mw9f/z4aa/9an8OBxtzdpzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338839; c=relaxed/simple;
	bh=GOtJ5J9rhh/H7gk77L4t4j5UwJ0HSuBa/G+3vZawLq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MIQlBAa1rUQ+DhsIx973BMMsWmCHdvOP/zWhqrRdYZcaPFs2jHfoXEClgpM9WZ63kxyEP1H94ny1fHRhiuwRmmMOO0BLiB3DtnwwFSLLmWPIx1dP5w0mtBgpg3ukHBWc/HdSxJ1ZATTj0bPi00EA1Zt9zOWEts6bWElO2jV/Ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjafvx03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjafvx03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAAD1F000E9;
	Wed, 24 Jun 2026 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782338838;
	bh=cQYEigDL33ued0SJr7cbgDkRb2nNEujZ5hyw6vb6jZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rjafvx03j5Fwsc4cS3L7oq62MiyIcLcMeRyQQsE2LzySKCj6CL8w+H9oTdqlzOWCb
	 /k6NVhiiEbGb3rHIXuxPBxaQkViWUXfHEcin/IVmUSwFMwPGB7J12PQpEM5n5kG5pc
	 TUPAviipbw5LjyAMs1TX7JzypQ1TTdNLGUZsZTvy0ewzMDdqTtPwMfpVWqJ0mtG5rm
	 YifXbTIYSWGeIkckcWbbnGRFvlEU9ZbLnfwjw7mrSpj0L7R4KP4egF+mWoVSGjZXvq
	 7AvqAtozCZkClbycviQeDLPr2jHsSoseayAdpbWKnoizPVlqOkach/Wlz1YFo84bFk
	 Z7FjyaezBKfyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.2-based 01/19] KVM: x86/hyperv: remove unnecessary
 mmu_is_nested() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624214218.73796-2-pbonzini@redhat.com>
References: <20260624214218.73796-1-pbonzini@redhat.com>
 <20260624214218.73796-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 22:07:17 +0000
Message-Id: <20260624220718.2AAAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When an L2 guest issues a slow Hyper-V flush hypercall without nEP=
T/nNPT enabled, the commit fails to translate the L2 GPA or return an error=
, instead interpreting the untranslated L2-provided GPA as an L1 GPA. This =
allows the L2 guest to read arbitrary L1 memory for hypercall parameters.
- [High] When translating an L2 GPA to an L1 GPA for slow Hyper-V hypercall=
s, KVM translates only the base address (`hc->ingpa`) and then reads contig=
uous L1 physical memory. It fails to apply L2's nested EPT (nEPT) mappings =
for subsequent pages if the hypercall input data crosses an L2 page boundar=
y, leaking out-of-bounds L1 memory.
--

commit 5644e8b1976b85a1ec2e9308b24a274e70825283
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/hyperv: remove unnecessary mmu_is_nested() check

This commit simplifies kvm_hv_flush_tlb() by using kvm_translate_gpa()
instead of calling translate_nested_gpa() directly. This addresses the
nEPT/nNPT check in slow flush hypercalls.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index fd4eb1e561f7f..0b5050cccab4d 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2045,10 +2045,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu,=
 struct kvm_hv_hcall *hc)
>  	 * flush).  Translate the address here so the memory can be uniformly
>  	 * read with kvm_read_guest().
>  	 */
> -	if (!hc->fast && mmu_is_nested(vcpu)) {
> -		hc->ingpa =3D kvm_x86_ops.nested_ops->translate_nested_gpa(
> -					vcpu, hc->ingpa,
> -					PFERR_GUEST_FINAL_MASK, NULL, 0);
> +	if (!hc->fast) {
> +		hc->ingpa =3D kvm_translate_gpa(vcpu, vcpu->arch.walk_mmu, hc->ingpa,
> +					      PFERR_GUEST_FINAL_MASK, NULL, 0);
>  		if (unlikely(hc->ingpa =3D=3D INVALID_GPA))
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but when an L2 guest issues a
slow Hyper-V flush hypercall without nEPT/nNPT enabled, it appears we fail
to translate the L2 GPA or return an error.

If kvm_translate_gpa() bypasses the nested translation (e.g., because
mmu_is_nested(vcpu) is false), the L2-provided hc->ingpa is returned
unchanged.=20

Does this result in the untranslated L2 GPA being treated as an L1 GPA when
passed to kvm_read_guest(), potentially allowing the L2 guest to read
arbitrary L1 memory for hypercall parameters?

[Severity: High]
This is also a pre-existing issue, but when reading the hypercall input
data for slow Hyper-V hypercalls, does KVM fail to apply L2's nested EPT
(nEPT) mappings when the data crosses an L2 page boundary?

Later in the process, kvm_hv_get_hc_data() adds an offset to the translated
L1 base GPA:

arch/x86/kvm/hyperv.c:kvm_hv_get_hc_data() {
    ...
	return kvm_read_guest(kvm, hc->ingpa + hc->data_offset, data,
			      cnt * sizeof(*data));
}

Because kvm_read_guest() iterates contiguous L1 GFNs when crossing page
boundaries, if the hypercall input data straddles an L2 page boundary,
won't this ignore L2's EPT mappings for the subsequent pages and read
from unmapped, adjacent L1 physical memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624214218.7379=
6-1-pbonzini@redhat.com?part=3D1
