Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8A3E6394
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948717; cv=none; b=sdZFPHlm4auQx1v29eHdViy7p1mbz1K9YlnsG1VSYU3m0kjeYC+7QSZPBmWXp/qDRFd+RND0gJsdBODG9/4l2Ke1YM818R+Aa8JZQdtiAnnFYF7Fu+bVo1CfbhpspGwrIsSq5viPRot1bcIUyx1liihCrql2wGxn/Nfwfsviwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948717; c=relaxed/simple;
	bh=yN3wmg8g4iqdKHMrE8SC6Uv/TbtxlpnxOUFysw9Bf/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRaf3K2KIhO2tlSYf23uxlGd6mP7r6kSFbHkaWTXXBtCBAVQRYU5pmaabPBSrCmbQtjzD0a0DVhdPza+9BD0wqUyb3U/10MzK+0W6JQVycvCcR5zOm/Dl+iDdCYQ4GrLULOGEf2pbu7yKvDonHgbVpZzOc86dJa3Vtw3uTOaaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDyfCdSc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDyfCdSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD71F00893;
	Mon,  8 Jun 2026 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780948716;
	bh=gd1Uii58XjTrgTC/iGqglue7gNeEVes2KuOht/1WvV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDyfCdScuPi9A4tw/GgNUJkPge4H6OENsj8zKmWNbw4ZRjvKAk+t9wDuaKDAOxBtU
	 nIUhNfBNQVicyrBJm9EHvupfJchHYXochutFBzW2jZODqMR4MuJv1/9sTjLRwW6O0N
	 ohlUW7MGGb1BDCn1kQWbOQcOpgBpJkWinFIhZwi1MCv1RGaPh4hGDqQ8axnB0/x7AW
	 51qAUf/xI8MxQ3+JM7M6XWklEkokLtw6sl/QSHYM5koHAFcIDNZI+M/AhQenctmijA
	 bmrwaoVysgS3HEU4Sx1RS0B/I24JojgwQodrTXLcmswd+1vO0+sDeakrjHqijhwblU
	 Opl06g/omHREQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 25/34] KVM: x86/xen: Prevent runstate times from
 becoming negative
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-26-dwmw2@infradead.org>
References: <20260608145455.89187-26-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:58:35 +0000
Message-Id: <20260608195835.CCFD71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double-counting and state corruption of KVM Xen runstate times due=
 to reentrancy from preempt notifiers.
--

commit 4a9cda06784af6de072f170463bdc1b39cf8245c
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Handle retrograde KVM clock in runstate accounting

When kvm_xen_update_runstate() is invoked to set a vCPU's runstate, the
time spent in the previous runstate is accounted. This commit handles
cases where the KVM clock goes backwards by refraining from updating
runstate times until the clock catches up with runstate_entry_time.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 82e34edbfdbd..b1d67ece5db3 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -586,29 +586,45 @@ void kvm_xen_update_runstate(struct kvm_vcpu *v, in=
t state)

[ ... ]

>  	vx->runstate_times[vx->current_runstate] +=3D delta_ns;
> -	vx->current_runstate =3D state;
>  	vx->runstate_entry_time =3D now;
> =20
> + update_guest:
> +	vx->current_runstate =3D state;

[Severity: High]
This isn't a bug introduced by this patch, but can this read-modify-write
sequence be safely executed with preemption enabled?

If record_steal_time() calls kvm_xen_update_runstate() with preemption
enabled, and the thread is preempted in the middle of these updates:

Original thread starts:
    vx->runstate_times[vx->current_runstate] +=3D delta_ns;
    <preempted here>

Preempt notifier kvm_sched_out() triggers:
    kvm_xen_runstate_set_preempted() re-enters kvm_xen_update_runstate()
    updates vx->runstate_entry_time and vx->current_runstate

Original thread resumes:
    vx->runstate_entry_time =3D now;
    vx->current_runstate =3D state;

Would this cause the original execution to overwrite the state variables
with its old, pre-preemption timestamps and state? It seems this would
obliterate the preempt notifier's update and force runstate_entry_time
backwards, potentially causing KVM to double-count elapsed time on the
next accounting cycle.

Does this state tracking need to be protected by disabling preemption or
using a lock to avoid this reentrancy problem?

> +	vx->last_steal =3D run_delay;
>  	if (vx->runstate_cache.active)
>  		kvm_xen_update_runstate_guest(v, state =3D=3D RUNSTATE_runnable);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D25
