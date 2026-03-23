Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AE3AF675;
	Mon, 23 Mar 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277375; cv=fail; b=BrnzyZmfV6yNcd+A/LzCrn7o/mocjdA6BN2dZBMNPSlfLtF6GfR2wz6rqk8goZUCg/TU/4G9rwSYLfJfsrWmymE+D3QjxxelM4mPgRaztFuDZUePYQvc4r9/QsUhNWYY9Wu81SDtIlqPMiAA5nM1g5jpmJE6RdE6gf+EOvgy1RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277375; c=relaxed/simple;
	bh=K39nlrNu0bJAOnfS3dV9n89ov8WBdbl+XBWvm7/5ul8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E7kBa2voUJUzXun5lDIKTZ5+wFBW64j1OyW149+yg5GNcs8/87f+Yg7fJwMyyeXU5WA6w3/gdC7CcP40ZT7s9Br5Bl44T81/vS+S3h80JBxX8mfmLqyR3m2rLyxBIEVXGrND0W+Y0EA8rXT1m22aJPo3j00qqgCLT6NeiJX4ewA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UcWm3FtG; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=LCVu/80h; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UcWm3FtG";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LCVu/80h"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NCA1WE3346057;
	Mon, 23 Mar 2026 07:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=K39nlrNu0bJAOnfS3dV9n89ov8WBdbl+XBWvm7/5u
	l8=; b=UcWm3FtG1a+31Aa/1n8g4D2Yhg83TlZj86pJUgRqiOWe+KwzHkw0pKVLN
	dRU9dUsl11k3MlMsjqFsmhINdS8kpClqhSJuiFvPmV2kiDJ/cqRC+zkjeMGJvBIt
	ZxKBxMiMDhcAwZ6Odg5LhzaTrVWS5pBh/lA158LlWU/cD44A3UahNSFNAazNVmWV
	aNU9QZhd9TgKz7XaAL536zZEf+u7lvJ08hcePhlnhRHLWi6VMUHao99U8B4BiM+0
	VfcmBoY+9cRKkK/8qGUSJgZp1MX/K9VDalkUJ4OyNU7ogVdl9fyxZgfXQ10h5T9d
	5l83sU2AWxu7tXkdn6ZuokaBVBh2g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022076.outbound.protection.outlook.com [40.93.195.76])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4d1qnkv2s3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbVcDU0WSGGqnccs6y4N94iT+/tFCMAotiOo9IweyPgePdHIxAwL8AnHWqMHDO4cMaGBTrzeI5KgwcV6I5vJrhXhqYsQnFUw2MFK43Gp2OAteDtzkx2ZcZNQgyxM+agB5LbYBHQiJKJOXEXaoYnZxGaVc+vhLdsPOdOe3RM0uXABVwO5AkQlqio1MOQzxFyRpgoKsI2Ywq3+fkngoHdTMrMPMUZYBcOi7BPoKnKlrjuMzcq2k1Nj0oWdk/I8nKvjqMl9bggOU2ax0oOtuK6u/wyhW8egSLwQ+J3d/XclNa7xY557OAhBmMkALG9zFQne72YSPPYsaCaUhCANukUuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K39nlrNu0bJAOnfS3dV9n89ov8WBdbl+XBWvm7/5ul8=;
 b=W57dgUnOp5hEgvFl1RrOWBIoBf+yC7XBDHVA34D5j8im/1C/jHV/J9Lem0sLhyDVRISnJ4aELcFAHXrq2kSZ7Wy+3Efg4j1CWNF4voZzzHd3QQ4/YAD1rH7LFQ8OVCMuM6SW9KKSDQjyASQDVhpgzNQ8RRu+0zr+baYIMeG9DkFoW2YltQgBr0a5FCZudiFHOEQQWG0FRgo/WFWHmeb+s4rRWTO+tlHGMrfbJ7t2QCMffE130GfkoLwCTlfLHsljkM6vuWfo4fAQF6uP4poq7c3k315uoyh6D5IPr7JcA9b8qc52vrAIwc9tWj9gMnhE3qlMnpy/84VagLJ8tkWrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K39nlrNu0bJAOnfS3dV9n89ov8WBdbl+XBWvm7/5ul8=;
 b=LCVu/80hZZIkS4H58zoUbWiQcGDOKZf1z1wwmhUjyJQ1yzHIrc3cijYm5QIIAwKz40lsdD+ncQO+5JjHsILqLvfeDsUltH/frYnuV1y/F+e2zmNMy7TGkFWnm4woeMrTmqZHi8qkDuSC9clBY1iOfeCDQ2CqikgHSuHIi3zY1xFnRJHsqGfHlrR3MsTgce6ziwluTFQilVpj9ZR65saK8s2p/fZvfI84taoRdUUaRWtAi8rNJfvjL+gJJNAoytruYqi/pE0ZjVlL7+wj0MT/21ofitdD8kPWfe4ExeOclNz+OQ/DwgUJo7BOMKld0X/kB2PbuvqpTxFh4MJK6h9pKg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA0PR02MB9919.namprd02.prod.outlook.com
 (2603:10b6:208:485::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 14:49:21 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 14:49:21 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Marcelo Tosatti
	<mtosatti@redhat.com>,
        Nikunj A Dadhania <nikunj@amd.com>, Amit Shah
	<amit.shah@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 13/22] KVM: x86/mmu: add support for nested MBEC
