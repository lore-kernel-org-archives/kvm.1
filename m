Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B993D88E0
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108237; cv=pass; b=tcNdJikkX2Zwjqq2TQuMNdhObhkz7wjSw4KCEqr+nJytsZKebB9Y0/u+CxSuNFUKdZBkzO0IGKWZspR7bEyUmsme9889maR/Eci6++Iu2GrIXLf8/2f2VeGOp1BjlPbw5i9A80+3Ws2/TzpajeqlBH+jQz7+i82uALXPKrRLeIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108237; c=relaxed/simple;
	bh=/mWAiD+SdF93v7V1LXk7HNRMpAc7xPC+EtxxIdvRnvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7OS852SkrIw/DVwBsj0o8T5hEbXOtcplc4oIEK36TCHh/6N4BAmtwvLftdlBI3vfoMnoSwNO7iMK7Pa7IAgoL1FAppENjput1iqzWKHLgehWz0ABwmefFTT0jVf7kQ2Bn/Mvt9ci9V6ErNRnebQxWzHWhKU7/8bcxe6CRmwwNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GchxOkN7; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GchxOkN7"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso5066a12.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792108234; cv=none;
        d=google.com; s=arc-20260327;
        b=eUVDhQo8QK7cfG11GjmsJWUdcqlvce2LU/Ui4k8PBogukJ5trXoNNU+V7UjMWStKQZ
         US3UwtIj//lYpgXQH5kIqVHSAdt36YCb8VAfohTqHpDfe9lOH3Vgm6XQ+h/SK4KfpJ7C
         /GTXZc74lHfD7T3PFWOWdx+Sy5Cv2IslCYJ+8oC1Vkvb1wXgy14sKE8PEy2cHl8AQYlM
         M/p5opa4DQnshQYKR/xNBI2MIGtZJ+OI5SbWzF08CsrqE8CUN7Mm3Tn1Ee+HHJPSbGGg
         u6wO+pVG4E8dIjo5J+wZw2RDLg6UYjAHc7md/9d1Xx2dk5JtzAyZQFRwJvCQskeDMPif
         bKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wRjFLXV6COr6RPV3tAUL8X/xyP3XarNU6behXnaftIw=;
        fh=eMbCkNF7KWWb2Pi4IV1//Zy2EahOs3Epa4D9LvKvOz4=;
        b=q7DBqjmvFB19S/q5EvuzovvQPwM5VNCTT7IKc6GjrsAPloQXkoZJLn5fyPUS+glsG/
         coJtr8MgwVuVmJsifcpq3av2HgUqbVuOwDWZYP7QNzCpYHU32iMnDs2/yluNf3MkCcMD
         YxZWqNzgZ1Uk2BzNIqlEGLj7PHQkZDapqVu2QkCG5wxatuDUzTAcR6GSHmO65IIPu2oW
         VST8A86ZJurCKPDHmNJBl5G2g7w6D+Tu3F7ucidTHQ9CBBF7gmzTy+M9jkdIJZorbJU+
         dEjSP7tmvQNTInC8jDvgZXgUnuj5RGoZ4FDRaNBJMKvsaf4qAiNkHg1N8jct68AzVKbx
         6sKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792108234; x=1792713034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wRjFLXV6COr6RPV3tAUL8X/xyP3XarNU6behXnaftIw=;
        b=GchxOkN7leNBeJZVYI12OP4G6bmSHvyVVIvzjAboQNyxXsrXcCzx1HTyvzDZFSwDkF
         QxTQ+0xxOeKdHlY2euLs6mBsV0g9LXjhJ2uUDzqXS8PiGmojgqleqYNNpzXCBY6c9g9l
         6rLC3OfQEojJPEWSYIwY482RoKfyYPGTCqBnebaMM9W0DGvUsasahBPT1mSbEqsxrf+h
         5x0AEhMu2Vfs/0XKdWnFTD2crfjwppx5xwHpfVQGqLz727WOXozQosAgLboKZbsyitrg
         2fdetylbl07l7jXDqQgO31OYHsDmNKCLEiWLCZDKoPKsoYB3LiktmCOV7VRPVrWC9cK0
         jqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108234; x=1792713034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wRjFLXV6COr6RPV3tAUL8X/xyP3XarNU6behXnaftIw=;
        b=JqJobntAi29uuHOsw6TN/DgaAfpWdKsvKRRGm/1qLD8LfL9YAHm7LfMQX3/WYlaQzQ
         gWUSct+gYXXzfcUQt1HaUQDJI3Z/0ssIyCOPfa09ktZb831GjvS0GUXJRRYzbKcvb9FM
         25tjimTXT23cTOnP1r7y5y9H33r133nUo6mKOGMdhmV8jRmP9rMugKB73yaTY38Gq2fB
         GsetJr+KWE8aB/oNemzSMP0i+VQCBOMS8IY1Uvua7Rpe3X7cr+E+V/rGLvDEpLv+Edq6
         nsoAvbFOaVARo6DFEKLvO0KMi/KhU51K9zYVqdD9PoWq8Xh5drXjjkaz4iCyqkkemhaL
         QW6A==
