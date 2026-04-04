Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012059.outbound.protection.outlook.com [52.103.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E631F9A1;
	Sat,  4 Apr 2026 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775273244; cv=fail; b=jPigeoISScxNmJTMcLQmlUTYMuXrzLsZUt/qWxEpJSrjBTHo1tomtzf8UXM0YQX/3VR8/26WF84ufYwYjEtrROkjYbmn+FhMMWUfRAPsR0CVxk+ykT+cM3i1ekNkWRxUtg0ira52EQcCxBFnSTsXOG25kI8luIGa9QBymhnd25A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775273244; c=relaxed/simple;
	bh=WE75qnmaMjoEmIteOj6mKcXh42Bx3WGeb/EMZeNx4Tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irVQWp3qoODjDw28ovbPISw9DCeX6NoBvbe/CyPVoAebyRDsRToK4nNtz0MaJL0y92PPaQnYxarqBR0LiOhHJEHuuDt7+laxYcIgUg6NTmKXdgxwnS983Kv2Z/9XiGC1T6viFKul/kG185k63b54ndXIGoZWIXW8lFZGoTj7iO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RLnmY60j; arc=fail smtp.client-ip=52.103.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RLnmY60j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR99MgLQ3A20Oe5F8t2EbB+FOenCxVN9nR5Hjbkhw1ibEa9uctjvuB5gkgi1Ja8MrjKtxjHLBzx8e6sANEbb8XQ1NbuSo3ytdZfcZ7FS4p0YYtQjfDLzoRWKaqjHou2ekzr7yWT/B9coZM/k2LuBcFmmiMr68zLqdmy6aNtV/prAGNxipnZEqiG99FKsM4j+e63x7Pshqu12wum/uotR8gITIooDb6th2C4zGIPtXaZQg4DiNMl6dkXMFoDKXzuuZBgIErpjAhOI5CSq0qCvW5n8ADNyOSG+wggtXFj5jkLc3HDd+A4wqNrAcU65owOtsFNOhnduM34LoOOkzp8Sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HDrnm167POo6byYeTQ1VaJSTu5Asbu4IAxMrwIrbxY=;
 b=vVknUcb0a8l6L506ag0r/s78WBgSGj+mO+0nAN/KX5pXHqGAU0Tl+TRCxEAQymeEazKNZ2h80vm3+EoJH75dhILko+kotxJC8ESqHwzYj66JlgrvFx9NqxNpo6eV4jXmqhFKtEN6rJNJklgp0cpvvGmQC/idh+tKIwFFM1AH59JJtoG5p1pOOm6cJSKHX5THMIrrLZKPB0ejnXAQgJAuXU9FldF+0KTecjEAVvWJ9Mem8KnejZ3gBdOhi1dszC1Ezm0GB/Nj2qweEdC518ImZRqPofIXX7v7nalpyUYn89py8rCBYtH2rX1ZOnthsAsOXWD0eLaaLlpLw2p9OUCqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HDrnm167POo6byYeTQ1VaJSTu5Asbu4IAxMrwIrbxY=;
 b=RLnmY60jwN94RZmIkk6Iy8XHlwJuF2eySvRfYj1xThsb662c+4WcpA5EzEFapX/CxJBYq+ENjORGCtZt2mi4eVOhSg+DjU6IiY3mmjLxUXSnPoYApMRlGS3x7dPz9ZudGAoX1HCgBslEitddz2/rsFi0/gaLyvzAm5zsuPf2CL08QfFLQj5XYhq8IyqkpDXqNDHe848d2COiivKShybSXneUxQkpHzdTVbhnA8CGb3mUwbsl1TNTw86ZO2aywrrMiqPD+daxAAMutoQBgSS3BDWsrSXwvLWeqLmLQ6mDLK1LEVBfwTtRFoQlQ9GuIdFYl4gQtSgwHNVPGWOo9y8wFg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by JH0PR04MB7622.apcprd04.prod.outlook.com (2603:1096:990:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Sat, 4 Apr
 2026 03:27:16 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.017; Sat, 4 Apr 2026
 03:27:16 +0000
Message-ID:
 <SE3PR04MB89223F969109A97CD415D64AF35FA@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Sat, 4 Apr 2026 11:27:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] RISC-V: KVM: Support runtime configuration for
 per-VM's HGATP mode
To: fangyu.yu@linux.alibaba.com, pbonzini@redhat.com, corbet@lwn.net,
 anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 skhan@linuxfoundation.org
Cc: guoren@kernel.org, radim.krcmar@oss.qualcomm.com,
 andrew.jones@oss.qualcomm.com, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com>
 <20260403153019.9916-2-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260403153019.9916-2-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <4c6a2c32-b945-4607-aed4-495396790a62@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|JH0PR04MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: adc58d48-2dd9-427c-7c85-08de91fa1171
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZmcv7cN2CQdJd4XVKwegu/430nOv43DHxiGO1F9C1ZvYu9MNV3Vt53kqLHWMh5TDrKz/ekW87QqSm/qqw8wjc6m9WCGL6n+n8I8coEg/can6Id3VeUvzW8CK8mQglCoJcOBCvAzz4a2U1LegnFlC8jiYM5A4lBLgKBpX1osFsm7V2HB1oEs18dlUrgYflE+n3CmQBSshKOfFdbXnsrWLLeazD9NcH/dv1BAt+STGJLZH4N0o/Xa64Ig1ohXC5szjSZm5HBkCKEKKv6wA1XWXDWVkgBCN9tnCmAh9moZfOYAABvCHpjuEJ+DejDxl3F5P02acVDh1yc7wXBCzBF1SJUIgjvrs4vRBbqvWW0JzLT5rZUyZ7IaRvZLhDy850R6JfwZhCmViEA/AP/dlXpslB1Qf6MD3E6jnEHR/k+Ky5Kl8IfXruxRboOLrfGeq7sJYeDWdUZZ8FBCzO6KjWx1loIz1pgRpzxkNFwYZCtfd8D+EZrDnbh6m0XvLfvd1AR1B2o2crxovk5lDiM5zPUbVl1/Vsji1deiJoDVtawimtl9f4A07urchggY0urjx7dx81ljS137+pgX7HKiTkFM7yt2gXlvhtSOUS4fZBm8Dr2VoG+PkJBliXPWJmJmEag0C1kaxfTEesIxSwfv1goApOBwQ3EdXtBzTPKQcO0H828/Ug0Gmfd+ZSzwymzXNJWG3hVreGbNF4NfrQI/PDJDCbxciR6NPdeDuMLEessZVg3BCjV0ZEL7nvexd7Utbpq1WU5I5NlMCVldmL4LOQMW+IRj0NevEx5vDGIcxUnQ89MoY2OdlxPQc2UF
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|12121999013|23021999003|19110799012|41001999006|5072599009|6090799003|461199028|8060799015|7042599007|15080799012|40105399003|3412199025|440099028|12091999003|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUdRZERHZHNVc3FRUGhRMGlBVVRqbVRjcnpYelRLcUdoWmlqMlp3ZjlocHZH?=
 =?utf-8?B?a2lXaWR0RXZ4eGNWeXVQQUh4NWdRWTUyZEpaN0pSVjhSaVYzU0E0K2JRMkFh?=
 =?utf-8?B?Y2JpYXlkVVM5TEk1U0g4cUdJYTZFVXBheE9iK3FaUVJRSnUxUUkrRkFJV1Vk?=
 =?utf-8?B?Wm5jVmt5bVlOM0YxZGx6SmtYck9VTldpZ0t5VUtyRGJ1NXJwMGtWbGVXYkE1?=
 =?utf-8?B?Q3NzL2VqcHVXUmF5LzNaNy9uQWVDU1MzVTdhMGFvNm1ZRGdpYTIxc2R2cjlD?=
 =?utf-8?B?eDI3Yml3dStyYmNEdjh5U0tETzcvWUJTeUthZ1ovcmUyU3ErQ1N0TmhoR3pS?=
 =?utf-8?B?M1M3dzMvU25zcWQ4eUQyYkxMMW16YTFQQm9EdUlrYURMUmxKNFpvT2w2bXdp?=
 =?utf-8?B?TUwrUEIrVTh1ZlRJZldSekFtUVZXcy9LTlVFWEE4YmFhcktObko5SmJkbTVq?=
 =?utf-8?B?R1dQQWNiaUNzM2tQQXJCeUZGMkZUOVBuK3IzMlR6cUdZM2pPN0laWmFVZ1Fx?=
 =?utf-8?B?NTgrYTJoTytFcGxnd1hQc1phZU5BWHZiQytHV0hrd0NHVUlhMjRKZ2FWYUNT?=
 =?utf-8?B?eHpWbXAzV2lFTzgra3MrNjl1Y3ZLWUt4dGFXUTVWNW9VTDUwbXVVcUJzL3R5?=
 =?utf-8?B?czkwTk44dHBDNkVKS213NSs2ZjhXVEdLMUhDTHgvVE0vVEoxbEgzaUdoMXlF?=
 =?utf-8?B?d3A1U1VqOHoxMDZ2WXo3cVpEU3UxUmk3T3UreWN6Ly93UHRRQVFkYUNyaGJZ?=
 =?utf-8?B?anlSaXlkQytjZHVRdjZsM2dBV2w2MGlDV05UaUk0eTNDa1ljTFlZUkVNZEFO?=
 =?utf-8?B?bXlqRkFUSnNWKzRzakd1Z3VqdDJFazUrNlQwSWlYWktKaWQ0dXdLQjhiNXpz?=
 =?utf-8?B?OThnNmRLV2trM0xaNmM3Nzh4bm1BY0Vta1J3NktYQ3pLdW5EU1Z3V3Rick5k?=
 =?utf-8?B?bHJsaE1YaVh5RndUMGFDVEx3R1lkNzJwRTY5S0JFRXFSRGxESmZKZ21Dem8w?=
 =?utf-8?B?c0pTNU5IaUE3ZlFRaTFRczV3NTUzUlhPTjhOWUhxNWpkd09ZSVlSVzlXNDlH?=
 =?utf-8?B?NHgxdi9TMUZVeUVEOURLZUVqZlRkNTZ6ak4yR3huZnlnQzlOSjhuZ1FEcVh2?=
 =?utf-8?B?ODF3bzJMQngvS0dLci81Z2o5MGJYUTJwa0c3QVhsOUNiOGdDVENaUFZyb1Ro?=
 =?utf-8?B?Sy91RGNoWE52d0o3eXVYRXF2M3gyQnIydnJSWkZIc1hoVHd4emRLV3lPWExR?=
 =?utf-8?B?UWpZK1dJK1VmTXVRN2ZZb2xnVmhvVjlEUzE3dXNuQzJMZzNIcmNZMlk3ejlC?=
 =?utf-8?B?bG1JRWQzYXJUVXFNdzlqNkdJRmdZU0V3dGkyeFUzc1IzeWVEV09NcUJLdGRz?=
 =?utf-8?B?NDFBUEhaZjV1bWFLN2o5Nk1hUlVNOU5mdTdLSlNRTXY0d0tuMXR1TzV5NnF3?=
 =?utf-8?B?TEN3YnY3SW16SmVPYW9uRytoVFpZUW05TWpVeUxnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnJiZ3pQSGkzUC9xWUE3bGswWWlGMEgvbjEybnB6a0cvcnBTVXF1UWo0bjN0?=
 =?utf-8?B?a3NUWlU4ZXhaYWFSZ0ZEcXhrdjFYNHk5SmxSajkwTVlNcjdNUUhoNmlZTW1l?=
 =?utf-8?B?RE45Q2dEeHl1SGtjSkdxVU91RkV2TStDVWcxNndXakIvaVU0ZEc3UDZ0TTlP?=
 =?utf-8?B?M3NxU2xHbUtxQWdjT2RrNWx6R3k1R3ZvcE5KeGpWRVJiUEZlUTBHcmhmdi84?=
 =?utf-8?B?dHAwb1diZWRvSUR1VUE2MU1zMWJZWUIwTDZhWWZ0OS9vNlA0Vk82Qnc1T2FJ?=
 =?utf-8?B?Rmp6cndpM1orWXFmV056ZGZTb3h5dXZ1SzBSbEE3YXVKd3lyTHEvN1doV2cw?=
 =?utf-8?B?R21tSU1hQkdUWC81NVpxNytzL3ZQMkVubUhZNjZId3k4NWdYVW5JbU9UUVI5?=
 =?utf-8?B?bGVZTFhyTzFQbzU5eFFZbTFHMDZrbmcxYThVVExEc2JDRUhKQjBIclNxcmMy?=
 =?utf-8?B?QlNFSFhBeUFaWTlrTEtoM05EZ3B6ZG5Ub0NpUGdObVptSm5SeFpaY1RnYWdl?=
 =?utf-8?B?VHN2UDRPd1o2ZG1JVDQyVmxxM0NnNE95aXFGMzNOVnJwUjRxQkNZc1N6akhy?=
 =?utf-8?B?b0xDa3F6a1Eyb2NDcVlPRE05anhaZFBsbloxZzUxbjNpSXRqRTAwNldqdU5M?=
 =?utf-8?B?QXBFNVlSelJwN3M3Sm5va3FjR0xvLzcxQ2RuNFowc0lkSm5KalBnczZEU1o3?=
 =?utf-8?B?R1BkRzFiK1M1WW9PZE45Y1ZyM0NXQkRnVm9UandOWHFIendxV09TdkRnMXFC?=
 =?utf-8?B?aW1kRms5eWNIdExuOE5PTnEyOVFHajdlOFlaaWxXeHZvMlpMVUo0QldTb01l?=
 =?utf-8?B?ck5YRXBTdjMwNzhrSzBMekRnWlVab3gzN3FCSWh5YXVzbk5HckVpdXhEV041?=
 =?utf-8?B?RTVCZTM4UjNFdk1Hc1g3OUQ4UnFKL3RYQXp3cjg2SzlWUEhoTHJ4WFU4cjJw?=
 =?utf-8?B?cXlUWXI1ZWFyTEQ3K3YrSjBibGdiMG51ZmM2d3hrRXNCY0w4MW1lWi8zVHBu?=
 =?utf-8?B?RTJoby8wdnF6ZVB0L0ZCTXphT1NzMWN6S1RzcHh0OE96QUN5UmlCWkliUHdF?=
 =?utf-8?B?TkJmVVFXa0ZEbGxGT1NLb1NTbmFXSFkzeUswQ2dEcE5MM0VWc0NVS3lnVHVJ?=
 =?utf-8?B?bEtENUJvMlNPenZFMTMydHh2R25TcUQ5MmZodU4wMWtWL1I3cFExckZreWVo?=
 =?utf-8?B?RjRsNlFHQXAwTmRQNzduaVRBOTg3N0RGeVJEM3hIMFJ1ZzFnZHp4eSsyN3BU?=
 =?utf-8?B?V0pwZW9NK2U5SXQ1VTUrbHBXSG9YeG13aXlDRjlmMFlqZXJPQ3RnUFJnclBp?=
 =?utf-8?B?dGVkT1NsbU9aSUtQREQ3L3BKOE5JQzJicThKMjFoRlNwQUp3UE9oTk5uTFpp?=
 =?utf-8?B?eDFJYXFNWEZER2pOVjlucWpGNFF1aWFzZ2d3eUNJK2RTUmJ5bTY2WHk2bWdv?=
 =?utf-8?B?Q0F0eC9nNGZMSjlPcmxhcTV1SlYzalpBNk8vUWNNNVV5T2VINzI4bW1IZ1Fq?=
 =?utf-8?B?c3pYZloyNE9Bb1JQREVmNy9SM1c3RVc3ZERWMU5PZzFpZVRkMnFXMmNrV2hj?=
 =?utf-8?B?OGJSL095UE9TMEdKRitSMHlRTTRmYUN6Y25JRGd1VVdpeDRFVmtvOG8weDFQ?=
 =?utf-8?B?TnNrZ09OYS92OFBLZTNnbGVEcW1hSzdCL3VVMkk0QjVSWTdtV0cwNVRheG9U?=
 =?utf-8?B?Tm0wbnJFTDZXMFY4aGJob0dZS0h1VlgrdHI4dVlaQTVVbmtYRmhtVDRsUk04?=
 =?utf-8?B?aWQ3TmtvR1AxdzluMUFtVDJlRmwvUm4va2dEcVNmRDhKdHQvbStOREsvVnlk?=
 =?utf-8?B?NnFLRTRqcjZlV2RpZXZFcG5QK2Y4dllCdWZkTTMwSDkyU3Rpd0R3N1JYcHpX?=
 =?utf-8?Q?QQXgxTlX21x2s?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: adc58d48-2dd9-427c-7c85-08de91fa1171
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 03:27:15.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7622


On 4/3/2026 11:30 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Introduces one per-VM architecture-specific fields to support runtime
> configuration of the G-stage page table format:
>
> - kvm->arch.pgd_levels: the corresponding number of page table levels
>    for the selected mode.
>
> These fields replace the previous global variables
> kvm_riscv_gstage_mode and kvm_riscv_gstage_pgd_levels, enabling different
> virtual machines to independently select their G-stage page table format
> instead of being forced to share the maximum mode detected by the kernel
> at boot time.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/include/asm/kvm_gstage.h | 37 ++++++++++++----
>   arch/riscv/include/asm/kvm_host.h   |  1 +
>   arch/riscv/kvm/gstage.c             | 65 ++++++++++++++---------------
>   arch/riscv/kvm/main.c               | 12 +++---
>   arch/riscv/kvm/mmu.c                | 20 +++++----
>   arch/riscv/kvm/vm.c                 |  5 ++-
>   arch/riscv/kvm/vmid.c               |  3 +-
>   7 files changed, 86 insertions(+), 57 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
> index 595e2183173e..5aa58d1f692a 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -29,16 +29,22 @@ struct kvm_gstage_mapping {
>   #define kvm_riscv_gstage_index_bits	10
>   #endif
>   
> -extern unsigned long kvm_riscv_gstage_mode;
> -extern unsigned long kvm_riscv_gstage_pgd_levels;
> +extern unsigned long kvm_riscv_gstage_max_pgd_levels;
>   
>   #define kvm_riscv_gstage_pgd_xbits	2
>   #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
> -#define kvm_riscv_gstage_gpa_bits	(HGATP_PAGE_SHIFT + \
> -					 (kvm_riscv_gstage_pgd_levels * \
> -					  kvm_riscv_gstage_index_bits) + \
> -					 kvm_riscv_gstage_pgd_xbits)
> -#define kvm_riscv_gstage_gpa_size	((gpa_t)(1ULL << kvm_riscv_gstage_gpa_bits))
> +
> +static inline unsigned long kvm_riscv_gstage_gpa_bits(unsigned long pgd_levels)
> +{
> +	return (HGATP_PAGE_SHIFT +
> +		pgd_levels * kvm_riscv_gstage_index_bits +
> +		kvm_riscv_gstage_pgd_xbits);
> +}
> +
> +static inline gpa_t kvm_riscv_gstage_gpa_size(unsigned long pgd_levels)
> +{
> +	return BIT_ULL(kvm_riscv_gstage_gpa_bits(pgd_levels));
> +}
>   
>   bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
>   			       pte_t **ptepp, u32 *ptep_level);
> @@ -69,4 +75,21 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>   
>   void kvm_riscv_gstage_mode_detect(void);
>   
> +static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_levels)
> +{
> +	switch (pgd_levels) {
> +	case 2:
> +		return HGATP_MODE_SV32X4;
> +	case 3:
> +		return HGATP_MODE_SV39X4;
> +	case 4:
> +		return HGATP_MODE_SV48X4;
> +	case 5:
> +		return HGATP_MODE_SV57X4;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return HGATP_MODE_OFF;
> +	}
> +}
> +
>   #endif
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 24585304c02b..478f699e9dec 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -94,6 +94,7 @@ struct kvm_arch {
>   	/* G-stage page table */
>   	pgd_t *pgd;
>   	phys_addr_t pgd_phys;
> +	unsigned long pgd_levels;
>   
>   	/* Guest Timer */
>   	struct kvm_guest_timer timer;
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b67d60d722c2..4beb9322fe76 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -12,22 +12,21 @@
>   #include <asm/kvm_gstage.h>
>   
>   #ifdef CONFIG_64BIT
> -unsigned long kvm_riscv_gstage_mode __ro_after_init = HGATP_MODE_SV39X4;
> -unsigned long kvm_riscv_gstage_pgd_levels __ro_after_init = 3;
> +unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
>   #else
> -unsigned long kvm_riscv_gstage_mode __ro_after_init = HGATP_MODE_SV32X4;
> -unsigned long kvm_riscv_gstage_pgd_levels __ro_after_init = 2;
> +unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
>   #endif
>   
>   #define gstage_pte_leaf(__ptep)	\
>   	(pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
>   
> -static inline unsigned long gstage_pte_index(gpa_t addr, u32 level)
> +static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
> +					     gpa_t addr, u32 level)
>   {
>   	unsigned long mask;
>   	unsigned long shift = HGATP_PAGE_SHIFT + (kvm_riscv_gstage_index_bits * level);
>   
> -	if (level == (kvm_riscv_gstage_pgd_levels - 1))
> +	if (level == gstage->kvm->arch.pgd_levels - 1)
>   		mask = (PTRS_PER_PTE * (1UL << kvm_riscv_gstage_pgd_xbits)) - 1;
>   	else
>   		mask = PTRS_PER_PTE - 1;
> @@ -40,12 +39,13 @@ static inline unsigned long gstage_pte_page_vaddr(pte_t pte)
>   	return (unsigned long)pfn_to_virt(__page_val_to_pfn(pte_val(pte)));
>   }
>   
> -static int gstage_page_size_to_level(unsigned long page_size, u32 *out_level)
> +static int gstage_page_size_to_level(struct kvm_gstage *gstage, unsigned long page_size,
> +				     u32 *out_level)
>   {
>   	u32 i;
>   	unsigned long psz = 1UL << 12;
>   
> -	for (i = 0; i < kvm_riscv_gstage_pgd_levels; i++) {
> +	for (i = 0; i < gstage->kvm->arch.pgd_levels; i++) {
>   		if (page_size == (psz << (i * kvm_riscv_gstage_index_bits))) {
>   			*out_level = i;
>   			return 0;
> @@ -55,21 +55,23 @@ static int gstage_page_size_to_level(unsigned long page_size, u32 *out_level)
>   	return -EINVAL;
>   }
>   
> -static int gstage_level_to_page_order(u32 level, unsigned long *out_pgorder)
> +static int gstage_level_to_page_order(struct kvm_gstage *gstage, u32 level,
> +				      unsigned long *out_pgorder)
>   {
> -	if (kvm_riscv_gstage_pgd_levels < level)
> +	if (gstage->kvm->arch.pgd_levels < level)
>   		return -EINVAL;
>   
>   	*out_pgorder = 12 + (level * kvm_riscv_gstage_index_bits);
>   	return 0;
>   }
>   
> -static int gstage_level_to_page_size(u32 level, unsigned long *out_pgsize)
> +static int gstage_level_to_page_size(struct kvm_gstage *gstage, u32 level,
> +				     unsigned long *out_pgsize)
>   {
>   	int rc;
>   	unsigned long page_order = PAGE_SHIFT;
>   
> -	rc = gstage_level_to_page_order(level, &page_order);
> +	rc = gstage_level_to_page_order(gstage, level, &page_order);
>   	if (rc)
>   		return rc;
>   
> @@ -81,11 +83,11 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
>   			       pte_t **ptepp, u32 *ptep_level)
>   {
>   	pte_t *ptep;
> -	u32 current_level = kvm_riscv_gstage_pgd_levels - 1;
> +	u32 current_level = gstage->kvm->arch.pgd_levels - 1;
>   
>   	*ptep_level = current_level;
>   	ptep = (pte_t *)gstage->pgd;
> -	ptep = &ptep[gstage_pte_index(addr, current_level)];
> +	ptep = &ptep[gstage_pte_index(gstage, addr, current_level)];
>   	while (ptep && pte_val(ptep_get(ptep))) {
>   		if (gstage_pte_leaf(ptep)) {
>   			*ptep_level = current_level;
> @@ -97,7 +99,7 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
>   			current_level--;
>   			*ptep_level = current_level;
>   			ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
> -			ptep = &ptep[gstage_pte_index(addr, current_level)];
> +			ptep = &ptep[gstage_pte_index(gstage, addr, current_level)];
>   		} else {
>   			ptep = NULL;
>   		}
> @@ -110,7 +112,7 @@ static void gstage_tlb_flush(struct kvm_gstage *gstage, u32 level, gpa_t addr)
>   {
>   	unsigned long order = PAGE_SHIFT;
>   
> -	if (gstage_level_to_page_order(level, &order))
> +	if (gstage_level_to_page_order(gstage, level, &order))
>   		return;
>   	addr &= ~(BIT(order) - 1);
>   
> @@ -125,9 +127,9 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
>   			     struct kvm_mmu_memory_cache *pcache,
>   			     const struct kvm_gstage_mapping *map)
>   {
> -	u32 current_level = kvm_riscv_gstage_pgd_levels - 1;
> +	u32 current_level = gstage->kvm->arch.pgd_levels - 1;
>   	pte_t *next_ptep = (pte_t *)gstage->pgd;
> -	pte_t *ptep = &next_ptep[gstage_pte_index(map->addr, current_level)];
> +	pte_t *ptep = &next_ptep[gstage_pte_index(gstage, map->addr, current_level)];
>   
>   	if (current_level < map->level)
>   		return -EINVAL;
> @@ -151,7 +153,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
>   		}
>   
>   		current_level--;
> -		ptep = &next_ptep[gstage_pte_index(map->addr, current_level)];
> +		ptep = &next_ptep[gstage_pte_index(gstage, map->addr, current_level)];
>   	}
>   
>   	if (pte_val(*ptep) != pte_val(map->pte)) {
> @@ -175,7 +177,7 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>   	out_map->addr = gpa;
>   	out_map->level = 0;
>   
> -	ret = gstage_page_size_to_level(page_size, &out_map->level);
> +	ret = gstage_page_size_to_level(gstage, page_size, &out_map->level);
>   	if (ret)
>   		return ret;
>   
> @@ -217,7 +219,7 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>   	u32 next_ptep_level;
>   	unsigned long next_page_size, page_size;
>   
> -	ret = gstage_level_to_page_size(ptep_level, &page_size);
> +	ret = gstage_level_to_page_size(gstage, ptep_level, &page_size);
>   	if (ret)
>   		return;
>   
> @@ -229,7 +231,7 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>   	if (ptep_level && !gstage_pte_leaf(ptep)) {
>   		next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
>   		next_ptep_level = ptep_level - 1;
> -		ret = gstage_level_to_page_size(next_ptep_level, &next_page_size);
> +		ret = gstage_level_to_page_size(gstage, next_ptep_level, &next_page_size);
>   		if (ret)
>   			return;
>   
> @@ -263,7 +265,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>   
>   	while (addr < end) {
>   		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
> -		ret = gstage_level_to_page_size(ptep_level, &page_size);
> +		ret = gstage_level_to_page_size(gstage, ptep_level, &page_size);
>   		if (ret)
>   			break;
>   
> @@ -297,7 +299,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>   
>   	while (addr < end) {
>   		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
> -		ret = gstage_level_to_page_size(ptep_level, &page_size);
> +		ret = gstage_level_to_page_size(gstage, ptep_level, &page_size);
>   		if (ret)
>   			break;
>   
> @@ -319,39 +321,34 @@ void __init kvm_riscv_gstage_mode_detect(void)
>   	/* Try Sv57x4 G-stage mode */
>   	csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
>   	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
> -		kvm_riscv_gstage_mode = HGATP_MODE_SV57X4;
> -		kvm_riscv_gstage_pgd_levels = 5;
> +		kvm_riscv_gstage_max_pgd_levels = 5;
>   		goto done;
>   	}
>   
>   	/* Try Sv48x4 G-stage mode */
>   	csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>   	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
> -		kvm_riscv_gstage_mode = HGATP_MODE_SV48X4;
> -		kvm_riscv_gstage_pgd_levels = 4;
> +		kvm_riscv_gstage_max_pgd_levels = 4;
>   		goto done;
>   	}
>   
>   	/* Try Sv39x4 G-stage mode */
>   	csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
>   	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV39X4) {
> -		kvm_riscv_gstage_mode = HGATP_MODE_SV39X4;
> -		kvm_riscv_gstage_pgd_levels = 3;
> +		kvm_riscv_gstage_max_pgd_levels = 3;
>   		goto done;
>   	}
>   #else /* CONFIG_32BIT */
>   	/* Try Sv32x4 G-stage mode */
>   	csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
>   	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
> -		kvm_riscv_gstage_mode = HGATP_MODE_SV32X4;
> -		kvm_riscv_gstage_pgd_levels = 2;
> +		kvm_riscv_gstage_max_pgd_levels = 2;
>   		goto done;
>   	}
>   #endif
>   
>   	/* KVM depends on !HGATP_MODE_OFF */
> -	kvm_riscv_gstage_mode = HGATP_MODE_OFF;
> -	kvm_riscv_gstage_pgd_levels = 0;
> +	kvm_riscv_gstage_max_pgd_levels = 0;
>   
>   done:
>   	csr_write(CSR_HGATP, 0);
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0f3fe3986fc0..90ee0a032b9a 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -105,17 +105,17 @@ static int __init riscv_kvm_init(void)
>   		return rc;
>   
>   	kvm_riscv_gstage_mode_detect();
> -	switch (kvm_riscv_gstage_mode) {
> -	case HGATP_MODE_SV32X4:
> +	switch (kvm_riscv_gstage_max_pgd_levels) {
> +	case 2:
>   		str = "Sv32x4";
>   		break;
> -	case HGATP_MODE_SV39X4:
> +	case 3:
>   		str = "Sv39x4";
>   		break;
> -	case HGATP_MODE_SV48X4:
> +	case 4:
>   		str = "Sv48x4";
>   		break;
> -	case HGATP_MODE_SV57X4:
> +	case 5:
>   		str = "Sv57x4";
>   		break;
>   	default:
> @@ -164,7 +164,7 @@ static int __init riscv_kvm_init(void)
>   			 (rc) ? slist : "no features");
>   	}
>   
> -	kvm_info("using %s G-stage page table format\n", str);
> +	kvm_info("highest G-stage page table mode is %s\n", str);
>   
>   	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
>   
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 088d33ba90ed..fbcdd75cb9af 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -67,7 +67,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
>   		if (!writable)
>   			map.pte = pte_wrprotect(map.pte);
>   
> -		ret = kvm_mmu_topup_memory_cache(&pcache, kvm_riscv_gstage_pgd_levels);
> +		ret = kvm_mmu_topup_memory_cache(&pcache, kvm->arch.pgd_levels);
>   		if (ret)
>   			goto out;
>   
> @@ -186,7 +186,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>   	 * space addressable by the KVM guest GPA space.
>   	 */
>   	if ((new->base_gfn + new->npages) >=
> -	    (kvm_riscv_gstage_gpa_size >> PAGE_SHIFT))
> +	     kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels) >> PAGE_SHIFT)
>   		return -EFAULT;
>   
>   	hva = new->userspace_addr;
> @@ -472,7 +472,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>   	memset(out_map, 0, sizeof(*out_map));
>   
>   	/* We need minimum second+third level pages */
> -	ret = kvm_mmu_topup_memory_cache(pcache, kvm_riscv_gstage_pgd_levels);
> +	ret = kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
>   	if (ret) {
>   		kvm_err("Failed to topup G-stage cache\n");
>   		return ret;
> @@ -575,6 +575,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>   		return -ENOMEM;
>   	kvm->arch.pgd = page_to_virt(pgd_page);
>   	kvm->arch.pgd_phys = page_to_phys(pgd_page);
> +	kvm->arch.pgd_levels = kvm_riscv_gstage_max_pgd_levels;
>   
>   	return 0;
>   }
> @@ -590,10 +591,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>   		gstage.flags = 0;
>   		gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
>   		gstage.pgd = kvm->arch.pgd;
> -		kvm_riscv_gstage_unmap_range(&gstage, 0UL, kvm_riscv_gstage_gpa_size, false);
> +		kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> +			kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
>   		pgd = READ_ONCE(kvm->arch.pgd);
>   		kvm->arch.pgd = NULL;
>   		kvm->arch.pgd_phys = 0;
> +		kvm->arch.pgd_levels = 0;
>   	}
>   	spin_unlock(&kvm->mmu_lock);
>   
> @@ -603,11 +606,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>   
>   void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
>   {
> -	unsigned long hgatp = kvm_riscv_gstage_mode << HGATP_MODE_SHIFT;
> -	struct kvm_arch *k = &vcpu->kvm->arch;
> +	struct kvm_arch *ka = &vcpu->kvm->arch;
> +	unsigned long hgatp = kvm_riscv_gstage_mode(ka->pgd_levels)
> +			      << HGATP_MODE_SHIFT;
>   
> -	hgatp |= (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
> -	hgatp |= (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
> +	hgatp |= (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
> +	hgatp |= (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
>   
>   	ncsr_write(CSR_HGATP, hgatp);
>   
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 13c63ae1a78b..fb7c4e07961f 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -199,7 +199,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		r = KVM_USER_MEM_SLOTS;
>   		break;
>   	case KVM_CAP_VM_GPA_BITS:
> -		r = kvm_riscv_gstage_gpa_bits;
> +		if (!kvm)
> +			r = kvm_riscv_gstage_gpa_bits(kvm_riscv_gstage_max_pgd_levels);
> +		else
> +			r = kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels);
>   		break;
>   	default:
>   		r = 0;
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index cf34d448289d..c15bdb1dd8be 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -26,7 +26,8 @@ static DEFINE_SPINLOCK(vmid_lock);
>   void __init kvm_riscv_gstage_vmid_detect(void)
>   {
>   	/* Figure-out number of VMID bits in HW */
> -	csr_write(CSR_HGATP, (kvm_riscv_gstage_mode << HGATP_MODE_SHIFT) | HGATP_VMID);
> +	csr_write(CSR_HGATP, (kvm_riscv_gstage_mode(kvm_riscv_gstage_max_pgd_levels) <<
> +			      HGATP_MODE_SHIFT) | HGATP_VMID);
>   	vmid_bits = csr_read(CSR_HGATP);
>   	vmid_bits = (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
>   	vmid_bits = fls_long(vmid_bits);
