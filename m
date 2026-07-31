Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E93C5DDB
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491510; cv=fail; b=tYheFazMMifyCxXHs/q4Yoe2+QdQIHDYo1cHok0u9NzEII6OqNpNk3qnJYHb+mCJ+K9AircVfQD6Z2V+P6WcB5pHoy86bAYJwa6R31mjTjGKN4E0RXHrPLsXrPtNxIRv1KFeuLHfDm/sVEqvtK6XZeHJtprGZ+ToHvCvmhO5MGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491510; c=relaxed/simple;
	bh=KGr7jHkmEhG8PYLRC/UzLforwoCrvNAEW4r23kqavFo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ffYH6OC5MosN8QOVGB6rlxsG9SIkHfbzAzuKRGfJyKgD0H7E1qDRSr/B3ViSj4f1yPrqIj0KWwDv1WqgP4w07EgG9nWyeZ4dKmKyMJrTfdCwplQ0/B1EEbXaUgREG9gJ32iZEByumWwczdpAvoqCpDHcMvROSj0McKInqNU1RW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=xB5mhxME; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vi2J9myU; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xB5mhxME";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vi2J9myU"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7xONX4149258;
	Fri, 31 Jul 2026 02:51:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=r1l1MkbFkjeXO
	M6N3v1PmTBXslD7e/NbZwFdZ3Yrk+k=; b=xB5mhxMEcpS3z6Tf1AV2T7ouiWcCc
	/ggW1ct6C/CQ76eb61kxv1niIpKn+EY3th27iQueXJojDviC8KkawCUdutI9E74C
	jUct+VL/zmNkf3KR0BDES1IPb+He0oRLWmxeKOUkMxoYyjDHPEaoZslD3dSV1261
	1lbh+qV7/PWcAmoPEa+iiPCcWZmredapBGlZh2sgpZm42upegvvlD4HnEVlPi1MY
	JSvtfawoH6Swd6a2UynjQICEW7cH8ysoh7qSKqPD0TA3ucpB4QYfHhnhGQhi2y5w
	mBHi4hP9HpqRQvTHGYqePmI8Gx2jXzX3ElwiLVvHQLVnY1LIsIFhHrXJQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020137.outbound.protection.outlook.com [52.101.201.137])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4frqg2g89t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 02:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ednQ/H6yfy3bgnyJ+Rv/S60AbG3DxAwDJCJv99lqn1gRVgudiHo5fJgovKrvDiRsgZhWl9j8qTmrdFHXJF12aQsryrpv8NJ1FfvFVESD2E2Ajzk9VadLr0FpM42nMTtgGYUe4kayrtSnZWMrSUN0mKaZMHtv+hqhmavwK6IdKlcz6TDqPBU6V6ttnzxZy/JGjxC7eUMyt5TWpIBkSVWZkAzqYKsgYcx+IJ24Rr2IdmVKGbJoE3C9X7oHPYsEXc/c8Soe20bT3cZlYDsdk+q1h2RsFPRUVUiqO+vpRXj6z9+cqRrC2zSOpq1TLiZtjQzTFFlgjRXZQZ2dGcgDP5LOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1l1MkbFkjeXOM6N3v1PmTBXslD7e/NbZwFdZ3Yrk+k=;
 b=qyUEtvAfKJqNzpPl8S/4iK++mdB7uyndfSXnMuKURjt6Tb+6ORXe/Uu5rGG/J/khTfrIc7k4X21WVN44yLksjvouS/UtEImdv9mhA1rsStdkmMdnU/wfIjf+CBgfiMUaqP9E9oj6QTI+gfeYZmaC6OdNEEv0Ojk40ACz2bYhr1nO0aA+a/GvEVWIGZ5Yc3tKFW+SsUc4kcN8yLXx7M+2Zzh4nbobFBoEuvI/l+El0ljSp3uW9ZCqf4TW+FDQxP29h6aYTWHahNGNFqIsWic/o/teTA4UFOJsjP/HXn81n3zMbduF66t+Gs+1KNzDcitZBHhXfyX38MTKEoVg5wjSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1l1MkbFkjeXOM6N3v1PmTBXslD7e/NbZwFdZ3Yrk+k=;
 b=vi2J9myUX4hXKLyPv4KsyONchVJdnANGcSxKL1Wz5aEPjlrf44oeV9Piuerky8eE9PeUplIHN572DxGUWRoZihDLNULpePJpzmurvgnNBdYY8DtJYWfBumstFU1cU7+tc72+Ku2ZKPGOsggQNlhKrbnFe4q2L7ezAoQhomjdBTnhrSvhJFa/i5hIG9BaUkTYcZFvZXwJL8ht7cIYJRpsiWI5nhCvzgjuQ2gZc4js/5c7iCdQ7kq6tRFdiT3xZ89gooaWm4WKmI4Ls29sItgcnaOXtKoK0C2zeEDoKOzgney7yWN3XXk39Vw9lUAwlfS3aOc8vUaqJmoxCFGNmVVyeQ==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:51:31 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:51:31 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Cornelia Huck <cohuck@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: kvm@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
        Florian Schmidt <flosch@nutanix.com>
