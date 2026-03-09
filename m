Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A41F03D7;
	Mon,  9 Mar 2026 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097398; cv=fail; b=ANJ3bkCLidQsfBHF3Ss/ixtLfO6/vpSckIH6o6HkOco6P/KRPSI5qNoIhzgXJllmbFt7EA269yC+EqwthjAlutPa/YfqKsPlcHMDcpnqE/2BwvcKHkoXU9AnIHFDv9/wA73gNAZBtHDuMW5LD9oYMjKb83qSpblRtMxHi21w8IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097398; c=relaxed/simple;
	bh=mDUl3LkZkYuEgciBW1KfZ+XqlDOaQ9OqShCbQ076e+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+Ef+6BgblDYZNN9YFhkchcwefjpgyUEq7lHLTr21l2Mful4RvCpxYeeGR+seZu8x0Pp7hS+3ay7L7eCqDuR9Cbha87mPSeX7S1vgUg+MRRqooCDzS6CQ+zX2XRHMZgRICbbGxhuySq5AW+mcEDvy3T2F8v7nmIkQ2OD6q/mhTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=BYCN1viN; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="BYCN1viN"
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 629N2XMl2832037;
	Mon, 9 Mar 2026 23:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=9wMrUBngkSJmQTzRJbfb26JT1pWDN4fl1ciZt6hKUWc=; b=BYCN1viN4kj/
	DbN+E9nnkyqnbDl02LRN0DH51/xYSN+3OfthPdRlGLMvXqPvYrNEaZKEZiNvzJAi
	yKA4ZujlGw0cq2pgweP43B+wAjrhfi1jPSxCp6XJpIMjf/ydSA2EEjh4/oTSNEX6
	DDvdv68X477rC0UrbuB+/WcEEIiTzWhk2Qw2XiU00mmOVVe8Sni/YwCACq8sZMVx
	PQ9ylWUTD/+9kmpPJ9VXvL/GnUK1sZtHFcARRsof2ljrEZXPEEMNvRPu2BBHC6VO
	3TNmaQjsyQlI7BKuDRx93SthxfoI3o6t8/sBszmw5mwysubNOz12RSwrjTYcFrah
	gEB52pRGXg==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4cryt9jk94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 23:02:59 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 629Mn0bb020836;
	Mon, 9 Mar 2026 19:02:59 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4crg7yucnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:02:59 -0400 (EDT)
Received: from ustx2ex-dag4mb4.msg.corp.akamai.com (172.27.50.203) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 16:02:58 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb4.msg.corp.akamai.com (172.27.50.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 16:02:58 -0700
Received: from SN1PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 9 Mar 2026 18:02:58 -0500
Received: from CH2PR17MB3797.namprd17.prod.outlook.com (2603:10b6:610:80::18)
 by PH0PR17MB7573.namprd17.prod.outlook.com (2603:10b6:510:380::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 23:02:57 +0000
Received: from CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2]) by CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2%5]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 23:02:57 +0000
From: "Boone, Max" <mboone@akamai.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett"
	<Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko
	<mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tottenham,
 Max" <mtottenh@akamai.com>,
        "Hunt, Joshua" <johunt@akamai.com>,
        "Pelland,
 Matt" <mpelland@akamai.com>
Subject: Re: [RFC 1/1] mm/pagewalk: don't split device-backed huge pfnmaps
Thread-Topic: [RFC 1/1] mm/pagewalk: don't split device-backed huge pfnmaps
Thread-Index: AQHcr+1eklEgHPr7TUGT7iw+X10ZcbWmpDOAgAAsNgw=
Date: Mon, 9 Mar 2026 23:02:56 +0000
Message-ID: <CH2PR17MB3797A91D5107B6E347EEDD97BF79A@CH2PR17MB3797.namprd17.prod.outlook.com>
References: <20260309174949.2514565-1-mboone@akamai.com>
 <20260309174949.2514565-2-mboone@akamai.com>
 <51eeb09d-d3f4-412f-85da-690fdc0f8e6a@kernel.org>
