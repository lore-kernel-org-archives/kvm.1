Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8E255E43;
	Fri, 17 Apr 2026 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776388997; cv=fail; b=AMDZLMU01xqvs+iAvDUBCcU91+yfZoUVt6t8uKFAkw3/HEFE74eeLOTdSPB3+rOdkGHUtMoS/yuA5hw5+Avho30ngrDsKJn7UycB4ArJ++ogyhT+CAA4RVnT//OEHZgnqrgoc63+x09eqB59cdKL/UoCklGwk9QphkDwGwi2pmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776388997; c=relaxed/simple;
	bh=gOMnBlgJGL+j9xOuAtzKWY/TYHQDRQNCFbZGwL/TN8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1vyAD2AGW8cFZEufXU/gkyY90UDT5PLtYFCtFKDxqG57BKUREb3gFm+vRc388kJVZDjwJUd6TuP+EDVIRyH/JcoHNo3BEWS8P+L3zxxiN5rL4CuS4EKp8KCYoJF5y+Vcg3f4pml6b41o/41UysiHmcSRcH6rSbw0wcNRmoJuhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=SEarQgGO; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Ww1llqwx; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="SEarQgGO";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ww1llqwx"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GMuVmr1821490;
	Thu, 16 Apr 2026 18:23:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=gOMnBlgJGL+j9xOuAtzKWY/TYHQDRQNCFbZGwL/TN
	8k=; b=SEarQgGOwRlN2XbcugbblYiJphAwsubW/+rLw9O6bMBlucvhedRm+ovFS
	gAko4i/EuPbvr5KN4NsrhKJ8qVR4qH0pU0nw+C3ss2zjojDg5wJtrkmPP+wnMf+a
	oVZeAP6CNlDuvQp2ymuwJPuR1xt0/d6Ww+0kj3vQ/xifkpkLOOeuzLT/QXKWwwGU
	WLahEcfdl7pG0TdFxVxWkCc5ee+/Sj1O+S2OvpA6baRIFv1N0G2d5BRfycEW6qh/
	TX5cHsNu+EFOqLz5zcdu9WSayb3sHqBTVl5lUZX54L1ttLDbAHaJ+LlmrhXwXZ0w
	baSuxl8jtkTk1ULuNvhiZKxfDSsRw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021142.outbound.protection.outlook.com [40.93.194.142])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4djm4sb7j3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 18:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j58hEjEz3BhI8nqS1bznT+BEeEPX3fvkxDNZ6kRCrG5Estl7U8LS4iPTkEpZk7AY/U10qxyE+iUp7Jm0AX12wcyh8sS2FyKp0CjHrjVUnEpcTWcJrojclXt7IE5f7WvZOMQ9YXW0wA7GXN2FCswUWAqJPft6DfqRjhw60mKaH27+qyYQLM4RtGo5nbf7Y9FWvmbPjlAa0S0McBx4mk1G6mNYhF4TpHO+/mYhhXF7ud4iGT9qWB0UxSDq1Kk1++B2H9fvP+Qph02SvxRWeeCKirIXy5K2684BM2KEUbdHrwHZ2Ne+bbY0AR8DpRFT3OsJb8lcELEHsktPBoSyrdFJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOMnBlgJGL+j9xOuAtzKWY/TYHQDRQNCFbZGwL/TN8k=;
 b=yTrxP/2NJJEvoeJ+ag6OoBlBs9vZcptLC1xGkt3/gF5PpExW1RZKFUIEkkmNlTzZFgs6S0f+ofDdN3BylqxCUL7HeJ31J7oZDHSxj28Kyf3qb6VLEyhKkHbQrsjlCdMiz/Fb4BDAjQoOoEwKUcZntb0BWt4XzdGwqK5HjX7/DnRkjtOLqV94f9ufWf06jHJ5x2GPdWFufDuTaERzFpQmIiKZCggpJSCOkGVSxq8K27iKmKB5ZRBIEwy0zq9LS/l2toIKgOdTDeu9DkWa2XfjmbTbPYrvykBVJuyuYsjloewfFH2SIkQc72F+gjUKJQfp8GigRCwVLjT5rOkJ8HuyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOMnBlgJGL+j9xOuAtzKWY/TYHQDRQNCFbZGwL/TN8k=;
 b=Ww1llqwxmCdRKBpRY8i14UZziD35cjo/DoQRZlrCT7VUKXUGqw/ZIuFa8b65g3E+tTJUSZMwR0Q1jqeKUnPrpcnGy/RM+EsE0qJ9/tFzGHwOJDqS54TiiuMXE6nZi39B3BpIf+upBu0cjZa+mrKi8OxnY5fgK7gNp94iIqFMJioCqN4s36JDBQZe4lobkJXIyxeWwZWbyCkATnPmTV572K46nLS0ywglULjc3CoxS5tWbkSQjWlTvMXX7lKGDSAncTWNCiXcanBkQJoVxNEFBQFY1IX+sWeFTGemhF1l8qv16hVxH+vV+YNQOfstHcv7/7DaELJML46jF0ym0Xfq2g==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CH2PR02MB6950.namprd02.prod.outlook.com
 (2603:10b6:610:5c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 01:23:05 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 01:23:05 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nikunj A Dadhania
	<nikunj@amd.com>, "Shah, Amit" <amit.shah@amd.com>,
        Sean Christopherson
	<seanjc@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 04/27] KVM: x86/mmu: shuffle high bits of SPTEs in
 preparation for MBEC
