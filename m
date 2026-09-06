Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE584192EF;
	Sun,  6 Sep 2026 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689340; cv=fail; b=dVIHTOQZlgMWEGiAUg+ylOmN5BSCrB/KnGULDtcbpGPzskOb7lZiyOaccd+oCeLjVCoM0uz6mPfdGJ+REpEPhKj8J72iB3a6pC7QR0nWF28fzbgDvK1SuyGYyoCvqLZLMaAHziB0azaNYF+VilfQCg/0Y/jbbFfm/cg8CVouX4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689340; c=relaxed/simple;
	bh=Y2cw9QY0bgAgtB4X6FtDXOtPQFYaSQwcqAk7lSAJLwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BNMlm8h88GEEcl/rOCGZzB9zJ91Uoy4YA/4fH6/E1oWpv4AjqR6O1lTioP3tm9XDlEtSVpk95BeAOHfJl4jyIa6HD+j3gEuLc8ImiLD/O5Xyp+JfRMkFLJ8ex13Tyo2Bh8QuFM1AWu2j7JOG/khvnAtPMIuqMZIQXMioNWhXZZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdSDpgkU; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdSDpgkU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr3KaizI0dyKIp+iqNlsnxJnPRpC9vYhN88CaJ42FRNY7XdeflXpar3BMMLkblcZVrZtrzgGhCEHR+4l/r++IWloOzQM0ePQMHSNym1p7YYn94NTr5zHRWsbdmr0yZYobiEFy5e9ELj7dFE4Pli10Uj5Xx40npun3ELA5utixOjGNrl/EvGJJw9Dn7ctwfLBWr2J1DWpqd0ZrQkCZMpWrlwrsqdMgfe68FMz0PPSzt4Kq0JTZ+PXmRFGm/jLj5JRiIpZArvymcZKpEGQc0ca83rNEze9K06w0wxWL/2Nh5p4KQDUgruHuJ5WXTbiAWrhNPGmXdtG7TBFJ8/qmKBypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2cw9QY0bgAgtB4X6FtDXOtPQFYaSQwcqAk7lSAJLwQ=;
 b=qt0GrgZuTl3m9Rqb5DYBv2Puk0ZVId+sCJRThT66FZpv2axNorHmdAHzDIVvbXlR1xRYmAEXml11ozWTBWZxLCAW6629x5CoQqLtdJp38Ry4UQ/UndiXm07tmxDaOIPgnMtOZyRggxSZ9kjwFsxs40gBnNX2oDs97nXAdgoB7vROUVR3A0CXaYZm4Z3kAZv5XrjZ5S9i3/zofOZ2l5FJDgm8X8//WolwMfMm32e1pCWbwh5zyna6zEkJTz64HZOQY/4qg+OEYWKcIoyMvqOfP6Y+cApYJdE4Kdu8TiwhyykmD1LmBHE2lwBDYRPkKvzjEqjxMXm8dGzRR89SS/cpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2cw9QY0bgAgtB4X6FtDXOtPQFYaSQwcqAk7lSAJLwQ=;
 b=sdSDpgkUkLhrp231gVyx4/UbMXac1Y8YdJCOfkUH748E3eJXqbcpoglUyMRvYy2vtF79gJuv/mAiSJKoBwWlXHow9fSCvbfr+AIf3OM5CYG+732zEvHDmUZSh6VyY2elyNzondEy01vtBBp9SDjEwWDsSJMMC6mnATaOP91A8HM=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 10:08:46 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 10:08:46 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: selftests: Account for kernel's off-by-one bug
 in NUMA node syscalls
Thread-Topic: [PATCH 1/7] KVM: selftests: Account for kernel's off-by-one bug
 in NUMA node syscalls
Thread-Index: AQHdOzl8v38lyKQdQ0Woh8ThvOJjsrbBWPGA
Date: Sun, 6 Sep 2026 10:08:45 +0000
Message-ID: <ef6ef8be43d667f9cce9780b3c54e397ee31fe3b.camel@amd.com>
References: <20260903001625.2792367-1-seanjc@google.com>
	 <20260903001625.2792367-2-seanjc@google.com>
