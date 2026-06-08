Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDD30569D
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936779; cv=none; b=CiGEYgpEadjHS70wIi4GFzJAtnN+UW6EBSZxxV4RyqtSlr2EHntxRElNfqePO+6F0vO79JqX0Jag6N1na0QMUteSGZLuIvMxpRd+PUXYW5+GSCaBXkOD4ESAYLL8E+GKp6BBu7vK4bbKwmrKzexiStln2mx/862IkntlCClmxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936779; c=relaxed/simple;
	bh=YS8jSAGTHN1p+8xkZwmsebfPTzKbkfOhbGwBkcLtjes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M+r9ZXLmmp0S8dICfJqF3cV+D4Q3GodgVi5/rmojKgewxEogUu9mIM5RBnQ2wX3PAH0sCiTSEmUUJ78sPPrYzXtJ3Ut51WrQkImlyvTeZ/YBWGBG82cbvjKsBg4Gn4NEH7PZX4UfPwmlOjMCpBpDldklEaLteVidTkV3c5tpM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvfUZEnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvfUZEnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B54F1F00893;
	Mon,  8 Jun 2026 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936778;
	bh=kc8h8sioyu7QxdgCSvHLx2G+zuNiarScChSLgh1sVA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvfUZEnTUqnsCNitJTF4h4cEQlZAoQvdonPfDiRGZiYWQqYGE0+qVWG/MrtMgO9d9
	 XV7uMZ48wqg9odG7aE9VAP3qIEi8UrMCYAC9kTXIVc0pX/EOT1UQI2Ig3MXsEoU1AL
	 uCUXS9IJeChpkf6zfqQG/q+YeJPcOcQwikgEqlyDMYgnGfuJoAi/sqWk4V52l5N6sg
	 lSj6LI8D2gIkv+TipJYDoY4RwAqYP/4N9Jj+Uv3T5JNnXTbg0ehb6dtbosbjCfCH1k
	 aGWvXEtUQ+OgFJueuxDPy+ce2nkyVaE9jYdSriQ9xStclIiXwgGSMruOLc7sEOk7z3
	 Y4jpq8O/jcziw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/34] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-9-dwmw2@infradead.org>
References: <20260608145455.89187-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:39:37 +0000
Message-Id: <20260608163938.0B54F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing capability check for TSC scaling in `pvclock_migration_t=
est` causes unconditional test failure on unsupported hardware.
- [Medium] Integer overflow in `tsc_dst` and `tsc_ofs_delta_ns` calculation=
s in `pvclock_migration_test`.
--

commit 672fb23aded51a56922a91383781eb9402e95560
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration

Adds KVM_VCPU_TSC_SCALE to extract the scale ratio and frac_bits, and
documents the process for userspace to preserve the TSC across migration.
Adds a selftest to verify KVM clock precision across simulated live migrati=
on.

> diff --git a/tools/testing/selftests/kvm/x86/pvclock_migration_test.c b/t=
ools/testing/selftests/kvm/x86/pvclock_migration_test.c
> new file mode 100644
> index 0000000000000..6a7eaf627d1a7
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/pvclock_migration_test.c

[ ... ]

> +int main(void)
> +{

[ ... ]

> +	uint32_t freq_khz =3D 1500000; /* 1.5 GHz =E2=80=94 forces TSC scaling =
*/
> +	int ret;
> +
> +	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> +
> +	/* =3D=3D=3D SOURCE SIDE =3D=3D=3D */
> +	pr_info("=3D=3D=3D Source VM =3D=3D=3D\n");
> +	vm =3D create_vm(&vcpu);
> +
> +	/* Set guest TSC frequency (may trigger scaling) */
> +	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)(unsigned long)freq_khz);

[Severity: Medium]
Will this unconditionally fail on hardware that lacks TSC scaling?

The test unconditionally forces a 1.5 GHz guest TSC frequency. If the host
lacks hardware TSC scaling (kvm_caps.has_tsc_control is false) and the
physical TSC frequency is greater than 1.5 GHz, KVM returns -EINVAL.

Should there be a check like TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL))
before forcing this, or a way to gracefully handle the error?

[ ... ]

> +	/* Step 6: =CE=94T */
> +	delta_t =3D (int64_t)(time_dst - time_src);
> +
> +	/* Step 7: Compute destination offset */
> +	{
> +		struct kvm_device_attr attr =3D {
> +			.group =3D KVM_VCPU_TSC_CTRL,
> +			.attr =3D KVM_VCPU_TSC_SCALE,
> +			.addr =3D (uint64_t)(uintptr_t)&scale_dst,
> +		};
> +		memset(&scale_dst, 0, sizeof(scale_dst));
> +		__vcpu_ioctl(vcpu, KVM_GET_DEVICE_ATTR, &attr);
> +	}
> +
> +	tsc_dst =3D tsc_src + (uint64_t)((int64_t)freq_khz * 1000 * delta_t / 1=
000000000LL);

[Severity: Medium]
Can this calculation overflow under heavy load?

With freq_khz set to 1500000, the intermediate multiplication is
1.5e9 * delta_t. This exceeds INT64_MAX if delta_t is greater than ~6.14
seconds. While the test uses sleep(1), VM teardown and creation under heavy
CI load might cause the time delta to exceed this.

Could this be rearranged to avoid intermediate overflow, for example:
delta_t * freq_khz / 1000000LL?

> +
> +	if (scale_dst.tsc_frac_bits)
> +		raw_dst =3D (unsigned __int128)host_tsc_dst * scale_dst.tsc_ratio
> +			  >> scale_dst.tsc_frac_bits;
> +	else
> +		raw_dst =3D host_tsc_dst;
> +
> +	ofs_dst =3D tsc_dst - raw_dst;
> +
> +	/*
> +	 * The TSC offset delta introduced by using CLOCK_REALTIME to
> +	 * estimate elapsed time. On same host, the correct offset is
> +	 * ofs_src; the difference is the CLOCK_REALTIME-vs-TSC error.
> +	 */
> +	int64_t tsc_ofs_delta =3D (int64_t)(ofs_dst - ofs_src);
> +	int64_t tsc_ofs_delta_ns =3D tsc_ofs_delta * 1000000000LL / ((int64_t)f=
req_khz * 1000);

[Severity: Medium]
Could a similar integer overflow happen here if the TSC offset delta cycles
are abnormally large?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D8
