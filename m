Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001634DCC8
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438187; cv=none; b=folor2T8fJG/xEMxAoY9Af/UGa48nlui1SnLyoRWOMPSiHLpIMkJn4bGdPY4T4pUwCJ9D7KBxZ501LNsnu4TOK4G/vBgDhshPD4wzLgQvjEiDHLJTglFtHvmvsnA5mCFiKCd5+A7w4IYkxHTkeLgmciIa/kR20Rfa4EIbZN0SFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438187; c=relaxed/simple;
	bh=yJidPIE2chC3iTFZGoyimR15PDgd3oAaIknCDbI44ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oo6Cpl8RSWNnSzKTCnb28om8/80dtuqSJMS20o55xHFAKZLgfvdUl7qnP3QIHIuUcBXlJm8U4jFJn9QY66yTJy8VnWUBMwmJfJMu84rFVTnr2JdTY4aaVp0KyfqQq1SSEkzRl+BKwfeMHhYVEwWbcQdwIrWHaG2izTUA58h9NnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoINyTgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoINyTgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290581F000E9;
	Tue,  7 Jul 2026 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783438184;
	bh=4lYHKXi3xlZBl//zOZeRuxFbp0Ivm4y5HlJhYSD3vHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoINyTgUsgeHf/lXBQuUpDbGia9ot9RLksl9/jA3QOMzL/iIwh/fFUG3WpYT38wKq
	 FYvItcljgyLh19JAKl4HZfGTYVTn8uYhIJ/6Skw6xXIltn1JogRmfqj++WE+2Nzq6E
	 LP3bEbBJj9zv2QQ/NPN7PZ/0QJ3fK24NL/6MyHU4d/mgajmqojg275Ca74+FMXGvLS
	 ov0Ws0vN0Tj0RC54OZHZOFVKKHmxFHQ5dBkUcRbn9rEYoF9kcBvH6jibzy8zZ2QZlV
	 Y5sa43UuIDiSKpl/pKPZJ83clYWLtVTjNmEvsanurb022zlt2FY08r2zQYUdroqVcY
	 51JL4Sn3Q4rPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: selftests: Randomize pCPU in steal time
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707150706.1198541-3-seanjc@google.com>
References: <20260707150706.1198541-1-seanjc@google.com>
 <20260707150706.1198541-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:29:42 +0000
Message-Id: <20260707152943.290581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized variable read leading to test flakes if pthread_ge=
taffinity_np() fails.
--

--- Patch [2]: [PATCH v2 2/2] KVM: selftests: Randomize pCPU in steal time =
test ---
commit 0d5df2335fea13e6ab9b9a76b38f38b87bb2fb85
Author: Sean Christopherson <seanjc@google.com>
KVM: selftests: Randomize pCPU in steal time test

This commit updates the steal time test to pin its tasks to a random pCPU
instead of hardcoding pCPU0. It aims to increase test coverage and properly
handle parent tasks that lack pCPU0 in their CPU affinity mask.

> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
[ ... ]
> @@ -514,14 +514,12 @@ int main(int ac, char **av)
>  	long stolen_time;
>  	long run_delay;
>  	bool verbose;
> -	int i;
> +	int i, cpu;
> =20
>  	verbose =3D ac > 1 && (!strncmp(av[1], "-v", 3) || !strncmp(av[1], "--v=
erbose", 10));
> =20
>  	/* Set CPU affinity so we can force preemption of the VCPU */
> -	CPU_ZERO(&cpuset);
> -	CPU_SET(0, &cpuset);
> -	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
> +	cpu =3D pin_self_to_any_cpu();
> =20
>  	/* Create a VM and an identity mapped memslot for the steal time struct=
ure */
>  	vm =3D vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
[ ... ]
> @@ -557,7 +555,7 @@ int main(int ac, char **av)
>  		run_delay =3D get_run_delay();
>  		pthread_create(&thread, NULL, do_steal_time, NULL);
>  		pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
> -		TEST_ASSERT(CPU_COUNT(&cpuset) =3D=3D 1 && CPU_ISSET(0, &cpuset),
> +		TEST_ASSERT(CPU_COUNT(&cpuset) =3D=3D 1 && CPU_ISSET(cpu, &cpuset),

[Severity: Medium]
Is there a race condition here if the worker thread exits before the parent
reads its affinity?

When pthread_create() spawns the worker thread, the child runs for a short
duration and exits. If the parent thread is preempted right after creation,
the child might finish its work and exit before pthread_getaffinity_np()
executes in the parent.

If the kernel task is already gone, pthread_getaffinity_np() will fail with
ESRCH. Because the explicit initialization of cpuset was removed earlier in
main(), cpuset remains completely uninitialized.

Could this cause CPU_COUNT() and CPU_ISSET() to evaluate garbage stack memo=
ry
and trigger sporadic TEST_ASSERT failures? Should the return value of
pthread_getaffinity_np() be checked, or should cpuset be initialized before
the call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707150706.1198=
541-1-seanjc@google.com?part=3D2
