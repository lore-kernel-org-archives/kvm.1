Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086F1A2C04;
	Sat,  5 Sep 2026 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634342; cv=fail; b=hqL3CC6lmgP0FZWcf43rHnxDDTRuRxekhJcXYOfVBIDzRGWW5MtCBtaYowaaOQPQJrb8C/4kN3m+T5DZ3YeibI10kFdth3Rt3uFRP3R+UXzb4zrgIclArLIs/gMphA5T1p0ixUtmWuqdPHAmzqlnIGN+kT0FkfNmrrk6DoPtxIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634342; c=relaxed/simple;
	bh=2iW1Mp7ZZbfi0qESyMLQumFP6tmNjl3L3M9kQftKOMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EObkI8g9XNTI1jt9t+0EFvTEptyUftSUMLua7rp2rlL532xM4QeIC7pJClRK82XszUwz8gTzMGmoUbAfRiy7dowaoresadMVBxXwf82i63ffC5YrrLaWegRi+ZbEMhoTkQ0dH30YyDBROknONn1VAHrVVKyqFBpI4n7gc3umNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bUigbG4b; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bUigbG4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umumd6PLcNMlrhXXXzaHZmhYp4/Pj9g3JgfZgUORi4zF7KpYi84MOjKeU1rL22gULHCl6HaUizbwWzTVyByAGBE8h9meIjvhJrNGJaWi+kvnAixigaxqrG9/f+KtPVSZbvGyi+zEvqRwcQORC1CwCha+dCkn34MLzbCFqE0angA/8RM0XfI8w7I56HdADVG5K0FKEfIGQb9Si+hef1kLLFOPG/MtxlIxau/UXm6gi+nB+zmHe2JFmkgIpHEW4xnUpZTiNoxSP5COk5/78fM6/AF5kic0xusyn2TWqge/rBJkdVmjF9Ic5Z5jUh7GRPDlP79nLmX5YkQNxhZELgVSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iW1Mp7ZZbfi0qESyMLQumFP6tmNjl3L3M9kQftKOMA=;
 b=r7SLrg9YcazqWsol6qWkCxtkFtEPxmrXh6eIqkuWamPyeQYTyYgSxj0LfJfIAlyquvStHPlLuKcBZNdJA8dBYPPtKdHZ39cjiwiTe2MfbdjcvvIUTA+zRrChqOYhL/r0YGpq3bk8d2HYffxFSPtootUtXNGNIaJFdIsrRIpnNSERaVz8SLd+rDdS6WfNMFIk0Kxx4V1oNQTcHpTKa1BbClV8xIgSmItpOmii/tnrdj1cNQlOmrsnhAjzep4mVcooFTZ88pGX3ohF3slB76J1ja9fuE4BKs6vr6GspPWmQ8c0gJNWy/Ct77n6NUjbOmPrZRe0/Sh2rNEAKygS/gFb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iW1Mp7ZZbfi0qESyMLQumFP6tmNjl3L3M9kQftKOMA=;
 b=bUigbG4bbImJ2UI6DFI5XcuDJw1z+ny0VbnFzPB63pCVmoV2AlxquuXcRP2y8iq0mCLdAdzkgplkad9tkFe2MCcBPeZcAZU8AsTXA2CT0XI+siKbW8N9iiRshpKa3wywFSEa1Hl4ulZgfOmrVsj6JAFkZ/Nlxzx53TN9KWxm9LM=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sat, 5 Sep
 2026 18:52:18 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0382.007; Sat, 5 Sep 2026
 18:52:18 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "jmattson@google.com" <jmattson@google.com>, "david@kernel.org"
	<david@kernel.org>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"pshier@google.com" <pshier@google.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ricarkol@google.com" <ricarkol@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] KVM: selftests: add get_numa_mem_nodes()
