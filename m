Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E949B5B2
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078380; cv=none; b=sckRnnXp5VacmGPxWK1qo94ROTTm+ss393lLBMkNU4kcBPgRhH7ACT+1MOMEF8YRnvlNv+oJaQIKZEPFEUCR+ECe1udxPO70P7TEwtCk683CPD6vZxeVxmlAQd/Q2sd0HU4Aa0RtrCXubcA4jjOEk9GBxr+LdHBohto/0m0tpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078380; c=relaxed/simple;
	bh=G0wqSGdSnUgGULY94xZn1xcmcLSENb+0oAvNPbiJToc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDNa0Lh2gj8F7tcPQuvPSDfWendIIJBHVbt4Qx3tqJnNfYgLUkh0tZCH34ueTJsY4f4K/TSUh9uppNE7jXV1uxIMxrpLE+c8iT/rg9oGj94jcAN7mbUkhxL+mYcdo/rnUa8ohUw83H9SgomvO3nI2xkJETyHZa1Do6keees1TU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8b54QUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8b54QUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085AC1F000FF;
	Thu, 10 Sep 2026 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078379;
	bh=lEgKHtHIQWavzsmZEP3oEru373jmN3woZ+q1HU8Ft48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8b54QUBgR7HdGjJSM7GU3EA8/UiVwqv6NxS5JpfR6m0BQ6C+7jCZXUj15s67arkJ
	 W8ghdBgl9PY83i4t4QyAGKQwCW/selF9lFKETiP2jsNRFIOScp1UQynlEqfcu3wUG+
	 zWQAX7ik8wWT8zAfBxyYKL7W18c7tbGg/ibj0rcSeqYP998y3V5/9s2BO5Cbibq9EB
	 8mZmyKJ6fMn8KqLUwoqzHcjrsgjjWsKI1V7BPUwJH/x3zGhQWQs4v1QeQxgZMhRJ/n
	 75HWV6Mz0OAUBgoj/C2JwSVEpr1yQ1p2hcY4dt+eD2R6K469bCbZDWmS5zSCOI543m
	 qzzVwxPLkCAlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 5/5] x86/sev: Re-enable RMP optimizations on SNP
 guest shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <a2dace70da1ea687b81a237372d4b7b6e82f1cd3.1788984053.git.ashish.kalra@amd.com>
References: <cover.1788984053.git.ashish.kalra@amd.com>
 <a2dace70da1ea687b81a237372d4b7b6e82f1cd3.1788984053.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 22:12:58 +0000
Message-Id: <20260910221259.085AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Race condition between KVM VM destruction and CCP unbind allows RM=
POPT work to be queued after SNP shutdown, leading to a potential kernel pa=
nic.
- [High] System lockup due to broadcasting a cold-cache memory scan to all =
CPUs with interrupts disabled.
--

commit 5610134a51dd4a088684e2eb5968c3e869f5727c
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Re-enable RMP optimizations on SNP guest shutdown

This commit re-enables RMP optimizations on SNP guest shutdown by scheduling
a delayed work pass. It introduces snp_rmpopt_all_physmem() to queue the sc=
an
10 seconds after a guest termination. The delayed work batches multiple gue=
st
teardowns into a single optimization pass.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5705723f1f412..d8e6b8a08b79f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -3032,6 +3032,8 @@ void sev_vm_destroy(struct kvm *kvm)
>  		 */
>  		if (snp_decommission_context(kvm))
>  			return;
> +
> +		snp_rmpopt_all_physmem();

[Severity: High]
Does this create a race condition with CCP unbind that can lead to a host p=
anic?

If the CCP device is unbound or shut down, snp_shutdown() is invoked, which
disables RMPOPT by cancelling pending work via rmpopt_disable(). However,
rmpopt_disable() does not set rmpopt_wq =3D NULL:

arch/x86/virt/svm/sev.c:rmpopt_disable() {
    guard(mutex)(&rmpopt_wq_mutex);

    if (rmpopt_wq)
        cancel_delayed_work_sync(&rmpopt_delayed_work);
}

If KVM concurrently destroys a VM, it calls snp_rmpopt_all_physmem() here.
Because rmpopt_wq is still valid, the background scan is blindly re-queued.

When the delayed work executes, it will issue the RMPOPT instruction while
SNP is disabled in hardware (SYSCFG_SNP_EN =3D=3D 0), causing an Invalid Op=
code
(#UD) exception and panicking the host system.

>  	} else {
>  		sev_unbind_asid(kvm, sev->handle);
>  	}
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 35678b1f535d4..c16f826423903 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -640,6 +640,37 @@ static void do_rmpopt_work(struct work_struct *work)
>  	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);

[Severity: High]
Can this cause a system lockup by broadcasting a cold-cache memory scan to =
all
CPUs with interrupts disabled?

When an SNP guest shuts down, it queues rmpopt_delayed_work. The worker
function do_rmpopt_work() attempts to warm up the cache first:

arch/x86/virt/svm/sev.c:do_rmpopt_work() {
    rmpopt_scan_range(NULL);
    on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);
}

Because the RMPOPT hardware cache is per-CPU, running rmpopt_scan_range()
locally only warms up the cache for the worker's CPU. The subsequent
on_each_cpu_mask() forces all other CPUs to run the scan with interrupts
disabled.

Since all other CPUs have a cold cache, they perform a massive memory scan
(up to 2TB) while IRQs are disabled, which can cause immense latency and
lead to host lockup (exceeding NMI watchdog or RCU stall timeouts).

>  }
> =20
> +/*
> + * Delay, in milliseconds, before the RMP re-optimization pass runs afte=
r an SNP
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788984053.gi=
t.ashish.kalra@amd.com?part=3D5
