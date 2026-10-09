Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9D3F4DDD;
	Fri,  9 Oct 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573541; cv=fail; b=XfYQuc0vj3JxUt3v76mfqduQEQjb76o4a+FcdH2i3eRsSYPc1UeTAb2WinlhFbKyukSkWizFQwBA+BXEAxZwdONzq9UZAC43Q6//Lcobjlyq4mq2Dwc6WYBgaPnuStjeR2mVkbvk/RgJYZYpDtbxwZPrwZpOGLnr7NXSQzxQuM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573541; c=relaxed/simple;
	bh=heb3EwiAPVQa53SdMKOULEbRvyumETpCAkNBgdT60Rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/aL6Hf4gtV3x3P/LwYcLjb5ole+IkGV7diw5OZ3a+TCgUEdWC0WfxgovGRoNVxUfyFc/sDAp7IWCIMmyzGKXMkVZV9KJfN8OWUQcyLxTJPLafiISnXV+SBmq78Rh3oEY1oX2NfN6Ck0U7LGQjChlrKWQmrZWHr6eXNTUzbFpOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HMqCEywL; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HMqCEywL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfDcAsVYDLJpdMFWV0es9bu4THjI757bz4CJ1in0pTwSn4CQurtuLIT0Nb74o6ieWw4dVKLMMUQXmVOXuzh1XGiZxJfEiLWDI4GrjztWS6wcXrKJCLDejwkrsZxe2YVVXGJfwiy4QbMOMmEbBA19QBR1ryMpYT6soOM1i05nKZUkbw9udbL3Dj+MpXD6nQAXBpyaDJwZxaTI6H3+SuQQjF/5nKaa6otswsqOdvxpZw7LCJ3Iihg4COiUn+TWANXoerqNThw5lQR326g3U3JxIGdwD7hsAL3VDHfzd1RSq91RfkVZl0854AQY+s0BzZlOdv7R2MHUsUejRaw9OWgXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIH4qyDlc84Zih5x5iO/JdRQpqWPLErwHBYWO/2uSnk=;
 b=YCm73rKOdVDxTXQcaMJ+zy6xwYxSsWqnL8vcXzwdMKG5GcNma+YQatMzHkdqt+TnUr6lSLqRNfmsNWmXn55aLcwUoH9rQ2eNz7muyXmtqpZLkgkHwHpl/C6RV9woeo718zrtjJr8u3a/CGRtFeYZosLE+SXvUc8Yu8lkdqJxvRsgFCmqg5P2fy0mlLvE+Ax+YLdeqaztzD/FGi8X1f772Y8QQXe1617edF6EqIrtVtRU1Ef2dnH4g4ntBdg9cnI/xWIiDNbX/C86BAy2y3PuYeKLEIuBmUVCzT/PHi24ItXCk3rM+tFDU8F86icXHIey4VmAm8DRj9N6WokaJgoPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIH4qyDlc84Zih5x5iO/JdRQpqWPLErwHBYWO/2uSnk=;
 b=HMqCEywLD5BDYn+C9w8eog9eBc2W5nMlEXFi1LPcpi5R0VUUAart8Ixif7iPdhrK4myoyJd/nFPzC0FJTaLzrZplfQayEMfUUVJ39YY/lqj6JRfiLN72e8YvwEc/YBSU2F3tcWICef+dq3tvsCw8igP/GQ1QavOIbYQ6v0Oy8+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 19:18:56 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:18:55 +0000
Message-ID: <3511498b-d72c-4fab-aafe-5d05d9d3f460@amd.com>
Date: Fri, 9 Oct 2026 14:18:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/4] x86/sev: Add guest support for Enhanced SMT
 Protection
