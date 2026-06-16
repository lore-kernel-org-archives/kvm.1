Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8191A5B9E
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571937; cv=none; b=u3dgdHeAveqWBYsfZvRdTi2xRSeAUgd7NpNRYCSXS92xQig79dRBTSAVbKnetC4RgXAZYFxKsnDXPouXu3tLcS5tIuqdWdYK1HKwQ5mkCgz4VqnIuoh2o2aMkckYnQhKbfeX/irg+NlqNxJmWofb8mSCC7HIleSY568Rqttr2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571937; c=relaxed/simple;
	bh=uJdsYMwXFPuhbtN51qdRLn3iBblMZOnyLsVXX8AQC0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E10ES4HLRuiUhNbdacjgHIguQllGAQ6g5O4VSW1Pi+gpWi0Dv4nvWZe+Wpmvo9gnKwRruDGy5rorTwcbMPmeYOY7opAT/ojetUTW+OCDlujAujX8gjWJB+dM45u8fQk0x2xAQycaBXgOWI85uSlx0/OItQ8kQSII852LEvgbwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/bBvUL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/bBvUL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8511F000E9;
	Tue, 16 Jun 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571934;
	bh=giEF0YGxu62745ft+5adUqz0MHj6+feURlVbyjIs+FA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n/bBvUL+hDj/yx9gg3IIfuUt33lL61jcXaazpPuR2SwcU/D4254RJBJv/5ihTu2bQ
	 iTNZaWyaIBqxQP+RnVFbXIu6XIqPCsWnWVfRytOWZTETtd509Y+l7PTI9hl5J27DYe
	 qo8Pov8QI2vDtMsmESaFbzTT2czZ7IwaQYJa8rokVkqrg0+Lx9eugyxLHH37PZobJL
	 j7YwjFD0myX8SHkBtcm+8OK6PShcO8+QvVUzkyJYSb9itdzL+hzgAXTXOD+42l7mYW
	 Bl9L5XdxyzDxV2sw5wbqIbO6TAsUZQ6QnUxFqhZCus+8+PQrLCeiwRw0CETjcXGmyA
	 MxtEOuAU1pm/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 13/25] KVM: nSVM: Flush both L1 and L2 ASIDs on
 KVM_REQ_TLB_FLUSH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616004155.1435766-14-yosry@kernel.org>
References: <20260616004155.1435766-14-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:05:33 +0000
Message-Id: <20260616010534.2C8511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Dereferencing `svm->nested.vmcb02.ptr` without verifying `svm->nes=
ted.initialized` causes a Use-After-Free write if `svm_allocate_nested()` p=
reviously failed.
--

commit 88a69b7a032d088ddb452c91fba161d26dbed0ec
Author: Yosry Ahmed <yosry@kernel.org>

KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH

This commit modifies svm_flush_tlb_all() to flush both L1 and L2 ASIDs
to properly handle KVM_REQ_TLB_FLUSH across all contexts. It also purges
all Hyper-V TLB FIFOs for both L1 and L2.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index dac3d0098bb77..4f13c3456a5d7 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -4213,7 +4215,11 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcp=
u)
>  	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
>  		hv_flush_remote_tlbs(vcpu->kvm);
> =20
> -	svm_flush_tlb_asid(vcpu);
> +	kvm_hv_purge_all_tlb_flush_fifos(vcpu);
> +
> +	vmcb_set_flush_asid(svm->vmcb01.ptr);
> +	if (svm->nested.vmcb02.ptr)
> +		vmcb_set_flush_asid(svm->nested.vmcb02.ptr);

[Severity: High]
Could this dereference of svm->nested.vmcb02.ptr cause a use-after-free?

If svm_allocate_nested() successfully allocates vmcb02_page and assigns it
to svm->nested.vmcb02.ptr, but a subsequent allocation (such as msrpm)
fails, the error path frees the page but does not clear the pointer:

arch/x86/kvm/svm/nested.c:svm_allocate_nested() {
    ...
err_free_vmcb02:
    __free_page(vmcb02_page);
    return -ENOMEM;
}

If a TLB flush is later triggered and calls svm_flush_tlb_all(), the check
for if (svm->nested.vmcb02.ptr) would evaluate to true on the dangling
pointer, and vmcb_set_flush_asid() would write to freed memory.

Would it be safer to check svm->nested.initialized here instead, to ensure
the nested state is fully allocated and valid?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.1435=
766-1-yosry@kernel.org?part=3D13
