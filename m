Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A78329C73
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125277; cv=fail; b=jJcYHpgBNgw15xj4/6P6CpXGR2jv6m1JhFFEJu7T6XO6TMTOX8re6fGBf/FMeNKraZBSU//JDKj/sW390MBw4YdxxqmbZVOv9JO90vdzBLN4xQsm4Xerqugzit2c1J+H7r/2hU3dlhEOqTzTTJuiDHIdQn/6nKkNZ+HjeDygk2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125277; c=relaxed/simple;
	bh=EO3I8zxUgvYnbJhv/5YeQ8teWCNR01OMy5hwgIwlRtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ssX/1rOCD0Mjo4/J4L8cf9GH1PmZcyRjDWZ1+LpYtWXPeNGQSs25/U6921BrICq8w7rmKVtbyBGrH/lVO2B1HHpWr93XF9RgKFX17rcVKwrhV27Y/+rQuZ4FHuOzFbVGZFFlIIpTZNRGcOJuvkGa/CErRYAYGEqJ0+YbUc7TwKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=xWuOGR96; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=k0MIjg5e; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xWuOGR96";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="k0MIjg5e"
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A6GbR73181755;
	Mon, 9 Mar 2026 23:47:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=EO3I8zxUgvYnbJhv/5YeQ8teWCNR01OMy5hwgIwlR
	tQ=; b=xWuOGR96FioR6OqHU/5GgJBH55eIhuEHyr+z/ESLHltoVWpUnP8UIlH8R
	fR2ETI2LxvxOX4DJ8gc1khkGGk6qumnHcDQap1rlKUTo5/cjdtcAVfOvwik/KPCa
	kkJaNsF59C4K4jIFVTs+1I8jg0QJMjHK0trZbDPDqcxI6lcJhSV9gLnOOCMY/36F
	T9uIOSfQR8JIH9f0Ex0+udHzEA51gbUwty4G1VMVxE+K9Z1GBtEBma+A36Sh/sK0
	nHvMo14F0cO5h1rLpSjxnfI8RqRPYblA01s5FoObnELr3VDtXoiybgtnKuPFHzce
	XWzi/8h44Oe5nPhu4HeD0PiFg1rqg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023122.outbound.protection.outlook.com [40.93.196.122])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4crm7hf7hy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 23:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3Aplj//JDBU5oMhLQjY9PM3lICM8f1qpE+aj/3qcgaDe7mt6FX6iAtjkVJEMaiUcke7rnt+nSuFcYuriqRNJ7PMXm9K1PG6tlswNtul3qFzp3HAjvMiMwIi4fRf0Ulrm7TDIGRI5xA8LYe4K7me1HGZuAyU/vzYplQSg8I8nAgzEVamam2UZTTMWsO4psHZyZqndvl1UEBfSZWWfPXhCzWj//gJ/Ru1xL6TrASspeTijPo3HGhd1s5hUgcz64iOyl2exeB8i+XTWX0D3g2/ViJN5iA4MRWWmIdCuZOMbs5yHTqy6128ydoTo5kO+pK60J2gfLjscla39X8oFTF6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO3I8zxUgvYnbJhv/5YeQ8teWCNR01OMy5hwgIwlRtQ=;
 b=x4hx64prE5ng1Kb4yoQmMqFjYfLr/iIi+DQ6umKFtzXt9nVjx8qr5xHaxQjeEFeSwhXP/DyoUmF0HHA9a6pJAlZNJc4hlBWTK55BFcNFLGbXgwQ2hrzxrfzTa76o1txPT1TkC26w9Fv8qxlL1rD9dbPzqI3T+d703xjPjYhOC28GGTICWbqsgXPbPbXAqJ1r7x13ShQBsXuttzTDgPGEZ4SIUBJWqUSu7t3BhKKMcN4CFiZVXXaWPwRzsr+bPa3gEQ7Z0hVSHWgx+hbqveWP2RAjjFXMY8fR1poMDILSVC6eTG0UrQrtZFjLm0Fz/5qbdcU+8AlJ4+LyHENLw8C13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO3I8zxUgvYnbJhv/5YeQ8teWCNR01OMy5hwgIwlRtQ=;
 b=k0MIjg5e17tsgUQ77QvncxwRD5vl0RJPsURMC9hms7vEmkPN5VF0KPFJtQK4GXyPqMqd56bfT4+4udjBRWzpcIvrkCwcoFffwNXfgy7+MljumFI0EnjOgzua6pkLsoitKLOpn5Ahz2M01eaaY0kJ0Z4CNJOdUS0lCsMC2a7OyXdFNVV0pSYspjnIzLCJF/qX9n2MFtO+9WEUQf4oqYl6QgNbP3oHy6OGwksHoo4x4s3HkElO/l3p1ia78bRSNxfhe0XiPGwCwcb+/7odQPBttraiIhUcUPKUt3zavsyanQ5GqmVUWxX/zIUzUTwhSdurK40+hCLafNtvDtG7kz5+bQ==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA3PR02MB9325.namprd02.prod.outlook.com (2603:10b6:806:311::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:47:28 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%6]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 06:47:27 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Shaju Abraham
	<shaju.abraham@nutanix.com>,
        Jon Kohler <jon@nutanix.com>,
        Mark Cave-Ayland
	<mark.caveayland@nutanix.com>,
        "marcel.apfelbaum@gmail.com"
	<marcel.apfelbaum@gmail.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>,
        "eduardo@habkost.net" <eduardo@habkost.net>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] target/i386/kvm: Configure proper KVM SEOIB
 behavior
