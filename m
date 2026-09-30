Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A69521888
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804905; cv=none; b=tRII3oAe/xKictf+ZsqZPe/MltXRSPTg++M7mUF7OIh8eIdLh4YzkdSRu3OvbQFIRUNoDDNkIPQ9B5kmC0n3pVkd2KWteKQe3xGDyIyvkq1XDjy3WTBPal4QzcjiG0BDO9NgAqq25zMFK9X/OGptoUpoMalTM1R7miB+xr/hlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804905; c=relaxed/simple;
	bh=5YxQpGujvWkODCGtB19lxg17dJFqM0rs1GSbbs4qo3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2HyAimNX/O1IY6Cso1Uq00ep/ct8GP1NLRsHUcOw/gOZMu9n88YGSFe/E7Th3KCCy/9abn+naHS+CsCfYjr3CNdvbxSKMu93lUfYT+BgioNUCsj9uI+VO9cdkgkJAAYNDoYAaE91k2C0Wr9VGQzA3h5eVcK4Yrm2+M/lmkYAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcS7BwPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcS7BwPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158FB1F00898;
	Wed, 30 Sep 2026 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804904;
	bh=HmNXxbCAcRqbsevfGL+ys9jjDnpPUe1gLVsTQOhkxoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NcS7BwPMEIPGboEvcVPg3eXAsV4qwxp5bYjYovNM1iPQy2lyO5c4XTct33sLOickC
	 bj3Yb4EJFKzSAR1uirZFCFpHc772xIrfsEO9e+47YMZCWpRqxmzoRgVCSsxEEWr09b
	 amtCYAB6i9BkDzk1Tq3OWIkrSYGl7H6TDTkj7B6XM3HK6decSiYNYeAEUCD1/yA09x
	 fl/jVUcfOoB+CilulbJ+ckOlFYS2DtYtEoF944fpfcMqmzapEprla9tc4vEgGzM2sa
	 Qvg2pKObBLPFTPtuUgsmtsn4YBXwNeaBPXw/gXvTT6/q7nRbxuv223YuL4l2oGv8lp
	 CE4Rjp7ZkjBiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/20] KVM: x86: selftests: Add APX state and ABI
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-20-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-20-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:48:23 +0000
Message-Id: <20260930214824.158FB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kselftests: missing volatile in read_egpr() causes spurious test=
 failures
--

commit 9da537583adffa94be39a84efcfb15a0c9610def
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: selftests: Add APX state and ABI test

This commit introduces selftests for APX-specific behavior and ABI
interactions in KVM. It implements guest code to read and write EGPR state
and verifies the state transitions after userspace updates and APX
disablement.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index 6e6f70035508a..6e3e7d96c571e 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h

[ ... ]

> @@ -917,6 +919,124 @@ static inline void write_sse_reg(int reg, const sse=
128_t *data)
>  	}
>  }
> =20
> +static inline unsigned long read_egpr(int reg)
> +{
> +	unsigned long data =3D 0;
> +
> +	/* mov %r16..%r31, %rax */
> +	switch (reg) {
> +	case 16:
> +		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=3Da"(data));

[Severity: Medium]
Does read_egpr() need the volatile qualifier on its inline assembly
statements?

Since the asm statements only have an output operand, standard compiler
optimizations can treat them as pure computations. When called multiple
times, the compiler might cache the result of the first read and skip
subsequent executions, leading to stale register reads.

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/apx_test.c b/tools/testing/s=
elftests/kvm/x86/apx_test.c
> new file mode 100644
> index 0000000000000..4825003d0616b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/apx_test.c

[ ... ]

> +static void test_userspace_update(void)
> +{
> +	/* Userspace updates EGPR state via the KVM XSAVE ABI */
> +	GUEST_SYNC(USERSPACE_UPDATE);
> +	GUEST_ASSERT(validate_egprs(USERSPACE_UPDATE));

[Severity: Medium]
Will compiler hoisting cause this validation to fail spuriously?

This sequence expects the EGPR state to be read strictly after the userspace
update and the hypercall returns. Because read_egpr() lacks a volatile
qualifier, the read inside validate_egprs() might be optimized away. This
could cause the test to use a stale cached value from earlier and trigger a
spurious failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D19
