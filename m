Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277B43C06F
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511451; cv=none; b=qRZkyPGeYa2DcSeZnHkh+fYYMPvnG7Zwx4CfJF+2J6DlNzfgHcSD9fudP7cMlXTe568ckGmlbB9PC4w8sYmtS1+cJl8W2uXmGHAWJWWf7wNXINy0c2GJSUxzNHAxp4vzG4wwbvOPTqJIPMlfjZZ3RdHDhf91E40IxshnOfkcGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511451; c=relaxed/simple;
	bh=ZQDTPgqx1HK6NT4jO5Ff1yEQTKAlgZ87QJ2Z43J9vp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z/EeUTadyvL04tJxxj1klLqD3EUJiBh5DFugvYMhCqXoo+bA6TThy6h+IKK3y5hnpzzuEo5ih0QbIM9WUYk3snDb5kxAgzRhAJhpm8d0ZaAJou49floiEhBPE8xc/pH13mZTjUNvn81wCsaXlXx/4BJAzQLGX/NM2RAhFM4sKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzsqNpxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzsqNpxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EAD1F000E9;
	Fri, 31 Jul 2026 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785511448;
	bh=iF3WHBcWjJDpjrjShGubmca6S4G4XkTwYtf/fMgwkwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzsqNpxLuU0hPwHEBUrwbCnWSg7haDrplsy9yfwspwhvtNwnusgbvGrCso2pNT2Q6
	 tM/ePLktZHllkHfOL3ni1E9Co4onaA1u5TlgkW6GSviLVJqGLn4SEhoN8REAleYI5e
	 6uCC0F0QYX6AuFOobaTRhCU9ZUDnbJ/2sLCdtkO+la1S5rXvzYbaIVKTy7kLgC2+ZX
	 nXuwZ1FrnsAcMfTXXMjTqJxaWoQoJdV8i/VtrXkrxJU6ZmZmLftbgPM9gsYYnVFzj5
	 6+M6A0gaz3sWSdvi5l3GIxaGBJkRMa6DeSxf5xIvOtQKM8wRQklkwV7XUwcS1Gft9K
	 TT96XR0joi/cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID
 as inclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmytro Maluka" <dmaluka@chromium.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731150846.1728164-2-dmaluka@chromium.org>
References: <20260731150846.1728164-1-dmaluka@chromium.org>
 <20260731150846.1728164-2-dmaluka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:24:07 +0000
Message-Id: <20260731152407.E3EAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch modifies a KVM selftest to avoid an invalid configurat=
ion but sweeps an underlying kernel bug under the rug by failing to fix the=
 kernel and masking the issue in the test suite.
--

--- Patch [1]: [PATCH v2 1/4] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU=
_ID as inclusive ---
commit 5e2afeaca4e83d31005f9aa5caf94dbbc9f20b8c
Author: Dmytro Maluka <dmaluka@chromium.org>

KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive

This patch modifies the max_vcpuid_cap_test selftest to account for
KVM_CAP_MAX_VCPU_ID being exclusive (maximum allowed vcpu_id plus one).
It changes the test to use MAX_VCPU_ID + 1 when enabling the capability,
avoiding the boundary condition.

> diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tool=
s/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> index 7e2bfb3c3f3ba..47ee14967873f 100644
> --- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> +++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
[ ... ]
> @@ -36,16 +36,19 @@ int main(int argc, char *argv[])
>  			    "Setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID should fail");
>  	}
> =20
> -	/* Set KVM_CAP_MAX_VCPU_ID */
> -	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
> +	/*
> +	 * Set KVM_CAP_MAX_VCPU_ID. Note: KVM_CAP_MAX_VCPU_ID is a misnomer,
> +	 * it actually represents maximum vcpu_id plus one.
> +	 */
> +	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);

[Severity: Medium]
Does this patch mask an underlying kernel bug rather than fixing it?

The commit message notes that setting bsp_vcpu_id equal to KVM_CAP_MAX_VCPU=
_ID
is invalid. However, by changing the test to avoid this exact boundary
condition, it seems we are leaving the kernel's off-by-one bug unfixed.

Looking at the kernel side in arch/x86/kvm/x86.c:kvm_vm_ioctl_enable_cap():

    if (kvm->arch.bsp_vcpu_id > cap->args[0]) {

This bounds check uses ">" instead of ">=3D", which appears to incorrectly =
allow
bsp_vcpu_id to equal max_vcpu_ids.=20

Should the kernel be fixed to reject this invalid configuration, and the
selftest be updated with a negative test to ensure it actually fails?

> =20
>  	/* Try to set KVM_CAP_MAX_VCPU_ID again */
> -	ret =3D __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);
> +	ret =3D __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 2);
>  	TEST_ASSERT(ret < 0,
>  		    "Setting KVM_CAP_MAX_VCPU_ID multiple times should fail");
> =20
>  	/* Create vCPU with id beyond KVM_CAP_MAX_VCPU_ID cap */
> -	ret =3D __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)MAX_VCPU_ID);
> +	ret =3D __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(MAX_VCPU_ID + 1));
>  	TEST_ASSERT(ret < 0, "Creating vCPU with ID > MAX_VCPU_ID should fail");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731150846.1728=
164-1-dmaluka@chromium.org?part=3D1
