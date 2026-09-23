Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC653AE198
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174057; cv=none; b=Bmw7sSxDLzf7317JmArtOeb/IAvlMws0g8f52igW57A9fppaaC1/CGLGJjLCOGhJbgejzjn0SlfIrq3r4tHs7CkovEgsso6IZWvicCttGHiA6ZF+kjSk9S2b8sl41RnlbhbooP8f2aeq6LVXx+oNZf0kBsqQ69/3ucZk1EEsYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174057; c=relaxed/simple;
	bh=J/+qh8sJSJMHCm+mbmTlr8SMGsX88Ags2LiUi/8J/KY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+4fX5ToTxwOw39zsrBU6a65HWSalBOQHVYbLuX2L1bEhTYpmXu8r6wyVCkQnF2fa7jsok3nMSlD5jFTT715B8EaOTyMdQBRfve212/TvEIwz3UNwFLRmUm4qW6gwQ0dYqSTAUC/J4R+Q1iEKWAF0RgZwHuLY099tjeh7ph9q0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiWaCu7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiWaCu7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C3F1F000FF;
	Wed, 23 Sep 2026 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790174055;
	bh=UL316f3yjPS1Vd7+u5O02bzqRSRB5YEPN/7ib2uoCTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AiWaCu7MWESsiVVexC8z2clLvZOtpYRfYmbop+DDOLqJu8E8tW5KoEf2rHUsDjRZ5
	 YlXYfiFu5xm2L/g/p5yKKRKr+iEwSJuPKwFq6SWLU2g8l3c+wDzbkkR6pFb54fUcnR
	 KTTaXFvUlNZ40WpEm804YpRMu3WHMH5SRs73+sXYocAtc00ZrnSXS96fzXgoiF1tjj
	 XYMxCXEuQZoh8W4zeZaph6Jfx+zzqJYYkP6xTX7qnUnLjMOsNrRQysX3NhkTCVCV2a
	 3QUqOWCr9HKWpcKPHe14wzZGM9y6UnFmIKXMcZcjyz0dP46cdKNw4FCA9oH4pYR53m
	 VzAJK7/1M5AaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/8] KVM: nSVM: Advertise DecodeAssists to L1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <46c9cf5d4b347b0147f9fb7781a06e0eaa8918a9.1790171702.git.zhang_wei@open-hieco.net>
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
 <46c9cf5d4b347b0147f9fb7781a06e0eaa8918a9.1790171702.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:34:15 +0000
Message-Id: <20260923143415.94C3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: nSVM: missing CR_VALID bit in exit_info_1 for synthesized D=
R intercepts
--

commit 442db7fa42ab1144e62575ec3079cbc2d2e5ea40
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Advertise DecodeAssists to L1

Advertise DecodeAssists to L1 now that KVM virtualizes the guest-visible
DecodeAssist state in VMCB12: EXITINFO1 decode data for MOV CR/DR, INTn,
and INVLPG exits. Expose the feature only when supported by hardware, as
KVM still relies on hardware DecodeAssists for VM-Exits that are reflected
directly from L2.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e83e4e5e7b934..82de844f63ade 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5557,6 +5557,8 @@ static __init void svm_set_cpu_caps(void)
>  		 */
>  		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
> =20
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);
> +

[Severity: Medium]
Will advertising DECODEASSISTS here cause issues for synthesized DR interce=
pts?

Looking at svm_check_intercept() in arch/x86/kvm/svm/svm.c, when an L2 guest
executes a MOV DRx instruction with decode assists enabled, KVM synthesizes=
 an
intercept but doesn't set the CR_VALID bit (bit 63) in exit_info_1:

	case SVM_EXIT_READ_DR0:
	case SVM_EXIT_WRITE_DR0:
		icpt_info.exit_code +=3D info->modrm_reg;
		if (decode_assists)
			vmcb->control.exit_info_1 =3D info->modrm_rm & SVM_EXITINFO_REG_MASK;
		break;

Does the AMD APM require bit 63 to be set for DR intercepts? If it does, wo=
uld
an L1 hypervisor that strictly validates the EXITINFO1 field reject this
synthesized intercept data, leading to emulation fallbacks or failures?

>  		if (nrips)
>  			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790171702.gi=
t.zhang_wei@open-hieco.net?part=3D7
