Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0504E323E
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657699; cv=fail; b=tcBBNvEKCKiv8IB1UoeMMrXGmV+vdHc7OaF6qWqy5XhrgqwFqBeNtHjKOCx4E9tVH73JdnucMKVrOSw26RyF44hZcyitYEzCl+lxgyStJrpNAke0rptu1/h9T+eUROq0r4Pf+oUGTuQtwdL5jTxblUnFhXaiLZ0PM2gGLXfLIjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657699; c=relaxed/simple;
	bh=v7PqhStPViv0mSHYII6CqjRxGMRIgxcadLvMBy+9o2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LjBcw8KINtcBhOQdh9OueSLBMg+whSpV2jyJSs8xrRhRyE748iz+Z+IAhS1TRlb4X6gLUKNP7B1PiKuyKk83Kch//NOip4Q2fwd+A8Kj/VB8ks+j3t9gvTINZlCBkJ/7PK7xs1rzw7IHXguTDJQWnCttLvmjXk3tPEXFeN+nusM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwnuG6pZ; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwnuG6pZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma+m40hxBrOE6fzVjYnEyXr1JOhDg4WsK63tqQkpqf9uTKFLVvgHI4PWc3cIMPWRxZ+j7SKWPhX7kqS2lqm9F48dccBvCrwmG+0GDQaXWt2DIjA8Mq85FnmOPj0S1+dVMtzyy/z1p8zzqX1bHi2AjdtkAc2vOtTyFTXhule1AzlP8rUjj71+vqke//yNU2a02O9nI2VXZW8JWUTVWuzq+L+jAAwyKELbzjAR3p+igVwUz1FFSvsIJdpcAOIiOygGlaRadSIr1SBKnmnPlYSZkccXOGdcvTJOM6gUsx7QY1BylvFJ0QlgwVuzAy/fMbYYTHUL9eCBpHCGMPyyDWjjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTph28p2B0ih982wCcgZuqMKKX5LotHkxGktMlKyLRs=;
 b=Krtgi/Nt5r9/stSFufnA/xnlE9B15I4XTxEZwCBE2YR0bI/g0G8LVAZNpgaCCeut6ySWnPcV5sHtgtOMBioC5xlIC0bdvK0Fvm8yW0Q6AE3ZgOTlmIwFrlhcFVsauVB1kQZlYxIcG1OYK9e/EHadjoz9USKfcxZ5Js83pjgusSs9CYcqxIKprxoMJ7tw+0ZFDMwDCj6aYa/3kjgM4X6SySFesjDQsmFDjvIadzOO5DL6LRnBbphjCpSGSHKsTRqS9rH7cGAHyKS3SNkkkYU5g4s1+ErLB97UBXWXTfZLCvahmZkMHe2syzMAnojOBjWI0HaDj+Je20X2ylA1vN1qCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTph28p2B0ih982wCcgZuqMKKX5LotHkxGktMlKyLRs=;
 b=HwnuG6pZA70+1XCc865+f4DNwjrVvqkZmITmsAd1H0eDCEJU7jX2snmhLj0hy3Ouq9OQRmk6HlDgGY9DgjpKJbmuXNQ4Zfgg4vvPG8Xx2+82YKhadYHiW1fssBE0hLvMVervz9RQO7BQ2koObN4dmscVHL8o7r25WLc2cewr1w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 15:07:34 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:07:34 +0000
