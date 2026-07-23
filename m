Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012051.outbound.protection.outlook.com [52.103.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF683E3D93;
	Thu, 23 Jul 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793540; cv=fail; b=oFfUlbxL54Wc6sGiF/uYFFbyQn6yrOfyFMCB+dNZFFF4lfr28NlUeKu6eUntinEHCP2hw66dsIZnvKOzvtUmW04a/1H0PmwhpN4CBLpX5/g8ESVa0LECC1ILH678Hj3pbtZ2b+ORnoxwrLDL66SWH+M3r4ZQ+z6hgYHbvxYyCrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793540; c=relaxed/simple;
	bh=ENBOtOeEscL6c/CkLZMJRIKplyPCjFJVv6UVvpldF3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwjYnPnKdnmDg2L6Wzi1RaJ7kK9Njo7snVe/PVVJsl8tKwCDz9ZQXD94GrG9woKRyexy0vw8g2YtQPivK83UfNe4JbrdwYnoFq+W0qZM5AIisQ3z9MZKwRpXWEbDoUEaifq+88/vS3DDAgb7miJOkSXnr4TpS+/QAnC1PL6u8NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=SgPNuBj0; arc=fail smtp.client-ip=52.103.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SgPNuBj0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRV0uAq/zJ5LO2cKmMBarL81tU+/783aeqnQHl81F2ErpUxi5ue+jUxk5g4WywLAGGcrBkHDJyRgbKbEs1JNeET8+W24Ha8lR4y0DJ/etVI4LL1c2KX/fBE4gCkSHplsJrK4akQn3JROzjF3d2wTCPRZVsktamXYChgS+QSPcbNt40d8hYxzjoNxAtcJW4phwVHVnVBFCK/zxfNXIfV+05UnFdgtso5zzg+GSZuQrnJyrZouQ7mVd5MmmYhxponCWH7h1evyqIrtT3/Dkylya5o4J+zNu5BGSrBlldH16jjSl1+F6p3tdDM/u531FsnaTSjSqGq9W49+pZ8T82PbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTWppCNywUMJwMJDMxU1XaTV1bw/7tF//tybjGEQ6/A=;
 b=JvRKpFvxYKklE1lQ0ExjSwkDGbCKGe7tw+db1mxTtVx++6YtI+dsXNYYcu2cZlk9n4pSFqnVHArRzYGLf+hdj1V/YVXsRwIycYjtHv6qCtXkbb5ap6A4sVDg9dusJTtBe9y4GufnhlG7GV/3A2alm6s9QqzhK7HKhYTiaXIsKgdO86nmXTJ9TiOqLqXehUKweDX26vY4zhclXCwix5oyOkqmmOZEsArgNth/rvsh7au4KIcHZdR/iR57npiCAY+ssJolcFcth+5ZGbqsEIKcHu42rsUN6gnHUfZwj4rAETnjVd9Em5NkYfwXULK2yjDQohGYC9FehY3GH6xIEKec7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTWppCNywUMJwMJDMxU1XaTV1bw/7tF//tybjGEQ6/A=;
 b=SgPNuBj0CRiBbU+qhNVPwDaiC1+V3HjTvKZlZmhernY+uqQeigt03AWNeciWEHSmiZqqPAzX5b3yrDpcZeQAlvjL/lxZvgN/24dJo3WrmEwd+Tp0CVkzpBOphk2A0dDg6ngjDhq3QBAGB7nf4UeVSFO7yizRyzq7PAuSVx0XDf+6mV+ns8vNjBbRE2NcQWqLWK5xfvMuRJjAleranlDD2Qxj5K1nhTkK5LcZSxkuOhstMQc8U7S+UW92Eog1bM+RWyREvInqslqWZmHhTpMyj5PAl3YbrQC6i/xjgHU369QuT5XUyeTCQIIZJ/Ht0jWrM4W8cz4hQDLI4uRSTNk3eg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KUYPR04MB9536.apcprd04.prod.outlook.com (2603:1096:d10:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.16; Thu, 23 Jul
 2026 07:58:51 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 07:58:51 +0000
Message-ID:
 <SE3PR04MB8922D15851D5F0167E65F63AF3C02@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 23 Jul 2026 15:58:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] KVM: RISC-V: Clear former VCPU cache on
 virtualization disable
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>, Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
 <20260721-kvm-cpu-pm-v4-1-146bf942547d@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260721-kvm-cpu-pm-v4-1-146bf942547d@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <6f3ada0d-4dd2-4419-bfb3-7dbc4e80295e@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KUYPR04MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: aad5ef2e-2d8d-47ed-9acd-08dee8903b35
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2OBesNPSjYbOUimaFtzI2zfAiP6GJs9T0ryKbkVVJPV9UPnz/EpauxJrPopMcHs7UelwnhCDF2/s/NJZA4n7UOJuLOGmaCHZO4K7zvW0Kys2cbR0rkCUutBGMeMeCL/5pm3cc7KX12v1oLgWo4vUZvm3U7qqbJSuaMKGHLsN5T0Thrrz/TWAiDSt4KLJUFCmwVHhSa9cfgUJOg5l1cpzqiWTFmUdk89ljka+wQQkBy0xRU4yZ28ddlbia1yRCm9gL6ArdgoVq1iFG+2jCUeNUOeL75G7/KRIOKL/xTmHi7fWP4l0Ec/x101iABjLxs2YRtnm3Sv69cDvUZEiUCxjOjWQexynQbQK6xivqNIZsijcmddaY/tUPRr/QEhdGlEF9/k5WLyRNJzT3FinAxIFOWthRgMPPCNFfb2GtyLho/cZzVmb72Y9twNI09YhejD9tcfIzQgMuGAktOq0QeQDFvLHcj4jj480iZ/AQt8VWLBCVxSJU+Fk9hWj+1A1mZxZ7fbz03LWK81kiGoHalzti0EfojcaJKbOBVfTLvfl/ohggSk/CMVyhax3WEMwnQuzPJ41B0A9MPgb5wG621d620L0LjI/KVvwa9W+FJFi93kK2CXMqC3mTpnAYVRWW7+pcgWN1pNoAd2lsBq6x1nddhpIN6gi9ZIh+g+ZSRcKm3FMRUJolJX3PcUA4CmYKyPiloWp1ElJN50bY0Ns0WIv15s+S1R3x5uU9lo7as+LS3t9OhVJ+/ZJH4a5Rw1BZhpG7/b2SLbk+sXb624MQnCX82P6P1XLrlSaE
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22121099003|15080799012|55001999006|6090799003|8060799015|19101099003|39105399006|22091999003|4140399003|5072599009|19110799012|25010399006|24121999003|23021999003|40105399003|41105399003|26121999007|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnpkVnlyS2hIRms2MllLeFhzRlBCdUQ4VGkxVE1DdVF2NVBOZVp5dWNNRHJB?=
 =?utf-8?B?QTJOV0N0RFF6dkZkcEd0a0szc3g4NUNNNXBPLzR4ZzlsRjBXZ2k5Q1JaK1Vq?=
 =?utf-8?B?MHJNQmpOMUxlRkFQZFByZFBNTUczcFRzU0E3TkpReFFrU0JHT09sbGtjRmhW?=
 =?utf-8?B?TFJxNzNXWTdhTGhNNnRUMWlxbnR5TXBGVUl2c3BhbEFDTWRJVFBFQ01TcEww?=
 =?utf-8?B?ZHlwL2NUQ29scitoZnF4YTBMT1Z6bGxFY0ZzYW1yQmFxNW1KM0x2YnFCdTJG?=
 =?utf-8?B?czFOaGNFSXU5S0RiL0ovMm44SXZybzJlaVlLZ0VCb2dBSTYwMHdCVUdjVjNE?=
 =?utf-8?B?NWRNYmNxMTVmalZQV1FyUmNiVFZsVEQ5QldheHgrWUdxVDlqNkVoSlJkeENL?=
 =?utf-8?B?ck5xaG4rSURqbUUxM3ZWeWIyMEJ1S2xuSnJ4ZkpUODQ0QnRJMlJwcXIwaEgz?=
 =?utf-8?B?OWVqQ2h1SnhXQ3pCUDFNWHo3SVNacm40by9GQ0V2UlFpNXBOd1ExR0VWVGVQ?=
 =?utf-8?B?TzFuMUd3N3EzVEVldE4zWVROMVVyWEtpTFowQlRUVUpqeFlLZ0NvSVBtUE11?=
 =?utf-8?B?VUVwZnlDNHVkSUZmZm1tRjF6UW9rZWFRMXZaYVNKOVJ1NHJ6eVVoTUdycCt6?=
 =?utf-8?B?YXlhb0U4aFc3czd0SnMrRVZvSnl0MWc5bDhvYkdRc2VPVlJZT256Z09ia3Iz?=
 =?utf-8?B?MGVzc1JFb3BsTXRnM0JhNWtUeURJYmxVUVlibnpaVzhpMUpNMFN0ODl5KzVF?=
 =?utf-8?B?RE14NzBvYVFwRlBReTNVTVh1cU5zYlBDYTZrU1dIRm9ZQnZNc0FycTQ0b1ln?=
 =?utf-8?B?aU50YU1NcTJtNUJmbCtKRkVxaCs1bWQ5L0JWRkpycWZmSG5JaThJd01EMWtQ?=
 =?utf-8?B?Q2wyQVQzK3hoTHFNajVQWHBqQnYvK1dwbEtwUHNURGlYUDVpTWhIZmhUYnVn?=
 =?utf-8?B?SXBQWm9icU9oVXZ5eTBjZFh0YU1UOW0yNldXSkFjTHJxWVZVNXVWZFNtdXA1?=
 =?utf-8?B?TXU4R1h3T1RYbW52bGpqTGcvdXpQT0E0TWlycVpMeHhqUWxrd1M5MS9kV3lL?=
 =?utf-8?B?V2dPZkR2Z1VkaWoxWGhBV040WkQ5N2NqV0Erb09xMUpoN0FKbGxmN28wMnh6?=
 =?utf-8?B?Zm9BZWk4SXFJRUNUNWUxMXdMbDNSK2paaHkzY3M5RmdpYm5UaUs0VnFaSE13?=
 =?utf-8?B?aFNJenhDSW5kNG5pSExSK0ZIU25KMkVVZEhwUVVjOCtXMEtvK1lNWFU5QmFM?=
 =?utf-8?B?SzFmSGNML053K01WVW1hU2VKQmJodHNYbmFqb2lWeVh2MjY2MTVVWlRwR3VM?=
 =?utf-8?B?elI1Z1dFMVEzelRiNWc0eFZ3cTV5SVFKRStXSjZNeXRnQ3JCSUVPcnlSZnZL?=
 =?utf-8?B?QllGOHpNM0JJZTU5YVR2UHdLUExuZ3J4TEpQWW4wRm9FaEtzbTEvbXUrS25Z?=
 =?utf-8?B?QnpZei9VMFJNcXdhQWk3OFZERjA5ai9vNk05Yll0eTBoQ2x2Y1VmRFJYVGVZ?=
 =?utf-8?B?aGZtdzZ4ZVAvQ0d6dDNSQkhHeGtDdVdWOG0zMHE1blhma3NYTFE3T2Jha1hC?=
 =?utf-8?B?dXBodz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NWOWIvKys3Rk1uOVBqRzhMVE1LMkdoTDBNamlsemVlQTlLSW1aOVRQbXZ0?=
 =?utf-8?B?bzNJUHVWdElnSGltQ2RwNVgzUTVnZWh2T0JPSmwvNXNKU2RNbGFaa20yWC9p?=
 =?utf-8?B?bjF4Q1M0TmR1UGRlcTJ5YzN2dHhGUktZd2NyUmFUSG5SSktQZXJWN1JDbTlJ?=
 =?utf-8?B?TU1FWSttMjVGNGlnejR6aXBvQjRVU29CTVA5T01UeGM1bHYwTFZ1Q1ZGay9j?=
 =?utf-8?B?NG1EbVpHZE8zMG1KTGZyemVzUFdaVnpMRXFkakRldU41V2dMZVpGTmN0dE52?=
 =?utf-8?B?ZWdpSElscUJpWkRMdEJYeXpGR2FUcDNub1ZuSytKVDF5anM4cFFlZWUrQU1q?=
 =?utf-8?B?aEMzamhQQ041NkdGb2FrOUdUS1l0M1lLWGNGSTVLWWFNNDlNdndSOVVWa3dH?=
 =?utf-8?B?SVJTcVhneEJ4djg3QXFBKzNKclc2dXpvNDJqeStCdVZsREh4OGFZb0tWK3VU?=
 =?utf-8?B?T29rVjJoT21QR1dkSWlIeFc4VUtFK0F6VFlYYi9mY09SNHBBZjVpZEtiWnFh?=
 =?utf-8?B?NU5QWnY1WXU4QWJIRzRnMml1R0FLYWpSN3JUaXhxZE9EY0RjdFVLMmFQQkpH?=
 =?utf-8?B?R3U2WEI0Nmp0QThXL3J5TDhXNGoyZjhWL3JrYjhxem1rTnVYa2tuVFNXMElu?=
 =?utf-8?B?dGRnU0U5aTJlZWNpYWJIUkNzWlhLdUlWaWxmVm1VV1YwakorOFlBbFBkT2w3?=
 =?utf-8?B?NUFudDBHWStLd0NNNXpZSFBwUi9rUjNDRmJXRFFQdEt4Z093THFZNUtleWFE?=
 =?utf-8?B?cDA2YTgwRGNBdVJSVWdneC83RzJjbEZ6YlBuTnNyMHZzd3Y3bXdSZm10dnpL?=
 =?utf-8?B?N21kYTQxNmdKdVZkK1ZvYzVaTEc1Nm5ZbWgrUnhWRXFhVml0KzB4SFd6UXJJ?=
 =?utf-8?B?VUo5L3poTnhQaG8zeWRxU21ud2Fzb29xM04vSStPTktSU0hXVnpMQ3gvU0RC?=
 =?utf-8?B?QllPK0doYkZsTWpPS21YSk9aTUZQNVNQMjBFcFNqVGhQeldyZW5Wa01UWFdo?=
 =?utf-8?B?SytuYlA2a0dFM1RGaUFCRmg5Sm50a3diUURRd3oxYjM3YW1pSUQ1WnFWRGph?=
 =?utf-8?B?YXFMakpJQUo0aTA1L0V5bng1WUhFNzVrbzl3YWk4aENvVVltZ1ZwN3VvTWt6?=
 =?utf-8?B?SGdscGprMHBUd0l6ZnhQbEhSUmwxNE1KcDZWSTAyajEzSEhJdEdkQkpQdHFV?=
 =?utf-8?B?elVGMk91ZUVSbEZvOFVkMS9XTmtxNU1nUDQ4OG11SWM4dVhQU0tuc3NMeW1K?=
 =?utf-8?B?UVNRbmhtT0pGZkwyOGJ5b1BaQXhxbXI2djBVbWwxUzY4RGV5RnZYYmx5Y3hC?=
 =?utf-8?B?d05qN2NlVGdGcVlJOHlWZlhXaG0vWUE0UFNJL3kyK0xOMVN5aU9iSGg5M0tw?=
 =?utf-8?B?MnZjMG1GS2tEZ3puVkpVbWV2eU9vSGZVM3ZYTXp5V1lmNEt5REM0bVlhSzVB?=
 =?utf-8?B?MTNrK3NBL0c2TWJ1aVh4V2RYVUNHbmlSbWFzTHdUbDMvQk5UU1JuYlR2WXNQ?=
 =?utf-8?B?SUoranN5eGw0Rmd4bURVczd4MXc1cXRaWFplNkxRbGNSdXg0eHhnSnlzRS9m?=
 =?utf-8?B?R1BGL0hPblJSaDMzU1p4b0lBWWpLTkx0UjUzMWRSZ2VPOFBoMG9xak9ZeWVJ?=
 =?utf-8?B?RVNXY2RHTFlGRHgya0RQOVBiNy9NUFVPMUh1aWFzRk53ampxazJrT1RrYk1E?=
 =?utf-8?B?RjJNTlBuVUJsSTU0VFdjSXBtYXhZWXljeUZUdWxNR2tpMGxtcWlWUzVQckR2?=
 =?utf-8?B?MGR0emRVVDZpSHdqV2VORmFFNmVmZy9rY3ByT1ZGQVFEUnRjK2c4cTNRMDhX?=
 =?utf-8?B?Ylk4ZDJTYk5WM1lvL1dYZ3pMLy9JdGdwaEFnL3BWc01XbUZLNW81TEQ4UGdY?=
 =?utf-8?Q?rYUpk/6h2687Z?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aad5ef2e-2d8d-47ed-9acd-08dee8903b35
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:58:51.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR04MB9536


On 7/22/2026 1:52 PM, Yong-Xuan Wang wrote:
> When a CPU is taken offline or enters deep idle states, hypervisor CSR
> state is lost. The kvm_former_vcpu fast-path optimization caches the
> last VCPU that ran on each CPU to avoid expensive CSR restoration when
> the same VCPU is re-scheduled on the same CPU. However, if this cache
> is not cleared when CSR state is lost, the next VCPU entry will
> incorrectly skip CSR restoration, leading to corrupt hypervisor state.
>
> Add kvm_riscv_clear_former_vcpu() to invalidate the per-CPU cache and
> call it from kvm_arch_disable_virtualization_cpu() to ensure proper CSR
> restoration after CPU offline or system suspend events.
>
> Fixes: 1323a5cfe52c ("KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core")
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/include/asm/kvm_host.h |  2 ++
>   arch/riscv/kvm/main.c             |  2 ++
>   arch/riscv/kvm/vcpu.c             | 11 +++++++++++
>   3 files changed, 15 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 60017ceec9d2..808b4ee1bd10 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -319,6 +319,8 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
>   
>   void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>   
> +void kvm_riscv_clear_former_vcpu(void);
> +
>   /* Flags representing implementation specific details */
>   DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>   
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0924c75100a2..350e4f097d6e 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -69,6 +69,8 @@ void kvm_arch_disable_virtualization_cpu(void)
>   	csr_write(CSR_HEDELEG, 0);
>   	csr_write(CSR_HIDELEG, 0);
>   
> +	kvm_riscv_clear_former_vcpu();
> +
>   	kvm_riscv_nacl_disable();
>   }
>   
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e2..e48338f907f4 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -26,6 +26,17 @@
>   
>   static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
>   
> +void kvm_riscv_clear_former_vcpu(void)
> +{
> +	/*
> +	 * Clear the per-CPU former VCPU pointer because hypervisor CSR state
> +	 * will be lost. This ensures that the next VCPU entry will properly
> +	 * restore all CSRs instead of incorrectly skipping CSR restoration
> +	 * via the fast-path optimization.
> +	 */
> +	__this_cpu_write(kvm_former_vcpu, NULL);
> +}
> +
>   const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
>   	KVM_GENERIC_VCPU_STATS(),
>   	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
>
