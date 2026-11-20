Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795191245;
	b=w2iacII6LEjxXn48z6oevYFvPyEDpWUEvk10h6Grep5+HDp5BbN5c2iGJSpWWg+ZyFiA
	 UTkMNSfVyN1JnrtxmPHlQSNe7cQqqaRkBEDQV9SMXTVRpmFDa3M8MeoqWxDgeW9ptsk+m
	 dgHiE/PLJZQA4ciJaG41RKTAoyxZI4zlTv3AEovLssXDsiG0hqcmeXVx/pFZsG/t3+zIx
	 2arN6JByHTvfuei99S85fx0fWVM5o/HF9x1awqcjOcreReRghEBUk3behWA3z4urgoz0R
	 Td/pJWu4UDiJqy4SUkM7vMwo1ZWk4iyDG1K3AEquEbNFYGLE8sZiUqiTta/U2v1XrKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191245;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KcGayBWYNUKCvfCoRL5+iNU94ZwMf8PMtIkadocU0FU=;
	b=MMHxM6fe7h4Cvm6d1DtJ0/mlv1KNKYPKPq0G3DhKX1LL4aF99l0PfK4IXG2vqwlZJNO3
	 f5viVcAhObVfSyR1JkfX8p7Gvz8DzQ5Oun4HZYMzW+Y4sfAF87MXi4IpUQH//XJjSLmII
	 lCNWbdyb1z8K1pMWPr9XtwSUPa/0cB4Bx85suRCf2v65GKtJZaIKIgFxkKAsJHfgqnKtW
	 UL+yd8g7u2vALe+zOaGcTz5PiC6k/9DyVaR81HIJpzbFJf3rO++HePp7P3jcUfOrzr+nB
	 5zIef4mPEvSd07bZ+kuSJvsUJDAqXHi/PaG8D+W+Jyy3Jw4C74/5SSSheLt7q46mb2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OpXJxnQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.46
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE864606A336;
	Fri, 20 Nov 2026 16:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE864606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OpXJxnQw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsbX84wQz6OQnk8Qn1q9jPvh18ppNeHc+B2qNy/oIbL3hDNcZ+2JUZ+VwavCvVWSB2zf9v9zYNt0cmfjZzmuhaB/ofhNhnVdy52LPpw1lrT6oPZJfnKmYhDHHPzFUw12XpAIyTAkQqjyr3K0e44j2rv/ihl8dV2OwHOvNphKHEwDksib7IN3mZ/sz1YffTMXb/YR7IhBMUQQg/tWsHW4oetk4Y2daAPdkcZG9AyVQwTTdV8vFpEgPykUJ3jUj740QCgLZZLUVX5Pmb6EaAfGh+M9LiU9BkthSs/oixZmc5iUwMnM8g7kDZO4+raxUmtrCeH9oKg9l7c/Wg+ykekPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcGayBWYNUKCvfCoRL5+iNU94ZwMf8PMtIkadocU0FU=;
 b=fZwWUoKngYerCbNGznjRRk6HIcHUxyvKyZjnvxmH0ocmFfiUeYgVCBqIDjudJKCscWUbjqLXBqIOMTfthSgOOp+vkT6q2w81OKRnDnXCDIBsNfywgio3LMgW+mJZu9MpZ2VYyO4RLC62M9UOr6mEvNbegQ88icld9TK36lu+TgJ7PK5LehuG0HdzgiRhWsluOjCK5ImKpYO6a8k6tUWXi44nTJNMAJ4Ja9UG2oZFhwh1YDQ/6h08mp+kj1kCN6nvDA0HO/5cWOFuZz7k6Rdt0LDVrZsOOsNIV6Wcj4ThnEs49uVMfNoB4piuos8nfDNl0d10h2px8IjCOQ2zqJWrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcGayBWYNUKCvfCoRL5+iNU94ZwMf8PMtIkadocU0FU=;
 b=OpXJxnQwYIadD8HW/tnQu8WqrsM/rvvCfL3ajbkueZmZk41G2bxlP1jaGNXKtioFHogQNvbU62tDOv8k+FA4+0v28eUd2gAAwDcZSkRT8Q1PlXlq7iK8E1IwSPpSLO4BJJBm/Cloo5oqPug3hVofFhKACzzt0R+fvOT51IvrB3k=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:14:00 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 16:14:00 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "jmattson@google.com" <jmattson@google.com>, "fuad.tabba@linux.dev"
	<fuad.tabba@linux.dev>, "david@kernel.org" <david@kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "pshier@google.com"
	<pshier@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ricarkol@google.com"
	<ricarkol@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"steven.price@arm.com" <steven.price@arm.com>
