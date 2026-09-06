Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFC5477E;
	Sun,  6 Sep 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717668; cv=fail; b=t4Z+xvcFN7Di85+UopGT93VQ6munUAaj3Ho3ltZHvIpO5nxQN5ci1Jo+9N3zIFaXHr5bmsyYYHRdGzW/ZyM5Wxbhp3qENpqk0kCcl247R5ytoIS8NJ7319VralQdRpXFshG5vTec5KsKkvfrO1fcB7+nWOBNXBUWOcsYLthwEEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717668; c=relaxed/simple;
	bh=M19uokE4S8JnKaZZLH/k2j3gzXjtbSsf40IZouacPM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qEJj3WMdAopWRIfn59PFOuTiVIXR0FNe8Gq3dpFcUmyRAO2ygnUjSNz+C87iH9L363lJe4PmdGnFnXST00O7HMtMfeb2Jx2xGMXS5hFG1kvxw4lhUFwO9JFSNTu+sxs5Q2mVZIAb8U/zfN2vr4qB/Y/IbjeFrhIgaeN9IYl45Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I5PY+86Y; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I5PY+86Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcMadbWY2g0hBF1GoLDY8UwqCBHrboriQGU8SyfVFyMVu3g8lw9MsFWLhIshR5Ej2irGQUb/X5mwFUAzkodgUcF0AtFJIa6hpdMlzSTJY9YNfXs+Isqx5fdLKTPYTbezL5LetAmg7mbGaV/nXb4fJjeaL9EnYjwlIAnVZtcMl4CTp9gqNt/y5+kPggT5xwEuzcPeS78MFAqFimZnfJ/4cY9SwsK/C2dKdZGDzz1guVKUL92GRiT5C9K5oY5maRLJQgdacF6hnXOe0+RhxRKk0xohFSyVlCeb9LrSljCiakxrNL6ysJvMbtt9NJz58raPrkFpRQYLWUjJ45FgW8Ny6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M19uokE4S8JnKaZZLH/k2j3gzXjtbSsf40IZouacPM4=;
 b=VmjzLoSCJsbSIvcrq1rt+AbMv3dJ8UR9LQ08F0Zhmk8XrUKCZ/m9pfdFUY7lWGcwXR3lBxgrOFwQHjRjSgVQx6FT5WGEEWkUJ2hqBzdBMzKg9tBw5OcDClotS30TNUFobf06pWQeR/naBMPP8S7CSivK3NFuHjHO3fPFdGtKhp44Gzct3/WErmROSM6WpoXvg8n8KmtHqvZiPe6KCXFXdjrXDf8dwh+8KGkgOmsgFQGIjL46N/xihyJJjavpAtEz6vtBWXf2HEpkLcmfLA+F98eH/DptObxFHswLL42GvWYI6EufrSU8BcfofjFdwvKGWhsd/05svlfsNLpZldngAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M19uokE4S8JnKaZZLH/k2j3gzXjtbSsf40IZouacPM4=;
 b=I5PY+86YCSAc4DVgT8Kow5AWFw+UBya6PNNlgMiT2kUG+1QG/y+cv8HUWi7pSVBGH+5E917oXO1/ThYIQvc4PhpZsGO7tx/WQ4aK6b8Aai+mu/sAx5R87i+BbQECr2lEy1W6skx6x5RIPAiW3CNzL8Qkdp2yPhFG23SZP1z8EOI=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 18:01:01 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 18:01:01 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] KVM: selftests: Automatically run xAPIC IPI migration
 test when possible
Thread-Topic: [PATCH 6/7] KVM: selftests: Automatically run xAPIC IPI
 migration test when possible
Thread-Index: AQHdOzl+RYYZlwVsFUiwIRgVH1K4bLbB3OSA
Date: Sun, 6 Sep 2026 18:01:01 +0000
Message-ID: <1f4005631738e2f118956f53dac1997b68ad999a.camel@amd.com>
References: <20260903001625.2792367-1-seanjc@google.com>
	 <20260903001625.2792367-7-seanjc@google.com>
