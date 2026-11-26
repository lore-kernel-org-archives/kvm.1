Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795700934;
	b=upTcCusJF8Iwy2nCNWy52f5Mn6xLrGr4keRTKBzhwkUkWHN9TKHcBgRwzZEFYw1XTqt/
	 0ygC5WcKjn/lGIFqkgm4nCfoR/Y0AA0kbO4H3i9goVPjF0K+NnAs49PanCJCX0XmEeMba
	 18gGghiF1zL0DoHoEzXm1TISXcxjYMVvv9zLKw7DphuyFjanYdfcEd8xJKHpynNFHvknB
	 J61IhCV8oGxn7AYr0mzLgHqYnt6oMl8lIXDquBe1ohyYSanIjGu/IJ2kQmXD1UMWQUlaZ
	 x3Ut92VWgC2grgbncnyjofsB0UU8rg3Hx3prNK12YIsxrR53Dv2oUcRR7oqCSGfbAHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700934;
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
	bh=SJWxV/P5igP3aPQg/5bTJc024nKk6rxK1QzW2r80VEQ=;
	b=irq9dpTbcs3BbOz9pyVv/3qxp/FBEqLtlyuHkXmhnysHFgeCmiL6Ub+JAgapDb4l7RB0
	 EvG6kMS7GphL+5oXkAuxS8RB3RvE0XF4bxEDItORspUYsTWlz6lBifD/bktcN1Vr+dJQS
	 jX7CgNq+ZgSHuCvGU9lyiIjbtnJ0wHbtTTybOd3izymIK9OeykTWVLmEmFLt6cx3QKOjw
	 RB1IzZGxACaUEHerzDX8S0TKpnts6T4WUQOlDTFbQ5X8/NhYl7vI4WD8J+I6H+v71o8ia
	 /iFiVqTi5YoVovjcGZWCazP/sFErsG0YQkcFcoSGZ8hmKAK/jwbuo/PZJC7yT809Qbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Hnf1V6zh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.29
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011029.outbound.protection.outlook.com [52.103.66.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96F606A31C;
	Thu, 26 Nov 2026 13:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE96F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Hnf1V6zh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY+gQmxV/W4QJD8szh2UfCSqYi/bndA6PrST7QHUDyvkuNcy8QRF0COlDcE6VRgsBE0TwBw0mqJ1cBbMvwMp1fRHjOz84NwCYc5bp0Oyq6LucI3KQI4AxP30fDdh2oPKCM+lXz5ev1kPTGp/RtUhALfw0tMeg/t76ee8WvAXuw3tzClse+KWL0bZNmxanKUHPlqrOTjKWhQH8Tm8uRA/bSHlfnBcdsv9ri7kIX+UvPLBRHbQ5xcmgR2GOEGQGzwhKl4AFb1b7V82pEkhDwAmQ23LysStDnzIfn84TlrtVp252fY7x8I4Xi0NIbIdtd8TFI2TvsvQZKZAZctuOL8ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJWxV/P5igP3aPQg/5bTJc024nKk6rxK1QzW2r80VEQ=;
 b=SCl2qsXf1+SdWOOqEh84p29OLeD533TClUEdOhhozBrkco7aQeLy6+wgiBYiOVa0ZHFSAJF0qquNVDFz3sGeGhUVnOyDwbkqcuFo7v+v+XCzyWASDqm4EkheKiJl/82sSXEeVyzIjM29ihbMrox9NzkPDL89VX3HEWnaGktc9kjsAPUyJysaFHZBYkbzf4xsFUyWTZcFrYOQ6y4UWLH2ApRsQdJVpirXQ5/IVBJapC6sYLD1mgzqgzP0z8aVUibcBNKGomMfI2+sbNQ+s0he0Wzc0Q+3yDLafiWjsOswRSka60LoQGvnBJR1gyGa5mRrzuKU2vk9YtDBlXmGTXcPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJWxV/P5igP3aPQg/5bTJc024nKk6rxK1QzW2r80VEQ=;
 b=Hnf1V6zhXKixurpoCblXBK5U/4tcL8i97lggrkfMjTW4MIcp1L5zY2lTWdEOljsdbYCp98dZdUZMVeHLCyqpuw/IVGt2pxgybB2aLux0IETmdIpzvvjt+oMkf4RQRKqNWsdotWYKLtOu9jzz7pCCIy8gswuJOQWEK+hTcIDlAib2WOxh7uqBfMJg042YTnUYmjyXxg7X1EeUcSbnYmNGlZHwDcmnP+xIqGNtGm7en64jwzKSlldB6qH6nF5fSaw2eKk30qX1uPBFMvRX/dARJqgr144iELiD93u7f3k0a3Mg7CUVkShQnOT7kjGWHa2f7PR7ExbfNZ+gs5ZuMsb9YQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15563.jpnprd01.prod.outlook.com (2603:1096:405:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:48:50 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:48:50 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?[PATCH_v2_1/3]_KVM:_x86:_Reevaluate_pending_interr?=
	=?us-ascii?Q?upts_when_unmasking_an_LVT_entry?=
Message-ID:
 <OS3PR01MB10251CA2655551F3EEE481D36E7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Matthew Leach" <matthew.leach@collabora.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <kernel@collabora.com>
In-Reply-To: <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Thu, 26 Nov 2026 13:48:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <48b085e2-53dc-42e2-a573-c1823504b193@milk.local>
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
X-MS-Office365-Filtering-Correlation-Id: b0633baf-2590-4a0e-8bac-08df4bc4004a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|25031999004|22091999003|24021099003|55001999006|24121999003|51005399006|25010399006|5072599009|23021999003|6090799003|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUE4QkIyaFpCNHN3QTRJYjRPbzVaQTRVeFNaaDNWSFdwYU5hZGdTWEJaS0ZY?=
 =?utf-8?B?dUJsK3ErVGhpTlliWDNSYWNDVkFDS0xoZCt0K0RkV1hmMkV2SHNEQm1WUzRY?=
 =?utf-8?B?NFVXZ0RRS2EyQ25QWXFzQ0hLWGdJVXE1QzJZZERHaTJTbzJaeTh1cDRLUUJ2?=
 =?utf-8?B?UVVsdXl1SjlIT2RyQmhyaC9FZDQxZTRoMGRRMlRmY2RPMkVGY1llN3BhbmYw?=
 =?utf-8?B?YWUwRkZkdnlscE9ZWHpSM1NMZTJuOFRzcnlBQWRibVAxdlNidkQrN2t6MzhS?=
 =?utf-8?B?ZUVkVGxhcGV3NE9HbnpqQ0svUzdpR1JRVjltaGNiY3J0Wm9YekJvd29Lcmt5?=
 =?utf-8?B?VEordzBiNUFBcEI2VjhEMmZhQW12QlQ4VCtTMWloZDduRFhXZUpQTTJFMWFF?=
 =?utf-8?B?eFBqUkZsdlJya3VMbjhESDlSVFRISXlxNXZYZm12aktNT2pTWHpVY01yRE1D?=
 =?utf-8?B?U1hsSzhtQzBMTG1vMHBiZDJTbm1sR3l5Wk5MYnlQMG1PRUtYRG9wcUZHZ011?=
 =?utf-8?B?U2NwczFDUHpZQVZEdnpkcEpMOEx0bGhHNXZWL2cxQXVNV1FmSFhSNmV4WGNl?=
 =?utf-8?B?RDdyK3JnTllDV1NOQWFGd29Mb2NZQVlxNDlBOFRtYkVtdi9oMTZzSzQvWTYy?=
 =?utf-8?B?Ukk4YVkxYXNwelVLRlk1R3N4SGFRdGtsMW50enRXd1N2TjRrbTJ3V0lBSjNX?=
 =?utf-8?B?SzYwQnBSOXlnTlg5RGtIdmNLS25DRHFYM1dpTEwyNERBaFg3aUxIOVZmdDVn?=
 =?utf-8?B?ZUZ0NnZPaU52Vk5HZ2trTDV1ZFZlYXRiekw3ZC9mM3NkcU1jcy9sQUlXOElT?=
 =?utf-8?B?N1Fsa2lOWkcvREFtN1dkUnVOVmJrWEg3K2ZGSTdET2g4akg3STVaZmxNb1Mx?=
 =?utf-8?B?Y0UwTG5KVTlIUnBvZy9xTmdVRVlxemk3YWNCWnhKcXBFVUV0Y3ZrTWRObFBB?=
 =?utf-8?B?Wnk3U2MyZ2JtN2NXeWlTNXhkTjZJTGY0Unp4MDhIZkRrTFVhYklaemhsaXlz?=
 =?utf-8?B?OVlybDl0c25TRFhQU0Z2akNPVnJLdlF3cjY2V2toRWYxN28zcC9kbFdZaldv?=
 =?utf-8?B?THdlRlVvTlFBU0tlcG1qUVpteE44R0lOYWZzWElENVJieGlVdFBJdzRzZ1kr?=
 =?utf-8?B?WEdkb1JSdjBGRllNZ2FmVmpjaGo5QkVpamtpcXRUTUNrYytJekR4R0VEMHRU?=
 =?utf-8?B?eFhLOVdQcUhOVzdveVArVkJnZkRtM0dzUEtLMFAwZzNZSW5PR0RqOHVXZnYw?=
 =?utf-8?B?VTI3b2RkWXl3QXhmRDRZV0NxRWJ4VFFtSHhFNVZLdElkT3JhcVpOcVFNZS9r?=
 =?utf-8?B?aXZSb2psRk9ncGliUlEwcGkvelVkRzhxcmxIWE4zVUo3N3BJbVovOW1aMWxF?=
 =?utf-8?B?Z3ZtaGJ6akM5d014U3BaWHZjbnVncDRySHhuMDVUWmdKQUpCcytwZDl2SlY5?=
 =?utf-8?B?RzZHcENlQ0RuNTg1MlRLSVdxbWRCTlRBZ2YyaE9sQ2FFUGVZYmJyODdxamRF?=
 =?utf-8?Q?LyUEZA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWhOWUFLcjNzamJuMFZRU2dpSDJlZ2VKOTh3N2l0TWtEc01tanpSbFBXdWU5?=
 =?utf-8?B?bittNEg1dWNyU0R6a29YbVEwbkZjcjVkclN0SFB3bTBuc1N5TWgxTk1rMjI2?=
 =?utf-8?B?WjJLOFpQTnZVOTMvaGoyeG5nblV0TEIwT09DejFpelg1eFJiUXR2QVNjTDhZ?=
 =?utf-8?B?ZCtsMHRzME9KS3M2VFRIUHRkS1B2dWRGOWtqR2dCNCtoUGViVENaUjhheEdn?=
 =?utf-8?B?R3cwbWovWnpseTJOT3pNbGZDK2lRWWdSVk1HS0hxQjhLcExPRERqTHlMSTZO?=
 =?utf-8?B?MUQ2L1dnU3hiRDM5V3p0T1RjTXFIZjNMbFR6UWI5TFNSWDJEOXMwT0pobUh2?=
 =?utf-8?B?eVRJczVlK05QRDVBMWpBc2dORGpMK0dkcEtTTE0zMGVxbmMzUlcycFc1RzdQ?=
 =?utf-8?B?cjMweDZqRFRyQTdSdUdBdG1tMzJMeWlBM0dmbVVPaXordzRlYkhrZGlLMURt?=
 =?utf-8?B?QWNTbFVRc0dzUmVJRXBpUWVBcVBENDhVNWJQTmdnd2JjYWllQi8zSmZjMDNl?=
 =?utf-8?B?L1R5RkZvcjRKSzAxcjQzbm9NczhnR1U0bUgySWxCU1I3d1pRaW9VWjZTQXcz?=
 =?utf-8?B?ZGVrUUZOVUJmTVlIM2Voa3EvK2RLSkdyU0FRRDRGSlpRcFVreklWZnJULzlt?=
 =?utf-8?B?TmxDWDZvYUR2b2ZjZEVNOG1pRnFwam9jbFhzd21Ob2FqRzBtUEtmc3N5SWkv?=
 =?utf-8?B?VkFlZGNQZzd0UURGTnhzWWQ4TFFFODZTQzBzWDdQTm9YdEhKeHhFdEEvdnBH?=
 =?utf-8?B?dDVyZWpHUHBWRDVrTDNmdXRTdWd5b0h0QzRIY3k5RUNoeWFnMzFFSE1nODA0?=
 =?utf-8?B?RysvSGYzWUtpVzl3WGFyc3dXVTdNTmlYTnJPbGlibncxcFc1K3kwTmd5aGd0?=
 =?utf-8?B?eWkyV3htS1lOM1RDZ0R5ekFVMWs3NjIvaUJjT3RkYXF3dHdZSHhNRkRuN3A0?=
 =?utf-8?B?YWFnM2pXSVg3VkIvKzZaTFgyYkdvcjVDcFhFNWJ5ZWozSldieSthMWhZWmRi?=
 =?utf-8?B?ZXJpVUczMGVFVDhTSUYyMERzbUc4d3g5cFlGVDFNQ1VzYzduZU5IUFBvQk0w?=
 =?utf-8?B?ZHp6NytsQ2hMTklwakVUZUlNWUZzOGpmYTZ5UFhvRms3ckJWOGVld2RWbEh5?=
 =?utf-8?B?YjdoRk5lTzduTEtsQWpYWjhkTmxDQ1BSUnJvcVlNeUtqd2hPZEVneXN3VDZS?=
 =?utf-8?B?d3lRa1NvSkFXVmtnNjExTFpzaDJpVGFSRWZBZ2Q4MUpEM2lxb1VYV01MYUZQ?=
 =?utf-8?B?dzVSMEVmN2ZydnBJT3pMT01xN1BaWmZtMFNvWjBVRjJEMnMxNVF5Q3NrckdM?=
 =?utf-8?B?OXFoVEdDSG5sU3NpM1NSOEJRWHVTZWo3SnV4ZlhhVEJ0MDVwRVJ5Q0VrbVB5?=
 =?utf-8?B?dFJqbnFNZElwS3p1dVZnNUliSjBEck5Xd3RJT1UrMXhSY0JLcXkyUDZzRTdk?=
 =?utf-8?B?QkxYRVRJTGxNVVQ2UkRvdVF2dVRGdFhwMWYvNmkyUlNKQUJLblY0MWlDbWY2?=
 =?utf-8?B?V3JsRklwK2FESnlwMkk4elRlZWZGNUM1ZVE0OEw5bm1rRkV3eGtqTW44RkVl?=
 =?utf-8?B?elhzSHhiQmJGUk1iN1pGa2dQVWRhZkVyQ3dHWmR0VUF4UnR2c1N1bytWbmJq?=
 =?utf-8?B?SEdjSzhPVlYza3hnSFRQNDVqN3kvbTkvYjZpZnRwK04zSTUzRGo2QktpcjUx?=
 =?utf-8?B?MjZIN1d1bW91Y3QzZFJYUm9qejdxazV6MFVuQmlRb0tJcUtkempVVUd5WW9U?=
 =?utf-8?B?TGQvMjlSd2NtM21XdENoR2lJelVJRzdjTmRSQkVyenNQR2E2TGMvR3BSL2N0?=
 =?utf-8?B?cE9IR2x4dmF5SlhTVTJrOU4zOGNLZTRMUnFyZkQrR1NkN2ZiWisrL0sxYTZt?=
 =?utf-8?B?Snh6bC8xMDRPSk9jUnd5Y0luR1BzcWlGcXNubEdiRysvRXc9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b0633baf-2590-4a0e-8bac-08df4bc4004a
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:48:50.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15563

From: Matthew Leach <matthew.leach@collabora.com>

The PIC kicks vCPUs only when its output rises, and the output stays
high until the interrupt is acknowledged.  If it rises while LVT0 is
masked, unmasking LVT0 later makes the interrupt injectable, but nothing
sets KVM_REQ_EVENT, so it is never injected.  Linux guests booted with
"noapic" hit this: setup_local_APIC() masks all LVT entries through SPIV
and later writes LVT0 as unmasked ExtINT, so a PIT tick in between hangs
the guest in calibrate_delay_converge().

Request KVM_REQ_EVENT whenever an LVT entry is written unmasked.  The
trigger mode bit can't be used to filter, as the ExtINT is latched in the
PIC and Linux programs LVT0 without APIC_LVT_LEVEL_TRIGGER.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
[jiaming: request KVM_REQ_EVENT for any unmasked LVT write, reword changelo=
g]
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 arch/x86/kvm/lapic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d341801b61cba..c1f819a0ab2fd 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2524,6 +2524,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic=
, u32 reg, u32 val)
 			val |=3D APIC_LVT_MASKED;
 		val &=3D apic_lvt_mask[index];
 		kvm_lapic_set_reg(apic, reg, val);
+		if (!(val & APIC_LVT_MASKED))
+			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 		break;
 	}
=20
--=20
2.56.1

