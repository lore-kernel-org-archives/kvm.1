Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDD4071F5
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386224; cv=fail; b=UJSD9lcQcq9YeTltts2ir87r10A76+ZkkCixmTCP22m+mqz/g6v+p0xB+83H1V1aKcykMOkqAKnVJhm3QAGj/Pc7IEL0bnG/TSrKOOatVqArkfTGiMwer+vdKfVnG4DiPLVN/PjLK5cF7veRekUcfXh5plwDUyB92vSLkf4Kiho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386224; c=relaxed/simple;
	bh=x0MBnlXQCbj5wslXTAixjBNr62Qv5MKWGk2+bW5CF6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzRs50DparbyDSqUNhSOMbKcpvI/cIu41Qvz4QE0AmjE/iC+AUFIdMHa/ykNerlMIsAvAk+Qk9ULwdNHiHqSSEy+eHjzsYj4x+x9q9ysD9cxfcmnUuNLi3iabOcTfnC6DnSrcQLuzJjQqEZofmSOsXNtDqigwY6JxeygLjZNLq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C1ccHKJD; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C1ccHKJD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcSixAc0f6tvrLYhfUnB0PX3aSy3whAGG5Lno/DOm4uTp8aSRfa58Jh4wnKV+w4TzrYfQILjV25lG5xXVG71bXzEMJ6wKcGJz4uXYXOF1wb6W9iFp0puGbTlDUaO99ukV+/5NQRm4Gkf9xTyUnoU4gcWKC9GPP50l4Qnj6gtmY8cgRFlC16SDzwuKDBkTD5cmGlPfo0f5UV/oFZpBGSA+flCvmjmtgVrZmPAMFxk8UW1f1LeTWcNkaHw5KCH6HkRT8BqTlR4bFiPE/FcEpL/xVRCnXL3STvA+8itDg3niWcUlnJKXFntoB814XJd76buzgWX3Gv7a3JePZ3+l4Xxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epwe+Yve2SmY5BUZCFMeY3f+dSn50wPSkU/SrhZ7DZY=;
 b=Y5muTJJGbGKnAdM3CxUEVwPBf5F8UmmtEXrUp2HqrEqLwJAVTLKa2KKw845bbazD7MDxQtLK8tAi9BNiLUMDLGiyXhEAM8SN7aUTzOmKdLXyfgPF4WjvJrHSVZ/idJI6A0b4wvdXTldos+rPuGOKK1+2oDc8P3GWIUNsdfRnwG13ZhLocmpUtqtRCECgmtUU8tuEmwN3ub1KKILteFOOMS99AHzymA5u7pBm5tsa2wUE1zb+lveRTIIJcw5MNCSuqc0iTN5aPVPr8Kd1BCZm8tH2M1bd0iYmdx1tAHztgW9lVZzFpeHi4rdDgNsQHs8dyehLYvvi44slwxOs+WVlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epwe+Yve2SmY5BUZCFMeY3f+dSn50wPSkU/SrhZ7DZY=;
 b=C1ccHKJDuJNJKwkasi3xM0p1Lp3Q2ysRXYrqwdM1HI5Bd3PlyLpbeg34Nc+MQMUpVluaGwE8h/R3gFEvah+ibe+4hujAxPWjGltghE4ls3rBXh+ZekzQVZcnuyP902e6wG2tQ6RuPESaDw3KSFnuCSYXiKfRQM8mfyjMlZRPA2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by EA3PR12MB172729.namprd12.prod.outlook.com (2603:10b6:303:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:56:51 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 21:56:51 +0000
Message-ID: <b1dec7be-d63d-4bd1-886d-c10b2af9290a@amd.com>
Date: Wed, 2 Sep 2026 16:56:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/5] x86/sev: Initialize RMPOPT configuration MSRs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <3ee20e3956ab0529aa7bf526b6a743fe970089a3.1788296083.git.ashish.kalra@amd.com>
 <20260902214500.6B06D1F00A3F@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260902214500.6B06D1F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|EA3PR12MB172729:EE_
