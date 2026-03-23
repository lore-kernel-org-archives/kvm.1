Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229273AA516;
	Mon, 23 Mar 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277369; cv=fail; b=WILSZY/LZsYU+ZHnimcN+qhlo/A13sHSIlxwIYIled1XEfPHfTuf1mI8MWNVxtwhpT3Hm0e8mRe+kN0zMOUyR+nhve7/Y3ZdIS6+RRHOPxXWL98/nHKa4simevVGMkHuaVXXmDbZvE7wNENs7tuAGeJrkwHL0ItrPHIQlwRXr34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277369; c=relaxed/simple;
	bh=/VZlNjr1SJ2Wp1lkxARULThT98RU88gL9qLygESjbx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cDmcRoUiRlYY7J/QcNNo3U0Q6iU+vr5/05GVJ/yvUTRLtPKMQC/7cwnH0dm+kz3ryifsUoekUZijL3WFVJI7QlVshZJvM6xEQnwJQculc2SiTiCfcJGfSoByORIP8ZAM8hDDq4jDb05xhul62RqpmznK0XFzOMA06mhWHTzLk7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=haGt8r24; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VdewZKC4; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="haGt8r24";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VdewZKC4"
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NDHdXu668625;
	Mon, 23 Mar 2026 07:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=/VZlNjr1SJ2Wp1lkxARULThT98RU88gL9qLygESjb
	x0=; b=haGt8r24FrIOod8w45lAFQFfRJl+aKmFNEbWN4tcfVCi+NOkz5GjX3JbR
	0BiageQYYzdC8xAgkq62oEIKl+CWhl4msguTr+lLV4oeUIbVrbyghJbSMZIW/JxJ
	go16EuNgSccbHUh9QrCcIVNzGAvBVR0mAB7hKif379vAP/omp+81TH/r7e9U/6VV
	DmZkBNS7/mxnBGixcG5rsjXy1dbAFBL31uisPQ7WgJDbwYroeQEfDTppDiZqMJ5i
	tRHBoiQ1sWlJMwlyNzmB23O3Bm5XmM+xqOR3w66hRscr1XfADXPRIM2JkVm3p5w4
	Kh7wdYmSTaLwc8+JpGnU9xrJGKixQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022134.outbound.protection.outlook.com [52.101.53.134])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4d1tvsbvad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzp2hsx55dRiqXaTORajRW2DHIe7C/EANyNaXyF2ZUnmESxIzzQtke8MkTGqeQTfFW1r4CO2l7k8y3E2eiNS9ZeLizpkvLasEiElHRHwFPBOmoE9AL+NxwtV5Tb8lV/fr5adZVvh5bWlheW9H7NEMqtblWNdxM1wEcEWLntkBjVYHsxJ0vhDN6rVtzzZgsBfYJ4HPgwvkjro1QoSfZ8SUosNGj65cuO0qR/zWBvY4nOD8uLVeUTDvjICsK2GnrXSmNbsprFOPHfHUr/4gHa/adk7bVadZjYTDSrbmjquoLCbe7Pbs1SVel7boYf3PfQqU+YFWZaBrLlAKkZQ80iyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VZlNjr1SJ2Wp1lkxARULThT98RU88gL9qLygESjbx0=;
 b=zOgyRdr7OOXzI2PGVcpHh9/5bCiz+OqWPHSs6XaoXmSpsbJLs5L2APjUQTzyJ4sMgbf0CQ3jQagsfAnCVxzwLA3BX1MrLNAduJJkwumwKHf0hQItfEjbJETyI8woRgf4bxW8eDI24EB6qVg9NOn9LXDcUDiFksep2KCeVtODTVlEV9IrIX8s580G2U6TG1KfkxTQVMnufkUWoYip0Lkh3ddmPpz1PBLCnzwPmuoAPJn5CeDOH4uOxvGOLOKbITvOmZbRtRARdG4S7yop5D6b6bNmly2rQIIljEXmKjREGHAGXiN/9ZvlgYO2UuASygdwt9J8IT9kC5if9eVqu4gcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VZlNjr1SJ2Wp1lkxARULThT98RU88gL9qLygESjbx0=;
 b=VdewZKC46SC78BfPAbVejsKxgv8QbB+EPuwLBV8xdGSZNO4RcFpVIusHSSFmT39PDp275C5tZFMRafbiPdpLpDCGd/otiZN0Wws53wGopHW8wbM1hvQAEvB2G1W6eIV0OIjWhfV3anrAH4Fi6xw8BhKoqgvO7LiJ42uJ1o7fg1liAVBpmZb7DGlEJte/mntzOwAFlouRJU3JiPD/0rM0xY2VGwIb3Lc40lPu/FzjJ/BORvSXjsFdLH8RseTEJEJuniSq72tMsVshESBQSkB4lB5Ts/sV56utMm+du0nP5DTBBQCmO/rjty3z9IUv/nPydrLyiSDgKiN5+8qPChvm1Q==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA2PR02MB7772.namprd02.prod.outlook.com
 (2603:10b6:806:149::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 14:49:09 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 14:49:09 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Marcelo Tosatti
	<mtosatti@redhat.com>,
        Nikunj A Dadhania <nikunj@amd.com>, Amit Shah
	<amit.shah@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 01/22] KVM: TDX/VMX: rework
 EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Thread-Topic: [PATCH 01/22] KVM: TDX/VMX: rework
 EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Thread-Index: AQHcuMcGfR9IKKrQZUyh3D78M0poLrW8Ns6A
