Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BC3EDE66
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931707; cv=none; b=DFRnul8C830lpJIBxfnGbG8nKf2t6/ok3s3wJykZvBH3HdDaUnDlh8WbssAksJl2XTDUCOihKnMdpsoTnpdjutGKqhg+54Yg1vjssk7wCQvCl3AUQMnKRTywNFNG6Vp/pNDwCzwKudHcbdVSF515f/xEvUeEriHtBO6M5XZoU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931707; c=relaxed/simple;
	bh=Ccc7S8glqkTg/tA+C+bBSw1EWMAfllOA8BQ95zZn5zY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgHdqGnN+tVPwOJtBbCWCbYDloHMe3YmcLJm101O56kJzYnsKITtSSbPYnchyfG9Lh45wxKt1XdwbSiejLiVMOPDRZRc1jqk2a4MC4HvjQKYXjjYnYcSCXi1whe2ZbOIVH6drVOled2i7VZb8jxvlpzgIYT2ACTVKzM0UFrapU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq9x88Ih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq9x88Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AB41F00893;
	Mon,  8 Jun 2026 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931706;
	bh=dNZbIAfvKE8/LYa9VMYFm6wVNCvJ1qmott6mQfuOvns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kq9x88IhxYivnb9oawHecr5j3ccy3pWs1LKOAQy1qcO1AlLjmjOAgfmXLpLdB3Qf2
	 h2x6mWAvB46MzeV60hO3/fvlqxRfOj2i3yrCQB0z+KpgGsTtL5xzg/PN7b2p85wRex
	 uGwupqCcxj9YmLMItD6cfrWg8x+hNbirPJPeU4z7hAFh3fQrbN3yEUNyB1aqxOHErv
	 9DYy9wRRm680bniTkr5D6X38mqVtZnjmd2bfkedKyTWZAM737AHSlqDucDRMmydLcL
	 K+p1UQp+n6zL20go+gD9cKZ8atwZv5xVW9DjfvsOjbnxy4/bHMf005zYvh36VvE0RQ
	 RSSbNrDPo9TUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/60] KVM: SVM: Inject NMIs when Restricted Injection
 is active
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-5-joro@8bytes.org>
References: <20260608144252.351443-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:15:05 +0000
Message-Id: <20260608151506.25AB41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] When an NMI injection is canceled while an interrupt is already pe=
nding in the doorbell page, KVM incorrectly merges both events into a singl=
e event_inj field and clears the doorbell, permanently dropping the interru=
pt.

Pre-existing issues:
- [High] WARN_ONCE in __sev_snp_inject can be triggered by a malicious gues=
t setting an invalid ghcb_gpa, violating the API guideline against guest-re=
achable WARN_ONs.
- [High] Calling a sleepable mapping function (`kvm_vcpu_map`) while the ta=
sk state is `TASK_INTERRUPTIBLE` breaks the wait loop in `kvm_vcpu_block()`=
, causing high CPU utilization (busy spin).
- [High] Data race on target vCPU's memslot cache (last_used_slot) via lock=
less kvm_vcpu_map() in sev_snp_blocked().
--

commit 457e56b8fb0a79fd5875e22fd1d0437c14618353
Author: Melody Wang <huibo.wang@amd.com>

KVM: SVM: Inject NMIs when Restricted Injection is active

This commit adds support for injecting NMIs into SEV-SNP guests when
Restricted Injection is active. It detects the active state and utilizes the
#HV doorbell communication from the GHCB specification to inject NMIs.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index cda83437382d7..44be2c9b8286d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5408,7 +5408,10 @@ static void __sev_snp_inject(enum inject_type type=
, struct kvm_vcpu *vcpu)
>  		return;
>  	}
> =20
> -	hvdb->events.vector =3D vcpu->arch.interrupt.nr;
> +	if (type =3D=3D INJECT_NMI)

