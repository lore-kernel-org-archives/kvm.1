Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0333F58F
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659165; cv=pass; b=d8VS+RseDExYJOPghabZ3roEli0whmlfF5DnqT6oVNtN6VwBG/d/wn2rjOLNSnMdZ3NgojLzH0Y9qSKrZ5vn0/oVxwaG0KnUVtT7UHS11ykICEVD7glOE1WBdS84na8irNJSrAwIzdeOPlZH07F6luz5RzB/eLLx7WlOPlIPDjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659165; c=relaxed/simple;
	bh=Evb7pUiFabj+kz7Z4hmGLA3FozrlLW7MTuvahXfdXYw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptI446i557hBJxNV38pSde7AgMT4JoWRVLnk9PJj4PToF1sR27KMQFmgSdsBdIw5ZElMlFPkKYd+QAPrFvzcQ9cYjrb4uimOGPL5DhKkQWNHG/UXq8Z51TsVmx2GOzy/tHZyDmn+dQ1oP44JABn5VgmW4oE3k6WSB6X2MfZdaPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fz2xMDPu; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fz2xMDPu"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6058ac0ebceso1505347137.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 11:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659162; cv=none;
        d=google.com; s=arc-20240605;
        b=fWq9lvYVKbYAX6QpOHQ3qlEahuqcAy6Bqunz0zkB/KvFnsLmQfIjzAI5k4fyJe6xQc
         n//jbFWQ3xBpvKnW54+iYfUJkifPsmGXjTy8CR948vU58bUi6NaAzLlrbC40/ELpoUL8
         rsg1F6Cs0pULDpsRblB3/nlPuNDpzjMe2YSpnTvbl9OdRswvfdsTvYr7ltLJiOUNur0l
         cFOARuKpu+lEsNGQnUtl/3cZ+I/PgNlwEwvkmtr7KjVEAZ+LwrmBHhpF/GikG2msAwFe
         0l6dZPA1Wkg/BevxVbFMNT/jUxEeRh7cBCZEVv1vBW94yoHWnUp4EstO4Qc8l1M6PV/E
         hfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=A/Y83NyQH5pjjwFsH83zSujxJ4pp2R0dNDGRnTykyOk=;
        fh=z661g8PhAycR4rMfPS+Fan+/FNHpmwGDesg0P+n+Ies=;
        b=ZjMUxKYYcGKwSApjeqPxoIEAgp7FjzigXbWIqLDj80F9k3O8AMqtGkqyAaY297+XgP
         KRK1CETyBYAsCKsLu1HcmF0v3G56WbHv7tvtPhWsXbZDW3ydDr4qsF5/N1FSbUyjyJCC
         QnVNExwAbHSz56PBCzmD/e1rzBgNlg7GlRFodfUgp0Til5tnco63MvPfCsiSuV3Pg4sf
         9XVGr521QrgMGXiSXIpHJqI7SrlZDa7pQIi8Kqej96/XPBGakp9WNMxc7coJqFDyd29T
         /AO9eiIQh2CXUeTGYHbaks/pUpOiNS+9DirW8or2C3QQpZw2OvOv+46C+Cz6dOaPcgQF
         WFAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659162; x=1778263962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/Y83NyQH5pjjwFsH83zSujxJ4pp2R0dNDGRnTykyOk=;
        b=fz2xMDPuAiN1GvGYv00WHHCXNhkiUmU1fUxwtQD3Endev+5cLzROkK65gzFBFAu81E
         UaiRueZk7P1+cltushahJ3seUetnjSN4wPsIp4QNipIoAw+0ku0Q53ChumDm9zQOeJmu
         dPdNOAyhBfQUwkPdhUZvBayOoGnwIFGRmXuvHFe5W5ZsHFgQqGzS4BzK7SkvxIB7zhOF
         aHg07/unMM0YT1/yZumCc4Gph6cBYRDog5tN+qnq+vPAZjrOhMO2416ORxUoIsQwfpuq
         q/5nN0vLWv5cX8PFPy+QFGphX+1ngooLH0RcYxv2fpH3q5fGZNC6LdCl7h3M3HIUBRFz
         FJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659162; x=1778263962;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/Y83NyQH5pjjwFsH83zSujxJ4pp2R0dNDGRnTykyOk=;
        b=QXXvrjTGhO15DwflqP7rz1zNjUWr6f98vgpb3R9tCuED+0VYnvbW4BtsuUBwgYLCXE
         YPw+v9hJskYF0R8KUyTwkoNOYLwQo2yebZ2clwdewJoACpiXH5iUGwuzUr/tOhyf1zNW
         cNopGbQvveGs+d4J2ldsgcDagmBzpwuXOEuKL6KCltnakg8PvD90V4FOEQkQH3QhlhPL
         8YlkzaYmpBzwUbHXduGn35lps4hM+etGpEbMw6SU2C49WNMMNdfED+HfKuXJ5FDvLHXv
         lrFuIZHRlNMSfzNLyD65CniYqh2zrbX/Ff9ZCJGHMYekYTDPsDd0bpeVAUxJBUs1++oZ
         n16A==
