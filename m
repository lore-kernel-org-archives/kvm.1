Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020083.outbound.protection.outlook.com [52.101.201.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B203859FA;
	Sat, 18 Jul 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784379560; cv=fail; b=kFacvPfO78Gu9WY0YIqUygVsJSe/cdFQ1lSNuikl3V+RChi3ORcgnx4MEqI0ntX2O0O+JJFLZWHOZeEySRwWRvv0drDek/JC2R5b/biQ4OElWRoI3KG4NojXPgZ5x/T4s/beB8rerR+Pnbq/O5QA+hjcaWi8hbW0QKYh8zK3Gig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784379560; c=relaxed/simple;
	bh=6ocI9MM8Xw/XZrLJi2qhqbdkLUBi3BsB3d+8UsXsn8c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jpnPVQxHjAPDMIU4JS+UE/RLjFW6+vUwJlT7U7KnM1hK6+J5AmywyFwRTKwmJ+wg1Y/YhsRPOSr5cHX/+sZ7J6Eo7YbjfggFR7RoFwLa60+OlcpwH51Nl0fbU3UIKTE5wozHL4td0kpKKoCGITdIJQsbbGBTb4xrJEf0nOSXhJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs; spf=pass smtp.mailfrom=phil.gs; dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b=DvGXYnzB; arc=fail smtp.client-ip=52.101.201.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phil.gs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b="DvGXYnzB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6wti/HiHwYj3tBV0Bg0z765AzNCPR1qpzCj7VOddPYJaxdiosU84KxQcSB+PNQumExVbP4KAkHmfDgeOoccvmKMkzkkfuocb+znRpd6isUZ9gTshs5oxGNTdXaot+ODwrNoQAh7GZyvH+R4ww2NvEqbAU4YCr3UCZL7MTnM4HI9kKigZxBcy19wryOokoo3LEdlbl5U+Z9PSYoE84HlBZ1uocouj7S8QmmOkhmwGcjy1tEV4iIHv52aP0BY98ARSjE6ZFMcDU1c+uC0DJt0SLSzwqyL4lmXOVjMKncDzuIlPAY7Rr+tzyLWG2gi6Xsty9ZgXHnukWkcsE6yl1uxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ocI9MM8Xw/XZrLJi2qhqbdkLUBi3BsB3d+8UsXsn8c=;
 b=peTSOpL383rxuQQU7YcO9DxuPXKq2UK2JF4dvOIA/ZximiRsXzBSyUCpewNc0HPyeQGrRbr6Ka0sLZZZxM/AIwrscDCEUoadZ8qiw1TxJbHIkSVmXWWAunVjacOpT5UusZVU98HPU50M7yHbdd2sFu4FkrsSB/3A5TekVUVsRYLNacSOLl2khL/YROiPx5VkNRAcP+hMAUzALhh2JolITkRtQz3yb5iCfy9EggiIDZh4txzZPnDaMJ5ihQwdBGK+vEsPZvpNAx6uLdJRDI0mPaqFS4Bjzw/FXFSJWFXYtVh1TU26ho0Z6xieVrKktqWLtMKyDZJlLmLK6GkYz9DGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ocI9MM8Xw/XZrLJi2qhqbdkLUBi3BsB3d+8UsXsn8c=;
 b=DvGXYnzBA0yLwG0fVQbAGsqXGcqUG/Rl82C9mq1i1x0R0h23FCEmya1/VA919OrRsBlcWyA1TB6FH3IBuCGO50Mdfo3vGyHbcdUHWjjwNObFS9q0+ifqIjGV9kb0NTEcXcAY/Fq0szcKcMuZfCfiPIJcOp5wJtxUDefhtDywlwk=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by BN8PR04MB6386.namprd04.prod.outlook.com (2603:10b6:408:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 12:59:17 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 12:59:17 +0000
From: Phil Rosenthal <phil@phil.gs>
To: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: x86/mmu: Fix double-free of mmu_page_header_cache on
  vendor module reload
Thread-Topic: [PATCH] KVM: x86/mmu: Fix double-free of mmu_page_header_cache
 on  vendor module reload
Thread-Index: AQHdFrU9BLUzBrbZrkCLVxfvABxMug==
Date: Sat, 18 Jul 2026 12:59:17 +0000
Message-ID: <3FD1B35F-ECF8-476D-B2F1-6A43E6E0B641@phil.gs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|BN8PR04MB6386:EE_
x-ms-office365-filtering-correlation-id: 8e245647-9e7e-4713-388a-08dee4cc607c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|7055299009|18002099003;
x-microsoft-antispam-message-info:
 CR+L0Cf/jZaMpMpq+HWvmWKxqa00LYGgdCDNuqcj6c0ORgNt1rwoe/0XQ+SS1M833O7lK7CwaZ+IZpoyp3CySrfBUfv/9H3fjhDTcNVtwUSs2ZcPbmpN+U4OIq9vNalaVEPjWEGDesP/bPgu26hyra/QpQ0bbdQfLzjsL00cp2p7kXTUan0p3fN0AO5Un/1H/WNLFfVUxdE/7nA09F7X+fgX8ci52mN5cC8iLaXpFczmQo+k9601MfoYmsr6Og+wqnysxu17+mer3wCA0C3pQnPERdzL7AkzuwsMMaoKUksCaQSAMgceiCraD6/5eIsfAc1EiVJe5aM7FOcisRLEf0HpDTOKJjzzl8bbBhh78wjE8iLkrttTZaM/DQngEgqXk3gyprKedwiQKx4ExsqObpg9SgyfKtB2YafsA7PcH9QjKLHZw+eTBeBno2xPzpqXZcmlvIKJJ5na5xjDx40cbF8sJZylA/mm6OQm6mFxCq9B90M6bgkfXWdnbO36GQpjRdHJB/wbjpYzxszYYGeNSv5Zit0KJeTWXaJ3/wCfndKLUQJO16INDQ9qiUDuzPNmYom1QcfI8n3dbQntXWS2Vtgn/EWzIVCLaKlNEzfx54ItOhLLhiCGgMjCCNnrU9l5IxU60J7Y0WkAbLgCJ1NAG4GKc/vzDEe/LKVKevJDNMskXZFh+ZnS/NGepqbYXbkcmhGWLYi5sat1HITzF3FRbyZQKVHWx4conDm8GECmbnPmnw9Wq7XEuoG2EyKUpYCW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(7055299009)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlI2MEpjd1pSb2xMVGc4VGg1OFhaN2J6MFArUDZ5Y0E4dU9mMG80bERrVWc4?=
 =?utf-8?B?K3hXOWk3ZXBxcFNiUDhZa1R2VmxXcll2b0M5VFc1YmhPZWw0QjhzVFpsRjB5?=
 =?utf-8?B?TGg5Y3Rxc29BdXVMWTJVSGMza3BnRjlhUmFtOFRiRWlTc2ZaOWZjSk0xYUNk?=
 =?utf-8?B?TjZlWFlnWTY3Ymd0eXFwYlJPOTgzNloyUUpGVmlaeU1NM0J1VUE0NlRPUjJI?=
 =?utf-8?B?blBiVFJ5UzdRUXlGTnRhSjlvbWdUblpseDlDOXlPcmVXdkFNUjdEQW13SnRa?=
 =?utf-8?B?bVFQN1dsS21jT0JoRTdwOEN4elg5ZXppZzB1dS80eTlCMjhrVW95KzBpejlL?=
 =?utf-8?B?ZXZhSUpwQ09PYmpraTF5eXozekJBRUp0ZEgzcW1JQ3pLUUM4QlBwQkY5b1Ax?=
 =?utf-8?B?enpZQ0xCZjVhMmtxWHdodjFrVmcxaFRreER2MEhpRGthTHppYlQzS2JlRDBu?=
 =?utf-8?B?Vk1WWFQ5WUJRdERXQ3B2RWtsdTd2QU1haDdqVmVVVFdua0FVR1hHZ1phNXpu?=
 =?utf-8?B?RVNUL2d1YVgyU0VVWUIxWEdhNHpIZVBUWlkxbnRXQnhuZEF2TnZmbFZ5QTlU?=
 =?utf-8?B?dU5WTHE3L3dBaWZJczVPVm5XdTVlUTNndTA3OHF5UUxYTEh5Q3AvTWhRdnBa?=
 =?utf-8?B?N2lXdThDV09LVE4rY0RPUnJTcHJWTXV5OE9JRnlSU0tRVlJMSlQ0bW5qR0dR?=
 =?utf-8?B?MEdjMkhvUkVHRG1vOTVPNUI3VXpLTm1UK1duNE9ublhObXRDeHl6ck04cW5v?=
 =?utf-8?B?RGNETHBOS0NoMmh4a21POFBXckJsWk1ndHZQR0x3dHM0ZTdsaDU0TG45TFRn?=
 =?utf-8?B?MGQvajZOZWdaSlMyRmtEZnRLVUljZTd2REVoVFNQV2RqeGhsKzFvRkFjQ29S?=
 =?utf-8?B?NDd0K2pQYjZ2a3ExL3JTSUMvOEhjdktqZkhjRXJYelRxdGRuT3R0cC9FWFRC?=
 =?utf-8?B?RitoOHUwMjA3bTNISkh6dE9DNHFEMXFVQjRzbWVvV3VrWThBdEF6Zy9qNHBL?=
 =?utf-8?B?TWJKYllRYXhsWHhWQ1ppVUJpcXU4Q09zRWtuQm15SjlSSGxRT0tzYWNaZzI5?=
 =?utf-8?B?L2hGeVlCQTlGL21LQkd2N1ZIR0FRcjZ5eGg3NFdITUNkbEVFaXRBdEFmdTJI?=
 =?utf-8?B?Z3c5VHlTZHhVTVpEQUNEU3l5UzJsOXNUeDhoeVdwbmxHcWgzNGRpQTB6b2sw?=
 =?utf-8?B?YkNwS1ZuMTMyRXVVdWdiOWJGU3RjQjEwL00yaVFXdmJxNGFLeEQ3WTNsNldv?=
 =?utf-8?B?aFkydUdob3FIWnVMR0pWSVNscUd2RnB1R3dvVDlKZkZQOEE5NGNyNjNSZXRn?=
 =?utf-8?B?V3VYZ2kxQmFwbFRDcnNsS2lpc3Y2OU9wZHFoWS9ySnJEeE15dkpVTGV3ajZU?=
 =?utf-8?B?M2dYSVhIcU92TnlNWUtjQ0libVhnMzNYc3ZkL3dPa0RIWFRzNlVGOWVOc3Iv?=
 =?utf-8?B?ZFJFbU40MkhLQklqTHQra3JlbDNYdzkxU1RBZzc1eTUzekVUWGlkK3hYaXFF?=
 =?utf-8?B?MEE0TTQ4L3JwTGgyZkplUjdmYUQ0ekNNTGhWVTM0SVMyUk5IbWtGTzJ5NTBP?=
 =?utf-8?B?SjcxdjJaQ3VXZjZoTjdUK1BJMm1DMjE3eXBYbEdRRTdoQnZmMWxpWlQ5K0NN?=
 =?utf-8?B?L3psL1QvYTBYZU5JOVBUejRGeWFtYkQxUmlNVkU2MUpOWHlsZlRtTnJnaXRk?=
 =?utf-8?B?cnQwb3dadnMwZlNwVmE5RHk3WjJKZ1lsZDRscmNRRW9yeVI2R0FEczVGcXdl?=
 =?utf-8?B?OWFwYXlXeUNldHBUanllUFdUMnRkcTVGL2FZdUg3U3J1dFlWdlJiNmljUFdk?=
 =?utf-8?B?cjdBMGlKaTdCaEw3SlFWaVl5WFJvZk5VWWRyQjYwU0Y1TWtYanJGcldOQm5R?=
 =?utf-8?B?WHFkUFJieVdoTXRJb2FReVNsSW0vOVJpMlBveUZvS29HdnFVQUNiN3owckNP?=
 =?utf-8?B?a0JESUlMVzAyMk1nd3c3ZmdKQTBOOFRpenFTK0JPNHJxcUdOZ25PKzErM3lF?=
 =?utf-8?B?cmRxcjdCQ0RsKzg2amFlMUNTNGtXelBCMmVncTRaVldKNmo4NWlkSjNBbWRm?=
 =?utf-8?B?YkR2QVBaMTJ6TTBnTXRYbGwrN1ZKZ0l4Q3crb3ZOZWFGTFZZYVZoMnZHVE9I?=
 =?utf-8?B?SG1iRTJ6K25tVFA1UjN5UmdQRnBUSE9heFFUOUg2TlRINGd2bWhaN0RXdDJa?=
 =?utf-8?B?WkU0cWRZVVZpQmJPSk5obkJNczFBK1d5ay9qRlhXazVPVkdhUzFvQ3dKU1I0?=
 =?utf-8?B?VThSQTJuU2F5Zm5lSHVIcEg0dFFKaGFBVHhZc0hNTzVkT3hGek1iUFNZT3RM?=
 =?utf-8?Q?P+gw+bzHtF0hr1yguc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE0AC54FD4A95A44B57089650D556EA5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e245647-9e7e-4713-388a-08dee4cc607c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2026 12:59:17.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WZQ68XDYozilybstKGpIXX5a7NeTa05SpsYD2CrVdu0ZYTTL3U72kTqHQVfnyBo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6386

bW11X2Rlc3Ryb3lfY2FjaGVzKCkgZnJlZXMgcHRlX2xpc3RfZGVzY19jYWNoZSBhbmQgbW11X3Bh
Z2VfaGVhZGVyX2NhY2hlDQpidXQgZG9lcyBub3Qgc2V0IHRoZSBwb2ludGVycyB0byBOVUxMLiAg
QmVjYXVzZSB0aGV5IGFyZSBzdGF0aWMgZ2xvYmFscyBpbg0KdGhlIGFsd2F5cy1yZXNpZGVudCBr
dm0ua28sIHRoZXkgc3Vydml2ZSBhIHZlbmRvciBtb2R1bGUgdW5sb2FkL3JlbG9hZA0KY3ljbGUu
ICBJZiBhIHJlbG9hZCBvZiBrdm1faW50ZWwva3ZtX2FtZCBmYWlscyBiZWNhdXNlIHRoZSBmaXJz
dA0Ka21lbV9jYWNoZSBhbGxvY2F0aW9uIHJldHVybnMgTlVMTCAoZS5nLiwgdW5kZXIgbWVtb3J5
IHByZXNzdXJlKSwgdGhlDQplcnJvciBwYXRoIGNhbGxzIG1tdV9kZXN0cm95X2NhY2hlcygpIGFn
YWluLiAgT24gdGhhdCBzZWNvbmQgY2FsbCwNCm1tdV9wYWdlX2hlYWRlcl9jYWNoZSBzdGlsbCBw
b2ludHMgdG8gdGhlIGFscmVhZHktZnJlZWQgY2FjaGUsIHJlc3VsdGluZw0KaW4gYSBkb3VibGUt
ZnJlZS4NCg0KQ29uY3JldGUgdHJpZ2dlcjoNCiAgMS4gTG9hZCBrdm0ua28gYW5kIHZlbmRvciBt
b2R1bGUgKGJvdGggY2FjaGVzIGNyZWF0ZWQpLg0KICAyLiBVbmxvYWQgdmVuZG9yIG1vZHVsZSBb
bGVhdmUga3ZtLmtvIGxvYWRlZF0gKGNhY2hlcyBmcmVlZCwgcG9pbnRlcnMgbGVmdCBkYW5nbGlu
ZykuDQogIDMuIFJlbG9hZCB2ZW5kb3IgbW9kdWxlOyBmaXJzdCBjYWNoZSBjcmVhdGlvbiBmYWls
cyDihpIgZXJyb3IgcGF0aA0KICAgICBkb3VibGUtZnJlZXMgbW11X3BhZ2VfaGVhZGVyX2NhY2hl
Lg0KDQpGaXggYnkgcmVzZXR0aW5nIGJvdGggcG9pbnRlcnMgdG8gTlVMTCBpbW1lZGlhdGVseSBh
ZnRlciBkZXN0cm95aW5nIHRoZQ0KY2FjaGVzLCBtYWtpbmcgdGhlIGNsZWFudXAgaWRlbXBvdGVu
dC4NCg0KVGhlIGJ1ZyB3YXMgdmVyaWZpZWQgb24gYSBLQVNBTi1lbmFibGVkIGtlcm5lbCBieSBp
bnN0cnVtZW50aW5nDQprdm1fbW11X3ZlbmRvcl9tb2R1bGVfaW5pdCgpIHRvIGZvcmNlIHRoZSBm
aXJzdCBhbGxvY2F0aW9uIHRvIGZhaWwgb24gYQ0Kc2Vjb25kIGxvYWQsIHNpbXVsYXRpbmcgT09N
OyBLQVNBTiByZXBvcnRlZDoNCg0KICBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGlu
IGt2bV9tbXVfdmVuZG9yX21vZHVsZV9pbml0KzB4MWJhLzB4MWUwIFtrdm1dDQogIC4uLg0KICBB
bGxvY2F0ZWQgYnkgdGFzayAxMTY5MzogICA8LSBmaXJzdCBsb2FkDQogIEZyZWVkIGJ5IHRhc2sg
MTE2OTY6ICAgICAgIDwtIHByZXZpb3VzIHVubG9hZA0KDQpTaWduZWQtb2ZmLWJ5OiBQaGlsIFJv
c2VudGhhbCA8cGhpbEBwaGlsLmdzPg0KVGVzdGVkLWJ5OiBQaGlsIFJvc2VudGhhbCA8cGhpbEBw
aGlsLmdzPg0KLS0tDQogYXJjaC94ODYva3ZtL21tdS9tbXUuYyB8IDIgKysNCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11L21t
dS5jIGIvYXJjaC94ODYva3ZtL21tdS9tbXUuYw0KaW5kZXggMjM0ZDBhOTVhYmY1Li5lYzQ5Y2U5
OGE0NDkgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jDQorKysgYi9hcmNoL3g4
Ni9rdm0vbW11L21tdS5jDQpAQCAtNzU3NCw3ICs3NTc0LDkgQEAgdm9pZCBrdm1fbW11X2ludmFs
aWRhdGVfbW1pb19zcHRlcyhzdHJ1Y3Qga3ZtICprdm0sIHU2NCBnZW4pDQogc3RhdGljIHZvaWQg
bW11X2Rlc3Ryb3lfY2FjaGVzKHZvaWQpDQogew0KICBrbWVtX2NhY2hlX2Rlc3Ryb3kocHRlX2xp
c3RfZGVzY19jYWNoZSk7DQorIHB0ZV9saXN0X2Rlc2NfY2FjaGUgPSBOVUxMOw0KICBrbWVtX2Nh
Y2hlX2Rlc3Ryb3kobW11X3BhZ2VfaGVhZGVyX2NhY2hlKTsNCisgbW11X3BhZ2VfaGVhZGVyX2Nh
Y2hlID0gTlVMTDsNCiB9DQogICBzdGF0aWMgdm9pZCBrdm1fd2FrZV9ueF9yZWNvdmVyeV90aHJl
YWQoc3RydWN0IGt2bSAqa3ZtKQ0KLS0gIDIuNDcuMw0KDQo=