In-Reply-To: <51eeb09d-d3f4-412f-85da-690fdc0f8e6a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR17MB3797:EE_|PH0PR17MB7573:EE_
x-ms-office365-filtering-correlation-id: fdeaaa66-8b01-4b7e-bf40-08de7e3000d2
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: Zbflbhjbq2et19jFv7YoADXJnTC2usFE57XZDrbQHb+N1jMuL/BA3QGyvNbF1teK3DjSGO8/sq/vG/qxWQ9yd1nHWiZDXFCSRGWYRaFWuJE02DB4C2iAmqri3b24uyzNnq5Wpo0PwLBj+GHCsxT/1exEvw782+xrmchwjCfaW8rHNb4ZTmOuLkVMmrYrNEp6i8FIiTb41LDLEapctHXZIBJ/AeOG16CB79Rww8rKiI8Se3kyh7DykfhRXpc4RYukvAVeQ5bnFGwpdpAnIMw3YO1FgErVJBFd6bKc88ihX4zMrv9+dwXEOpIKcVHKnVha7vIQNaku9eUDGX/rZhDT92iSTecE20dazVGpiq/cUe3C/UfvBLdri+7wmoeDTP+hA0h9a/9r5IOCf0XXC71AE3+z5wMeIYOshCfeJu1tH81WdyVLS4wuLnkvABMq8Y/9nc8pRLfAkVSX09z6AGz295+hxBWTDLwdQGoGpUVWz8bglDaVHM1yM8U+/WAQ32sohVf2JxXIJcpXNHLk9mcmlG7rCIAJV/+oyp3bDVrV2MxitQaG3LKfo597qdbLT5hwZ36aZG23PpI3OHAmZt96cWFOyQxRIO5z0v08Vk/8jHnv/U6l1guktK1do3PJaiqBu+uqOydbdw+pkbiCQ1gdN1ZXGyFVzLBhAW4aQM1Eob3jK4nnUcLR/+nCIhiXTELQ/EEv91at6bXxMa3pKE3UrQolc6trKRVpwwJP9OV16ZEjgNlBf0sSEafs5khjeqJ+cJh1rLSvocan74FrXAyv8U54E7lfUFZHdWTqu/57bdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR17MB3797.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nD61AoXL2jmC2wMJxGGMJcaDwvLPH6zqdgkL48fnOTa/fHNx1cs1lBdc5C?=
 =?iso-8859-1?Q?6UpAZbPE5s/EZJk0LmFb7RhiovKE67SJOzGnHrs91qysi/qkf8TLNaDA5q?=
 =?iso-8859-1?Q?PKSQuqJ9Jz+8FHt8Pwn56eQJKsd+HWUTMJAMr2XvcGmMj0V/jQtp1deOUT?=
 =?iso-8859-1?Q?t7GheQRhxedwUyE83XwvUQ2hFzO3pL3DiSwz0USXwj/A+eRRmlpXTSzuPo?=
 =?iso-8859-1?Q?SJvi5xv/vdz09vv700u9icsVrk2ZS0ILiFqoQrNBRDe4ASca+uubxvCPwq?=
 =?iso-8859-1?Q?yWcz8qAC/1WmQA2rG7MO8OhljzWc0jrN+WqloF9ijVqM1KkFvW3FpCNPqs?=
 =?iso-8859-1?Q?5Z9onjQGFT6bgLXUiNehTA1FZOjaAR8TMJqfwuuqOV4P987UkSNNK0akTx?=
 =?iso-8859-1?Q?66do8qu8Ny0/myYIJ3hQoJc+wkDonoKF0oqly7qq+exmfR36pVSnfZNTCS?=
 =?iso-8859-1?Q?vih3g6tfskJi3mGuSjPTBI0EqkhiVypy5uSNPFq5RcQw6NtTD5o+SMZHOe?=
 =?iso-8859-1?Q?gDuqwCCpWesECrP8d+zaidsC5OHK9AmBtdlV8hNK61ZiaWMCKZHG9Etuxl?=
 =?iso-8859-1?Q?t7y0VKhZOia3vyQQ29qvnkXbZny8jk0TBDZE89TujTB9OQp/KuBHXWEu+r?=
 =?iso-8859-1?Q?7GaFd1V7mawzTCc3sbLDywsZtEz17FeZZgHnef9fOwTnpy+uHTcncqe3iL?=
 =?iso-8859-1?Q?voeGceHte7n2ugk45Uz9MED7BOadcvTVQKM6WiNXyJxp0OVggI6WoLDJ2V?=
 =?iso-8859-1?Q?Xvlr1u7VLynWiOV9bcVW2u8g/op6WZAPWMlHssZyGdSIuG58AwdknV+Wup?=
 =?iso-8859-1?Q?/sqztAhChmwgdsrFk6N/eTcB+1qhkHPiI5wDnLgOdtwvFkNCfl49CefaKb?=
 =?iso-8859-1?Q?K+WUWMos0XWM+F1DFbk3TBu9P2lyMHWBvzpSKViMNUrj8e/Bixc2dloBlb?=
 =?iso-8859-1?Q?Q2t4yzwZPJ16e0OpchRMjwynEpJtQJ7KYYTHwVbdEAaRVALC6YOloKdP48?=
 =?iso-8859-1?Q?DoygMbRRd4bW+xT/cJOXRMa6sbAvd/FqNS0eWVGJl97Sr+3aZzHUsNAV0Z?=
 =?iso-8859-1?Q?rN/bnyM7z1njD9waOrm5OzPXLJ5VxcJyYEnFa5iSwYHFJOGyFYUCOMFt37?=
 =?iso-8859-1?Q?Ib3+bnQS8VL3QR86iVfy2556Q9pTU5DNM6oLyUKO9hEL/qY05g6dJPd/I0?=
 =?iso-8859-1?Q?tAe0XVbIEJhF/cDlZDi1rFJlPXXA4Bm/x2ym7S5V8P9Cx3a3ZiKk+amhIM?=
 =?iso-8859-1?Q?duj0nKPOt0AxJ4+ZEvsqURbvwj/9c22gcgU+F919wOIKte/glTnME7Bayy?=
 =?iso-8859-1?Q?KimUfqPCgbh8qI0D6uR0vZBBMu5Ipa0BC+M4g3aYZm3xqP2BtTLK99GxAl?=
 =?iso-8859-1?Q?WoUuR0H1dCTJik7WOOvO9LwO2KwcPc4caEE9vkwK86JqoC9hHsU0iWucAP?=
 =?iso-8859-1?Q?nxbauy7RA6G+iyWuSFo4QdPQ0jy+gRYHYS73dQqH+ThT0GwkxdQCEQnpH4?=
 =?iso-8859-1?Q?n2yDs02U6Y+rxEBUE/uPBh/2/8PX9peP9MNzRRkCfBsv9ZGV5/UXu5OrV2?=
 =?iso-8859-1?Q?JnJrpmh4f9tiGFLEPZ/V2cEBjO2ti075d1H2gdXA+D72VvC3QrcJvwca3x?=
 =?iso-8859-1?Q?5SQIxllD9UVVg/EsZ0Z5fqhS/S4HOSXLzZiAHYtws7b2DWjoiWZc920pTH?=
 =?iso-8859-1?Q?9y+2DvnLPLvmV47ig0LjJ+CR3FfGfWXcOHyaBgB9tvhpT6GJ0NSj8o+0sU?=
 =?iso-8859-1?Q?GM0uJFrs1FY7yuEZFn/MeoQ+hjPmTfjOxR503g9LgkHJmxZCI76nDBN/Qt?=
 =?iso-8859-1?Q?ZvLBFzlIHngDSC4Czr5hrsXz8iOX5dRqK6d5k+glPvB3bduEKYD6?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe2ssLn379GdtYtFfg7hXjoh3+RhDgWTmt40d5hmNpqXkqIt1T4SufflUIIumihQjgTWPGUrj8YFxRRQxx7VztGecVQcLJAZgZ1ZKfQ3eH5syHL1JCUb3AmtyQ2FGlrpuF9zyoJk7HtRkP2H1alb3eh5vlAXTfn0mCYSZPbZoKJyRv6sU7yISj26P5FkEH0yw9PN3GpQPQQLSPDgsR1y52GRfxL4mOUfuJLjiwbGBY9TwIKFHU64ab6NNc9PzIDDcAkhZo6X1M6JG1t+gBQ8hqLVtcaDfomS1MU8Kj9M9QuItc/GDB8RF2Jl+N7Dh3Qxn+SUmuThyyJslk/1YeZ9iA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGQTLLbMVEQXtqUlXUABrNwNO8WZpjxZc071ZuH0a4s=;
 b=P3QjWr9p/tK3YmKYfz6or8lPVPFOKidwuAvtGMcZJTqrgm834s73t3jxG6FREupShfsXjEs1/YbUjn447rd7CwoOXH2aX2jx/KBHTtBgiLeM0bKImqikSh7U+xWRt26kqAeifKsh43ljCHJIWS5roE7bln5x/G11Q9SxUKmD5GqlmNRbUmF6Dt/oofaWKWYyNc5SVLUiGasXF2+CWYCqWD5BkPdFrjSP9j1GDgDzENEC4SO+3T+ENEL//0adYslLYVRNrKP8wZ9W+aU5wXgCmiAt5DJepIXvOOREKFAUW4yRSM3Be5AFZ4dKhXetq4xia5bR41VepXT0mhlztaha/w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: VpYPH53qkr1zRBYXxBudi1ScJkl9+CCRNGRBDR2FtERCglFoGHrwu/qNE/np6QglJ/uCnr2sEimopoaJlT1uAq0BSG7QGhw4SdfPKEF/ype1WPl+0Nvlb1SQu9d3tcKkAzbdbOCbSS1wKK0Cs6MVo0zyfbQVNm6qoFwmaE7EkKSBE3SPMNbea7p28GEihdO4o2o7FDswMNfjZyU2y9bDOY57nMIgaaBQGoqLHxZtL6NxA7NxNut4LCCcaHxUI9dwhtnskoFzMThO7UvpkrrlsTtEh+E9TsswSrbWyGWoGIefq5nsY4UccO/53Ed2up1HuMP1tEOD18UmCX5AYbf/RQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH2PR17MB3797.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: fdeaaa66-8b01-4b7e-bf40-08de7e3000d2