Thread-Topic: [PATCH 13/22] KVM: x86/mmu: add support for nested MBEC
Thread-Index: AQHcuMcXYhFuHwnmqEaBU6uyiDj+fLW8NtsA
Date: Mon, 23 Mar 2026 14:49:21 +0000
Message-ID: <D389BD7B-E798-4B3E-89DB-E55516881196@nutanix.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-14-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-14-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|IA0PR02MB9919:EE_
x-ms-office365-filtering-correlation-id: 9ee001aa-b019-4826-4c8b-08de88eb5e46
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 iVQ1QhlcvslrPJzGXXh+LkZGiTMlqr2aXi3JTL33YTEpqcs+gUcCMNUGLpswSsUqC9Ux9RhrHP5aVHXMahCuFjGNbjkW0omYr5PKNuSQoYf2tzm2ilYZXj919rwjmklC9MBI5Cujdn54ae3ZWAR+9AN57s2/MlsKjIB5wQi5P6ULLc35KPz7nqkcbHzVZQyiLGFyWG/y7ACdbWXsLb0qpw62WeX4oPw9eF3ftwqilZbjHOKhWO6dAk3CKc8NPRkdUeiq5gc4lzFX27DcJ/KxQcIP/+68LqfRgPTThRiAe6enWLDTwWyUPlUfFvNWXc7KeiHIlIxNXHLWmzsyJL33GzwPmsvVMZZDY33fwcLXuHKiQpzPAoqnKc+Gq9Uv5V6RH9yOehmqeZ6ZBfhWzPAD/j0ccb12AFkc1uh0MErf4kdPQsORJB2VLRKWE2sCLSZdWW4oqoxc+8yHqgssZMjK4qk4mWgZbGTrD6OJmO7MyE8yX76o/l2Q9fx3xCDgtXDb9r/msFeepGD1irBxuNKaAPaEQrKdHvaHxFNe8IU41JMmmWhd1wuWbOYO8dYCLQNDLJ1rkrOOGEZa1wJqfVecOb70aojdB340FbNhFIbydaqla9EYgdhuHiT8iR6d5gvLLX2ZbxxRYkPsNVjH3oxwcv8osMTgY+jY6Dlt4+iN8l40qrUVJKBhdolbHJDFAn8P4vwxN1vUMGGPJkrc0YgF4HVOHDiguriC2Oydco20TloJD/fc1Y09xiHSnBWWBO59rdQ5i4WX1oPOOc96wPwFdLaHQoV20ti3BGjBG3eDY/s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0dXZXphQXB3alUvMGFKZ0xzRUNpYlN6anZvbHR3bUIxNVk5RmdXa1N5ZTht?=
 =?utf-8?B?cW01MXgrbXhHZDluNzI3Q2ViNVNORVg2UGNPS0ZIVzhDS2pJZjJiSllNMm9P?=
 =?utf-8?B?Q3BqZm1WN0RiZ21oanladDViOFlOaE90V1VZSUVKUmxMaWtxdG9kRTRMTmlm?=
 =?utf-8?B?TnBRS0dzVkg2b241U2xyQnBZY3FtY2c1WkNBQmJuQnhzQlVSRjhFN29tSWpi?=
 =?utf-8?B?K3Z2NlpzRVlKWjU5Q295YTMxaUlnc0JrWTJrRW8vS2N1RDhGcmpBVlYvUXhE?=
 =?utf-8?B?aFFZdFpFaE05Q0NoR1dqL3BtdmlJcHRrQ2NkcHlkczJhKzJRMzhMMTd1YXUz?=
 =?utf-8?B?WEp3b0FUWW1FOHhDU1plKzZocUJwRnFuamhFOEtCSXdtc1hvb2hhdXViWmtY?=
 =?utf-8?B?aUtKNmJ2Y01xb3B0RFAzTHlvOU4yZnRoWlRQYm5ZQ1doNVFiTTJ6ZmNBTjdP?=
 =?utf-8?B?SUJNcWt4STNXM280d0ZhR3I0UzlaN0N5LzhXd3FyaEc1Z0RnNEFjUnIyQ2g1?=
 =?utf-8?B?SFJJRzYyelBJRjdKTnFRcWtRU2JxSkdJRHJrVzE5bDlJMnkrbG5LdUcyTjV6?=
 =?utf-8?B?VHcvSGd1b21qVUVVWnlRdkxBc3FlOVhZLzluRnVwcjhkRjZQMDJvZDBWK0Fu?=
 =?utf-8?B?cXk2aFcxbjhjNkJZMm1obnlNVWIyMC9XZUwwQWwyZG5DOGxUaHVJSXpNalN1?=
 =?utf-8?B?Y1FiTmpEZ2szQ3FFTjB0N2g2MkRSQlZVbDRjRFVROEVpMVY5RWZMYXNiTEJY?=
 =?utf-8?B?MGJZbCtZamtVcld0cXhQWDhLdXVaWFJRSE1pWXJQWFRWc0paRjcyRmZ2N2JW?=
 =?utf-8?B?TDhON2ZyR00xRDRQbERlbFZHVUhvczIzT3lMMnBUNGtPRHhuYVp0OG1rUVpJ?=
 =?utf-8?B?VDQyR1FzTUdkZVgwZmNwdEJXaE1GUHRZMTB2dnFTNkhCVGJobndlQWF2OXRr?=
 =?utf-8?B?WjZURjYyUklyK2xkZ3JFWjhWdW85ZFhoN1Z3TGJCY2c2bzVXOXN0b0lxNkFJ?=
 =?utf-8?B?alJ4eDNpbTJPU3A1SEhRdmgzazM3WXEzQ1N3VUd4Si9UV1pzdEFjWC9BSXR5?=
 =?utf-8?B?WVhIVlJ2anhUajg5aVJ6Y0poNGtjL1FhdXlPMjVnZ3NvUGNCRW51WGpLNm42?=
 =?utf-8?B?Vy9uYStIMzFzd1l5Q0FTTnFQdXQ1ZHNZUHFlRFoyaTdkN2w3S2hJU0VzNy92?=
 =?utf-8?B?YnMxSGhjYWo2RnFsUDZRcTU0dTVmS1RhUk9FNEpkcVFQSFM5MVJOUDIyN2xG?=
 =?utf-8?B?MzdiUjlsMklRVE1VWU9lSEFtYXQxdGNRSjZydW5lY1dBY0JleVBacVhnMUow?=
 =?utf-8?B?NGV6bSs3MUFGa015ZEZBdTE5NXRsWm4wV3dHSnp1c0J2SHlkYWlFdzBlV2lN?=
 =?utf-8?B?UVYxeHkrVHUzOU5qZ0lldkFwV0xUWEhsRnRQK1p1NG00bVFJa3hBbmVTMTlL?=
 =?utf-8?B?bU1KdG0vQ2pMYWpFNDdtSzMzdm8wSGorVFFWSEUzclFpclRPdFpob2FtWVpk?=
 =?utf-8?B?MkhVMklpNlpna1pJTkF2bmYrTWJvQmN3bnh2Vzd3MUc3NGNXaHBXOFVjdVIz?=
 =?utf-8?B?OW5iVUo1WUcySEVDMFQzb3ZpMzg0dHlPM1ZqdXNGM3VnS21zdGdsT3IxMmVR?=
 =?utf-8?B?cit1SHVmcHU3SG9iRHppRUhBaTlyWDdpK2RHQ1lmN0pKaXFBRTI0NWducDVD?=
 =?utf-8?B?a1gzNllLNUZRU29SdGdWZGRTWGRQTmxWdXM1bFVMSW5xK1B0WWRLR3EwUVVG?=
 =?utf-8?B?b1lOMndHODhhNE0wb3p6T2tQWWxFUmo2cVZVTVREc0VUVk4vUysvMGFtdFgr?=
 =?utf-8?B?anNXQytIR1h1bnNOTUFoZjFRejdLV1ZGM2xERm1yUkFsbDRNOGZqT0ZIbDI2?=
 =?utf-8?B?TDhlMmFUdzNTUnllNk12UDdQak5qTWJhdmpaZFdiNXZFZE1ZM0JQVml6MjJW?=
 =?utf-8?B?Y05aMDRTRkJTUk1ZT09kTHNWZmIvd1VxejN5dldLdUtEWDJpOHJFUllnVXdD?=
 =?utf-8?B?MmN2cDA2Y1d2cTRjaXAyaU1IR0h5NWJLSWExV1NpUU0rMlpIS1JDd3V3b29F?=
 =?utf-8?B?dk51S2syMUxMcEpmbk1nUWFMWEJoWlp5bit5TTlhUnVmcENzbzRyWENwa2JL?=
 =?utf-8?B?MzlGQ3ozYWJFNXdsZlQvSEtPNEptT3AzRlRHWFJ5ekM4TFU4S0w5VzRzZ2dQ?=
 =?utf-8?B?MGNGKzM5bmxKcGFJc1gvVzRqZy90Yi9LdlFaalgyTjJ6eFVPdVpUR0lCNmFF?=
 =?utf-8?B?U29Tanh0cG5DTEZXSmpXQUsrMHEwckxFQWtHR2FLM1cvUjhqbzNrMWQzb1R5?=
 =?utf-8?B?WjhuV2JWSkppUnBQNkNEQzh2WnBHRkhOSHFCQ240ejBaeVA4cUdjdXBVQ3p2?=
 =?utf-8?Q?uMqBUToVf8s8h6TW46CLYVmz00Twm7oKvLD5qF2V9yiHM?=
