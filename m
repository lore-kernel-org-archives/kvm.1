Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255A315793;
	Tue, 26 May 2026 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789706; cv=fail; b=lSG/Fl9sfEktU5EtngpxhtLCanFUt8RqhA8JLSuIzTw60+F8tBEZTeECVAhEC3rMDRO3EF6MYIeTnHecwRR2NEuK89s2sfH2vdEQFyNgJCzRdlz6s9UisI9DgVLIV87NCyAHu9f2N2PkH6QoXuOOZHkFco2n4sZC8ySWl+g1glI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789706; c=relaxed/simple;
	bh=gHmfBRQXAR/yV4bm7EH5c6YT8NzcVEYFd9sjCJTgvNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m9LssrKdphMC6NK9nQDPOtThYy62pR8Egsk04AGX+bdU/UvsAl1qh7p0T3R4zlG1F07grqsfXNzykvRxDXbYSwOZ4Dsuvj1/G/NJySb4WI0/5yGt4sO414sOl+9q1aw2sQW0ykaIbaXm5pbUmfusqjg5Z0afXIB+uZ/QVzdwFvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Fq5EzE6j; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Fq5EzE6j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTAqCzWNrtvAW1hFq54nQUZPnhLSYDc76AWt8acQmCxhm37Re1O+hv5tpJ6zoRqyQdtyKEFv3PaVlN0rkeG44kLFh3KXD41/5Kn4/rXykTJBqrpReuY0dF/xRb6RUBLwTl/MdCOXHHTF2rv1WfPx8AnxdvK83B2ZbldJvlpRL679N7GOfTWNf4SSjovnVWhjW3qUa7SG8ukof6o5VZVWhga0vHPdP2/BLVo0efPXesef/eEKiUI7Tt0v6UG7hoJKKdoiKmW2eIFnQ3A9mCVzWSs1eN5R1k+yMw6JDPg4YWdDo+oYqXA2iJ8jNLwoaG98qttTNSHmDsnZ7nNjo3j2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHmfBRQXAR/yV4bm7EH5c6YT8NzcVEYFd9sjCJTgvNo=;
 b=meg5M6NNQoYyODSYA/Tkq+XIq1XvrYgI9I2wVoOz1BILboOFy/+sd2l4lR3/PVIlk+hSC6w7SN5ryDgLy69Uci/vCSOurPpT0ju6oaSYKeo9KRiMNbJiSGR0M2c2mw5HTOG27/bg2EuAwQkVm4AyT4wZRQ0rbFiG2V5gHGrebK/996NSOdsr1jxe/se889X0bGuIMINGik8uQOj05Noy/wWKLN/mtA9vGCUzILcvaM+xNoIWg/3Ny4u3IYb/3b2DghiAW/5rRaQqj2xq8J056YDOyiCEBQMwzuwv0uf2sTYcGGvz47bqllgJw/VYTCZEVjQ6vaDRWj18ya8xl+y/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHmfBRQXAR/yV4bm7EH5c6YT8NzcVEYFd9sjCJTgvNo=;
 b=Fq5EzE6jVjXZEAVeSpH5Kdu+1TRr3awaoFuU1xQrkpuPfLmN91gcmXvh9CN5idYhhUXLN6GPow3FKRz2L/tK5aUCx1+CL6OjTmSw3W284gSCShzuVgYAX1ppESZGP3P7Gn9buY2F8YD7nk1alWyx5o8fsCetr6XtLrcivym8B3NRb9I2pc91HEnfg3RTiHsKIeBPJ+MOwnY9TvgZlkJwDafRZ2iMsW95VAEW0GIQg2zgHNI6iFLCRDCYKXqMdKGJg9WbpDZCPRZqeZwCWmD4aw0A5ohwA1WLtJftOkqEWDk6o8Oq6pN1E7xa3ECsyoYDwClsSgyYD5JyOo4RrYG1GQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB7261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 10:01:41 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 10:01:41 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "binbin.wu@intel.com" <binbin.wu@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "bonzini@redhat.com" <bonzini@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Thread-Topic: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Thread-Index: AQHc7PVsdKod4bVSfkqrGLlbuPRkI7YgE2AA