To: "Pratik R. Sampat" <prsampat@amd.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1791302373.git.prsampat@amd.com>
 <92a1de684bfb5d8633c2de0ed8511f33282a0d70.1791302373.git.prsampat@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <92a1de684bfb5d8633c2de0ed8511f33282a0d70.1791302373.git.prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ba70f0-1f51-43e6-1860-08df263a298c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YvEyC2IGMSkTJX1qKt7yTO1Q5pzlttq/hCaQIZ7aW/PxrVEdK3wX7nNTvwVaqHQ3+ZY8RW0efvG1ZXZnMQ62KTfGlEIr/vvTo4NVx5swJ++fDkiAyS7iDscjTrZ+E2fhc0hB8Uh0isfNyplLa5R4QFTffQl3DCIYjiFocm1xhRBpafzmluLn+kUGjjQdX+wCEtUVKbVO4VJZAaJ4e8rvLrJi74qcEzCFs0ZxXnXgrkszW19ih9wtoDfpxMsKbTwf5IsbI0GKF6SaQ7MXUONxDinc6MszAWnVsvDJ3TkBkHGhqSEmL0XGwrSDaqowNpwnCcOhY7TLbkyh9/4HxlDdK5k8WXg/OoI8jgJyRcHNOAUzpPBE02SdHmiwR1EpzQN/OaWeoct5PEoksIwGHPAY6FPbTXCdgd9jEd2eUcAcgnl8AlLwb6dWLcTlFTcU1fZqW4o8sR0djf/uc0vY2tLfbvoFZJdcBYnC582biO1cNRLMiq0s8KUJneVvfed1nTDpnEaPh5AUNwZ7JFUAU9ovujofI3s65C2WVs/D0uf0M6nrGMpfe71Pwz+9CXM3ndAuWXEKDs+rCinr4AJX1w50CjW37qyH2vPJOxNUxA9mdbG+cU+bDSGo2TUNCH2C5CPpkZ7ZSDUQDLlJqvRxmKKT+J6j7qNFexQNk54yt6gC0mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N245U0dyQnRCQWJmMExzYi95NEZGVTZid2pBay9BQTZYdURRWDlMZTl3T3ZI?=
 =?utf-8?B?aTVEMEV5NG1yWmU2VHZkQXZqeGg0YkhOYmhYWG5zRDl5aEtwZjVqM3h2anFG?=
 =?utf-8?B?dGUzMlhSNGx4NjZ3ZGMyNjlrZ2tVNEx5cWxqeVJqMVA4QTIzS1JRczFhL2RS?=
 =?utf-8?B?T0t5dFdPQ3lWMXJxdVhyb2xPTXN6WWc1RUF6VU9xM2hLSEVoUDBNVUJMeGlR?=
 =?utf-8?B?S05sNjZTRExMVS83Vm1OcFFOTGU4RWlGNGJsZW5NekRMUHpabkgrd1loU2ZW?=
 =?utf-8?B?b1BNSWZ1TUNub0VqbTdjT1NuV2I3OHhiWEpJRzQxSHBMNkROTTkrbzR4QmND?=
 =?utf-8?B?Skw4SEw1dEF0UXRqOTVsRUkvZFFXN1JPSHUxMFFjSEZPcE1pRUFwU2dJQlBx?=
 =?utf-8?B?bThtMEJKWXBSSElTaXg1UmxJWjU5V1hoMjdpeEdCajI5WUp3VFNwQ0syNjB4?=
 =?utf-8?B?bjdiRm1pWHFqelAwc2pidmxXbWhhS05BencrTE50QlR5MXErNXh4cjg4dXls?=
 =?utf-8?B?bFRNenlmM3JDd1llSjBFOGpjVVROaytRdWMwSnFsdDZneUk1YUxKR1NvdDQw?=
 =?utf-8?B?ZzdDMFpzR2ZRTGdSYXBIMFZGR1k2VVJJL05lb1h2dWtCbm10blZaYXlrdFlL?=
 =?utf-8?B?ajFEbk9aT0dQbHhVSlJWWWRvY2NaK0V1cHdheStJV0cvZXlmcDNrY01yNk9H?=
 =?utf-8?B?RkZyZFcyOGdXN0tFdHZ5c2hYOWxYNnNrQlhTS2J3MW5nZUxFZ2wvYmh6M29V?=
 =?utf-8?B?bk91SkNIVVF3cng2Q0hzSXczeUI3bnpMVWhlL0k0QlhwK0ttdVRoeCtySDhu?=
 =?utf-8?B?MzVSbWZtam1VdlVXRUZVVjRCV3YzQW9WNDdkUk1hNCtadGNTa0NMaHg5ZU84?=
 =?utf-8?B?OFNPQk1xeDVQNlNPbk1NQUl6bnY5bDQyeFJVbnh4VUZHVHBub05yd3BBWTdL?=
 =?utf-8?B?MzdHcE5wVjV2QnBwNVBneEMyM1N6WFlza3Z4NFVMLzVtTnJwZGY3ZFY0NXU4?=
 =?utf-8?B?Q2E3MFl3bUk5T05ZUnQ2TmdhbU9XUnFVMVdIQktXVWQ1SDZTdzVtSlVBelds?=
 =?utf-8?B?OGVCNVRRaERycFBjUC8rd2NDbmZmWDdlbmhEelRFZjBCZ3NkMThtb0dDR3M5?=
 =?utf-8?B?cEpFampVYjZ0T3lRd2RvQ2MvM2FLeFdvNUV1UFpOUGY1S2tZbUIrK1gvZ3dS?=
 =?utf-8?B?TlR3Z3ZrNDZWK0NtTCtvcGs3TlJwVFByejR3M3hPZW9JNkF2QXMxU1pIdmQ0?=
 =?utf-8?B?czNyMUhhMzBHcThJdEdIbEVyZURldGdyVkZ6YXEzNThlN3RGTVd6bTNsWWp2?=
 =?utf-8?B?cEpVTmxnR3RhdFlKMG43akE2Z3haQ0t3SmowUDZXZXVVS3ltVXJhVGNqT201?=
 =?utf-8?B?WkhwTEpxOHp2czZJTVJkZTBaeUhSVWRzaUcyMEdaaWkvZmFVU3FjZDFJM3B0?=
 =?utf-8?B?QVNtZWVhRkhiTmZyMkdXMTR2WVliWjR1cDJVaVV1clRnVVJOVHl6N05tR081?=
 =?utf-8?B?N1lkVkNJMFU4L1NoTXdBSytJcjhmZFJJei9xUnRRRmN4WDhqMXNGMjFUQ1J2?=
 =?utf-8?B?VkYzeW4rWG5UamlEODIrc3NkSEFKcjdvMUxOZjZGYXhadDVYbnRFY0ZyTk9C?=
 =?utf-8?B?K2ZSSDlNeUhsNFFzT2NMUWJGdWJzSzVVa2hTbUJSdEoreWZtR2lza1c0Rmd0?=
 =?utf-8?B?QjdKUExDZHJqQUw0SVQyM3ZsNXN6ZTB0REFuWTlpeDBsT3JOZVVySjZjRmtr?=
 =?utf-8?B?VWl0QmtEeUFOdFhoUVlFZzcxRi93OEdaVXpwWVY3blZRMkE4bjJ1M0Nyc042?=
 =?utf-8?B?SUc5TEZnODY1YTJNTWdtbWE1RXducHBza0dlNlZTL1A4RDZONlRVQXFWY3Bp?=
 =?utf-8?B?T251Q01tUjlUMW5XeXlkNEdzd1B4YWVpckkveEU4MmNpRExkb1IyZ3ZzNExF?=
 =?utf-8?B?Ui9LQ1JDM2l1UC9QeEcyeno1Tm9wUy9HUmxNOU9mYzRUMkxSeWRPQkR3bTMy?=
 =?utf-8?B?U3hGVUh4VEJqRm84ZU5OQXZvdzcwQnFJL0dMM1U1VnB1V3lkZFpFSGZSdmNz?=
 =?utf-8?B?RXprL05MWUxzcW9NVHFwUDhkbVNmL0FQK3BxM3dUZFY0OUlHY08zZENlaVdt?=
 =?utf-8?B?dmdhR0RpZEQ4QllRN01RM3RnNEN5WCt2c05nUjJIZ1l0ejNJVFM5YWZqWGxQ?=
 =?utf-8?B?eFR4OTVQS0xlM2p1bStvbmV4QktVQW5NMFNXeGxnaTY0L2pQalgvK3VlREpS?=
 =?utf-8?B?UmJCb25rTzlITDNKbHFRNlh0Z1ByVVpETEVROU1BZ2J1L0cwckJCdGE4c3hB?=
 =?utf-8?Q?PVX8vbLj/u+gIsPm2R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ba70f0-1f51-43e6-1860-08df263a298c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:18:55.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ffrsx1MSNhGKo8JVT+/0C2AOCZKy2TIQ1/4pI/65GbcuRUrvjmvehBXWZ1UPyAWiSB6RNPUZ8lsfsRShQmqbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

