Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126B39A805
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953249; cv=none; b=NekTICPYCGsmsVSHw2SOdycuPPJ913LVzw8sfs/h3LskdwrNJg0x/XEqd95G9WOcxjsLzFjyWPFeTiIvchRmy73D+PNE090RD/Sl03KAcA33FcYFO+xDJjLByjxXSQvnPu3BHZl6gQ14dNbVttoAJSrVyrI+aXbYOUj6XXX6+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953249; c=relaxed/simple;
	bh=KxorrfyKMPCKHhrne/WwzpoN4zl6iXQufj4m4jme21g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d3mgUhDeNnQVDU8DgBo5dTIwL+46+ODWecADinwsHL4b7vjlXGf9N05YJo6NdwtNRNmKCQbC6qagJ/jPsWU7bhBxtGThdL8TbsfjMuYaiOFgrRRHPtVv635vY2NPT8WDMkXZLsW1NHFbnyPYKpzcQgmSW/iVmDosi34u1qxwAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPledm9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPledm9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA30F1F00893;
	Mon,  8 Jun 2026 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953247;
	bh=R+Sx1lx2WEnejCDc1OeAf2kQJntNxD8Fc5Npp1s4Q0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iPledm9U+3nOarRKhIqA2NBLzrjkT9peqV3i/QhQdKC5+uxICQ/dZxJ+hffZTSRiX
	 f7cLhNdfS/irhBevOU/okXsmJJGsH59seqhoe7ajiY+WBaQK3xHdha6QmSEbtpIKct
	 VyIAr5AvL0EG6jfn2x731gU7DAXlrECbRk8E9/RrxD0t1xJn415CYDGOHSUpyCVBBe
	 vkCG26ePAZzmmI0iMoH1G/ziOnC++lOoeo1ZufAVsqV6wHniEx0ds+jE647NHCcL7v
	 6kggVN1oXVHEgJeVBbit09KRraUNIm0NogcInhi/ZnOQoYw7kg8zSk6BjDUtvmQq6y
	 9yAs2gvidThmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 47/60] kvm: x86: Select a plane to run
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-48-joro@8bytes.org>
References: <20260608144252.351443-48-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:14:07 +0000
Message-Id: <20260608211407.CA30F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] The dynamically selected vCPU plane executes without acquiring=
 its specific `vcpu->mutex` and without calling `vcpu_load()`, leading to h=
ardware state corruption and preempt notifier list UAF.
- [Critical] Unconditional dereference of vcpu_plane0->common causes a host=
 kernel panic if the VM does not configure planes.
- [High] KVM_RUN populates the `kvm_run` struct of the dynamically selected=
 `vcpu` instead of the invoking `vcpu_plane0`, hiding exit reasons from use=
rspace and breaking the UAPI.
- [High] Switching planes will immediately abort the run because `vcpu->wan=
ts_to_run` is uninitialized (false) for the new plane.
- [High] Signal mask set by KVM_SET_SIGNAL_MASK is silently dropped when sw=
itching to a non-plane0 vCPU.
- [High] The shared state `common->plane_switch` is modified and read concu=
rrently without lock protection, leading to unpredictable VCPU loop behavio=
r.
- [Medium] The `pid` of the newly selected `vcpu` plane is not updated, bre=
aking scheduling heuristics like Pause Loop Exiting (PLE).

Pre-existing issues:
- [High] KVM_REQ_EVENT is requested on the wrong VCPU during a plane 0 even=
t wakeup, leading to lost interrupts.
--

commit 67964c816ae6ba8055d2af56d1a3a15cc567d4c2
Author: Joerg Roedel <joerg.roedel@amd.com>

In the KVM_RUN path, select a runnable VCPU plane and use it to enter
the guest. Also handle KVM_REQ_PLANE_RESCHED events to switch planes
without exiting to user-space.

This patch updates the KVM_RUN execution loop in arch/x86/kvm/x86.c to
dynamically switch between vCPU planes. It introduces a loop in
kvm_arch_vcpu_ioctl_run() that selects a vCPU, executes it, and handles
rescheduling events without returning to userspace.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7e94a378b3d2..b9828cd31136 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11398,6 +11398,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcp=
u)
>  				goto out;
>  			}
>  		}
> +
> +		if (kvm_check_request(KVM_REQ_PLANE_RESCHED, vcpu)) {
> +			vcpu->common->plane_switch =3D true;

[Severity: High]
This isn't a bug introduced by this patch, but in the plane handling code in
vcpu_enter_guest(), when waking up plane 0 it calls
kvm_make_request(KVM_REQ_EVENT, vcpu) on the currently executing VCPU (e.g.,
plane N) instead of the target plane 0:

	if (kvm_check_plane0_events(vcpu)) {
		kvm_vcpu_set_plane_runnable(vcpu->common->vcpus[0]);

		kvm_make_request(KVM_REQ_EVENT, vcpu);
		kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
	}

When plane 0 eventually runs, its own KVM_REQ_EVENT flag will not be set.
Will plane 0 enter the guest without evaluating and injecting the pending
events that originally triggered the plane switch?

> +			r =3D 0;
> +			goto out;
> +		}
>  	}

