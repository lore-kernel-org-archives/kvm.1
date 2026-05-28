Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79A2F5A29
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012312; cv=none; b=WmQx60N+0X+/VBivT/lPcHniui1m/dsdKSIn3HAy0JrIXQgAuCuk6yumih40H9I7lnbaBC3ixm78RGy7W7DjjCmLRizMS4FkTq9j3GsyEg6dSrODxcz/kjh1yKTmo85JL1ERRY6raKPHKeMYxYjAVzktIoWNYrjODxjvO6TizCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012312; c=relaxed/simple;
	bh=rHM4wAfvg9nYKQCxTqGwVLmr8j9+EdQrN7oloye8GXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AKtCKChGbZfF3lOgXefmAAdq8NQ3uxxT/nT1blwYlFz4wOXC0M0CxIg7qVGMzN41zek5MatLyYtQ40w4iS7vTLfbidjz6EsrFh/zGxrM9YhZQz8MvQMwxgZao4/Frg+HswJBgYo9hLwJWORkMGVO1QT939Ype8Bu3DvmOWwaMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbbM1cQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbbM1cQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E59E1F000E9;
	Thu, 28 May 2026 23:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012311;
	bh=nOWZEUYWzbl2T/PjZbv31YBIwn/SFgCZXjmGgukO4go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbbM1cQE1GNdE9r4LquzED97U+lNQBhXWSpBbb0uhrspuqrZXI52DpjszrcMgkq0q
	 mRJc+7TlWnjOP+0htgFD4nH17BHV0wWahUD4WiemS0Z+jSj1nfGrmbjadBEretAWbP
	 j1CLpnwpJ9jXW/F81mQghx3RiJArG/rx3GKVPjn/fQmoVcM/zu9RJZlsxH09Ln9grn
	 Mi7VLz0SgkXm3BiMcuG8yQcFb/qTkYDLcbBj60p+DHtNsOzBgfa4Bzzcewl3RdlQiH
	 bMcPhVex2WY8RxaJK6NHSmrKTVKuwr5fSC0f3Jl7znsnm+sr24vBe+scXkETXCalbc
	 xHAkDqxrrXIww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: SEV: Do not allow SEV-SNP VMs from intra-host
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528-sev_snp_fixes-v1-1-d67a08151779@meta.com>
References: <20260528-sev_snp_fixes-v1-1-d67a08151779@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 23:51:51 +0000
Message-Id: <20260528235151.9E59E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete protection against SEV-SNP VM state duplication in `sev=
_vm_copy_enc_context_from`.
--

commit 6c07753da8cad5a8ac0223da06cf2b84411e6fbf
Author: Atish Patra <atishp@meta.com>

    KVM: SEV: Do not allow SEV-SNP VMs from intra-host migration
   =20
    The intra-host migration feature is not fully implemented for SEV-SNP
    VMs which require additional SNP-specific state such as guest_req_mutex,
    guest_req_buf, and guest_resp_buf to be transferred or initialized on
    the destination.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c2126b3c30724..aff6a0cf5bfe8 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, u=
nsigned int source_fd)
>  		return ret;
> =20
>  	if (kvm->arch.vm_type !=3D source_kvm->arch.vm_type ||
> -	    sev_guest(kvm) || !sev_guest(source_kvm)) {
> +	    sev_guest(kvm) || !sev_guest(source_kvm) ||
> +	    sev_snp_guest(source_kvm)) {

[Severity: High]
This isn't a bug introduced by this patch, but does
sev_vm_copy_enc_context_from() also need a similar check to block SEV-SNP
VMs from VM mirroring?

If userspace creates a mirror of an SNP VM, sev_vm_copy_enc_context_from()
copies its encryption context but fails to copy vmsa_features:

arch/x86/kvm/svm/sev.c:sev_vm_copy_enc_context_from() {
    ...
    mirror_sev->enc_context_owner =3D source_kvm;
    mirror_sev->active =3D true;
    mirror_sev->asid =3D source_sev->asid;
    mirror_sev->fd =3D source_sev->fd;
    mirror_sev->es_active =3D source_sev->es_active;
    mirror_sev->need_init =3D false;
    mirror_sev->handle =3D source_sev->handle;
    ...
}

Because the mirror's vmsa_features is zero, KVM treats the mirror VM as a
standard SEV-ES VM (since ____sev_snp_guest() will evaluate to false).

When vCPUs are created for the mirror VM, KVM allocates standard SEV-ES
VMSAs and fails to perform SNP-specific initialization, such as registering
the VMSA pages in the RMP via SEV_CMD_SNP_LAUNCH_UPDATE.

When KVM executes VMRUN for the mirror VM's vCPU, the hardware evaluates an
ASID bound to SNP execution using an invalid, non-RMP-registered VMSA page.
Will this trigger an RMP #NPF (Nested Page Fault) on the host hypervisor,
leading to an unhandled hypervisor crash and denial of service?

>  		ret =3D -EINVAL;
>  		goto out_unlock;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-sev_snp_fi=
xes-v1-0-d67a08151779@meta.com?part=3D1