Subject: Re: [PATCH RESEND v3 0/4] KVM: guest_memfd: fix NUMA selftests
Thread-Topic: [PATCH RESEND v3 0/4] KVM: guest_memfd: fix NUMA selftests
Thread-Index: AQHdeOJV88KJL33YsU+Kiq+/0JRljbc2/7sAgAAiywA=
Date: Fri, 20 Nov 2026 16:13:59 +0000
Message-ID: <c0cc9c1de5c676402304f9610f8552bb4510ce49.camel@amd.com>
References: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
	 <awBUlv3ItZiyZvlS@seanjc-mac.roam.internal>
In-Reply-To: <awBUlv3ItZiyZvlS@seanjc-mac.roam.internal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|IA0PR12MB7507:EE_
x-ms-office365-filtering-correlation-id: cdef229f-0061-491f-3c94-08df47214968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261102123227099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 /kgX+WEG0bOmRg7YDALj9bOBiuglb6imOKaFtAFX5alII5qrsPRAqrT0KLYG/LskpeMnsUSNxLI2joL3uVxVcoyTPzTxurpxxMU7BpFP5b6Nte6Kirv/r2YTLIOHkMBlTM3W+UaG8p19X2r7Q9VHHDk2Lm97a9ifBA9vT8nQbO97s6qjFS/Fi/NrN/HGZdKiSp48fyh5QTC74TEApOZ4lv7PLQnScEu7YHwUYImhRYuWzYSvEPDpgEwNFJncCN+BfqhIj+enLxPhjBqhfROkY2t4pFmqm3bMNizJrqadjW0vnyUUoGPzUGCjeAeMX4kpF6LEtWZD5dC/ZI/zHARY7L6Y6DCsju3ORX/OVN5TpyztG/NH66nWm/DNrqhV3uSbCSjYC6Pp+xtpvUpzXBdBahyYgTGw+SaClHxaIp6Zx+vRS8JJ2CzqksobjyLoJm7DQi6EDBnJGpfvBWbpfh3++Cvv04QGkFv6YdmZQza8eWMLL0QzV8XCU5fQ5UYpHxsxuX7Q34M7Dp5Db4DV3FpDp+uN+uIgQ7JpaaWKBPt6fIcGe6yw6KbyBs+ka8OXUJtZu9qT51xT5Chqdr7PWgyeLGVMIXlTMto3F6ViCqGIO1SdSGkUsx4gDcWZPNosfKlFsH7dRaw5nOXWqprR6l0hZL5J3OtA5kQwh5YG0g/40seIQqQfnEjLtPcsGI7DyiiMWijNS85vJTszoZKtRIDp/IzvK23AV823KBTkBJyEehQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261102123227099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUl6NFpzYmRTL0RmSHF0L0c5UU9peUx3ei9yOUhyNGorem9IZEJMNjVQV2tx?=
 =?utf-8?B?R0wvTjRmRk11eTVqdXF2MlMwQ3k4OURKSnVxMG1FQXpXOHo0cnVLYzBvOExz?=
 =?utf-8?B?OTZubThwTlhwN3MyMWEyakFJRUpBQXlZSUpWbWtPajNZY2wzZlh0WHVuM0Vs?=
 =?utf-8?B?WFBUMEQ3YlRHbkZOa0hPa3l2ZmdZWkhldiswVEdpZmRoTEpzRkpmM2t3dUhY?=
 =?utf-8?B?MC9sekRCR2ZwK2tZdGpiRUVUd3FkWEMzZ2NFeHYzaFN6TU9kbGdKcVcrcWts?=
 =?utf-8?B?L0FWZmY4bDJ0ZXA0VjlJM3dSekF1SHFPYXpueUZvYit4YVZ6dWJNODVGc1pV?=
 =?utf-8?B?K2lWT2V4ak5rQnhrZHFQWVRZT0pvdzY4ZEtwUHBPNEk3cnBSaWNaOVpMMnBz?=
 =?utf-8?B?N2xqanlQckpIK2dEbm80c0lua2ZNQW1ZaWI0ZkxkTWpVRTFNZk9FZVpVK2h3?=
 =?utf-8?B?MUFPRlZVcncyU2dMT0xrV2hIejFPbkNvSzk4OXBxQlNGYlNlVThKTkI3Slhn?=
 =?utf-8?B?QkgvUmd0bXFaLzQrQXdDdGxQcU5jTloyZ0Fjc2pYbFpHbktkd3RNSEEvQ1lY?=
 =?utf-8?B?OUFuam1JRndVUDFMNHlxOFNyNUlrSGNqV3JTSWZhWmI2WUhMZEN1YmRqcElH?=
 =?utf-8?B?TlhKNXJndzdtblBSZzRHQTR1Rjl1ZysyMU0wQXVSWElpTVRzSEpmYkFteDBV?=
 =?utf-8?B?NTV3aU5yZDNXRHZvdjA3bk8wb1JDNkxSWkZvaWZ0bWpqMVcyVWlablJGTllv?=
 =?utf-8?B?L2V4VFF2cUxENUI4T2xtVmljS2FkRHN5cy9EeUo4bjJXQlc2WGNaV1FUZjVm?=
 =?utf-8?B?RVJySzNSeFJRRXlhRndmT0Q1OTI5cGFOWGFXZC9oZndqTmNzbGRFMHYxU3FE?=
 =?utf-8?B?VDBzNW8rNTN0Ny82N04vbmpGNmY3RE1PNUdZV2N5WTlIVXAwRW52UnpPdmJs?=
 =?utf-8?B?Mmp3alphK093WWFVREljSmJ2RUVqMmN0cit3RjNZL1M1TXRrcmdyTWV4SmdG?=
 =?utf-8?B?TVMzTmk0UDg1RnlhcWZxRmdXallibXdsaTZRaENJWEc0VVhwSGlVM2NUVUds?=
 =?utf-8?B?bG1sd3MxVkxjTEwyNGcyOWppWEgwMitRVnJBZnVzYUhVWFJ3ZUtQRlBWNkwr?=
 =?utf-8?B?S011NHprcm5ZNHh2V2xYcThCQ2xRWmM3OE5BUmNqQVZWeXM4Vmo0aVJhbFJH?=
 =?utf-8?B?NDhwdE9qWnUyZWxvN0Q3YktMS0krelVZbkVhdGZSQ3lheHlNY0ExSFlzZEhT?=
 =?utf-8?B?cnZSeHJLaUlkdmhmKzhYMFpTdzlWYXMvZjBmRXVqd21tUHV1NnRFZ3RTSEY0?=
 =?utf-8?B?UTlaMVBNOW5YNVY1ODQ1bXBxZFFhWjdDWEtqL2NHcWtnSmx5Szd6dEtBWGoy?=
 =?utf-8?B?NndjdXhQbUV2UlJXWHJidVVlalFSZzFwQjVxcldWSzc1UVNKR2VjbFg2ZWNV?=
 =?utf-8?B?TjFvZ0d5L3l3M1lHdmc1Ti84K0tMaDVNZEZGRGsrcmtFYUxxVmh1dVA2dExW?=
 =?utf-8?B?MDJoZFVVdCsvMlluVjVnN1cxRUwvUVFPcmRjSTNrV2p5WEdINWl5YlN0ZkVk?=
 =?utf-8?B?LzJjUVY4Tm5BVDk1VEExK3E5TXRHVWlUWTQxQlJ5RVZ6dWF1T2M5c2dWT0hh?=
 =?utf-8?B?UUxnYWJRekE2ZkRBQm1NTE1DVXZ5dlkrWjhjV1g1U1cyYmhnRmsyVURHZkRE?=
 =?utf-8?B?V0NPODdsNGRnejJia2lpcXpNTVAyZFFKSXlLelQ3YVdUYVRMTTNOQ2tRTjRN?=
 =?utf-8?B?ak9sc013V3VPYkRqY1ZNNUs2SVpydFlMa3I1NmlZSjJPMmJTejhwUTdYd2s4?=
 =?utf-8?B?ZjdVdWkxSlc0ZW1BU2VQQUp0ZDNaT3V3bG1SVWwyV1BlakQ4eVVYcThTRmNs?=
 =?utf-8?B?QkJBS0dpbFBuOCtEWjJUcVZaZ3IxS3FwNkxVMmNHV0JRMDNIMFVJV3RrNnBN?=
 =?utf-8?B?QXBQc3ZPSXpoTXdveU9oTktKTzFzTnhKVzg3VDIrWnFEeVBEUElxSmJWcnJx?=
 =?utf-8?B?bWpZbWtacld5bVRzdllWTVdhcjJGOG9IRDRYRDFWUjJXZ0NzWm1aWHRvQ1U1?=
 =?utf-8?B?WVBkSU9rMkJBVkRHRUV1c1NMSlVkSGZudXVXS21GajNKZHBUcGx6ZlNMS0I0?=
 =?utf-8?B?em5zZEp2S3d0ajhQSUd3T0FRN3V0cDFlcDBNbmhJUkZZU1k2UXVrYzBYblk2?=
 =?utf-8?B?QVhiNlB6YWFSd3hhL3RiNWlWWDV0N0Qzdlh2dGVONmtzemxrNU5uNEtPcFNm?=
 =?utf-8?B?SlhYVUsyT2cySU5IREJNSnNNRnh4TmJGL29TcXFJdWx5Nmt2K1pJekxVQnRK?=
 =?utf-8?B?SDNwYWdlVGkzMzFiRllzMnM0UlV6VU9KZU13d0dKdWhwZnNHTmF4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC333156211F54B9865C8D609CA8445@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdef229f-0061-491f-3c94-08df47214968
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 16:14:00.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxGOuYK7M68Fo2cAcBvoL2aokStjYO9i2qWCOQ2utElGexi2iiHxlapwfzHLz8URVXibBtzDJRh14UYhxMRn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

