Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BB47D457
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327028; cv=fail; b=JWUJvtUPz7+QnQL7tte67rbMrPnwS8F8QKBU8uzayoQAzFw0rOSENED3Hb6SZqJGdZsoQHjGjqVz3PNo0xA/uqEcPJOv0rlglRsP5x7lLwaDkl1D4zPudWhv+JEGNQ9nVkb/F+P+8UBq2SzirZN5U4R783/uN/foXX/OCCb3Jw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327028; c=relaxed/simple;
	bh=Z9K8dSadjFlr/ZKQSrthb7dLNcYlUS/dKk2fIMXQUWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9qJGzXzKkgInTCQTLtJvIjMmNkOmDwtZj5m0S7Y4l/r/wnAjI6deF/jWteIieDwLdEoXC6avajq9e+xLF3ciUmLISDiMByMnh8aFNnDMh1a+z5SrnCyMsujlQuxeLApcwZVPsgmv1nyq1gXa+ggPinTS/UnrPj64u8vQ9/FTKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KeCb4j1l; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KeCb4j1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gohguy70uwr62LFv+FA+aOjqQvcGufKMQ+yghmjeYhgno9s6s7Dbw5clz0/fhMzsrYy8ghCPGyizfMiJ9pEcJxNe80i4iiN/yyVlmxpn3EVHsfNcMsAclR04z+mmK/sgh+pIpgZ0mLdduJem0AAcSNvbtWWntC2TyBhgdULl+J5/aSpSYn8pBwrsBeouedPBMEaeBNUHhimTFqkHpeKf8158oJIy3VJUZOP2nQraXfHazXy4n3TOpoJXE3DMWSP8XAdCcM9lpVVBqFo7Xyf/wgjn4xtrd88H8AvmdtEvQcT82hj9KLTbyTmtXI25/lgmnlJMdKfoXBl2RG7OSM96xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9K8dSadjFlr/ZKQSrthb7dLNcYlUS/dKk2fIMXQUWQ=;
 b=Zwbiaee/WpnO/Yd9pbKEqmoyIIJfNS52PpS2MvCIY7vKej4rFBql8XzeXqg58TTEVv1xbE3TT0T0FHTWwQNxskCmQoN+XSCCxw7Kv9K7RlmAbqkmbRUrdK1t1R7UAIIS4C89pNoBwmwoFR2Buqk2KbzWnavYtZo8nY5aKDiJxvBqRvx3BXKtfQO+fpELxpRazoIGpmFWGUG1vVS7zI7xPivUny0jpFqkG4Z/cK7iWND6qkLUMyUmSv2wWrs6ueq9AXKxjjORQwgH8adSUUedJ0pNngppLDPCalRq2rKutzNh4bofqmNW8hcuIiS1DJK8xwMPNICHsBAZzxkViNV+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9K8dSadjFlr/ZKQSrthb7dLNcYlUS/dKk2fIMXQUWQ=;
 b=KeCb4j1lGEwy/18edLutt5dOHx6vtSNgenqNWpkNm6Ilvsp/Y9zHyO4fCf4gLiH7/VqMGdLISbUY6/24bgBWhDsDpPWvE4xN6o0q351a7hM0AfhjoQfwTSSR4fdoq030BlirXmNcknMmxRdPNnFS0fCktfcnJOzWuCFaNVH2Q6U=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 12:10:21 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 12:10:21 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
Subject: Re: [PATCH RFC v2 2/4] KVM: guest_memfd: implement folio migration
 for non-confidential VMs
Thread-Topic: [PATCH RFC v2 2/4] KVM: guest_memfd: implement folio migration
 for non-confidential VMs
Thread-Index: AQHdHnJWtblRRa/Ut0eN8x9PPwFoK7aEaY4A
Date: Wed, 29 Jul 2026 12:10:21 +0000
Message-ID: <6f7de096befe6468a0d1cdedf8098c38e4420834.camel@amd.com>
References: <20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com>
	 <20260728-shivank-gmem-migrate-v2-2-269ac1f84e2b@amd.com>
	 <20260728092027.225CF1F000E9@smtp.kernel.org>