X-MS-Office365-Filtering-Correlation-Id: df4105f4-b37c-4163-2ab7-08df093d1836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	yABtEeDq5CVxblRIr9YMg1WQdRW3AJZeSWEw1YwQcdg/v789wVMrcXwgAlyHVlmDWx+u7GWmlvEig+7vBCQZI5havkof1AX6K/qDHcDQ1W3Q4nu5S53zrqU9VQMKPZxNuhx6pPUQc1l8XE4athfkgWpavGtNM2MFE6FLq4ix505eCEoaLEVNbdYUY90Em5fmyVw8ZZdm+Mc5Wn38xbEuhjgpk1J+i6SD8LNv120S1QxOblhjJA1+hdXlaveotudj/5pu8mK0qIcXMcZIwKpfIEMbqU+b4DebeNRC8p8ew/upv6bgzvHDv2kxRspYSZyNj5nZJMvKhoHm8ea0mBNnAcqHBn1O1SwEZvSgYpTeKBO7FAUCcxSJnvM6yUDt2Rhw1uAJH0vBGCkU9l5RYgQaALE+8fQXQRoStJYa7jWz2UDVYVgh3PNLslRGHedR/+kzHebIiqSPPxG7swsKKhVCJrEov+K7B4gNc2uOeJoWcQEWX95D6vEIYA2L7o0e0WbKfZw+X59iO06oGMmVD7454qiufzOJYBPIVCu3+V+i74bnh35BcK/ycRLqRzUAI0L6nc3sfYpzVNe9g9tdWFczZEwf084U0i4+zfr5yFJowwUmIrPY4+ZzGoAqjIIDeRpLCbg/eYnSLLptQLEdiOV9hs8JJgUtqGlJQy4LCUywAqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy8ybGtvZ0xOaU8wNitRUWtiWEVDM3NkMzZhdGZzZFdNbkQranJsRGlaTkZ6?=
 =?utf-8?B?L3NUSWJtUTNyOE9KeThOUklQSG5EL0w4aG02RTRiM2cyK3JsbEJWbXpOUExZ?=
 =?utf-8?B?NlF4TGJrbTJXZTc1emZXVURpbVhZRGlzR29vK3FJL2g1VTVxNU9hVHhza21z?=
 =?utf-8?B?cUE5RXREdjVNVUVsUGQyc3FqTUJSREVrQjBZM1ZDQngzelFsak5DaWJJK3B3?=
 =?utf-8?B?aU1nVEpyZFQrMkRUNzJKbXJnQjMrYSthV1BpTEoway9CUVQyRXVIV2NYb1Mw?=
 =?utf-8?B?NnFjK0s5R1R6amFZMFNMcldRYmphdG5VUy9qRURnWlpjMFQ5TzM5TDQ3cTE2?=
 =?utf-8?B?MGtub1dyOWg0Y3haT3BhVXRJZmp2MGxwRmZ2MjByRnU5S0o5VnY2a2gzdXox?=
 =?utf-8?B?S1Vid2xJZTVORTdiejZ4YXNaMmpFajljTUxUYWQya3NpZkl2QXVyK3U1SG5R?=
 =?utf-8?B?Q3YrR21PL09oUmRaVkp0Q2MrdDJHbjdHOWphTXNGR2o2NnBQTUE2b00rUys4?=
 =?utf-8?B?UG1UcTRzNGdsZ3EzTFBqUUJ1WmZNaG1SZ0srb3BIRGdBOGo1alRIbjBoZ2RL?=
 =?utf-8?B?ZHJWNXNRaEk0S0FZb004U29aMVFtOGxhOHBWbDhlSXNZczZYd2lvKzRpbDR0?=
 =?utf-8?B?Ny94RXo5Vy9XdEdsK21kOUorVjI1NWlKenNhUUdkcElxUW9VMkdBSElObE91?=
 =?utf-8?B?b0d6VmQ1cEE4VDNXZ0VoRng3OGx0WmtqL01xNThnQ09WSFNTSkdkQ0pNMEFx?=
 =?utf-8?B?bGxRVWhzRWxHelkyYUNGaEc1Uy9TdGR2VGZKSlVETnJObHRmb3c5OG9MUWVL?=
 =?utf-8?B?b3lUWUpOVnRMaUlxWTlSNU8yMnhJWVhtTVIzdG53Y2lZVUVFYVo5cWZjY3Zk?=
 =?utf-8?B?bjdrYzFVeHNaTWswZ01SbWtWUWZQR2dRMlYzMzhnd1JUYVE1N0ZTak5XMFI4?=
 =?utf-8?B?K25CV0MwQlNEbXNoblpPcXlsbE4reCtCcmpDa0cxc1ZIZEdVWStYNnNuR1Np?=
 =?utf-8?B?V2x4YzREeWtGME9SOEx2eEx6UjFIT2QyYmtJTmJhZGZzYXlkVG1raXB1Nk0y?=
 =?utf-8?B?ek8ramxQVmpzMk9sNzBBRmhkZVFZVXdLMEJmNVVIU25GZHZLVzFieXlJNWR4?=
 =?utf-8?B?bmNrMys1UmV1YlhzU0p5MEZmNWpBM3ZlS1ZoL0FOSUxNUjlFZFZ2TERsZUpi?=
 =?utf-8?B?Z00yTGhOT3AxeVFJUmx6NnpmRnB2cVRHY2pWZFNQZHg2Zkw5Wkk4R1V4K3o0?=
 =?utf-8?B?dUFCbnJjYkZETVVkVnQ2cG1ZcDRCQWRqd1hKVU1kZ3RCQ0FBOVZ6eDdFZUtv?=
 =?utf-8?B?OUJ4ZTlpTGNtR0V2bTZ3QVl6dkVrYy9YaG5PekJtaU53UzZkZmJDRjBHZmdu?=
 =?utf-8?B?MlFiVW0vck56NkVPMVpEL1pYS2RxNTUrTGs1ZU43UUNKWTFuRGpmY2hSeXNT?=
 =?utf-8?B?YjhJL3psenBSYy9sanc5cTQ2Z09NckdtWkhRcC8vam1Jc0JSNUZ2SmI3WjRv?=
 =?utf-8?B?Vk1EeGVhMzA5UFBEL2lsbnhpblVxVFlZZU00eGxYU1A1c2NZVFk5eFRhNENB?=
 =?utf-8?B?ZHdxaloyTUd3dkl4KzgvcHFyb2xSdkhEQVJLQnF0VVZIWlc0Y04zcVcydVV3?=
 =?utf-8?B?ellqdFhlbE9ncXRBODN1OU9JWDRJU1R0ci91M0JTcXdkTyt6eFg5dnlhMWpX?=
 =?utf-8?B?VVM1NmwvOFhLRkNIOGh1RDB1ZzBxL2xjWE9yU1J6NDVlR0I2T2RsKzRtUGMy?=
 =?utf-8?B?bVh2MjVlTnRWanFCMkFTRHJtZmsrbVZCSzNZMUlqejFYOHFCb2RhMDRQc1I2?=
 =?utf-8?B?d0hQTmpxZXRQNlRhNWRLVkliNzgwWmtZd0FHTnJmL21BUHloMUQrTzNTT3Er?=
 =?utf-8?B?ZWFrZ2VJc3cwcmRXRk1BcmU5TDZ0MHpYeVQyd1UyY25VWjR3MEFOYjFFcXRo?=
 =?utf-8?B?cHQzeUgra245ZUNBSjFNRm5uNFhjcmVhQlJQZEQvbU0vYm1pckVjU0hSSURS?=
 =?utf-8?B?TFNJNmo4WHFGV2JNZW95SWlsSTJNUG04QTZFNzRJRXF2M0Q4UG85WVBwajJh?=
 =?utf-8?B?QlhrYVVlRmFtcXJjdCtKampCeUUvci96ZG90TVZXNmtpOGRmdGJ6ZFV1WFQ5?=
 =?utf-8?B?QW5xZGNaOVZKZXBOQ2JJZkZ3UTVJV2V3dVp1YTZlMTc3WElWRGVsNzJwS0ZZ?=
 =?utf-8?B?WHhnZFNaUzN2OTlyYXVrazY2aEYvNmdncVZ1SUNwUGU4MHR3czBvNE03L2hF?=
 =?utf-8?B?NVYrenZ5Q0Q1L21iUmxaVFkyNkp1WmhrWUpuTWFMQkdFeDhHdnhqdUlJQURl?=
 =?utf-8?Q?fXc9vW6IY6PgKvcPP5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4105f4-b37c-4163-2ab7-08df093d1836
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 21:56:51.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlU6s6h2klYNUSLMZBeS0ayeE2CIe3SXVyt/UnS15JVGy4bFP/8zwwTTXwQ+J4HIg5HDsYwXi9U+qzSUZ3Khiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB172729