[ ... ]

> @@ -12196,6 +12202,27 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcp=
u)
>  	return r;
>  }
> =20
> +int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu_plane0)
> +{
> +	struct kvm_vcpu_common *common =3D vcpu_plane0->common;

[Severity: Critical]
If an unprivileged user creates a standard VM without the plane feature
enabled, is it possible for the common pointer to be NULL?

Dereferencing vcpu_plane0->common unconditionally could lead to an immediate
NULL pointer dereference when invoking the KVM_RUN ioctl on this standard
VCPU.

> +	int ret;
> +
> +	do {
> +		struct kvm_vcpu *vcpu =3D kvm_vcpu_select_plane(vcpu_plane0);

[Severity: Medium]
Will the pid of the newly selected vcpu plane be updated here?

kvm_vcpu_ioctl() conditionally updates vcpu->pid only for vcpu_plane0. If
the execution loop switches to a new vcpu plane, its pid field might not be
synchronized with current.

If another vCPU attempts to yield to this plane using kvm_vcpu_yield_to(),
could it read a stale task pointer and fail to yield to the correct host
thread?

> +
> +		if (vcpu =3D=3D NULL)
> +			return -EINVAL;
> +
> +		common->plane_switch =3D false;
> +
> +		ret =3D __kvm_arch_vcpu_ioctl_run(vcpu);

[Severity: High]
Does KVM_RUN populate the kvm_run struct of the dynamically selected vcpu
instead of the invoking vcpu_plane0?

When a guest exit requires userspace handling (e.g., KVM_EXIT_MMIO),
__kvm_arch_vcpu_ioctl_run(vcpu) might populate the exit reason into the
hidden vcpu->run structure of the non-plane0 vCPU.

Would userspace then read vcpu_plane0->run, observe an empty or stale state,
and fail to service the VM exit?

[Severity: Critical]
Does the dynamically selected vCPU plane execute without acquiring its
specific vcpu->mutex and without calling vcpu_load()?

kvm_vcpu_ioctl() acquires vcpu->mutex and calls vcpu_load() exclusively for
vcpu_plane0. Executing the new vcpu here without acquiring its mutex or
calling vcpu_load() could allow concurrent execution of KVM_RUN on the
switched vCPU's file descriptor.

Could concurrent execution of vcpu_load() on the same vCPU from two threads
invoke preempt_notifier_register() simultaneously, corrupting the preempt
notifiers list?

Additionally, could executing guest code without vcpu_load() leave the
physical CPU virtualization state programmed for the old VCPU?

[Severity: High]
Will switching planes immediately abort the run because vcpu->wants_to_run
is false for the new plane?

vcpu->wants_to_run is set to true by the generic kvm_vcpu_ioctl()
exclusively for vcpu_plane0. When switching to a new vCPU plane, its
wants_to_run flag remains false.

Could __kvm_arch_vcpu_ioctl_run(vcpu) explicitly check
if (!vcpu->wants_to_run) and immediately return -EINTR to userspace instead
of running the selected plane?

[Severity: High]
Is the signal mask set by KVM_SET_SIGNAL_MASK silently dropped when
switching to a non-plane0 vCPU?

When userspace configures a signal mask via KVM_SET_SIGNAL_MASK, it sets
vcpu->sigset_active and vcpu->sigset on the vcpu_plane0 structure.

When __kvm_arch_vcpu_ioctl_run() selects the new non-plane0 vCPU and calls
kvm_sigset_activate(vcpu), the non-plane0 vCPU might not have its
sigset_active flag set.

Could this result in the thread executing the non-plane0 guest with its
original host signal mask?

> +		if (ret)
> +		       break;
> +	} while (vcpu_plane0->common->plane_switch);

[Severity: High]
Is it safe to loop on vcpu_plane0->common->plane_switch without lock
protection?

Since kvm_arch_vcpu_ioctl_run() clears common->plane_switch before running
the VCPU, and loops conditionally based on its value afterward, while
vcpu_enter_guest() sets it from another thread, could a data race occur if
multiple VCPUs in the same plane group run simultaneously?

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D47