T24gRnJpLCAyMDI2LTExLTIwIGF0IDA2OjA5IC0wODAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBGcmksIE5vdiAyMCwgMjAyNiwgU2hpdmFuayBHYXJnIHdyb3RlOg0KPiA+IE5V
TUEgc2VsZnRlc3RzIGluIGd1ZXN0X21lbWZkX3Rlc3QgYXNzdW1lcyB0aGF0IG5vZGUgMCBhbmQg
MSBleGlzdCBhbmQNCj4gPiBoYXZlIG1lbW9yeS4gSG93ZXZlciwgbm9kZXMgY2FuIGJlIHNwYXJz
ZSBvciBtZW1vcnlsZXNzIHdoaWNoIHdvdWxkDQo+ID4gYnJlYWsgdGhpcyBzZWxmdGVzdC4gIFNl
bGVjdCB0aGUgbm9kZXMgZnJvbSBNUE9MX0ZfTUVNU19BTExPV0VEIGluc3RlYWQuDQo+ID4gDQo+
ID4gQmFzZWQgb24ga3ZtLXg4Ni9uZXh0Lg0KPiA+IA0KPiA+IFRlc3RlZCBvbiBiYXJlIG1ldGFs
IGFuZCBpbiBRRU1VLiBXaXRob3V0IHRoaXMgc2VyaWVzLCB0aGUgdGVzdCBmYWlscw0KPiA+IHdp
dGggRUlOVkFMIHdoZW4gbm9kZSAwIG9yIG5vZGUgMSBpcyBub3QgYW4gYWxsb3dlZCBtZW1vcnkg
bm9kZS4gV2l0aCBpdCwNCj4gPiB0aGUgdGVzdCBwYXNzZXMgZm9yIGFueSBzZXQgb2YgYWxsb3dl
ZCBOVU1BIG5vZGVzLg0KPiA+IA0KPiA+IFJFU0VORDoNCj4gPiAtIFJlYmFzZSBvbiBrdm0teDg2
L25leHQuIE5vIGNvZGUgY2hhbmdlcy4NCj4gDQo+IElmIHRoZXJlIGFyZSBubyBjb2RlIGNoYW5n
ZXMsIHRoZW4gdGhlcmUncyBubyBuZWVkIHRvIHJlYmFzZS4gIFBsZWFzZSB1c2UNCj4gUkVTRU5E
IGlmIGFuZCBvbmx5IGlmIHlvdSBhcmUgc2VuZGluZyB0aGUgKmV4YWN0KiBzYW1lIHBhdGNoZXMv
ZW1haWxzLCBlLmcuDQo+IGJlY2F1c2UgeW91IG1pc3NlZCBhIFRvOiBvciBDYzosIG9yIGEgbWFp
bCBnb3QgZHJvcHBlZCBieSB5b3VyIHNlcnZlciwgZXRjLg0KPiANCj4gSWYgeW91IHdhbnQgdG8g
cGluZyBhIHBhdGNoL3NlcmllcywganVzdCBwaW5nLiAgdjMgaXMgc2l0dGluZyBpbiBteSBUT0RP
IGZvbGRlcg0KPiBhbmQgYXBwbGllcyBjbGVhbmx5LCBpLmUuIHRoZXJlIHdhcyBubyBuZWVkIHRv
IHNlbmQgdGhlIGVudGlyZSBzZXJpZXMgYWdhaW4uDQoNCg0KR290IGl0LCBzb3JyeSBmb3IgdGhl
IG5vaXNlLg0KSSBkaWQgbm90IGtub3cgYWJvdXQgdGhpcyBhbmQgd2lsbCBrZWVwIGl0IGluIG1p
bmQgZm9yIG5leHQgdGltZS4NCg0KVGhhbmtzLA0KU2hpdmFuaw0K
