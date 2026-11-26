Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795700900;
	b=uIwNZCSgqwsyqvZpBrEBZIsliIvFLyDdYK5Mq9r+q6k3vXMRzaAi/ogHtWFwhpMww8TZ
	 vkMWC65L9c1YvgHaEns/s3xxP7AzcgNAUmlWINmMFElvM5q/dUjPK/X+5yKNm85kgJEUF
	 97wh3Wj11EG07kIuVWD5/OT1WDk1j6X2WKJvNjKeD/i6jc7QIEO63Wmz+QZSeD0nw5+X/
	 GbliNU1SREO3SfrkE1HXWnNMDdcGjYHY5dmpNiSD4Zt1Q+OQqnwcnK2BpyTE+/+mGjiLo
	 OJ0y++ZqLlCOm+2+aszZ89EsxDAdhvPtJntDt4G8L9xNKyazht6BT3r6ybshEC4V8Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700900;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:Date:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
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
	bh=uCSVUKM+hP7ZleX3nh4QGp014BnPsssJQbDFTDMZcyQ=;
	b=bgrrNuWLQVA5oATq3mPNgbFlGbkglAimEISZEzOWZG+nfmlaMt1oiCKDtfE7bM2QwY2D
	 2wusvrzqa725EvPcdvRjr+9k6ACWh9kTbeIZt3Mn1y063Y7CFm5Ay+dWIZSnf6ga1Uapj
	 PrDKOxfsoinwhhhwUG+HKLqS7oJgVVKupYKzFUu55gYN8+t1yRtVVgLm8krCrnDEjsHKQ
	 6J16oSxs7HhQmZAyU3dTIUSvOciscykGSnZixAohBqIEGuXsds1BPtjQFt8YMZoHVl7uI
	 cQwqUFw0x/lNqQNtOS10Ct5aD1CfergNnKZfNHVP1L1En7BuI+JHIOS6tWCqYn32nbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=XlIHjAww;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.17
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010017.outbound.protection.outlook.com [52.103.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D2606A31C;
	Thu, 26 Nov 2026 13:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 425D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=XlIHjAww
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsP0BvtYjxKlJizrCZLoo0gqmlB2XtCvd0Ke3uB5yCU9MRwmdkwKXz32B3RIxNAnKqiKJmZwliZlrUTkL9lJKvDD2I7diawBqgX5qlmNEmQVlP7czpPla6DT0I+0caqOWGD4Kvmbnb0xHoAkcFl3KWhPU8e6cBFjx32gOah4UB/8svu0Sof3sbf8r1J14j9+HvUmnu7Mf1MAfS+bIh3X6SSg4kpLpZmb4KyE5q4HO/qEbj8WYZWy1n2BOTIL1ZQgjun9eXHF32v1ggmrkVlemlDHfNZtSByFgGK9qeagdBTEBdZm/fIk/gf4mlTu7R1GLIm+hfOn/eZ6OWakGNXeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCSVUKM+hP7ZleX3nh4QGp014BnPsssJQbDFTDMZcyQ=;
 b=jSnirVNF0NnZbh7PT3gLQ85KoE0XR+lRZrmKDOJb0usDxMYETJdXMN5goy6m+4k9vWfw55i4UgE1gZulaWDaE1wDnyfuahdpOBdXK5L3McldrI//6stzZ0cSjMZNvJhGNL5Ag1RrG8vee/nKSoBjyuVef0DQkK6WxXn0IXTe1/MpTdkb2IBDb9y5l13kqpxAG4tZj1YMRN2qZRVkTGWYLvATYLOItZm7UxMIYha7+YP9IFmqBp6CYx7gIIfJCGqCg+xQgUJBdaUv+4SFXBAvkqin5SQGM5H4u9pLYdeWmsi9XB1KBYDu9EhTOntjGPh5kVIdcpXlQ19GDymiA7aC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCSVUKM+hP7ZleX3nh4QGp014BnPsssJQbDFTDMZcyQ=;
 b=XlIHjAwwE+skSIG9EkbDAgIKBMnEOjkEm/pcBLfKOBPig3HS6k0Dc1o+eq24dvVONCljuzgylnxM0NDrc36+8uQYg4znEAcDvyb9IRVkBZB83yCF3aZbDWi38TEdBsjkQH6zw17l2OO2j0ozmnHXkQz60uH/hYoAfbaWoEgPG1Eiya/jfC6OpUi4ymnTuTQ+bcO1qxC7bKHktKc6KwM2V3L0XTDukHAXo4HTk+dqywqirKvl1d1waafIWFKXWP6Je/ts8qG0nmoKoAU9WaxWRP02KS5Ozf8CskKT5B5Uu4Mw33ooq0aIbd/JSL/owM5S4L/xiIq4CXdBxKiVr9bmhg==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15563.jpnprd01.prod.outlook.com (2603:1096:405:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:48:16 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:48:16 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH v2 0/3] KVM: x86: Don't lose ExtINT latched while LVT0 is masked
Message-ID:
 <OS3PR01MB1025133EF63D307090C7718DEE7422@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Matthew Leach" <matthew.leach@collabora.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Date: Thu, 26 Nov 2026 13:48:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::12) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <d144ced4-5c65-4301-94a8-4e8fc1529f6c@milk.local>
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
X-MS-Office365-Filtering-Correlation-Id: 751f5bed-dac0-4943-294b-08df4bc3ebf1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|25031999004|5062599005|22091999003|24021099003|55001999006|24121999003|51005399006|25010399006|5072599009|23021999003|6090799003|15080799012|10035399007|40105399003|1602099012|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3NyU1NGN3VCUms0V056bVd6aTZVbHlFbmhrRVVWRUpHQXhkZUNFblZXZHFL?=
 =?utf-8?B?aGY4dTVUMERya0xYdmgvcXdTYittZERsMGRjc0RqSElDTmpNK0ZjK0FaSEcw?=
 =?utf-8?B?cEFXUWRFZEtRRGsvUkhYZFN2T3dqUy9JRjNWM1NFNVpNcEthcHBpdS9DSlRC?=
 =?utf-8?B?aThUTjNQOUM0UHh3Sk9aTWorbjdEUS9SenpkTmNtUU9NSDNuTFBrU2grak5k?=
 =?utf-8?B?L050VVJUc0Y5QjRzKzQzM0E1eVJlTVBKbmFnODluRTMwSkF3U3UvRmFlYkpE?=
 =?utf-8?B?eFNSc2poQ0VlRkR2bHU5VmFMUzV2MDFkamxtWXVteTBFenA0eUhhVFlZUVpa?=
 =?utf-8?B?aThycmdkMGZvNUJiOUI0NWRHcGRsSjdnbzFreitWZUpobFM2OWZWbFlYdU1x?=
 =?utf-8?B?TW9DL05oQnF0SUg1YzNzcGF6OXo5Y0ZDMWpTZUFWU294NytjYk1FV2kycFA0?=
 =?utf-8?B?NjNhMTc4KzgrWnJIcS9SRVNzUzhMaTdRNWpKaDdNRFNLSmpzZ1NBK0JoQk1K?=
 =?utf-8?B?RFRHSThXc3ZONHFSSDhZUjdtK0Eya1VTU3FvOHRnK0d2SHpzOW5qUWd1Z2gw?=
 =?utf-8?B?NHlMZm9IL1FieTd0bW1UTDhKYXorSWp4K3RDVFd0VmRzd0w3M0lzREsreVpM?=
 =?utf-8?B?Mk9wOU9BdDJhakxTZUxCbFNzbmdqKzMvbGZGRkpDS2M2WE9nMjJ1UTZWTExr?=
 =?utf-8?B?VnNoSHRociswTVk0dWNyNEd1eXgwZmdpSm8vNEM0ZWxETkNCeWFHSkx6WHJL?=
 =?utf-8?B?c3p1aUgrZkRxZXZuWWdUMCtKVmJwalZLWHU3Um80RllyakY4cnF5cEQwVFo1?=
 =?utf-8?B?L0trVWVOaHV5bnVSR0pNbjFQai9lUythNzJFU3N6R1NSa1hOMDBFdW0yUE9B?=
 =?utf-8?B?MDBhdzhXeTVOZGJXekNsWW1hd2JaVlEyNXdHT0ZyYitoSTQzZStWTWlRdFNT?=
 =?utf-8?B?NnM4ZmJmS0hHYXdXRjAwUEZUV2kvbmJIT0tUaDhURXQxSGlWcFcvMWNqV0Z2?=
 =?utf-8?B?SVdEMGh4S1VUR1BBaDF1M1h4ZHFKODJBWVo5bmxJZjlLcUhXU3lDVmJkcHkv?=
 =?utf-8?B?dXVYK3B1OUxpMEpiZjZBN0pKeEJORFUwREJzU01DV1J4clUzL3U1NnVTbHlP?=
 =?utf-8?B?b1VZb0lIUFdMellvY0lxV3hUQWdZdEV5TkpOcnRaR09rU0laV00raVRrNVFZ?=
 =?utf-8?B?VjF3Q0laRzZxV3Z1U1NNUTJoVElhS1JJY1QvSUx0cTM4UTJsMmxBQ2pmb0Qx?=
 =?utf-8?B?TUZZWkxSQ2dwNU1DbDlUTTZ1azFQYlY0ZDBDMllDMEgzQ3g4M2Q2UnNSUEFK?=
 =?utf-8?B?cTVNRXBaLzRZY1pFQUV6WTY1NDczeWhCRmF6cHhZZUhXOWxiMzVPbklITzJw?=
 =?utf-8?B?R1RuUWpmVjZpekFmb1IzTytNbEJGMDZtcmVERHQvU0NBa1NzT3VjbW1za1pW?=
 =?utf-8?B?cE01SzBSblIySkY2MjJqL01lKzRpNWgyQjdHN1A4U3Y3cVVIV2trbWJ5ZE9V?=
 =?utf-8?B?dUZSRGRHUnVRMnJqNXpxM3VrdzQwUG9XRWx0REI5d2hMYlVuV291dmpacDNR?=
 =?utf-8?Q?0rLWK3bout6KsJjvEId9z7iDI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elpJVTZmOUx5cDNWYWVadDJIR3paeER0NXBDbHZuRU9mVTE5QlVTNzkzL3B2?=
 =?utf-8?B?NklWazlNQ1Exd1dRclh3NEsyQWYrbGc2eTNHajNZZUpkM2lNUWFZclZyaGtI?=
 =?utf-8?B?TVlnOVNNOHpPSVBRNHIxVTZ5TDNwSytEYWR2ajJ3TEFXdUdMYWtEZkVxbGVx?=
 =?utf-8?B?dzFXbjZnR0FtaXFwQkFyU0lGRXRoWlRHRDJuNTVNeTF5Zk9malJsTUtPWVlX?=
 =?utf-8?B?ZXJxWlNLN0drTWppTTZjdVl3Y0xCd3BZYUxockJkaVFtcGNKc2NEcDFjclY2?=
 =?utf-8?B?MlZ2d1pCTWxVOFF6cVlLb3YxTkEveVNzUHV0L1FNanFnQlBZRjFYKzQ0RkRL?=
 =?utf-8?B?bzVaVXJYWjh1WjBhOVB1YnplRWE0VDlUVDVEMVJsd2wyc0NuREdudnE4dzZp?=
 =?utf-8?B?L1BPQ2ZDOTRCRndjVnA5aGJOVHR4YkEzWDlOajRyVEpBckVGV2diUlo5YkZi?=
 =?utf-8?B?dmZkbVFZTUI4d3hXQkZCWXFaaFMzb2FobWc2NndqcTFaSW1NbWJtTDNWd3l2?=
 =?utf-8?B?TnBGbkNURUc4b0FnZDhQWUJiWnpOTXk3Vm16TTk4d1ptK210enpTODMzTm9H?=
 =?utf-8?B?LzlvYVJpWE5aUEFlZktzQmJIVm9GR0twL0MxdEZ2YkhEZWtBZFFISHR1NVBT?=
 =?utf-8?B?TGtEdTl1endlcWtvN1VvR28rWXR2a0NJL1NzMXVXYmFtRGJlSXdLU0tNSVNa?=
 =?utf-8?B?ZVhJU1pWakNianhqWEF5WWVxUGwyRU9VY1BzeXg5c0M4WDJxSjQwb2RzQy92?=
 =?utf-8?B?UmloQkRDTUxsMFU2cTFnV3cyQTFGUHd3VkNPUmZDY2RZRHVYaFJxM1pINUJ0?=
 =?utf-8?B?Y29WU2o1OUlkWklaa1Fockw1Y1VqWXN2UWJ4Z016bmlrdmM1NnByM1l3a2tR?=
 =?utf-8?B?RjgyR3JnWlpTTjBDSDdYK2ZoY09tdVFyS0xNejJzY05Bc0pFMDBaVEhNWGVx?=
 =?utf-8?B?SWlPaFFkQS9PamJuV0JRcHRKVWNWc1dtUUc5bDhNSStRTzJJR0Q0TElaakRr?=
 =?utf-8?B?YzBwdDRHUW95SnJCV3BtclY5WUJ3N3hMN2pJSkFuZCtHYWdKenNwclcwemlw?=
 =?utf-8?B?M2ZWd053K0g3eEQyYWtsbEVHZWpZa1FXNWxhQUtScE1WbFhXZjFzQ0N3a0tt?=
 =?utf-8?B?TVBiWklOa2hLalJwaitIcncyOWZ4S0lTaUlySnFncEJ0WWVSZWFGZG1MeXhC?=
 =?utf-8?B?cWIybTdoYnA5czlSTy96SWJILzZIVVFnT1VpZVFKVEozcWozMnZjTy80TmQz?=
 =?utf-8?B?MjJXRDhtRUZ6bzA0NkY5R2RxbGpRQ3psL2hKdlFkcitHM09NR29lZDR4UWFB?=
 =?utf-8?B?TnZxaVR5cXhvSFBBMnVYZlUrUmdRSU0xQmlDWWpJY3lGNkxsUk5jTkNIOS9y?=
 =?utf-8?B?aVg2NFdjNmVaeWhSRkdMVHlVb2NXOVppNlJHQWZMZ095b3NYTEZWSzlDV3pQ?=
 =?utf-8?B?dmx3WWZoRm9jUkZCamlKSXJET1ZkSU05c0JMVi9xSSs3UFFrSGVOelMzTDRu?=
 =?utf-8?B?RWZ6VUk3dHhQaS8rTk5ZQ2RQalFoNHJPM2VQODB3QUc0TTNnajhzMnJPUUZX?=
 =?utf-8?B?UC9yOXp0c3grS0hSWXBvVnNKVmJKMzl0QWVoemRFN0oyVEwzRmdjR3pycFUz?=
 =?utf-8?B?dnVhVGdsdzhmd0dScUY1T1N0WndRRkZ2QWRHNDF6ZExNUmJhWG8wV3FpdTBH?=
 =?utf-8?B?bXNjNTdjM2pqN3lUWkVuNzdBdDA3THZWSmVhTVJ0czAzQ29zaDBjdlVjK1hi?=
 =?utf-8?B?dFNpVUFwZzdjT25YMUwzSWwzVDVXeEttWWxIV3RBbGtyWTUwYjlXckdVNEUz?=
 =?utf-8?B?UVVZV1lVMklkQWdySFJGU2NiUTBzTG1lZzBUS1orY0NTUFFwaXRROFpla1Fv?=
 =?utf-8?Q?v0TQYCl2VUhKZ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f5bed-dac0-4943-294b-08df4bc3ebf1
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:48:16.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15563

The in-kernel PIC kicks a vCPU only on a rising edge of its output, so
an interrupt that arrives while LVT0 is masked is never injected when the
guest later unmasks LVT0 (patch 1) or hardware-disables the APIC (patch
2), as neither path requests KVM_REQ_EVENT.  Linux guests booted with
"noapic" hang this way in calibrate_delay_converge().  Patch 3 adds a
selftest for both paths.

The selftest fails at the LVT0 unmask on the base kernel, at the APIC
hardware-disable with patch 1 alone, and passes with patches 1-2.  Full
KVM selftests and kvm-unit-tests show no other differences.  Tested on
AMD only, nested with AVIC disabled.

v1: https://lore.kernel.org/all/20261008-lapic-extint-lvt0-unmask-fix-v1-1-=
db2bf68fba75@collabora.com

v1 -> v2:
 - Request KVM_REQ_EVENT on any unmasked LVT write [Sean]
 - Add the APIC_BASE fix and the selftest

Jiaming Fan (2):
  KVM: x86: Reevaluate pending interrupts when hardware-disabling the local=
 APIC
  KVM: selftests: Add a test for ExtINT latched while LVT0 is masked

Matthew Leach (1):
  KVM: x86: Reevaluate pending interrupts when unmasking an LVT entry

 arch/x86/kvm/lapic.c                          |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/x86/apic.h  |   1 +
 .../selftests/kvm/x86/pic_lvt0_extint_test.c  | 241 ++++++++++++++++++
 4 files changed, 246 insertions(+)

base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
--=20
2.56.1

