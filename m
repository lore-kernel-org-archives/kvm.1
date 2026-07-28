Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6E2C326D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252124; cv=none; b=N8hZx66QUtG7XGO3dYceYXitFoBE4t2TGMBMdoCB2gHpVKMET3ltXwJ1q8idwjdo1YF11DqYx6FRLQ3dRkz6EY8bGthluipUcwU/kV88TmIriw8mMan2R8qOmP1YzTHV82lg2PIEYjBEMDsD7955GE9IEA+FeYUJTagjalMjNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252124; c=relaxed/simple;
	bh=6Kk5p5eiPh74p6dlRhwhsqS+ljfRwEIBYlaVaTpMyeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fXylbfS1LZCemhErGpaEl9I2nLt9jLEM8fyAlx4PoP+hsn5P1CcrTMVAxG/pTFAKTiGyFCF0oDPfBimlJfsyc8vnxOn45H4vLBiD6Q+vG7CyghlZ66JJPwBSWtWmEK78xeRpGjFZyUOhMQMkabGr+1q0r/BWuThsbdZRFRMyyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCD8M7Sd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCD8M7Sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D151F000E9;
	Tue, 28 Jul 2026 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252122;
	bh=fDDNOYZDyYEQh678J4/av2QkxiqZOAJvollBX1CZQLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCD8M7SdBnlmkUy58CDzs86fn4AxIjFf9r1nnaLUYPzF2yAbGMdYHw8O04fC0NcSU
	 6vaBbEjt0tDuhjCx3o+ZHPHVZlJZYE5mETqGbdEhiLzB8qKcbQiOAJY9vK5/QuNfzy
	 K49Vp1dzESQ/8185RmOQbTFjo/AJtJ0qOj9dS5iepExul7yy3D7w6fd+u/Ru/VLxXT
	 KhCelahriAT0ihnkJkj8Nzxw0EzYZw14eYz6wbbsRFXDsL24tKE5Tw8WbSgm28VMc7
	 jjHQhqhsiiSVH2ZYERtb2T72ksknCKPSSG/WcJx9eknHmnsy28nchQHVxIVR0Eb54J
	 9NUAdWLFLfeiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 34/36] KVM: selftests: Add master clock offset test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-35-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-35-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:22:02 +0000
Message-Id: <20260728152202.A6D151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test uses `__vcpu_ioctl` to query `KVM_GET_CLOCK_GUEST` but =
ignores its return value, potentially leading to the use of uninitialized s=
tack memory.
- [Medium] The test's verification that the clock advanced by 1 hour is ine=
ffective on machines with an uptime greater than 1 hour.
- [Medium] All vCPUs register the exact same guest physical address for the=
ir pvclock_vcpu_time_info structures.
--

--- Patch [34]: [PATCH v7 34/36] KVM: selftests: Add master clock offset te=
st ---
commit 52f3f310d696d962b9db181f0b7e2661011f0cb2
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add master clock offset test

Verify that KVM master clock mode remains active when vCPUs have
different TSC offsets but the same frequency. Creates three vCPUs,
sets one to a different TSC value, and confirms KVM_CLOCK_HOST_TSC
and KVM_CLOCK_TSC_STABLE are set.

> diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/=
tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> new file mode 100644
> index 0000000000000..88e2bd2edab51
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c

[ ... ]

> +static void guest_code(void)
> +{
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);

[Severity: Medium]
Does this code instruct KVM to write to the identical GPA for all vCPUs?
Since guest_code() unconditionally hardcodes KVMCLOCK_GPA, KVM will
concurrently overwrite the same memory area with different vCPUs' time
information. Is this API contract violation intended?

> +	for (;;)
> +		GUEST_SYNC(0);
> +}

[ ... ]

> +	/* Get per-vCPU pvclock in order 0, 2, 1 */
> +	int order[] =3D {0, 2, 1};
> +	for (i =3D 0; i < 3; i++) {
> +		int idx =3D order[i];
> +		__vcpu_ioctl(vcpus[idx], KVM_GET_CLOCK_GUEST, &pvti[idx]);

[Severity: Medium]
Could this lead to the use of uninitialized stack memory? The return value
of __vcpu_ioctl() is ignored, so if KVM_GET_CLOCK_GUEST fails or is
unsupported on the host kernel, pvti[idx] will remain uninitialized.

> +		pr_info("vCPU %d: tsc_timestamp=3D%lu system_time=3D%lu "

[ ... ]

> +	/* Re-read pvclocks */
> +	for (i =3D 0; i < 3; i++)
> +		__vcpu_ioctl(vcpus[order[i]], KVM_GET_CLOCK_GUEST, &pvti[order[i]]);

[Severity: Medium]
Does this also ignore the return value of __vcpu_ioctl() when re-reading
pvclocks?

> +
> +	pr_info("After +1h: vCPU 0 system_time=3D%lu, vCPU 2 system_time=3D%lu\=
n",

[ ... ]

> +	/* Verify the clock actually moved by ~1 hour */
> +	TEST_ASSERT(clk0 > ONE_HOUR_NS,
> +		    "Clock should be > 1 hour after set, got %lu ns",
> +		    (unsigned long)clk0);

[Severity: Medium]
Will this assertion trivially pass on any machine with an uptime greater
than 1 hour? The test validates the absolute clock value rather than the
delta (for example, clk0 >=3D clk0_before + ONE_HOUR_NS). If KVM_SET_CLOCK
completely fails to advance the clock, wouldn't the assertion still pass
on hosts with sufficient uptime?

> +
> +	pr_info("PASSED: pvclock still consistent after KVM_SET_CLOCK +1h\n");
> +	kvm_vm_free(vm);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D34
