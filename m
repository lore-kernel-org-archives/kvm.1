Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9743BDB7
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695922; cv=fail; b=AO3ftqDMnNN0Pksf01BkslnwVBkaeF6l/WaSz6Hp0K+NxC7k7q1VT4hJByrnpQ7kx/oT+isj1ASYQwfA4ipkmdL3TzLM7TUXrzfRgGtD7762dGKJgP1up7VF2A7z0Bahbt9XMg7KB0iNoJ176mYymZRhx2UMbzpmO20nVN65xkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695922; c=relaxed/simple;
	bh=jZJLDQk6k5czJQRNuS+nS6hFLcd+xJSRYo0MwH454jQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1WMXcg6v5kWBaSrq2VZUDRFzKqQmMBz25/7zereMf+rZHhfDhdS+N4mAZjevU0G0SEkeFC0Ch5/ekJL30tRuHV2M76FF3VjM03mMaQZxJTmbiH9EFyCxn3CcIjMjsI5MQAxDyinL6lv/NFD4lJsCbzd413wJfhoOXq6QXqxsfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=usdSodyB; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="usdSodyB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKxaKYhFrQV7/PzB6Ka5W377shhCqypMFyMYQd1VWTYZ7A0I93hltM/bvkgxR42xRdu2+ChNKgzFdiSxn7q6nePCjt+8XeEQ+wgs7WXQL/CTlR6LvPNhbRB2lOTGKWzLx8cupbzQndhM6eG/DgbT2Dbys7aB4+5bN+PLPP6DaflYJkh7nT/DGdd6XPg27joi/axlFO2ZxTnOkqjzAcxyK/x339rBKo5NaWD5di6CxkKzRaRNCdEtpeQlphvS4ft2ItT5ttE1/SlqmLypDmwh8I04pfXFpMYkr53XL/PCKl/olhHzib1lX/8k9+howXa+12FOb62jTheqNVqNKK4Vag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZJLDQk6k5czJQRNuS+nS6hFLcd+xJSRYo0MwH454jQ=;
 b=Sf3Ky1K2GL27Nc1n1hAXqiKZkMfkcMTmoJQizerYo6xlLHjhMYNkljYpn9tCNXfjnYUJFxJqNxAmQiSrtWqBZwCd8UngjVGFgZPTFpOZQbSrOpNziExaBYeNGA9zsHCCKHlxGrPtv+bTscAykNCAFMO8QcrMyNrDTOghG3OMu7Nlk9WwNiEE745xCCUC828w57CuzGvlZ+x9KRJxXhMHwxOa40qqIf1on+Sue+za29J3/V2a2vpJ9etymbF2HiUIhDdH1pVQpcw9u961q7BfjUeOWaJLvuDdPK8/ekmYEYDEbP7EM6V1+492iCxqW91aGzmRwANAY6zOizGymc9Vvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZJLDQk6k5czJQRNuS+nS6hFLcd+xJSRYo0MwH454jQ=;
 b=usdSodyB9rxQhCckBmtBYt+ou/nvdX2G1VGayI6+59o+rCKdSc7lw7d1u0QCkOnVvnjek4qFHKQxeyqxWvUxjrJjNJ8bMwBDxco2OWoxKyh0dKCxtr9cbavbuPhtvcm8IOtRk2A/WKJKuC69/tA4ZpPfGX2YTDpCqmyngGKSK6Q=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 08:25:14 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:25:14 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 4/9] KVM: guest_memfd: add GUEST_MEMFD_FLAG_MIGRATABLE
Thread-Topic: [PATCH v3 4/9] KVM: guest_memfd: add GUEST_MEMFD_FLAG_MIGRATABLE
Thread-Index: AQHdJKlEthktLcogDE+HuG4NeJDNF7adQ4iA
Date: Fri, 14 Aug 2026 08:25:14 +0000
Message-ID: <7bb6fc47b7eff2f76ca528671b4b883d3231a1ea.camel@amd.com>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
	 <20260805-shivank-gmem-migrate-v3-4-00d8bdec4e1d@amd.com>
	 <20260805070846.D3B281F000E9@smtp.kernel.org>
