Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8352F1FC9
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945947; cv=none; b=f93yl8pVLeVzcesA7ohi6nlm2Ae2WX6do4nF/E0XftGOrBnH38ele9dyvbkUWuru9P/xb9BfLEzy3rGwJ6hN88NHgEuq5+T86Y+IC4bViI/u8rL+0TlrX9FfD8iTMkTezchJqqgm/IT29TS0JO4qfi45h+AQWCcwjcVhOyaj1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945947; c=relaxed/simple;
	bh=nFsaSD8lCqmBc39lxTH3tPplGW76yzJ44QwMA5vSdK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NFOMDmGaDD0uyWRh4r7bBNc1JB1uSZHoVWNiSnPYlnDdYhx9PaH7eq8lxZ1DqpQobFA0Kbsu3SeaWBuG/yI6RXedl7k/wCZUjh3xp4QvzTz9I32s+g3Z1USpCAR/v17a4IQxuYFAyBUvLKptl+kujU8L8VbEJji3AAoVemNd8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIf4FpDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIf4FpDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF81F00893;
	Mon,  8 Jun 2026 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945945;
	bh=D4WhSfUb4C1DGoX7S8um3pkoTEVW/Bx0t285jmVeSDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FIf4FpDIC09dNpMoXjQ838QVf09sD1QTOwuoZYq0Ie+YeUNEYRE9U7DFxk0O8FTVO
	 RaPVFV5Nl6wM2hlQ4JJb98vUnmDPTm09eQvj0nMnD4kBs6FXA8/CR6bQTNXipRa6GG
	 F+ZZd7UfC7G3lVbWIhYlUcjgascr7v17i0ydC5hcc8QtIfTnv4Bb11o7T0+56jqLk2
	 7UqJ7haJylKLHDfgfuKrTQK/xOiRoBBl4Q2IiYFIFYMWR70mwAEZ6qp5mnXm+Fp/OL
	 px7VhZe7qRiIwv728CJD4cqkVvvKqU0v/DGuVjvdK+cnUa/3JXfpgc+DsiWfx+PvqG
	 MwB4G33MPhICg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] KVM: SEV: Perform RMP optimizations on SNP guest
 shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <bfefc8564ae28a05be565d60e8857173d9c1ae7c.1780903370.git.ashish.kalra@amd.com>
References: <bfefc8564ae28a05be565d60e8857173d9c1ae7c.1780903370.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:12:25 +0000
Message-Id: <20260608191225.96BF81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The RMPOPT batching logic fails to optimize memory for guests th=
at terminate shortly before an already-pending workqueue timer expires.
--

commit 855d23e84feebfc7b3cebafc11cb0b8453330a11
Author: Ashish Kalra <ashish.kalra@amd.com>

KVM: SEV: Perform RMP optimizations on SNP guest shutdown

This commit triggers an RMP optimization pass after an SNP guest
terminates to take advantage of pages being converted back to shared.
It batches the work so that a single optimization pass can cover
multiple guests terminating within a short period.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4272293478766..0e94f81907ec2 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2992,6 +2992,8 @@ void sev_vm_destroy(struct kvm *kvm)
>  		 */
>  		if (snp_decommission_context(kvm))
>  			return;
> +
> +		snp_rmpopt_all_physmem();

[Severity: Medium]
Does calling snp_rmpopt_all_physmem() here trigger the optimization pass
too early in the KVM teardown sequence?

sev_vm_destroy() runs during kvm_arch_destroy_vm(), which executes before
kvm_free_memslots() where the actual conversion of guest memory from private
to shared occurs.

Additionally, looking at snp_rmpopt_all_physmem() in arch/x86/virt/svm/sev.=
c,
it appears to use queue_delayed_work() rather than mod_delayed_work():

    queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
                       msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));

Because queue_delayed_work() does not reset the timer of an already-queued
work item, the timer is not extended when subsequent guests terminate.

If a second guest terminates just before the pending RMPOPT work item execu=
tes,
the optimization pass will run concurrently with or prior to the second gue=
st's
kvm_free_memslots(). Since the second guest's memory is still private at th=
at
point, the RMPOPT pass would skip it, leaving the memory unoptimized and
causing a performance regression for RMP checks.

Would it be safer to use mod_delayed_work() to ensure the timer is properly
extended, and perhaps trigger the pass after the memslots have actually been
freed?

>  	} else {
>  		sev_unbind_asid(kvm, sev->handle);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780903370.gi=
t.ashish.kalra@amd.com?part=3D5