Date: Tue, 26 May 2026 10:01:41 +0000
Message-ID: <6ae24df3f3a62957ca997c6788926fd212f074b3.camel@siemens.com>
References: <20260423155611.216805954@infradead.org>
	 <20260423155936.843498069@infradead.org>
	 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
In-Reply-To: <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.1 (3.60.1-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DU0PR10MB7261:EE_
x-ms-office365-filtering-correlation-id: 586a6faf-b2ae-4b01-1307-08debb0dc8e2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|18002099003|22082099003|56012099003|38070700021|55112099003|6133799003|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info:
 A1zaDsLx1xPWG6g9HeH3E9V7S0Pr6OEl6xKmTC6rBXQq7tJuKXF731750ghP8/eLunpclEsJ/HToLFP24vgIAz3IgMgNfRoCkAJmBZ9t/HiVbBOFUPCPmtPeUO6Wdp4KD4lc5iJsTDqckZU1naZUShJPboyLfRC1kyqt1tvQiI+tMhuOZe0fbTpv/x6QBBaVuLPAjt7QgOol0yBbgquFpot0h408ynXDtZRqTGfcvzInEND1Gv9nW5QgCzIZkWVu9g8tH5P5ZRIsbDiX06hf3GLM9g0xUcqeiucnV+LGF1rK/PYUM+lfThXEEXTf25gGJBYt7V/uuKuW4n4xEGr4NYhtQX7BRAlqn3msSHg91gjwpKlf9f4HH926uH1vAekN3yR76eFvnktujxwiavqrRNlaDxH73PWd0xIbU6MWxklpO764E+pvZxpBuMP37/tzMRyMJs6ehlQAY5GDxrwNIvw3p79F8ls64Srx9h9/NaXwXRVh1+/g5Mkiw/IPyYg2TkLfi/Ljezf+4jlbAtPOU9S+KPJ/idNwcZ8uvPRIi9yNbDXjapf5mVy2lDwgvl+08h/E/hXyTYkOkybhVKexKv4NO2AveZgEt1ISdgJ1W2NBmOlOt16YLnnAAeyLtWPc+kRJKnflnFXpy2+CIloGszlWzlKfr4n8JtEeBo33bjpbYPohfbAPDZuL23CWvyxP6BoXOElHTsX9tXNUalWwVUEvrFaeOfeeLx28Iz+oOd4otxcvhbogbKAUjVfPzu5f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021)(55112099003)(6133799003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlN3bkR0TlJaSTgvTmpFVlpxOTZlYjZHTkpwVjgzUXhpMjdOYkhUUmtYT1ZK?=
 =?utf-8?B?ak1kRUg4aEhBOVdyUXFMYzdUbnRPMDNRRGVLYld0dk56RXZFeVFvTHBOV2E5?=
 =?utf-8?B?NGNyNm9TM3E1WXBuM1dqNGZGaDdhYUp4VmVtY2VrOEkvQi9ETTZnV1ZFMjVF?=
 =?utf-8?B?bklRYm1sUHFFV2I1SzcyQ1FHZEFwRU5ySkN2b1RvclBYYnYwb3ZSZVFZdUN5?=
 =?utf-8?B?MVhKbllzR1lRV0Q0MVF2ZnUrcnpPTzdSa0REMUplL1dIOUMrZ29WVUp2SmhN?=
 =?utf-8?B?ei90aC9rY0thNXVUL2I0VlFTUm55WlJINDAxYVJXQU1OdlR4WFV2OC92ZjRs?=
 =?utf-8?B?eCt6QTNodzVpaUovTmFsaDQ3TmhVQTR1OXp4TXVlY2Z6NmJ0bmIyT3pqZFlY?=
 =?utf-8?B?Y1pvTlV3dlNSd0xNSjlKUzNuMmVCOU9FdkNjUjdhV0ZxS0g1VDdXMWdYQVFP?=
 =?utf-8?B?ekFrSzBRckZ1VHNZWVVLRUtPRyt1Zm1aaXB6bzhqOG9PVUxURUdYM3ZjZUFp?=
 =?utf-8?B?Y1VEc3hCdVRCVVR6MXQ0elRxV2ZtMGRQSXhJLzVLckpaQ1lxMDJkZnRHOHJl?=
 =?utf-8?B?SGtncXd6OTBqVUgwUzJlc1ByTFlQSjEvQTNweklDQUlaaklOM3pBc1lNQUdv?=
 =?utf-8?B?TGtzNHJzekFnSEI3UlcwQnJiQXg0RWtERmtFV0hXeHhGNXdrSm5hL0xCZk16?=
 =?utf-8?B?Zm1VWkpPYnFzV1M5NXpWdkc5OW9vbksyY3AxUHJVb3M3MHMrR2JyNXVoWEQx?=
 =?utf-8?B?d3k1QkFiMmJMUXI2allLZ2tBajBjTWFPa3FGc2lIMnNwQ0gzbGFhOWt5VU5z?=
 =?utf-8?B?cUVtMGVySXNoVFc1ZWwzcVltN2owUFlqd0xsbmlCTTV1RzlFZ1AyZmlaa3FK?=
 =?utf-8?B?eW52aXdJYjRHTTNpazVEWUZYWVZ1S0I5anR4cyt5UzRHYnVSOVNUNE1iUUVO?=
 =?utf-8?B?RCtsckFYc2ZBSk12bi84azdiTUJNZit3TUl5ODJHbHRnUVdrSHdaaUk1TTNu?=
 =?utf-8?B?ZjhjZld6Lytpall1bno1K1JFZFhHTGpsNDRKYjFOcXdIZ214d3FhY1NvTVZE?=
 =?utf-8?B?TXNnTUEzMWhPSklYTFZ3MzZ2VWp6aVAva1JrY1J2eUM5S3lUZk5JOW16OWlu?=
 =?utf-8?B?TDZlLzV0NFhyUlFaOU5pRUs5USttYjZuY1BVSzltYjg0RE1qRW1GTjRqTjFT?=
 =?utf-8?B?cWhSQmxzd0k3TUxnY3Y3aDQvMTdXdWhTbk8wQ3lkdm45V3cvTXI5YWhPcnhE?=
 =?utf-8?B?ZkpvR3ZJZHkzelBScHI4bXB3U3N5OHBodHNrWXY5aGtoVlpYNFI5NTM2LzJC?=
 =?utf-8?B?SEc5Z2h1TG92dVN4Y0RYeHE1UlBaOVRxWUFWTG5CYm1VOTdzRzltWXh1Vy9S?=
 =?utf-8?B?WXhENGJhYXJ2NzJ6UDBRWFBvZWpTdDVFL0ZPMTVCZWVmbDNRTDkxbXcwbTVo?=
 =?utf-8?B?UzZIbDZyZFRxUkhLOHRkRWExY1I5MjV0ZDBWZmhKZjFMU0NHWXQvZW1hUi96?=
 =?utf-8?B?aENMRGt6bythMmxNUDlYTGdpcmdNQm84bFpMSDBwWnNZSkJwS1M3Rzh0cTdy?=
 =?utf-8?B?NUFPb3orSXRVUEU0dEZoWGJaOWlxdTl1aXdlUFFUcXRkcWRhSkZrb0s3dk82?=
 =?utf-8?B?RVp6bE51MGxFVkVnem13VHNZcXRGSEdqaDV4OFBERXJtZzJKUjRaTTJuTzFw?=
 =?utf-8?B?em9VdnJtMitBeVJXWG9MNjRzOGNUYmwxQ2xWZS9mVnlxczFnandHRG5ueDNx?=
 =?utf-8?B?czlRcCtXazNVY2tCZ0p4dEhLMkNXelkzWjBQaWd4WXFqTjZxYVg3VHJyUUZS?=
 =?utf-8?B?UEJjc1JPa0hXS2ltN3JJT00ySHJXOU5WUk53WkJpV1hucW5HN1dmZE1mcHdv?=
 =?utf-8?B?TE8vNm94UWFSUG44THh4dGVqOEtCcUxITExjUmxDT1djMmRyT1ZVdEpZczRm?=
 =?utf-8?B?SmpValNYMjZCa3BCY2EwVkJDdHVpMkdHOS9EVS82TTVQSjlxVVBFWEF0d3g3?=
 =?utf-8?B?U2Rhc01xcHlud1hZRzM0b1UvWXBsUERKaGJTRkhDZ21yZkpqcDRRYy8rZk5M?=
 =?utf-8?B?RXgrTTVhSzR2bzZCcjhtRDB6R1dCeVpvcysxUUIzdTE5UEpQd1lxNW5BdXJq?=
 =?utf-8?B?NzFBUUIrM0lEV2huMHFCWktjOExkbzNUdW9MUjgyZkpqbDhTVXRTSGtLUDhq?=
 =?utf-8?B?TnNVRHY4QmFlZmN5UW8yKzNtQ3g5TFpIK0k2cFprNmo0L2dHTUFYRXRRNFJ2?=
 =?utf-8?B?NDduaFBSV2k0Uk5OVldrQXhaVFNYSDZUS3JmUjM4ZXRIVlRiNGVSZk1OM1RD?=
 =?utf-8?B?VnF0Qk1aTzNyblViSzNOZ0xrZGU3OWxWY0d5N2djNzJkYkZsSkdNWUwvZitH?=
 =?utf-8?Q?XtwoS62YL0KFXwb3AMWnUuN5xXuSPkbDTW1znEKlw/bEX?=
x-ms-exchange-antispam-messagedata-1: 45a73igTvLh9XDfhL4jutmrXK11iZhRqxKE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45E29785AF654744804F5DA6648BD519@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 586a6faf-b2ae-4b01-1307-08debb0dc8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 10:01:41.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+qRg+AG7kwz+IqlJFBMQq0m+W6oO8nWDGWh6eqUI7KeE9PN4CDT9GJogXj5uYl4I16R7laQU8mx7TjgK62ubcuAvbZ3/pG+6WHdKbKmuQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7261

SGkgUGV0ZXIsDQoNCk9uIEZyaSwgMjAyNi0wNS0wOCBhdCAxMToxOCArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE1vdmUgdGhlIFZNWCBpbnRlcnJ1cHQgZGlzcGF0Y2ggbWFnaWMgaW50
byB0aGUgeDg2IGNvcmUgY29kZS4gVGhpcw0KPiBpc29sYXRlcyBLVk0gZnJvbSB0aGUgRlJFRC9J
RFQgZGVjaXNpb25zIGFuZCByZWR1Y2VzIHRoZSBhbW91bnQgb2YNCj4gRVhQT1JUX1NZTUJPTF9G
T1JfS1ZNKCkuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5q
Y0Bnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gVGVzdGVkLWJ5OiAiVmVybWEsIFZpc2hhbCBMIiA8dmlz
aGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gIC0g
b25lIG1vcmUgSVNfRU5BQkxFRChDT05GSUdfS1ZNX0lOVEVMKSAoWWFuIFpoYW8pDQo+ICAtIGZp
eGVkIGlkdF9kb19pbnRlcnJ1cHRfaXJxb2ZmKCkgcHJvdG90eXBlIChCaW5iaW4gV3UpDQo+IA0K
PiAgYXJjaC94ODYvZW50cnkvTWFrZWZpbGUgICAgICAgICAgICAgfCAgICAyIC0NCj4gIGFyY2gv
eDg2L2VudHJ5L2NvbW1vbi5jICAgICAgICAgICAgIHwgICA0OCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIGFyY2gveDg2L2VudHJ5L2VudHJ5LlMgICAgICAgICAgICAg
IHwgICA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL3g4Ni9l
bnRyeS9lbnRyeV82NF9mcmVkLlMgICAgICB8ICAgIDEgDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9kZXNjLmggICAgICAgICB8ICAgIDQgKysrDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9kZXNj
X2RlZnMuaCAgICB8ICAgIDIgLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vZW50cnktY29tbW9u
LmggfCAgICAyICsNCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2ZyZWQuaCAgICAgICAgIHwgICAg
MSANCj4gIGFyY2gveDg2L2tlcm5lbC9pZHQuYyAgICAgICAgICAgICAgIHwgICAxNSArKysrKysr
KysrKw0KPiAgYXJjaC94ODYva2VybmVsL25taS5jICAgICAgICAgICAgICAgfCAgICAxIA0KPiAg
YXJjaC94ODYva3ZtL3ZteC92bWVudGVyLlMgICAgICAgICAgfCAgIDQ2IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGFyY2gveDg2L2t2bS92bXgvdm14LmMgICAgICAgICAg
ICAgIHwgICAyMCArKy0tLS0tLS0tLS0tLS0NCj4gIDEyIGZpbGVzIGNoYW5nZWQsIDEyMCBpbnNl
cnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBhL2FyY2gveDg2L2VudHJ5L01h
a2VmaWxlDQo+ICsrKyBiL2FyY2gveDg2L2VudHJ5L01ha2VmaWxlDQo+IEBAIC0xMyw3ICsxMyw3
IEBAIENGTEFHU19SRU1PVkVfc3lzY2FsbF82NC5vCT0gJChDQ19GTEFHU18NCj4gIENGTEFHU19z
eXNjYWxsXzMyLm8JCSs9IC1mbm8tc3RhY2stcHJvdGVjdG9yDQo+ICBDRkxBR1Nfc3lzY2FsbF82
NC5vCQkrPSAtZm5vLXN0YWNrLXByb3RlY3Rvcg0KPiAgDQo+IC1vYmoteQkJCQk6PSBlbnRyeS5v
IGVudHJ5XyQoQklUUykubyBzeXNjYWxsXyQoQklUUykubw0KPiArb2JqLXkJCQkJOj0gZW50cnku
byBlbnRyeV8kKEJJVFMpLm8gc3lzY2FsbF8kKEJJVFMpLm8gY29tbW9uLm8NCj4gIA0KPiAgb2Jq
LXkJCQkJKz0gdmRzby8NCj4gIG9iai15CQkJCSs9IHZzeXNjYWxsLw0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jDQo+IEBAIC0wLDAgKzEsNDggQEANCj4g
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsNCj4gKyNpbmNsdWRl
IDxsaW51eC9lbnRyeS1jb21tb24uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rdm1fdHlwZXMuaD4N
Cj4gKyNpbmNsdWRlIDxhc20vZnJlZC5oPg0KPiArI2luY2x1ZGUgPGFzbS9kZXNjLmg+DQo+ICsN
Cj4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19LVk1fSU5URUwpDQo+ICsvKg0KPiArICogT24gVk1Y
LCBOTUlzIGFuZCBJUlFzIChhcyBjb25maWd1cmVkIGJ5IEtWTSkgYXJlIGFja25vd2xlZGdlZCBi
eSBoYXJkd2FyZSBhcw0KPiArICogcGFydCBvZiB0aGUgVk0tRXhpdCwgaS5lLiB0aGUgZXZlbnQg
aXRzZWxmIGlzIGNvbnN1bWVkIGFzIHBhcnQgdGhlIFZNLUV4aXQuDQo+ICsgKiB4ODZfZW50cnlf
ZnJvbV9rdm0oKSBpcyBpbnZva2VkIGJ5IEtWTSB0byBlZmZlY3RpdmVseSBmb3J3YXJkIE5NSXMg
YW5kIElSUXMNCj4gKyAqIHRvIHRoZSBrZXJuZWwgZm9yIHNlcnZpY2luZy4gIE9uIFNWTSwgYS5r
LmEuIEFNRCwgdGhlIE5NSS9JUlEgVk0tRXhpdCBpcw0KPiArICogcHVyZWx5IGEgc2lnbmFsIHRo
YXQgYW4gTk1JL0lSUSBpcyBwZW5kaW5nLCBpLmUuIHRoZSBldmVudCB0aGF0IHRyaWdnZXJlZA0K
PiArICogdGhlIFZNLUV4aXQgaXMgaGVsZCBwZW5kaW5nIHVudGlsIGl0J3MgdW5ibG9ja2VkIGlu
IHRoZSBob3N0Lg0KPiArICovDQo+ICtub2luc3RyIHZvaWQgeDg2X2VudHJ5X2Zyb21fa3ZtKHVu
c2lnbmVkIGludCBldmVudF90eXBlLCB1bnNpZ25lZCBpbnQgdmVjdG9yKQ0KPiArew0KPiArCWlm
IChldmVudF90eXBlID09IEVWRU5UX1RZUEVfRVhUSU5UKSB7DQo+ICsjaWZkZWYgQ09ORklHX1g4
Nl82NA0KPiArCQkvKg0KPiArCQkgKiBVc2UgRlJFRCBkaXNwYXRjaCwgZXZlbiB3aGVuIHJ1bm5p
bmcgSURULiBUaGUgZGlzcGF0Y2gNCj4gKwkJICogdGFibGVzIGFyZSBrZXB0IGluIHN5bmMgYmV0
d2VlbiBGUkVEIGFuZCBJRFQsIGFuZCB0aGUgRlJFRA0KPiArCQkgKiBkaXNwYXRjaCB3b3JrcyB3
ZWxsIHdpdGggQ0ZJLg0KPiArCQkgKi8NCj4gKwkJZnJlZF9lbnRyeV9mcm9tX2t2bShldmVudF90
eXBlLCB2ZWN0b3IpOw0KDQpTZWVtcyB0aGlzIGxhbmRlZCBpbiA3LjEtcmM1Lg0KDQpJJ20gc2Vl
aW5nIGEgYnVpbGQgZmFpbHVyZSBoZXJlOg0KDQphcmNoL3g4Ni9lbnRyeS9jb21tb24uYzogSW4g
ZnVuY3Rpb24g4oCYeDg2X2VudHJ5X2Zyb21fa3Zt4oCZOg0KYXJjaC94ODYvZW50cnkvY29tbW9u
LmM6Mjc6MTc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhmcmVk
X2VudHJ5X2Zyb21fa3Zt4oCZOyBkaWQgeW91IG1lYW4g4oCYaWR0X2VudHJ5X2Zyb21fa3Zt4oCZ
PyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCiAgIDI3IHwgICAgICAgICAgICAg
ICAgIGZyZWRfZW50cnlfZnJvbV9rdm0oZXZlbnRfdHlwZSwgdmVjdG9yKTsNCiAgICAgIHwgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4NCiAgICAgIHwgICAgICAgICAgICAgICAg
IGlkdF9lbnRyeV9mcm9tX2t2bQ0KYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTA6MjQ6IGVycm9y
OiDigJhyZXR1cm7igJkgd2l0aCBhIHZhbHVlLCBpbiBmdW5jdGlvbiByZXR1cm5pbmcgdm9pZCBb
LVdyZXR1cm4tbWlzbWF0Y2hdDQogICA1MCB8ICAgICAgICAgICAgICAgICByZXR1cm4gZnJlZF9l
bnRyeV9mcm9tX2t2bShldmVudF90eXBlLCB2ZWN0b3IpOw0KICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KYXJjaC94
ODYvZW50cnkvY29tbW9uLmM6MTg6MTQ6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCiAgIDE4IHwgbm9p
bnN0ciB2b2lkIHg4Nl9lbnRyeV9mcm9tX2t2bSh1bnNpZ25lZCBpbnQgZXZlbnRfdHlwZSwgdW5z
aWduZWQgaW50IHZlY3RvcikNCiAgICAgIHwgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fg0KDQoNCg0KPiArI2Vsc2UNCj4gKwkJaWR0X2VudHJ5X2Zyb21fa3ZtKHZlY3Rvcik7DQo+ICsj
ZW5kaWYNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCVdBUk5fT05fT05DRShldmVudF90
eXBlICE9IEVWRU5UX1RZUEVfTk1JKTsNCj4gKw0KPiArI2lmZGVmIENPTkZJR19YODZfNjQNCj4g
KwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9GUkVEKSkNCj4gKwkJcmV0dXJu
IGZyZWRfZW50cnlfZnJvbV9rdm0oZXZlbnRfdHlwZSwgdmVjdG9yKTsNCj4gKyNlbmRpZg0KPiAr
DQo+ICsJLyoNCj4gKwkgKiBOb3RhYmx5LCB3ZSBtdXN0IHVzZSBJRFQgZGlzcGF0Y2ggZm9yIE5N
SSB3aGVuIHJ1bm5pbmcgaW4gSURUIG1vZGUuDQo+ICsJICogVGhlIEZSRUQgTk1JIGNvbnRleHQg
aXMgc2lnbmlmaWNhbnRseSBkaWZmZXJlbnQgYW5kIHdpbGwgbm90IHdvcmsNCj4gKwkgKiByaWdo
dCAoc3BlZmljaWFsbHkgRlJFRCBmaXhlZCB0aGUgTk1JIHJlY3Vyc2lvbiBpc3N1ZSkuDQo+ICsJ
ICovDQo+ICsJaWR0X2VudHJ5X2Zyb21fa3ZtKHZlY3Rvcik7DQo+ICt9DQo+ICtFWFBPUlRfU1lN
Qk9MX0ZPUl9LVk0oeDg2X2VudHJ5X2Zyb21fa3ZtKTsNCj4gKyNlbmRpZg0KPiANCg0KW3NuaXBd
DQoNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZW50cnktY29tbW9uLmgNCj4gKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vZW50cnktY29tbW9uLmgNCj4gQEAgLTk3LDQgKzk3LDYgQEAg
c3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGFyY2hfZXhpdF90bw0KPiAgfQ0KPiAgI2RlZmlu
ZSBhcmNoX2V4aXRfdG9fdXNlcl9tb2RlIGFyY2hfZXhpdF90b191c2VyX21vZGUNCj4gIA0KPiAr
ZXh0ZXJuIHZvaWQgeDg2X2VudHJ5X2Zyb21fa3ZtKHVuc2lnbmVkIGludCBlbnRyeV90eXBlLCB1
bnNpZ25lZCBpbnQgdmVjdG9yKTsNCj4gKw0KPiAgI2VuZGlmDQo+IC0tLSBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2ZyZWQuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcmVkLmgNCj4g
QEAgLTExMCw3ICsxMTAsNiBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVkIGxvbmcg
ZnJlDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X2luaXRfZnJlZF9leGNlcHRpb25zKHZvaWQp
IHsgfQ0KPiAgc3RhdGljIGlubGluZSB2b2lkIGNwdV9pbml0X2ZyZWRfcnNwcyh2b2lkKSB7IH0N
Cj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVkX2NvbXBsZXRlX2V4Y2VwdGlvbl9zZXR1cCh2b2lk
KSB7IH0NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBmcmVkX2VudHJ5X2Zyb21fa3ZtKHVuc2lnbmVk
IGludCB0eXBlLCB1bnNpZ25lZCBpbnQgdmVjdG9yKSB7IH0NCg0KVGhhdCBzZWVtcyBzdGlsbCBu
ZWNlc3NhcnkgZm9yIHRoZSAhQ09ORklHX1g4Nl9GUkVEIGNhc2UuDQoNCj4gIHN0YXRpYyBpbmxp
bmUgdm9pZCBmcmVkX3N5bmNfcnNwMCh1bnNpZ25lZCBsb25nIHJzcDApIHsgfQ0KPiAgc3RhdGlj
IGlubGluZSB2b2lkIGZyZWRfdXBkYXRlX3JzcDAodm9pZCkgeyB9DQo+ICAjZW5kaWYgLyogQ09O
RklHX1g4Nl9GUkVEICovDQoNCltzbmlwXQ0K
