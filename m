Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F38456DF4
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251718; cv=none; b=r82++PDmo21hc3j5/qRdnB7qM4F/1PA/tqPjz6XZnDx17V5NIEMm3uRzyn6wOvzfJJrlWyZlUWRe8dBY7v7/6Os18Mk6Omw6+5pzGZAc4nXPgHacbXyszLmqhWf44CA5ntMTFBLBzgXCjf6urdtVt2H87v664l8CcxhzHtVMpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251718; c=relaxed/simple;
	bh=1XPeTeyq+OapWROWP2yl/o4e1aRD/REachub1OkDvWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o07KrTjzxsZdfKbmGt62URUIbD/VYlfOgGNFgJ24SUasJDVPe9+h5haTnrH82RQyMdFzSpCOspf+eCgH05iBfzMJW205pydEvK7nJeSOJjZ97Ly4+GIEkAQIdWaO2RPu1E0AaouS0jG7EwlMuy+kiVDGdCswZ47v7NTYfgKl4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUhOSeKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUhOSeKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FA1F000E9;
	Tue, 28 Jul 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251717;
	bh=U3TvFNtwbi/Y2kJprhhAgf98s6+zZGLDC8nv4GbylDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUhOSeKGxdCAs3+Ncuj2B1BYzBhYJl1VmbAOo2uv7t5POZ84YnBj0mw6kazKTuZ36
	 V4TmCKdBV9fTWlCp+svXaOp8gKl5LhFzCHWPgk2XWy15ZmSaekGKUOOSVY0boddEeG
	 xeL5bQwi7Nj7bq9SBknUUYZnCJRy8tTbbGn95hF2wVwk3jpvMarrAbv2OUXJaYivwt
	 Fu7zVaePk6upoG/kdGIvFaEVBPg1ZITbmtQDr5hjhxKacS/Cl9Lp2/Es+6Cfc/ZBhY
	 lP4cqqto0hPlgjmqxdpAKCV6x5dx4r71+oLtWj2JlWQullJI808qndCIiyhmtkQe9S
	 eiJKAbAI9nPZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/36] KVM: x86/xen: Prevent runstate times from
 becoming negative
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-21-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-21-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:15:16 +0000
Message-Id: <20260728151516.CF1FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Cross-thread arithmetic on per-task `run_delay` leads to garbage=
 `steal_ns` values and corrupts runstate accounting.
--

--- Patch [20]: [PATCH v7 20/36] KVM: x86/xen: Prevent runstate times from =
becoming negative ---
commit 1979f0260ec16f7c2af18f6f359a100b98ca0b72
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Prevent runstate times from becoming negative

This commit handles situations where the KVM clock or run_delay goes backwa=
rds
by refraining from updating runstate times and clamping steal time. It adds
logic to prevent steal_ns from exceeding the total elapsed delta_ns.

> Also clamp steal_ns to delta_ns to prevent steal time from exceeding
> the total elapsed time, and handle negative steal_ns (which can happen
> if run_delay goes backwards across a scheduler update).

[Severity: Medium]
This is a pre-existing issue, but is the negative steal_ns actually caused =
by
run_delay going backwards, or is it caused by cross-thread arithmetic?

When kvm_xen_update_runstate() is called via ioctl (such as from
kvm_xen_vcpu_set_attr()), current evaluates to the ioctl/migration thread,
not the vCPU thread.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 694b31c1fcc9a..0670d5e50b883 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -588,29 +588,45 @@ void kvm_xen_update_runstate(struct kvm_vcpu *v, in=
t state)
>  {
>  	struct kvm_vcpu_xen *vx =3D &v->arch.xen;
>  	u64 now =3D get_kvmclock_ns(v->kvm);
> -	u64 delta_ns =3D now - vx->runstate_entry_time;
>  	u64 run_delay =3D current->sched_info.run_delay;
> +	s64 delta_ns =3D now - vx->runstate_entry_time;
> +	s64 steal_ns =3D run_delay - vx->last_steal;

[Severity: Medium]
This is a pre-existing issue, but does this cross-thread subtraction
corrupt the steal time calculation?

If the previous call was from the ioctl thread, vx->last_steal is seeded wi=
th
that thread's run_delay. When the vCPU thread later runs and executes this,
steal_ns becomes:

    steal_ns =3D VCPU_run_delay - monitor_run_delay

Since these are run_delay values from two completely different threads, the
result is garbage (often negative, or massively positive).

[ ... ]

> -	if (vx->current_runstate =3D=3D RUNSTATE_running) {
> -		u64 steal_ns =3D run_delay - vx->last_steal;
> +	if (vx->current_runstate =3D=3D RUNSTATE_running && steal_ns > 0) {
> +		if (steal_ns > delta_ns)
> +			steal_ns =3D delta_ns;

[Severity: Medium]
While this clamp prevents integer underflow/overflow, will a large positive
garbage steal_ns from the cross-thread subtraction above silently convert
100% of the elapsed delta_ns into stolen time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D20
