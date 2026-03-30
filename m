Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1F34405B;
	Mon, 30 Mar 2026 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837692; cv=fail; b=MUk5ncDAZNavKKcaCYM0xpSSQloDVqgW9qrcQM8wBB0Trppabkj5/k6nLFHG79SNOAVO52rhdX6oE17ZE5YGuJeVwCFoBu6Yu9Y0FIQY+jMq2XgGV8d4vAivdef0wSqJMIAbxh5w2t04EwoplDWn0x2ApXYM14/pAhDJGGmlNmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837692; c=relaxed/simple;
	bh=7cU92yDEWBXsK+1K4NNN4+NWV8MsBO+21jmUCkrIPrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NWpvyzd8og/vVsEfWxMC2CHFICpP3vBzQi5uGeH8r2EizyFJSypKX4ijpD4juraEJKeB4syvL8OolcjNVrgFVZ9MkLMRWwDkXhd/im1dKX2jlR3lTYI/aHHVHjRVvTgkcqCoEfWT/NLMWuT4BZtrUYQffQDJnMNwEQEHKsYy+z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Dn6R4NOu; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kwbrCObF; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Dn6R4NOu";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kwbrCObF"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TMlIme2536723;
	Sun, 29 Mar 2026 19:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=7cU92yDEWBXsK+1K4NNN4+NWV8MsBO+21jmUCkrIP
	rI=; b=Dn6R4NOuYmNXq+ydFlzWjhokADnn39spGYUpu1reeHlRX6x7lG9Vjyidi
	4BLNJzOVBoA5Bf0htyNiqLYGQ1JqNrWqh2kzpsb20tEYnQrBBE2UfLOrSO4oxi0d
	qm2IIEdbh10pUvTOtw9GbHFDT73uIKN3zKDRZkJbhW/vVTOLTDreQrZzJmQihV96
	g73peWEhPl34aCBBAQNRiSSofsUX0q2AP5hg1AW3aoP4v694R+EemDJa3WwOtI2C
	e/Qgp9KKSQuBRwMBHKWB6U0wx/r+3T3tbn3wNYYdvsiSG+rIorybOKiQ+TKOYyrA
	8+Q95iKqQmwHjsOFAtqpf2BQ2HCFA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020101.outbound.protection.outlook.com [52.101.46.101])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4d6baq24km-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 19:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9V1ivyNBIl1zxo0g6yG2q2g6/6TpmSoEtRwPyxI12c6bC56zlwYDneJyOPmqPw3HLfWWKtNbw/5dRE4P80//7rNneohivpZCsc3PKpf64K1OIMC2TQHd2MNtvtHsqcJyreQyhi5lxu8F+wmTp2D2O49hfrXwTqzf8FjgSD4E+Z493LkUbRuIlyzYSzJ/btIEQqOqTl1opaPMk31uRiKNqzOBEmGja5fO9TvI9HKM9GlV1Bp40rfvHkENb5IOKE9/OLX52yfvfI613ZQkHOp6onTR9fGAcJfgeXaJjatymdNNHrBoG7sZMvRO5jmfw0Irlf1VYfDWSH1pkP+qzub6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cU92yDEWBXsK+1K4NNN4+NWV8MsBO+21jmUCkrIPrI=;
 b=W+VMrKrEs1fj0elZbn3Fk4jP/7xxm7Q4TnVcm77LeE4pkfMHhUeQ4l+3rubTMfp4y6l9OtQzC9NG3a3vJP/0G/RyHSjuIurjYE67qc88Pg0tcmG2PzdUTTK5n0ZGzs6piVWPwsuoVZQ0QJB9uGD3DCYOtJmFVMXvpWxvUmmG4tU+y3NqhKm8BdYX3/CZ0qRo77Rp3G83Pfosu3yTLci/Ym715p5D9GIrM+CDN4Mcni8TFSMPosOmHNs4W0gKVX4aBJZVmFGqbweckmNB4CilI2ePnE4jB/n/ARNgSbUHQIB5GFG8I0zkGj8LSaMPbPxapQ8F14El4rjie/DOO1+nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cU92yDEWBXsK+1K4NNN4+NWV8MsBO+21jmUCkrIPrI=;
 b=kwbrCObFgsSpanhoETX42e0gJ3imcc2Txle8CEteuCPg1JBQv6unhxgu9waDA/JEJy1MEwej1MfRIMaTZ2HxGoEnHtSIzYV5kYuqUPF34PHyFWc6cf03/6O2cu0f4Zg2BSE48Lka4yXtXyZdj/7mAJUaks4Ggx90rR8po3AF77ExIaW4o0NsWOK/ABZ7HQXNRL6DChtA+VNUPaVm37SHuQRI7/XbdOrR9hXXKd8KKk/K+gyFYsrCP8Ms1kv0ykq/S3iyi1i6SPZFXij+EySPmnmBO601s3/Goao1BJG9BqfVMfjUjYlZ4jj41Oam1IiTG00xk6D9qEIHmMKQavXXCg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by MN2PR02MB6974.namprd02.prod.outlook.com
 (2603:10b6:208:203::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 02:27:51 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 02:27:51 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nikunj A Dadhania
	<nikunj@amd.com>,
        "amit.shah@amd.com" <amit.shah@amd.com>,
        Sean
 Christopherson <seanjc@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
Thread-Topic: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET
 support
Thread-Index: AQHcvUzQMiuRBN6BBkmcEmhJjsHrgLXGXveA
Date: Mon, 30 Mar 2026 02:27:51 +0000
Message-ID: <BD696E74-1EFB-4E70-9DC8-756A7810599C@nutanix.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|MN2PR02MB6974:EE_
x-ms-office365-filtering-correlation-id: 138cfd5e-3dab-4f47-15f7-08de8e03f148
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 moK+5nAtQmlcq1iJH3SNL7oOgdBnkM9Jyrwlb3N2ixaybq1pCdwzQF8uF/Bou0BXN5QJGSUVrAKeBH7TsPDRoddVft6yguolv6ZvammpMDds+vpCjtrMxIt6FWB2Te1GFS+WHuz/6GDBBe2fBxmQFXT3DiZW0N9u96+GE/HwF9lDalgXWXFrbkLQmyKyUzajWxZh0JxkQ3VphQi5OjiWE6OgpZt+dWScvJh77wZ5CItFziok8wcbOL2t+RT+HKpCoqsvPRwwoofrwvqmx/njbxUnRurbB0R2TQo9fGSFtIGkLbDPCBKCbiSEDol22D4kzjm9jOQwbhzjqzqW7DNLKUGHaKp9y9NM63MDsGIJ7dR3S+9pId7+PsBHxLJ08QvRRN6AJGMPwd3FBctszs5qRoFV0gizaCcay4QMgySKI1VHTpcvs3f3DL8ABPNOlgnenf1T1lcbWaUyCsZKICoRrIcLMJOVdEGw03sT3S0wu5KNGF+ck8Rme+oPpOLiFqvsnZm23L6k5GkQKHK9VB+tXBe1Ms9s3KZ+SSe8P9sofrVPUVAWa6coZJEHEIHJKoYBFcAkbSaKQrEz2R0gO0aRpdqO66ouyI+7W/XcjNLT1MxDoHMBP/uAC6SFzODZoJoh/ni++dE8rSc3PeBzzZLjxk04BcUU7jp603gqBJBRDrf1me8TWQG3QykwwL+mYNmLiQWP6y+1yozCd+hDQRqTFoJ5bcXBgpWfpNUjHCVsCuW3va1REVgLN9Wie3tEU82a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3prTm8wRGVVTEc1YmZnVkgwWnhnRWVmVnhsRHEwRmNuOVRDdWU4UGtJOEtV?=
 =?utf-8?B?VUdUbTgyZ0h4MVF2cW1sKzZqcWVjS1dlTHVIR3g2ZG4xTHhCR1pMVDNmS1FE?=
 =?utf-8?B?djJmUHhTK1hLRVZBbDluNVRXSG4zemtYcDJ0cmp2bWNJWmNuZE1kMGcxT2tj?=
 =?utf-8?B?Z1MwZjZVS3NNcHJKS2RhYkIrMnlDU3ptQ2dJZVlYdzlsRTAxbWtKQkpQVnRB?=
 =?utf-8?B?VW1SOGFycVRMb1phQkNHUnpva2tUVHdaMzFXdXRwdGRaWjhXVkFucFNqV1g4?=
 =?utf-8?B?bnhuZjlFUkwwTzE2OFpRa21QL28wYUlWWUtlckhuc3JGd0IxdHRvTGdyRXE3?=
 =?utf-8?B?NjNSSUV6TklzUER1SmdFeGoyUElOcVhsR3NzWjFUSzk1TklvdVBSNnEyOVFB?=
 =?utf-8?B?dGEwVGRCd25sUmxEUm1Ua2EyWVBEYXB3VnBZb2M3KzZXSGkwdnFpck91bmlh?=
 =?utf-8?B?ZlVONnlJcDNBemc0dHdiOWZEUnhzS0JaWVNJQ0E0RWVNVjNVTEllZk5qbWg0?=
 =?utf-8?B?ZTFZaUp0anBER0k4Wm5UZFo1Vy9WSnY1Q0NUNnc0KzFZNjlrcGpnYTZqTXZ1?=
 =?utf-8?B?V0UycEpDcUpSWUp4L01UT0dwczZ6REVHWktFSjQydlBKcFJLV0h5bWJ4b3Vz?=
 =?utf-8?B?NzdMZmdjQjhrOVVjcFNMUVU3Q0U1YmhwdGJ2eXQvaEdldkc5eFVZTjJwOTcy?=
 =?utf-8?B?ZXYxUUlIb3BneW4wbWRMQmpIdWF2T1k1RSsrVjNoMDhPWUtvUk15d1I3d0ZL?=
 =?utf-8?B?Zk5yeXBmK0tKV2UvakdGenBFYkFubCtqMTFEN0JqRjZaU1d5b0Z5U0tIVFBx?=
 =?utf-8?B?UzJ0cUhKT216eVplRVRwTGFOdkk1SHJBYVFLekpwamZXQjU5TXFZMkVsTUtQ?=
 =?utf-8?B?Qzd5ZmFmUGFEQnZZS0NLNGovaTY1NlJxUVRYNGxOOG1la21hU1hzOWlnTk9l?=
 =?utf-8?B?SldFMjZDKy9pYWxuOEhMRnEzS0wvYkxJSEx2Ukx5V25QQXZQMDJUakJHRDk1?=
 =?utf-8?B?aEx2d0UrWTJQcWltNjI5NUNSZFFTUVhheWlrZnBZbjdVbUExdjdWbWlWWUJm?=
 =?utf-8?B?MGVBZlVEbmpmTDRYNjRsaGpOcGV5MzhlUGtmT0NCL2JKbE51dUlhWHhPbW1i?=
 =?utf-8?B?V3NIZDFlT2E3WnJhdDA0WDNML3BsdlN2dndJY3dRZ21TTElOQXpKdkQ0YkhX?=
 =?utf-8?B?RzdlY2JmekNuNHVlWVlYVXhIc2ltNGMrN2o3aDdHSGNITExSUm50Smw0VUg1?=
 =?utf-8?B?V1gycFN3dExWNmFxYmNSWjJXdGEyNTZOcENwdFRNc0hmeFRZdURxMUtPNTNx?=
 =?utf-8?B?TjQyTUZaLzBXQ3VOZk85QWJGQ0NXa0d5ZkJDcThiRGRRYXJtRDlYaS9XaE5Y?=
 =?utf-8?B?Q2VrcndrZjhMUjZJRFJXWGVpMmd6UVdqZUZIVnh0aUQwU2VkRjRGeStrbis4?=
 =?utf-8?B?U1A1dlpITnl6R3p5RkRZOVl3U3Jtdk9mZUdRQnlBV1VXMFdhanlSVmtYdkJL?=
 =?utf-8?B?YkFoMDRJenZHMEl5U0JUZTNBaHd5TUNHWXN3L0EyNUl4V25UVVBOZGpkTXlQ?=
 =?utf-8?B?TVBDT3B0ZXROd0cyVmtMZE9mR0FrZE9RMFh4UjdiNUJLSnhZYkVZMnB6UDE3?=
 =?utf-8?B?TnhsNTRZRDhBcWJYZm9EdG0ySjlBN3lxRVBKNDM1UnE4QmNhLytiekdPRk52?=
 =?utf-8?B?ci9jSG13U1Rvd0VvUGlEOHJwZ2RFckd1WlBSY01SQXliZ0dXMUwyNUxBR3VX?=
 =?utf-8?B?RHI0TldhUWhkSTdiMEVpYms3UVkxckNkM1BCZ0VSL2hIUFhRM0JUSS8rQU9W?=
 =?utf-8?B?NHVCdkpUWmVuOGgyOVZURDF0TUdPYk9XdEtRbERBYm9rSW51N2xwUGQ3L1pq?=
 =?utf-8?B?MWYySHJiN2d6SEF3dEhRTjRId3pEdXNYRUtHTHk5dXZiVXRpT3YyK3ppbHF0?=
 =?utf-8?B?Zis3YmFjNDA3aVVycGpoS0dSdTQ5dGZYUEJadzFrRHpid2w3QytZelB6WTc3?=
 =?utf-8?B?dlZycXBiZ3Fucm0wMTdLQUVMcnFTdjBzSWx2VTNwak9IeUltR0pudVh0ZkVD?=
 =?utf-8?B?Nk1iNmFPM01PQ01mTDlsK0lJVnlBeXB0WXRhV1lRU2w4VjdDQVdBUmNFMk5C?=
 =?utf-8?B?M2lvMmF2Yjk5cVIyZGpubkx3VGpqb25MNVFkUnZlOWptbDZla3NmakJ4eC84?=
 =?utf-8?B?UkVEL3RkbTc5RWVZbklrMFp6Q2tXVzl3NkRvSlhuRUYzK01sUlZhczgxaVdS?=
 =?utf-8?B?ekpSVVVTNFVJNHBnTTErRzVWb1NwaXoyRmpLaFphakZGYWJWT3ZuSkxQbUVz?=
 =?utf-8?B?MlBtVXVFb0orSExvWWxqKzRpQkpsemFNWTROVS91eExQZ1RZTzJvTWFCTWJM?=
 =?utf-8?Q?WuuI9CAWbeQcAN+k7dkXVcc3d8v3Sj2xaSI150Otn1L1a?=
x-ms-exchange-antispam-messagedata-1: lxduViCn5crloBXnIMVL84OlRJ9ZSKrr0ag=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD453E5819BC704DBAF8183EFBCEDA50@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VSpBelfXefL3jClYxPo/MFDsHEKMlgpXnSVvq8dyIf62C8L+Pb189xXLZDZ/3IqUD+kCTzucjYz9DqtOm4aJkrAfRlxPHy5IMbcrN03oQYNB51CEvGXzOY9fu3IHpNQ7hzFu9WceqcDFDZaNNglmfn3pP/I8qC32ChDguUuE6UGZKIgNcXCPQC7eFf5nhNhk8dIr2Ry+IIaaQ7OFW8ZuYyMNx9A/5msHig5PVYQiotFP2dtowEPG6Cs8Mowk6Yumpb6/N1ZMhWkZTWuyh7yC5kJaxZwsK/bapPsRDBxQ/aiofQ+OekQDMlovI5Xs+BIsw+BqRXYoiH2yXdyMSzPvDw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138cfd5e-3dab-4f47-15f7-08de8e03f148
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 02:27:51.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZNG/LF3TJRXR9YWOQ9YB0qNS00wfI6BoDFKsbERouyCw/S1PE9DZnWyIXkDSbH8dNQH3Qn1jyfdnntLtdBv6AuxfjWoriRzC1/Bsxeh7WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6974
X-Authority-Analysis: v=2.4 cv=GuFPO01C c=1 sm=1 tr=0 ts=69c9dfaa cx=c_pps
 a=hSUXT6xmpWUQcPkODs04Ug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=Xbg-A50rfY3wVFKIoHgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rj1Hy0sVSpOhWQuT4EmnIpEMDkfMHYLX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAxNyBTYWx0ZWRfX4nl98/OX6HND
 u1hXwfcYQSSfOMx7Dp/G2/0pwi0iayRf0QUJCmQUlh9CDAXTluqCERDPIt8CrCFD1LofHq5wXAo
 OQtKiuGiuvo0qUOKBJl2ecVkiiTCDBvqf1c+AgU3iR3wCLkEd88hZkeA9v7xpWf6ryUNMUxMr7H
 7cF17Jal3AgKwf4/JuoWvkAnAkTmLrcZJkilWZdfgZUhh4Hf8221B7YR09CrXadrRrdteyWBNx+
 t1E01IW03+oFvfpA8/73v2AY2EEqWPtEiaAftVaUe4JFRI29Oxgk5GJPvy4aYmAwG57sF2sBJFo
 y4Jt25iT19UuEi6SMBlXyLRVQeh6u8V4TOuA1+sFr6fsZ7ly9LhC1gKYkyXbK1MlX7eSEH8+J52
 ggq/BlunEmvjYsLWwMNFf5pr4uqe/QmA+a7xCVb6E5fbFDXso18ixuUsYA9M5cWfjVvGLzqQRPJ
 9FsYQw1qLnXpw+ST1EQ==
X-Proofpoint-ORIG-GUID: rj1Hy0sVSpOhWQuT4EmnIpEMDkfMHYLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDI2LCAyMDI2LCBhdCAyOjE24oCvUE0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gVGhpcyBzZXJpZXMgaW50cm9kdWNlcyBzdXBw
b3J0IGZvciB0d28gcmVsYXRlZCBmZWF0dXJlcyB0aGF0IEh5cGVyLVYgdXNlcw0KPiBpbiBpdHMg
aW1wbGVtZW50YXRpb24gb2YgVmlydHVhbCBTZWN1cmUgTW9kZTsgdGhlc2UgYXJlIEludGVsIE1v
ZGUtQmFzZWQNCj4gRXhlY3V0ZSBDb250cm9sIGFuZCBBTUQgR3Vlc3QgTW9kZSBFeGVjdXRpb24g
VHJhcC4NCj4gDQo+IEl0J3Mgc3RpbGwgUkZDIGJlY2F1c2UgaXQgY2FuIGRlZmluaXRlbHkgdXNl
IG1vcmUgdGVzdGluZyBhbmQgcmV2aWV3LA0KPiBidXQgSSdtIHByZXR0eSBjb25maWRlbnQgd2l0
aCB0aGUgb3ZlcmFsbCBzaGFwZSBhbmQgZGVzaWduLg0KDQpJJ3ZlIHRlc3RlZCB0aGlzIG9uIGJv
dGggSW50ZWwgYW5kIEFNRCBpbiBvdXIgNi4xOC55IGJhc2VkIHRyZWUgYW5kDQpldmVyeXRoaW5n
IHdvcmtzIGFzIGV4cGVjdGVkLCBhbmQgd2UncmUgdmVyeSBoYXBweSB3aXRoIHBlcmZvcm1hbmNl
DQp0aHVzIGZhci4gDQoNCkkndmUgYWxzbyByYW4gdGhlIGt2bS11bml0LXRlc3RzIHNlcmllcyBv
biBib3RoIEludGVsL0FNRCBhbmQgdGhhdHMNCmFsc28gd29ya2luZyBhcyBleHBlY3RlZC4gSSBw
cm9wb3NlZCBhIGZldyBtb3JlIFNWTSB0ZXN0cyBvZmYtbGlzdCwgc28NCndlJ2xsIHNlZSBpZiB0
aGF0IGhlbHBzIGluY3JlYXNlIGNvdmVyYWdlIGEgcGluY2ggbW9yZS4NCg0KR3Vlc3Q6DQpXaW5k
b3dzIDExIDI1SDIgT1MgQnVpbGQgMjYyMDAuODAzNw0KDQpBTUQgcHJvYzoNCkFNRCBFUFlDIDk3
NDUgKFR1cmluL1plbjUpDQoNCkludGVsIHByb2M6DQpJbnRlbChSKSBYZW9uKFIpIEdvbGQgNjQy
NlkgKFNQUikNCg0KRm9yIHRoaXMgUkZDdjIgc2VyaWVzOg0KVGVzdGVkLUJ5OiBKb24gS29obGVy
IDxqb25AbnV0YW5peC5jb20+DQoNCk9uIHRoZSBlY29zeXN0ZW0gZW5hYmxlbWVudCBzaWRlLCBx
ZW11IGhhcyBib3RoIG1iZWMgWzFdIGFuZCBnbWV0IFsyXTsNCmhvd2V2ZXIsIHRoZXkgYXJlIG5v
dCBleHBvc2VkIHZpYSBhbnkgbW9kZWwgZGVmaW5pdGlvbnMgKHlldCksIHNvIHVzZXJzDQp3b3Vs
ZCBuZWVkIHRvIG1hbnVhbGx5IGVuYWJsZSB0aGVtIGluIHRoZSBzaG9ydCB0ZXJtLiBJJ2xsIHdv
cmsgdXAgDQphIHBhdGNoIHRvIGV4cG9zZSB0aGVzZSB2aWEgbW9kZWwgZGVmaW5pdGlvbnMgYW5k
IHByb3Bvc2UgdGhhdCB0byB0aGUNCmxpc3QgdGhpcyB3ZWVrLg0KDQpbMV0gaHR0cHM6Ly9naXRo
dWIuY29tL3FlbXUvcWVtdS9jb21taXQvYmZmZjRiMmFlNTQ1MjQ2M2FiOGMxNGI0YThhMDIwMjg4
YjVmZjVkOA0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0Lzc0NmE4MjNh
MTdmMjUzOTNjYzhjMGNkMTI1N2Y2ZGNlZjc1N2JjMDkNCg0K