Message-ID: <bfed1448-4901-4c41-97bd-d0fcd5c7a62a@amd.com>
Date: Thu, 17 Sep 2026 11:07:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/sev: Add guest support for Enhanced SMT
 Protection
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1789399214.git.prsampat@amd.com>
 <56d81f0c1527c8291733aaea72fb70742fb96719.1789399214.git.prsampat@amd.com>
 <20260914171104.CD8181F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <20260914171104.CD8181F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 7612d081-95ec-4c38-35ae-08df14cd66fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|6133799003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FN8/0nsQ+woCqPyv7R+cjUCYPys7no0iXZzTldhGkO21mKv3PbBfmaKjfD+Xx2o+X7zEs7Pi1FG+7zdjCtVXoSJEl/INW2XKK7OAduYHF1IXYQpCW8Q4kcwliBERvNNM9DqsU6/w6yxwG+PYE6JE8kWCRFpxHwYbxu/mlyvWuSO0l/zNPJFXo28cLTuIv1DO8TQYjBO638tQnAKPmXk4wXIcoMwsut1paGlFyROvXe+rviiJSVOLh0lPFE2b+8tBLwt9j6dlAqbIDTDUKrEXST3zsmAjMNrqSUwgoh8gM0noQH3xwZLxKYyiH93Dvt1VsxWAkpc9K8F6vjzRJQSQIa912+PlaGDTQQfAO9PvulYl81Ose7R2w7NyxvdJgKEtx5bSIxHB1bjoHNWh/W+wxwkJGnx8tXTPI/m7FH2F1xgGiBAn9JgvXvTRHNeST9SSHZh3aRoM0nE6+xR+YCGbwOUcgQxWSJL5+fjkoC5QxHcTyceQbzfe67QsKoL4nbvIBPMMLr3UCF5t/63WdRCdHG/Eur1jfzgiXSTOJ+s+aLYjiVNXIG1TI8gdjLXB7qkuvZLhHR6IXDc4Ja1i/NXuTd3nSOlB6qfS0aJlECJ0QfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(6133799003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStlNzhJUzB6RU5PQkV4TktLMUtZVDFrY1J4WGhBUUl1bnBCZ0JYRFNhN2VJ?=
 =?utf-8?B?dmt3OUFzdjBjRy9UR2kreGFSODR5MU5pZ3NPYXV6SGNVMjJ0K0g4Y3BDc2gz?=
 =?utf-8?B?bzJISDNKNXQ2a01HMXNmbEEwRXB0WE5UK09aa0ZKMlJxUEVSNDdKVHdZdXNw?=
 =?utf-8?B?YkVQU0w1aXNlcGNWWGN4bnRyQ2dJd2ZHUHlHU0cydWYyNWo2a1VTK0NtaHFV?=
 =?utf-8?B?b1VzT2UwNTRPa002QmpJajg3WVFYWEVQV1pNSUxRQU9WUlNTS0hpQmU1Nm5G?=
 =?utf-8?B?WWhrNlFXeWVwY00yZDVLR2NrdG05WUJ3WWFTWWNtcGhXMVFqRmprSGJYbk5Q?=
 =?utf-8?B?cnNRVi81VW5mdlhubmJaVmpXWE5ueFVNajQ2dkVtNklKUGFUL1dxam5abEM5?=
 =?utf-8?B?S2RKMlA4aXZBcUtHdDJZdFRuaFoxcTQzTjA4d3d1V094b3QvV2VOUjN6ZGtw?=
 =?utf-8?B?a1IwUFQzdFAvSU9zaE00UUdFR1c3NjIyMmpOVlJtc0lUc2pKV0N6V3YzM1Yx?=
 =?utf-8?B?RVZ3d0NESXUzTTcvSWY4bzRsRW9YamV3Z0xNeUcyMVZveWIrWUNOWmFYZTRu?=
 =?utf-8?B?cEg2RXlIcDRyY2Y4ZEw0TXEvUCtUTm5Nbk1GZWtEcVBDdzBwbzlmVk5FMDVx?=
 =?utf-8?B?MFdaNERQcFF3NjNydllITDBBSVVMY25qbitrdG13Smhxa2tteGQrWVA0MVlT?=
 =?utf-8?B?cGx2YXh3cGlXZ215Y29GTWYvQXNqRlJ3eWFodUc5U25oWmN3MFNyM0NFTDc5?=
 =?utf-8?B?aXhzemxkZnhsanFRY2ZQdzd0TkhVM2FDMmJLdW5YMTRqdlJiRzJIKzFoMDNF?=
 =?utf-8?B?ZzNmaEk0RU52d3JJRS92SFBEOHZQQ3hWV3NEOTcvR0YwWlpvZEpUdU5PQlFa?=
 =?utf-8?B?Um9GNzBTd09kRkVDdHBlTENQMktIYmdHMHIvR1M1b3Z5bnJqNDNOTjZFZ0lY?=
 =?utf-8?B?MHpFbVEySlE0Um9pa2pPTWJ2OFpJV2RYNkl0ZEorck1JWmxpaDFLemZSYVha?=
 =?utf-8?B?N1dIWUQyZnRpZ0lsNW44Sll5S0QyUDlVUzhwTXVSM2M3NlYxUmNxZFNpQ2RQ?=
 =?utf-8?B?a1RzaXFaeUxRa0pIcmtBa2l2dlU2R1Z1aEhqeGJiU3hqdHJzOWVKNXF0QSsr?=
 =?utf-8?B?djhtRnVsNzBtQTJOOFl5dHo3bEF0UVIrZGJia2dLY3pRWjlGdVorcWF0WjZS?=
 =?utf-8?B?NzlGMnJveGdCUFFCOVRMOFRTbTluSHNZRzIzbFIwTkFlSnJKSjhkNGw5TUpM?=
 =?utf-8?B?NUh1QnBzNHkvN3NLc2t0dkdjOEk0TEhlU3FSc3hkVW9SUkY2TWtMK0hxVTFE?=
 =?utf-8?B?QzZzV0tyQW1Jcmp5ZHM1d0VPR1plUnBpOGcrRUgvMkFBSjlhVG5vSHpSSlVr?=
 =?utf-8?B?V3hVbWJFMHhyL2xrdUQvUXN2MWM3SjA2bUgxUzNwd1F0OEhvQytTY1VYQlVI?=
 =?utf-8?B?Z3YrZ2NiNXJWWEY5bjVnSTB2a2ZKeHowSnJVT3lQOEpXaVZCSFpWMGFoZlF0?=
 =?utf-8?B?MWJvTU1xS3JwQXFMb2RVYnViTVRnQUFlU21QMmI2VVppYTlQY01nc3ZzZkFF?=
 =?utf-8?B?ZHlFVUVOdlNrZkV5R3RoUkN4WjNaTHA5TS9ybUNXQ3pkNVFxeUVGN2pOdjJT?=
 =?utf-8?B?VzBJMHVMR2ovRVVBNDByZllEWk0yZjY2R2hZVUVmei8wd290aTQvVExhU3h0?=
 =?utf-8?B?cHNYbGNuTkRCTXRERFFMeENjRHhQWDBGWHk4NENIUUhiZ2FGekVJT0hFU3c5?=
 =?utf-8?B?RDBsNmZDWUZvZ0UwM2NnWGJNUjBTUElpNVRKdTNpSHBMZTNvNVkzY3JFbUhp?=
 =?utf-8?B?MTJCdzZHeTZqVHBRcCtlWTlaT09JeTJHSDZldDRnSmxpdUE5aVViZTJEZzJV?=
 =?utf-8?B?NVNaZndZQ2pvTzVsRm1XeVpyK0ovR2pCRlBqK1ZJT3FEcml5MU13eHJYc2xZ?=
 =?utf-8?B?c1d3QjZBaWFac1ZEQ1I2Tjh5Zldtb0FNUUlwMW1Kckt0ak41bm1nRGcyS3VV?=
 =?utf-8?B?dWlNM0p4QjNGUTVsUzNxS050UHlEODBSSmlGTzFmaWNvYXpkZkpzaXRERFNt?=
 =?utf-8?B?bGZzV2dxVkRQVnZWcXkrbkZGUHV0RUNxSUswdGY4ZVJzQWJ4M0hpaGdYbnNx?=
 =?utf-8?B?cHR0aHhRd2thc3hnUWtoQk0wT08vOS9UMy9GcEpQWTkwOVMzTTlRRFVyT2lu?=
 =?utf-8?B?Q1l1QUgyTlZtc2pMbHVXL1ZBdFdScjVnWndFTUdlcFhad3grTXQzRUNHcnEw?=
 =?utf-8?B?b3JkZGJVTVcrYjMzYW11aTVnTFU1dVJubGN5RVVaL3ZxRVlHT3NiSTJPUC9N?=
 =?utf-8?Q?bGyc8mlnjPo5w1crsc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7612d081-95ec-4c38-35ae-08df14cd66fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:07:34.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Du0m3KUgdbnxcq0/71345fBYBLsCJqX+UFjA3+fdehHsK7AUATv4utHRiOqzr2vU0op19sp1NdsurLPLT1J8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955



On 9/14/26 1:11 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Hyper-V SEV-SNP AP boot path entirely ignores ESMT, leaving VMSA fields as zeroes.
> - [Low] The tools header for msr-index.h was not synchronized with the kernel header changes.
> --
> 
> commit 8604f276ddd2e9fc69ba0b3ddf175ec09324c70a
> Author: Pratik R. Sampat <prsampat@amd.com>
> 
> x86/sev: Add guest support for Enhanced SMT Protection
> 
> This commit enables guest support for Enhanced SMT Protection by
> populating the vCPU's identity and SMT sibling mask in the VMSA during
> AP bringup. The sibling mask is fully set to allow threads of the same
> guest to be co-resident.
> 
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index ecd77d3217f3c..acf25eca1a5c9 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
> [ ... ]
>> @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
>>       vmsa->vmpl              = snp_vmpl;
>>       vmsa->sev_features      = sev_status >> 2;
>>
>> +     if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
>> +         (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
>> +             vmsa->vcpu_id = apic_id;
>> +             /*
>> +              * The mask fully set puts every vCPU in one group, so any two
>> +              * of them may be co-resident. A legal ESMTP sibling must
>> +              * also match on ASID, so the sibling of a vCPU in guest mode is
>> +              * always either another vCPU of this same guest or idle.
>> +              */
>> +             vmsa->vcpu_sibling_mask = U32_MAX;
>> +     }
>> +
>>       /* Populate AP's TSC scale/offset to get accurate TSC values. */
>>       if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
> 
> [Severity: High]
> Does the Hyper-V SEV-SNP AP boot path also need to initialize ESMT fields?
> 
> Looking at hv_snp_boot_ap() in arch/x86/hyperv/ivm.c, the VMSA is initialized
> without the new ESMT fields:
> 
> arch/x86/hyperv/ivm.c:hv_snp_boot_ap() {
>     ...
>         vmsa->vmpl = 0;
>         vmsa->sev_features = sev_status >> 2;
> 
>         ret = snp_set_vmsa(vmsa, true);
>     ...
> }
> 
> If a Hyper-V SEV-SNP guest with >1 vCPUs is booted with ESMT enabled, the APs
> will be launched with a sibling mask of 0. A mask of 0 does not intersect with
> any other mask, which could prevent the AP from being co-scheduled with any
> sibling, leading to a hardware violation or a failure to boot APs.


Yes would need to replicate the same for Hyper-V.

> 
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index ee9fb820a1cd7..638867e7b4ec2 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -745,7 +745,9 @@
>>  #define MSR_AMD64_SNP_SMT_PROT               BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>>  #define MSR_AMD64_SNP_SECURE_AVIC_BIT        18
>>  #define MSR_AMD64_SNP_SECURE_AVIC    BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
>> -#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
>> +#define MSR_AMD64_SNP_ESMT_PROT_BIT  19
>> +#define MSR_AMD64_SNP_ESMT_PROT      BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
>> +#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)
> 
> [Severity: Low]
> Does tools/arch/x86/include/asm/msr-index.h need to be synchronized with
> these changes?
> 
> Currently, MSR_AMD64_SNP_RESERVED_BITS19_22 remains defined in the tools
> header without the ESMT_PROT definitions. This missed synchronization could
> lead to inconsistencies or warnings when building tools that depend on this
> header.
> 

Ack.

> --
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1789399214.git.prsampat@amd.com?part=3