X-Forwarded-Encrypted: i=1; AKwUvByJY6/CQuwmWzS+p/tXMl2zPZAbW2eqb42A6LNESRMShaFLNiTcxVAQ0avlDR2YEsNZWKE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwtYKL7zJGnKttoxQj3cbLdP2f11nsGPe5mODQoPtGSsKm5AxL
	jF7LHL+W9Ha94+NP2Ab7xI+R0f7Cd8KQ2kQmckLOEOXV2PTGHF2dK25ysUi2KjZ15auRwadAyCt
	njbnRM3bSowxC4FjlF/0Wqt7Hc87Dg9o7sUBmyB5+qhB+oI8Nz/FQG0soeYo=
X-Gm-Gg: AYBFou2In3IWbO1V81VwMvrL1cNomCAfLiDJGumWs0YHxIjA2uGoXVo5TfcXMaVwyI2
	2DmOazPx8rI3kkZlhogMcDB2BvBCiF/oOOX+xRqi8gT74thRtIYIlzSYgHhQ/DT7hg4xH2C+Mll
	Vs15mT8D1A77j/ilSUx7mBLhA2u+eUHp1BfW+s8JY4cQQBZXk+cpuKzZ5RwzMZXmyNb9ZeaxjMx
	fjI09OoIOxZOrCuqJlEkWmEuXHPT5kHVUIaZLMQBzmzgbjYcjOn97Pn9Edy/HmEowyv/KePj3d3
	hrOWBCRYoS2K9z2EcnjpKEuH1s9AR+Pnm9VlTbmslIW0DEzq4xPzLAU9JjL+PeXSgA==
X-Received: by 2002:a05:6402:569a:b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b375fed3bbmr61015a12.16.1792108233125; Thu, 15 Oct 2026
 16:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-23-yosry@kernel.org>
 <CALMp9eSv9a23si8rtWd_XGRJxVWE96aWdSzE_Ram5Bu6G_pb+w@mail.gmail.com> <CAO9r8zMkRADNhRCBoxKCPNM90H0uqB5Jyt7oB4RDmbhgY_UM-g@mail.gmail.com>
