Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDE351C11;
	Mon, 13 Jul 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965135; cv=fail; b=l9b/KB89+bRl1Jo7/inzKB1bBNAO/JZj5+cqMHdModi6xBtv4Y4cf4odbbYUUq9FUc3rqZQze4TUX3c3x+4pycxZHXo9STIxoGIfVzOK4VDQIz4FbyFy0EybTviTOhRpuCQpLYcaHKfIISHQepz9UwuRgT3CXhN8mK1skLctPj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965135; c=relaxed/simple;
	bh=NXmRZMaKd5gkjKctjKw3y4zuJNPHId5db/9RXWOkmlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=krE7nkg3HVYl1EgIYr4oQjeU36zBzwm+mMkiAgy2hos3sCl9HchhJZa00OtiHCQlhieLTb2j44cB66yaCqUold5roUqRaQjp4mR65U5DovSD1WH9fkR1IOEUZez+AxCt4ZbZt49L/PuRNb2LaQS16/CF4FowJbJuMj5t2/aBQXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDykkxkq; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDykkxkq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS+EapxBPlInDdmB1LoC0A3ZCGgGXxEssi+FhpmRouWqSz4/xnKHHyNJSvnHnbLEUI5Uob5iHZrSz9sdaZDlPXKilBcygIOO6YKsJ/VoC8kFtSl+lMTDLngutiEs6sZghlCtG0vttI8P0Y2m0fwsbteyoaTKAFD64speUO7rj72Gc97SeEI0JleNxHbAeNJT7x3VsEJ84l6K75YbgU/QF32sygYcBqVFk7nLJChGWg2Zek1Z9pPymTReLOsKwYO4srLl6p2iIU0JzxE4nRleGkX6m1B94MCDXLDwrKUBcyJaKlgpEmBeOrHa5+CPA/oAOUvgTbOHBHiMLLG5+ITDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiBn63d2Rz7n+GYSbtue1lh54qGorWcazEX2ZAdFqhw=;
 b=l+/PqIAu8f1L2+3d32TODrmM8MIWG7ZOCQ9ZWfwsdbzRcYC1lOk47xmUZkFwgU2IwuJ3jjBs5CLjx6M1PITgSl1HzR464LznBV+7o48V/DK0dNVgFTSnC87CBB55S7G8ROlkwWLZbrZwyl75vNbKO17KZCg4V5bBaQOIxLdWmJQCBLRbTwF9Yo8wHbNBFXjotkFDBIBllCZwCzg/IJSsBTIe8j+ZLDCi6hDjjupCFmcmuI1yzNBP/5TPxVgj1gRfneSfT9uwrdkNzH6D0isJ9ArQyCzSyr23Oa3Byk/NhL7+ME449qGIrqZn2QqO1kQ3iEB1SUnEsoScCiiOE8SeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiBn63d2Rz7n+GYSbtue1lh54qGorWcazEX2ZAdFqhw=;
 b=PDykkxkqXME2SPsVvavY+wAYb7V5HOuduikB/Zk0ZWj9U8q6NEo9r/GL14SQO2oB2prGy2Xa77wJ96OlSb4llt3hm/HVjdyEvQ59ENsBAGTrxXi5a0gBOJOnWJfmfQUc3oTTL1sAa12Xt6FAgHG/UvmKNrqalpk/TQ2JQ8ABPG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 17:52:09 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:52:09 +0000
Message-ID: <c2712047-cf0d-43de-be42-fa7ae80277a4@amd.com>
Date: Mon, 13 Jul 2026 12:52:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/27] x86/kvm: Disable PV_SEND_IPI if Secure AVIC
 is enabled
