Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B93D9DD8;
	Mon, 31 Aug 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164673; cv=fail; b=l1vevRRFpDMcPjiosBqvI0l0ZfyEFqHDw5fYCpOcqNOmYw8gLlmZe+PHZzwfsBsbocbz8wVzFsqsKmV/BjyIDgn40m1B5qUF279DovZp0pzSCDhjMfB6G6zRAQjf2+usyKGSSrm4GpWQoloIp9nyvC4f0pnu7/MpG/EcBt6DGm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164673; c=relaxed/simple;
	bh=jc3O4H72jIrtEB/aUnjyu99KCZd0/gom2nfNHdsqFeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PEDrIdbbTznZC9lDrzqvWT0B3ffSmJbLcz9KC4yQo+0V2+AMK0Bs8aRw2b9WtNaL1B9tH49SsnBHggBGXvMfsDztuXYykj7OhgBRN7xllnhlI5Tx9LxrA03wuH4O+XtbXJn3Y82/MkafgmiBpmHE5g34Y568nh0zL900MdCWrFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e76p3vXL; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e76p3vXL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXzHKNil1neZ2a5ZS2v9jKn2zkVfgzytC20OAlol9G4L4oVB3sFTkmZoAJ8ghs6KotyGXoRsSSDE8aSFe6fR3/5MpBSZ03F632zq2SkjgZi/81rOdMS069ehaQwAdzVFb+Yx9iIA9LPmKV/84vzKko85Co5cKC4+l6yVccPkaBpayGnJ1eAmvdGID3pXdTeOINUYrP2z6TJskGbbzoAaPssks0+16jVxmFDM8GrOV8DLpwhj5asPMZOaaiCbCEB0n6HSzqwqHRh2Oky55f+5+dTSJBwueMFmDLd9+ijhDU8tn4cba9l/pIkcW3qGU653hTl3s3lHBxtxaj5beU9X5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc3O4H72jIrtEB/aUnjyu99KCZd0/gom2nfNHdsqFeA=;
 b=VRrCchMyvnR5pjdDsm3g5AgYsY48OT7T+nbyurFQLrp2Nd/eSaEVEWu1oweklBE1JRc5nN/iW8nbUh763dp/16nVNo6cFxiXKomn2High9EtunlnD+lijrSWWJ4WK07vK/RiTHEboCGqWTHsOMgnBXKoXASB4iSHRe9Ea7LVvZStkk+pszdN7Wk209m5D6TXD2Y/JQJwHKamzkTFK9XP4jbJExDr7Ige4CcklNItvuGDQ9ARqoofQm8fFZeyxAXrLmEPPMwQfoLYw/1cpuaJAa9rBVyiCGmZpO878S4ORbkZfXQqpCfHTCuvui+z9bbrlp64DWvqgcLw5O/gTHUljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc3O4H72jIrtEB/aUnjyu99KCZd0/gom2nfNHdsqFeA=;
 b=e76p3vXLI0BQur94KPucji1vdawkEocirPxg+7zUdJiFznc3olGBiPh+7+Yii/nOZVHfG/60oRuBeXKgWwbPKThJUYOyW9iCm3I8b3C0EsbbJPh9oUx3kgmR2xEYC33gDkAb+HoZgKL0GOiYsuxQ1x5XWF0sk1p1IftkcjD1/oA=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:24:27 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:24:27 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "jmattson@google.com" <jmattson@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "david@kernel.org" <david@kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "pshier@google.com"
	<pshier@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ricarkol@google.com"
	<ricarkol@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 0/5] KVM: guest_memfd: fix unbind race and NUMA selftests
