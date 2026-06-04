Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF1223DE9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541369; cv=none; b=EXaKdRW1t+cqZsl/y2U81UYDTsFJYvQPDOsMHbjRT4AN2+k/qbYHA/VUXOqRIkqIql7ZkxepLB89qv/36imATXIQ4i3vWeiaMxNuR80RH2EqVfTr3q6rZ26Lo+7a/pOitaaBZkNO4z0ACV0evv7D9E69gT2S7f6UotFSkQjjpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541369; c=relaxed/simple;
	bh=Zf0i2nPMF7IunkWz4SdAPakOiqU2OLaJ40Zu7u+Etfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SGl8u5QQsOp/rZS/44B/VOXXQ65dyaFDRNPaPMSJOtYdIJQVziB4gYU8cAwbAZJIeQ2vdUnVi7Bo1F2v4VCTtpYu042dAXPRuHoy8KQBP6xfMil37p8C8N9OvgyABPx6ED8tt7PKI0cqvCtdz7EyWYZAOXORyK41ArkZRBVEpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dazOcLjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dazOcLjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22311F00893;
	Thu,  4 Jun 2026 02:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780541368;
	bh=YpacrZrtrrN9WT0ffn8ebpvM7hEL+eL57fpr07LIP8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dazOcLjpHcSqw2XeToX2cgOvuNpnMWYMiG1Do3cA6kIIyiQMCn6OftL0U+jGoPuxQ
	 kTGK/0dqyZFpEhd3I88tuB8c5xPrCFB6c/rhyelmfMecrvRmuGZd16Zc5pzhJVLQOo
	 X19Wlar6ljQSXtRkbW6nZEkOYGr423Jt6skBIpUebG0c562pxWrwsOXieLlegmdfJc
	 5qPjHricsRNpjnN5kOnr2gbglOT7GerGjkGTeYQCHClueVr/sly34iqwwosSAb3cdt
	 B6oVp81+q52Emb8oZuGF88VuYDg+6kcld79GZFtPIesfLdVB72/fVEYCrViOEn0ymw
	 NLbRFSmlZxlsw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] KVM: x86: TDX: Validate userspace CPUID
 input for KVM_TDX_INIT_VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604023314.3907511-4-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-4-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:49:27 +0000
Message-Id: <20260604024927.E22311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `tdx_unsupported_cpuid()` incorrectly uses the userspace-provided =
CPUID index instead of the canonical TDX configurable index for validation,=
 allowing feature allowlist bypasses.
--

commit c2adba56353483cd6dcf40b3fe14141409c0ce54
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: x86: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

This commit replaces the hardcoded CPUID denylist with a validation mechani=
sm
that checks userspace input against KVM's supported allowlist. It aims to
prevent userspace from enabling unsupported TDX features during VM init.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> +static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *e,
> +				  const struct kvm_cpuid_entry2 *mask)
> +{
> +	return ((e->eax & mask->eax & (~get_supported_cfg_cpuid(e->function, e-=
>index, CPUID_EAX))) ||
> +		(e->ebx & mask->ebx & (~get_supported_cfg_cpuid(e->function, e->index,=
 CPUID_EBX))) ||
> +		(e->ecx & mask->ecx & (~get_supported_cfg_cpuid(e->function, e->index,=
 CPUID_ECX))) ||
> +		(e->edx & mask->edx & (~get_supported_cfg_cpuid(e->function, e->index,=
 CPUID_EDX))));
> +}

[Severity: High]
Does this validation query the allowlist using the correct index?

If userspace provides a CPUID entry with the KVM_CPUID_FLAG_SIGNIFCANT_INDEX
flag cleared, kvm_find_cpuid_entry2() matches based solely on the function.
This means the returned entry 'e' could contain an arbitrary, user-controll=
ed
index.

Because get_supported_cfg_cpuid() is queried using e->index instead of the
canonical target subleaf mask->index, userspace could spoof e->index to
point to a more permissive subleaf in KVM's allowlist. The TDX module would
then blindly apply those validated bits to the original, narrower target
subleaf, bypassing the intended feature restrictions.

Should this use mask->index instead of e->index when querying the allowlist?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604023314.3907=
511-1-binbin.wu@linux.intel.com?part=3D3
