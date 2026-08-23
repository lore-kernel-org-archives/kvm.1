Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B5352004;
	Sun, 23 Aug 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494945; cv=fail; b=cP4IPv5cgTWuR39RYNVYU7SizVVmb2Wz3KkZIIZAYu8cAb41sDQ9Ot5YZG9WIW0JVv5ZYbKeNWFFt0mT+GD2wfIPEgdJRWw8Viw5f622KuUD/wwRJM5olbDLwFlXIpHen6jbCNPN3BS2kW9u+VbQkJOMgQKBrQqwI1uSJJXGqOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494945; c=relaxed/simple;
	bh=KfIn7V6tJl8SAn/SZtAVN9hrFFbH/f4gSgdVuauOUVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEx5ZWO6SsF7/BuZuwcgWLEFzS0LBKU03aLPAL7iFOB1WJ+A3LWMm9FNjwyFZYtVUdK5nERBr2gQ2ta3QkIPg8Da0BLJnxj73mr8ruZmLALPvfi6m24iXRhbx9rNARPYXDvnK/isOc65g++5Uy4OO2V76luZn3I+Cd5ScQbn2CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uPhSWAEJ; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uPhSWAEJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIfTmhWekDwnSgls5ib9WTMwfetGdc3q795IkUH3Of1R3eAG7Ykxf1NWvaW/GgA6dg+YGrskrC2UITPLsn0T4kj2PsC+7IgWPLzv8i/trJo2iWNgSX0z505vA4+74M+saRQWLcCwbeoxhTwBccVFUbAf/YAt1Oq91oyQjDrXRChjf1+kqw3KmXOflcl2uZzoH5M39X74RuhdZO0VRUmNT+B2a6qJp5XEVl3xZTCrh5ljM1AV0cYLVlV48yaZEmyeJ+iJwqI8ugsRT7Ktvwq0PIgkR281J+MsJDENTvmqhhP63ZMb02h/UU1pCVVheGntlFgIBRbG5XWx/Dim3oI8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfIn7V6tJl8SAn/SZtAVN9hrFFbH/f4gSgdVuauOUVo=;
 b=iIIVaXsjD0/dMQdSlZPl7dGQIKvVEkgSSxBmTL55j4eSje3YRDTtCpmh42sgkc1G7pVbpCFkEsPn6RCFDWLFPLr+xORpf3/MOIjCTaEdVaAllDszZA7WF3EusPC2Mh51yYnmjlW+yJy61mBG/Sz09E3mLTqECrV3I2ughDsavUdL+J8viPZfGhkqw5mR1JIy1a4C6JtEFlwIibOE6FfMR6vEiBq2orGvQOouP9xHTx8KG1+rVD+ldxOgAwbqCtUUy/sJRwynZngSG4+FsKWOd5AhOrShgSTJywsdgvLZn29QkfUq4FbTnSiZ/kCQl5bBvkb0koIEQo4NIdZu+W197w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfIn7V6tJl8SAn/SZtAVN9hrFFbH/f4gSgdVuauOUVo=;
 b=uPhSWAEJPaax12oWePWfX/A0sBY/YAVWxMttRsUCkfxYoXEbRGGqx2M3d1FffUQMVTJAeqTVViL98jnyohaM1cuh4PrInA5wkyqkWGZMSucVs7/5Ya/JZGQxuXzXFHrJnCAiYw/v0Cs8bJayhMmyFDrY0mOeK5Oyr/d8uKp/WBQ=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:22:17 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 14:22:16 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "jmattson@google.com" <jmattson@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "david@kernel.org" <david@kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "pshier@google.com"
	<pshier@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ricarkol@google.com"
	<ricarkol@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 4/5] KVM: selftests: add get_numa_mem_nodes()
