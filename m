Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD73BE164;
	Fri, 12 Jun 2026 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244479; cv=fail; b=BxHhed6zh5I9a0km7QRKzPyTp8FNPJEgaVpRDmlLxffRz1rAXoNKYAeOJpB08t1HqDWmSlPLyJkzLShRjNzjL0PiIpAxNignd0r1ItYKEM1ak+5pH8vhiU0JGVS14tQvqqqHMr1Nvr7UUv14/bisLvOhBrT0HohHjS233voV2GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244479; c=relaxed/simple;
	bh=4FpEDOWLuxFkBA7M1BZLE7pJxvB4FclBmaXvS/3XY1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f+D05kAMJO8nRUpWVZu9Dc6m88y8qHncXXwbvdh5e2hcYtDpWMGRrEFHDUAs+p6z688DtxflfuJbLlO1ZtHjajxoY4P3an5NFLI+G+dE8K07Y/SC1uGQScQ0NwwSZhPMBaPoobFUWN3E7Wm6ZxunBbuFeLwgV0wlKs0Tcgu7as4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jmk0qSm9; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jmk0qSm9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N54/NFwIxZhvKDgj7ETLPBE+NK5xrse6jVeMJ6DkkrXH/5A/6jhl/yN0WCiPRD46Ta4dh+LtUkD9AvGGOHIjUDPLUn4EFrAA9SpNNf+8F6YueRq7PXlF7Zyl53ZvucHMl4en2iu7rSSfkIFff/wCR9bRqFrJK0UgllxLGbdtIhgDhUfYbfXgZ1zpOWzVSlhXx6CUoMnvBsvXg863GcDx5LiT9YYjjPq9dDhlcO1zwrMPp7kMUcwmuESIxQ1GsvJHnrAFSpKhaAUIwthzceqjQRXPN4dCYcCL2BuO64U4t9MwCMCCfyF2q4vMCqAMUjMKKK+qK4al6GPpM1x1oufgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hbxkVQSKMAmR8qX02acy8z8V7y+lWavSQDLI12jZQ4=;
 b=PzQIRU8ATZz+un85NpdZrxOUG45NlFTdOh5W1Raqcv9x2Fww4XtCpGvN1ZISBm+AUx3oszbSagfl4dnSRFyqSMUZ72Lm422VOLbHA1yi/wUP6DycM5Teg20zfMb2LI6+wqMsnSj1ecMN0hD+KAIQGAyfMQMeNynNa7COqjMJJnChJFSF+BxkVElN4dab0jcdjlSTq59S265Jum+kTDyhDX+mWJdWeJ1eTL1VkQ8fmUNhOPY13U5v0+lOeMA88mxSjiW5HXJu2xWrsbEhWwtyrGBIHCP0g4bHqa/aIsu0mo9+BkhhpuT38KJAaNHwb760TfJSQXdneiDBVJbxuLzI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hbxkVQSKMAmR8qX02acy8z8V7y+lWavSQDLI12jZQ4=;
 b=jmk0qSm9RxigDZWqsq+lt7YE+ocS721X3RF1rBPpK9Jecc1xNhA0v87JFr3HLlsfK7jz1cLroJlvGlomOahaC9fB5LloS02Pq7szteTtNLocYKmQbQJNmksE1EviKII8WdFp7BNa549Z2E+KCGZppw2eGm0v53sX4eckFyHw23M=
Received: from CH5P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::13)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Fri, 12 Jun
 2026 06:07:52 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::8) by CH5P223CA0017.outlook.office365.com
 (2603:10b6:610:1f3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 06:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 06:07:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 01:07:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 23:07:51 -0700
Received: from [10.136.37.196] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 01:07:47 -0500
Message-ID: <380d53e2-3671-4327-a613-cf35c58b55d9@amd.com>
Date: Fri, 12 Jun 2026 11:37:46 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] sched/fair: Credit a persistent,
 queue-depth-scaled vlag margin
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>, Richie Buturla
	<richie@linux.ibm.com>
