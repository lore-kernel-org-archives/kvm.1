Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8923A564
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541849; cv=none; b=eoOYJzfAG7sr9MHsoByQmBUMYmgdok0ZW2OYbRL56cjdBvowT4kQarhUz8b9A1yxEUgHbfznGQY8FLE8GePuXOk5U/zolyTTu6uCcAPpCkHiFAQGCn3f2dGVr7ALlWMdZnSoyRAZMVt5F6yq6+GT1+4ZvD7EIx3gD3bJuk06jLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541849; c=relaxed/simple;
	bh=aIfUT9VCotfqdDtNZKEKFEppPHpbeJKW4wR/Xid1xeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fihhexEuaJmYvhvB4Obpt16gaLpFpfKZaLSPUzdvsPLrtykK0E8MO6MpFhCp7157qFF119ERJc+EhWab0+o2MjSEtVyL1GNHl/CLHg/ygwvwtRSE1w/8SkoRC1nc/TOJKq1FMN5KAgpgNlYb2dTyxCQggllMwY8WiNG9rJc2MWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE6GpVaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE6GpVaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831A61F000E9
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541848;
	bh=p+johDyvaAsZFIJjZNya8NIrdlwwt9FwjAazLt63idQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JE6GpVaU10tRJ5rLSlkPudPYEP5Q4f7bLdo/2+S5WYmUSza73uUHASR85XIW1JYMt
	 aj4rQtbZnyjwj394eV3lq1zsYDBS7B0ZvRhQepffNK3FTCsbUQlHkx/pKJZQ6li7uj
	 e7BAD4zI+qflFnxlBeRdlrtDGkv6SghhzFX9h2+lrVaVgh3Mh3o9oUZsa4obxcCf6l
	 InrffX5Dj3hfFbBV0EFG8nxZPOjOc9frZ0FvPWmWQPB5jUDjkioQVE4FbcdHTbHNZb
	 vrQne0xZclCJuCWYjpojL8BeC6ilND74nzPlZu4XoOnOuA9L6wtFXSProHHC9T+Xog
	 nyZgIfDQshqdQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso5695404a12.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:44:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8U9w9VVpIsmKu/JYFGZUywDCUjZng4UrZ3/vYluMOvNKQXcODeQ5SOQoSwP8Xpgd9MSLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJTTJfh6evsrk28aH6qrmMVzYFPyGgBEimFXLUpE62Vd+Ftnd
	HeXl0DGUrGhLrznIpZPHgwvdUr3eXoIuDn96QMYRnT/alUzAkRAj3kJPhxs7zTwYJQdHt8Um0E6
	5zXt4VEI5vzFsBdqTbw81Mr/p6BK3+AI=
X-Received: by 2002:a17:906:c106:b0:bf1:d4fc:a4a6 with SMTP id
 a640c23a62f3a-bfe287ed912mr814277466b.17.1781541847467; Mon, 15 Jun 2026
 09:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
In-Reply-To: <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 09:43:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMX3_JgrJNQGuvFaANXKsA4hMEgO7=OS=q=-AA4mMhhaw@mail.gmail.com>
X-Gm-Features: AVVi8Ce7CrOzW5cx3l8A794xhdZ_OOBZ_LTLiHU2zlYUOoLc_CWrWOEnIY0zvJQ
Message-ID: <CAO9r8zMX3_JgrJNQGuvFaANXKsA4hMEgO7=OS=q=-AA4mMhhaw@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:40=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Jun 12, 2026 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > When querying whether or not interrupts (IRQs) are allowed, check for a
> > pending nested run _after_ checking whether or not interrupts are block=
ed.
> > If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs ca=
n
> > be blocked while running L2, and interrupts will indeed be blocked once=
 the
> > nested VM-Enter to L2 is completed, then KVM should treat interrupts as=
 not
> > being allowed.
> >
> > For injection, this avoids an unnecessary (forced) VM-Exit, as KVM can
> > immediately request an IRQ window, instead of forcing an exit and _then=
_
> > requesting an IRQ window (because after the forced exit, KVM will see t=
hat
> > interrupts are blocked).
> >
> > For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection() =
is
> > affected in practice.  kvm_vcpu_has_events() is unreachable when a nest=
ed
> > run is pending, as KVM clears nested_run_pending prior to calling
> > kvm_emulate_halt_noskip() when putting L2 into HLT via GUEST_ACTIVITY_H=
LT,
> > and SVM has no equivalent to GUEST_ACTIVITY_STATE.  I.e. the vCPU will
> > always be runnable if a nested run is pending, and thus
> > kvm_arch_vcpu_runnable() =3D> kvm_vcpu_has_events() is effectively dead=
 code,
> > as is __kvm_emulate_halt() =3D> kvm_vcpu_has_events().  Oh, and TDX doe=
sn't
> > support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable as
> > KVM shouldn't be faulting in memory with a pending nested VM-Enter.
> >
> > As for kvm_vcpu_ready_for_interrupt_injection(), incorrectly treating
> > interrupts as being allowed could result in KVM prematurely exiting to
> > userspace to accept an ExtINT.
>
> "incorrectly treating interrupts as being allowed" is the status quo,
> that this patch fixes, not sth this patch introduces -- right?
>
> The changelog reads like for the non-injection case this change might
> not be the right thing to do, but I don't think this is the case? I
> assume returning false from
> kvm_vcpu_ready_for_interrupt_injection() and kvm_vcpu_has_events() if
> L1's interrupts are blocked while L2 is running is the right thing to
> do?
>
> The code makes sense to me but I am trying to make sense of the changelog=
.
>
> Aside from that, I have two comments about existing issues (Sashiko-style=
):
>
> 1. The return values of {vmx/svm}_interrupt_allowed() are annoying.
> IIUC, 0 is not allowed, 1 is allowed, and -EBUSY is generally allowed
> but not right now, request immediate exit and try again? That should
> be documented somewhere (maybe I just missed it?).

The next patch is adding the documentation, I spoke too soon :)

>
> 2. Aside from TDX, seems like {vmx/svm}_interrupt_allowed() are doing
> the same thing? So maybe move all that logic into
> kvm_arch_interrupt_allowed(), rename it (because it's only used by
> x86), and make interrupt_blocked() the actual per-vendor callback? I
> assume this is the case because nested_run_pending used to be
> per-vendor, but now we can clean this up. For TDX, I assume the
> per-vendor hook can just be tdx_interrupt_allowed() reversed?

It also does the renaming (nice!), so we're halfway there. I think for
this series, we should at least convert all direct calls to the vendor
.interrupt_allowed through the new kvm_is_interrupt_allowed() helper.
Unless you wanna go all the way and rework .interrupt_allowed to
.interrupt_blocked while at it as well.
