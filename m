Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795700969;
	b=dvHHy2Ud/tRGqjcArnBfXQHeRVFAsTxTtQM2C+6dDF+VtPWKF520AIJemg0jGabUTVB+
	 sePq7RPzvF80LhD5Ozzqp5x33WF/F/iP0l96LB/0VzbXx/DryzrGVd62I5iNsVjTi4Yh2
	 55YgUE8Lwa9i7XwZ3ZhVXciSTpc1jjpHSbvX9Nll3v4suBsoTv4HiGdQ3GFbER+1/4Kvn
	 M7yPc1TuxlHbZQp51ccR87KsQhS1TPlCHitNGtde+NBKokTCfHj9aF/GZ1tF+wK9Xuq2A
	 28AslqQozdMJZIRndL+4K0EtzFeDlX/Trii4n4SUKvr3CSze9Kni5Bf1m4Nhyeh9+cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700969;
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
	bh=bmjwDA9iVdO2z2nuPYTLa37Tt0RK4ThFQBQ/MkCx5eg=;
	b=ecqNK9CAAIJPdzAZr0zOwFsIZP0ap5z2gc0B8abIpKwAwN35eeMoj2GkDWE9d6rhGBM/
	 /2P+lkwVc4c8rLpTeRfd1dnhzYSnTRgPaW1s+8bc7DCHG00rZ1eF0RybRUWNjZk1+eww+
	 fC4+/gD2YsjkM9vkdENOiZ9Cm6GzjnwClLE5fRb4hlCaWH2KXlh+9z/+x3wgl4LRHLCj6
	 UnsTAExwAIYVQr9zlmg+8VCyCkl1ipGnR7VOgRpB2HNcV5c9hWgHm/rd4bgqTY7d+4ohI
	 kAxYMeNb8jcT8F7pLIXJmw0NepcrjpIiqwwlkHy2HdAl1Izx8syf3o4Yd0rNGZuQtEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LqfPyWDL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.31
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011031.outbound.protection.outlook.com [52.103.66.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF4606A339;
	Thu, 26 Nov 2026 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84AF4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LqfPyWDL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mA5m7gPamL/xP2dzUCXBimGkUtgEJxEb+vGw0Iu8+mRb+3IXbhMVOJdGYlh3PWv03ZqtKl8bk8au8ts4MFq8aZ+ZkzQeYTcNK4sKatABM3Zau7FW6Se1x0Epmhq9p1qvbNjVFkeI0bZzLAkX+DAYRk0viqkWynKQhkHvdsUDZtVUtCK1EQ6a0cpjj/nxu/otd2umepQRRREKms0X4/dev93vvKfOjSGsq9Xe4OjDjKVUYxhkmUkpRS5wh+0FrjSn1AdlmZcBdOlxDlNiC2gJr+MnAAwnwUc4b8EIrK3X9ETxbGkT4XVa1eBm1jXMLM5sVPWumUeIijx1Tz/Y/qv1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmjwDA9iVdO2z2nuPYTLa37Tt0RK4ThFQBQ/MkCx5eg=;
 b=XrrjRSMf7+xsAb7gmTopTZAFV/sD8IMJD1CxLw6FyMNT4Oh2rDavlIZYK2SDgBhxiH+mV39v5HY5OQ9qfGkV9w/2nMspejIzhU0RcpEAt0v70F8Prjdoi21f6gkqmn4wFu+EXreNT8M1S7Nkq/HcR7RaO8KUFpzJ7Wkt+b1/EwBJmANzLIU2LT95DozY5rGCwmSmYYoqv4fhOqk2IMPrx2g+4dMejmD5mbMOFR84ms/wEzvTVQY+OC9/FTGH9co7J3yZF/E8Rz5YxWPixNwUU9Ocavvkb7CJGYczljByxKe+0zGRKpzSSnj4gmFZenH+geaarWCRFtUBrPy6/BZhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmjwDA9iVdO2z2nuPYTLa37Tt0RK4ThFQBQ/MkCx5eg=;
 b=LqfPyWDLIUC3QbfI6WJ1qRb3DzXzcpvMCGBYHhgtMOkPqxpIfegs2l2SPTH/AlLj/jJvRVNGePYSjO9r0EDI1IdCMOnsrLxaTgOWu6tUGQGZU6Gy/s4Lsay249xEqo5vvfHFQncQ5cdfg862Co4G0BJ9krPZGtyKx36pLqSyl7eC1CjCmXYGp+7KWVo6l1KSdr11+7QPTMa6KaurSlVnHcFRLliOkqf3AY8fNORhJL0aTC+iMlpES8MM8VDRG0kBG04nNSb0dt4sfGfvFMXs4/FzJMdm1S0Tf+uuWboqH1zU+tjAkwu75a83r1eTaDL2M+hAW9kUZ4O00UtxLLQdVA==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15563.jpnprd01.prod.outlook.com (2603:1096:405:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:49:19 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:49:19 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?[PATCH_v2_3/3]_KVM:_selftests:_Add_a_test_for_ExtI?=
	=?us-ascii?Q?NT_latched_while_LVT0_is_masked?=
Message-ID:
 <OS3PR01MB1025146BD451120D08B0CAF2BE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Matthew Leach" <matthew.leach@collabora.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <kernel@collabora.com>
In-Reply-To: <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Thu, 26 Nov 2026 13:49:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <6b71afa6-83cf-4075-bf3e-31f577e4d1a9@milk.local>
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
X-MS-Office365-Filtering-Correlation-Id: ad0f0b3d-cdbe-4e47-4085-08df4bc411bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|25031999004|22091999003|24021099003|55001999006|24121999003|51005399006|25010399006|12121999013|5072599009|23021999003|6090799003|15080799012|41001999006|12091999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVRUWVQ0YWJUVEE5a1hOc2hSVG5DTHA0RVBIVTVKMzNtSER5aHg0MEE2NEV6?=
 =?utf-8?B?MlNwcmJpTURLWDBoTFI2VWE0MkM2UmdHRTNNT0dnVHNSSHhleVY4NkgxZXdi?=
 =?utf-8?B?cE8rQVVQNTB0K1lHV1Q1bVVsbzhzTGdWTzBIelVZRzdKb1BoUDUvZ2dpeFpj?=
 =?utf-8?B?OWVOeEFMUVZ2WEVqRUg3TG0xTE9GZFRTQUg2eXlKVVo3V3NVem4yMXVsRjRu?=
 =?utf-8?B?aXFHN1Z4ZEI1TzFqQW9vL2wrSG9LSmJNcDhySU0zUlBTWkZCbmYxdEszelZT?=
 =?utf-8?B?ck1wd3FJNXBlRkJpOTVMSktJTThXelJIdGNYOHpIZks2Yi9yNFFLN2R6bEJC?=
 =?utf-8?B?bWNqYmdhcHE3RDRjZ3dVVTc4VlMzdEtveTdXY3BEOXh5aG1wVW1SQ3l2YXc2?=
 =?utf-8?B?Y0lQOXhPeFNLTk11SUl1Z0hqL3FDdjVMUmREOEtLNEtBMFdpUDZ1eEYrOTRF?=
 =?utf-8?B?L056bS9FVkhPQzZkR1dGZGNZM3hqdGRzRWJSc1pXb0taTEFBSzRjMUZpNjB0?=
 =?utf-8?B?UG52QjRNL2tmcEtFSHhnL2svRUhmcFIraVpPOG9tRVpjOG41M1pzeEgrcWdi?=
 =?utf-8?B?L2cvaFFJNUh2OU5pTVh2V0JmbVZpWlJRdnNXVWFVNUI0UjR5Tko4ZllNQnF2?=
 =?utf-8?B?Z05Sdy9FbHN4VjJmbjI3QjNuM0dJRVdiSXgyUTBrazBuclFBY3E5UjA3eXZH?=
 =?utf-8?B?OVl4N3lpeTErMlRHdGg4UHpsdjc3UXU0bXh3RWpSYXpDREhPSmJjMWhzeHd3?=
 =?utf-8?B?R3lrS2UwdDJwS0FremxYYUN5dTVHR3BpN1UxeGFYK0V5cjhNa3FraDN2K1cz?=
 =?utf-8?B?bnN5OXBlWUhLZUNnckRzU0plSy93SmdWMzV4ektvZEhFblVYZG9HK2F5Y0Nu?=
 =?utf-8?B?UTFvcDVXSWtKMTdPWU83Wlg3M25UVitrb3Q0NlpaOE5Mc2dOdGlxS09rTTg5?=
 =?utf-8?B?dDVGSW1pMnBKUS81Z0Z2aFkySkwxczFCN2M4T1pVODlicytRM2ZzQ256dTBi?=
 =?utf-8?B?SmVncEFnTk9Tcm95YVJGbkE0d0hTQzdIVmZQOFNpZEZObmtoa3NZb2pUWWZw?=
 =?utf-8?B?TU40clFDV3hFQ3R3bll1K2Q3Y25EUk9ROUZSaEFZZHJlaUdyTm1nUUdGbGZJ?=
 =?utf-8?B?dGFJME02K21JS0k3bSt3RWpSQ2FlZ3pnN2pCWXFJdEhOQ09GK1BYSTk2RU5R?=
 =?utf-8?B?d2JoR1F6S2d6WmQrVDI3bHR4N0NMeElkcUR3VUFRSnp6bldkM3o3SkI2UWh6?=
 =?utf-8?B?cG5oVU1SZG1uVFA2ZzdleVZvdXlQMk1HOFJpY1Z2VTBlWXhhL2Z5Q29Oa2JM?=
 =?utf-8?B?U1VXMVFIOTJrMEQ5UTJEMHlCajZtTEtjcDB6alZwTGNmWkNSV05FdUtHZ3Zl?=
 =?utf-8?B?N1BORlZmbkxXa0oyVTZwVWtmZU45MWw0bHhTUFE0YUpMVThTSDB4WXVCK0xT?=
 =?utf-8?B?bHVYeE5lTkovczVTQXZzanN0WkJsZDdqRXhIUk9HVmNwSk0zYk5hN1dyY0pF?=
 =?utf-8?B?ak9kNGNJa1VEQjZnTmRDczRKRWNLUElaZkpCMUozNGREY2w1NCsvVThtaUh6?=
 =?utf-8?Q?JBZmIBaj9lkirDu2Er1LwubdwoivMxpMXWkQOh0wmbp+dv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJFa1FqRGYyamh0NHBwLzZjYTI0WXlQQ3F6cit5RDk5MGtuYkhwRVMvaHRI?=
 =?utf-8?B?S0lpNFVPOEQ3NnlrVmV5QUppaUhaZzg0UTU0Sm8rZjFEUVV4a21hblpWYysr?=
 =?utf-8?B?ODlRVTJ3SkIvV0ZEMVJVRWE5NHRNTzlGTk4vMjF1UFNsYzlnbWFvSEdwc200?=
 =?utf-8?B?ZW8vV3BiMEF2QTV6bkxha2ErRzlFa1lWdUxMdXdXZXY0dlBUc3dFQnJhYTZV?=
 =?utf-8?B?bkxQMkhuSU9GNDFic1A0VXpMc1h3OEVRT0NTMU1uQ1llV3EycVRNY3BJQmdY?=
 =?utf-8?B?MkYyWkFsblFYWi9yMmY0M0tjTzF3MVZNK1AzTjNDQ3ZZYXpWR2EzYTVid1VR?=
 =?utf-8?B?akNkUkdLSlMybWxuQ2J5MGZ2VVdrYXd1MmpjamlwVG1Vc3BDM3FoWU9Kd2dN?=
 =?utf-8?B?UXU0d095M3RmR1l0VlNZaUxpM3UrYmNaRXF3ZUlac1JHV3Jzc2gzeCtKbkVk?=
 =?utf-8?B?R0xKWEhGTzJRUUNaODNnZUxwUVRwcE5LNUpXVmhyUGF3VGU3NlZSWi9XZ3Q3?=
 =?utf-8?B?YTYzNXFpcjg5UkhwamZlUHhLYm1TL1B1U3FMbjlhZHA3WkNVYlhocTR4azBX?=
 =?utf-8?B?enFheXc2S1htK21lWEhBdDBDUzg0YzR2MjgvTVcxQkRXMkw1ZFQ3ci9QQ2hT?=
 =?utf-8?B?bzJvYWt2L3NjaExCcUQrMWxUcGk0LzdWM0NPdFNoYUNQK3piNE5pN1g3eVlu?=
 =?utf-8?B?eEpxMzJoR29DRHd2UHovbHR0bll4K2RiWmIyTml2R2h2Z01mUy8yeWVzZmtk?=
 =?utf-8?B?cVNvR081dWJuVWJlbGt3VmhJVFRHdWRxYStxR00yUVZzaHRhS1JDQ1lCYUJ5?=
 =?utf-8?B?ZVNDblVTdVRGakhvVXhpbHdHK2JXSHoyNTkwcUhLYjA5RElXWUUzOVY0RXFO?=
 =?utf-8?B?aTBtcGxTM2VrZkpYWGxTcCt1WFB4Y3ozWHdnTkJNaDR2NDU2UnVVdzRTQ01u?=
 =?utf-8?B?aVE4MHRvQUdMYlZTODI1dzJ6ek5jbzduYlcrdVo0a1lDcDVrN2M0OEFCY0pH?=
 =?utf-8?B?UXc2a2pDMlIrMDNYaWZ0eGZkbU1TdzYyVTFIMDdpVjF0S01rd3JOaFU3VzVW?=
 =?utf-8?B?Uks3OVVSTHdQRExzbzR4N3Uxc0NsZ2tWK29CbUo2T1MwWVR2SnZEVzBpdGlj?=
 =?utf-8?B?NUdWQ2JIcUtNbTJHcVMrZUdzbXpWWnFJcEFPU0xoMDNKOWdTTUdsZ3BCTkZT?=
 =?utf-8?B?dEMxc1hIM1RoejkxU1kvWlJvWERxZTBYVzVEUVZTUmNOdSs0TWNjSVFnWjdk?=
 =?utf-8?B?TERCOVVQTk5iWjl4MFVFSmdMWENvaFpYMnlXMkZueEQveGhyNVBSd1l0d0xl?=
 =?utf-8?B?ejBiUlMyLzRRMFZRcUpTYWRwVXZ3Ni9yeUZiWDhUWWlneXdZWUNUemNaOHlx?=
 =?utf-8?B?UVM1MFpBbWROdlh1Vnd5eVdmbmh2Y2RDcXBVY2Uzc1ZPcmdrOGhpdmN6Q3di?=
 =?utf-8?B?UkZOS2pKMWNsZ01kVGxUUzhKYkVFQkxoNmQvSGRjQnRMd1BRMlZIekc5YWJL?=
 =?utf-8?B?cGg5NXdCUitscDdIS1Q1WXdaY3ZZVTM4WFpIeml3clRQNUVuNjY0dFZpQ3hI?=
 =?utf-8?B?ODN1NWlvMFIvOFdVNlhRNDczTHMyd3pTOWJZdGxYZzlzQjB1VTZoTHoxZDYv?=
 =?utf-8?B?RmdOb3Jqc3Zja3FqbFJpdVhZQ0doNldmeFFwMmNPNThYVHZtV1MvTzlXS2p2?=
 =?utf-8?B?djJFb1NpWk42MHBxSEtMVGduM0lIU1FKa0w2KytFVHJSdXNBL3lvYTBYb29D?=
 =?utf-8?B?bm5jYmxwc3N3dmlldFhzTkNuWXNyUnhlQ2JIMjlBOGN0MXFkREt2bHZReWlv?=
 =?utf-8?B?RnNiVWdzTHhONGRaY1Z3WjE0UVBUZ21WbExLdVRtK1k5ZVQwVXlHaFRYQThy?=
 =?utf-8?B?T0xUNVN6TkNFRjBmclNyYU9ZbzRDTXg0NVE1ekwzd1N2YXc9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0f0b3d-cdbe-4e47-4085-08df4bc411bb
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:49:19.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15563

Raise a PIC interrupt while LVT0 is masked and check that it is
delivered after the guest unmasks LVT0, both directly and after an SPIV
soft-disable as in setup_local_APIC(), and after it hardware-disables
the APIC.  Run with both xAPIC and x2APIC.

Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |    1=20
 tools/testing/selftests/kvm/include/x86/apic.h     |    1=20
 .../selftests/kvm/x86/pic_lvt0_extint_test.c       |  241 ++++++++++++++++=
++++
 3 files changed, 243 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 95867977beb3c..c01d1c4c032d3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -114,6 +114,7 @@ TEST_GEN_PROGS_x86 +=3D x86/nested_tsc_adjust_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_tsc_scaling_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_vmsave_vmload_test
 TEST_GEN_PROGS_x86 +=3D x86/nested_x2apic_test
+TEST_GEN_PROGS_x86 +=3D x86/pic_lvt0_extint_test
 TEST_GEN_PROGS_x86 +=3D x86/platform_info_test
 TEST_GEN_PROGS_x86 +=3D x86/pmu_counters_test
 TEST_GEN_PROGS_x86 +=3D x86/pmu_event_filter_test
diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing=
/selftests/kvm/include/x86/apic.h
index 31887bdc3d6c4..6cf91b917ef50 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -67,6 +67,7 @@
 #define		APIC_LVT_TIMER_PERIODIC		(1 << 17)
 #define		APIC_LVT_TIMER_TSCDEADLINE	(2 << 17)
 #define		APIC_LVT_MASKED			(1 << 16)
+#define	APIC_LVT0	0x350
 #define	APIC_TMICT	0x380
 #define	APIC_TMCCT	0x390
 #define	APIC_TDCR	0x3E0
diff --git a/tools/testing/selftests/kvm/x86/pic_lvt0_extint_test.c b/tools=
/testing/selftests/kvm/x86/pic_lvt0_extint_test.c
new file mode 100644
index 0000000000000..9ee8a935cf7ec
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/pic_lvt0_extint_test.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Verify that an interrupt latched by the in-kernel 8259A while the BSP's
+ * LVT0 is masked is delivered once the guest unmasks LVT0 in ExtINT mode.
+ *
+ * The PIC kicks a vCPU only on a rising edge of its INTR output, and only
+ * a vCPU whose LVT0 accepts ExtINT at that moment is kicked.  An edge tha=
t
+ * arrives while LVT0 is masked therefore reaches no vCPU, and the output
+ * stays high until the interrupt is acknowledged, so no further edge
+ * follows.  Unmasking LVT0 must thus by itself make KVM re-evaluate
+ * pending ExtINT, otherwise the interrupt is never injected.
+ *
+ * LVT0 is masked both by writing it directly and by soft-disabling the AP=
IC
+ * through SPIV, which is how Linux masks it in setup_local_APIC() before
+ * re-enabling ExtINT on the BSP for the 8259A ("noapic" or PIC mode).
+ * Hardware-disabling the APIC through IA32_APIC_BASE also makes a latched
+ * PIC interrupt deliverable and is covered as well.
+ */
+#include <stdatomic.h>
+
+#include "apic.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+/* Any ISA line other than the cascade (IRQ2) works. */
+#define PIC_IRQ			4
+#define PIC_VECTOR_BASE		0x30
+#define PIC_VECTOR		(PIC_VECTOR_BASE + PIC_IRQ)
+
+/* 8259A master command/data ports and command words. */
+#define PIC_MASTER_CMD		0x20
+#define PIC_MASTER_DATA		0x21
+#define PIC_ICW1_INIT_ICW4	0x11	/* edge triggered, cascade, ICW4 */
+#define PIC_ICW3_SLAVE_ON_IR2	0x04
+#define PIC_ICW4_8086		0x01
+#define PIC_OCW2_EOI		0x20	/* non-specific EOI */
+
+enum {
+	SYNC_RAISE_IRQ,
+	SYNC_LOWER_IRQ,
+};
+
+static bool is_x2apic;
+static atomic_uint nr_irqs;
+
+static inline void pic_outb(u16 port, u8 val)
+{
+	asm volatile("outb %[val], %[port]"
+		     : : [val] "a"(val), [port] "Nd"(port) : "memory");
+}
+
+static void guest_pic_init(void)
+{
+	pic_outb(PIC_MASTER_CMD, PIC_ICW1_INIT_ICW4);
+	pic_outb(PIC_MASTER_DATA, PIC_VECTOR_BASE);
+	pic_outb(PIC_MASTER_DATA, PIC_ICW3_SLAVE_ON_IR2);
+	pic_outb(PIC_MASTER_DATA, PIC_ICW4_8086);
+	/* OCW1: unmask only the test line. */
+	pic_outb(PIC_MASTER_DATA, (u8)~BIT(PIC_IRQ));
+}
+
+static void guest_pic_irq_handler(struct ex_regs *regs)
+{
+	atomic_fetch_add(&nr_irqs, 1);
+	/* ExtINT bypasses the local APIC's ISR; only the PIC needs an EOI. */
+	pic_outb(PIC_MASTER_CMD, PIC_OCW2_EOI);
+}
+
+static u32 guest_read_apic(unsigned int reg)
+{
+	return is_x2apic ? x2apic_read_reg(reg) : xapic_read_reg(reg);
+}
+
+static void guest_write_apic(unsigned int reg, u32 val)
+{
+	if (is_x2apic)
+		x2apic_write_reg(reg, val);
+	else
+		xapic_write_reg(reg, val);
+}
+
+static void guest_write_lvt0(u32 val)
+{
+	guest_write_apic(APIC_LVT0, val);
+}
+
+/* Soft-disabling the APIC sets the mask bit in every LVT entry. */
+static void guest_soft_disable_apic(void)
+{
+	guest_write_apic(APIC_SPIV,
+			 guest_read_apic(APIC_SPIV) & ~APIC_SPIV_APIC_ENABLED);
+	GUEST_ASSERT(guest_read_apic(APIC_LVT0) & APIC_LVT_MASKED);
+}
+
+static void guest_soft_enable_apic(void)
+{
+	guest_write_apic(APIC_SPIV,
+			 guest_read_apic(APIC_SPIV) | APIC_SPIV_APIC_ENABLED);
+}
+
+/*
+ * "sti; nop; cli" opens exactly one interrupt window, so a pending ExtINT
+ * that KVM knows about is taken before "cli", and one that KVM ignores is
+ * not.  The test thus never relies on HLT, which would hang the vCPU in
+ * the kernel rather than fail when the interrupt is lost.
+ */
+static void guest_check_irqs(unsigned int expected, const char *when)
+{
+	unsigned int got;
+
+	sti_nop_cli();
+	got =3D atomic_load(&nr_irqs);
+	__GUEST_ASSERT(got =3D=3D expected, "%s: got %u IRQs, expected %u",
+		       when, got, expected);
+}
+
+static void guest_code(void)
+{
+	cli();
+
+	if (is_x2apic)
+		x2apic_enable();
+	else
+		xapic_enable();
+
+	guest_pic_init();
+
+	/* Control: LVT0 already accepts ExtINT when the line rises. */
+	guest_write_lvt0(APIC_DM_EXTINT);
+	GUEST_SYNC(SYNC_RAISE_IRQ);
+	guest_check_irqs(1, "control, LVT0 unmasked");
+	GUEST_SYNC(SYNC_LOWER_IRQ);
+
+	/* The line rises while LVT0 is masked, so nothing may be delivered... */
+	guest_write_lvt0(APIC_LVT_MASKED | APIC_DM_EXTINT);
+	GUEST_SYNC(SYNC_RAISE_IRQ);
+	guest_check_irqs(1, "LVT0 masked");
+
+	/* ...until LVT0 is unmasked, which alone must deliver the IRQ. */
+	guest_write_lvt0(APIC_DM_EXTINT);
+	guest_check_irqs(2, "LVT0 unmasked after masking");
+	GUEST_SYNC(SYNC_LOWER_IRQ);
+
+	/*
+	 * Same, with LVT0 masked the way Linux's setup_local_APIC() does it:
+	 * soft-disable the APIC, soft-enable it again (LVT0 stays masked),
+	 * then write LVT0 as unmasked ExtINT.
+	 */
+	guest_soft_disable_apic();
+	GUEST_SYNC(SYNC_RAISE_IRQ);
+	guest_soft_enable_apic();
+	guest_check_irqs(2, "APIC soft-enabled, LVT0 still masked");
+	guest_write_lvt0(APIC_DM_EXTINT);
+	guest_check_irqs(3, "LVT0 unmasked after soft-disable");
+	GUEST_SYNC(SYNC_LOWER_IRQ);
+
+	/*
+	 * Globally disabling the APIC turns LINT0 into the processor's INTR
+	 * pin, so a PIC interrupt latched while LVT0 was masked must now be
+	 * delivered.  This must stay last: the APIC is unusable afterwards.
+	 */
+	guest_write_lvt0(APIC_LVT_MASKED | APIC_DM_EXTINT);
+	GUEST_SYNC(SYNC_RAISE_IRQ);
+	guest_check_irqs(3, "LVT0 masked");
+	apic_disable();
+	guest_check_irqs(4, "APIC hardware-disabled");
+	GUEST_SYNC(SYNC_LOWER_IRQ);
+
+	GUEST_DONE();
+}
+
+static u8 pic_master_irr(struct kvm_vm *vm)
+{
+	struct kvm_irqchip chip =3D { .chip_id =3D KVM_IRQCHIP_PIC_MASTER };
+
+	vm_ioctl(vm, KVM_GET_IRQCHIP, &chip);
+	return chip.chip.pic.irr;
+}
+
+static void test_pic_lvt0_extint(bool __is_x2apic)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	is_x2apic =3D __is_x2apic;
+
+	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_install_exception_handler(vm, PIC_VECTOR, guest_pic_irq_handler);
+	if (!is_x2apic) {
+		vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_X2APIC);
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	}
+	sync_global_to_guest(vm, is_x2apic);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			if (uc.args[1] =3D=3D SYNC_RAISE_IRQ) {
+				kvm_irq_line(vm, PIC_IRQ, 1);
+				/* The edge must be latched for the check to mean anything. */
+				TEST_ASSERT(pic_master_irr(vm) & BIT(PIC_IRQ),
+					    "PIC IRR bit %d not set after raising the line",
+					    PIC_IRQ);
+			} else {
+				kvm_irq_line(vm, PIC_IRQ, 0);
+			}
+			break;
+		case UCALL_DONE:
+			kvm_vm_free(vm);
+			return;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	/*
+	 * vm_create_irqchip() silently falls back to a split IRQ chip when KVM
+	 * is built without the in-kernel PIC, in which case KVM_IRQ_LINE can't
+	 * reach a PIC.  The PIT capabilities share that Kconfig option.
+	 */
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PIT2));
+
+	/*
+	 * Separate VMs so that x2APIC can be hidden from the xAPIC guest;
+	 * KVM disallows changing CPUID after KVM_RUN.
+	 */
+	test_pic_lvt0_extint(false);
+	test_pic_lvt0_extint(true);
+
+	return 0;
+}
--=20
2.56.1