In-Reply-To: <20260728092027.225CF1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|CH2PR12MB9519:EE_
x-ms-office365-filtering-correlation-id: acdc4792-1411-411e-6d0b-08deed6a5d1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 WJ4iLwuJCk95M4EQcNv3uAxaqRS97HOVePdGszqu/Lf27k5SwRu3iAXSh9A+3V1HmSI7A0sHEinDRjFnMxfxgTqHXjiC8RwTGxVE6DBKblf7VpdtegveB0nwP7YEI4vu57FFdOuzn7mfFz+l1CbRxzh47JZxLbbBAZItfXkzNclpFhIjZNwbTvNbpp07tfAglCLf1GQxBeahDipGLrOpsBNgx2LjmEwYVMaPUFo/A7iv8y8OmlCPbQEEqFbj8b9Qf537VEQQ6dEtrdS1HGmSz0PgZA1Litkwi4J+zL5hii4Ez7aLCBubKVvpW4pJ7TmEL3a59EUpBVfOowJ8ByrLJYtuwBu99FwyYv4RgPE5OW/BPjpbnkgjpVrM1Y9FDmxwY05cm+pRbmRb4b+psQLx6b2oONdW6FM+CUjlRqjKaau+BztyYpRy8unpuc1a4sB8ZfO9SY2vltDUsTA0J+l5CFewP0xgBOFB0aHuFOuEtwHe8CKLis3FAdhTvGln9p0OeyhDxdEu9VIOE3TPwROoMAG5YTJobm2UTxKReZui8iLryFA7hOzxxce2NTSsozrN5ZXq4wxr1emkhLhgs346ar8v9RZs5pPRgMSiUXDTNJy87rQlkxWIl7pCYICU7YZ9RgC3AVGpWIhRlnmdbnfcRoSCLyjTx7Rgkx3Xlcidei8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzNWZlZHanVrMjhBdkRhTkNOTFdxRmN0c1lJcUpiQktYUDZlMGlFRWJwTGt3?=
 =?utf-8?B?UENBaElwUjVDNjVyL3FHNUwyaUhGb0Vzb1pkT1pTcTVQcmtBRVM2VWdPSWQz?=
 =?utf-8?B?SUlpZkROVXcrYytKUi9TR216MlI2dC93L29kb1R4ck5PdlZ2RkFwc3E5cFpU?=
 =?utf-8?B?M1UwaFN4VWpoK2I2RzRHajd3bFBpV1c0SlNLMFg4TmdyaS9lMllIUTh5UXpY?=
 =?utf-8?B?QXJKSTFteFFpVGhhelFiVTBkK3VQZmRQdTlOT3BTZ0w5YVBlUjlTVzA5ZU5s?=
 =?utf-8?B?N25MbmVydVNyYlZQaGRacUN3dkdaSFNhQXFLVjgvWVdnM25yTS95NkpwZFFN?=
 =?utf-8?B?bnc0NFhtTHQxejN1TU5XMEhPNDR1eHBmSGwzWkpQanUxeGZvUTJGM20vWmFu?=
 =?utf-8?B?VnFGNDhvNXI5OURpMVp4L0VveHNXbVlob0JBQUl3SXNaY3QweGFpdE1LSHlM?=
 =?utf-8?B?MVJtajFlSEJUTGoxUEJjTHJWMmlnWGVQZW8zQ0toLzZiYUM5eGdieDdYUHYy?=
 =?utf-8?B?Zy80RFh5aWxWbUZZRDIybjczRC8zMmIrdEtHeUxPMUVJRVpmQkp4WTA5Mml0?=
 =?utf-8?B?WWFtVnNkVHVOUUFZUzRURnArU0prVUhEMHV1dUVzTlMxcTZERlVrSUZqK0h4?=
 =?utf-8?B?RXJuUkU5MDBFWWIrckJFOWZGaThFeGg4WTYvaTJaSVd4ZjFxTzVFbFlTTTEz?=
 =?utf-8?B?aU1hT1dTYjliQkt5TURHbUI4K2VkeUJJOWkzR3FrRnMydThqd1hpd2JubnhU?=
 =?utf-8?B?NklvTmNrSkFvcmh1dUtaQ0hUOVE0WmdqMHdiU0ZVSHJCUk44NWRIWXdLd2d6?=
 =?utf-8?B?RHB0RVlwS2N6WlAyYkZxTWxxZGRzUnB5dUtldW1uL21FSDNGQVBveldhRXVm?=
 =?utf-8?B?dE9XcExUOC9HYXloR1FTc1puQTI5YWpKeG52THNRRk5jMTRSZlZTQlNDZGc0?=
 =?utf-8?B?L291Z3o2ZkdkYXZtcjg4WDR2aUM5NjFwM2pOUzREeDNNN0pPTHB5OTNoeSsy?=
 =?utf-8?B?T1BRVFVhUjVDS0xzNXBhTXdVK0Z5MlR1YW1kQkpxV29oR1hDZjJtZHpETjFi?=
 =?utf-8?B?cmxublM4L0ZkbTAxUTZYVmFRZFFaOWF4NFByZEFKOS82cnR6aXFXdmFxUWJp?=
 =?utf-8?B?TzNLaEQwSlhDZEFPTEJHc0VkVytMbnNnQzJXVy9FVGo2bXNLQmQwdjNTVXlj?=
 =?utf-8?B?WFN1MG0rTTJ1dmsvdzRZbFBxNDBmTmMzWVZ0ZlU2SjcxVzBsVUhqYmtEYU9K?=
 =?utf-8?B?dmxNamM0eGlFSFBZV05uN3JNazV6aGJqN29ab2xqeFZJZ0kwNWxJNlVGVWNm?=
 =?utf-8?B?Ryt5K3VPWUJsUDFUWFhBV2F2UUdsNUJRZWdtOWZWMndESDFBSGRya1A2OVg5?=
 =?utf-8?B?TVg5d0U0QWlpMklYN3crYmpoMXVOd29TdjEreEFnQnZhckhmS2N0c2pjMzVY?=
 =?utf-8?B?c2hDYnY0S2l3RlkxK0Z0ODkxbG5UOVhUTDQyM0p1K3NGdU51V1VleG5SaVQy?=
 =?utf-8?B?SzhEemJMYTJUSlZjTy94MjNYRGhkWll4bVUxNjdGQzd1STkxYUU0dFpUVU90?=
 =?utf-8?B?S0h5QnhtSkFScHNZdUZ2ampoQkV3NW5jZGpJajlhcEhleEkyOG5TbFQ3NStj?=
 =?utf-8?B?S3hndXNFcWd3blpjNElLNEpOV1hxRVFzQXJIL0tqVUNYbG80Z0pVLzdPYzA0?=
 =?utf-8?B?cE5TbGoxYTdodU14am1IU0dZZVNqR1I1WTV3RDNyVnhwVDI2dlZKUUI4c0Ro?=
 =?utf-8?B?WlV4cDljWHRCdEhLRVczaUs3QjdnN1AxMkxMR1l6U09jR2ZzMTVXNVBmMVlo?=
 =?utf-8?B?alFqNTVtU1FueHVMTk1idHZHQk04TDRzbkR5TU0rZ2VvdEtQVkxvNWpTTHJF?=
 =?utf-8?B?R08wSjgzRHZaenhZTFg3VUlLdllNOEpTckVpQWZCb1VBS2F4TEhpTkdRRVRl?=
 =?utf-8?B?SDZmRjh3OFZnUkdoa1QzeEd5OTdlWEcvcVIwN3pVR2FrTHRsckVkSUZTQnNP?=
 =?utf-8?B?Nm9ncERpUlhjdzRYT0ZOcCsrUzN2VUFhMmVsdit4Ry9JOFZnZmVxVzhORU9E?=
 =?utf-8?B?ZGpOc1JHK2xsSjBIbFI5NkJxZ2pxZnlsSENFYlFwdkZhcEFLdDZtdEEwc2xj?=
 =?utf-8?B?ekxzZHFnSG0rYlpTbUhvWEI2OTVyREFMcU5EeUlmN2FEK0hUM2JaMjRxdUds?=
 =?utf-8?B?RWQ2bERZNGN3K2FjV3AxdXdBaGpGdHpHYldFUlZoQmJ3djQzblFSSE5SMWpH?=
 =?utf-8?B?dHhMMHhtUTg0c1RGRGJBeHQxRHArb0JvQlI1aktmR1FJSWg2VnJ1NHlqZ3dL?=
 =?utf-8?B?Qi94SXI4bSt2a1BxNUpMdWp5TkJYRmxhanFOSW1sSjBQcW1wV0h5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ECFA86958EF734999AB9609C827DE8C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdc4792-1411-411e-6d0b-08deed6a5d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 12:10:21.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIxvR/GGmKD3x7qOm3TNI2L4vFKJsg9i1HjhMTXAIExfq1kVKYN15IQ0I9Cpj4cWvoo0HEQFEVcR7Nsov7lPEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDA5OjIwICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAyIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gDQo+IFByZS1l
