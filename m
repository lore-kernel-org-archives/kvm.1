Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1C2F7F14
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801090; cv=none; b=OkoUeWX9QcArJ/s+JbiRUCUxtFaVjTxlYrosWaj9KgAeLIZITu0heUwWZJEMEo6iGAQBsrGkC8M/A1jGpq0dM9udSoy2OlZs9rhF7gXBwc3iVrCDsVbN7ODaJg4Ac74ZgFOeRwbOMB1q4dmo5AO5Rf7FvWRtUY9g8uMmjq4QugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801090; c=relaxed/simple;
	bh=VLrs2B1X/GwL5YjSssr72LsRFO+Z2YlHW/jGrKZ2z4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e5n3zv/toI6s74Y7pkCX24W16aelk0vLS7X17c4Cd5g2+wHGBpP9rk+2wB+on03dzrLL7MSjsohbCE3JBR81fMcjKKT0bpTVCBsASOWOpA/dXegZ/yAS2J6wyARcK+VHlGql9B0TFQlpB47wirhJECIsCOgZtN7IW9geDnXCCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlwfXHtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlwfXHtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E31F00A3A;
	Thu, 27 Aug 2026 03:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787801089;
	bh=W0YoMb3M8Y+pAAE5VaM6WlddEkaVGXxrxC5j+o24sPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlwfXHtPvze+Yro2j2+CUjNhirr2ot3smqKXbUOot1DvowMAEqV/TC+R8uB16zqpD
	 R/JuNU5gw/RrQkRRjX0xJVD3RhqFXmBMZXK5HUHqjtGP6OAf2I4qd04b+8SeB0q1Sb
	 8V361xGi8RqV5ByzKCCfPak/6MoyT6w6DXHnFINNqzMAdWm2PH/dkJDMU4IYB9+zvS
	 lIZ46Xt/8S7nJqUf/sdQoDGSjPJAcKLGNq5ObDGqF4VY9EnHpHEAi9afdfnfv/dfUV
	 fcMxCG+JaXWUxcdc/7giIi+YYKBB8jxNHPbJOzDrevCvcPfO4ZYqMj5V3IolvBsqu9
	 3XMrYykOKXn6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260827031837.2863609-5-binbin.wu@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-5-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 03:24:48 +0000
Message-Id: <20260827032449.489E31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on the hardware-reported `num_cpuid_config` l=
eads to an out-of-bounds heap write when initializing TD parameters if the =
TDX module reports more than 48 CPUID configuration leaves.
--

commit 491ef15b15a75d61b2ded06ddb90ff6562206292
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

This commit validates the CPUID configuration provided by userspace
through KVM_TDX_INIT_VM against KVM's TDX allowlist. It drops the
hardcoded denylist-based check and instead rejects entries matching
unsupported CPUID bits or entries with mismatching subleaf indices.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index e8951353de73c..12dea8775fd4f 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -2556,7 +2548,16 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2=
 *cpuid,
>  		if (!entry)
>  			continue;
> =20
> -		if (tdx_unsupported_cpuid(entry))
> +		/*
> +		 * Reject entries whose index does not match the expected one.
> +		 * This catches userspace passing a CPUID entry with the
> +		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag cleared when the index
> +		 * is significant.
> +		 */
> +		if (entry->index !=3D tmp.index)
> +			return -EINVAL;
> +
> +		if (tdx_has_unsupported_cfg_cpuid_bit(entry))
>  			return -EINVAL;
> =20
>  		copy_cnt++;

[Severity: High]
This is a pre-existing issue, but does this loop in setup_tdparams_cpuids()
lack a bounds check on the hardware-reported td_conf->num_cpuid_config?

Looking at the loop just below this diff in arch/x86/kvm/vmx/tdx.c:

    for (i =3D 0; i < td_conf->num_cpuid_config; i++) {
        ...
        value =3D &td_params->cpuid_values[i];
        value->eax =3D entry->eax;
        ...

The target td_params is allocated with a strict 1024-byte size bound
in tdx_td_init():

    td_params =3D kzalloc_obj(struct td_params);

However, the hardware-reported num_cpuid_config can be up to 128. Because
struct td_params contains preceding fields and is bounded to 1024 bytes,
the cpuid_values flex array can safely hold a maximum of 48 entries.

If a TDX module supports more than 48 CPUID configuration leaves, this
iteration will blindly index past the 48th element, resulting in an
out-of-bounds heap write with user-controlled CPUID values.

Should num_cpuid_config be validated against the maximum capacity of
the td_params allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827031837.2863=
609-1-binbin.wu@linux.intel.com?part=3D4
