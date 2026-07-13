Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8B34CFCA;
	Mon, 13 Jul 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965597; cv=fail; b=nO1uW2ztDlV3bBgmknHre/DPym8afTSe5iRF8DtTBhEZyqIyYij8Ns2mF5WhzTpYCtgYH9RRgzM3B4DEM0v9Rppc2Q5fL0RW7SX1lnsl8uCNIBIyS8wn8OZ/fU+Os53WMyHKgNki/ieq8QVXTZR/IiTXh/2gwQn9ZuSuvIbV3zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965597; c=relaxed/simple;
	bh=0QkltrxJuR37qpOwPPRVcSbBAQILrPJGMMeZihVqm8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9ObHdhAlq1DJxaJUpaPw7c7LulwQWZkVOl+q12O8btNiu2OOd/27Ie9HgQi2ZrFQctJaROGh++ANgTT1Gkxl45/CiznypN8S+E/w0ymbciMlRxj/UgW4mGNeR56soFs498E/matAlLci6oADfl+6sIDpaMbvtwjFX6OIQ69l7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xr0TZz5u; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xr0TZz5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APv8eoYMyyqjY9xn4tDlfjANca6vntvf6ZeZaWkM1M3k5stImJTdCWPMf7A4xUa2NhKw7F8dxAbEVKjEadUSrYzC1Vglsg5leedYGQGX8IuApjuIqyY0CgzqBm52nxIPzFAgl/wtasW+TVvIJtZsNTfJBITv/3QW+IvnRkObRw9lsJ3XYVNjtvlppHtDsU6BWyN6ke1ErZ3Zz3HWSsPuWtx4T4i/gLVzzVs0lLpsX2JqC1YfBmk29DYTTu/hXKObm+iO2eJXPNw5AOM3/61lp4fsklB+HU4pXpM2Bzv4U7jlliEbKgMphC7TWkJW2dOpMBi7Al9rb2y9xmhB+Zf6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcCpBBOozz125FodZM/9E1Z1/eP7VloLjX/y6CMrqj8=;
 b=Kcj0fi7EbLObuIhVqnGN/oIJ+lD9NQ1dT8n6dImbEV6UpKIqxAijfL6NET6eGoD9WCeMOPWRi94eQHv9HJpU3rZYE/Kpq3LdkzOrnBtSf6DKxaGXFxR+HPyQlwRAWXmPZ8fTge0Gj+r5P4ce9c0TrtajboGMa0cefQ4eSRRl1X3TpSMykxCZlnL5YrPdKrX84xzL8VJL0N0Hxni2NSf6gYx3s73/hIBA3i2VN2L5vaHJ5tQNViCmhLoTp9OJ62F1cpkYcN8Joc1H8zlicOdzeIUKQJqjDADv4ziR01NepCk9ULRvQ7xtma8VFheCVRoIUG8o77p38Vq29c+MV8Ty8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcCpBBOozz125FodZM/9E1Z1/eP7VloLjX/y6CMrqj8=;
 b=Xr0TZz5uYnU4v2tpS2xDut8ZRakpz6urq01wM/Iw3SwcrVEwx4bRxjj/fy2ezg1/g10FOlbR1NRhImBDiZELg/k34rHXKz+jwZnr9/bgeHevJkqoJSGi1/DiIeMsTXI980DQ37mLDD7R7ZqwOyMRNN48H1mQ1oF3fyJfBRFjcSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 17:59:52 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:59:52 +0000
Message-ID: <29a8e63c-d317-4717-ace2-9471e9866eb2@amd.com>
Date: Mon, 13 Jul 2026 12:59:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/27] x86/apic: Use AVIC_INCOMPLETE_IPI VMGEXIT
 for Secure AVIC IPI handling
