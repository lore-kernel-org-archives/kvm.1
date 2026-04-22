Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EE2AE8D
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817820; cv=none; b=PvRMDe8brNErMltsRzVOQUs2tVL0dyrKbuh6QGXwsaG1666Rtq7eWsf1u3QBtdBeomDRAYMYoTqmnkcUQDfeH36nl5aIceGjsXxhh912E0RrCzux0BznjQ6K1kESNGsGdkyqBmP0xZPkD7svmx3tdilX/SfA9ovd+uy2DqKdLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817820; c=relaxed/simple;
	bh=7Y5ImozDqW6OD5xyIG/QojfYLFWuRs82Cror1puL9jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVcO4G/6dPu8dn0DeBFLTW03FDtcF5QnZkbrCGTVfBL7h4tVJAXOFmFXAR8o2r0XFoLrKN+gqGcITS5GKCSYp3rCghgK88R+gVge5YNGztEiUq3oYM4WCU8bz++67KXwOnKsWykOgM1JcEYMisePqcF+ZIWKmSF+QNW7by37Pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atz3fOO8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atz3fOO8"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f460260cfso5051656b3a.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776817818; x=1777422618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLhc5GqYQh8ZQDuPNfNQLpnp46keTtwROBUIsbV99co=;
        b=atz3fOO8fTFUnQO4mD13arC7H8JEK4krmN9zhABYN//IZYgBPcJvd9XjiVYWy/WhDx
         HlRx7xDGezBPOq9sE1zjU1aREsIrHsCOmTQRBDtxw+QiXe2MFd/UB1A4oE8CXnzCov3K
         Obe9PPFaPJ3YZ3Eh0/ehrXLNd49LMz6VqUUz+YCafjWh8ssbuHDjY1/siTm4W2kzAecW
         M916ehEanlzq4he6x5mzrWwrOfsUIafa+7c4YPDE7w1Ya+cIPxvbEFDmcj84gNIHiyx7
         Qvy66+jqehooKd84YLK8J0/GigBQzpCRaaZmahDBHnTiayae4sv+BYyOKEmcJwcz1g7h
         ICyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817818; x=1777422618;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gLhc5GqYQh8ZQDuPNfNQLpnp46keTtwROBUIsbV99co=;
        b=ajksO5Klc3LTPHnZThWJgYU/L9Rn/PEftQflT8m1h748GDL5FrFXL40MYFDxBs0c0p
         TSO/NPMRFTpE92Vd8a0jySNXsjHvZmg/hDKkFL0eX8szHAWLFCZ42LolXgRq/HhN8TIP
         4DRuggCndkSvQHMg0XqTxswxAw/1jWOckfsT/faDf7Cuklw3HR+cWp/D1wvJLRG8g0+N
         zEbHCmVqb+KjsXLg6mGdAOqN7yppMFFK+Gm5P4bkTQ6sroJnqI28flmxnXEyrgIgG6ZF
         1rH6tXUTdej17ysUyOFS1e/KPmSMmfnHkrMliofqVxhuMzdClsr5UjKT+mRU2hOgTB55
         uscQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Dlh0rxHm0c6QI6NoTLnEUHrzIaDZ8ApmaX/ZfJ4kvFuAg9sCdQR8sWqwQ/RU3saf3QD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoSrUIck0WdZfzrIzPk/0wbN8p8ZvwJiOA3rVmnNssF4zD4xX
	f4XK5zksPea12HeBKaVemKXhuyevks+N8mATc4UFd6fvkm8supNSHkKRtf3hrK7LSx12+fyXnM4
	wMCffsQ==
X-Received: from pfbg11.prod.google.com ([2002:a05:6a00:ae0b:b0:82b:928a:17cd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88d3:0:b0:82c:eafa:8863
 with SMTP id d2e1a72fcca58-82f8c9501a8mr20046065b3a.49.1776817817958; Tue, 21
 Apr 2026 17:30:17 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:30:16 -0700
In-Reply-To: <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com> <aeeS7LDPJ6NCy3Uw@google.com> <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
Message-ID: <aegWmKk8uK5r10dM@google.com>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "nikunj@amd.com" <nikunj@amd.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, Kai Huang wrote:
> On Tue, 2026-04-21 at 08:08 -0700, Sean Christopherson wrote:
> > > =C2=A0=C2=A0 vCPU Reset:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 vcpu_enter_guest()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80> kvm_check_re=
quest(KVM_REQ_EVENT)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80> kvm_apic_acc=
ept_events()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=C2=
=A0 =E2=94=94=E2=94=80> kvm_vcpu_reset(..., true)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80> init_vmcb(..., =
true)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =E2=94=94=E2=94=80> control->pml_index =3D PML_HEAD_INDEX -- PML buffer wa=
s already flushed
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80> kvm_x86_call=
(): Next VMRUN
> > >=20
> > > > Could this result in the hypervisor losing track of dirty memory du=
ring live
> > > > migration, leading to memory corruption on the destination host, si=
nce
> > > > svm_flush_pml_buffer() isn't called before resetting the index?
> > >=20
> > > AFAIU, no. The PML buffer is always flushed opportunistically at ever=
y VM exit.
> >=20
> > Huh.=C2=A0 There's a pre-existing bug here.=C2=A0 Commit f7f39c50edb9 (=
"KVM: x86: Exit to
> > userspace if fastpath triggers one on instruction skip") added a path t=
hat skips
> > kvm_x86_ops.handle_exit(), and specifically can give userspace control =
without
> > going through vmx_flush_pml_buffer():
> >=20
> > 	if (unlikely(exit_fastpath =3D=3D EXIT_FASTPATH_EXIT_USERSPACE))
> > 		return 0;
> >=20
> > 	r =3D kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
> >=20
> > Given that SVM support for PML is (obviously) on its way, it's mildly t=
empting
> > to add a dedicated kvm_x86_ops hook to flush the buffer on a fastpath u=
serspace
> > exit.=C2=A0 But, I dislike one-off kvm_x86_ops hooks, and that only wor=
ks if there's
> > no other vendor action required.=C2=A0 E.g. very theoretically, a fastp=
ath userspace
> > exit could also be coincident with bus_lock_detected.
>=20
> Seems vmx_vcpu_reset() doesn't reset PML index upon INIT event, which see=
ms
> to be fine since we are not losing any dirty GPA tracking AFAICT (otherwi=
se
> we already have a bug for VMX here)?
>=20
> How about doing the same for SVM?

We don't really have that luxury.  On SHUTDOWN (even intercepted SHUTDOWN),=
 the
state of the VMCB is technically undefined.  I.e. KVM needs to write _somet=
hing_.

Hmm, actually, how is that going to work?  Dropping PML entries just becaus=
e a
vCPU hit SHUTDOWN isn't going to fly.  E.g. if a VM crashes while it's bein=
g
migrated by the host, then it could end up with corrupted, incoherent data =
on
the target due to leaving dirtied pages behind.

> Alternatively, we can always manually flush PML buffer upon INIT before
> resetting PML index.  This still allows to do the
> EXIT_FASTPATH_EXIT_USERSPACE check in the common code.
>=20
> Not sure which way is better, though.
