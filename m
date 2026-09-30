Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C51509F05
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805155; cv=none; b=ANivG38+KYCY1D2lHJ+wV71+UCHstYvoAm1eoyJXRG9KfVEBqli2D2DiWIoEttxsSvQXSImSDVVU6cdoT+IhyO5JUxMbvemYb06Ual21xr3LcO1atjB7VVNL4Lx5+UdLxjqyjeaoS2ePb5DxosFktz3en+ghv111IsAYm9FtC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805155; c=relaxed/simple;
	bh=pqhdxNRhgTxL2QcLDWCKukCjr//v6/Q99+jJMu9TcR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pE9joMDHeC9obFfghuDNH5EH9rGVsvOSJVvdzjc/djpkFayZzSGcTY7BwZxWtarZKUGBFUSIn+GUyofRIt3bBcCAH01pXeIF7pL9kWY0HQtdXpUBKTV+bwhZ8RBFWNmgtPtvvzWSWQ7cLp7X2W0ZEJ2snHYh3Ew+fvxiUeQvCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlSkgjH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlSkgjH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E721F000FF;
	Wed, 30 Sep 2026 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805154;
	bh=C5lM4RZ0vELCrs2U74RR2bzBtwVm5eZBSv9kv4J8Ors=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AlSkgjH4ut9X7i00gjRQNOJUH5urzi6Qr/NiTyVGFHF42DTvJ3B5LqTS/aMkXU1+9
	 4IJ1doCSsSpkKO6YZVW4unrHq/jx0THC6Xc4rxWW0zD6nCSGszAae3S27STVgeVlZy
	 Ys6rjreFT9Ml9tjqgk4yWDvBCmLgHLKFy/iuWudWBoakgFTCeNRmw6y73I45s1oqjb
	 ooyj3RKFvsHqlqKO1J5EZjnVguSLdsH86WKpJ6iTizHffYDkTL/qDJlbKmCNQONSV+
	 QGXO21ltjuzDZl3862wMuLQHPxtvCh6Th5rbyQBsfRmxp01swApEDPjrtAcWAZXRyx
	 nzqXDVaiCVfag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/20] KVM: VMX: Support instruction information
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-9-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-9-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:52:33 +0000
Message-Id: <20260930215234.10E721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: vmx: eVMCS mapping missing for EXTENDED_INSTRUCTION_INFO on A=
PX hosts
--

commit 2d697a70afdaa50d39579af2713731bbc6805336
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Support instruction information extension

Define the VMCS field offset for the extended instruction information.
Then, support 5-bit register indices retrieval from VMCS fields.
Note the APX enumeration alone indicates the extension is available.

Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com

> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 863b08478544f..4a76af6137201 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
[ ... ]
> @@ -714,20 +723,22 @@ static inline bool vmx_guest_state_valid(struct kvm=
_vcpu *vcpu)
> =20
>  void dump_vmcs(struct kvm_vcpu *vcpu);
> =20
> -/* A placeholder to smoothen 64-bit extension */
>  static inline u64 vmx_get_instr_info(void)
>  {
> -	return vmcs_read32(VMX_INSTRUCTION_INFO);
> +	return vmx_instr_info_extended() ? vmcs_read64(EXTENDED_INSTRUCTION_INF=
O) :
> +					   vmcs_read32(VMX_INSTRUCTION_INFO);
>  }

[Severity: High]
Is a new eVMCS mapping required here?

When KVM runs as L1 on top of Hyper-V (using eVMCS), vmx_get_instr_info()
unconditionally calls vmcs_read64(EXTENDED_INSTRUCTION_INFO) if the underly=
ing
host CPU exposes APX (cpu_feature_enabled(X86_FEATURE_APX)).

Because EXTENDED_INSTRUCTION_INFO (0x2406) is not defined in the eVMCS mapp=
ing
(vmcs_field_to_evmcs_1 in arch/x86/kvm/vmx/hyperv_evmcs.c), evmcs_read64()
fails with -ENOENT, triggers a WARN_ONCE, and returns 0.

This is reachable by any L2 guest performing a CR access or VMX instruction
when KVM runs on an APX-capable host under Hyper-V.

It causes KVM to incorrectly decode operands for all control-register acces=
ses
and nested VMX instructions (defaulting to the RAX register), leading to to=
tal
failure of nested virtualization.

Note: The related vmcs12 nesting issue raised in the original concern was
correctly resolved in follow-up patch 9 (commit 50ba47ea51df), but the eVMCS
issue remains broken through the end of the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D8
