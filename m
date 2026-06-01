Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012052.outbound.protection.outlook.com [52.103.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EC32ABCA;
	Mon,  1 Jun 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304001; cv=fail; b=QKQj1IhF5AxKgqLPy3Ez3pQBQQetN+3tP6alkSmlCZCn7d9xiPb8HuurRdTa6EAuhPS0VkBX28j27OqJy+Y5zubRSxxg2Hvvq0lFtMk2kukrOv48ppcbZtC0JGMMqNo1luNWLDvWWG6gZcILNM6612EutQJXl8E6uB55H1K5kII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304001; c=relaxed/simple;
	bh=f8q39IHeNr0i78vFWj6WVuwVmTt6QFNkM+pavdK+Jm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XjjREQf86YKncT17wBp8XRNVQHbupPi/4gkgTcq/jnfr7EldAK69ZHCh1/Vciu2rkfTogcqXigguXV3KS5yQ9CYGZxMDXAjtB759dLRkRAM2D4ObuUBTG97esBxOtV8kPtQINlTcgXVqzHP7IjCX8uU1EospJ/3+K7KBGoO08ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DoDRCMJW; arc=fail smtp.client-ip=52.103.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DoDRCMJW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDD5PQrLYc0CoGLuylMjJV00fm5RAidI5x7p2BCp38wONXnp2oVEB3h9RnqXDOxhWtx/oHtfNjXeelE/umzWeuiqG4IwDFqjecwX+N1m5625xKKVCgC9pukCUykrxdB/6Cjpm78o/AICOvOtu9Co53zG6miJWYKZQ/2wwPZfFMJM6oS00TU4Wbe126Miw7pmkCULpx6L/WsDI8Y37ZUc/rsS7W7bSkgS/FnOwbSfU+xkLfIPOOeJ1Ms1X29wCl5bznjw9y6ohj9LdPeoBivtQPXHJmIU+0oiT6YPqSF7v4CjYspsWQnyyL1Wl5D5nY6hvC5JnS+06GfnhZvVhnyQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaM7+xC0c/FTJQaT1ilLi8aONmJ9jAUmX5vLGajUwpU=;
 b=i2qIlFOcpbjlxRNVUTYkKCUUNn4QJpEsv05CWcsj5gN8ZB+YaM3kea81l6r5g0JSUM3ETEHsykqMrJGSqlI6aXsGxpWl0pER/VPfCGAlT4IiKsbl4wKDv4STUUWDYmKErJEb+L0AeBqEXHrQXAqitJcUh4H9nmHJKmX6naET3FuPeyNsAhO5ky81GkZvgJSzcI2yVdvp/Bp3sOndWn4cp798xHMNHo2I2R4O8uE/55XhDxtYp6MUirPhuXVqGgb8NU4XrPr3MBFxCxm2pEeLCRWbPxf9Y+EjKsM1ZKJ8Vdb8ToFVsZmceo86FE5JbkwhThG5VKdMYEB/fiYlOhP2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaM7+xC0c/FTJQaT1ilLi8aONmJ9jAUmX5vLGajUwpU=;
 b=DoDRCMJW09fZ4k5LIjf6+hMoKRwgDvXmg7BSct6rDPg3XZCOybUHBtcYqSPCQiKJeIWfgQBEqsuXy0co6iZ55qYZ3akT5vpCSSZiwTmWlRUP53apz5mu6ClkgYXj97lFaup27+5fTYxGn4BIOerZN2YphigC2Ii5iUKX41LR4fkbNtfTpfwOQe6u+S4NJPZP1QxX6uBOYShDjl90iyQItxRBR3BeNNb9TcMGvH3K+o+mJKivXLksGFOVX/NHNOYmYuAV3hvwRlG4ABU5dOqNQQoISnWN8nW59r6eGs1bYf0l69E6oF0LlRhTDSk14cLuKnppIHEes3BFnW+nFOcLmA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR0401MB6306.apcprd04.prod.outlook.com (2603:1096:820:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 08:53:11 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 08:53:11 +0000
Message-ID:
 <SE3PR04MB8922FD6348F0F4426A3E2F46F3152@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 1 Jun 2026 16:53:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: riscv: Pass the target size to huge G-stage
 checks
To: Jinyu Tang <tjytimi@163.com>, Anup Patel <apatel@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm <kvm@vger.kernel.org>, kvm-riscv <kvm-riscv@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <radim.krcmar@oss.qualcomm.com>, Andrew Jones
 <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
References: <20260520152148.131272-1-tjytimi@163.com>
 <20260520152148.131272-2-tjytimi@163.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260520152148.131272-2-tjytimi@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <68a890c8-73ac-4b33-bdd8-05708c2f6637@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR0401MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 3720c93f-d029-4add-cb53-08debfbb355d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|45011099003|41001999006|12121999013|23021999003|5072599009|15080799012|19110799012|8060799015|19061999003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDcwVHpSWHgvWWhlQ2E3akxUaHFweUZobllzZ1NJZThqMmRxRVhYN2dwMzJ2?=
 =?utf-8?B?MHlhTm5aTE96UExMTlhYdUFTblpoankwcC9lUGFmK3FlSEV0YXBVcHFOeVhu?=
 =?utf-8?B?dE0rSExqTGl1ZzRpb1lmd245alFPUUFxVFM5TFVUNXZvb240cmozb2ZRZ1d3?=
 =?utf-8?B?NWZHZWptY1RqQTBjMkltZUVWNmVoRURHeXBaOTVXNnVwVDhrWW5xRVlBY0lp?=
 =?utf-8?B?T0JrL1RraU4xNjY5czJ4VmIyYktSamZGekJGaHhhQWYraThZeDFpSDVSNnBz?=
 =?utf-8?B?S2lEZEd1SXgxUEQ3aUtjak16Rk12Mm5kMTFxNXo4ekVRdmV1eUVlOENwc3BS?=
 =?utf-8?B?bXgwb1NSbnRyR3p3ZXc4TkhyZXhSSDRXWlJTbjlVbUR4RC85a2Z6cmNtWkpw?=
 =?utf-8?B?ejZtVzcyd1drakRkOEN2RnVFdnN2TFZzLzk1cXhNSmxkZzdZQ1BaVlk4MWdm?=
 =?utf-8?B?WnhEdklpbWJ5RkVoV001T3JjRjhuNmlucGNlRWZaTFRxT2xpTnJiUUs5UG4w?=
 =?utf-8?B?UC9hYzk1WU1zbXc1N2xJTy8rWit4a1puMTB1NkRjemhZdHltYi9hajkyVGNz?=
 =?utf-8?B?ZXYvRFRIU21aZFJ3UjlvYS9VQ1FuVnVTRU5yU1R4NlY4UjIvNm1XUEsvdEVp?=
 =?utf-8?B?N01VUmZWT3RMUzFBZytvL0wwTGVYTnBCU3o1dDZLWnRNekhRRkg3VVNPWmdk?=
 =?utf-8?B?RVJjRk9oWUYrL3hQUDBmRXZpWE9VdDNXQWJ6THM0ZloyTGhDMlJFSnBTMnFE?=
 =?utf-8?B?cWtmNWtLcmpZNFUzM0xmTjdONHprTW9COWM5L1VlVUNPYmFoRDA5NGYyY1I4?=
 =?utf-8?B?Y1NFL3JjUlhmOXU1cVZKVDdoNzRCQm1VamYzeUxPK3RTUkwxMWFLMGRzemow?=
 =?utf-8?B?TWw3OWlaRHJvSzVDWU5FOGlOak1nZ3BVODIxaWhjMzJ2Y29HQTlMNEs4eWhr?=
 =?utf-8?B?RnYzb2hEZGdNaE1YWXdMWERUWE9pS3lPWTR3eEFWRFZWaGZTOEI3VkV5SzZL?=
 =?utf-8?B?T3NSWHhTclI1RDYvV2M1dGN4VVVoRFh0Rk1DMTd6bW5JUkJxdHlIQVp0NGdh?=
 =?utf-8?B?bFlsTjZRM3dxVHQ3cGdlaU9RaHhBU1psaXlVTytEbXlGUFJhYmw0NXRaN21Q?=
 =?utf-8?B?blhLSEZ2YTNVcjRrYng3RFAxUE9ZRmswU3VVQlhyMndnWmFRTFBIOTBJRy85?=
 =?utf-8?B?YS8zWXJiUjR2cHRJQ2lMYVVLc1NBVFdLVHhPQVhMOFVoWHhEYTRVa1VRdUFs?=
 =?utf-8?B?cHZhVURnby96V05iZWxkbEUxQnluNi80UUdxWTVIaHJLb0F2MnoyWkxSVTl0?=
 =?utf-8?B?akdmQXRXK1dSeHpyc25vbldrdEFWZTZRNm41MGRiZ3BJWFZtSFBIN2wzZ29H?=
 =?utf-8?B?UkxkZmNPMHg3VHNUdzVHTkxONWhGbk41amdndERSemVsQkVtSnN0NTZxRlpk?=
 =?utf-8?Q?65W1aehA?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG1rZ0tPWE5FZU9FWkkyNXVIM3Y3VE1MWjJJNXlISmtpcGhBYjgzb0N6UmJV?=
 =?utf-8?B?OVBGMU5aL2VhK3VuSE1vdGhGVkxrMUQ3UjVBdFJEN3hZT2NtRmFNWVFRUjFW?=
 =?utf-8?B?UGRWMTN0UWdDcmd0bnI5T1ZxU0RndnNiclFpTGRHNWp3MkdXY2Q4RFROVnhj?=
 =?utf-8?B?c3k3QUdtajlNQ1BTa3N5TEg1azNvdFJJV0tyb3pJeXZGVmFGdUpqQm54b1RS?=
 =?utf-8?B?NnAxVm0wSkJmbmJNWW9OQlJEWFZnelJCQmpQckhTS29nU1BjR211Z01GWWFB?=
 =?utf-8?B?czNVcFV5Z1FqckZ6NzdRWmhPeXdvUVlVbmU2cklyV0V4amZzNUZOOHJvZHRa?=
 =?utf-8?B?V0k3clo5dEliZjBXQ01XOXZORTlUaVhRM2c2V2VmczZ4TFJJOVNUWm9wcHNt?=
 =?utf-8?B?dE1KNXZ0eHFQUThTWSt1MCtQd240U1BzU0NXeXRZWHNsUWVlRFh3V1UzcFVp?=
 =?utf-8?B?dGY5SWp4Y0JkWHJyVWhXNDVyT05nVHBoR212eWtIZDhtckt6ZjJXNENKc2lr?=
 =?utf-8?B?UFdCTXZzYXgzWmh0ZmpmOXZkOEplUnQ1SGRGa1dhajhBTWhQcTRpazl1aDZL?=
 =?utf-8?B?K1hZVE5xTEZOUGZ3eUdzbUxzSkZkM2V3Z0VKZFdNdjZybkxlZkt3Q1pRc0J5?=
 =?utf-8?B?WkVGSG9IOUhmL0x6MEovc2w3SzkyYWsvNmgxT1lSQjEwUXQ0SjZnOEd2Tzky?=
 =?utf-8?B?QVFFL3ptRnczUFZaMmdadHlJM09HOTk3QXdndGpWaVJibFN1Tjk3azB2bWZZ?=
 =?utf-8?B?dFEyNXBhK0t4ODI5Mnc2bW5MbUxmY2ZSV1JPWEZWVU8rK0RxK1lsVmUxZGpC?=
 =?utf-8?B?dXp3NmJGMzBSYTdHWkw4d3BhbW80YXpFcGR2K294MENuUXk4NE1wamE5TWIz?=
 =?utf-8?B?bEpBeVY5ZGYwT3pXbVEraVMxTGlGWlFkZkd6ekc5S1NvMVdCYTNETFppMzdC?=
 =?utf-8?B?bmJSS3FLUTRiT2ZLKzlMTnZjS3NEN3pIWWdOcHJNUU5rSlNCeDFDMkVDYTFD?=
 =?utf-8?B?RTN5OUplbFh1VklLeXZrdlhQZE1tcy8xZmowdnNpSHJOSEZRSW5ZbjJzckVs?=
 =?utf-8?B?OEp6WUFLNDhMa3BvWTV3MXJmVGNBaHFad3JhVXp5dEdKaUEvZis0WU80Y0Z0?=
 =?utf-8?B?OU1Dbnp4SWlQbWNaM3pMS0FpQWdLY0wzVlVDYktuU0w3WW5zbExpWWNWNnhn?=
 =?utf-8?B?SWhFalVtQmJybFlpWW5MUlQvTzFIM1JkS3RpQXJwQmxCTXpPTStOMExhOUZE?=
 =?utf-8?B?bUlyRjRNV0JybGxFSitUeG1HankwMkdGMXdyb3B0VTlIbzcvOVpqcWJhY29L?=
 =?utf-8?B?R1lWL0cybWppRk9MSFV0RndDUGkrL2tOMWFMQkRFMFA3VDRqaHlhY1ZZOW1F?=
 =?utf-8?B?UGpMSTQ1YURpV2VhazRKUFJOWEo1bmx6dWVlbTBWVW5IbnhMcUcvM0U5akxP?=
 =?utf-8?B?ZnpRY1VKY2FGK1I2MWRYSlRlUndoU0d1VGVoYUl4eWlsZUVYOW1iOEJLdkhu?=
 =?utf-8?B?ajFiaFFvM0g2akVISGdmTVVDTGNIMTFGMjJLVFpxTndVN1NWdmY4MjdMdEFS?=
 =?utf-8?B?WHFnZXgyQTNQbUFxc1NZY1I3Y1ArY3Nxc2FQc0VkWFdRTGN1TG9wNUxHdHov?=
 =?utf-8?B?cEJnWHhPelJackUxaG1NaUhZalNDVzRBbUVaam5XTkhjY3laZTNkYzZmRjVw?=
 =?utf-8?B?U0RNbkd5NytOeWw4V3FYYmRpbjI2SDVrMU9JaThZV20xV3ZRbVAxOEtMYzlt?=
 =?utf-8?B?QjlFTVJNQzZGeWNXeC8wbTE4TXdTQnUydGx0WmltSEhHNitFeXFnSkZDK2Jn?=
 =?utf-8?B?V0w1dHk4UmdyN2thakJHOVdLNUpsZXlzbGQxd0RWNU9TN0xwU3RwaDRwYVA0?=
 =?utf-8?Q?RY3nYea7Fz9ey?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3720c93f-d029-4add-cb53-08debfbb355d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:53:11.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6306


On 5/20/2026 11:21 PM, Jinyu Tang wrote:
> fault_supports_gstage_huge_mapping() already contains the two checks
> needed before installing a G-stage block mapping: the userspace address
> and GPA must have matching offsets within the block, and the whole block
> must be contained within the memslot.
>
> The helper currently hard-codes PMD_SIZE because its only caller is the
> transparent hugepage path. The hugetlb path needs the same checks, but
> the target block size can be either PMD_SIZE or PUD_SIZE depending on the
> hugetlb VMA.
>
> So pass the target mapping size into the helper and use it for the
> alignment and bounds checks. This keeps the existing THP PMD behavior
> unchanged and prepares the helper to be reused for the following hugetlb
> fix.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>   arch/riscv/kvm/mmu.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024..10be8f683 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -286,7 +286,8 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   }
>   
>   static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
> -					       unsigned long hva)
> +					       unsigned long hva,
> +					       unsigned long map_size)
>   {
>   	hva_t uaddr_start, uaddr_end;
>   	gpa_t gpa_start;
> @@ -300,8 +301,8 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
>   
>   	/*
>   	 * Pages belonging to memslots that don't have the same alignment
> -	 * within a PMD for userspace and GPA cannot be mapped with g-stage
> -	 * PMD entries, because we'll end up mapping the wrong pages.
> +	 * within a huge page for userspace and GPA cannot be mapped with
> +	 * g-stage block entries, because we'll end up mapping the wrong pages.
>   	 *
>   	 * Consider a layout like the following:
>   	 *
> @@ -321,7 +322,7 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
>   	 *   e -> g
>   	 *   f -> h
>   	 */
> -	if ((gpa_start & (PMD_SIZE - 1)) != (uaddr_start & (PMD_SIZE - 1)))
> +	if ((gpa_start & (map_size - 1)) != (uaddr_start & (map_size - 1)))
>   		return false;
>   
>   	/*
> @@ -336,7 +337,8 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
>   	 * userspace_addr or the base_gfn, as both are equally aligned (per
>   	 * the check above) and equally sized.
>   	 */
> -	return (hva >= ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DOWN(uaddr_end, PMD_SIZE));
> +	return (hva & ~(map_size - 1)) >= uaddr_start &&
> +	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
Seems they are not exactly the same.
Should be like this ?

+	return (hva >= ALIGN(uaddr_start, map_size)) && (hva < ALIGN_DOWN(uaddr_end, map_size));

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>   }
>   
>   static int get_hva_mapping_size(struct kvm *kvm,
> @@ -404,7 +406,7 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
>   	 * sure that the HVA and GPA are sufficiently aligned and that the
>   	 * block map is contained within the memslot.
>   	 */
> -	if (fault_supports_gstage_huge_mapping(memslot, hva)) {
> +	if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE)) {
>   		int sz;
>   
>   		sz = get_hva_mapping_size(kvm, hva);
