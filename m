Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C143D45D0
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633332; cv=none; b=QoyWOwnZeuqtOlI62Dw4tSWog2uMTkohUvJBNbEcaznkrj8nm8pOTD/2/cx0IH9BweChFTMD4DWrLXLo2/u+ipeNEYAS0pRjAsIF+My5CMY7WCISIj0pQRJTfUf3zn/t/WRu+y8NcsGUOQ31bYgvdtdLB2Fnszh0EcodI2KkjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633332; c=relaxed/simple;
	bh=arqKhCihB5JDVtmQoXCAb74Cvdu7kmDsfX64C4Kv1kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMdsqWSdIC4mXYnDcd9F86fCCAuVmyqy9Vb2KC9kGsjd8okzZfmLHsMAMe7JPcQF4OIBlZE0SJoEpuZN/lijbGxHuo/SjQLlSikEEZxwJC4bxCjCZ/YDDaIc1utixPykr6i5tKLKY3z6UsfTxT5q9ahGvN5tTNXhSy1eU8s6iVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f28k3Rc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f28k3Rc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17911F00ACA
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781633331;
	bh=7ZTUYGWwPHsthZoqCkj9Vm+M1QsFJVb06Zv8Ndcjf0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f28k3Rc7K2W2LZF8X4ARTVi7E4MVxclAYUv1KlSmOn42g0zQtK3eEMvbs5Z44eLpY
	 nZwdL0b/QzwGmNxRBZ0pC0ascVVOzQ4t28nQ1EcPk+55B1f6n3ducwNdAz6Mjwv9pS
	 tmdUsdS3mrNDV9B212YqQi1gQ3Z8eI+VCX19zCGKa58Mr8yXbNetaI7DbXSvtqMETC
	 cXCXsmjOoPBbQr9yrVqZVP1JHvkJjZJ/2+lazRqtUn/gx4iG9FVjci7TVXnR4KVF2z
	 4I627oyobIS/7vLenytPUNZBlS6fikav6nhbVIQew96zp39lGt/vBV40d1c5rm4r1N
	 YaUkKxsFF4J1A==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69165354c87so6216104a12.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:08:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+naBNV58+/odwXfDjnnGd0atATED6jSsgW1JyBXH4D1FpzKG4ukmEA5DHzD3V9kvAwPaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpc8nI0KZOaEvpAKdvzR8pbOEkC1twfCKy4MFy/z36xQlhRtEB
	4s96U6hw5IBKCA8odwAxBa9W7hcnLRxNMyeAILfS6QKO1KIwLpY8FxdEKz/+34Jm9sLqhINl/iY
	2Aj64g7BR5zjiHK1KinFOikS6c3F7cZQ=
X-Received: by 2002:a17:906:5a73:b0:bee:f541:1dca with SMTP id
 a640c23a62f3a-c05a6ae1f4fmr38536866b.28.1781633330510; Tue, 16 Jun 2026
 11:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
 <ajA1xaafH-IkuugD@google.com> <CAO9r8zNFk287zeB+0nrUvcCqpn-wi3CZo6t-9COQGkdd3POzMg@mail.gmail.com>
 <ajGL95j_Z3ynCUAy@google.com>
In-Reply-To: <ajGL95j_Z3ynCUAy@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 11:08:37 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO2njO+0NDAOLqnhOn4b2s985wkydk6x5Fe+r1RS0FiLw@mail.gmail.com>
X-Gm-Features: AVVi8CejsJbZ4LaPfo33g3O_5ppQSrSPJ615eUywzqDH914AnHEzL3_0Bf7Vocs
Message-ID: <CAO9r8zO2njO+0NDAOLqnhOn4b2s985wkydk6x5Fe+r1RS0FiLw@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:46=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> > > > The code makes sense to me but I am trying to make sense of the cha=
ngelog.
> > >
> > > What part (parts?) is confusing?  Honest question.  I'm trying to rew=
ord the
> > > changelog to make it "better", but I'm failing miserable because I do=
n't know
> > > what's wrong :-)
> >
> > 1. For kvm_vcpu_has_events() being unaffected, the explanation in
> > paragraph #3 is focused on the code path from nested_vmx_run() ->
> > kvm_emulate_halt_noskip(). I don't immediately see how
> > kvm_arch_vcpu_runnable() is unaffected.
>
> To reach kvm_vcpu_has_events(), kvm_vcpu_running() needs to return false.=
  For