To: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
 <730334f9cc320ca738402183c8b8555242a84ba3.1783490022.git.naveen@kernel.org>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <730334f9cc320ca738402183c8b8555242a84ba3.1783490022.git.naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:610:b3::20) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: fe44f900-e85f-4537-b300-08dee1077590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	dkDbB7LXi2xT9Yk3FLpBD0fLBa0gAjhFtAgR4K30qWSSr54IUOqs+HuGnDKKN/ojQGdTC0Nr22I7oTCGj/G2xFUeOyOm8RgVkGXOWvZ35uEZU+CCJkXXYGyOCm7mkG1dgrbHQGVDyH5rN8bqd68f9T8RqlhPLhiUMEapZf5pC6OvwC1Zz41UoJHqYtc7r/WWWGUfuY5bPSn8BM58/LX2CnluNK0jSJIGM5ljknEp94v1u6Bjg64q1cS7SlFnGdl8w5HCA379b+mxkpu1kgTmoAfwrtF9JBWz8TNwN93eU/e17ffJ8xPiXS4/ZgFJa6ykMTayz4gaerBDzqzpyl5VJAgCN6dzO5gikiYtEyZgWbWylVObNQPq9H6dNbmChMxHleCiLoXkH58zNRT+5AwEArNwo71/yxoHC+w1IKDV4MwS1L8oSM1LesSSGV1rl1UVMEJXcROjkL1oLn4AVq99rv9Uuei3MGLB4f0OPwXpRMQLxoZxTIW0Asm8L3i62W4kiHmrPTRgwjuBrIGu0y8Ht8Nacfu+A8DPXnhrYecsZqDQP1+iMGdXeGP9cR/CRDnJu8yYhf9pmLmwUTQl1v3mKAP3oMgpBtiy6B+DRQVwWWOP8QVGs81jTpOxgdeUnMUuI14JtferC79oh/lfG+uzVAxtP5ssNT+01z7czWIswrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzF5Q0UrdnFBMmh1T0Zqci90YUFDaDgyMjBkU29BdDN3NVJrR1RuREZ0Tnpx?=
 =?utf-8?B?YWJ3T0g5THU1Y0xDNXM2ejI5N1BtZVhOT2RrRFRncjRhdmNqdzZnMnhjaTkw?=
 =?utf-8?B?NnhVWEw5RjgwZm5TY25MZFYvR3d6bUdqSGRGZTdnQ29FNVExZTE2c2hybEhs?=
 =?utf-8?B?V0Z4TlZFeXNjYW9Na3dKSHZ5aElXNkl2QmlwTzY4NExwRXNQZ2s3dDN0M3pX?=
 =?utf-8?B?TEQzS0hHSmoybXVpMnpDYjlpMC9WZi9ITWszMFN0UEdsOEFiZXRXcEtRaHY0?=
 =?utf-8?B?b3BRa2pnelI5a3B4VUxnbWovMjE4WTRMWXlLUGt1QldpbjM3S2IxalpGYXVC?=
 =?utf-8?B?d2tSMFlFRXhtdFJkdm9Lb2hoZWw4bTkybW5JdkJWRnFwYStOTW1weFd6ZXdU?=
 =?utf-8?B?Y095YzcvY1dyTHZnQXpldUlrNGFaQWxtYlhvYm1kODJrZThIdXlLWXprZ0Vn?=
 =?utf-8?B?ZkhxRk9kTFpWRENrd0M2RTZjQzN0YlZCWkR6VDMyVnI5Y2xzN2FETEdqV1Vu?=
 =?utf-8?B?cy9IYWxNOGJHTGtZS2NyNVhOZmJpVnZ6QlpsZ1dtUzZQeG9lUzNYeEFCMnMx?=
 =?utf-8?B?REN0SUZMMHM3RisySVhXWmdmcGNNNzdqMWtFUmVqYmh5QmNtelBwTHdBRjNS?=
 =?utf-8?B?QzQ5VitRZjI4bU5XL0NPL2t6dVJ6elROVlpPUDBLV2pvSXpZZVJZc1N3cEZU?=
 =?utf-8?B?akhQbE1rRGRlQ042RUdEWndFOUdKSHZPNkNtU2YzZzlEb1FyT2x2dWJhUXBq?=
 =?utf-8?B?cVJMOGVHUytUM0Y5UXJDN3Z1djFKMnczOGFxNEU5ZEh0SXJTd1JLVzB3a0RG?=
 =?utf-8?B?cnJ5a1JuWGNzbWorOWFZaFRUTDZyNGQ0S2hkUUJoTm4zZDB6VDRLdzdLa3l0?=
 =?utf-8?B?TG5uU0l1bGlnNndlSlVRUzJIVlN1Ty9LdnI0WTFwRFY2UzdCRVJjVzh5Ni95?=
 =?utf-8?B?b3FQcXVsSFBlai94S3VFM3BpK3RKdllKY3daTEVFdGJHZjNSZ3dPT21FOTlT?=
 =?utf-8?B?eThTb2dpQVFZL2J0VlZ6WEs4SHF1MmQzZUg4VEgxVGF5WENOZmtWNTJ2dWlu?=
 =?utf-8?B?SFBVZG1TM0JEaU9kL3BGQUdPVVVlR2R5KzZyQzlGTGFybmpqSlRTTzljY2Ns?=
 =?utf-8?B?NFZRNjNsTVZ2UG5XUEZZblBJM09tRXFqQUhJWmpvcjFIMEF2U2NqalFlSjdY?=
 =?utf-8?B?Z1luQ1Z1QkJtYXNOWGN1SVo3ZEFMUE1yVmJtbkJreVpGRmMrK3p0aE0wc2NJ?=
 =?utf-8?B?TGdDck1uOCtXVEY4SFBBcThLa1hMcjNyamlubVczMXEyYTRRUk5FaFFnV1pP?=
 =?utf-8?B?djh2L3JHelNpcEx5MitwNVNpY29Dem81K3h4cGVlTjFxVE55QTluYlJvNVRK?=
 =?utf-8?B?cmFoWFJ0RzNIZWNGZmE4bU02NzREclMxeVZYaGkxUkVNTlNmMUhYSDF6bFlW?=
 =?utf-8?B?cHBORmRrVDBiZ3l2ZGdqaUI2NjkyZHR6bkM4OXFIVG9zQVBPSTRhWm1kb2cy?=
 =?utf-8?B?UWtZTmxhTHdJamN3YTBLY3kvOFRuLzU1UzJ5djk4UVRjazFIdm1ta2N6U2J5?=
 =?utf-8?B?WmRLRHNOenNldkhNQnIvSEtaU0pUUzJyaVRKdjdiQmtESE1hNjFBREhtTnVB?=
 =?utf-8?B?YlpTYTJnRjdLSlRqcXFFSU9mcHpRM1hEMjBUbzhpNzdGeXVFbUEwR3Q5WWpv?=
 =?utf-8?B?Tm9kYldLZFd0amxSWU9oTkMvcXhadEVZb0lJZFg0MzhxRkZwWjhMWHZ4WHd3?=
 =?utf-8?B?RUVGdXBPeXkwQmdrdk9TOE1LR04xNmYrdkI5S29xZTVOcy82T2ZrcVNXUWZi?=
 =?utf-8?B?ZlNPUld2K3hoeXJuRFdienlTbXBvVis1cGY2YkVneGs4YXV2T1BDZVArMHU4?=
 =?utf-8?B?dTV5bUJzTEpLbzFQVVB1RkVFMElrTGRBZlpPdUJ1WUE1Wi93Z2N1ZTZhenlv?=
 =?utf-8?B?Q3J2R3NEVUxmOGFGU1lnM3dRMzNxRElpUW5OdTdBKzFiRjlBUFVsVWxXN2Jr?=
 =?utf-8?B?anBVdExLckRWWjBpaDFIWnVIbFN3NXJZVGVyWkdjQ1N4eUNaT2NhTy8yK0F6?=
 =?utf-8?B?aHpZNDdPUHVKUDVqcDFDNXovQ0pJeEdXazJlM3F3T3NuZ1FJcE9ETDFDZ3Jy?=
 =?utf-8?B?d1pVbkQyQnNaQ2RuM0FhaUtoTGJRS1NQWjJvYU83OE5UY2ZBYXNUSm5wVkR5?=
 =?utf-8?B?ZTc2c0FIdUZkejI1cmlBRkFTNUtBZWh1a0hvT0VMUnI4UnpmaHY1ckJPOVFo?=
 =?utf-8?B?VGFGaHdDcnNOSlhEMjdBVGhGeXdjaXdKK3JwbU9CS0lrUnAzZmo5MW5odjh4?=
 =?utf-8?Q?KNxYpNhnUPjUcPoYsJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe44f900-e85f-4537-b300-08dee1077590
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:52:08.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdgSwUFOdNYgSypZFUmleFxvlb5mh+h9lcuY0JyeMQ6Zgp041b7jSrqTY+jWXHEaNlMwk8XZGgvlX5toMHG/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> In Secure AVIC mode, Linux does not allow IPIs to be injected as the
> hypervisor is untrusted. This is achieved by not setting the IPI vector
> in SAVIC_ALLOWED_IRR in the Secure AVIC guest APIC Backing page. Due to
> this, PV_SEND_IPI cannot work since it needs KVM to be able to inject
> IPIs into the guest. Disable the same.

Another guest patch...

Does this have an impact on the hypervisor? Is the injected IPI just
ignored because of the SAVIC_ALLOWED_IRR? How would the hypervisor know
that it needs to schedule the target vCPU if not using this, a write to
the ICR?

Thanks,
Tom

> 
> On a related note, PV_EOI does not need to be disabled since the
> behavior is exactly the same as AVIC: though it is advertised, KVM never
> "enables" it since APICv is always enabled for Secure AVIC SEV-SNP
> guests.
> 
> Fixes: c4074ab87f34 ("x86/apic: Enable Secure AVIC in the control MSR")
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> ---
>  arch/x86/kernel/kvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 29226d112029..e2dad507f2a4 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -495,7 +495,8 @@ static bool pv_tlb_flush_supported(void)
>  static bool pv_ipi_supported(void)
>  {
>  	return (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
> -	       (num_possible_cpus() != 1));
> +		(num_possible_cpus() != 1) &&
> +		!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC));
>  }
>  
>  static bool pv_sched_yield_supported(void)