Date: Mon, 23 Mar 2026 14:49:09 +0000
Message-ID: <ABE27F8B-CB34-4C6F-AFDF-13C33189238F@nutanix.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-2-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-2-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA2PR02MB7772:EE_
x-ms-office365-filtering-correlation-id: d0a5a7a1-7177-481b-f8f2-08de88eb5730
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 QQhb0Zv5ltPYv12EqKacbf5oDfuzTqZR3ePP7U53y4sLlIbLruKjvN51BsR8t8mqZjcnDkjem6flLqEfR/pIo9eMyN2ISgeuQ4cxQitES3H5aPYENA0zzHwvgJhTU9eA1TXvUg7eLWwJyeb2YvLv41mJ/svb35ord9DBACPUAvpXpoq8Hdw0fHDlDqr0wPIu2NVuyu1BdZvilZhi4CCAq0YpUcNxjFszXsHRHb+pTEghZKMZtoXJs+G9xJ207/O6CoCvepKKAe6VE/4YthiOEqfmLewwktTWQqJhqHdJQ0btzEtGFLTY996Y0VssngRDIbZPn/6tOlBOr0ZHfLeAouRJ+4eJac0VWAans8VB0VjGkFBU6yghHM8GcmS5UhElIk0MovcwJSDrJOd8vjK6qkxiXcgWqYX99NPfR50kfrffSB0mLRS9gO6IUTn90+M91LsC//rrOf4eUrBv6uUHCn2NaiBGAGOdBswcY4Udsbx2tA5LpSqfP8MtzSlrpqfEtfLniTiv+dU0DcWjLM3bYvwmlpqqs9CB3RTlpy/SZ4v9WdYe2EcoJAvnGcHD0qZWCO5x53O845KnB3p/nD5nZMKUJ8fPdfQDppzBrXfyrksO+oLSnn6t1pMmie/45vZ+k3+6f0EoFaCUnVLvcGRAy0DETVwBvw0LaNk/l+9qLslkmHG1hBTiA3aF7/HnGbcpCI3M+xYiMEZgGRY1jfAcpAmwh4CLom6i/MJXXWHRGGtxPaodlhV1fsgRp3eATp06OLiYdZsLTQKAcWvZy3QBhxiTkX9F5AWg7PNb3AJHvaQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTl6OGJjb1JGeGtkSjBCTjZmdEtQdDJIRWJmdUtkeGxKVnJoY2FOc3h3QUZY?=
 =?utf-8?B?c1VRK2s0eEJmVDRPdUFtSWk3NXJKL2hEZEtoSjcxdTJ2c3RraGxQR2FXNkJM?=
 =?utf-8?B?Q1g1N3AxMVhUWWc5OUVrSWFVcEZyR0VpbkxkZGpYdzVGeXlvZTJmR2J0WXVi?=
 =?utf-8?B?M3dyTVZINjBRNFBLUXc4VGEvK0U0dnNoYkFCcG1nZG5BQnV2akdrVndjM01W?=
 =?utf-8?B?dllEYlpOcHFSRmx2Ujk4RG9hdld2YlR1VzdpQUs0c2dQZWlXN2s5RlJhZjVv?=
 =?utf-8?B?ck9POXQzRFN3bW9PWm15YmY1ZjJyN3hEcytwbGxQd0ZQUjNwam9VaFl5REEw?=
 =?utf-8?B?ZHU5MlY4d2J2VDlydUdCalppd1Z4bzA2Nm5VUDV1KzNSYmU5NHNlZ3FkVUo0?=
 =?utf-8?B?L0ZLdkFsbmp1YTRNNjc0dzJWdTlsM0FNWEhoeWVLbzZyWEVoNy9wMkh3UUVD?=
 =?utf-8?B?S2NsRiswdVlNbUdsdEpXTFNiWmpTcFRaMzBlbWZzY2tWRnpxYXMreUMvdEVN?=
 =?utf-8?B?NGVzbGQ4Q2diVGc1WlBDWTlSL3pzVWo3ZytpTW5IREhPVit1UmgzN3UwWGxQ?=
 =?utf-8?B?Wko3ZnhZbnlsa0NFemdHOEc4Z0VuMEcwREpLK2NsR0ptZkZBVEovUEJqeDBR?=
 =?utf-8?B?cDREaVZYN0hRZG9XYTRRNmRuWUR0Ym5tRGhtUDJuWWpGK0h2N3NDVWxhcUdw?=
 =?utf-8?B?UFdyVWR2MlpqbjFBVDBGM0tPYk5XbDY3R0J5eDEvRUJRNmIrd0VNV1dtaDVM?=
 =?utf-8?B?Z2RocWVPa1hrNGs3VzkwV0FkVVRtQXZLYWw1ZVhZQkcvemRzQUxQUk5kaFE3?=
 =?utf-8?B?Z1NUWlpkZFlxRWxEOUNLazRqRVdSVDJoTW5XVmVVczFBSXg2S0piSkdJZ3dr?=
 =?utf-8?B?bUl6cUtFQVg4K05sejd5YlFscTFNNWl4LzM4MldwQmhsZVhkYW1Cays1TDZh?=
 =?utf-8?B?Z3daaFZSeEFPYjRDOVo2a0ZvditSVE5nQUpaYWd4RzdMUFMwN3hvZ2tEbXMr?=
 =?utf-8?B?REozczZmbXRjdG56MHgxZUJOZ2svKzFGZ0tnVHdxK1BJMkNlVDVKREFXbTUz?=
 =?utf-8?B?OWFSQmMzenNWUCtKUEZRc0xMVHlNcEVKenIxOFhBbXJxYWlRdUgzVlRLK0RJ?=
 =?utf-8?B?WnF0djhVaTJBOVAwR3RoYnNFYVhQNFROaEhMZ1RxU1pVdzMyZVRsWG1uZmVE?=
 =?utf-8?B?MUNCK1FBTk5ObVJVS3ZSQlZuK3ZCaHRNRzV1Z0FiUk42MlY3MDc1UUNQSmls?=
 =?utf-8?B?TExkVjJRcTROM2YzWVFheDAzRWN1MlVCT3htZmtFaWY4R2x4YllOaWhHalh0?=
 =?utf-8?B?c0c2TEhldUt2SVA5MHYyOEJiTjlaNEI2cllqL0YyclJUZUJoakg3V3hYU0FW?=
 =?utf-8?B?NDdKN2hOdHlUWHFkOUhaWWJURlpVQ25JRkdwdjM1SG9PN1ZuMkluUHdJaTQy?=
 =?utf-8?B?VDliMmEvRzArTTAveXhWajdtZFpqTElBT3RLSTBsWTJ2Z2ptdjI3dlREWE1R?=
 =?utf-8?B?MjBtanE0RUVCTEF2U1VXcDNVc3hrdUZhVVF4WE9QbWd4WURWYUFZdkRkYzBK?=
 =?utf-8?B?V25OY2VmclJjcytBQWswVnluMXVHczFGa2RrNlBCZDV0OERUWEJwNHYwWGEw?=
 =?utf-8?B?dmJvVEl2RXluQUp2SGFXd05HcEg2R0lwZzQzT000VkN0UVYwZDVhT3QvbmRt?=
 =?utf-8?B?STRQTVdDT0FtNnpGaCtNck5qU0JlaEdMNHFjOFlhMHpKS0l3RWd3dEIxTEpK?=
 =?utf-8?B?QUMxMHkxaDJLWDl4L3pEc1NqVWdKMjR6ZnpnbEVPTVdCMFNOSmlwMkVaaTB5?=
 =?utf-8?B?ZVM3YjVmc0tkZytETEUwcm1DRjB1SUY3NFVPOUxyUVd1NzJtNGxrZitkWXZU?=
 =?utf-8?B?dXRCNVkxWHA4ZkVuZHJTakF1aFQva2tpSUNPczNaM0IwSDlaSXBBcFRjM3Qw?=
 =?utf-8?B?SWprdEtGcUVhdGJBUldnTnJNTTU4bXpERisyeW0zMjBrcHI5SVcyTHJmUzVB?=
 =?utf-8?B?NHdjWjBreTd4eS9WU2MwNDQ4VDZ3NTRCdFJZUCthWU1scm9RSzRuMUNEN0sx?=
 =?utf-8?B?OTJtbTdlVGZZWXlrdjFUZlpLQTUwTkpqa3RsTlU2UUl3NGlGaVpXY0RtUEZh?=
 =?utf-8?B?NG56THpibE1qS3J3eklSbnovV0tERlhyU1JVbHh6dlNTK0phY2NHVVZhSTZr?=
 =?utf-8?B?ZTlkSytWcWNrRDl1dS93b0YrTjNmeU4rTFhndlZKNUV4aTlobU9XTUxRQnoz?=
 =?utf-8?B?c1B6YndqTWZUSi9oeUNkRi91VW44b0ZvbmxrRm1RaHhWY2lBcmNCYjRscGtH?=
 =?utf-8?B?M1dXakhma01XQmFndXdnQ1JnMGdLQ0V4bnBOR0xPRnd0TnZadys3OU1zMmE4?=
 =?utf-8?Q?zpnU523D4hn8XixOV1l4vjiZ1W8DFgHlKielOFhkcE6iq?=
