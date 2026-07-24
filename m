Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C824A06D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855517; cv=none; b=Ee72jaUnbtD/xFACYhP8rw5wLtbejNOGgq53sl367+bYltKL5mYkCcmmjLKGUu9znAptBwEGx42qlKi2vSQ7SLw+Z8GME8rpqP52ANn74xumjrbqajg0357FBxALa3dpp7bZ43VRwqzfjOFJqubq5ptvJA2VCZsggfoqQtnKBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855517; c=relaxed/simple;
	bh=mx/RTnp8zq5n2yFB5RxVseG+Pu9Vs28s6fZwzQ3uZDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PSpcK/nt3ROYwLq7V5NmcVEqhoW1MQlLYa1gPMsKmGJjPU4s2ksfnOI8/oRjSBMMZeO6Ky20TTktaUXOrRMw7zEANyVHGOENy+F4EXq5umpmO1lkz3mHwonWA2OrUcNNRPW/TWUs0ipx72VyfZsjCur39Lms3YBz8n8+BafDBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDi2Sifv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDi2Sifv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BEE1F00A3A;
	Fri, 24 Jul 2026 01:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784855516;
	bh=ZLI5vWEwpKJ4x2nmWac7Pj+ds8sD51oPcCIaIcg4xLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDi2SifvtN0hmFeV1sKaauneEO3uYMC6MTFI2YXnVGyjjS1JiRPcgOIK4c+Eo7MzX
	 Q3RLCASMdZ2xjWYfQqT6YIrvZg0Ypw+S3Pv8Y48AXxwneQBfB+twMJZL73rx5AhnWp
	 BjlIEugTSLpqNw2DFXkzvltEVcDvxS707QcYgtP+lkT/zitys7yuYFv/TMN8mGc53P
	 DyPEZqwegEAVLGK2Nu4MvlqaEtkoZqyW9s+JSKZ56H6cQonbBy8bMc572Kw8FnvLGg
	 2kFtA4sTsKiymKB+iOyw7ZRwbomVodxS741fS7UCcGD8xvhUwWJrzX1nHECZhctFtH
	 vu/3Sp9kB2c8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] KVM: Harden kvm_vcpu_map() against double-mapping
 and thus leaking references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724004757.131420-7-seanjc@google.com>
References: <20260724004757.131420-1-seanjc@google.com>
 <20260724004757.131420-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 01:11:55 +0000
Message-Id: <20260724011156.41BEE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `WARN_ON_ONCE(map->hva)` in `__kvm_vcpu_map()` can=
 be intentionally triggered by a malicious L1 guest during a failed nested =
VM-entry, leading to a host panic if `panic_on_warn` is set. This violates =
KVM subsystem guidelines against guest-reachable asserts.
--

--- Patch [6]: [PATCH 6/6] KVM: Harden kvm_vcpu_map() against double-mappin=
g and thus leaking references ---
commit 8ccf1780ac5defdd7cc6ad600af4fce97f3731bd
Author: Sean Christopherson <seanjc@google.com>

KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking referenc=
es

This commit explicitly unmaps existing mappings in __kvm_vcpu_map() when
map->hva is already set. This change hardens the code against memory leaks=
=20
from zero-allocated maps. It also adds a WARN_ON_ONCE() to alert on double=
=20
mappings.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2df8ee9ecf6c6..e9e32686e41be 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3118,6 +3118,9 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn=
, struct kvm_host_map *map,
>  		.pin =3D true,
>  	};
> =20
> +	if (WARN_ON_ONCE(map->hva))
> +		kvm_vcpu_unmap(vcpu, map);
> +

[Severity: High]
Can this WARN_ON_ONCE() be triggered by a malicious L1 guest, potentially
causing a host panic if panic_on_warn is set?

If an L1 guest sets up a VMCS12 that requires mapped pages (e.g. for APIC
accesses) but provides an invalid guest state, KVM maps the pages in
nested_vmx_enter_non_root_mode() via nested_get_vmcs12_pages(). If the state
check fails:

arch/x86/kvm/vmx/nested.c:nested_vmx_enter_non_root_mode() {
    ...
		if (nested_vmx_check_guest_state(vcpu, vmcs12,
						 &entry_failure_code)) {
			exit_reason.basic =3D EXIT_REASON_INVALID_STATE;
			vmcs12->exit_qualification =3D entry_failure_code;
			goto vmentry_fail_vmexit;
		}
    ...
}

KVM jumps to vmentry_fail_vmexit and returns to the L1 guest, but skips
calling nested_put_vmcs12_pages(). This leaves the pages mapped. When the L1
guest executes VMLAUNCH again, KVM attempts to map the pages again, map->hva
is already populated, and this WARN_ON_ONCE() is unconditionally triggered.

Does this violate the KVM subsystem guidelines against guest-reachable
assertions?

>  	map->pinned_page =3D NULL;
>  	map->page =3D NULL;
>  	map->hva =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724004757.1314=
20-1-seanjc@google.com?part=3D6
