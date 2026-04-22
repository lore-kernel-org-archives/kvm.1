Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DC38839F
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864031; cv=none; b=a8k2xwY2vHt5nH/hL7n8yE+CvioO2dFt0V9zM9wh56Dc/mQy1iLXNaYmF6XOixGlJ7UQv6lm/7ba/q37dfACyVD8E1iTeSc7+iX/KDdOry6D0obSK3crbgdo0p1wdNR+3mkgh26wl0sx2J9bQNU/QQPwV1XjYsaygsKsMZ5FQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864031; c=relaxed/simple;
	bh=dwNvp5cQjxN93kZejq/HnytKRM27fh9VyrplqWAuk6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ClXdPTwBvTpbKs+XtIxiiWwu85C6eYGv4b7T/B9Yi8KcRbcZhMYi+B2qD/1OhKQBBWzFLoSErTsmCyxLGnvdM+DHXB75f4QYM/oupgfaPZ9+AzTZDi3q8RiyXgzCZ0I+fgh0TesFOLJryo8dvx1X8IZkaIuShbDHdWMjEPh3hYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KcuGj6LJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KcuGj6LJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso8149706a12.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776864029; x=1777468829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crXZqqSbgnbrPuRYPg8OgLKGvN1wrTiGY8ceEWHehu8=;
        b=KcuGj6LJzY0l3WEJu4EcIQCfrY1xyItzY2lfoSfXqLfyPXiZufdC84bp8rFgWxXxXJ
         Wo8Z0peJG8MxZBAGv/z0bYa8nNkAhbwXjulQ16L64G7+yH5yclmD8W+FFsc0QSHo33ZY
         4TDrr+7V71I0gZg3Y/SzWO848NxwgKEFIQQosHhasI6jvuw9ZsKunwGOzDWdPms3/ykm
         e7gcVd3N0Pdw/k7+2JVD/dBS06jG/9C2IBYRMHLqRDJ+z2KTjmKDzck+Nskz6MmbolKq
         b0p0VB0J3XtBKLO9iVqw/jINYDjEcfn3gvUewC7cWg9JrmVLvSLqtquy0gMDVajXUC0I
         VKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864029; x=1777468829;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=crXZqqSbgnbrPuRYPg8OgLKGvN1wrTiGY8ceEWHehu8=;
        b=dkB9hN/XCUr4tRWHVVvpxYBK8rZmB5NppAKvRlVpv0x0cC/PlCTHpAUsy8vdp/YX8l
         R9BYO6LRTY6bsRoFEEFWk+/ncBPpxZ9DNK6g6hI9QEm28nxM2y/Ib2/u1gA/GCysmbq2
         O/CPft1YKQV8WqXe6XemWLqVwCsHDzPbp4TTub/qzROgxEv9vYeKYbGliJ5eqK91rnZT
         x9/F7ttpoZNkt2YOFfH8Z834kGPALsZ+7fZt6yruDdOFdDvjDL0geELirWoXMrQS8txT
         RSy/9wnuRuGTyo8jCs5hWe4FvGpW+fZniVToGERe2AtevTFDA+AARxWs6Xi1XDpDpn59
         3tig==
X-Forwarded-Encrypted: i=1; AFNElJ8rTOUJyM55p53nsrnfRFjkIhl8iwTU6iub9ACKiTOZoKndXM/LQHXjUq1Dv5RbOQNbRp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynx/C9io9bDBF2qYV25I0lR71+KFjfbBw+qOiIEiWk7lfSbR5x
	MgQFNYmJXUPfPr/ql+pIW9RuFZTKfGz62OhzEJqDj1Z+gF57r67gUs4UTPncww2NmNPn7swStIg
	8a4u35g==
X-Received: from pfud7.prod.google.com ([2002:a05:6a00:10c7:b0:82f:2efd:4158])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4085:b0:827:3946:a23c
 with SMTP id d2e1a72fcca58-82f8c830793mr23688860b3a.10.1776864029054; Wed, 22
 Apr 2026 06:20:29 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:20:27 -0700
In-Reply-To: <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com> <aeeS7LDPJ6NCy3Uw@google.com>
 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
 <aegWmKk8uK5r10dM@google.com> <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