x-ms-exchange-antispam-messagedata-1: Mg10/aLofcEXNnxWK5AEF+ObvvDAxHYjfi8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF0682B8135603409DC8802F0328349B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vuKmCQJDa//xYGaOKuhJ1k8yHL2oQeenHJio75xPtiBL6SaryCYVyW6XAVhtfisHbvVp4ES+3EdnN5i2PF2EKplwc/l7SV6fL3hGswV+e3V0nbtY1RkxbrRrW6S/IxjI8DAQnlHfK0z84UnITwAzivwinKlmlKcFu0Lfw2PktVljoSXLFpk/xuvi93ESqjxYNMUzWm9UQ3JCIG2x0hh4sTKHYAXZYo5ClkQaIXSpFTWmWNUIw/RfKBcWnBrX7JWKaJte8QgRkZ9JwJxq/yWEiML3lWK53bJrd253iUXzLTIBXA+q/Tml8mmhD1ASkU3NNIlUcDwUeSn4lUOP8VhYZA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee001aa-b019-4826-4c8b-08de88eb5e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 14:49:21.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFU+Q5E3lTfGSqHp4Zvn7+9I8EzIzyihYmOvlNN+rdlmbc0rgOwF1+3bFFZi3JeyRh01SzuhK7M4LWrtwqkR/uAglGI64x8SJbwDNvWN1WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9919
X-Proofpoint-ORIG-GUID: ilhG8nj--YG7vseBSJTUrJzYD3AHpp8G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfX/i17IUhr+fZ3
 +LKuS2ThHOnSIqV8e5lCGSu/z2YjaP/fcHsI8JpJ0GEx/Nync5w+UKsSf4ISmTs1hKylIvXf6jI
 DvbK+46/PuvY1mNF1BxpROEaMW/o+3rXNTpKI8nyuCVN41xCmF+IdUjv+jHc6+YbImFgmYDmZ3u
 O5PbuPnuU41BizYE3NaayP4RGWoj/Ycq7mC2Jt4piz9qFBebkW2tM/CaUc8Dt27wXin63nrFfk5
 HHj6dbK7+slO8RLT0UttvPXtBQUWt17eSsu1PhxQfI3XPDxPq46pz6lOUQq8aKmiM4qJb1KxuhG
 S3qT7JiU541Fk/hzuOpvNq98NrRL+LCSVE3atmCtG8y4BHLQr6oWFDxDRhydUe8zxXyma+dBMrW
 i1eJrTx2QoJgn2egQVLp1mLO9K3SDzPZ7TchCGMcBBrRM8h0mQpd94B/KJfXcZh8xOG9fdDw/O6
 bUyAwziZG4ufomjxzXw==
