Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258513;
	b=nsLpZ/I1rtTifd9X5hDTah6HQepyCLtArOhO6yvyuDo2tgpGwbUJvDL1EZUq2MAsM4lL
	 aFOCAgh/ODh7xWc5/jvLBxxOcnIOc1QbS4F5JyrpUFOwGpwHlEQGnaYQuIQ6I2DkDsVzz
	 lzrEfjMT+Sz3YSu5R5YeRKh6Xx+8n2iaifPdEuBcZZPHga5q9Pdcviymeh7hLm2GR8EWx
	 pYSu2gz+85RwH1AqxaR8LZE8KQQ4APhBQgbXBRWxqL1KeLNfvG09GacVGlbX6iCowHX1q
	 zuPT8Gr54nNjhwwS2YJr3ZYqQW+0eWL8dMDLQFAFlxo9ba4NZXvevPbpcleNchPTIFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258513;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i6blNjsCoXZetNVR8kkwZW+/hEkGkFMEdjMPlK/oY1w=;
	b=Sf9sxOuKQ7YC+9Ija0/WEwUBUroluvGG3G/6YA9pFBvK4/d2wa+KzthydokRCo6INsJm
	 A/kFXKslqsn8Cs7OMm9LaE1y2QarU9aqnaidOUamIlSnN0i2/6zPpqKxfboN+d/Zx/Zwx
	 x07NJJzrLRbCqq3qnZwprVDTD+l/w/0kzMd4AR5r/soXDpdOKYt2H58E2KjZu7hNKrN+E
	 qQnvPUA0wLYngoZNGLNw2rr1Wc8ESwcxbVsH+9FYvo9JOgD5h+mUD+qn6q53n6h0UZhkL
	 2bA1IzJ47oxExDQ38q4JXCktgAZspDtBLWP/k/YOBK0uskJ5sy8wICOIxAO3fetVL0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=assacM9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D33606A32A
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=assacM9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1D81F008A2;
	Mon,  9 Nov 2026 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258512;
	bh=i6blNjsCoXZetNVR8kkwZW+/hEkGkFMEdjMPlK/oY1w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=assacM9xZhffkz+5Kl91NxbUm9rqImWoodneQd2/XLjuhzsiQw+i/IWnE9OCcQZFC
	 sqp2xRGFmIwAzSIHXRfHiSFM49wcVsPZ+PR3PmhMvFX9egTRErHo6GlA0ntS1dFS+k
	 k31JnWKVZmedS/jhfRtgT7+TACHI2aE22tB/7aRXwDVrOQAFuxYuLWiQVwukLQg2Uy
	 q3PJFhX/3o1kLvdNYox1Qi7h7UIhCFFQWwseN3oE7DqW8vGh3uxc7r1JSlKBuvW7zy
	 qhSUUIp71FWrfI8b1tNO6dSrj1c65LE9ExOUjA3uE2WA/hXnruJJLV86Xs4pC0cnSf
	 mn0lnceaRtSAw==
Message-ID: <sashiko-outbox-205631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 1/4] KVM: SVM: Re-queue events that were never
 injected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>, kvm@vger.kernel.org
In-Reply-To: <a523c8930e82f897d6fdfb4f05a283a6e2649414.1794244450.git.prsampat@amd.com>
References: <cover.1794244450.git.prsampat@amd.com>
 <a523c8930e82f897d6fdfb4f05a283a6e2649414.1794244450.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:08:32 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] KVM: SVM: self-IPI on force_immediate_exit aborts ESMTP VMRUN
  sync in a loop
- [Low] kvm: svm: svm_complete_interrupts() clobbers VMCB exit_int_info
  and event_inj
- [Low] KVM: SVM: inaccurate comment in svm_complete_interrupts() on
  EVENTINJ clear
--

commit 3134c7d995fb21938bef42d0d4bd1ee3a0a75674
Author: Pratik R. Sampat <prsampat@amd.com>

KVM: SVM: Re-queue events that were never injected