To: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
 <97a8081fb548567f004f31e2afb02bd06d7a9982.1783490022.git.naveen@kernel.org>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <97a8081fb548567f004f31e2afb02bd06d7a9982.1783490022.git.naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:806:121::17) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a617306-1426-4aae-324a-08dee10889b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M6/3QkRc9QGAZHSxgkgxM/qn4755h5FOp3cl2Mrhkca6OWM+0MFVoC1/+I0W1XYX7i2gDyeBHV1oP89LYTkMkz0RzTVKqqSeAMf5N9IWxH3nWfbheTxqb6XNUycjRNoRZGYnWYC0NhdqKgAPt8o/nRDwmJQ96t/1tnuBFQEGEtw8iaZPYFBFAUUnqfHTbpgK54ZCGLPoIEYuSpHNepnvW2Az7qsqpIsSbNL2fYtPM0Z2OlMv7gK/pbYBLi/Be+ugg2BoxmhoA/5HPlzFNsramr7SC4edrHoWBTtJqV7VmfBMuLISLy5WCeVjBc/woGNnXaaJvlL1JEgERekUGClAcRVMshuCfuvAQdY6Z31we1N4EuUTYQSbYjtCln+NlCInw2wXIMyg4f4xrl4ixrlsZZBjxDczrsl8gD8xbhkf2dTj4MZdyQUvFkvbm2TUd9wuh08ajcH+HgSBBETSnFt922dpANOGdId4S+j3TfhaOZmhiuib1Ww8qK55gLXgAlj/VUxgCE3gmwDqrQyqkw3lL3DPtlVv4gOCnY8uaX63sTmCuiLnFAqhAd+6gxJBWKnDf/mO1N7IA83xYRV2MK9XzjXeJ7G+ti/ab3v2Tq+HutJlSiXq1kK6yiZXkQoP0a1tP1Ye5FEsxqlIUiE/6JiAQZAAPQkllE+HlXoJv/9wS9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzNJWTNCWFIrbFhadndXSnAvclRDSlVtY1VMNFAweXNUK1VUaUY1L2xOcEtm?=
 =?utf-8?B?RnlQSFMycDhTTHdGV3BvNnlrYjlZNGU5WUQvUmRtTnFrQkhIWlBINTNyU2N6?=
 =?utf-8?B?WmROdldKUHlNM3lqWFpjUjlpMldxbWE4ODFacFhtQldUajlLWGNiSU95d1hT?=
 =?utf-8?B?dFlPZ3VQbmhlSUtPWlVsekZ4U0xZYk5aWXBZZTl1UnRBYXFhNnI2MFRqbmNJ?=
 =?utf-8?B?MjJwWHdEckIwZCt4WmJNWDdRWEFSeVJyYmd4aGJPM1NUb2p5QTJsd0dYSmkr?=
 =?utf-8?B?Z2dNaHZwREUzRk91ZTNoQXkwbXhhYzVpcjVTZ1hvSFIzN3R3Y2tjMVM0azlJ?=
 =?utf-8?B?QWZlbEJkVVIxRWZML2ppbWFHeW5vVVZSb2xnMTYyL3o1c1p0KzMxZ0swc3Fi?=
 =?utf-8?B?cCtXOWNiOHRmMlp0Q2NTSXFXK2FxeFd3Q3h3dkNTNjJaTVpZckVmTWk2SmZK?=
 =?utf-8?B?QWRNNGxKbVhGVmNtYkx6d2JvK05oSmhtZEdpVjRaYnRmeHUzQlV1U1Rrayt4?=
 =?utf-8?B?QjcvSEpyTjZkMllGNHpZcjBHN1dzZE1NNDNySzk4cVJWbHR2VUpLOHhHc0dy?=
 =?utf-8?B?aFZldnNtS2srNmN1bC9tSzE5c0lXMjRaTVQvY0JiRHNBZTllTnF1bmN1eVUz?=
 =?utf-8?B?Y0lMVi9RVUo3ZENzd1cwV2FTWnNremdQTERZSHlCclEvanhHdUZnRGlrTDlY?=
 =?utf-8?B?akdnQ0o4aUhDTGlFMGFqcFpmMkZDeTFreXpXMWtQalBERVR2ZnNZLzVkSWpu?=
 =?utf-8?B?dkM4dlVuUEJRbW1oVU1VaU1KNm1QU01LOG1pS1ZEZG1Sbk43aUY0QUV4aHpq?=
 =?utf-8?B?aGg1WU5PMlVTY1dBV01DUiszcElsNW55c2w2OEY3aUVUSkZKSzAvekdjZ2Va?=
 =?utf-8?B?Z0JkUDFxK2Z3alRLMnJKM2lJeXp4SGR4TXpQNDE5Z2FIdHcvWlF4dGVIaC9S?=
 =?utf-8?B?WnRleURud2tEOVdROExNNHpIOW5RWWs3cjZKMllvRTl3NnBsdnlDcU1XVmRU?=
 =?utf-8?B?MXhQVzhOWmRFVG9HSS9TbzBnc1A3T0Y5aUEyT3dpVWZZd3J3TGtsckZ3bnZw?=
 =?utf-8?B?MHhrYnV5T3hQalZWSG4vUlJ4YlJobFdXRGN6cHBRWm51cHpGU2dtc0ZiYmlB?=
 =?utf-8?B?SGE0Si9OUWswRDVoWGhLVW5zaGh5WjRWZzdsNTVZK1hpbExSdU54a3Z6Zi91?=
 =?utf-8?B?bzhzNnJMQVYrbHlDMElRTDQxY1NRWUluMFJEcEZ4QUF5RUZ0dFpYSlNMakRL?=
 =?utf-8?B?Q1Mzb0IzazVGU1VLems4MTIyYlNvbW9BT0xvSHdXaWNnU0NmTHp0eTlJREd1?=
 =?utf-8?B?b20wSGlLY0JqS1VON1ZleERiTTd3UUlNNjQ0SDhLUnFhZW9yMUdtZC9KTVVP?=
 =?utf-8?B?RUZJcEJ1VkpOT0FQTnRURjRWejlkUmJKZE9XZjlBOERzL3doUG5TNGZmMTBB?=
 =?utf-8?B?eWVtZm9qaWc5ZEJ1Vk1tS0tmZnBhUnpBWVhWa290WVY3c2NYWXlmbGpsampG?=
 =?utf-8?B?azhYNXdGR1ViZ1FrbHArNFBJcUZrazJidGU1VUlSV0tvM0prSElsSDF5V0kr?=
 =?utf-8?B?eWF0bVZ5TE9lelRKNG9yVFlXNnBydHp0SkFiZXRDcGcva1hQZHM5OFM4VnZG?=
 =?utf-8?B?SU05Vm45MGxZUEdqUlcyZ3RZdk1sY0RMZjQvTWtNSm0vMFg3aDdOQ3hKTEx3?=
 =?utf-8?B?K1VIdnU2Ny9FdWxXejk4L0YvbU9qOFZNRStxSFhvTmU0L3RCaUd2WWZ5SmlR?=
 =?utf-8?B?aDNPL0Jhdlo3MjNVUS8vVVZjU3k0MWtsREh0cmdjQ3NGSE1zRUlGa3RVa3ho?=
 =?utf-8?B?N1J0a3plT1Z3WHRtb3o4UnN2MGlvR084ajRkcFVvQVExRWcraEcyVkVQc1p2?=
 =?utf-8?B?RmlPdGt6bDJ3NUtiTi9jZmczSzJhMkNybFlBTUMwWEdaL0dhM2NKdlRLT3dH?=
 =?utf-8?B?Y1NtYmR5Z1dCZmtOZUhqcnRHTWZkeFRkcFV4Snd2SndFYVZUdUwrcTlIYnAr?=
 =?utf-8?B?MlRLQjBZQkd5ZnpSZmIxR21MU25TZ2JtbWNta2dxakRhNVE3MUlMYk1JZEgz?=
 =?utf-8?B?bGkxdjhXb0d0QTRQVXgvSFZpTjdrMHBva0lGL1ZoZFovc0d0d1QwcWFTc0xn?=
 =?utf-8?B?dys1amRjTXVGU0c4cC91RzRkU1dubGpESjlLcmMyaFQ0YmczL3ZVd1Q4K2c0?=
 =?utf-8?B?L0MxbmJQL2N4ZTBiVUhlSkZQbUx6ak9yOVJFTisxc1FrL0lwRThSL3lhMWxH?=
 =?utf-8?B?NnJMTXp0RXI5N0tKZG1XSmdod0FwVE5CL2Zudm9TQkkzYUFIQjJCLytWTHlI?=
 =?utf-8?Q?RY2JXj038k62k31nQs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a617306-1426-4aae-324a-08dee10889b6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:59:52.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlWSENmFKWxADT5xxYod6O302n+nw5suI7TjcSzqxcvFfNjisCCvtZUUS0ZccPx08NtbXz38L60/l5HELpO13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> x2apic_savic driver currently uses SVM_EXIT_MSR to have the hypervisor