Thread-Topic: [PATCH 04/27] KVM: x86/mmu: shuffle high bits of SPTEs in
 preparation for MBEC
Thread-Index: AQHcx25Qr2B9zFx0dUueFTzL8e7skLXigpEA
Date: Fri, 17 Apr 2026 01:23:05 +0000
Message-ID: <B3920345-FF0C-4C24-88AE-420E8AFB31BF@nutanix.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
 <20260408154217.458420-5-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-5-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CH2PR02MB6950:EE_
x-ms-office365-filtering-correlation-id: 0af08200-9587-4a26-451b-08de9c1fe03c
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 KtV4Cfm53wuGx06Pff2xos64CzoTJF86u+Kj/nxtsJr0vEFQebKF4kcGYg/kR7EGYuFGSaq76K89qzmlAUP8jphhCpsYcTuqny1COvUC90/JTHSf8v0ZcsTl98fA4SmzH9nlr9umzYsUBvmtRhMrzy6wF0t+0MB9V4fe3ngPBa4TI+7IfsW4B79ru+84SWl2thYu69RZ90sWIb2hnHD704USJodAzkiHZF5v08m5DSqicVldE83YWM9/QQzyGOpUf2eHKtKPKV4S8wM8TuNgk01WpJ7swKGCgj5iAZvYv67H4uZmeG1S1NROW/9xz3+RVaDC6U71EugCkSwiStQ+xX2YStkeeYn9Y4nX0+0N16OyI0k5i68ikK4AiYgeXJ+/Mur2N+C4ExwHSaE0xkI8JfVBPQcgdXTNY3WJNJUJJefckWoPME7VlBLns7+aZZJzXNxd7C2eaQiNEKA/mUbgdqGzd7aZjsiKj+m22RC1pG4loTPqojafXDmeT+s2JX2aok7hnQgqftzi+G1lQVc8L58nW+v5EoIo6iP7ZtiDx+eGjaaRP+GkvqfU5AafgBGoAGAIdhWxHuq+6HgFX8LawvVp29fmZpB6hK6R4OyDKpMLbzWUZyM1e2laLPneEvLcIX07MFkiqiA9iBL1K4qNlSxNCviZ82t5bVuUroH2H7/6yDevLJ1rqrEX3SELdnEARoeDPLiKSK+1TkqRIbHeaH9BHsHRh+n/3qqKsMppPu8phTmz8NWKXSdQpzRW6dRaHMdKFFIb7fK3Tog9LouMJNl88glm/OuRNrRmIxvNFBc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTNQc3hjZ092RGg3cjJzR2xkL2ljNnc1WkJOdmxReUh0V29KL3BBMjFWVjRo?=
 =?utf-8?B?bkVheHNEcFlGSm0zc214OGdLUWg1VHE0dVFzZno0bGJOMWszWm4zN01jc0wz?=
 =?utf-8?B?czRmNlVqTWxKRis5S1hUa0FucTd1QzROL04rVGo1K3NBUGYwcXhzeE9vdzlV?=
 =?utf-8?B?SHpJYThxVktqKzFiLzI3WXF0SWtrNUFmRDVycERyaDBKbEN1eHVWS3prZVI0?=
 =?utf-8?B?aWFsazBmTklwclVGY0ZBSXFSc3RPTVJqZm1uS3RmdGV6NzN4VXNxaW16YjNB?=
 =?utf-8?B?bzY4S05IN2x2WGttT280dmlFaXBwRXo0UkdhVVRhcDlGU0lpRW13aDhuajlt?=
 =?utf-8?B?WmFNUFpCR1pFZWh0NkhONkxKTXNoemtHaHlTS0tMemZhbGdoaU5sVmZZN0xD?=
 =?utf-8?B?c1piMzFiRnl6Sit2VlV5WUxGOTNiWUNoNGdMTWFid05xL2ErbUNOTjFPbk9p?=
 =?utf-8?B?emRwOVp1NlJ6QkpzL1lIMndudHhGb3EvYTBiZ09ibXFrQkpsY1BLbTVQL1RT?=
 =?utf-8?B?UHdIV2d5N2QxQnl2K09ad0pjVU40Tll0L3JkaXEyL2RvMUw0cG5LM3NxSUgy?=
 =?utf-8?B?SXhMNEY2L202Qlo1OFZqTmlPNFYrSTh4bVAzTHZTSmxjYjR0SEpiMFk1eGNu?=
 =?utf-8?B?OFNIUS9OYitFZWl1WDFuYWhac2ljN2JIazFyUTNuSk12bERlOU9zTm5Welcz?=
 =?utf-8?B?ekdqVXRoemtmYXBiYkJBaWtWNG9aVjNYMkdHNXBvWE8rb2JTRWhLdk84TTgz?=
 =?utf-8?B?WG1qblgyOUJFT0g2cHlEUTh3SUR2Ti82cEdsRjFDMTVYWHhWL0hwYXNOdi8x?=
 =?utf-8?B?N2lZVisxckJNZlVyZzc4Wno0UmxsdUl2VlN3UUlYeUVnNHd4Sm1pRVJ0dzlK?=
 =?utf-8?B?Tm03VzlLcHBlcWpRN01xbzZMZ2tJZ1JianpmWmtyWGplN2dCSFN1NVUvQWU4?=
 =?utf-8?B?WUdsYmllOXExTnM3MG1EME1lN0JBQm9VSHdha1FqQ2JYUXBlS05xNWI3L05v?=
 =?utf-8?B?MGtaN0xidFpYVmpzMVpuZTU4SmprL2k3dU1HeU53SHkrSDByRng5ZDY3bFRO?=
 =?utf-8?B?S0NqU1A4SGhYcmRKQzdEVlhRS1hwZEZUZ09kSzRUWkk0bzArWUNDUXFBZTFE?=
 =?utf-8?B?Z2l3V2FuTFQ3TVdDSk5PUXFUSjI2TW4reWNrdE9HclB0b01qRVlaRW82RWtE?=
 =?utf-8?B?VzVuTDhIUzVKL0pvdndnZDZSWXpWemM4djhYTlUzeCtsZllVYklFdnFTLzZI?=
 =?utf-8?B?NURWWDNHK2djcWZ3bmlIWVJsckF3NENwNkR0UU45RXlwWkhuYVlNaWV3OW9S?=
 =?utf-8?B?OFFTQUtTS0Y4MlVMRUhOcnNvb2NwYlVLV0FoZ2RBMGIyMG5NYW5GZXpVTU1u?=
 =?utf-8?B?SHRCL3VFTHFWK0R4NktYeDYrMVlOdUhxdExPU016OHFhZytXVzgxSHRFenBT?=
 =?utf-8?B?TUtWWUwra0x0TXNxeFVVQ3laVThwU0wwWHZYbnJ0aDhJV0FCQ0M4T2FiQWZk?=
 =?utf-8?B?WXV3ZUtNNmtIczhrLzR3RHBEc0t6cm5LMmpTcU5CeFJsOEVYRXBCWUY1bmtL?=
 =?utf-8?B?Z3U0UHlncEJaaGY0NVhueWJDNVIyc0V1THpoN3Z4NVhXeXJMYWJueUNkYnk4?=
 =?utf-8?B?cFVDQUJXNElIZW8xWGlvSzlIUE5XdkYxRnFxYWhYQ0JRdjFkeDFzcEZaMU1v?=
 =?utf-8?B?VEZYL1MvWE5iOG1KWXhVMGJNaDNGRUdJSVpJaHFtMWF1NUE1NWk5Q0swZmpX?=
 =?utf-8?B?cm9lbkYxMS85Z1V1aGtvT2swS3ZWdHk3R3pKZE9aM0w2TjNTV1JTdGdtWVZW?=
 =?utf-8?B?aFhjTlBwMlBCRXA2RTYvd1E2d1FwdW5oWnBDVFduK3c4VFJwZkFCL2ZjMjRU?=
 =?utf-8?B?aEdFTEJMUHNRRWhzWG1PREhieWhLVVRGdzhLcFZ4R1p0Rk5sTGRvWVlSbS9J?=
 =?utf-8?B?ekYyMGozMk1RcEFnWWtCNkhUc3JqR2lkS0FmbEZXVG4wbElNMlJjT3pITVJO?=
 =?utf-8?B?bGs1dGNPb1RrRkh2bC9DeHFkTFB3UWZUVXBtODYvanZoTitNVmlEbUNZcWs1?=
 =?utf-8?B?Nm5BVm9HcEpQam5kcUdoT0RlMmszamNtMXUwUHVLL2JjSU5HR2dlaCsrZzFS?=
 =?utf-8?B?OVo1b1FGYzdVaVZoQmRocUIwZWhFRXIxQ0tuQktEdndJb3FnZFR5ZW9UclRk?=
 =?utf-8?B?V2tEeGp5NXdkU2hiYlcvR3ozSGUwSDQ4N0ZpSHFYTnR6OE9sZUlRNTUvdkZC?=
 =?utf-8?B?OHRXVHowKzNLNHJJaWNkSkNHUHJhbmFubVJmZEIyV2pLUGxuaVhTWlRWSWRz?=
 =?utf-8?B?c0xjbklTTVRHR00vQlM3K05KbTAwL3QzbUlxRFI4N2VaY095WU1ncm82U2RG?=
 =?utf-8?Q?q4q2V+eZg/cV+Trt6Qa4OFyW8p5036KDL9MtpqDp8oT/p?=
