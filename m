Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3B41D120
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774558; cv=fail; b=iHiD/KsgR8Vd67gJU8PweOaik8Rolauea9PHnsGg/+QgfI5KvYVs12pDaul3VBGzVWtUhWy2AZjEJwn3L20wZedoL+QueN1utIMjE5h+8PZHuNm8MvALyv5OV0OOVitetcg6lphOXsAhHH0wJyAO0eflh8+UX8nxggGe02RlsfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774558; c=relaxed/simple;
	bh=ISaFC0gzTKoPC2zjZFN6jSjseZtrs+FjbpitzFD32p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lMG4ThtHTB45tBAr4CX2gqNEN2M9ar/9Ns5lht62nMbrVwHRRYq43tIvMhvg5nfjOIAS2aOcWNTQDTeI803Wk2YGgQniNda2c+kbERr1+CzxFUoVb5bRLQyyaJEYrh50RRrQ+1HniwZDJ09kcG27dybJz8eWxpC+eBx+tbIR1aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJ39K/UH; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJ39K/UH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giArIgowx+5Ep4HHkzd6ne0ib+g7Iy/imytAJ5vvcVL+4zJn6Gk7YSAYov5IlrS24M/18tdkkTRtQ4C/AJjkt2B00XPM/1T3vDpX5BUtbatfXsXvU7x55W7jeoL8fc03wR5HK5vEnbgTi363sGBuCdTKuOmvBEW8ifwlpowsO14e5fS1QCi/QAHCypeNdAIN9RNRsld63BBo53RAtXjPy5JpDHB4qLXQ+OOhuAmH199FIr0ypMeijdWUvQbqHUm/4LrDPKJ5Udwm6NwO4iN6EyoEF3F0PhT512PCgJjumiHuPHmKK9aL/r71XOd94wPMhgjUfloV4F1/kRBSSGeKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fWlL9fkw1+ByyoyFzka0lCTKJd3ZxjWDG9EEcvpEqs=;
 b=qJzYRjetPBorExQhk6/Lkvm82DjlF2bnqMgwVNXWRotjBOonpETWNtqkQNQCNHxY/Jl3I8bTtMU/7/qTiisTu/6Des2qN7nnluhhb7hyHzJ10bRngnZJjDCnYU6eFtGDseCBRqgo4ffQhKYZQ/Dc0y2mTV3wqd5EXg2TnLxnyI+i7kiPMk8AxhsLM9zWTpI1MGkOLgqICRlM29SvxPAO/n/W5+LbAE+a2lgYggGR7LFjG1ry5sHS9SSrUKR2HKFzRLrmJ/xGlPjK+ciw730i0sfGSwonB0Pcd2vhls6EDTPGcifYqb84Ho1S0UhR8TdEi6bl3BXnFifc7zaXmVYzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fWlL9fkw1+ByyoyFzka0lCTKJd3ZxjWDG9EEcvpEqs=;
 b=GJ39K/UHonjLXZjW9F7GyCSkjbfRFxcBeT/KUOPfpu6RXQYPpLKrrm1ruwtv9+ZjjgQlMz4BuSSu/iv5Dkr2rzmRm3OhIGfcqWdmj3i0OPjek9tEm033fI/TBOea9G+Ko7N3I2arvLgqiEMxgEy5irEcZEHTIntr8ii5SEBPUp4=
Received: from SJ0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:a03:39e::26)
 by CH9PR12MB809658.namprd12.prod.outlook.com (2603:10b6:610:314::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:49:13 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::87) by SJ0PR03CA0291.outlook.office365.com
 (2603:10b6:a03:39e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 09:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 09:49:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 04:49:11 -0500
Received: from [192.168.0.105] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 04:49:10 -0500
Message-ID: <8eb2e144-2ad0-47b5-876f-bbbab102aca4@amd.com>
Date: Mon, 7 Sep 2026 15:19:04 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] x86/cpufeatures: Add Page modification logging
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260907063906.1964557-1-nikunj@amd.com>
 <20260907063906.1964557-7-nikunj@amd.com>
 <20260907064714.8068E1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260907064714.8068E1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH9PR12MB809658:EE_