Message-ID: <aejLG_w8H16EifMj@google.com>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026, Kai Huang wrote:
> On Tue, 2026-04-21 at 17:30 -0700, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Kai Huang wrote:
> > > On Tue, 2026-04-21 at 08:08 -0700, Sean Christopherson wrote:
> > > > > =C2=A0=C2=A0 vCPU Reset:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 vcpu_enter_guest()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80> kvm_chec=
k_request(KVM_REQ_EVENT)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80> kvm_apic=
_accept_events()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=
=C2=A0 =E2=94=94=E2=94=80> kvm_vcpu_reset(..., true)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80> init_vmcb(..=
., true)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =E2=94=94=E2=94=80> control->pml_index =3D PML_HEAD_INDEX -- PML buffer=
 was already flushed
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80> kvm_x86_=
call(): Next VMRUN
> > > > >=20
> > > > > > Could this result in the hypervisor losing track of dirty memor=
y during live
> > > > > > migration, leading to memory corruption on the destination host=
, since
> > > > > > svm_flush_pml_buffer() isn't called before resetting the index?
> > > > >=20
> > > > > AFAIU, no. The PML buffer is always flushed opportunistically at =
every VM exit.
> > > >=20
> > > > Huh.=C2=A0 There's a pre-existing bug here.=C2=A0 Commit f7f39c50ed=
b9 ("KVM: x86: Exit to
> > > > userspace if fastpath triggers one on instruction skip") added a pa=
th that skips
> > > > kvm_x86_ops.handle_exit(), and specifically can give userspace cont=
rol without
> > > > going through vmx_flush_pml_buffer():
> > > >=20
> > > > 	if (unlikely(exit_fastpath =3D=3D EXIT_FASTPATH_EXIT_USERSPACE))
> > > > 		return 0;
> > > >=20
> > > > 	r =3D kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
> > > >=20
> > > > Given that SVM support for PML is (obviously) on its way, it's mild=
ly tempting
> > > > to add a dedicated kvm_x86_ops hook to flush the buffer on a fastpa=
th userspace
> > > > exit.=C2=A0 But, I dislike one-off kvm_x86_ops hooks, and that only=
 works if there's
> > > > no other vendor action required.=C2=A0 E.g. very theoretically, a f=
astpath userspace
> > > > exit could also be coincident with bus_lock_detected.
> > >=20
> > > Seems vmx_vcpu_reset() doesn't reset PML index upon INIT event, which=
 seems
> > > to be fine since we are not losing any dirty GPA tracking AFAICT (oth=
erwise
> > > we already have a bug for VMX here)?
> > >=20
> > > How about doing the same for SVM?
> >=20
> > We don't really have that luxury.  On SHUTDOWN (even intercepted SHUTDO=
WN), the
> > state of the VMCB is technically undefined.  I.e. KVM needs to write _s=
omething_.
>=20
> You mean KVM needs to reset VMCB to reflect the architecturally defined I=
NIT
> state for a vCPU?  Or the hardware itself may reset VMCB thus may reset P=
ML
> index?

Neither.  The APM states that the VMCB is undefined after SHUTDOWN.   PML i=
ndex
could be anything:

  15.14.3 Shutdown Intercept
  When this intercept occurs, any condition that normally causes a shutdown=
 causes a #VMEXIT to the
  VMM instead. After an intercepted shutdown, the state saved in the VMCB i=
s undefined.

KVM synthesizes an INIT because it's the least awful option.

  static int shutdown_interception(struct kvm_vcpu *vcpu)
  {
	struct kvm_run *kvm_run =3D vcpu->run;
	struct vcpu_svm *svm =3D to_svm(vcpu);


	/*
	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
	 * the VMCB in a known good state.  Unfortuately, KVM doesn't have
	 * KVM_MP_STATE_SHUTDOWN and can't add it without potentially breaking
	 * userspace.  At a platform view, INIT is acceptable behavior as
	 * there exist bare metal platforms that automatically INIT the CPU
	 * in response to shutdown.
	 *
	 * The VM save area for SEV-ES guests has already been encrypted so it
	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
	 */
	if (!is_sev_es_guest(vcpu)) {
		clear_page(svm->vmcb);
#ifdef CONFIG_KVM_SMM
		if (is_smm(vcpu))
			kvm_smm_changed(vcpu, false);
#endif
		kvm_vcpu_reset(vcpu, true);
	}

	kvm_run->exit_reason =3D KVM_EXIT_SHUTDOWN;
	return 0;
  }

Now, maybe the APM is trying to say only the save area is undefined, in whi=
ch
case PML Index is fine and can and should be left alone.  But if that's the=
 case,
the APM needs to be updated to make explicitly clear what fields in the VMC=
S are
and are not valid after SHUTDOWN.

> > Hmm, actually, how is that going to work?  Dropping PML entries just be=
cause a
> > vCPU hit SHUTDOWN isn't going to fly. =C2=A0
> >=20
>=20
> Not dropping, but just leave PML index unchanged.  The PML buffer itself =
is
> still there unchanged, and PML is still working in hardware thus the buff=
er
> will eventually get flushed.

As above, the PML index could be garbage.

> This is the case for VMX AFAICT, thus I wonder whether this also works fo=
r
> SVM.

No, VMX is fine.

> > E.g. if a VM crashes while it's being
> > migrated by the host, then it could end up with corrupted, incoherent d=
ata on
> > the target due to leaving dirtied pages behind.
>=20
> If we leave PML index unchanged upon INIT as mentioned above, I don't thi=
nk
> we will lose any dirty GPA tracking.  But maybe I am missing something.

Correct.  The question is whether or not AMD's architecture guarantees PML =
Index
will be valid/accurate after SHUTDOWN.