x-ms-exchange-crosstenant-originalarrivaltime: 09 Mar 2026 23:02:57.0078 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: uoumXk+nwWo09Kbzw7hE9DHrZaPKgFKEKi8IBaMBwqj+mRvpv1l4P9PfGTqHl/r6qz1Ic1qrVDlTL9/ylpLuDg==
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR17MB7573
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2602130000 definitions=main-2603090202
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfX3KbuMwI658/V
 J5Anx7c7U/rnNgPIMNe9XaCU8HQ5mCwGWc5NBkDZYsboV/sf6hAe5oEGaq0TWNIY5tqzbPe/I9f
 z/ZvPj10prUbrAvPDJKsO4gnCYbOpuI3zQxXzbzeAQS+qu3N6VOz5sQc6PhiFPXVDuhEPfU5wM0
 tymFnGszP8hFfR3AhU7wulzZg0M6e7SKD8cu5QQ7GfwadQgJekbTP2535R3eopZa6aLVCwQBqlG
 SPfIVxTyJZvN0ubIhXFr4bXob0WeyNoOUsY+zZWSiicEr26H1V5rjVtjtGRlLC9DT/nUjadSgTn
 WXvl+YPCMqlKPZGWk2HQ9rJ8HClm61/yxWz0+YHZ3EFYpJPgbizs+dN8B22wr12Yyo0+Q4JNa3J
 krnjMgCjR8Le9pIN+Krg5pmVJGKTq+MERvmo/d+6EIgGz2pP9Nqr2CeZbBw0y4vEheqRVBaLGae
 7b/6TALqJDg9vfVNq5g==