> emulate ICR writes and to be able to deliver IPIs. However, the driver
> also sets APIC_IRR in the APIC backing page of the target vCPU, so the
> expectation is only for the hypervisor to notify/wake up the target
> vCPU.
> 
> This is incorrect since SVM_EXIT_MSR is for requesting full emulation of
> a certain MSR access -- and hypervisors expect to be able to _inject_
> (set APIC_IRR) *and* deliver the interrupt to the target. This can
> result in duplicate interrupts at the guest (assuming the guest is
> allowing that vector to be injected by the hypervisor).
> 
> Instead, have the driver do AVIC_INCOMPLETE_IPI exit so that it is clear
> on what the hypervisor needs to do. This is the same exit used by SVM
> AVIC when it has already set APIC_IRR in the target vCPU APIC backing
> page to request the hypervisor to send an AVIC doorbell/wake up the
> target vCPU. Add the newly added exit ID AVIC_IPI_FAILURE_UNACCELERATED
> (ID number 5) and use the same to signal that this is a Secure AVIC
> access that is not accelerated by hardware.

Except that the GHCB specification doesn't have this support, so you can't
really do this. And if you want it to be part of the GHCB spec it will
need to be a new feature bit at this point so that the guest knows that
the hypervisor can support this new exit code.

With the current guest code, can't the hypervisor support know that for
Secure AVIC it only needs to schedule the vCPU since it is assumed the
guest updated the target backing page?

