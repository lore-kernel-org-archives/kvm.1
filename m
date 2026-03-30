Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA01D5CC9;
	Mon, 30 Mar 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897181; cv=fail; b=gPewzICU2MaytKrIZz7Afe3opSv8iRHBtmvn2ox1IAbDiOsCOBgQ2d5liOjfgPwEvNRG3WCbzjGFd5UfBoK98dfE141LiC90k26nEXNHFcqJZjmfxNvErbqnNyzlLUaJoLMmloIOKkt8iCzPfT3GlE2FCjFU8DwNi60chBRrIB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897181; c=relaxed/simple;
	bh=EIB4xqgVK3tzUz7P521qLcUOZ70GCPhOP5tGA98lBxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsoPyMNhqptoJigZT9Fkurcn7j9+SoLi135wfBZybYbwQblura/vFbfbOmfng+OFTTR9hhx34abpOZYr9iMm9OVr3XhqiELA/Q9fXSR36+r0dng4lb1CTQHcNW8Y0pc1z3FAjtlggPthxC8DbYcXV6tLj5Zbl3QfXTRH/q2/U3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=n/IJGo2W; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=CqZfYvrf; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="n/IJGo2W";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="CqZfYvrf"
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UI2mvP4011737;
	Mon, 30 Mar 2026 11:59:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=EIB4xqgVK3tzUz7P521qLcUOZ70GCPhOP5tGA98lB
	xk=; b=n/IJGo2WwLLzOYdQfTenXAdgYu7HrHbmoL459DbDI4wTDruQ8AahzykYo
	Vh+3NcEJx2KJJupiOxuOOciQ2WMSG2hm1M5Ly0g8sgUXA5oxPdtynV42WMbQI0XL
	SddxM2oYukj/hCdO5tmhNVPnauMvL2BwA9QWokFiDs6HMGTrIdxM5g3pUc6+V8Y7
	qfT+MI8lO3aDzaWOq7J1q3fwcErQBOYIMhjRePs8OBAB/wWhMwqejEKPvckmn7cE
	F+4P3IZZc3Pt5FQJvEczTzkA/2O1iQ3tXk0B+wz4JBrdfPw8zjs3zJ9AFit+aVZ+
	7ynwjWiwclTee1HYRRHib0d9hTFWA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021141.outbound.protection.outlook.com [40.93.194.141])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4d6ehsm7ha-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 11:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQtpUQz4u88IuWBYw0fE8nqvT2cMj00VN5gMt4RkW36YAB9uVWCAzaCZmlaaiMUAdXkZMPrNVWhOvucbgRhyMOtswlU5OvUzXWP1X/WFXR588kjcqT1QjSc0QvNdSrd8baW3x1vI+6HW5sOxmYwp72bsClPdw6Ig5OiH8tS3jHByC7mWWovDfOLCreXgWsGUnCymm/kf6XO2gqGqStacgqb2dlpQA8auLTXySUYZ+mw32RtjOSGCbaruiAobv5y3JDYINlWzALb9VZqDJUNZYNfe3LOPKSGYPenhhXoBjGGtLPbWz+q5ybFj1zhekSz6Yi53oCkMG4S6CIAC7W1Cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIB4xqgVK3tzUz7P521qLcUOZ70GCPhOP5tGA98lBxk=;
 b=uD6C2Um0TKApqDtzuXyP696cvVCQay1v70Ez6RuWXS1e6su8VQ9HItDarCM+now5hPxlnkqzWxlqF62NyRhe8KK3itsdG0gFNNKiRsbiKffGjUZY43/fOsvWLAA9jSeFXnKkzc748yJRnilqCHOboxy2YXDEVP4vLXPGg2/N9rZMEKE6X9y0YrEiXVdRS4yHRSx1SLIDJb6QVLxRvJ5iMPjzIQ+N0qTeai308okXAI8F6ukQ1YsBPxirP6xolU5TItKc3YrL1c8FnF0sRU4MHSNkYQ3W+wajN5qAiZFRKZ8o1ihCXfUPvr9TmALx5BNkn1iOwJaOnsQG6BRKHgVtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIB4xqgVK3tzUz7P521qLcUOZ70GCPhOP5tGA98lBxk=;
 b=CqZfYvrfQ76GKnnFvZFP3cUmqMdi3kP3d2PYxwFOoJIJgbjZOZqRopV984XFkkVh3N2RUWEarWzCRgG3knJpBEZkNXoSTs5oqcoMqkwsxUBD5UFUdF75y/DGQtCMWfbF9qpaiWvuw6i8AGYxrrIFyxG08PB+HlWPCPo9YSU7bo+h0ruT+iS66znNOGJmxCIPob80Fr4esgFnTHD+av63yUXT/SG87AtLTxA6GL2ZX2dScEu4TvkQjXhR45OlnQj9lnpE10jQs7oISSrM2ge53wOu5zfzRN2TrbCPOGcZ198fUch7a+iXBBUYFxwgkVFaA61VNWmKmhZ6xk18piISXw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BL3PR02MB7922.namprd02.prod.outlook.com
 (2603:10b6:208:351::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 18:59:30 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 18:59:30 +0000
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
Thread-Index: AQHcvUzQMiuRBN6BBkmcEmhJjsHrgLXGXveAgACKnQCAAIpzAA==
Date: Mon, 30 Mar 2026 18:59:30 +0000
Message-ID: <AD9FE419-97DF-4399-B4C0-C172A2700530@nutanix.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
 <BD696E74-1EFB-4E70-9DC8-756A7810599C@nutanix.com>
 <CABgObfYhNJhvVhe1nRG11MMF9p=eT-QoaGNGaN8P+YaywNUg+w@mail.gmail.com>
In-Reply-To:
 <CABgObfYhNJhvVhe1nRG11MMF9p=eT-QoaGNGaN8P+YaywNUg+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|BL3PR02MB7922:EE_
x-ms-office365-filtering-correlation-id: 7c2685af-5b02-4448-5ca1-08de8e8e797a
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 26BzAQ03mbSpehZ/SscGIMcelon14TMk5YRCAhI8jNb41k8KrX4B8Qon4i+BOze2DTblFQXOFGeECO7vPW8ZBO4uaku7YhCH6hrl+3NRb2dhjqV/EzqGUSW2SmVDHcNfs23RI/LmwTumLMz67/Zw3HNQGRnYW1/df7I2V0s4Ee3UgP4+powZNupmBJi7y/4BNGOV8ieAW2a47Zz9aF0+WaoS/pv2lxgLUOlU0AeL3wme9cng1SLgeW/XsDbVUpzswCm9wULhLyMUp8z5ztoR8QF/hrPGQTE/6QmYpGY9ErDkMlj3OgTdftx+up/2CZbnMo4Lp1JUYTit1xz5IF8+0fKSaMljyelZqdMdh1cERq/ex6ZlKe3XMft3XPSHjSeSrnHkDrBDjbIMLvm/9Pxnu4M/0xaa1FO1X/PN0wHXN5EdsIUUqBIFYBxKCsPqjYbVleDmnpE9RDBuHHlSs2a9Xqo7/0b9mBvQgVZldWIieCsG7d2fVPwgy/phppkvB3h/wgGtblmtUIiZPKDb9ZpM7cKJQLsyO/zCE5+kSEohzGS1w3ha5Ja9fx5QvEwmAWwmBFRh+33z/c4WP69eQ8VWDC4wolVSpOsJmeUreWyz/fgF99kQPol9rj5NOkIb63CyAmROFYSem2p29S964j3qLv+BNNq2A+oEih5NErfsNkalwvb4gdu3YApZdVL3V84nsW0RS8eSZjm2K3biPc8NQ/iIkbxXckoqz/GOXJGXE6L4+tTkJ/YMPu9SXeI/s8ZzSYvgMhI9bWjVYAPtUW/SMYaQ6l3guOnEicL6eKe5OEk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d28wRWMzTk93cEMwU1NyaWlxZGZFcDNvTXcwNXdaUWV5aG9Pa3B4T1doMUV6?=
 =?utf-8?B?ejlhUkVLZHpuVkMrRzlmSmxWL0JpTitkUDhBR2JBSmVkczd2VzNLTFdKbzRK?=
 =?utf-8?B?LytmMXdmQU53VStwQlVVSFBmZklQSnVDN2NDUWJTTUpBb0FLVFJwVWlPMCtN?=
 =?utf-8?B?VmZmeDNPZkpIMDhBMzlacnBCWERhTGlCcFQyaE1FZGFTOUFhekVObTJZRjI5?=
 =?utf-8?B?TGdtcVhVT0p4UGlJQkhmaXFQd3B3dzFhbUJ0NkFkeTZQdk5wTURiTHN0SXpV?=
 =?utf-8?B?RnMyT1ZjYlBMNzAwQkVHakhsV01RbWRXbDVRckF6L2VZNjRBVEhTVzNHWUVI?=
 =?utf-8?B?RWUvei81dlI0VzRMVkpXcUlkdjdMNEVhNlk3V045a2pKamw3MHg1dWlVOStl?=
 =?utf-8?B?ZlY5VDJ0VEh2c05kbTVyUkNYa1YwME5sMnhpQXlsTjNuTDVCdThBZGN1WmM5?=
 =?utf-8?B?cDFsSjFQdEpPSlF2SjdsVXE4NzV1eGQxNis4Z1pJSHhWa1g5VytLR1dxVFFN?=
 =?utf-8?B?bXlDZmF0MEh2YTN5M1hjVWswd2tVYlVJV002V1hyUlhWVXBtY0FCZ0paVzc2?=
 =?utf-8?B?TmRoZGRJQjRHUStLcEtleFR1WDJ2eHp3SExxKzk1bHZUZGttcTBmUWNncGVx?=
 =?utf-8?B?OHVLWEJlbjFhRjRyclNndTY3YkNlS3U4Ym81TW1HWWVjd0dyOHB2amhWSm1B?=
 =?utf-8?B?WllISUtJS1d0RWNwTFFoUW5VdktURDh6TklUK1FLaXU4d21YRUt6cXI2dTJi?=
 =?utf-8?B?bVZhNGZlMnZVZzB5RWU1cGNhZzQrZGVoZFRMTURlNndWOGhFUlJlZGloSWp6?=
 =?utf-8?B?cVk1OHN2T3V3SkE2NVlzQnBqYjllZC9CVFgyS1ZQTm1uS0QzN0VDSlVzTDVq?=
 =?utf-8?B?S0VkY2ZvY05VRXIvNEIvbkFiNE5hNEZ3MWFkRlpnNG5ZOEdMY2pxaXV4TkJV?=
 =?utf-8?B?TWhxNFRwcVRyOHBueHlYK2Z2eUxMQUdTdDIrT0RaMkQyck9XYTBaNTA4RHdK?=
 =?utf-8?B?Ty90ejFXOTNnSG9tdU1mdWZxNjM4RUdVR2dEVFh3RWJldmJ6eGpod256VU9B?=
 =?utf-8?B?QnVlNXBWSTF2Ui9VVmhlOFY3aU5rVnh0OWpXc0k4TzdETFRxZ2ZmM1VjejBS?=
 =?utf-8?B?L2N1R1Q2dmpOcVVYaHpCNlFPZFBRalJ1RVdyeXR2N0EvaXBiRFBsSjNwNElO?=
 =?utf-8?B?MEpnWnAyQkxaTGRsc0F2cy9jM2VZc2xBTVNMNDFEd0xNSll0dDc1TkJtSUVw?=
 =?utf-8?B?bHRWTmdoVkxMWUcwcURBZzd1d1pGWnBFWDl4U1JJQmxvTERhdE1yUG0rMXY2?=
 =?utf-8?B?OGF3cVVMWU41UG5FTS9IbTFIRmdvZ2xBdUlQYWxqSWZXMEhoTkJlRHE1YnZv?=
 =?utf-8?B?R3JXMXBxOE0vMURLT2ZmL2Jrd2ZNOTB5NXM4WWk1SVZwYmJRUlQxRVFFZnNI?=
 =?utf-8?B?TStaWEkwWHlRUGlNQWVnSDdHSHhONEJvVWpJMGhVRXRQbTJpcnc5RFB2aXhw?=
 =?utf-8?B?Y2hhL0Q3eG8xdlovRUJBeXQ2dGc1S0gxT0sySEJqdVNobGcyaW96aHdRMWZo?=
 =?utf-8?B?ZVRaWDZmd2wyV2d1K2dlNld2RGhYMlRqSHBtbktVWGlTZ3NybFFIV05hb0lL?=
 =?utf-8?B?cU96a09KRmE0alVkaEN0Sjdzc0xnWDdBVGkwY0lxKy9WYitQVXJPZzZGQ0dI?=
 =?utf-8?B?K2VvRzJDS3Q1ME42UEVXZFZpbkFGRnNXZVZEVGgvRmlLZWkrM0RtOG5TTS91?=
 =?utf-8?B?ZjBYb0xEbEd5S2svTXpRU1ppZm1keVo1ZmY3akNySEZrcGVpUjdlUDZxWmdE?=
 =?utf-8?B?M29LNFMyN01XU0tpb0FtTUlaTEwvRjJTeWdVd0xIa1hXTHlDZFRGTlBPOU1a?=
 =?utf-8?B?Q3RLRk50amRTSTZucWVMWVNVSXFodGg0UVEvdVpPT2R6SVExVHhCRnd2d0th?=
 =?utf-8?B?Zm1Zd094amtkRmpOZnJXd3VmUjNsS05ZeUFLUjhYWDNRdE00enh4Tjh5T3lC?=
 =?utf-8?B?am4yVzJUaVF1L2FrUU10R3Q5QksxaHdlcW16OHpHRm5vcVR4cDJTYXU2eVJS?=
 =?utf-8?B?MjFMVmdQQ1cxcGRKYVE5UHlyNUdsbktpRDNCMXJscHRRMVpEcmpmKzFOTG5B?=
 =?utf-8?B?V1ZxbDlTSUZsTWpaRFBGWC8yT0RrMTlvN0I3OWYwckw5YWZsWkVaMDkvMDNT?=
 =?utf-8?B?OTQwS21TNUQvWnpzdmo2WEJFOUs4SmM3Um9VSkRVa0VOTk5PUExtNTFLd29P?=
 =?utf-8?B?dmdZTHZPdmZ4aFdYb0t0VC9IN1ZiK3owcy9KQmlnOERkOGhRYVJIYjNiS0hH?=
 =?utf-8?B?Nk1vWUVrVmpRcExkSEpLWW55RjV0cS9JY2Z3aUFlTVBXNi82TnVBRlNQeE5S?=
 =?utf-8?Q?E/Sy4bcOldsY/7GOhcb9w1lYn3xJaMizE/colXiUGMdro?=
x-ms-exchange-antispam-messagedata-1: qBojefg2BHvkWVGWOjYAXK8LrpzzLJ3bCjE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3296FD23F93C934D918551711FC478F0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hHAdEGFkqnfYU4Os/ViOD831e+fUtAgoYrmD8iDeh+ECYLyINo2vvRVItgxFr0tniq8apL6iNtMGoKbvbSGeB138zuujENqkOWr2Fcivrc83tJ1VE0DgbMxoUTYXeHR8GIKEI8j6c3BgchtfnvjzEoH2C2sippUiFtXyYiSun8XsGcDa5hPFK9icsIKnfjGMYES9LmJ0mElU49lA22xsqDUQE8VsCWdezK0Fihr6SESP9Nczs7bU6Q7Vi5rb3iUI+Ud4Pc7+n7tRq3ZO7jYs1M0CwdmEu7+sUrSitZHWDziEB1bcsuoPdxbhEL4f0MDasYvD3oQJXBsExIX05oTtQg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2685af-5b02-4448-5ca1-08de8e8e797a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 18:59:30.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cf6IVu32nosOKD0hENfSBElHbXbYSO/+TufOFD2RNrarJSKlfsg6o7O5OuLVIxXTMEtXY4xR+R4lOHPwzKOwvo+6s6oW6u6NyarjedQfNF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7922
X-Proofpoint-GUID: Ag3sGKaL7WWK9e_rXm2LHWYj_EVi7z7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1OCBTYWx0ZWRfX84IGq7ndtDlf
 Tlynngf+efbG8GpqNCLpN7zNuHvUevo8yvBQdY72/N5PqO6ae7Wo8ROxrcD8WUvAW4nwWSxHDaB
 8NH1LODZp1Bal+qE693MoMEFEq4Lfh8UXtHPKFlBS3PAV83mK5J9MESy6Y0bMDCNhe8kHsD65YE
 7hQ3row5fFmuTCa9wcyHn+1eT/HPMie14bvzX8zCsO40IPiWSjEDEm5UIT3pUh3XL9jk3ZIJtGE
 2XnJkyJB89teqi/viO9JOmeNGP3SRUQ50fc1/SnAnOGS8GN5jzNFMEVOcQCKQgn5PsA2OYfBflt
 pmJuPofLE4azpK51i1sbXMFtVB0Jm1CqjYzlltxTkQDhGu3RWY4MOVLY42v6Z3mJ5z7UyswNjc1
 E1PZz5htaCf+Ck79+0ePf2NqAxVLitTane1sfQjUUghTJwAOUo0LBuOGboMV9ExEFjKQXzsWKIf
 dBsnDR9wSPIF47QuVsg==
X-Authority-Analysis: v=2.4 cv=COEnnBrD c=1 sm=1 tr=0 ts=69cac815 cx=c_pps
 a=OpSXQbuC3dJaDDyxjzMkQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=69wJf7TsAAAA:8
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=XemeiUOoYictBSP4HlQA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: Ag3sGKaL7WWK9e_rXm2LHWYj_EVi7z7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDMwLCAyMDI2LCBhdCA2OjQz4oCvQU0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBNYXIgMzAsIDIwMjYgYXQgNDoy
OOKAr0FNIEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4gd3JvdGU6DQo+PiBGb3IgdGhpcyBS
RkN2MiBzZXJpZXM6DQo+PiBUZXN0ZWQtQnk6IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4N
Cj4gDQo+IEdyZWF0LCB0aGFua3MhIEZXSVcgSSBmb3VuZCBhIHNtYWxsIGhvbGUgKGp1c3QgYnkg
Y29kZSBpbnNwZWN0aW9uKTsNCj4gdHJhbnNsYXRlX25lc3RlZF9ncGEgaXMgYWx3YXlzIHNldHRp
bmcgUEZFUlJfVVNFUl9NQVNLIGFuZCB0aGVyZWZvcmUNCj4gYWx3YXlzIHVzaW5nIFhVIChhbmQg
YWx3YXlzIGFsbG93aW5nIGV4ZWN1dGlvbiBmb3IgR01FVCkuIFRoZSBmaXggaXMNCj4gbm90IGhh
cmQsIGJhc2ljYWxseSB0cmFuc2xhdGVfbmVzdGVkX2dwYSBuZWVkcyB0byBiZWNvbWUgYW4gZW50
cnkgaW4NCj4gdGhlIG5lc3RlZF9vcHMgYW5kIHRoZSBjYWxsZXJzIG5lZWQgYSBsaXR0bGUgYml0
IG9mIGFkanVzdG1lbnQgdG8gcGFzcw0KPiBtb3JlIGluZm8gZG93bi4gVGhlbiB0aGUgdmVuZG9y
IGNvZGUgY2FuIGRvIHJlc3BlY3RpdmVseToNCj4gDQo+ICAgIC8qDQo+ICAgICAqIE1CRUMgZGlm
ZmVyZW50aWF0ZXMgYmFzZWQgb24gdGhlIGVmZmVjdGl2ZSBVL1MgYml0IG9mDQo+ICAgICAqIHRo
ZSBndWVzdCBwYWdlIHRhYmxlczsgbm90IHRoZSBwcm9jZXNzb3IgQ1BMLg0KPiAgICAgKi8NCj4g
ICAgYWNjZXNzICY9IH5QRkVSUl9VU0VSX01BU0s7DQo+ICAgIGlmICgocHRlX2FjY2VzcyAmIEFD
Q19VU0VSX01BU0spDQo+ICAgICAgICAmJiAoYWNjZXNzICYgUEZFUlJfR1VFU1RfRklOQUxfTUFT
SykpDQo+ICAgICAgICBhY2Nlc3MgfD0gUEZFUlJfVVNFUl9NQVNLOw0KPiANCj4gYW5kDQo+IA0K
PiAgICAvKiBOb24tR01FVCB3YWxrcyBhcmUgYWx3YXlzIHVzZXItd2Fsa3MgKi8NCj4gICAgaWYg
KCEoc3ZtLT5uZXN0ZWQuY3RsLm5lc3RlZF9jdGwgJiBTVk1fTkVTVEVEX0NUTF9HTUVUX0VOQUJM
RSkpDQo+ICAgICAgICBhY2Nlc3MgfD0gUEZFUlJfVVNFUl9NQVNLOw0KPiANCj4gSSdsbCBwb3N0
IHRoaXMgYWZ0ZXIgdGhlIHNlcmllcyBnZXRzIG1vcmUgcmV2aWV3IGFsdG9nZXRoZXIuDQoNCk9r
IGNvb2wsIHdpbGwgbG9vayBmb3J3YXJkIHRvIHRoYXQhDQoNCj4gDQo+PiBPbiB0aGUgZWNvc3lz
dGVtIGVuYWJsZW1lbnQgc2lkZSwgcWVtdSBoYXMgYm90aCBtYmVjIFsxXSBhbmQgZ21ldCBbMl07
DQo+PiBob3dldmVyLCB0aGV5IGFyZSBub3QgZXhwb3NlZCB2aWEgYW55IG1vZGVsIGRlZmluaXRp
b25zICh5ZXQpLCBzbyB1c2Vycw0KPj4gd291bGQgbmVlZCB0byBtYW51YWxseSBlbmFibGUgdGhl
bSBpbiB0aGUgc2hvcnQgdGVybS4gSSdsbCB3b3JrIHVwDQo+PiBhIHBhdGNoIHRvIGV4cG9zZSB0
aGVzZSB2aWEgbW9kZWwgZGVmaW5pdGlvbnMgYW5kIHByb3Bvc2UgdGhhdCB0byB0aGUNCj4+IGxp
c3QgdGhpcyB3ZWVrLg0KPiANCj4gU291bmRzIGdvb2QhDQo+IA0KPiBQYW9sbw0KDQpRRU1VIEdN
RVQgbW9kZWxzOiANCmh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1k
ZXZlbC8yMDI2LTAzL21zZzA4MDkwLmh0bWwNCmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUv
Y29tbWl0L2ZhNTMwZTg2YmVkMTJjNTc0M2Y2ZTg4YzRhMWU0Y2MwMmNmMGU2OGIgDQoNClFFTVUg
TUJFQyBtb2RlbHM6IA0KaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11
LWRldmVsLzIwMjYtMDMvbXNnMDgwOTEuaHRtbCANCmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3Fl
bXUvY29tbWl0LzJiNzAxMjE2NTNiMjAzN2U1NTE2NzczNzdmOTJjYTQ2MjNmOGQ0ZmYg
