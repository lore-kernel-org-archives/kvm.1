Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73452C030E
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784112; cv=none; b=ucUXGJPLqf7Dh4OciMbhHjUJBxFzfhohLEwhHERXz0xDSJguUUhitm0i1yldE7yB3GnPBNRL1Yr6POKuBeMkUA8/VsmzyI88SwF32/DgG1lyH6m5zDGP13fkrOPky/3N0o8Vhoq3QEUgwiHpz7usrh5t7q9R1BZIGoHF2mbcHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784112; c=relaxed/simple;
	bh=MFcd1+QV7DFyCakC+nJoiA0jDRhS8k94rxx1FQOrc1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmqsZeSq5tZibF2lEKbk+Jew/NdHh+y1ANlS2M1U/rpQOPeLiUXHgRWTUc6arf3rxJkXVmPycwP2o+KTdc+7Qpl/ayVi6Jop6Z9Qd1sewtLOPcKrJd1Z6VzSQIZLuxKBMk8Y2O94hCRzexfSO3ial4JeGK8u+vbw+KDZqfuyWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZNiuOZq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZNiuOZq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso2412059b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776784110; x=1777388910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/fLvadU/CHyav5bcbpJnR4cQyR8gwfjFOkr8LTaMcI=;
        b=gZNiuOZq5XXX9zmw3gdAode9HgWbldE1xfNCFqHOH6c5I1VkkGH2liQf+4L+hVbdIm
         iH9kvOt0oEG7v2G8YLQTlkpynTIZl6n6xqWC8KvhuAiw5raNzOpVWUuDnqPtNLFU22zN
         2hN/hMXPkXFldTHPxMtiB/aBCmWHZ3R3YbxKq34X9AhcB4JExJaaJBFexYho4M7DdVTV
         aall2c99cDdwGQT3Q7aQgXvUy/PCxOKjdyrRbasHyN8lWKSSKdCFE7J8kOXl4D0lGpQ9
         w939e02A1T2xkgvKy8aXztIAs8Rr7a/63t11n/CGyozVsQC9mu879sfhU6IvhszOqlVE
         iQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784110; x=1777388910;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/fLvadU/CHyav5bcbpJnR4cQyR8gwfjFOkr8LTaMcI=;
        b=cCME9pi2X9NXgOiKcLpDgzsrrZiWeuDYu/mc3/PT3jEynKfOblpyFJDMjcm582Fd6Z
         h/iRwTyvi12wLzacPLlgywIcDIj3/1v1ULzGSE/TfJ6xpoQfbaaugvR4lVzseTCINrwh
         RTWmPYS2re6SVysio0hjHsFbJwpm+PSD7tL7TORkItJHoIv7cwdgZIDHdoxJghccPOyG
         xv8u/ArkGRC49h6pgP4Zn7xjHO6lDPyd8KVDENNfluYk3WpMNZdep/qoAL3ui3eGoLJl
         3RGO3YAlBOaqB/V83U8ylnIwzlsANyIBwfM7m1NxKS7sfDRvNYZFWvVqc4BW4QN/KQCP
         R8Jw==
X-Gm-Message-State: AOJu0YxzHHOIPyWZ3CBV6GpOd0pIIuYzuYE93EVoWAb95a3+2NAAEq95
	Yg6VevV/Elh5SCocrcb4wfDTNcKE9H3chGyXCx7fCVzyV9WFdOt1ng7bNu7/abwf+tP4HeM7RUP
	jKhL2tQ==
X-Received: from pfad4.prod.google.com ([2002:a05:6a00:284:b0:82f:96ee:b9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1956:b0:82a:17b8:1474
 with SMTP id d2e1a72fcca58-82f8c82dd9cmr19431275b3a.1.1776784109845; Tue, 21
 Apr 2026 08:08:29 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:08:28 -0700
In-Reply-To: <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
Message-ID: <aeeS7LDPJ6NCy3Uw@google.com>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	bp@alien8.de, joao.m.martins@oracle.com, kai.huang@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026, Nikunj A. Dadhania wrote:
> Sashiko reported a couple of issues [1]. Let me address them here:
>=20
> On 4/7/2026 12:02 PM, Nikunj A Dadhania wrote:
> > @@ -1206,6 +1209,16 @@ static void init_vmcb(struct kvm_vcpu *vcpu, boo=
l init_event)
> >  	if (vcpu->kvm->arch.bus_lock_detection_enabled)
> >  		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
> > =20
> > +	if (pml) {
> > +		/*
> > +		 * Populate the page address and index here, PML is enabled
> > +		 * when dirty logging is enabled on the memslot through
> > +		 * svm_update_cpu_dirty_logging()
> > +		 */
> > +		control->pml_addr =3D (u64)__sme_set(page_to_phys(vcpu->arch.pml_pag=
e));
> > +		control->pml_index =3D PML_HEAD_INDEX;
> > +	}
> > +
>=20
> > If the guest receives an INIT IPI and init_vmcb() is called to reset th=
e
> > vCPU, does unconditionally setting pml_index to PML_HEAD_INDEX discard =
any
> > un-flushed dirty GPAs logged by the hardware?
>=20
> There are two scenarios where init_vmcb() is called:
>=20
> 1) During vCPU creation time, where we need to set pml_index to PML_HEAD_=
INDEX
> 2) During vCPU reset, when init_event=3Dtrue

Nit, please just call this INIT, even though KVM calls the function "reset"=
.  #1
is KVM's one and only true RESET flow.

