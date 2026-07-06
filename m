Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0072F8BC0
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305577; cv=none; b=oWtDUM/3Zx6yZ7D+AOpgNkG0wozqdIR6x4bTMlFCm2R3i8kgRLGUh4tX/VJkkV1T3uod2uuOYB/TRdpbferI8TXor2LwyVC1ATUK7YIuZOe6isiIDs8eCerz7522YlY+X1/64NAoZGfsZx80HvvoY0cio9+uuEZ3TMvkNmx1W7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305577; c=relaxed/simple;
	bh=cE40ZBpM/d4vizV6Fn/t7Vl9Wpes68ouEc9J7ryp/JU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cPXtpkGqJQKZ1aybltB1gRn9Oz4y8IZJEOr16y65ZVcsc4ALGOSlRD0XFQfA068WAKDVbhPtraLVRLbdJn8Fwkx7N09JJu4OLFVHrXCAxAgYy70d2mPWiulWx8PVzm1FY2avS9bX2X3vTm+by9EeZhnMaQx1jfJkHKxUspQm6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuEAhUPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuEAhUPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A001F000E9;
	Mon,  6 Jul 2026 02:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305576;
	bh=A9CZEQvmXw7L/nldlwUaCcxtz3E83vWMNPKOJne3Wu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VuEAhUPxXG5RiFykDuVlvTI/6TCE5D+cWoQ2TgplEzRxRJTDofSUIq7oKps82FMgd
	 rPgLW7OeX1rhNsommNJD1Ilo3XXjnWA0MD6fc8AZLVxVCY6sRYUXXmbqC1nMFBiiEN
	 rLgqUtpVBPzzadxegOwN+LM5ISlahuOLUiJhc1s0G/4uE6nVdBLVnXRMWUSIxLYvOc
	 iEyTj40LQqn2/bf1MmA3wPDDYEsv5RY2CeJ45uT4CtunkOGQ7JfBWlk8Q3W6ZRq2RW
	 rBwnnUYT8NNoFqZx9323OnYMTgYe4/qylMnhjasVuDMVr4TLETKJfzLtA4kBFLwCP5
	 yGuqo2txzFN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] KVM: riscv: selftests: add Zicfiss/Zicfilp
 extension to get-reg-list test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706022046.214956-9-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
 <20260706022046.214956-9-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:39:34 +0000
Message-Id: <20260706023935.81A001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `RISCV_CSR_ZICFISS` macro generates an uncompilable C code s=
tring when outputting registers.
--

commit ffbde58160b6dea5b92bb36fa48c6dca47305718
Author: Inochi Amaoto <inochiama@gmail.com>

KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test

The KVM RISC-V allows Zicfiss/Zicfilp extensions for Guest/VM so this adds
these extensions to the get-reg-list test.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 94e33b2ee7963..49a4be8250315 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c

[ ... ]

> @@ -358,6 +360,8 @@ static const char *core_id_to_str(const char *prefix,=
 __u64 id)
>  	"KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
>  #define RISCV_CSR_SMSTATEEN(csr) \
>  	"KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_REG(" #csr ")"
> +#define RISCV_CSR_ZICFISS(csr) \
> +	"KVM_REG_RISCV_CSR_ZICFISS | KVM_REG_RISCV_CSR_REG(" #csr ")"

[Severity: Medium]
Does this macro generate an uncompilable C code string?

When outputting registers (such as when a test fails or when running with
--print-list), this macro will print KVM_REG_RISCV_CSR_REG(ssp) instead of
KVM_REG_RISCV_CSR_ZICFISS_REG(ssp).

Since ssp is in struct kvm_riscv_zicfiss_csr rather than struct
kvm_riscv_csr, copying and pasting this output to update expected register
lists will cause a build failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706022046.2149=
56-1-inochiama@gmail.com?part=3D8
