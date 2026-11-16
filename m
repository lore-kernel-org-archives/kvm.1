Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794838645;
	b=hWD6byWadN44m6K9loGl5AZLwzEeVFqPhX+i6xKawwcGqEUagWHIDA8KZpWXMLYOIzJ2
	 Ntu/0LFDH7j/NoZyBDPDSoI1G8CMeFW5Uu/72r6DoQTRayk6da4nba8sb3pUCC939YBoP
	 E0Km8OgNfusD1dqqVqJ7tsQeAxBLHMdaT/YsnOoMbsXKUjlxcIrk4aNGZ0aRcfrQ+Bp1Q
	 QAkKRLG2dkOXbbBxfwEZZaSc0PN9770cJNT0nCwHdUYQycT5EcfK9eXTtIjTfqU1/U1jb
	 WE/TMyn8WNFgAPtjSDAX6njxDNsAxtF18Tv0qJ2OCkFMR7SMHAl6ylGC+MmOzW0LOKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838645;
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
	bh=tRSOs2rYnUgynPODANacZyiud0KAfal9yQ/MAzmJUdw=;
	b=JaAiomgTlHZh8aGc8YBkleLjZodLgnKooT4R5BlIYuVol+Q+DLSqR/d7+tsV/RqM54Ec
	 /PTVohPl9S1NgZj6J3Zk6SpGVzpmOTpfJ78qoejGyFaSKOB2rYHbVVbq78XDqONBrzoS0
	 ZUjTBOzX98xdlG2611xHE80Q+k66RvgdjD67X/Gfp+qT5jhJd2SZcVA0V6zv568LJnfrg
	 etWuJ+JV/ZCyIXQp2NsiWt1/Ga4KlGZBLTdjMQwlccsB4Tx228U2pVLHB/9OTo9+cfFYe
	 W7w1pZYzaDm3Q+76gu1tLOObCJECILE8DKOlxpKBKk+eUK5WFsUSl+tMo+oymiOD0cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=N4e14esT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.8
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011008.outbound.protection.outlook.com [52.103.66.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B1606A323;
	Mon, 16 Nov 2026 14:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5B1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=N4e14esT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/tIlYBQdWo6ApzGHa+CGjumUN7iVRTeK1sreqh2j8RRWOnEJ4b48iMkDprIxodLVcMvr9bcrmoGJUAxULDj+RoXny1YtbyxXGY+LBMjz/Ij6An6Jp2xtFRBO9igmOO9Ah04qISEWNjDa4nPIwXih7lNlKt2habxzg9JVQsnzYpoVem9EOBkh6n4X4jtm5hytRlKy2Hj2zYelLkzfIOsieGAEBAAwzsnU1Pp3J7UvG4mhvumdG58tsBbGJKBbcYky7xYyLANW+eV8ZHJMn7/HYESYHLYRCdhdlvqzDc42Hpp/YQnM0m15i+C5k1krKrcFDTB4flX1zA5P5/4BTTgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRSOs2rYnUgynPODANacZyiud0KAfal9yQ/MAzmJUdw=;
 b=iOhvurMT5ydgWt56Pw6MJo3L4G9yorFXex9adbsijfPKt2ruEKCemjbZSuhXlWb6gy9d9vPEHnvB0qfBVLU1eIhD7Y544hCk5aKgT/4Hbgi978UAAqAlGUAaxVMnhqoFdvc1VCJP5NZs5NtIG2zwEErQunacKyK0U9j6V+qk3fkL1SCb74A+vD+n0OjWE4IepMYOUX1JGDL9+yOGZLoXgHJHmLuu1/fWdzL2bSldZjd4vSsScA67MVfiqion/aS9gDJj9daUo/WCC2deNE5SRJxNsPLKcPHqhMbmxIbwc4QAZYa90SRQuQ4bA7DO6qsicRTLm71sbPJMYUEMcHo/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRSOs2rYnUgynPODANacZyiud0KAfal9yQ/MAzmJUdw=;
 b=N4e14esTsdoe4jrPXXO3aHlaYNYfrd4lYYAg0yG9kk5niJY+ygevbRKTOviQ6ULAPrIlOLOIgx/jrfqq9ypKFvHi72g6a08fEU7BTTuQvvkZGRItJNYPA8kGeky/mr2xRtv/MZdd4dEL2ulVLB035SSa2qvhsfVG0QDYwfeQn+vjtmM8GQXJ769zPVl65oiTQqzmCQdMr7NpXGoD7fe00xDZHZDgQsZCPQ51S0TmsqnOHCVtJTJ6dvSOkAfD8NprcxLo1KaqcMgkzbDw1YZ48ZoBvdaEOhP/DZUng1wxqmq2HAM/woagZQxnZ7AtwwLHrZqMmhwRrrXz4xmqMsKRRg==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY7PR01MB18039.jpnprd01.prod.outlook.com (2603:1096:405:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:17:22 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:17:21 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?Re:_[PATCH]_KVM:_x86:_Reevaluate_pending_interrupt?=
	=?us-ascii?Q?s_when_enabling_ExtINT_through_LVT0?=
Message-ID:
 <OS3PR01MB10251C0B5CDCF9538DA3A1727E77C2@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Sean Christopherson" <seanjc@google.com>
Cc: "Matthew Leach" <matthew.leach@collabora.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <kernel@collabora.com>
In-Reply-To: <auuQ8pE439EB63tm@google.com>
References: <auuQ8pE439EB63tm@google.com>
Date: Mon, 16 Nov 2026 14:17:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <79753798-5fec-461b-9767-411d1c765022@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY7PR01MB18039:EE_
X-MS-Office365-Filtering-Correlation-Id: 336c3f7e-296c-4ada-f8ef-08df43ec5467
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|12121999013|22091999003|24121999003|6090799003|24071999003|23021999003|24021099003|15080799012|55001999006|19110799012|5072599009|8060799015|20031999006|39105399006|25010399006|4140399003|40105399003|440099028|3412199025|25131999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0luNG1yY2ppY2lpRmE1bEIvVnlkckpQbHhjZ3JDK1R5NzZXT3ArUm10MUNj?=
 =?utf-8?B?VThSTyt1cDFhZVFtMTdsTjBadDhZNUR2b3VFbjlCYUNhSGdvWjMyMEJqRTIx?=
 =?utf-8?B?NFJNZ0pZT2VqZ1o3QUZIaGdxYTc4eWUxc3BKL1hLZnltUFZIWURpdEhJbzZB?=
 =?utf-8?B?c2xUeGxBN2VPZW81c3NuR0wza1BvNUtZd3M5U200aW1XWCs0RndpWXprbGdK?=
 =?utf-8?B?S0JoTFRGdWx2VzI0NXZGSUEzL1BaMWlYUThXdk1aV2dzZHFPTHljZzZOSXFr?=
 =?utf-8?B?VFVwTmUvcmtFREpZYjFQVlV1WEs2ZGY3NXZaeGRxVUx6RnlMUUhNRkRKbmYr?=
 =?utf-8?B?cG90bjFkK0xEKzFNQ1VlZVNBWWFIT0RuQ0tFakNjTUk5NGZwOUZzZ3habHZI?=
 =?utf-8?B?dWVRbFZQSlA4OXFsWDdoeE54TG1pNkgwc2NzYTNlYi9sM0lKR3NQaDdLSWdh?=
 =?utf-8?B?KzR3Y1ZtR3JreUZ5RERsTHRZYUFwdXl5RDc1U0Znck9VOUVUTjRvUXllQXo2?=
 =?utf-8?B?K29pUEU3THltamxINC9wQ3hTdWpMWDA0V3NyRTRldWlHNGZYWFpxOUFQM2JP?=
 =?utf-8?B?SWJXRCs2N1BqNnFvaStxbzJ5bFd5NWVidjhXQTZRaUFXN2RLbmY2OFNLeXpt?=
 =?utf-8?B?RHVXUUxMYlEvWm9JZnBZY25sdDFVc2RwWjhxTXBHOWpoWUlvUU55WVQ2akFB?=
 =?utf-8?B?ZXRSckg1ZlZBc3BzeFZQWk1KVGR2VmF6amppSlowMFE2ZUd3UlZBK0ZHbXly?=
 =?utf-8?B?Tk9LZzI4aEtMMWVuU1FBVVR3eUpNd0VWUDBsZy94NVF2a25NTXFleHNIaHdR?=
 =?utf-8?B?WWExNTFXRnMwK2c3a0o5VEY4cjNBNEdaUi93WWpzRVpDUnhwOXRrN2pWYndT?=
 =?utf-8?B?TzJqcTkxR1hCRm1VdW5pa0FxaXo3YWk2aEdvckxkUTh6Y0EwUStEL2c2aS9R?=
 =?utf-8?B?Mjk5YjNqNFFoVnY4MUxrc0Y4TElpcmUvc2owbnExR3RLQW96emo0VC9ldkkr?=
 =?utf-8?B?QXY2V1BEQjRvYXJ6c2szL2psVkF0cVB5V1BRQ0R3VSs0YnZqUHpjMlhrTmZw?=
 =?utf-8?B?RExuc2R5Yy9UVkNGK0xtNFNYbUlOSnhZaDgxVnBGWVB4ekpRS0pGT1NQNjFC?=
 =?utf-8?B?SUdMa0V0S3NtYUw0czlsV1NaWFpBRG5RaFdZTjJCUmxYV2Nab2twZzRYa01o?=
 =?utf-8?B?S3BKM0ZIZis1YWRRRGFQU0R3cUJoMW5acjJRd2xmU2RzUFBHNC9ITURWZE1a?=
 =?utf-8?B?a3lOYlVGOExMc2QwRlJCMWxBVS91Mk1DYVNhL0FVSlhQWVI2WXNFejkrV21N?=
 =?utf-8?B?ZGc0OWdudDBtbGZMbEtFczNhdU15eWZnVVllWXkzcENDdTRONGN4bGhBZUtv?=
 =?utf-8?B?Q0RxbWppQjJ4RE90UVJTWTB5Nzl3cExXMDZENk9VRy91RGhoNXRZNTQ0eTQ3?=
 =?utf-8?B?V2dPTy9jeG5vVHBVaC8vbGQxeUZqTGRYUlZ0QlFTcGIwcjdXQnp5b1lzVjhM?=
 =?utf-8?B?MWxnb2hwNzRFZGZBRFBFb0NTY1AzOGtKcXpaRUNOU1ljcGU4TjNRTXplMGVV?=
 =?utf-8?B?ZE1nazJSWUtTQTRBTUFCelcyWEcvZFJNcHN1RDcwSi9TYUFqV1Z4MHpnUlhI?=
 =?utf-8?Q?/9eEljoBjpeZfSNLgr87nz+jNqdco4l/aKalIANthSno=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WERPQm11TzU5K2FTV3VrL2ZJK3RFNm1VcHlsbGk2Vk9WU2c3Z2VOYUV3SkJV?=
 =?utf-8?B?WVQ3MFNkNTFvYmZjcCtiQ3ZBaWVoc0xSU3E1aUdiUndkOFNGajY3T09jQmFZ?=
 =?utf-8?B?SUtWOWJSTFhXNVFKMTIyN0p3enV3Z2tJMElLdmhZbjhkMHpLY3dmTTk5dnZu?=
 =?utf-8?B?UFpXKzZxK2JUSG9UWldXaXhUd3lCWDFSVThMWW5wVXhKd25PYzNIQi81MC9j?=
 =?utf-8?B?U3QvQzQreDZ2SXBEeWs2QmQwaEIvZHpsV3JKcDBzRUxONDVOYUs2OU5OQ0pE?=
 =?utf-8?B?eFFiazNlU2J4aTQwSVdzcVFFZUJiSDk5T2s0L05IZXlWdW1IRzd6SEVXV29D?=
 =?utf-8?B?Zlh0T0wxeWlMdzBuUEgrTE5IYysrYmV1MDVBYTlwT0lXMjk2TzJwNUpnM0xY?=
 =?utf-8?B?eHhCR2JvM0ZQYzV3aXFCaFNXZllyZDJYNW14WGt1MUFZai8yZTYwNnV1Mmgz?=
 =?utf-8?B?UUdjQnpYQ25IZlMwSzVaUE5tRGg4Ky9aMmcvcUVLZ3JJdGY3bUNOTnJDVlNm?=
 =?utf-8?B?a1p6VVVma2V0VG5lSmhHQ05hVStKenIwUkF4UGdyWDVkQ0ZXa1Yrd0hBVHdu?=
 =?utf-8?B?d1ZDQm5IR1p4VFpETlJrUVFZVlRMbnRRTjZYN1A5OUFVc01vdng3VGdId3lP?=
 =?utf-8?B?UDY0NlhCei9lVDdjSEZjL0I1YklyYmhlcUJEN0RyYzRaYldKTmFHZW9jOHUv?=
 =?utf-8?B?dG5kd0ZpTGF3b1NaOWx1ZjdJdVZuUTJES0d2UTd2Y0I1OUtwY2YxaDVaOWNk?=
 =?utf-8?B?dVVEZnVUZHUwRllQUC9nOGNTR3MvNlFiVDBDd0NwU29wMW80NE96cmpFdEJC?=
 =?utf-8?B?cFNWOVRHMG9sS0Q5akpXVEpFNkNDamNtRnRBL2FCendMZ3g4YWJ2VTJhdzVE?=
 =?utf-8?B?TGFScWhTcFF3NjRkQWRUQ2dZcEJFZVZ0UFN0RSt1S0h5YzV3cmpNSy9ueG5u?=
 =?utf-8?B?VzJIcmFjdmloakZQWDBsWHVsejh6bGY2eXZIV21mYnkxR0ppWDVPbFc4VmpC?=
 =?utf-8?B?WWlabCs2N2QwT2JUZGttTlVNejlHYVByTHVGRFlGQXNoMjJDK2x5b0lSZlFZ?=
 =?utf-8?B?ZFdMcnJ0dlorSEl5bzJqOW81aHdWNWg0eFdNbnhyRUo4bU9pODZWK3lmM2dE?=
 =?utf-8?B?OCtzdmVBa3BwSzk3S3VhNkRIZFVNOElQSVRGY21nQTd1OHR4eDA2ZldZQnll?=
 =?utf-8?B?WnhyQUw3OVlTUk52UVdMc0V4alJQa0krNmZxSWRFbHRrSlBrbHdzUitLaXNR?=
 =?utf-8?B?WUFJc2M3bmJPeDBpMkgxZ2dJRW5Yby9hcnp1cE5WMlM0OWNVaVVYeFNGMXpp?=
 =?utf-8?B?WEJkWXpoaTQwMU0wQnpGbDFlRXU4T3VMUXVkSlV2aStPcWhaTys4RlAwcTRk?=
 =?utf-8?B?TC9GZWs0SHFlQVZkT29qM0pKbTE0MWZJNkVMWHRIMWF1ZDhObW1jSktZTCt5?=
 =?utf-8?B?K1d5YWh6V3dUVGVWdWU0NUQ0Ny9HTjlsL3huMk9majcrenVXL0Z2dkVndXhP?=
 =?utf-8?B?Q1lYenY4N3N3WHF4OXNvc2M5Z1JXVnN1NDFUbHBESXltdXYvb3o5MitvdUE2?=
 =?utf-8?B?M0VLNEZCckRUalY5d2s2SG9weHpjUERocExnSjFPZ2JPOGozcWxLa2gxTkJi?=
 =?utf-8?B?VGp3OXpxT0lrMkZLVlZ0eFpDV0ZFVTAyQ0VqZUQ3bEJJbHhGNDlZTk01ekZk?=
 =?utf-8?B?d05aaVRNOXptY2ZkUzh1c1pHTFJvaG8rcldGdGlmaFM3bjgyWUQrekhMdDdL?=
 =?utf-8?B?SG5sZlJXZGNITFY1eVpsc2dMMlRTOG55WktzYy9uM2NJeHdVNjkxMUFRWTdR?=
 =?utf-8?B?cUthaEpTRG9LU0JXODFwMkpCVFgwWk1lTEowQzh5TEZGU1RvYWdVODMvelE0?=
 =?utf-8?B?Um5KNWxBSFFDL1RIYjFqSjJGZ0d2Ty83bDdpZ0JIcldzc1E9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 336c3f7e-296c-4ada-f8ef-08df43ec5467
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:17:21.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB18039

On Wed, Nov 04, 2026, Sean Christopherson wrote:
> Ahh, but there's nowhere for edge-triggered events to be latched, so this=
 only
> affects level-triggered events.  Which means, this?
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index d6e5fbc3c58c..b72930a8516d 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2554,6 +2554,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *ap=
ic, u32 reg, u32 val)
>  			val |=3D APIC_LVT_MASKED;
>  		val &=3D apic_lvt_mask[index];
>  		kvm_lapic_set_reg(apic, reg, val);
> +		if (!(val & APIC_LVT_MASKED) && (val & APIC_LVT_LEVEL_TRIGGER))
> +			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
>  		break;
>  	}

