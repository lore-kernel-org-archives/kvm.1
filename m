Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012057.outbound.protection.outlook.com [52.103.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F423625;
	Fri, 13 Mar 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400971; cv=fail; b=UHYea+cmDi0gM7J0KyVD00x3jkbTBmaFX4hNdwGEZ7DgoaeS+mL3HX/P/uxqQNJkyGhlYQdSMyFAXvCYft1DcV0JT1ItIrlmOjJsORfXAJPpphHXGGYwbX+tb2xXFKSDSmzI68Z71cGu02zv8HZZ0RCHedSBLEoInWwmhGjJGDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400971; c=relaxed/simple;
	bh=0KW9Jp25z44qgwFBogzdaIT+KRkeEdyoi+Q7jM3d/Bw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G6ggraE1gQBaYV998rroutb797MYZr12pPGlro8nt1eQ6eLuG+3A6JbWvqPixCqG/w0x7YVP5l53/BhtMr5uEmG52mzl8yzcA7KAHzDgSHP2vX6ryLR40xgdJegyaz9SJSFLLLXIu48yFl2NVkdDw8tqKyu0H1v9tkDqXuxaylo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AfFLfTRG; arc=fail smtp.client-ip=52.103.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AfFLfTRG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfX3R0DytZ/HDbLvBz9Y69zZsELywc6J3X5MvmYtf+6drEhAwShIiHI/2DO02sxdlopY+39K6+c6kz9j07smp7lpSOt6jQy8VY+IuELWuCg9XLUpQcKOcV+Ao7sfADn2dgyS9fg+w3w6auk5WUHLZpGF6JAOBGceJqOrNAattmts5XTyKL/P4FHWyg3WtRDANjNkx3tzwjxQix3tbccnaB5atQjIC98AaAxmsNA8wuRnnyCSpONn1KOA8ZQdEGIeLDZ6dII/BoYNYrcWcID0Cd/02ePvLdFw+niqU3NdOj8RUitBddadX5k/AIpiSYV47224H81eBIGAEfXVaK16XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCnYrDYI+82ltK4QHNad8efUggo3ef48gZ1k3T7zg14=;
 b=nR2hNYKgg65/bEgq5C2GP8LI8Kd6uHba5Fx8isqLTYV76QMLhGJwxaU4dPTYy9JXN7xIUde5Axt7xbr/kIvr4TgHBGXtZWp+eX4kfySybGabYLyluaHso6p2i96t4mgqQK+mFFTuxVgzoSDqCWgQFsLjSc3cJ6aNPflrG3Bwro2q6kXQVOQMYLyqi1Xs1trYYS699S/YSKUP2cmUWTeUuW45Luy90oW3/bUxjuHaIiCID6y3gEyIvEwKtn/J7k/DosFTR1p7Q28X011sA1k1Oj1py/8IulRVu1V9Rj1CejbVX5eIT6ghe6jcpOj3Vi+cr9DaOYn4u06UBPvVDVCRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCnYrDYI+82ltK4QHNad8efUggo3ef48gZ1k3T7zg14=;
 b=AfFLfTRGfbF3b4CPM3JcBA5lPeX77EewQC79k0jzSXmwQmYkXY99KjhXy+MKGuDZ/a3K/weIyFJsnn39P/MlE8ooqb/MPVXRIXWGmOeyqTYd90Y7B4Py8vwwRbdmisrtRkzZBDqo21I63rkTtwKgeWTW7lzYZjNLQ7hFJToPF8pmvTpWdKRc0Ar1/xFRKIWyQVHkYnNj/3oZkycjgmtLcJChBU12tI8E6rFVcZYMLwtseLBx2uEE/YMXXgPRgKX4KsZtg8fJSp7sDGdJYO1ShlxLGUR6JUIHnpM8aZj2r8IwjSAXh7wvurEpuNPNbM2kPhx0M9t9Dxwy09ckrnByVQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEYPR04MB6555.apcprd04.prod.outlook.com (2603:1096:101:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 11:22:45 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 11:22:45 +0000
Message-ID:
 <SE3PR04MB892267C1A570CF03E870BAADF345A@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 13 Mar 2026 19:22:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] RISC-V: KVM: selftests: Fix firmware counter read
 in sbi_pmu_test
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
References: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
 <20260310055557.835531-3-xujiakai2025@iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260310055557.835531-3-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <f878e7ea-d835-4a0b-a3a8-9cbf20fb450c@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEYPR04MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae74547-1c4d-4a77-2c7f-08de80f2d993
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|19110799012|12121999013|7042599007|8060799015|15080799012|5072599009|461199028|23021999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmVWb3U1RlFRRkpjVXgrNFArOTA1MkEyOEZWbkF1OFpjMUtWNTZBY0tMS2ps?=
 =?utf-8?B?TVZWVTBVNldFRVpFR2tkZjFoWU5qeThOdHpoM2QyWjdXQU1TRWVaTGtNTW5h?=
 =?utf-8?B?bG1KRmN4eHpScEFwUnpkVVVUSXhPdjZTcnh3ZExEK1ZyTkFoSVBGdGd5ZVdX?=
 =?utf-8?B?SUhjbHN1NUkyeXlFWS90clNDazd2cFlSSmljQUFydjFTTmhOb0VIZWM4WTFS?=
 =?utf-8?B?OUxaYnA1eVgzajdJZ3FacmV0RGpMVEZMUTg5NjdVSDdITHB0UFRDcGt6YTNs?=
 =?utf-8?B?ZVFvVE9KQXlzN0pSZmJiVnhyY285MmsxVmpRQ01oMVpES3hZU3BsVHVGQ3Vp?=
 =?utf-8?B?QTA0YjgzQkdVQ1Zjb0RpT0doK2hqMHRUNzI5L3pqYjF1R016VkExNy9pZXBE?=
 =?utf-8?B?QWorNjhMdDNFVHZzSkN6S3BjejRXb1pVUzM3c2hQVWgrdXhpcWN5VzROMkVk?=
 =?utf-8?B?MG5xenZlWWYrZmN5TUh1SjNYRE9seTI4RGJ4K3BZUGdhdU9FaEQ3aElwVFdU?=
 =?utf-8?B?RDB3bUpPQzd5eHB3UjJuWXJQa0E2ZGhIcXZxLzRPZURTSkxSVDF5cFY5OGZF?=
 =?utf-8?B?NVhRRGxxMGJyZm5nVERsb3JHNmllU01VOTNXZGRIZ3NUNTBxNTc5MTNNMjky?=
 =?utf-8?B?aEo4TEZaK1l0SXhrQ1Y3WjdYVXVZM1VoY3JaNm9KUkF1Mkdtam1YNjFocWJE?=
 =?utf-8?B?WXV0QlE2VXZvMTNaUVJ6eVRON1phSmN1WnJlcHdmVmJDaExFaVJ0bmVNWjJi?=
 =?utf-8?B?STh2Y1NFQmJoZWJhWlpSQVJ3Q09rcGVmWWNZWGFXQWVpcXFNeXZ2bkpHM25N?=
 =?utf-8?B?MGdNQk9mZnFhSjZLMkN5aUhrSFZQeWRvYUxYOUNQRktqYktxemZiTHNRdkp1?=
 =?utf-8?B?K1AydDc1bjJPMEFCaWZEL0ZTeGcxZUt1R3pKZGFHM0V0VTVpZ1czbVNTZ1JP?=
 =?utf-8?B?S01WR1JhZDdDV2MrSzQ1N2lEUHZYWHd4YmUvSkpUY2FIdW4wMGZiajg5cG0v?=
 =?utf-8?B?T3JhQWo4SXZ5djJRWmNGTkt4elRPVkVsRDJndlV0TWxZd3FHT3BHMVpVQXJ5?=
 =?utf-8?B?VSs3ZzltYS82QmFQYzJwWjJXNm5NL3I3OFIwVm13MmpWb3RPeDRSZGtJcnFH?=
 =?utf-8?B?Mlg1RFFicmQzMXNKdjZ5S3J6bU5qdTFGWHFsTk12ZGVwdm80N1RBUUUwVEhz?=
 =?utf-8?B?YzQ4aXpmY2pxQVlxdC9hOGNiVGhvWG5Kc0hIdnBYL2hlbWZSMGhvNFNaV0k4?=
 =?utf-8?B?QkZyT2hlOFJrZkkvcFZTUzFFTmR2aW1vY3J6aklqSHFSMStjSW5qbzZYY2hJ?=
 =?utf-8?Q?/COSIMm9/B21q0xml+FiGMZ41A56m4f41x?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZWUnRQTkFoOVVBT293WEVTOFdSMnVSenJETWpia3c1RlFObVhqdGN1MU41?=
 =?utf-8?B?QWc0ZWhFY0EzY3hWM3VhZTdScFFCSlA3V05PN2JGS1V5MEN3ckhyaWFmakJH?=
 =?utf-8?B?MC83YlRGU2lqZTZUNFFVdWRyOHZoeUxPTDhweXdWVUxna2NVMHpFNHg2R3BX?=
 =?utf-8?B?RDhPbmsvQ0JsZFFwanlHQWdIbHFuTk9yV3lZV05ESDMvZmtodkprVFJwamxs?=
 =?utf-8?B?QlRNWU42L2JLQkZQRThjeGtmaU5Jc1hsVmNpUEwyOFl1N081QUY3WEI4M2Js?=
 =?utf-8?B?cllCOVNOQzJqRitZQmd6enkyU3daZWRoL2lTTm9aODBHRFZmc1JOZ3hwOHVn?=
 =?utf-8?B?TWp0emYvY1RKSnNsVXVYYmpGQkl6ZE1yOXViVDVlSXBNaWVSeVNFd1BCSFBM?=
 =?utf-8?B?a3hteUhpR0xycnIxcksrYjBEc21jVks4OEd1U2dabGtSaU1kVWtSTG5HYUh5?=
 =?utf-8?B?NzBONkN6Q1czdVF0ODBGL1U3M0lhYlBCUjlyUWNVcnVyWDJ5RzMvZ2VWbFZH?=
 =?utf-8?B?NS9ObXBxU3RVSklWNUlvREg3ekR6cmlySWYvL3NpaVBlVEJobUlIaWI4a0lt?=
 =?utf-8?B?cjUreE83Nm5oMWUwRGpBMnBKaFl2alJjckp0NU0wSUFzR3RDQjRHOW0rQTQ2?=
 =?utf-8?B?SFZib0J0YU0yMCszMFo3MFV4Wkh0SG4xV29DVEJHTVpvb0wrOE5SUDQwcjIz?=
 =?utf-8?B?ZjF6RGJhYTZ5NWVxalByU0ovZVNzcUp3REhMMGpmNDk0d2ZqY0FjTTdQdTQr?=
 =?utf-8?B?d1k3VXkwRHR2bFZDVFFYZ01hSS9pekN5c2RrQ2g5Vmx4bTN2Wk5UT0FQWlV2?=
 =?utf-8?B?dDhkemFtdmJFWTBEVnR2L2JkdTRtQ3hHNjJyYmdwUlAxV1lJZ25xTDV5Yk1Y?=
 =?utf-8?B?V1k2dG44V0dHazhnckVGcWlyZjNLNG9tYlVBa0JuRzh2THJMMnB0aDRXekZ5?=
 =?utf-8?B?QjdRaDRsR0ZaeldWRFdNTkNaTENZMVZKVmd6UWRIcFlZUGFqT2FOdnhudDNS?=
 =?utf-8?B?RGRuUjR6bXNSV2JOWmNGYjRFNlVyTFVpaC9haS8wZnFpTXlseXFtbTZTYVFp?=
 =?utf-8?B?MEsvczR1cmF5SVlhNmFZNER2REN2OHFHUVFSTnRhWkFmRXkxM3VGVDQwcCtW?=
 =?utf-8?B?MVVFMG5oSHRKcGhURUdma1duRUdnVXJrNlhrZlNsREIyNWZRQjI3RElra0Ez?=
 =?utf-8?B?TUkwWXZXcXgvOE13c2FuKzhMNndnWXNlMmlJa1JyQzVDM3BFSnVxYkF1Z3hU?=
 =?utf-8?B?WU5YTUZ2L0gyNUs3NUZrd2k1SmZ1ckJEV2FTelRST1JVNVR6a1lBZXN1K2pX?=
 =?utf-8?B?VUNhSUdpRlVsMlVxZkFZTXo5WENWK3dGZ3FrVWtCUDNJeDBaOEc3ZW90V0o2?=
 =?utf-8?B?cG1teCtjYk9FcTQvbXZSSnlRVDlIaVpDK0U2ZHVxRGdiWVQ2emNBTmxObWxw?=
 =?utf-8?B?eERheWh4SDJ3Z3BrNmdDSG9tZlpOWnhmMEErei96ejlOQnRiUDUySE51MHpq?=
 =?utf-8?B?RFV4VmFzOFV6UDZiUmlodkRMMTdGdHpJcWdJS3hSYWk4SWR4M2FLUi9MQW1s?=
 =?utf-8?B?VHpubXV4ZStYRDNOVU5KaXJtTGZRWjFuVE9JSzJvVHlhWlpHakUwRDJLU0Vo?=
 =?utf-8?B?TGVCbHBSdHVMQ3k4YlhCNVBNejNNeDFkSEM4TkpUcytzOGR3cmhKUE5taGtY?=
 =?utf-8?B?WDNoMjloakdLdnl4Rit3N2U5OUJPdWJZSzBnQVVMLzBNbS81cnFzZnh3SlFt?=
 =?utf-8?B?eUhzZlBWUFRNN3RtK2t1S1FXNEJzYzJ3OVJ1SUJ5ZWJkM3ZZZGIzejE5UzJw?=
 =?utf-8?B?TUxvRXNqSWRmNS91OC9hTWh6M1dqbElJODFOSGNJZVlWaU9hL3YzZVBRdmtE?=
 =?utf-8?Q?7giV5wxXQloGD?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae74547-1c4d-4a77-2c7f-08de80f2d993
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:22:45.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6555


On 3/10/2026 1:55 PM, Jiakai Xu wrote:
> The current sbi_pmu_test attempts to read firmware counters without
> configuring them first with SBI_EXT_PMU_COUNTER_CFG_MATCH.
>
> Previously this did not fail because KVM incorrectly allowed the read
> and accessed fw_event[] with an out-of-bounds index when the counter
> was unconfigured. After fixing that bug, the read now correctly returns
> SBI_ERR_INVALID_PARAM, causing the selftest to fail.
>
> Update the test to configure a firmware event before reading the
> counter. Also add a negative test to ensure that attempting to read an
> unconfigured firmware counter fails gracefully.
>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> ---
> V2 -> V3:
> - Removed unnecessary BIT(ret.value) & counter_mask_available check.
> - Asserted ret.value == i after successful CFG_MATCH.
> - Fixed eidx construction in SBI_EXT_PMU_COUNTER_CFG_MATCH.
> ---
>   .../testing/selftests/kvm/include/riscv/sbi.h | 37 +++++++++++++++++++
>   .../selftests/kvm/riscv/sbi_pmu_test.c        | 20 +++++++++-
>   2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> index 046b432ae896..16f1815ac48f 100644
> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -97,6 +97,43 @@ enum sbi_pmu_hw_generic_events_t {
>   	SBI_PMU_HW_GENERAL_MAX,
>   };
>   
> +enum sbi_pmu_fw_generic_events_t {
> +	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
> +	SBI_PMU_FW_MISALIGNED_STORE	= 1,
> +	SBI_PMU_FW_ACCESS_LOAD		= 2,
> +	SBI_PMU_FW_ACCESS_STORE		= 3,
> +	SBI_PMU_FW_ILLEGAL_INSN		= 4,
> +	SBI_PMU_FW_SET_TIMER		= 5,
> +	SBI_PMU_FW_IPI_SENT		= 6,
> +	SBI_PMU_FW_IPI_RCVD		= 7,
> +	SBI_PMU_FW_FENCE_I_SENT		= 8,
> +	SBI_PMU_FW_FENCE_I_RCVD		= 9,
> +	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
> +	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
> +	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
> +	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
> +
> +	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
> +	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
> +	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
> +	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
> +
> +	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
> +	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
> +	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
> +	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
> +	SBI_PMU_FW_MAX,
> +};
> +
> +/* SBI PMU event types */
> +enum sbi_pmu_event_type {
> +	SBI_PMU_EVENT_TYPE_HW = 0x0,
> +	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
> +	SBI_PMU_EVENT_TYPE_RAW = 0x2,
> +	SBI_PMU_EVENT_TYPE_RAW_V2 = 0x3,
> +	SBI_PMU_EVENT_TYPE_FW = 0xf,
> +};
> +
>   /* SBI PMU counter types */
>   enum sbi_pmu_ctr_type {
>   	SBI_PMU_CTR_TYPE_HW = 0x0,
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 924a335d2262..9404577e4ad5 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -436,6 +436,7 @@ static void test_pmu_basic_sanity(void)
>   	struct sbiret ret;
>   	int num_counters = 0, i;
>   	union sbi_pmu_ctr_info ctrinfo;
> +	unsigned long fw_eidx;
>   
>   	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
>   	GUEST_ASSERT(probe && out_val == 1);
> @@ -461,7 +462,24 @@ static void test_pmu_basic_sanity(void)
>   			pmu_csr_read_num(ctrinfo.csr);
>   			GUEST_ASSERT(illegal_handler_invoked);
>   		} else if (ctrinfo.type == SBI_PMU_CTR_TYPE_FW) {
> -			read_fw_counter(i, ctrinfo);
> +			/* Read without configure should fail */
> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
> +					i, 0, 0, 0, 0, 0);
> +			GUEST_ASSERT(ret.error == SBI_ERR_INVALID_PARAM);
> +
> +			/*
> +			 * Try to configure with a common firmware event.
> +			 * If configuration succeeds, verify we can read it.
> +			 */
> +			fw_eidx = ((unsigned long)SBI_PMU_EVENT_TYPE_FW << 16) |
> +					  SBI_PMU_FW_ACCESS_LOAD;
Nit: Also need to align with previous line ?

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +
> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +					i, 1, 0, fw_eidx, 0, 0);
> +			if (ret.error == 0) {
> +				GUEST_ASSERT(ret.value == i);
> +				read_fw_counter(i, ctrinfo);
> +			}
>   		}
>   	}
>   
