Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87A1C3318
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381529; cv=none; b=nOdAACKz5NJ4b7rh+zsPkq5y1YZ8K8WV7TpcBn4UfKVBPEgka5h8RlqUrx7yuV27y25h9strG/ToWJwyeLp1JmDfEZYLV4GoLCb0FOWQGuiA/mmeVzlj9j90CTAzmwx09lX28x4p/VK/Tw2rr0IKTE+mgGG/mMAEMIyr/afv1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381529; c=relaxed/simple;
	bh=D2l4UPSwjKaZW92b78Lz5WpX9/hOvPbhO87Arsy+08A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LnAdoxGHft/svLQmD1yVkLsc81izPABcCPNKOslPmcGeYyOFVLbZGdoS94kjJOlRktI/a+CeQIKhIlKo3xJZ8QR+ZmYeayY1Ngc4GFqhsIcalna8SKPyi8Jg/Fb+f2Eioc9s9L1BtG+6IEc4kMGdGZEzFz2qD4mUdlpQuI8Mymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCq9Sc02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCq9Sc02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9271F000E9;
	Thu, 25 Jun 2026 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782381527;
	bh=rjgNVFiJIRYsPbHuP/g8yee21thBNJXJ0xreD+jwWMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCq9Sc02DOYL62KEQ456EqwqyT2ID/7b+xlH3iwz6rbhHC/4MMoeYR4wdYu2cjhhi
	 llW9JOffqzdCS6oHYXc3kqTHJIEqKBqK6PmbsimilzbHix0b60hzFq+xN5bdYEw3yG
	 be8mvuXuy4GBHP0yGi0e3jrGc3aIYY5CNumi3wU+0snDzJ0Wd07jVUB/wmUhOX5/05
	 1pxnjNmHNit7BTcEIqNdP3mWanWjPtGGdv+Zay2EQr/FfPBL8cCbNtxQT8cXlVQjfc
	 lYsgr3qT4mhr+vR5GVyfTPITV3L2BKPo8f4hznth0LnvDoFfRL6EoFrnU2Dc+644KY
	 Mi9wOPR6T9kDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SVM: handle wraparound of asid_generation
Reply-To: sashiko-reviews@lists.linux.dev
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625094047.255954-1-suryasaimadhu369@gmail.com>
References: <20260625094047.255954-1-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:58:46 +0000
Message-Id: <20260625095846.EF9271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch claims to fix a 64-bit ASID generation wraparound, but=
 provides an incomplete solution that only shifts the theoretical ABA vulne=
rability from generation 0 to generation 1, and fails to remove the corresp=
onding FIXME comment.
--

commit ecd299cb836eda8be32eeffedf37f3e076185761
Author: suryasaimadhu <suryasaimadhu369@gmail.com>

KVM: SVM: handle wraparound of asid_generation

If asid_generation wraps around to 0, it matches the initial
value of svm->current_vmcb->asid_generation (0), causing KVM
to skip calling new_asid() and potentially reuse stale ASIDs.

Fix this by skipping 0 when incrementing asid_generation.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 24d59ccfa40d9..cfb9952f7c1f6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1794,7 +1794,8 @@ static void svm_update_exception_bitmap(struct kvm_=
vcpu *vcpu)
>  static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
>  {
>  	if (sd->next_asid > sd->max_asid) {
> -		++sd->asid_generation;
> +		if (!++sd->asid_generation)
> +			sd->asid_generation =3D 1;

[Severity: Medium]
Does skipping generation 0 fully resolve the wraparound issue, or does it
merely shift the theoretical ABA vulnerability to generation 1?

If a VMCB happens to sleep for an entire 2^64 generation cycle and wakes up
when the generation counter reaches 1 again, wouldn't it incorrectly match
the wrapped generation 1 and reuse a stale ASID?

Also, since this patch aims to handle the wraparound, should it remove the
explicit "/* FIXME: handle wraparound of asid_generation */" comment
located in pre_svm_run() just before the new_asid() call?

>  		sd->next_asid =3D sd->min_asid;
>  		svm->vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ALL_ASID;
>  		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094047.2559=
54-1-suryasaimadhu369@gmail.com?part=3D1
