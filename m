Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.151.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793176357;
	b=wBa7YanRglB4iiP1zTEqpp0RCwh1RPVP960PEzRE+LzQVrYHvlNTerEeAzkh4vWWWXtI
	 DZL9flONFSQDdOeP7j5Kd/ANw8YOEZ6B0mgUNqCJB9qbLLF2p/uqLK+ZRwYVX+7ULN+Lc
	 ft9igs3/5CquBdXDxwsinpAM5jU3xj0sQssOd6epSSkamAeGTp4OQJ3tFLZnYVYFhRrYz
	 /4aS9oIfZgWvwWJozAGPlc0KmOzMU80cyizpGvLZiUC40IHkhAox/uBOA/dHKw100SeQ2
	 gq0FlCykuN8Jjf3IGeAdii7nEBYsqCQ5W3H4PUJdXIDnfnAxs16K7cGXJr8xStSPDmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-proofpoint-crosstenant:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Reason;
	bh=U6qMGZI+6Kictp7OjwounXrilNIg+okvyTaf9i3kNBM=;
	b=s/FQtC25XugsVsF+nn8hCeeSYj6NrtjDLlr9BJW64i360lYKWO/f8/DiMzL8F0eY5aZH
	 GbfZElj2Kr8UaCJgAgWov0YLodNexE+QQx4yFuckD0BZs1+UvWmKXqDZxgwfnCNyuF7Jx
	 iuIPwYwfcr4UyAnebXOFWWWEW9VBEJSQvk62e6XUEZGXW+N8ZVGQu2ukFdKBsykW9mDEA
	 mwIW4KcNXUCeFYAnPoBKjza29irpCq2Jii1Ml4Q4FJNzX/DzNf9uQprWgypom7mOOvtby
	 KBwzrUlHXWL5Dy9SU1BUDX3RnjitNSB7G7ETa+AAt6j17cesV878+cG8DcU60A5HTbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nutanix.com;
	spf=pass smtp.mailfrom=nutanix.com;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=WUpHZPZA;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=CaZDWTZA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.151.68
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A1606A31A;
	Wed, 28 Oct 2026 08:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 547A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=WUpHZPZA;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=CaZDWTZA
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8IAGk1705545;
	Wed, 28 Oct 2026 01:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=U6qMGZI+6Kictp7OjwounXrilNIg+okvyTaf9i3kN
	BM=; b=WUpHZPZAgzB42JVXbPm7XqcwBUytqBIh4WkKoRMbrYvzZKh603KpuW2Xv
	wpavNi0ZQA6xgUj0H9msG3T/vgTZNCkAn2RxVjKR9Ahb+RxTL/dYQ0nyQWszCYht
	177JGk5Gmq1SMDZOElsZW0ca22x+FanPJUytAfwlmGYfRAuQrTmk9uSOkaLj3Bkc
	OK+fkYpbiVuf7fOe2gcIY35vAzdMppYA7RQehjs/ssM1wfRW6E962995Xxd7lgP6
	m/s6w/FNlBq605IJA/ZN3N7vCfKjXpwwEzd7sulCT3gTKCsiMolEhfZ2K+AkCiQR
	BLXxYjErw7aP2WBZpFpuYvXi5JhLw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hk40k957g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 01:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhKfjtmzHyQCR+n/tYtpSf+buyZOEDqbcs7dQ4muJaucq0ie7+qI8u0dhtKpW8IucTq2i2zP71Lkw+wSy+sdf3mEeUgzQbCyx59zCpOr7CvRcLQGpqwnOznnZ8NHboDaVhjJlT8ot8NgvdCOF+Q+lj7FKvW4nplHMv+j1QAqzb1cgA47QEyaNCcQWYONqzzvw69BizTOuAMRG9kXwyx5rkdJSly7o/bgfL1dphaEKV+pfyLWTsEeWvgZijk2QeR9C/Jifc1xK2J+yMadG45jCe3cvyQYDGfrvu2XjrJE4JVR4eprZzbvDTDPU2S42e3cEYfnEs06K3Y7aDTEjcye3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6qMGZI+6Kictp7OjwounXrilNIg+okvyTaf9i3kNBM=;
 b=aej3CJ85NEGPJcukYDC9hFQ6/qxiC6yFDTvDIF3rizw+zPqor0GI4JOqHZbPZVRri6JhKKE55tUMC3xDn/cCFRHKUBfa3WelDwNCLU1EzvdHJF7EIKdqfQSG1yDNt79QNo6g/D56GQVSWX/eTAQ93vaXiIsRqex9+xW7M9hQrR2aKN+vdiX4M96+NmyIPY8Mu9EhN55Rvpqt2DMsSznMbxE4LcejBltEoCWhEuxsre9DMVMz7cFj+eLUjhEw4Zfut4lo1MBcVS66UEed9hKHzXVKEFTaG8ey5/XLxe+7FAkKi1CEgKF1bYY5++t8iDT0zxN3o2iVv87qO5bJuy3Uow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6qMGZI+6Kictp7OjwounXrilNIg+okvyTaf9i3kNBM=;
 b=CaZDWTZAnYKqYrL4CmohypJ9E4masWVVzSl6EzbLwhajmmvRiI41CJ+vUNm1QUKAo5dTQiflvgIuUJpWMuE0BEpfQC3RLm4ybhbTgsjIy0OcLg2A3N88Tw/WvBDcJYXCRQ8XfSgNT90AjKdLKxVqf0HW7vVFFmQ7dluC7dz3bGImVwT7TB3fsJbdHUVREiU43aZdGwDvVzo0L5H6ji9SI1peaSuncfrVz8zgHw8Bh0wjyv9MNZgWSYZeUUKlbNfi7plbY4AoWvDgfzfSlFBKwEuAU5uUunpxWd13dd7gvxoBuDjwyoZOQdUFWYoUqgvdlp/0f2BJ5TzPa8Fadd+Rtw==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by LVUPR02MB11563.namprd02.prod.outlook.com (2603:10b6:408:38b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:32:33 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:32:33 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH v2] KVM: optionally post write on ioeventfd write
