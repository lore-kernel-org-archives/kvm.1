Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD047A0B2
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632217; cv=none; b=mByhTZRSS4enx5sN28PVHwJ8rpAgz0EvnwGW7FBhFj1HIqxG5QsXpoheGW66WsGJeAD5ppDWGbXpXoxqmOGnffKv9grpDLw1L+fRtMJmSudrkjdZFu1CGke6OkwBlLSjwf1f8OKOenvWsocLHRdq7e6kK33gRXNpUnjfXDf390Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632217; c=relaxed/simple;
	bh=2xJU3EUgB11TjApXEKDFkGt4OKhNVlgD4zewD6ww9+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5FdUVDFunW8mLBREV8mI7fRIA8T0F4nLESaoFQDzoymK95d1L3tsi7fRYU8rfwVpVE3ZNJvWGIDjsIWx6oxXQ1mD2vk5zkM87k96cUFGqpLVp4+R5sSKiWg/Mc4EWKMEsBlWJ1OZ1vJSFZwhyXeHdbBNdOCc9h00pexEQUWPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO/AHq1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO/AHq1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C3B1F00A3A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781632216;
	bh=FHLPq2A00I7+F2DKrTZbIwi3ct5dQL+1sBagexb2s6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FO/AHq1K/S4Daz2UzMJV1NzqG38zu2qm9anluL9YSYqNXIteUXKbK4ix9+GBRKspU
	 yQQxgDrK6kTgr5qAIYkTjStRlIzVDw0tjFrxD109pMrOLqwwAiHioHRf0mIHDkz4Li
	 m3TVYrh9hOklsTYn7JBQFynjfNui/tFeFWb/fv57QKwH7DSrMzMsrf3MOUMImuCOWy
	 KEvayLmPXQh4Hsmz2D1a1RYeZotI4XHKLBj5g/jw57z8sGK1/4enc8cvtyTPtwqjC7
	 qJq49jK35Vy7BC1TL7hwTKNIReX4D+4+1HXbzMHd/kc5F4oQegTL6oNT2GsWQay3y8
	 sopG+V2huz7vA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bebac79fff8so606661266b.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:50:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyrPih3Up5BHGQd+GhS5k93D43r8/mO7SnFxSJqz2f2zVn040Eu
	1KnD2u+Dnidp253xAASqFNeDbVQQlY+7fkYORhez2g2Mj1NUM0v7CXtzaKOyzRjxlN8dNWGag41
	iWiKGo1muqRGy9hL76eef4NEkwPecWHE=
X-Received: by 2002:a17:907:1dd5:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c05a4916759mr33745466b.5.1781632215257; Tue, 16 Jun 2026
 10:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-9-yosry@kernel.org> <20260616010604.ACC021F000E9@smtp.kernel.org>
In-Reply-To: <20260616010604.ACC021F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 10:50:02 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNx4=dq=SBMcNwWzedVR4UGgarg=_pfmPT1DWb1MzC2CA@mail.gmail.com>
X-Gm-Features: AVVi8CfyvLtwlh7WPXuubljN1gObNsZtFo58f4bG51EgOSaM750oePrajF28m4s
Message-ID: <CAO9r8zNx4=dq=SBMcNwWzedVR4UGgarg=_pfmPT1DWb1MzC2CA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/25] KVM: SEV: Stop using per-vCPU ASID for SEV VMs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 6:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] A malicious SEV guest or an unprivileged host-userspace process =
can trigger a host WARN_ON_ONCE by executing VMRUN (entering nested virtual=
ization) or via KVM_SET_NESTED_STATE.
> --
>
> commit c3ac1dbd3331e2991b6bd808b207ce3395a73130
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: SEV: Stop using per-vCPU ASID for SEV VMs
>
> This commit updates KVM to initialize the SEV VM ASID once in
> sev_init_vmcb() instead of checking and setting it on every vCPU run. It
> replaces the run-time assignment check in pre_sev_run() with a warning.
>
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -3555,10 +3555,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
> >       if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
> >               cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus)=
;
> >
> > -     /* Assign the asid allocated with this SEV guest */
> > -     svm->asid =3D asid;
> > -
> > -     if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> > +     if (WARN_ON_ONCE(asid !=3D svm->vmcb->control.asid)) {
>
> [Severity: High]
> Can a malicious SEV guest or an unprivileged host-userspace process trigg=
er
> this warning by entering nested virtualization or via KVM_SET_NESTED_STAT=
E?
>
> KVM does not strictly prohibit userspace from exposing CPUID.SVM to an SE=
V
> guest. If an SEV guest sets EFER.SVME and executes VMRUN, KVM intercepts =
it
> and handles the nested transition via nested_svm_vmrun(), which switches =
the
> active VMCB pointer to the nested vmcb02.
>
> The nested vmcb02 does not inherit the SEV ASID assignment from
> sev_init_vmcb(), and its control.asid is initialized separately. During t=
he
> subsequent svm_vcpu_run() -> pre_sev_run() call, the VM's valid SEV ASID =
will
> no longer match the nested vmcb02's ASID, causing this warning to trigger=
.

Hmm I looked around the code and I can't see what prevents SEV guests
from setting EFER_SVME or using KVM_SET_NESTED_STATE. However, I think
a VMRUN from an SEV VM will fail, at least due to not being able to
read the vmcb12 from guest memory?

That being said, I can drop this stopgap if preferred, I was going to
drop it before sending but I left it in just to be cautious.

>
> Since this condition is guest-reachable and controllable by userspace, do=
es
> this create a host denial of service vector when panic_on_warn is set?
>
> >               svm->vmcb->control.asid =3D asid;
> >               vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.14=
35766-1-yosry@kernel.org?part=3D8
