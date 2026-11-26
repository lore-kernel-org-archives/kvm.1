Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795701015;
	b=hV3bCriaKmUydaKE1Nst701MWV40Dyq+Gy58d/LLlI1K4k1CcPr9M7+ErGJftRa6LOAI
	 ZK7ddzNxqAnhZapdOTDEqt+b54dsiw2nreaCOJTVkR935bDEfgiuvEERut5JKcLwlu6Q0
	 I1rQGSwemV2Zo//EioVJUeKUgLKUjscQtrALC2NRariFb1riiZpTouNamadZmT2U9wHbj
	 UfdJFQuKxDxgCCKyJXdk9RxKZNThrgxrSnkSiAend6q7nSKrXjA49JTfFj2Yz8d5FOAAG
	 RODZeIiNKIbt/XayeL5el6ugXA8iqpf2zBeNx/3OIBh/k0V2GiHF4T+0lC36UHR8g6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701015;
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
	bh=4jxIed5hFynGWkHxrTP83JjCWkx0b4mrLbv2N2Peb7c=;
	b=Mu6vjVAT55bYYwsei0cx997Q5fIVtxKUZgHdSTHi9KmAwVUpz8EYaO8unvUJp5wc7fZL
	 ev4ORAAOgtnBZOJgSknpbpKMDGZH2EblXHcnlXxIobnf6ADJvL7uCrpE49OszEddV53Ak
	 td3rh4fB9uELAdAzdO0FG8HXlSEeoIa5g7ZvQHu2EqLyBUMXiT/9LlarO39tVmpQhMh8n
	 QapcEfiS/FaTx1FPSGdjI0M98PgWKhzJLnO8mKfPFQNpHyVX5zKKr2L/SHtgjnjbJIjSi
	 lt2ZAyl1Ig2FNTTfJiQf0lS6BTG2C7iJ6bSKR1jugVQW75fJ0xXZ6/PRP8hirCfVtZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=BsQeOoHi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.10
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011010.outbound.protection.outlook.com [52.103.66.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC3606A31C;
	Thu, 26 Nov 2026 13:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=BsQeOoHi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9++Vu/b8YJQvUD0/5Y2dFijLas6ZNGlk+wq7Wzg49aqajDhOa5Cr7mmW5rcaRwBUVd2lqpDF8CSrgD1+0W7hZ0ctXgNzrp77oawYzsPVkBSebUNferRs0+155/oH3lS/zsUINiZGWpmohH1lE84oKuQQPp1tAx5IZsr6FnSiVtqOcNZAF/eTBjtLZHFDCHhnNWU+az1knSDNVPnAtvFw4tu1sPKjPxHKytUZAfaxHt9dmrvys9BzOU8g7HbqHlJrBuFRMLXj1HB9YyVadD/6NI4QQ9nfP8S9hF7wAPgHlhqJecp+2Gfsp0jaqEfOKBbSbVVwagH7K0nXE8/Zr7EdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jxIed5hFynGWkHxrTP83JjCWkx0b4mrLbv2N2Peb7c=;
 b=to+ygUCOmgbUECMbcmayTDB8skVjbh66flHS7ZIs1HImjM5zsgbyodX4raNe4P6gLRDFJmm1MBDwllpSG/JEMpnpxno6whUw9jQzIEWPqb/DzWwkVdW+MWhIeQRVDYrsRan7MQQ06DTpYBvtCOrWDTc0LbkiRXFcsxm1zaB51D8qJwnQx9aHMKvqs2uybZdT7HQ3IAp8/xRW3ut/nLww35+boFDc7fFDKJVLoqBw0a4PZLgKgnlEd78WcKy6l5gD2GMdFSgq171WxkT9pyMZbh0Z1e+mt11jnJOuCUSbFSC/VH/gDMHMfoowjwidpv6Fk58+F51d5oAEIzOOiR8XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jxIed5hFynGWkHxrTP83JjCWkx0b4mrLbv2N2Peb7c=;
 b=BsQeOoHibCLkKHM30E19IanhN1umnhWTmVqjoJN8/llmwThIN8VNOpU8ZpqWQEUXIzpc1A9W4XDb3OsAM/bS4IxvIr4ebMoZYBD5AXohRiMzrh3Xj+GDzmedF3/sE63a9zJsyOKA8RnIbEONwaRhiIZkaFHatd7HIVOhcsL1M/OB0FrQ11aKKjdXALa4qbaL1AR5mK35kDw01IUlD5QcTIGXvKTacfh3aNE+h1kDNo4s4Ysith6v2t66rkgLQ6+6g6Q1FCSsX2UKAWttoDIV7InPWiIpB3uDjxrHTO+K2DG//vs/Ar3553NGUox4JULEA/roiwInBEWyFHDLn4c/OQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15563.jpnprd01.prod.outlook.com (2603:1096:405:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:50:11 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:50:11 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?Re:_[PATCH]_KVM:_x86:_Reevaluate_pending_interrupt?=
	=?us-ascii?Q?s_when_enabling_ExtINT_through_LVT0?=
Message-ID:
 <OS3PR01MB10251DFFB7B787365C6709D78E7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Matthew Leach" <matthew.leach@collabora.com>
Cc: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <kernel@collabora.com>
In-Reply-To: <87wlq3n5wu.fsf@collabora.com>
References: <87wlq3n5wu.fsf@collabora.com>
Date: Thu, 26 Nov 2026 13:50:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <cf7d6bb0-4b09-4e31-ad92-d475315091e0@milk.local>
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
X-MS-Office365-Filtering-Correlation-Id: 57d03d0d-fb83-4124-4586-08df4bc43086
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|25031999004|22091999003|24021099003|55001999006|24121999003|51005399006|25010399006|5072599009|23021999003|6090799003|15080799012|10035399007|40105399003|1602099012|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmxlV3RzbW1DN01Gc1hnclNsbk5UTncrUS9aYkQyWk9KU0tTQkloYUJPcmda?=
 =?utf-8?B?a3J5VmF5Zlh6WlZrWVZiQk1vUFZnTmowVjRvM09JWkdhc3NhbEhOczJTM252?=
 =?utf-8?B?c3kyTisxWkFqYlN0NmZwU3V1TmVia05MTmRSLzBRYzVXVXh0YTF6c1NJYVlC?=
 =?utf-8?B?SStxUjV5OFU5SEh6OU5JVjRLZEZDeC9ZbWtQZ0xvajhWMC9xTHpiY2RzWDVv?=
 =?utf-8?B?R1QzSjB6dDRTcVUrVGJGbEpZVTdHejNnWk10cUNHRU9oVHk0eFJhK3RuSy9U?=
 =?utf-8?B?K3lJaXNhQVAzd2h5NDlBczFubTBQN3V4Q3ZyQzNTNkx2WDRhYWxQbFNBRVRK?=
 =?utf-8?B?cHUzS2Z0N2h1NFdSZm14ckJtUXZqUmJYaW1VRVlqZUN0cWwzNksvK1pIUVl3?=
 =?utf-8?B?eVY4QkZ1MlE4OWpzck40NjNsWC9NNFFiK3k0bmQ3UEJnaHlyYm1iNTA5cWt6?=
 =?utf-8?B?dEFSWHI0dkFPK05jSWFYc1VHTHEvL0ErMW5IOVkvSE5qNGlUSDd1ZzRLLzFW?=
 =?utf-8?B?R1psYUpIVEVIQ2l4c3dzRmlBWVQ1cUFxdGtnSkl1Y1hkT0ZWWk9KQ3ZpaHkv?=
 =?utf-8?B?cGlzU0dTdFNUVEhYTnZpQWc0bGQwcGFudmk1R0tQTkFQSmhmSkc5cHc2Ykdj?=
 =?utf-8?B?WlcrU2Q0VzBkTHVwQnJRTFl4ejkyWDlwTXQvcldvbVZOVXZ4emVGNFRsN2dn?=
 =?utf-8?B?UGU2LzFwYmpyeVdsYnQ0QW1ESmxTbCtjS0xKT3dVaXErb2xOVG5taXA3enc3?=
 =?utf-8?B?YjJ2b1dMTkZnbmpYaWRUVHhla2FIVlUwd3A4TCtxK2RFTFQxMjJWaUlWWmRl?=
 =?utf-8?B?VXQxVUkwSWZjWm9jSEtkbVpWRG1qS1phUThyVy9KbExkOVdjMmd4WWQ1ZHJF?=
 =?utf-8?B?Q2VmZlpqMGw4SjdzaFFiNld1MG9LejkxWGxVTm80Z1luUFBrR2hlUm9ERDJt?=
 =?utf-8?B?VDNQNUY4MzBJOUlucDVGWTR0QTRGcnBxdHUzQjU5ZkN3c3pRWVVuOVhyMjJP?=
 =?utf-8?B?czIzd0ZPY3E3a2ZIZ1kySE5XVkNSU0Rvb2JKK3pKOVliTlphcDE4cFpCTlRy?=
 =?utf-8?B?SFZZdlVhbVcrUzVPaVd0b0hrR0UvNGpFV1FPdUpFZ1RNNnVIUVlpTklha2xp?=
 =?utf-8?B?M2xmYUNmMU1paTUvVjFTUjhoM1NVWDVRV2pGc3d3bEZiVGpZencrYnpiSUE5?=
 =?utf-8?B?L2g0Tno3clBHRnJrTmtYNy8wVzY1ZWpZYUVIbUxCR1FjQmRDVk0rWGpCQWdK?=
 =?utf-8?B?YUt2Q2RkdFBFemdIL0JTR2RVYURONmdaVFJHTWUvbUdFT09hN29hUTZ0TGRO?=
 =?utf-8?B?azFpZ1JVdXpvYjJZVEx5L292UDhNWWFzeWtPWXZWNGVtRisvdzJZcGpTUkRW?=
 =?utf-8?B?aWcwYzRlZVp1MGdRQXNZYVBheHlQS0ljZTJEb1VjSCtyNStuOE01RktTOVVV?=
 =?utf-8?B?MmJiMmNGT2J0c1E2K2RONDVqS0J2K21yd04ybmZ6TUkvVEtsdnMvaFZRSS9X?=
 =?utf-8?Q?JOKCrpM8SuxySX99qOPgbJo3KnJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVpTRS9PZkM2U3Q5RHNUVE1YV2t2SkNabktzdUs3MGdKdXNvUlRWZ2wvREJQ?=
 =?utf-8?B?cmVraU5tQ0pUVUkvSTRUSDhtR3BMYUNNSVJGTlBJNFMybjhPMWkxNHJoWmhl?=
 =?utf-8?B?V3g0RWZYMUZaT053Y0NKVy9sZ2poZk44YTd1QWZKeHZIY0trOG5LVS9ZUE5u?=
 =?utf-8?B?bVBzWkIvcThnNko4cG53L095dm1hZzlpcndjY2hvWE1uVndDR0g0WEw5UXVy?=
 =?utf-8?B?S0ovRzRuTWV2NTZKMEptT3NVLzdNTmJmZXVEQi9mSG9RMlVCbllTcUtCVFpN?=
 =?utf-8?B?aU5IWGljWlY3RmZoY3k3dUFkc0N4aitjcEVXeGp2MWJ5WEEvWTI3RUxlam9o?=
 =?utf-8?B?N0gzcHJ6K09OLzViNWRUYkNkaEJOSTJsSnVVeENVemo0a0ZhUFFHREx2VUNS?=
 =?utf-8?B?Y0QxWGtqdGlKUVZTVjQ5UzFyZm9RYTNCcEZhdGFmeERIaWN3Rkk3amk2bVpV?=
 =?utf-8?B?UElzWUZnblZpdFZaMkR0ZGJ3cHl2TXNHSExQZXlCNU85QUJHRElYZUFwWlVN?=
 =?utf-8?B?N1RBaEpxZDJzbGN3L0thVS9KWE9wOXR6NGN2NUgzVEpVNXRDdDZobURRb2d2?=
 =?utf-8?B?eS90S0dybnNQVktlSHpPWWFxSWdhVWFsSzZFNk8vSkEzUndQbDBBSmQ2VUtY?=
 =?utf-8?B?QVhpTjJ6VTF2V3RkT1RTeDg4aW1Fc094K1RmK250T1dSTDcxd0tISDdQQzda?=
 =?utf-8?B?TTRLWSsxT293RmZ1MUtkTkpnUWxma2djQXJGV0VHTmJhK3dLcGNyOGFFTW9U?=
 =?utf-8?B?aW9GZVJ2cm5OUU1nam0xbGcyOGhhT3duNFIzSkxZVytWeThaUjh6azk3L29C?=
 =?utf-8?B?TnNjakJxVFdKQVZ4YkFaUkdoVUVjYmFza0NJU2VRbUNRRGMweHIwd3BiSUxk?=
 =?utf-8?B?Um9jOGcvd05RcVpreUVzSGg3dHhlbVl0aEYzWDN2bHgwVG50SzhCU2ZpWjRk?=
 =?utf-8?B?V3R6REQvcGNheE9XaTF4UGhPb21POUV0c0RtZTJwSzBETHV4RktmZ01KTkFX?=
 =?utf-8?B?ZmI4alBEQTNYNU00WlVLRmRhcGsvdWhnOTVnRzE1cUdKWkpxSDBwZGQrbUpz?=
 =?utf-8?B?em16V05GSVZ4eEZiR0tqbXRTVkkzSWlRZGh6QndEMGlmMmxFelE2NFRKTlgx?=
 =?utf-8?B?MDVEeWR1cDhuUXM3d3Fia1NKdk8vMngyQ2w3ejJ5WjVQVzBaM3VCZVk2bXNr?=
 =?utf-8?B?bnBUMG9yR09NNE0rdGNoQ1R0L2FuN0JadCtZUjNrMkZqTHJnT2FuN3gycGJz?=
 =?utf-8?B?dVZRODJDaXRWRGdsMmsyNEFHMDRJdFVFR2hNRS9uWjF1VmdSV09xZDBEVHpy?=
 =?utf-8?B?azR6QmFYWkNGakI0V0R0VWRHcmFzSmRzWlh2SjIxbkkwYXVpU3JFWThkSVBz?=
 =?utf-8?B?QWNqZmV6SHM5SXJ2b0hLZ25KeW0wT2ZBZXIzTDRLaFM2WmdhbmVCc2xWaUhm?=
 =?utf-8?B?K29aYUR0Y0ZpZDRpMmo5eld4WnZmOEZsdmxnVVB2bnJvS1NCcW9Zd3hxaWpS?=
 =?utf-8?B?dllyUk85M1V1akxHQ1d2MU5GV1U5SzJEcERPVFIvM1FiV3FUdVcrSnVHd1Vk?=
 =?utf-8?B?S2RuM0Q2dzRRZjVTcFNHdTVLSU03aHJIMEZTYnpRbDBqUkMvY2FtTlNsM05W?=
 =?utf-8?B?eU15azYzcGg3NSt5VGlyUTlXeGZlNlpGYm1mcUJKYVNmMlJMVkY4OUEzZkly?=
 =?utf-8?B?ZGtjeFBBeE95TXRCbXh4UlZCeC9UNVhPM25MM3lFVnl2TVBkQVVqa1NYVmsw?=
 =?utf-8?B?M1NzRkVZR3lGRSsxR3hZNU04RWJVRi9tekxUdVZ4Q0lKckoyYmRCaEk1b2lJ?=
 =?utf-8?B?YmJMTktmdXo0ZWhhSXhMNTZjczFVc1kxNWFnRXlvSkhCanQ2VGtBcnBwRW9s?=
 =?utf-8?B?SWFrKzBabHNLZHRWaGVXZXRPdk5SYjdmUzVwSkNYV3dleVE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d03d0d-fb83-4124-4586-08df4bc43086
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:50:11.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15563

On Mon, Nov 23, 2026, Matthew Leach wrote:
> Looks like you've done much more digging into this than I have, so
> please go ahead and fold my patch into your series.

Thanks, Matt.  v2 is out, with your patch as 1/3:

https://lore.kernel.org/all/OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01=
MB10251.jpnprd01.prod.outlook.com/

Thanks,
Jiaming