x-ms-exchange-antispam-messagedata-1: 3/1LGNG4l2PiveRzHqZt/pkYP69JFlH6soY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36D312842D41F24FAC8E38BDE3B473DB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	G9xw+owLvr/mJ4ZsfyJdmGEKDKAK6YYp9yTY7C7bGLKLB74zhHSJaD4aBnpVZaMIXAgQCBSXoiGZDroyp7nCCbdh9Qy1M1TZANTixlPa78+TC3002lY+bj9jIzUD5xs8z0MOmrjRflraOHhtAR7ShngnwSoKLJ1QcHGBDUeXsvK9NNN8qepl48Tx+opoKRF+DlWLl+mtjZk0Tb8FA1+NcmpE5dI+shnSmjjdr9h4mdR32ovvdIzzUpASnHPti2z7s+3zyY1CTVBQdvuC+h8SjF4oFTSq+evi3GTPtFaeZo7rXXg0l0ML+drlISo3ruyknRbrlXegJEZJIMiWZoPa+Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af08200-9587-4a26-451b-08de9c1fe03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 01:23:05.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UG4G1yGwQpHSLHTy9uoOcpodbEyyJNVxlq4stUdraMY8DNE2MI+A7+APFm7QIWkLJh4StZTFUVnVTeOpQGAckCIb+efnx0BKjilteUVfIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6950
X-Proofpoint-GUID: OqjVD8OJuf1Ah2aiuKPFjFltsm75Bg10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAxMiBTYWx0ZWRfX2waZjGiivHvc
 sULye9jZZEMNs2nK9o+BYJ55W8CCdVKzdoGR22w4iYexwtwkHoYO1mXklIJEmTWJKMXqD879ETt
 MnTmZr4V1iBhrf7Uq4ORLQHEQLcDveLaUXLqO6u+t5RGGN1LqTZN6Jd2qP9TLeEL5pczd1yTkNg
 JU7c1fXFlYeP9Z0X7lGb70yTsCRVxMbY/7JmEoHoHVVtRdLKQmSXtPd4lyUWZUiDk1qUG+fIg7J
 oap0efhZVQfEM3U4E29e91DAWGED5VMPSWhom2alC7XU2MewuSjWgnIJHRoJbtQbvzGE4uoLUk+
 YRi33KDjHwSJo4cHZXR1IDENzlf+CmCdMPQg78+JMcmkogDbopO5glrhajU0RyojyQHdwLpye/D
 XbsYmp4U5VA2trHKVluUO0gDWlMLfstfoDUOgnahB09yDuhD34AG64NkTGzNBKadNn7JIb1talc
 yoqW5mNakKbd3kLJgaA==