Subject: [PATCH 0/2] Support for Hyper-V's HvExtCallGetBootZeroedMemory()
Date: Fri, 31 Jul 2026 09:51:10 +0000
Message-ID: <20260731095112.2975175-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::12) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CO6PR02MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b35b5a5-f56f-47de-f867-08deeee94c6d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|23010399003|1800799024|366016|38350700014|6133799003|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	P/Iqk36rU1d5XETLY53bfE2mVWjYesBI0lV5I8cx3oshCr6ms3vK/P8S34G0Wpqv60YbpsFsCHJnF+hr7qE7Yj7YQ1CsxVAeqaEw/TlPQaOaidBkRHZ/G0z7/B4jmDTGniMzt7Ep0y93ioYRTQhq+h71L/PFCX7v+Uk8Fq2d4D3hUF9weVPKjpjfdAalsbZ6J3Oa/yQ4+zc9b1V3SiEpn/SOGABE1AMCpdKFdSP3o/uJKSkLrqiKoiO5tjz2br41FCg/MbNnBFqyiglJS7QSu5ZYOL7EG/L8/OSLm4fIgMMjtizQKEt8yYy9nnQIOsuNFXVVf5ih9fCPojRPcQ9PID8tw2rrLLK9QlJoKH47DhUCM1bOFpNis+jukWLmCJ43Bzo12QoUH5SU4rVcK8yrvcCjsKIM2e+ZZFpML3BpdVMqFM9uovkrINH899LJ590Ky2uRmo74s5+2hmzYtg1txmw+mgXLdL96Eu0Txrfn39Bngz8e3KFo3QefTGhWCi9z3rT5SyRBad/rsvDW8GyxpFin48d1H8RF7wWDrh3N9n6tmObalbKmUIcuE0yhJ4OXNbX3KBikWCgTCh1Ta0QyYgdMNUzEPO9DXem14aEjmZZixusmUPfSu0DjnF5QKIXngHDT9+PUrEYLHmvbZuTbcbjotAaqfGcqBOQlCRNKQFEDvEQSwM4+ewDsj9eyabC7OM2mshrZyOnTAUIn1p2lq8YogHvNIlCFYW2Zmf8wLro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6197.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p3vnjnDDXI/mYWX+1/EBskInh/GYxPlI+hAXjUtEtvKMS4w/ZNd2ztfVnYGs?=
 =?us-ascii?Q?WqJshwXwVHtpfqhe0ZVS73IFZdwt1GZ3iGRvY8HkxOSOihDzHI/RGxEXA/PI?=
 =?us-ascii?Q?Hhnz9X08GPf+hoZtIQv6Fpkp36pKk6bva3b49Rrp5cjbgA6bdLyDuEKPRz+e?=
 =?us-ascii?Q?mfq2SGbl7y6X8rYvfIlWOYMgu/u3qlhkVxMwMfdc/zNg1yfpp/Q0sSLsw4K5?=
 =?us-ascii?Q?pGnB8NTYW4zIBm7WWLisVIOHOKQ/gSNxCE9g1zR46V1k01pv0zbQIgb6+Jcq?=
 =?us-ascii?Q?QhZFrlEyhevrf0XqiGcLQ7f++uh0RWXn2pdq0WU5NKb7zOLrnCRp68MWb7l+?=
 =?us-ascii?Q?3dEfQSfAwWvyJdq7/Xc6kqAGivdxfu+oZVJiewB3O4d55pGulRmGv8rVU0Sl?=
 =?us-ascii?Q?E6tan1dADKIMdp6E+KyBM/nQxaJyfJLSqdVWODayuLGvDz7uUAVegSxWu8bd?=
 =?us-ascii?Q?0Ij0kKyZb9ePxsR8/HthaH8I67jwf9bmoD41CbX35L+AsXVLMuwi/JGMcpWA?=
 =?us-ascii?Q?z1h0kapK64PQC+aXQH1OXUyhYtfX3yDHOiSSJ1QajaAnMMj4VNpg1VEZMM8g?=
 =?us-ascii?Q?F1NzBsGb/te4B+9LQdCKpbLFgfyKKC6BsUJnnCgGeYAyZamiIvgA2IWQDOAL?=
 =?us-ascii?Q?FLTIQCbCurS0UTBOb+8CtwLWBDg6Cp+JqyPQ7Z+bnAPf0QvR8eMU2bmb+nW2?=
 =?us-ascii?Q?C3LDXmqNV3++UZL59WVM9yuEqJkywbinj1zvOumrU4wOcB4+9fOJAC2MsZHb?=
 =?us-ascii?Q?sUzZut3+C01uDp9G6GqVttRhffEUrbD05C+Z8qgiQcGRdN4d+Ju+nbQJJCle?=
 =?us-ascii?Q?832YX0KDnFvyVo0rjpmPE/Uni4yLr2xCoeOb+wc46FixuDAWEkYKTZHbw9Ci?=
 =?us-ascii?Q?HhTfauOikgSbftw/e5300+sr7bBC8bBTJ9qHOqcrUtt6wCuEngT8rLlBFYuM?=
 =?us-ascii?Q?ZSrp4AwSXKCmmkdc4cPb0AD4NbI+7PrizvMyusWJfPSH/cYY0QOOHJNoAVYF?=
 =?us-ascii?Q?cW+3LJUKp2B19ofGlODkC1EONJLz/NrNUjMkfvGfOBDvjfO/2WltDqSDDp+w?=
 =?us-ascii?Q?TDwl7josts+ivMdppPreDVxGpHCJ3/1W4wZr/6EgL3Cvhm5XBfNAP/v9Iiqy?=
 =?us-ascii?Q?NBf4w5fnRe5dXfsCTazR6j4aJ+isUVF/I5ma4209uI6N+/urI90hfE+qbLYn?=
 =?us-ascii?Q?73Dm77QVogKLXd2qs+hsD4GtffG4Q0Ojr2W7WR3OPeV5MQl6MupO1BlZ8yJn?=
 =?us-ascii?Q?uW6cAFRLq2RT4sG03ttDEaBfPWJZ5oRYbDcjpWAiteP5AMSQ2vSCTjaGB8Id?=
 =?us-ascii?Q?Ww5/E4st1qAA/MRFDhHb6K5iUB0rGyKTGy6aNzWQoll3ML9HK8qT3zXd+FP6?=
 =?us-ascii?Q?MLpIicZkLh+qRzILK1HKIZuNSRfseiImJSg10+ULZ7zDCdWGVwSXyXSjHS2Z?=
 =?us-ascii?Q?JWhC+EPYxJt5gI/j5ALEIvOeXzOxz7ZmKnG+hY9OHzsTqsVOJEl3e3WP42A5?=
 =?us-ascii?Q?/w2FC2+GWV646y4xpCgDuAjiEELHxBUtr+r5g0ufBkhcEtBLu4Id565HLV9u?=
 =?us-ascii?Q?M7ecpWyXD/9EgvhaEsxZlW4To/3EEI47Ac7FRpu8basmZm/vvR2ONtmfJGtt?=
 =?us-ascii?Q?ky53AALFYGYfIrjHC989JkbJ+tCt4UGsBJ/rGhox5NNBKqzopNKxzbso9zHv?=
 =?us-ascii?Q?mm+DdMkHdHaa8vlRgvKFFmog4XstzSeTBbz6r+l1xplr1kgaGQiCe2osV+EC?=
 =?us-ascii?Q?ePwtyWQIcq8MwbWQcWZoFgjQDyKjXEk=3D?=
