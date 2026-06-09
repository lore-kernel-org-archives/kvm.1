Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E43DB64E
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990798; cv=none; b=FZkSrzRtcwSrNIWHDGmYTv5SBkyYVvjxGha41XI28yHenDQgwXQKqjlQvaXza46twk8x79KBpOQkCZY3bjZCSF5t+SwqG28QvuS4aplJ1C3SZzOL9p0oCBDbZqrdjRd3/XtZliLqlDai5XSc0sB+eqjoCuK2egz/SVu15zHBI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990798; c=relaxed/simple;
	bh=rLdPNJBT+3v9nbZ+lPyPAWI2n4gAUZ+qcnaelCReKpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFXfAMqgFWLP5fEpjI3wPbk1x5ikCNZOi/hT1aOVRMltW8U+geYrYxUun3X9r+WIkiOMY+jY5TPejRr97W4fv94V3ZxiVlLSL4YubLZ3DPqJdT8DYs4z8lBrmZgHpJq23NFME9p2NY6JTo6xLjzP1BL9hi8JlhSbCQFWcVGnWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyL5EXu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyL5EXu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3865C1F00893;
	Tue,  9 Jun 2026 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780990797;
	bh=dHQ+ZEUoQiWZXcTh3paS+60oNcvVENwd9O4yL5enxhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyL5EXu4lmXehKgCAEct5rnUGjBp1o4x00DZ333aPxcNv7Laq+9mDDhgJuJ523o3z
	 alaS0CT9rUxtXEzH3t5K742MtJKd1N2Yb7xmDjMmBk7jKaJ0uCSNdUfWwNhUUCYNvO
	 2v6GfqtGGVJjXksmdDO0cEE6yqmBmdW+iwozWtfXVvQr0561Bm//SRp2x561r6q4lI
	 7WUng1PUanmusWRVYG71PHIWc4b6pdLk280mvBvOoFTIvCQqw9uhI351flV3nXDZkL
	 pYan4UwYfNn0gp8AvuCt9Xt+toauZSxoKsGfqm6YBzEa/Dt3UIrtzsTa1W9wOnSaYa
	 NJazZZFmOh5mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: LoongArch: selftests: Add FPU test case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260609072715.1005923-3-maobibo@loongson.cn>
References: <20260609072715.1005923-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:39:56 +0000
Message-Id: <20260609073957.3865C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest fails to actually verify that `vcpu_fpu_set()` modi=
fies the guest's FPU state, silently passing even if the SET API is a compl=
ete no-op.
--

commit d53e91be78e2fb09e2650551dd5ea13d9268274c
Author: Bibo Mao <maobibo@loongson.cn>

KVM: LoongArch: selftests: Add FPU test case

Add FPU test case and verify FPU register get and set APIs, the
FPU width supports 64/128/256 bits.

> diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/tes=
ting/selftests/kvm/loongarch/fpu_test.c
> new file mode 100644
> index 0000000000000..5bccce9db5d01
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c

[ ... ]

> +	fpu.fpr[0].val64[0] +=3D random();
> +	vcpu_fpu_set(vcpu, &fpu);
> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	sync_global_from_guest(vm, *fp);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx=
",
> +			fp->val64[0], fpu.fpr[0].val64[0]);

[Severity: Medium]
Does this logic actually verify that vcpu_fpu_set() successfully modifies t=
he
vCPU's state?

If vcpu_fpu_set() is a complete no-op and fails to update the state, the vC=
PU
would retain its original state. The guest would store this original state,=
 and
vcpu_fpu_get() would retrieve it. Thus, both fpu.fpr and fp will contain the
old un-mutated values, and the memcmp() will evaluate to 0, falsely reporti=
ng a
pass.

Should this test also assert that fp (or fpu.fpr) matches the mutated value=
 we
intended to set?

> +
> +	fpu.fpr[0].val64[0] +=3D random();
> +	fpu.fpr[0].val64[1] +=3D random();
> +	vcpu_fpu_set(vcpu, &fpu);
> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	sync_global_from_guest(vm, *fp);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got=
 0x%llx %llx",
> +			fp->val64[0], fp->val64[1],
> +			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);

[Severity: Medium]
Does this have the same validation flaw as the previous check for the 128-b=
it
vr0 registers?

> +
> +	fpu.fpr[0].val64[0] +=3D random();
> +	fpu.fpr[0].val64[1] +=3D random();
> +	fpu.fpr[0].val64[2] +=3D random();
> +	fpu.fpr[0].val64[3] +=3D random();
> +	vcpu_fpu_set(vcpu, &fpu);
> +	run_vcpu(vcpu);
> +	vcpu_fpu_get(vcpu, &fpu);
> +	sync_global_from_guest(vm, *fp);
> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
> +			"Wanted 0x%llx %llx %llx %llx from xr0, got 0x%llx %llx %llx %llx",
> +			fp->val64[0], fp->val64[1], fp->val64[2], fp->val64[3],
> +			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
> +			fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);

[Severity: Medium]
Does this also have the same validation flaw for the 256-bit xr0 registers?

> +
> +	run_vcpu(vcpu);
> +	kvm_vm_free(vm);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609072715.1005=
923-1-maobibo@loongson.cn?part=3D2