X-Authority-Analysis: v=2.4 cv=bahmkePB c=1 sm=1 tr=0 ts=69af51a3 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8
 a=l5EkWL-BefAPXQSqTN4A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: ZSlD3i8Y2J32nYgKJZzHaA0rzXXP-k7N
X-Proofpoint-ORIG-GUID: ZSlD3i8Y2J32nYgKJZzHaA0rzXXP-k7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603090204

On Mar 9, 2026 9:19 PM, "David Hildenbrand (Arm)" <david@kernel.org> wrote:
>
> On 3/9/26 18:49, Max Boone wrote:
> > Don't split and descend on special PMD/PUDs, which are generally
> > device-backed huge pfnmaps as used by vfio for BAR mapping. These
> > can be faulted back in after splitting and before descending, which
> > can race to an illegal read.
> >
> > Signed-off-by: Max Boone <mboone@akamai.com>
> > Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> >
> > ---
> >  mm/pagewalk.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index a94c401ab..d1460dd84 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -147,10 +147,18 @@ static int walk_pmd_range(pud_t *pud, unsigned lo=
ng addr, unsigned long end,
> >                                continue;
> >                }
> >
> > -             if (walk->vma)
> > +             if (walk->vma) {
> > +                     /*
> > +                      * Don't descend into device-backed pfnmaps,
> > +                      * they might refault the PMD entry.
> > +                      */
> > +                     if (unlikely(pmd_special(*pmd)))
> > +                             continue;
>
> In general, if you're using pmd_special()/pud_split() and friends in
> ordinary page table walking code, you are doing something wrong. We
> don't want to leak these details in such page table walkers.

That sounds sensible, there is a check in the split_huge_pud macro, which p=
reviously included DAX memory.

Related to handling that macro, I see another proposed patch for lazy provi=
sioning of PTEs for PMD order THPs [1]. Possibly adding a return code to th=
e split functions allows a better solution here as well?

I'm not sure if making the split (or rather unmap, calling it a split has b=
een a bit confusing to me as it doesn't allocate PMDs) a noop will improve =
things - as to my understanding it will still try to descend.

> We do have vm_normal_page_pmd() to identify special mappings, but I
> first have to understand what exactly you are trying to solve here.

Specifically for the page walker, avoid splitting and descending into the P=
UD-order pfnmaps that VFIO creates for the BAR mappings - as these (can) re=
present hardware control registers rather than regular memory. I haven't be=
en able to reproduce it with PMD-level pfnmaps, but I'll build a kernel wit=
h PUD-level pfnmaps disabled tomorrow.

But if course I'm mainly concerned with fixing the race such that reading n=
uma_maps does not cause an illegal read, resulting in the read process cras=
hing while holding the mmap lock of the process (and subsequent reads of pr=
oc freezing, waiting for the mmap lock they'll never get).

> (You would also be affecting the remapping of the huge zero folio.)

Ah, good one, I do think that this race can occur with PMD-level mappings, =
looking at the walking & splitting logic - but given the PUD-level mapping =
triggered the (rare) occurrence I'm fine to focus there first. I guess it h=
elps we don't have 1G THPs, but it would be good to treat 2M and 1G similar=
ly?

> A lot more details from the cover letter belong into the patch
> description. In fact, you don't even need a cover letter :)

Hehe, first timer, still figuring out the process.

> IIUC, this is rather serious and would require a Fixes: and even Cc: stab=
le?
>
> I'll spend some time tomorrow trying to understand what the real problem
> here is.

I think so, the bug can be easily triggered by repeatedly booting up a VM t=
hat passes through a PCI device with large BARs while continuously reading =
the numa_maps of the main VM process. The reproducer script is mainly to na=
rrow down to the specific part where the race occurs, the VFIO DMA set ioct=
l.

Should I raise a bug email to refer to, and resubmit a new RFC v2 (without =
the cover letter), or keep discussion in this thread for now?

> But for now: can this only be reproduces with PUDs (which you mention in
> the cover letter) or also PMDs?
>
> For the PMD case I would assume that pte_offset_map_lock() performs
> proper checks And for the PUD case we are missing a re-check under PTL.

Have only seen it with PUDs, will try forcing the mapping to happen with PM=
Ds tomorrow.

> --
> Cheers,
>
> David

[1] https://lore.kernel.org/lkml/20260226113233.3987674-1-usama.arif@linux.=
dev/