Thread-Topic: [PATCH 0/5] KVM: guest_memfd: fix unbind race and NUMA selftests
Thread-Index: AQHdMwR0uLzmsdbaZ0CT4S12Nm25Jra33jqA
Date: Mon, 31 Aug 2026 08:24:27 +0000
Message-ID: <b95f21c1cb45673351df50dab208ec8dd3e8ca66.camel@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|DS0PR12MB8043:EE_
x-ms-office365-filtering-correlation-id: 94870aec-7afc-4f99-5f72-08df073945b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|38070700021|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 2sw2ivfqiVNRAyoVpW2r/xuiT1OKEQHtQsTBd7NAU5GvcTFVxFQ2KHYv4c9eW5pLQfoFisrBCtYzEobwlb8YLKL+9CJGaekBkE9JWTGd/8J2N6lP/YlrYwldPCnwngsFF1omLcWUN5FvQCY0g7fQ0P2CX0CX5aR19Guy4RMij/s5wruXfF1nQZcXy089TWeSE+yfhTOBo/36MFim3xVUlsme7eueLhQ3yYxfgjpLLxDnvYBiflSAmwPmI0oEihOV8/A1YHgCkkiE5NKBO7V5aQmh3y5dpfhIM3X19nrGisXrBKF0cW1N91Ekg0TC2qh2BTT8/XPcfn+9v23DeR124/ojXjJvEdgvV5sMjn6bWM8JGmhEAzQLfJt1e4ob5Cd0qm9kOpSdwPBrj36I11DzSVzM6BFj/2oqXgpP+vHf/M2wN6lnvCQqAR2Eq8tU4kEsad4WvhwF48xTJvESGuoC1oInI5/EuZDevEAAteQYNiExa6TiZEzL6QXcFcluWV8pD2XyZEGAk19KdGoRHagi9bG/41CePE6MHSJ0mdyBm16zbMMSX24D2VCroDDVYi56TeTuRMn4C4OmTXr/uMeeLLe1khEa4NMrHUY77Dn5GUJUgbpgtMLrVdR7ZTwhwhK8RHTvwu8Th0rMP98+qtabQujF5PmZFge5WQrAf9N1prPhMRdVUcF1XmZqLiXJnZUtfy184l6mVfYOMizngL0wTKy3Pkp9FP+dYNWzfne0ah0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R29QdEJtMFBsMEoxYm1CY2hoQmFXdWtMRDN6OXI2UUZhK3h4N2ZUOUNhelBK?=
 =?utf-8?B?c0RsNktva3ZIOGRwLzlhdHBkLzgrSUpXbzVVMysxUFFySEg5QjVCSHA4NDBn?=
 =?utf-8?B?bEVUREpERE5HTHlNcldlMVpZZjFyYkNTZDZaV2JSQTRyVHAzZmd0VzNibnNM?=
 =?utf-8?B?NlRiQllMY1dBMmhvRXBDcFBEUzl0cU9TbFZ2MlgxZ0IvMDBEUUc3SFpNWDJj?=
 =?utf-8?B?UDZOdll5NnIzRUkydEgyaTNXMVV1WVd1ZnJaMDNYTDdWWlR2RUp5c3FhUldK?=
 =?utf-8?B?b1V4QXMwREhOdkpEenQ4anEycS9Nem5sVXI1Q3BFbVFhU2RYREFUcFh0RllP?=
 =?utf-8?B?ZG4rVk1CZW5XeTFTa2cvcTNtMXFiQU43WUtIUUdzY1RZQkVIYlRsaWJLQkNE?=
 =?utf-8?B?NnlNRFRwNGVYN2R1OWFZQzNCUVMveDRvVjZBL1ZHQk5rMTUrY0M2b1J0VmtU?=
 =?utf-8?B?V3A4OS81WTlKREd5Z3ZZTGljT3Zwb3U1a3dHMlFkUDZXNzZVTmxvcWVuVHA5?=
 =?utf-8?B?bEY5ajJTYmpuWkZnQVBBUDIyK3htWXJTU211UXZLQVFEN0Z3YWxDeHJjdnlD?=
 =?utf-8?B?QUNNRGlVdEtVaUZld21aMHJIODUxbmFPYUJVRklxN0FjVmxIN3pFclIvTjIw?=
 =?utf-8?B?a29CSVFTOURtNllpY0xnZFA0akx6REFtVXhKNGpCckR4VE9xVEpZVjFZQ3gw?=
 =?utf-8?B?NTZsdHlEZVFPSXJjL1hBSXQvdUtNVzZJcDNJK2I4cktSbXRCcFNTZi8zNG5t?=
 =?utf-8?B?dHJoVCtZVFh5TlJTdnYreXkzRHB4THEwNy91TUFyTGcwdXJZckdPalRZVExG?=
 =?utf-8?B?UkYxOHVKTXN3d2pWQnZtSUZXZmFyMU1MZWk1UVl3YnN6dStvejEybGdsVGs1?=
 =?utf-8?B?ZzMrbEsyNlRtVWtld1d0LzdmK0JZSGFkcWErRitsejVGUXBWVlcyTmZFVUxr?=
 =?utf-8?B?bGh3TDNORVlKT1FLL1pkZW1SZ3Z3aGxTNGF3aW9LY2djMnQxV0JjaDVlVmQv?=
 =?utf-8?B?UU5YUTFPUWpUYVV6R0xsd2E1eUdpMEh2TGp2NERBKzBLUDYwMGdNcTRpNWVk?=
 =?utf-8?B?bzIxT3pNNElHaU1YWVNrcXpNODVrd05mYVpOeWRIQzBWbS9TQ0RxcTRWKzVB?=
 =?utf-8?B?cC90NnErSi94UUh4aXBxODJXMDZMdnZLQW94UmkyRUJoZVNMUjJuWUVqcUhM?=
 =?utf-8?B?MzN3K01JV2ZmUXhPODE5R0ZscUlqTk01Um9iRmVEMmZIM213Y3RiRERYTWhh?=
 =?utf-8?B?dHk3RVphWEF4cTR4MU5SZ3prWDZ1UnBpK1N0V2hFWnh1cm9LNDc2QXQ3SEFk?=
 =?utf-8?B?cEhsTnNsd0tYdFhSNndPdk5sSzhjVTI0bFZHMXBOQTFKNWZDZnBNY0NvVHRQ?=
 =?utf-8?B?d1Z0THdvM3pJNitDa21YOE00RHYyMXJKRW1EWWl1OWJmZExteXdsVlJYTlJw?=
 =?utf-8?B?eS9RdFNxV01HTSs0V1hWbDhtUmUzN3d2M2tidE8yNkZWQUNCc1pyWC9tbGlu?=
 =?utf-8?B?UnBCWlp4WDJwTXEwY3ZUMVh4TWhGUUZJZVZBZG1xNWZTZUl1MGdKamV4MjYr?=
 =?utf-8?B?UkhaRTJZcExEeUFRRVNBNXp0T21VT0U3QTJORmd5aTFKQ0pUbVJlSmxzelRu?=
 =?utf-8?B?U29hTGhXWXdESFhBUXJIOEd4c1NoWHcvRmlRYlk1ekR2dTFUcGRWYlduSjFG?=
 =?utf-8?B?V2tXb09IS3lqcTJsUVVLM0I5OWJtQktNR2FMemhvNzkrT21INGt6Tm9wb1Er?=
 =?utf-8?B?YXdiUUpGckh6VWdOL0hUMkhXT0ZqT2VHYTVubFVoK2xEbnJBMFFsYTNDZEhH?=
 =?utf-8?B?eU54VG9rc1FMbUpPV3Q4ajNncWcxQlJ0TDY3eU9pVS9sMDBxVGFnSU9xSTNT?=
 =?utf-8?B?cjhqSFVwclRNMDVSN0I3T3B5U0M2VGEwVEgvMjFyZURjUkVhYlJYYVdCcURN?=
 =?utf-8?B?MzZGK2hKeHBObTRYc0lwbzVkOFh3Sk5LYjJVNHV2cWQxcUxhMmwzcFl6SXlS?=
 =?utf-8?B?TDRIaWRPNzlMZ2kyZ0VzcjZqTFF0VXFPVGJCWXpnaWR1Vm1YeE1TS2IyTEJl?=
 =?utf-8?B?NWRETVY4VGZ5eTNMWTV2cWExREEzVUhKOTlkdU5Vc09NcmZGN1ljU3hHZ1BF?=
 =?utf-8?B?V2lTQTQ2QXFBZ1ZEQTlVbk1BNWMwOVJ4RnhXN2R3NXJNa3d4bE1TNmdiSGR5?=
 =?utf-8?B?TE5CYjVaQU1YbWFFMndYSlRzNWRTa0NGZVQydFZ5WUlrcFl2MXlGRFgzbmVq?=
 =?utf-8?B?WS9RNk0wRnNKRHNEZzdDdGRtZXNpZzNEWURyWHBEQ3dhRllrQ1pxM0FRQ3M1?=
 =?utf-8?B?RERsT0kydGxFODJRaTd4REFBbHYzNzFHV1V3OWxBZmorNTh3RmFidz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81683F8790E6EC4696D75AD37D989453@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94870aec-7afc-4f99-5f72-08df073945b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 08:24:27.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPZOWxwkqYUhD2bl1WJnQgouh/rrQpW9fG1UBmBqkB/zlqUo9whr/LZVqNtlYunUx2A1aRFP3pvsGhy8lSIsZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDEzOjM2ICswMDAwLCBTaGl2YW5rIEdhcmcgd3JvdGU6DQo+
