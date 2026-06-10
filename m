Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646E3BB40
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053288; cv=none; b=M4YLB2OU4JuADO78dYfaWiAA+MKS0lbHwGKJcehuYq6+psamy3XNIUTvJiyxNNF9BKGYgPkygHGNLtXoOfxG3DNy82O1UCnzZzkKg6nDbgFlM692vAF69OaFKPlv3jlhS/4eIIWJ4CYSv4IaJL2AGIj9WM4u4GbowJysaxionwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053288; c=relaxed/simple;
	bh=3mJwGglQrR1RjowpcwJ1JIgpMgUIszTd4iO29CnpjB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WSPlXYQkI19xhYgYoZHcQwFDZjTKivR/GAjEr7Bo1cgRe5P5bUtUJmjUHHtIjSKdp9eHLRbBX49m+EgZ9qnZoA50NJ4D/n4saWqPOFq8VPJpznWUMa7yvCY5NbWoqDFN9wWcH5FSAVmj0aRN7IKWBDPbmVe5sbmftqCyr4cn0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbs98/91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbs98/91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86D81F00893;
	Wed, 10 Jun 2026 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053287;
	bh=4wEuh530jikmSBBz6UbIRfFXFvFFZpcqmarbNkdp31M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wbs98/91BFETW23VmZoi61c89s3rkJsoSKx91Mdh8no7FYcZfrpNOce5v2Dl/44yR
	 dQNAYYLEZHXn+u3WvpqZ75Epebp3y68h0c+KxWSe4GAu5VNxvshPmC5t3OjZLyutyy
	 53n57la6H0h1w5FdumBzDH2IewTU47nHV/R6y2LdWBQ7rRchWFI+Z4QC5BQb8yNx5H
	 uo8H2C4hCDQNMTgQe5MZEAr5cB9X1Szhh6dUZ03ESuGswLxUY6IC+d7TUds90XM6pa
	 G8x+rHHwZ6eEyxph5j21+nFCE6BpvECXw3hc8S6tV2UDYdDUq8VmPwzPPeNQmI3fVc
	 Xdcsvty/ec0bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/18] KVM: selftests: Add helper to generate random
 u64 in range [min,max]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610005338.2967132-5-seanjc@google.com>
References: <20260610005338.2967132-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:01:27 +0000
Message-Id: <20260610010127.A86D81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm_random_u64_in_range() silently fails to cover the requested =
range because it relies on kvm_random_u64(), which leaves bits 31 and 63 pe=
rpetually zero.
--

commit 7a6b1751be67e53b72972ac1a299690dc79f537f
Author: Josh Hilke <jrhilke@google.com>

KVM: selftests: Add helper to generate random u64 in range [min,max]

Introduce kvm_random_u64_in_range(state, min, max). This function returns a
random u64 in the inclusive range of [min, max] using a struct kvm_random_s=
tate.

> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/=
selftests/kvm/lib/test_util.c
> index e98ca7ef439c4..e208a57f190cf 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -42,6 +42,24 @@ u32 kvm_random_u32(struct kvm_random_state *state)
[ ... ]
> +/* Returns a random u64 in the inclusive range [min, max] */
> +u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
> +			    u64 max)
> +{
> +	u64 value;
> +	u64 range;
> +
> +	TEST_ASSERT(min <=3D max, "PEBKAC, min =3D 0x%lx, max =3D 0x%lx", min, =
max);
> +
> +	value =3D kvm_random_u64(state);
> +
> +	range =3D max - min;
> +	if (range =3D=3D ULLONG_MAX)
> +		return value;
> +
> +	return min + (value % (range + 1));

[Severity: Medium]
Will this reliably cover the requested range?

Since kvm_random_u64() constructs its return value by concatenating two
outputs from kvm_random_u32(), and kvm_random_u32() only returns values up
to 0x7FFFFFFE, bits 31 and 63 of the 64-bit output are always 0.

When this skewed 64-bit value is used to bound the output range, significant
portions of the requested range become completely unreachable. For example,=
 in
a 32-bit range, values >=3D 0x80000000 will never be generated.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610005338.2967=
132-1-seanjc@google.com?part=3D4