Thread-Topic: [PATCH v2] KVM: optionally post write on ioeventfd write
Thread-Index: AQHdZj5QxZfCLEMxlEOFylWgMTLaDbcRtwiAgADqLeA=
Date: Wed, 28 Oct 2026 08:32:33 +0000
Message-ID:
 <IA0PR02MB9462FB83108FF848B8BBFD2A8B6F2@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <arK05GrLtiBvbfmm@google.com>
 <20261027180903.1008-1-thanos.makatos@nutanix.com>
 <sashiko-outbox-187032@kernel.org>
In-Reply-To: <sashiko-outbox-187032@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|LVUPR02MB11563:EE_
x-ms-office365-filtering-correlation-id: 99bf0b55-c3f1-443c-baef-08df34ce0322
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|261026135527099003|18002099003|22082099003|261026140227099003|4133799003|261026130827099003|38070700021|5023799004|56012099006|261022075727099003|4143699003|261021123027099003|261021130227099003|261022105027099003|261021121427099003|261022115727099003|10067099003|261009223027099003|261022113327099003|261021135927099003|261021133027099003|261026121527099003;
x-microsoft-antispam-message-info:
 lGIRlHLBCYJsAhJdnqI6xGuBqMJn3Mi7G2WFv0QfpqupijoS03vbFyc2NTKAu1hWUltc9gkibhsZ73hYTQtK680N6Ar1CY2279CHs59RPoy9SlPYEaX7miFxZh178JBOayVKgrOxkA6eB5mpXB3ZUBFF1qRdLsuDQp/KbxPa4W7Cm3LVkJbdIBAnENJy4x+D0KN+MCVDLtjF/RZ7GMLvuU/6UTEynT7GXCfT1ZX/QvNv21tJcywxzKVxo1+dPM6oLAGBXu9I7oK7MfyPt87d5VXJcBeBvqLipe+wXLM0uTh69o+AtQUzPVnhdyqCRJEIfu+AIvfwP0pOL5BzoSUrei6ECRCH6A5LHz8StVHjDpBCOF5JrN53q5AsTLfd4BbitQThWC1Emah0Bp+F31Jtqm0BcTouHLr60w5y18xfBN70VfY+X31B8wwqjwcsUeeu8uPTchoq7PE/KXagttBOKZ2ZQiECmfCSi2/dDXNggcrhsfRHsd9drk94fczFBhLhAHoi+lYUKBK3nzi/sffL7kFMVzT/apA/+IPSu0XX+W4xqOOz2aPEJ03iKofXUj635GHurQBpKFkF3f3R8AmThPqqS65JwAxxMf0xBqBiCAzRCsJMATfd3VwelXIlF0WhI1AGO4OBj5vn59A4Hg2OsphcnOHbWdDMDmUTIP7TjK4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR02MB9462.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(261026135527099003)(18002099003)(22082099003)(261026140227099003)(4133799003)(261026130827099003)(38070700021)(5023799004)(56012099006)(261022075727099003)(4143699003)(261021123027099003)(261021130227099003)(261022105027099003)(261021121427099003)(261022115727099003)(10067099003)(261009223027099003)(261022113327099003)(261021135927099003)(261021133027099003)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THhLa0NMaXVJUmZhK29JMkR0MWsza3Z3NnhORnNJaVFDT1JONGVUZHkyTzgv?=
 =?utf-8?B?U0JLbmo3T3dYSGUySHZHUGQ1ODdPYk1hRGJMenY0ZU1nVm91cXpaWFZLbzZD?=
 =?utf-8?B?Q3gvYyt2Q2JPcG8vc3grYTkyOGpYeHpBRTRKVkhhWjY4SFRaWW9XMVZ4dU1n?=
 =?utf-8?B?QUs1aDUxUG9pbDhhaVFMcGNKblJrZ2t6M1VyZ1Y2S0JjRDNkcWxVUWxvaWVE?=
 =?utf-8?B?bHYxamhqRHYzTEFDYVNkVW9LbUY2aUkvSG90V0RTWm5CWmJGVTlDSEJZb1Rx?=
 =?utf-8?B?V3FuQUZXSllVZmpWOStsb2VCS2dOY3Vad1BFVUg2Yy9WZXJKYkg1SEl6ZFFY?=
 =?utf-8?B?bFNIaFB1WDhWMXRhRFEzektOdkliTDcvY0M0RTBDZ0FlWVF6aTYwaXVnRzRr?=
 =?utf-8?B?cmdoY0Fqc29PU3Q4cDBjZC8zS0FIR0xURmRta01JZG5Yb2o2L2dKY2dJcEww?=
 =?utf-8?B?QXBUVlFTTEZBRlExVkx3K0grQVB3dXBDV09TaERZQUxrNkhVYnJEeEhhdThu?=
 =?utf-8?B?UHpuZXFSTEI2TGpQTkdTdnNvUmkrUHRVQ1BCVmJXRWsvRlJjWXQzUndBdzFO?=
 =?utf-8?B?aXVBUFpaY1Jubk1ralR4T0xBYlNENlIwZTRENjdHT2t3RXZIZ3lBNkh0UFQv?=
 =?utf-8?B?LzY3WjZRbktDTXpvK0l1UmJqTEpQeEFrT08xbGdkLzVubWQ3bmYwa2VOTHg3?=
 =?utf-8?B?VjFtNjRJa3A4SGVUR1Jub2JyUjArNlNWQXh4bURHc2pSUFp5cFVuWDJITEI1?=
 =?utf-8?B?TGxtb0lMcmV3RUxBVnJOQmdkN0tPd2ZQZUtidjk1Q0lCYzBnUzlQL1Bra3Nk?=
 =?utf-8?B?NWl1NWRobXNJbU5SNm1JdzdGTnNlZXNTeVFSRmNQMlN6b3AxQURMZzh1dXVi?=
 =?utf-8?B?eE1TekdiT1NYNzJ2RjNRN21sYXV2eG10SFB2UUdvdmx2am1ucXZyblVqZ2x2?=
 =?utf-8?B?TlVHVDlJQmRKaURkeFJWemV3S08vT04reHlwSktkY1VUbC9EWnNhY1J3NDhQ?=
 =?utf-8?B?YTJ3dDVvSlNZNUJCL1RvQUlOR0ovcVF5MHZhRllockljZ0JxTUZ4K01zR1NZ?=
 =?utf-8?B?L0s5MmpQYWp6YWQzRHVDQlFtR3dtTEtyK2srS1dEWWQrc1NKQWRiTXNFS0Ur?=
 =?utf-8?B?WlFvckZMQkxjaGxsYjRDdE9YamZ6RkVybWFaMTBWMmFyd2ZwTThQMEJWSmJH?=
 =?utf-8?B?YjJtVFFEdmxEZC9QTkRYMTFQTENSVW1YVVhjZ0hiVHFmVlByNGwzbEZiVWg1?=
 =?utf-8?B?Y2dvQ2d5OVNKWkxmRWZPazRxR0NxWFRuUW1ZYTAxcitmTTJmWUc4V2VIcmta?=
 =?utf-8?B?ak41Qk13eWdIRkVHSllJN203c3hlNGRsYTFaNHVKSDhpVDlvb09ETzF5WVlN?=
 =?utf-8?B?K1JBN3o4UFM3UUFOOUxqdGMxa2hoSGo0VlFxU0ZPMWVzNW5DV2xUeEQ5RGNJ?=
 =?utf-8?B?TWw3dzBrYUg0YVJuWTJQdmtCbk9BNGpscmNZMDBXRVhPb2JZTHltdUgzOTdh?=
 =?utf-8?B?TnJmVk5jQjZ3dzdvRUxiU2lIYm41YkpobWlKNEh1V1BLSUsvQTVienYzMFAv?=
 =?utf-8?B?a3RpMU9RNmRFejNGNDF3dlVQWG1VV3hRQTlmdTdLNWY0eHUwYkhaa0IrNDk4?=
 =?utf-8?B?NnVNWEJja2dzei9YUUZiQ0tCUURPNzg0cnkvTkprYlNjaTRWb280R2dmZTNE?=
 =?utf-8?B?VHpUTWRTenlFR1FsUkVINmU1dVQ4cTQ4WmNDRHVPbW8vaWw4cERzRXhtcjM1?=
 =?utf-8?B?bHYwVjNXUFFoT3FGcTU4RnQ0UFFCQ3RZaGIwWjJ1QmVrOHRybWhkdGhTbjZW?=
 =?utf-8?B?UUxkckc3NFBidW50OHArWWJNaWsvRjdGSnZ0ZmdIckZwRlZxcGxsQmQxTWJ4?=
 =?utf-8?B?aHZMRWZqOFV3WnM5cU1lRVJweWxxdTJDQVVScWlOYlVoQzdHVVFlNVJyblkz?=
 =?utf-8?B?K3VBejkxeWhLYTA1S091L0ZxSW1xWk1ManUzalRoU01COEdGb2FOVENPOWFD?=
 =?utf-8?B?RVErS1pZWllHY3RCL3F1LzQvSXJONzdGK0RucVJpaGVxTXNsWE5KbEJGbEFz?=
 =?utf-8?B?TUU3NUlUeThVYkVEWTFrKzFKaEVhbisrai9adzRXLzh4L3Z1V045RHVocW52?=
 =?utf-8?B?YUh6TTFESHQ1Y0VGU1AyTVJsUWIzcXBMTkRacHZpSzJacG1RMkw1VEVKWklV?=
 =?utf-8?B?ZTF6dk93bzc5dm03NDdSNU9VVW84bzJlS1J4S1AyY3lDNVhScjVhSnJyMDRN?=
 =?utf-8?B?UGExdS81MmhVSlA4TWtBQmtEdXN3RDJieGlwVnpXOTNjbUVzMUJVRE9Xa0ty?=
 =?utf-8?B?UVEzUG5qdEVUZUZiT2l3YXphbjRmd0lTWXIvVnEvUVp4YjZtRnU0QT09?=
