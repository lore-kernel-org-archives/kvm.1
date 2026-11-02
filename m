Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620365;
	b=TW0DaQlAW4mUKshYT+1cLJsjlpWbvUZFoVioPD0ueH/gx1FyePjUB7KOSl/At+FGbe4y
	 Wpns0haI/PdAer78+zGrz2f+4xyiuQI0m4pYmj8fa8BnGXRJ2M6t98h5GHh9bKQ1X7X+m
	 ZlfVsVs+/koW8UVJaI+jn15QuBu8cIKATlF5mHcMlTqilSkFOIu2I5Ncr3Pum0vMR/qXZ
	 MqWRMWmRkiWXYP8lqt0bv3/NkrZlB6vXCa/7xEy+0l/6K6txN+bxAydukUwb6cZMOQRhD
	 gh4JZNWz+nUYwxCKMAaNPqUHPsXMs17yybM8CQBI1iJEEixtBHeJSrecMbuG9Gvlm3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k+eBEOfejDNZ+lox449Cha9eyYlLspXx2M3Nr5gH2/k=;
	b=xobn3kx0+phxbe0glpXVBjYkSfWEH9h+kscVDZ+G+998dx8xsKrWZmQVW85C7aTClWgB
	 L6EBjMEBEZzP48fZx60SMTFZN69mC0yCnemSKPN8fbkmSbWIBSzySrD99DuDyAUptrr9E
	 nuHjUpgEf2tbBVuwvbQdQ/RsnA+WAcOUlXYm9L+rXpO0zZwIhmBLkffXsryJizVUSY7Pi
	 3i+h4ZxK16zDos7Vf4hhw+PewE2IjVhA1QF5m+N3LXtBfbY5Cas+gWP6+ljGC8La0YwIi
	 hnUg1UO9IWBuCuhKKxkYoAj7PNd6h6iP4Yhv5HfWRFNOAKwuf2n23LZdRhRFZo0+b1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCs1mAJn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E350606A329
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCs1mAJn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64711F00A16;
	Mon,  2 Nov 2026 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620365;
	bh=k+eBEOfejDNZ+lox449Cha9eyYlLspXx2M3Nr5gH2/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RCs1mAJn+bjqxR/83lm51dVM1pSUS1IlsbhNnWsCGzFBYnMVf7gdUHDCUx2V/CTVH
	 mHM7mUb3+8NoQImIhtc8A3nLxLEjpi8Ld+WXiHJj8tNESb5wnP4E9VvWbARVCanP5F
	 9T+E+wGfjo76nBQoY6z/MuFvPelG8jdXH9GtCFzAg0J7mkJEvGqp67+sMjUKVLpGKD
	 pBGDmuyGvtMa1m64w848d+87U53GGdMZcnTOHBXx4g58iczitYbKv0ucnQiLQcmjiA
	 vyBUtpo0wW3CG8jvsXTtveuQdUJaFLgBVWm1oIW4t+fBgCQkPxMWIThINCbC39lMOy
	 Zq36B3F5144bQ==
Message-ID: <sashiko-outbox-193355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] KVM: SVM: Implement GET_AP_APIC_IDS NAE event
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261102114137.1198982-3-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:52:44 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: SVM: Unconditional enablement of GHCB_HV_FT_APIC_ID_LIST feat=
ure
--

commit 3bffb8ab055298369df7622e8e3308488b5501b8
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SVM: Implement GET_AP_APIC_IDS NAE event

This commit advertises GHCB_HV_FT_APIC_ID_LIST and implements the
SVM_VMGEXIT_GET_APIC_IDS NAE event so SEV-SNP guests can retrieve the list =
of
online vCPU APIC IDs without relying on INIT-SIPI.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index fad72cab76cf4..c0ae34871be90 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -40,7 +40,9 @@
>  #define GHCB_VERSION_MAX	2ULL
>  #define GHCB_VERSION_MIN	1ULL
> =20
> -#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATIO=
N)
> +#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | \
> +				 GHCB_HV_FT_SNP_AP_CREATION | \
> +				 GHCB_HV_FT_APIC_ID_LIST)

[ ... ]

> @@ -4708,6 +4769,8 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		if (sev_snp_ap_creation(svm))
>  			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
>  		return 1;
> +	case SVM_VMGEXIT_GET_APIC_IDS:
> +		return sev_snp_get_apic_ids(svm);

[Severity: High]
As reported by Sashiko on v2 [1], GHCB_HV_FT_APIC_ID_LIST is added
unconditionally to GHCB_HV_FT_SUPPORTED and sev_handle_vmgexit() dispatches
SVM_VMGEXIT_GET_APIC_IDS to sev_snp_get_apic_ids() for all SEV-SNP guests
without host userspace opting in.

When an SEV-SNP guest queries hypervisor features via GHCB_MSR_HV_FT_REQ in
sev_handle_vmgexit_msr_protocol() or SVM_VMGEXIT_HV_FEATURES in
sev_handle_vmgexit(), it will unconditionally observe GHCB_HV_FT_APIC_ID_LI=
ST.
If a guest uses this feature and is migrated or restored onto a kernel with=
out
SVM_VMGEXIT_GET_APIC_IDS support, guest execution will fail when invoking t=
he
NAE event.

Should this new guest-visible feature default to off and be gated behind a
capability via KVM_CHECK_EXTENSION and KVM_ENABLE_CAP so userspace can mana=
ge
feature exposure and live migration compatibility?

[1] https://lore.kernel.org/r/20260908103338.427254-3-joro@8bytes.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102114137.1198=
982-1-joro@8bytes.org?part=3D2
