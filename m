Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56746380FE5
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358453; cv=none; b=ojShjcAolcDWJu/Ib+TPLZhu6AwaXgduV7vyOyUp3s/5RbiUNwQGGphBZvfwHEsQK9XBeHoC19waRdcAPhvTgetkbtsLEUzNrInAsr2F+0IcOTeDoNRAwFG1a7T2+Zmz3N6RxfDF+PZVpBxwT0J51my1EvWP0QEztuI58hMU1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358453; c=relaxed/simple;
	bh=i1C6qlndihuo6RVorEwX36sx+P0rTd6yQlsEtMJImLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BNW1A6gkZ25Yy9CE3mzAM68vgOvMUCZ4jlFgpMehBEBRr9ayXnEa5Z59LTJAcv7Vr52walEnA3mWWSixSGipH74ikKjMP+jqvIVLFBVTkyeXrttyB3Tf7W7pQIbNBzWE9pV+vXyMFHYD2GdX3/XbtQYnn1fpjHionSpOZLu0FM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRBaxnB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRBaxnB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82981F000E9;
	Mon, 10 Aug 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358451;
	bh=tsxPsFJX5evKIhw/S3glrJaAgRUFaIc68fIOhhLiAMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRBaxnB+aXupNkBi6n102I/dVhU2c1eu9CYF181K6XjEmMbXBXYcv0IEJHCFtWfgV
	 1XgHUV/NYemRwEGFHzeC3jl/EE93fd6wKcvbw3saRTXEH/uA9UxyT5TKOsXa/ujmSz
	 YbTbRZDXIBj6P8wp56BTiB26NI/dmstBzhk9pEOBs/w/6qqWsC7wC7zmoRXAkCaQoy
	 6ZGTTEtFlVbDjvmLC+ZdlX3Kl8El9ABC+unN/+f3eirY6JlKTatr8Ko4woUFhJ7eff
	 YQ3dC60VSqW3Nu8tT5PF3qZw/DZrsPeMYB3kuU70Jy8BK44LwKAXmMk0uY2SZAktAE
	 tg/FrwvDijVxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] KVM: SEV: Disallow the use of hardware-switched PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <c88cd7d448c7ff998efae53979624b5b08a045c1.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <c88cd7d448c7ff998efae53979624b5b08a045c1.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:40:51 +0000
Message-Id: <20260810104051.C82981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch correctly disables hardware-switched PMU for newly initi=
alized SEV-ES guests to fix a bug where KVM attempts to interact with PMU s=
tate in the unencrypted VMCB save area instead of the guest's encrypted VMS=
A. However, this fix fails to apply to SEV-ES VMs created via migration or =
mirroring.
--

--- Patch [8]: [PATCH 8/8] KVM: SEV: Disallow the use of hardware-switched =
PMU ---
commit 0e4fd883c1122d7a244f0bb8754669e617c9a34a
Author: Sandipan Das <sandipan.das@amd.com>

KVM: SEV: Disallow the use of hardware-switched PMU

For hardware-switched mediated PMU, the guest PMU state resides in the
VMCB save area. When SEV-ES or SEV-SNP is used, KVM cannot access the
encrypted VMSA, so this patch clears KVM_MEDIATED_PMU_CAP_HW_SWITCHED for
such guests to force software-switched mode.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 944aaea6501f2..c5df6da8d030f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -534,6 +534,9 @@ static int __sev_guest_init(struct kvm *kvm, struct k=
vm_sev_cmd *argp,
>  	if (snp_active)
>  		sev->vmsa_features |=3D SVM_SEV_FEAT_SNP_ACTIVE;
> =20
> +	if (es_active)
> +		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
> +

[Severity: High]
Does this clearing also need to happen when an SEV-ES VM is created via
migration or mirroring?

Looking at sev_migrate_from(), it copies the es_active state to the
destination VM but does not appear to clear the hardware-switched PMU
capability:

arch/x86/kvm/svm/sev.c:sev_migrate_from() {
	...
	dst->es_active =3D src->es_active;
	dst->vmsa_features =3D src->vmsa_features;
	...
}

Similarly, in sev_vm_copy_enc_context_from(), the mirror_sev->es_active flag
is set to true without clearing the PMU capability:

arch/x86/kvm/svm/sev.c:sev_vm_copy_enc_context_from() {
	...
	mirror_sev->es_active =3D source_sev->es_active;
	...
}

Since KVM unconditionally sets KVM_MEDIATED_PMU_CAP_HW_SWITCHED during VM
creation, could failing to clear it on the destination VMs leave the hardwa=
re
PMU feature incorrectly enabled?

If a user migrates or mirrors an SEV-ES VM, might KVM attempt to read/write
PMU state from the unencrypted VMCB save area instead of the guest's
encrypted VMSA, reintroducing the issue this patch aims to fix?

>  	ret =3D sev_asid_new(sev, vm_type);
>  	if (ret)
>  		goto e_no_asid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D8