X-Authority-Analysis: v=2.4 cv=RuDI7SmK c=1 sm=1 tr=0 ts=69c152f3 cx=c_pps
 a=eCb8aTw/9lghk0zZp47djg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22 a=20KFwNOVAAAA:8
 a=18g_pxkGiKwvm2t90C0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ilhG8nj--YG7vseBSJTUrJzYD3AHpp8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDIwLCAyMDI2LCBhdCA4OjA54oCvUE0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCg0KTWlzc2luZyB0aGUgYm9keSBvZiB0aGUgY29t
bWl0IG1zZz8NCg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tPg0KPiAtLS0NCj4gYXJjaC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5oIHwgMjkgKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21t
dS9wYWdpbmdfdG1wbC5oIGIvYXJjaC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5oDQo+IGluZGV4
IGM2NTdlYTkwYmIzMy4uZDUwMDg1MzA4NTA2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0v
bW11L3BhZ2luZ190bXBsLmgNCj4gKysrIGIvYXJjaC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5o
DQo+IEBAIC0xMjQsMTIgKzEyNCwxNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgRk5BTUUocHJvdGVj
dF9jbGVhbl9ncHRlKShzdHJ1Y3Qga3ZtX21tdSAqbW11LCB1bnNpZ25lZCAqYWNjZQ0KPiAqYWNj
ZXNzICY9IG1hc2s7DQo+IH0NCj4gDQo+IC1zdGF0aWMgaW5saW5lIGludCBGTkFNRShpc19wcmVz
ZW50X2dwdGUpKHVuc2lnbmVkIGxvbmcgcHRlKQ0KPiArc3RhdGljIGlubGluZSBpbnQgRk5BTUUo
aXNfcHJlc2VudF9ncHRlKShzdHJ1Y3Qga3ZtX21tdSAqbW11LA0KPiArIHVuc2lnbmVkIGxvbmcg
cHRlKQ0KPiB7DQo+ICNpZiBQVFRZUEUgIT0gUFRUWVBFX0VQVA0KPiByZXR1cm4gcHRlICYgUFRf
UFJFU0VOVF9NQVNLOw0KPiAjZWxzZQ0KPiAtIHJldHVybiBwdGUgJiA3Ow0KPiArIC8qDQo+ICsg
KiBGb3IgRVBULCBhbiBlbnRyeSBpcyBwcmVzZW50IGlmIGFueSBvZiBiaXRzIDI6MCBhcmUgc2V0
Lg0KPiArICogV2l0aCBtb2RlLWJhc2VkIGV4ZWN1dGUgY29udHJvbCwgYml0IDEwIGFsc28gaW5k
aWNhdGVzIHByZXNlbmNlLg0KPiArICovDQo+ICsgcmV0dXJuIHB0ZSAmICg3IHwgKG1tdV9oYXNf
bWJlYyhtbXUpID8gVk1YX0VQVF9VU0VSX0VYRUNVVEFCTEVfTUFTSyA6IDApKTsNCj4gI2VuZGlm
DQo+IH0NCj4gDQo+IEBAIC0xNTIsNyArMTU3LDcgQEAgc3RhdGljIGJvb2wgRk5BTUUocHJlZmV0
Y2hfaW52YWxpZF9ncHRlKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQo+ICBzdHJ1Y3Qga3ZtX21t
dV9wYWdlICpzcCwgdTY0ICpzcHRlLA0KPiAgdTY0IGdwdGUpDQo+IHsNCj4gLSBpZiAoIUZOQU1F
KGlzX3ByZXNlbnRfZ3B0ZSkoZ3B0ZSkpDQo+ICsgaWYgKCFGTkFNRShpc19wcmVzZW50X2dwdGUp
KHZjcHUtPmFyY2gubW11LCBncHRlKSkNCj4gZ290byBub19wcmVzZW50Ow0KPiANCj4gLyogUHJl
ZmV0Y2ggb25seSBhY2Nlc3NlZCBlbnRyaWVzICh1bmxlc3MgQS9EIGJpdHMgYXJlIGRpc2FibGVk
KS4gKi8NCj4gQEAgLTE3MywxNCArMTc4LDE3IEBAIHN0YXRpYyBib29sIEZOQU1FKHByZWZldGNo
X2ludmFsaWRfZ3B0ZSkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiBzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIEZOQU1FKGdwdGVfYWNjZXNzKSh1NjQgZ3B0ZSkNCj4gew0KPiB1bnNpZ25lZCBhY2Nl
c3M7DQo+IC0jaWYgUFRUWVBFID09IFBUVFlQRV9FUFQNCj4gLyoNCj4gLSAqIEZvciBub3cgbmVz
dGVkIE1CRUMgaXMgbm90IHN1cHBvcnRlZCBhbmQgcGVybWlzc2lvbl9mYXVsdCgpIGlnbm9yZXMN
Cj4gLSAqIEFDQ19VU0VSX0VYRUNfTUFTSy4NCj4gKyAqIFNldCBiaXRzIGluIEFDQ18qX01BU0sg
ZXZlbiBpZiB0aGV5IG1pZ2h0IG5vdCBiZSB1c2VkIGluIHRoZQ0KPiArICogYWN0dWFsIGNoZWNr
cy4gIEZvciBleGFtcGxlLCBpZiBFRkVSLk5YIGlzIGNsZWFyIHBlcm1pc3Npb25fZmF1bHQoKQ0K
PiArICogd2lsbCBpZ25vcmUgQUNDX0VYRUNfTUFTSywgYW5kIGlmIE1CRUMgaXMgZGlzYWJsZWQg
aXQgd2lsbA0KPiArICogaWdub3JlIEFDQ19VU0VSX0VYRUNfTUFTSy4NCj4gKi8NCj4gKyNpZiBQ
VFRZUEUgPT0gUFRUWVBFX0VQVA0KPiBhY2Nlc3MgPSAoKGdwdGUgJiBWTVhfRVBUX1dSSVRBQkxF
X01BU0spID8gQUNDX1dSSVRFX01BU0sgOiAwKSB8DQo+ICgoZ3B0ZSAmIFZNWF9FUFRfRVhFQ1VU
QUJMRV9NQVNLKSA/IEFDQ19FWEVDX01BU0sgOiAwKSB8DQo+IC0gKChncHRlICYgVk1YX0VQVF9S
RUFEQUJMRV9NQVNLKSA/IEFDQ19SRUFEX01BU0sgOiAwKTsNCj4gKyAoKGdwdGUgJiBWTVhfRVBU
X1JFQURBQkxFX01BU0spID8gQUNDX1JFQURfTUFTSyA6IDApIHwNCj4gKyAoKGdwdGUgJiBWTVhf
RVBUX1VTRVJfRVhFQ1VUQUJMRV9NQVNLKSA/IEFDQ19VU0VSX0VYRUNfTUFTSyA6IDApOw0KPiAj
ZWxzZQ0KPiAvKg0KPiAqIFAgaXMgc2V0IGhlcmUsIHNvIHRoZSBwYWdlIGlzIGFsd2F5cyByZWFk
YWJsZSBhbmQgVy9VLyFOWCByZXByZXNlbnQNCj4gQEAgLTMzNSw3ICszNDMsNyBAQCBzdGF0aWMg
aW50IEZOQU1FKHdhbGtfYWRkcl9nZW5lcmljKShzdHJ1Y3QgZ3Vlc3Rfd2Fsa2VyICp3YWxrZXIs
DQo+IGlmICh3YWxrZXItPmxldmVsID09IFBUMzJFX1JPT1RfTEVWRUwpIHsNCj4gcHRlID0gbW11
LT5nZXRfcGRwdHIodmNwdSwgKGFkZHIgPj4gMzApICYgMyk7DQo+IHRyYWNlX2t2bV9tbXVfcGFn
aW5nX2VsZW1lbnQocHRlLCB3YWxrZXItPmxldmVsKTsNCj4gLSBpZiAoIUZOQU1FKGlzX3ByZXNl
bnRfZ3B0ZSkocHRlKSkNCj4gKyBpZiAoIUZOQU1FKGlzX3ByZXNlbnRfZ3B0ZSkobW11LCBwdGUp
KQ0KPiBnb3RvIGVycm9yOw0KPiAtLXdhbGtlci0+bGV2ZWw7DQo+IH0NCj4gQEAgLTQxNyw3ICs0
MjUsNyBAQCBzdGF0aWMgaW50IEZOQU1FKHdhbGtfYWRkcl9nZW5lcmljKShzdHJ1Y3QgZ3Vlc3Rf
d2Fsa2VyICp3YWxrZXIsDQo+ICovDQo+IHB0ZV9hY2Nlc3MgPSBwdF9hY2Nlc3MgJiAocHRlIF4g
d2Fsa19ueF9tYXNrKTsNCj4gDQo+IC0gaWYgKHVubGlrZWx5KCFGTkFNRShpc19wcmVzZW50X2dw
dGUpKHB0ZSkpKQ0KPiArIGlmICh1bmxpa2VseSghRk5BTUUoaXNfcHJlc2VudF9ncHRlKShtbXUs
IHB0ZSkpKQ0KPiBnb3RvIGVycm9yOw0KPiANCj4gaWYgKHVubGlrZWx5KEZOQU1FKGlzX3JzdmRf
Yml0c19zZXQpKG1tdSwgcHRlLCB3YWxrZXItPmxldmVsKSkpIHsNCj4gQEAgLTUxNCw2ICs1MjIs
OSBAQCBzdGF0aWMgaW50IEZOQU1FKHdhbGtfYWRkcl9nZW5lcmljKShzdHJ1Y3QgZ3Vlc3Rfd2Fs
a2VyICp3YWxrZXIsDQo+ICogQUNDXypfTUFTSyBmbGFncyENCj4gKi8NCj4gd2Fsa2VyLT5mYXVs
dC5leGl0X3F1YWxpZmljYXRpb24gfD0gRVBUX1ZJT0xBVElPTl9SV1hfVE9fUFJPVChwdGVfYWNj
ZXNzKTsNCj4gKyBpZiAobW11X2hhc19tYmVjKG1tdSkpDQo+ICsgd2Fsa2VyLT5mYXVsdC5leGl0
X3F1YWxpZmljYXRpb24gfD0NCj4gKyBFUFRfVklPTEFUSU9OX1VTRVJfRVhFQ19UT19QUk9UKHB0
ZV9hY2Nlc3MpOw0KPiB9DQo+ICNlbmRpZg0KPiB3YWxrZXItPmZhdWx0LmFkZHJlc3MgPSBhZGRy
Ow0KPiAtLSANCj4gMi41Mi4wDQo+IA0KDQo=
