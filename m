Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625430;
	b=hMqqL5Nz7thwqnH6SZ7PcH/3DMif5lq9ouzEG6Z2Q+ybEpo8HRsj7GnneKlWzYlnidwC
	 UvZ/mMZ58TbWm/jZ2MLQagllQM+8s+dibj/gl7uqIOk9zN6UltLYKYZ+HCKL6Vf2JzsEe
	 UFL6wbh8QCmtTPNpGbJ2BxMIPsP+U6hABp29E/LW2fpYhPpl0W+GthmxI33GMeSKs1HuX
	 g281Ns0jQdLDQ9ixx4Bwpe8FeWGJykUM3hVfDG1WXYhjC/Y0/MqAp/rZ2gPH3bzFhsLyl
	 LFliJ4RESkstK9SlwqfvdLKHH8YX72tu+6S7fjQS4MD6dzLcmKtMudWohYQHQqYoXTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mxrf6NKA5k9J7Z0dB+u09aH7eIW8QpQZoUvjhBdiJnM=;
	b=0lGvz1n9SwUk2b/nOQqdH2XiZxaJZ9bDBXl1c8NFLJyc+PfE9hbkR7YeiKttKdt1/ec/
	 K9KV7WDv9iEtIJM0EVcsyQTwm5j4SqBwcnCwQNTfn5ujoM6OzUf42mc4kgvJVKABfHu9d
	 GXNym2ZIeUzrdFwaRrFo2d/My7T0SeKQHynKFd2vS9tNw+XI7i7D3YY+yeGUbmLwxVSoN
	 wRH2e8FdKFEy8gisLWYJE7tD1zx1wW/k0F4kj1l3MP7zRj1/3zrqTo2Ji8w7nDAXo9TR5
	 pohJpoIaeT6U66qw/dfTbsczJbG3vND7cJWKfmZpHWTzryMH0b3fZaTedl7QBncA4sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pa73dwoR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE5606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pa73dwoR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB81F000C4;
	Wed, 25 Nov 2026 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625430;
	bh=Mxrf6NKA5k9J7Z0dB+u09aH7eIW8QpQZoUvjhBdiJnM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Pa73dwoRGtFzHtCddn+aIZ3F1YYlqCOb2lh+q3ICjPRaFGIAwSc1SqC8hrMbDe53y
	 mBQ7GjU0ileFy3K/6RQOsqymPyOTr4zkoQ+k0/Pm5zGWPugAhceJ39QY6PTW92xc/0
	 PMiy/lZ5+m84gncXkgVmBPKdymVf6LqOF5+cCdBEPxjd4X4UkTbGkvKlcjqx1Mi+EU
	 K2B6XMEySVNMWWk3atDeUBfbd013i+qSucXYCGaQ+JkqAmqg21fqAmpPJCMVZ9DVyj
	 vtuOgXTOcjHVaE5LL1zTyeOhlJfX+hKoKBfP/h7dk9bvH0S9VO7LnsZEh4Tb3qtI15
	 3okXTXfrzmqHw==
Message-ID: <sashiko-outbox-233779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] KVM: x86: nVMX: fix races in delivery of nested
 posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261125155819.408795-6-mlevitsk@redhat.com>
References: <20261125155819.408795-1-mlevitsk@redhat.com>
 <20261125155819.408795-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:50:29 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] KVM: nVMX: delayed KVM_NESTED_PI_ACTIVE misdelivers PI to
  halted/restored L2
--

commit 1837fd79b0a3f7ab8c9981e92e02daa94e796f28
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: x86: nVMX: fix races in delivery of nested posted interrupts

This commit synchronizes nested posted interrupt delivery with nested VM
exits using atomic operations on vcpu->arch.nested_guest_state and delays
enabling nested posted interrupts until KVM_REQ_GET_NESTED_STATE_PAGES is
processed when entering non-root mode outside of a VM-Entry.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index eb33528619c2f..d2f092fa076a6 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -3701,6 +3715,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>  			vmcs12->exit_qualification =3D failed_index;
>  			goto vmentry_fail_vmexit_guest_mode;
>  		}
> +
> +		if (nested_cpu_has_posted_intr(vmcs12))
> +			nested_vmx_enable_posted_interrupts(vcpu);
>  	} else {
>  		/*
>  		 * The MMU is not initialized to point at the right entities yet and
> @@ -3712,9 +3729,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>  		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
>  	}
> =20
> -	if (nested_cpu_has_posted_intr(vmcs12))
> -		atomic_or(KVM_NESTED_PI_ACTIVE | vmcs12->posted_intr_nv,
> -			  &vcpu->arch.nested_guest_state);

[Severity: High]
Does deferring nested_vmx_enable_posted_interrupts() until
KVM_REQ_GET_NESTED_STATE_PAGES cause nested posted interrupts to be
misdelivered as L1 external-interrupt VM-Exits when an L2 vCPU is restored
in a halted state?

When nested_vmx_enter_non_root_mode() runs with from_vmentry =3D=3D false
(such as during KVM_SET_NESTED_STATE), KVM_NESTED_PI_ACTIVE remains clear
until vcpu_enter_guest() processes KVM_REQ_GET_NESTED_STATE_PAGES.  If the
restored L2 vCPU is in KVM_MP_STATE_HALTED, vcpu_run() enters vcpu_block()
instead of vcpu_enter_guest().

When a nested posted interrupt arrives to wake the halted L2 vCPU,
vmx_deliver_nested_posted_interrupt() sees KVM_NESTED_PI_ACTIVE =3D=3D 0,
returns -1, and queues L2's posted_intr_nv into L1's LAPIC IRR.
vcpu_block() then calls kvm_check_nested_events() ->
vmx_check_nested_events() before KVM_REQ_GET_NESTED_STATE_PAGES is
serviced:

arch/x86/kvm/vmx/nested.c:vmx_check_nested_events() {
    ...
		if ((nested_state & KVM_NESTED_PI_ACTIVE) &&
			((nested_state & KVM_NESTED_PI_VECTOR_MASK) =3D=3D irq)) {
			if (block_non_injected_events)
				return -EBUSY;

			atomic_or(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);

			kvm_apic_clear_irr(vcpu, irq);
			goto no_vmexit;
		}

		if (block_nested_events)
			return -EBUSY;

		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT,
    ...
}

Because KVM_NESTED_PI_ACTIVE is still clear, vmx_check_nested_events()
does not recognize irq as L2's posted-interrupt notification vector and
injects an EXIT_REASON_EXTERNAL_INTERRUPT VM-Exit into L1 instead of
processing L2's posted interrupt descriptor.

Similarly, if the restored L2 vCPU is runnable and receives a nested
posted interrupt before vcpu_enter_guest() runs, the vector is placed in
L1's LAPIC IRR without setting KVM_NESTED_PI_PENDING, so any higher
priority nested VM-Exit (or a masked L1 PPR) causes __nested_vmx_vmexit()
to miss __vmx_complete_nested_posted_interrupt().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125155819.4087=
95-1-mlevitsk@redhat.com?part=3D5
