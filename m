Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9752FE075
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627046; cv=fail; b=pT0w5KhXiDy0yhb+ZGIQZLpT4mcuKQ/ArX5yft0U7RZsSKDRzbsNXoriDvbsm6uA0SfcWAYpLu7QljHrYvlFCHI54SxWskA/4hPBF3r5r+NZNFL2CcaCxWiFjkcoCiQZFSUfxjx6rmsUAq21XYWfPugP3M+YlCqFdMGLO9RmPoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627046; c=relaxed/simple;
	bh=F1nlUYIe61C7rY0vH6mExfSTLtHxLKAbfbi3CaNCc50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GjqO3lD9ZSQaHq2OhgeiEaAKuwMkgK1FtXXnl2oiIJxnTN0FF8b0lWPbxDyDuesUynLT7Jbghk9Hlo+ZeVtr6FKmfN+c/E0uGchLSO/mP52K9mMJDrpHqaKuosVQJmhgtupVU/xfI3mXRaXafFnyVQ6U8P/ozsKNthg8wFh2ge0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=j6maH78c; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=u/2td05w; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="j6maH78c";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="u/2td05w"
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QLWT1Q2587691;
	Fri, 27 Mar 2026 08:57:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=F1nlUYIe61C7rY0vH6mExfSTLtHxLKAbfbi3CaNCc
	50=; b=j6maH78cb+qgn+DN/r9cq676yKWKG5BiYGc8KLIeyb4AhMD6s3GD+eOnQ
	IE2avS8azyTnzH/Pu0yCT1wr8XVL03uHzmcbHhawmkPRG37puoM0EI0REcqWiJ27
	gdD/8Nqz4YUxOgwm84UQe9F3CSmkenfmMg7vdFySRWphg6zWNGY40JINDlU0ixqe
	MwBuKuys4WmDf2WX+cWeHzcDK3fWr6WKvZFrX8GeXYgar0P9e4Ldx6ALoy3Hv8lb
	B3r28kPgCOvPhqp/C4/OixV/4Bq3Bg9d40xtkeCGvrkxaQQrMeReC+6JnSBe/KUh
	P0nTmrzgUeaMqx8U7igqika1J0FrA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022110.outbound.protection.outlook.com [40.93.195.110])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d4auaxx91-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 08:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqpUS1sWLLEhj1vOi/qKxa/dkFmFcQNHDD3VHpK5+CmM3iZ6fD+PbtM7xXyIk7QN0tbrwgo1TvpqdQ8u+ksOUvNeqfgSjiT3UMfCQuhuaeLt87QwyYEWm9rtbSqxfYYNUPfQCjSJ3wavg+zBivWx2mg3avnmuS/7k/qDIJOvOqyEEyc24Z9c3upfbWALBkynelQzbpOwqnqpDl5jZpJvra54FdbPOqFXsaH0ZAd554ZjqR0eWyHa7VrBZHjvkCVhu0Q5p5O/mUq6AKN5yZeoL8r7zAR9+ZjqhWdcfPpiV/g9TIYkTsPGhSG/mFXPIxnmiUjd1rkArSegS9F54MlsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1nlUYIe61C7rY0vH6mExfSTLtHxLKAbfbi3CaNCc50=;
 b=lrSPBjsDuf4g/2Wse27mq+4QDSWwGbkqzD1Oiz2opMhswbMcGjNt6INa5WW6cWK1eCB2Whdfb9TA1JfsLf3UG/7FovzO4FtGvRuxDoic5ttaPKZ2c/U3y/5xq1xIJcPbK76w2XENlBt4fmXtO+0IaUR4elsa/h1YGAXCgrYHD4AG5lcxBhF5h5iC4uItJKET6kyjDwp9nIdzr/idLYGfI9OWFTAmQjL8UsOlEx9UN2RDpByqq8xia7mQotvgNLDFgsA7mo3LrgIwJ1JT+PmuMNMzDHSEL79rFowBlb85SJl89ivU9ZyW6DSul6nfxCyZ5yKBV49/rlH4FOZwmhWVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1nlUYIe61C7rY0vH6mExfSTLtHxLKAbfbi3CaNCc50=;
 b=u/2td05wCve6rruJGOJkMTaxL3ALqEXto9A9z7iH8gEcEvaRX2tkc6kgE+CPu9imqEAbWXvF83AYxoa3djoUXehReHNPBIVUqwOXpAJmu7lmEKHXXX9vxPIkIVfRZoadK7tDITN83dASMhGQ/jljArjLNDbwPLcvWdfiYVg3Zs9w1Oz8d0aCsqElqvRyjE4WI98iyqRQmziHFOCjbgprNmPVx8A4pzFuK7DTxSWlDVrdgIAcozjpc5ZreQ4lAEd3eBC20LNuQODvQ1pz6RjdVdTDotRKYXhtGCbsbMH0OGvulT5YTNs2iR9wkAuAKMmmmgStPJkO8Ov4qcaf4Yy5Wg==