X-Proofpoint-ORIG-GUID: OqjVD8OJuf1Ah2aiuKPFjFltsm75Bg10
X-Authority-Analysis: v=2.4 cv=R+4z39RX c=1 sm=1 tr=0 ts=69e18b7b cx=c_pps
 a=0LNrXYcIMabMz0p9jkIKmA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=20KFwNOVAAAA:8
 a=qYRiaHvKgZu_pv3Q9LEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDgsIDIwMjYsIGF0IDExOjQx4oCvQU0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gQWNjZXNzIHRyYWNraW5nIHdpbGwgbmVlZCB0
byBzYXZlIGJpdCAxMCB3aGVuIE1CRUMgaXMgZW5hYmxlZC4NCj4gUmlnaHQgbm93IGl0IGlzIHNp
bXBseSBzaGlmdGluZyB0aGUgUiBhbmQgWCBiaXRzIGludG8gYml0cyA1NCBhbmQgNTYsDQo+IGJ1
dCBiaXQgMTAgd291bGQgbm90IGZpdCB3aXRoIHRoZSBzYW1lIHNjaGVtZS4gIFJlb3JnYW5pemUg
dGhlDQo+IGhpZ2ggYml0cyBzbyB0aGF0IGFjY2VzcyB0cmFja2luZyB3aWxsIHVzZSBiaXRzIDUy
LCA1NCBhbmQgNjIuDQo+IEFzIGEgc2lkZSBlZmZlY3QsIHRoZSBmcmVlIGJpdHMgYXJlIGNvbXBh
Y3RlZCBzbGlnaHRseSwgd2l0aA0KPiA1Ni01OSBzdGlsbCB1bnVzZWQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiAtLS0NCj4gYXJj
aC94ODYva3ZtL21tdS9zcHRlLmggfCAyMCArKysrKysrKysrKysrKystLS0tLQ0KPiAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rdm0vbW11L3NwdGUuaCBiL2FyY2gveDg2L2t2bS9tbXUvc3B0ZS5oDQo+
IGluZGV4IDQyODNjZWEzZTY2Yy4uMzE3YjljZDE1MzdjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni9rdm0vbW11L3NwdGUuaA0KPiArKysgYi9hcmNoL3g4Ni9rdm0vbW11L3NwdGUuaA0KPiBAQCAt
MTcsMTAgKzE3LDIwIEBADQo+ICAqLw0KPiAjZGVmaW5lIFNQVEVfTU1VX1BSRVNFTlRfTUFTSyBC
SVRfVUxMKDExKQ0KPiANCj4gKy8qDQo+ICsgKiBUaGUgaWdub3JlZCBoaWdoIGJpdHMgYXJlIGFs
bG9jYXRlZCBhcyBmb2xsb3dzOg0KPiArICogLSBiaXRzIDUyLCA1NDogc2F2ZWQgWC1SIGJpdHMg
Zm9yIGFjY2VzcyB0cmFja2luZyB3aGVuIEVQVCBkb2VzIG5vdCBoYXZlIEEvRA0KPiArICogLSBi
aXRzIDUzIChFUFQgb25seSk6IGhvc3Qgd3JpdGFibGUNCj4gKyAqIC0gYml0cyA1NSAoRVBUIG9u
bHkpOiBNTVUtd3JpdGFibGUNCj4gKyAqIC0gYml0cyA1Ni01OTogdW51c2VkDQo+ICsgKiAtIGJp
dHMgNjAtNjE6IHR5cGUgb2YgQS9EIHRyYWNraW5nDQo+ICsgKiAtIGJpdHMgNjI6IHVudXNlZA0K
PiArICovDQo+ICsNCj4gLyoNCj4gICogVERQIFNQVEVTIChtb3JlIHNwZWNpZmljYWxseSwgRVBU
IFNQVEVzKSBtYXkgbm90IGhhdmUgQS9EIGJpdHMsIGFuZCBtYXkgYWxzbw0KPiAgKiBiZSByZXN0
cmljdGVkIHRvIHVzaW5nIHdyaXRlLXByb3RlY3Rpb24gKGZvciBMMiB3aGVuIENQVSBkaXJ0eSBs
b2dnaW5nLCBpLmUuDQo+IC0gKiBQTUwsIGlzIGVuYWJsZWQpLiAgVXNlIGJpdHMgNTIgYW5kIDUz
IHRvIGhvbGQgdGhlIHR5cGUgb2YgQS9EIHRyYWNraW5nIHRoYXQNCj4gKyAqIFBNTCwgaXMgZW5h
YmxlZCkuICBVc2UgYml0cyA2MCBhbmQgNjEgdG8gaG9sZCB0aGUgdHlwZSBvZiBBL0QgdHJhY2tp
bmcgdGhhdA0KPiAgKiBpcyBtdXN0IGJlIGVtcGxveWVkIGZvciBhIGdpdmVuIFREUCBTUFRFLg0K
DQpOaXQ6ICJ0cmFja2luZyB0aGF0IG11c3QgYmUgZW1wbG95ZWQiIChkcm9wIOKAmGlzJykNCg0K
PiAgKg0KPiAgKiBOb3RlLCB0aGUgImVuYWJsZWQiIG1hc2sgbXVzdCBiZSAnMCcsIGFzIGJpdHMg
NjI6NTIgYXJlIF9yZXNlcnZlZF8gZm9yIFBBRQ0KPiBAQCAtMjksNyArMzksNyBAQA0KPiAgKiBU
RFAgd2l0aCBDUFUgZGlydHkgbG9nZ2luZyAoUE1MKS4gIElmIE5QVCBldmVyIGdhaW5zIFBNTC1s
aWtlIHN1cHBvcnQsIGl0DQo+ICAqIG11c3QgYmUgcmVzdHJpY3RlZCB0byA2NC1iaXQgS1ZNLg0K
PiAgKi8NCj4gLSNkZWZpbmUgU1BURV9URFBfQURfU0hJRlQgNTINCj4gKyNkZWZpbmUgU1BURV9U
RFBfQURfU0hJRlQgNjANCj4gI2RlZmluZSBTUFRFX1REUF9BRF9NQVNLICgzVUxMIDw8IFNQVEVf
VERQX0FEX1NISUZUKQ0KPiAjZGVmaW5lIFNQVEVfVERQX0FEX0VOQUJMRUQgKDBVTEwgPDwgU1BU
RV9URFBfQURfU0hJRlQpDQo+ICNkZWZpbmUgU1BURV9URFBfQURfRElTQUJMRUQgKDFVTEwgPDwg
U1BURV9URFBfQURfU0hJRlQpDQo+IEBAIC02NSw3ICs3NSw3IEBAIHN0YXRpY19hc3NlcnQoU1BU
RV9URFBfQURfRU5BQkxFRCA9PSAwKTsNCj4gICovDQo+ICNkZWZpbmUgU0hBRE9XX0FDQ19UUkFD
S19TQVZFRF9CSVRTX01BU0sgKFNQVEVfRVBUX1JFQURBQkxFX01BU0sgfCBcDQo+ICBTUFRFX0VQ
VF9FWEVDVVRBQkxFX01BU0spDQo+IC0jZGVmaW5lIFNIQURPV19BQ0NfVFJBQ0tfU0FWRURfQklU
U19TSElGVCA1NA0KPiArI2RlZmluZSBTSEFET1dfQUNDX1RSQUNLX1NBVkVEX0JJVFNfU0hJRlQg
NTINCj4gI2RlZmluZSBTSEFET1dfQUNDX1RSQUNLX1NBVkVEX01BU0sgKFNIQURPV19BQ0NfVFJB
Q0tfU0FWRURfQklUU19NQVNLIDw8IFwNCj4gU0hBRE9XX0FDQ19UUkFDS19TQVZFRF9CSVRTX1NI
SUZUKQ0KPiBzdGF0aWNfYXNzZXJ0KCEoU1BURV9URFBfQURfTUFTSyAmIFNIQURPV19BQ0NfVFJB
Q0tfU0FWRURfTUFTSykpOw0KPiBAQCAtODQsOCArOTQsOCBAQCBzdGF0aWNfYXNzZXJ0KCEoU1BU
RV9URFBfQURfTUFTSyAmIFNIQURPV19BQ0NfVFJBQ0tfU0FWRURfTUFTSykpOw0KPiAgKiB0byBu
b3Qgb3ZlcmxhcCB0aGUgQS9EIHR5cGUgbWFzayBvciB0aGUgc2F2ZWQgYWNjZXNzIGJpdHMgb2Yg
YWNjZXNzLXRyYWNrZWQNCj4gICogU1BURXMgd2hlbiBBL0QgYml0cyBhcmUgZGlzYWJsZWQuDQo+
ICAqLw0KPiAtI2RlZmluZSBFUFRfU1BURV9IT1NUX1dSSVRBQkxFIEJJVF9VTEwoNTcpDQo+IC0j
ZGVmaW5lIEVQVF9TUFRFX01NVV9XUklUQUJMRSBCSVRfVUxMKDU4KQ0KPiArI2RlZmluZSBFUFRf
U1BURV9IT1NUX1dSSVRBQkxFIEJJVF9VTEwoNTMpDQo+ICsjZGVmaW5lIEVQVF9TUFRFX01NVV9X
UklUQUJMRSBCSVRfVUxMKDU1KQ0KPiANCj4gc3RhdGljX2Fzc2VydCghKEVQVF9TUFRFX0hPU1Rf
V1JJVEFCTEUgJiBTUFRFX1REUF9BRF9NQVNLKSk7DQo+IHN0YXRpY19hc3NlcnQoIShFUFRfU1BU
RV9NTVVfV1JJVEFCTEUgJiBTUFRFX1REUF9BRF9NQVNLKSk7DQo+IC0tIA0KPiAyLjUyLjANCj4g
DQo+IA0KDQo=
