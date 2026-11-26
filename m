Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661853;
	b=OPIKbkRrJYQ18pm7jAF39sx1msr//zvVX5yZss7fxV/DRcNkTzNf8k/TTsvJTx7gONP9
	 GWbpf8UWLQMeaNqRTH4Wzm1CxAKI4CRBotskYx+b2XP1bTdaIW9aqCs2bu7zuGv5D6efO
	 ZWuVNqgL3H7ljlTMCOqi3txtIV7X2dt2Z7dh8w274GEGon+XVdHaBpL8+DG2h/c5O/b6o
	 9EIr/m2byXMUcbbyhj5unH54eq1n3gjnzKbzHYt/AAAr0c22sV+9RV4etCSNJuQeTOziO
	 J6BPSYNySxZ3pAPJaVTtRuSP2dhTGxo7s5+/OJLdWS7f+mbB7aPRT+ovDxvgtB/gYvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661853;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5FnP62RxLTsM2bptn0h0fhyjsftudz6W7OX3VFgXQb4=;
	b=rR6sG8SU5x6dPj89iAeI2D/UJSnWTkvKhx6fEoa1TCHZo6uEhCk8XGx9nnhfaSLNyzlI
	 eEUE9D6wiPtmk7VpKWPY71agP7ovJRZ37GO/W/Qm7iYdQfzpT+bWBtLkgSKDMfgu3wUpb
	 1+L+uxp/WXZIDlL4q9OOZY5N+SRptt+4U54evvqWVeVgn+wLVlAzO0YcvsRp6QSHykGqS
	 bJ+OQv6VrB0ogf1rWDLIVnqtgQkqGVGdkQZzR+/yxMoAyAAgoEHNr3muWR8oCq+3hbWUw
	 Lb/WyZfy+2GLj+OTOhoqe+2EtJXWPlsuY/BQYJ/kX5i3Krw/QWNUq70zDKMWgpyhgJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvDxX05R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C1606A323
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvDxX05R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD241F000C0;
	Thu, 26 Nov 2026 02:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795661853;
	bh=5FnP62RxLTsM2bptn0h0fhyjsftudz6W7OX3VFgXQb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YvDxX05RLyCurclhOxJ5FGz+zGN9ewMT6QIEaT9GftrpE6NV1CBxYvvpIv6frBMpm
	 L3WcT+v9gulgHVsPLMRGuxm3/V+l+TC6FABX8n7yr+QW+mWpv87ko4ZVl2RiRa/N0K
	 c+oFNMqMW+ZtrQ2Ceb93U+WitJ/hUzhx051uPBnbyVsfF0XgKiu2aStlJQJ9GPi81/
	 o6BUVJfiFakGKI2c4CQkxmr/RpH03HDRvx1jvd7k4GAoxsmnEhNS9lfmLb+0m9ChBo
	 L5DekojgwAlHYRdRfYNoDJAGy7puK0fSqe2ew3Wd3IgZrzHslPC26DlOuIjRxoFYyW
	 iXi9MdJ9Z6M5Q==
Message-ID: <sashiko-outbox-234666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y] KVM: x86: Acquire kvm->srcu when handling
 KVM_SET_VCPU_EVENTS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dickson Wu" <dickson.wu@certik.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <CAFaZ9eoOtFxAansjaUbA-CDNQLcVAVJre2R9vaTQONG9MYUEng@mail.gmail.com>
References: <CAFaZ9eoOtFxAansjaUbA-CDNQLcVAVJre2R9vaTQONG9MYUEng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:57:32 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: x86: sync_regs() calls
  kvm_vcpu_ioctl_x86_set_vcpu_events() without SRCU
- [Low] KVM: x86: malformed line-wrapped Fixes trailer in commit message
--

commit 05ed0e79c4f4c1c55cedf5e0e31a01d98645e969
Author: Sean Christopherson <seanjc@google.com>

> KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
>
> commit 4bcdd831d9d01e0fb64faea50732b59b2ee88da1 upstream.
>
> Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
> leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
> reads guest memory.
>
> Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
> via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
> kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
> problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
> grab it unconditionally for KVM_SET_VCPU_EVENTS.
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
>  -----------------------------
>  include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!
>
>  other info that might help us debug this:
>
>  rcu_scheduler_active =3D 2, debug_locks =3D 1
>  1 lock held by repro/1071:
>   #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at:
> kvm_vcpu_ioctl+0x7d/0x970 [kvm]
>
>  stack backtrace:
>  CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-v=
m #552
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x7f/0x90
>   lockdep_rcu_suspicious+0x13f/0x1a0
>   kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
>   kvm_vcpu_read_guest+0x3e/0x90 [kvm]
>   nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
>   load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
>   vmx_leave_nested+0x30/0x40 [kvm_intel]
>   kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
>   kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
>   ? mark_held_locks+0x49/0x70
>   ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
>   ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
>   kvm_vcpu_ioctl+0x497/0x970 [kvm]
>   ? lock_acquire+0xba/0x2d0
>   ? find_held_lock+0x2b/0x80
>   ? do_user_addr_fault+0x40c/0x6f0
>   ? lock_release+0xb7/0x270
>   __x64_sys_ioctl+0x82/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  RIP: 0033:0x7ff11eb1b539
>   </TASK>
>
> Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM
> state is toggled")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240723232055.3643811-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ adapted to 5.10: same as the 5.15.y backport, vcpu->srcu_idx since
> kvm_vcpu_srcu_read_lock() is missing ]
> Signed-off-by: Dickson Wu <dickson.wu@certik.com>

[Severity: Low]
The Fixes: trailer is wrapped across two lines.  Should it be kept on a
single line?

  Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM state=
 is toggled")

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 58660d5de1413..d44c974756258 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4970,7 +4970,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
>  			break;
> =20
> +		vcpu->srcu_idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>  		r =3D kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
> +		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
>  		break;
>  	}
>  	case KVM_GET_DEBUGREGS: {

[Severity: Medium]
Does taking vcpu->kvm->srcu only in KVM_SET_VCPU_EVENTS leave the
KVM_RUN -> sync_regs() path without SRCU protection in 5.10?

In mainline, kvm_arch_vcpu_ioctl_run() already holds vcpu->kvm->srcu when
calling sync_regs(), which is why upstream 4bcdd831d9d0 ("KVM: x86:
Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS") only locked around
the KVM_SET_VCPU_EVENTS ioctl handler.  In 5.10, kvm_arch_vcpu_ioctl_run()
calls sync_regs() before vcpu_run() or complete_emulated_io() acquires
vcpu->kvm->srcu:

arch/x86/kvm/x86.c:sync_regs() {
    ...
	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_EVENTS) {
		if (kvm_vcpu_ioctl_x86_set_vcpu_events(
				vcpu, &vcpu->run->s.regs.events))
			return -EINVAL;
		vcpu->run->kvm_dirty_regs &=3D ~KVM_SYNC_X86_EVENTS;
	}
    ...
}

If userspace invokes KVM_RUN with KVM_SYNC_X86_EVENTS set in
kvm_dirty_regs and toggles SMM while the vCPU is in nested VMX guest mode,
kvm_vcpu_ioctl_x86_set_vcpu_events() -> vmx_leave_nested() ->
kvm_vcpu_read_guest() -> kvm_vcpu_gfn_to_memslot() dereferences memslots
without holding vcpu->kvm->srcu, triggering the same suspicious RCU usage
warning and risking a use-after-free against concurrent memslot updates.
Acquiring vcpu->kvm->srcu inside kvm_vcpu_ioctl_x86_set_vcpu_events() (as
__set_sregs() does in 5.10) or around the call in sync_regs() would cover
both callers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CAFaZ9eoOtFxAansjaU=
bA-CDNQLcVAVJre2R9vaTQONG9MYUEng@mail.gmail.com?part=3D1