Received: from DS0PR02MB11138.namprd02.prod.outlook.com (2603:10b6:8:2f7::17)
 by SJ0PR02MB7774.namprd02.prod.outlook.com (2603:10b6:a03:323::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 15:57:15 +0000
Received: from DS0PR02MB11138.namprd02.prod.outlook.com
 ([fe80::c2e6:9a7:5b0f:384a]) by DS0PR02MB11138.namprd02.prod.outlook.com
 ([fe80::c2e6:9a7:5b0f:384a%4]) with mapi id 15.20.9745.024; Fri, 27 Mar 2026
 15:57:15 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nikunj A Dadhania
	<nikunj@amd.com>,
        "amit.shah@amd.com" <amit.shah@amd.com>,
        Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH kvm-unit-tests 8/9] x86/vmx: run EPT tests with MBEC
 enabled when available
Thread-Topic: [PATCH kvm-unit-tests 8/9] x86/vmx: run EPT tests with MBEC
 enabled when available
Thread-Index: AQHcvS/ytaReNdpYEkK7ZzccSrQfj7XA/JWAgAGNwQA=
Date: Fri, 27 Mar 2026 15:57:15 +0000
Message-ID: <6E3F86F1-5777-4445-9833-48E52B197F9D@nutanix.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
 <20260326145035.119519-9-pbonzini@redhat.com>
 <0c3f5ab5-05be-4ef4-b16f-84e5f27fe540@redhat.com>
