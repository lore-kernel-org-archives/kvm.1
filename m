Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1E346A14;
	Mon, 13 Jul 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964635; cv=fail; b=XJovNaw75PrXezz+JV8jRmmq3pVPjp1Z3qZJb7P2tqOfxpsJzyZl3rTha3nDrngKeMljxyyZ8BFfruqlzWMU0jR0BfOEbskCMIRgIOj9BPUq1xb2LbybTMG23sZaIVwTPhIhz2THsx4LaW2tKErz3iK2IufvvhUV8fLtmnbVAoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964635; c=relaxed/simple;
	bh=Julo+NZnCWYlzZIFdAtKu/FGSmzz52BzWIjNQY4CHKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEdkfBHTLYwPomM1oc6m1M5GVYQk3pPlKxLgZQZlWYjnQIYnZvD3Og9ruma5DBttV3CG8uyAUejei6jA/LNnlbSY1ne1YP7y+Ma4eXwGh+b47cVO/3yrJg2rtbWACYhS83JW/717+ekDs0bGHY8rlN5DhGLW7Pt8SkgVUruMbWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IbMeikwV; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IbMeikwV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQCWKC2/jgDeZBAWdxAwkHTvCFzCbVeJrnor9C7/VFQ3IqBJoBcFZJK3RG+A56aZ94KyjdkyISZ/z5puDZLgVzLd2TwOckzvkwYkA7XwMEg+xfXg3d1WGdGGmn6ChijetlJMbXyPoYJfQLVDyVY6epTSHC1YCuhP/vOvMNyOBGjfJXeiJJ/93UFeRqUaslHnHtMZTg02C2I93KxvysWi7dHEmfVcdQ07ibPDSkxzc3OM/BXVoSUU1TQyc+ISKs5YAa1qj0Bdh3LOSEqYpsK+a8/d6hcbN6F1NvejQ24pkS3RSSQCqnW/1Vj89e+3zaJjnXya58jgAf1aAssNz6Y9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4DyoHIgALXUeJLN7HEMt3D6Whh9BeDPP7A0hK9CWoA=;
 b=w9FVDSAzRyycUjzW2uqH84bD+M1ZOC8v7IMzvPCWxb5ohLK7PF9Xw+QMxWu6Tn3Z3Yz19cQ3CJJoR2No0lYlzdZZ50ETf2SHTeTrwqh2WYLQ+jIUBK8+GjiBHTFP8BevTAn62UtTsH5uEdjwCMlb3WW5Iim6RrYDJoo99tAab8S1xgY2lmmO9bm32Sp0Yc1Vi50PXRT8zzxwi56FpMgLHxT6MB8XoBuojWZGpmnKaXDp/Rdd+FOss5DfWqcYMi94QxSqFlYu0lnJTyzwigipOVVKne5IFvwfKasZmzoL5lcdEkn4iQlwWNefDu031RCfcDNVTD8b29pVxzjyt213Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4DyoHIgALXUeJLN7HEMt3D6Whh9BeDPP7A0hK9CWoA=;
 b=IbMeikwV9Jl1//pwk9KiFRfIiLODol8B/pAex8KKaVoz/FWcw7qcgTvQ+tJcVgbMPoYNtUjgNMrb9+deRiCfvuC6VFnWl4XhGikkplHyKQfFmz8VQBxnHu6uG2l83fHknEeWKVP9rb17rCD/YV7F9rbivq+k+sBmD84Pf9TFbUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:43:48 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:43:48 +0000
