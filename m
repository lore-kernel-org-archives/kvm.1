Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2B449B24;
	Mon, 31 Aug 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186186; cv=fail; b=SJdmIGHOVMm2afL0Oy45blsQUFUPFW14DhPQmlTTbYxpay0UWtHqLqQWLz7OfQ6nXalfm77ZZPRRL4Ri52LYlqsSQAek5nXKC5tjm+lSKtAVL3Kb9adRAyfVR4TztWSEX+5Edu0Dzqi9Oft7flHi8+daiyB53fbmoN6kWGszf7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186186; c=relaxed/simple;
	bh=bgVfqHaG7wQhoImwej9xzrtUnOLIxjxnZn8SIu2OsZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paRAzg9486wBYj3scekHuZCEnjmIFqAErF3g71faRk3gkKMCqp1+5sDt2OwlBZQRKNhPJVv2nTnEl3Fu2z+eLOXYYLEi46N4RJP0BxR8J6zZSxwps2A3O41Ik00jURYQXTB59gNWNDO/X3k7jwKvwwwMuXyrc9xAOYT82bhkMmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1UQPtrYs; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1UQPtrYs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0fkqZw+lvaIrdK/Y8NCfrB0Y/FqjQTkhSNk+4fxYmuldrnFdiCmyvOHW74ljrvmi8fI8jQgIhLOr0VrQlsfyzuvCC0G0ppBDnzoR90BXC/2W0CEkvtXWXNNVUKCWV5UNehPR4c/fPmKbtOaIC5V+Lycw0GDN+4eOshxDGCD1PN4oOdCkyh8y49Thnzjeg+6iNeQd6jsVI+Qys89IR4BsdlTu8IRzlz/u0WX3Q6xU8/Xs/3dyv7XOm3w4062N2O4P36+4DCly/q8YQ4ThZLL29yDTbIakGLmPsLnq/VvsP1JZpPq7tpJs6kctEiijvkijxBNtazcgVne8JTMvaOmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgVfqHaG7wQhoImwej9xzrtUnOLIxjxnZn8SIu2OsZI=;
 b=Ej28vDYSwqVkwfBZnawNbESL00ZizE5eIiyV7iyczuw9BcesLIFeAi6r2oGUIG2qBlOcE8+j5H/vQGXGBHM7Avo30ksIeImjPqAeeru9t6YIYklCvOJFI4ACYFu/hUez6X3FmCrQuHOkV48Ypz+SWWSlO65FOKpDVEcJNTT40zzxarfP93wuUaBc1Xs0/hCN4rbJXMeZzEqMz0Tm6HCHJzKLEjTifhUD6SIGSUghqfjNjM7IKE3ZeOcAMGey3MRxcL8ThacOfF/TgbAqmo15kUc6zoyVezmFCPlz51WHo7SYy+Lx9xogLYKlyR2zyHZT4zMtfVUorpiwm+qPk/GDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgVfqHaG7wQhoImwej9xzrtUnOLIxjxnZn8SIu2OsZI=;
 b=1UQPtrYsKyxu1QJN3RNzlQpN5ovUdvufl7/FhrKYeJAaf1prbbXnO1Ru2Yui/+3UqPV+KHs5kSuqkI01HnCzIelvz24R5s+HQHSOTSPlWkkqweEplGcW/HMd2T1it1671wVKoYbK6/lm+mf+qkGuaA024Yc04G9g1X6i0ihCx6Q=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 31 Aug
 2026 14:22:58 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:22:58 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "jmattson@google.com" <jmattson@google.com>, "david@kernel.org"
	<david@kernel.org>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"pshier@google.com" <pshier@google.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ricarkol@google.com" <ricarkol@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>
