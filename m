Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74E3E0C41
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758919; cv=none; b=YtaBTxpQ6VhMHYvspoBTFlMExr3ch5RiFndNXEuMEwExma50wOF0NR1eHbFEEyt6qcaqcUDktfkdF6WFNhkx6Jt7Zji+faqrTpTs+33GFsUvM52tqlg1ddFWR09fXNpsIrHEutiLYdvJVeKqifFSQ3PdpiyzhZyWpf4ICh3mTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758919; c=relaxed/simple;
	bh=K9ChK7/SctVkdgD2L4TRlp01/z6TovVNz12zGCYJeSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWxkptM9lDfDiwHebso4lZ1JuZhSOuKTycHY+3aE01ixREpUQardCeXhXnVFVAGlV8XzAIqoipRpe21BbPPwrhmQ9dKzRqheV4qAQJxEhlbT9ccXoSkb6s/wdSROK1oC43MNVtO32gDKGWCTzlbpnQ/cP3W23n+faaubIAN2iEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebeDjq7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebeDjq7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6A81F000E9;
	Mon, 29 Jun 2026 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758917;
	bh=cVvdUg8QiBb1aPXaBmj3zozjZUwHp/YMe6FdawShq9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebeDjq7hD7swaQV5vLQazxxU6KkqC9PBZIXj9A4bNguM2iX0cadBO4B/mksh74daW
	 k936saKSpNof5Ghh8E46LkBm7VXMAM8ROW/7N5ujCWBmZ9fIutQihw2/xBrVVAgsFK
	 p4iI+LeKEOjzZfYINQz8xaviMUu0MaJDFMW/F+Y3zlpQidijnKIx1gOY6QQgafcRBE
	 esbMgTTADgRqSQta1npjYHQ1+vQPW7MHhPc1A5oiOvO0+G9iZTXOwanGrFaqV8djtA
	 4/4eTV/EqD0wiwzycRifebARIlAo629iv1iOEr8xjltFrmPzLARZVWmEFZvFK8LBxC
	 gZs4EfAJpRPMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] KVM: selftests: Trigger save+restore randomly
 in the #PF stress test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629183746.699840-9-yosry@kernel.org>
References: <20260629183746.699840-1-yosry@kernel.org>
 <20260629183746.699840-9-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 18:48:37 +0000
Message-Id: <20260629184837.AC6A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The aggressive 1ms signal interval can starve the guest and caus=
e the test to deterministically fail on slower or nested environments.
--

commit 4750524a9d34a97e2957bdf96a22b57c5404cb65
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Trigger save+restore randomly in the #PF stress test

This patch introduces a background thread in the page fault stress test that
sends SIGUSR1 to the vCPU thread to trigger exits to userspace. This allows
exercising race conditions between page fault handling in the guest and
save/restore paths in the host.

> diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.=
c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> index 1b6f64bbcf937..bbbb5bb2a2ee1 100644
> --- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c

[ ... ]

> @@ -94,15 +96,41 @@ static void guest_access_memory(void *arg)
> +static void *sigusr_thread_fn(void *arg)
> +{
> +	pthread_t vcpu_thread =3D (pthread_t)arg;
> +
> +	for (;;) {
> +		pthread_testcancel();
> +		pthread_kill(vcpu_thread, SIGUSR1);
> +		usleep(msecs_to_usecs(1));
> +	}
> +	return NULL;
> +}

[ ... ]

> @@ -151,18 +179,30 @@ int main(int argc, char *argv[])
>  	while (count++ < NR_ITERATIONS) {
> +		/*
> +		 * Only handle SIGUSR while the vCPU is running, otherwise
> +		 * ignore it to avoid interrupting other ioctls/syscalls.
> +		 */
> +		vcpu_sigusr_listen();
>  		r =3D __vcpu_run(vcpu);
> -		TEST_ASSERT(!r, "vcpu_run failed");
> -		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> -
> -		get_ucall(vcpu, &uc);
> -		if (uc.cmd =3D=3D UCALL_ABORT) {
> +		if (r =3D=3D -1)
> +			TEST_ASSERT_EQ(errno, EINTR);
> +		vcpu_sigusr_ignore();

[Severity: Medium]
Can the aggressive 1ms signal interval from sigusr_thread_fn starve the gue=
st
and cause deterministic test failures in slower environments?

The first time __vcpu_run executes for a newly created VM, it performs
expensive kernel-side initializations like setting up the shadow MMU. If th=
is
setup takes longer than 1ms (which is probable in nested or heavily loaded =
CI
environments), the background thread will send SIGUSR1 before the guest
actually executes.

When KVM detects the pending signal, it will abort the entry and return
-EINTR. Because main catches -EINTR and immediately proceeds to save the
unchanged state and recreate the VM for the next iteration, the test can get
stuck in a cycle where the guest never makes forward progress.

After exhausting all iterations doing nothing but VM recreations, the test
would then fail the guest_faults > 0 assertion at the end. Could we verify
that the guest actually ran and made forward progress before destroying the
VM, or perhaps increase the signal interval?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629183746.6998=
40-1-yosry@kernel.org?part=3D8