Message-ID: <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com>
Date: Mon, 13 Jul 2026 12:43:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
To: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
 <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:610:e4::17) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a34148-b026-4bd5-75b7-08dee1064b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|3023799007|18002099003|22082099003|6133799003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	jt0T+gZ7Eds90c6Tv9AnwM6pU7EcJ8UUJWotd9tNZapYHW92MHBVmqP2GjTSxDzaqBsgw4tRPeRB9oKx+SLiJ+vk71JJjnTylcbSz+CSr3ntrRcXaQD93MBx0KFXvg9xovq8qHblPtqI6oYG1TdLf15sG9eFs/phFvFeIT7i7qasecoK/cGe0/2GLa3IoTICrdfTEP8AR9cmTbcu68mPy9s364AKTfQM6sSpjnuAnr0Y0usO5R2CYarr5Gf6mnD1Y9V9hP+glZl8CxfmrhLF+1+24NmlH1ad/4bLcbKrzal3KHw5KJZsqkA+VvmnWUAddDu2alJNEaeDNmPoAxPhFCWRIpk9xpdutp/ET8i56D6w0v4fY7xfItnWRdKYR5E6kFumM1K1HJMRZQk9BbIu7zoPd8eKUt7d6mTlAUUwVj+ItoYk5WAc0eZH4GIYoyJiA0L3UjnNxe4gkmYPV93i9BQjcu9enDpFm/6BXK+A6Nt0iXyc0/qHi5VyumigDqvOcOEcU5yE9Yr7NKYa834ghUR79E9D3j8mrqpsBUZEuKU0Dlr95lm1J7alM1sivtfxnoVP1Fl1iikkYpm7ZVSaNtvg4GvyQ1Jrb/2kNBJIQJ/OA9lZe9itqp5odi3GIM0uZMC7PULV3miUqYm5wUrZ9sj4NKXqJjy6d+v2HZfCeu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZXSnFUM0NlelVWZHlTUlE2N3pxejVWYW1GdjJUeDhaakJnTzYyb2U3eUQx?=
 =?utf-8?B?WHRnZFB1Mnp1Wjg4anBlR04vSmU1Z3p6YUtEcTlLTWxlQzBvRzV4ZXZJcURi?=
 =?utf-8?B?U01UUk5MWWwrYnpvTEFUdWFPYjc2Zms3T09USExrd1A1QUc2R3FRTStQdmJT?=
 =?utf-8?B?TzNFeDcwRUxWTElXaE9JbHhqTjduRGJ4ejZQbkpzWDhuNm9CTitqNE9KL2NO?=
 =?utf-8?B?RDVpZmVMNVBhZjZ0L0hxQUFxSG44bFZZYmlHeVRaL2g0dDNDN2c0em8zSVlN?=
 =?utf-8?B?NEYyWjBncnQ4bEM2dCtzVjZmdWptbVZSRXk3TGZaZjMxMytLc2dubzN6SHlt?=
 =?utf-8?B?RDIrQ3FIa3NkaGxGclJkaU1XeE5WcSs4OVp2a1RRdGw1VXNldGJMTUI4WjZp?=
 =?utf-8?B?elpQMHdNWEYxN2R2K3dwMFBzb1BUVUdOTHRBamlObE9OdDNGSGhCZDZPVWJq?=
 =?utf-8?B?bCt2WUpwbSt4RTA5cGtoVDFCeGM2eHkxT2RpMXhzaDRFQjh6d29aVzRwUkg2?=
 =?utf-8?B?cFIxK0RZVldBbENzSFNBSDZ4ME55dW5Ta0o5c3N4bWZmWUxyMTd0c25sVDhI?=
 =?utf-8?B?dEpIY3htUWo4OThTazA0MlhYOVhIMXF5UWRrQ3RhRnJpN214U2F6SVFJc3M1?=
 =?utf-8?B?WTlaRlprdk56TElrT2lMSWZXcGZ2ZUZlcnBRakZGdDZqejAyT1ppNi9TWVRi?=
 =?utf-8?B?NVRvaldGTWhPUUNkQ2ZRcDV4K0dpZ21LLzZxd2E0b0VXUGdYbE1mcDExWDhw?=
 =?utf-8?B?MDVIVjJERUF2dWF1RGJXZFBtY2ZGNDRnY3JPSXl3QzZQM1ZKUkx0cW53VFV5?=
 =?utf-8?B?dW4vL0NZUmc0WTBRdkd1RmlDbDd0M0lPellhTXhGejBYM3N5ZkUxQ1ZvalR5?=
 =?utf-8?B?SGVKYys4Vlluc3NqdVRmQ1ord2p6Q1BIdS8yMlVyR0VaVHpxRnNKRlEyWUxJ?=
 =?utf-8?B?S0NkZHlJZ0xTNFQzNVJ4TEVFaWJGbFk2dnY5aXBaOE5BWlpVUndwMDJWc2gy?=
 =?utf-8?B?VFZHWHFkb2hiUlRWbW5rRVR4bUZ5SzkvdHBXejBzdGxZem5OYXdTOEl2N1l4?=
 =?utf-8?B?OGx5c2pzb2d1NXFnKzArbkIyVGFxMkU4TVgxVWZpWGNoa0U2VEkrWnFUUm1h?=
 =?utf-8?B?bEg2ZkFQeU1vZXl1bDJ3N05ITkhURk9HN3MrNzhvajVQeE0rdEszY1llTWo4?=
 =?utf-8?B?YU5OVHF0UVE3cmNHa0JpWHJmWmNoNnY5dVNVYWxYOCs3cnFNNTRTRi9seWpt?=
 =?utf-8?B?MDJxa2w2aHNMRWhDamU3T2g1bjhkNC9jUGxqMGhWQVBpVllyZTY3UUQ5V0NN?=
 =?utf-8?B?VGNJWUsxbTJlOXhqTG1yT0laYk5ZdkQrQkJDU05uV0FPUzBoVEY5RXJ3Zkor?=
 =?utf-8?B?RU5KSk05VWtNWFRnbVgyZTY5SVRqR0tmY3o2eFNDK05IZnhxSmphekMzNDUw?=
 =?utf-8?B?Zjg2VC9oOE9kdXdzeVVRSVlzd1hZQmdHL2FTaDNwemxtNkVvWG9NK0ZnQnNZ?=
 =?utf-8?B?UkxwaDdrbGpNYXVtUmlCYm52NGtvQytOTmJWa0w0MHJxaXZRZG9PbVhNL3lT?=
 =?utf-8?B?eHlqRlNydlBLeW93T29CbUE0K3ZzL0o4djNsKzhUbkdleDlqTlYwcFk5bHpk?=
 =?utf-8?B?cUh0c1V0YnVUMm96K0JzU2xDTDZRa2dxcUpIREtvdDhITXRTTHorUDZQbW1l?=
 =?utf-8?B?YkNmc2JXNEVHVkVtOENuTzcvZ1hqNjRQalY2c29WTkwzUG50SkY2RkwzdXlL?=
 =?utf-8?B?NUtod2NtMWJYbXFmSTU4RUtuOVZsZCt0T1FZNlE3clBWelVlUDhhTUxoR1dr?=
 =?utf-8?B?LzRTWFRVRm05bjlwVGlIQitZTHNVZHlyL21qcVY1ZHhNTi9xOXc2QWt5ZVYz?=
 =?utf-8?B?anlTNlI0UWo2Q0VRRmVQQUtpU1J2QmVlSUZlM0Y2WDZpdFNVdWErbmZlOWtS?=
 =?utf-8?B?UGE0bmR2R1JEakp1ODl2b2xhSzNHYkV1QjhMNy9yMm1idTJndzhSdXpxbjVW?=
 =?utf-8?B?RDJpZ3U1RFoxZHdRTDh6TjBWMnh4MTQ0OEM1MnZyelZwZ2xSYnZ0Z0syYi9D?=
 =?utf-8?B?MjhCM0FqbExXL1IwdlBlNVNYMmRPZTRjUlZGSytKczl0bkt4T1N2bldTWjV1?=
 =?utf-8?B?ZHVGVXZFWk9rRWRlNFJWT1cvL3Vrc05JV2xLYnpIQXl3NEVIMmsvczN0L0lH?=
 =?utf-8?B?YS9ETjVDd1F4ZWVGclhLVHEvVWJzbnRDZ3lvODF2R0YrTmNuelZkc1NqcDhB?=
 =?utf-8?B?amFGQlBhK3E3a0s4bFA2alA0ZFBlaDMxMGlNYW9DRitRdnNhTzZKbk9rc1Nk?=
 =?utf-8?Q?gFLMxGBvbvWqD/EbBG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a34148-b026-4bd5-75b7-08dee1064b31
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:43:48.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BakQMJWyYuHR9CWXrSGsLWggTJfU5DOSK/ayBDLFEU9DN6iboVP1cP3NIfAkFG5Gsz/G78qQznHtv2SRpW9KsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> Drop savic_eoi() in favor of using the native helper that writes to the
> APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> level-triggered interrupts. However, it relies on APIC_TMR indicating a
> vector to be level-triggered, but APIC_TMR can never have a bit set
> since it is only updated when the LAPIC accepts a level-triggered
> interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> level-triggered interrupt sources are in the VMM (emulated IOAPIC
> primarily) and KVM accepts them on behalf of the guest resulting in the
> APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> by the guest, which has its own private APIC backing page. As such, the
> savic_eoi() handler is dead code. Remove it.
> 
> Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>

