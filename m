Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A4469829;
	Fri,  9 Oct 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575015; cv=fail; b=fLy12h1v5dbC4i+4D4M9df8vXK2C6hfPBqVoaBih/bhytbLJ0ua+otOngaMC4zn5oTDmm3f11VYaZ0OvGWi9y0f1RE8zc8wpeTythZB+SudusAAliEvv7UUh+pIeziepB9UQOMTB+fJF+qj20hMI2+QTIqya979KcVgGJClVUMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575015; c=relaxed/simple;
	bh=XHjNtyc1777xH+wz4V/LkyifA0p7x/w8kZQqM+k+t1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jbqe9IJTqYDUa7bfLLAFyO3DVpbebiu+SBky9Ro7eBQ6tM9NM4T+g6AUcbz9vsalC/wyM5XiPzpWqZYu5QWKeu7vgx028VD6GmHSiSvlofjC+ghVkDk2zQ9IIZeX+E6ATzzcH02EnE+xHWbM6AsYN7AKPzUgeCrBk1rTbRsTNPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xXCLD/cN; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xXCLD/cN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUNeGFAPCGHG+EYs0Q7+RYs2kFxSuxqU+BLUnKKvTlkrMPxWQ4Q5Q5+ZTBTnyNTG1p74pISJpbLFCi+Dhn8AKfe2qy+11Xn/aL/VD0e5gl/4ydGJlmcRa+t6yVUvQF7Isqykfz9Ccv9EKE/JAtLUVB8gMa5THQL6NLaUORoP6DheXkupSeTdvXThr8Y5I3f2lzRmnuf5dmqg+57Zz7bLh7Dz6mKI4YtdTkWUmd/PS7xm+XvYPyewcuaRnWe3sAtWVLX6E2LwQJP4Sjxii1fxCS2sPESeBsN+rV9sG3uQ35yZdGATmu9BTDGnFAr17dCP9h6Qmh1gpHho+skAPuF0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H12U52iiEmghhPgLKnyhAIQMPNU5SV0jfovlWwgzZHo=;
 b=djdKgAsirYIDLecnAnakNXI14CWOhK5cgmDr32xdzeZcvU/dvplXvkEFpop9nsqlJGVw13g16zK4W5CgsccAzDkmg4V1cTNlpwNuqNx8yWW45P7TcmnL1rqkejsAJ2cBnUSPlhbCItNwiLaD3Yd9CqEjr3mMYJVHy/Bfnr20ZC8tFkm6nwyOckLut+o6YXrDVI3JKqfWhA/N7yoex2yazE6XgTGnGBN/98zeiYtaVyLP/0uolir7YD6hjI9jPrKpbH8IUrWRa6cyD3WAysyOJrkAN0WPWPzN6hhL9Mlp8xkKpJjAhIsSdDwKzyL2BK3v8msni5SqnHnkAgD8JDf7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H12U52iiEmghhPgLKnyhAIQMPNU5SV0jfovlWwgzZHo=;
 b=xXCLD/cN9LYR3OBILDY+YYznnYIpDB/csj3sUVfr123n2J0D7ZSybO6mKL9X8/ePFBfP8wOoI1TXOr+5Q6azBfwIbICHiGnPCqPtafWBvhTejoSOjPJXRksuTffQN9LZQCEUfQP6uKt5X5fsGE8boNa1l0HgfgOb0Zvvz1OqSaA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 19:43:21 +0000
Received: from SJ1PR12MB6217.namprd12.prod.outlook.com
 ([fe80::bdbb:19b0:4f1b:44e5]) by SJ1PR12MB6217.namprd12.prod.outlook.com
 ([fe80::bdbb:19b0:4f1b:44e5%6]) with mapi id 15.21.0451.034; Fri, 9 Oct 2026
 19:43:20 +0000
Message-ID: <15395e61-7da0-4904-bea0-24f88de95d61@amd.com>
Date: Fri, 9 Oct 2026 15:43:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/4] x86/sev: Add guest support for Enhanced SMT
 Protection
