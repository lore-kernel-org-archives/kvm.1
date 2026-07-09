Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23639B49D
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616162; cv=none; b=Fn4H5HYIWPcFRUdJrhfjbrzxHgch4ZS6jfshwgL+lI3tgfwU5m0MXDzjV6QB6hKMAEykiiQYrf5rcERHToJYWlcAfyutl/04YgwomrDjEi4Xe3bLqOlI8Z3NN5vHSMrxw20QnHoEJWQhBIMaqZLiP79/Hf5nqGA4Ts1awEfqizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616162; c=relaxed/simple;
	bh=l9Pkr1ERQLM9BP3VqHpr64BYf8YPr+aQC1VCqgt76ME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jWcbn+uyLgjKm67oIXIzJ8gN5+tb9FPxlkLtMEwvKOHZh+QcL5QKyt4YHEB2+qO9QoWYmlHZCyzqn4aK1cgx9KZyhjMDsB6y/M0whlmWe5qtuPWBu7x75B+vDxvjy067/2hjrEJgv9M19sihy+8EPrmeUpO50OSIkCZkTqJnpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfC+cQF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfC+cQF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7440A1F000E9;
	Thu,  9 Jul 2026 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616160;
	bh=0pyNlxL4hON2dv5r6FiNc/ZeZMf7AcSwpRgTUktyRjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfC+cQF51c3FsPzhL/Z7hnzLX8kI6lxAo/aWnwc6m9/lPSX8Qq+3LSPHcSTWo4Lm3
	 jZhz54kgdHhgddyVpp4E6CupsZHVsNMs0aKHHQ+DEHmjUEfoGwCm5LQdSjUdvIMXe6
	 fYOGOfQjl8nPqjx3chi0MXTEKEIRBalBV4m1eiHI6ZeHJA1JrvbHmbMBd1SIJVovDF
	 OClHFQQSInb+tIZlxvXBKM7J0x5brppGE8mj2pD4oR5XI8PIZ66MuLasglkDq4ncXY
	 OMkalwCnjvw5KmjtzAFT2awFRuEGe7i6C7uuUY6pmRX+POvK0M0rQsNPdJWvbDJcfl
	 4d9MPsZUB56mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] KVM: selftests: SEV: Verify unsupported VM types
 are rejected at creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709164751.621326-2-hemanth.selam@gmail.com>
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
 <20260709164751.621326-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:55:59 +0000
Message-Id: <20260709165600.7440A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unreachable file descriptor cleanup logic due to `TEST_ASSERT` abor=
tion behavior.
--

--- Patch [1]: [PATCH v1 1/2] KVM: selftests: SEV: Verify unsupported VM ty=
pes are rejected at creation ---
commit 6d2bb062d11a83854e4168e36bd8f632c92e6ba6
Author: Hemanth Selam <hemanth.selam@gmail.com>

KVM: selftests: SEV: Verify unsupported VM types are rejected at creation

This commit adds a new test to verify that unsupported SEV VM types are
rejected by KVM_CREATE_VM. It introduces a helper function to test invalid
types and asserts that the creation fails with -EINVAL.

> diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/te=
sting/selftests/kvm/x86/sev_init2_tests.c
> index 8db88c355f165..724ff11f16c94 100644
> --- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> +++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
[ ... ]
> @@ -73,19 +74,34 @@ static void test_init2_invalid(unsigned long vm_type,=
 struct kvm_sev_init *init,
>  	kvm_vm_free(vm);
>  }
> =20
> +static void test_create_invalid_type(unsigned long vm_type, const char *=
msg)
> +{
> +	int fd =3D __kvm_ioctl(kvm_fd, KVM_CREATE_VM, (void *)vm_type);
> +
> +	TEST_ASSERT(fd < 0 && errno =3D=3D EINVAL,
> +		    "KVM_CREATE_VM should reject unsupported type (%s), got fd=3D%d er=
rno=3D%d",
> +		    msg, fd, errno);
> +	if (fd >=3D 0)
> +		close(fd);

[Severity: Low]
Since TEST_ASSERT() will unconditionally abort the test program if the
condition fails (which happens if fd >=3D 0), is this close() block dead co=
de?

If the assert passes, fd is strictly less than 0, making the condition
false. If the assert fails, the program terminates before reaching the
close() statement.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709164751.6213=
26-1-hemanth.selam@gmail.com?part=3D1
