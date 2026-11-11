Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378114;
	b=p51u5OF4S2Bi884DsPKJOhnrZLRPn33npBoD76GzCsaVY8avV+SYYbFeFjVr31PwGhjq
	 uQ+4cqCG+3WqGt/zNgcSuBOS6KsNCc+Z4COpyWMeyxXP+1QqO5b+9HQuLuAORkECha1x4
	 PhIxm2m5zUMj7oAC7J6eXDAgxHmH1fHh/PAGf/GTzgz6fe8B2nY8MdxvvDfzKTJWQWwr9
	 TCnNTs30AW9E1hU0A7BpwGrqzuYoyCjzX8TxUHfEDGmuuCQkjZExs1wd8DTkE7JNUf/nQ
	 SszOYIP48t4xaLsSv3I93NE6gaKJW2+WK9T66iNu8Pd1HywdC/VszYecB18m70gwcmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TsLwKqOvEA2LYCwXTxfbTvd16z1dPdhvaX6O9sFi818=;
	b=HNUgGLNPDBPn/kFsMjkAIoKTRxqBiGwlGrb23mAdTO7IbkChz90fcNJ2Jmz0jfQ7v1s8
	 kur+CojUbK2RGQtSPHiNgHCnXGD2d0vBNzdx7VWLTIGW5UR0zysKykUd1+xFRVDuSvHmt
	 jX3J57oKFGwwceIAQ+yNPtWhaEF/ZhXV53BJ6W8YjOoyDqdYZfte+ofBLW/r6fqMxdkG5
	 LdMfUcBLgyICyC1UuaFje6l/64fFm0fDgdt+7XLsGN+9PYYsgzrQBSnIfRKBq6tL+L55m
	 +od+/qiUihThbET/RUNVnpo9ewq1pM1j/wRZj5hCS8Njd1S5JUdhQN6gibYwAiRgiSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKVIfo0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C77606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKVIfo0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F81F00A05;
	Wed, 11 Nov 2026 06:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378114;
	bh=TsLwKqOvEA2LYCwXTxfbTvd16z1dPdhvaX6O9sFi818=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jKVIfo0bLeJja+lYUf/UGhp1DJYwQQH9yV1lTpi4NUV6pZjWtniOtnYGE+mmhfhg7
	 /2Ur3tOjuDE9h6BU71YH/5FhJ2mWW87DUNjO8qSjQaVxuKlXfCvPyLdzIrcdylYYnD
	 cKzed5hM8JmjWy6QOkhTZANsCPSGbIapb+MTvsP0TlKK/+YVCZNvCvriSlkFvXDu5n
	 LJV8V0ljXrFoAwJi9Ih/IRimDRGkw6Ahj1iqmjbbjUGC+dwLzTbOQ5cWELv+mnd+HL
	 Ema4KtTa6kJN0myZYo0NE7GeTc3VojC8Z1QqXWwqFHZSdwDdoeHIrY52wXMY8/D9So
	 PY16O9ClxuFTA==
Message-ID: <sashiko-outbox-208431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] KVM: selftests: Test nested VMware backdoor
 routing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, kvm@vger.kernel.org
In-Reply-To: <60dbf049b84e8d48da4b4c6138e759d8e2cfb92b.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
 <60dbf049b84e8d48da4b4c6138e759d8e2cfb92b.1794374897.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:21:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: selftests: GUEST_ASSERT() at CPL > 0 in l2_guest_code()
  faults with #GP
--

commit 17432eb224b8266c29f7a0e74dd2c96eb87440ef
Author: Zack Rusin <zack.rusin@broadcom.com>

KVM: selftests: Test nested VMware backdoor routing

This commit adds a KVM selftest verifying how nested VMware backdoor port
accesses from L2 are routed between L0 and L1 across VMX and SVM.

> diff --git a/tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.=
c b/tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.c
> new file mode 100644
> index 0000000000000..3d12be7906e0d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.c
> @@ -0,0 +1,223 @@

[ ... ]

> +static void guest_done_handler(struct ex_regs *regs)
> +{
> +	GUEST_DONE();
> +}
> +
> +static void l2_guest_code(void)
> +{
> +	unsigned long rax =3D guest_case.rax;
> +	unsigned long rbx =3D 0;
> +	unsigned long rcx =3D VMPORT_CMD_GETVERSION;
> +	unsigned long rdx =3D guest_case.rdx;
> +
> +	asm volatile("inl %%dx, %%eax"
> +		     : "+a"(rax), "+b"(rbx), "+c"(rcx), "+d"(rdx));
> +	GUEST_ASSERT(guest_case.expect_l0);
> +	asm volatile("int3");
> +}

[Severity: Medium]
Does GUEST_ASSERT(guest_case.expect_l0) in l2_guest_code() cause a false pa=
ss
when a !expect_l0 test case fails to fault on the inl instruction?

l2_guest_code() runs at CPL 2 or CPL 3 with IOPL 0 until int3 transitions to
CPL 0 in guest_done_handler().  If the tested inl does not raise #GP when
guest_case.expect_l0 is false, GUEST_ASSERT() invokes ucall_x86_do_ucall(),
which executes an IN instruction on UCALL_PIO_PORT (0x1000) while still at
CPL > 0.  That port access faults with #GP(0) and exits to L1, where
l1_svm_code() and l1_vmx_code() see GP_VECTOR and report success via
GUEST_DONE() instead of aborting.  Moving the assertion into
guest_done_handler() would run it at CPL 0 where ucalls work.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794374897.gi=
t.zack.rusin@broadcom.com?part=3D12