In-Reply-To: <CAO9r8zMkRADNhRCBoxKCPNM90H0uqB5Jyt7oB4RDmbhgY_UM-g@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 16:50:21 -0700
X-Gm-Features: AclHuK__2bxVqgF-aRzH9PjET3jPZMjv08B5sdt-cb2rpApPG1RY0C2Eadkz3CM
Message-ID: <CALMp9eTM23iFdrbZE8qw9kuJ2va+Mahv5wZDmgs1TZrAREh=gw@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] KVM: nSVM: Flush the TLB if L1 changes L2's ASID
 in vmcb12
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:20=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Oct 15, 2026 at 4:09=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > KVM uses a single ASID for L2 guests per-vCPU. Hence, when L1 changes
> > > L2's ASID in vmcb12 (e.g. due to switching to a different L2
> > > vCPU or simply to avoid flushing an existing ASID), KVM needs to flus=
h
> > > the L2 ASID to correctly emulate different ASIDs as different TLB
> > > domains.
> > >
> > > Additionally, the nested NPT needs to be resync'd, as the MMU context
> > > is not tagged by ASID, and KVM cannot reuse nested NPT entries across
> > > different L2 ASIDs.
> > >
> > > Essentially, L1 switching L2's ASID is treated exactly the same as L1
> > > flushing L2's ASID, which is consistent with the APM:
> > >
> > >   Software may effectively flush the guest's TLB entries by allocatin=
g a
> > >   new ASID for the guest and not reusing the old ASID until the entir=
e
> > >   TLB has been flushed at least once.
> > >
> > > This is similar to nVMX's handling of last_vpid, except that when L1
> > > changes VPID12, KVM does *not* need to resync the nested EPT, because
> > > VMX VPIDs, unlike SVM ASIDs, do not tag guest-physical translations
> > > (i.e. nGPA to GPA translations).
> > >
> > > Reset last_asid when nested VMRUN fails to force a flush and sync on =
the
> > > next nested VMRUN. The TLB flush request survives the failure, but th=
e
> > > request to sync the nested NPT does not, as it ends up being serviced=
 in
> > > L1's MMU context after the synthesized VM-Exit.
> > >
> > > Drop the commentary about vmcb12's ASID being copied around only for =
the
> > > consistency checks, as they no longer apply, and opportunistically fi=
x
> > > whitespace alignment.
> > >
> > > This is currently functionally a noop, as a full flush and sync is
> > > triggered on every nested transition, but is a step toward eliminatin=
g
> > > that.
> > >
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 29 +++++++++++++++++++++++------
> > >  arch/x86/kvm/svm/svm.h    |  2 ++
> > >  2 files changed, 25 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index e04cc4f7669ea..8e4686b0d603a 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -556,10 +556,8 @@ void __nested_copy_vmcb_control_to_cache(struct =
kvm_vcpu *vcpu,
> > >         to->nested_cr3          =3D from->nested_cr3;
> > >         to->pause_filter_count  =3D from->pause_filter_count;
> > >         to->pause_filter_thresh =3D from->pause_filter_thresh;
> > > -
> > > -       /* Copy asid here because nested_vmcb_check_controls() will c=
heck it */
> > > -       to->asid           =3D from->asid;
> > > -       to->clean =3D from->clean;
> > > +       to->asid                =3D from->asid;
> > > +       to->clean               =3D from->clean;
> > >
> > >  #ifdef CONFIG_KVM_HYPERV
> > >         /* Hyper-V extensions (Enlightened VMCB) */
> > > @@ -691,23 +689,35 @@ static void nested_save_pending_event_to_vmcb12=
(struct vcpu_svm *svm,
> > >  static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> > >  {
> > >         struct vcpu_svm *svm =3D to_svm(vcpu);
> > > +       bool new_asid =3D false;
> > >
> > >         /* Handle pending Hyper-V TLB flush requests */
> > >         kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> > >
> > > +       if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
> > > +               svm->nested.last_asid =3D svm->nested.ctl.asid;
> > > +               new_asid =3D true;
> > > +       }
> >
> > To make sure we don't miss a flush after restore, do we need to clear
> > last_asid in svm_set_nested_state()?
>
> In [1], we set svm->nested.vmcb02.cpu =3D -1 in svm_allocate_nested(),
> which should be called when EFER.SVME is set on restore, and should
> force a TLB flush on the first vCPU run. That being said, if EFER.SVME
> was already set (not a fresh vCPU), we won't necessarily flush the
> TLB. KVM_SET_SREGS will _probably_ flush the TLB, but I don't think
> it's guaranteed.

I'm pretty sure that restoring nested state on an existing vCPU with
the same asid12 and no TLB_CONTROL skips the flush.

> But wouldn't this also affect non-nested? Are we guaranteed to flush
> L1's ASID after restore?

That may be a bug too.
