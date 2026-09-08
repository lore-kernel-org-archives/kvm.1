Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A843CE42
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864670; cv=none; b=nlcQdG3wYtsotKm6uVOYjrznUwd2k39AYJovHIl+R06JBmtrKoZGxMUpvBaXwj2jsPiRW501PoZAi5XOzs/swgZlTFmkgzqQJu/rQLTp5AbK+ULyC1FV1PwXskzxXTzzmXWwMLjh+fmqixEn9jQOYwW8kIPHWFSrPAzcxzvd8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864670; c=relaxed/simple;
	bh=zIUIULLl43TW1yRy/ZyNi3K3HQGeVGb8x/rosSua5Lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7zPLVjj2KDLeAb1dZikncZytgBVBcHmkyI2ulgMa3z1IIFbJh7KUlVsoRQBZ1XA2aXQtlsbFND4yQYj0Na4ziE/7Cn0//SvlhC2QaizxzjJAjkJtwYrEyFLl9Ixs1F+Elkyxl5E4rmNKHrfNGc6qJAuRuZWIj38Dx5ad43zAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3HU/hK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3HU/hK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57211F00A3A;
	Tue,  8 Sep 2026 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864665;
	bh=ue7L45fjlyu5HFAQfXTBM6l19jFTa7UXPRWLwOeWIFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3HU/hK8Q5fzZYKnQUAHXQ7R9DcPJuY+HtJa+OCt/UZKiNyTlsxk7aY1RE1XMQyCS
	 vMYf5QdHfWXIa+NbpX3fayWSBsm4JekF4jPJCEJXo7D0o/CTZaRwnXuVfddDRCLSCP
	 vESD0vcSvh/Z06GSaM5zFzFhGxGL8LZcheSx7OUHkZHyCVGim9mTXvkKMwZhhRWGA7
	 BeggCIeDtTOyzdpvvNTydur33bxuMGM2OSl4r+nu/ImmGD/sXL0syGap/ZjNEdvU9i
	 diz1dyQy4Hv6/fI07elgGOWSBKucUZUn2XdQ9DUKzTJ5LRdySmcniwzSiqQa82/6EB
	 TSXwKMzYlkv0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] KVM: SVM: Implement GET_AP_APIC_IDS NAE event
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908103338.427254-3-joro@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:51:04 +0000
Message-Id: <20260908105104.D57211F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new SVM_VMGEXIT_GET_APIC_IDS feature is unconditionally enable=
d and advertised to the guest, breaking the default-off policy and live mig=
ration capability.
--

commit b3798f7802c495f4483b09adbdba116cdb452f71
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SVM: Implement GET_AP_APIC_IDS NAE event

This commit implements the GHCB APIC ID list feature to allow SNP guests to
discover vCPUs needing VMSAs without INIT-SIPI. It handles undersized buffe=
rs
and copies online vCPU APIC IDs to guest memory.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5705723f1f412..c16eca9983f37 100644
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

[Severity: High]
Does unconditionally adding GHCB_HV_FT_APIC_ID_LIST bypass userspace=20
capability negotiation?=20

KVM subsystem guidelines mandate that any new behavior the guest can observe
must be off by default and discoverable through the architecture's standard
enumeration interface.

If a VM boots on a kernel with this patch, observes the feature via the
GHCB_MSR_HV_FT_REQ MSR, and is then live-migrated to an older kernel that
lacks support, could it cause the VM to crash when it attempts to use the
NAE event? Should this feature require explicit opt-in from host userspace
(e.g., via a KVM_CAP_ check) before advertising it to the guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908103338.4272=
54-1-joro@8bytes.org?part=3D2