>   Before vCPU reset:
>     vcpu_enter_guest()
>       =E2=94=94=E2=94=80> kvm_x86_call(vcpu_run) [VMRUN]
>       =E2=94=94=E2=94=80> [guest executes, PML accumulates dirty pages]
>       =E2=94=94=E2=94=80> VMEXIT
>       =E2=94=94=E2=94=80> svm_handle_exit() --> PML buffer flushed here
>       =E2=94=94=E2=94=80> return to vcpu_run()
>=20
>   vCPU Reset:
>     vcpu_enter_guest()
>       =E2=94=9C=E2=94=80> kvm_check_request(KVM_REQ_EVENT)
>       =E2=94=9C=E2=94=80> kvm_apic_accept_events()
>       =E2=94=82     =E2=94=94=E2=94=80> kvm_vcpu_reset(..., true)
>       =E2=94=82           =E2=94=94=E2=94=80> init_vmcb(..., true)
>       =E2=94=82                 =E2=94=94=E2=94=80> control->pml_index =
=3D PML_HEAD_INDEX -- PML buffer was already flushed
>       =E2=94=94=E2=94=80> kvm_x86_call(): Next VMRUN
>=20
> > Could this result in the hypervisor losing track of dirty memory during=
 live
> > migration, leading to memory corruption on the destination host, since
> > svm_flush_pml_buffer() isn't called before resetting the index?
>=20
> AFAIU, no. The PML buffer is always flushed opportunistically at every VM=
 exit.

Huh.  There's a pre-existing bug here.  Commit f7f39c50edb9 ("KVM: x86: Exi=
t to
userspace if fastpath triggers one on instruction skip") added a path that =
skips
kvm_x86_ops.handle_exit(), and specifically can give userspace control with=
out
going through vmx_flush_pml_buffer():

	if (unlikely(exit_fastpath =3D=3D EXIT_FASTPATH_EXIT_USERSPACE))
		return 0;

	r =3D kvm_x86_call(handle_exit)(vcpu, exit_fastpath);

Given that SVM support for PML is (obviously) on its way, it's mildly tempt=
ing
to add a dedicated kvm_x86_ops hook to flush the buffer on a fastpath users=
pace
exit.  But, I dislike one-off kvm_x86_ops hooks, and that only works if the=
re's
no other vendor action required.  E.g. very theoretically, a fastpath users=
pace
exit could also be coincident with bus_lock_detected.

Yikes!  And I think userspace could see a stale CR0 and/or CR3 on AMD.  Hmm=
, but
waiting until the full exit path to grab CR0 and CR3 is flawed on its own, =
e.g.
it's a bug waiting to happen if KVM consumes CR3 in the fastpath.

So over two patches, I think the fix for those issues is the below.  I'll t=
est
and send a mini-series.  I don't think there's anything you need to do; I c=
an
resolve the resulting conflict easy enough.

diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..df0bd132edf7 100644
--- arch/x86/kvm/svm/svm.c
+++ arch/x86/kvm/svm/svm.c
@@ -3644,13 +3644,8 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fa=
stpath_t exit_fastpath)
        struct vcpu_svm *svm =3D to_svm(vcpu);
        struct kvm_run *kvm_run =3D vcpu->run;
=20
-       /* SEV-ES guests must use the CR write traps to track CR registers.=
 */
-       if (!is_sev_es_guest(vcpu)) {
-               if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
-                       vcpu->arch.cr0 =3D svm->vmcb->save.cr0;
-               if (npt_enabled)
-                       vcpu->arch.cr3 =3D svm->vmcb->save.cr3;
-       }
+       if (unlikely(exit_fastpath =3D=3D EXIT_FASTPATH_EXIT_USERSPACE))
+               return 0;
=20
        if (is_guest_mode(vcpu)) {
                int vmexit;
@@ -4502,11 +4497,17 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kv=
m_vcpu *vcpu, u64 run_flags)
        if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
                x86_spec_ctrl_restore_host(svm->virt_spec_ctrl);
=20
+       /* SEV-ES guests must use the CR write traps to track CR registers.=
 */
        if (!is_sev_es_guest(vcpu)) {
                vcpu->arch.cr2 =3D svm->vmcb->save.cr2;
                vcpu->arch.regs[VCPU_REGS_RAX] =3D svm->vmcb->save.rax;
                vcpu->arch.regs[VCPU_REGS_RSP] =3D svm->vmcb->save.rsp;
                vcpu->arch.regs[VCPU_REGS_RIP] =3D svm->vmcb->save.rip;
+
+               if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
+                       vcpu->arch.cr0 =3D svm->vmcb->save.cr0;
+               if (npt_enabled)
+                       vcpu->arch.cr3 =3D svm->vmcb->save.cr3;
        }
        vcpu->arch.regs_dirty =3D 0;
=20
diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..4cb355ecfe46 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -6687,6 +6687,9 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, f=
astpath_t exit_fastpath)
        if (enable_pml && !is_guest_mode(vcpu))
                vmx_flush_pml_buffer(vcpu);
=20
+       if (unlikely(exit_fastpath =3D=3D EXIT_FASTPATH_EXIT_USERSPACE))
+               return 0;
+
        /*
         * KVM should never reach this point with a pending nested VM-Enter=
.
         * More specifically, short-circuiting VM-Entry to emulate L2 due t=
o
diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 0a1b63c63d1a..9ad7ec3bf0f1 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -11602,9 +11602,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
        if (vcpu->arch.apic_attention)
                kvm_lapic_sync_from_vapic(vcpu);
=20
-       if (unlikely(exit_fastpath =3D=3D EXIT_FASTPATH_EXIT_USERSPACE))
-               return 0;
-
        r =3D kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
        return r;
