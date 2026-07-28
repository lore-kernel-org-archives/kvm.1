Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA522EC0A2
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252394; cv=none; b=bjBuJqTbpE1WI6jiLQkFz69ORRQzZRu7H3Q7lXUEaGTA8HK7wD139KiEjnRltaSOsvbJlTW3Oppcaeidkd9KBb8qyYNkWThr17RYv/IKrq+iw/8wRoDNLOkEAyVywlU55Ea35MqxY8+/RE+LJ//UhzMfiVek/clibQjrswSEsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252394; c=relaxed/simple;
	bh=TJYRrVrBjoYMREvEMo+yvpJ8gXvVXofUFM9OurVOYXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LymofI60rSEvLMU9O+zc3/aJjLWoJQdt/QlQtYUD9avM4G1N1oZIwC8JoOm7gk92bDCELX36f7TWEneUGr4CrIw0vv9AO8sn8BVmTHHOfGcIIVtgeXMiV/qEMTL5bWkP3hOjYkwhIi1RjNzbnUu4AQZc4HlhJJWpC7MOiLBrOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goSVL17N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goSVL17N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1300C1F000E9;
	Tue, 28 Jul 2026 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252392;
	bh=pA45KeLruzR/AzbKuHazT5v3whlDOEom7SWF5W2YUI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=goSVL17N1Dlxlef07aGp+SYNlzkzjNS/OwhrbyP4KTpGwirLgaZcgP8XJWQmfljFp
	 jrtabCIhtr7w9HRPvPsUqRLW76PQpjQKuhNbOXFfTsP92EXfwkxejtJXWHWffLWtNO
	 BDKSHve528ZG7TCm9Mbz1a/K7FUGppjRariUomDRLHUJK9DSQ/j05CgPGZXwCCVjU3
	 KCkuPI/0Q8hCLuSeeWYfggUBBni1zpoBaFYjDOxJdrZm/8YAISZVv/QxfkMjd8Mgod
	 wwf48IdWpve2DVPBUlPjyeBOq8PgTv7s7U7tA8kwFuXPWSn+tYsCsiMgSv0jFgWTOm
	 AsiD3OKUosSgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 32/36] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-33-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-33-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:26:31 +0000
Message-Id: <20260728152632.1300C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The documented algorithm for TSC migration calculates the destin=
ation TSC incorrectly by omitting a unit conversion factor.
- [Medium] The exemplar test contradicts the documented procedure for setti=
ng guest TSC frequency.
--

--- Patch [32]: [PATCH v7 32/36] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix t=
he documentation on TSC migration ---
commit 24bf59a7caece6b1df9bc880e92f05672eb883ff
Author: David Woodhouse <dwmw@amazon.co.uk>
KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration

This commit adds KVM_VCPU_TSC_SCALE to extract the actual scale ratio and
frac_bits, documents the process that userspace needs to follow to preserve
the TSC across migration, and adds an exemplar selftest.

> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt=
/kvm/devices/vcpu.rst
> index 66e714f2fcfa7..2b8ab8995079c 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
[ ... ]
> +From the destination VMM process:
> +
> +4. Before creating the vCPUs, invoke the KVM_SET_TSC_KHZ ioctl on the VM=
, to
> +   set the scaled frequency of the guest's TSC (freq).
> +
> +5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_dst) =
and
> +   host CLOCK_REALTIME nanoseconds (time_dst) at a given moment (Tdst).
> +
> +6. Calculate the number of nanoseconds elapsed between Tsrc and Tdst:
> +
> +   =CE=94T =3D time_dst - time_src
> +
> +7. As each vCPU[i] is created:
> +
> +   a. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scal=
ing
> +      ratio (ratio_dst[i], frac_bits_dst[i]).
> +
> +   b. Calculate the intended guest TSC value at time Tdst:
> +
> +      tsc_dst[i] =3D tsc_src[i] + (=CE=94T * freq[i])

[Severity: Medium]
Does this formula need a unit conversion factor? If =CE=94T is in nanosecon=
ds and
freq is in kHz, multiplying them directly yields a result that is off by a
factor of 1,000,000.

The new test performs this calculation with the division, which appears
correct:
tsc_dst =3D tsc_src + (uint64_t)((int64_t)freq_khz * delta_t / 1000000LL);

> diff --git a/tools/testing/selftests/kvm/x86/pvclock_migration_test.c b/t=
ools/testing/selftests/kvm/x86/pvclock_migration_test.c
> new file mode 100644
> index 0000000000000..3b675827aec34
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/pvclock_migration_test.c
[ ... ]
> +	/* =3D=3D=3D DESTINATION SIDE =3D=3D=3D */
> +	pr_info("=3D=3D=3D Destination VM =3D=3D=3D\n");
> +	vm =3D create_vm(&vcpu);
> +
> +	/* Step 4: KVM_SET_TSC_KHZ */
> +	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)(unsigned long)freq_khz);

[Severity: Medium]
Is the documentation correct that KVM_SET_TSC_KHZ should be invoked on the
VM before creating vCPUs?

The code here invokes KVM_SET_TSC_KHZ on the vCPU after creating it, which
contradicts step 4 of the documented procedure above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D32