In-Reply-To: <20260805070846.D3B281F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|IA1PR12MB9466:EE_
x-ms-office365-filtering-correlation-id: 60a87ccf-27bd-4b51-104a-08def9dd90a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|22082099003|4143699003|56012099006|11063799006|10067099003|18002099003;
x-microsoft-antispam-message-info:
 ADhAY3TvviVPFZuQCtSnJmlG9MxRzAqCZc+G+GqTgMW7X6Z5MQmgSl0dRAy7uqbMYN58h7coGTknpKupdj/Fxy8KdXDDmLauuLiYy8WzPi8M+/yTp9Gd7yr2p71/sas0aMjbezazmCy+F3PxX2AOhqXKRSdgMfG1Fp+rQrGkp9dl0YcSQbX4s1WZMJqYMENXHERfC9aKSMC2+E1N5bMMWjWLsbB+3a39WjeygFfk2oDObazepFs3gi3S1eNHvA8+IYuNXIHl1f3ktQwj3VIeaVSLgPqkik1jD29F8J1/2iE90z1WTaehEmQ0sCdVsEpV/aL0CVHuS/ZRKH+Lpnm2K+XBdpK3bgn0/n5WbDZGyIwiowwfTgDWYFKQflMwhTvJM+zXls64Y8q6eBDljFaFg0G0sVWXE39ghp+n01yewWyMQ1Sq8DUrYZRluaIEQU7JnN2HhSI4AoB99OkSlRuhBOsY5qZROQcrumDWhbmUpvPdvGcDgR4sJ6RsX+bpgPUWEw8h7SPG+IiZvAmLlhYiLtgWjIb/pyF7YKah1XXaJzTfZMVcypKcfBbIRD5MX0TyEp6I0vjE3LJc3uMXETc6XUqtjCAN3+nD48yH2HIQmzff55wYCGgjwyiK9aEOb0It/qAu41QuNq59qDvIXB0zcznQKqFLiAd74gzy6OW3gAA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVlJc1kzQktQdlIzazdQWkhmVEI0YTdBSkJ3RVhMWnJjWEVMelhQU3FuTWNy?=
 =?utf-8?B?SDlYajVKZ0Z1cFpyeU03SHFBc0RmWk1KaWRxZ3Q0S0hxVUpmNlN5Z0JWbVdq?=
 =?utf-8?B?Q0VUSUZ2TElvcnZoUFIrZW5UcVR4cCtxQUxVYkcwZXZrNGJZbngxRHFnK3FY?=
 =?utf-8?B?MTB1a3UzWk9qdkxoWWExY3ZNcUFtaEhhckxPVGJGZlcyeWRrQUhsMVZIQVFk?=
 =?utf-8?B?cFRTV2FHYStFYkJaRVdWbVQzYWQrSXpnSXJXU29KMDcrODFiQWU3RjZoczhK?=
 =?utf-8?B?aFJ5L1ZiL2pvNmRnaGxiSW5EYmVTYzBCa1R2SlVTc043WDdLeXc5RTNkQUto?=
 =?utf-8?B?MFJXa2pSWS9UdEFjQlFhcEt5dFhTbkllRkxPVnRlKytFZzZqalpHSUl0WXVu?=
 =?utf-8?B?cE5vVXZ1dG45eUdJek9EOVNQVjB5WkJWaWEwRDZIQXM1RDdYWnB1OGttSjFz?=
 =?utf-8?B?UWtVZFRxSkp3RHkzbWxNQ2xFeDRnUmFmVlU2ZVhwQnRlcS9SRWdyOVdXc09M?=
 =?utf-8?B?WXdyWjBqcFZzN2VOK1k5TVBwcnNGR2xKSXlwMWhDRmlnZ0tZbDdMb2pzNmNX?=
 =?utf-8?B?Qkg0bWFEVXBNdmhYM05ELzhhOTFzSXhlR3g1OW1EeGxlaytFSlFhZ2hrbDhk?=
 =?utf-8?B?SVRYUHpTdk5JaDB4eEVnd3IvbmRDMmdROHFxVkVJTXV3Y1lhWXNuT1NiMDY2?=
 =?utf-8?B?NjIvL2hscUlubDR5Q0lDUXV2ckJQNEFNM0wvT0lOeEhNZjYxU09NTytsbEFU?=
 =?utf-8?B?OUI2cE94eW45STZZRngzSUc4YWNIZWNXeStuYzdlditoNUxhWndUQWl0ZVBK?=
 =?utf-8?B?T0pJb25XaEFrNDJHUUdWU2Y0b3NYb1JLOGlVWmMwTVFNMFdiOFFJS09xdHZx?=
 =?utf-8?B?UVVQREUvK1hCckppcXhOVE94WFhnY1RiQXZWMm5TUUQwQ1B4VEFtK2ZvSXVl?=
 =?utf-8?B?VjYxek9wWTdNaGdEdnZmeEluOFFnTTY2Y2ZlN2RUZ25zSkNYS0NYSE95WFNw?=
 =?utf-8?B?clN6Qm81eEwxMzRKRU1KQVdmeDlpaXU5K0VqRWE3Ky9BUUxicXFvZXB0RzVv?=
 =?utf-8?B?MzBTZWtEWG9sZWY0SmZvZUcvRW5lN2I2UW83Y1pMelQ4VHU3RWlpYjdQVUpi?=
 =?utf-8?B?MEFtMUdzb3kxcU5zRTZEbEM1SkVsQllaWm90MG5TaG1sS05GbFZQczFhaUlQ?=
 =?utf-8?B?ZW10bFdJUkI0WHRaZ2pkdUNoTFR4N0dSNnpZV1lBNmE4a0VIWEthbHR3eE1F?=
 =?utf-8?B?SGREbkQraE5HWCs0djB0SWdQNzE0MTh3K0ZXSWQrRSs1OU5oUUNJcHA3am5X?=
 =?utf-8?B?YXhDMndlSjU0eTZ4cWdiRmZha2ZIcEVsL0xsbHNqMkI0elJidDJyb0JZVkcz?=
 =?utf-8?B?QitaREZwSGROdzlWYVhHVTBIYXd0TkhKNENqUzF3akZZK2hKNGpXZC9JYUNm?=
 =?utf-8?B?K2NMV3JHZ2JNcWdienZyeVd1SGRWVTk4eHA2WGVsV3gyeUVSbjlmZkR3WU1I?=
 =?utf-8?B?NlNNMndoeTBFR1lXYkY1VUd5c0dwbTh3a1BFU3Nma2lNRlZZd1d1S2FPTCs5?=
 =?utf-8?B?bnIvSnhjUStwNDg0Z3FuWEYrSE5DaTFjcitMWElQRmdoSUtZMXFydzBZMGo1?=
 =?utf-8?B?VGg0VFY1RVQ3UGlLS0VET0NpQ2h4ZkpSblE2aDNMLzhWL213ZTYxNUpMVzFt?=
 =?utf-8?B?ckVkamlIcStwczRJSWVTN2hvZHRmd3VPSFhGOWF5eGpsaFVqZ0xBZ1U5dlhV?=
 =?utf-8?B?cmt5ZUZZSVRDYTNjNlFhTUZjYStFTEtlQ0s4d1B4a2tneE91MDQ4b0JrdEdn?=
 =?utf-8?B?TUJKenZXeERhNzlSMFFONWt4UW1ydjF6aGdOczhZSDFCVWY0Q0xOZFRSdVdK?=
 =?utf-8?B?TFR0aDlKNjJCTjJtY0ZLQXFOZzFiUU1ta2paWEJ3STY3QWc3NitnN3I1L050?=
 =?utf-8?B?QmhNRlgzaUVMUFFtaXNQNlc4bFA0ZUVyQi9BdUd1VloxNlJ2YUI4WHBRa09N?=
 =?utf-8?B?bG1rMzV4aC9FNE1FeHdYMVAwT1VNay91a011Vk4vZWdXeHlMM3dGcHpYWC9t?=
 =?utf-8?B?K0pqYzlkOVhKSnV4S1QxVTdaKzZSVmJzSWVpMm8vSGlITWdvekt0ZjdQbHhz?=
 =?utf-8?B?V1FGVTZUcWk4bFMwc2ViR3FiMUl6eG5ObUc5ZHJtZWxJazhyZXNzUVhCN2hB?=
 =?utf-8?B?amRzUThhMjJyRFB5cjVpaVU2QVMzWFcwblk5OUVMbm8xYXRKQ3ljbE5rQS9k?=
 =?utf-8?B?V2FFQ0pYeVBiWmxRbTYvSURBNU03alIyZEJlc2lZamRlamY0YmFDZHA0U3NE?=
 =?utf-8?B?R0dvTXNkVnVYRDRRdk55bUFyeWkwdUttMlVSZTNCQU1jUk5wc0hsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB302576F53E3A4FA2A48FCA29C5A8C9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a87ccf-27bd-4b51-104a-08def9dd90a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 08:25:14.2826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwbPK9i5NdI/UKUjdw2n8pNLM3swwn0y9cfu0pw2DlxA4UfZp6Lar3on/g8yS6bAQEtZghpNVPI4oI7ZO4Fugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

