Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240635B63B
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131976; cv=none; b=Omt64j9q2dO9IvH/EE6KBRRObD/yRet0KSu6PgvFPeqtat7ffB82Py5vgLtKPR47XR5IqxaWZbwneeyTdB4HDrq6OQkXGq9D1+ystaJVMKyeV8mV6burT1gakZFz4e5PAhpAV5ib40LRWJLLBq3O5MQn8wgViSczSZZZZux/eOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131976; c=relaxed/simple;
	bh=4BcLJyUbU0YdriyPLIGWImrxx7mS7A+R/BMVlGk8ZXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqTEZaVe+/KfQVPorAMjHi0/zE1eqnQEbM+Qv//uJK72pU+FwVc7fDM4DmpC0aCZEHEIzYIgJKTe/FOSTEkesBW+vdMaLioBuGYE/J0lPtuuTDJxKlKxiHGKYUaLvoQxfMyko8ovKuiMuMdHc60Sgcjvh7NI+TxPofC1ZhZjJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijKR5fe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijKR5fe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C676C1F00893;
	Sat, 30 May 2026 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131975;
	bh=bn9vCF5dp6ZR7LZAEtLrqAYQ+jLzNvQFWfrBppUmsOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijKR5fe7SbU/PuhH1UuezFCefWg94wqVXh8XDVbObVbAuqmUTTOt0kBtuRlVYVAxS
	 XRhaaMG6bCklK4kzynycZTwOAdFSHPX2qntAji4slxmytghHlIDKFUvWKbshwwXTXp
	 BrzhZkjVOCjRPHDAkaSquLr30CV7w5UGYS3cEQY1rHaWTZAJVpLMZlpH+H2rr4lj+K
	 /CyNBXANnLa7tndjfB3a7WNLaC9dr9YQejar0Do5V0POgFLNXFFMA50nmfHhMK8PEq
	 tIaYULsvNdkLJaTmQpHuizi4vRnCZT0/SY+eyyW+DvWAB/PLKwaaDHoUbu7FS+nfTI
	 7p6/eNImIJQ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/24] KVM: SEV: Unmap and unpin the GHCB as needed on
 vCPU free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-18-pbonzini@redhat.com>
References: <20260529183549.1104619-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 09:06:14 +0000
Message-Id: <20260530090614.C676C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `sev_es_unmap_ghcb` calls sleepable functions (`memunmap`) and per=
forms unsafe guest memory writes while executing in an atomic context.
--

commit b4a31af8d74ea9fb855e6bc78164835ceed7d4bd
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 11d46600cbdc0..6c6a6d663e296 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -3552,6 +3552,20 @@ static int sev_es_validate_vmgexit(struct vcpu_svm=
 *svm)
>  	return 1;
>  }
> =20
> +static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
> +{
> +	if (svm->sev_es.ghcb_sa_free) {
> +		kvfree(svm->sev_es.ghcb_sa);
> +		svm->sev_es.ghcb_sa =3D NULL;
> +		svm->sev_es.ghcb_sa_free =3D false;
> +	}
> +
> +	if (svm->sev_es.ghcb) {
> +		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);

[Severity: High]
This is a pre-existing issue, but does this execution path end up calling
sleepable functions and performing unsafe memory writes while preemption is
disabled?

vcpu_enter_guest() disables preemption before invoking
svm_prepare_switch_to_guest(), establishing an atomic execution context.
That function then calls sev_es_unmap_ghcb() for SEV-ES guests.

If a guest sets its GHCB GPA to an IOMEM region (e.g., an assigned device B=
AR),
kvm_vcpu_map() maps it using memremap(). When __sev_es_unmap_ghcb() later c=
alls
kvm_vcpu_unmap() here, it delegates to memunmap(). Since memunmap() can sle=
ep,
could this trigger a scheduling while atomic bug and allow a guest-triggered
host DoS?

Additionally, just before __sev_es_unmap_ghcb() is called, sev_es_unmap_ghc=
b()
calls kvm_write_guest():

void sev_es_unmap_ghcb(struct vcpu_svm *svm)
{
        ...
        if (svm->sev_es.ghcb_sa_sync) {
                kvm_write_guest(svm->vcpu.kvm, ...);
                ...
        }
        ...
}

If the guest scratch area is swapped out, the page fault handler will abort=
 the
fault due to the atomic context, causing kvm_write_guest() to fail with -EF=
AULT.
Since KVM ignores this return value, could this lead to silent data corrupt=
ion
in the guest, such as missing MMIO read data?

> +		svm->sev_es.ghcb =3D NULL;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D17
