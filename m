Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DD3822AB
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605856; cv=none; b=rMEa9vP5GGPCbE6jCiCJFufJnU88PAn/mlsb5EXvv9N7ySzmyWcUVmZ/YEZ5ds9MsX589SmuRxtQlMhmf1eddYEZc264LI+B9B0LjfM5JCQF/FSptJuoAILpapNGBRLshMz7oVRajza9rR6bFybloVF5mckaR/n9K7OikcVDPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605856; c=relaxed/simple;
	bh=Bfx6vAzbRPmBpi76w7a1l99bMGBPwjGBrvcdp6fV+Yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mAJ1LrQXH39S3m5a6cwyQSOHjNhjm4b/f12KyG0us23p7ZwxYvaoGvhDhH7MLhHJVaRjWImd9iCf4sLg6mfUCHzYYwpp86rB937px7MqWpHiNVmpvZbEtHMLKfNZZAJOhsTfmYqgDE2nc0rHw82DOoeLMDCOGs2uwd0/kw8gTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgkObMfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgkObMfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE0F1F00893;
	Thu,  4 Jun 2026 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605855;
	bh=jgiDjIt/TszzALsi7EsgfpdGNqZ0+kPmgLN7fkTndds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgkObMfGRFvmqTB/552sIwujP6PdvhvsVdHyT6qaMtO+lq+lv6aFMY8RuVxAGLzl+
	 5giCmbxgLW7SYOx7/z+vQT8+WELzeV2D/0Q3QyZkbXCNQ9tA5D729voDJiM7zgdL+3
	 XHAbc0IxD2kps0+TJtf8vm9n8PhirpgsQ2fBPS5Q7YA47K5jyyKKPAj5KvdX/oPpt7
	 Lepq2N2jBJnB6hcrUwHLgpouyGT5T1YXFW2x+fup5nUjD0Nqa3GoQMY4F56Od8U+ax
	 qZX/w/i9RC9OoB9GzBF5b4FazHKyg8ceuIYplfNB5BTWmKOTwWkxt3ltTp2YfCdwE8
	 J9KXmErcaCpwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] KVM: selftests: Use an array for guest_regs
 (and fix offsets)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604203546.365658-4-yosry@kernel.org>
References: <20260604203546.365658-4-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:44:15 +0000
Message-Id: <20260604204415.9FE0F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `guest_regs` array is under-allocated by one element, leadin=
g to an out-of-bounds write that clobbers adjacent memory when swapping the=
 `r15` register.
--

commit 2b93b9d75a4b05f37bd5b56a9795d649f317160b
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Use an array for guest_regs (and fix offsets)

This commit replaces the gpr64_regs struct with an array to eliminate
hardcoded offsets. It also renames the SAVE_GPR_C and LOAD_GPR_C macros=20
to a single SVM_SWITCH_GPRS_ASM macro.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index 513e4a1075fac..ff0b270bfe27f 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h

[ ... ]

> +#define GUEST_REGS_R13	13
> +#define GUEST_REGS_R14	14
> +#define GUEST_REGS_R15	15
> +#define NR_GUEST_REGS	GUEST_REGS_R15

[Severity: Medium]
Does this under-allocate the guest_regs array?

GUEST_REGS_R15 evaluates to 15, making NR_GUEST_REGS 15. However, there are
16 registers in total when counting from index 0 (RAX) through 15 (R15).

> =20
>  struct desc64 {
> diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/se=
lftests/kvm/lib/x86/svm.c
> index f9ea1a2aeb8bc..1bd111e8bed26 100644
> --- a/tools/testing/selftests/kvm/lib/x86/svm.c
> +++ b/tools/testing/selftests/kvm/lib/x86/svm.c
> @@ -13,7 +13,7 @@
> =20
>  #define SEV_DEV_PATH "/dev/sev"
> =20
> -struct gpr64_regs guest_regs;
> +u64 guest_regs[NR_GUEST_REGS];
>  u64 rflags;

[Severity: Medium]
Since NR_GUEST_REGS is 15, does this array allocation leave out space for t=
he
final register?

[ ... ]

> +#define SVM_SWITCH_GPRS_ASM \
> +	GUEST_SWITCH_GPR_ASM(rbx, GUEST_REGS_RBX) \

[ ... ]

> +	GUEST_SWITCH_GPR_ASM(r14, GUEST_REGS_R14) \
> +	GUEST_SWITCH_GPR_ASM(r15, GUEST_REGS_R15)

[Severity: Medium]
Can this write to index 15 clobber adjacent memory?

Because the guest_regs array only has 15 elements, writing the r15 register
to GUEST_REGS_R15 (index 15) writes past the end of the array. This looks
like it will corrupt adjacent variables in memory, such as the rflags
variable defined right below it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604203546.3656=
58-1-yosry@kernel.org?part=3D3
