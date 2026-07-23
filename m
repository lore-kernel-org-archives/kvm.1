Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25D25B0AE
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766813; cv=none; b=IAkigwayPkmi5FLoFIUnkrt3QR2fFLd9pgSMJqmFh7tjzWxFTqzJw67YP06oUYiP3NaR3cbBMiFbBgcrpjPTi2mqGv+XtdJXo5PkmEwOwan9YN+9tQHPQ9HNUAQdXTF8sFSmL2XXfhjKT+vOo3OtQEkQ4ZaY5sWR6Nq6L8XWbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766813; c=relaxed/simple;
	bh=e7/RpxVSolxHTXBW1etTUxJL+/1qsGU1BtMP/7h5Mu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dc30MY/SYDbJa2bQfCTlY5cbwnXPbvYwX9Js6w4yu0HoHLc9uRWf+A5ta2UsaizjQ5F8z2R2mLNicG3NFKbv3HCMZTDMxda/nYJ2SjWIwIj7g5EMraX3IxQA3qef1Lyk4+BTkqphWk6Vl/31HAWWBVXM5I4CBN00ljJxvX1mbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRM/3WlI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRM/3WlI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482b95574dso93407b3a.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784766810; x=1785371610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eRKdtnniIXUIJNdGrRoc0zImiCzQKE7Rwz9ClWWv88M=;
        b=fRM/3WlIqNhqJ7ELSG7HSmajCMjAQXQL/PIkKdrKV5wuhrceCV63Gus/pNQVGEzdJR
         R+UKwf5utEz4jC/HSncTGzCyVQvcUovtrFPVE2vhfY4I5YeozzP/R4+6FaziZ4iOdWZC
         zKyZET2UbifL13tCf9NEtCCKGYot+eqZUFMc/neP0BcT24uqsduABLMOvMpVa2PxbsLS
         Awqay/hW6uNnZX08qp+cfK2tUEmK4hy4CwHw7AM2CXKEru2PJcSNCVWv4FsWQoei9Kb7
         J0tnvIUEBTRrOy1HgcbDL91/Inx0Z7FXRklkBXjJBcrOaNS80ZOfLmpR6gc5GhRwMpei
         kxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766810; x=1785371610;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRKdtnniIXUIJNdGrRoc0zImiCzQKE7Rwz9ClWWv88M=;
        b=ksdlzL/retNC3sDVhgw9n+Kze+q+imClXdYC9lCkCGrsVnEXuLlN/sUCP8PvV3TnRR
         cthAUo7wx46hcImhik/drB9IMOyNvjdj7Xh3yVVVRDHdp7qZpgHnlp9zP1UuSPfOiHtF
         up6L/P1/OsMn2tvk3nMI8iixweWi+pDO/G7tj1R1zBLrNcFkhk/d4y3CmG4VTzkCvma4
         B3VKpc3RPKofegY+XK8OjaaUj2gz4dHnAw2DfYFpUK/LxRD6fFU+4vVyOV1CO8qLvey+
         YKmWrI6Yj3xa89+NAnSuUoN3D3N55/lT3fIK/BRLOE0VwyyPDPCVOJtyAfF3n1dIdsK/
         SY5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrA5eaoP8N7U3GOV9GGaD9riPvsT79rLAs7wnFmtGW9oX20VkocPPq+4yvbcpWyOsY/mLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx2uPO0Ooxv4iQBn6k19qpjE3+G9scVHQY77BAmyRKDTJla6jB
	cjs0WmdPzuWHpK+GrvyZeQ0f5VE8n9CMhhXzkXWU6FCj0Ttto0+gFFvUXVytqpDtMJ3IoksfYw1
	NJjNp2w==
X-Received: from pghz12.prod.google.com ([2002:a63:e10c:0:b0:c9a:b3b0:a861])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:d8a:b0:3c3:87e1:2637
 with SMTP id adf61e73a8af0-3c44b013224mr818095637.22.1784766809981; Wed, 22
 Jul 2026 17:33:29 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:33:29 -0700
In-Reply-To: <CAO9r8zNE5F_895rmxuidfs_5Rf0Y5n+osr+bdiT3ju5=+za5sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-9-yosry@kernel.org> <20260616010604.ACC021F000E9@smtp.kernel.org>
 <CAO9r8zNx4=dq=SBMcNwWzedVR4UGgarg=_pfmPT1DWb1MzC2CA@mail.gmail.com> <CAO9r8zNE5F_895rmxuidfs_5Rf0Y5n+osr+bdiT3ju5=+za5sQ@mail.gmail.com>
Message-ID: <amFhWUcEWucx1hlH@google.com>
Subject: Re: [RFC PATCH v2 08/25] KVM: SEV: Stop using per-vCPU ASID for SEV VMs
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026, Yosry Ahmed wrote:
> On Tue, Jun 16, 2026 at 10:50=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> > On Mon, Jun 15, 2026 at 6:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > --- a/arch/x86/kvm/svm/sev.c
> > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > @@ -3555,10 +3555,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cp=
u)
> > > >       if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpu=
s))
> > > >               cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_c=
pus);
> > > >
> > > > -     /* Assign the asid allocated with this SEV guest */
> > > > -     svm->asid =3D asid;
> > > > -
> > > > -     if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> > > > +     if (WARN_ON_ONCE(asid !=3D svm->vmcb->control.asid)) {
> > >
> > > [Severity: High]
> > > Can a malicious SEV guest or an unprivileged host-userspace process t=
rigger
> > > this warning by entering nested virtualization or via KVM_SET_NESTED_=
STATE?
> > >
> > > KVM does not strictly prohibit userspace from exposing CPUID.SVM to a=
n SEV
> > > guest. If an SEV guest sets EFER.SVME and executes VMRUN, KVM interce=
pts it
> > > and handles the nested transition via nested_svm_vmrun(), which switc=
hes the
> > > active VMCB pointer to the nested vmcb02.
> > >
> > > The nested vmcb02 does not inherit the SEV ASID assignment from
> > > sev_init_vmcb(), and its control.asid is initialized separately. Duri=
ng the
> > > subsequent svm_vcpu_run() -> pre_sev_run() call, the VM's valid SEV A=
SID will
> > > no longer match the nested vmcb02's ASID, causing this warning to tri=
gger.
> >
> > Hmm I looked around the code and I can't see what prevents SEV guests
> > from setting EFER_SVME or using KVM_SET_NESTED_STATE. However, I think
> > a VMRUN from an SEV VM will fail, at least due to not being able to
> > read the vmcb12 from guest memory?
> >
> > That being said, I can drop this stopgap if preferred, I was going to
> > drop it before sending but I left it in just to be cautious.
>=20
> From an offline discussion with Sean, seems like it's technically
> possible to actually run nested in SEV.=20

It is, past me actually got it working (I was curious). :-)

> So I need to actually handle this in this series, by making sure L2 uses =
the
> same ASID as L1 (required for SEV), and always flushing that ASID on nest=
ed
> transitions. I will also drop this stopgap, given that it's likely that u=
sing
> the wrong ASID will result in a loud failure anyway.

FWIW, "need" is debatable.  If supporting nested+SEV adds a lot of complexi=
ty,
I'd probably be ok dropping support for that, e.g. by failing VMRUN with a =
software
error.  But if it's roughly the same complexity overall, I'd probably vote =
to
allow it, mainly to avoid making semi-arbitrary support/policy decisions in=
 KVM.
