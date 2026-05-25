Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359913385A1
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706727; cv=none; b=FwQLT8hgn+CSxPKYAEvYGiS/Y1Z8y6tiAcpv1DQ2zi654FSrNSf6LsAiaXtKugXWKVrBOXEPkh8WRQQ9QmNgMepC/JujZBHyxGv2O4VUXdMteQSiJllkP4Qde1ibJuvDcDhsqk0j10JEs2lXRrjIYEcyeA1G9zygCGtU7HJZi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706727; c=relaxed/simple;
	bh=sdq1rPfhdz7Wx/oS04l1wxjewm56om68cE5RDy1jSyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KttxO5gO3YVbHBKninitYUsf2ex2IaURXue+zpiZ4vIhJME9SdmKEeYVgV5/N5NzAvaBeYJoc9OuaD9xEfS8SbH1e2JaI9+BXiNjOTeM9sBS/UyJwU1kqJI8ZK3NmOikkTUWRGFh3g55IOxGcqK6YZ358MbLHNcikfNpSDPPAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfc+29n5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfc+29n5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCDA1F000E9;
	Mon, 25 May 2026 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779706725;
	bh=9ZAAZwve9Ja8/vUWezZF2l+h4GkMLm44oQ5YCs/nkv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfc+29n5VgYp4d6D64oYI9xjtIWNo9XENrMHJ81FIVbYgZ5yaEX5E8w7VBwTLWFH/
	 VzJof4CPNhB5UeUNdoFJhXTrSBP9b1GsI1BLjIQlUu3OoUH1ZhAFqSTpkvIep8zBLE
	 VFIrxQGIrpUkrRhl9AB/m0c8ysaMLm+3FloJ/u4Px3gvgaH++Z+aRYrBd8SttnIzmS
	 dpayv8C0NFS8iz7RJx8rYbhr5nxnkRLpcPFZ48AQgGEQ5my3/epkZpIIwt9ElIIYw2
	 mXQ6SwvhYUkzQQXmji8ZOQaXjmpwSAOW9wyqp2E/wqxHYUR19cdeIYcuLYSVeh69lT
	 59zNr+r8w6YuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] RISC-V: KVM: AIA: Make HGEI number management
 fully per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525094945.3721783-3-anup.patel@oss.qualcomm.com>
References: <20260525094945.3721783-3-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 10:58:45 +0000
Message-Id: <20260525105845.9FCDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but a Use-After-=
Free vulnerability exists in `kvm_riscv_aia_disable()` during concurrent VM=
 destruction and CPU offline.
--

commit b20fb1dd06460a83c6a2cbe4fe6445306d7467e2
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

This commit introduces a per-CPU field for the number of Hypervisor Guest
External Interrupt (HGEI) lines, replacing a single global variable. It
updates allocation, freeing, and disabling paths to use the probed
per-CPU values. The global value is retained to represent the minimum
number of HGEI lines across all HARTs.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288555d..bafb009c5ce55 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
[ ... ]
> @@ -588,7 +617,7 @@ void kvm_riscv_aia_disable(void)
> =20
>  	raw_spin_lock_irqsave(&hgctrl->lock, flags);
> =20
> -	for (i =3D 0; i <=3D kvm_riscv_aia_nr_hgei; i++) {
> +	for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
>  		vcpu =3D hgctrl->owners[i];
>  		if (!vcpu)
>  			continue;

[Severity: Critical]
This is a pre-existing issue, but could this lead to a use-after-free
during concurrent VM destruction and CPU offline?

Looking at kvm_riscv_aia_disable(), the code reads the vcpu pointer and
temporarily drops the lock before using it:

    vcpu =3D hgctrl->owners[i];
    if (!vcpu)
        continue;

    raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
    kvm_riscv_vcpu_aia_imsic_release(vcpu);

If CPU hotplug runs concurrently with VM teardown:

CPU1 (CPU offline)
kvm_riscv_aia_disable()
    vcpu =3D hgctrl->owners[i];
    raw_spin_unlock_irqrestore(&hgctrl->lock, flags);

CPU2 (VM teardown)
kvm_destroy_vm()
    kvm_vcpu_destroy()
        kvm_riscv_vcpu_aia_deinit()
            imsic_vsfile_cleanup()
                kvm_riscv_aia_free_hgei()
                    // acquires hgctrl->lock, clears the owners slot
        kmem_cache_free(vcpu)

CPU1 (CPU offline resumes)
kvm_riscv_aia_disable()
    kvm_riscv_vcpu_aia_imsic_release(vcpu); // dereferences freed vcpu

Since kvm_vcpu_destroy() does not use RCU for reclamation and no reference
counts are held for the vcpu while the lock is dropped, the memory appears
to be freed immediately.

Is there a mechanism preventing this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525094945.3721=
783-1-anup.patel@oss.qualcomm.com?part=3D2
