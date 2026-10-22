Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706559;
	b=H2Daqp4cqS2aNo6Rw0yokCvTHgVJL8hX5yQcGF4Uw+u3M5bOSOC6YSj9c7mKV4YAC4uq
	 +VuU5bFmSF8lHy2mIFNjUBpHI6jXjhWFePibwyG3r+CL8K8SUDpjyahDQ5CKt3SnZEDgf
	 seeHWHPd5JU4uWHKEE8KU1vE+RgYQOEjgxuZ8zq2a6PU3Dp+zVy3cZf8N5GIx6nas5HvL
	 oj7J53Zlcz87B4vOlRIVmiW9/pu2l6/EMCox7lmOe4s1w3cJKvGo9l/+8C9+jh0i/Tg1k
	 1KUrdKkIBeUOSiQgMAFb7I/SC31VT5Z1xD8ltIVLkic7jpPhJa19kt5/v1dlzjmMQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fd9B8gzH6yuTYAHPFL3oZFs+sfvHOjx4b9vLpjYRecU=;
	b=GqziQKrTXh1ZLkyLH6YNG69JN9AtGS7DhnEXzqUC6JnZhZQhs0RXxlbx3GEV811NqGlh
	 K21VxJs1oBdU3gNrYFeQ7lq8NQu2/D/ikfKoLMSXIGPUxhet6EDX2kjfDayJFhTPqPCZt
	 F5rruJWm5HfXe510z9pzfXcyhhZ9Np3Y/lWgwK93q2w50kanc2ekfIdk1NkG25UyoeefC
	 kGY0zDXRJSU3Y69hiZiC+SD4HYWuMYaPOmQO9BKZh8WEF4v4UdIA7HK/Jc740DNF5BVb1
	 akLwdZcDNUujb2CkE5+zBJlB+MjC/jQwAGVWB+JMaA18eaZijViO7R9RKjnouIUMRUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PpPg/GV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C3606A31F
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpPg/GV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1701F01829;
	Thu, 22 Oct 2026 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706559;
	bh=fd9B8gzH6yuTYAHPFL3oZFs+sfvHOjx4b9vLpjYRecU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpPg/GV/m9jqYn1UfJL4Xe8lcStDEWdU17DxlTTSLToaU6BaGGhMzxiGKdNKu3rRU
	 4zI0fS2C1jeI1s0HYn1zcRViaPQGn04isNSKQIlXp+u4qXYgFTGZzn3dqIbB43cyz9
	 n4VEVPae+yy+CNFuKbSCZxNbvFGlgZ5BTS0eV5bWDH0VddEUjF9kGhYeNAh29oGb+h
	 8fJLfgmK/udh1BXKILw3S98qV2Qo3xOse1PTi0XmHoqXaGIJxJLiVB6Zva+Z4X/Lwy
	 KYbOCpQKJ+TGOQXbx4ehF7KWoGnu/Wmg51m69cy8RYpJTTX7CtDEVDDhp4HgBnnrYI
	 trdirDclKu/fA==
Message-ID: <sashiko-outbox-182093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Convert all runtime WARNs to ONCE
 variants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022215541.631694-3-seanjc@google.com>
References: <20261022215541.631694-1-seanjc@google.com>
 <20261022215541.631694-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:02:38 +0000
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
- [Medium] KVM: x86: mmu: unconverted runtime WARN_ON() in kvm_mmu_uninit_t=
dp_mmu()
--

commit 835a7acf1a3a4511d7751ba5bd49ae351fd0688c
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Convert all runtime WARNs to ONCE variants

This commit converts non-once WARN_ON() and WARN() calls in x86 KVM that are
reachable at runtime to their once-only variants to prevent a misbehaving
guest from flooding the host kernel log.

[ ... ]

> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 44dad106fad19..945efc1cfaea1 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1368,7 +1368,7 @@ static bool __kvm_tdp_mmu_age_gfn_range(struct kvm =
*kvm,
>  	 * this helper must NOT be used to unmap GFNs, as it processes only
>  	 * valid roots!
>  	 */
> -	WARN_ON(types & ~KVM_VALID_ROOTS);
> +	WARN_ON_ONCE(types & ~KVM_VALID_ROOTS);
> =20
>  	guard(rcu)();
>  	for_each_tdp_mmu_root_rcu(kvm, root, range->slot->as_id, types) {

[Severity: Medium]
Should the WARN_ON() in kvm_mmu_uninit_tdp_mmu() in arch/x86/kvm/mmu/tdp_mm=
u.c
also be converted to WARN_ON_ONCE()?

arch/x86/kvm/mmu/tdp_mmu.c:kvm_mmu_uninit_tdp_mmu() {
	kvm_tdp_mmu_invalidate_roots(kvm, KVM_VALID_ROOTS);
	kvm_tdp_mmu_zap_invalidated_roots(kvm, false);

#ifdef CONFIG_KVM_PROVE_MMU
	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
#endif
	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
    ...
}

Despite having uninit in its name, kvm_mmu_uninit_tdp_mmu() is not a
module-exit helper. When tdp_mmu_enabled is true, it is invoked per VM at
runtime during VM teardown (as well as on the error cleanup path of
kvm_arch_init_vm()):

kvm_arch_destroy_vm() (in arch/x86/kvm/x86.c)
  -> kvm_mmu_uninit_vm() (in arch/x86/kvm/mmu/mmu.c)
       -> kvm_mmu_uninit_tdp_mmu()

Other VM and vCPU teardown checks, such as sev_vm_destroy() and
free_loaded_vmcs(), were converted to WARN_ON_ONCE() in this patch, so
leaving this check unconverted allows repeated warnings on every VM
destruction if kvm->arch.tdp_mmu_roots is non-empty.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022215541.6316=
94-1-seanjc@google.com?part=3D2
