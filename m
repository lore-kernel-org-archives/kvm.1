Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886321;
	b=g8A4izdAOVgRkO9maKxuJlWGM73JP9WF2OcEIjpqwQlewARYtmO3idpaa6GVfFzs3sxo
	 MkRBDhbwUAHFsdpXOLLsCVfGVA83zLW1KjNmlJiwhhpNBgs5G/LMaVkMEIK37iMP4P4I4
	 RoUMNXPb04/22eDT0+tA5sXHuTLDW6VAfHHy3F13Yo3T5QtpJcVjauH71cW90/Y5skffa
	 PcO0f3EP4sIW96W74URy8IYriLV1etjaLbbBaojKyEzmXEe2gwkRYw8MXqwFMZykWyUT/
	 riuH+l0UOTDLflTUV//CEqt+7mLiZREp/ydpRlypFLHMxoVqm/rWvDqKNF5iMZCs2pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H8YT2SwEJ6hDW+M6wbdoXxFfBstZcoEWctkgKEGvgbE=;
	b=m2esWHePO/GBU/aJtlSBPBospYXHP/MnhQPY5ndB4wHtXYox66CtuiwOS9C5GfF67WiI
	 ku2MkX1tSaCGBDe57BBRRTM8VkUBR63i8MLQg9NNM+McidXUM+eEP7qIIAN0kULCBwA2t
	 builK8j11KBDqcxjT2ME6Ql8K1msGAuaRLvrCD9AfkHK+ShTmAZQNAP9cRWO3etWyry7j
	 K3XOU6pnwPgj4ElWnnpfJL5RfJ+e7N0GVr7Iylbj7L6KsHnejpQsnxkioIB89x22HskE5
	 NAx7h7V/Ruda1XKxIfqmtYHCOhzuVRVlSDt9eGds8pPzNeTI6L5t/Hc7fp8+OhrioVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wm3gkblZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E7606A33F
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wm3gkblZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA76A1F000C5;
	Tue, 17 Nov 2026 03:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794886320;
	bh=H8YT2SwEJ6hDW+M6wbdoXxFfBstZcoEWctkgKEGvgbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wm3gkblZtmOR/RJf/pmulI3Bzm3Obt7LFaqtJD46cGowuDK1TGabiHnJM6zGNyV+c
	 gk0+nveBRQXcIqDVqAsAMBUAanADG2VZSuh5B4wjabmmppSLH15ZWV8gM5KEvSr1Qk
	 OcCB1ciDqMB0YZ90qDG7O3KFr6GuMDIPndUaNZbdJqHKD7o8VH+DgiZChPaD3exjkr
	 HohRkpyuGrvZ5z9izVlqK3ouF2NM/NZQDJuhAvHnCjttMSLzRQ9dxFuDHMXc1sp2La
	 J/m6uKzQLbZsny+6ZOgS9oH6OuGb0qQz4nKhhi4H/2xiRkc1lkX4miOYBgkhMxnrni
	 GGs3RO6WidGvA==
Message-ID: <sashiko-outbox-218142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: KVM: PPC: Book3S HV: Clean up on uvmem
 initialization failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261117032247.1053075-1-haoxiang_li2024@163.com>
References: <20261117032247.1053075-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:32:00 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: PPC: Book3S HV: inaccurate Fixes tag and subject prefix
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] KVM: PPC: Book3S HV: missing nestedv2 cleanup in
  kvmppc_core_vcpu_create_hv() [1]
--

commit 07a9a6f45bc7e7b1aca445fde7a6c5495883e5b7
Author: Haoxiang Li <haoxiang_li2024@163.com>

> fix: KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
>
> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
>
> Fixes: ca9f4942670c ("KVM: PPC: Book3S HV: Support for running secure gue=
sts")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

[Severity: Low]
In commit ca9f4942670c ("KVM: PPC: Book3S HV: Support for running secure
guests"), kvmppc_book3s_init_hv() had no err: cleanup label and ended
with return r right after calling kvmppc_uvmem_init().  The err: cleanup
label calling kvmhv_nested_exit() and kvmppc_radix_exit() was introduced
later by commit 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory
if module init fails"), which converted the other failure paths to goto
err but missed the kvmppc_uvmem_init() check.  Backporting this patch to
a tree without commit 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated
memory if module init fails") will fail to build because the err label
does not exist, so the Fixes tag should point to that commit instead.

Also, the commit subject should drop the leading "fix: " prefix and start
with "KVM: PPC: Book3S HV:".

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 22283d46e8fe6..620097f292b89 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
>  	r =3D kvmppc_uvmem_init();
>  	if (r < 0) {
>  		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
> -		return r;
> +		goto err;
>  	}

[Severity: High]
This problem wasn't introduced by this patch, but in the same file
kvmppc_core_vcpu_create_hv() has a similar error-return leak [1]
when vcore lookup or creation fails:

arch/powerpc/kvm/book3s_hv.c:kvmppc_core_vcpu_create_hv() {
	...
	if (kvmhv_is_nestedv2()) {
		err =3D kvmhv_nestedv2_vcpu_create(vcpu, &vcpu->arch.nestedv2_io);
		if (err < 0)
			return err;
	}
	...
	if (!vcore)
		return err;
	...
}

When kvmhv_is_nestedv2() is true, kvmhv_nestedv2_vcpu_create() allocates
guest state buffers and message structures in vcpu->arch.nestedv2_io.  If
vcore is NULL (for example, when kvmppc_vcore_create() fails or the vCPU
ID collides), returning err directly without calling
kvmhv_nestedv2_vcpu_free() leaks those allocations because the caller
kvm_arch_vcpu_create() only unwinds via kvmppc_subarch_vcpu_uninit().

[1] https://sashiko.dev/#/bug/linux-46c997c5-a07e-43e8-b2c9-b5fd597c3c0c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117032247.1053=
075-1-haoxiang_li2024@163.com?part=3D1
