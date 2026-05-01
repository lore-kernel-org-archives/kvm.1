Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED23FF8AD
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661869; cv=pass; b=J8G1oEhYnZ5vFNvUv/kZ/pseljRj6Gh/N6r6FIWFLY5TSXRvCefIVbaXqPhXwzW1A7+VTDke4beQ15OGbBtC/M+u0yrUM2l8Q3zJHezdYE7EvoWn92sq0J2FpA+fMtAvswznLmDeIMUkgF/z+2Kkht0REuu1ywAfgNol6YRyINs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661869; c=relaxed/simple;
	bh=Koi/x6eiTTEG0emLXyoyoxitRX8hdub1AnzYnT/nULQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2ADs1WMY8LxpXD7nozc5SSTv6KHeELr64WapN4CvLQgF2+6lhao77zDkOa4eRuygbd41FKiUfrBO3PsEdjaWEc2myunLqRaZZUhkvlIpqj4preehnP1goM2yzboaZUfMyW0wH0UglU2NuL2/ZrUQyUstwf3Tcx5LLca5NkeO1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPQHP95r; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPQHP95r"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-953a5defbbdso1438751241.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 11:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777661867; cv=none;
        d=google.com; s=arc-20240605;
        b=LXyqFpC0ZboAvJDUbY0cGuiFNEypbirLBJoPnpk9jukPSNZGUV9plr3emn5SEdLLKF
         zzrl/jhJO+A3LFAiCpFVVkID/aaew8gU+Qpp8HtEnRGZ8G5QIryMH0ZyPsggdzRBdR2Y
         H4mLsg102unXVpxcw04B5cOzNInAJyd21GxgNS9u/HsLQgaXnmC/Yb9IwxVE2jHfuCpg
         XMRXDVNdA79g80h5pTLUZSdlML8gzw4ILINcm3b8h4pcI+3pUpAs7z/D2N3Ip2f6kgSK
         AbWX9TwqkmeeUcoDDPC24i2Q2m3ZtgaMi+bmOjKHSTAod8hWhV3r36ErvtPlSubD7tw5
         kwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2wORHHkll15fgrTiDIYC4jYGmLh8OaJoz0awypHbtgE=;
        fh=g/wNwy/UZ363MG3IzxECsJqXlYUKUqgVWRtJNHblisU=;
        b=jgmTB5Rhz1gGenmCLuuk2FZz48JMRLDLVqtXBP39sMgoloiHHmBW7HBjt3suux5RW3
         YkZ7Ii9QplWvIlgY5YgMlcknSHZmyziQNQTWf9M6uQ4uOHo+tNIhGtZwqgC44huU8NwS
         3KG5+FcoJJuX4jmPEGM3vYUhXnjOnzz03vTC9lNFEOw4AMLvv9ppEjmY9WEUCCsfDOxh
         FWJG6NGysm+Zec3owrLLzDXFjBFWHiC0URZ7e5BHcaT/Pq2QsjllI2lP7s0u5x+/H2Gq
         udo4H3ieAXhQjmZMYQp/9ANf6ig1dYcMrd4eqHNurLHEaHAfkY86qp5AI9XeaNVSGSbZ
         LBYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777661867; x=1778266667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wORHHkll15fgrTiDIYC4jYGmLh8OaJoz0awypHbtgE=;
        b=OPQHP95rBZVAKwrRBlmV/VrHHhcGKVNK1mcUw8kkDXNtZ1dIb1cKv28bYJauXqR3oQ
         4zLyYoxSZy72wLwklKl4SCmTcxPHf8y1J3KMGivpLACIOVNn3SsVGjEdksHVjGO0ffId
         MmiXhCiZnQd7F/wrLESOnW09vdC5ubVhutLJghl6ovHY0LDjW9i6/QQtA7FbXP4QAqX+
         qWWcBCcSMdt9xVRYY043ufTqcbt4IoFEVmJaLcWFYxItHcOnykZwYzkLBvO0QFel2/Yt
         1DTk49l+YeJcUYhvFiNg+WQCtnCKPsrNoMnrBpKnvKODCE5GmI2U8bZls5oRjOp4eQpp
         5dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661867; x=1778266667;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wORHHkll15fgrTiDIYC4jYGmLh8OaJoz0awypHbtgE=;
        b=BT+NmBOQLoZ+ndVgontZPk+LquwZ8aZo2411x+IgH818T1GnMmkdE9Y19T4vGl4WjF
         yFO3H9KYlA8gcYQ10BwhC1QP8v1gZzBpRwpkb8CsrNyBM/MuUhTKGE9fxG0uePiInFZL
         D0Z0BzFJWWFUdODHOpwq5s5DkycFDjGkSJg9Umbm7bCG2azcOJwO51duKnO9o1pS1czB
         HNlzSTstpUrffPJitF4phGa7GI+zlSgcaDWTjyeXbAs4aOKgeF+K9/JyrkxfazbQROAZ
         niLIrGVW1lNkl+5R9QM0kbWsE2KGeY9XoAqjzPUSFlaQ1dbDSI2PF4XTFxZj1E/Cviuz
         inYQ==
