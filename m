Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45706482D4
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791420122; cv=none; b=DguR6he/dh4HoqaIOwck+hPMyVdWrHZDhSimRADfTxe8U95/e1eGMIiDFJSkewHJpGI67iDBIsgoj6kGJUH073nnvljTcQ3wNm+pWvbcHWsYStYZodtrRFw1li06OOrL0bGphIW3dSFR47/qaMZhXyIhAT0eFksFJ4zY3fSEc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791420122; c=relaxed/simple;
	bh=GFDrr5dSGVznz+KRrMa2x0EdrzeORBnxsUjRxPqDZ00=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sVbmhUnIg2FOxh7CPrYPPkp42PBqu/12fN+x04V/BUiI3QoOs4OMve6Yvz7bgvzuXabdB62I/quItMOkHyh/nTGv35NTpIbmV0Hzu6mDTuInPmU5bLONbKUbonBT7p6Zz/CygiKeKqEZGCIFNeSvOVqRyY5SUfJi0M5cHav5eCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWm1Lmnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWm1Lmnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB2F1F000FF;
	Thu,  8 Oct 2026 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791420121;
	bh=MZ2jH3nR9Guy4pwUVkN8fTHH+TBcw9QFofg66xChF6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TWm1LmnrE4wmN4gTRaol0Et6yJk2lqc5gXhwE8sp+QgJDI2lrpoFhELREJ9N9hMrW
	 Etp70LRumWmnEhkBhA4fyH2Ex5DHSFVUQ1venHrL0ut7z+PLlSbSS52dNulrlgIBwQ
	 WIY5uaBQWBkeIqa/WqPv+cPx7e3B4rClBvdBIhm3rafHroZxPlSzFZQZXKHtdshlGy
	 8KFOKV7I8fYaBQIAJQdEjuu+mBrMofRX9ID9ooNAumEGvmH5zu1LHNcoAxS/ibd6K6
	 Ko5J+2UO2MNXXbwXAUdYKUdFotQ+MT3CEmgINS0PXNSf0perDyr7Inw3EiK2Oiu9Lh
	 qDJZqPeQ1Ce8A==
Message-ID: <sashiko-outbox-163478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/29] KVM: nSVM: Add a placeholder ASID for L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-14-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-14-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:42:00 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm/svm: SEV migration leaves vmcb01 without SEV flags if in guest=
 mode
--

commit a990122c49d4a9878fc605ac4ab62f79ce50bdad
Author: Yosry Ahmed <yosry@kernel.org>

KVM: nSVM: Add a placeholder ASID for L2

This commit introduces a placeholder ASID for L2 that is initially the same
as L1's ASID to facilitate future ASID separation. It also updates SEV VM
migration to copy the new SEV ASID into asid02 and vmcb02 if nested is
already initialized on the destination vCPU.

[ ... ]

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 99577859e1aab..b2e6acfbb081f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2041,6 +2041,15 @@ static void sev_vcpu_migrate_asid(struct vcpu_svm =
*dst_svm,
>  	 */
>  	free_asid(dst_svm->asid);
>  	dst_svm->asid =3D asid;
> +
> +	/*
> +	 * If nested is already initialized on the destination vCPU, also update
> +	 * the nested ASID to match the new SEV ASID.
> +	 */
> +	if (dst_svm->nested.vmcb02.ptr) {
> +		dst_svm->nested.asid02 =3D asid;
> +		dst_svm->nested.vmcb02.ptr->control.asid =3D asid;
> +	}
>  }
> =20
>  static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)

[Severity: High]
Does this migration path leave vmcb01 without SEV flags if the destination
vCPU is in guest mode?

During SEV migration, sev_migrate_from() calls sev_init_vmcb() shortly after
sev_vcpu_migrate_asid() updates the ASID:

arch/x86/kvm/svm/sev.c:sev_migrate_from() {
    ...
		sev_vcpu_migrate_asid(dst_svm, dst->asid);
		sev_init_vmcb(dst_svm, false);
    ...
}

If userspace restores nested state before the migration ioctl, the vCPU cou=
ld
be in guest mode with svm->vmcb pointing to vmcb02.

In this scenario, sev_init_vmcb() modifies svm->vmcb, effectively leaving
vmcb01 uninitialized for SEV:

arch/x86/kvm/svm/sev.c:sev_init_vmcb() {
    ...
	svm->vmcb->control.misc_ctl |=3D SVM_MISC_ENABLE_SEV;
	clr_exception_intercept(svm, UD_VECTOR);

	WARN_ON_ONCE(svm->asid !=3D sev_get_asid(vcpu->kvm));
	svm->vmcb->control.asid =3D svm->asid;
    ...
}

When the vCPU exits nested mode, it will run L1 as a normal (non-SEV) guest.
Since KVM still expects an SEV/SEV-ES guest (is_sev_es_guest() is true), KVM
will skip loading guest state but the hardware will execute vmcb01 as a nor=
mal
guest. Can this cause a guest crash or hypervisor confusion (e.g. unexpected
intercepts triggering KVM warnings)?

Should the migration path ensure vmcb01 is updated with the SEV flags and
new ASID regardless of whether the vCPU is currently in nested guest mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D13