In-Reply-To: <20260903001625.2792367-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|PH7PR12MB5950:EE_
x-ms-office365-filtering-correlation-id: 5e85581b-2d55-4d2d-90d0-08df0bfed653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 R/G99Tzmwu27eFLHsak+hxUlOEUkuigmftThYGkulf1EsAB7/xxsiQBLKIgo5yt+sFb3QTT0ohRFwXT7Wezss2mBhQXlxVouVwgTMNwMX9agfN3/aoDG4G5XZ895uy6qhN6c4iRuVcWVztLLuI9i8/ChW3Rushvd+/fvfkp/pdP8eDWSLNYnFiEfBHtpkpHpXRYoq0KS8xNv00ky3deAx739OTphHrXEUCM/El4dt/gWaZ0UMyOFdBnJWpcIRDVrEWFT3Rn/mVmtu8T3ssOHugy5HMOaiSVc2VgUPPpCx0Ad62Rz4g4qsk4ajqJc30te8fOGWeI/tDdp1ERDdD30Zy+Ebm59OJxBWt17RjdYmKRZTmseVwmJApaaf44YDZdRweXf9mUmtSCmG4ROdhtE8xS2X/vZRxZKSXm0ikQs8iYBfXKmHk2QzSNttnYBVrs+KopitfJmnv8GINiwOyy15Gigfmdxx9HsEjUh4ILLM3X58Qyb/DE/gvDs4UVroAg7272W55JWhJBOJ3hgENAMX+Yw34Do04kgaWeUhaFy8gykasFdWKg7Zo8no86Os4H0xVon5dPRo/hSgtJG3EN1SSB+mZZKejfE+1wlFT7qvF/xxMs+NhE/kDQzJvPtZSPBDlq310xiMT1lSLoKeWdxwnlHx+DuGURM2Hr23sAsfdzn4ap92Luq7toYSvYLnEYuwf3Fik2YWy4OzhyYnvREtA4nV26vtAZLt3BAE8R/FFM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjdLWlZ0S2ZjdTlnRmZXbEpmR3UwaVpFR3pHUC9OMjJTR0pXVlIvMDc1SEN6?=
 =?utf-8?B?N2dYOUgyUURlZXlUb3R3ZHlrOGNUUkg2QWo1QlEvNVE5UUNoNVhaKzBSNER1?=
 =?utf-8?B?bFU2STlNbE14N0pSd2dKaU50VzZyVm5XMjBpSTM0Z081MlNJVklBb00yQ1Zr?=
 =?utf-8?B?Skh2T0psTTRmM1VmNFAyeGJGTjRhOER3ZS8zcGczYjFQRERzZWZkZnZmQzNJ?=
 =?utf-8?B?WWhBMTJqdHRnTUNuOTJPMVZlR2x5MXF2UmVXNmtjRlhQUk1nWGVmM25KbGc2?=
 =?utf-8?B?TTNzMm1MQ3QrWlJiYndEVWRZb1JETC9SdWF4QnlyMGw5aWNVa0syRWJ5Tzlu?=
 =?utf-8?B?Ull6M3ZIakVUR3pLZjZNcTlwcHZkRnQ5YWkxQzdxNGgyNHZlMkJuS0JjUkxu?=
 =?utf-8?B?enQ2K1hlUnQvSXc3Vk1VckVOTzFDaklrdWY1RXNMYWhLdlZNVm41UVUrMG9H?=
 =?utf-8?B?c29meXA5OGRCYkhFL042UnlUZ1ovRmg0L3UrNnBlZW8wWmZvbEtsZ3dXUlR1?=
 =?utf-8?B?bUJhSndmTWtVYmY3dDIydVZLK3g2V3paaENqdU1qanVidlFRZXBHMUZUek1B?=
 =?utf-8?B?WDFOQkRwQjQ4K0VtUjJIS2lOMEQ2TkFxUFp6Nk85S2hDZ0QyakJkTm5EeVo3?=
 =?utf-8?B?TVFJbUxYNTVEWENtRlZ3a1pLMVkyRUZCOGJ6UTNvSzBHSmVwZ3c2d3d1a0lB?=
 =?utf-8?B?aWtTTm5WeXNOODl2OE8ySXFVVnA0YmdUMTZHY1BFVG1hbXRsQ3pYVHhRMlFM?=
 =?utf-8?B?SVczb1RKLzEyVWpGWXZDYUx2MHdIOFpTUWt1cjVJYTB0SWxtS2d5WjFUNC93?=
 =?utf-8?B?VHZPWGRlZ0JCaUhsWGl5a0hhVVRvY1VvVzAvK0NPSzFxeGdabThZeTliS1Mw?=
 =?utf-8?B?THh5QWhMeE95TStRcFM1MHR5UDFOakRIZ2NnRXlhMTNod0llSmZzOFdYaEsr?=
 =?utf-8?B?Nm45RmVDeXlkZWd0STZidS9Yc2ZscU51dTlDWFlOU3RCZU5nUkpxUUNMYktw?=
 =?utf-8?B?blQxN1NzbUlVcmliNzBVMkNhMHBpb3B1QlRjZk5LQ1RoZHNKVlZSK1NJV0xS?=
 =?utf-8?B?bzAvYVh2aUFVUW5oTzdZNGluMzVzdVhwVUFBblNhM1FLL2JLZFR0OHF4bEFX?=
 =?utf-8?B?NmljRHV4VUFDWnRVcWh1MktuSGxTYUhaS2FqMWVjQmVUODkvbzJwYjliak5y?=
 =?utf-8?B?RkRNTHBsN0d1YWlkR1NQbzhFbHlsNHowaWVtT3JoMHR0c0lTTzNXZmF3YXZI?=
 =?utf-8?B?aHZ2ekp2QnRRVUhKTkYvU0lzeHFXclVlUkJVeFRBbWthOW1TTjVlYXh3NzVW?=
 =?utf-8?B?cG1kMjNkS3FyR0Nmam92SDVnWG5LaVZXbmFUeU9RNFlZeW5mVVBPc28zN1lM?=
 =?utf-8?B?amZvNHkwalIyL1o5aUtCM2UwR3J0TGdKNWVBdkRqcnluV3l6OFplTVdlanNO?=
 =?utf-8?B?dHl2eVhtaHZtbjk4Y0p1L3E4WVVsdDYyTm95UjY2R1FDMVBncGJ1TDZOeEFl?=
 =?utf-8?B?WHVCc1VJYWJ5a3NVTGpXZmJjVVVhZzc1bENGZHd5dGI2RkxaWlo0dXA4SEwx?=
 =?utf-8?B?OTF0MHI2alpqSHA4S2trbDFBdzB1NCttRHh3NUhkRCtEdCtMcktRRkVRTk9U?=
 =?utf-8?B?RnlSU3lEY1lCZEdIakg5S1RRd2RqZy8yK09ZYXJ0QytKbU9hTWp5ZUxUN0Zq?=
 =?utf-8?B?TjVkajhzM1hib1VvQW5Ybk9lY0VMREg2NGZiOC9XUS9va2dPZDBkMWFtUEV3?=
 =?utf-8?B?Y1lqK0d6YnhHVTdjeFFQT1FuaDREZFhwaThFRlZnZ0V0NEV4Ykx3YkNKemVu?=
 =?utf-8?B?eEZGay9rTG5tWjJ0QmI5WUVwTGYvMzhMUnRHRUhVWm1XY1pnU2wxcmNNeUJG?=
 =?utf-8?B?OG9nMXRheVlZOW80NTNqSTRqbG5JdEtQaGhpOEowd3c0MmtmMS9pZVd1NnVx?=
 =?utf-8?B?Z0Ftenl4V3BNRWhtMFo4aVI4L3E5dEZDNloramtTTGQvbmdWb1FiWFMzWGh1?=
 =?utf-8?B?bGRXQ0V1Y3JhdHY1Qk0zMUVwdTZrRzg0ZzI3UEdIaFlEWVBack5iWEVLTGZV?=
 =?utf-8?B?T1BCNzdMaVRWckpVTElENDk5Q0daWG5mWG9OU1kvOW81ZDhQM2s5Qm1XMURK?=
 =?utf-8?B?WHgwQ2NLMWZCV29xZ3NQSXZ0cCsxNEFyWXJtQi90NXRxNmJKT0cvSldqV0sw?=
 =?utf-8?B?TkJFcXV6L2hNZlhXYUZRQWMzODBhMEkrdHJVZEN6OEY3NHd0Q215L21lQjRa?=
 =?utf-8?B?SjRCcW5YS2JPQXRucm5CaW81WkhUTkNXSDdLbUFWMVpBNjZxTHhKQnBDb1VQ?=
 =?utf-8?B?ZmpGUVl5KzBZZGV0RzBqRGNyNGwxUWh0NzM1YzhMWk9Xam1ZUk5Ndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <326B1F85DC83BF4AA67959ED1E3F5D85@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e85581b-2d55-4d2d-90d0-08df0bfed653
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 10:08:45.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7ibfxd8EuVwg31+p4y08GZrLf5/Kh5ArSVvuH6Q0lcTaD2B8ynn5E83FMMu1PIHLBdKfa5ZWNzKi52D3gxHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE3OjE2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBZGQgYW5kIHVzZSBNQVhOT0RFX0ZPUl9NQVNLKCkgdG8gY29tcHV0ZSB0aGUgImNv
cnJlY3QiIG1heG5vZGUgdmFsdWUgdGhhdA0KPiBpcyBwYXNzZWQgdG8gdmFyaW91cyBOVU1BLXJl
bGF0ZWQgc3lzY2FsbHMsIGUuZy4gZ2V0X21lbXBvbGljeSgpLCBtYmluZCgpLA0KPiBtaWdyYXRl
X3BhZ2VzKCksIGV0Yy4gIEluIHF1b3RlcywgYmVjYXVzZSB0aGUga2VybmVsIGhhcyBhbiB1bmRv
Y3VtZW50ZWQsDQo+IGxvbmdzdGFuZGluZyBvZmYtYnktb25lIGJ1ZyB0aGF0IHJlcXVpcmVzIHVz
ZXJzcGFjZSB0byBzcGVjaWZ5IHRoZSBudW1iZXINCj4gb2YgYml0cyBwbHVzIG9uZSwgaS5lLiB0
aGUgbWF4IG5vZGUgcGx1cyB0d28uDQo+IA0KPiBUaGUga2VybmVsIGJ1ZyBoYXMgYmVlbiBrbm93
biBzaW5jZSAyMDA3WypdOg0KPiANCj4gIDogQW5kIHRoaXMgaXMgSSB0aGluayB0aGUgcmVhc29u
IHdoeSB3ZSBjYW4ndCBjaGFuZ2UgdGhpcyBub3cuIEkgYXNzdW1lDQo+ICA6IG51bWFjdGwgYWxs
b2NhdGVzIDEwMjQgYml0cyAoMCB0byAxMDIzKSBhbmQgcGFzc2VzIDEwMjUgdG8gbWFrZSBzdXJl
IGFsbA0KPiAgOiAxMDI0IGJpdHMgYXJlIHByb2Nlc3NlZC4gSWYgd2UgY2hhbmdlIGl0IG5vdywg
a2VybmVsIHdpbGwgcHJvY2VzcyAxMDI1DQo+ICA6IGJpdHMgKDAgdG8gMTAyNCkgYW5kIG92ZXJm
bG93IHRoZSBhbGxvY2F0ZWQgYml0bWFzay4gSWYgaXQgaGFwcGVucyB0byBiZQ0KPiAgOiBhdCB0
aGUgYm9yZGVyIG9mIG1tYXBlZCB2bWEsIGl0J3MgYSBzZWdmYXVsdC4uLg0KPiANCj4gQnV0IHVu
Zm9ydHVuYXRlbHkgdGhlIG1hbnBhZ2VzIGhhdmVuJ3QgeWV0IGJlZW4gdXBkYXRlZCwgZS5nLg0K
PiANCj4gIDogVGhlIG1heG5vZGUgYXJndW1lbnQgaXMgdGhlIG1heGltdW0gbm9kZSBudW1iZXIg
aW4gdGhlIGJpdCBtYXNrIHBsdXMgb25lDQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvNjNjY2M4OTAtZmQ1Ny0xMThiLTU5OTctZTAyNTlmNTA3ZDI4QHN1c2UuY3pbKl0N
Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+
DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21lbWZkX3Rlc3Qu
YyAgIHwgIDIgKy0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9pbmNsdWRlL251bWFp
Zi5oICAgICB8IDExICsrKysrKysrKysrDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0v
eDg2L3hhcGljX2lwaV90ZXN0LmMgfCAgMiArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2t2bS9ndWVzdF9tZW1mZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9rdm0vZ3Vlc3RfbWVtZmRfdGVzdC5jDQo+IGluZGV4IDIyMzNkODcxYTM4Zi4uY2Q1ZGY4
OGJjNjQyIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vZ3Vlc3Rf
bWVtZmRfdGVzdC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9ndWVzdF9t
ZW1mZF90ZXN0LmMNCj4gQEAgLTgwLDcgKzgwLDcgQEAgc3RhdGljIHZvaWQgdGVzdF9tYmluZChp
bnQgZmQsIHNpemVfdCB0b3RhbF9zaXplKQ0KPiAgew0KPiAgCWNvbnN0IHVuc2lnbmVkIGxvbmcg
bm9kZW1hc2tfMCA9IDE7IC8qIG5pZDogMCAqLw0KPiAgCXVuc2lnbmVkIGxvbmcgbm9kZW1hc2sg
PSAwOw0KPiAtCXVuc2lnbmVkIGxvbmcgbWF4bm9kZSA9IEJJVFNfUEVSX1RZUEUobm9kZW1hc2sp
Ow0KPiArCXVuc2lnbmVkIGxvbmcgbWF4bm9kZSA9IE1BWE5PREVfRk9SX01BU0sobm9kZW1hc2sp
Ow0KPiAgCWludCBwb2xpY3k7DQo+ICAJY2hhciAqbWVtOw0KPiAgCWludCByZXQ7DQo+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vaW5jbHVkZS9udW1haWYuaCBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9pbmNsdWRlL251bWFpZi5oDQo+IGluZGV4IDI5NTcy
YTZkNzg5Yy4uNzFmMjYxZWFmYzkwIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9rdm0vaW5jbHVkZS9udW1haWYuaA0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rdm0vaW5jbHVkZS9udW1haWYuaA0KPiBAQCAtNiw2ICs2LDcgQEANCj4gIA0KPiAgI2luY2x1
ZGUgPGRpcmVudC5oPg0KPiAgDQo+ICsjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvbWVtcG9saWN5Lmg+DQo+ICANCj4gICNpbmNsdWRlICJrdm1fc3lzY2FsbHMu
aCINCj4gQEAgLTMwLDYgKzMxLDE2IEBAIEtWTV9TWVNDQUxMX0RFRklORShtYmluZCwgNiwgdm9p
ZCAqLCBhZGRyLCB1bnNpZ25lZCBsb25nLCBzaXplLCBpbnQsIG1vZGUsDQo+ICAJCSAgIGNvbnN0
IHVuc2lnbmVkIGxvbmcgKiwgbm9kZW1hc2ssIHVuc2lnbmVkIGxvbmcsIG1heG5vZGUsDQo+ICAJ
CSAgIHVuc2lnbmVkIGludCwgZmxhZ3MpOw0KPiAgDQo+ICsvKg0KPiArICogQ2FsY3VsYXRlIHRo
ZSBAbWF4bm9kZSBwYXJhbSBmb3IgdGhlIGFib3ZlIHN5c2NhbGxzIGdpdmVuIHRoZSBtYXNrIHRo
YXQgd2lsbA0KPiArICogYmUgcGFzc2VkIHRvIHRoZSBrZXJuZWwsIHRvIGFjY291bnQgZm9yIGEg
bG9uZ3N0YW5kaW5nIG9mZi1ieS1vbmUgYnVnIGluIHRoZQ0KPiArICoga2VybmVsIHRoYXQgaXNu
J3QgcHJvcGVybHkgZG9jdW1lbnRlZCBpbiB0aGUgbWFucGFnZXMuICBUaGUgbWFucGFnZXMgc2F5
DQo+ICsgKiB0aGF0IEBtYXhub2RlIGlzICJ0aGUgbWF4aW11bSBub2RlIElEIHBsdXMgb25lIiwg
YnV0IHRoZSBrZXJuZWwncyBhY3R1YWwNCj4gKyAqIGJlaGF2aW9yIGlzICJ0aGUgbnVtYmVyIG9m
IGJpdHMgaW4gdGhlIG1hc2sgcGx1cyBvbmUiLCBpLmUuICJ0aGUgbWF4aW11bQ0KPiArICogbm9k
ZSBJRCBwbHVzIHR3byIuDQo+ICsgKi8NCj4gKyNkZWZpbmUgTUFYTk9ERV9GT1JfTUFTSyhtYXNr
KSAoQklUU19QRVJfVFlQRShtYXNrKSArIDEpDQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUgaW50IGdl
dF9tYXhfbnVtYV9ub2RlKHZvaWQpDQo+ICB7DQo+ICAJc3RydWN0IGRpcmVudCAqZGU7DQo+IGRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0LmMNCj4g
aW5kZXggNDY5ZTNhYjE2NDYwLi4xZGRjZjk1ZDdmZTQgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3QuYw0KPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0LmMNCj4gQEAgLTI0OCw3ICsy
NDgsNyBAQCB2b2lkIGRvX21pZ3JhdGlvbnMoc3RydWN0IHRlc3RfZGF0YV9wYWdlICpkYXRhLCBp
bnQgcnVuX3NlY3MsIGludCBkZWxheV91c2VjcywNCj4gIAkJZGVsYXlfdXNlY3MpOw0KPiAgDQo+
ICAJLyogR2V0IHNldCBvZiBmaXJzdCA2NCBudW1hIG5vZGVzIGF2YWlsYWJsZSAqLw0KPiAtCWt2
bV9nZXRfbWVtcG9saWN5KE5VTEwsICZub2RlbWFzaywgc2l6ZW9mKG5vZGVtYXNrKSAqIDgsDQo+
ICsJa3ZtX2dldF9tZW1wb2xpY3koTlVMTCwgJm5vZGVtYXNrLCBNQVhOT0RFX0ZPUl9NQVNLKG5v
ZGVtYXNrKSwNCj4gIAkJCSAgMCwgTVBPTF9GX01FTVNfQUxMT1dFRCk7DQo+ICANCj4gIAlmcHJp
bnRmKHN0ZGVyciwgIk51bWEgbm9kZXMgZm91bmQgYW1vbmdzdCBmaXJzdCAlbHUgcG9zc2libGUg
bm9kZXMgIg0KDQpMR1RNIQ0KDQpSZXZpZXdlZC1ieTogU2hpdmFuayBHYXJnIDxzaGl2YW5rZ0Bh
bWQuY29tPg0KDQoNClRoYW5rcywNClNoaXZhbmsNCg==