Content-Type: text/plain; charset="utf-8"
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
X-Exchange-RoutingPolicyChecked:
	d3kL7quzO5bbb1yJc6Pg7Ke+Qpe+97Drw4Nlc7o3Jnw6j3W07begSz+uwUzZ9OQ+59Yv0R0VKvIE4V3w7mZ3cTFzc3WEw6/6cXnYU4YrL+813F5IjyCd7KLkax+jhn9qdw5KoLetuYIqIee6zNik2QQPrzkAOR4xc+fluyEkfsJsBxhkA8njysFqAs6NgYLv3qyyU3Y7czKUzwnaom10ZLi1x92GMJLgEPDEZ5FMWzB6TQxKwOqBNIitOpxe4QyzLTUuFN7YVnGc8MqkOjUC1bv5Cd73JTFlbtb7fNgxKh7LmJOewvsN1EOAII7XZ8De6F8JT33nrzVxSxaylrZSqg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bf0b55-c3f1-443c-baef-08df34ce0322
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 08:32:33.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wjaRBXGndBPNbSdc6JfO9Go8zE8RNsSSt2sjcprt5AjfpJANjqm+dhwdAzSYflMPFz3MkTj8z0Q0L2klrwuBmrQXB7sPAcVsUMUtQ9zSkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR02MB11563
X-Proofpoint-ORIG-GUID: 6aLNScpfvDRpIUZsZ0pbxYuPMtxcQm95
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMiBTYWx0ZWRfX0TQGO3+tr5QY
 LGh0Jumh/24Qlkl3SoKvUUU+v1NGtKTqsOt2j/w7SG5GN8wdanThkFHTszQUJHpAw+TOf1ug2/V
 HphU4LdVtfnzXRmNDMMDvoZ1ObkwBvA=