Thanks,
Tom

> 
> Fixes: 2c6978ea1a85 ("x86/apic: Add support to send IPI for Secure AVIC")
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> ---
>  arch/x86/include/asm/svm.h |  1 +
>  arch/x86/coco/sev/core.c   | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index aa63431ba92c..42ececa8963d 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -284,6 +284,7 @@ enum avic_ipi_failure_cause {
>  	AVIC_IPI_FAILURE_INVALID_TARGET,
>  	AVIC_IPI_FAILURE_INVALID_BACKING_PAGE,
>  	AVIC_IPI_FAILURE_INVALID_IPI_VECTOR,
> +	AVIC_IPI_FAILURE_UNACCELERATED,
>  };
>  
>  #define AVIC_PHYSICAL_MAX_INDEX_MASK	GENMASK_ULL(11, 0)
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 7ed3da998489..69c75ea543a3 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1014,13 +1014,29 @@ void savic_ghcb_msr_write(u32 reg, u64 value)
>  	struct ghcb_state state;
>  	enum es_result res;
>  	struct ghcb *ghcb;
> +	u64 exit_info_2;
>  
>  	guard(irqsave)();
>  
>  	ghcb = __sev_get_ghcb(&state);
>  	vc_ghcb_invalidate(ghcb);
>  
> -	res = __vc_handle_msr(ghcb, &ctxt, true);
> +	if (reg == APIC_ICR) {
> +		/*
> +		 * Exit with AVIC_INCOMPLETE_IPI to request hypervisor to notify
> +		 * the target vCPU(s). exit_info_1 is just the ICR value.
> +		 * exit_info_2 encodes exit id in the upper 32-bits, and icrh
> +		 * (IPI dest, since Secure AVIC is x2APIC-only) in the lower 32-bits.
> +		 */
> +		exit_info_2 = (u64)(AVIC_IPI_FAILURE_UNACCELERATED) << 32;
> +		exit_info_2 |= upper_32_bits(value);
> +
> +		res = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_EXIT_AVIC_INCOMPLETE_IPI,
> +					  value, exit_info_2);
> +	} else {
> +		res = __vc_handle_msr(ghcb, &ctxt, true);
> +	}
> +
>  	if (res != ES_OK) {
>  		pr_err("Secure AVIC MSR (0x%llx) write returned error (%d)\n", msr, res);
>  		/* MSR writes should never fail. Any failure is fatal error for SNP guest */

