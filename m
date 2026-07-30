Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007245C714
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437568; cv=none; b=LzHDy2PJKlZT9/Z+qoawFLWGkaRI3ibCQHkQ3CsYWNhhuCF8dYD3ePd650KstqP1bkO/btKZRJc4ari3camtXUTrI6Gayiuwn61MXo4iYT92sw6y3dFXGB+ARTuUld0iwu7BZ2qmlwO+23yPm2iziCZ8388VJjB1b5O+eX59kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437568; c=relaxed/simple;
	bh=DScrBJdYInuIR2DjXbmgNVziDJJL1A3bYQespWGpzE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MSY5JJOc7teisxg+/noo2d7o80U3kc3hoY4JzWmyUv18IYy+p8L2DqZOcXK+onZX8UJW5pbolWz4lPBjENoVn17C0TBnfVPSq+WizEKNuBvk3c0HfvXD2qMRg0mikBsP/0GGF79KYIREsVpqcadWPcse8uSmO1PLNKLW+67MALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7cauTYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7cauTYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3201F000E9;
	Thu, 30 Jul 2026 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437564;
	bh=IivWIsnspZnVqiTmFvKhqXbYWsxFxJUDYLIpNhQ7MAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U7cauTYpL+nPQ6btPjJ4VcZ9TtuX7L73uNUphlno40N7kOuY9WWv8qsrLsfz3a7TH
	 xhMJqg1cLhNOUO500kwnI+aeYx72Utyv6ybNvF3Wf9Inq8vE63h5HE26A3TzfuyHW7
	 j6HaYMi132WnH7MPqkqm7v688zJkpA9XgevJN/cirKZNc5sbL1ldUkYwYTEW9Tfbmr
	 t2WLzMzOU3y8+13tIDxVPzYtbswfM9KcXQXE+YLMGzo53loqAaKW1vS/iF1Z9Fj4qb
	 ydZq2JLLf+aBIK/uhgv94JFIZtvRYXDegCGc546yQkpK7lrNsv2fN+LIajFEU6bsU9
	 hKuq09DqEXdZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as
 inclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmytro Maluka" <dmaluka@chromium.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730182425.1223530-2-dmaluka@chromium.org>
References: <20260730182425.1223530-1-dmaluka@chromium.org>
 <20260730182425.1223530-2-dmaluka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:52:43 +0000
Message-Id: <20260730185243.CD3201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest changes assert that setting `bsp_vcpu_id` equal to =
`max_vcpu_ids` (the exclusive upper bound for vcpu IDs) will be rejected wi=
th `-EINVAL`, but the KVM kernel code was not fixed to enforce this and sti=
ll returns success, causing the tests to fail.
--

--- Patch [1]: [PATCH 1/3] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID=
 as inclusive ---
commit 985e68429c6e20e59d983752bd84f5dc599b83f0
Author: Dmytro Maluka <dmaluka@chromium.org>

KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive

This commit updates KVM selftests to treat KVM_CAP_MAX_VCPU_ID as
exclusive rather than inclusive. It modifies the tests to assert that
setting a boot CPU ID or vCPU ID equal to or greater than the maximum
capacity will fail.

> diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tool=
s/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> index 7e2bfb3c3f3ba..43f16c052de4a 100644
> --- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> +++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> @@ -30,22 +30,25 @@ int main(int argc, char *argv[])
>  	if (kvm_has_cap(KVM_CAP_SET_BOOT_CPU_ID)) {
>  		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)MAX_VCPU_ID);
> =20
> -		/* Try setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID */
> -		ret =3D __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID - 1);
> +		/* Try setting KVM_CAP_MAX_VCPU_ID below or equal to BOOT_CPU_ID */
> +		ret =3D __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
>  		TEST_ASSERT(ret < 0,
> -			    "Setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID should fail");
> +			    "Setting KVM_CAP_MAX_VCPU_ID <=3D BOOT_CPU_ID should fail");

[Severity: Medium]
Will this assertion now fail because the kernel code hasn't been updated to
enforce this behavior?

Looking at how KVM_CAP_MAX_VCPU_ID is handled in the kernel, it checks:

    if (kvm->arch.bsp_vcpu_id > cap->args[0]) {
        r =3D -EINVAL;
        break;
    }

If both kvm->arch.bsp_vcpu_id and cap->args[0] are set to MAX_VCPU_ID, the
greater-than condition evaluates to false. Will the ioctl return success
instead of -EINVAL, causing this test to crash?

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c b/tools/te=
sting/selftests/kvm/x86/set_boot_cpu_id.c
> index 8e3898646c69d..1c4ebdf8e82c5 100644
> --- a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
> +++ b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
> @@ -39,8 +39,8 @@ static void test_set_invalid_bsp(struct kvm_vm *vm)
>  	int r;
> =20
>  	if (max_vcpu_id) {
> -		r =3D __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)(max_vcpu_id + 1));
> -		TEST_ASSERT(r =3D=3D -1 && errno =3D=3D EINVAL, "BSP with ID > MAX sho=
uld fail");
> +		r =3D __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)max_vcpu_id);
> +		TEST_ASSERT(r =3D=3D -1 && errno =3D=3D EINVAL, "BSP with ID >=3D MAX =
should fail");

[Severity: Medium]
Does this change also cause the test to fail against the current kernel?

Looking at the KVM_SET_BOOT_CPU_ID handling in arch/x86/kvm/x86.c:kvm_vm_io=
ctl():

    else if (arg > KVM_MAX_VCPU_IDS ||
             (kvm->arch.max_vcpu_ids && arg > kvm->arch.max_vcpu_ids))
        r =3D -EINVAL;

Since the kernel checks if arg is greater than max_vcpu_ids instead of
greater than or equal to, will setting arg to max_vcpu_id return success
here and trigger the TEST_ASSERT failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730182425.1223=
530-1-dmaluka@chromium.org?part=3D1