Thread-Topic: [PATCH 4/5] KVM: selftests: add get_numa_mem_nodes()
Thread-Index: AQHdMwSDUVjosOAidEyS3NsPvUEcybarr4uA
Date: Sun, 23 Aug 2026 14:22:16 +0000
Message-ID: <6c48bdfc202a83c5eab0b0c13c91868b0dc368f3.camel@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
	 <20260823-shivank-gmem-fix-split-v1-4-512a29fb8e86@amd.com>
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-4-512a29fb8e86@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|IA1PR12MB8222:EE_
x-ms-office365-filtering-correlation-id: 9561bfc9-8a22-49af-88ca-08df0121ef32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 wFHjuMWxknm1z2mNA+GX8PLq/yuCJyeEOC2zx1xj2yfv0BH8vsqugVV/ZBI57tUbMMjEgvceY/TFP0hUZWAfqMJxqOSWiiCfGuONssBQu0eW249ctnJshkLzX1hDo40iz8OQkallkzEBCe28/8Sdr+xK0Dg7Yn9c46Uznr1eteMdL4JSAjfOMpImLhxTwJVucAO9TToNEnF6qy9x2kceqcdMo7RDshPFbgb/lyx+pupPLSrC/Ly6jQSQgGE/n703L0x57xqVxxttszuTkEIl44j18j2SBZH1uPlQwXxaU6ujxj6CIyPJ/ghVWtG3xtMWPaKrY+yVK+SnN9Y71XVQuVJ/DqSuTQ5bfKZju5xQ6F1MwN2P/YGb5SUDub4Ip+eDsZL74coM3wEUqDEPwrPpXoiUfEHn5sh6WvHaGCKhdQwszBHZ1OUfXfHMO+5N/7qkQQsKHQY2abXt9cQm3Y/ueEN/xPhrfCFfJ0olpKG+XiZexeRop+gKcX+GGbEqIfKroijzslD30HNG8LWRW3eGVtrg8gWGXkH7WirVMFtMiTQBCykFsIE/Ede1ONoRrDiA4XoK1OVbKdCQt+zYgyBajNpDhi+5Cx3mqxAGJAPL5Ug9M78yt9rvSR8GGlhU0DSVpUwMSdJ3tY9WaVLrcGHIgNZs1O3qv4AuPBp3UB8d5nDpFv0LedoGT973fZ9PYNEYZFE1a7L5b62Alrdp0vMpO/JZjK2mrfCa7Y294gpXhaE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzdQbXBUTHZibVZXSXhLVHo0Y2FRTzcwWmRYYW1wL1ZFdnBwZ1J5WVhHMVB5?=
 =?utf-8?B?L3pvNGV0Zm9Xd2E1Y1JaSnFoWDk0ZXI3dDhXMHZZZWJYd3pHdTBvdTFPZDBC?=
 =?utf-8?B?aGh5QWZ0NGpmNk5tb3BsNU91TC9FSWVpRkdUL2ZIRWhZZ0ZyTWRBbCt3MFZO?=
 =?utf-8?B?VEk0L1Q1NTgvOFRMZHpMSWFlUlNlSXVaTDMwRkRZYU5jcEdpS2Q0UWFCWGhF?=
 =?utf-8?B?S3Z4eWpET0xmTDUxejZpTXNUb0k2cFNIbk80SEZtRlRiVFlMY1ZBb0N5cExw?=
 =?utf-8?B?bmNMckNkMWdqcHUvREQ2Z0IxSUtlNk5QMThVd1E4KzlsTXFyeHFxSjcxREcz?=
 =?utf-8?B?dUxuSjZGQ1AySUNpTXc2SDFLVk5QUlU2dkJKWkovdDVxRnFvVkVGcnpRQ1Fp?=
 =?utf-8?B?cGZSWVZWTUhKS2diZGdkMnN2WTZDZUlxQklOd1pmMjlnVjRyYzBXem1hSWRT?=
 =?utf-8?B?bEYrRGlxU1Z0a3ZaSGhLOGx5SS9MdG9nWDI5TldBVlpKV3drTzhqRzVabGdi?=
 =?utf-8?B?KzJSbUlnZ21vTTVKVVJrNHgwQm45dDMzWVNqQ2Q1LzNkQ0NmZnRwVHI4Rlh5?=
 =?utf-8?B?WXo1QmRWYTBoNi9YVDh0T2FSK1ZYcXA3MnMrOGwrNE5xcnBJUnBNeWlpREcw?=
 =?utf-8?B?elJuRTJFOHhXMkFJbUQwb2oyZTd6NGJmRmptSVpJeVlCWFhCaDg3cnpXVzVS?=
 =?utf-8?B?UW94R2ViYlUxZVNzMG5tQXdjYTNYenJoYUliM2kzV1dMNXhLdEZBTVJ0dVd5?=
 =?utf-8?B?REtOcjdSam1naytZM3JqZXNiR1lZVzJxaTI5VmdrUE8rWUE2QW9uSVM1akdm?=
 =?utf-8?B?aUg5ZXJBZXd1THB0RVcxQmhYbGVhcTRuOEk5TFc2eUdqV3hrYVFPODF4SUlS?=
 =?utf-8?B?ZDgzNzNLcG1PK010WnIwK3RTeXg0L0RTaEE1ZWYwZjdtK21rcjA4WUJTampu?=
 =?utf-8?B?TTRBN3h2U0VQWlYvRUJhdnN2YUlHQm45b2YwTmx2OTcvTDA5U1VYRis3VjB0?=
 =?utf-8?B?NHkrYjF5M2NxVVhiSTJlc1d6NmJFLzdRalVJd2JPbktaYzkrYUk4QnpvdDN3?=
 =?utf-8?B?aXhJOFF5RE5YWXRvbnplRDBPMyszRWtJREUrWnZwQVdOM3liSkxzSnQxQnhT?=
 =?utf-8?B?cmh5NHFuL3hTaGhnQ05haDh2VDk1enZYVWxoTnIzTHNBcWlPbzM4T2FpRndV?=
 =?utf-8?B?TFFJMEN0bFcxMklyMTBjeGt5QmVFWUJ4eWdiUElKcjMzUHpwN0NIV0EzRktF?=
 =?utf-8?B?eEJ0Y25kVldLSUhUYnc1dmpvWHpDU0RCNEswejZ0MUlnN3VNL1Y5aE13b2p6?=
 =?utf-8?B?eTJ0NEZsS0RHaDRWUG85bVJYdXUzVWxOSkFtR0ptT2RWUExETnZLd0JKNmcx?=
 =?utf-8?B?V2U5MTI4TjRvcitTUXB0SmhxczdhakVtWVIyNmdpL1VERnFDMkc3M0JHbE1p?=
 =?utf-8?B?TjFKc1B1Y1pNRzNaU3h6SklhZnFqVzlvN0NCWllwLy9OUm1uVVF0djd6YVpP?=
 =?utf-8?B?cVBQaUNUQ044eXBKbThrS3FzVStHVUxCTGZGVVN4RlE2UVIxOEhVN044RGdZ?=
 =?utf-8?B?NStCdHJMVUl2LzFWMFlHaE1IQ21nSThRRTMwdGxQRHI1UFB2SXYra0RDd2VX?=
 =?utf-8?B?MTBCSkcvU1FkQVIxeCtJYlg3WDRxM05KYmNYUDlPSE9UR1ZxeG91L1BCSkFF?=
 =?utf-8?B?Rk1mNzM3YXlUa3FQRndSZ1pNUDZ4UGZTdGYwZVZHOTB1SU1pOXA4NHlpOVRo?=
 =?utf-8?B?ZUpZRS9INENDRWR4Z1pocktDa1JkcjVoZW4wbGxHY25SRjhnVlVIdEd3VFFV?=
 =?utf-8?B?K1hqM05YNGViQzJBbktSTkNXWDkzZVRVZHc2OXExS3FmQ0RRbjZHOVFQaXhM?=
 =?utf-8?B?WC9YYkw2MkFnRVhFMThaLzlNS0toaUtqMHFPUDltcGMweUFaU3h2RHdMT2NJ?=
 =?utf-8?B?aXRYUE81Q3JMNHY1UXM0a3dpUnB4ZzA4Rll1MVd1MnNhZCsxUGFoUnArbTR0?=
 =?utf-8?B?dGRRQUp2S3dVWGl6dXRDbkdrZXhOUjVsVUtGS21OTlllN2xQUStWU0FraWht?=
 =?utf-8?B?UzBySWV3NkNZcjNiSWlhcU9zeFovS3RMdjliTUlSK29RTXB0MHRoOXFUTEI3?=
 =?utf-8?B?OCtpUDIra0NlRGliRGhUdkVRbG04NmJTV2MwaE9yQjN1Sm02MUtVZzlqbHhC?=
 =?utf-8?B?WHgyUnZ5UlBZK1RpUC9HSjkvck0ycktDaktjY2F4d2tZMlFlamJmcVJYd3N2?=
 =?utf-8?B?ZytHNlFWK1VTZnptcEVGOWVQcDYxdi9BanJFUU1tZGpYS3RWL0s3b3FaTGta?=
 =?utf-8?B?eTYxT1lVcVBDUUF6WkhHWGdlNjFHWVlzL2VzN2JKT1FtR0hWRkQ2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04BD91B978345C419AF98C0D38BB9B83@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9561bfc9-8a22-49af-88ca-08df0121ef32
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2026 14:22:16.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajz7l+5Bg99PHAJOoI/QEmKCw1UruxlIR3fmVrc8STAPmAF/GimM9etiYvJIkCaOA5WLCLzqPMQYXMhOzq89bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDEzOjM2ICswMDAwLCBTaGl2YW5rIEdhcmcgd3JvdGU6DQo+
IFRoZSB4QVBJQyBJUEkgdGVzdCB1c2VzIE1QT0xfRl9NRU1TX0FMTE9XRUQgdG8gZ2V0IHRoZSBt
ZW1vcnkgbm9kZXMNCj4gYXZhaWxhYmxlIHRvIHRoZSBjdXJyZW50IHByb2Nlc3MuIE1vdmUgdGhl
IHF1ZXJ5IHRvIG51bWFpZi5oIGFzDQo+IGdldF9udW1hX21lbV9ub2RlcygpIHNvIG90aGVyIEtW
TSBzZWxmdGVzdHMgY2FuIHVzZSBpdC4NCj4gDQo+IENhbGwgZ2V0X21lbXBvbGljeSgpIGRpcmVj
dGx5IGluc3RlYWQgb2YgdXNpbmcgdGhlIGFzc2VydC1vbi1mYWlsdXJlDQo+IGt2bV9nZXRfbWVt
cG9saWN5KCkgd3JhcHBlci4gVGhlIHhBUElDIHRlc3QgYWxyZWFkeSBhc3NlcnRzIGl0cyB0d28N
Cj4gbm9kZSByZXF1aXJlbWVudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoaXZhbmsgR2FyZyA8
c2hpdmFua2dAYW1kLmNvbT4NCj4gLS0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0v
aW5jbHVkZS9udW1haWYuaCAgICAgfCAxMiArKysrKysrKysrKysNCj4gIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3QuYyB8ICA2ICsrLS0tLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9pbmNsdWRlL251bWFpZi5oIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUvbnVtYWlmLmgNCj4gaW5kZXggMjk1NzJh
NmQ3ODljLi41NTEyNGUyMzMwYWIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2t2bS9pbmNsdWRlL251bWFpZi5oDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2t2bS9pbmNsdWRlL251bWFpZi5oDQo+IEBAIC03NSw2ICs3NSwxOCBAQCBzdGF0aWMgYm9vbCBp
c19udW1hX2F2YWlsYWJsZSh2b2lkKQ0KPiAgCQkoZXJybm8gIT0gRU5PU1lTICYmIGVycm5vICE9
IEVQRVJNKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGdldF9u
dW1hX21lbV9ub2Rlcyh2b2lkKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgbm9kZW1hc2sgPSAw
Ow0KPiArDQo+ICsJLyogR2V0IHNldCBvZiBmaXJzdCA2NCBudW1hIG5vZGVzIGF2YWlsYWJsZSAq
Lw0KPiArCWlmIChnZXRfbWVtcG9saWN5KE5VTEwsICZub2RlbWFzaywgQklUU19QRVJfVFlQRShu
b2RlbWFzayksIE5VTEwsDQo+ICsJCQkgIE1QT0xfRl9NRU1TX0FMTE9XRUQpKQ0KPiArCQlyZXR1
cm4gMDsNCj4gKw0KPiArCXJldHVybiBub2RlbWFzazsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
bGluZSBib29sIGlzX211bHRpX251bWFfbm9kZV9zeXN0ZW0odm9pZCkNCj4gIHsNCj4gIAlyZXR1
cm4gaXNfbnVtYV9hdmFpbGFibGUoKSAmJiBnZXRfbWF4X251bWFfbm9kZSgpID49IDE7DQo+IGRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0LmMNCj4g
aW5kZXggNzY5ZDhkOTVhYjJjLi42NmRjZjM2Mzk4YWEgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3QuYw0KPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0LmMNCj4gQEAgLTI1MSw3ICsy
NTEsNyBAQCB2b2lkIGRvX21pZ3JhdGlvbnMoc3RydWN0IHRlc3RfZGF0YV9wYWdlICpkYXRhLCBp
bnQgcnVuX3NlY3MsIGludCBkZWxheV91c2VjcywNCj4gIAkJICAgdTY0ICpwaXBpc19yY3ZkKQ0K
PiAgew0KPiAgCWxvbmcgcGFnZXNfbm90X21vdmVkOw0KPiAtCXVuc2lnbmVkIGxvbmcgbm9kZW1h
c2sgPSAwOw0KPiArCXVuc2lnbmVkIGxvbmcgbm9kZW1hc2s7DQo+ICAJdW5zaWduZWQgbG9uZyBu
b2RlbWFza3NbQklUU19QRVJfVFlQRShub2RlbWFzayldOw0KPiAgCWludCBub2RlcyA9IDA7DQo+
ICAJdGltZV90IHN0YXJ0X3RpbWUsIGxhc3RfdXBkYXRlLCBub3c7DQo+IEBAIC0yNjYsOSArMjY2
LDcgQEAgdm9pZCBkb19taWdyYXRpb25zKHN0cnVjdCB0ZXN0X2RhdGFfcGFnZSAqZGF0YSwgaW50
IHJ1bl9zZWNzLCBpbnQgZGVsYXlfdXNlY3MsDQo+ICAJZnByaW50ZihzdGRlcnIsICJDYWxsaW5n
IG1pZ3JhdGVfcGFnZXMgZXZlcnkgJWQgbWljcm9zZWNvbmRzXG4iLA0KPiAgCQlkZWxheV91c2Vj
cyk7DQo+ICANCj4gLQkvKiBHZXQgc2V0IG9mIGZpcnN0IDY0IG51bWEgbm9kZXMgYXZhaWxhYmxl
ICovDQo+IC0Ja3ZtX2dldF9tZW1wb2xpY3koTlVMTCwgJm5vZGVtYXNrLCBCSVRTX1BFUl9UWVBF
KG5vZGVtYXNrKSwNCj4gLQkJCSAgMCwgTVBPTF9GX01FTVNfQUxMT1dFRCk7DQo+ICsJbm9kZW1h
c2sgPSBnZXRfbnVtYV9tZW1fbm9kZXMoKTsNCj4gIA0KPiAgCWZwcmludGYoc3RkZXJyLCAiTnVt
YSBub2RlcyBmb3VuZCBhbW9uZ3N0IGZpcnN0ICVsdSBwb3NzaWJsZSBub2RlcyAiDQo+ICAJCSIo
ZWFjaCAxLWJpdCBpbmRpY2F0ZXMgbm9kZSBpcyBwcmVzZW50KTogJSNseFxuIiwNCj4gDQoNCg0K
RnJvbSBmZDExOGI0OGUwNDZjODdkOWI2NDViNGNlN2ZjNGFjNWMwNjU2NDMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU2hpdmFuayBHYXJnIDxzaGl2YW5rZ0BhbWQuY29tPg0KRGF0
ZTogU3VuLCAyMyBBdWcgMjAyNiAxNDoxMTo0MiArMDAwMA0KU3ViamVjdDogW1BBVENIXSBGaXgg
cG90ZW50aWFsIGNvbXBpbGF0aW9uIGlzc3Vlcw0KDQpTYXNoaWtvIHJlcG9ydGVkIHRoYXQgbnVt
YWlmLmggZG9lcyBub3QgaW5jbHVkZSBoZWFkZXIgdGhhdCBkZWZpbmVzDQpCSVRTX1BFUl9UWVBF
LiBJZiBhIHRlc3QgaW5jbHVkZXMgbnVtYWlmLmggd2l0aG91dCBwcmV2aW91c2x5IGluY2x1ZGlu
Zw0KdGhlIGhlYWRlciBkZWZpbmluZyB0aGlzIG1hY3JvLCBpdCBtaWdodCBmYWlsIHRvIGNvbXBp
bGUgZHVlIHRvIGEgbWlzc2luZw0KZGVmaW5pdGlvbiwgYnJlYWtpbmcgaGVhZGVyIHNlbGYtY29u
dGFpbm1lbnQuDQoNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI2MDgyMzEz
NDgwMC41OTZDNTFGMDAwRTlAc210cC5rZXJuZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBTaGl2YW5r
IEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+DQotLS0NCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9r
dm0vaW5jbHVkZS9udW1haWYuaCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUvbnVt
YWlmLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vaW5jbHVkZS9udW1haWYuaA0KaW5k
ZXggNGJiYmYzMTRlOWQ3Li5iODk1NTliNmVhM2MgMTAwNjQ0DQotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9rdm0vaW5jbHVkZS9udW1haWYuaA0KKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3ZtL2luY2x1ZGUvbnVtYWlmLmgNCkBAIC00LDYgKzQsNyBAQA0KICNpZm5kZWYgU0VM
RlRFU1RfS1ZNX05VTUFJRl9IDQogI2RlZmluZSBTRUxGVEVTVF9LVk1fTlVNQUlGX0gNCiANCisj
aW5jbHVkZSA8bGludXgvYml0cy5oPg0KICNpbmNsdWRlIDxsaW51eC9tZW1wb2xpY3kuaD4NCiAN
CiAjaW5jbHVkZSAia3ZtX3N5c2NhbGxzLmgiDQotLSANCjIuNDMuMA0KDQo=