X-MS-Office365-Filtering-Correlation-Id: b15078ea-92e3-4117-7ff6-08df0cc545a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A2OCQMtbkfHiny6+DdtkPeXv80aCfklP1oy8kyzKFMR+YpMYK7A59NGeKUwJIQ31XtNmr9FCgclDZxN9mpuRe9ixtG3WM8okWZ1uFaUB2+VJ5/eLhkojHUoNUMk+AkH+CQG5cl9vD8y8Ev7ToZ+FuO+eM8DbpzC4IwqEUxxq62Xgz9DoyQKXkx6sAE83XxV6fhdZ7LsUL3iVszMPe48z9m7n2YMEmpSxp540LH/WyNYDnAbXTE8EtnY9jod8iBNCIqxbcI9mmtAciKfTWdq0yvZ4/EbPHtR6+d03v1s+fnDsSWdKrzIqv78Rae3VgjCKZ9qo6JU9kYrb1xGlpddf2+d2cDuv0mVImpE0Fs8vfFMgiVxQvquSXhsyd4tot9olV8ouTYL5jk4Z4+rhC9ZRIuMltlUCGagksF7TV/y/8zySLEid5WkgJDMEXhqBlOZFGytV1M4uBvOWPVSjtQ0j2Pyy9nAQj5B6ok4Z1h80aB3BOfIf71Wq8sw7pT4dDRgkrqQzgwvkkGUI3lxXlBk3RsvjxFLGd1LDRYC53W843jeTnh9cxpxQSyt8vZdAnBCvq4CUpSE9xL0cNWjrVxJ63HOyrX6LjpftTG6gg9ayxx31Y3IIQJRTZ9Z0dwIa6J1KQEkaNu21uvEn06bqHW3majp9WUjS+SaoDVQGA6fkh9yH6tQcGOp+erb2wuy58uRJI2B1khM2HkjZLomfKzp8RQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rXBUR2zqiWUIBuPmN9EUMfNUhfQBLxnP3mwrYae8BdL30/BfMwvoXL5dgCzPpUm5wxau1+A9d0stCUg0a6Chce+zgrEkDsoghCx9s7qX1USvB3aW/UhAvdj0TC6aeot+kgz3xIFnh88r++u9ZL/PBNMKcH3nwBVKieUk6sciRUK7tRNUwUa+DQkxuM6wRffuZqp9IusM4WFMD37dt3khUi3ACYi9ZOw6eFoVNvopb+WqsJ/9E0xucIkwl21Mhj3xHHnQs0o6PH0F4AFRO2a1W5jzHoH7r36aUoz5OHBFuH+1p9zZDjgYsteywLQJwxWAUjrVNNBMbu29cAaqSSm2n+OBYouf7tWz11fZ7gYAsMqnHIiiIR/8a+w2BTQnEoGtVm37QMc8XL8+liKjqSzIiA4EZuA+vvoThgVFQM5J8/Y27jKVsQ0vuNQuMcW721/d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:49:12.4978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15078ea-92e3-4117-7ff6-08df0cc545a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB809658



On 9/7/2026 12:17 PM, sashiko-bot@kernel.org wrote:

>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index f70ee74b5f921..cbfcc66a18e9b 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -238,6 +238,7 @@
>>  // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV unlock function */
>>  #define X86_FEATURE_VCPUPREEMPT              ( 8*32+21) /* PV vcpu_is_preempted function */
>>  #define X86_FEATURE_TDX_GUEST                ( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
>> +#define X86_FEATURE_PML                      ( 8*32+23) /* AMD Page Modification logging */
> 
> [Severity: Low]
> Does this new feature flag also need to be added to
> tools/arch/x86/include/asm/cpufeatures.h to keep the tools header in sync
> with the main kernel header?

No, as per tools/include/uapi/README, updating tools/ copies of kernel
headers is done by perf/tools maintainers, not the patch submitter.

Regards,
Nikunj