To: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1791302373.git.prsampat@amd.com>
 <92a1de684bfb5d8633c2de0ed8511f33282a0d70.1791302373.git.prsampat@amd.com>
 <3511498b-d72c-4fab-aafe-5d05d9d3f460@amd.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <3511498b-d72c-4fab-aafe-5d05d9d3f460@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:4e::19) To SJ1PR12MB6217.namprd12.prod.outlook.com
 (2603:10b6:a03:458::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6217:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: f5784fb6-4077-4397-05d1-08df263d92dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	erYMCQwj6ZZc9c2VXS85XYmypNdOynpJg2Yl/wUKSc839OnU5BABtm0XalvgQkyGkWqCGDjEv0TXiEVNPnf/kkNg9jXX+OZtbdt5n8p/aQLNh4q//lHU70fi1I50Yb3EawsogYb9iN8nCOHiEM0+M3MZe+TXPql/jAIAiLfJ5P+/Wi17uEWU/iuYtan55bkzB9OhWdbcM+4abwk/P4zcGEvgwi7Q06ZfjafM2UAzI/DnNJhKfRkHl+pJUIsfV4rRpyW5J2egIwXA0wxPT0E6u4PR2FGfLe5XhxcIv/pnwZwZ3o8PIBmxF/o1Nuvxy5K8Org/A0vVzjlRCO5ZX0fitaCada1SrES8g6IQRLvH9Qf1k/arxojXF3+d4S702TKoy1YP6N2oIZMUB5FBDTSjL4LybeLonxs6o4NtvwWpdif5jLjmhBHxa1QLsLgt0NrEPe85tSS7bXmvGtXJtdJSKb374vKc64//AkSc+i87qzOakWQIBmiIU3jZPyCQKOdNKBN5qNoG75uBOBbiUuvcdpTTL/FIOGcfHrC0m/fP4SobK4KklDWGxsHmIYZoJl+sAB0SwfD8/43R0u3nyWU0Uzh42Vcv0JRl1/aOPxoITY00SnKdZBK+eeAStg1Ca0UwrVnxCS+PwZPSQ30MFVFZSACYEobJoar8YJvca+ycKKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6217.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckM4YVJqZFpCZUwxWXdad1FJSnV0Z3JidHFUdGNaZjhkV0FRYXFCWmFkUzZZ?=
 =?utf-8?B?UlEySVp2WUZPVmduUGNxdnhJMWthY1FySXhNQWxQM212K1dUYTZZN3E2RXVM?=
 =?utf-8?B?MnlGY0QybkJBZm1FbDdLd1V0S0lJdjh3bnNvMG9QVjVSQXdUMGlwTUpyb1d3?=
 =?utf-8?B?ZjhQeTJ1SldpWmZ5QzE3b0hhNmhHbkhUT3JGc2dLUkdGeldXR211eGdDM0FC?=
 =?utf-8?B?dnBuQkFjRVhzejJxUUV2RzV6WVVscENkSzRZMlRXUVk1ckpvTm1YbVp1K3Ni?=
 =?utf-8?B?NXhncVlmMmdMMndHVVRTTkZPenNIbi8zenJrdHRWanNkRXhuRndsaENPQmVr?=
 =?utf-8?B?K0ttblA1dHQ2UlcwVVdXQUQ0M2JtMUV3NzU0VnpyUWhpc1RCQ0NaQ3FNMTlI?=
 =?utf-8?B?Tk12MjIyMHc3Sm1JTnVkTExVODhpa3RMc25RVk9yeUNXRXlTVU9SSi9MYnE5?=
 =?utf-8?B?V2tpYXlyUm1oMy9acnhGMitmTy9raTdHNGNVQlVPZCttQ1ZzcThLR1lJUTFX?=
 =?utf-8?B?Z2c1S1NCN3kvbVBBU2VlNnFRbWs5OEZXQ0p3RENJcjloc1FuK0xGdU5mbldR?=
 =?utf-8?B?WjFGYjlLQkExZU4xUnNncmpEMGFEaytKdE5VZU1LQ2h4Q0E0cDA1TWpaUCt2?=
 =?utf-8?B?UVZZbnZwT2h2TzBNL3pGemtXRkJ0NmtuMTJoQnpqQzJpNUYyaVp3M21SaXN1?=
 =?utf-8?B?c2xDWGNmNUhuR3pqdUtuV0plWUZJR1NQRUtDTmFkYmpRajlhc0VzNkhYaWVk?=
 =?utf-8?B?VEhDR0VzcnhKTkQ0aUJDSUIxanE4RkUxSkhxcms3S2VEa3cxdktxWmI4MDVE?=
 =?utf-8?B?WHJMU2NXMm9MQU96QWMwQkEyYURkeEc2ZHJCUThjendURlJtU2xwOFRDYmZT?=
 =?utf-8?B?U0dSRTB3Zk5hSFZ4U1BOZjhPUCtDalFTOWhUN2t6VTJ2Q25NSXdHWHVVejhz?=
 =?utf-8?B?RXB5SjE5VlJWNDhFS2E1djhpK2hxQ2lBMWkvSzA2b2RDTnpiRjVxTkJmVHZ5?=
 =?utf-8?B?am1Uekszc002ZmVUZ2hGVVJ1WG1RQWFBWW04OHl1VGpzcmdSZmVENEZKYlJk?=
 =?utf-8?B?ME9CWjZrU2liU2htdERNa0pJaXdYUHRES2FnU3dKQUNlMllwUWtrSGlkRXVT?=
 =?utf-8?B?YTFmTGh0S1ZBaWxlVWcxNXkweC9IdGh4QUR3Y1lHRHdoVDd3M2tvZURHUTlZ?=
 =?utf-8?B?Wk9Sd1NGbEJQbmxnNnp2U3hXZnUyWFE5aXhqdXVqQldTR2ZtNkNnUGpKMGtu?=
 =?utf-8?B?K3RGK2o3WGY0VUU1TmQ2eDdmZ2xGbWVlZk03NDZhbXBrSlMzVFg2cVhQNlJi?=
 =?utf-8?B?V3luZzR1VXl3SzJCbnNtNUd4RkJBK1p6RnF5ejhJa3BlaXgyR1hzU045dzl1?=
 =?utf-8?B?WS9YS05aMVZxTk1NdWFuMnZpdlBCcWZmdUtpZ1NDZE44UERwYWcwTXNrYmFi?=
 =?utf-8?B?bEwvNFdZL2lYcFYvUjZwSnJ6Z0ZZRmUwS253akVwekQ1VlhpQWpuU3F6MkQ4?=
 =?utf-8?B?QzBLeS80QWo5Ukx2U0VGNENibHVVdE12WVdEVkFjSHFEYTluWW1BN3lkbnVq?=
 =?utf-8?B?V1ZNSHAwYzVEWVlSWTNEZU9BNUNORCtmNlBRZWxrOTBzbStIS2VVeFg2OW5J?=
 =?utf-8?B?QUV1UHZ2dVNEOW14SG95ZWtSN0IwdnlOdjNrZXVTYzh2VFFYQmlXM0dhYXBK?=
 =?utf-8?B?S3ZncEU5a0VFQU9LdVFyeGlGYmlaaU9pekxaYzFwbFlhY09lL0xCRG5hL2Zo?=
 =?utf-8?B?NEhaWndKMHZuM1FPdFY0cU9JMUR5cHRHVE91MVZ4QmN3OFVQYW93WnN4Tnln?=
 =?utf-8?B?cTBWa1RnQU1qUndWS0hkT1F0Y0U3WXB3RDdZS3Q4UjVNS1ZzODg2STMrMUZ5?=
 =?utf-8?B?TWJsUCtJVnA0dVB3ZVFGaE1pclk4Uk4vTTluYm5OT3pjbmZzNXIvanJyVFVr?=
 =?utf-8?B?ZVJ4QWE2ZjJFVFI4amtldFhFTEplM1VDQUtabk9OMkJuVDR5WG5KZFVmRkds?=
 =?utf-8?B?cXAwWWJUQlR4K3pkRlBDTmxWaTkxcElXc2IzcFBUYXRlU2VIUWdzMWhUNkR4?=
 =?utf-8?B?azE2WDN2OFRucFNFck5qWUJSM2xZWDlndk83Ti9YQVpFK0JGQjlIUXhhaDZ0?=
 =?utf-8?B?eXVrRTRvUTlNOE5LN0ZmZWNhU1lOaGNQWmRETkh1Y0w2aldXQWpZeEJ4OUYy?=
 =?utf-8?B?bkltUmhMdXcxUjhSK0l6Zm5ZR0plYzhjUTBjWlhWQnhJMTZLMHc0aUZ6a2FT?=
 =?utf-8?B?UUhRaGk1d21ZYVg4azhGSE95U0t5TEVTWkM2dlBZbFpGbkh1K1dqYjB1VC9K?=
 =?utf-8?Q?IATAnJ5Qxm5/vfK8qY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5784fb6-4077-4397-05d1-08df263d92dd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6217.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:43:20.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvkfL6Z/3ctr/+OWN+/EZjh7dFIG7wkRmRmPIh4O/yRvKfb85pnzorIj4ymYZsGiUPr2RQpw4leRpSiiIhQhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877



On 10/9/26 3:18 PM, Tom Lendacky wrote:
> On 10/6/26 11:55, Pratik R. Sampat wrote:
>> Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
>> and the mask of SMT siblings it may co-run with. The guest builds the
>> VMSA itself when bringing up an AP, so populate both fields there, before
>> the page is turned into a VMSA and while it is still writable.
>>
>> Fully set the sibling mask so that all threads of the same guest trust
>> each other.
>>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> 
> Minor comment below, but otherwise:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
>> ---
>> v1..v2:
>> * Add ESMTP to SNP_FEATURES_IMPL and SNP_FEATURES_IMPL_REQ  
>> ---
>>  arch/x86/boot/compressed/sev.c   |  6 ++++--
>>  arch/x86/coco/sev/core.c         | 13 +++++++++++++
>>  arch/x86/include/asm/msr-index.h |  4 +++-
>>  3 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index c6512f2ea31e..4e0fa5a5f70b 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -188,7 +188,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
>>  				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
>>  				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
>>  				 MSR_AMD64_SNP_SECURE_AVIC |		\
>> -				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
>> +				 MSR_AMD64_SNP_ESMT_PROT |		\
>> +				 MSR_AMD64_SNP_RESERVED_BITS20_22 |	\
>>  				 MSR_AMD64_SNP_RESERVED_MASK)
>>  
>>  #ifdef CONFIG_AMD_SECURE_AVIC
>> @@ -204,7 +205,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
>>   */
>>  #define SNP_FEATURES_IMPL	(MSR_AMD64_SNP_DEBUG_SWAP |	\
>>  				 MSR_AMD64_SNP_SECURE_TSC |	\
>> -				 SNP_FEATURE_SECURE_AVIC)
>> +				 SNP_FEATURE_SECURE_AVIC |	\
>> +				 MSR_AMD64_SNP_ESMT_PROT)
>>  
>>  u64 snp_get_unsupported_features(u64 status)
>>  {
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index cc292d7c6fd1..730cff2700d4 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -89,6 +89,7 @@ static const char * const sev_status_feat_names[] = {
>>  	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
>>  	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
>>  	[MSR_AMD64_SNP_SECURE_AVIC_BIT]		= "SecureAVIC",
>> +	[MSR_AMD64_SNP_ESMT_PROT_BIT]		= "ESMTProt",
>>  	[MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT]	= "IBPBOnEntry",
>>  };
>>  
>> @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
>>  	vmsa->vmpl		= snp_vmpl;
>>  	vmsa->sev_features	= sev_status >> 2;
>>  
>> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
>> +	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
> 
> You're using sev_status for ESMT_PROT, might as well use it for SNP, too,
> instead of calling cc_platform_has().
> 

Sure, will do.

Thank you!
--Pratik

> Thanks,
> Tom
> 
>> +		vmsa->vcpu_id = apic_id;
>> +		/*
>> +		 * The mask fully set puts every vCPU in one group, so any two
>> +		 * of them may be co-resident. A legal ESMTP sibling must
>> +		 * also match on ASID, so the sibling of a vCPU in guest mode is
>> +		 * always either another vCPU of this same guest or idle.
>> +		 */
>> +		vmsa->vcpu_sibling_mask = U32_MAX;
>> +	}
>> +
>>  	/* Populate AP's TSC scale/offset to get accurate TSC values. */
>>  	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
>>  		vmsa->tsc_scale = snp_tsc_scale;
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index fbcb3313e946..6fd26151d146 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -745,7 +745,9 @@
>>  #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>>  #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
>>  #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
>> -#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
>> +#define MSR_AMD64_SNP_ESMT_PROT_BIT	19
>> +#define MSR_AMD64_SNP_ESMT_PROT	BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
>> +#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)
>>  #define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
>>  #define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
>>  #define MSR_AMD64_SNP_RESV_BIT		24
> 

