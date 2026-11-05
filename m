Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900399;
	b=novkt8aJaeZhzIngIY+rxjERYz2YLnMCX9nxoCuRB/trgA0ULMK+b9bNvcDxIgiHKTMe
	 QLv8Ikg6Sf/dK4NKP5+dwtI18Q0HKat0DEYSKAWzenaqyz7LDtbgfxoDcN9zFU8NYuhWr
	 0jftZKi5/DxMSUdnYr8sOI751kkCXzZgsTP4U59cMQQhQLfosCJ6HjHbBWRiUOVKGY3t7
	 +mfLbyoL+i3/KGFLzZFJCXor/zxdzV6A7kGSUwMqY3CDgNJSk/Tj3NtlIQd4mxhH/YUZk
	 hOhblWXsQZFAb7540K6kS7SnaTIkS94zlqeRyd/cxLaUlwNZklsXwveLWcZNypQdlgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5IuQ2LIASqU+8WcfjUgkbAn0VQq/Ius7honjWE6ee4M=;
	b=3o/8mJTyTLqhOvPzRPb0BjY5YfyLWo4tByHfFu95ZqIAYbHYjZ8I3fWScKDjseW6cHIu
	 kof+oNTacsXY0nyYLTSbNpfMXRKKfBqWQ1bTZJSz6CgLbxZNCBWaW5CtkuM2F2oUan654
	 L9UdCFA/17mWuRhuVTBXdpRQvVwk2ldw3dIhMgfY8e5yoQDzNCAjTN2tZiJGrLoFSmq6a
	 DzAtdh24D2uPKLsjNQ7w0roPZ/V/mYnVkmHceQuehPhZFWQyhOuJYUZgZyNo4bSXqDFBv
	 U/KgLnKMJ8H7VZ0cSdQeZxzosMPv9AolV50z36fAlNsn0LC8OLo4rtK1wn/zf/MvBkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNtM58GX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA2606A329
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNtM58GX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E81F000C1;
	Thu,  5 Nov 2026 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900399;
	bh=5IuQ2LIASqU+8WcfjUgkbAn0VQq/Ius7honjWE6ee4M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eNtM58GXT5190Qsj8qA/OVURob/4ZUsh+LfD2EtBrwQsR2QDG3NihDkY2xQN1K++Q
	 t1oBFq4uoPGiBRIFnJUBf6N9tLTCxlaeliJBxzVpCicfRGv8O6dSS1gTXwrf148dra
	 KpddYjkBTCEtX/JF2OjqoRy+xAIP9RaqBdCkcxS2wdafzdIt2g0dXAgmJI1JpfOeL2
	 QKfcGzmu/USCBbTcMYDwcaIIOb61FpL1o1wMMTLqTya4HIdwR3Q74comtAs+f/myzx
	 kHw7yAiYMiTexTYa66FtbkE84CVDKkmuwcW1rZcyVythNOlIsa1089vrsDZMka9Bb/
	 BOXfdUftmVKdg==
Message-ID: <sashiko-outbox-199646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] KVM: x86: move asynchronous page fault handling to
 vcpu_enter_guest()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261105164531.313849-6-pbonzini@redhat.com>
References: <20261105164531.313849-1-pbonzini@redhat.com>
 <20261105164531.313849-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:39:58 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86: stack use-after-free in vcpu_enter_guest() when APF toke=
n is 0
--

commit c5a7c8d28f1e59908884ea94549586d942a8b76f
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: move asynchronous page fault handling to vcpu_enter_guest()

This commit moves host paravirtualized asynchronous page fault handling out
of the MMU page fault paths and into vcpu_enter_guest() using a new
EXIT_FASTPATH_APF fastpath exit completion and a stack-allocated
kvm_task_sleep_node.

Link: https://patch.msgid.link/auqAsEk9o6buPNiR@google.com

> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 3cb2616d88aca..c01a1cf70d77b 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -163,17 +163,20 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
>  int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
>  				u64 fault_address, char *insn, int insn_len);
> =20
> -static inline void kvm_handle_host_apf_irqoff(struct kvm_vcpu *vcpu, u32=
 token)
