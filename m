Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB43FA5E9
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103703; cv=none; b=RFHQX/iyVET1OTVmFtWh0EX74gy2kZuNfAsOZsGuqqnvlDauuw5i9ZMm0R7AKOcSfA2+Lp1L49LN5bqW9KfI6F4DmVkBMlkzlxeLMg63m3wCodXqE+JYvORESltqYWLLNobJiLzc9MPtnD70xreBQ6RVV9x7ILZchGg63f9KaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103703; c=relaxed/simple;
	bh=5PFxIgrJdw21ooFVEocIxaEpQMQcs7ItkH0ese3ArLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWLdmVu9oSsTrh6on3bn6Q1Ia5kQwUXB0AbQ3GsizVtghUJh0fz4dAzFhZw/a2rlymBUTzay0YinlkVzYyQuhIRIC4SZxOIbCLQIajKTyYU773T6B/63Cn2pU6pxR1gLp7PyVBcVzX0WYFP8C3/Yd2rcnD2EK3Tpd0BFr06YkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCkS8jX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCkS8jX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9A91F000C4
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792103702;
	bh=WbO4SWlI15SaTCWeULamB5kn+8ZiGYLKf2XlNAHXwv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GCkS8jX2kX7QGEl4LSEyKTzi9rWy1Nus/ZdKpgw9JULuSs1Y+lu1yNYE422pLh8nL
	 HblSU9NCAUDuytovps6zWm+opILBqlGLN3/urrwrE6QntANzrq+rhzca65OsJEJHpF
	 NyTfcIiRBWVV1KLjkhE5TyCivpPnpecmZp6HMLc4Cfgksa3u12TZJ6+q8HOj9jssqL
	 cOhOzTv2uswakilpsEcJxwi1BIm2yXs8AvQCkxHrnBitlM1hnNMzgY/5GEHIfv+QWh
	 um+3ZILVkU2nGtBKeyYQeyrXkk9SbB8cq05Cv4Tj4Y6YUbaAhxW5+gYqlWGyhSjBiM
	 vAkjVNs3i598g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c315869241fso374066166b.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:35:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw55BxL8b8xBzIYZdGJ17O+7E0KPjrQNnQg83vAZ2dxh60LwhPJAZGl1LvyDwputMuosAY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQf09PeUNHdAIl5w78Fou65GfzaOBKregm0dVGY+rZhrly7yjb
	z67vq9xmA+0osy3+dZ9KcRPB98uAAQ4OMlMFzqWLfNoVSweqb72IIA/eUt+UBRguyS0kbRaSDaB
	EcHZV78Va3phhaNxaCd+qIJruXZjIy4E=
X-Received: by 2002:a17:907:9411:b0:c2e:3464:6e36 with SMTP id
 a640c23a62f3a-c31a9ff9da2mr1818965366b.41.1792103700947; Thu, 15 Oct 2026
 15:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-20-yosry@kernel.org>
 <CALMp9eRd3COQijFU8AdcJKo+usr4A7dC6GOYT3YS93UBZ0yHRA@mail.gmail.com>
In-Reply-To: <CALMp9eRd3COQijFU8AdcJKo+usr4A7dC6GOYT3YS93UBZ0yHRA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 15:34:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNvcoXxDHxxZEWZM-Effav-Yb8piVuN5BsGanhR5dJmFw@mail.gmail.com>
X-Gm-Features: AclHuK_YkVEoNDjbcrU4O3rdkg8Pvm3reSys94L6OW6XtPIG7XQ-1bdB25FxSiY
Message-ID: <CAO9r8zNvcoXxDHxxZEWZM-Effav-Yb8piVuN5BsGanhR5dJmFw@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] KVM: nSVM: Service local TLB flushes before
 nested transitions
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:20=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > Service pending TLB flushes for a specific context (L1 vs. L2) before
> > entering/leaving guest mode, as KVM does not track TLB flush requests
> > for L1 vs. L2. This is not currently required as KVM always flushes the
> > TLB on nested transitions, but it is a requirement to drop the
> > unconditional flushes.
> >
> > TLB flushes are performed through the VMCB's TLB_CONTROL field, so
> > service the flushes before every VMCB switch (except the precautionary
> > switch in svm_free_nested()). Servicing flushes may end up purging the
> > relevant HV TLB flush FIFO, which is based on guest_mode, so make sure
> > local TLB flushes are handled before calling {enter/leave}_guest_mode()=
.
> >
> > This is conceptually similar to how nVMX calls
> > kvm_service_local_tlb_flush_requests(), except that the VMX calls only
> > have ordering requirements on {enter/leave}_guest_mode(), and not
> > switching the VMCS, because VPID used for TLB flushes depends on
> > guest_mode, and flushes are not VMCS-based.
> >
> > Note that nested_svm_{entry/exit}_tlb_flush() must be called after
> > kvm_service_local_tlb_flush_requests(), otherwise the TLB flushes will
> > be immediately applied on the outgoing VMCB rather than the incoming
> > one.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
>
> [ ... ]
>
> > @@ -1549,6 +1567,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
> >                 vcpu->arch.nested_run_pending =3D 0;
> >                 svm->nested.vmcb12_gpa =3D INVALID_GPA;
> >
> > +               nested_svm_service_local_tlb_flushes(vcpu);
> > +
>
> When called from svm_vcpu_free() during teardown,
> kvm_service_local_tlb_flush_requests() will be called for a vCPU that
> is being destroyed--and isn't loaded. By that point, the MMU has
> already been unloaded. Is that safe?

It should be, VMX already does it.

I am assuming you are specifically asking about
kvm_vcpu_flush_tlb_guest(), as it could end up syncing roots with TDP
off. kvm_mmu_unload() should set all roots to INVALID_PAGE. Both
kvm_mmu_sync_roots() and kvm_mmu_sync_prev_roots() will then
gracefully skip.