eGlzdGluZyBpc3N1ZXM6DQo+IC0gW0hpZ2hdIFByZS1leGlzdGluZyBBQkJBIGRlYWRsb2NrIGJl
dHdlZW4gYG1hcHBpbmctPmludmFsaWRhdGVfbG9ja2AgYW5kIGBmb2xpb19sb2NrYCB2aWEgYGt2
bV9nbWVtX2Vycm9yX2ZvbGlvYC4NCj4gLSBbSGlnaF0gVW5wYWlyZWQgYGt2bV9tbXVfaW52YWxp
ZGF0ZV9zdGFydGAgZHVlIHRvIGxvY2tsZXNzIGBmLT5iaW5kaW5nc2AgeGFycmF5IG1vZGlmaWNh
dGlvbiBkdXJpbmcgYGt2bV9nbWVtX3VuYmluZGAuDQo+IC0tDQo+IA0KPiAtLS0gUGF0Y2ggWzJd
OiBbUEFUQ0ggUkZDIHYyIDIvNF0gS1ZNOiBndWVzdF9tZW1mZDogaW1wbGVtZW50IGZvbGlvIG1p
Z3JhdGlvbiBmb3Igbm9uLWNvbmZpZGVudGlhbCBWTXMgLS0tDQo+IGNvbW1pdCBjYjMwYjhjZDBl
NzNiNWU3YWQ4MGQwMjg1MzA2ODEwY2JmNGQ5NjNlDQo+IEF1dGhvcjogU2hpdmFuayBHYXJnIDxz
aGl2YW5rZ0BhbWQuY29tPg0KPiBLVk06IGd1ZXN0X21lbWZkOiBpbXBsZW1lbnQgZm9saW8gbWln
cmF0aW9uIGZvciBub24tY29uZmlkZW50aWFsIFZNcw0KPiANCj4gSW1wbGVtZW50IGt2bV9nbWVt
X21pZ3JhdGVfZm9saW8gdXNpbmcgZmlsZW1hcF9taWdyYXRlX2ZvbGlvIGZvcg0KPiBub24tY29u
ZmlkZW50aWFsIFZNcyBidXQgZG9uJ3QgZW5hYmxlIGl0IHlldC4gR3Vlc3RfbWVtZmQgbWFwcGlu
Z3MgYXJlIHN0aWxsDQo+IG1hcmtlZCB1bm1vdmFibGUsIHNvIE1NIG5ldmVyIGNhbGxzIGl0Lg0K
PiANCj4gPiBkaWZmIC0tZ2l0IGEvdmlydC9rdm0vZ3Vlc3RfbWVtZmQuYyBiL3ZpcnQva3ZtL2d1
ZXN0X21lbWZkLmMNCj4gPiBpbmRleCBkM2IxMTg2YjAzYjNhLi5lYzg4MWNhYmU4ZTNlIDEwMDY0
NA0KPiA+IC0tLSBhL3ZpcnQva3ZtL2d1ZXN0X21lbWZkLmMNCj4gPiArKysgYi92aXJ0L2t2bS9n
dWVzdF9tZW1mZC5jDQo+IFsgLi4uIF0NCj4gPiArCXN0YXJ0ID0gc3JjLT5pbmRleDsNCj4gPiAr
CWVuZCA9IHN0YXJ0ICsgZm9saW9fbnJfcGFnZXMoc3JjKTsNCj4gPiArDQo+ID4gKwlrdm1fZ21l
bV9pbnZhbGlkYXRlX3N0YXJ0KGlub2RlLCBzdGFydCwgZW5kKTsNCj4gPiArDQo+ID4gKwkvKg0K
PiA+ICsJICogRm9yIG5vbi1jb25maWRlbnRpYWwgZ3Vlc3RzIHRoZSBmb2xpbyBpcyBob3N0LXJl
YWRhYmxlLCBzbw0KPiA+ICsJICogZmlsZW1hcF9taWdyYXRlX2ZvbGlvKCkgY2FuIGNvcHkgdGhl
IGNvbnRlbnRzIGl0c2VsZiB2aWENCj4gPiArCSAqIGZvbGlvX21jX2NvcHkoKS4NCj4gPiArCSAq
IEZvciBjb25maWRlbnRpYWwgZ3Vlc3RzLCB0aGlzIHdvdWxkIG5lZWQgZmlybXdhcmUgYXNzaXN0
YW5jZS4NCj4gPiArCSAqLw0KPiA+ICsJcmV0ID0gZmlsZW1hcF9taWdyYXRlX2ZvbGlvKG1hcHBp
bmcsIGRzdCwgc3JjLCBtb2RlKTsNCj4gPiArDQo+ID4gKwlrdm1fZ21lbV9pbnZhbGlkYXRlX2Vu
ZChpbm9kZSwgc3RhcnQsIGVuZCk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMg
YSBwcmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCBkb2VzIHRoZSBpdGVyYXRpb24gb3ZlciBiaW5kaW5n
cyBoZXJlIHJhY2UNCj4gd2l0aCBrdm1fZ21lbV91bmJpbmQ/DQo+IA0KPiBJZiBhIGd1ZXN0X21l
bWZkIGZpbGUgaXMgYmVpbmcgY2xvc2VkIGFuZCBpdHMgcmVmY291bnQgcmVhY2hlcyB6ZXJvDQo+
IGNvbmN1cnJlbnRseSwga3ZtX2dtZW1fdW5iaW5kIHRha2VzIHRoZSAhZmlsZSBicmFuY2ggYW5k
IHJlbW92ZXMgdGhlIG1lbXNsb3QNCj4gZnJvbSBmLT5iaW5kaW5ncyB3aXRob3V0IHRha2luZyBm
aWxlbWFwX2ludmFsaWRhdGVfbG9jay4NCj4gDQo+IENvdWxkIHRoaXMgbG9ja2xlc3MgbW9kaWZp
Y2F0aW9uIGhhcHBlbiBiZXR3ZWVuIHRoZSBjYWxscyB0bw0KPiBrdm1fZ21lbV9pbnZhbGlkYXRl
X3N0YXJ0IGFuZCBrdm1fZ21lbV9pbnZhbGlkYXRlX2VuZD8NCj4gDQo+IElmIGYtPmJpbmRpbmdz
IGlzIG1vZGlmaWVkIGR1cmluZyB0aGlzIHdpbmRvdywgX19rdm1fZ21lbV9pbnZhbGlkYXRlX2Vu
ZA0KPiBtaWdodCBmYWlsIHRvIGZpbmQgdGhlIGJpbmRpbmcgYW5kIHNraXAgdGhlIHNsb3QsIHJl
c3VsdGluZyBpbiBhbiB1bnBhaXJlZA0KPiBzdGFydCBjYWxsLiBUaGlzIHdvdWxkIHBlcm1hbmVu
dGx5IGxlYWsgdGhlIG1tdV9pbnZhbGlkYXRlX2luX3Byb2dyZXNzDQo+IGNvdW50ZXIgYW5kIGNh
dXNlIGd1ZXN0IHBhZ2UgZmF1bHRzIHRvIGhhbmcgaW5kZWZpbml0ZWx5Lg0KDQpUaGlzIGlzIHZh
bGlkIHBvaW50Lg0KU28sIElJVUMsIEkgY2FuIHJlbW92ZSAhZmlsZSBicmFuY2ggYW5kIHRha2Ug
YW4gaW52YWxpZGF0ZSBsb2NrIGZvciBzbG90cy0NCj5nbWVtLmZpbGUsIGlmIEkgY2FuJ3QgZ2V0
IHJlZmVyZW5jZSBvbiBnbWVtLmZpbGUuDQoNCglDTEFTUyhnbWVtX2dldF9maWxlLCBmaWxlKShz
bG90KTsNCglzdHJ1Y3QgZmlsZSogZiA9IGZpbGUgPyBmaWxlOiBzbG90LT5nbWVtLmZpbGU7DQoN
CglmaWxlbWFwX2ludmFsaWRhdGVfbG9jayhmLT5mX21hcHBpbmcpOw0KCV9fa3ZtX2dtZW1fdW5i
aW5kKHNsb3QsIGYtPnByaXZhdGVfZGF0YSk7DQoJZmlsZW1hcF9pbnZhbGlkYXRlX3VubG9jayhm
LT5mX21hcHBpbmcpOw0KDQpUaGlzIHdvdWxkIHByZXZlbnQgaXQgZnJvbSByZW1vdmluZyB0aGUg
bWVtc2xvdC4NCg0KPiA+ICsNCj4gPiArCWZpbGVtYXBfaW52YWxpZGF0ZV91bmxvY2tfc2hhcmVk
KG1hcHBpbmcpOw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICsjZWxzZQ0KPiA+ICsj
ZGVmaW5lIGt2bV9nbWVtX21pZ3JhdGVfZm9saW8gTlVMTA0KPiA+ICsjZW5kaWYNCj4gPiAgDQo+
ID4gIHN0YXRpYyBpbnQga3ZtX2dtZW1fZXJyb3JfZm9saW8oc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmcsIHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gIHsNCj4gDQo+IFtTZXZlcml0eTog
SGlnaF0NCj4gVGhpcyBpc24ndCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBk
b2VzIGt2bV9nbWVtX2Vycm9yX2ZvbGlvDQo+IGhhdmUgdGhlIGV4YWN0IHNhbWUgQUJCQSBkZWFk
bG9jayB0aGF0IHlvdSBjb3JyZWN0bHkgYXZvaWRlZCBhYm92ZSBpbg0KPiBrdm1fZ21lbV9taWdy
YXRlX2ZvbGlvPw0KPiANCj4gSW4ga3ZtX2dtZW1fZXJyb3JfZm9saW8sIGl0IHVuY29uZGl0aW9u
YWxseSBjYWxscw0KPiBmaWxlbWFwX2ludmFsaWRhdGVfbG9ja19zaGFyZWQgd2hpbGUgdGhlIGNh
bGxlciAobWVtb3J5X2ZhaWx1cmUpIGFscmVhZHkNCj4gaG9sZHMgdGhlIGZvbGlvIGxvY2suDQo+
IA0KPiBNZWFud2hpbGUsIHRoZSBvcHBvc2luZyB0cnVuY2F0aW9uIHBhdGggaW4ga3ZtX2dtZW1f
cHVuY2hfaG9sZSBlc3RhYmxpc2hlcw0KPiB0aGUgc3RyaWN0IGxvY2sgb3JkZXJpbmcgb2YgYWNx
dWlyaW5nIG1hcHBpbmctPmludmFsaWRhdGVfbG9jayBmb2xsb3dlZCBieQ0KPiBsb2NraW5nIHRo
ZSBmb2xpby4NCj4gDQo+IENvdWxkIGEgY29uY3VycmVudCBmYWxsb2NhdGUgUFVOQ0hfSE9MRSBh
bmQgYSBtZW1vcnkgZmFpbHVyZSBvbiB0aGUgc2FtZQ0KPiBndWVzdF9tZW1mZCBmaWxlIGRlYWRs
b2NrIHRoZSBrZXJuZWwgaGVyZT8NCj4gDQoNCkhhbyBaaGFuZyBpcyBhY3RpdmVseSB3b3JraW5n
IG9uIHRoaXMgaXNzdWUuIFsxXQ0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Ft
YkVkU1BqZXJaSVZOMGJAMTkyLjE2OC4xLjIxNQ0KDQpUaGFua3MsDQpTaGl2YW5rDQo=
