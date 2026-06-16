Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D244E042
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633197; cv=none; b=ZH846mRItWaVjDr/PANcwWw4/VbWmfifY0q5Shld1Obkxe1RFR0ttR5oznZlOT3nS7lUo0Yk3zYjfkLRZUL8ikljW+pfNNK/WXbsgGx3yF57EL+fYYxxf8D4sakOnIwcPmXQbwWcpNYKUOoAUDGwkMCea+TYaZoz804So8cynK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633197; c=relaxed/simple;
	bh=qoB9GPNPtRCGdgUzvHR5ID3q5VcfG6xQ3u0PiTHG1PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVDCoElC4hT3Evbx8XYZkcaw11DR68MJ0dvSLsr0OxmycLvcu9AkKnpxGjt/mvy9l47sQqfsFmo58d92g7ir40FAX0h1RDrokBsJBmb+StBdVg3DEBHpwsfbushbUuXp/IP9bIbMLQxDRZ4XkKu/eEEhzhJmigXswxXMw3tmLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2aS8IFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2aS8IFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3511F00A3A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781633193;
	bh=xMWgSJWYxuKZLOL7EL5ws3yqi8TQEX54163KvYwXdYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P2aS8IFKAX4yilXU/kblHbrQyyDW5FfHY8fDYO9F6towBp7gjCw7sE2J7xQWcaV1k
	 NXl4cmcLCb3XRsILSHGXqdpRFJgqQ8KgOv+w2/8CLdxPvGO+ymhUkCtsEvScJ6E2yJ
	 xsV2iRH7AQFh4NDIyF4sSZ9Uk3aEee9f6k8oXIcOrPnayQquAqq76tdo/Sh12XbNcy
	 eEgBaBP38nWCu53fWmM93YAKk/5J41nG4u1zZNZcopce7G+s3gBDhIIlNp67910cT1
	 EdGY5LNXiEpATJeYpEij6pOYA8TIiZBwkr7LYP3z1hdS1FWK5nn23vsz6+gAZqSz4J
	 BYyd6rhg1MNaQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6924a68e3f3so7828958a12.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:06:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy0gmtQw3GI88BEr6Zd3n2zIYJ6Xfd9jOP+5D8Pgz9ZY37WtcAi
	msLWxQD7R8ZmL7ffaF2QkojTnRYDaXDgK29aUmdZF87vtulL8+2mEMP6wAlFCJjWPSklZJQGJjQ
	BqL2pzaZz0f3xZgkyEVuXnme7OvplJ0s=
X-Received: by 2002:a17:907:c81b:b0:bfa:6dc1:3c64 with SMTP id
 a640c23a62f3a-c05a2748e0emr50765966b.13.1781633192653; Tue, 16 Jun 2026
 11:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-18-yosry@kernel.org> <20260616012056.669B91F000E9@smtp.kernel.org>
In-Reply-To: <20260616012056.669B91F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 11:06:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfe7ybnfoedhz86zNlgaFamO5obTudW21u4hB04KYbKN9HFXxuXbRO2_xE
Message-ID: <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before
 nested transitions
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 6:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Context mismatch in `svm_switch_vmcb()` incorrectly applies glob=
al TLB flushes to the outgoing VMCB and clears the request bit, causing the=
 incoming VMCB to miss the flush. Furthermore, on nested VM-Exit, `leave_gu=
est_mode()` is called before `svm_switch_vmcb()`, causing `kvm_hv_purge_tlb=
_flush_fifo()` to incorrectly reset L1's Hyper-V TLB flush FIFO while hardw=
are flushes are applied to L2's `vmcb02`.
> --
>
> commit 5fb35fcca4bb6e1756cc67fdc65ffe16ab6c194f
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: nSVM: Service local TLB flushes before nested transitions
>
> This patch updates nSVM to service local TLB flush requests before
> switching VMCBs during nested transitions. It aims to ensure flushes are
> applied to the correct context, similar to how nVMX handles them.
>
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 234724d8b4c54..7b19191e0e43f 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *svm, =
struct kvm_vmcb_info *target_v
> >  {
> >       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> >
> > +     /*
> > +      * TLB flushes are applied to the VMCB, so apply any pending TLB =
flushes
> > +      * on the current VMCB before switching to a new one..
> > +      */
> > +     kvm_service_local_tlb_flush_requests(vcpu);
>
> [Severity: High]
> Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH_GUEST)
> while applying them only to the outgoing VMCB?
>
> If a host-initiated flush occurs (e.g., from page reclaim), the request
> bit will be consumed and applied to the outgoing VMCB, leaving the incomi=
ng
> VMCB to miss the flush and run with a stale TLB.

Yeah it is intentional to apply the flushes to the
current/old/outgoing context. If there are flushes needed in the new
context, they are queued by nested_svm_{entry/exit}_tlb_flush().
That's similar to what VMX does.

>
> Also, is there a context mismatch here during nested VM-Exit?
>
> In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
> svm_switch_vmcb(svm, &svm->vmcb01).
>
> Because of this, kvm_service_local_tlb_flush_requests() will see
> is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
> kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO while the
> hardware flushes are actually being applied to L2's vmcb02.

Ugh.. yes. This is annoying. kvm_service_local_tlb_flush_requests()
needs to be called on both the current/old/outgoing VMCB *and* guest
mode. So we'll need to open-code the call in a bunch of places before
svm_switch_vmcb() and {enter/leave}_guest_mode(). I really liked
putting it in svm_switch_vmcb() together with
nested_svm_{entry/exit}_tlb_flush() so that all the TLB flushing logic
for nested transitions live in one place and the ordering needs to be
handled in one place.

I guess there's already a lot of ordering dependencies in all code
entering/leaving guest mode. We really should refactor the code, if
possible, to have one helper for entering nested and one helper for
leaving nested, but I guess that's outside the scope of this series.