X-Exchange-RoutingPolicyChecked:
	RVFYSzM2WH3nwruLZs0gOk9A1D4hPqk/qAWF1O/H0Mez2Q/4w7LDiMjesQHIYG8G18Me/D3PPF9S0i63KDw2v8ObaGmQhRNSSFVbI/YjSNuySObdinJf0/vdeSgLtBPeNUPk3ytyebSM/WIVByTXLGPClBiB4cYSUBe8PsUkkH5rSeRxQ+CPPQT5wR5v2odUsclLi/JPsjAajI2i6CpIe8jkGB3xYhfNpzkp/VgX8IXL4iguBUhcTXvjLwCgOSq2n+e6MOmLfkUpfzgokhgZJzsMChzgiB663berO97vU2xwCa09CuAB5VoWXiJhMX222yvQPlrr3vRApSehF6btfw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b35b5a5-f56f-47de-f867-08deeee94c6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:51:31.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVEqw8zhwk3fgYcdzC3S6F5kgXevfjXw42Kipz1CW9HXd93uC68ip3cCecu/yCL/ZB3ojpb6XNBWgPDeii8lKZxHls5OwBctWJC3LiOl/m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfXws0hERSpIIOd
 qDBXH3tv9CAPDksxcCIavK120epE/mONlcE032esI0koiWAFeQDhSWqnkGApRfNU4MBP4z5Nk2i
 /dn+d9O+JCMy1+AI8NEAVmVMIwt9PBhtGhwpW/2GEE4yAzEbP8hGZpi6zcMOmgiU3IItxRI3W6p
 70TdstbEhHFmkNSpNVsq8wZ4JfBRuCvM30RbCRQm+TReuMon9nmKSRm4CwoAw1Bmrr4fsJge1VK
 B2GYVxI9TIoZNZtqkRyGXcBb7LpMQXk9d4GKktR+wOj4ulUwMarnMzVH8gRkOgbkr2GruU406v8
 Xhw65JO40DJeNUh+Dq+XA2wr22ODKIamytqXEzE0GIjX17j/ntnr7x2A2N6mX0pTrCvu8+R8pKF
 pgqqCQ5TcKUXow1kXU9lFR3UCIVpmAjQCjmWU20d3bnd+uRJ4U1WcV/EuC5zM9TzS1rf/J3uvEj
 o7wGuhMeDMHlSCunfTA==
