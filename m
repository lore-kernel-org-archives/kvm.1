Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19233936B
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786597049; cv=none; b=r1pCCN2Hy4NSi9ad9RrvwyXe/LZ/9KVUfJCXuHPWijxJ/EU5+lWqkwOWWXjztWnDkenWy2Ej2pis7Qzz+MxxwU4qLiXzbiczBd2W5xV4D9u8Gzgg7ZBcRismexqIsqwEDxuzZdND7ujhxh9B+LEPTrh/wtX+3jCDP8VDbTn7O64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786597049; c=relaxed/simple;
	bh=EkR/HzsHgp69LLnuHdAgq/1v/rcIjpylLpWgW0v1Gog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJ5xth6SncsO+jpQi+YpA6cLOcwvZtSHA+9gSmi+6VIsiAAGhT0AmFKKgZdixcv+MnjyGW/+77ZuM8ez9GRqhxppbwescqEPwTyLvgPSmJZ7vXKRWxFS9JMDLrXp/131we9dVVPG+s5TbmIT8UVlVRr+dJ0TVfWUHbESNsC+nCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkErHoy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkErHoy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903981F000E9;
	Thu, 13 Aug 2026 04:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786597047;
	bh=DGovaHJczWC91v9AVf4SkRjibDBg6E/QuJiJb9qlr98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OkErHoy3zbjHEQa5PvG/eJ3GJpmLA31czxhLD/plXLCDVhAnhsH7xUBK82lioMqw5
	 Vmr5Z0bDjdewtiFj30rDeyLBeHhAAwjEOqsTtuTJY4YImEj9gSAXfa248jOrydA882
	 qkB/VKV+7T2VYcfgQI6FMuRF0sow9yt21Vnm8Pw9aEGW+1GDiymUfUtrer/FcwCpi1
	 M4R3kgnwQnZJwerhxH3T22wFXWDw3mbRe9iz0OmvTaZtqiQyKfHV00RX5hkKcaLSry
	 JneIF7B2RrNCUTjwbRDH+dEMJjvHzzhufnvmam7IjljEfnoqd68+BcwyDbhW0U5KOd
	 kz9XJb0tHo9Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping
 the pages fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinwoo Lee" <rkskek9254@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260813043932.3214460-1-rkskek9254@gmail.com>
References: <20260813043932.3214460-1-rkskek9254@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:57:27 +0000
Message-Id: <20260813045727.903981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes the missing re-arming of `KVM_REQ_GET_NESTED_STATE=
_PAGES` in `nested_get_vmcs12_pages()` for VMX but overlooks identical vuln=
erabilities in `vmx_get_nested_state_pages()` (VMX eVMCS) and `svm_get_nest=
ed_state_pages()` (SVM).
--

--- Patch [1]: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mappin=
g the pages fails ---
commit ce93ee9654c7f639f51372bb8a7e1b25a376436b
Author: Jinwoo Lee <rkskek9254@gmail.com>

KVM: nVMX: Re-arm the vmcs12 pages request if mapping the pages fails

This commit ensures KVM_REQ_GET_NESTED_STATE_PAGES is re-armed if
nested_get_vmcs12_pages() fails to map the pages. This forces KVM to retry =
the
mapping on the next KVM_RUN rather than resuming L2 with a stale vmcs02, wh=
ich
prevents hardware from accessing unpinned host physical pages.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ddf6df7bee93b..9e9bd6c541baa 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -3525,6 +3525,20 @@ static bool nested_get_vmcs12_pages(struct kvm_vcp=
u *vcpu)
>  		exec_controls_clearbit(vmx, CPU_BASED_USE_MSR_BITMAPS);
> =20
>  	return true;
> +
> +fail:
> +	/*
> +	 * Re-arm the request so that KVM retries the mapping instead of running
> +	 * L2 with a stale vmcs02.  Bailing here leaves the vCPU in guest mode
> +	 * with vmcs02 loaded and its APIC-access, virtual-APIC and posted
> +	 * interrupt descriptor addresses still pointing at the host pages that
> +	 * were mapped for the *previous* nested VM-Enter, which have since been
> +	 * unmapped and unpinned by nested_put_vmcs12_pages().  KVM returns to
> +	 * userspace without leaving guest mode, so if userspace resumes the
> +	 * vCPU, VM-Enter succeeds and hardware accesses those stale HPAs.
> +	 */
> +	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> +	return false;
>  }
> =20
>  static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)

[Severity: High]
This is a pre-existing issue, but should the same re-arm be applied to
vmx_get_nested_state_pages() and svm_get_nested_state_pages()?

If nested_get_evmcs_page() fails in vmx_get_nested_state_pages(), it returns
false and exits to userspace with KVM_EXIT_INTERNAL_ERROR without re-arming
the request:

arch/x86/kvm/vmx/nested.c:vmx_get_nested_state_pages() {
	if (!nested_get_evmcs_page(vcpu)) {
		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
				     __func__);
		vcpu->run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
		vcpu->run->internal.suberror =3D
			KVM_INTERNAL_ERROR_EMULATION;
		vcpu->run->internal.ndata =3D 0;

		return false;
	}
    ...
}

Similarly, in arch/x86/kvm/svm/nested.c:svm_get_nested_state_pages(), if
load_pdptrs(), kvm_hv_verify_vp_assist(), or nested_svm_merge_msrpm() fail,
they also exit without re-arming.

If a compromised QEMU sets KVM_REQ_GET_NESTED_STATE_PAGES and KVM clears the
request but fails in these setup steps, a subsequent KVM_RUN could skip sta=
te
setup and proceed directly to VM-Enter L2 with stale control structures.

Does this allow L2 to resume with unpinned HPAs and lead to a use-after-fre=
e?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813043932.3214=
460-1-rkskek9254@gmail.com?part=3D1
