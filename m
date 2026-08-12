Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013082.outbound.protection.outlook.com [52.103.43.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986DC2C08CF;
	Wed, 12 Aug 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537385; cv=fail; b=aZWgCIFA1+z1UT3RGDL444F4vRG/cfbMBEsW1zQBQZVDStjvaFLpuJObNz/fNgjOna/8fsn1BnOziX4aqXNFE0ct6ajs7cVtXsb8aa3/ClQMNGT/85Bp8dtPoWql+bb2aMVgqXrU0npJJ1m372qTmS7ByQH0Fs+3SQMCMgcDcLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537385; c=relaxed/simple;
	bh=aTAVkHaxAGXFivMaycOAabXG4mYJ5z5H4p1mNStV45U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r/M7wVzySLeP8ETNMOgSEkeFo8TIMeSGM9iKGEe/Gv63fzB8kxFxUte6dtyC3yGmR+/4JoQeU4GB9W119cO/sFmPdZXc+Unj/RagGsK5R1tkmlfoT0qf9Vvy3gnSs+r73jPi/Rjxxo+Cl/Ds0AG62GgOjMJuInnQwb0PDlrmsHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JH20ttMq; arc=fail smtp.client-ip=52.103.43.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JH20ttMq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHGZdngpGU9fxPwiPKDIexg4fcCDBgHXAE637wvnu0MOHdFxVEzMp6nK7xYjxPYvXv7jZBEjr5+AakXy0EKb6LwlLNsIxGCxgqno5537JrNXCTQi6QA03P2bm06IoVrcQCf1GdDpTZ5JMF+UcgiWDamt9M/6JVsybZQ4uWYodBGwaFiEJUV+iIr6bq5NdEUlP10It0TaPlSluMmlb16OBKH8ggrAYoyBynqbz+UEjaM6GDmTAsazw7PAVGPjo1dlP8AoJD+rrsHSdUfPaKG/S3pdQGZdH7uuJvQFhk/nCeOkX0OBtmMVI9GJTo11XLmnlRODeJlDfO1BaT7A5wu7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i86GRI0411of84NhW3F7VKaGZyhtrF/Opm61EJR3bQY=;
 b=SXviTxQzH1CJgmokHZJoopfXCr7ZnpuQhrjmG9IUtGZ3qyiGTpUZY6jiaDmQAJXbnlGc1a7E7P8sk2b8zzHPRqRUQePHvSM0l9ZRh7SvmFwN6FPJgS7nqcGyjCfzz4hXRW6b8lTzpdvFKF2uOomgl71vOxaTk7wrmNckyHx548qjL5J2/K/E42b0Av5Z9ja5F4pLOCmTIKxJqQWEqhXBZ+usgcwtpJT+vOGk5xR+UfeblrTNpTFtffR0ed0gtUINKQPLszJuzO/seYDiZ1VwN6lPZj35a37ACbz2iAwuQyUYMFaCYWdHpvm8iDVkDBGUGIvX7RkB0S7GKCXsiqWs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i86GRI0411of84NhW3F7VKaGZyhtrF/Opm61EJR3bQY=;
 b=JH20ttMqPtclF/w9apdnt3riFY1DiKGJYDeJ05o0Net2vYsIlP8Pk2NnnmB82RVN7Fb/gN7pVdfOUBEaHghmKoNUZ3pky+3YlnV0RiT2sD4gLQfUJv2osxCwixJ/sJkX2rdmIKCoInNIZStbHVRsg4uURodroBg5n4U+oZJQm7JvE82LQuVaBsWMsCsBTB9USFYckfml8eWY8A6Bi9neZP2ie+Uup15+DhXhB/c4RFJjl7Hnja54FxvN6ufswCNX2fLB1FkGMjTLmOygCjPN9XXBzbh2/mfhJBtqO6z4rti2dw5r6Y1gPw/95KOPZ0occG6nKJnTOUSwS0xNuos3jA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEZPR04MB6477.apcprd04.prod.outlook.com (2603:1096:101:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 12:22:58 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:22:58 +0000
Message-ID:
 <SE3PR04MB8922A641FF933A0BF913E343F3DC2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 12 Aug 2026 20:22:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: selftests: Add RISC-V Sv57 page table
 indexing
To: Jinyu Tang <jinyu.tang@linux.dev>, Anup Patel <anup@brainfault.org>,
 Anup Patel <apatel@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Atish Patra <atish.patra@linux.dev>,
 Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones
 <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, Jinyu Tang <tjytimi@163.com>
References: <20260811230316.218770-1-jinyu.tang@linux.dev>
 <20260811230316.218770-3-jinyu.tang@linux.dev>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260811230316.218770-3-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <9c5a5dd0-ab15-4532-8bca-194392f60e75@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEZPR04MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 6721c541-1f47-46d8-8b33-08def86c714d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|5072599009|55001999006|25010399006|15080799012|6090799003|23021999003|4140399003|16041099003|19101099003|19110799012|8060799015|440099028|3412199025|41105399003|40105399003|53005399003|2607281247196008|26121999007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3VuWU8yc1JPZCtBYmhxUXFCd2pnWWhsMzdrUHlzdzBSZDhGNW5OVFNXSXky?=
 =?utf-8?B?MzBqWHl3YjloaWRjTjFXM3ZiWThFZGZGcWRRSVJlQmFvN1hIdGlRTmZOY0sz?=
 =?utf-8?B?djByTWRESHNid2JqZ1BZaWc4dGFjL1h3ekxrbkV3a1BwRmFpM2EzSG9JYkZ0?=
 =?utf-8?B?U1NiL1Z4eTNOTWFtUFJOcGxpWkdtd0YyQ0JuMGZUSmtHcjVwYyt5elRMNGQ3?=
 =?utf-8?B?b0JOanYwbWhrVXJsZnpBVWxlNHJJeGZpRkhxaWdoQXZkdkVMZVg0NHlZSnFC?=
 =?utf-8?B?cUlGTkh1ZEdRN2cxLzh4MEM5T3ZvNkNkU0NpMWhYYkxEcjJNYUtVcC8wQ0dZ?=
 =?utf-8?B?Wm15OXlUNDNUM2V3YUc5ay9iS0N4bk44Z2J1RkxXajlsclBrbGd3ZndHZ2JU?=
 =?utf-8?B?cDNmOXdEajBOcFVIYnNFczQ3SVQxbXg1SnpOUWpnYW1FbUlQOU1mVDlEa21E?=
 =?utf-8?B?TGhSU243NHRram9reGJnN243OHEzeXlWZWJpZnlKeUxzQVdjZGF3dW9oL3h4?=
 =?utf-8?B?dlhieUVpN0ZVR3U5RktGYkxRNjRyZ2lVWmlaZlozdlJxbEEvVThUa1hZUko0?=
 =?utf-8?B?UnpuRUVtM0w0ekI4ZmtOQWc4MVVuWTVNRXMwSTJKeFRSMTJMRTh5REM0UXph?=
 =?utf-8?B?MGhzSnBjVkN5enh1WXVTR3RjM0R5RWxaemZITUg3TlJDVDNVM1FpSGlLNGQx?=
 =?utf-8?B?OW5uaSt1UmE1UXR6dkhiSG9hN25FdTNqVTJPNWticVFpOUV3MWlXUDY5MGVW?=
 =?utf-8?B?bnlnUUtsQ05lUk5KSVJlQlBUVDRkQ1MxMVZLTzhGNGFFS3BrTFE1SkNNbXpT?=
 =?utf-8?B?ZEJYamwxYWt3VkxXUDIwNE0vTXFLaDNaakQzaytuemVkbEhvQlFIVWg5ampS?=
 =?utf-8?B?d3VSZHFoajB5WFhlNVh6ZVo4MEZOWnNGSHFaRlR5QjVQVi9VL0VnY20zM0dE?=
 =?utf-8?B?d01ndHdmT29ZbDkvT3QvU3crMzZFOWlXdnBlOGc3STU2SmhmU3RBSWpmdEtU?=
 =?utf-8?B?T1ZpWk9ob0VOcUc5WkZCeTFQT240YkluMVM3ZUpSMTIvV2xvUVV4TWNuTmhY?=
 =?utf-8?B?bTBUS0xEa2RSWHVhRmN1ZlpuRmVvR0Ira2NtalVSVVJBRGVWN0dISWhhaXVw?=
 =?utf-8?B?S0kvQTltVjZCSm9UZDZOR1VUNVJrUmQzUUVVSWpESEtiUjU3NDA0Z1VwWWRm?=
 =?utf-8?B?dUZrdGpZNEhtUHJPY29yOXNoV0llVlNQVWhFcG1TNnRWKzlkSXkrcFlKTm1Z?=
 =?utf-8?B?cjhOV2JJZjJXVThyNFpSeHA5L1AvN0RKVE4wUE50NmM2cDluS0JrdzY4L3pi?=
 =?utf-8?B?blBFeDRtWlVhc3ZVZ3NxRmhLTjVCaXlOdklnRG9RSXlueXlGb0xUclljT2Ry?=
 =?utf-8?B?REpDTWtSbkdZOFRWQ1N6SVI2UUEyMFlaMFYwU1piMGRnR0JqYUJTRTJLNDkw?=
 =?utf-8?B?TEpOWkhESEVZeGN4SWZERFJMNWUzb2xBOG04YWxXVWtqV3VjZGVSTnNEelVR?=
 =?utf-8?B?dWY1SmZXemhJKys1dHpnN3loV0ZyTktyMnRGMVJjTFNURlhFMTBMWGxIWG5M?=
 =?utf-8?B?ckVBZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlRxMzJlczVQcno4MHdxZUdKaW9RSjc1SkFTL3NMZ2JoRUhheDBxQ0hubFpw?=
 =?utf-8?B?YmJNNDN0TzlScXhES1hLWmpub29sNnZjc1JlSHdDZmUvc1FkRk9oSzNYR2Vi?=
 =?utf-8?B?NVlwNVVncWNrQTIyNjQ4ZEkxSGt4aU52T0lka0JjVkZxaTNvcDI4K1VBZlJn?=
 =?utf-8?B?cHFkZU9Ld2RuUVUrNnd6cGR4SkhmUlJwbVBzSHNURjU3M1BiTlgxamhMQS9L?=
 =?utf-8?B?djFzMTZobEVIaFAvbGRsOFo4WmNsa3F2aWpOdS8rdDg4a0JlYnFlaVRIdkRO?=
 =?utf-8?B?Sng3VDhlOGhlVllPZk5ic3l1SjE2RCtTd2g4N3RmYnVOWjkxbUZLUEJuekNr?=
 =?utf-8?B?YTZtMmF6aGppWDFNOHpoaExMcjhuRWhvL1pPUVRyK2ZiWHdQY0FqeWVIZGhR?=
 =?utf-8?B?K201SDIzcWkybXZrNHZzc2RvN2hnZjNuNDZkZXVvbUI0ZGxaZ2Y0MGYrNHQ2?=
 =?utf-8?B?R0RxMVV1RzMwSDVkYWFKdmtSWnBWOTNiUERjNEFQMUZZRXg2OTluenRVNDhK?=
 =?utf-8?B?N0p4MXhwNFI2Vmc3a05XUW9Qby94a2hBejNnUHFwVGxSWnN2VXJjNHk4VlR5?=
 =?utf-8?B?MGRaRlNidFpQRnUzUG9rY3dQM3F5d0pVN01WZnZnZFB6a3piVHBGMlNKM1lZ?=
 =?utf-8?B?UElxcnpHZUZiTEJRcUJVT0RrYkJwQkRnZ3RTbVhuYVFZY2tQYXlqTVhMZ0h2?=
 =?utf-8?B?OXN4UzJjM3hmNXFPc1R2OGlvY2JabzltYjJxV1dzZUZVS3BBa2JaUFJ3OWxF?=
 =?utf-8?B?MC9WTTIwV3RTUEtrVW9CRDdpTVVxWGRHem9iZGp1bkFVR1VCZDI5SVJUM3Ba?=
 =?utf-8?B?cnhuVlRWNVh2R0hETU1CQkhlL1Y2ampzbVBOamVnYU5qNlo1M1YvOFRBb1JE?=
 =?utf-8?B?Qk9GZ1l4WGF0OXh5N3dQUTB0b2JncGw2VTQwK2hsaWpkQXFLelRXTStycm03?=
 =?utf-8?B?TXhhVVNPYmpGaDZIanIrU2NDcUlWeHpHNUxpb2JoS2dJaUFuT1c5aks1QlpW?=
 =?utf-8?B?VDVLVm9kRllrckNFU1o0NmdSVEdhZDNCWVRkTG1lUHp0QnFCTVRyZXpsOEVS?=
 =?utf-8?B?QlJkaGFnUmFCbFgyaXV5RVl6WDU5VXlmSy9RNEMxRlk0a1YyZEkyemNmMko0?=
 =?utf-8?B?NkdLTC9IWTlIZWt2VHk0Q2c2K3BNa0trRzZOMFBRc3prdkV1dWF5VFFkQysy?=
 =?utf-8?B?VDZnNTMzRWNVUmlZdldkRWZYYUtlL1p0eHFaM29hKzlMZkRYSXdEQm1WbGVQ?=
 =?utf-8?B?eFp3ZUgxL2hVSTZ3WTM5d2ZnRDYrY2FaZXJzM0NXNUdlVkxDVHphcEdEZXVo?=
 =?utf-8?B?MmdRTzI1dytXOTB5NC9tdDEyNVptVU5KTTZvM2xKTHZFL29wUW1YVmdicnF0?=
 =?utf-8?B?KzRtT0lHOWpxa0VHZDJENmx3NkdqVXYvcE5BdDFnZEsrNXl5T2FnbHZaWStP?=
 =?utf-8?B?MlBaVmxTSnhSSVpzNVJoZS8wQ2txK09MM3hXMG1OV21vWURYSmkzWXNoWmp4?=
 =?utf-8?B?enZWQWpCTTByTzBNQ243U0JrcW1sM25oWXB3Zmh4Mjhoc3hDTGZDNjJjeFNp?=
 =?utf-8?B?S0l4b3FnT01pV004OElGZGdlY1J1QWU2emtVbDBTemxsZXJhNmFkWU9teFVV?=
 =?utf-8?B?WEtqUnIyUTlmZHphNlJIRWR3TjBKMGF4YjJGa1l5Q0d1ZGtzWCtIazh4bXUw?=
 =?utf-8?B?aGxURDZ3Q2Y4eThpdGlFUGRQUlhzRC9VQWh1Ry8rNXNCaDg5SGJEUVVPbGcz?=
 =?utf-8?B?SnkzRmhmRlkyT3BxRW1KK09ZNk9rYVZJUmloaXozU1lqbjJoL2U2Zy8vRk81?=
 =?utf-8?B?R3pQS05PSnp1R1pSdGl4eXFVWklLbW9FblJkNGlIckZ6VmhqOGpoRDJHQzhr?=
 =?utf-8?Q?pFXyautRGlpUS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6721c541-1f47-46d8-8b33-08def86c714d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:22:57.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6477


On 8/12/2026 7:03 AM, Jinyu Tang wrote:
> RISC-V selftests can create guests with five page-table levels, for
> example when the selected guest mode is Sv57. The RISC-V page-table
> walker only had index arrays for levels 0 through 3, so
> virt_arch_pg_map() indexed past the end of the arrays when level 4 was
> used.
>
> Add the missing L4 index mask and shift so selftests can build guest
> page tables for Sv57 VMs.
>
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   tools/testing/selftests/kvm/include/riscv/processor.h | 3 +++
>   tools/testing/selftests/kvm/lib/riscv/processor.c     | 2 ++
>   2 files changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index e3acf2ae9881..abde3c71c891 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -127,6 +127,9 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handl
>   
>   void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handler);
>   
> +/* L4 index Bit[56:48] */
> +#define PGTBL_L4_INDEX_MASK			0x01FF000000000000ULL
> +#define PGTBL_L4_INDEX_SHIFT			48
>   /* L3 index Bit[47:39] */
>   #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
>   #define PGTBL_L3_INDEX_SHIFT			39
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index ded5429f3448..b4d41a407553 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -43,6 +43,7 @@ static u64 pte_index_mask[] = {
>   	PGTBL_L1_INDEX_MASK,
>   	PGTBL_L2_INDEX_MASK,
>   	PGTBL_L3_INDEX_MASK,
> +	PGTBL_L4_INDEX_MASK,
>   };
>   
>   static u32 pte_index_shift[] = {
> @@ -50,6 +51,7 @@ static u32 pte_index_shift[] = {
>   	PGTBL_L1_INDEX_SHIFT,
>   	PGTBL_L2_INDEX_SHIFT,
>   	PGTBL_L3_INDEX_SHIFT,
> +	PGTBL_L4_INDEX_SHIFT,
>   };
>   
>   static u64 pte_index(struct kvm_vm *vm, gva_t gva, int level)
