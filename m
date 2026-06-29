Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BD1DED4C;
	Mon, 29 Jun 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764947; cv=none; b=RHJKxLgFsD4+SA94Te4XmSA/HVlaVAoJdtPOt/iS7uXPuAkRj8hOjTJqietmk1EtUmnxzs59bvPS+6/wpaMhhog5m8S/UHrXE70tTBh75pFgDriOba+lDYxnv5Ozv/y+iqWsBbs1D3mmBNcpIG1h8WEiSe+xbat8Io/Mi76VN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764947; c=relaxed/simple;
	bh=EkWiumAdGdEZA1wyoGx6kM49zgLeXp5JyNmsc5Y8gj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBCCDdukXLLE+OGLKjtbAf4WKpu/p80gbEsbPAeJDkP8IuC428wACbJYWThd3Je/d8oyhPDg89OpMXinECzsJ7NuXOlnqsAGrxvyIm6cNcsQBtzv+g9WHmHmVJa1xWcmHfAvtrTQ7bgbIuzK9Bn7cEvgViwDt+z+9xzTVQevgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXQ/2Gjc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXQ/2Gjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8E01F000E9;
	Mon, 29 Jun 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782764946;
	bh=QiaiMk/8MUSUEOkj3Bec2LDycEF7ymV/xwRgd60b7SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NXQ/2GjcMKp6N4pT+J8LYT4BZoAFjra9sd3+wEFa1UEnfqV4R9Xye+XvKruo/SLEq
	 2KtC3pIIteEw5iEkDuaNMsHRia04+WP6zPpN6v/94Nue/4Sil9p5C/dpg+d2lZNKzz
	 wS7l7yZ3ZlkbFPR9/aDfaEcmSx9ZNSVqyOZQZyVWhQcwzIItOctcwKI4b/ATCVMY8B
	 8tJp3VIWxGPrB2LmTCyDmuZXqwyW+ez99j/5YYbn0JHA2zZmsLxLPOblgE6gZ5mqhB
	 4wMu5Ac/c2pMyUO9ykNcbWQ6GzttdffJh8+eWM7WUxQVjqXtQTA7GqHju2OlRXGUDm
	 Fo3Y6QOEuTqYA==
Date: Mon, 29 Jun 2026 20:29:05 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 08/10] KVM: selftests: Trigger save+restore randomly
 in the #PF stress test
Message-ID: <akLU4Zdfal21geBW@google.com>
References: <20260629183746.699840-1-yosry@kernel.org>
 <20260629183746.699840-9-yosry@kernel.org>
 <20260629184837.AC6A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629184837.AC6A81F000E9@smtp.kernel.org>

On Mon, Jun 29, 2026 at 06:48:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The aggressive 1ms signal interval can starve the guest and cause the test to deterministically fail on slower or nested environments.
> --
> 
> commit 4750524a9d34a97e2957bdf96a22b57c5404cb65
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: selftests: Trigger save+restore randomly in the #PF stress test
> 
> This patch introduces a background thread in the page fault stress test that
> sends SIGUSR1 to the vCPU thread to trigger exits to userspace. This allows
> exercising race conditions between page fault handling in the guest and
> save/restore paths in the host.
> 
> > diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > index 1b6f64bbcf937..bbbb5bb2a2ee1 100644
> > --- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> 
> [ ... ]
> 
> > @@ -94,15 +96,41 @@ static void guest_access_memory(void *arg)
> > +static void *sigusr_thread_fn(void *arg)
> > +{
> > +	pthread_t vcpu_thread = (pthread_t)arg;
> > +
> > +	for (;;) {
> > +		pthread_testcancel();
> > +		pthread_kill(vcpu_thread, SIGUSR1);
> > +		usleep(msecs_to_usecs(1));
> > +	}
> > +	return NULL;
> > +}
> 
> [ ... ]
> 
> > @@ -151,18 +179,30 @@ int main(int argc, char *argv[])
> >  	while (count++ < NR_ITERATIONS) {
> > +		/*
> > +		 * Only handle SIGUSR while the vCPU is running, otherwise
> > +		 * ignore it to avoid interrupting other ioctls/syscalls.
> > +		 */
> > +		vcpu_sigusr_listen();
> >  		r = __vcpu_run(vcpu);
> > -		TEST_ASSERT(!r, "vcpu_run failed");
> > -		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> > -
> > -		get_ucall(vcpu, &uc);
> > -		if (uc.cmd == UCALL_ABORT) {
> > +		if (r == -1)
> > +			TEST_ASSERT_EQ(errno, EINTR);
> > +		vcpu_sigusr_ignore();
> 
> [Severity: Medium]
> Can the aggressive 1ms signal interval from sigusr_thread_fn starve the guest
> and cause deterministic test failures in slower environments?
> 
> The first time __vcpu_run executes for a newly created VM, it performs
> expensive kernel-side initializations like setting up the shadow MMU. If this
> setup takes longer than 1ms (which is probable in nested or heavily loaded CI
> environments), the background thread will send SIGUSR1 before the guest
> actually executes.
> 
> When KVM detects the pending signal, it will abort the entry and return
> -EINTR. Because main catches -EINTR and immediately proceeds to save the
> unchanged state and recreate the VM for the next iteration, the test can get
> stuck in a cycle where the guest never makes forward progress.
> 
> After exhausting all iterations doing nothing but VM recreations, the test
> would then fail the guest_faults > 0 assertion at the end. Could we verify
> that the guest actually ran and made forward progress before destroying the
> VM, or perhaps increase the signal interval?

The signal interval was initially 100us and that did cause problems on
slower kernels (with DEBUG options or ASAN). With 1 msec, we don't
observe any problems internally with DEBUG or ASAN builds on a variety
of platforms. So I think we are good with 1 msec.

Increasing the interval too much will probably make the test less
effective, as the signal is less likely to hit in interesting race
windows.