On 9/2/2026 4:44 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] CPU hotplug lock is leaked if SEV-SNP initialization fails.
> --
> 
> commit 16bd9580b377dc645541bd4f478c471c109e65ae
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Initialize RMPOPT configuration MSRs
> 
> This commit introduces the RMPOPT configuration MSRs and adds support to
> set up and enable RMPOPT once SNP is initialized. The RMPOPT table base
> is initialized to enable RMP optimization for up to 2 TB of system RAM.
> 
>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>> index f833cb7e4da36..287a8345854ba 100644
>> --- a/drivers/crypto/ccp/sev-dev.c
>> +++ b/drivers/crypto/ccp/sev-dev.c
>> @@ -1663,6 +1663,8 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
>>  
>>  	sev_es_tmr_size = SNP_TMR_SIZE;
>>  
>> +	snp_setup_rmpopt();
>> +
> 
> [Severity: High]
> This is a pre-existing issue, but does __sev_snp_init_locked() permanently
> leak the CPU hotplug lock if SEV-SNP initialization fails?
> 
> If snp_prepare() succeeds, it disables CPU hotplug. However, if an error
> occurs later in the function (for example, if walk_iomem_res_desc() fails),
> the function returns the error code without re-enabling CPU hotplug:
> 
> drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked() {
>     ...
>     rc = snp_prepare();
>     if (rc)
>         return rc;
>     ...
>     rc = walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, 0, ~0,
>                              snp_range_list, snp_filter_reserved_mem_regions);
>     if (rc) {
>         dev_err(sev->dev,
>                 "SEV: SNP_INIT_EX walk_iomem_res_desc failed rc = %d\n", rc);
>         return rc;
>     }
>     ...
> }
> 
> This leaves cpu_hotplug_disabled strictly greater than zero, which would
> permanently prevent CPUs from being onlined or offlined. Does this function
> need an error handling path that calls cpu_hotplug_enable() before returning
> on these failure paths?
> 

Thanks — but this is intentional, not a leak. CPU hotplug is tied to
SnpEn, not to the success of __sev_snp_init_locked().

snp_prepare() disables hotplug and then sets SnpEn on all CPUs via
on_each_cpu(snp_enable, ...) before it returns 0. So by the time
walk_iomem_res_desc() (and the other post-snp_prepare() steps) run,
SnpEn is already set on every online CPU and the machine is in SNP mode.

While SnpEn is set, a CPU must not come online without it — that is
exactly what disabling hotplug guards against. Re-enabling hotplug on
the walk_iomem_res_desc() failure path, with SnpEn still set, would
reopen that unsafe window, so hotplug is deliberately left disabled
there. It is re-enabled only once SnpEn is actually cleared, on the
x86_snp_shutdown path: snp_shutdown() verifies SnpEn is clear and then
calls cpu_hotplug_enable().

The one snp_prepare() failure that occurs before SnpEn is set — the
"not all CPUs online" check — does re-enable hotplug itself. There is no
failure path between cpu_hotplug_disable() and snp_enable() that can
return with hotplug disabled and SnpEn clear (the intervening steps are
void). So hotplug tracks SnpEn on every path.

Thanks,
Ashish

>>  	return 0;
>>  }
> 
