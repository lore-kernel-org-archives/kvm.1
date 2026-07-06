Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760373DA5DA
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368691; cv=fail; b=fH1AdaSgwy/E0aWg9gHPyDC8nyZQkvfFQB7buvt+ZQh6IXGDhkwT/JNsPSwLf+fVXx6fusWiyJrAHiUuqbVrppwfuV8yFL1rn+cq7WCau0oPWxBZQOHDYAvGDzT9MSqyNMqB1D2e2zczZyRhQcAVXVHj/kBfpjJK6ED5MDNZNeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368691; c=relaxed/simple;
	bh=RWq5KoSE5XvnWKhL7S3LyUjYd0x5jGrMvZluiax4+n8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rl3QJ50u2ee5eJHSR9GJT47ZkOdraq1xJxeswZt5NCwDrn1CfIccx5BZNue5q3r5hMO1CG8+O4eOK6Gi+bHTheryrNMjbOiB088g8suy/LhUTTBNs765ea/LqAYU9y68KQI+/kSbZb55Eh/AUcpn3fFWrrb/lOEKg/ztuIyJhAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MWysoe1H; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MWysoe1H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCBhmnCMv9pbK4uUeN3p7LbSTcWITAZ3MzlWLorrfHO/45Dj6de9KHLX3lYZkCBgT9otDS0RdznN15YSAPRZXplk7GBztYvbSra1rP8xbefe4PvPpDMNUTNK8UerW1o6pYjWCDW5bTk/1Hxvco0rPdYMROjcZhkPq/9E16p/X/viDMAEy0S9yM9NoHyGhQiojcin9BaZADA9UJttW4dBpusi2AvJ7HQ1XMputYA2YCIy2atZMWpxyD9U8zYAz8MkC330ZuewgDuVlMQ9y5cQ4E9bwmTe1rP+5V6kPZBEt00Xv41lq0Y1D0HFYRi+7/ld+si2DEdg4KkT0KBSY6fdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrYNUlY6hsoHLkGdTeVLf0Bc6ntWI+vgxXnP7OKqZlk=;
 b=dGuFgEXl1bYZ5GmL8j++Y0WqjjfcKBSpx8XdJ15QMg2Oh3ZxC1w8fqgyArvrEC+eWBl5XkjEEIABdRn04Dn1JeBuJ5JnmahNkayaWn5Q5nOBx+x5rv+uGGrKRkLOFnzxjpdZwuZlzi/fT0hadkOASx/b74haimN1I2x2sk8OiUPgMRi3/yr9Kf8oh5mrzBMx1FbZqydt0VAw0ctuMwLUsLWA1j9ERP8mNtLUvRFJRQT6lVuyKscjiDNMt3FrkcO1oCCFj0VaTpQZhA/wzOgL0DXZ0z1HZAhVjv4GX3SAMydbv0iC4nzltX5vBUTtNKx2Htu427nSS20w4c72mtoq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrYNUlY6hsoHLkGdTeVLf0Bc6ntWI+vgxXnP7OKqZlk=;
 b=MWysoe1HRYBASFKmqsbsya7o61qbNeFZxPpjRUr+O5ce1sA96lHn/W47uuzqteJC54ekwG4GO8S/F1deDz0+jO1IaJE7Oxi52Zr0hRv1DBxKMoC0VaAItgpskcynfFdJqeujbajz/McumUhzPo+mcc7CXH1o1OLnflrYmlTnXDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 20:11:27 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%7]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 20:11:27 +0000
