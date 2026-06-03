Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F0325495
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527940; cv=none; b=Lg2q1GkFUAwf1QkNdqZ6+lQweMLbCK7QcYfLhZ38lepyGfwzNhNPwHewJ1d4g+B7HYjN21hZcCYBL+38emUQXYjdc3POIFAqLUjnq0M3S9S5z3YK1gqn6ocguGSb9bq1izi5bGqhgmkHUTcn9A5fcrNJuWhizGOxm1r88tFG+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527940; c=relaxed/simple;
	bh=15oeuA16uk0AG1L8m9mWYzL2ezEG4XKu5nQXCPPs69s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XuuJ7y2oicA0cKatJDDE9/t73z6/7MQ7i3xosCd5sVMVgk/wlnC2U1wobImiV6Dli46j4uoa+berIbE4WkUL2G34fwMtYYHj9QVc42eaBgtDp9sVkiLEJ3Mf7Y2+gVaict7CduTq6ZbrX3pLDKsX7SpT/ZxSh2ZLlPyWM9k3Ado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwCayrlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwCayrlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FDE1F00893;
	Wed,  3 Jun 2026 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780527939;
	bh=YPaH9Md9YyURLlQBCNrSH7QBsH2x7cFbX1e8rCN6C8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwCayrlQfIpA/WBTReUuTmcqPnpE92oPQLqZzDJxz71SLV9tVsbIiGn0HgeRy3USz
	 nTx9HuldF3vSPe6MBRbAR8MliAHm8VquwR7kjPCzkptDMunx/iUraW777y7eY1fuOT
	 orDlD7F0+kujgmxW4KeSe0P1hrssdoWjinF1Ub82UIX06m+qdEvaTuEUbXyKCDBM5r
	 NxPl/+7SnVh5GVP7WeH47iJZmJ9wHF9jIDYJUR/shCaHrVgnPmRnV7kjDOvih8Nt7T
	 9EyEG9pa1PLOQCcTyAHZcFSCVljGvQn26AiftluCV0iOJQKQ4bZhiIgLyUFR6UITSA
	 dP+b6+bVZnswg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Make guest_code_xsave more friendly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com>
References: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:05:38 +0000
Message-Id: <20260603230539.59FDE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Converting `guest_code_xsave` from a top-level pure assembly blo=
ck to a standard C function invalidates the test's core assumption that no =
compiled code runs before the `xsave` instruction, exposing the pristine VM=
SA state to compiler perturbation.
--

commit 45df73f97588ddd25e44034bc6f46ec39b28af24
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Make guest_code_xsave more friendly

This commit converts the guest_code_xsave entry point from naked inline
assembly to a standard C function to prevent linker errors when
guest_sev_es_code is optimized out. It also refactors the xsave instruction
into a separate C helper function.

> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/tes=
ting/selftests/kvm/x86/sev_smoke_test.c
> index 1a49ee3915864..8b859adf4cf6f 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -80,13 +80,23 @@ static void guest_sev_code(void)
>  	GUEST_DONE();
>  }
> =20
> -/* Stash state passed via VMSA before any compiled code runs.  */
> -extern void guest_code_xsave(void);
> -asm("guest_code_xsave:\n"
> -    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
> -    "xor %edx, %edx\n"
> -    "xsave (%rdi)\n"
> -    "jmp guest_sev_es_code");
> +static void xsave_all_registers(void *addr)
> +{

[ ... ]

> +static void guest_code_xsave(void *vmsa_gva)
> +{
> +	xsave_all_registers(vmsa_gva);

[Severity: Medium]
Will this change allow the compiler to corrupt the VMSA state before the
xsave instruction executes?

The original code was explicitly written as top-level assembly to stash
the VMSA state before any compiled code runs. By converting guest_code_xsav=
e()
to a standard C function, the compiler is free to insert function prologues
or instrumentation (like ASAN or fentry) before the xsave instruction
executes.

Since the x86_64 ABI treats YMM registers as caller-saved (volatile), any
compiler-inserted function calls could clobber the FPU/AVX state (such as y=
mm4)
that the test relies on, causing spurious test failures.

If the goal is to prevent guest_sev_es_code() from being optimized out,
would it be better to keep the raw assembly and apply __attribute__((used))
to guest_sev_es_code() instead?

> +	guest_sev_es_code();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-snp-selfte=
st-cleanup-v1-1-73b29fe31ce6@google.com?part=3D1