IFNwbGl0IG91dCB0aGUgZ3Vlc3RfbWVtZmQgZm9saW8gbWlncmF0aW9uIHNlcmllcyBbMV0sIHdo
ZXJlIG1pZ3JhdGlvbiBwYXJ0DQo+IG5lZWRzIG1vcmUgZGlzY3Vzc2lvbi4gVGhlc2UgZml4ZXMs
IHJlcG9ydGVkIGJ5IFNhc2hpa28gYm90IFsyXVszXSwgYXJlDQo+IGluZGVwZW5kZW50IG9mIGl0
IGFuZCBjYW4gYmUgcmV2aWV3ZWQgb24gdGhlaXIgb3duLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI2MDgwNS1zaGl2YW5rLWdtZW0tbWlncmF0ZS12My0wLTAwZDhi
ZGVjNGUxZEBhbWQuY29tIA0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYw
NzI4MDkyMDI3LjIyNUNGMUYwMDBFOUBzbXRwLmtlcm5lbC5vcmcNCj4gWzNdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcyODA5MTk0NS5FQTZDMzFGMDAwRTlAc210cC5rZXJuZWwu
b3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+
DQo+IC0tLQ0KPiBTaGl2YW5rIEdhcmcgKDUpOg0KPiAgICAgICBLVk06IGd1ZXN0X21lbWZkOiB0
YWtlIHRoZSBpbnZhbGlkYXRlIGxvY2sgd2hlbiB1bmJpbmRpbmcgYSBkeWluZyBmaWxlDQo+ICAg
ICAgIEtWTTogc2VsZnRlc3RzOiBmaXggbWF4bm9kZSBhcmd1bWVudHMgaW4geGFwaWNfaXBpX3Rl
c3QNCj4gICAgICAgS1ZNOiBzZWxmdGVzdHM6IHVzZSBCSVRTX1BFUl9UWVBFKCkgZm9yIE5VTUEg
bWFza3MNCj4gICAgICAgS1ZNOiBzZWxmdGVzdHM6IGFkZCBnZXRfbnVtYV9tZW1fbm9kZXMoKQ0K
PiAgICAgICBLVk06IHNlbGZ0ZXN0czogdXNlIGFsbG93ZWQgTlVNQSBub2RlcyBpbiBndWVzdF9t
ZW1mZF90ZXN0DQo+IA0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21lbWZk
X3Rlc3QuYyAgIHwgODYgKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9rdm0vaW5jbHVkZS9udW1haWYuaCAgICAgfCA1MiArKy0tLS0tLS0tLS0tLQ0K
PiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Ni94YXBpY19pcGlfdGVzdC5jIHwgMTQg
KystLQ0KPiAgdmlydC9rdm0vZ3Vlc3RfbWVtZmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMjMgKysrKy0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspLCA5MSBk
ZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiAyNzA5ZGQ1YWUzMmYwODI4ZjM4NjMy
N2M3NmJiYTlmMzlmNjNhMWM2DQo+IGNoYW5nZS1pZDogMjAyNjA4MjItc2hpdmFuay1nbWVtLWZp
eC1zcGxpdC1iOGE5MDU3Y2Y5ODcNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0KSGkgU2VhbiwgUGFv
bG8sDQoNCldvdWxkIHlvdSBjb25zaWRlciBxdWV1aW5nIHRoaXMgZm9yIG5leHQgKDcuNCk/DQoN
ClRoYW5rcywNClNoaXZhbmsNCg==
