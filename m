Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402D2EBBA9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539340; cv=none; b=H/fD2/yj6wiThYVA44cr7+gyxAXHEoUU1OEBhy0OC0ligxV9rdsVghscqGRVBdCAuejKpypiaOO6Lw11dgHOrWIscW9JQDWnO8VIz7Uioo6Au1+rPx8DDPmu/AL971En2G1DuaRhcIFsBC/TdpmVdocSzNJ3ZYuIS6/k6ogweqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539340; c=relaxed/simple;
	bh=dkN5Dy865urRun2Z0zIV7rGl7c1aYGuq5XHryQqCZiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Po4/QjEGpoZz1cKKxWxGtgtVF/pxbUeSsJ8PAn9EZlpegDU9VO2tTx92p+ZWZQVxlr26WIV2qRxbWTUVeNhTxwCXZJpEGRlfxLEvA73EA7KU/Fxw/eJ3XItILuCrwdzCQsU+ci+XsT3IjebBpXPaUF8DqMoshGXOObare9fNtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjqEO4KG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjqEO4KG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1A91F0089B;
	Thu,  4 Jun 2026 02:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539338;
	bh=ceojYvok3zA8WNGmblLq4h36HOgTqKyhg62odYC8Mtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjqEO4KGdI0OqSQIxQnItCRpRXxw941sF6xB7PVj8CNuVPDrrqoZ+nDB9IrlScgxE
	 nPoDF8A7rXJlF42DsCyCmHvPdZ8DzSIsll6CLiBMpphyuaZnCpk2oTCQ8TV+Bt2zt8
	 X7G2DlTuwcO7MJURR5tYUybjXcJY3FEt4b7Am/qssLryKH+8bJSg40vWHSFQAWVsc/
	 yiXywQ/XB9k/Uaw4JZnVPLOn3FUd47ruIFi/JpMBE+A5irdMCjC6qWjA9QzpfpsvXN
	 MH2C2fMNxj/yei6awYcz3XpGto0XYfXzUv7GIqvBjvjTBnfpDpQqx6EC9oXapWqL2X
	 YaEWzbI+Tgbow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/21] KVM: selftests: Verify IRQs wake up halted
 vCPUs in IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-12-jrhilke@google.com>
References: <20260604020143.748245-12-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:15:38 +0000
Message-Id: <20260604021538.BC1A91F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The guest code introduces a missed wakeup (TOCTOU) race conditio=
n between checking the `done` flag and executing the `hlt` instruction. Thi=
s can cause the guest vCPU to sleep indefinitely, leading to a test hang.
--

commit 9a28612ad82c9a519d18da6d85e17ef536f35e8d
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Verify IRQs wake up halted vCPUs in IRQ test
   =20
This commit adds a '-b' flag to the KVM IRQ selftest to verify that
interrupts correctly wake up vCPUs from a halted state. If the flag
is provided, the guest uses the HLT instruction instead of spinning.

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 90cff165c3512..671338f0e6122 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c

[ ... ]

> @@ -43,8 +44,12 @@ static void guest_code(void)
> =20
>  	WRITE_ONCE(guest_ready_for_irqs[guest_get_vcpu_id()], true);
> =20
> -	while (!READ_ONCE(done))
> -		cpu_relax();
> +	while (!READ_ONCE(done)) {
> +		if (block_vcpus)
> +			hlt();

[Severity: Medium]
Is there a missed wakeup (TOCTOU) race condition between checking the done
flag and executing the hlt instruction?

If the host sets done to true and triggers the final wake-up interrupt
after the guest evaluates !READ_ONCE(done) but before it executes hlt(),
the interrupt handler will run immediately. Upon returning, the guest will
blindly execute hlt() and go to sleep.=20

Since the host only sends one final interrupt per vCPU, does the guest
need to disable interrupts (e.g., using cli()) before checking the condition
and use safe_halt() to atomically re-enable interrupts and halt?

> +		else
> +			cpu_relax();
> +	}
> =20
>  	GUEST_DONE();
>  }

[ ... ]

> @@ -247,8 +258,19 @@ int main(int argc, char **argv)
> =20
>  	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
> =20
> -	for (i =3D 0; i < nr_vcpus; i++)
> +	for (i =3D 0; i < nr_vcpus; i++) {
> +		/*
> +		 * Verify that sending an interrupt to a halted vCPU wakes it
> +		 * up. If the vCPU does not wake up, the call to pthread_join(),
> +		 * below, will hang.
> +		 */
> +		if (block_vcpus) {
> +			kvm_route_msi(vm, gsi, vcpus[i], vector);
> +			trigger_interrupt(device, eventfd);
> +		}
> +
>  		pthread_join(vcpu_threads[i], NULL);

[Severity: Medium]
If the race condition described above in guest_code() occurs, the guest
could miss this wakeup interrupt and sleep forever. Will this cause
pthread_join() to hang indefinitely, resulting in a test timeout?

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D11
