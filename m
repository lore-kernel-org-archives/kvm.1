Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEF3A960F
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631188; cv=none; b=TFVw4xQLYUFJ4Wm5SjwQe97CVQh38z+WhvihTfxpvIL13T4okxsKy0qCx53zHqIRBTKJBDUDNg+soKQQiSaFySwqgO8PggmKc55Mj1DlCh3u0VYz67sZaDBxxfno4x8AeZSQyk9BU4CmZ4/X1DCr7Ct2ptjWf3vT5FctDVLPbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631188; c=relaxed/simple;
	bh=sn6EsAblLVeBH53cp5CikTNNMzOpooXvROjXGYVe5n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iA8L0quqxFCzi4v6zMOpmsYy6dsiuQ5FZebSI9jTbjhWyaElxM5inE6alabstbgm50g4OTKKvJ89NQNqCBrLdBK4FZYkTnOVXnB7jRY3y++vDsBvUOKP8JTMjDWUsyhfWfRVVY9wr1a90sAjuvStTIlkGKPME7Zh1gMb2DRuqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxoqv/ZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxoqv/ZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6FF1F000E9;
	Thu,  9 Jul 2026 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631186;
	bh=jbKKOAA8iXso8XwuSZ4twtGdAAWES+SWRZiCPcvzH+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yxoqv/ZTaEatUGk4y8tdVwUm+3UPcZB0sWKzMJJeyP1GWHQm62VDWkG6wQ4CX5/K/
	 DGYBGJQcGPoHfiquw6DMRA1WxsI9ZK74HR2K60BVpjYQ4lm3ef3KZJlfLpirTnGYS1
	 9BxGsZYbmwtv4UO1j1oGKJ8u3bbMklPBBCQUlMA4zKXZIkvNpU/KELRpc0qefsvtRY
	 ihMSsUOPdVotQa60TVnWfzozaFoVFy8iM2pLKrXzCi/llzHzvRjy2JGwkD6NWk4C3s
	 4+3HiPLlCkhYy3jLvrC9TLyRAZT6grBDk+LyZlic9JCuUaGtw7aKx1U/+Yt+GEgce9
	 N6P2e548IiK4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/18] KVM: SEV: Extract loading of guest-provided
 VMSA to a separate helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-3-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:06:26 +0000
Message-Id: <20260709210626.BD6FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing MMU invalidation sequence check and invalidation hooks=
 when resolving and installing the guest memory PFN into the hardware VMCB =
(`vmsa_pa`), allowing a guest to trigger a host Use-After-Free via hole-pun=
ching.
- [High] Early return on failure to retrieve or load the VMSA PFN leaves th=
e vCPU permanently in the `KVM_MP_STATE_HALTED` state, causing KVM_RUN to h=
ang indefinitely instead of returning an error to userspace.
--

--- Patch [2]: [PATCH v4 02/18] KVM: SEV: Extract loading of guest-provided=
 VMSA to a separate helper ---
commit 77b2286f40978a436ebf37446c67270e552074af
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Extract loading of guest-provided VMSA to a separate helper

Extract the loading/retrieval of a guest-provided VMSA to a separate helper
so that KVM can reuse the core logic when refreshing the VMSA after an MMU
invalidation from guest_memfd.

Cc: stable@vger.kernel.org # 6.12.x

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 827f5dc061023..d8ed00f76aa31 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -4011,12 +3999,9 @@ static void sev_snp_init_protected_guest_state(str=
uct kvm_vcpu *vcpu)
>  	 */
>  	vmcb_mark_all_dirty(svm->vmcb);
> =20
> -	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
> +	if (!VALID_PAGE(gpa))
>  		return;
> =20
> -	gfn =3D gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
> -	svm->sev_es.snp_pending_vmsa_gpa =3D INVALID_PAGE;
> -
>  	slot =3D gfn_to_memslot(vcpu->kvm, gfn);
>  	if (!slot)
>  		return;

[Severity: High]
This is a pre-existing issue, but if the VMSA loading fails here (e.g., due
to an invalid GPA or missing memslot), does the vCPU remain permanently
locked in KVM_MP_STATE_HALTED?

Since sev_snp_init_protected_guest_state() marks the vCPU as HALTED before
calling this reload helper, returning early bypasses the eventual transition
to KVM_MP_STATE_RUNNABLE. Could this cause KVM_RUN to hang indefinitely
instead of safely returning an error to userspace?

[ ... ]
> @@ -4040,7 +4025,7 @@ static void sev_snp_init_protected_guest_state(stru=
ct kvm_vcpu *vcpu)
>  	svm->sev_es.snp_has_guest_vmsa =3D true;
> =20
>  	/* Use the new VMSA */
> -	svm->sev_es.snp_guest_vmsa_gpa =3D gfn_to_gpa(gfn);
> +	svm->sev_es.snp_guest_vmsa_gpa =3D gpa;
>  	svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);

[Severity: Critical]
This isn't a bug introduced by this patch, but does resolving and installing
the PFN directly into the hardware VMCB (vmsa_pa) without using the
mmu_invalidate_seq retry protocol allow a guest to trigger a host
use-after-free?

If an untrusted guest triggers AP creation with a guest_memfd-backed VMSA,
and then punches a hole in that guest_memfd, could KVM miss the concurrent
invalidation since this path doesn't check the invalidation sequence under
kvm->mmu_lock? The hardware might continue using and writing to the freed
page.

> =20
>  	/* Mark the vCPU as runnable */
> @@ -4054,6 +4039,31 @@ static void sev_snp_init_protected_guest_state(str=
uct kvm_vcpu *vcpu)
>  	kvm_release_page_clean(page);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D2
