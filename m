Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE448CFC
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933751; cv=none; b=MaHdtjG7rKOoH3kZ8Cwg6FwFEupai+AzVHjMXptXVtP9asxXTzDasDuD75IOcMgWLSOejab7CwMCpAXdcSd5XtkOX334vrckTb7PDwrkwGcL+YzLsrCUSSDJc20xolKo37/FIZfGn3okNN9xyWkCD1PQD4tDdxyPji2HzWsAv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933751; c=relaxed/simple;
	bh=6hnbbkSKl5GGqA/6kAGly18n4TWAFvzWN6++t1kHjfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DND9wHHkQ0xPMA7vNhDivfppMUMXIR9+iWnSyULEqz3N+pAt0I3HwBg0vUekjPrPzqqdqQtfO/VSX4YRr3L+M8uoLiz2v7vP4aRepGHNWpjItqcfngH5YsBzCq08brgwPNL9zSTpr2ufof7Ndw/yxwzaqA8b5k5LzZkzgiMJYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TemXg42o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TemXg42o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6259D1F00893;
	Mon,  8 Jun 2026 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933750;
	bh=vVhH0ODFMiZpWQx2tzCsy6fnPQYShEj4xAwQOwh/4lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TemXg42o7ialRzMWiRYeCdcEkPnIs8VgIx3q5gQECH1F9t+RXKm5FovKrUB9Xofvp
	 Rjyb0C5y+llDDcTRxKiQnn1qqqYzLyg65oWVNmXAu5gZXi+SmkVwtwCC+ogNj44poN
	 98ALEnylFPS784DbxRiQecQI3FSCoxFQdq2syp3A/dWsJ/rF7ywrL5gKL+q6PYIioO
	 tAeVcvX1eL2p80Ns05zovzqUwdWuUDz0cU/oGo7sYylSkSur3oUUjr1YQsiQAk2hfa
	 U6QiIJZkmm6zj0OLeLVytY7+oUlxSP8M5vRpj9eK7t4/ZD7k/Sdv5IQGoTgpbBGlcU
	 xrXPvjXKlmgMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/34] KVM: selftests: Add KVM/PV clock selftest to
 prove timer correction
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-6-dwmw2@infradead.org>
References: <20260608145455.89187-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:49:09 +0000
Message-Id: <20260608154910.6259D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flawed API/Feature Check for KVM_GET_CLOCK_GUEST support.
- [Medium] Missing Capability Check for KVM_VCPU_TSC_OFFSET device attribut=
e.
--

commit 26a6d06b6a0ac05e89b1ed831e29fd555de24ff8
Author: Jack Allister <jalliste@amazon.com>

KVM: selftests: Add KVM/PV clock selftest to prove timer correction

This commit adds a KVM/PV clock selftest to verify timer correction during
simulated live update or migration. It verifies that using KVM_GET_CLOCK_GU=
EST
and KVM_SET_CLOCK_GUEST maintains the relationship between a guest's TSC and
KVM/PV clock.

> diff --git a/tools/testing/selftests/kvm/x86/pvclock_test.c b/tools/testi=
ng/selftests/kvm/x86/pvclock_test.c
> new file mode 100644
> index 0000000000000..aecd62fc8a93c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/pvclock_test.c

[ ... ]

> +int main(int argc, char *argv[])
> +{

[ ... ]

> +	/* Check KVM_GET_CLOCK_GUEST is supported */
> +	{
> +		struct pvclock_vcpu_time_info tmp;
> +		int ret =3D __vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, &tmp);
> +		TEST_REQUIRE(ret !=3D -1 || errno !=3D ENOTTY);

[Severity: Medium]
Does this condition correctly detect unsupported ioctls on x86?

Looking at the KVM implementation, kvm_arch_vcpu_ioctl() on x86 returns
-EINVAL for unsupported ioctls rather than -ENOTTY. On an older kernel where
the ioctl is not supported, wouldn't errno be EINVAL, making this condition
true and causing the test to proceed and fail later instead of safely
skipping?

> +	}

[ ... ]

> +static void set_tsc_offset(struct kvm_vcpu *vcpu, uint64_t offset)
> +{
> +	struct kvm_device_attr attr =3D {
> +		.group =3D KVM_VCPU_TSC_CTRL,
> +		.attr =3D KVM_VCPU_TSC_OFFSET,
> +		.addr =3D (__u64)(uintptr_t)&offset,
> +	};
> +	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &attr);

[Severity: Medium]
Will this unconditionally fail on older kernels that lack support for the
KVM_VCPU_TSC_OFFSET device attribute?

While the test requires KVM_CAP_TSC_CONTROL earlier in main(), the
KVM_VCPU_TSC_OFFSET attribute is a separate, newer feature. Should this
include a capability check using __vcpu_has_device_attr() before invoking
vcpu_ioctl() to ensure the test safely skips on older kernels?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D5