[Severity: High]
This isn't a bug introduced by this patch, but since this patch now calls
__sev_snp_inject() for NMIs, does this increase the exposure of the
guest-reachable WARN_ONCE() earlier in this function?

If a malicious guest modifies its memory map to remove the backing memslot =
for
the doorbell page, map_hvdb() will return NULL. Doesn't this allow an
unprivileged guest to intentionally trigger the WARN_ONCE(1) and potentially
cause a host denial of service if panic_on_warn is enabled?

> +		hvdb->events.nmi =3D 1;
> +	else
> +		hvdb->events.vector =3D vcpu->arch.interrupt.nr;
> =20
>  	prepare_hv_injection(svm, hvdb);

[ ... ]

> @@ -5488,10 +5491,17 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vc=
pu)
>  	/* Copy info back into event_inj field (replaces #HV) */
>  	svm->vmcb->control.event_inj =3D SVM_EVTINJ_VALID;
> =20
> +	/*
> +	 * KVM only injects a single event each time (prepare_hv_injection),
> +	 * so when events.nmi is true, the vector will be zero
> +	 */
>  	if (hvdb->events.vector)
>  		svm->vmcb->control.event_inj |=3D hvdb->events.vector |
>  						SVM_EVTINJ_TYPE_INTR;
> =20
> +	if (hvdb->events.nmi)
> +		svm->vmcb->control.event_inj |=3D SVM_EVTINJ_TYPE_NMI;
> +

[Severity: High]
Is it possible for both an NMI and an IRQ to be pending at the same time?

Looking at sev_snp_blocked(), it checks events.nmi and events.vector
independently based on the type. This means KVM could inject an NMI while an
unacknowledged IRQ is already in the doorbell page.

If a #VMEXIT happens and KVM calls sev_snp_cancel_injection(), wouldn't this
bitwise-OR both the IRQ vector and the NMI type into the single VMCB event_=
inj
field, overwriting the type to NMI but using the IRQ vector?

Since the code directly below wipes the doorbell page by setting
pending_events =3D 0, will the original interrupt be permanently lost?

>  	hvdb->events.pending_events =3D 0;
> =20
>  out:

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7253936c460c1..5255393986ccf 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -3968,6 +3973,9 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
>  	if (!gif_set(svm))
>  		return true;
> =20
> +	if (sev_snp_is_rinj_active(vcpu))
> +		return sev_snp_blocked(INJECT_NMI, vcpu);
> +

[Severity: High]
This is a pre-existing issue, but adding sev_snp_blocked() to the NMI check
path expands an existing sleep-in-wait-loop regression.

During vCPU halting, kvm_vcpu_block() sets the task state to
TASK_INTERRUPTIBLE and waits in schedule(). If a wakeup check calls
kvm_vcpu_has_events() -> svm_nmi_blocked() -> sev_snp_blocked(), KVM maps
the doorbell page via kvm_vcpu_map().

Because kvm_vcpu_map() can take the mmap_read_lock and sleep, the scheduler
will reset the task state to TASK_RUNNING. Won't this cause the subsequent
schedule() call in kvm_vcpu_block() to return immediately, turning the halt
into a 100% CPU busy loop?

[Severity: High]
This isn't a bug introduced by this patch, but it expands a pre-existing da=
ta
race. Can this lockless doorbell page mapping cause a race on the target vC=
PU's
memslot cache?

When kvm_vcpu_on_spin() iterates over vCPUs to find a runnable target, it
calls kvm_vcpu_has_events() on foreign vCPUs. This eventually reaches
sev_snp_blocked() and calls kvm_vcpu_map() on the target vCPU.

Since kvm_vcpu_map() non-atomically modifies the target's
vcpu->last_used_slot cache, and this happens without holding the target's
vcpu->mutex, could this corrupt the memslot cache of the actively running
target vCPU?

>  	if (is_guest_mode(vcpu) && nested_exit_on_nmi(svm))
>  		return false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D4