T24gV2VkLCAyMDI2LTA4LTA1IGF0IDA3OjA4ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAyIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVkaXVt
XSBHbG9iYWwgY2FwYWJpbGl0eSBjaGVjayBmb3IgS1ZNX0NBUF9HVUVTVF9NRU1GRF9GTEFHUyBm
YWxzZWx5IGFkdmVydGlzZXMgR1VFU1RfTUVNRkRfRkxBR19NSUdSQVRBQkxFIG9uIHVuc3VwcG9y
dGVkIGFyY2hpdGVjdHVyZXMuDQo+IC0gW0xvd10gVHlwbyBpbiBBUEkgZG9jdW1lbnRhdGlvbiBm
b3IgR1VFU1RfTUVNRkRfRkxBR19NSUdSQVRBQkxFLg0KPiAtLQ0KPiANCj4gLS0tIFBhdGNoIFs0
XTogW1BBVENIIHYzIDQvOV0gS1ZNOiBndWVzdF9tZW1mZDogYWRkIEdVRVNUX01FTUZEX0ZMQUdf
TUlHUkFUQUJMRSAtLS0NCj4gY29tbWl0IGYxMjc2NWY1OGNmM2FkN2MzOGFiY2Y2OWM2MDk1NzBh
NjY1NzhlOTMNCj4gQXV0aG9yOiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+DQo+IA0K
PiBLVk06IGd1ZXN0X21lbWZkOiBhZGQgR1VFU1RfTUVNRkRfRkxBR19NSUdSQVRBQkxFDQo+ICAg
ICANCj4gVGhpcyBwYXRjaCBhZGRzIGFyY2hpdGVjdHVyZSBzdXBwb3J0IGNoZWNrcyBhbmQgYSBu
ZXcgZmxhZywNCj4gR1VFU1RfTUVNRkRfRkxBR19NSUdSQVRBQkxFLCB0byBhbGxvdyB0aGUgTU0g
dG8gbWlncmF0ZSBndWVzdF9tZW1mZCBmb2xpb3MuDQo+IEl0IHVwZGF0ZXMgdGhlIG1hcHBpbmcg
R0ZQIG1hc2sgYW5kIHJlbW92ZXMgYSByZWR1bmRhbnQgV0FSTl9PTl9PTkNFLg0KPiANCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9hcGkucnN0IGIvRG9jdW1lbnRhdGlv
bi92aXJ0L2t2bS9hcGkucnN0DQo+ID4gaW5kZXggZTMwMDNhMjQxZDViMC4uOTc2OTIxNTI3ZWY5
YSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2FwaS5yc3QNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2FwaS5yc3QNCj4gPiBAQCAtNjQ2MSw2ICs2NDYx
LDkgQEAgc3BlY2lmaWVkIHZpYSBLVk1fQ1JFQVRFX0dVRVNUX01FTUZELiAgQ3VycmVudGx5IGRl
ZmluZWQgZmxhZ3M6DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aXRob3V0
IElOSVRfU0hBUkVEIHdpbGwgYmUgbWFya2VkIHByaXZhdGUpLg0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU2hhcmVkIG1lbW9yeSBjYW4gYmUgZmF1bHRlZCBpbnRvIGhvc3Qg
dXNlcnNwYWNlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlIHRhYmxl
cy4gUHJpdmF0ZSBtZW1vcnkgY2Fubm90Lg0KPiA+ICsgR1VFU1RfTUVNRkRfRkxBR19NSUdSQVRB
QkxFICAgQWxsb3cgTU0gdG8gbWlncmF0ZSBndWVzdF9tZW1mZCBmb2xpb3MuDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBdmFpbGFiaWxpdHkgaXMgYXJjaGl0ZWN0dXJlIHNl
cGVjaWZpYy4gV2l0aG91dA0KPiANCj4gW1NldmVyaXR5OiBMb3ddDQo+IFRoaXMgaXNuJ3QgYSBi
dWcsIGJ1dCB0aGVyZSBpcyBhIHR5cG8gaGVyZSAoc2VwZWNpZmljIGluc3RlYWQgb2Ygc3BlY2lm
aWMpLg0KPiANCg0KQWNrLiBXaWxsIGNvcnJlY3QgdGhpcy4NCg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGhpcyBmbGFnLCBmb2xpb3MgcmVtYWluIHVubW92YWJsZS4NCj4g
PiAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jDQo+ID4gaW5kZXgg
NDdjYjllYmExMTNiMS4uNzA4N2IwYjhmOTczZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9r
dm0veDg2LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCj4gPiBAQCAtMTQxMzAsNiAr
MTQxMzAsMTUgQEAgYm9vbCBrdm1fYXJjaF9zdXBwb3J0c19nbWVtX2luaXRfc2hhcmVkKHN0cnVj
dCBrdm0gKmt2bSkNCj4gPiAgCXJldHVybiAha3ZtX2FyY2hfaGFzX3ByaXZhdGVfbWVtKGt2bSk7
DQo+ID4gIH0NCj4gPiAgDQo+ID4gKy8qDQo+ID4gKyAqIE1pZ3JhdGlvbiBvZiBndWVzdF9tZW1m
ZCB3aXRoIHByaXZhdGUgbWVtb3J5IGlzIG5vdCBzdXBwb3J0ZWQgeWV0DQo+ID4gKyAqIGFzIHRo
aXMgbWF5IHJlcXVpcmUgYXJjaGl0ZWN0dXJlLXNwZWNpZmljIGhhbmRsaW5nLg0KPiA+ICsgKi8N
Cj4gPiArYm9vbCBrdm1fYXJjaF9zdXBwb3J0c19nbWVtX21pZ3JhdGlvbihzdHJ1Y3Qga3ZtICpr
dm0pDQo+ID4gK3sNCj4gPiArCXJldHVybiAha3ZtX2FyY2hfaGFzX3ByaXZhdGVfbWVtKGt2bSk7
DQo+ID4gK30NCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgva3ZtX2hvc3QuaCBiL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaA0KPiA+IGluZGV4IGFiOGNm
YWVjODJkMzEuLjdiMmYxNWIyMTk3MDUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9r
dm1faG9zdC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oDQo+ID4gQEAgLTcz
MSw2ICs3MzEsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wga3ZtX2FyY2hfaGFzX3ByaXZhdGVfbWVt
KHN0cnVjdCBrdm0gKmt2bSkNCj4gPiAgDQo+ID4gICNpZmRlZiBDT05GSUdfS1ZNX0dVRVNUX01F
TUZEDQo+ID4gIGJvb2wga3ZtX2FyY2hfc3VwcG9ydHNfZ21lbV9pbml0X3NoYXJlZChzdHJ1Y3Qg
a3ZtICprdm0pOw0KPiA+ICtib29sIGt2bV9hcmNoX3N1cHBvcnRzX2dtZW1fbWlncmF0aW9uKHN0
cnVjdCBrdm0gKmt2bSk7DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIHU2NCBrdm1fZ21lbV9n
ZXRfc3VwcG9ydGVkX2ZsYWdzKHN0cnVjdCBrdm0gKmt2bSkNCj4gPiAgew0KPiA+IEBAIC03Mzgs
NiArNzM5LDkgQEAgc3RhdGljIGlubGluZSB1NjQga3ZtX2dtZW1fZ2V0X3N1cHBvcnRlZF9mbGFn
cyhzdHJ1Y3Qga3ZtICprdm0pDQo+ID4gIA0KPiA+ICAJaWYgKCFrdm0gfHwga3ZtX2FyY2hfc3Vw
cG9ydHNfZ21lbV9pbml0X3NoYXJlZChrdm0pKQ0KPiA+ICAJCWZsYWdzIHw9IEdVRVNUX01FTUZE
X0ZMQUdfSU5JVF9TSEFSRUQ7DQo+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfTUlHUkFUSU9O
KSAmJg0KPiA+ICsJICAgICgha3ZtIHx8IGt2bV9hcmNoX3N1cHBvcnRzX2dtZW1fbWlncmF0aW9u
KGt2bSkpKQ0KPiA+ICsJCWZsYWdzIHw9IEdVRVNUX01FTUZEX0ZMQUdfTUlHUkFUQUJMRTsNCj4g
DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBXaGVuIHVzZXJzcGFjZSBxdWVyaWVzIEtWTV9DQVBf
R1VFU1RfTUVNRkRfRkxBR1Mgb24gdGhlIGdsb2JhbCAvZGV2L2t2bQ0KPiBmaWxlIGRlc2NyaXB0
b3IsIGt2bSBpcyBOVUxMLiBEb2VzIHRoZSAha3ZtIGNoZWNrIGhlcmUgY2F1c2UgdGhlIEFQSSB0
bw0KPiB1bmNvbmRpdGlvbmFsbHkgYWR2ZXJ0aXNlIEdVRVNUX01FTUZEX0ZMQUdfTUlHUkFUQUJM
RSBmb3IgYWxsIGFyY2hpdGVjdHVyZXMNCj4gd2hlcmUgQ09ORklHX01JR1JBVElPTiBpcyBlbmFi
bGVkPw0KPiANCj4gSWYgc28sIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyBub3Qgc3VwcG9ydCBtaWdy
YXRpb24gKHJlbHlpbmcgb24gdGhlIHdlYWsNCj4gZGVmYXVsdCByZXR1cm5pbmcgZmFsc2UpIHdv
dWxkIGFkdmVydGlzZSBzdXBwb3J0IGdsb2JhbGx5LCBidXQgdGhlbiByZXR1cm4NCj4gLUVJTlZB
TCB3aGVuIHVzZXJzcGFjZSBhY3R1YWxseSBhdHRlbXB0cyB0byBjcmVhdGUgYSBndWVzdF9tZW1m
ZCB3aXRoIHRoaXMNCj4gZmxhZy4NCj4gDQo+IElmIHdlIGRyb3AgdGhlICFrdm0gYnlwYXNzIHRv
IGZpeCB0aGUgY2FwYWJpbGl0eSBhZHZlcnRpc2VtZW50LCB3b3VsZCB0aGUNCj4geDg2IGltcGxl
bWVudGF0aW9uIG9mIGt2bV9hcmNoX3N1cHBvcnRzX2dtZW1fbWlncmF0aW9uKCkgc2hvd24gYWJv
dmUgbmVlZCBhbg0KPiBleHBsaWNpdCBjaGVjayBmb3IgYSBOVUxMIGt2bSBwb2ludGVyIGJlZm9y
ZSBwYXNzaW5nIGl0IHRvDQo+IGt2bV9hcmNoX2hhc19wcml2YXRlX21lbSgpPw0KPiANCj4gLS0g
DQo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8y
MDI2MDgwNS1zaGl2YW5rLWdtZW0tbWlncmF0ZS12My0wLTAwZDhiZGVjNGUxZEBhbWQuY29tP3Bh
cnQ9NA0KDQoNClNvLCBJSVVDLCBJIGNhbiBoYXZlIGFuIElTX0VOQUJMRUQoQ09ORklHX01JR1JB
VElPTikgY2hlY2sgdG8gbm90IGFkdmVydGlzZQ0KdGhlIE1JR1JBVEUgZmxhZyBnbG9iYWxseS4N
Cg0KVGhhbmtzLA0KU2hpdmFuaw0K