x-ms-exchange-antispam-messagedata-1: glruDZss5Kr6LzvR/3a0XZ843+8jjFUmCpk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB77071B982B3F48B09D58AC843E7776@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eVWt24kKgbURO8eiZdK0Wgg6fhN054LWNVsQWdJywKMxpxKij58wvpXtM8YsA5pdZm5uBQP8K648W93e53p1DPGGCGXyqI72LuEeuWtWRruyBs5tlS6DMPLHjGuMbl9e6NxdrzyveJ3YhbA/TRi/C/ANf7rRohIxKOLUBIcY8SzAuHtUcenSjkaXil2G3DwAvkG14X7+jxNq1UnjgP5EqkAMZR8RqfNPgMc+AqAcjUbxZleMaBvjYFXTe59wWM+eR5N+LhwndrH8aZXhTgl6oTal0j4xKUpN+6fYtPW2+ag/zWeJWdTsNnTEmQGwop7pJZN99q9QbVSnHmtuQtvsxA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a5a7a1-7177-481b-f8f2-08de88eb5730
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 14:49:09.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smjI7noy3MBRSi3U9T1KSBZyg0yKiIRt/FVTcTvaIlH6tsUmhGGp35+a65F9KsncPZWUiR51bdY3gerN8aQH5DBesP9cSty1NgiCvCJdnIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7772
X-Proofpoint-ORIG-GUID: BF2cqorUxgPBrdnKi6RNPDMahz4981Gv
X-Proofpoint-GUID: BF2cqorUxgPBrdnKi6RNPDMahz4981Gv
X-Authority-Analysis: v=2.4 cv=DIaCIiNb c=1 sm=1 tr=0 ts=69c152e7 cx=c_pps
 a=sw9tB11567c3hJo8WHKnig==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=UMs1EcMwc8yErfsPZUoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfX5shGytuaOupP
 9w0b9apYMCoyF4cuZQUaRTZfKLK443qY26OFsH0Z1yKnPrOOkBTcL+oRzQnfD/JSGDNqKjtX89B
 n6Mi4B9a+CX9k3RdL5DYIpxqZn01amhC1lGq5mtqK7+SSCGYsnGHSmNg4tqR6pDlsDSTBJNrXfZ
 YRQGzCAUFSajZL68h9+qoHpSyHWepJsxQz8P3WIE777GDdBsbgm6bA97MsXMyFdvtauO+T9oZdC
 HSyEnF242NZe12WiQIkHJ8yz+2+PWor+OmCXFTfhQU1cMX0GNcpJ1TDWjsNLBuqF1vtkgMHIfew
 Y8XwDgIlwOhLITZLA4kFlevIoRYJ/HzO9Bv5LhNBzv0A4M16rDm1zh2EDxKwLX3o8/Pd66LpPZC
 Nth9Hs2Hp51wknJk5aD6QVfKiO+iEeJTS+0snkPJ0w4N5dxj/X/OnkQCR4osXmkBo3zZzWO4GUI
 f/6D485/e00/h8SZyzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDIwLCAyMDI2LCBhdCA4OjA54oCvUE0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gRnJvbTogSm9uIEtvaGxlciA8am9uQG51dGFu