X-Forwarded-Encrypted: i=1; AFNElJ98JzZCHb0UNpvFb6XmHlKpuF1e0X3IUlpmPHgSDhQQL+eOm5q6V0qjlrmBaXzAmUinFEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb081s0nEsl0/8fuKD5uJTDR0sC+hMy+jAY0yNKC+4lmZxd2aU
	xqsHGZlAcd5a9kWCwETe7fEIbWp8/yYwzSskVzv4w+Eb8Q1fiAvI5Fvm7Vh7zNed8T3SbjKLaZq
	paXcweTAAUaP9Sc4ekdsAnPgFv57Pv1Pu47oSlAtZ
X-Gm-Gg: AeBDievvVZzbj/o1Zx/of8FYUbDIEo3meN8SM1ww8TWFtJeTAwuzYUXgGtJeww/uqQz
	QeNVgg0Kvf8UlUgNqj2DAqXvUZP2xduzJ6dpm0YiNuV3fgoFS7s4+sh8EKiDOp9cUhKcd/3Ytfh
	YZJ6LbD+yQfO8/lSklJBsTPYhdKuCpVFoRXl/zVnpYx5U3dLhmPZauqEtiYfQuiJSHzWFEw0H8b
	rHbMRLdFTfBcxOQnL0ylheEitMs5iKUKNSh51vQ9tZJhi6CRD/QXnykQMf37uhIXenB0hVqaqXm
	n4v6aEgkcxPSek1d4NKSliAqcE++dJm/qmEbrbBjSujf7X8XCVs98iqe2zJsxqq/jtN+nvEtsWp
	hYQnkc1frkgdehs61ygh9ouu1Gg==
X-Received: by 2002:a05:6102:c8e:b0:608:cdd9:2bcd with SMTP id
 ada2fe7eead31-62afef0f7e0mr3530809137.15.1777661866644; Fri, 01 May 2026
 11:57:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 11:57:46 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 11:57:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ad924b3fbe4154466195e0668604afe8e0b825ca.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <ad924b3fbe4154466195e0668604afe8e0b825ca.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 11:57:45 -0700
X-Gm-Features: AVHnY4IvsBfXLUkyXbLpr28PPeYHc_4XXhzxQ2PbvYLXjabiP4YS4Oqwx2rdAxI
Message-ID: <CAEvNRgFRJNRyUf3T9TTWr9-xt76E=Z28vSKsdZ46QK3UAEd8dA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] x86/sev: Add support to perform RMP optimizations asynchronously
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ashish Kalra <Ashish.Kalra@amd.com> writes:

>
> [...snip...]
>
> +/*
> + * 'val' is a system physical address.
> + */
> +static void rmpopt_smp(void *val)
> +{
> +	u64 rax = ALIGN_DOWN((u64)val, SZ_1G);
> +	u64 rcx = RMPOPT_FUNC_VERIFY_AND_REPORT_STATUS;
> +
> +	__rmpopt(rax, rcx);
> +}
> +
> +static void rmpopt(u64 pa)
> +{
> +	u64 rax = ALIGN_DOWN(pa, SZ_1G);
> +	u64 rcx = RMPOPT_FUNC_VERIFY_AND_REPORT_STATUS;
> +
> +	__rmpopt(rax, rcx);
> +}
> +

Could rmpopt_smp() call rmpopt() to remove duplicate code?