> +static inline fastpath_t kvm_handle_host_apf_irqoff(struct kvm_task_slee=
p_node *host_apf_node,
> +						    u32 token)
>  {
> -	vcpu->arch.apf.host_apf_flags =3D kvm_read_and_reset_apf_flags();
> -	if ((vcpu->arch.apf.host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT) &&
> -	    !kvm_async_pf_queue_task(token, &vcpu->arch.apf.host_apf_node)) {
> -		/*
> -		 * Nothing to do but regular page fault handling must still
> -		 * be suppressed, so leave host_apf_flags nonzero.
> -		 */
> -		vcpu->arch.apf.host_apf_flags =3D KVM_PV_REASON_PAGE_READY;
> +	u32 host_apf_flags =3D kvm_read_and_reset_apf_flags();
> +
> +	if (!host_apf_flags)
> +		return EXIT_FASTPATH_NONE;
> +
> +	if (!WARN_ON_ONCE(!(host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT))) {
> +		kvm_async_pf_queue_task(token, host_apf_node);
> +		return EXIT_FASTPATH_APF;
>  	}
> +
> +	return EXIT_FASTPATH_NONE;
>  }
> =20
>  void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2a26900c06bd0..ffcf6ab622518 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -8130,9 +8140,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	bool req_int_win =3D
>  		dm_request_for_irq_injection(vcpu) &&
>  		kvm_cpu_accept_dm_intr(vcpu);
> +	struct kvm_task_sleep_node host_apf_node =3D {0};
>  	fastpath_t exit_fastpath;
>  	u64 run_flags, debug_ctl;
> -
>  	bool req_immediate_exit =3D false;
> =20
>  	if (kvm_request_pending(vcpu)) {
> @@ -8507,7 +8517,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		fpu_sync_guest_vmexit_xfd_state();
> =20
>  	if (exit_fastpath =3D=3D EXIT_FASTPATH_NONE)
> -		exit_fastpath =3D kvm_x86_call(handle_exit_irqoff)(vcpu);
> +		exit_fastpath =3D kvm_x86_call(handle_exit_irqoff)(vcpu, &host_apf_nod=
e);
> =20
>  	if (vcpu->arch.guest_fpu.xfd_err)
>  		wrmsrq(MSR_IA32_XFD_ERR, 0);
> @@ -8569,6 +8579,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.apic_attention)
>  		kvm_lapic_sync_from_vapic(vcpu);
> =20
> +	if (exit_fastpath =3D=3D EXIT_FASTPATH_APF && host_apf_node.token)
> +		kvm_handle_pv_async_pf(&host_apf_node);

[Severity: High]
Can this leave the stack-allocated host_apf_node linked in async_pf_sleepers
after vcpu_enter_guest() returns when token is 0?

In kvm_handle_host_apf_irqoff(), kvm_async_pf_queue_task(token,
host_apf_node) is called without checking whether token is 0 or recording t=
he
boolean return value:

arch/x86/kernel/kvm.c:kvm_async_pf_queue_task() {
	...
	n->token =3D token;
	n->cpu =3D smp_processor_id();
	init_swait_queue_head(&n->wq);
	hlist_add_head(&n->link, &b->list);
	raw_spin_unlock(&b->lock);
	return true;
}

If token is 0, kvm_async_pf_queue_task() still inserts &host_apf_node.link
into async_pf_sleepers with host_apf_node.token =3D=3D 0 and returns true.

Then in vcpu_enter_guest(), the condition:

	if (exit_fastpath =3D=3D EXIT_FASTPATH_APF && host_apf_node.token)
		kvm_handle_pv_async_pf(&host_apf_node);

evaluates to false because host_apf_node.token is 0, skipping
kvm_handle_pv_async_pf() and returning from vcpu_enter_guest() while
host_apf_node.link remains queued in async_pf_sleepers.

A zero token with KVM_PV_REASON_PAGE_NOT_PRESENT set can occur if L0 is bug=
gy
or untrusted, or if L0 KVM sets KVM_PV_REASON_PAGE_NOT_PRESENT in L1's
apf_reason.flags via kvm_arch_async_page_not_present() and queues
vcpu->arch.exception_vmexit, but exception_vmexit is subsequently cleared
before injection into L1 (for example, when preempted by KVM_APIC_INIT in
vmx_check_nested_events() or svm_check_nested_events() calling
kvm_clear_exception_queue(), or across KVM_GET_VCPU_EVENTS and
KVM_SET_VCPU_EVENTS), leaving KVM_PV_REASON_PAGE_NOT_PRESENT stale in L1's
apf_reason.flags until L2 triggers a regular #PF VM-exit whose faulting
address has lower 32 bits equal to 0.

Previously, kvm_handle_host_apf_irqoff() checked the boolean return value of
kvm_async_pf_queue_task() directly instead of testing host_apf_node.token !=
=3D 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105164531.3138=
49-1-pbonzini@redhat.com?part=3D5