Message-ID: <151e544a-63dc-414f-8418-e6912d196a9e@amd.com>
Date: Mon, 6 Jul 2026 15:11:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] x86/sev: Disable CPU hotplug while SNP is active
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1782841284.git.ashish.kalra@amd.com>
 <205a5259f9fd353dc0ca6b00565c8175a96768c7.1782841284.git.ashish.kalra@amd.com>
 <20260630183231.393071F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260630183231.393071F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::28) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: edc34bbf-c9bc-489b-8273-08dedb9ac2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LpUKSSylV7mZ94QDJ31LWeOYlOfe0sOsbQg07znLetPRfe5ZTc/pqeVZQL3PTfNnc7v2ClgS6hJgyzq+Q0hkNNXKRXQdB4kvnlvxRyYGlBid22gYWJBcZMaAJuw0Oj1knDEQ+lz8yoCeogqDWBnkCTA1ztIgTIiqa52uX0eWF5GRLzKmYgrNbOY7C9qy6gV11gBAqG6zJjIYhGYFsQeVKaYepYbN5KZEc+hMmCovTpZTk0LWZeIehpjQ0zfmVY5UleLjidllZkG3SsWyUWm8EOyQ3vzNcBKZWEXM+ylMKpL2GG6nvsjG59AwZ69ldhIzF+j/YmNI4wSrlkVWDic7KX9YpSY3+dQITbDw2y686hvJXwSlL8nSm0dxb7d+0mwKq+uvu3PXSrOq7Mcfu/yFsIduSgfvZVwFAtBz5L2uqn2h6ZMLVYDk0c3S3DjgIW6d/7IjqDKMrHU/lGlmHNuCpYI2m7sWuKZMWxGl+qfu21cvEPioPrvYJgqWBPhhcwjW8iEZBNw3tyHPtRPKPzn9kaUuOfWFsHF9DT2AdmVDZUnSDDf+L5PntcwlJVUf5j7sdN9F2cYGzk75PyDZHVsZDf8DLwfA+/RzEeP5XZFAuLCEqlOxjV/WFKYfKUKJIgMkl5xYYLca0aiKcluEI6mg2rh+ClFRptKqgOHWeC6LJiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk52NGVlKzFwU2VUYUhpZlRHTVZtNmFsR0FHUG5mUlRyWkpFZUkzRUNLaDM0?=
 =?utf-8?B?NldRdFVVdi94clB5OUJNUmd0R1pFWGFnY2JkUFY4cjcvQ0dlOVprUk5MZm5L?=
 =?utf-8?B?TzlPckFvYkJGNlM2c2ZTYm56ZlBCVTNyczhlMGsxblZFbmlCN0h1NDhZQmxC?=
 =?utf-8?B?ellRcCtQZnE1RC93U3lqNjV4Zmt1RjFRWm5kUmZwUVlkTlQvRzJlc3hYVjQ4?=
 =?utf-8?B?UEtGT2cvRmlkc3hyclhpaFVtczlUV0FUWWZPbXN5bDVTNW5iZGVzVGJpVmVB?=
 =?utf-8?B?SFhOQ1F2ZXRNMWFoN2t1MkRXOGZGam5iWFBYKzdhc2h4NGF2ampEdmtqSUo2?=
 =?utf-8?B?Ujd2YVhOTy8xTGd4NVVjQi9hRFJoWlJhZHRoQkJjbFVId3AvUFJQL05Lc040?=
 =?utf-8?B?SFV6TjFPbTJzTVkzS29UKzVTRE52TlJ0S0xYaWxOTkZLbFFQVVVNMzdPbWZs?=
 =?utf-8?B?V3daenExblExL3liU3RjV0RWMW9kV2laM3VlYkcrd0FVT05XTE5aaGtuRHcz?=
 =?utf-8?B?RnpHK2lYOXltM1V3ZkRmSEN5YlpPU0tPbVBrWVFTZmdkaDBkMkVNYlZudkt0?=
 =?utf-8?B?SFdieXoyYXV2ckM0UmFMMS9QQ1Vuc0dEd3FFZmdwR1FocXd4ZHpvdDV4eVl2?=
 =?utf-8?B?NWpmWTlZUzRXdUIyYmdPWGhoczlobEVySzU4OXJHN2V6TTZtTUQxOUVpRE0x?=
 =?utf-8?B?dGVMclE3VHZkMTBZQTNsRjYwSWtSSXRIL1hDYTBSeVJIemlBaVI2Wkx1Y2VJ?=
 =?utf-8?B?QzhNbGZhL0NJT0wxSHNwMXFkQ0hkbTJPanBNdktpQk9CV01pdnNLblE1Um0z?=
 =?utf-8?B?MjRqUTVWT3N4c1N2Y3NXZ0Jvc0p5UytRc2lXR0E1MVlvYlFZYXM1U2NlSFho?=
 =?utf-8?B?NEU0Y01qcE9ZNFdGR3lFcUFvTXRwOEdNWCsyOGtKUFVRWE5Lejk1MHBEdDdH?=
 =?utf-8?B?ekF3cDFLeDdvMUhSUDc2TVdJZnNLUDdnRlZnQSsxdnQxN29DOHZhS2cvQ29h?=
 =?utf-8?B?QUg0YU5lVjV3eCthR25FVitSQncweXU2OWp3RWtFRzY4ZklhMjBoK3M0b1Z2?=
 =?utf-8?B?L1Z2TnJCRzBldHNDMUEzR2xYcHZOTk4vZlRDdmt1SU1UWkZGZEFZWVI2K09M?=
 =?utf-8?B?bWZpVEk4QmJKOU4vTUtHVy9tdDk3SnBwMUtxY01JamdESVJmUVF4Nk9KWnF1?=
 =?utf-8?B?MU9iWlNXNW16RmYrU1RIYTJtdFZLRUEwd3FKNXRZcWVna0FVSU8yVjhVUURK?=
 =?utf-8?B?dDlGeFF0aGpqR0Z5MzRCYUpGN0t0MTBoYzJtVkVkSmhza3JzZFFFU3pFOTd1?=
 =?utf-8?B?dmRQRzNyVW5EZi9vbGUySktzd3dzQlhnQy8zVTdVb3pYUVJqS0pSMzd4VStk?=
 =?utf-8?B?NmZJbm9iaVY1b0ZhQ2ZSUStDQ1c4bHVxRk5LRDd1K1VQR1ZPbytEeWN4V2xD?=
 =?utf-8?B?MGV4Wk9wNExQN1BvKzNwZVV3N1RWRVZvcTQ1ZnE1QVZibDY0b1pxMll3YldR?=
 =?utf-8?B?QTJBaVovL0toU0Fubzg1Zm5NeTA1UVd1MXBMbVp5SjRWWTBBSVV1RGpFWERW?=
 =?utf-8?B?a0t4OXljZ3lNa05NZXI5THZtSzZaNEFucXg1RkgrNWhuZE5JU05jUGJpYmhw?=
 =?utf-8?B?bDRwVHdySUl3Vk1tVGNFVTlNdjk0bTNEY1E4cXZjN2pPamFzaVNmbjJrTnIv?=
 =?utf-8?B?bDVmSUF1T2dlSHE2NlF0VmZDVkh0eDhHa1lYdVgxQXYwVGZ6NlRCOE0vV2hT?=
 =?utf-8?B?QW44VGdmcitZREk4UTJrRXE3Y05sbms0aHUvQ2J3UmpyVVM1NmhhTkFRN0Fw?=
 =?utf-8?B?eTJ3bTBFRThVcHZDeXdFTHVwa0hhTVZhZEV6VlljQ3ZhcDJhdlJHNGJYU0VV?=
 =?utf-8?B?cGU1ZVUvTFZyMWd6T1Y2SkJ3RW1YSTdCeFNPeEIwbEFhSlNZa1czNmR6dUcr?=
 =?utf-8?B?RmlEc1I3eVVrclpxckYrdU1odllIUGVselRCQ2RWVk1oZVRPckV2Y29QTUtt?=
 =?utf-8?B?RFN3cUZPQ1VFeGN1VTZZUVdzeUVITWM4MnBMUUlhWnBtQ3d4eng1ZHhIcFox?=
 =?utf-8?B?R0dDaCtITzNjem5IYmtJcFpkamFNWUVlemZ3RWN6NnFXSTRVbEZuOFJDbWR4?=
 =?utf-8?B?VUJIeU4xYllqK0daSWxZcSszTjFCQklpd0grS2x0VG5BM1ZydnE1dWQxaDFy?=
 =?utf-8?B?VldZWG1VbGZ1OHpRdVQwTGdTMU1OaytPemtJSzlvRW92dWk5STZjRUJyT1I5?=
 =?utf-8?B?MzFadktYV09ldmo5Q3ljbFVnZlRIZU01VXZSekRaQmFGUnJQVkY4NTR2aExX?=
 =?utf-8?Q?dHi3/bsVPA3HJd/PnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc34bbf-c9bc-489b-8273-08dedb9ac2b4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:11:27.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eTGo2o7bRwiJCKC4bsaCQDZKlNHu6IF+6vRGpxvtRvD6uH2GJWxxlR5wCObeTokF2+b4TLeC8HuAnLtaZWk0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353