In-Reply-To: <20260903001625.2792367-7-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|CY8PR12MB7659:EE_
x-ms-office365-filtering-correlation-id: c92144e3-3728-4224-9ac1-08df0c40cfb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 PYivEv+PMEwrvNCMniicT0NjFOix2sJgfTW/jizGvBkTZwV/hrX+USKoMQSFlRc8u2J+fg/K6mME8m7oAb2GCC5Rs/FSRHRgw5EvcwlBxqhLkZVh3XqPVp1qjS2kxOJOwDFvtBiaVxZ9cX4Xa/n9HPw/URU5OWSmmhR2Gq866x19ld1QjNAFjVwnfAKATxBDh57I0FeiY+yJUUzZ1gEiBvpMs3fTw3hmw+/UuWtgva9fZzS9hXk3QGokWpGKzPYAkeBdlRZRw8sgxax1n+uOW4et6UUXkvPAaYanff0f/G9pizrWPEMQA91RUlH8dPy3PjKVuEcGbYYSIbwQtoUeJQc/vI5rrus/BuvL7j5nNQNu9+qYxK/vqX6knOS9rpsx/K4nX1EieEWHhTTllj+y/Iti2s9IeA83HCql3jfRpX8Fg2ou7fdLJCpUqUr2jFs0kSLMUQr7wBChkjcJYgYn3wLHBxH20QrpMlHMO7UOyk6YSP1RSgDcMSd+FKkhEmd57/En9xPwzhPmcEi2ZdI3FVyLfhJjfvh5mUA9xV68PiEt4fbGVuU5sHE5l4B+6qGrZmPjh4X82M1UHYlOa+CbWcWh9fifUCgfianzNiFH4U3cj9o/q4yEl9zb+q5FHnPYP4k4QHtEYbcUQOCRI4e0syw1q40gahRbSciAZ055rR5H2/HQcbpFQl7Fh4pJNrjL01q54khcTcnmisuDl1OpGV1qvk/ZshydyVulzeaSOg0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXVYU2M0czV3VmFNblZaallqUkVXTFNIWHNoSUZ3U0t3TUlHNzYvRmFFSzRT?=
 =?utf-8?B?WEUwUk5nVVBhbWtpbS9UTklielVLbTlmMXhEWUVldi82Q1g5M0NsQnlKTEEw?=
 =?utf-8?B?dWdrQktWczFaYkNzV3BkSjdFa0Z4WUI1QXg5cmRjWDFGa0hpWWlMbkQzbWFz?=
 =?utf-8?B?RnhJa2ZvK2U2dzRQS0tQY2FXMU92OXZRbkVSL2pKdnEyMktmakhraUhLRVU5?=
 =?utf-8?B?OSszTjBmN2FDWit5UEhRTDVWT2RCY1NNdjJ4Rm9handyVDF1Nm5naXZFWUth?=
 =?utf-8?B?dWZVaCsxN2JZN0l0cThZN1diK0dRSmFOTWp0bkhkdDdGQ05DSmVnRFlqSE4x?=
 =?utf-8?B?cW80WnByZUlNUVdZT3d6b2NzNUF1b2lxVis4Y1lwY3MvWERnditndmVBMnQ0?=
 =?utf-8?B?ekoyMExWUjI0Z1p2b1dIMDdpUlI3NEtBZUpleStndjhsTDhCdm1aNGlqamlO?=
 =?utf-8?B?VkZ2Zm01V0t3OVNjYmMwVUNvaGIwdXFybjBkaFFKVTEycE1RVlhSaXl0WW5U?=
 =?utf-8?B?bzBLTWxxcFRjUmVuZ2dTUUxDVnA0QmZLdHdXTk5oY1dhQ3psYlNWcWdNSklo?=
 =?utf-8?B?MmlLR2toRmkwdlBSVWUrTG55bEtHZG92djhJeVB2eDc0U2dwNk54b3NJVUJ4?=
 =?utf-8?B?M0FVN1A1NDBoU2tDYzR5S0ppR2lXRzN2Y3RuLzd4bFNsTndkcHpxQjJxYkRJ?=
 =?utf-8?B?QXVES3F4UEtsbUJ0aHYzTGR5V3VXb29JMVNxWlJ6SHd4cjZ0QnhNeGhFV0g4?=
 =?utf-8?B?ZWRTNm56Wi8vWjhpVU1kQXFPcThLVDZrOEpORGhDMHhyS1pIN0lMeGt3UnFz?=
 =?utf-8?B?RjBzY1kxdnhUU3hNTHJ1bm1SMVI1dHdpVGVzb01WbkVvb25QZUJzZEp3NURB?=
 =?utf-8?B?ZXFObEZEeXRudTcvUEZVcytYNDFLVTJCWnZBenB6eXVhK3A5VzBjanRlbDhm?=
 =?utf-8?B?VS9FV2ljWlJYWVI1OXFDeUhXajMrUU5TcmFOcTNOMVBmemozcmNSaG05ZnNm?=
 =?utf-8?B?dFRhbCtVTXlYKzk2QXo4QXhWbnNBbWg2dXIwUnNLRVNEdk1IRDZMaEgwM3BF?=
 =?utf-8?B?cjl2ek4wR1lrZlNHdTJqZWh0M25RRVJvQlZjdXR2Q2RZVExRbjdnaStDUjE2?=
 =?utf-8?B?azdBS2NpY1d6OGxkeGdvS2lsb1Y5UXNCUkZpbHRGU09DbGZhSno5VGRtSXlM?=
 =?utf-8?B?cSt2Nk9LUjczQmZ3VlhrbjVUSzlRSEF5dVdhdkN6d051VGg2d3l4ZE40TFZK?=
 =?utf-8?B?cVBjVXFVMExpKzcybjMxRzR3Q1NiY0xkeUZ1YUhibFNtVnhxZXIyUHcyMk9k?=
 =?utf-8?B?bmZ2bk1TMWNFUEw3c3ZoZEU1dzBDRDlSRkdqM2RkK2pxT2hLb2p4andKUnFS?=
 =?utf-8?B?K1ZvY1J2Q2h2TkZUWmZFZmRrTGRYTEVGK0VVZ1ptNVlCYzUrcWU0eUJvczBD?=
 =?utf-8?B?bW9Vb1EvTml5dnNtRzVXZ0hsNWxEdkdQNGxWbUFYZzRZNlJzaEF6TXU0WE5y?=
 =?utf-8?B?SC9VWVdaZWdodlVwSGk3SURyMlpOWG1OY0tRRVROMkhGVUFrZVJNNjJMczl5?=
 =?utf-8?B?TlRQWUZVK2lFMmZXa0Jnb0p6cnlRdFgxeCtQd2p5Y2FGZlltWkZMbTBGaHZl?=
 =?utf-8?B?WWpHM21oV2ZCS3Zyb0U4cUJOYWVPNmE5eEhrNG9RMlV4NGdMbkFSMUpkUjdz?=
 =?utf-8?B?VWNpN2wyQVNHMllsNDRSa2IxMjJuMWE1aEM4bjg1bGVJQTc4Y2xMNFJrR1Mx?=
 =?utf-8?B?ODZEV2RGQVFEeHdxdFhLemVIMWR6L2pLdFNsZG9VRHgzNGFxL0k2MWhuVnhY?=
 =?utf-8?B?YkFISnhDdkpuWEU4S0EzM041cDEwM2Y3UW5OMEw4WG1xZW1RbkcvTFg3Nzha?=
 =?utf-8?B?ZjVFeXJUdHRjRTJBb3NWdU5weE9qQnR0M2ROb1dKQ1cxemZjS3RMbWJoMFZU?=
 =?utf-8?B?VjJRd0ZhVmY0eEJOb20yNCtVM05BMTFsdjI1SzZTTmN1ZnE3Rzd5bmJ3SWdL?=
 =?utf-8?B?K3UwcXQ5NmFqbVVzQ3UybjhGTXpXamlEVGpXYUtkUWxJZ3BYVEVTOHpTNkJn?=
 =?utf-8?B?emhObGxPeXVvbFhnQWlFR0xlR1Z2MENIUVNuTWpmcjM0NDZId0hQQWtDMDVH?=
 =?utf-8?B?T3NjVWxvSHJmM3VlRm9PL0RQTlR3bkY1NStoYmFFRzFRZ0NWclZVVGt0M2NP?=
 =?utf-8?B?c01CQmFkRmV6bmJ4eGtDbHdWVzZhYUtabStCVHI0aEtvazgxNFB6Z0VkQXJt?=
 =?utf-8?B?LzVjcFdsWlprSEpIYm9HZWtTdmo0bU1ZSWIzanVtMFFleGpaUkszVnNObk5E?=
 =?utf-8?B?QlduUVV3UVMvN0ZzWUx4Q1hXcVJiT3RRaVF4MlBJdURRN21MQ0FZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C62F5D08642353498142385109916FCC@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c92144e3-3728-4224-9ac1-08df0c40cfb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 18:01:01.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrzbu+x3bLT+LZdNTEYRJZupv8jQiLi2v6AqGNdXOly4yMkFxZDqqp8QU9RqDULiYi1pXpcx+j/HG4C4LG8aJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE3OjE2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZXdvcmsgdGhlIGludGVyZmFjZSB0byB0aGUgeEFQSUMgSVBJIHRlc3QgdG8gYXV0