Another guest change which should be separate from this series.

Is this causing issues with this hypervisor support or is just code that
is never invoked? Do other hypervisors behave the same way and will
removing this break them?

Thanks,
Tom

> ---
>  arch/x86/kernel/apic/x2apic_savic.c | 31 +----------------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
> index cb3b55225ab6..f2af149c6005 100644
> --- a/arch/x86/kernel/apic/x2apic_savic.c
> +++ b/arch/x86/kernel/apic/x2apic_savic.c
> @@ -304,35 +304,6 @@ static void savic_update_vector(unsigned int cpu, unsigned int vector, bool set)
>  	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
>  }
>  
> -static void savic_eoi(void)
> -{
> -	unsigned int cpu;
> -	int vec;
> -
> -	cpu = raw_smp_processor_id();
> -	vec = apic_find_highest_vector(get_reg_bitmap(cpu, APIC_ISR));
> -	if (WARN_ONCE(vec == -1, "EOI write while no active interrupt in APIC_ISR"))
> -		return;
> -
> -	/* Is level-triggered interrupt? */
> -	if (apic_test_vector(vec, get_reg_bitmap(cpu, APIC_TMR))) {
> -		update_vector(cpu, APIC_ISR, vec, false);
> -		/*
> -		 * Propagate the EOI write to the hypervisor for level-triggered
> -		 * interrupts. Return to the guest from GHCB protocol event takes
> -		 * care of re-evaluating interrupt state.
> -		 */
> -		savic_ghcb_msr_write(APIC_EOI, 0);
> -	} else {
> -		/*
> -		 * Hardware clears APIC_ISR and re-evaluates the interrupt state
> -		 * to determine if there is any pending interrupt which can be
> -		 * delivered to CPU.
> -		 */
> -		native_apic_msr_eoi();
> -	}
> -}
> -
>  static void savic_teardown(void)
>  {
>  	/* Disable Secure AVIC */
> @@ -421,7 +392,7 @@ static struct apic apic_x2apic_savic __ro_after_init = {
>  
>  	.read				= savic_read,
>  	.write				= savic_write,
> -	.eoi				= savic_eoi,
> +	.eoi				= native_apic_msr_eoi,
>  	.icr_read			= native_x2apic_icr_read,
>  	.icr_write			= savic_icr_write,
>  