> +/*
> + * RMPOPT optimizations skip RMP checks at 1GB granularity if this
> + * range of memory does not contain any SNP guest memory.
> + */
> +static void rmpopt_work_handler(struct work_struct *work)
> +{
> +	bool current_cpu_cleared = false;
> +	phys_addr_t pa;
> +
> +	pr_info("Attempt RMP optimizations on physical address range @1GB alignment [0x%016llx - 0x%016llx]\n",
> +		rmpopt_pa_start, rmpopt_pa_end);
> +
> +	/*
> +	 * RMPOPT scans the RMP table, stores the result of the scan in the
> +	 * reserved processor memory. The RMP scan is the most expensive
> +	 * part. If a second RMPOPT occurs, it can skip the expensive scan
> +	 * if they can see a cached result in the reserved processor memory.
> +	 *
> +	 * Do RMPOPT on one CPU alone. Then, follow that up with RMPOPT
> +	 * on every other primary thread. This potentially allows the
> +	 * followers to use the "cached" scan results to avoid repeating
> +	 * full scans.

Out of curiosity, how does this caching work? Is it possible to do it
once and then synchronize the cache to the other CPUs?

> +	 */
> +
> +	if (cpumask_test_cpu(smp_processor_id(), &rmpopt_cpumask)) {
> +		cpumask_clear_cpu(smp_processor_id(), &rmpopt_cpumask);
> +		current_cpu_cleared = true;
> +	}
> +
> +	/* current CPU */
> +	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
> +		rmpopt(pa);
> +
> +	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G) {
> +		on_each_cpu_mask(&rmpopt_cpumask, rmpopt_smp,
> +				 (void *)pa, true);
> +
> +		 /* Give a chance for other threads to run */
> +		cond_resched();
> +
> +	}
> +
> +	if (current_cpu_cleared)
> +		cpumask_set_cpu(smp_processor_id(), &rmpopt_cpumask);

Sashiko [1] pointed this out: after cond_resched(), this code might be
on a different cpu so smp_processor_id() would return a different cpu,
that would mess up the global cpumask.

Perhaps it's better to store the id on a stack? Or actually, what if we
give on_each_cpu_mask a copy of rmpopt_cpumask with the current cpu
unset?

[1] https://sashiko.dev/#/patchset/cover.1775874970.git.ashish.kalra%40amd.com

> +}
> +
>  void snp_setup_rmpopt(void)
>  {
>  	u64 rmpopt_base;
> @@ -568,9 +656,20 @@ void snp_setup_rmpopt(void)
>  	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
>  		return;
>
> +	/*
> +	 * Create an RMPOPT-specific workqueue to avoid scheduling
> +	 * RMPOPT workitem on the global system workqueue.
> +	 */
> +	rmpopt_wq = alloc_workqueue("rmpopt_wq", WQ_UNBOUND, 1);
> +	if (!rmpopt_wq) {
> +		setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
> +		return;
> +	}
> +
>  	/*
>  	 * RMPOPT_BASE MSR is per-core, so only one thread per core needs to
> -	 * setup RMPOPT_BASE MSR.
> +	 * setup RMPOPT_BASE MSR. Additionally only one thread per core needs
> +	 * to issue the RMPOPT instruction.
>  	 */
>
>  	for_each_online_cpu(cpu) {
> @@ -590,6 +689,20 @@ void snp_setup_rmpopt(void)
>  	 * up to 2 TB of system RAM on all CPUs.
>  	 */
>  	wrmsrq_on_cpus(&rmpopt_cpumask, MSR_AMD64_RMPOPT_BASE, rmpopt_base);
> +
> +	INIT_DELAYED_WORK(&rmpopt_delayed_work, rmpopt_work_handler);
> +
> +	rmpopt_pa_end = ALIGN(PFN_PHYS(max_pfn), SZ_1G);
> +
> +	/* Limit memory scanning to the first 2 TB of RAM */

I think this is better phrased as "limit memory scanning to 2TB",

> +	if ((rmpopt_pa_end - rmpopt_pa_start) > SZ_2T)
> +		rmpopt_pa_end = rmpopt_pa_start + SZ_2T;

and then this could be

    rmpopt_pa_end = min(rmpopt_pa_end, rmpopt_pa_start + SZ_2T);

> +
> +	/*
> +	 * Once all per-CPU RMPOPT tables have been configured, enable RMPOPT
> +	 * optimizations on all physical memory.
> +	 */
> +	queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work, 0);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_setup_rmpopt, "ccp");
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
