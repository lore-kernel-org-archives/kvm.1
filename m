Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A12C2374
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572858; cv=none; b=jGHwEx+6U8ifdr2NgN3Vk9k3x518SKXODh3ONOTZHfkEDrrhkvzV5xy96zPw2NnPVP2aCZztKRbJMclEhRA21MZ5C6TRi+lENy9AaN1xezEyzJrLtJyJgXZxb+DmK0pJk6EP5M8oLBWDrIVSQ2zeCSo2B1VR+cIJBhtlN54SBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572858; c=relaxed/simple;
	bh=9rmFleEqEZ1NoGZC1U5yhbxeMLWUVsjEi6avQ4rbQOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n4F+48JvaDuxodJD05FeFSBqVkk4gFCmrbu1GBxKUDSEEUPeq+yfngr9T8xJGzzG+n5MlDUgLvcbAlWhUdAOgznbnyDcmzK6SgCoRDWBT8DAH3fFbnoTiro6q0ygZzHYBc/YeckGQoj8gJfawrzoRPY4TuLCv2l6/GHi5eU+V5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/o5VpJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/o5VpJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669B91F000E9;
	Tue, 16 Jun 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572856;
	bh=895wIXkkxKK43qyU382LZ9LxyjRlaMapTx8LLJIpPYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/o5VpJvCFE1xMS2FzmJ8/T1+Roim5xU4f0H53xb3KmBoiaADw0NzAt3xb+cPUMJ+
	 8sC5AHgSzUi4TDtWN92rWC7Y7zDPTgyppmZruVEaagDf/qr9J+Ctx6yjUCd+iMvkqA
	 DqbXhY+yfh8DGlxi+l/URDGDsbMCyjts8WQ3zk5ZLYWf9oobn18flmTlllO8YzRLne
	 76eDtJ4Dm3EYRLgDyxKmzifdHHbagqo5trqWCQj1NfgArVkYiWycPLLBEHiiEJfniH
	 I233IYjH28P/TA5Xw0ARE+OcUjDQ+vfooBvG2UQKGdqUIzz8+cAVxnKZqpjj3WDlHO
	 PHmCBVaH14mKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes
 before nested transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616004155.1435766-18-yosry@kernel.org>
References: <20260616004155.1435766-18-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:20:55 +0000
Message-Id: <20260616012056.669B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Context mismatch in `svm_switch_vmcb()` incorrectly applies global=
 TLB flushes to the outgoing VMCB and clears the request bit, causing the i=
ncoming VMCB to miss the flush. Furthermore, on nested VM-Exit, `leave_gues=
t_mode()` is called before `svm_switch_vmcb()`, causing `kvm_hv_purge_tlb_f=
lush_fifo()` to incorrectly reset L1's Hyper-V TLB flush FIFO while hardwar=
e flushes are applied to L2's `vmcb02`.
--

commit 5fb35fcca4bb6e1756cc67fdc65ffe16ab6c194f
Author: Yosry Ahmed <yosry@kernel.org>

KVM: nSVM: Service local TLB flushes before nested transitions

This patch updates nSVM to service local TLB flush requests before
switching VMCBs during nested transitions. It aims to ensure flushes are
applied to the correct context, similar to how nVMX handles them.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 234724d8b4c54..7b19191e0e43f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *svm, st=
ruct kvm_vmcb_info *target_v
>  {
>  	struct kvm_vcpu *vcpu =3D &svm->vcpu;
> =20
> +	/*
> +	 * TLB flushes are applied to the VMCB, so apply any pending TLB flushes
> +	 * on the current VMCB before switching to a new one..
> +	 */
> +	kvm_service_local_tlb_flush_requests(vcpu);

[Severity: High]
Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH_GUEST)
while applying them only to the outgoing VMCB?

If a host-initiated flush occurs (e.g., from page reclaim), the request
bit will be consumed and applied to the outgoing VMCB, leaving the incoming
VMCB to miss the flush and run with a stale TLB.

Also, is there a context mismatch here during nested VM-Exit?

In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
svm_switch_vmcb(svm, &svm->vmcb01).=20

Because of this, kvm_service_local_tlb_flush_requests() will see
is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO while the
hardware flushes are actually being applied to L2's vmcb02.

> +
>  	svm->current_vmcb =3D target_vmcb;
>  	svm->vmcb =3D target_vmcb->ptr;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.1435=
766-1-yosry@kernel.org?part=3D17
