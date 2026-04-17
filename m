Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013083.outbound.protection.outlook.com [52.103.43.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91D3321C1;
	Fri, 17 Apr 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408028; cv=fail; b=c/X8eHtcnXAEDqDh4T3S/t36wTrNCbi2XJP+R1i+LPUjJ+IV4dcjvBf/9g4E1LVUIprM0nE8xrcZRECGfZVD1YbL02LgVViFvLTAh/dWtsb4lKzuxHAwXz4C2tsnK6GBTrgEONF6mByfHQVABFSFcuHlYuDrviAvWC8EQqVizdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408028; c=relaxed/simple;
	bh=iuNpL/hWfE5N1YW7mhAi5dg+a2N8BRRQYStR7CACobM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HD1NlvtnzOiJlNuX1gxNJNA46TPwt9KA7gMnrAw3/3JU09FIKpTAGNUkyVmNokED4x+deVEnPoInMNQkvJ9iqas9bOu9X3om/4kI+sqfWLPsAJfuE1Rs79KosuuRVGMzqkreVr6tTQS0rCue1u3XLu7Nw4JrN6LcisWcmi1jvFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cS2IanOo; arc=fail smtp.client-ip=52.103.43.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cS2IanOo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBm3tka+luAzH1tky6f4c3S8b3+09Dyjz9B6dMC9qY7N7NePbm9XmyrTnsM8ydrVWe7YiTh63/KHmaoBl5Kd3vZH7fWvwChA1Ey717suWxuFgIZZW5YfzLchhoXXXClpeA9Nbd8MUetQAAJvllmsfxQZebdRQEJYLxOwEDWyHXg1gx50341jcP3riW8T0m+MLD/HpahyYsdj4bZ94g39xu3pcv6ab4DEJRzfGmPj73mjqDLHAfMQZbNOXoUNNlCOsbpAusGXPgL87TKiWKWPb/ZGxJ9tq4HW3zfjSSXmN55SIIl+lj6m1qFHMCl747Jqm4wXxQpdGxH7FchLvK2oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTTvM4pNNp/FVINMQDki/2ds+R8K6qmLsHyNhgZ9ooE=;
 b=q0YSSY/rVFPhUwGMSYXtKNkPlDVGQpNyOhsHaXybMPuefUSBYMWr87BSFx+tXEGY+at08npAp9zKcATETDbuQJRNGt+XsCnB6o3MFHcfne6PYjMVETqzCrANERDzvoXovXKS3cYfFJXtOJhJ3X/ujOofopahYhjENgK54gCUn5LKNddAUuKQnGyXuWiZgqCTYNdKHpTuRmkkbKFUYg3e+uiJl4LRKoRidNAfS7aTrzVw/afmtv/ofLQ1C7ohLHyGfPhGqCaR7QRdn2uwHric3PL8KFtTFVuyA8N2Zwp9DF9ynCZ4LKMYDshmVzPggVZGdK88SPNiF699L7jg2EzENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTTvM4pNNp/FVINMQDki/2ds+R8K6qmLsHyNhgZ9ooE=;
 b=cS2IanOoNrHDB2i1wOFArzmEgQBNhx5C11GYDJ2MzZZAo9VxhlnwGh7qb8qjoiYEiKKpTyYq8TsiLdoXCj4fboL6U57MCDkKGt3ugA4PXD8zNfUwxBx6UtzTtfqwhV2fEvSvaNh+wdrZ9drQEAbO6tBX10ZfElXrVvR9ELy7nxsf2c+sNztWohEK5y0IBuzzaOYrzsrtvaSYygsGEg6yb6M/8KceJSffnsfHIVPP/6zMoKMCsOPW0CfkI8wPLk462H7rup0bC2jhm7sLvEOs67CvcJVBROHGVXN3c0pX6bntEnicvcxIw9FNoKORXCSqOCW8v8LO3Q1L3QMAPj8BIw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYUPR04MB6691.apcprd04.prod.outlook.com (2603:1096:400:353::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 06:40:22 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 06:40:22 +0000
Message-ID:
 <SE3PR04MB8922199111036C3396AB7BEFF3202@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 17 Apr 2026 14:40:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix invalid HVA warning in steal-time
 recording
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
References: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <ad9a743c-92a4-49b0-b537-c4d5fbebfebc@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYUPR04MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 79480f79-983b-4fa9-d36c-08de9c4c32bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|8060799015|41001999006|19110799012|15080799012|51005399006|6090799003|461199028|5072599009|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdjTnplMTlMQUlwYnRWbnp2NTFpeGZwTUpsU2YwU1RzSXV1NWFBc2lIckFx?=
 =?utf-8?B?Y2E4NERSRmZhN24xVHFWd3BFbjVtelJjVjJSWStQQmJTSVJSa1JzVkx1ZVZL?=
 =?utf-8?B?YjAxVVFveVczRjNYanZ0THEzb0cyYVA2Nkhja2RkN3pXWWpzNFhNWmF0bzdi?=
 =?utf-8?B?Q2ltTVlkRm5VL2FaWFRvUTBGc0pkbXBNZmZsY1I2VkNuUEgwQkh2VElhNzh0?=
 =?utf-8?B?MVhMSTlqdmhqR3JnN3VLcnFPYXA0blFKM1QrMW9vS2k1L2dsVWlpaGcyS01j?=
 =?utf-8?B?MjNmUkxsZVB4NXJsbmhTbXREellST3FCQzdzajR0YVcvRzNYam50bTZjdHpB?=
 =?utf-8?B?LzZwQkRPd1R2NUw3STBqSXRleTRBOFcrVVFJSmNUa1cyTUZ3TmNSZ2pLZXVO?=
 =?utf-8?B?THFVYlpBb0FCQUxQUGhrVHFlaXloZTFDSDdidTM2SzFRV2xPSlNSelVxTTdJ?=
 =?utf-8?B?VXllZU5Sa25qelM4elBiV0pZQWNjeUlUbHBTVkRUelNxZTkyS1Q4NEZmM0Vr?=
 =?utf-8?B?VG1rU2lwbWNiZ0F1VG5uTXJZSFRwQytlL0pwNFdjTWlZUXk3NnREOFVNVTFn?=
 =?utf-8?B?cWRlWElmMXVndng4a2ZhRTVkZDlldnhEeEtlNm41aUlacWtRSUszeEI1ZWpW?=
 =?utf-8?B?S0dWaXdJcWwwek5XTDY4Y3Y3ZmhWaXlab0IyZWFOTmt5aGlvTFVqOHUrN1hT?=
 =?utf-8?B?Zi9hRVdhNkFFeGJVQXJ5NXJwaXBvYjQ0MVBSM0w2ZTN2RlVSdG1mMUFWemlW?=
 =?utf-8?B?R2g3ZWY3Z0owSjFvejB3V1VuYkMrbnVlNFpxMDQzMGxOUUFsVDVyclFlSW1Y?=
 =?utf-8?B?RTJvRDJVd25jRU83TExzbjgrU1hMU3FSaHRkTWVLSCthS3JnWll1b0w3NXIy?=
 =?utf-8?B?UGt6ME43Y1p4clRtNE9RcFhxaURwZVNPSG85aTBBdmgrYk5vOXNYaU1IeXB4?=
 =?utf-8?B?bVFVeDRkWGNCWFN5b1VqLzR0UDM5bVEyVUFWVkwvcDFRWWZTTnhvVWdkWFhj?=
 =?utf-8?B?QmJETko3VGlYeWt4a2tNYmNUek9zTi9weXFMOTNYV0prYnl0OEtneGd1K0Qx?=
 =?utf-8?B?ZTBsOEREdVdocDNQUmlaTGl1V0paTDNnZ0JPNlVrSGRwK0FQRWllaURxZkFE?=
 =?utf-8?B?TUtZdHJScCsxYktOY3FIMFNJMlVNT3RGMTJseDM3b0U4aXdSeTh1TFJBY3d6?=
 =?utf-8?B?QkluUHMvQVFSdjNGQ0JiRDVxWUtuL3JVbWhOUWpqN016RmY3dWd6c3JKVEp2?=
 =?utf-8?B?M3JpaG5NSVVlTzRaeHYvTlFlRkxXS1dyZ3dwK1ZabmN0UzQyUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUxORzg5NnhzVnJVdmhvaTFsdm9jemJvTzBtVmdzclZvVmgrM24ybVlmODIy?=
 =?utf-8?B?aWRKMGNJSW16VmZPdFN1MXAwKy9WYWNZTW1wNFlzcTFRdVZRSUZtanVJU1RQ?=
 =?utf-8?B?OEJVVFNmSFJ6a1hUYk9FOWdHRkdsRjkrVEFNRE1mSTlYUzZIekFGNjRNdnpi?=
 =?utf-8?B?VUIzTnZHZVJOUHZwVi9oVHVXK3N3VmxTS3FpUnRENGtXNE8wbFNPeWxzSkhv?=
 =?utf-8?B?eTU4SzZqTXQ5VEJjelpzWXlrOUhyZ0EzYXBDMGhvRUd0RWZDMG1rZnROWnRT?=
 =?utf-8?B?TnQvM1E4ZGxnQU8zSDM1TWFFbVJ0RGFoU3lLcUYwZGRxT2lDSFVDTDNIY2h1?=
 =?utf-8?B?UzY2U2EreW9pSGVvQWY2UUZkbHNXQ0VQbEw4OFpWVXNIREhPZm55emhJWjJj?=
 =?utf-8?B?cTRhRDVEeFF2OTJwWWlnOGhJa2tCTXVBczdrSmJzQmszL3hsMkNiMDN3dmxN?=
 =?utf-8?B?MitHU3dxanUzKytyd3pZM3p4YUh3RWozemFxTDNmMEVWRlJGWWJrMnJVVk9p?=
 =?utf-8?B?YnV4MjZtWHgvOEdjaGRuUlBIS3lyOC82NVFRSmdPNmR3QUZ4VjBCcEwvUnc1?=
 =?utf-8?B?SDY4cndSNGhSbHdIUFhsMUNTb1dTVjB0RWFkRTZ4d3pwQm1scUFRcG9rQ0Zu?=
 =?utf-8?B?R202bTBGK0R1dDhjeG9EaXJ5MERkdmFnNVBpZHlDcGptSGg2SHl6aFlYYy9B?=
 =?utf-8?B?aElQS3pGa1RFcnIwTDd0MDJHaHB0b1FIaFVGekxkeGdodklXaDhaUUtibHhH?=
 =?utf-8?B?N2FlWXJ6MlFKWldRZ2ZUQ0pLTUUrTWRNaTd1V0hQSzZ3b1ArSk5lSWp5Sm9Y?=
 =?utf-8?B?b1o3OXVMaURSWkplMjY4R3kzS0RBRWJ3dkh2WitNWThHclBtejB4RzRzbDU0?=
 =?utf-8?B?U04va2N5ZHdhdEFBTjlHTXVFeFpnY1RURWpzbGptQlV1dG4xSDJqNFh6bzlm?=
 =?utf-8?B?c1Z4MUNadzhaeW96MjR3OEs2Ump3K3pkdFRSZ3BFaHkwdzdFQ2ZBQ3k4Rklz?=
 =?utf-8?B?NEkzZlByQ1Qwbk5JZGYzUDlOVUUyTkRwaWxVVUI2TzUvejdXSUc2MW1aTHpr?=
 =?utf-8?B?RHppOUw2QkFZY2l3OVNKZS9sVEZLalZ3L2RZeVU1U3lmOVBmUVVCcWVVaTRX?=
 =?utf-8?B?aWlodHd1YktrUkxjbTdhTGNqTTZaeWZidkVZdVFWb2ZSQ2dmZit3VGt4UEt5?=
 =?utf-8?B?Wi9IRmhKaHgwYkd5SDVJNXJJeDErQzBVSmJpdEd5cVUxSVBjWWpORXhtdEow?=
 =?utf-8?B?RXZUQllRNkRwSHlJSTRSTUZCL0hCRXIwZk15Nm1uL0J1SGMwTUQ4bEE0MENW?=
 =?utf-8?B?bnY3S1RQSzVhbDIrd0J0d0RqZ0xDbEdxYTJBaTZmS1VCNjdUQzMydTNSU1lM?=
 =?utf-8?B?OU1IK1lERXdwUzFwZitZVmlITExwZFFLYzV0cG1hckxlOWtrSEswdEdTeG9M?=
 =?utf-8?B?SW5NT1IzaHA1cGpUNzBJSGRROWNBZ2svaGpVY3ZzcExtY290S2s1ZCttOVAz?=
 =?utf-8?B?WndUTWRHRjM0ZmxTNHRzVVJWMTBCSGR4OHRXZGFBdUplNlI4MnBSd3hJUVVT?=
 =?utf-8?B?NVhkQlJpYXNCbzBIWEdWclVDWW9oQklIV3FacXRnalVyN0R0WUM5S0dVL2ky?=
 =?utf-8?B?SU9oN3g3dlo1THRLYXc2cFpHa2hsL0lkYUVTbGhqVjJuMDVXWHdwRndLS1dU?=
 =?utf-8?B?eThOK1dOb0M3KzlTcjNSdkt6dzZXcGQ5Zm40RWxncVd3VmFPYWw0VVNNd05O?=
 =?utf-8?B?cEZMdGFNeXd0NlRRbW15R2VGYVJDZTVvcXhtRnE0ZTBvWGtudHhQZ3c4K3E5?=
 =?utf-8?B?UGs2bUhTWTREK0Y1Q1FndlN3NG5QUCtoWEd2NHFMR2ZWeXE4cmQ4eU9Vdjlu?=
 =?utf-8?Q?p4CjIosUMU5eD?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 79480f79-983b-4fa9-d36c-08de9c4c32bb
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 06:40:22.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6691


On 4/15/2026 3:52 PM, Jiakai Xu wrote:
> kvm_riscv_vcpu_record_steal_time() assumes that the steal-time shared
> memory GPA (vcpu->arch.sta.shmem) is always backed by a valid guest
> memory slot. However, this assumption is not guaranteed by the KVM
> userspace ABI.
>
> A malicious or buggy userspace can set the STA shared memory GPA via
> KVM_SET_ONE_REG without establishing a corresponding memory region via
> KVM_SET_USER_MEMORY_REGION. In such cases, the GPA cannot be translated
> to a valid HVA and kvm_vcpu_gfn_to_hva() returns an error address.
>
> The current implementation incorrectly treats this as a kernel warning
> using WARN_ON(), which may escalate to a kernel panic when panic_on_warn
> is enabled.
>
> This is not a kernel bug condition but a normal invalid configuration
> from userspace, and should be handled gracefully.
>
> Fix it by removing WARN_ON() and treating invalid HVA as a normal
> failure case, resetting the STA shared memory state.
>
> Fixes: e9f12b5fff8ad0 ("RISC-V: KVM: Implement SBI STA extension")
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Assisted-by: OpenClaw:DeepSeek-V3.2
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/kvm/vcpu_sbi_sta.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> index 3b834709b429f..60e50296a0085 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -46,7 +46,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>   	gfn = shmem >> PAGE_SHIFT;
>   	hva = kvm_vcpu_gfn_to_hva(vcpu, gfn);
>   
> -	if (WARN_ON(kvm_is_error_hva(hva))) {
> +	if (kvm_is_error_hva(hva)) {
>   		vcpu->arch.sta.shmem = INVALID_GPA;
>   		return;
>   	}
