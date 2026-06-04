Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A155B21A
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541066; cv=none; b=EzJjjxqkMTdB4xsPKDAMoG/9QREg07dFVyd/96g3SIUrkZ7rW1UnMreki7NPU11F268+nBGsV+dWk5stzgspYDPVq35SLy31ru4K1nFfsebLQtJrMzv8ubtn0t6525vUcoRNyhKWX73aYKuFUjLR2Xz1ycDxom/KG6/hKPUHIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541066; c=relaxed/simple;
	bh=5qDCjISANrmJaEsm6+bK8fBD+AyuYqsVcGgTm+g9fXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPKIXmNkqjU7qtj+ueUVYp4gBKFeZ1e7zxa9zxsilDy3KPx8/MaxUkRkqdgdWVCN6XPep3DifF7mQ8rhWtJwsZfs/MnbcNGp19Uf2Fb4eV76WNVC/EdlDUskn2qY2TVH63OiUKZEA8xIBXfTZGtWftCIlcFKz6ENzGaQ1RseNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWC9weSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWC9weSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4923D1F00893;
	Thu,  4 Jun 2026 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780541065;
	bh=+rEDs0Cxtux+SKP3cRBKFOkWB8SX2Bkatck4D1qkGgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWC9weSdqIl8/PaxcB3Axc41SyH5djrvJz9aPuusrXUNzT7dU5NAXlgBaVoMsKvLa
	 yftRY+w6Mc18Lo/6BNT4/6oJsXSU8uYjmnmiPv+6CmVxJizgs+YUhVQgzNJ8JEkzbf
	 9rUekAzXOcGDkQMJ72V1BI8RDvhvlTvr/lfHasjB6luvcGr6/6mPt1ZZllo89aDEnD
	 s0x6FVgP5M5GtnvZW+nMxktWKtIozb5n6G4YdgmON56ZxpNenCy/VYSRwT44UQUkvG
	 d9R6q+dDd5qoLZlPfPDbWxZ1Uz7PyD/j59vC0rCOOoLfu1g8Q4c2XdWFWKZ3XqUQW2
	 w+S7M8M5QodxQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable
 CPUID bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604023314.3907511-2-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:44:24 +0000
Message-Id: <20260604024425.4923D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `tdx_cpu_cfg_cap_init` macro is highly fragile and relies on th=
e caller providing a mandatory trailing comma, which will cause obscure syn=
tax errors if omitted.
--

commit 8aa0677abade944ac536d7acccef89b12ace7386
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: x86: TDX: Track supported configurable CPUID bits

This patch introduces an allowlist for TDX directly configurable CPUID bits
supported by KVM. It tracks the supported bits by statically initializing
multi-bit fields and dynamically populating feature bits during hardware
setup using a new initialization macro.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b8c3d3d8bbfe5..028d54c76b81e 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -52,6 +52,178 @@
> +#define TDX_F(name)					\
> +({							\
> +	tdx_cpu_cfg_caps |=3D feature_bit(name);		\
> +})
> +
> +#define tdx_cpu_cfg_cap_init(_func, _index, _reg, feature_initializers..=
.)		\
> +do {											\
> +	u32 tdx_cpu_cfg_caps =3D 0;							\
> +											\
> +	for (int i =3D 0; i < ARRAY_SIZE(tdx_kvm_supported_cpuid); i++) {			\
> +		struct tdx_supported_cpuid_reg *r =3D &tdx_kvm_supported_cpuid[i];	\
> +											\
> +		if (r->function =3D=3D _func && r->index =3D=3D _index && r->reg =3D=
=3D _reg) {	\
> +			feature_initializers						\
> +			r->mask |=3D tdx_cpu_cfg_caps;					\

[Severity: Low]
Is this macro design relying on the caller providing a mandatory trailing
comma?

Because feature_initializers expands to a list of statement expressions
like ({ tdx_cpu_cfg_caps |=3D feature_bit(name); }), omitting the trailing
comma in the macro invocation would result in a syntax error immediately
before r->mask |=3D tdx_cpu_cfg_caps.

Could TDX_F be redesigned to return the bitmask directly so they can be
combined using bitwise-OR, avoiding the strict trailing comma dependency?

> +			break;								\
> +		}									\
> +	}										\
> +											\
> +	WARN_ON_ONCE(!tdx_cpu_cfg_caps); 						\
> +} while (0)
> +
> +/* Only for TDX directly configurable CPUID feature bits */
> +static void __init tdx_initialize_cpu_cfg_caps(void)
> +{
> +	tdx_cpu_cfg_cap_init(0x1, 0, CPUID_ECX,
> +		TDX_F(MWAIT),
> +		TDX_F(TSC_DEADLINE_TIMER),
> +		TDX_F(AVX),
> +		TDX_F(F16C),
> +	);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604023314.3907=
511-1-binbin.wu@linux.intel.com?part=3D1
