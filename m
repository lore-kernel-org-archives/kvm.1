Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9940DFB6
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888767; cv=none; b=aQB0r5c0RPIUUU1bGdu/ks0HuDtjUGFiMwnbbQhfPLA9izgDGZHcGVblwRFazi4/7hzghRQuUHppOPYuXlnU/hp1ktNuILWTiov678xqGGRqWlStUvgqDc+B+CD105ADSs0/t6S5S9r1FR/rPAeIlHjD1KR191UFkB3x4teQwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888767; c=relaxed/simple;
	bh=nHxCvMt8mDytJgMjaUw4z4vw03dWooYH1/hea6CnYfw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uB2FVDX/Tso4Nm5uniUrpcKk4KEVAqtF2c1/2FBQSHsrOfbY/9xzdZudWCx6gKR+7VA30Mjdl0kceLQM4po/QQL29hk7Kdt426OPTKcRlmbqPEMClPoEn3xotZYNFNi0m7UdK2djRHSQdzKHuLvlLYMa1PSZ1lR/De3E50+2P34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si53YlWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si53YlWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D501F000E9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888766;
	bh=DSBT5YBxTZz4CzRcFm7NIe+OsuGHiBnjci1SR+eEU58=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Si53YlWDtFOT0i8dadigm5IqOK8pqrixeJC0FUGLH2hYxl/z5w2//RmfJUw6T+XL/
	 5g+4OM8mKrR1K03xuuCphWN3G2Y+PysNVuPNoyIKo86PGYsG0uUZO0xsvrZrqgpDxw
	 WJyt5bS4poPc6rGZELsG8mE7DVaHXIA68Cs5mQ1eVdYPAwpKxo670WUafC/BdSmp6O
	 CcgJUsnHTn8Kj30TviALHe+63peAzYxJF93nHN15yYcQQn190BLYycZIXY6wlN+rhZ
	 iHML/NrJ4nqVBhkJZUDz1X4aSGh8IB+4y/RGaUK9Q/oQ/BPWkKXaGPqSZ8dsEuYXlK
	 kTXZGSjGgV11w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 03/10] KVM: PPC: selftests: add support for powerpc
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <99818a9e1c8954ba74e1861dfa2bd5eee19f4f86.1779885589.git.ritesh.list@gmail.com>
References: <99818a9e1c8954ba74e1861dfa2bd5eee19f4f86.1779885589.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 13:32:45 +0000
Message-Id: <20260527133246.26D501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Global exception handlers array leaks state across VMs and cause=
s race conditions in multi-VM tests.
--

commit 4362b48fc35809ad7a74045c726f7ffae0c70ccd
Author: Nicholas Piggin <npiggin@gmail.com>

KVM: PPC: selftests: add support for powerpc

This commit implements KVM selftests support for powerpc (Book3S-64),
including ucalls and virtual memory for the radix MMU.

> diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/=
testing/selftests/kvm/lib/powerpc/processor.c
> new file mode 100644
> index 0000000000000..9846ec26a32aa
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c

[ ... ]

> +struct handler {
> +	void (*fn)(struct ex_regs *regs);
> +	int trap;
> +};
> +
> +#define NR_HANDLERS	10
> +static struct handler handlers[NR_HANDLERS];

[Severity: Medium]
Could this static global array cause state leakage across VMs or race
conditions in multi-threaded tests?

Since this is defined as a static global on the host rather than a per-VM
allocation, a new VM will start with a zeroed guest handlers array (from ELF
loading), but the host's handlers array will retain entries from previous V=
Ms.

This appears to limit the total number of unique handlers that can be insta=
lled
sequentially across all VMs in the entire test process to 10, which would
eventually result in the "Out of exception handlers" failure below.

Additionally, if multiple threads concurrently create VMs and install excep=
tion
handlers, would they race on this shared host array and sync corrupted stat=
e to
their respective guests?

> +
> +void route_interrupt(struct ex_regs *regs)
> +{
> +	int i;

[ ... ]

> +void vm_install_exception_handler(struct kvm_vm *vm, int trap,
> +			       void (*fn)(struct ex_regs *))
> +{
> +	int i;
> +
> +	for (i =3D 0; i < NR_HANDLERS; i++) {
> +		if (!handlers[i].trap || handlers[i].trap =3D=3D trap) {
> +			if (fn =3D=3D NULL)
> +				trap =3D 0; /* Clear handler */
> +			handlers[i].trap =3D trap;
> +			handlers[i].fn =3D fn;
> +			sync_global_to_guest(vm, handlers[i]);
> +			return;
> +		}
> +	}
> +
> +	TEST_FAIL("Out of exception handlers");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779885589.gi=
t.ritesh.list@gmail.com?part=3D3
