Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66B3F86EA
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746324; cv=none; b=tiB8MQU4Wks9buypK9mXXSzb1aCeB5LCnSu3THermswXmmR3WvQD+gUKgw5rvFGCA7a3csPEWj6pq6BPw0/M1Wb4Fnx5GPIj9/pZvK2vNSFgkymVY3nlCZMEYByss7Xmfm8mRuejWWDOjYVkblbZh3ULfqnHAeYc5yc4mVS9N/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746324; c=relaxed/simple;
	bh=mefwxJrKd2nD3WOkC0USLEM7UfLiJXC9zVnrsZeygko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cY2d6NFInAMLroPSkLY8JkyA9CWtt6wgPOpABS+Ah/RlbbxY8KIEBLy8NVt5RwSqAXGU/aJnG/M0llvzcRGUqrXJ0LPCdpTtKhq7vwAtMzB64sAY1MNIFfhy1H791IlbrLyt4Zv4SpgRZAa5ISUmUtfVKVCniQtisAKsR/wJzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP1TXJ2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP1TXJ2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E7A1F000E9;
	Wed, 26 Aug 2026 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787746320;
	bh=BPpLnkjB70kYtqC9kG8cnVT6ZHKNLmaHQrI7GzxyJfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cP1TXJ2NTJbWW/y340uyYYPqKpoSO+KHyvylukdPNYkdYz/sRKQWQSPCOlvmVhQjz
	 QoGjksqEosxE6j+RNR+NVl8XcQC42B8YKBbnP2uYl1LdF1kVgLdnlc9uM/xMvzrJoL
	 DCxUsX4ZVOJ4b1WpmbQzN7N8YNntwarsWYz8vO6A60hgiRqj+/pycskS81zWzDZenR
	 hEbAShsIT1faIkwjTfAWVsPpV3sZH2PEErkTxAYT4d1n89DVTuDyU6/ePwvoBAKp+c
	 qgItG+hVrFBmeTa8yZsXISBEKAfYPt5EcVPsPu3J24dc+mMfx1Q3qPIb80+5GdAifu
	 IYejfplQfGZ5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: selftests: Add a helper to read a vCPU's
 APIC ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826115915.2882221-2-hemanth.selam@gmail.com>
References: <20260826115915.2882221-1-hemanth.selam@gmail.com>
 <20260826115915.2882221-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 12:11:59 +0000
Message-Id: <20260826121200.79E7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vcpu_get_apic_id() incorrectly computes the APIC ID for x2APIC v=
CPUs, particularly when KVM_X2APIC_API_USE_32BIT_IDS is enabled, returning =
0 for typical APIC IDs and truncating IDs > 255.
--

commit dd16ed0d3dc6ed699be3a1e4ae7b88bd360cc286
Author: Hemanth Selam <hemanth.selam@gmail.com>

KVM: selftests: Add a helper to read a vCPU's APIC ID

This commit adds a helper function to read a vCPU's APIC ID directly from
the host. This prevents tests from having to open code the KVM_GET_LAPIC
ioctl when targeting a vCPU with an IPI.

> diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testi=
ng/selftests/kvm/include/x86/apic.h
> index 31887bdc3d6c4..293044c81228d 100644
> --- a/tools/testing/selftests/kvm/include/x86/apic.h
> +++ b/tools/testing/selftests/kvm/include/x86/apic.h
> @@ -79,6 +79,15 @@ void apic_disable(void);
>  void xapic_enable(void);
>  void x2apic_enable(void);
> =20
> +/* Reads the APIC ID of a vCPU from the host, e.g. to target an IPI at i=
t. */
> +static inline u32 vcpu_get_apic_id(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_lapic_state lapic;
> +
> +	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
> +	return GET_APIC_ID_FIELD(*(u32 *)&lapic.regs[APIC_ID]);

[Severity: Medium]
Does this unconditionally apply xAPIC bitwise extraction, failing to account
for the x2APIC format where the ID may be stored unshifted or exceed 8 bits?

If a test invokes vcpu_get_apic_id() on an x2APIC vCPU and the VM has
KVM_X2APIC_API_USE_32BIT_IDS enabled, KVM stores the unshifted 32-bit ID in
the APIC_ID register, but GET_APIC_ID_FIELD shifts it by 24.

If not enabled, KVM shifts the ID by 24, but GET_APIC_ID_FIELD applies an
8-bit mask (0xFF), silently truncating any x2APIC ID > 255.

This incorrect APIC ID computation could cause tests that rely on this
helper for cross-vCPU IPIs to target the wrong vCPU (often ID 0), leading
to test failures or false passes.

> +}
> +
>  static inline u32 get_bsp_flag(void)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826115915.2882=
221-1-hemanth.selam@gmail.com?part=3D1