In-Reply-To: <0c3f5ab5-05be-4ef4-b16f-84e5f27fe540@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB11138:EE_|SJ0PR02MB7774:EE_
x-ms-office365-filtering-correlation-id: 454d6211-1306-4034-9c21-08de8c198415
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 IwQqZkm07UvNbXkjbBmuoXE++whmOoHyBq0VhS0zJHyRNCJxVv7P4d7K1AWb5smI0QjWGB/1BZZiqG5O/mHMJdSRY+kYZDKAQr+ShDT79SQoFmmxdj1/0GrK9FbsDAKrQZUts/h6HSxMsTPIdzn0wKFaU7IF1ulLYTj7T/so4oZkaoXFyDrncYNy2cqJFa70MIET7f06B4POph1L2oX0nizAJuFbyItlcY8VrLdRJNgFXTfNXQVF4JiDxhDs8shJGprq/UysFN+IYHFfPC4ki85D6nRKpMcDpYtEuAOyn0h5RntS10gDyOL4h1hv2fowwmVmDr6ACtevqWybX3oD/1BLVw8/gX7uHdMZubwOeaBCHamFkmwL9c7o0cq0fsljE0Z3mXZ6rckOxBszBSaH27C9PF+XwhceWTOkueL7BVLv75FsPnZsvD+U8CC1OxhTPlnpFJI/CgnlZ1SGJFGNvMZzeeLGMeXmQOgjvqQtM1rPQ9kKOXgxWiZ5AXCa++wKZPfUojs+c6sqRqBgVgXzxjXCNfVxBYC2GwSzNWMm8mmXNFTmM34kgMmRnXNbKkq7tSU3SBErcNgmlSDHxfBK9mTu21z70/ERBwfJHb0RdcAeo9Ry5oxpb1Ug0dTiN+DYqLpVFHMlJ+/ev5Xf6gKL9qeqwUntXsgWCI/AgObGSK+gC+qOFHZ6wGOAgYo3ymfBI99H30v7nbDb/LE2FDpyvmSAJbR3Pld1vaQZbZGtDoWj6LsU+HVGqcGRNTCIceErxmV5l0Gm8eds1OelnmLOfy71all7ewswE36e9DdwVcs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB11138.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVh3Zks5YnpsMGxXSWVMVUR1bnlZZnBjcjdVb2JxMUpTRTNHUmc1T3RxZ1Bp?=
 =?utf-8?B?ZDEwSTkySlpYSTlpdU10Qlp5eDhKTHByN01mV0dHSTV4MHdpYnZBUHRRME9T?=
 =?utf-8?B?OXB5cGZhYSttSXdDWngvT2VRVHVYbVErN1IycnYzbzEzdTVsaGNrLzhuNjVW?=
 =?utf-8?B?QkREMmJwVG43VVlaWmp2b09VdnUyK1JyejFrbGQrbUgwV3JLbEd1UlowemtF?=
 =?utf-8?B?d3dFUXJFSURleXFJMHVhak9YMmErelFNYjJtNStFOFlrbDV2Y29pOUcrQ3oz?=
 =?utf-8?B?d0RpZjAzMjJIa2c1dkg4UlB4U3dZbi9Bc0VLVWN4TW14WUFvMW1UNXRKMFlm?=
 =?utf-8?B?blgvdytuM1l5dnNPNys4WHV3RisvbW9yaWdOTlp0M05lRWZ5RTFiNXRnKzJL?=
 =?utf-8?B?L21SZ0lBckZMRjF2bkN4SFpiMFdIbVBKVFBoSStFQWRDVm1LaU9GZWlucUxx?=
 =?utf-8?B?bzFnYTM2QW9EQ3QvbVlITjIybkRpN2o4d3c3RXlHRXExaG9ucS9BY3c4Lzdp?=
 =?utf-8?B?dHNQWEhNeWNrNE9nTkxEZE94SGl2NmNJTGhWbkpOWVR3SkpFZ3JnRGZ6L1F6?=
 =?utf-8?B?bEJmcEx5QUJSSTdYRml0RC83OGtVSWtTdCt4OWtGRHVVT3lXNy9lbnFBSUtB?=
 =?utf-8?B?aVFXZytHTEJFeG5POHQ1N3RxT1lidVhFaXlrOXBadEtGZFg1QnZWd1puTk1n?=
 =?utf-8?B?SnhwRlk2MmZXV2RDUEJkNmNkN1NNT1dTbFplNUdqR1dZY3pMaUhjSXF4WWQz?=
 =?utf-8?B?Zksrd1pmREYwWGxsdTFHU1R1MFk4Zmp4b2MrdTl4WlNycUFoaEdpNWZKQXJK?=
 =?utf-8?B?dmdxN3JXRmFmVUR3UmFFU3Z2M3R4QzBQQXFhQ3dhZzRDY3dSUXVjbVpTTk5E?=
 =?utf-8?B?T0k1T04yaDFhYTBkM0l6ak5sWnRtay9lWGRaTndMM2ZjbGNXTGlFN09CMHly?=
 =?utf-8?B?c1h1VHNObjUvS2VBTHA0bEFXakJJcHU1RHJyWFhFQUMxcStSaXMwb2UwdUVH?=
 =?utf-8?B?ek9JdTFRbWJpNEUxNDlMeVdMUzVOTDU5T2dLdDZoN2QrTFQrTURrc0NOTWhX?=
 =?utf-8?B?V09jZ1R6bFhuTWlTT0NkZkkybXpxdGtBaHVZMjcxdXhHbVZiNWRhaUI2OXJ5?=
 =?utf-8?B?Z3ZwOGhRUHcrVHAxWVZkOVk1UldBWVpGSjRtc1phNnMxV1QwZmNMSEFrNkZa?=
 =?utf-8?B?WkdjZHpsWDZXWmFBaitjZjkvUXg4S2VuNHVJQit2eG94V3p0YVFybERmRXhm?=
 =?utf-8?B?eXpvNVpaKzBES0NFSlRMdkVzenlRY0dXMHFDNDBJVjZGWDRyV2J5WXVndTlR?=
 =?utf-8?B?L0R5bVNlbHBFYXd0eUdQQjNqK2s2T2Rja292YWtPdVJvRDU0R2RWd211TS9B?=
 =?utf-8?B?RW1UUzlDeUhML0tWa2c4VnUvZjRjejB0T3hKejNObFNVelBSUkhJWFJZWklz?=
 =?utf-8?B?MytxQ0dPMkFOaHZqZXRYdzhSU0tPc0lZSitpektQYnRBd2g1T203dG5GdnF5?=
 =?utf-8?B?dWp5VnY5MFRRNlVnNzB4Q3U0dXhzWVV2T3B5L05VNXhobWNjQWhEc3hINTF1?=
 =?utf-8?B?aEhpMWMyYVBsclR4akFDeHNQMFdNN3FOSGJEZTlaNlg4T09wcXRBSUJTdml0?=
 =?utf-8?B?QW5tZWFINFd6VVVLaHpUdWZrZ0M4aUxrQlduRHRvRHJtWlU2cWhJTW5ZblVK?=
 =?utf-8?B?UXQzbE5NeDBEc3pDdTNWaFJXeW5YV1dQY2FaNVZTS2RLVzhmckVoYkxsdzRH?=
 =?utf-8?B?anlEQWYyYzYwNWtvdFRMd2pQZE5Xa0NwRVR4NGJCdUdsS1dtdCtWeExyVU1Z?=
 =?utf-8?B?WEJxQU5jZkdhazd5c1IrNHZDS0hoTlhIdEZxWE13aFk2c2FSUnRFR2tnYm15?=
 =?utf-8?B?bVNFTUgxSWQ1NDc1ek1KSTdFcEZQZjFvYjZlaExTRTVhR09hTWVyTko3RjEw?=
 =?utf-8?B?WE1HZy9MV2g1MTdpRmNhMFFRbjgvMnU4QVB3TUdzdzJySk9xSjlBdmFoTW1l?=
 =?utf-8?B?WkVNYzliVUVIREFGNTlRNGMwK0JmRUxaZDMyOXJQS2NtUnc3SUNpN1BsMG96?=
 =?utf-8?B?RzI1emhQL25aSzRPYnl6aityTkRrTHY0S1BVM1FYNi9nSmx6WHF1NFdjSDZx?=
 =?utf-8?B?Y2praWxPdGUrdHdNZUQwSitjdE1ZVlpERDY5N3p4VjgwdGFSbmRKb1EyWkxR?=
 =?utf-8?B?YldTZ2gxVXVFSjRXS0xkU1N4L1htclZpdDR1NXhvb2hEaC9INC9rWUtSSVRl?=
 =?utf-8?B?UGJRcm9vMExFN0plaWg4bkZxOTZJOTM4ZHhtSWVQTDBzbXV3L3JKTDFNM2pk?=
 =?utf-8?B?bkV2WGdCUmFBSkpPUGZFWFZCNnpjOVh6TVN6ZHU4RlRlWXk2eFpCSkZJR3FF?=
 =?utf-8?Q?194L8OfwL2/7T5kZ/wGwU8It50l80whMRvpDxleE8Tt+n?=
