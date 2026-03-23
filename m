Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013085.outbound.protection.outlook.com [52.103.43.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DC3112B2;
	Mon, 23 Mar 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255684; cv=fail; b=d4afwCLG2IPWQaktekU4qdBc86KJgLexUCKoHzLhVhFVt11TKh2548I40pc8TK/Pip6LCax9gdAeeKbR4uc4KHJYFSJJT2PbCI+pFlSse8gkyBvOIUmrH1mMxch9fq1Jmm1G1Hzes1IhQzIX+dPoZZgDVBFitbYi+8j9g6xGuVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255684; c=relaxed/simple;
	bh=7k49qHx0xK57RSTahqvjP/GfLt89doBkEDGpLF8326I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iEfiavttWxMpJnF5j+F2RamnKAvj2z0PXouH3eqllZA8yXKZGiLEycQCccdEw7aJdubnvcwHNC+stqCbQZGn1OoXf7ZnhqBV+1eASnc2cj9bJxFan+L28+oUS8f+L38GVtytAEsJ+vCfCZSXJJseTZzh9paoaQxo/xrsfV7hHpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=hZAxQOv0; arc=fail smtp.client-ip=52.103.43.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="hZAxQOv0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHQRnK1S45EFaBId5sEATyABizwd4Zx9xm0W/31Fh+q/SE3aQ07wMubUh/hE8ciBDSHLfySBapXRrk5MnEEdPoVobL7jbQKuuEgdVIApNx7pTbXXJ3l2FZKG5xT1KwIn6ldTeWdArNfBxYcyI5mCD23of7DjzOEdKz1qt3OVaneFcIhegBT9OQrwUjD7eS8L0eFGu7PuOmoQOxTYDKVGABEXYO4RM0RkPvMGzzkCRihUKhMKMo9wfAnHJybD4elLZPbtx6sj/GV/1CWfYJzRt/4dzmKg+ENzyKjDyl8eRw1Sl/MwqsR2O+D6fhayT6/IYo1e/noy0RAtowUAVOwbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjjSDlFCyfFN0cVrIV23AxHPYr4vJdFAjOK8UG+DIaA=;
 b=YmraX9xGVYI9VgTLu8jYjGvswSAUTqzvpi0gr5NIG7TkxMVoQ4jki+1MBGgvhj/cPUz7YExjrz42Q9qK091FjPgfo0K8CSt42d7OlXPEv7pPIpqCkkvd0qBiZ792uyOdkPPZoQyY2ZH7HVw+tdzgKTGzJLe0eQ51WovusvPbhGKuJCvGszvyrfI5FudD/NQqu/reI9ClnEDmiAwm1ieNPGb1pWNYkk3ag0FgfxzfKPH5oWVh/WtSdlu1hi1dACaD5kDGOXH7OZrk2cOHbLYRnZV1GDhDjRO5woXu6m5Bexid7W+JljB8/uQ/MJaI4lcigdWhGLYDbkkTfmThwp7TCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjjSDlFCyfFN0cVrIV23AxHPYr4vJdFAjOK8UG+DIaA=;
 b=hZAxQOv0Iv+29p4Nv8jtmSX2IJWBOSsvGCs2xMPVtuAF/d16kHFi4FMGXuNZioaPXcOlePcDGH8Gq9DV9fAARMR4nyN4K35e0un11XUbmwN98QakRRzGjpYWZWzJ/jeCJVZpOTX8kUwg3PQHKfN7JAkp19lq8hCb+PtSCxQqIyUkjLesIpR6wSqdvd4lr7AW9AMKpOgpffKCUrtyBzXrluAv30vwLXDqaO7eG88wpPk1ls/YUa4zY7twc0SRGeUVG8M2Qw+weCeysGG6sWbj0CAf3uCuqnIqSceI4cOHDckaUHmeYyCY6IdDEGQP5k0U5zypatOZRImK64Ox592H5Q==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYQPR04MB8969.apcprd04.prod.outlook.com (2603:1096:405:2f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.29; Mon, 23 Mar
 2026 08:47:59 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 08:47:58 +0000
Message-ID:
 <SE3PR04MB8922DB627EF47A77082B7874F34BA@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 23 Mar 2026 16:47:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix integer overflow in
 kvm_pmu_validate_counter_mask()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
References: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <2ba71d51-cb99-4d48-a182-9c9b41e7ffe0@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYQPR04MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b275ebe-785b-4323-8887-08de88b8e199
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|41001999006|461199028|8060799015|7042599007|6090799003|5072599009|12121999013|19110799012|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L29IQnN6bzRBV0U4SlBFUnpQY3JYY3o2WWJzVk9wN2FIeXd5OVE3NDZQMjYy?=
 =?utf-8?B?NTFhR1V5Y3dlMnZ2dGZNc2hnc1NMUUZrdlI0bUlKMnJXV2lJb1JzQ0NOY2JV?=
 =?utf-8?B?WGtwNmc3TVVZaE9TWC9qUjNVVy9jWVlLLzFFSEFwYUxQVjVCaXU1VWhEZmI2?=
 =?utf-8?B?TnVyZGRvbDduREs5bkkxN2ErTVlNelNnQnBNcjJKa0VmcW5qakY3WGR1VlhJ?=
 =?utf-8?B?WUJvZkh5eTBPQmcwcnZMMFVPWk1VdlMxL1I5WGZHOUx2MWFRVXV0ZlhOOTg0?=
 =?utf-8?B?aXhxa2NPeHU4SHZwbFhOTENkdVkrVUFTbk42dERpTkZzR3RqVTk3UkFUZmtF?=
 =?utf-8?B?dFc5UEcrTE4xMFRFS05hdEZ0S2o0Ym9EdjhFSTNsWUJUeDdkZi85eFo1aFBm?=
 =?utf-8?B?THBlRWwwVDN0NjdCZ2Rtd0tzdm85Y2t4dndXZzBDZENmN1dMbjhkcTRRWlRR?=
 =?utf-8?B?ZDQreEZraWtFOS82V0JhR0NGeUxsbCtIQXhFVXlBN1VISy9tU3Y3Y1dYV3Bo?=
 =?utf-8?B?OGhFcHNURXZzQXFYRFp2azBQSnJxWGhKSlVQd1doL0tza2Vic1g2TnBWRmJv?=
 =?utf-8?B?V0pld3dVVDJkU21Pclk2eHZPNFQraEUzV05FUklLOWh2NmVsN1ZQaEF5cDNF?=
 =?utf-8?B?TXJZYlliZVM2R1V2cVlNTG1wcjZpR01pcGx6VTBtTW9ZMmhqeGkxaUkyUXpH?=
 =?utf-8?B?ejRQOXFNTWwxSnhRVzB2VUl3U2xlMjM5aHhaTVVtMzlqWjVMMFNEYUxidHdQ?=
 =?utf-8?B?QWkvNVg3NWYzNEc1bFh5cTBkZWlqQWdvVVFUejBTc2tROC9ELzZ6UG9HWkxx?=
 =?utf-8?B?N2p4L21LVjBSS3lDNjBwT3Z5V1NYSGlXbTh3T2dDc003K2x4b0NlU2o4WXdZ?=
 =?utf-8?B?WnMrWUNxWVZ4RzJydHJGMXJYc0I3Y2NhTGRnWXZZeXdOci9nUER1MmZ5V2Vl?=
 =?utf-8?B?RVdiZVpwakFPWVRXOVlQK0lWUUVOVE5Ud2grNEIwZXA4OEZGaXVPYXdsRkpw?=
 =?utf-8?B?Vm1kQzZkWmN0eG8wSVRzbmpWRWJRaVE4enFEWGRMY0xCc2tycXcvOTRZd2hk?=
 =?utf-8?B?L0ljL3VBU1lNaCswb2RmMUtFR3A0T0x2MnVBWVM0dmxvUmNpdGNxdXJZSG5T?=
 =?utf-8?B?YmNLdzQrKzlZaTVYTXQvaUtzL1RLTHFIc0hUNEV0WVk3QjF3SHpwTXptQWQy?=
 =?utf-8?B?UjNBcUVNdDU2bjZ2a2tVMnJwcktlanhUQzVKSzFOMURPMC9FYnNJckZtcGFE?=
 =?utf-8?B?QUl1bThxb3BzdzhYV0Fnem9qVWZERkprNVNrYVh5Uld4WHN4YmsyQVV0MU5a?=
 =?utf-8?B?RmxrdTZRWWd4R2NOZDdwSVRzbVRhZDBtNlVITDVTS1pzT1F5ZXRUZW1UM20y?=
 =?utf-8?B?bEdLMUtYWnNkUGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFBnNEJBZE44Rll3RW53NXBveVR3eCszdnM2dXdFdXo5a2FDUzdXMTVKN0lv?=
 =?utf-8?B?dE9SSVNIUWZIc0RvSGh1WDBnNXQyYndRMUxrQmpuZWNUYTZoNFArcEpLcXlk?=
 =?utf-8?B?RDlBZHVNQXYyYlM2aTd0Vk51TUlPNUtSSUhWUTBmSGo1Njh4bHNiSmZMZEF0?=
 =?utf-8?B?ZzMzS1drTlEzTmk3MUMyVFVwQ3B1NjYrckNIRTVkbmJxSnIxZjlIQklxbzVC?=
 =?utf-8?B?OFBzdWFiRGJRQkRXdE9uY3VrRWNqNXBMZUM5akVkZnFhdFJRTk0xbWhvQ202?=
 =?utf-8?B?a0hjak5jY2lMSGlHVnVtTkdDVnRZUVYwQnFyd3ZiZCtrbStZMFBiSW1LRTNu?=
 =?utf-8?B?R1hLTE1zUERwVW1lLzBhc29PTGJjQnpXOGdFWUZoQjVIRDRNNzdNTjNqVUdR?=
 =?utf-8?B?aWxPaCsrc0ZxcG51TFhrNGhwQTBKekJCY2ZhekNJM081M0FDNTVKd1hJYUdr?=
 =?utf-8?B?amlVTzhhMkxyYVFUUkI1NWZDbjhCTThDR0MrOVdPaGRPUUdGODhXN2lGK2x4?=
 =?utf-8?B?WXBTeXEyQjZkajlUanQza1NDSC9jb1BZOXphSnZiRHA0U3ZTVm1Fd3E1Slhx?=
 =?utf-8?B?ajlFdW1Db0ljS2tqemhwUjl3ZzdJSjRqWVU5TmJqclVwbXp3cmFMZWNhYVdR?=
 =?utf-8?B?ejlvbklIMGdMVCsxZGNPbERQaTlIQ2lhZDc5R3dBaVFWNGNrZ0V3c0g0MXV6?=
 =?utf-8?B?RXBMTzY1YVNHc2lTdy9Xa3NDdnhieUgxeDdPc1pxVExRQ2VualZnUnVJY1pT?=
 =?utf-8?B?QWsvZ0JkQWJUUnMzdUtXRFp3SUQ0Qm53NU5vS0hkL0ZkVGdIbVh3cXp5eDAx?=
 =?utf-8?B?QVBpem03d0xBWHdYdEdiVUdpTDJiT0E3Mm1CVGxCd0M0RDc4K1pON3B4TEtL?=
 =?utf-8?B?cW9kdlcvVXdtSWNvaGJxcHZ2MmJneVFZOCtnSmg5bjlIeGdmMGNUMXEvRk1G?=
 =?utf-8?B?eklHYk9nQ0dMU0dKdU80clN2QWRzaXJkeS8yUTFVVkx2YTZQRngrU1lPV1RP?=
 =?utf-8?B?YTdUVnhhY1p3UG1WaE1aYnlkaUEwQnl6ZHR2ejQ0TDZiajlqeE1VNVl2V0FK?=
 =?utf-8?B?KzZtNU5ENm9rVTAwdmpiNWJrcjVueXUxdVJ0UFV5L1pRRUNaZVJEUzNmQytr?=
 =?utf-8?B?WW10TXBJWmtOS2ZKTW9Vc2p4OEV1WjdWQzFPS2czTXhQaWNxU01iRjNIbFBj?=
 =?utf-8?B?dk9wK05zS0lkZ1krTGtpU2t5OCtjbkhHRVpzQ1ZFWUdDYXBvci9WMkVFVXQr?=
 =?utf-8?B?YmtubmF1WWdDNG5WTDZsQTByS04zOFVCU3lkZ0ZkS1ExRENCL0Q0ays2bGN5?=
 =?utf-8?B?YmN4dzBFRGNTZ2hqVGJlL3Y2TGY5U1FBMkpjS3ZtOUZlUGhuWE14LzZIVXJl?=
 =?utf-8?B?LzdVb3gwT0JHWVVqWkpTaGFkbUhNRko1eTR3OWthSmJ5MUVnV2N2VmZDbjhj?=
 =?utf-8?B?UXdwUVZWVDFmMStxMTUvRUg3NG5FdWpsL3NBVi9SekZPVjNrL1VER2plbFoz?=
 =?utf-8?B?TStoMkh0N3hRU21yMXJWbEJleWJLL2pWUkNRWkgrTTJSWmVFaWI0cU9XQlFY?=
 =?utf-8?B?RnNSTXQ4SzZEMEdIMUdud2tCbzMwbk5HT0MrY3N3WVlETFE0SGpLTVAzeWUw?=
 =?utf-8?B?dXFIcFlvSUNWSEtzVDBkZ05pYjZBSG8yOWJFWkJqT1g5c3FiaDQ2em9HVjBz?=
 =?utf-8?B?WHh0NzlDWFVlQ3VJTnZ3RmxUbkxkUGx5bHpiQWlNYjVlSU1OY2ZYLzY5cHZM?=
 =?utf-8?B?eGx4RU1UbHZndlhPYjNHMlZkbzg0b0Jsak5EK29nckJYWGRobGduNXJQcWFG?=
 =?utf-8?B?eFJpZ211RWtWVTZzS2lhZHpoeUlreHdFbnh2eUROeE1rV0ZleXhGczNlNHNS?=
 =?utf-8?Q?cQaq96AnUUJfh?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b275ebe-785b-4323-8887-08de88b8e199
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:47:58.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR04MB8969


On 3/19/2026 11:59 AM, Jiakai Xu wrote:
> When a guest initiates an SBI_EXT_PMU_COUNTER_CFG_MATCH call with
> ctr_base=0xfffffffffffffffe, ctr_mask=0xeb5f and flags=0x1
> (SBI_PMU_CFG_FLAG_SKIP_MATCH), kvm_riscv_vcpu_pmu_ctr_cfg_match()
> first invokes kvm_pmu_validate_counter_mask() to verify whether
> ctr_base and ctr_mask are valid, by evaluating:
>   !ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu))
>
> With the above inputs, __fls(0xeb5f) equals 15, and adding 15 to
> 0xfffffffffffffffe causes an integer overflow, wrapping around to 13.
> Since 13 is less than kvm_pmu_num_counters(), the validation wrongly
> succeeds.
>
> Thereafter, since flags & SBI_PMU_CFG_FLAG_SKIP_MATCH is satisfied,
> the code evaluates:
>   !test_bit(ctr_base + __ffs(ctr_mask), kvpmu->pmc_in_use)
>
> Here __ffs(0xeb5f) equals 0, so test_bit() receives 0xfffffffffffffffe
> as the bit index and attempts to access the corresponding element of
> the kvpmu->pmc_in_use, which results in an invalid memory access. This
> triggers the following Oops:
>   Unable to handle kernel paging request at virtual address e3ebffff12abba89
>    generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128
>    kvm_riscv_vcpu_pmu_ctr_cfg_match arch/riscv/kvm/vcpu_pmu.c:758
>    kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:49
>    kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
>    kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
>
> The root cause is that kvm_pmu_validate_counter_mask() does not account
> for the case where ctr_base itself is out of range, allowing the
> subsequent addition to silently overflow and bypass the check.
>
> Fix this by explicitly validating ctr_base against kvm_pmu_num_counters()
> before performing the addition.
>
> This bug was found by fuzzing the KVM RISC-V PMU interface.
>
> Fixes: 0cb74b65d2e5e6 ("RISC-V: KVM: Implement perf support without sampling")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b2..a098a9b417ad8 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -266,8 +266,10 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>   static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ctr_base,
>   					 unsigned long ctr_mask)
>   {
> -	/* Make sure the we have a valid counter mask requested from the caller */
> -	if (!ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu)))
> +	unsigned long num_ctrs = kvm_pmu_num_counters(kvpmu);
> +
> +	/* Make sure we have a valid counter mask requested from the caller */
> +	if (!ctr_mask || ctr_base >= num_ctrs || (ctr_base + __fls(ctr_mask) >= num_ctrs))
>   		return -EINVAL;
>   
>   	return 0;