Thread-Topic: [RFC PATCH v2 0/1] target/i386/kvm: Configure proper KVM SEOIB
 behavior
Thread-Index: AQHcr4eRycrH35elTkivCISxd/xcP7WltDUAgAAJ7QCAAAYdgIAABXIAgAGKtwA=
Date: Tue, 10 Mar 2026 06:47:26 +0000
Message-ID: <18761E46-D486-4170-B8AC-1DFCB04ACED9@nutanix.com>
References: <20260309054243.440453-1-khushit.shah@nutanix.com>
 <6A894B95-03A6-49EE-91A2-D3BCB09AAFCD@unpredictable.fr>
 <D74B0637-1332-4FC4-B29B-804E5AC18C33@nutanix.com>
 <1279CDB9-C8E1-40A3-A01D-3C53E831989F@unpredictable.fr>
 <EE8967D5-244F-407F-A106-1D14EA066039@unpredictable.fr>
In-Reply-To: <EE8967D5-244F-407F-A106-1D14EA066039@unpredictable.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|SA3PR02MB9325:EE_
x-ms-office365-filtering-correlation-id: 8a9e7eae-c56a-4c05-e6f8-08de7e70e4ad
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 quL2d3AmgcOHj56sxwP+bmNt8EceeP3OFjm8ZB4n8S2u6zF8eu2Cz6p38jKwPUglKmPHF8DOXPUCi0B0kUuZEkPdKd8UcS4DLVpg76deAwD5d70Kt4etr7NupXGdAKU9MsMJ/yHVzEqGzpEvqgAXgGlMj2GjLRCkLtkoY/Zu87BCu4+U4ToSj7azP53FDZjfaqmmxXymGKzYi/BPvUvRocue7QOokiiloXVTJ4IJV/1hsx9fIC9d/oMhyySlnYMiY9kXpTj3wyjlQKjniEjbW9oaHUJmbJV2bGFhV4LRzZa1YMp224AjQxtS+6yCoJdRBrn0bQJIq0J5AOu0o7LJx2I7BctTxaVxtQZTBCKFq+7VHPE7Wvqq0yTkH0uc3K5tekaCvQjEbgq2QzjWHdtSIltirqdL2/jlOcYvZwyIWFdAXj1I6HagbcGR+yR5ijmZNjxMecpJEou2XeTumc8Zhw7uw7LocC3a15rbcVmDC+C0Y5YCKSzDKjTm7Hw3284vj2RINRysY2xl5BmYYrtLG/Q6rc/fXq0htEPLo1/A3xkFMmjZIKXEcRvSC7RreITTTt/v93eEeADrE6sTAtP3ewmP2Z6nvQfl3ESQpeH1EQfYU/e/AWMUoINGHjo8OcyXYB+T3hTRQsnhAeP7JEPWijejKiB2vY1RFVcp6k2Xps6WyZAMzzhMFIQOgg+G+hEna7lKIBKkNxFYMuATVA69/TJPSoG5HmZ4b/LpN/x/QZESP5GETTY6+v2Z4LHmWdcrdNDZQbywjCJWvBmnQ8qOz89PyKh71j3Phuktiubil1U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1paUE1MbEE0NkFDOE9FcjYvZXZNMjVSNnZBbTJKZWFJSFpJSWtwb3htMm9T?=
 =?utf-8?B?bTdrNk9KNTY3bE5TNnU1eVVrMzdKN2g1SzF3c1RwenYvV0F1RlRCckR0b091?=
 =?utf-8?B?Yy9GWlNZdkQxNUozSGVKN01jL1RkcURxSnppb3hnWVkzTVl0YTFjQXBvWElw?=
 =?utf-8?B?cWR6QkhvT2NNbU1zK29MRjB6VWprbDFhSTBxb3hVaVoxdGRzbjNMK2dCaUFu?=
 =?utf-8?B?NGdMNmNCQ1ZVRExvR3cyaVBScjNQNEpCUHdpVmlNQ0ZJY0hVekxOY0FzU3Jz?=
 =?utf-8?B?ZFQ1eUJQV0xjTjFteXlaLzFBQ1hyQStlQXR5NC9LZUdsdjdzS2gzU2ptRGs3?=
 =?utf-8?B?OHdyZEszbnhCak16eHBNYWtPaHNOYlI0OW14ODJUYkZxMHFmNzVLaWozYjhY?=
 =?utf-8?B?VklCNXVZWGZFTzZYck40OHg1WDZJZW11NWlqY0hRWkRubHVjY3N2b1Vod1ZH?=
 =?utf-8?B?MVdBYXRKRU1qTWlYZXZmNTJTR2sydWdBOWhkZmV2SEx2SGo2b2czWGJCZXlH?=
 =?utf-8?B?QnNQUGVPNHlXbXAzT084ZVIxWFNIYkYyanZiMi9UY3lhUnlyenhFdFJmemdO?=
 =?utf-8?B?aEJoc0xOTEgxRy9iT0JpNWZ6QXk1RTQxVVFpTGNxbzEydlhlVFNIQ0tUODIz?=
 =?utf-8?B?OGNqV0p1aFdwZmFWbWEyWFdzSmZhN01FWlZmYk9mSUk0aEY5QzlCWjA1VE9X?=
 =?utf-8?B?TytLSG8wanlBVmQwTnJBV1NiOXFCaWZPSUZiMVcyNzNXZWhBeTRNbXNsandq?=
 =?utf-8?B?K1gzS01tUUZHcEZPS2JTZXZYKy9hNW91OXhKa3JkZ3h5WEVDdll3T0pFYWc5?=
 =?utf-8?B?Zm1mUCtDQ0VoeXZOL3ZHZzZzVDBWWjJFeHkyK3BJNUtlcDZDUGJRMXREMENs?=
 =?utf-8?B?RzZjZ0xoRnJVa05KeUozdUJuMEVaT1o3UXBZU3JMcC9Nb1dQQ00vVlRJbk9a?=
 =?utf-8?B?M2EzZHRlS3lRRGZ6VVROVTl5NGMwSmkxdFYxc2F6LzNxWTk5STRGd0VFRVh4?=
 =?utf-8?B?cXNITXpMcU15WGlGS3dhai9TQ1JraEY1TElSL1YxWVdaS05SZlF6ck93M0g0?=
 =?utf-8?B?MDlJMjYvRWYzSVZsWVp4S1pGVTUxZkswUjdta3hxWTlMb3NXZTRnNkp5SFJB?=
 =?utf-8?B?M0ZZbTJSWU4zcW5ZeGFRRmxqM0JlZFl3TnpWTGRmbWdMdDU3dnI1czdrdy9M?=
 =?utf-8?B?TXFVRHQ0VzB4bHZtRVVMZmlSNEdIcVFDdjhrNWV0bzJINU9qTUdkNml1TGRn?=
 =?utf-8?B?NWpmbnBGdkhmQ1hsSkxTZjJwUjJOczE1c2NmeHMrNjY0blZiNXpnN1pqS3cr?=
 =?utf-8?B?NHE5dGptRzlRMW93M1hUemhuRXYzS0VmekFrWUdtbWhyS3V0YktvZG5QVHNR?=
 =?utf-8?B?UEltR283WFFCeFZXQ3Z4dlEvUVM2UkxGT01Ra3RsMGhrb3JuVjRUK3hlRmVF?=
 =?utf-8?B?elhhOVJOa0tKZVlGTU5yMnV5Mm5IRWNaMVRHdmgvTncvcWVnT0tCRTdhUVVG?=
 =?utf-8?B?QmxKcEpJb09jditJRDBuU0hvMWdRRGJvaFBqcVFGaC9WakErbGVpR2hUZ1hQ?=
 =?utf-8?B?VXJ6cmtkUjcrYStYQ2NoaG5nd1NUcm1OOWlXTkM3NHBFLzBzTm5ZTVoydmdW?=
 =?utf-8?B?QTZYZExIVDlyTEtCT0F0TjZBcWhPSVJ2TmtSVjdBUFlnbUFpS1FLOXRGRFdt?=
 =?utf-8?B?Zmk4UzkrcFUyMk9mYnJDR0dGQUkrSTJzYVFTbGxRbXBCSUplTEl2YkRZQUNp?=
 =?utf-8?B?c2RUK1JkNml6ZG1MZUJTdE1HWmFsYzNsZ2hveS9PV3Z2dEVLUEdXTlVkcHow?=
 =?utf-8?B?MzRzdGpWQXZHUUlJYXZtSU81ZTFBTE1CS1RkOFpSRHlld1B5UW1VbzNsN282?=
 =?utf-8?B?UCtRV09lS0QvS1BqdjFxQXFVNlRMNEh4UjZMdlhScUdOSEZUUVBONjVJTVRK?=
 =?utf-8?B?OUFvbWFMVnV0ODBFZkpZbUtwblBVS2M0UzVpcjR0M0h6R3d5M0t6TldkMG1B?=
 =?utf-8?B?VGJTazFSRldzVVR3U2pRZmFNd2Fad3RLbDgraHVXSkV4bnVVSHM2ci9Ic3Vh?=
 =?utf-8?B?UnUrdmh3dFZhZ3NzVFBPUjVndDNoaDhOcnJJTFhjK3BGTlVNbUdQM3JrZkZN?=
 =?utf-8?B?d3RxS09XTis1cThwd245cEptVzhLanF5VGhPODlLaVJwVjF1M3dGRHRYK1dl?=
 =?utf-8?B?R0g3Y1V0SmxYZ2I5dGFPRjVaV09nTDFNblhBSEJldmdrM3BoZ1Z6K3FLdDBa?=
 =?utf-8?B?RjJScll6WGprSlFJc3RuQVM1aHlhQU8xYWg3TXFUSWFXZW5INkhSRjRzdlNp?=
 =?utf-8?B?ZjZYT1Rkek42ZHFTb2c0Y1MvYjhtWFpVTll6b1I1YTZzaklWei9OeDRXU3Uz?=
 =?utf-8?Q?oG4+VXh9gE+TYUTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA3AAE5063ECE245972BF9BE198B78A3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	j1aKYwMxYywhjsEd3Nmx8iiaydwXfRO3BQJBRDTOJ+9cikVNSwriYHwMJdfMpcC6t0YBDeIXFZ8gQvqzvl2lFFbdPCKJTQqRLaiJOniNWscWCa4si6wMMyjhe0qooi8aSfLBGuBf0MvWbl0f7zTol96Em+FmfvkaTXe3A+r7K9qcyXvFTsRRQUVtdEteMuxoocKgU/760V6t5h7GVP7iRbfMQmJq+INOqIYiV7Weqv8FE6tT+TVYeClo4EMuAdWV/ZuN3Ob0CP0VWMhSQIfjgKCnhjosCOtDzQWfsoXW9FB+HHF3kllqV7/bmo3JNRQbfyACRPjBoJJEoWJ6bTNPNw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9e7eae-c56a-4c05-e6f8-08de7e70e4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:47:26.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32wOu+mv5+9U6tv+R3AeEGOj4DtnrcdX/QBX4y3JJC62cAXHHkHWEGJwD0EL8ixvyD5+L0SGr987twPw6oUe6EMKgF9cjLlziCiJOZOO3hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9325
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA1NSBTYWx0ZWRfX9iZzyb/lLA9V
 djY58Mhf51VM9AJvQZhlXE/S4DGOzqMwadkNv82u3qA0xFIIcIMlJSLEGQFTLRR9OhNl+KOUaSd
 yWr1JZr4OWLfCrzQz8dRTUFztSVMs6jqDmPUkHwqdK203ZpG4tQ9q6vH6r9pZs8zG8E1JozTNR9
 TJwLXLZkj8/6vrKbPa3w55bOhfAZOAr+AJ/Ax9aOCIzHmylMxcG2z3SSEV+hg6Qqy+jHhEkGIc4
 rDsWBO0cYUWyJgMFfrFIhyz43CouKmDnbYSOLRKkekRSB8n+u9zY7OPEjdLsOWdPux6qkPcuFN4
 6E7Rq1vNLvxm0NOZyrEYiAr3D+lC+N+h5tn3O/Lb5l3qwvTsPE6Poz6P37/b9PCDUEMulYhChsn
 roPdAH+eP15ajNHn9N3rdvBKV3uy0tzlYUaE9tG0JW3R1vqeFzm0KjqKIzcdKiq71t13gvRpN1o
 jrigrDlsvAFA/HfLMEQ==
