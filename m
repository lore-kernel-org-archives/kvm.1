Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793226892;
	b=uRqsV9mY104I696CajLEQGRNHlyCMV4t7qHAX/90SofiDi6W+wQtOVvHhgle9KoNjEKK
	 0JxtuQfLPyBHXddRPzM65h5rmZnERidXObfOmeAPqNqkpjKujzMopbF33/K8b2TrBWn2X
	 /IHcbmUxHVW4VfXoO0gE//U7lpLcVGG1tJbXRGqb7ZhOrujX4d7VXevo+vaVATEV+t6Bm
	 vouAuiskzEe0/arLgjaA7+kHVW2qnntH/5iDxjEP/VArVfEf02X6m3L6dy4MxCFQ8e6b4
	 wekmyohbhojTdRyC8BKpw3oXGKfJUkFvYpP/2886+EJBe+ADG+NaZ/w7CltSN71lWqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226892;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:client-request-id:
	 request-id:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID;
	bh=Lgh+hhGS75rubWV5zgCJ4hXh7MmZKxcyo4q5zkkgJ40=;
	b=DDJUIFbx3Gv714xguzeE/KxLbr9PrX43UJCKxU1yKLAzovcyg25OmVkhOEoEdbXpqZv1
	 easp+w0KGNM41bxZLCCCAaUQkBJCA7M6QBGYenRY754R2hyoKWUq893NGT8kbs+qKWTkm
	 HTq0m2pf/4ZTeg2mG2Y+JiTY5eHbY+saR4fE16jFzKuY4r7E56eajhdkS2gNREL8FTb+E
	 32SsBo9F5v4FBJUot9F5Uz9t5Y2FB97PT/IYzs4H9NY9O7NxK5AGodveQ3J5kfoHJFutR
	 iLSq/byMK8kGm+hW5ajwgug+3OzuCR51PdBM3qCAJVFFeuYtvVAaiaI+6JMGs29VHzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=gnPjXsin;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b="tiXzHvJ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A720606A31A;
	Wed, 28 Oct 2026 22:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A720606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=gnPjXsin;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=tiXzHvJ/
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SLBo5G3996656;
	Wed, 28 Oct 2026 22:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Lgh+hhGS75rubWV5zgCJ4hXh7MmZKxcyo4q5zkkgJ40=; b=
	gnPjXsinAfL2Gypp7213E/eQLbmtuXxwaWWoTmpLa0hStIQmI1ge1oVYr3dzPxHT
	9PVFABWZwKGTYQZGNe8UJ5rJhq1L5dpw8XUv3Vcd8YgevtKVLdRErzZt4E+EL4cA
	oUie1FaG6D+jJU+IhFg3Cu38PXkG18llLGYNY7uUxh7Yj9ytKoWYiTv+Hlg0hPT6
	fqktqPe3/mawAVLu07znj8LeYH40xSddl/HSxEoVDDQEbu5vAJmCbCAeKlVtKtlr
	sNFSEsjQ9x7/pHHGtYlDncfkVXpO/xaotvDmYeGpvrw4zMTSDViX4TKgl4dPsfrL
	0MUft8rDvOTw8Qmmr/2+uQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgmj7pm2a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 22:34:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69SM87jH068847;
	Wed, 28 Oct 2026 22:34:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hkqx141f7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 28 Oct 2026 22:34:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1Abj3979bDyrISJZJUwJlAjtE5rosHcAzBCYo5k8EOw2YHPueKMUadtGSkiAqyn4kRFxDyHQmc8rSR1doi1vJSVOmDABwS9bPjWJPyYQFINJrmPccqZeijw0BLgqtN/pMdm2zPveAWTDRLtMnJsrAHJ7L4+/8YxrPY9BYV0N8GcIVLTA1cbWHxi3QyZEm1+8dEv9sVYhwPQ12D7ky2rW9X5OGqtX6hwweiHnBMT2sKlmnyv33D4di9/hMJtyZf/ST/wPeanLS1RduwasHjqXywGW7e6piIWQsSYkzGgKLJO8gZXX5kR/azJB8R23UiNodxaZ5ZQD/WxOcMsowu5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgh+hhGS75rubWV5zgCJ4hXh7MmZKxcyo4q5zkkgJ40=;
 b=gOiMJxHIdUL1xz9VqcU0NpxZRQmH1+qJ0OYTvXtRPG78eiz7J/WDmCzwTcdOGaWH/WB4YGtoZ63dn8OFcFM/Gmcq4TPy7nKw+6qRI3yX1qHZmdz8bSgSjdawiGKf5UFkYPSlMbt955+VWGY3G37PHNWe62tCcdJDsiHOWt3KgIXgFXnb4/QSwCvUZr9v4EvP4fYORVnLiUfOC49Wn4zpSxkqwIKn3mAD+ZuHRgilWbgVLRiE1gxIyYqlHU3SYdtutkGRL9R73mBFL8LbQozcBR880z1SpXk7hu/7ahrmcYNNc7f9oJxT1dbMYuUJiIVJPmt0ODprYfauqfY/Lhz4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgh+hhGS75rubWV5zgCJ4hXh7MmZKxcyo4q5zkkgJ40=;
 b=tiXzHvJ/pbaSeqpROFPVNANZtSvhYNkYwfwhbLEL8ukXdROXqe8kh9RExYvgHtX0K3Csi0aGlgeB+HmR9+ModHj1Cdh1QOQ/TKE981+IgrIgztiAv3BbaCH0s0AF3Y2AFslMc2WxLKiOzIo5csKdkdYXxOfogbN+jEzer0ZMk90=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA3PR10MB8346.namprd10.prod.outlook.com with HTTP via P2P; Wed, 28 Oct
 2026 22:34:12 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 22:34:11 +0000
