Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FF39B4A5
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950948; cv=none; b=gsp4swb8eZUeuy6cen9g7lkuNxryyf6Vl1Ix5NZg8g3D4SP86DFgSZb8ESq1HjjyTV/IsqukxNIDaOJTCOE28PUhF5RKp9/Qn6zHnULRs0ONxzoF0hTYrOTrZ9VtAjDGkNY2vCpBdW+Y9BFyTqJA/eyK/2Lm+aDzpk3R0ZkCwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950948; c=relaxed/simple;
	bh=C0uT9odDaYsUyyN6y/2jYB11Rbf2TNFfligA+vl3h8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VcZtFOHtnoE+bpMrPWI1+scxF+xaKGX1srRW1eF0dtb3UjwhauJNInLU4YYh8wWPSDl0vN0A3xMT2j1LHKgJLt1MLi/8RXgUzK4Kzs6+pbMNbAqNMKBNmcQAX/uycJKkQbaJUCeBySvWSK/IghGmBwMCaCvCm3Nz/fgs3XVHq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMaoJbA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMaoJbA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A35F1F00893;
	Mon,  8 Jun 2026 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950947;
	bh=1l/d624InjI4USjpTCuo+YDf8OFMWUr3b2gnG1T1G70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMaoJbA+1Za8uLkWZyhW6MVa9W8PxmPn3HYsdd3ytqCHguIurLeS51XP+dhe7LDtq
	 ltZB2nsQZ8VUYA+iiDLfNXUjr7nTx1j7LKq9Fgzskjv89LhsbIo0MCRAS4rSl8/eg/
	 J9BYloVQ4PJLxOLD0Asx2iWEiAVqS4CBn3x02N3V5BArvpSdvNIsHj1idnpBFDveEY
	 Ml2M8EzOQ39yWBt0v7qydVJTrfkLsR7X+5iOuS+pUgJJVZqlXwTRxn1oVg1o7qUw+o
	 kbSu6X2PT8T4zU04/6ctX9nc+cBfQ4PGjZzcIa4hABqLUCTWcQmrDofiFh82voUpZY
	 +x7OGps7irm2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 44/60] kvm: x86: Move cpu_caps to struct
 kvm_vcpu_arch_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-45-joro@8bytes.org>
References: <20260608144252.351443-45-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:35:46 +0000
Message-Id: <20260608203547.4A35F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Moving `cpu_caps` to the shared `kvm_vcpu_arch_common` structure c=
auses per-plane dynamic capabilities (e.g., MWAIT, OSXSAVE, OSPKE) to overw=
rite each other, breaking CPUID emulation for multi-plane vCPUs.

Pre-existing issues:
- [High] The shared `cpuid_entries` and `cpuid_dynamic_bits_dirty` state ca=
uses the guest to observe the wrong plane's dynamic CPUID bits.
- [High] `kvm_set_cpuid` fails to initialize `guest_fpu` XFD features and H=
yper-V state for all planes.
--

commit 37a5729990263e7e405f34c6c28312d008fdb0a0
Author: Joerg Roedel <joerg.roedel@amd.com>

Now that CPUID state is shared across all planes, cpu_caps can be shared
as well.

This commit shares cpu_caps across all vCPU execution planes by moving the
array from kvm_vcpu_arch into the shared kvm_vcpu_arch_common structure.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -284,7 +284,7 @@ static __always_inline void kvm_update_feature_runtim=
e(struct kvm_vcpu *vcpu,
>  						       bool has_feature)
>  {
>  	cpuid_entry_change(entry, x86_feature, has_feature);

[Severity: High]
This is a pre-existing issue, but does applying plane-specific dynamic
state to the shared cpuid_entries cause the guest to observe the wrong
plane's dynamic CPUID bits?

When kvm_set_cpuid() iterates through all planes, it calls
kvm_update_cpuid_runtime() for each plane. This updates the shared
cpuid_entries with the current plane's dynamic state and clears the
shared cpuid_dynamic_bits_dirty flag.

Since the dirty flag is cleared without leaving it dirty for the next
check, won't subsequent planes executing CPUID just read the shared
cpuid_entries populated by the final plane's state?

> -	guest_cpu_cap_change(vcpu, x86_feature, has_feature);
> +	guest_cpu_cap_change(vcpu->common, x86_feature, has_feature);

[Severity: High]
Does this code incorrectly evaluate per-plane architectural state and
commit the dynamic results (such as MWAIT, OSXSAVE, or OSPKE) into the
globally shared cpu_caps array?

If this is re-evaluated for each plane, won't the capabilities of the last
plane processed overwrite the state for all prior planes?

>  }
> =20
[ ... ]
> @@ -382,7 +382,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	bool allow_gbpages;
>  	int i;
> =20
> -	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
> +	memset(common->arch.cpu_caps, 0, sizeof(common->arch.cpu_caps));

[Severity: High]
Since kvm_set_cpuid() iterates over all planes calling
kvm_vcpu_after_set_cpuid(), does this unconditional memset() destroy the
shared cpu_caps state on every iteration of the per-plane initialization
loop?

[ ... ]
> @@ -536,8 +536,8 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struc=
t kvm_cpuid_entry2 *e2,
>  	swap(common->arch.cpuid_entries, e2);
>  	swap(common->arch.cpuid_nent, nent);
> =20
> -	memcpy(vcpu_caps, vcpu->arch.cpu_caps, sizeof(vcpu_caps));
> -	BUILD_BUG_ON(sizeof(vcpu_caps) !=3D sizeof(vcpu->arch.cpu_caps));
> +	memcpy(vcpu_caps, common->arch.cpu_caps, sizeof(vcpu_caps));
> +	BUILD_BUG_ON(sizeof(vcpu_caps) !=3D sizeof(common->arch.cpu_caps));

[Severity: High]
This is a pre-existing issue, but does kvm_set_cpuid() fail to initialize
guest_fpu XFD features and Hyper-V state for all execution planes?

Looking at kvm_set_cpuid(), it mistakenly passes the loop invariant vcpu
instead of the iteration variable v inside the loop, failing to
initialize Hyper-V state for other planes:

arch/x86/kvm/cpuid.c:kvm_set_cpuid() {
    ...
    if (kvm_cpuid_has_hyperv(vcpu)) {
        vcpu_for_each_plane(common, i, v) {
            r =3D kvm_hv_vcpu_init(vcpu);
    ...
}

Additionally, kvm_check_cpuid(vcpu) is called completely outside the loop:

arch/x86/kvm/cpuid.c:kvm_set_cpuid() {
    ...
    r =3D kvm_check_cpuid(vcpu);
    if (r)
        goto err;

    vcpu_for_each_plane(vcpu->common, i, v) {
    ...
}

Doesn't this leave other planes uninitialized for XFD features?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D44
