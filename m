Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187C3E51CB
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849421; cv=none; b=OIM8cqyH9kdCpv6n/Ifds94qctUppV1DQ3CZIgIPJkCcEvutHVsRz8M7SJGrOVY2ZPuY1NdthfF478Qogam1SWOQMdysIO+a0+LffZ0//CPMZdp1aANtY2wxWoExPjtv1pGU8hhl6EIJkIVbyJdQTiTqKxcSo1adH4YaYSOsEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849421; c=relaxed/simple;
	bh=5EuGYMCaQpQOiSVpx/yRnAe9W6CzxVBaVZISm0hrOUs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HtYR3jFVmppfNpCJW5qMsaHutD7DsbTci7M/9uLj6n7PUE3hhXzYW7GJVupkaAF39G9A+3A6RelGoPPDARMXTQFAATZkubfSjZWTjDOw8o4B4jIlhdU+MEcbJTJCHo7ZR7xUvitFNg9yN/ftR9cJMGjmtGCLQTiREie/Wb7mV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzBPC1uS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzBPC1uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C79C1F0089B;
	Mon, 12 Oct 2026 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849418;
	bh=ZRyY83rHdC+8pJw0cUiBXih+nnLzyAzIcCgHqQF5gvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzBPC1uSzhCL8q3sbzQ18bQO302cAIqHUSsaHgQEMgfD3BdTe+IJQUV9XPwRGBdw3
	 sApPjfajeSdmTaO0yLWJUUbpidJBEsQyCzeGmBEsKpAaGL3iox7gXD5QwGGWP8Z1Oo
	 TIFVPih8wapRDh0dTnfZvKGWcr+8PEZ+5rJJMlD2k5s5x3Km3MJy1P7AFoAm/SSszm
	 HwhLSJfV0xDjFTSHwa8j7tRJ6KP03L6RmGZpQPt7Y6pukUnt149nb22ugTY9sTPUgm
	 Ck3tdmszyD1JPd2wlCvUBKxlwBJp0+0XfOiA8AprFMUDXbfOR6mHYVCYOpQvA19vGW
	 gINJDM28Gx7qQ==
Message-ID: <sashiko-outbox-168758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/27] KVM: x86: hyper-v: Allow purging all TLB flush
 FIFOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261012233638.2546339-16-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
 <20261012233638.2546339-16-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:56:57 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] x86/kvm: redundant guest TLB flush due to uncleared KVM_REQ_HV_TLB_=
FLUSH
--

commit fd7f6324f98d1c559f015e78c148b1f3ca58d78f
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86: hyper-v: Allow purging all TLB flush FIFOs

This commit refactors kvm_hv_purge_tlb_flush_fifo() by introducing an
inner helper __kvm_hv_purge_tlb_flush_fifo() to allow purging a specific
FIFO or all FIFOs. The refactoring delegates the KVM_REQ_HV_TLB_FLUSH
request check to the inner helper, which is now skipped if no FIFO is found.

> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 03cc65f8cc52d..a23ef05c1075c 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
[ ... ]
> @@ -312,18 +312,29 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kv=
m_hv_get_tlb_flush_fifo(struc
>  	return &hv_vcpu->tlb_flush_fifo[i];
>  }
> =20
> -static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
> +/* Purge pending TLB flushes in @fifo, or in all FIFOs if @fifo is NULL =
*/
> +static inline void __kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu,
> +						 struct kvm_vcpu_hv_tlb_flush_fifo *fifo)
>  {
[ ... ]
> +static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_hv_tlb_flush_fifo *fifo;
> =20
> -	kfifo_reset_out(&tlb_flush_fifo->entries);
> +	fifo =3D kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
> +	if (fifo)
> +		__kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
>  }

[Severity: Low]
Does this change inadvertently leave the KVM_REQ_HV_TLB_FLUSH bit uncleared
when fifo is NULL?

Prior to this patch, kvm_hv_purge_tlb_flush_fifo() unconditionally evaluated
and cleared kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu) before returning
early if the vCPU lacked an initialized Hyper-V state.

With this update, if a Hyper-V VM-wide TLB flush sets the request bit on a
vCPU without initialized Hyper-V state, kvm_hv_get_tlb_flush_fifo() returns
NULL. The helper __kvm_hv_purge_tlb_flush_fifo() is skipped entirely,
meaning the request bit remains uncleared.

If a standard guest TLB flush request arrives and triggers the purge path
in kvm_service_local_tlb_flush_requests(), the uncleared Hyper-V request bit
will still be pending when execution reaches vcpu_enter_guest():

arch/x86/kvm/x86.c:vcpu_enter_guest() {
        ...
        if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu) &&
            kvm_hv_vcpu_flush_tlb(vcpu))
                kvm_vcpu_flush_tlb_guest(vcpu);
        ...
}

Since kvm_hv_vcpu_flush_tlb() fails (returns -EINVAL) for a vCPU without
Hyper-V state, would this fallback path execute a second, redundant
kvm_vcpu_flush_tlb_guest() operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012233638.2546=
339-1-yosry@kernel.org?part=3D15