b21hdGljYWxseSBydW4gdGhlDQo+IG1pZ3JhdGlvbiB0ZXN0Y2FzZSBpZiBhdCBsZWFzdCB0d28g
TlVNQSBub2RlcyBhcmUgZm91bmQuICBUaGUgdGVzdCBleGlzdHMNCj4gc3BlY2lmaWNhbGx5IHRv
IHZhbGlkYXRlIEtWTSdzIGhhbmRsaW5nIG9mIG1pZ3JhdGlvbiBvZiB0aGUgQVBJQyBiYWNraW5n
DQo+IHBhZ2UsIGkuZS4gZm9yY2luZyBlbmQgdXNlcnMgdG8gb3B0LWluIHRvIHJ1bm5pbmcgdGhl
IHRlc3QgaW4gbWlncmF0aW9uDQo+IG1vZGUgbGFyZ2VseSBkZWZlYXRzIHRoZSBwdXJwb3NlIG9m
IHRoZSB0ZXN0Lg0KPiANCj4gUnVuIGJvdGggdGhlICJzbGVlcGluZyIgYW5kICJtaWdyYXRpb24i
IHRlc3RjYXNlcyBieSBkZWZhdWx0LCBlLmcuIHNvIHRoYXQNCj4gdGhlIG1vcmUgYmFzaWMgdGVz
dGNhc2Ugd2lsbCBmYWlsIGlmIEtWTSBjb21wbGV0ZWx5IGJyZWFrcyBJUEkgZGVsaXZlcnkuDQo+
IA0KPiBLZWVwIHRoZSAtbSAvIG1pZ3JhdGlvbiBwYXJhbWV0ZXIgc28gdGhhdCBpbmZyYXN0cnVj
dHVyZSB0aGF0IHdhbnRzIHRvDQo+IHNwZWNpZmljYWxseSB0ZXN0IHRoZSBtaWdyYXRpb24gY2Fz
ZSBjYW4gZG8gc28gYW5kIG5vdCBnZXQgZmFsc2UgcGFzc2VzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgLi4u
L3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0LmMgICAgICAgIHwgNDAgKysrKysrKysr
KysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94
ODYveGFwaWNfaXBpX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFw
aWNfaXBpX3Rlc3QuYw0KPiBpbmRleCA0MmM2MDE2MTdmNWEuLmM1YjUwNmViNWU3ZiAxMDA2NDQN
Cj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Ni94YXBpY19pcGlfdGVzdC5j
DQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3Qu
Yw0KPiBAQCAtMjQ1LDE0ICsyNDUsMTMgQEAgdm9pZCBkb19taWdyYXRpb25zKHN0cnVjdCB0ZXN0
X2RhdGFfcGFnZSAqZGF0YSwgaW50IHJ1bl9zZWNzLCBpbnQgZGVsYXlfdXNlY3MsDQo+ICAJCWRl
bGF5X3VzZWNzKTsNCj4gIA0KPiAgCW5vZGVzID0ga3ZtX2dldF9udW1hX21lbW9yeV9ub2Rlcygm
bm9kZW1hc2spOw0KPiArCVRFU1RfQVNTRVJUKG5vZGVzID4gMSwNCj4gKwkJICAgICJOVU1BIG5v
ZGVzIGRpc2FwcGVhcmVkPyAgbm9kZW1hc2sgPSAweCVseCIsIG5vZGVtYXNrKTsNCj4gIA0KPiAg
CWZwcmludGYoc3RkZXJyLCAiTnVtYSBub2RlcyBmb3VuZCBhbW9uZ3N0IGZpcnN0ICVsdSBwb3Nz
aWJsZSBub2RlcyAiDQo+ICAJCSIoZWFjaCAxLWJpdCBpbmRpY2F0ZXMgbm9kZSBpcyBwcmVzZW50
KTogJSNseFxuIiwNCj4gIAkJQklUU19QRVJfVFlQRShub2RlbWFzayksIG5vZGVtYXNrKTsNCj4g
IA0KPiAtCVRFU1RfQVNTRVJUKG5vZGVzID4gMSwNCj4gLQkJICAgICJEaWQgbm90IGZpbmQgYXQg
bGVhc3QgMiBudW1hIG5vZGVzLiBDYW4ndCBkbyBtaWdyYXRpb24iKTsNCj4gLQ0KPiAgCWZwcmlu
dGYoc3RkZXJyLCAiTWlncmF0aW5nIGFtb25nc3QgJWQgbm9kZXMgZm91bmRcbiIsIG5vZGVzKTsN
Cj4gIA0KPiAgCWZyb20gPSBrdm1fZ2V0X25leHRfbnVtYV9ub2RlKG5vZGVtYXNrLCAtMSk7DQo+
IEBAIC0zNTEsMjYgKzM1MCwxNyBAQCB2b2lkIGdldF9jbWRsaW5lX2FyZ3MoaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSwgaW50ICpydW5fc2VjcywNCj4gIAl9DQo+ICB9DQo+ICANCj4gLWludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICtzdGF0aWMgdm9pZCB0ZXN0X3hhcGljX2lwaShp
bnQgcnVuX3NlY3MsIGludCBkZWxheV91c2VjcywgYm9vbCBtaWdyYXRlKQ0KPiAgew0KPiAgCWlu
dCB3YWl0X3NlY3M7DQo+ICAJY29uc3QgaW50IG1heF9oYWx0ZXJfd2FpdCA9IDEwOw0KPiAtCWlu
dCBydW5fc2VjcyA9IDA7DQo+IC0JaW50IGRlbGF5X3VzZWNzID0gMDsNCj4gIAlzdHJ1Y3QgdGVz
dF9kYXRhX3BhZ2UgKmRhdGE7DQo+ICAJZ3ZhX3QgdGVzdF9kYXRhX3BhZ2VfZ3ZhOw0KPiAtCWJv
b2wgbWlncmF0ZSA9IGZhbHNlOw0KPiAgCXB0aHJlYWRfdCB0aHJlYWRzWzJdOw0KPiAgCXN0cnVj
dCB0aHJlYWRfcGFyYW1zIHBhcmFtc1syXTsNCj4gIAlzdHJ1Y3Qga3ZtX3ZtICp2bTsNCj4gIAl1
NjQgKnBpcGlzX3JjdmQ7DQo+ICANCj4gLQlnZXRfY21kbGluZV9hcmdzKGFyZ2MsIGFyZ3YsICZy
dW5fc2VjcywgJm1pZ3JhdGUsICZkZWxheV91c2Vjcyk7DQo+IC0JaWYgKHJ1bl9zZWNzIDw9IDAp
DQo+IC0JCXJ1bl9zZWNzID0gREVGQVVMVF9SVU5fU0VDUzsNCj4gLQlpZiAoZGVsYXlfdXNlY3Mg
PD0gMCkNCj4gLQkJZGVsYXlfdXNlY3MgPSBERUZBVUxUX0RFTEFZX1VTRUNTOw0KPiAtDQo+ICAJ
dm0gPSB2bV9jcmVhdGVfd2l0aF9vbmVfdmNwdSgmcGFyYW1zWzBdLnZjcHUsIGhhbHRlcl9ndWVz
dF9jb2RlKTsNCj4gIA0KPiAgCXZtX2luc3RhbGxfZXhjZXB0aW9uX2hhbmRsZXIodm0sIElQSV9W
RUNUT1IsIGd1ZXN0X2lwaV9oYW5kbGVyKTsNCj4gQEAgLTQ1OCw1ICs0NDgsMjkgQEAgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gIA0KPiAgCWt2bV92bV9mcmVlKHZtKTsNCj4g
IA0KPiArfQ0KPiArDQo+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiArew0K
PiArCWJvb2wgZm9yY2VfbWlncmF0ZSA9IGZhbHNlOw0KPiArCXVuc2lnbmVkIGxvbmcgbm9kZW1h
c2s7DQo+ICsJaW50IHJ1bl9zZWNzID0gMDsNCj4gKwlpbnQgZGVsYXlfdXNlY3MgPSAwOw0KPiAr
DQo+ICsJZ2V0X2NtZGxpbmVfYXJncyhhcmdjLCBhcmd2LCAmcnVuX3NlY3MsICZmb3JjZV9taWdy
YXRlLCAmZGVsYXlfdXNlY3MpOw0KPiArCWlmIChydW5fc2VjcyA8PSAwKQ0KPiArCQlydW5fc2Vj
cyA9IERFRkFVTFRfUlVOX1NFQ1M7DQo+ICsJaWYgKGRlbGF5X3VzZWNzIDw9IDApDQo+ICsJCWRl
bGF5X3VzZWNzID0gREVGQVVMVF9ERUxBWV9VU0VDUzsNCj4gKw0KPiArCWlmICghZm9yY2VfbWln
cmF0ZSkNCj4gKwkJdGVzdF94YXBpY19pcGkocnVuX3NlY3MsIGRlbGF5X3VzZWNzLCBmYWxzZSk7
DQo+ICsNCj4gKwlpZiAoa3ZtX2dldF9udW1hX21lbW9yeV9ub2Rlcygmbm9kZW1hc2spID4gMSkN
Cj4gKwkJdGVzdF94YXBpY19pcGkocnVuX3NlY3MsIGRlbGF5X3VzZWNzLCB0cnVlKTsNCj4gKwll
bHNlDQo+ICsJCVRFU1RfQVNTRVJUKCFmb3JjZV9taWdyYXRlLA0KPiArCQkJICAgICJEaWQgbm90
IGZpbmQgYXQgbGVhc3QgMiBudW1hIG5vZGVzLiBDYW4ndCBkbyBtaWdyYXRpb24iKTsNCj4gKw0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KDQoNClJldmlld2VkLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZh
bmtnQGFtZC5jb20+DQoNClRoYW5rcywNClNoaXZhbmsNCg==
