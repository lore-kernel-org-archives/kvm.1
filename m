Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024CD3BB13E
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803897; cv=none; b=nuOlD9yz/hddbsjok40tFskM1Z1M5s1MVLK39fUfgAQxv+nhYubwdQ2a2qKr18WO0Qvn6u24B67KhZDsVC0jYeb2lAB+VhsCb+l91p9p5joPHdTkIzBTE9zrxewDG9Z4OlIzuQIFwUeXcdXkQkH/1QyX3md1wHQwpboWmWVqnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803897; c=relaxed/simple;
	bh=JiMEyaFNVIZSWW1K/PcraIMf0L2hk0rInPBwx2L3tEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxOhAUvPrRagPTteC0fe9wmLWGnepCjMktSSpwswYTkdV6NjUW5vWTI8vCmwENNFvui+uunSNm5XyIs1wVDhf4vyoSEhL/fL/LrhwvtrHDhyUjO1bagnO1+TIufv4drssiKN4KfRXke1Mixs07b8N7q+GsmooB/xuTUZgWLV6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3+n3Jld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3+n3Jld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8961F000E9;
	Tue, 26 May 2026 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803890;
	bh=ErVWzd266CtKPfG0j8UHh7NH3/RYwetvrXKMdWAlzhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3+n3Jld+HkIvPopvAond/VkblFBFJGi625jyuFvcP+0mMPBxLRbIznczNni4zsgm
	 66MTkpz5I94VSkjER+1aKh5OKkbXw3zTLIbynW0qMM4BYdm3Qf2pEWmKln+5OMfYoS
	 LNG7/K5uHX/zMxdNHDpHyTLxXAUDLPhfKkNACuT3pQkw3MfDIwinLGRHlbHDbU/e83
	 LiN8xMaeeX0Z2/0hrSEAsPRPc4Dcn8ZxBxl2S9DIEW7dCAC4zkIUEW7xUX6tX61xkh
	 ZcwdppGqQmh6Aebd7nMeV56carA/yYU95fp8hBhHuONIxT6plBJi+Tts1e/a1By2uN
	 J4Wj4F+cYy2oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] LoongArch: KVM: Check msgint feature in
 interrupt post
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125256.2511876-3-maobibo@loongson.cn>
References: <20260526125256.2511876-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:58:10 +0000
Message-Id: <20260526135810.BC8961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch silently modifies the KVM_INTERRUPT ioctl behavior for=
 `irq->irq =3D=3D 0` (INT_SWI0), introducing an asymmetric and undocumented=
 UAPI change.

Pre-existing issues:
- [High] The local array `vector` is not initialized, which causes uninitia=
lized stack memory to be evaluated and exposed to the guest VM during inter=
rupt injection.
--

commit 9895570eabb4c4a9d430bb3b664e6aebc5a28711
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Check msgint feature in interrupt post

This commit moves the check for the VM msgint feature from the interrupt
handling path to the interrupt posting path to optimize the hot path during
VM context switches. It also alters the interrupt ioctl handling logic for
queueing interrupts.

> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrup=
t.c
> index a18c60dffbbae..48dd56aa4dc56 100644
> --- a/arch/loongarch/kvm/interrupt.c
> +++ b/arch/loongarch/kvm/interrupt.c
> @@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsig=
ned int priority)
> =20
>  	switch (priority) {
>  	case INT_AVEC:
> -		if (!kvm_guest_has_msgint(&vcpu->arch))
> -			break;
>  		dmsintc_inject_irq(vcpu);

[Severity: High]
This is a pre-existing issue, but I noticed a potential uninitialized memory
evaluation in dmsintc_inject_irq() which is called here.

In arch/loongarch/kvm/intc/dmsintc.c:dmsintc_inject_irq():

void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
{
        unsigned long vector[4], old;
        ...
        for (i =3D 0; i < 4; i++) {
                old =3D atomic64_read(&(ds->vector_map[i]));
                if (old)
                        vector[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0=
);
        }

        if (vector[0]) {
                old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
                kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, vector[0] | old);
        }
        ...
}

The array vector is declared on the stack without initialization. If
atomic64_read() returns 0, vector[i] retains its uninitialized value.
When it is subsequently checked with if (vector[0]), could it evaluate to
true due to stack garbage, causing random spurious interrupts and exposing
kernel stack memory to the guest's ISR registers?

Could we initialize the array to zero to prevent this?

>  		fallthrough;
>  	case INT_TI:

[ ... ]

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index df5be9b265e8d..ebd432da3ca4c 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1493,14 +1493,18 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcp=
u, struct kvm_interrupt *irq)
>  	if (vector >=3D EXCCODE_INT_NUM)
>  		return -EINVAL;
> =20
> -	if (intr > 0)
> +	if (!kvm_guest_has_msgint(&vcpu->arch) && (vector =3D=3D INT_AVEC))
> +		return -EINVAL;
> +
> +	/*
> +	 * Clear irq with INT_SWI0 (which is 0) is missing from SW side
> +	 * INT_SWI0 is cleared by guest kernel with the similar instruction
> +	 * clear_csr_estat(1 << INT_SWI0)
> +	 */
> +	if (intr >=3D 0)
>  		kvm_queue_irq(vcpu, intr);
>  	else if (intr < 0)
>  		kvm_dequeue_irq(vcpu, -intr);

[Severity: Medium]
The commit message mentions moving the msgint feature check, but omits
documenting this logic change for KVM_INTERRUPT ioctl behavior.

By changing if (intr > 0) to intr >=3D 0, INT_SWI0 (which has a value of 0)
can now be queued. However, since the dequeue condition remains intr < 0,
and -0 evaluates to 0, it seems impossible to ever dequeue INT_SWI0 via
this interface once it is queued.

Is this asymmetric queueing and dequeueing behavior for INT_SWI0 intended,
and could the functional UAPI change be documented in the commit message?

> -	else {
> -		kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
> -		return -EINVAL;
> -	}
> =20
>  	kvm_vcpu_kick(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125256.2511=
876-1-maobibo@loongson.cn?part=3D2
