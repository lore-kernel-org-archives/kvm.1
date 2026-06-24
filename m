Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BB28C869
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339071; cv=none; b=CYX3VNp1AjJzzt71ZM/F7tzW1vfNrM+7iHjFQDUADuRmtTlBMCcRyiv7ZbAI314+LogXlWnrTjelugU9lD9fz7u6+fL4I/LS0c77EGqAx9wNnglwHgNxk0JJpQuTNC4GwsLNeyf3+OyIbd2cBm5rZbFa2mIIDoU9C9SAOfTUoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339071; c=relaxed/simple;
	bh=yF7KBSGUOFwsombsU4RMscAiBCtWyMOpgOuv5D/VkZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FbbCsjDLMNl6e1VBFAIcOIo0SleNp85NAPyu8cnc7EUcfRMGexAdlGq3YvwLDoc7JBb2vPLmjy+gPq+AdR4fAgdyetdCDehrg5Fu0/eP6w0hSt2I2wfClItn2r3JhOqNJXh12CIeQcb68ePjV0Poudt6MDPmYbnmNQSrFB8SoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRH6cza/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRH6cza/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A731F000E9;
	Wed, 24 Jun 2026 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339069;
	bh=+Dt70Qzv334iladyCxyzbLwf2cbkTJ/hVjxL7v9Al9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WRH6cza/GA3yr1HbVGW9RLSsIKPpIck9oyzbEdi4OQyiYwSPB1qaFhcZdaYWNj8Ju
	 TokEswP/W0BJarvg/mak1V9nubIpBgbfhpxakx/dWtwVv+brz6mAdPFTWL+28MIRoI
	 MjKRxGyy+YJ3NZXF+CsGfK3SLhGJFK8N7hEdIussUXQ+FBAMMMghC3pJ/sgSEb9mjz
	 Yv9LiNrhM8Ymv2+4ibKcFUcNHKtY1EpVTnrLzNm/JecT4H7BEOPgYW8CpS/u6wecwF
	 8ic6tBwehpGDnrjCKkpcHCCi9nNzmUoImbiJl0JnHBCT48VRTvgXF9djDnDvx3RP6f
	 YCTTZJfYBcgRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/6] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <94105d8ebddf2c53344f5470ee307da51c8a63c3.1782336473.git.ashish.kalra@amd.com>
References: <cover.1782336473.git.ashish.kalra@amd.com>
 <94105d8ebddf2c53344f5470ee307da51c8a63c3.1782336473.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 22:11:08 +0000
Message-Id: <20260624221109.A4A731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The RMP optimization work handler fails silently if allocating the =
follower cpumask fails, permanently dropping the optimization.
--

commit aff4fb20feaba36704d56dc8d40be21819095e40
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add support to perform RMP optimizations asynchronously
   =20
This commit introduces support for performing RMP (Reverse Map Table)
optimizations asynchronously via a dedicated workqueue. It enables skipping
RMP checks for 1GB memory regions known not to contain SEV-SNP guest
memory to minimize performance overhead.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 60984f76b4e9f..5f99cbbc6cbd9 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -627,6 +648,101 @@ void snp_clear_rmpopt_capable(void)
>  	rmpopt_capable =3D false;
>  }
> =20
> +/*
> + * RMPOPT: F2 0F 01 FC
> + *   Input:  RAX =3D system physical address (1GB aligned)
> + *           RCX =3D operation type
> + *   Output: CF set if the range was optimized
> + */

[ ... ]

> +/*
> + * RMPOPT optimizations skip RMP checks at 1GB granularity if this
> + * range of memory does not contain any SNP guest memory.
> + */
> +static void rmpopt_work_handler(struct work_struct *work)
> +{
> +	cpumask_var_t follower_mask;
> +	phys_addr_t pa;
> +	int this_cpu;
> +
> +	pr_info("Attempt RMP optimizations on physical address range @1GB align=
ment [0x%016llx - 0x%016llx]\n",
> +		rmpopt_pa_start, rmpopt_pa_end);
> +
> +	if (!alloc_cpumask_var(&follower_mask, GFP_KERNEL))
> +		return;

[Severity: Low]
Does this code silently drop the RMP optimization pass if the cpumask alloc=
ation
fails?=20

If alloc_cpumask_var() returns false due to memory pressure, the work handl=
er=20
returns immediately without rescheduling or logging a warning, which perman=
ently=20
abandons the performance optimization for these ranges.

Could this be updated to either log a warning or reschedule the work to be =
tried=20
again later?

> +
> +	/*
> +	 * RMPOPT scans the RMP table, stores the result of the scan in the
> +	 * reserved processor memory. The RMP scan is the most expensive

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782336473.gi=
t.ashish.kalra@amd.com?part=3D4
