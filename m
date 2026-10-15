Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338B3C1966
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106447; cv=none; b=sBr/vG1ZQYpzxzjjvLpxYmqA7pjenCsh79qiD5RQfoyK3aC0rfKRi/Ihuh/BLM3o03yXRWt0VFJdDZgT79mw3s2ULUxxnK6S2NAJtytYq8kaL2hwf+Etg1mckT+XKoL7HWo6ScMPOBiT49spo/eUaV7aCGkDWZhwkDMnAj8T2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106447; c=relaxed/simple;
	bh=j83uMIx5Rfc2yvF68EcUoRsA11g31hIpPgYnchUqs+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8dZUWlQvlqCM3890501mwOOuk16ViYeF27dN7C2GgAfsjG26RJZIh+VcEpudITGHT5lSkdDpiwl91BTu8RBs8qvQO/rF7Mbjsg38vbxdd0gozWLit87EleoXPBzZgqyfxC5dmXgzD/AYHBjEZ+6Nue7O+jrG8XeJ1l6ck7x7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDu7Okga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDu7Okga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E161F000CA
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792106446;
	bh=LUvhgsUTECZ66zaJTPjvK1A1xICdLeq69Y9+jbS//zo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XDu7OkgasokV1iQvw3CEpqZLLkZGI3z2dwXjxnRJtCYl4faVFEQA6/CWJYsSbQnay
	 T+JaiGb99s2HI5ito20X5vsnEKrqzvqFlIA8K3vbHiiMFtiL+Hmnt8+MrJnS8P9Gcz
	 j7VGK9OMwsXNHdZc/Dzbu6nIMYPqo7s8rhVug6w4uurM78QYJBTX85JrbQDzQ47xl0
	 tCxubG+aX2MDIazqMrPNqcm7EEXGKDnAhSNL8xjQGJZXQzH9pVx9+d/RZSF0JabVx2
	 uUGk7gsReduqCiW6uPBxITHBTrnqgn+Me01opaJ0VNtcmIIUbbJcX6jenvDFzIF10g
	 ziaGGcQx74Nvg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso1023600366b.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:20:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzKIJCreAlmWmp2tYVRgTtLe2iZW9YtpiaCAWNT5Pu5INtI2Gr9KoO7+7kZNH4dD61ECLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnvaqLDDbjvkibjaYnnUeU3EBgZbL2dn44ROKw9leT8pPUsgO0
	k47Hp0TDorPvBwMhPdW1n6jllgD1jPBfLWiJsU/BQF3+9cDjFxAIoAfsUa2+gLzTHq99jxdrR3L
	IGnKtYT5bIg7bUtlE857NZR+tiNiGv8M=
X-Received: by 2002:a17:907:d90:b0:c2d:bc76:8342 with SMTP id
 a640c23a62f3a-c31a9a2db07mr1874472366b.5.1792106445362; Thu, 15 Oct 2026
 16:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-23-yosry@kernel.org>
 <CALMp9eSv9a23si8rtWd_XGRJxVWE96aWdSzE_Ram5Bu6G_pb+w@mail.gmail.com>
In-Reply-To: <CALMp9eSv9a23si8rtWd_XGRJxVWE96aWdSzE_Ram5Bu6G_pb+w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 16:20:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMkRADNhRCBoxKCPNM90H0uqB5Jyt7oB4RDmbhgY_UM-g@mail.gmail.com>
X-Gm-Features: AclHuK9Dl0an3RcXmue1Fj0HSSER5rW3elDdOiQ5i-t568Zwn5LzEUXcQnJZvgo
Message-ID: <CAO9r8zMkRADNhRCBoxKCPNM90H0uqB5Jyt7oB4RDmbhgY_UM-g@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] KVM: nSVM: Flush the TLB if L1 changes L2's ASID
 in vmcb12
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:09=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > KVM uses a single ASID for L2 guests per-vCPU. Hence, when L1 changes
> > L2's ASID in vmcb12 (e.g. due to switching to a different L2
> > vCPU or simply to avoid flushing an existing ASID), KVM needs to flush
> > the L2 ASID to correctly emulate different ASIDs as different TLB
> > domains.
> >
> > Additionally, the nested NPT needs to be resync'd, as the MMU context
> > is not tagged by ASID, and KVM cannot reuse nested NPT entries across
> > different L2 ASIDs.
> >
> > Essentially, L1 switching L2's ASID is treated exactly the same as L1
> > flushing L2's ASID, which is consistent with the APM:
> >
> >   Software may effectively flush the guest's TLB entries by allocating =
a
> >   new ASID for the guest and not reusing the old ASID until the entire
> >   TLB has been flushed at least once.
> >
> > This is similar to nVMX's handling of last_vpid, except that when L1
> > changes VPID12, KVM does *not* need to resync the nested EPT, because
> > VMX VPIDs, unlike SVM ASIDs, do not tag guest-physical translations
> > (i.e. nGPA to GPA translations).
> >
> > Reset last_asid when nested VMRUN fails to force a flush and sync on th=
e
> > next nested VMRUN. The TLB flush request survives the failure, but the
> > request to sync the nested NPT does not, as it ends up being serviced i=
n
> > L1's MMU context after the synthesized VM-Exit.
> >
> > Drop the commentary about vmcb12's ASID being copied around only for th=
e
> > consistency checks, as they no longer apply, and opportunistically fix
> > whitespace alignment.
> >
> > This is currently functionally a noop, as a full flush and sync is
> > triggered on every nested transition, but is a step toward eliminating
> > that.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c | 29 +++++++++++++++++++++++------
> >  arch/x86/kvm/svm/svm.h    |  2 ++
> >  2 files changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index e04cc4f7669ea..8e4686b0d603a 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -556,10 +556,8 @@ void __nested_copy_vmcb_control_to_cache(struct kv=
m_vcpu *vcpu,
> >         to->nested_cr3          =3D from->nested_cr3;
> >         to->pause_filter_count  =3D from->pause_filter_count;
> >         to->pause_filter_thresh =3D from->pause_filter_thresh;
> > -
> > -       /* Copy asid here because nested_vmcb_check_controls() will che=
ck it */
> > -       to->asid           =3D from->asid;
> > -       to->clean =3D from->clean;
> > +       to->asid                =3D from->asid;
> > +       to->clean               =3D from->clean;
> >
> >  #ifdef CONFIG_KVM_HYPERV
> >         /* Hyper-V extensions (Enlightened VMCB) */
> > @@ -691,23 +689,35 @@ static void nested_save_pending_event_to_vmcb12(s=
truct vcpu_svm *svm,
> >  static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> >  {
> >         struct vcpu_svm *svm =3D to_svm(vcpu);
> > +       bool new_asid =3D false;
> >
> >         /* Handle pending Hyper-V TLB flush requests */
> >         kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> >
> > +       if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
> > +               svm->nested.last_asid =3D svm->nested.ctl.asid;
> > +               new_asid =3D true;
> > +       }
>
> To make sure we don't miss a flush after restore, do we need to clear
> last_asid in svm_set_nested_state()?

In [1], we set svm->nested.vmcb02.cpu =3D -1 in svm_allocate_nested(),
which should be called when EFER.SVME is set on restore, and should
force a TLB flush on the first vCPU run. That being said, if EFER.SVME
was already set (not a fresh vCPU), we won't necessarily flush the
TLB. KVM_SET_SREGS will _probably_ flush the TLB, but I don't think
it's guaranteed.

But wouldn't this also affect non-nested? Are we guaranteed to flush
L1's ASID after restore?

[1] https://lore.kernel.org/kvm/20260903175856.4065099-1-yosry@kernel.org/