Message-ID: <62e09b20-b839-448c-90ad-0c63233b523e@oracle.com>
Date: Wed, 28 Oct 2026 18:34:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: x86: Select lowest vCPU ID for aliased xAPIC IDs
To: Sean Christopherson <seanjc@google.com>
Cc: Partha Sarathi Satapathy <partha.satapathy@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, wim.ten.have@oracle.com
References: <20261027051808.243000-1-partha.satapathy@oracle.com>
 <auDF9WpqW8OCu_8w@google.com>
 <85b0e3aa-0b84-4a00-852a-821aed4a0649@oracle.com>
 <auEI0B7QkIhg-lLG@google.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <auEI0B7QkIhg-lLG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::6) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA3PR10MB8346:EE_
X-MS-PublicTrafficType: Email
client-request-id: 97f70ad5-4899-42ae-9624-7f01c0f7f1ff
request-id: cfd687aa-9efa-4a86-12b1-08df354396a6
X-MS-Office365-Filtering-Correlation-Id: cfd687aa-9efa-4a86-12b1-08df354396a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|261021121427099003|261028144727099003|261026140227099003|261021135927099003|261022115727099003|6133799003|18002099003|3023799007|261026121527099003|22082099003|56012099006|261021123027099003|261022105027099003|10067099003|4143699003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	UiKJ2tFMd+qbUzObCR3uUGouecxFN0TRAmTxQCnavV0EHn0nlUVmyDayIFPkmNOBDXgcin8W288qIEXx6CfbeQf7VUhs2q1P8dI9QZd0yJ5Yhae2u+PZrwnzaHnqLhhNJFjTYrj33Kw1t9KduG72WV6icNQS9dm562ux9s0QvkiI6CyJH3BbWRXEsxHRbYC7UeDRvqHSg5d+OJnD+x2vQUalF8oosUveAgNUCTq3ulKg6IcEehvhZGiVioTniW5ZLUNGUPF33QSWkCpdT6D4QPrACxJb2f5uFskzi3hKFFlOn9t5FcgCMnbL025lu8ev0DoDX9BjN/QwFFLrKM+rkljBu08m4JYWpsHOrpirJdMeMXrh0+CVaU8SHozKscIzP4oMKeWbSo5LF71nD3T7d5A9eVdxVJc+ap5nKO4Sq/ryaPlKq7sz/zASkq8tmMtQGhDYf3MhUDTG9e7xDUFjfonKMoR+R0ltkfUUhjKEHDcKIZS7j04G5z8WNJ9kcsvQbe6IPRrMwySBQ1u+aLGdTxYQVwfRCBRO2omNLrfi72BdMRWep1xubAzn5R21bJmVMuAQrBFBey6hu8XmB5y7pnANgwHl8f9QnWDHp7fV9YMac4x3InCPl/fiK42B64Bt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(261021121427099003)(261028144727099003)(261026140227099003)(261021135927099003)(261022115727099003)(6133799003)(18002099003)(3023799007)(261026121527099003)(22082099003)(56012099006)(261021123027099003)(261022105027099003)(10067099003)(4143699003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFl4MkZnSHB2QUxiQ2E1ODg5OUowdXNWdUNaT2tmMUFoa0lzOHdFWE1BcWtt?=
 =?utf-8?B?K0lKdGt2OVFnUHhWYTBVOE0wMmR6WE40NjVqSHh3TytzK2dLS3FhRnhUWkg2?=
 =?utf-8?B?b2VLRlF4ZkhmWUZCNG0zdEJJRGdpN2I0c0NTMEJaaVBHdlVKODV3WWlDUkht?=
 =?utf-8?B?eVJxS2RVT28xODJOMURtSFB3YytQM25DcmxrRjU2Z01rSWgzVDc2L21RczhB?=
 =?utf-8?B?NWpsc3RaWkR3SzVxajRlOFdESjdMUk5YZ0d2Um1kdy8wQTlYdXgveHpaeGRs?=
 =?utf-8?B?dkxOT2QvTlBSQUtmY28vRlFFSEkza2Y0NFp1dzNDTEtNdjZ6Ujh2T2ZZd01k?=
 =?utf-8?B?QVVYQUdZNENFNTRaenRoV1Aydm9zSEZ2eU9vT0hFOGxlUVEvNERwaGRyZjFI?=
 =?utf-8?B?WHgzb09adGhCRUNQVi9zUUd0U1N6TjFsb0ZZM1Eyak5NeWdkTVgxZUVlSytv?=
 =?utf-8?B?aFphTVE5aG9UTGc5Y2FWZENxRlFpbUZSbkdVdllRc2Z4dWcyOWdZdUxpd0dX?=
 =?utf-8?B?RkdMRXFIdEFnbVFxSGVSZVNhSTFSRUpEazlraHlkM3h0UDBpaE5QWmw0VXAv?=
 =?utf-8?B?ZXY3dlp3b2hMeG5BNUFYTVlaSTZlRXIwSTdBTTE4UDBoRHYra1l2YUdlb3BH?=
 =?utf-8?B?VTZlV3dYSjlBU2J0b1BrRFdrcThXTWtxSzBENEFwUXllZVdwem5aWkczVHBp?=
 =?utf-8?B?Y0NCbHVGK0hOREplc1FRWU5OMWN2WHRPWnZFZ3F1aXhaUDMwbE9CUXVBSUR1?=
 =?utf-8?B?S2RSdHBoOGtjbndpbFJUOFFwVVlBcGVLZ3dyUHdPc2VIMlc2RkpOZ0JRL3F4?=
 =?utf-8?B?YkFqNnVlRlBVYmVsWGRTM3dTMUhGSTRIMUJDdlZnKy9uT01IM3Y4ZDUxNjkw?=
 =?utf-8?B?eUR6bTdJdzhpRlRvbVRIbUtFWFNBVEZheGE5elJkdU0wMjUyYWI1MmtIVVdF?=
 =?utf-8?B?UGUxTW82RHhjeU1tRjZCaXhwclRIaUt3QnkrSHRSd0crd3NUZUw2ckhQZTJ2?=
 =?utf-8?B?Ny9lcnJ3UGZ3WlppZ0VJMk5jRWROMU5FTU5jajFvVml2QVFGbWVzdVRKTXRw?=
 =?utf-8?B?QkFnS0w4aVQ1KysrOXpXOXRNWEZidEdpUGs3NWN1cVg3K1ZDQzIxbHZjYWkx?=
 =?utf-8?B?V05xNmJiRWRQb1pKM0hNQ1Q0aW1HR3RxNUM3dlVYeXZGbU85UDdmRFM0N3pp?=
 =?utf-8?B?NFEvWmdKRFkxbHdZOS9KTENVTzFlcm0xOW9UYnduZFJvVEFGZW9DdURKU1pT?=
 =?utf-8?B?NVgwM284dmV5Qk93dUxMZHNrSTdWTit6TXYrOFpvcHFwMDdGNUZITXBHd2Ra?=
 =?utf-8?B?ZVNWTW1CbU9aZ0NMZkEyc3UxdWM4aTlDMysraWc2SU1BWVk5bkhSY2xnL3ZN?=
 =?utf-8?B?TXJVUGZTOTRJeGsraWJsYk9XbHNyNXFvL2llc0R3ejNNczQ2cEdVdTA3MmpC?=
 =?utf-8?B?RzlRNUlnaDVQandFNnRnaW1EbDB6V0pyMGlpR0pZbXFTTVlwdWc3VUxBdkkv?=
 =?utf-8?B?MkExLzhyZnV3cjFpSEM1UU1QODV3ZjNURzFBTlNGdENNM1owU0RyVkF1RWRa?=
 =?utf-8?B?ZDNzclNOMXpjU05KNzFXTEIzeHhqVktjbzVzRVk4VWZMZ0E1LzdMdUY0aU1Y?=
 =?utf-8?B?QmJYNmJveGdJbndBQjN4MXBkTUtiUDUzNllZN2JpQWd0TnlqT1dTeXFiWGxW?=
 =?utf-8?B?eUJ3eFk4VWk0NTZoa0dFMVBuMUFTcGtxZDllNkN6MzcrWDN1c3N1Y2dEbXF5?=
 =?utf-8?B?TWFJVy9OQmdBSkZDaE1MSXk5a00zbm1iVWZpMUY0YURsRjNWWTVvaHREUVk3?=
 =?utf-8?B?eUM4QStCRU9XL2VaSUNxOG8vSDFnR3NrL3ZzNFNrWXBMSFJZTE1IWGkwWU1s?=
 =?utf-8?B?UFpWVHFTRFR5VXlCYlNyaDdRRnAxSHE5U2F1K0xBWXdNMFo2YmorRlJXV0NL?=
 =?utf-8?B?RDQ3Njd6cGVHK1duTExsTG9paGZId2IrZWZYL3VuMTFwclFYNkxpR1RiSXZS?=
 =?utf-8?B?Yi83Z0NLSC9WRmtqSjhlSjh0S3lGSFlaaVNVdHhucGlLT0Y5NnZoWFJZUHQy?=
 =?utf-8?B?blNHT3IyQ1NqQkJDVFNZTHR0N3JqN0Rkd3RoR1JPdXFPZkM5Z2pOb0ZPWk1H?=
 =?utf-8?B?Y2YxK0tNQzVhelhxMW1TdGpFREcyYnNwcWRWbCthTFNUMGVFZUdybWpucWtj?=
 =?utf-8?B?emJTYWxPMlA2dUQ2WjM3SmtydFJpckI1NkRRR0ZKMFVXOS9PRDlGT0htOHFJ?=
 =?utf-8?B?Y3JiNFAwa1JGeHdzQzJNSkpoZVhDL3kySXQ4WHA4SnRNdVkxVWxYZ2pMV2pR?=
 =?utf-8?B?Y242bDRWL05uS3hvSjlLK0sxdVFncXQyb2xSOXk5R1AyMmMvUGF6bFVORlJv?=
 =?utf-8?Q?uX9WnjwQHa1kSy0M=3D?=
X-Exchange-RoutingPolicyChecked:
	Kt02UMSIvOJYrZmOnXQWu5BTNipDjtNGRUvwgEzSEw3t9IURnxIbYdxoO4V4RcFGP4abdszHzVLG6hQOFrQtLRgYwCAytj9dSZqNh6jcuO9dILz5iKPZWhpjwIOtCeB/VO2NAB3I/l85k2m0UOfztucuOTiXKkh9uwch9jWLnSfj1b12DiuffNkJAQNhWxvsO2grhmPft+1fYEZHCZNCbEYIYhRLdMYMF4uzMxanvyDIwYzmExIGcz/1RZfqS7JdkM5YdXWuq9Bh5jk5AyZNvNT1Ud3IweNjrXyWo/wQV5dv2MFrwPI9sSlJNUvdoousNMD0pUYVMiwOrWWmInJssw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jkP4IuChflHaQoSxRCpNj6cBHMMmTc1gGXWkmUdnqYGMPZEAeI2Lx/q29F+QG+Sk1ocVeb37/UzNM0XMwPDZAhLZQNDanSAOVXJC6IsmJ02WzcOIiwLHzY2Hbyo3UVKwbwtfun3EOGMrL2uDc9u7JwIcBMUskw5lEJgyrsbQABG0oj+79IoxJRHLu6abAID/TomvQqZxxyFxFzBwTEefs2pavotwYkiAy77iDKSmBpKqAHaB5ww+Ck5l8Q3tgYhc/VNCmjRs7HmjTrzvdDq8+0RTJ+envVa4f1JgPDUAAWJYve+swxGJ8u7222X3Ut4xqXV6lCWIcTPRNTJalMQ9dD/fGEvmrbTExUR+AmM0H5L9tB/XkFfgP0cFSSsB/4cKjH34DpqYLqdIRzmTSA+VlgZ0lSGBLVu5Da0VXVoCIT7lSKFhv/gq55K5uqfq+65f/Yrr4dQaG1omkpP/18pyAlOxO5kD4ZI3X4WFaXYPfKNmH0T4YxAMKwfgbND1T+tajPZKX3L0q+WfrYm3KgpbHeC6SZZr2IsyEMVYt16f7ZdfviL+/i8EB7flgB3Ox0PNZ8IP0seersrwfaEpeyTmkn/HHYfy89gbA+vhJyfoqDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd687aa-9efa-4a86-12b1-08df354396a6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:34:11.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz+PDaPnqENC45d85ylbJu0jZx1AKIjh9K0Ex78C+9GxqS2BpS83GklJdP2KRALRsZ8Dafc8KwnVKtefl2hS/Q21OQgHyW5iTC3E01wsal0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 adultscore=0
 mlxlogscore=-999 suspectscore=0 bulkscore=0 spamscore=100 phishscore=0
 mlxscore=100 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4OSBTYWx0ZWRfXxMGvoZpCqYgL
 kdjmLbJyWjzmO92roBKViKwDhqCQ4+uNTg4Y5xMCq1jgav0O7YZ8svRiNNL1LHOZaqfzn1DhqoO
 xzKG+Ing53aq0YH1QfE80wwW5Qj54nwJ/Pf8kq9hT/w5r8cdKECvowrnvD/BPJP5dEqvRhw2GFo
 2OFbMq2PEpfwwfRz6aP7l6R8ATiMWO8b3wkxyRc+I6fQQsvto3fP5s1NQKwHmI5iDEmqZz46PMW
 zeoRoSZAEXMkZiUoHR7bRZa6O/v08DuYxPf/slQfzt/raJKBWZ9ODco56AQBTTHm1HSjcieFaH+
 w7UmGJcDpzU/duxi4CirQx49gRo4YfsSzClypb6JOoFzrbN2y5aM2t2JwfzyVhA0aoHteOW3Ndn
 SdA/ENbagxVuVhT8evcKxridRHA/LK7NiXkTsXQfqsaQBC81MfDD+qvHIPZTVNaac1uZs0l0xMP
 Wq+UcjR6G7f5kyhKHAplWfZpLMBsocXTevr60ptU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4OSBTYWx0ZWRfXzc/vXB83el5z
 MdiBdX9p503SXx/Gp6oXyjIjKTh4StC9IyZu2Fv/4UEp9vcho9pUZdBcErpHt7syKUhrav4po5E
 LPtEd5I5tKUJHa5zWxq8jyMD4h1NnRshH+YJLr2nrJ1lPud7kXQa
X-Proofpoint-ORIG-GUID: zcyI-KA1by1nGcT3EXEdbN8tXuPT_xjW
X-Authority-Analysis: v=2.4 cv=cKV1IVeN c=1 sm=1 tr=0 ts=6ae27872 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=iTPJzHH51ZrYGbrdj50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: zcyI-KA1by1nGcT3EXEdbN8tXuPT_xjW



On 10/27/26 4:25 PM, Sean Christopherson wrote:
> On Tue, Oct 27, 2026, Alejandro Jimenez wrote: > On 10/27/26 11: 40 AM,
> Sean Christopherson wrote: > > On Tue, Oct 27, 2026, Partha Sarathi
> Satapathy wrote: > From: Alejandro > > Jimenez <alejandro. j. jimenez@
> oracle. com>
> 
> On Tue, Oct 27, 2026, Alejandro Jimenez wrote:
>> On 10/27/26 11:40 AM, Sean Christopherson wrote:
>> > On Tue, Oct 27, 2026, Partha Sarathi Satapathy wrote: > From: Alejandro
>> > Jimenez <alejandro. j. jimenez@ oracle. com> > > When
>> > KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug > quirk
>> > allows events to target a vCPU
>> > 
>> > On Tue, Oct 27, 2026, Partha Sarathi Satapathy wrote:
>> >> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> >> 
>> >> When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug
>> >> quirk allows events to target a vCPU by its x2APIC ID while the vCPU
>> >> is still in xAPIC mode.
>> >> 
>> >> In xAPIC mode, APIC IDs are truncated to eight bits. Consequently,
>> >> vCPUs with distinct x2APIC IDs can share an effective physical APIC ID.
>> >> KVM's x2APIC erratum specifies that an event targeting an aliased
>> >> physical APIC ID is delivered only to the vCPU with the lowest vCPU ID.
>> >> 
>> >> However, the optimized physical APIC map does not guarantee lowest-ID
>> >> selection. When rebuilding the map, KVM retains the first xAPIC-mode
>> >> vCPU encountered for an aliased 8-bit xAPIC ID. Since vCPUs can be
>> >> added in any order, that vCPU need not have the lowest vCPU ID.
>> >> 
>> >> For example, vCPU 19 has x2APIC ID 0x013 and vCPU 275 has x2APIC ID
>> >> 0x113. Both expose xAPIC ID 0x13 while in xAPIC mode. If vCPU 275 is
>> >> created before vCPU 19, the map retains:
>> >> 
>> >>   phys_map[0x13] = vCPU 275
>> >> 
>> >> An INIT/SIPI targeting physical destination 0x13 then starts vCPU 275
>> >> instead of vCPU 19. vCPU 275 executes the secondary startup path for
>> >> the firmware CPU entry with APIC ID 0x013. After vCPU 275 enables
>> >> x2APIC, Linux observes APIC ID 0x113 and reports:
>> >> 
>> >>   Firmware: 13 APIC: 113
>> >> 
>> >> KVM hardcodes a vCPU's x2APIC ID to its vCPU ID. When populating an
>> >> aliased legacy xAPIC entry, retain the vCPU with the lowest vCPU ID.
>> >> This makes optimized-map selection independent of vCPU-add order.
>> > 
>> 
>> First of all, apologies for the confusion since this is an earlier WIP
>> version and due to a miscommunication it was sent as v1. The selftest also
>> has changes that are not included in Patch 2. I will send a v2 after the
>> discussion on this thread.
>> 
>> For this patch, the intended commit message is phrased/focused on
>> maintaining the stated KVM hotplug hack behavior i.e. the commit should be
>> more like:
>> --
>> When KVM_X2APIC_API_USE_32BIT_IDS is enabled, events targeting an aliased
>> xAPIC ID must be delivered to the vCPU with the lowest vCPU ID. However,
>> the optimized physical APIC map does not guarantee lowest-ID
>> selection. When rebuilding the map, KVM retains the first xAPIC-mode
>> vCPU encountered for an aliased xAPIC ID. Since vCPUs can be added in any
>> order, the initial entry does not necessarily map to the APIC of the vCPU
>> with lowest vCPU ID.
>> 
>> Compare vCPU IDs when populating aliased xAPIC entries and retain the
>> lowest one, making destination selection independent of vCPU creation
>> order.
>> --
>> 
>> > I'm genuinely curious.  What VMM adds vCPUs in a "random" order?  I agree a fix
>> > is needed, as KVM should be internally consistent (kvm_apic_match_physical_addr()
>> > will always try to match the truncated ID).  But this also makes me wonder exactly
>> > what userspace is doing, and why.
>> > 
>> 
>> The issue was triggered with QEMU and a tool that uses libvirt API for
>> resizing guests and balancing their vCPU allocations across NUMA nodes. I
>> am not sure if similar work has been published upstream, so I'll defer to
>> Wim (CC'd) if you want more details.
> 
> Oooh, actual hotplug of vCPUs.  That makes sense.
>> 
>> A basic reproducer (besides the selftest) simply uses QEMU to issue
>> 'device_add' QMP commands and starts with a vCPU placed on socket 1,
>> followed by its "alias" on socket 0. e.g.
>> 
>> { "execute": "device_add", "arguments": { "driver": "host-x86_64-cpu",
>> "id": "cpu117", "socket-id": 1, "die-id": 0, "core-id": 11, "thread-id": 1 } }
>> { "execute": "device_add", "arguments": { "driver": "host-x86_64-cpu",
>> "id": "cpu017", "socket-id": 0, "die-id": 0, "core-id": 11, "thread-id": 1 } }
>> 
>> I wondered initially if this approach was breaking some convention, but I
>> have not found anything stating even a "random order" is disallowed. So
>> here we are...
> 
> It's not disallowed, just unusual, obviously.
> 
>> >> The separate full-ID entry remains unaffected, and destination 0x113
>> >> continues to select vCPU 275.
>> >> 
>> >> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> >> Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
>> >> ---
>> >>  arch/x86/kvm/lapic.c | 4 +++-
>> >>  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> >> index 1597dd0b0cc6..5dedffddebec 100644
>> >> --- a/arch/x86/kvm/lapic.c
>> >> +++ b/arch/x86/kvm/lapic.c
>> >> @@ -245,7 +245,9 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
>> >>  		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
>> >>  			new->phys_map[x2apic_id] = apic;
>> >>  
>> >> -		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
>> >> +		if (!apic_x2apic_mode(apic) &&
>> >> +		    (!new->phys_map[xapic_id] ||
>> >> +		     x2apic_id < new->phys_map[xapic_id]->vcpu->vcpu_id))
>> > 
>> > Hmm, I don't think KVM should always override a smaller ID.  It should be a moot
>> 
>> Why should it not always override the smaller ID (in cases where
>> KVM_X2APIC_API_USE_32BIT_IDS is enabled)? I interpret the wording from
>> x2APIC section in:
>> https://www.kernel.org/doc/Documentation/virt/kvm/x86/errata.rst
>> 
>> "KVM will deliver events targeting that APIC ID only to the vCPU with the
>> lowest vCPU ID"
> 
> Gah, foiled by my own documentation.  I had this wrong in my head.  It's not the
> aliasing logic that matters, it's literally the behavior of the optimized map that
> I was documenting.
> 
>> as having the consequence that we should always replace an existing entry
>> in the map with an incoming lower vCPU ID, but the potential corner cases
>> in this space make my head hurt :).
>> I think xAPIC ID is unfortunately writable, so perhaps that is the sort of
>> scenario you are thinking about?
>> 
>> > point, since xapic_id_mismatch will be set if "xapic_id != (u8)vcpu->vcpu_id",
>> > i.e. if the incoming vCPU has a smaller vCPU ID and a true xAPIC ID collision
>> > (not due to truncation).  But to match kvm_apic_match_physical_addr(), I think
>> > it would be this?
>> > 
>> > 		if (!apic_x2apic_mode(apic) &&
>> > 		    (!new->phys_map[xapic_id] ||
>> > 		     (u8)new->phys_map[xapic_id]->vcpu->vcpu_id == vcpu->vcpu_id))
>> > 
>> 
>> The above works for the case described in the commit, but going one step
>> further, I think it doesn't behave correctly in this case:
>> 
>> vCPU 531 (0x213) is created first
>> vCPU 275 (0x113) is created after
>> 
>> the map is not updated and will still point to the lapic of vCPU 531.
>> Reversing the creation order above leaves the map with vCPU 275.
>> If my reading of errata.rst is accurate, then vCPU 275 (i.e. the lowest
>> vCPU ID) should always be selected regardless of creation order.
> 
> Yeah, ignore that.
> 
> Backing up a step, what exactly is the problem you're trying to solve?  Because

The problem we are trying to solve is an INIT/SIPI being delivered to the
wrong vCPU during hotplug.

e.g. we create/hotplug vCPU 531 (0x213) before vCPU 19 (0x13), and
KVM_X2APIC_API_USE_32BIT_IDS is enabled. The first vCPU 531 will populate
two entries in the phys_map:
phys_map[x2apic_id] --> phys_map[0x213] = vCPU 531 apic
phys_map[xapic_id] --> phys_map[0x013] = vCPU 531 apic

Side note: I think that the dual entry behavior is needed since the higher
"x2apic_id" entry is required for the KVM hotplug hack, and the
lower/truncated "xapic_id" entry is needed so the vCPU can still receive
interrupts addressed to its xAPIC ID (is this actually needed/used behavior?)

When vCPU 19 (0x13) is created/hotplugged after vCPU 531, the APIC map
rebuild will not replace the phys_map[0x13] entry with one corresponding to
this new/lower VCPU 19 apic. So INIT/SIPI addressed to "lower" vCPU 19
(0x13) are instead delivered to vCPU 531 (0x213).

> I suspect there's no solution that will magically fix everything.  E.g. if you're
> trying to resolve an issue where vCPUs aren't recognizing SIPIs, then the example
> you provided means vCPU_531 will never wakeup, i.e. which vCPU is  "buggy" changes,
> but the bug itself is still there.
> 

Sorry, I don't follow. vCPU 531 would not receive an INIT/SIPI addressed to
the aliased 0x13 APIC ID in my example, but it will be reachable using its
full x2APIC ID of 0x213, for which an entry in the phys_map was installed in:

        if (vcpu->kvm->arch.x2apic_format) {

                /* See also kvm_apic_match_physical_addr(). */

                if (apic_x2apic_mode(apic) || x2apic_id > 0xff)

                        new->phys_map[x2apic_id] = apic;


My interpretation is that behavior is "the KVM hotplug hack", and that
behavior is not changed in the proposed patch.

My example was meant to show the conflict of your proposed change with the
"deliver to the lowest ID" rule, which you clarified is not a rule after
all :) (but perhaps it should be since it has been working so far..?)

> If this is about SIPIs hitting the all CPUs, then I think to have a robust (well,
> as robust as this mess can get) implementation, we'd have to disable use of the
> optimized map when processing SIPIs with PHYSICAL delivery, e.g.
> 

But then we would also have to disable the optimized map for INIT as well
(APIC_DM_INIT), since those would still be routed to the wrong vCPU otherwise?

And if both INIT & SIPI are using the slow path, they will be delivered to
all matching vCPU IDs, which is likely to cause problems e.g. hot plugging
one vCPU will potentially initialize and start all of its aliases too?

I need to test this with proper instrumented kernel so I can "bring
receipts" (and I think Partha is doing it already), but hopefully my
concern above makes sense.

In short, I think the original proposal of allowing a replacement of a
phys_map[xapic_id] entry only with a new "low" entry (i.e. one with vcpu_id
== x2apic_id == xapic_id) fixes the creation order issue while preserving
the existing behavior for the typical cases.

Thank you,
Alejandro

> diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
> index a9cf0e004651..65b8a612bfff 100644
> --- a/Documentation/virt/kvm/x86/errata.rst
> +++ b/Documentation/virt/kvm/x86/errata.rst
> @@ -63,10 +63,10 @@ When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM activates a hack/quirk that
>  allows sending events to a single vCPU using its x2APIC ID even if the target
>  vCPU has legacy xAPIC enabled, e.g. to bring up hotplugged vCPUs via INIT-SIPI
>  on VMs with > 255 vCPUs.  A side effect of the quirk is that, if multiple vCPUs
> -have the same physical APIC ID, KVM will deliver events targeting that APIC ID
> -only to the vCPU with the lowest vCPU ID.  If KVM_X2APIC_API_USE_32BIT_IDS is
> -not enabled, KVM follows x86 architecture when processing interrupts (all vCPUs
> -matching the target APIC ID receive the interrupt).
> +have the same physical APIC ID, KVM *may* deliver events targeting that APIC ID
> +to only one of the vCPUs.  If KVM_X2APIC_API_USE_32BIT_IDS is not enabled, KVM
> +follows x86 architecture when processing interrupts (all vCPUs matching the
> +target APIC ID receive the interrupt).
>  
>  MTRRs
>  -----
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index ecf611845fb1..255c8dc00e0a 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1181,6 +1181,10 @@ static inline bool kvm_apic_map_get_dest_lapic(struct kvm *kvm,
>  		return false;
>  
>  	if (irq->dest_mode == APIC_DEST_PHYSICAL) {
> +		if (kvm->arch.x2apic_format &&
> +		    irq->delivery_mode == APIC_DM_STARTUP)
> +			return false;
> +
>  		if (irq->dest_id > map->max_apic_id) {
>  			*bitmap = 0;
>  		} else {
> 