aXguY29tPg0KPiANCj4gRVBUIGV4aXQgcXVhbGlmaWNhdGlvbiBiaXQgNiBpcyB1c2VkIHdoZW4g
bW9kZS1iYXNlZCBleGVjdXRlIGNvbnRyb2wNCj4gaXMgZW5hYmxlZCwgYW5kIHJlZmxlY3RzIHVz
ZXIgZXhlY3V0YWJsZSBhZGRyZXNzZXMuIFJld29yayBuYW1lIHRvDQo+IHJlZmxlY3QgdGhlIGlu
dGVudGlvbiBhbmQgYWRkIHRvIEVQVF9WSU9MQVRJT05fUFJPVF9NQVNLLCB3aGljaCBhbGxvd3MN
Cj4gc2ltcGxpZnlpbmcgdGhlIHJldHVybiBldmFsdWF0aW9uIGluDQo+IHRkeF9pc19zZXB0X3Zp
b2xhdGlvbl91bmV4cGVjdGVkX3BlbmRpbmcgYSBwaW5jaC4NCj4gDQo+IFJld29yayBoYW5kbGlu
ZyBpbiBfX3ZteF9oYW5kbGVfZXB0X3Zpb2xhdGlvbiB0byB1bmNvbmRpdGlvbmFsbHkgY2xlYXIN
Cj4gRVBUX1ZJT0xBVElPTl9QUk9UX1VTRVJfRVhFQyB1bnRpbCBNQkVDIGlzIGltcGxlbWVudGVk
LCBhcyBzdWdnZXN0ZWQgYnkNCj4gU2VhbiBbMV0uDQo+IA0KPiBOb3RlOiBJbnRlbCBTRE0gVGFi
bGUgMjktNyBkZWZpbmVzIGJpdCA2IGFzOg0KPiAgSWYgdGhlIOKAnG1vZGUtYmFzZWQgZXhlY3V0
ZSBjb250cm9s77+9PyBWTS1leGVjdXRpb24gY29udHJvbCBpcyAwLCB0aGUNCg0KVGhlc2UgcXVv
dGUgbWFya3Mgc2hvdWxkIGJlICIgLSB1dGYgc2lsbGluZXNzIGFmb290ICEgDQoNCj4gIHZhbHVl
IG9mIHRoaXMgYml0IGlzIHVuZGVmaW5lZC4gSWYgdGhhdCBjb250cm9sIGlzIDEsIHRoaXMgYml0
IGlzIHRoZQ0KPiAgbG9naWNhbC1BTkQgb2YgYml0IDEwIGluIHRoZSBFUFQgcGFnaW5nLXN0cnVj
dHVyZSBlbnRyaWVzIHVzZWQgdG8NCj4gIHRyYW5zbGF0ZSB0aGUgZ3Vlc3QtcGh5c2ljYWwgYWRk
cmVzcyBvZiB0aGUgYWNjZXNzIGNhdXNpbmcgdGhlIEVQVA0KPiAgdmlvbGF0aW9uLiBJbiB0aGlz
IGNhc2UsIGl0IGluZGljYXRlcyB3aGV0aGVyIHRoZSBndWVzdC1waHlzaWNhbA0KPiAgYWRkcmVz
cyB3YXMgZXhlY3V0YWJsZSBmb3IgdXNlci1tb2RlIGxpbmVhciBhZGRyZXNzZXMuDQo+IA0KPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FDSkR6VTFwX1NGTlJJSmRAZ29vZ2xlLmNv
bS8gDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+
IE1lc3NhZ2UtSUQ6IDwyMDI1MTIyMzA1NDgwNi4xNjExMTY4LTItam9uQG51dGFuaXguY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiAt
LS0NCj4gYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmggfCA1ICsrKy0tDQo+IGFyY2gveDg2L2t2
bS92bXgvY29tbW9uLmggIHwgOSArKysrKysrLS0NCj4gYXJjaC94ODYva3ZtL3ZteC90ZHguYyAg
ICAgfCAyICstDQo+IDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oDQo+IGluZGV4IGNjYTdkNjY0MTI4Ny4uNGEwODA0Y2M3
YzgyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0KPiArKysgYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0KPiBAQCAtNTg3LDEwICs1ODcsMTEgQEAgZW51bSB2
bV9lbnRyeV9mYWlsdXJlX2NvZGUgew0KPiAjZGVmaW5lIEVQVF9WSU9MQVRJT05fUFJPVF9SRUFE
IEJJVCgzKQ0KPiAjZGVmaW5lIEVQVF9WSU9MQVRJT05fUFJPVF9XUklURSBCSVQoNCkNCj4gI2Rl
ZmluZSBFUFRfVklPTEFUSU9OX1BST1RfRVhFQyBCSVQoNSkNCj4gLSNkZWZpbmUgRVBUX1ZJT0xB
VElPTl9FWEVDX0ZPUl9SSU5HM19MSU4gQklUKDYpDQo+ICsjZGVmaW5lIEVQVF9WSU9MQVRJT05f
UFJPVF9VU0VSX0VYRUMgQklUKDYpDQo+ICNkZWZpbmUgRVBUX1ZJT0xBVElPTl9QUk9UX01BU0sg
KEVQVF9WSU9MQVRJT05fUFJPVF9SRUFEICB8IFwNCj4gRVBUX1ZJT0xBVElPTl9QUk9UX1dSSVRF
IHwgXA0KPiAtIEVQVF9WSU9MQVRJT05fUFJPVF9FWEVDKQ0KPiArIEVQVF9WSU9MQVRJT05fUFJP
VF9FWEVDICB8IFwNCj4gKyBFUFRfVklPTEFUSU9OX1BST1RfVVNFUl9FWEVDKQ0KPiAjZGVmaW5l
IEVQVF9WSU9MQVRJT05fR1ZBX0lTX1ZBTElEIEJJVCg3KQ0KPiAjZGVmaW5lIEVQVF9WSU9MQVRJ
T05fR1ZBX1RSQU5TTEFURUQgQklUKDgpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3Zt
L3ZteC9jb21tb24uaCBiL2FyY2gveDg2L2t2bS92bXgvY29tbW9uLmgNCj4gaW5kZXggNDEyZDA4
MjlkN2EyLi5hZGY5MjU1MDBiOWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvY29t
bW9uLmgNCj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC9jb21tb24uaA0KPiBAQCAtOTQsOCArOTQs
MTMgQEAgc3RhdGljIGlubGluZSBpbnQgX192bXhfaGFuZGxlX2VwdF92aW9sYXRpb24oc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCBncGFfdCBncGEsDQo+IC8qIElzIGl0IGEgZmV0Y2ggZmF1bHQ/ICov
DQo+IGVycm9yX2NvZGUgfD0gKGV4aXRfcXVhbGlmaWNhdGlvbiAmIEVQVF9WSU9MQVRJT05fQUND
X0lOU1RSKQ0KPiAgICAgID8gUEZFUlJfRkVUQ0hfTUFTSyA6IDA7DQo+IC0gLyogZXB0IHBhZ2Ug
dGFibGUgZW50cnkgaXMgcHJlc2VudD8gKi8NCj4gLSBlcnJvcl9jb2RlIHw9IChleGl0X3F1YWxp
ZmljYXRpb24gJiBFUFRfVklPTEFUSU9OX1BST1RfTUFTSykNCj4gKyAvKg0KPiArICogZXB0IHBh
Z2UgdGFibGUgZW50cnkgaXMgcHJlc2VudD8NCj4gKyAqIG5vdGU6IHVuY29uZGl0aW9uYWxseSBj
bGVhciBVU0VSX0VYRUMgdW50aWwgbW9kZS1iYXNlZA0KPiArICogZXhlY3V0ZSBjb250cm9sIGlz
IGltcGxlbWVudGVkDQo+ICsgKi8NCj4gKyBlcnJvcl9jb2RlIHw9IChleGl0X3F1YWxpZmljYXRp
b24gJg0KPiArICAgICAgIChFUFRfVklPTEFUSU9OX1BST1RfTUFTSyAmIH5FUFRfVklPTEFUSU9O
X1BST1RfVVNFUl9FWEVDKSkNCj4gICAgICA/IFBGRVJSX1BSRVNFTlRfTUFTSyA6IDA7DQo+IA0K
PiBpZiAoZXhpdF9xdWFsaWZpY2F0aW9uICYgRVBUX1ZJT0xBVElPTl9HVkFfSVNfVkFMSUQpDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jIGIvYXJjaC94ODYva3ZtL3ZteC90
ZHguYw0KPiBpbmRleCBjMzA4YWVkZDg2MTMuLmJmOWZlNzZkOTc0ZCAxMDA2NDQNCj4gLS0tIGEv
YXJjaC94ODYva3ZtL3ZteC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+
IEBAIC0xOTIxLDcgKzE5MjEsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdGR4X2lzX3NlcHRfdmlv
bGF0aW9uX3VuZXhwZWN0ZWRfcGVuZGluZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcA0KPiBpZiAoZWVx
X3R5cGUgIT0gVERYX0VYVF9FWElUX1FVQUxfVFlQRV9QRU5ESU5HX0VQVF9WSU9MQVRJT04pDQo+
IHJldHVybiBmYWxzZTsNCj4gDQo+IC0gcmV0dXJuICEoZXEgJiBFUFRfVklPTEFUSU9OX1BST1Rf
TUFTSykgJiYgIShlcSAmIEVQVF9WSU9MQVRJT05fRVhFQ19GT1JfUklORzNfTElOKTsNCj4gKyBy
ZXR1cm4gIShlcSAmIEVQVF9WSU9MQVRJT05fUFJPVF9NQVNLKTsNCj4gfQ0KPiANCj4gc3RhdGlj
IGludCB0ZHhfaGFuZGxlX2VwdF92aW9sYXRpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAt
LSANCj4gMi41Mi4wDQo+IA0KDQo=
