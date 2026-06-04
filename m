Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86B3890FB
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601755; cv=none; b=KUl0xG9IDCWMG8zlSSECT+Ec5z+/F4pUF79GgDmZXMyH6H4nO1ODtM/VbyaWayJlUV3sIUqJDfWB23+ErG5YAlaFqyPwTFubi2f4qAFq2SqwVVwCl+l1OQvFKFlcoizLm8byJMFd+TF/pVd++zDIfdtbMeOyEIF0F1/fH80uEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601755; c=relaxed/simple;
	bh=GetBA3NQEL5DP/wshPU5F0qHruPz8KpujD7QmlXU6e4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KUS2BEHV4+y68ExgDZz+8DSqWhaNBJhbHiu9CqzCTZMQO3hBzLwth+S/ZC6Xq+GeVSlOyRuSVCisPjvKRbRSWpBMtP2SnpVfEj5wM3YyZ21iBBc6VVI/UgNot5JcSWLZewKG0XukwbBrHd/ws3XW638ikLncY1R93UDGN148R00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgNER3Ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgNER3Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA311F00893;
	Thu,  4 Jun 2026 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780601754;
	bh=aKtdwRIZ1FVgQqSLiAojEk+dtgcHHqJ5Bz64OF+9+uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgNER3Ru5R/mzeVBrdIEC673EvEWxDzfyHNA1eGcBYK6kJx5gpoqgKGWTxU0AIjXM
	 4wQ3utSVayZ6nwtkr2kJWO3gKQdDvvhsS1+6FZZoWnjnyv1qmMJeaR8xL+ZG1me9CJ
	 eAgrwDSCSlIr+8vSGVHEMNvLodgK3zo44LAT90loC29LLWKFSyFLV8dWmHEdj89fYe
	 x5a0BNoO3sGvt4OzLMD8RvzAG0+P/SeP7tWvmMflLGg0SnvhYjR25sSL0ZMujlesOm
	 s3U+yspGQokhWmtV4bZXQsRWj0VbvdocSGz3fayK/YYVgGWxgQ4yGDak6/u0cEzTQ8
	 mbcx4ryaULJgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86/xen: Read long_mode only once in
 kvm_xen_set_evtchn_fast()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hyunwoo Kim" <imv4bel@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <aiHPPUk5DY7rH-zL@v4bel>
References: <aiHPPUk5DY7rH-zL@v4bel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:35:53 +0000
Message-Id: <20260604193554.1BA311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest can trigger a host split-lock panic by placing `vcpu_info` s=
uch that `evtchn_pending_sel` crosses a cache line boundary.
--

commit a112a8243664e8390567ef2c91d59d503bd5858b
Author: Hyunwoo Kim <imv4bel@gmail.com>

KVM: x86/xen: Read long_mode only once in kvm_xen_set_evtchn_fast()

This commit ensures long_mode is read exactly once in
kvm_xen_set_evtchn_fast() to prevent a race condition where a guest might
change long_mode between the port range check and bitmap layout selection.
By latching the value, it guarantees both use the same layout.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index d6b2a665b499d..32af7731c59bd 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -1862,7 +1866,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *=
xe, struct kvm *kvm)
>  			goto out_rcu;
>  		}
> =20
> -		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
> +		if (long_mode) {
>  			struct vcpu_info *vcpu_info =3D gpc->khva;
>  			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel))=
 {

[Severity: High]
This is a pre-existing issue, but can this atomic operation trigger a host
split-lock panic?

If a malicious guest aligns the GPA of vcpu_info such that the 8-byte
evtchn_pending_sel crosses a 64-byte cache line boundary, this
test_and_set_bit() will execute an unaligned locked instruction. On hosts
with split_lock_detect=3Dfatal enabled, could this result in a guest-to-host
denial of service?

>  				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
>  				kick_vcpu =3D true;
>  			}
>  		} else {
>  			struct compat_vcpu_info *vcpu_info =3D gpc->khva;
>  			if (!test_and_set_bit(port_word_bit,
> -					      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
> +					      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {

[Severity: High]
This is also a pre-existing issue, but does this cast in compat mode create
the exact same split-lock vector?

The compat_vcpu_info struct uses a 4-byte evtchn_pending_sel, but casting it
to an unsigned long pointer and using test_and_set_bit() forces an 8-byte
atomic access. If the guest strategically places this struct so the field
crosses a cache line boundary, will this similarly crash a hypervisor enfor=
cing
strict split-lock detection?

>  				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
>  				kick_vcpu =3D true;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aiHPPUk5DY7rH-zL@v4=
bel?part=3D1
