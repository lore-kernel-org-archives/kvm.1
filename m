Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013075.outbound.protection.outlook.com [52.103.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050703BFACE;
	Wed, 23 Sep 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156748; cv=fail; b=ZHWpdvPJOBkjThfg+dwnHCZdghujlkEqookdocLNHrJNhe4xKBTMh3ho+QLUa0bobIkErcw1NETROImXDUshiR5LsrbmrhsQn/g+b2wbO8s2shbqIKlbSd6TWD8CVNhtBFRWcRZP9cb4igtU7D+RR2m7eRDCSUjQzjrM5I5JoGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156748; c=relaxed/simple;
	bh=FllcTvqCAVQaQNfCNwsBotLkwyUDI2YJqXiqmDuH9wg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cdNs5bzWBcLRcFUWKu++Ms8YmHl5Uz/RFKjpGFcSKO3DbhL/hv+7NGQhdU9E3Uu4q/RQTCIxKWPtZOVw0IcdIP5edlOIxUD3ZS6BWcnRPh4qo5a30PUMFul6tEYtCv+vC3sp97MaGB14h2eC30KGtpfST91hw7cNLHaQq7AFw58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gAhB3pDq; arc=fail smtp.client-ip=52.103.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gAhB3pDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB4KxDj4srG3+wZ1pRhRjEA6fMyOALq3IWTvsoZB1UKPMNiNsdG+NN1G3DF9TKvFgF04T+YcwQtWws6b9e1xgGOHItiRqC2YwsXCz/tU/UFZQDrIw+41I3+i+lcX9s0aRTjISvbHY8x6MtPebSPB2tS5rC1vZLrMXDGg1U1LzA1MO4Q6BrqPDXAtrdyIfU1RXkhyGhlTlavUWxBkLE0n5rbP93hBDdxJ6cb1XaoRVd6gehvqE3VEzJ66yncK+SdSAkKSUIwfyXzHZP3HGcRgz4B7H6VlqRA9EheFHgz6ASYR+iE9BRo6CAulgHZT/yQFHM2zN6v1pFl0EVs1iTF5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wInSErQltcloLt/Fi+ttXV2P8hxOQ8jqerbBJnadsDg=;
 b=jVizshcS966Hkrc1fJYHU+TODEiHH4pX3DIWXzezkT8Hoi5wHorJhOxx/WDXwGwuBpvCHk7jcjihrK/a7czJvmCVIcsFizPTE6qO+bAcP7+IPHpncaOgSLVeDHxCQljZBlSf4r0iKNKM0Bj8itmTSSDJA/9HmvtJHzIDVfmv9Ih1exFmyzcCKtIXYGDA3cC0j7hWzSBZbFQDy57QdKtXwbB0cFAkk98JEWm+MZGakczpBTr+0h7y3HQwmQ3rWZHbx4bw4cmz3Qj1woxPm+4mN8jb/atYI3wdiLG2laTzL9YkSEfljgjlfWKsVjlqhEgQu7+yNaEr3S5aUvG/uN6oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wInSErQltcloLt/Fi+ttXV2P8hxOQ8jqerbBJnadsDg=;
 b=gAhB3pDq3k9qeHJ/cpy0+HTjF2KhJRdXUACfhZLwWFK6OwHRdEKuzyVCO8kFjLeQSpvdusu1bSUUpvLr9Y0F5sU4zCKmdogMMJdF7jAzdG2XU78lt2gjr0fTHOTKSaaOiE7DN10KzmvKdig3GMhuj3faC41i8CRe22cKEiyVVs2cEqqRWmMgSMIMrQWQKBb8mJ36TL9sNFtDOWY+TeamnC52of/fzMdOdVyxKmKHPumT0QLoC5/w1Z6aki63lGa1byqTWRGgu7kAV1mzzF3ouDbh1wy37Jnb4gQ7En/NU1X5K1JxX05RHjIb2ftqnSnguwLAl9cJV9DFy1QALFAMFw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KUXPR04MB9418.apcprd04.prod.outlook.com (2603:1096:d10:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 09:45:39 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 09:45:39 +0000
Message-ID:
 <SE3PR04MB8922DDB6052BFCE83F49778EF3822@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 23 Sep 2026 17:45:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] RISC-V: KVM: Disallow GPA-width changes after AIA
 init
To: Pengpeng Hou <hppiscas@163.com>, anup@brainfault.org
Cc: Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, Guo Ren <guoren@kernel.org>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>
References: <cover.1789872556.git.hppiscas@163.com>
 <fbe7337f6989994ad4dbc4dc03a67e8ebfa61f8d.1789872556.git.hppiscas@163.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <fbe7337f6989994ad4dbc4dc03a67e8ebfa61f8d.1789872556.git.hppiscas@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <828b9f46-22e1-427d-a963-b80f497b63c1@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KUXPR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 141af514-c240-4b86-f210-08df19576c75
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KM6CoYXTTNjh34iAhmnTq1HmPGebyoaWM6xaHaAdfOvjelPuGPMX3OKwt9DVVtLvkBTm2ZjE4CJlSAd4BhoY4jgapAK/Vd5SU5AQExHWtnMPQOo5OUKmS/cvomI/cF6ErL/wmG3vRgwIP8uh0ViwV6u4AWVs2H6knp/p/NEsY4rPyEEMNOuedGnXyKRB3RXKOBPKoeCWvwrj3r/MtLu0ly7wSAYyE50Ng86ACTPKu77SfizENO7Cvo8ntQzixT1OEHZgJRDW6I1rDl/XiRna8zhWkb3MJCSlP9FRGLksk1rT31LRAKEKhg6QPD894REL5mbFPTmetLwsX0Kevh3NDu8oTaLQZLHHl7c4UFxtb4VdV6qT1/yssGrIgr7a1fwkqPRzIi31MSZLEuhevS6xMPSr+csbBIsFyf2k4RiixcEgyBlGsQg4FsmZNvsmJh960NbFGLwULppUXPXcFA04h11zAtAuC0bIzJzP6uj/La8S5Y+evNR3O9Dmy6MB87A0PhsPjtdaJNybXs/p7iIHyABmo5H78wP/oyf7TMcvbSQZhb/HsBmXb5oJrVej/dHDqZbh3kF+hK2TIF+RO3ucB7D6fK9hXZocVSOIRGtfTQb2AKNUZ8VQ6L3KgAjDAIyLZzRR3ebzKU6VW5exsfQuZHv62+kHcGYTD9IgI5uJIyzNe0Xoi17D6Wf7RNKUfau1pZVrOWpRQJfEHNg7DYkupZWrBYSAVqsz3gaV7Av1OhpvbvHngVmyc3M0rr204DP+TvNKtYjGY76Cfza0/5GD01PTEVMKSfcK+4semFRxqS4B+ZSrzIhtGBj1OsFUBkXR4kua/VlAwxNOSt1SdOph0QeknME7J33GfoBM2A/9dLLBA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|24121999003|22091999003|19101099003|55001999006|6090799003|19110799012|41001999006|5072599009|8060799015|4140399003|25010399006|52005399003|40105399003|2607281247196008|1602099012|10035399007|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1NhK3RTTDF4bnJ2MnRtTzgwV3B3YklHM1JxTktpSTNIc29ZWDlBRHpxU21o?=
 =?utf-8?B?eHhTMUh5UEF3bE5DSmFhWE93QUtsRU5BZ1BQajZFMHkvZVFrcCtCU0VYbjA5?=
 =?utf-8?B?cGQ0Q0Q3KzFvMDJoQUxYS3BlQ1o5NFc0Rysyd1hQdVk3Ky9xMFRNM0ptTWdT?=
 =?utf-8?B?NjRsd1UzOVI1aG9vUzA0a09KLzBkaFV1RmRDdzAyTHltQVoyLy9vSGNjODdP?=
 =?utf-8?B?QWxlTlczTjFVUlgrRG12Nm5nMzUwL0R6SjlWZ3lYVnRzSnRpVWc2NndmUzc0?=
 =?utf-8?B?SkhsVzU1THMrR2J6V1BJK2JOR0xMcnF2TlpWMDVYK1dIRFJ1QUM1Y2VrVUEx?=
 =?utf-8?B?MUJ3MTdYMEpSWm5BT3k2YXJzajRieHlJWG82M0RsNmNxcDMrR1NZZ3lyQ3hy?=
 =?utf-8?B?aGcwTW93NXJUdVZRVFZ3RVJ2SXlCV3R1UllZN05nQjl2WVVzUWE0NCtiMnZR?=
 =?utf-8?B?TFlTNktpZVJYL1lWOE5iaEdxL2tUd2JFQi93Z3pQVnZ1WkxnZVRnaHNyVzhM?=
 =?utf-8?B?c0htMFdqU2IreTJWNGltQkVYYTRTM3A5OXhWak5KMk15UUlhNU5NWDRCUkxQ?=
 =?utf-8?B?Zk1BV3ZveXltVXk1WTFYbjlEcUtHTUkxa25CenJzNjRFNWQrYlFrcUhNY1Ru?=
 =?utf-8?B?ZEkxNFVWRXBDQkZmUUx1T2xOSW9QWmc2aklNNExIVnhkSjJHdkVpNHRwclNv?=
 =?utf-8?B?MTRxUG45V0E0U1ljc1Iwc05TcnRwZWUrZ3M3QlB1TVdLVkxuN05QVkJ5akpL?=
 =?utf-8?B?dFFkRm9LancvYlFOMk1LZHh4cUk4UjNaMDlOWGJDMGlOVDB2Y3dQbC8vOXQ2?=
 =?utf-8?B?eGxpTmhBQ2NHVldFKzNOMVlkVUVNcjIvNE9iYWhuang5djg2Q0VXeWQ2NEFm?=
 =?utf-8?B?N0R1bjhZV0NvQldKOEZnQmthOXRlSzh2QUZDeHk3S0VQOWZnVUloSGIveGNT?=
 =?utf-8?B?ZlMwOElrTFc5TUh3VkFHMStoRzh2TmFURlBieXhuMUVBUmhiUlFhRmZWeFhR?=
 =?utf-8?B?SnR4akZCTnlpTVBqUnJXVU1nMm9oN1dlYXhzUmNuR3cvMW5KTU9tMVlqZHpP?=
 =?utf-8?B?QVozY0hJbmttNnphMFdYcHlMWXlnaytuOTJwRW9ZakYxbHB2MmEybUtTOFdj?=
 =?utf-8?B?YkRTd2R3MTdJdmlaZ1Y2Qk42azRaUHQ5Rnp6eE9ad1hlNkdYRzQ1RXZuTE40?=
 =?utf-8?B?WmRyczJ4QU4vWXMvcGF2MTJjU0hpcndGVzhEeE1rTklmTHVPa052VXRiZEZl?=
 =?utf-8?B?S1hUNWVJcUJqR3VvV0xVRDFlWE0wK0ZFTUYwc3ZEUGM4RDNkbG9lU1dRTkY2?=
 =?utf-8?B?ekEvbUxUa1llb3dpa1NRZ0x5dzdJZkk2UENXVHhJTlgvTGZnZDZ1UENIdG52?=
 =?utf-8?B?THZMVk5ZYU0wN0ZjUG5kcWduMkhFZFBIUXJUZkp3SnN0VkJGRGx4ak9BOFA4?=
 =?utf-8?B?TmtNaUhScWVaQVlkd1p6YTl6bm1nY29BUnZDZzNWdXk0ZEt4UGdvWUxnMm5a?=
 =?utf-8?B?ajd0dlB6RVY5RjViMFh5MTBoNzJRSEIxVzV6TGlQcGphUXZURHlYeTVFa2l0?=
 =?utf-8?B?MEo5Zz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhiS3pjNndtWW1HQXNjcWJUY3hOdXJXVkgvc3l4YTlaaVExajZUZVZrTktT?=
 =?utf-8?B?SW1pWjgrK2lCZy9CNkp0eVN6cEJqMXBTUzVrV1hzd2o4RjlYS2pGbCtPTTRv?=
 =?utf-8?B?ZnNjM2dzTCtvdTBKUUJuVS9UTVJKTG8raTZRZzA3VU1BKzFuNjBKYUdaRUt3?=
 =?utf-8?B?NXNKZC9YaEI0SFZVMDdoSjNJbjhOaU04bElkUWgvRTU5VTNXc092UW5iaERK?=
 =?utf-8?B?VlZtL2Y1eWlhU09CekRBd2J4Z2dZWlRvQWdkMlkxRGFvazkybGFWa2xDRGFP?=
 =?utf-8?B?aWZSTXc5bEMvcEQ2SVRjZzBnS1NtS2ZQaGJEVzMybHYycmxCVW5ndFNvZkV5?=
 =?utf-8?B?OU1wNk5KTXZKci92b1NBaHdXTStOSUxRbDRoR20vTzdxL0U5a2x3VGFiSWlp?=
 =?utf-8?B?emJLaUhiYVVCMzY0Y0RTelRXWDV3bEx1MEsrSjUxQ0o2blRNTU9TTytsVzZs?=
 =?utf-8?B?V0lySEt3TEQ4bjE3cTlDRlBrSEs3c2V1QmpsY1R3eWJocEZYTTZ2eU9YSGMr?=
 =?utf-8?B?QUYvZ2l6dU5oaUVGOGlDV2VkMUUwRUJLUlFPRzg3Z1JBeGExZ3JMQzJQQ1VX?=
 =?utf-8?B?d2xhWEJsbFB2amZxSGJQZlVvdmduYXhjS0hzbzRoM012c0l6czVvampYL2g4?=
 =?utf-8?B?VFBJcXZDMlhwSDl5MGZnYXVsWFpHSXQ1SmdEVzM2a21IMW1RV0UrMjlhZGtm?=
 =?utf-8?B?UEZYaEplQzZGQU1PWHM1MGhnN1FvdVZPUlpmbmpoSjJjZzJkbzNLTjdtTlVM?=
 =?utf-8?B?S1Q0bVRSdERxR3kyY3hwem1jMThEb1hhU3NhVmxFaFI0UTMxNXpsVDVMR3R6?=
 =?utf-8?B?NTZ4SzBrc2lWeklmTmFYakNpQ2FsNCtjOFNndTQvREdHWmpHOGxuTUwzZEVF?=
 =?utf-8?B?YzRweE5aNGZGM0o2ZHJWc3lyb21UZTJEM0pLUHc5Wk8rcUhuZlBzWS9RUDBX?=
 =?utf-8?B?a1FFTDVnZjExRjJadmJJOE5ydE5lWEFxNURBdDZ1MUc5U1pZQ3pySVRZb0Rv?=
 =?utf-8?B?d1RZTmh2cXp6Q2xtZmVXdjlXdHlvODlqN1hOcXNmditRWVloVmE0WmtidlYy?=
 =?utf-8?B?eG8wblhHSHNiOGdobHVQQ3NaaTdqaXhmN2lFU01YVnloZGhLeFo5cDhaalF6?=
 =?utf-8?B?SEFZRW9jRTNkY0JOUHQ0Vlp0dVpmb0xLSDcvUE5xbFFBenU1S1R6enJxaUt2?=
 =?utf-8?B?SllucDU3WmFXMW1POGh0aEZqcTkrNUpCYUlaY3pCTXBCWkZsNVNEOEZTSkhr?=
 =?utf-8?B?ZElyNGVvZ1FaeUxTU3oyOXZiU29scU8rdThSV0JSeHFVYktpRG9vZjNSWmJr?=
 =?utf-8?B?VWJEUEwxd3BxcUhQL1BzaEVKclF3UFNCSHVvRDFid05mWWM0RnFxcUN1L2lF?=
 =?utf-8?B?QUhiMXh3aldIMmhwQW9xWWMzR3NYeW1IbldtaEFES3Z4ZzVyN1pRRlJ2amlI?=
 =?utf-8?B?ejh1UkZTK2JKVjdTQzdaaGRJcys3ZnIzT3ZwcUZWcnRuNloxL0x4K2RrV3lx?=
 =?utf-8?B?Qm9UUG8wNmhzVm9TOHo5bEhBNDhqRWZDMUxWdEJHdDZNcmt1MXV3QWFrQk45?=
 =?utf-8?B?OUY3U1lnNTdOMmx0UFhEdUVXM2tMeDB1WEdMUFZibmZTdG5Rb3cydlVXbkQx?=
 =?utf-8?B?U2QzVUtFeWNjSm5KaXRiYUtlemFzYXdXQ3pIRXpCY05xSGEyaUZzQkVabE1j?=
 =?utf-8?B?MnRoTTlnbmZkT1VqRVpQSkVSWGNYbUV1aW1zckM5Wkt0aEQ2alkrUnR3K0Jy?=
 =?utf-8?B?YjMzQzJXUGllb29JYkxwOVIrMEdOWVVUWmM4ZURkZ0VWOFRyV3h5dk4wZU5j?=
 =?utf-8?B?M1orSmxVOFFVVk16aGd2T1E3a0F6N1hreHhKUFZ1YWo1aEhGOFczNUhhVkx3?=
 =?utf-8?Q?exK+ZTWKVfugL?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 141af514-c240-4b86-f210-08df19576c75
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:45:39.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR04MB9418


On 9/20/2026 9:09 PM, Pengpeng Hou wrote:
> KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace to reduce the
> stage-2 GPA width while a VM has no vCPUs or memory slots.
>
> AIA initialization can complete with an APLIC and no vCPUs or memory
> slots. The APLIC MMIO device has then been registered, but the existing
> checks still allow userspace to shrink the GPA width below its address.
>
> Reject GPA-width changes after AIA initialization. Both paths hold
> kvm->lock, serializing the width change with AIA initialization.
>
> The issue was found by our static-analysis tool.
>
> Fixes: 7263b4fdb0b2 ("RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE")
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
> Changes since v1: https://lore.kernel.org/r/4852f3b8985c353811fa065e4701d76dc9a7f086.1786512671.git.pengpeng@iscas.ac.cn/
> - No change to the code; retain Anup's Reviewed-by.
> - Rebase and clarify the locking description.
>
>   arch/riscv/kvm/vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083f..66edfaa 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -250,7 +250,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>   		mutex_lock(&kvm->lock);
>   		mutex_lock(&kvm->slots_lock);
>   
> -		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm))
> +		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm) ||
> +		    kvm_riscv_aia_initialized(kvm))
>   			r = -EBUSY;
>   		else
>   			kvm->arch.pgd_levels = new_levels;
>
