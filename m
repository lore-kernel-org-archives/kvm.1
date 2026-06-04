Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010363DFC98
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564289; cv=none; b=mZVVa28e+dLfGgwbTNlSxA6DfWpcTKs2rrJ4bDW0+do8bQYm1MHfhKPi2LyiCAgCkjG3warQ8HNfnbCEoj7ZSyMBvOFQEsOpxLiVzvLloPq5DwFvoSQTuxqd4G7ucJcBD1HflxmkQFaEO0l4TZwS/dOLPgrraZ36wZY/W6Dj8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564289; c=relaxed/simple;
	bh=Xa3tWZFdSxu86hvxYlbTgy4Rm9ekfTlrQcs7Ipt1ekY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rwi3WP1xnJCN39O3gSrFZVDT/bgYc35LXPUqj+RIu85HUHlLKC2ZlM9OrbKLTE2CAOnzjkSudBfsoX5P3aLILQ7xE2sGKEz4RGMnduZw+ViM5HyB5pnmMBtWJRrPHmYUjz5rmUPezF6XMZdGSQAdOex9ehrJS8pA1Wyo/jDPGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNMj+aL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNMj+aL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F0D1F00898;
	Thu,  4 Jun 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564287;
	bh=UHL05Q1MYJheI/0cXMnlVR5EzF1cIyhk9rAZoMHk4DY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNMj+aL+It5Yxet16sMxxP8PzWXy6L4SpQqRpMU3ADy9Zk3yTzTkwONCPxAzKBRTd
	 N+DWllPN8WbcFu5MZAyZxm2GG8cvDNr5h/ZUtr+pwOHT/W+IxoOhLEYq7KHdXwJTyP
	 O/IdcB/SHCGbhV8unBr6f7lcjTU6rbp9NWngH0Pln0Jsvj6rmihaR2bwKlcUuL8qkp
	 Sgw7Q4HXraCfCgUZzAnYUubgH3ttYSfOX8St0zDxqe1cJiRsHGMEQHpFGVXxXk852S
	 iYmnXZrWQdWCPZTiID9kmDtsGIalf+5R+ItsazEMQN9RbHQ5rTzP20k88/Rb678bAx
	 jZs8xWFVBaSFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: LoongArch: selftests: Add FPU test case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604085752.2820331-3-maobibo@loongson.cn>
References: <20260604085752.2820331-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:11:27 +0000
Message-Id: <20260604091127.B9F0D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Missing register clobbers for `$f0`, `$vr0`, and `$xr0` in inlin=
e assembly.
- [Low] Missing `break;` or `/* fallthrough */` annotation in the `switch` =
statement for `case UCALL_DONE:`.

Pre-existing issues:
- [High] KVM_GET_FPU and KVM_SET_FPU ioctls incorrectly copy only 4 bytes p=
er FPU register instead of the full 32 bytes (256 bits).
--

commit e7df5d9c391e26058b67115312055b29d7797eda
Author: Bibo Mao <maobibo@loongson.cn>

KVM: LoongArch: selftests: Add FPU test case

Add FPU test case and verify FPU register get and set APIs, the
FPU width supports 64/128/256 bits.

> diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/tes=
ting/selftests/kvm/loongarch/fpu_test.c
> new file mode 100644
> index 0000000000000..459996286c832
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "loongarch/processor.h"

[ ... ]

> +static void guest_code(void)
> +{
> +	unsigned long val;
> +	struct kvm_fpureg *fp =3D &vector;
> +
> +	val =3D csr_read(LOONGARCH_CSR_EUEN);
> +	csr_write(val | 7, LOONGARCH_CSR_EUEN);
> +
> +	__asm__ __volatile__("fld.d $f0, %0, 0\n" : : "r"(fp) :);
> +	GUEST_SYNC(0);
> +
> +	__asm__ __volatile__("vld $vr0, %0, 0\n" : : "r"(fp) : );
> +	GUEST_SYNC(1);
> +
> +	__asm__ __volatile__("xvld $xr0, %0, 0\n" : : "r"(fp) :);
> +	GUEST_SYNC(2);
> +
> +	__asm__ __volatile__("fst.d $f0, %0, 0\n" : : "r"(fp) : "memory");
> +	GUEST_SYNC(3);
> +
> +	__asm__ __volatile__("vst $vr0, %0, 0\n" : : "r"(fp) : "memory");
> +	GUEST_SYNC(4);
> +
> +	__asm__ __volatile__("xvst $xr0, %0, 0\n" : : "r"(fp) : "memory");
> +	GUEST_SYNC(5);

[Severity: Medium]
Are we missing register clobbers for $f0, $vr0, and $xr0 in these inline
assemblies?

Since these statements load and store values into these registers, without
clobbers the compiler might allocate variables to them or use them for
standard floating-point operations. This could lead to their values being
silently corrupted.

> +
> +	GUEST_DONE();
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +	int cont;
> +
> +	cont =3D 1;
> +	while (cont) {
> +		vcpu_run(vcpu);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_PRINTF:
> +			printf("%s", (const char *)uc.buffer);
> +			break;
> +		case UCALL_DONE:
> +			printf("FPU test PASSED\n");
> +		case UCALL_SYNC:
> +			cont =3D 0;
> +			break;

[Severity: Low]
Is there a missing break or fallthrough annotation here for case UCALL_DONE?

While it successfully terminates the loop by falling through to case
UCALL_SYNC, omitting the annotation might trigger -Wimplicit-fallthrough
warnings. It could also lead to regressions if a break is later added blind=
ly
without setting cont =3D 0.

[ ... ]

> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	sync_global_from_guest(vm, *fp);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx=
",
> +			fp->val64[0], fpu.fpr[0].val64[0]);
> +
> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got=
 0x%llx %llx",
> +			fp->val64[0], fp->val64[1],
> +			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);

[Severity: High]
This isn't a bug introduced by this patch, but will this test actually pass?

In arch/loongarch/kvm/vcpu.c, kvm_arch_vcpu_ioctl_get_fpu() and
kvm_arch_vcpu_ioctl_set_fpu() calculate the copy size like this:

memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], FPU_REG_WIDTH / 64);

Since FPU_REG_WIDTH is 256, this evaluates to 4 bytes instead of 32 bytes.
Because memcpy expects bytes, it seems the ioctls will only copy 4 bytes
(32 bits) per register instead of the full 256 bits, leaving upper bits
uninitialized.

Does this pre-existing bug cause these newly added 128-bit and 256-bit
assertions to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604085752.2820=
331-1-maobibo@loongson.cn?part=3D2
