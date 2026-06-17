Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62E149DF1
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781655716; cv=none; b=jK4MIw1BJwdqNB9BM7Cv0udnn5B1kowT/QX4+E74uNLGs2QpqZoqZQZIURxX1LcX27WSC1QWgrst9l/F9zPQePzGA8Obr6nO4V63UcEePkat4jdEYktYg/XMWcvKi6b0GlsWYbu9GsebJDMD8RI7+YGaqSpwc1X9QWlYABPdEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781655716; c=relaxed/simple;
	bh=+TVQTv2h97ByM9nO6MCPec314sU8X6wggPTrtuJjeT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JltXt9jJhsEqAPmoYSU8oDSxsVE3TcywoHFqWiwaqWKJs3xZvl6Zlo7SQOHpYwwe56HLaBaAcfCYxW5zz2jeTjN4OKS4W1ZPtMTjr2QxS1YMAHOmRdVx3qLU7j49AF13vXJY/1sGtIAVgb8ebkJGgpJAJuwYo1XusKjngI9vHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgtqhzc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgtqhzc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4854B1F000E9
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781655714;
	bh=4hU3qNPA5Vv5eHQo3QDJjtf2MKIrx2ckmCQE1lcbp7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bgtqhzc+5R0NMh7UrybC13cpZRmK6A3djXxfgaEXZ+FudOcPdpijzPgFGbZMUp9Xr
	 x9xaUifr4Z2Imi2+sDKJasHmSnSfIMWTOOIsi6/D/YZUSnwoR4kYUcB508UXqIkMdN
	 66Bos6p4CvmscxPyPD1Y/OxwxsghFyppiV+/E4Qq3s0bQV5tTwMXKrWdmbc02JfP5k
	 VQcJ0KEBiCE5f0SNmnSRFfHmaJ7ceo/59C+Z4GuDpvPwNcMMqdwRNJxEIWUPUDYq4q
	 3BRsHDVnXvIROyXSIkNc0Rt5EmbAYMpeVB9eCMoGnv4TfnI9b4eu8+zPRAlYYTNtIX
	 DK+h/xUY4tq+g==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec49f7e35eso679659266b.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:21:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLRQJ1hAfuIGetj7Y8uLJvwH8fx/Yhf7hMI17MLLer9wx9P7SX
	hc8gNjumVuWGFxs82dw+kH8yDdrnndxIv0cwQvmefIfiwNpGVSqOncc/ZcES5dUXFAM9JXUwe16
	B5ekFFc8mYQuRBh0HCiqNO2Gq4Ved/wI=
X-Received: by 2002:a17:907:5c8:b0:bed:38b8:9b4b with SMTP id
 a640c23a62f3a-c05a6bde16cmr109406166b.27.1781655713237; Tue, 16 Jun 2026
 17:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-18-yosry@kernel.org> <20260616012056.669B91F000E9@smtp.kernel.org>
 <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
In-Reply-To: <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 17:21:41 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
X-Gm-Features: AVVi8CdFWbP5VaAaq7cks-G-REivXE_Kzo7woPGSH4eC8AYYHPKUgrnDxPqcoN0
Message-ID: <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before
 nested transitions
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:06=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Mon, Jun 15, 2026 at 6:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Context mismatch in `svm_switch_vmcb()` incorrectly applies gl=
obal TLB flushes to the outgoing VMCB and clears the request bit, causing t=
he incoming VMCB to miss the flush. Furthermore, on nested VM-Exit, `leave_=
guest_mode()` is called before `svm_switch_vmcb()`, causing `kvm_hv_purge_t=
lb_flush_fifo()` to incorrectly reset L1's Hyper-V TLB flush FIFO while har=
dware flushes are applied to L2's `vmcb02`.
> > --
> >
> > commit 5fb35fcca4bb6e1756cc67fdc65ffe16ab6c194f
> > Author: Yosry Ahmed <yosry@kernel.org>
> >
> > KVM: nSVM: Service local TLB flushes before nested transitions
> >
> > This patch updates nSVM to service local TLB flush requests before
> > switching VMCBs during nested transitions. It aims to ensure flushes ar=
e
> > applied to the correct context, similar to how nVMX handles them.
> >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 234724d8b4c54..7b19191e0e43f 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *svm=
, struct kvm_vmcb_info *target_v
> > >  {
> > >       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> > >
> > > +     /*
> > > +      * TLB flushes are applied to the VMCB, so apply any pending TL=
B flushes
> > > +      * on the current VMCB before switching to a new one..
> > > +      */
> > > +     kvm_service_local_tlb_flush_requests(vcpu);
> >
> > [Severity: High]
> > Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH_GUEST=
)
> > while applying them only to the outgoing VMCB?
> >
> > If a host-initiated flush occurs (e.g., from page reclaim), the request
> > bit will be consumed and applied to the outgoing VMCB, leaving the inco=
ming
> > VMCB to miss the flush and run with a stale TLB.
>
> Yeah it is intentional to apply the flushes to the
> current/old/outgoing context. If there are flushes needed in the new
> context, they are queued by nested_svm_{entry/exit}_tlb_flush().
> That's similar to what VMX does.
>
> >
> > Also, is there a context mismatch here during nested VM-Exit?
> >
> > In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
> > svm_switch_vmcb(svm, &svm->vmcb01).
> >
> > Because of this, kvm_service_local_tlb_flush_requests() will see
> > is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
> > kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO while t=
he
> > hardware flushes are actually being applied to L2's vmcb02.
>
> Ugh.. yes. This is annoying. kvm_service_local_tlb_flush_requests()
> needs to be called on both the current/old/outgoing VMCB *and* guest
> mode. So we'll need to open-code the call in a bunch of places before
> svm_switch_vmcb() and {enter/leave}_guest_mode(). I really liked
> putting it in svm_switch_vmcb() together with
> nested_svm_{entry/exit}_tlb_flush() so that all the TLB flushing logic
> for nested transitions live in one place and the ordering needs to be
> handled in one place.

Maybe we can just re-order the code to always call svm_switch_vmcb()
before {enter/leave}_guest_mode(). We already do that on the entry
side, and seems to be straightforward on the exit side.

With that, we can keep kvm_service_local_tlb_flush_requests() and
nested_svm_{entry/exit}_tlb_flush() inside svm_switch_vmcb(). We can
add a WARNING to kvm_service_local_tlb_flush_requests() to make sure
the calls remains in the correct context (i.e. VMCB matches guest
mode).
