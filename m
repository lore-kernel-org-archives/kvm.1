Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980227;
	b=1Bsa99Gpf6hZWpnVT6glDIGynB6t2hZszX3p80AXjGMPpNcuxVUhyQBqV9EvjKBPfAnS
	 PaFRl4CC0MuMJnRY2hoQ3t0e3R2ygIwZiaDOBmO3YIiMQHGXJBTdUbXspgqpYo2YUzh8D
	 oF5JTAUtx596NLVYzlyHpvspOHO0rcwbnTOO0IycrDDZzK9BYvDV8+KpZzK7GPdnlW8P4
	 kkbfheH/CurwgzaEtOxW9ElQCt9PS/JIR7SPcaz/4+88App/rRjG/G//gEXH1sICxFo8r
	 P3g6sXZWE387wKlWU9VcjtZkNAp4WurdLHMBQq7ZZj4FivwZu65uivDhUSugCMdu89w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bjwk9tDO8f1h3aEvNEMTJAmAxCZXKvo0+Y35LraCst4=;
	b=n9xpd0ncTvuAuFMjU3pannLznEuT6vv+01V+SygWw0wHXBtaEAU4D9iQn58bhlpYk5x9
	 c2KmiHsBwBZL7XMZ4qAcJyQ2qyXrj/VSacFWwN0gSvoCPwCMxvJNfguFeH44ypsgJwqU0
	 xSHticxqCV4fcCbsQQWXtRACEVQ54KewVK79robUvoCpuGYFigZzBJFizZFOGuREbRSgr
	 vHBZYr1aH4o/AVsDn3VEj2A7Y7qrCzFippYMpRfhqvGYSbBsvQF4QgNPyRHVofBc3TZhg
	 Fnk+NAcI47X+J4n7AdBNm1aK7zUByiSvqDicrmaMaTkvJVwofqXQfIHSsEKzHzIPMtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy5qBz93;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3F606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy5qBz93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EDA1F008A4;
	Fri,  6 Nov 2026 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980226;
	bh=bjwk9tDO8f1h3aEvNEMTJAmAxCZXKvo0+Y35LraCst4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fy5qBz93leK69NJ1zEVQfd4WTXEf3VzqPH2x3aib/QWUg46UllXFg+BKmiz6MPTT5
	 qsW2YVTQyhmyTM2fqTNqy+bvIdgwNByCMQ6vTtrMlxMdfX4HHrepZ5Egvv29rEHNFZ
	 Gjycvdn7r+uwYMyG2acUaaobKmpP8hYqDYtgm0umPoYa2cO84HbzRW9UBBm7OfUgsH
	 1XmlZ5Rs58uQt8u0IEC2czpvZZVmtzf2ahHPaWmlfW/L0TSHG9dIHL2Z6CsJ+XZcMx
	 PDwqtQx1bNJqE13wWn38NxCidJ6ij5Niil5SM3g/Dpu7YVYIG0vavHgwOhzEf6UcMs
	 CLu6rTRu4eaYA==
Message-ID: <sashiko-outbox-201736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KVM: PPC: Book3s HV: Ensure reliable usage of
 latency counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261106153136.330165-4-gautam@linux.ibm.com>
References: <20261106153136.330165-1-gautam@linux.ibm.com>
 <20261106153136.330165-4-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:50:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: PPC: Book3S HV: u8 overflow in
  kvmhv_set_l2_counters_status()
- [Medium] KVM: PPC: Book3S HV: l2_counters_enable underflow across CPU
  hotplug
--

commit c5caaeddc35ba638841a3b81b1767bed8f97a3e3
Author: Gautam Menghani <gautam@linux.ibm.com>

KVM: PPC: Book3s HV: Ensure reliable usage of latency counters

This commit replaces the boolean assignment of l2_counters_enable in
kvmhv_set_l2_counters_status() with spinlock-protected increments and
decrements so the kvmppc_vcpu_stats tracepoint and vpa-pmu driver can
enable VPA latency counters concurrently.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 5fa6f93548add..e1bde3c6b0c4e 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4142,14 +4142,19 @@ int kvmhv_get_l2_counters_status(void)
>  		get_lppaca()->l2_counters_enable;
>  }
> =20
> +static DEFINE_RAW_SPINLOCK(l2_counters_lock);
>  void kvmhv_set_l2_counters_status(int cpu, bool status)
>  {
> +	unsigned long flags;
> +
>  	if (!firmware_has_feature(FW_FEATURE_LPAR))
>  		return;
> +	raw_spin_lock_irqsave(&l2_counters_lock, flags);
>  	if (status)
> -		lppaca_of(cpu).l2_counters_enable =3D 1;
> +		lppaca_of(cpu).l2_counters_enable++;

[Severity: Medium]
Can lppaca_of(cpu).l2_counters_enable overflow here?

In struct lppaca, l2_counters_enable is a u8, while vpa_pmu_event_init()
places no upper bound on how many perf_sw_context events can be opened and
scheduled on the same CPU via vpa_pmu_add().  When 256 consumers enable
the counters on one CPU, l2_counters_enable wraps to 0, causing the
hypervisor to stop accumulating VPA latency counters and
kvmhv_get_l2_counters_status() to return 0 while active consumers are
running.

>  	else
> -		lppaca_of(cpu).l2_counters_enable =3D 0;
> +		lppaca_of(cpu).l2_counters_enable--;
> +	raw_spin_unlock_irqrestore(&l2_counters_lock, flags);
>  }
>  EXPORT_SYMBOL(kvmhv_set_l2_counters_status);

[Severity: Medium]
Could lppaca_of(cpu).l2_counters_enable underflow across CPU hotplug?

kvmhv_counters_tracepoint_regfunc() and
kvmhv_counters_tracepoint_unregfunc() both iterate over
for_each_present_cpu(cpu) without CPU hotplug callbacks:

arch/powerpc/kvm/book3s_hv.c:kvmhv_counters_tracepoint_regfunc() {
	for_each_present_cpu(cpu) {
		kvmhv_set_l2_counters_status(cpu, true);
	}
	return 0;
}

If a CPU is hot-added via pseries_add_processor() while the
kvmppc_vcpu_stats tracepoint is enabled, disabling the tracepoint
decrements l2_counters_enable on that CPU from 0 to 255 (or drops an
active vpa_pmu event's reference), leaving the VPA counters enabled after
all users exit.  Conversely, hot-removing a CPU while the tracepoint is
active skips the decrement on that CPU when the tracepoint is later
disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106153136.3301=
65-1-gautam@linux.ibm.com?part=3D3