References: <20260612013355.59231-1-kernellwp@gmail.com>
 <20260612013355.59231-3-kernellwp@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260612013355.59231-3-kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ba4123-422f-4c56-806b-08dec848efe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|11063799006|6133799003|22082099003|18002099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	p1ekMYUSsFDWYXNAN8xTT6FPJndT3r827QAteqvSgU3rJuUu2V5fUk19qbAxRLHowIKY938PE/w9PogZce2MqIrDusDW6U7dZaVekvSRhOw6ENWO7beBZV+J61BfjNhp+Emzq11JOG4yiRylZKva1NDwCkhTXQNVO+0yvLVJEaFq10s6adH5sitUH93m2TmHqPe3lFmmL22eTy3962cfFccPr2ptl1dxIqO80CYnDirGEukxvgCyZgCRPFmKoKmszdRmK0q2s6WTPqgYzBTFei6OjfH+jxS9XvFTO5AvB1Z4ZONNvLBIR3oRhXEY5b/W2qZHo3XVFrDiXFuuKrdPpVuFDhZDZDWBjisCkJYNEiNHM1pAQwJf9+BL5SQ00ildRfKD2BjhwopgSktc/z+QN82jVQ5CnCYNfIT1dVGpO1P9KFNl6IcPxwlV3we46p5R9GBSQ2KlMaxlb0F/iOwt6wZCncMkyAa8T2qi3O8uOTkQPvJmEYcXViJbM07lYwqVUKqGvRi/slBsFgK3uKWylNG1FDzEDyave2kP1FELQPGdOnoE0J+7EX3H4dnYTStlScuB4AXIVkVjT0X1dodGsqb26QAhlBYqLoN+pFkXN15DPr+iPip6PrYiDE/xK93UJ2jfX10nYvqussLsuoQ9vgRE89cDxYzvjBks5iy+hnFHPYlJp0J8GW6TQUaeIr5vRSLs/DbYxrkswmKc4xyF/28NyFC61/xME1lu1+Bu3jE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(11063799006)(6133799003)(22082099003)(18002099003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ht8ZfMTdQVuzqEsbeo9Og2LQ4Shtc2tOFAJD44qpQZoipj5B84vY21G2KOjzLpSJtW+oCu/YqJM+gqTKOWc8ELQ65O2uofWMqHG4YYPthIOrSmVlMiR1OnSPE/0rU4lE5/sI8cTlOOR+UiblubeBOWI7IRzVUUNl+oY326T1jSOsMD8iIJ9TW4Bg5MSi3pI6RQFtwetFII6XvIhVonI+m6UJuMFANVdci17utqlEXv25OWDLoYj3RiMNnFt0p6lEFf5mcldt+bO3aohNCFkVpqsXKxiqzUdT4yUdwQcbRnKg/leuMo+KoArCW5I9gnauITvXuUtg1dpofBcHrHHUoOkqmdqctAxPIWcyu/9r/5avE+i3DDPVzAV8JSaHNwkCkhDQO7PxuykP+DbixgsO1L+KJSGb0BzId7Bd8C8rRRQKZUO87J5mr2Z79eP99U0Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:07:52.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ba4123-422f-4c56-806b-08dec848efe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

Hello Wanpeng,

On 6/12/2026 7:03 AM, Wanpeng Li wrote:
> -	/* Already eligible: nothing to do. */
> -	if (vlag >= 0)
> -		return;
> +	/* Clamp the margin to entity_lag()'s bound so place_entity() keeps it. */
> +	max_slice = cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
> +	lag_limit = calc_delta_fair(max_slice, se);
> +	margin = eevdf_persistent_margin(cfs_rq, se);
> +	if (lag_limit && margin > lag_limit)
> +		margin = lag_limit;
> +	if (vlag >= 0) {
> +		if ((u64)vlag >= margin)
> +			return;
> +		want = margin - (u64)vlag;

And we are making an eligible task more eligible but *where* is this
credit coming from? Someone should be paying the price right?

Just adding an arbitrary credit and then moving the task doing the
yield_to() 0-lag point is simply not fair IMO.

> +	} else {
> +		want = margin + (u64)(-vlag);
> +	}

-- 
Thanks and Regards,
Prateek

