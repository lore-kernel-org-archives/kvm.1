Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46824CEEA
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356554; cv=none; b=faLiwumPF/csdBkBn1v9VH9tebkxOT53fYHiwxqOnXGSDHoZUn09aIYsLdOjWKfxiKvOXRvnF/5dLDHj39oVrxN7/39U+T+BSShftj+vequn+A0emY4NIHIxMjPWHVLDAFPuY52OGWu/Fi1vyksveNpj5JgV1GCpXaozvcYs9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356554; c=relaxed/simple;
	bh=cz7rL7YO3MlDdYlTMsCWQzGMEpT5gsM/Le8OMHYWhGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6JrOeedcNPL90jj1DRQ+4xYrCmq0oXWXftDKJIVvlMkpiRrNngQsDvTxXexYzuYoliCc4OClNbua3I3Rt9sTOEay+AO233Yjf3qUBHemg7P0WkngNImtZzMHKVGcNVBSB30scBOSFNDDKQuNFAcupaxnmyaoroI2oJmYtuWGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knagcOKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knagcOKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A91F000E9;
	Mon,  6 Jul 2026 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783356553;
	bh=BVLsEVBR/ICZ42X6VTsYMp6z4wYpBy6iXag5i67HDmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knagcOKSVzEzpWPESE0h5l6SQY5UARQWVgmub/6lg86uUpeNqqi4ZArviSzQa84pf
	 hAO7KXZgJzF0cqeMQFYCWHdt/3Z20T77vd42V/k7u5xXcMlB9N3qm7fTSHhqu0vaz+
	 hoMcUfZxaNRcT/IrETrez4S9QEEXIlDC7+svjXFLexPSEVAN2igX1yS42khD9WG3ZR
	 w8JxAEcj0Hl3X71afbFkOIpwqtFPVpvkIdMpTGHgyuRcDgwYHRHpS8N0hSSBDcZNLt
	 Yi/9DBCsfRiYe8QMel2Y4LjSH8GMH+wtNhHRFc+EUCfMYifAbuswzFCoIexWELLUtc
	 Z1VzzqnvnTsyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Use KVM's task pinning APIs in
 steal_time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hisam Mehboob" <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706163649.155548-1-hisamshar@gmail.com>
References: <20260706163649.155548-1-hisamshar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 16:49:12 +0000
Message-Id: <20260706164913.3A7A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition causing intermittent test failure (ESRCH) due to =
late thread pinning
--

commit 27b6bbfae99d5564cda41cbc7b8c36c7b9a4ed64
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Use KVM's task pinning APIs in steal_time

This commit updates the steal_time test to use KVM's task pinning APIs
(pin_self_to_cpu and pin_task_to_cpu) to pin the vCPU and stealer threads
to pCPU0. This removes the use of pthread_attr_setaffinity_np, allowing
the test to build against non-glibc C libraries.

Link: https://lore.kernel.org/all/aLIroyJSWQ26wnY4@google.com/

> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index 76fcdd1fd3cb4..19a97d6a36076 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
[ ... ]
> @@ -558,7 +552,9 @@ int main(int ac, char **av)
> =20
>  		/* Steal time from the VCPU. The steal time thread has the same CPU af=
finity as the VCPUs. */
>  		run_delay =3D get_run_delay();
> -		pthread_create(&thread, &attr, do_steal_time, NULL);
> +		pthread_create(&thread, NULL, do_steal_time, NULL);
> +		pin_task_to_cpu(thread, 0);

[Severity: Medium]
Could this introduce a race condition that causes intermittent test failure=
s?

Since pthread_create is called before pinning, there is a small window
where the child thread (do_steal_time) could execute and complete its very
brief 200us run before the parent thread executes pin_task_to_cpu.

If the child thread exits before pin_task_to_cpu attempts to set its
affinity, it will return ESRCH and trigger the TEST_ASSERT inside
pin_task_to_cpu, abruptly aborting the test.

Is the explicit pin_task_to_cpu call necessary here? Since the main thread
already called pin_self_to_cpu(0) earlier, the new thread created by
pthread_create should automatically inherit the parent's CPU affinity mask.

> +
>  		do
>  			sched_yield();
>  		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706163649.1555=
48-1-hisamshar@gmail.com?part=3D1
