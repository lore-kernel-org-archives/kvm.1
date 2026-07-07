Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77A2E4257
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459850; cv=none; b=Y5I+n5UkvEtBYOr9rmGBbwKUYQlwkY2WElx8a/pITyjcQy57rtv/ne+1lWPHd1hWLry4n+7ImJY6rfqM/NOi13YTovcZmx9rCyJ4ZvHX5yCjU9PpBJYmVsirxINSOG6AwoNQd11LKxpURo7B9BW5ZTVuieBWrnyg0DNx22j6huU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459850; c=relaxed/simple;
	bh=DXH0aRXnYaP7QETshPi4uyPfPTP48GB0M/DfH46M2rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcIRNdkPzEDahd4NCxiicAXAcw6r2Gl3T6lUnoAm/f8jFdwmicBHsIHvYVz4vUy49QdOiOD7POyN/xpxE5QIvt9DOBGu+SvWaloUvCcWmVFgx+xPMCf4jRCHwkDl3UxgPNGVim71assFKR3IKGwr79R2kN2y7n6z9GqLw6fc3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSXuP6YY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSXuP6YY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30A11F00A3D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783459849;
	bh=jUrtZOMOAslTH4TMg0dZsW+Mr33f9fVV9xKYRa4YG2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VSXuP6YYSk0ZUqWd9QXrxru9kfEt/dZPdS6oZ01+X50VzZ4xHmnf7r3KhghhrORSf
	 wJRsTrHhl4XHVDcb6jMRstTZHl5PpK/2p2PGn0ZFvedFjYY9ttOMMykPBADYPrHQsi
	 LQnzuW/PzxwFHShHnSE8vfheR7qiCBmUuK8i3lKAOa8gVZ+8FGv5aRL0NH5zqaaABR
	 7WxCHuubKwyjJnZzVTr/f6sKMnNa70/0wi3qAOn1Gtmi1zK6bkiM4lBXatDT34je0Y
	 tc8gz/T9GmAn3JFv0J6MG1VqdjMeReMkUVI0Jrll8C87F7OahHYPESyfIg7Ho7tY8Z
	 ISSUcMtUcvkHw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so22913a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 14:30:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx73QQFmsqRn8sk+48KTFLooXeC0Zo5qn0glzFmcZhWbldt28CW
	H4G+5L0GnhxLElT82KJNE+VTQio2LhIN4hf2w4nAA65JNPQvhbHbgOuJphYxRwsiv/UPDZdonzo
	Z/bS+0GJDwWePchTZfUpphQfO+/WPXLM=
X-Received: by 2002:a17:907:94d4:b0:c12:7ab4:637a with SMTP id
 a640c23a62f3a-c15a66e630dmr424140166b.16.1783459847898; Tue, 07 Jul 2026
 14:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-9-yosry@kernel.org> <20260616010604.ACC021F000E9@smtp.kernel.org>
 <CAO9r8zNx4=dq=SBMcNwWzedVR4UGgarg=_pfmPT1DWb1MzC2CA@mail.gmail.com>
In-Reply-To: <CAO9r8zNx4=dq=SBMcNwWzedVR4UGgarg=_pfmPT1DWb1MzC2CA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 7 Jul 2026 14:30:35 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNE5F_895rmxuidfs_5Rf0Y5n+osr+bdiT3ju5=+za5sQ@mail.gmail.com>
X-Gm-Features: AVVi8Ce3MYu7L632otiHXJ7Oxy-yHuj60mGeED4wvEYr3gOCcDnxymtvlFpGQ1k
Message-ID: <CAO9r8zNE5F_895rmxuidfs_5Rf0Y5n+osr+bdiT3ju5=+za5sQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/25] KVM: SEV: Stop using per-vCPU ASID for SEV VMs
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:50=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Mon, Jun 15, 2026 at 6:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] A malicious SEV guest or an unprivileged host-userspace proces=
s can trigger a host WARN_ON_ONCE by executing VMRUN (entering nested virtu=
alization) or via KVM_SET_NESTED_STATE.
> > --
> >
> > commit c3ac1dbd3331e2991b6bd808b207ce3395a73130
> > Author: Yosry Ahmed <yosry@kernel.org>
> >
> > KVM: SEV: Stop using per-vCPU ASID for SEV VMs
> >
> > This commit updates KVM to initialize the SEV VM ASID once in
> > sev_init_vmcb() instead of checking and setting it on every vCPU run. I=
t
> > replaces the run-time assignment check in pre_sev_run() with a warning.
> >
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -3555,10 +3555,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
> > >       if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus)=
)
> > >               cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpu=
s);
> > >
> > > -     /* Assign the asid allocated with this SEV guest */
> > > -     svm->asid =3D asid;
> > > -
> > > -     if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> > > +     if (WARN_ON_ONCE(asid !=3D svm->vmcb->control.asid)) {
> >
> > [Severity: High]
> > Can a malicious SEV guest or an unprivileged host-userspace process tri=
gger
> > this warning by entering nested virtualization or via KVM_SET_NESTED_ST=
ATE?
> >
> > KVM does not strictly prohibit userspace from exposing CPUID.SVM to an =
SEV
> > guest. If an SEV guest sets EFER.SVME and executes VMRUN, KVM intercept=
s it
> > and handles the nested transition via nested_svm_vmrun(), which switche=
s the
> > active VMCB pointer to the nested vmcb02.
> >
> > The nested vmcb02 does not inherit the SEV ASID assignment from
> > sev_init_vmcb(), and its control.asid is initialized separately. During=
 the
> > subsequent svm_vcpu_run() -> pre_sev_run() call, the VM's valid SEV ASI=
D will
> > no longer match the nested vmcb02's ASID, causing this warning to trigg=
er.
>
> Hmm I looked around the code and I can't see what prevents SEV guests
> from setting EFER_SVME or using KVM_SET_NESTED_STATE. However, I think
> a VMRUN from an SEV VM will fail, at least due to not being able to
> read the vmcb12 from guest memory?
>
> That being said, I can drop this stopgap if preferred, I was going to
> drop it before sending but I left it in just to be cautious.

From an offline discussion with Sean, seems like it's technically
possible to actually run nested in SEV. So I need to actually handle
this in this series, by making sure L2 uses the same ASID as L1
(required for SEV), and always flushing that ASID on nested
transitions. I will also drop this stopgap, given that it's likely
that using the wrong ASID will result in a loud failure anyway.
