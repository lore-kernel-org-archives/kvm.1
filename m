Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324A1531E8
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854327; cv=none; b=U2MXL8bdRe0p4yGhOrtZyYp12Dt6bE4JrSPy+ePsuw0bVyqPxB0Y4SCSMRk5mi1k/8hGTdnwgqIhy8K5UF02s/wb95Iewn/XDcfwYZAMH+QGSkLOrWqsKuSBNf1l94c2pyQ9RFAAn9+rGeM2U1tJexfAEbAYAnU+gIvC+UOw9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854327; c=relaxed/simple;
	bh=A57K7eanqNW/pnQBas54RY7d9aO35H76WOwvkw1WNlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=brgFuy7d3XgxCeLUz7X6nAB5hBg+bK+RrNNJElb1pCdfOM4akbEjMqTXnmkEx+0u1SfTxZnl5awqUrnEtJhZ5ARMWKvw2czwmK6DaEZ2y+dvjXSGfTDGgz4xz7kWvt3DqT5sYGyPVRcpONomDMVk1lobuwF/vZGFf2QxBrOzstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmezBaSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmezBaSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8201F000E9;
	Tue, 30 Jun 2026 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782854326;
	bh=smQdbm4dtJNh8O3XKgcziJ1vzKg+UYu/kcvjQtehlHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YmezBaSGiIw1Qdn7HYhJehF0ApRLFEunWmqVJtRtnEyk/H4OO3U/1QCLHaXov4UM7
	 xPeR52AdZYC8+KR8ywN+K6cX85QiMI/7l0qWL1O+tP0xQbC6bUwU3Yvhlt9HpfEAVy
	 OtcAmUz+adWufgYh4vLON2GUzFMlgsJP4d+qsaH/ESwcT/cU4Oq2nVJbfgrWepCP91
	 rdlXU0VGOHm2+oH/dUTq6H9m4YPBYoo7qItNWaML11rvJUhBDHGPQ/Jn88N+OuxHVy
	 D9SnoIJT1wRtMFMeIDAIy/mAGNgsMpf7hPL31HrLQOUNIwL0HCNshW9LaLlRddIqN2
	 xA3AGzqMJdoQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] KVM: SVM: Do all per-VM AVIC initialization
 during vCPU precreation phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630210156.457151-3-seanjc@google.com>
References: <20260630210156.457151-1-seanjc@google.com>
 <20260630210156.457151-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 21:18:44 +0000
Message-Id: <20260630211845.8E8201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function prototype `avic_vm_init(struct kvm *kvm)` remains in `=
arch/x86/kvm/svm/svm.h` despite its implementation being removed.
--

commit e515c341adc5a84997456546a40c3f72c03c42b6
Author: Sean Christopherson <seanjc@google.com>

    KVM: SVM: Do all per-VM AVIC initialization during vCPU precreation pha=
se
   =20
    Move all per-VM AVIC initialization from VM creation to vCPU pre-creati=
on,
    i.e. defer allocating the logical ID table and adding the VM to the GA =
Log
    list until vCPUs are created.  This will allow removing the VM from the=
 GA
    Log list before vCPUs are destroyed without needing yet another kvm_x86=
_ops
    hook (.vm_pre_destroy() is very intentionally called if and only if VM
    creation fully succeeds).

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 4a0a2dbd1687f..d71a2fed1a08b 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c

[ ... ]

> @@ -308,47 +308,32 @@ static int avic_alloc_physical_id_table(struct kvm =
*kvm)

[ ... ]

> -int avic_vm_init(struct kvm *kvm)
> +static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
>  {

[Severity: Low]
Does the function prototype for avic_vm_init() in arch/x86/kvm/svm/svm.h al=
so
need to be removed? The declaration appears to still be present even though
the implementation is removed here.

> -	unsigned long flags;
> -	int err =3D -ENOMEM;
>  	struct kvm_svm *kvm_svm =3D to_kvm_svm(kvm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630210156.4571=
51-1-seanjc@google.com?part=3D2