The trigger mode check doesn't catch the case Matthew hit.  Linux's
setup_local_APIC() writes LVT0 as plain APIC_DM_EXTINT, without
APIC_LVT_LEVEL_TRIGGER, so no request is made and the "noapic" hang
remains.  For ExtINT the pending interrupt is latched in the 8259A,
whose output stays asserted until the guest acks it, not in the LVT
entry, so the trigger mode bit doesn't tell whether anything is
pending.  Your first version (any unmasked LVT) does work for LVT0.

There is a second path with the same problem that neither version
covers: hardware-disabling the APIC through IA32_APIC_BASE.  With the
APIC disabled, kvm_apic_accept_pic_intr() returns true, so an ExtINT
latched while LVT0 was masked becomes deliverable, but
__kvm_apic_set_base() doesn't request KVM_REQ_EVENT either:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2825,6 +2825,7 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu=
, u64 value)
 		} else {
 			static_branch_inc(&apic_hw_disabled.key);
 			atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
+			kvm_make_request(KVM_REQ_EVENT, vcpu);
 		}
 	}

I ran into the same hang independently (a small VMM booting Linux with
"noapic" on the in-kernel irqchip, roughly 1 in 5 boots when nested) and
wrote a selftest that reproduces both paths deterministically.  The
guest programs the master PIC and masks LVT0, the host raises IRQ4 with
KVM_IRQ_LINE and checks that the PIC latched it, then the guest unmasks
LVT0 (directly, or after an SPIV soft-disable as setup_local_APIC()
does) or hardware-disables the APIC, and opens a single interrupt window
(sti; nop; cli) to count deliveries.  It runs with xAPIC and x2APIC.