Subject: Re: [PATCH 0/5] KVM: guest_memfd: fix unbind race and NUMA selftests
Thread-Topic: [PATCH 0/5] KVM: guest_memfd: fix unbind race and NUMA selftests
Thread-Index: AQHdMwR0uLzmsdbaZ0CT4S12Nm25Jra33jqAgABWqACAAA2DAA==
Date: Mon, 31 Aug 2026 14:22:58 +0000
Message-ID: <9c185236e4af2040f641109c93e5f488b80d3164.camel@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
	 <b95f21c1cb45673351df50dab208ec8dd3e8ca66.camel@amd.com>
	 <apWC6tyBOsf8LT1t@google.com>
In-Reply-To: <apWC6tyBOsf8LT1t@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|PH7PR12MB6955:EE_
x-ms-office365-filtering-correlation-id: 0dc65b16-25d5-4bee-287a-08df076b5b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|38070700021|4143699003|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 Z1MIhSAjP8y9Vjh7tW91YCXVqjwt6D8SaE4abJNngCJqgWvI3OpdRWY9tmeZYd2a8bVQrUEnfQJEh9eLNO1dom/Q7xzqTHSerU7CGD/0dRvTcfS4JVHWZDqQYzWZQAdb625ODKCEL60XL/12F4JtTicEOyKpqM84Y1pJz5G+om5TK5qmM6aQwCcwa+VgDkPXQdeEvv/M8M4lYB+e+vzOgTv50i+Jll36hKja5xIg2rD1e8zv4Ullx6/WhN4ezPgz3uvndUDMmjjEzImYXoqEd1IM3hmFZpU3YKcTNe9+lF76rbao87rNR/aDT9gebmWtN4r0YwbsncD5IQU7+Dne0f0Tk6U6xk0N4ZRg/i3SV2BvHDwVjsfGbjI1PFY0gRyQu0rcy8g8kGMoL3ZLJPfjkfJBd/z0zT3SZE0gIOvwOZcOVnUJOb0qwi3oYONe2U2L7WJEddllfcg95+9ga9I+owgz7O4ftNx4lfDDMO/lGkDy9RfdbGVH7tk9kz95H2Em2ZQ/8P9vWnrUOmhH7H/t1enJ1CB7XHOcKtKuXSPAqd6QVnrr+Ke+OnyNbbgkrC7Kl96ZBCsoEkqmXx0I1HWkVHcifHK3/0Qlr45thaoCNJQ7GPnd7HOLfy0yJvh2bOMBx490m9CLp7rfrE/OuIWDrnSwB2ZnrnktVi/ZbTp6+/JTWm/1TE84tOXDuNIjhYo1SfVgbfaZ702woRWGkfg/u27klOuKTTP4MCP1chQiVtA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(4143699003)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXJ4SUk2R2psTVRrTjI0UUdYQVFwSkJvK0N1cmRTZVNPWnFpVUxGSUZEVk4y?=
 =?utf-8?B?ZzV6a0Uza05oZjU5R0tGWWtkRTRWWmhJYzlPN3NtSGJ1VS9IQlhJQ2J3cHhU?=
 =?utf-8?B?VmRSbkl6bWM4S2R4cjNlS1RhcUU3UldvRkZUZ0pMcC9xRUYydGFtTm40SC9i?=
 =?utf-8?B?UUxSY0FZY0NUWjd0cEMxRy9CRXNlb0VVM3JxT3locXVXMHJVeDU5R3p5dzRV?=
 =?utf-8?B?SFFVdmRtejVjZ0RQNm9QOHFMbm14Mm5EVHZ6UmYremdiVE9ZSjVxY3QvUzB2?=
 =?utf-8?B?N2tRVTRTczJ1V2ZUSEt2K241UHFGZ1pUcHZRRGpLT3Z5dFFNbmFZQmliUW1M?=
 =?utf-8?B?OWFnMGh4TitMTWJwUHhMTXNWcGVPMXE5UGp3MUI4YS9NeTlEOVhnT25RMmxn?=
 =?utf-8?B?VWdpdmozdnNsVHg5YmlaSzFGczZLZmV6dUhkaFcyMjhvaHVHVThwOVNCT2tm?=
 =?utf-8?B?Ny9KNUtBSm9wK0FNckNZK1llTFhqMTlyclVIREpzblpFc3VqTUlpekFmNE1p?=
 =?utf-8?B?TzZUNk81QzlkMkFzWi8yWVNXcFphb1ZzMm9hQnJjcE9nS3J4WU85VkpHOS90?=
 =?utf-8?B?aFVqTGptVlVRUTg4SkQrT2NIV2dGQ2tBaSs3Z2FIMUdBUG14Rmk5ZjFlTncr?=
 =?utf-8?B?UkdacFVLeUErbUdNN1JFbkxxT3FPemVZN0RyaE0wQUhOdXhzdWs3aHpEQW5D?=
 =?utf-8?B?M3U5VmVkM0pTQXpxQm1Hbk5tUEc5dTRiQjBtdzlVa1ljTlJEV0lOdURiNGNC?=
 =?utf-8?B?VXFMVDdRQVpBaGR6aUVMbUFtQy94bGJMZnBTOVl4aTJENlNQcEVnWTgvL3lH?=
 =?utf-8?B?K3cvYU1YK1M4MVFjSXR4MFE4TWhRWVZUN0hTdUJGR215ZmpMUWNjMEtxR3Nq?=
 =?utf-8?B?bWl2M3lWTUVCUzNETW1vVmdkZlY0M1dTMCtmb2V0amdUUk0vVTRrR2E1VEty?=
 =?utf-8?B?YWREalNmRjVuY3NodHJ4NVRwRFpBUzF1bktiancraVRhNnc5dTljNWdCSkI0?=
 =?utf-8?B?cjhzcWpuZjZ5M2p4dEZlMlZ5V1JURmtwS0JiR1htYXRoaHlicWFIZ1dLcnV1?=
 =?utf-8?B?YVNYYXNBU2Rpc3NQd0hUZ1k0WWtiMkY3L1YvQllEaDBSU0QyZDMzb0QrS1d2?=
 =?utf-8?B?d1h3Nm1wVWtZa3RGZkJweWtxWUxKWEw4SUVuK3A4cnpmUmhWZkJqWDM0UXhZ?=
 =?utf-8?B?V05wMUNveTdCNGJzTUFmMWkzVVNGZEVwakZzdEU4K1E4ZGxscjJvRWhuNkEw?=
 =?utf-8?B?ODZWc25jb2ZXSnZiRHp4bWRVUEtjQXNEeHdiOVArSDI2c29Ud29MckZOTDVJ?=
 =?utf-8?B?TjF4cjB0MzVnUURjeEtLK2RremhNT2k4WUEySHdPTTduOVhCTk9xaHh6RE5y?=
 =?utf-8?B?S0hIWENMU21rMytpekFrejVaSUdNYlhTanExcGEwejdkWUdoMGpRaU1GTkx1?=
 =?utf-8?B?WVlOYVZDaS9ISHYzT1l3cDA0Y082eWNWZXBodUhVRlQ3TVBrZHIvNTNVZ3FC?=
 =?utf-8?B?bWo4QXRLZzIydUpuT3RQY2lUM3NsdXVkanlWZlhVc3NwQ25IemxjU0Y1SHZt?=
 =?utf-8?B?RWhaQlBPNlZRVUxMajVIbkpCaG1GL1ljeG1ON1dyeDh1T0NyQWpTODhjc20z?=
 =?utf-8?B?aVVhSUJ6V2dzNnVEbVArS2hWaTEycDJBM1owb00xNXBaWnJIZVJPYm80WUVY?=
 =?utf-8?B?VDlVR3E4ZUtBeEZ5c1cwUVFwTkNhcnhWYjM5WWRwb25NMmdORnJ4K0tNeG9X?=
 =?utf-8?B?UGxHcDdEYVlQbDgrUTVXcE9KU2poRWJ6eGV1U3hUV3dKdXRKam9RWjFMVlZi?=
 =?utf-8?B?bTdnaElkUnN5VjFxanpYLzRkaVl0SEVaaWJUZWNldlRMTHFTZzFPalRzUytq?=
 =?utf-8?B?cnlqVEErckR4YnpuZHh6WDJpbU5pdlRZam9qdlV1bjNFcWJPenpGY1lPa3JP?=
 =?utf-8?B?QXNYY3IwYURNeEYyUTFnUHk4Zm9DQUNjd0dFQWJsYlJ2NldaUzlCczRpYkVj?=
 =?utf-8?B?Z2VaMml1a3ozNVdESUc5bE91TkN5TzZTMUNpQm9va3pMNUZ0ZWFvY01EU2U3?=
 =?utf-8?B?TU5WdEpXdTZpdVRiSTBoOTNVRFFOYTQ0Z3hhS2E1bzcybXpZQnJ2dzY4NEFz?=
 =?utf-8?B?RnNtdURnYy9MYW41VzNmMWtnVTFPenVKYkhrZUtTYUJWcFFPUVdibFhXR096?=
 =?utf-8?B?Ym1Ja2ZjTWhZeDJ2YzJpTjRnRDFlUm1JVlk4MzBDMlA1bXdCczZPOWw0OGRl?=
 =?utf-8?B?NThsbDBjc2I3UlJXalh5b2JQTXdkb1JyMkJKQkhaTlh0bmlzZm1ibEhQOWEw?=
 =?utf-8?B?UjNaVVd2eUxtaElwaUVBWmIzakNOMTRyLzc5UHIwMHJ3YkRMSHAvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <137740CEBEFDB14B90F8018184CBF2F1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc65b16-25d5-4bee-287a-08df076b5b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 14:22:58.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gc4BNLGtteeJC3BA1OTLRGIdmsKIq8sS/PXteUtMJhDdfUQsGt//EjzK8ayOrBD4eDyJoj5Xik1GMZ40IPVNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDA2OjM0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEF1ZyAzMSwgMjAyNiwgU2hpdmFuayBHYXJnIHdyb3RlOg0KPiA+IE9u