Thread-Topic: [PATCH v2 3/4] KVM: selftests: add get_numa_mem_nodes()
Thread-Index: AQHdOesdqtOlDnaM3EG9JvMCmbDNLra50zmAgAaIRwA=
Date: Sat, 5 Sep 2026 18:52:18 +0000
Message-ID: <c15678d5ea8f229d9b7eb8afb1f0a0c94faf8e20.camel@amd.com>
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
	 <20260901-gmem-selftests-fix-v2-3-5a273153354c@amd.com>
	 <apbqEfeCQhgdAvKa@google.com>
In-Reply-To: <apbqEfeCQhgdAvKa@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|MN2PR12MB4406:EE_
x-ms-office365-filtering-correlation-id: b882de53-5568-40cc-f1a1-08df0b7ecf52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 5Yy6nmlhH3RZQ5agOP355iNFA7gf7TD3+9bYUjEAkQ1NhB05XsKZ+bPkS5Vf9BK3TEgUBqeVdkcsrzB4gwSXoZ1pC83XJcBtXsJD6PxxNEhTzwDQ+xRgI9EZyZpyLdU9ZdthVMRpqRIR7iBX5ipYNnw5MgBfNRG7hcX2ZesStVBOPTh7I77lrf/stDf8papfPe9EEgPUalM57Qv/++TzhHtgN18VZqK15ibzvUyvdeYbUCFVxqzTCLUOD07XjnClqK3QUc0I/yAEDQg5ITcrQyH44Yzp2Wc89qIErCvqyaXe75Hr5aepqX42q9kE2/RdgeXTItbCm6ryIG86HoHUh6Be0Yu37UquNki3HszFcDtVPwT/TBiVsFqXg0GpAfE1kY0aLKVCouLLkyZqIJQhVzJvEyFeBdDe/4j3Ek+ioEMg9mfi+HMbWe5QwGgpmxxcLzzPDdq9JS9ZQgNxWN6eND0Isi+rdJzvtilLaaKPLczfdEhb05dFa3/E+ITQ9rDUyxiwCyXCZHdTETaojaGEcXquV3ka9UO0XIxQQC1nQ6ntu+y6DchH0yfYSwID3TvqmlEGOlkcJvnv/fBRIZn2qp+uIsGTOpz66jjpHpA+Fc9CKYLVJTJBHeBIbvql0MmDBk37MKMcvO9HrdAi9v77SV1Gzx/pbr+7MbphxdwDctuYPm28dCAq0jqnckEcpauoyg6zHbEtvIlT+efYMshD0g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3BFT2dYY1ViSVJXbmMzTDA0OWNkTVJHUVRVREp5WkZmaHBNZ2JVRjh4eTl6?=
 =?utf-8?B?dFNBNUdDb2M4WS8rZnRwNXhTaWdjK0Y0bjdrSHNsT0Z5U3pSK05KOFpaSiti?=
 =?utf-8?B?RG9COC8rZFRLWkVLMVJiY3NtODV6WUtkdkM5TCt2RVBBMlZ3MUg3QVYzNDNq?=
 =?utf-8?B?RTJrclFCc1ZBa01zRTVQaHVvcWgyVjI0THJtcnY2bWdlbHlXUVVGNjZuSEhi?=
 =?utf-8?B?cFozK2RRWDl2SWM2L0hNOS8rVUgzOUpoZHkwaWlrcXZ4MXQ2UUhwTFhaUlN2?=
 =?utf-8?B?b0JyOXRXQkdtaHlTZGY2L3ZLTVE1akhybnJWbXo3NU5xeHVGNndUNFBScVc0?=
 =?utf-8?B?ZEFxR3lST29tM1VibnNXVlIydlJHR3JYY2V4YUU2cW16b2Z4SmUxTTRSMmE5?=
 =?utf-8?B?MExzY1IvYlIyVmU2ekRlRFJBakMzUkNhblIwTFViRXVqT0tpNUk1eVpRQUph?=
 =?utf-8?B?K3ZTVk05MDdpbTlZRUVHQWMwWmNQQms1SXVKNFhuQm9ZbHJibVp6b3R6SkNL?=
 =?utf-8?B?azFBc2tHSHMxeWE0S3ZHTlNGb3VDQVM2b2gwTHlJeVkvTFJGK3VheWNYYU8w?=
 =?utf-8?B?NjQ0WFFSZ0RRYWgzR1dGVmFWTnlFTURVY2JkTEdvZWZQYnR6dXdUVjhoSHVM?=
 =?utf-8?B?aW1iR0pWY2MvT2NCNUt3TEszY1ZMYmlJVUJOMXlrMUpqREkrbEVvNEhHWHlh?=
 =?utf-8?B?YmRhQTR1emdYUkQ5cGNsamJkWlYrbFNGbzBhRW9HM3VLS3JoNmFWbndSOWpG?=
 =?utf-8?B?UktZWXpwQzBxMUt4SS8rdHdER1VxVVNBaHhzUDNwRFNYZy9sMHFSeVJ6K1d3?=
 =?utf-8?B?R0tnL0Rib0M2N0RUbXgrMTNrbnpmbEw1QXljTDFCNTdVd0pvSml0amQySUt1?=
 =?utf-8?B?VXFjTTdKZmM4N3NnbzIrQndUcDVtUTJBT05LSURPZFkwYmNHckgwd2RIZENa?=
 =?utf-8?B?eGFaeEVkMFdpbmgrYS82ZVIySHZmVzdheUJNU2FrVTQ0OVAySW8zUWYyWlcw?=
 =?utf-8?B?blFGTnhua0FHN0JjZ1FvUUluMldRMmo3MmFGbzkvc1JIQmRmYWtYZkpuYUc4?=
 =?utf-8?B?d28xK0xBRjZ6RkNEbVlIMXRnblNkVWxSakJlU29kekg2d3QvM2tpNVpYcjVt?=
 =?utf-8?B?dGd1T2dSckRwMHRTUE9uTTRRYVBpQzVGSW1CeFJPK1JhQUZiY2MzWXJja2lZ?=
 =?utf-8?B?WkxuQzJadWZoVWZyU1FCVHd4MEZlMVJSalUrUjVIaTRLcVhRNjJ2amJnUGFq?=
 =?utf-8?B?Nm5nTWZqeElEWDJDU2R0K3cxNEJjaHgyVmp5RHpDaStuUm1SdlFMZzg0Ujlz?=
 =?utf-8?B?djZlSmVzYU12cW1aS3hEdHpDTkVpUytoaUdLaDJYT09Bb2Z4V2ZIU0hZaWp1?=
 =?utf-8?B?SHpkUXRvbGsyaWZXOVlhdTh2eFlTOHpqN1lEckNDbXVIVGdyRWM4aTZxYUVJ?=
 =?utf-8?B?bk0zWTZQUG1zYzhaRS8veld6QUlyQjdHdjN3c1pwSGVad0w3VkF2Wm54RVMv?=
 =?utf-8?B?U3BMYzJXdGh5VWdOY3hxdWJuTW16K0RxTXZZL2JJMjlPaE9JOWVHUmlaZjU1?=
 =?utf-8?B?bWZZL1BxL1EreEZmVzFFMVZ2amtkUDFYUlNTNFBMOUIxNlhZdXBOOVU3YnRn?=
 =?utf-8?B?VVBrcVRmOFIxSzNlUmFoTkFnbUhOQUExeFFKUjZNNW1xU0NMdG5MS2xTR2xq?=
 =?utf-8?B?UTlrWmtLaXF3UWdWWXhuOTVKS3BKanRnSmJ5b1FqbFhWWkd3bWlyM0ZWNjJN?=
 =?utf-8?B?Rkw1MTJ6a0tMSThyUU5OQzBNUUZ4N3BINXd6VVg3NDl0eUx5ajg4OEE0L3pG?=
 =?utf-8?B?QmczRVEyeGltU0ZDSzlnZHFPdU12dmE4eXdBSEFkVEdvNHY4VCtCcnF2UUhy?=
 =?utf-8?B?bThWaU1QQ2xoU2ZINVdERXZOcWd6NHYrSGdxZStiZzJaUWtZQ2JFOVplNWNa?=
 =?utf-8?B?ZUN5QmJDUlBmSDRFbWlsM2Z0TjM1UjhSTk51bEJRWHNJTXRQYUhCQTBpeTl2?=
 =?utf-8?B?ZGkwWEF2UGQ1d2VuRHZWZDNaRkxkRUwxNDhRbGpycVl2ME1HaW12L0tPb1hF?=
 =?utf-8?B?b0RSdk42R1pJalp2bHhkamx3SkhUdkpZYlNydlQ1dlpRT01uMXRTbG9PbWtP?=
 =?utf-8?B?VXRFeCtDVU00YzZkVGFJZnpnSkhpQTZBdkRpbm9jdTYxWk1icE1ESFNjdWtO?=
 =?utf-8?B?cis1OWdGamQyYS9oMkw0d1JmeTY0eGJZRU94RFhTYys5bVp5Uk92WjBhcGtY?=
 =?utf-8?B?ZlNrZGpKUTNGY0ROYjliUThvR0FRYnFmblU2TFhKTTQwT09lb1dZM2h4N2N2?=
 =?utf-8?B?L2FFZFY4MzhCZWREK2ZLSzZRMU1nR0hidGxFOWZndGpKTVBma2NsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2962F076A7DA9488AEFDBDC93B4DD3F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b882de53-5568-40cc-f1a1-08df0b7ecf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 18:52:18.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeeG0gkCRv1kCrVH3BLulAW+wJePQRczQChCpXTBm1Y1vXbAyUicvsmGWPIp9+dG2aehT5Pze7+GRBI5BUso6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDA4OjA2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIFNlcCAwMSwgMjAyNiwgU2hpdmFuayBHYXJnIHdyb3RlOg0KPiA+IFRo