On 10/6/26 11:55, Pratik R. Sampat wrote:
> Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
> and the mask of SMT siblings it may co-run with. The guest builds the
> VMSA itself when bringing up an AP, so populate both fields there, before
> the page is turned into a VMSA and while it is still writable.
> 
> Fully set the sibling mask so that all threads of the same guest trust
> each other.
> 
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

Minor comment below, but otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v1..v2:
> * Add ESMTP to SNP_FEATURES_IMPL and SNP_FEATURES_IMPL_REQ  
> ---
>  arch/x86/boot/compressed/sev.c   |  6 ++++--
>  arch/x86/coco/sev/core.c         | 13 +++++++++++++
>  arch/x86/include/asm/msr-index.h |  4 +++-
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index c6512f2ea31e..4e0fa5a5f70b 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -188,7 +188,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
>  				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
>  				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
>  				 MSR_AMD64_SNP_SECURE_AVIC |		\
> -				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
> +				 MSR_AMD64_SNP_ESMT_PROT |		\
> +				 MSR_AMD64_SNP_RESERVED_BITS20_22 |	\
>  				 MSR_AMD64_SNP_RESERVED_MASK)
>  
>  #ifdef CONFIG_AMD_SECURE_AVIC
> @@ -204,7 +205,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
>   */
>  #define SNP_FEATURES_IMPL	(MSR_AMD64_SNP_DEBUG_SWAP |	\
>  				 MSR_AMD64_SNP_SECURE_TSC |	\
> -				 SNP_FEATURE_SECURE_AVIC)
> +				 SNP_FEATURE_SECURE_AVIC |	\
> +				 MSR_AMD64_SNP_ESMT_PROT)
>  
>  u64 snp_get_unsupported_features(u64 status)
>  {
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index cc292d7c6fd1..730cff2700d4 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -89,6 +89,7 @@ static const char * const sev_status_feat_names[] = {
>  	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
>  	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
>  	[MSR_AMD64_SNP_SECURE_AVIC_BIT]		= "SecureAVIC",
> +	[MSR_AMD64_SNP_ESMT_PROT_BIT]		= "ESMTProt",
>  	[MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT]	= "IBPBOnEntry",
>  };
>  
> @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
>  	vmsa->vmpl		= snp_vmpl;
>  	vmsa->sev_features	= sev_status >> 2;
>  
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
> +	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {

You're using sev_status for ESMT_PROT, might as well use it for SNP, too,
instead of calling cc_platform_has().

Thanks,
Tom

> +		vmsa->vcpu_id = apic_id;
> +		/*
> +		 * The mask fully set puts every vCPU in one group, so any two
> +		 * of them may be co-resident. A legal ESMTP sibling must
> +		 * also match on ASID, so the sibling of a vCPU in guest mode is
> +		 * always either another vCPU of this same guest or idle.
> +		 */
> +		vmsa->vcpu_sibling_mask = U32_MAX;
> +	}
> +
>  	/* Populate AP's TSC scale/offset to get accurate TSC values. */
>  	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
>  		vmsa->tsc_scale = snp_tsc_scale;
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index fbcb3313e946..6fd26151d146 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -745,7 +745,9 @@
>  #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>  #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
>  #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
> -#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
> +#define MSR_AMD64_SNP_ESMT_PROT_BIT	19
> +#define MSR_AMD64_SNP_ESMT_PROT	BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
> +#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)
>  #define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
>  #define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
>  #define MSR_AMD64_SNP_RESV_BIT		24

