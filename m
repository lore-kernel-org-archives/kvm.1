Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78892459C5
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431540; cv=none; b=Z0iPBUQpfkbJeGl9o3YHfSavrsDr0YJ50J4BTiBMIWHghppiPpvq8gvfXVmdQb5+S2/5TCY3rF1Xh98LrPlqDQxM/LaHheD5Ee5oc3ANV5+ATf88Hyf8IEBTCBkHMbYYBIih3gnyjwu03+6R4Ufk3ErB5ASOsztB59iYV4P5o9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431540; c=relaxed/simple;
	bh=SCSk6mvQLUmb5AfwNscQKtxP1za0dhAFzZOYNB4Wk1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMqhIzuYe53DO/4bcQUS2E5KoqoZ6wISuYDgzdk3DxvEMIP3thcS/7zLje7h+h7eQ9oGE/qrSPLnrWXvxft1SeLX1E7/gWYrhkLDghN3SEk+WUAwd9TGStYXPqCgeLeZRbjCllC9yibtJW4eEYQ6d2aE1AXVKgWIM+D+GgSls9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTatoyuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTatoyuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208FF1F000E9;
	Thu, 25 Jun 2026 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782431539;
	bh=8SsGtsWpH7TCgVfXlSf1zXT2GhX2GEVEPD36nbaNNPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTatoyuo/dnShn12+BhpmiPYpWe22U8D4zoE5XsGVJIn5ca4Jx4aLhKvCWeVEtbOZ
	 ihYprIaAzk5NXxLAK1djU76UMlS5hEdIgYH2P71ofz1Dhm3odKC9zACIKjOgMfKLkC
	 81MO7eepIInUlV4uCD+8uKXvhoHztmqOsnzYZkf02HU1mbhwTPFvUY4w1xIXUmXQEl
	 xmVDn940yaPq9sCLE8MChRKYgFl2fmyQlACAnYdVnFCvJdUcHDfcl89MuvjjpSM1PU
	 KWZ4IivSeRvjOPMBnJ1kQsvXiyZiFSFkjAXo7e52Hc+4AKW0a1m1OGvi2zkD6vij+u
	 qqo8tG8yesbLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: x86: Move nested_ops out of kvm_x86_ops, to
 global kvm_nested_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625233846.3407303-4-seanjc@google.com>
References: <20260625233846.3407303-1-seanjc@google.com>
 <20260625233846.3407303-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 23:52:18 +0000
Message-Id: <20260625235219.208FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Uninitialized register value leak to userspace via `get_evmcs_ve=
rsion` static call on SVM
--

commit 41ec1a5f1876c74be6794086189350b5338ee224
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_ops

Rework KVM's handling of per-vendor nested ops to copy the vendor's ops
into a global structure owned by common x86. This guards against post-init
changes to the vendor's ops now that KVM uses static calls.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 8b396ccd847e0..b010dca37b9d1 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2787,7 +2787,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct =
kvm_cpuid2 *cpuid,
>  	};
>  	int i, nent =3D ARRAY_SIZE(cpuid_entries);
> =20
> -	if (kvm_x86_ops.nested_ops->enabled)
> +	if (kvm_nested_ops.enabled)
>  		evmcs_ver =3D kvm_nested_call(get_evmcs_version)(vcpu);

[Severity: Medium]
This is a pre-existing issue, but does this static call leak uninitialized
kernel register state to userspace on SVM?

Because get_evmcs_version is declared as KVM_X86_NESTED_OP_OPTIONAL rather
than KVM_X86_NESTED_OP_OPTIONAL_RET0, the NULL target on SVM gets patched
as a NOP rather than returning 0.=20

When this static call executes in kvm_get_hv_cpuid(), the C compiler expect=
s=20
a uint16_t return value in the %ax register. Since the NOP doesn't update=20
the register, whatever leftover data was previously in %ax is assigned to
evmcs_ver.=20

Later in the same function, this uninitialized value is written to ent->eax:

    case HYPERV_CPUID_NESTED_FEATURES:
        ent->eax =3D evmcs_ver;
        ...

and subsequently copied to userspace via the KVM_GET_SUPPORTED_HV_CPUID ioc=
tl.
Should get_evmcs_version be changed to an OPTIONAL_RET0 static call so it
safely returns 0 when unsupported?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625233846.3407=
303-1-seanjc@google.com?part=3D3
