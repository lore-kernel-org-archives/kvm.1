Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DD348C46
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087793; cv=none; b=u8hT6feTPxs62+sRAukaOnFatHBHpgRdfCyrjDvdvLQwLvQxMDGlvpyjdMqwVHRC3et/69dfji+OxRTTc3HcTPwBwQJUaECFbCcMGNqmo03O6qQGFtx113RN9ERYHaIOK9ZBLYNkLgSb4knFRiLbaUPmPW5v671vtRP65pVFDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087793; c=relaxed/simple;
	bh=liJBUIVRHY8hU0t+EVOsm3ZF7Q/U1wd/I4p0mf1PnBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKtLztDqNZmoHAPfEVpxBLGoPK/DAeIhlBRHVjebNdG9jHmBl9n/2D5Y3XDhaR4FIB5oj0GttBte2KtUcm3RfglIVDk8GiQoATxWOmzu4qacurewzF8UaXs15VC+/rriBf6ykENYyADOI27GMfsdpuQ+EzbYbpTyNj7LoAqGjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5xaJyGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5xaJyGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51161F00893;
	Fri, 29 May 2026 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780087792;
	bh=73r4uK8zdiuhkhMDsdDz4xnv166r049b/thwpK7xxl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5xaJyGZNmJ7fU+/8x52fkzfqRfVZ6tQCglYJFaegMo3kJntIy+hWKwZBO54LKduE
	 94KwMqZbnPiFk/HSCt79smqGG7n7ficYAgIFiLRLuph/C44X9p1noZQMRSE/XEy9bu
	 8Kq8Nlv/TbeQQrvlBEA9TYEa8rML6BiYOnRkV10DPL5bpRDnOwXEV2TXU3oBTBxEsq
	 ovNhicPoYYqnaiiS7Ge2wB9PNGvWdbDO6KA4Bn+ECBN6yefeQqEhpslsHfr0/YaI9R
	 HD0+fTAhlTy/ceDy1v9s6EnhZm3pTt761huE8yJTVPntmSWV1VU4PE+6phxs2pe3dU
	 zQaNwdHlHoovQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/24] KVM: SEV: Use the size of the PSC header as the
 minimum size for PSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-6-pbonzini@redhat.com>
References: <20260529183549.1104619-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 20:49:50 +0000
Message-Id: <20260529204951.E51161F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Insufficient bounds checking for Page State Change (PSC) reque=
sts allows out-of-bounds host memory reads and writes past the mapped 4KB G=
HCB page.
- [High] The GHCB mapping pinned via kvm_vcpu_map() on #VMGEXIT is permanen=
tly leaked if the vCPU is destroyed before the next VMRUN.
--

commit 2f8a93115345b3dcacdee9bdd3b3bd2f9154bfc6
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Use the size of the PSC header as the minimum size for PSC reques=
ts

This commit updates the Page State Change VMGEXIT handler to use the size
of the PSC header as the minimum length for the scratch area. It stops
using exit_info_2 for the length, since the GHCB specification does not
provide length for PSC requests.

Cc: stable@vger.kernel.org

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 52703c9548568..cbb3040e07782 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4559,7 +4559,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		vcpu->run->system_event.data[0] =3D control->ghcb_gpa;
>  		break;
>  	case SVM_VMGEXIT_PSC:
> -		ret =3D setup_vmgexit_scratch(svm, true, control->exit_info_2);
> +		ret =3D setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));

[Severity: Critical]
This isn't a bug introduced by this patch, but by hardcoding the bounds che=
ck
to just the header size, does this allow out-of-bounds host memory reads and
writes past the mapped GHCB page?

If a malicious guest places the scratch area near the end of the GHCB shared
buffer, it can satisfy the bounds check for the 8-byte header in
setup_vmgexit_scratch():

setup_vmgexit_scratch() {
        ...
        scratch_gpa_end =3D scratch_gpa_beg + len;
        ...
        if (scratch_gpa_beg < ghcb_scratch_beg ||
            scratch_gpa_end > ghcb_scratch_end) {
            ...
}

However, later processing in snp_begin_psc() and __snp_complete_one_psc()
iterates up to VMGEXIT_PSC_MAX_COUNT, directly accessing and writing to
entries[idx]. Since the GHCB is a single page mapped via kvm_vcpu_map(),
accessing entries beyond the validated 8 bytes could result in accessing
host physical memory beyond the page boundary.

I see this is fixed later in the series by commit
89266ec65feabeba5d0f747da7115a19492fab4e and commit
4dd1fe3ae23c326b447d893657435197aa346458, which compute and check the corre=
ct
max length of the scratch area.

[Severity: High]
This is a pre-existing issue, but could the GHCB mapping pinned via
kvm_vcpu_map() earlier in sev_handle_vmgexit() be permanently leaked?

sev_handle_vmgexit() pins the GHCB page:

sev_handle_vmgexit() {
        ...
        if (kvm_vcpu_map(vcpu, ghcb_gpa >> PAGE_SHIFT, &svm->sev_es.ghcb_ma=
p)) {
        ...
}

Normally, this is unmapped on the next VMRUN in sev_es_unmap_ghcb(). Howeve=
r,
if the vCPU exits to userspace and the VM is subsequently destroyed without
running the vCPU again, the VCPU teardown path in sev_free_vcpu() does not
appear to unmap the GHCB. Would this result in a leaked pinned page and mem=
ory
mapping for every such destroyed vCPU?

I note this is addressed later in the series by commit
b2c42b3d82becdc801cc7f669caa3dbec0464c89.

>  		if (ret)
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D5
