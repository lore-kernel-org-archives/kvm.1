Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BB40DFA0
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541640; cv=none; b=l0p4INLjVYtMz+Ylm+LPwkHuJWcGY4ad5si+e6vQSXcNShZokcj17EshbknwOWl0F0VflqpuepJVJJVc10m2YqjoW1IeT2//wREp2g57kmyQcxW1SYF3noJXUHq2I1NSuR+z0V1Khx3Kd3WGmDoHQuQsESmY0pEP24GY1YU2apY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541640; c=relaxed/simple;
	bh=HtfkxUAbGncAOqkVxZ3tQ1/jcut7+90HfeP/I3vepXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEKyRdYxDxGdpPkpANMG1LF4bFXAt5pH4B9JWTai16XQnJDN2N5GZ0ny2QoHBCrj7twq6hDznlMcXOcpahJ3jl9S1ReSdgidWec+AtwB+/s6yCedn7oFt+0nxKHRh/gurTFS+UAPd6kWV5vWBOWiUGK7Tkwm7ujn3OA5JzTkLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF4KrTn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF4KrTn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5D01F000E9
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541638;
	bh=idQK8wpZMb7DJVVwKy7sJN1C0MUqn2bj4cGb2Nv20sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FF4KrTn/g9up6SHBjb8IHmT+Hco4MC0/b/MYk1FspwU7xK8O3b4zxGESFQjwHW/1K
	 J1kE2OtmPV2iqHye3ggfoKiM88w5HubqTTvmAwGKBgkmTZh7+fV27yLywR2+YjVn9n
	 jJBP4IhAkIWDY5U4aXL8+RGoKwCclXbQamst/NZn3o23ELvoP2bMTBveju88zAfuRg
	 ByLBKNEZ9+E2p32QYrX7/5qNS/hM0UVxOqnD5zjQW7zbjbAfFj1CSWpmZ5hksDrFQ6
	 ps5NP9+aflOZKSd0h8mcsUTEuEFyuB4dHw8dlCQIC3JmEK6pW4sCeV82MUNye/5tyu
	 iIiGg4qgkfQvQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68f36e1663cso6076748a12.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:40:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9rS590XLYaGXxlmGbo/v18FzrQI9mptM7OATNQfWln/1uTHUqBjZ5tonO5CSK20lHYRvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhS0tUKQgIFCWlYK67V/oodiJw/axG9byZyOr79MATOWLmQv0y
	BoC6iRrMGXcvbPnNn7r4k1DMvklhjJt3hHX6hVV1bbXviEZCEe2zOGeVzA4Lh5TtXBez26PSbz7
	ShxQ8PJ9149v+A4ZqGUeTUenenqF9DB4=
X-Received: by 2002:a17:907:6095:b0:be3:d140:2b54 with SMTP id
 a640c23a62f3a-bfe2a115660mr770164366b.31.1781541637166; Mon, 15 Jun 2026
 09:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
In-Reply-To: <20260613000329.732085-27-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 09:40:26 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
X-Gm-Features: AVVi8CfUVf0OhLp4VmRXiFlTOT75cvw28iiIYqnuAu_sqfpCEVAXJCqD2ecrPTw
Message-ID: <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When querying whether or not interrupts (IRQs) are allowed, check for a
> pending nested run _after_ checking whether or not interrupts are blocked=
.
> If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs can
> be blocked while running L2, and interrupts will indeed be blocked once t=
he
> nested VM-Enter to L2 is completed, then KVM should treat interrupts as n=
ot
> being allowed.
>
> For injection, this avoids an unnecessary (forced) VM-Exit, as KVM can
> immediately request an IRQ window, instead of forcing an exit and _then_
> requesting an IRQ window (because after the forced exit, KVM will see tha=
t
> interrupts are blocked).
>
> For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection() is
> affected in practice.  kvm_vcpu_has_events() is unreachable when a nested
> run is pending, as KVM clears nested_run_pending prior to calling
> kvm_emulate_halt_noskip() when putting L2 into HLT via GUEST_ACTIVITY_HLT=
,
> and SVM has no equivalent to GUEST_ACTIVITY_STATE.  I.e. the vCPU will
> always be runnable if a nested run is pending, and thus
> kvm_arch_vcpu_runnable() =3D> kvm_vcpu_has_events() is effectively dead c=
ode,
> as is __kvm_emulate_halt() =3D> kvm_vcpu_has_events().  Oh, and TDX doesn=
't
> support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable as
> KVM shouldn't be faulting in memory with a pending nested VM-Enter.
>
> As for kvm_vcpu_ready_for_interrupt_injection(), incorrectly treating
> interrupts as being allowed could result in KVM prematurely exiting to
> userspace to accept an ExtINT.

"incorrectly treating interrupts as being allowed" is the status quo,
that this patch fixes, not sth this patch introduces -- right?

The changelog reads like for the non-injection case this change might
not be the right thing to do, but I don't think this is the case? I
assume returning false from
kvm_vcpu_ready_for_interrupt_injection() and kvm_vcpu_has_events() if
L1's interrupts are blocked while L2 is running is the right thing to
do?

The code makes sense to me but I am trying to make sense of the changelog.

Aside from that, I have two comments about existing issues (Sashiko-style):

1. The return values of {vmx/svm}_interrupt_allowed() are annoying.
IIUC, 0 is not allowed, 1 is allowed, and -EBUSY is generally allowed
but not right now, request immediate exit and try again? That should
be documented somewhere (maybe I just missed it?).

2. Aside from TDX, seems like {vmx/svm}_interrupt_allowed() are doing
the same thing? So maybe move all that logic into
kvm_arch_interrupt_allowed(), rename it (because it's only used by
x86), and make interrupt_blocked() the actual per-vendor callback? I
assume this is the case because nested_run_pending used to be
per-vendor, but now we can clean this up. For TDX, I assume the
per-vendor hook can just be tdx_interrupt_allowed() reversed?

> But, KVM will still hold/block the ExtINT
> and request its own IRQ window.  I.e. the net effect is more or less the
> same as the for-injection case.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 6 +++---
>  arch/x86/kvm/vmx/vmx.c | 5 ++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 526e0fdcd16b..883d5f703391 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4055,12 +4055,12 @@ static int svm_interrupt_allowed(struct kvm_vcpu =
*vcpu, bool for_injection)
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
>
> -       if (vcpu->arch.nested_run_pending)
> -               return -EBUSY;
> -
>         if (svm_interrupt_blocked(vcpu))
>                 return 0;
>
> +       if (vcpu->arch.nested_run_pending)
> +               return -EBUSY;
> +
>         /*
>          * An IRQ must not be injected into L2 if it's supposed to VM-Exi=
t,
>          * e.g. if the IRQ arrived asynchronously after checking nested e=
vents.
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2c120ff47790..9b277e36a521 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5254,6 +5254,9 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
>
>  int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
>  {
> +       if (vmx_interrupt_blocked(vcpu))
> +               return 0;
> +
>         if (vcpu->arch.nested_run_pending)
>                 return -EBUSY;
>
> @@ -5264,7 +5267,7 @@ int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bo=
ol for_injection)
>         if (for_injection && is_guest_mode(vcpu) && nested_exit_on_intr(v=
cpu))
>                 return -EBUSY;
>
> -       return !vmx_interrupt_blocked(vcpu);
> +       return 1;
>  }
>
>  int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