On 6/30/2026 1:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] System suspend (PM transitions) bypasses `cpu_hotplug_disable()`, stripping `SnpEn` from secondary CPUs on resume.
> --
> 
> commit 29b8362e9ad72efa8892f6bb3124dbbcc29ee822
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Disable CPU hotplug while SNP is active
> 
> This commit disables CPU hotplug in snp_prepare() before SNP is enabled and
> re-enables it in snp_shutdown(). This aims to prevent CPUs from coming online
> without the SnpEn bit set while SNP is active, as the firmware cannot track
> OS CPU hotplug events.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index dab6e1c290bca..04a58ac4339cb 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -535,6 +535,15 @@ int snp_prepare(void)
>>  
>>  	clear_rmp();
>>  
>> +	/*
>> +	 * Disable CPU hotplug before enabling SNP, so no CPU can come online
>> +	 * without SnpEn while SNP is enabled; it is re-enabled in snp_shutdown()
>> +	 * once SNP is disabled.  Must be before cpus_read_lock():
>> +	 * cpu_hotplug_disable() takes cpu_add_remove_lock, which nests above
>> +	 * cpu_hotplug_lock.
>> +	 */
>> +	cpu_hotplug_disable();
> 
> [Severity: Critical]
> Does this actually prevent all CPUs from coming online without SnpEn?
> 
> Looking at system suspend (PM transitions), freeze_secondary_cpus() calls
> _cpu_down() directly, which bypasses the cpu_hotplug_disabled check. Upon
> resume, thaw_secondary_cpus() brings them back online via _cpu_up().
> 
> Since snp_enable() is called via a one-off on_each_cpu() in snp_prepare()
> rather than being registered as a CPU hotplug callback, wouldn't secondary
> CPUs resume with the SnpEn MSR bit cleared? 
> 
> This could allow a suspend/resume cycle to create an asymmetrical state where
> hardware RMP checks are bypassed.
> 
> [ ... ]
> 

You're right about the mechanism — cpu_hotplug_disable() doesn't cover the suspend freeze/thaw path, and snp_enable() has no resume hook. But an SNP
host doesn't support suspend/resume: SNP is set up once at boot (SnpEn on all CPUs followed by SNP_INIT), and that state can't be rebuilt on resume
without a full re-init. So this can't arise in practice, and it's pre-existing base-SNP behavior, not something this patch introduces.

Thanks,
Ashish