X-Proofpoint-GUID: VwAgLH8YsDR0P3-R9K5PmSYXc3SWb57q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfX4f0gacF7SZlx
 EhBIjP3eRaEEfUiVEfum8apRd5IC25AjkSrELiKuZLANa8I4rpy+yp6SSsZUUMjXgTVlr5nfvcy
 41UKl+HCa3+D0TIS6/fdwuFnusiqPcI=
X-Authority-Analysis: v=2.4 cv=MoBiLWae c=1 sm=1 tr=0 ts=6a6c7025 cx=c_pps
 a=m7gYBUTXKXNlxA7KPONIMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=OZCAnqxBrRD5xbqKsIYA:9
X-Proofpoint-ORIG-GUID: VwAgLH8YsDR0P3-R9K5PmSYXc3SWb57q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

This patch series implements two new Hyper-V hypercalls. The primary goal is
to support "zeroed memory" enlightenment via HvExtCallGetBootZeroedMemory().
To do so, we also need to implement HvExtCallQueryCapabilities(). While
HvExtCallQueryCapabilities() uses another bit in EBX on CPUID leaf
0x40000003, it then allows the guest to query for further "extended"
hypercalls via the return value of that call.

HvExtCallGetBootZeroedMemory() allows a Windows guest to enquire which areas
of memory that were provided by the hypervisor are already zeroed out,
meaning that there's no need for the guest to do so again. This has obvious
performance benefits.

To get a rough idea of the performance benefit, looking at a 4-core, 64GB
Windows 11 guest, we can see that an otherwise idle guest takes a bit less
than 90 seconds to finish zeroing and settle down from the time the qemu
process is started. If we look at CPU usage for each vCPU task 90 seconds
after starting, we get:
1559 498
1294 343
1451 314
4015 2729
Conversely, after enabling HvExtCallGetBootZeroedMemory(), CPU usage is
reduced:
1583 458
1441 361
1279 312
1337 264
These are taken from the respective /proc/<pid>/task/<tid>/stat entries,
denoting user and system time per "CPU X/KVM" task, in ticks.
We can clearly see which to which vCPU fell the tasks of zeroing.

It also has the benefit of not touching all pages at boot. This can be useful
if, for example, the VM is started with a balloon target already set to
overcommit memory on the host. In this case, we don't risk memory usage spikes
on the host if the VM touches all memory before the balloon can catch up.

Major changes since RFC v2:
* integrated KVM ioctl (under review in parallel) into
  HvExtCallBootZeroedMemory handler.

Florian Schmidt (2):
  Add HvExtCallQueryCapabilities
  Add HvExtCallGetBootZeroedMemory

 docs/system/i386/hyperv.rst      |  14 +++
 hw/hyperv/hyperv.c               | 202 +++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  12 ++
 include/hw/hyperv/hyperv.h       |  13 ++
 include/system/physmem.h         |   8 ++
 linux-headers/linux/kvm.h        |  15 +++
 system/memory.c                  |   7 +-
 system/physmem.c                 |  50 ++++++++
 target/i386/cpu.c                |   4 +
 target/i386/cpu.h                |   2 +
 target/i386/kvm/hyperv-proto.h   |   6 +
 target/i386/kvm/hyperv.c         |  14 +++
 target/i386/kvm/kvm.c            |  91 ++++++++++++++
 target/i386/kvm/kvm_i386.h       |   2 +
 14 files changed, 438 insertions(+), 2 deletions(-)

-- 
2.47.3