X-Proofpoint-GUID: 6aLNScpfvDRpIUZsZ0pbxYuPMtxcQm95
X-Authority-Analysis: v=2.4 cv=F5DC5ahN c=1 sm=1 tr=0 ts=6ae1b323 cx=c_pps
 a=ATTLtrtrxPgGSLD8O921vA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=RIQUCeFnAlq5k2OyaXoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMiBTYWx0ZWRfXw5V2kJe4ob9r
 9/tnAsQpcT2S+kKEa/B0U9JiGBmOB+5D8z0v1ggJ79RFVoLezEyNpy8eYKigIJ5CXuezIYMCdJF
 4BHv9H/EwKSydUZ8sIqdRZBpluw4qNs6sIeekY4DfpFiRxG7+Xfl4dpAQcfNoFR+MyyqqEtVBqq
 Nm2vjP+RFy32uzzOPi6HeqvRzTvIdvSQxosM06s9R48IL12EqhHSst5u4HYFe45hSib/GIDFikI
 p7t2i6vmdW5DqP64SHll8P7/tWxa24GRnWsyw/RRF9QssNTK8YPq+ybQKahXJRGjN1uSRaR9U9N
 uXzCZ5vOo8pJ4lBpFSz7fktV7hm410qiyI6JkGCRmPiJoOYiP8GRuPT/fCZVKk8qz0Qsm2HVWCu
 kMwtjJoP+IHOMsoPX1SkBVKWidBlmhtXCDWqDWQyAi2GbGQUwIs5DW0MLUEGYihoN57V/g6GGwb
 HQru3Wn2Gno4VxYGW9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtvLWJvdEBrZXJuZWwu
b3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIwMjYgMTg6
MzQNCj4gVG86IFRoYW5vcyBNYWthdG9zIDx0aGFub3MubWFrYXRvc0BudXRhbml4LmNvbT4NCj4g
Q2M6IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gS1ZNOiBv
cHRpb25hbGx5IHBvc3Qgd3JpdGUgb24gaW9ldmVudGZkIHdyaXRlDQo+IA0KPiBUaGFuayB5b3Ug
Zm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlh
bA0KPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVkaXVtXSBLVk06IGV2ZW50ZmQ6IHJl
cXVpcmUgbmF0dXJhbCBhbGlnbm1lbnQgZm9yIHBvc3RfYWRkciBpbg0KPiBrdm1fYXNzaWduX2lv
ZXZlbnRmZF9pZHgoKQ0KPiAtLQ0KPiANCj4gY29tbWl0IGM2Y2Q3NTE5ZTdmM2JkM2FmMzI0NTk2
YTM0NWY0YjM0NmVhYzM5MjkNCj4gQXV0aG9yOiBUaGFub3MgTWFrYXRvcyA8dGhhbm9zLm1ha2F0
b3NAbnV0YW5peC5jb20+DQo+IA0KPiBLVk06IG9wdGlvbmFsbHkgcG9zdCB3cml0ZSBvbiBpb2V2
ZW50ZmQgd3JpdGUNCj4gDQo+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgS1ZNX0lPRVZFTlRGRF9G
TEFHX1BPU1RfV1JJVEUgdG8gY29weSB0aGUgdmFsdWUNCj4gd3JpdHRlbiBieSBhIGd1ZXN0IG9u
IGFuIGlvZXZlbnRmZCBNTUlPIG9yIFBJTyBhY2Nlc3MgdG8gYSB1c2VyLQ0KPiBwcm92aWRlZA0K
PiBhZGRyZXNzIGJlZm9yZSBzaWduYWxpbmcgdGhlIGV2ZW50ZmQsIGFsb25nIHdpdGggZG9jdW1l
bnRhdGlvbiBhbmQgeDg2DQo+IHNlbGZ0ZXN0cy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3ZpcnQv
a3ZtL2V2ZW50ZmQuYyBiL3ZpcnQva3ZtL2V2ZW50ZmQuYw0KPiA+IGluZGV4IGY0M2I4YjI1YmM4
NTQuLmIwZjJhNmI0M2UzNTQgMTAwNjQ0DQo+ID4gLS0tIGEvdmlydC9rdm0vZXZlbnRmZC5jDQo+
ID4gKysrIGIvdmlydC9rdm0vZXZlbnRmZC5jDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC04
MTEsOCArODE5LDM2IEBAIGlvZXZlbnRmZF93cml0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0
cnVjdA0KPiBrdm1faW9fZGV2aWNlICp0aGlzLCBncGFfdCBhZGRyLA0KPiA+ICAJaWYgKCFpb2V2
ZW50ZmRfaW5fcmFuZ2UocCwgYWRkciwgbGVuLCB2YWwpKQ0KPiA+ICAJCXJldHVybiAtRU9QTk9U
U1VQUDsNCj4gPg0KPiA+ICsJaWYgKHAtPnBvc3RfYWRkcikgew0KPiA+ICsJCXU2NCBfdmFsID0g
aW9ldmVudGZkX2dldF92YWwodmFsLCBsZW4sIHVuc3VwcG9ydGVkX2xlbik7DQo+ID4gKwkJaW50
IHI7DQo+ID4gKw0KPiA+ICsJCXN3aXRjaCAobGVuKSB7DQo+ID4gKwkJY2FzZSAxOg0KPiA+ICsJ
CQlyID0gcHV0X3VzZXIoX3ZhbCwgKHU4IF9fdXNlciAqKXAtPnBvc3RfYWRkcik7DQo+ID4gKwkJ
CWJyZWFrOw0KPiA+ICsJCWNhc2UgMjoNCj4gPiArCQkJciA9IHB1dF91c2VyKF92YWwsICh1MTYg
X191c2VyICopcC0+cG9zdF9hZGRyKTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJY2FzZSA0Og0K
PiA+ICsJCQlyID0gcHV0X3VzZXIoX3ZhbCwgKHUzMiBfX3VzZXIgKilwLT5wb3N0X2FkZHIpOw0K
PiA+ICsJCQlicmVhazsNCj4gPiArCQljYXNlIDg6DQo+ID4gKwkJCXIgPSBwdXRfdXNlcihfdmFs
LCAodTY0IF9fdXNlciAqKXAtPnBvc3RfYWRkcik7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWRl
ZmF1bHQ6DQo+ID4gKwkJCVdBUk5fT05fT05DRSgxKTsNCj4gPiArCQkJciA9IDA7DQo+ID4gKwkJ
CWJyZWFrOw0KPiA+ICsJCX0NCj4gPiArCQlpZiAocikNCj4gPiArCQkJcmV0dXJuIHI7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICAJZXZlbnRmZF9zaWduYWwocC0+ZXZlbnRmZCk7DQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiArdW5zdXBwb3J0ZWRfbGVuOg0KPiA+ICsJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiA+ICB9DQo+ID4NCj4gPiAgLyoNCj4gPiBAQCAtODcyLDYgKzkwOCwxOCBAQCBzdGF0aWMgaW50
IGt2bV9hc3NpZ25faW9ldmVudGZkX2lkeChzdHJ1Y3Qga3ZtDQo+ICprdm0sDQo+ID4gIAlpZiAo
SVNfRVJSKGV2ZW50ZmQpKQ0KPiA+ICAJCXJldHVybiBQVFJfRVJSKGV2ZW50ZmQpOw0KPiA+DQo+
ID4gKwkvKg0KPiA+ICsJICogRGlzYWxsb3cgcG9zdGluZyB0byB2aXJ0dWFsIGFkZHJlc3MgMCBz
byB0aGF0IEtWTSBjYW4gdHJlYXQNCj4gPiArCSAqIGEgTlVMTCB1c2VyIHBvaW50ZXIgYXMgIm5v
IHBvc3RlZCB3cml0ZSIuDQo+ID4gKwkgKi8NCj4gPiArCWlmICgoYXJncy0+ZmxhZ3MgJiBLVk1f
SU9FVkVOVEZEX0ZMQUdfUE9TVF9XUklURSkgJiYNCj4gPiArCSAgICAoIWFyZ3MtPmxlbiB8fCAh
dTY0X3RvX3VzZXJfcHRyKGFyZ3MtPnBvc3RfYWRkcikgfHwNCj4gPiArCSAgICAgYXJncy0+cG9z
dF9hZGRyICE9IHVudGFnZ2VkX2FkZHIoYXJncy0+cG9zdF9hZGRyKSB8fA0KPiA+ICsJICAgICAh
YWNjZXNzX29rKHU2NF90b191c2VyX3B0cihhcmdzLT5wb3N0X2FkZHIpLCBhcmdzLT5sZW4pKSkg
ew0KPiA+ICsJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJZ290byBmYWlsOw0KPiA+ICsJfQ0KPiAN
Cj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IFNob3VsZCBrdm1fYXNzaWduX2lvZXZlbnRmZF9pZHgo
KSBpbiB2aXJ0L2t2bS9ldmVudGZkLmMgYWxzbyByZXF1aXJlDQo+IGFyZ3MtPnBvc3RfYWRkciB0
byBiZSBuYXR1cmFsbHkgYWxpZ25lZCB0byBhcmdzLT5sZW4gdmlhDQo+IElTX0FMSUdORUQoYXJn
cy0+cG9zdF9hZGRyLCBhcmdzLT5sZW4pPw0KPiANCj4gSW4gRG9jdW1lbnRhdGlvbi92aXJ0L2t2
bS9hcGkucnN0LCBLVk1fSU9FVkVOVEZEX0ZMQUdfUE9TVF9XUklURQ0KPiBkb2N1bWVudHMNCj4g
dGhhdCB3aGVuIG11bHRpcGxlIHZDUFVzIHdyaXRlIHRvIHRoZSBzYW1lIGlvZXZlbnRmZCBjb25j
dXJyZW50bHksIHRoZQ0KPiB2YWx1ZQ0KPiBhdCBwb3N0X2FkZHIgcmVmbGVjdHMgb25lIG9mIHRo
ZSB3cml0ZXMsIGFuZCB0aGF0IGlmIHRoZSBjb3B5IHRvDQo+IHBvc3RfYWRkcg0KPiBmYWlscywg
dGhlIGV2ZW50ZmQgaXMgbm90IHNpZ25hbGVkIGFuZCB0aGUgd3JpdGUgaXMgcmVwb3J0ZWQgdG8N
Cj4gdXNlcnNwYWNlIGFzDQo+IGEgcmVndWxhciBNTUlPL1BJTyBleGl0Lg0KPiANCj4gV2hlbiB1
c2Vyc3BhY2UgcmVnaXN0ZXJzIGFuIGlvZXZlbnRmZCB3aXRoDQo+IEtWTV9JT0VWRU5URkRfRkxB
R19QT1NUX1dSSVRFLA0KPiBhcmdzLT5sZW4gaW4gezIsIDQsIDh9LCBhbmQgYW4gdW5hbGlnbmVk
IGFyZ3MtPnBvc3RfYWRkciwgc3Vic2VxdWVudA0KPiBndWVzdA0KPiB3cml0ZXMgaW52b2tlIGlv
ZXZlbnRmZF93cml0ZSgpIC0+IHB1dF91c2VyKCkgb24gcC0+cG9zdF9hZGRyOg0KPiANCj4gMS4g
T24geDg2IGFuZCBhcm02NCwgYW4gdW5hbGlnbmVkIDItLCA0LSwgb3IgOC1ieXRlIHB1dF91c2Vy
KCkgc3RvcmUNCj4gdGhhdA0KPiAgICBjcm9zc2VzIGEgY2FjaGUtbGluZSAob3IgMTYtYnl0ZSBv
biBhcm02NCkgb3IgcGFnZSBib3VuZGFyeSBpcw0KPiBzcGxpdCBpbnRvDQo+ICAgIG11bHRpcGxl
IG1lbW9yeSB0cmFuc2FjdGlvbnMgYW5kIGlzIG5vdCBzaW5nbGUtY29weSBhdG9taWMsIHNvDQo+
IGNvbmN1cnJlbnQNCj4gICAgdkNQVSB3cml0ZXMgY2FuIHRlYXIuDQo+IA0KPiAyLiBPbiBSSVND
LVYgd2l0aG91dCBDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVEX0FDQ0VTUywNCj4gICAg
X19wdXRfdXNlcl9ub2NoZWNrKCkgaW4gYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS91YWNjZXNzLmgg
Y2hlY2tzDQo+ICAgICFJU19BTElHTkVEKCh1aW50cHRyX3QpX19ndV9wdHIsIHNpemVvZigqX19n
dV9wdHIpKSBhbmQgZmFsbHMgYmFjaw0KPiB0bw0KPiAgICBfX2FzbV9jb3B5X3RvX3VzZXJfc3Vt
X2VuYWJsZWQoKSwgd2hpY2ggY29waWVzIGJ5dGUtYnktYnl0ZSBpbg0KPiAgICBhcmNoL3Jpc2N2
L2xpYi91YWNjZXNzLlMgYW5kIHRlYXJzIG9uIGFueSB1bmFsaWduZWQgcG9zdF9hZGRyLg0KPiAN
Cj4gMy4gSWYgYW4gdW5hbGlnbmVkIHBvc3RfYWRkciBzdHJhZGRsZXMgYSBtYXBwZWQgcGFnZSBh
bmQgYW4gdW5tYXBwZWQNCj4gcGFnZSwNCj4gICAgcHV0X3VzZXIoKSBwYXJ0aWFsbHkgb3Zlcndy
aXRlcyB0aGUgZmlyc3QgcGFnZSBiZWZvcmUgZmF1bHRpbmcgb24NCj4gdGhlDQo+ICAgIHNlY29u
ZCBwYWdlIGFuZCByZXR1cm5pbmcgLUVGQVVMVC4NCj4gDQo+IDQuIE9uIGFyY2hpdGVjdHVyZXMg
c3VjaCBhcyBNSVBTIChkb19hZGUoKSBpbg0KPiBhcmNoL21pcHMva2VybmVsL3VuYWxpZ25lZC5j
DQo+ICAgIHdoZW4gdW5hbGlnbmVkX2FjdGlvbiA9PSBVTkFMSUdORURfQUNUSU9OX1NJR05BTCkg
YW5kIExvb25nQXJjaA0KPiAoZG9fYWxlKCkNCj4gICAgaW4gYXJjaC9sb29uZ2FyY2gva2VybmVs
L3RyYXBzLmMgd2hlbiB1bmFsaWduZWQgZW11bGF0aW9uIGlzDQo+IGRpc2FibGVkIG9yDQo+ICAg
IGFic2VudCksIGFuIHVuYWxpZ25lZCBwdXRfdXNlcigpIHRyYXBzIGluIGtlcm5lbCBtb2RlIGFu
ZCBjYWxscw0KPiAgICBkaWVfaWZfa2VybmVsKCkgd2l0aG91dCBydW5uaW5nIGZpeHVwX2V4Y2Vw
dGlvbigpLg0KPiANCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly91cmxkZWZl
bnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fc2FzaGlrby5kZXZfLTIz
X3BhdGNoc2V0XzIwMjYxMDI3MTgwOTAzLjEwMDgtMkQxLTJEdGhhbm9zLm1ha2F0b3MtDQo+IDQw
bnV0YW5peC5jb20tM0ZwYXJ0LQ0KPiAzRDEmZD1Ed0lGYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0
R2NnJnI9WFRwWXNoNVBzMnpKdnR3Nm9ndHRpNDZhdGs3MzZTDQo+IEk0dmdzSmlVS0l5REUmbT11
MHUzTHJ0bjBNNFloeldfNG42Yl9PTXhuYThlSE5QS3NORTYtDQo+IE9pVXgxMWZJUmY3REJKRWNo
d1YzZEttNV9IaCZzPWZkSUxjTUd4NjV3c09qTUFjRDZvakJ1cVp3RXM3ZmxXNW5SRXFMYy0NCj4g
TkxzJmU9DQoNClJlcXVpcmluZyB0aGUgYWRkcmVzcyB0byBiZSBhbGlnbmVkIG1ha2VzIHNlbnNl
LCB3aWxsIHNlbmQgYSB2MyBzaG9ydGx5Lg0K