IFN1biwgMjAyNi0wOC0yMyBhdCAxMzozNiArMDAwMCwgU2hpdmFuayBHYXJnIHdyb3RlOg0KPiA+
ID4gU3BsaXQgb3V0IHRoZSBndWVzdF9tZW1mZCBmb2xpbyBtaWdyYXRpb24gc2VyaWVzIFsxXSwg
d2hlcmUgbWlncmF0aW9uIHBhcnQNCj4gPiA+IG5lZWRzIG1vcmUgZGlzY3Vzc2lvbi4gVGhlc2Ug
Zml4ZXMsIHJlcG9ydGVkIGJ5IFNhc2hpa28gYm90IFsyXVszXSwgYXJlDQo+ID4gPiBpbmRlcGVu
ZGVudCBvZiBpdCBhbmQgY2FuIGJlIHJldmlld2VkIG9uIHRoZWlyIG93bi4NCj4gPiA+IA0KPiA+
ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDgwNS1zaGl2YW5rLWdtZW0t
bWlncmF0ZS12My0wLTAwZDhiZGVjNGUxZEBhbWQuY29tIA0KPiA+ID4gWzJdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcyODA5MjAyNy4yMjVDRjFGMDAwRTlAc210cC5rZXJuZWwu
b3JnDQo+ID4gPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzI4MDkxOTQ1
LkVBNkMzMUYwMDBFOUBzbXRwLmtlcm5lbC5vcmcNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogU2hpdmFuayBHYXJnIDxzaGl2YW5rZ0BhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBTaGl2
YW5rIEdhcmcgKDUpOg0KPiA+ID4gICAgICAgS1ZNOiBndWVzdF9tZW1mZDogdGFrZSB0aGUgaW52
YWxpZGF0ZSBsb2NrIHdoZW4gdW5iaW5kaW5nIGEgZHlpbmcgZmlsZQ0KPiA+ID4gICAgICAgS1ZN
OiBzZWxmdGVzdHM6IGZpeCBtYXhub2RlIGFyZ3VtZW50cyBpbiB4YXBpY19pcGlfdGVzdA0KPiA+
ID4gICAgICAgS1ZNOiBzZWxmdGVzdHM6IHVzZSBCSVRTX1BFUl9UWVBFKCkgZm9yIE5VTUEgbWFz
a3MNCj4gPiA+ICAgICAgIEtWTTogc2VsZnRlc3RzOiBhZGQgZ2V0X251bWFfbWVtX25vZGVzKCkN
Cj4gPiA+ICAgICAgIEtWTTogc2VsZnRlc3RzOiB1c2UgYWxsb3dlZCBOVU1BIG5vZGVzIGluIGd1
ZXN0X21lbWZkX3Rlc3QNCj4gPiA+IA0KPiA+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2
bS9ndWVzdF9tZW1mZF90ZXN0LmMgICB8IDg2ICsrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiA+
ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9pbmNsdWRlL251bWFpZi5oICAgICB8IDUy
ICsrLS0tLS0tLS0tLS0tDQo+ID4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Ni94
YXBpY19pcGlfdGVzdC5jIHwgMTQgKystLQ0KPiA+ID4gIHZpcnQva3ZtL2d1ZXN0X21lbWZkLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIzICsrKystLS0NCj4gPiA+ICA0IGZpbGVzIGNo
YW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDkxIGRlbGV0aW9ucygtKQ0KPiA+ID4gLS0tDQo+ID4g
PiBiYXNlLWNvbW1pdDogMjcwOWRkNWFlMzJmMDgyOGYzODYzMjdjNzZiYmE5ZjM5ZjYzYTFjNg0K
PiA+ID4gY2hhbmdlLWlkOiAyMDI2MDgyMi1zaGl2YW5rLWdtZW0tZml4LXNwbGl0LWI4YTkwNTdj
Zjk4Nw0KPiA+ID4gDQo+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gDQo+ID4gSGkgU2VhbiwgUGFv
bG8sDQo+ID4gDQo+ID4gV291bGQgeW91IGNvbnNpZGVyIHF1ZXVpbmcgdGhpcyBmb3IgbmV4dCAo
Ny40KT8NCj4gDQo+IE5vLCBJJ20gZXhwZWN0aW5nIGEgbmV3IHZlcnNpb24gYmFzZWQgb24gdGhl
IGRpc2N1c3Npb24gaW4gcGF0Y2ggMS4NCj4gDQo+IEkgYWxzbyBkb24ndCB1bmRlcnN0YW5kIHdo
eSB0aGUgc2VsZnRlc3RzIGNoYW5nZXMgYXJlIGJ1bmRsZWQgaW4gd2l0aCB3aGF0IGFwcGVhcnMN
Cj4gdG8gYmUgYSBjb21wbGV0ZWx5IHVucmVsYXRlZCBidWcgZml4Lg0KDQpIaSBTZWFuLA0KDQpJ
J2xsIHNlbmQgdGhlIHVuYmluZCBmaXggYXMgYSBzdGFuZGFsb25lIHYyLCBhbmQgc2VwYXJhdGUg
dGhlIHNlbGZ0ZXN0cyBmaXhlcy4NCkkgdGhvdWdodCBvZiBidW5kbGluZyB0aGVtIGFzIHRoZXkg
YWxsIGNhbWUgb3V0IGZyb20gbWlncmF0aW9uIHNlcmllcy4NCg0KVGhhbmtzLA0KU2hpdmFuaw0K