X-Forwarded-Encrypted: i=1; AFNElJ+SnW97W0SOXmP19PgIiSOr7GYMyVXCVZtuU5+sJMDhsDEGWL69cKE/9wUS1wIXcq7Qdx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBEXEXnAyFDcfEoeXeGvFaa2FfQExMuOFjKfcedu94z1FIn9a
	OBY6ud9sv3ke/72VFKIW9cwr1KSi6KTrJctZJ8e7ugCEEQiaqajVzeuSGQGKBJAw7NQXFhGls+6
	4MsxNHcJnfSdxklvdqGas04xWqjsPX2jHsLWTQQT7
X-Gm-Gg: AeBDietFEo95pev8uJHs5iWxtu9umGsawcdScAZE6JanFw3b9mOxYe3iBARwF4sTuau
	W7Gil/BXzPrSQFPvDfUdXJDxp9hTGttXLNjp2+uvpa2ukDtzJxkMhpqUnMH9Y8NKByMGAU2bFRi
	2l92qg8o0Br7BJQPqwFQbl8yhnx2NrRqJQy2czLESc58AEYidCbTDDfPudCXUxyynK0zf6HegjB
	Wxh/aSo+rABEpQ2FObzJOYmsvaYSYMIL7/z5pGPxmngwwVrVr+QPUCgcM+BJyAx5PpZ7G6SqmJG
	9PAoV/1esQOeuZ17RZnEBvO8+eg01PUaUe5taLM8soUgw/gnSXjzuhZKQazOZodQRlnkMGIPRAT
	W6Ld2o9Z0M0BYmnE=
X-Received: by 2002:a67:e116:0:b0:605:5d09:8631 with SMTP id
 ada2fe7eead31-62d87c925d5mr189727137.29.1777659161523; Fri, 01 May 2026
 11:12:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 11:12:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 11:12:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <846263383f9b6a08fc87ce6edb931c912f68c60d.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <846263383f9b6a08fc87ce6edb931c912f68c60d.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 11:12:40 -0700
X-Gm-Features: AVHnY4JCk1U3ofCsegg3s5i-0XLTqrNFTyFRrFp-Tgnyf0yeEIzSs60Geh1Ze08
Message-ID: <CAEvNRgEC2NSROZWz8uxnOSD6t8s1KmmFrr92=e8s30PJzYhQ1g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] x86/sev: Initialize RMPOPT configuration MSRs
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
> +void snp_setup_rmpopt(void)
> +{
> +	u64 rmpopt_base;
> +	int cpu;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
> +		return;
> +
> +	/*
> +	 * RMPOPT_BASE MSR is per-core, so only one thread per core needs to
> +	 * setup RMPOPT_BASE MSR.
> +	 */
> +
> +	for_each_online_cpu(cpu) {

Dave mentioned hotplug in v3 [1], which led me to check. From this
series, it looks like RMPOPT won't ever be performed for newly-plugged
cpus, is that okay?

> +		if (!topology_is_primary_thread(cpu))
> +			continue;
> +
> +		cpumask_set_cpu(cpu, &rmpopt_cpumask);

nit: perhaps flipping the condition is easier to read:

    if (topology_is_primary_thread(cpu))
    	cpumask_set_cpu()

> +	}
> +
> +	rmpopt_pa_start = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G);
> +	rmpopt_base = rmpopt_pa_start | MSR_AMD64_RMPOPT_ENABLE;
> +
> +	/*
> +	 * Per-CPU RMPOPT tables support at most 2 TB of addressable memory
> +	 * for RMP optimizations. Initialize the per-CPU RMPOPT table base
> +	 * to the starting physical address to enable RMP optimizations for
> +	 * up to 2 TB of system RAM on all CPUs.
> +	 */
> +	wrmsrq_on_cpus(&rmpopt_cpumask, MSR_AMD64_RMPOPT_BASE, rmpopt_base);
> +}

[1] https://lore.kernel.org/all/ab41b1d8-e464-4ad6-ac07-7318686db10e@intel.com/

>
> [...snip...]
>