x-ms-exchange-antispam-messagedata-1: 3pFnlgroxJ0LnV6JEOI3zRooXbIh7udyx2g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FFDAD2A2F3311438FF79E5629B89B4A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vRE9Rm72bJsRE+G6cpjjlvg+Fe3blu/9cNOHLHQWSRmnKcWqIM2ybB/jf0tZhUJl9cz3wEjKhZAjs9AvPZrmyZ5FN1HXLMAe3si98mhVrdosWbJiv56+ylXL3sk4g+MuJdQaA0KM69dwcwmjShIOHKI1tjdabRbke+dbrfj0wJoQFb1d5lTwdroEbXcrVRxZYS7A3u7xMDEjh7/3D+IaP4UmxQKW9SqmhfheDaizrQeHtNR6rfZNq7Y2yE1zNWmf+2sVdSfidkRj5/lYCDlo1XoITZEk0Ft8RK2ueZLbyzL/bHpwtQ6RWpLwY7OZvwp4gEGLrqqNS2jLvNYsxUalkQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB11138.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454d6211-1306-4034-9c21-08de8c198415
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 15:57:15.1201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +P8ijf5X5mxKusmX0fstvlXntsv3e0nDYrCkYE9f0mE0baMv8dwel3NUiEsvNWehu1/t3e7j8ToKom7etUk86bc1LeRbgk2vWfO4HM2DtyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7774
X-Authority-Analysis: v=2.4 cv=T/WBjvKQ c=1 sm=1 tr=0 ts=69c6a8e0 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=20KFwNOVAAAA:8
 a=rKxM9r7zjRZ3mYq0Rv8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExMCBTYWx0ZWRfX0EpHF5GNaCj+
 9lMdHVGySxPoTm6Qfmsnh/l8KnDBV0fYlKZnP9nLOxaqQZ8u9yREcX18tksexPcD/9hnwtCHssO
 gVSXcxziw93fc+PzFuJlN1JA2xn+B3Wcw1Be1sxasCbAfirLfCgM4ab61W7GGrW2jh+t90Lm+fX
 5C4E4HG7Xe0cf3qZp76cokN3+suwgUuVRe3kbScUjaijrq6lcCxkObL+f9v9rAska+kE8sfnQVW
 5oKzwurSmSBu6gxdn+ek14s4ZND8d0n+rhPrtV6q7kAjTBbKIBoXKGaCoEaIo+scn2ZOZ00Bs4d
 7Ub4rj/c1KFscuRhNOFeP05iUfebmDrVij7nBvLV5rSbRZTKkKNDmwg86q/KqtOBjk4grG4fW2L
 +HIb33Hj8NmKezWvrEos0WQrjfr1KeRcDMg1Z92Etxn6mGPzgrQ4v5SGeAbxcpV49/2hXmNr0OQ
 SjZXXgWl8jZ30OfWJJg==