X-Proofpoint-ORIG-GUID: CT9BIEaJYjU3jh1ifvsG2JMLxAW1ie4s
X-Proofpoint-GUID: CT9BIEaJYjU3jh1ifvsG2JMLxAW1ie4s
X-Authority-Analysis: v=2.4 cv=TpTrRTXh c=1 sm=1 tr=0 ts=69afbe82 cx=c_pps
 a=+8ozu11IBk2Dcx/W9SapsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=LpPRjoQVVnQoasUoXi4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gOSBNYXIgMjAyNiwgYXQgMTI6NDTigK9QTSwgTW9oYW1lZCBNZWRpb3VuaSA8bW9o
YW1lZEB1bnByZWRpY3RhYmxlLmZyPiB3cm90ZToNCj4gDQo+PiBBbmQgaGF2aW5nIGEgY3VzdG9t
IGZsYWcgbm90IHR1cm5lZCBvbiBieSBkZWZhdWx0IGZvciBhIGxvbmcgdGltZSBmb3IgdGhpcyBj
b21lcyB3aXRoIHRoZSByaXNrIHRoYXQgYWxtb3N0IG5vYm9keSB3aWxsIGVuYWJsZSBpdCBpbnN0
ZWFkIG9mIGl0IGJlaW5nIGV2ZW50dWFsbHkgcGhhc2VkIGluIGFzIHRoZSBkZWZhdWx0IGNvbmZp
Z3VyYXRpb27igKYgDQoNClllcywgSSBhZ3JlZSB3aXRoIHRoaXMgOi8uIFRoaXMgaXMgc29tZXRo
aW5nIHRoYXQgY29uY2VybnMgbWUgdG9vLiBBbHRob3VnaCwgZm9yIG1ham9yaXR5IG9mIGd1ZXN0
LA0KZWl0aGVyIHRoZXkgZG8gbm90IHVzZSBkaXJlY3RlZCBlb2kgb3IgdGhlIHNwdXJpb3VzIGVv
aSBleGl0cyBmcm9tIEtWTSBqdXN0IHdvcmtzLiBCdXQsIHVzZXJzIHdpbGwNCmVuZCB1cCB1c2lu
ZyB0aGUgcXVpcmtlZCBzZXR1cC4gTWF5YmUgdGhpcyBpcyBmaW5lIHdpdGggYSBwcmludGVkIHdh
cm5pbmc/IElmIHRoZXkgc2VlIHNvbWV0aGluZw0KYnJlYWtpbmcoYXBwYXJlbnRseSBub3QgYWxv
dCwgYXMgdGhlIGJ1ZyBoYXMgYmVlbiBhcm91bmQgc2luY2UgMjAxOSkgdGhleSBjYW4gbW92ZSB0
bw0KcmVzcGVjdGVkL25vdC1hZHZlcnRpc2VkLiBEZWZpbml0ZWx5IG5vdCBoYXBweSB3aXRoIHRo
aXMgdGhvLg0KDQpIbW1tLCBtYWNoaW5lLXR5cGUgZ2F0aW5nIGxvb2tzIHRoZSB3YXkgZm9yd2Fy
ZCwgDQoNCj4gT24gOSBNYXIgMjAyNiwgYXQgMTI6NDTigK9QTSwgTW9oYW1lZCBNZWRpb3VuaSA8
bW9oYW1lZEB1bnByZWRpY3RhYmxlLmZyPiB3cm90ZToNCj4gDQo+IEJ1dCBJIG1pZ2h0IGJlIHdy
b25nIG9uIHRoaXMgb25lLCB3aXRoIG1hY2hpbmUgdHlwZSBiZWluZyBwb3RlbnRpYWxseSBiZXR0
ZXIgaW4gcHJhY3RpY2UgLSBhbHRob3VnaCBpdOKAmXMgd2F5IHRvbyBsYXRlIHRvIGRlZmluZSB0
aGlzIGFzIHBhcnQgb2YgcTM1LTEwLjIgYmFzZWxpbmUgYXMgdGhhdCBoYXMgYmVlbiBsb25nIHJl
bGVhc2VkLCBzbyBpdCBjb3VsZCBiZSBhIHNsb3dlciByb2xsb3V0IHdpdGggdGhlIGRlZmF1bHQg
dGllZCB0byBhIG5ldyBRRU1VIHJlbGVhc2UuIEFuZCBhbiBlcnJvciBtZXNzYWdlIHRvIHVzZSBh
IG5ld2VyIGtlcm5lbCBpbiB0aGF0IGNhc2UgaWYgdXNpbmcgdGhlIG5ld2VyIG1hY2hpbmUgbW9k
ZWwgZXhwbGljaXRseSBvciBpbXBsaWNpdGx5Lg0KDQpJIGxpa2UgdGhpcyBpZGVhLCBieSBkZWZh
dWx0IHdlIGhhdmUgaXQgb24sIG9uIGVycm9yIGhpbnQgdG8gdXNlIHF1aXJrZWQgbW9kZSBleHBs
aWNpdGx5Lg0KVGhpcyBhbHNvIGZpeGVzIHRoZSBsaXZlIG1pZ3JhdGlvbiBzdGF0ZSBpc3N1ZS4g
U28gYmFzaWNhbGx5Og0KDQpGb3IgdGhlIGxhdGVzdCAob3IgbmV4dCkgcWVtdSBtYWNoaW5lIHR5
cGUgdmVyc2lvbjoNCi0gc2VvaWIgY2FuIGJlIG9uL29mZiBieSBkZWZhdWx0IGJhc2VkIG9uIHRo
ZSBJT0FQSUMgdmVyc2lvbi4NCi0gdXNlciBjYW4gZXhwbGljaXRseSBzZXQgaXQgdG8gcXVpcmtl
ZCB1c2luZyB0aGUgY29tbWFuZCBsaW5lLg0KDQpUaGFua3MsDQpLaHVzaGl0Lg==