> that to happen, vcpu->arch.mp_state needs to be something other than RUNN=
ABLE.
>
> If nested_run_pending is true, then mp_state *must* be RUNNABLE (barring =
bugs or
> stupid userspace), because KVM shouldn't emulate VMRUN/VMLAUNCH/VMRESUME =
while
> the vCPU is !RUNNABLE.
>
> I didn't include that in the changelog because I thought it was obvious, =
but
> obviously (LOL) not :-D
>
> I called out the GUEST_ACTIVITY_HLT case because (to me) that is less obv=
ious.
>
> > 2. More importantly, paragraphs #3 and #4 read like this patch would
> > regress kvm_vcpu_ready_for_interrupt_injection() and
> > kvm_vcpu_has_events() if it affected them. Maybe clearly state that
> > this patch is the right thing to do for these 2 functions as well, but
> > they are more-or-less unaffected by the bug anyway? For
> > kvm_vcpu_ready_for_interrupt_injection(), maybe just make it more
> > clear in paragraph #4 that it currently incorrectly treats interrupts
> > as allowed in the problematic scenario, but it is not a problem
> > because ..., and it only results in a spurious exit to userspace (or
> > not even that?).
>
> Is this better?

Yes, much clearer (to me). Thanks for bearing with me :)

>
>   When querying whether or not interrupts (IRQs) are allowed, check for a
>   pending nested run _after_ checking whether or not interrupts are block=
ed.
>   If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs ca=
n
>   be blocked while running L2, and interrupts will indeed be blocked once=
 the
>   nested VM-Enter to L2 is completed, then KVM should treat interrupts as=
 not
>   being allowed.
>
>   For injection, this avoids an unnecessary (forced) VM-Exit, as KVM can
>   immediately request an IRQ window, instead of forcing an exit and _then=
_
>   requesting an IRQ window (because after the forced exit, KVM will see t=
hat
>   interrupts are blocked).
>
>   For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection() =
is
>   affected in practice.  Barring KVM bugs or misbehaving userspace (at wh=
ich
>   point all architectural guarantees are off), kvm_vcpu_has_events() is
>   unreachable when a nested run is pending.  To reach kvm_vcpu_has_events=
(),
>   kvm_vcpu_running() needs to return false, i.e. vcpu->arch.mp_state need=
s
>   to be something other than RUNNABLE.  If nested_run_pending is true, th=
en
>   mp_state *must* be RUNNABLE (again barring bugs or stupid userspace),
>   because KVM shouldn't emulate VMRUN/VMLAUNCH/VMRESUME while the vCPU is
>   !RUNNABLE.
>
>   The one "near miss" is VMX's GUEST_ACTIVITY_STATE field, which allows L=
1 to
>   put the vCPU into HLT or WFS as part of nested VMLAUNCH/VMRESUME.  Howe=
ver,
>   KVM clears nested_run_pending prior to calling kvm_emulate_halt_noskip(=
)
>   when putting L2 into HLT via GUEST_ACTIVITY_HLT, and also clears the fl=
ag
>   before setting mp_state to INIT_RECEIVED.  SVM has no equivalent to
>   GUEST_ACTIVITY_STATE.
>
>   I.e. the vCPU will always be runnable if a nested run is pending, and t=
hus
>   kvm_arch_vcpu_runnable() =3D> kvm_vcpu_has_events() is effectively dead=
 code,
>   as is __kvm_emulate_halt() =3D> kvm_vcpu_has_events().  Oh, and TDX doe=
sn't
>   support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable as
>   KVM shouldn't be faulting in memory with a pending nested VM-Enter.
>
>   As for kvm_vcpu_ready_for_interrupt_injection(), KVM's current behavior=
 of
>   incorrectly treating interrupts as being allowed could result in KVM
>   prematurely exiting to userspace to accept an ExtINT.  But, KVM will st=
ill
>   hold/block the ExtINT and request its own IRQ window.  I.e. the net eff=
ect
>   is more or less the same as the for-injection case, the unnecessary exi=
t
>   just happens at a different boundary.
