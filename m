Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795700949;
	b=vniU4CWLZvZjqViXaS41hcJ1H6pBOS1ZTdYby5/w4Vdr+qx4MAIbejCJGDmKuNmCTsu+
	 co+aIdOONzx1ed8uqZfQ2Nx5f8FViPK34BXxFREFl6I2ygMKYuojKT47/7S+c4hn6Lx5G
	 vJ2VSoX1uBMUJAHrWfFY/jrY278//5QlDf4EgAml2m3qoUwWN7VapHyZyzqSPDJGR0VlT
	 Dr2RL9bq68sDZhjekYoA30jUIBntCaBIuRqg1QzaXHXufFh+r8/p0kSh4OM+I00wMQHna
	 NuN7uOx2TNeLlaDor2uULztrRJJDoGT/Ga0iEu5whno08rFP1StJ8bjJZggAHjDSORw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700949;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=53xb8MMKNgh8v6HO3zl6QWN31CmHGVqjzEvAOvw5T7c=;
	b=TcdsvkWSjLU2TyJ1G7HT8upyvp1aMP5koKoWqL2gble9D1Cv0vQsT/+kd3xGwvfkSbGP
	 qSu6/YNJkS24uYGw5eK36Y+mcDgSygCN6Og4aQuIiUvAni4FX6BRSKgkrwEzzoV915MAy
	 KR2/H8RnbiKsqF416cCpAx/xy50YUStlM2/vjIdO8tn9vEXTqKPmruVHsYq1K3kcywhMy
	 D+MTI5+wXYDM0DN3XANxiaKh/FtFj++1ymd/yIirp3Qv3Vuymk0rhT1ZCIHcnfymUWgE/
	 yquluM0PSyPJsT7PCG1I05WCiWL0vsT2b4ehTvOwEpTGEtBsWSVumJreyNdaZffdLIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=bpmORAEs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.39
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011039.outbound.protection.outlook.com [52.103.43.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA893606A31C;
	Thu, 26 Nov 2026 13:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA893606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=bpmORAEs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBf+YYwX7tZnB5IHzk+bJlBxzL63Xl5Lz1a6zvOs9o0PP+qKmNwNUc3q3CRCqAjBC75KdY5x7qN+WJs5QdcsyVK/MwhExph1mLksQIGh+wlHNYN3W1ROd7LP1rjBCpialHRwooDvAgXgDFrf393lB+n+g7UAFoJAr74G3Kxf7h6G19lFWT0UEmYp6k9yRRS0jzoIPx7sb8EF1j9ebvOD1psfziq4Ywz9m7yW81HCICQ1fvWQe5ag6zS0I3BiuPNf2i4AvuxZhozFsrQxtSBxFh17Q5oNI8dsmNLNzDbc73l+pABcf1SRAU+1Jc1wwUKn4k5wGbVpqliQGgdIdKZV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53xb8MMKNgh8v6HO3zl6QWN31CmHGVqjzEvAOvw5T7c=;
 b=yXFf4D5n5Lr8AvQofwTwvtlaFeHAwsMKIYnpVGC7a6xWbZBQ6OOLFrOK3eASBfqZ6wh9WYpC4bXl24kjfb1fml3arNppBo58Z9zDNJhEdAJttvQNqWxKHUxcFH0AbV2wbky20bhNwuBjegCun0hoWgf795x/Te0H9kue2N0Z8R9DxWLc6r52AcM31Lvx4KcIi+djtljlQcKjActjAMPPfDyzQPnbHrivtSTeFn4ZiGsySk4brPG+gM/PiYWH+0tCY3OUcQz/OncjPkVi3fIN2IWKsLcPfS6C/xqeETCaVpfdq50MWpIKh1kjgO9V4WWhSG4BChSmGOrDFNcXEj0Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53xb8MMKNgh8v6HO3zl6QWN31CmHGVqjzEvAOvw5T7c=;
 b=bpmORAEspG6CXf0Epd/aCrB98P2ZycBUYkHM2ozohSIL5LmtXHwr4x8PkgzfGOezPI1Xfh7+t+tYkp1rZL5HsNjdNeumkIYPiq4ML6KRZxx+Y8luDqXKNv7sNaC8WblGo2v8FsOtHCUEUoj9hm5uFJYT6BxZSUP/wtthjS9PZouJOMnSi87oOvSusz5cR1GEDM9E3bp4aVfa29kvwobehSdglkzw0HtpriqSX749SDEp50ks9WBfZX2rSTqJWM2u0DLqUaxTyazUBh/Gm/9iMhMEx2ltqs3KVoRI2I+XcSJxoa9q2g4rQ3b5S0NDHzwmEgKI3Xb5H2q493XP0wWaMQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15563.jpnprd01.prod.outlook.com (2603:1096:405:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:49:05 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:49:05 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?[PATCH_v2_2/3]_KVM:_x86:_Reevaluate_pending_interr?=
	=?us-ascii?Q?upts_when_hardware-disabling_the_local_APIC?=
Message-ID:
 <OS3PR01MB10251292D59FA84CCF8B5CCECE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Matthew Leach" <matthew.leach@collabora.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <kernel@collabora.com>
In-Reply-To: <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Thu, 26 Nov 2026 13:49:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <03f1f295-6fc7-4e59-941d-aad187db1f69@milk.local>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYYPR01MB15563:EE_
X-MS-Office365-Filtering-Correlation-Id: e1696249-94f3-49c1-a4d0-08df4bc4091e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|25031999004|22091999003|24021099003|55001999006|24121999003|51005399006|25010399006|5072599009|23021999003|6090799003|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtVWDJJM3V2cW1Kc2lITytVSDFOR0ZDS0dNVzQwN0xIYk4zaEN0czJuNzkw?=
 =?utf-8?B?WHJyT1Y2YTl4eTU5dGhoV09YbU8yUEFyUGhiTEVuakc5QXpPd1luV0dSYlNG?=
 =?utf-8?B?WTEwOU5ReUZhNkcyUmcvM0FzdWUwYnlzTzlrVEpvMWVJWjhqMEtpVkIwL25D?=
 =?utf-8?B?L3BvczF1dVk3QzgwMzEyeFRtVWluUEFkSTZUYXg3R09TVitvdUkraXROYVhs?=
 =?utf-8?B?QTBieWdoU2JObnlVNGlpYkE5cUQwN0lpNEUzNXhQZnJVNittNzgyUDRuaS80?=
 =?utf-8?B?NU1SSVIxc1pHa2swcmxIS1hRMnUxSnZadXhEZHlvc3E0Y21XdHpKMEdVVWo0?=
 =?utf-8?B?RnFsdStjQTJkdjlhVk1xT1Z5WEhCUWo3RVNDVGgzYTdNbGtjRDNVRjdXOTBG?=
 =?utf-8?B?SitoOVJlQ21GK0x1N2VuVlZKdTRPR3k3SmxRaGs4SWxZbEJkd011NzU5S2po?=
 =?utf-8?B?ZWdVQzNxUC9xaE90TVV1MDVjTnZHVGhveDV5REF3UUx6cmNJbFBnZ2ZZclZ3?=
 =?utf-8?B?RDdhV05lUWIzMXFiNlVsbHB0OUhxRU1uM3Q0elJsKzYzUkRvTndoM2ZVZzYr?=
 =?utf-8?B?SEYrSlJ6eUlvbTcxVDRuMzg0RVZsNkRRYk5JVjhCb0MzV1RpdTl0NTBBbzNQ?=
 =?utf-8?B?R3ZDTzlrS01VSVRLdUtrd3MvRnIwUUJnbElNVzVvalFPazQ1a0JvMnhCSVVj?=
 =?utf-8?B?YWQzTjFHTzdBNTR5UVFRWkRob3V1TlY3Tkd3ckcrOHZicHNNYVNOQm1OeXRD?=
 =?utf-8?B?cHQ5K2I5dE1yZDVVcWlid0l4ZnN1ZWpaUEFwVDdGaUVpZUxYSVBEZjRId2gv?=
 =?utf-8?B?Q2kyQXpscFRrS0tsZFRDRkxrb3RUTGJPaElPOHVEd2gxeHBWVjQ4b2Y3Qk5p?=
 =?utf-8?B?NFRyRy84SlRWeC84Q3pYRG5GZjRteGFxTWY3M2JQZGtZVUI2QmZrcTRDZ2l0?=
 =?utf-8?B?Ni9DU3BRVVZkUm5tTkh1WEo2ZTlmUXErYkR0V2JIdkRqMmk0V1lPVHdsUTNM?=
 =?utf-8?B?S3hBTVNxaTBsUWVkaHorVEF1SEh5dUlJZTl5SHlPSjlMNHROaE4wbmw5eG5H?=
 =?utf-8?B?Q3FjenVyaTRBdmpGb2h2TkxobHFScFBTcVFzamFvbGlVZWxmSWFkSGdWN2JG?=
 =?utf-8?B?OGhaam5tUDZXWkR4c29nem1iUnJNWlF1TlFsT05QRWdWVTdWNy9FQnBwd2Rh?=
 =?utf-8?B?djBIb0NpeloydTFkTCtOdG1jeTZobWtISzltTy9MVXFVYWtpV3hGN2FUMndK?=
 =?utf-8?B?d3RhREhvbytuYS94ci9CYVhzRHNtWUx6Qk5OQklPVE9tNVhHTGZLVTFtdnBD?=
 =?utf-8?B?S3QyMEcvdWxaZ3R2R1FOczA0ODZXbCtCaTcyc2xHMWZmei9KU2hnVm5LaUtF?=
 =?utf-8?B?a0FndVhwemJnbUNyN3ZydFhtUHQxa3hnMmgwZHJ0QWtWZU5xM2lIWnJ1RWc4?=
 =?utf-8?B?cnFQbjl2OHlHajV2TDhNQU9oMmNoejZSWlc3VnJKSEtHbytMNktISzl2Zmwv?=
 =?utf-8?Q?DWSFiM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZhc1E5YldRRFdWQ3hLQmE1TmNPQmVqcG1janFJdG1mS3dhSTVvRlIvSEM0?=
 =?utf-8?B?WVVKV0U2OFhmdGVCV2w4NEkvMlQ3WHVkK0hzM3VGYnlaTGZvVUV0U2pBVThz?=
 =?utf-8?B?YWtIcnZlMWU0MVQ3ckYzNndSa2pJcngxRXc2MURTNVFIME5aWVBFOXJQd01D?=
 =?utf-8?B?RTRJcGZtYTFQVHk4WU43ZWt3cHNPMnZzNWVJVlRBRVByZCtGczNSS284aHJv?=
 =?utf-8?B?WVFnRkRKSWJua3pVb0JneWlLZDYvSGMvMVRQL0c0bnVQcS9Hdi9LRDNpd01N?=
 =?utf-8?B?cElXMDRkOG0xeFFLSHVFdkRVSGpnZUtzUEhmWDVuOTAxcmVkcXB0MXY0Nlg2?=
 =?utf-8?B?bDZKRUQ3dTJCcklxczNNVlZaTmZ2ME9DS2NmVXIwYm9raStEd2ZZRkxSR0Ev?=
 =?utf-8?B?bHMyNFVoeTd1cWlkc1RlelVxUktNTmZuS3NrQWNqRmU5MmZ2ZzZwZUFQdkpR?=
 =?utf-8?B?L1BoSml2dVAyTW5USlBRQjlBcURRSzdZS1c0eUZqeHlRaWFmbjduTCtQd043?=
 =?utf-8?B?czVqSzlFdVNSa2xtdFJJNWQ2THN6S1NCUG9nSDR0K2ZMR3RmSlcwaDhJUk9M?=
 =?utf-8?B?cEV1dmdjby96aElCMzljNnlrNWM2MitQVTlGU1RMSTZLN094SHk5Mks0TVd2?=
 =?utf-8?B?cWZGMUpNOW1yTWVxNTJHdzJNS2FPeE5kclhQcmd2QTZIMzlXNXpzTStZZkds?=
 =?utf-8?B?SHBoWXVBUEdob1g3eUtrVDU4aGxidTdPZXFJVkpWSVBuWGhiTjBEUHpiRTVM?=
 =?utf-8?B?c3hLb2QwNXJlWlFiOTZKbW1rSUplRGJWRXpCcUhvV2FONTJBeW1VTWJFSE16?=
 =?utf-8?B?ZFVPUS8wcVdScEx6YVJTMmtvZ2tWcGhDM0FublVYcExEVU12clJUK2tMZVho?=
 =?utf-8?B?YjAwdER4b2FtZHJKT2RTMlZta3lVMjN0TFR1ZHRXbXd3MCtRbVlmME8zL0V5?=
 =?utf-8?B?QnpLSWlLajhRVndvdVVIcUY5NGo3dHBCWlNUSzZjNlJnNEdlbGp6L1M2Nktq?=
 =?utf-8?B?S1ZKSHJVdEhSQ0psTFo3TGVGWXIxMVZIZmRYWnhpWXpiaUFsRW1HcnE3KzhL?=
 =?utf-8?B?bDJFQW9FTm5PWFpxQ3pBeXNuNGVURk9wQTIzdEdRMW5oWHduajcwRWpqOWNs?=
 =?utf-8?B?VXVqRzh0MzNQdGhXS05mZWpCN0F2V0EyNGNjNGM0aWx6eEwxKzdqVEJFQ3Zy?=
 =?utf-8?B?cmM3ck52TjlENkc2SlFHK3BibjJZNWVLNllLelMraGhHd2t4UVlMZ3dia0ZL?=
 =?utf-8?B?U3c2VGVaRVV6TEVrUFoyQTB4S3N6UFV4YlJxdUltYmRGSWdFN2NpQlUrRWo4?=
 =?utf-8?B?cS9jRXBReFZ2eXg1NlRTUVdrZlJ3dWxhV1pCQXRSMS8zRXNWYnBvSXpRZCtD?=
 =?utf-8?B?S3dTaStFMHZVUXBsODRYYUtZeitDVFdBdG9hdUdOQXQ1Qm52NjRUOHpCSEJZ?=
 =?utf-8?B?Um12QUs4d2NLVzhXdGtPM2hIeWtkdSt5Wm1NZ1VJR3Y4K1dCczdhOUdDSkhl?=
 =?utf-8?B?ajYwRVBEQWxGWW1ISHFVU1kzN056NEF2eUU0d2JmK2pjdS80enVIUVlvcG9o?=
 =?utf-8?B?VmtWV1BRazBmaFhHV2tUWGIwU1hPR3FEUFA4NHdGeHZ2ODE1OTN2eWh6dmZN?=
 =?utf-8?B?MUQxSlZTbDlsRmE5WEJXR3NnazNCbktzZThLVUtSM0ZlbU01NWZuZDBoRzFv?=
 =?utf-8?B?VjNyMjBIT0xyRFdBdFdsSXRVSWJDTThaRVJwaEhFdlUzNDFiR0gyQ2RNL0cz?=
 =?utf-8?B?V2tRL3dlUU0wSXA1ZmlhWmFDaXhsd2lEcENjelc3K3lrcFRWem9Qb0IrbGRm?=
 =?utf-8?B?YWYwOXBMVklrekttYWxDUHJnY1Nsc1lnUmxFU1BWVjVEU2dXVk94cTNLaUJD?=
 =?utf-8?Q?1IJJfjUdAgiwZ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e1696249-94f3-49c1-a4d0-08df4bc4091e
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:49:05.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15563

Hardware-disabling the APIC through IA32_APIC_BASE turns LINT0 into the
INTR pin, so a PIC interrupt latched while LVT0 was masked becomes
injectable.  As with unmasking LVT0, KVM must request KVM_REQ_EVENT, or
the interrupt is never injected.

Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 arch/x86/kvm/lapic.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index c1f819a0ab2fd..86206cd47bc61 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2827,6 +2827,7 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu=
, u64 value)
 		} else {
 			static_branch_inc(&apic_hw_disabled.key);
 			atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
+			kvm_make_request(KVM_REQ_EVENT, vcpu);
 		}
 	}
=20
--=20
2.56.1