ZSB4QVBJQyBJUEkgdGVzdCB1c2VzIE1QT0xfRl9NRU1TX0FMTE9XRUQgdG8gZ2V0IHRoZSBtZW1v
cnkgbm9kZXMNCj4gPiBhdmFpbGFibGUgdG8gdGhlIGN1cnJlbnQgcHJvY2Vzcy4gTW92ZSB0aGUg
cXVlcnkgdG8gbnVtYWlmLmggYXMNCj4gPiBnZXRfbnVtYV9tZW1fbm9kZXMoKSBzbyBvdGhlciBL
Vk0gc2VsZnRlc3RzIGNhbiB1c2UgaXQuDQo+ID4gDQo+ID4gQ2FsbCBnZXRfbWVtcG9saWN5KCkg
ZGlyZWN0bHkgaW5zdGVhZCBvZiB1c2luZyB0aGUgYXNzZXJ0LW9uLWZhaWx1cmUNCj4gPiBrdm1f
Z2V0X21lbXBvbGljeSgpIHdyYXBwZXIuIFRoZSB4QVBJQyB0ZXN0IGFscmVhZHkgYXNzZXJ0cyBp
dHMgdHdvDQo+ID4gbm9kZSByZXF1aXJlbWVudC4NCj4gDQo+IE5BSy4gIFRoaXMgaXMgbm90IGFu
IGltcHJvdmVtZW50LiAgZ2V0X21lbXBvbGljeSgpIHN0cmFpZ2h0IHVwIHNob3VsZCBub3QgZmFp
bA0KPiBmb3IgdGhpcyB1c2FnZS4NCg0KQWdyZWVkLiBJIHdpbGwgZHJvcCB0aGlzIHBhdGNoLg0K
WW91ciBrdm1fZ2V0X251bWFfbWVtb3J5X25vZGVzKCkgLyBrdm1fZ2V0X25leHRfbnVtYV9ub2Rl
KCkgaGVscGVycyBhcmUNCm1vcmUgdXNlZnVsIGhlcmUuDQoNClRoYW5rcywNClNoaXZhbmsNCg==