This commit updates svm_complete_interrupts() to migrate any remaining
event in event_inj to exit_int_info on #VMEXIT so that events left
uninjected when VMRUN exits early are re-queued, and simplifies
svm_cancel_injection() accordingly.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 136069dfcd44f..850ebbdefde09 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4463,6 +4463,7 @@ static void svm_complete_interrupts(struct kvm_vcpu=
 *vcpu)
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	u8 vector;
>  	int type;
> +	struct vmcb_control_area *control =3D &svm->vmcb->control;
>  	u32 exitintinfo =3D svm->vmcb->control.exit_int_info;
>  	bool nmi_l1_to_l2 =3D svm->nmi_l1_to_l2;
>  	bool soft_int_injected =3D svm->soft_int_injected;
> @@ -4470,6 +4471,27 @@ static void svm_complete_interrupts(struct kvm_vcp=
u *vcpu)
>  	svm->nmi_l1_to_l2 =3D false;
>  	svm->soft_int_injected =3D false;
> =20
> +	/*
> +	 * Hardware clears EVENTINJ field when it injects an event.
> +	 * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
> +	 * mode, and thus that the event was never delivered.  Migrate the event
> +	 * to EXITINTINFO so that it's requeued instead of being dropped.

[Severity: Low]
As reported by Sean Christopherson on v1 [1], is this comment accurate
about when hardware clears EVENTINJ?  Hardware clears EVENTINJ
unconditionally on #VMEXIT when exiting guest mode, whereas pre-entry
Enhanced SMT Protection exits terminate VMRUN at the synchronization point
before guest mode is entered and leave EVENTINJ intact.

> +	 *
> +	 * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
> +	 * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
> +	 * without having injected that event into the guest.
> +	 *
> +	 * Clobbering EXITINTINFO is safe precisely because the vCPU never
> +	 * entered guest mode.
> +	 */
> +	if (control->event_inj) {
> +		control->exit_int_info =3D control->event_inj;
> +		control->exit_int_info_err =3D control->event_inj_err;
> +		control->event_inj =3D 0;
> +
> +		exitintinfo =3D control->exit_int_info;
> +	}

[Severity: Medium]
As reported by Sean Christopherson on v1 [2], how does re-queuing
control->event_inj interact with KVM_RUN_FORCE_IMMEDIATE_EXIT under
Enhanced SMT Protection?

When kvm_check_and_inject_events() stages an event into control->event_inj
while a second event is pending, vcpu_enter_guest() sets
KVM_RUN_FORCE_IMMEDIATE_EXIT so svm_vcpu_run() sends a physical self-IPI
via smp_send_reschedule() before VMRUN.  If ESMTP stalls VMRUN at the
sibling synchronization point, that pending self-IPI immediately aborts
VMRUN with SVM_EXIT_INTR before guest entry.  svm_complete_interrupts()
then re-queues the first event with injected =3D true and sets
KVM_REQ_EVENT, causing the next vcpu_enter_guest() iteration to hit -EBUSY
in kvm_check_and_inject_events() and send another self-IPI before VMRUN,
livelocking the vCPU without ever synchronizing with its sibling.

[Severity: Low]
Does modifying control->exit_int_info and control->event_inj in the VMCB
here corrupt subsequent diagnostic output in svm_handle_exit()?

svm_vcpu_run() calls svm_complete_interrupts() before vcpu_enter_guest()
calls svm_handle_exit().  When VMRUN fails with SVM_EXIT_ERR (for example,
due to an invalid control->event_inj), dump_vmcb() in svm_handle_exit()
now prints event_inj as 0 and reports the offending event under
exit_int_info, and trace_kvm_nested_vmexit() logs the undelivered
event_inj as exit_int_info (disagreeing with trace_kvm_exit() called just
before svm_complete_interrupts()).  Using local variables for exitintinfo
and exit_int_info_err while only clearing control->event_inj would leave
control->exit_int_info intact.

[1] https://lore.kernel.org/r/arFYHRzNFT886BME@google.com
[2] https://lore.kernel.org/r/arEuMojZa_kv9VXA@google.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794244450.gi=
t.prsampat@amd.com?part=3D1