Results on kvm-x86/next (cbe54fc3462b), 3+ runs each, all deterministic:

  kernel                                 selftest result
  -------------------------------------  ----------------------------------
  unpatched                              "LVT0 unmasked after masking:
                                          got 1 IRQs, expected 2"
  Matthew's v1 condition                 "APIC hardware-disabled:
                                          got 3 IRQs, expected 4"
  any unmasked LVT (your 1st version)    "APIC hardware-disabled:
                                          got 3 IRQs, expected 4"
  unmasked + level (your 2nd version)    "LVT0 unmasked after masking:
                                          got 1 IRQs, expected 2"
  any unmasked LVT + APIC_BASE fix       pass

Tested on AMD only, nested under QEMU with AVIC disabled.  Not tested on
Intel or with APICv/AVIC enabled.  With Matthew's condition plus the
APIC_BASE fix, the full KVM selftests differ from the unpatched kernel
only in the new test, and kvm-unit-tests show no differences beyond the
"MOV SS + watchpoint" cases of the debug test, which fail intermittently
on both kernels in this nested setup.  I haven't run the full suites
with your first version yet.

Matthew, are you planning a v2?  If so, I'm happy to hand over the
selftest and the APIC_BASE fix.  Otherwise I can post a series with your
patch (reworked per Sean's first suggestion) followed by the APIC_BASE
fix and the selftest.

Thanks,
Jiaming