X-Proofpoint-ORIG-GUID: zGmIIIJCBuwOmMMFgekvcPPQ96bLdfdj
X-Proofpoint-GUID: zGmIIIJCBuwOmMMFgekvcPPQ96bLdfdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDI2LCAyMDI2LCBhdCAxMjoxM+KAr1BNLCBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDMvMjYvMjYgMTU6NTAsIFBhb2xvIEJv
bnppbmkgd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEveDg2L3ZteF90ZXN0cy5jIGIveDg2L3ZteF90
ZXN0cy5jDQo+PiBpbmRleCAwMjM1MTJlNi4uYmYwMzQ1MWEgMTAwNjQ0DQo+PiAtLS0gYS94ODYv
dm14X3Rlc3RzLmMNCj4+ICsrKyBiL3g4Ni92bXhfdGVzdHMuYw0KPj4gQEAgLTEwNDQsNiArMTA0
NCw4IEBAIHN0YXRpYyBpbnQgaW5zbl9pbnRlcmNlcHRfZXhpdF9oYW5kbGVyKHVuaW9uIGV4aXRf
cmVhc29uIGV4aXRfcmVhc29uKQ0KPj4gICAqLw0KPj4gIHN0YXRpYyBpbnQgX19zZXR1cF9lcHQo
dTY0IGhwYSwgYm9vbCBlbmFibGVfYWQpDQo+PiAgew0KPj4gKyB1NjQgc2Vjb25kYXJ5Ow0KPj4g
Kw0KPj4gICBpZiAoIShjdHJsX2NwdV9yZXZbMF0uY2xyICYgQ1BVX1NFQ09OREFSWSkgfHwNCj4+
ICAgICAgIShjdHJsX2NwdV9yZXZbMV0uY2xyICYgQ1BVX0VQVCkpIHsNCj4+ICAgcHJpbnRmKCJc
dEVQVCBpcyBub3Qgc3VwcG9ydGVkXG4iKTsNCj4+IEBAIC0xMDY3LDkgKzEwNjksMTMgQEAgc3Rh
dGljIGludCBfX3NldHVwX2VwdCh1NjQgaHBhLCBib29sIGVuYWJsZV9hZCkNCj4+ICAgaWYgKGVu
YWJsZV9hZCkNCj4+ICAgZXB0cCB8PSBFUFRQX0FEX0ZMQUc7DQo+PiAgKyBzZWNvbmRhcnkgPSB2
bWNzX3JlYWQoQ1BVX0VYRUNfQ1RSTDEpIHwgQ1BVX0VQVDsNCj4+ICsgaWYgKGlzX21iZWNfc3Vw
cG9ydGVkKCkpDQo+PiArIHNlY29uZGFyeSB8PSBDUFVfTU9ERV9CQVNFRF9FUFRfRVhFQzsNCj4+
ICsNCj4+ICAgdm1jc193cml0ZShFUFRQLCBlcHRwKTsNCj4+ICAgdm1jc193cml0ZShDUFVfRVhF
Q19DVFJMMCwgdm1jc19yZWFkKENQVV9FWEVDX0NUUkwwKXwgQ1BVX1NFQ09OREFSWSk7DQo+PiAt
IHZtY3Nfd3JpdGUoQ1BVX0VYRUNfQ1RSTDEsIHZtY3NfcmVhZChDUFVfRVhFQ19DVFJMMSl8IENQ
VV9FUFQpOw0KPj4gKyB2bWNzX3dyaXRlKENQVV9FWEVDX0NUUkwxLCBzZWNvbmRhcnkpOw0KPj4g
ICAgIHJldHVybiAwOw0KPj4gIH0NCj4gDQo+IFRoaXMgaXMgbWlzc2luZyBhIGh1bms6DQo+IA0K
PiBkaWZmIC0tZ2l0IGEveDg2L3ZteF90ZXN0cy5jIGIveDg2L3ZteF90ZXN0cy5jDQo+IGluZGV4
IDAyMzUxMmU2Li5iNTk5NDcxOSAxMDA2NDQNCj4gLS0tIGEveDg2L3ZteF90ZXN0cy5jDQo+ICsr
KyBiL3g4Ni92bXhfdGVzdHMuYw0KPiBAQCAtNDg4Niw3ICs0OTQ2LDcgQEAgc3RhdGljIHZvaWQg
dGVzdF9lcHRfZXB0cCh2b2lkKQ0KPiAgICAgICAgICAgICAgICByZXBvcnRfcHJlZml4X3BvcCgp
Ow0KPiAgICAgICAgfQ0KPiAtICAgICAgIHNlY29uZGFyeSAmPSB+KENQVV9FUFQgfCBDUFVfVVJH
KTsNCj4gKyAgICAgICBzZWNvbmRhcnkgJj0gfihDUFVfVVJHIHwgQ1BVX0VQVCB8IENQVV9NT0RF
X0JBU0VEX0VQVF9FWEVDKTsNCj4gICAgICAgIHZtY3Nfd3JpdGUoQ1BVX0VYRUNfQ1RSTDEsIHNl
Y29uZGFyeSk7DQo+ICAgICAgICByZXBvcnRfcHJlZml4X3B1c2hmKCJFbmFibGUtRVBUIGRpc2Fi
bGVkLCB1bnJlc3RyaWN0ZWQtZ3Vlc3QgZGlzYWJsZWQiKTsNCj4gICAgICAgIHRlc3Rfdm14X3Zh
bGlkX2NvbnRyb2xzKCk7DQoNClRoYW5rcywgYWdyZWVkLiBUaGlzIHdvcmtzIGZvciBtZSAod2hp
Y2ggZml4ZXMgdGhlIHNvbGUgZmFpbHVyZSBJIGhhZA0Kb24gRVBUIHNpZGUpDQoNCj4gDQo+IGFu
ZCBwb3NzaWJseSB0aGlzIGFzIHdlbGwgZm9yIGNvbnNpc3RlbmN5Og0KPiANCj4gZGlmZiAtLWdp
dCBhL3g4Ni92bXhfdGVzdHMuYyBiL3g4Ni92bXhfdGVzdHMuYw0KPiBpbmRleCBiNTk5NDcxOS4u
Y2YxMDIyYmEgMTAwNjQ0DQo+IC0tLSBhL3g4Ni92bXhfdGVzdHMuYw0KPiArKysgYi94ODYvdm14
X3Rlc3RzLmMNCj4gQEAgLTUwNjgsNyArNTA2OCw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfcG1sKHZv
aWQpDQo+ICAgcHJpbWFyeSB8PSBDUFVfU0VDT05EQVJZOw0KPiB2bWNzX3dyaXRlKENQVV9FWEVD
X0NUUkwwLCBwcmltYXJ5KTsNCj4gLSBzZWNvbmRhcnkgJj0gfihDUFVfUE1MIHwgQ1BVX0VQVCk7
DQo+ICsgc2Vjb25kYXJ5ICY9IH4oQ1BVX1BNTCB8IENQVV9FUFQgfCBDUFVfTU9ERV9CQVNFRF9F
UFRfRVhFQyk7DQo+IHZtY3Nfd3JpdGUoQ1BVX0VYRUNfQ1RSTDEsIHNlY29uZGFyeSk7DQo+IHJl
cG9ydF9wcmVmaXhfcHVzaGYoImVuYWJsZS1QTUwgZGlzYWJsZWQsIGVuYWJsZS1FUFQgZGlzYWJs
ZWQiKTsNCj4gdGVzdF92bXhfdmFsaWRfY29udHJvbHMoKTsNCj4gDQo+IFBhb2xvDQoNCg==
