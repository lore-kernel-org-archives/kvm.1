Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68122D876A;
	Mon, 16 Mar 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677087; cv=fail; b=qhVsq+3eOxyKYgodXcLXqKqaAQ/CN4ylHLzb3wJOPlX6Eajn4kP6S15+vcXWJP74mw9b5XUA+N3QOw1cELYBjxvu3iLA0ilgjEKPTtHSlbvjG60w9UqJ4bQZsMAq2BoOAQ17lLA3a+6TUyNrKuylpgkQ+UHdJG5qhw/tGvGr4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677087; c=relaxed/simple;
	bh=HRjyncOQ/e3aMWbCrTX+do5HiRGvS32fyaqXa5C/wdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2wUQSP2p51fU8kEYgrjCrtEVmm94pf0rWZYGpkUiBBt7gKl08lsXuvKOCjmn4wH9aSqHziYmgVi93mx09r3mRFKgetfzOaQCeqFgu4pqFqT4JDGutJx3AAf7AJFeicpYJqEM4PDPVTZWGn4jANnwbaTCStBJTWpgZ21J9yViiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QsXl9D5S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GINEOrpQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QsXl9D5S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GINEOrpQ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDIw7r051567;
	Mon, 16 Mar 2026 16:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/xfEKvc6eoOvvWkSmYA8gwMPYN7PBFbnSqTlsXMCDuY=; b=
	QsXl9D5SxICIxAFUk6imyOG7Qm4EmoDXlFk/ihFzJfYzkY2DW2zHXPsXTkL6Xhnc
	oe5RYQvJwHNYhwxWHnI0xhxkjxJO7lwNBxy+F6WuZxsjT8iIaLzAJbhHxWC+Zdn9
	lB0m2f7Pns/lbtRRxSAixa6k/vl4JfvSlMCxgcyybot5KQm5Xeeub1Asq8TugKzi
	8SAOubAG62ML6liqZ9ShfVTAF94eri3y/jDa12o8EqUXgEvchVPXu3ZwD4GPw+PR
	Tsbq1Iir21TA5PZHBYS2ZmGpiwaurJVirGJJ4wZ1gt+3efCeqosgubH+nJ14rRuA
	FZhrc8AxGAZ7pyZucB8+UA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rakrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 16:04:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GELAge021885;
	Mon, 16 Mar 2026 16:04:37 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4m3mr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 16:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMCdPU8u/ze16Ra6YLf6J/lnLwHmts3Zy3LgDEnUAC2G6EWYm1VqWrleRjlxCCDd6wt/bO9QT6VzeqcPh0tX5YQ4cPyyJ+QeLQ2fDAQp2Ak++IRevNWaQoYrqmTZT16j0tkdo6FGoG7mRLB1W5cX9aE1BjerdKkIapq7PaWOny85XigODlNKRmohNfZTZV1S0NS9709U5kfK205LJSty8/SJEsN0GzO5Z7YfYSHdOJjQ3zDlmIRB7fWRHC2XsCuVhhvZUMw4ZuxuDCJtZKvOSu0MglXlw4i5PUtheilMMiAblnLSSXsJdk6hfe6IHrT0IoK+qdxXIOd9YuuHfljb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xfEKvc6eoOvvWkSmYA8gwMPYN7PBFbnSqTlsXMCDuY=;
 b=ssSbjP9DpgPVxB9b/Ap/+4V2s45X8wsXbwWhJqlCikq6Sx5NNSxNWe/CB7Ll7S+NT0QsOJroa+nVZNye8IpLoue/HD+eSlWpbq2AV2vc9n9x4lueX76iwlVp2Lmne5wJtLUxKZ/5geubKwcb38v1pk2oi5UBamlMZwqVju2LvUAE+mSXX03K5ArJshGLwCac6xb747o27t80UtVVmPhwgmdLdyebNJFYPC8IKHP9rhfAfC1VZgolvgkBCvvkyCDXyQnHIKfKdZWLOeXIRCzFv3lkL/eaak/5A9KYZXc+feMs0X07afQIWcBoQHvhG14PVSxayRNHSqb8ULLL2soAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xfEKvc6eoOvvWkSmYA8gwMPYN7PBFbnSqTlsXMCDuY=;
 b=GINEOrpQgYqtaN0p9xErGHPbPByn05ho/x0e9D9qamFAiJ6o43ecM/rNTvYeYpcSWMVZ6s2AdS9xpoawxSTgReY3Yqscl/ktk8zH2FWraal7y/nY+PmTFmziNzojPZ1QGghabXCcRdTNVkw8FwfS2cgDvPk6m7oIKn+GWZV+H0o=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 16:04:34 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::54d4:413b:e276:e71d]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::54d4:413b:e276:e71d%5]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 16:04:34 +0000
Message-ID: <354a0d93-4634-448e-bed6-eabe24ab02d1@oracle.com>
Date: Mon, 16 Mar 2026 16:04:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] KVM: SEV: Drop user-triggerable WARN clean up
 REG_REGION
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, liam.merwick@oracle.com
References: <20260313003302.3136111-1-seanjc@google.com>
From: Liam Merwick <liam.merwick@oracle.com>
Content-Language: en-GB
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|BLAPR10MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d213580-0333-4dfc-2708-08de8375b77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QBAGM1ArJIiDcTQvqHSOznr0ZI55NKubXBhGl6ORr3snBmIHEfHc3u8I9AEbO5slgj3ajjpTaqeupHhygPCDQkTXXgR6TPgdL33iwssSHuJKQSeY3qRWUa5MgeX/oVJwkslQ5c5GnNSPyRXF618LRiY2lj1FI2Yjc7PGXqwz8Fza1qVD441lF8iYmKaL7YQrZSjmeKk+lSv0yoczJ1S87V4yNoH5VAaNkmITdWCHPsA24vgzvfY6yqbRxf82FH9R1t8MRNFjudNtp0msGjMIVZ7MdwHrk2XD4OHLctvuYoaVG9dyJrmbQ1Rkwa9WU8MjT1aluwsKaldOI1g1wmr1rY1mp+Q2R6a/q6TrhzwIBBKphjc1Y5KMyMqDVp5wcBHoLCF79KrRnZiVXPE/hpbQeL9wtvK6isgapPPxGPUZKVnTn5TO3WMteIa3dsiMFQMMtUjqu6ckDxOnzA8RQO57DB3+qkHOrxXmaH9VAL0FIX1jYK1i5Vl4wdNoQnX2icDsGkFV8JJ37Ah3fxkzcilc4sP4HmoP8ipBpcLYraATm2MYIuRpxPIm6Owg2X8vGGQyHOfw+Q2SzgGgDGsZJRR5DxjvnXUBPVoyhYYg741Td1LZo5e6v1oTG6T9v9LZwm6iy/H3Gz01seIFY/d6fnavuCiPHeg8nyYWypxvBWEiNv4uK45ozptR3tEhYfBBN1on7d0iYJdOp2pO1roM/fE1Kbjdf+qe0TitympKAhRpjZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWFpV3BPWHhtRXVQZ0lCK3lWTFBPNGRONXlYNk9NQ3lhdXhtTytHNUhudHZI?=
 =?utf-8?B?eTY2R0JvV09IOUpyK1U1TVhqelRabHBMRzhReElzcDd4LzNzRG1xS3FzMGVO?=
 =?utf-8?B?QlBibmQreXJkSzFVdzlQSk9DaE5XN1lwNmhXYjFQNTlDOFlnZXU2NzNna3c2?=
 =?utf-8?B?aXB4bncxTEdJek5JcEJxdzRrVEI2bmxKcmpoZ1JoNmM2aDA0cmd6R2NjL2R2?=
 =?utf-8?B?MHVLZjJZalNvRWNzNWxraktXd3NSZnlLQnpGd1RjQWV1Y2drdkZUL0IyUWZY?=
 =?utf-8?B?QzJzM1gwMVYxVUQvb3lnbEExcm40Q3RaSFZGSGdFdHU5Lzk2SEhMKzZlbFRN?=
 =?utf-8?B?RWZTbEFxc2FILzVkU1Rwd2IwT2doZFhwVWdlUUlub2xpMXEzcGwxa21oOExT?=
 =?utf-8?B?L1dUbDMvZDY1ZitSc25Xa0Ixd1JjSU12Z3FNVEtNSUU0S0RidFdrS1lQNXRM?=
 =?utf-8?B?STdmaS80SmVMd2JoRmM4RksrS3BGYVNKTDcweVJWZDMvVDdTU0l4dUs1d04y?=
 =?utf-8?B?UGtEZTFscFI3ZzFlbTNpVnpsZGZ2TjJpOTBpb2ovUFBtS2N5eGdUVmZ5T0Ju?=
 =?utf-8?B?QmswY3BSTzZpeTRsbVlrQ2kvSmZYUDNJeXZla2JRRUZiREREdk95ZVlFRTdt?=
 =?utf-8?B?eGpIemdhSmhySVlXK1pXTUJwaEVHZTR6MUFKRC9HZS9jWTFxMDVNakhvbnlK?=
 =?utf-8?B?ZlFwMHZkY2E0VGV4V3N5a1dwbXFhNlg2LzFCWGtwdVB1ck9xVUI0WTRPZjhn?=
 =?utf-8?B?Wjc1OWcyVTFndjRQWkNJOU5POElTWDNqUERKb2dIODd2bFprZ3ZCWGhNUlQv?=
 =?utf-8?B?QlRVcjlRN0FEL0dvbW52V1lpajcya0p3b0lxMFRrTmhsb3c2WFprV3gveENU?=
 =?utf-8?B?dGZ4RXRDMEswckJRWktUbWx6aEMxTHFiQmIzZEMzM1hoaExydktEYlRUTEov?=
 =?utf-8?B?cHVHamd5MUNHK2hvTFNOaW1uTGlNQWkzU0ZvakVmYlNQeU85SGljYWdEOGdm?=
 =?utf-8?B?S3BIN1FMUFJqT0lHREh6ZlR4VVFMSk9DeUhJWG5WSDVoWDJXQmZhNW5ZdG9s?=
 =?utf-8?B?SFhQNHhBQytTQTdBTnVPU1gvV2czWjZzTVJESnFzZUpsMEZzdExWekJ4TnpE?=
 =?utf-8?B?SjB1N08vVm1lVWZhNUdiU29PZFZ1aTA0TGRPZitaanZHakh5R3VQNm1tM2hI?=
 =?utf-8?B?ZURNa2l5SFI3SEFGTEQ4K1AxWEtIa0lxMkpiRDlZZlNNZTVRR0o2SUUweVd4?=
 =?utf-8?B?R2pBRXhpRjVwcGJUdHpza1B4NXhHZkJaNjJrWDVqMVRMV1QrOE1tT2tSS1VS?=
 =?utf-8?B?NDFxT0NORDlyNG9mSU15ckhkZjNjTlloWlZpNkk2L0RDeW9CaGE4aDZaSWsx?=
 =?utf-8?B?VnJuR3gwY3hUQUlvWnVtN3BaK1NKTzlaWmJnYU05RVlXY3lkWUY0Nk5KTVJW?=
 =?utf-8?B?TjY5U1VvZ1lMcGJHWFJyQTNLT3RxMnhBYjBNdjJXU0NOVnhubVorYkc1UmxL?=
 =?utf-8?B?TlN1ck42OWRQOFRXRlViOUlnTHpGeUNpZVM4OXRqU2puOEU4RG84MDhhQldN?=
 =?utf-8?B?d2dtRThvRDBYY2RzTWE2MmpjTHJYOEpaOHdvQzZqOGpqejZ3TEpuUERxeUlm?=
 =?utf-8?B?ODdTVnBrOU1FclcyZEZwVWxnZkZDNlpQbFU0UzVzT3JycWsrQmFQSjA0LzNY?=
 =?utf-8?B?YklXTmVkVlNKeDRReDRWVnZsWVhnUTR0M1p1Qlh0T1dxM1lYdEZUVVNia3pC?=
 =?utf-8?B?TEQyOHJxVmIybnUzd3BpK1krdjFnd01UK1N5aWRyTFUvc0szbnRDVWZhdDd4?=
 =?utf-8?B?MzV5L0x6WlRaM0FIMXZVUU1iK3dNeXFEbXNQSDQvZzNTajlSVjg0c3luRWlV?=
 =?utf-8?B?d21qLytGTlVLU0pZSFJ6NVFFQXVxZXMyMVYzVjRPdEpLWCtYMkp4YmFSdEZs?=
 =?utf-8?B?elROenVkUnE3d2tnL3hMNnpHUnJTaU5YMW1qYzhxaHJza2JoWkxQWEpmcmM3?=
 =?utf-8?B?R3ZCS2h3Nkp2aEVJSXJCWW9hRW9oMXZEQytZMGlldHdOc0dqbzZueFNIbWho?=
 =?utf-8?B?bUNQR1JVaEZUNUxPT04xTlp5MWNmSEwyVFhmK3BWcG9mQzNGVnY4NlNwdy9L?=
 =?utf-8?B?amEzWkFsUkQxR0t0NjJSZjlUczViT2E5QUp6dHBxNmVKbFlyZ1l0YXZoRENT?=
 =?utf-8?B?NGNlbFFSUExGdHZEZDgvSEp0TlVoUzkvZU5aQU9oa3NIUkZjOTdFNmc3YjNL?=
 =?utf-8?B?QUF2YTZWUWtsMFh3V2JDKzZOMVZTRlVucFhKcjVLQVZ2eVhINGIwUVQzNElu?=
 =?utf-8?B?czRsdWZMdmxaU25ITDFXL2Z1VWl5aDRNcmZhc0VKdUN3aTNyRGVZdz09?=
X-Exchange-RoutingPolicyChecked:
	JEE424cbwfZ/XPeMVmLygTjInldwz+//UQBcZt+IshpVC5XrSrLyajCDCKASiS4VhG4T+oyMaEFJmvIiJ/4q5N8DFOxS0H1/Sg6LcSMKzMB4U4EOQ5LJiheVkRjCcqvih0aYlEBRSFacYXQlPtJsq0JMmDyVczUmm61sZRCOaD8kmIfErfwaXo/2REchlFf73Xdmdei11O/we5MQziJWfj94ICk8Bm6NoORdI1YfdMoMp3WuiW6ci9fzMQGlDx5/W9zf/BJGEz+Y+OUD1D+YnY6QKwBok/n6N63DN29JEg4I8fLIC5RPJPZs1m0OpWAxGBQKVJAimsVSJbMcu9aasw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6UL5AzBs0Fv5b5pRZzn3S+8mJO0Mw2iFekv4WZsVSkqVO3APa/sBwfoO8Hnumh2G8+Sw2S0DbOADFpBNddiXQeUyMQCVzKpFNCYBNgF7LjumdrlasjjrTEwF6HksBXwQuolzgn5KGmKdf2eq5vZGuX3efKockHMA7RDuUJ7N1FvLmA0s9u8Z1/d1yCjoy3ix1L/6/naQ6eblVPFfFjjBCe9FyXIGoon6OtW/FNtvSn2XJpmdKEzjeGTSbm+7WnoyJYgonQCj1po/jVR72q0BXJLxcsa+0Ilx51N2jKs4pSyaLccqJvgtyrmv+2My04Lew5Bo76TvI0YJ5C+wOar/mxs0dAg5yEyvXz9N5Z4v+LRgDzQtQ2P7EiYYgdeakWugLDXy4aNbkeNPaYCeVL61qylkKzdhdu46gQYcd9d1vdavSEKL2kBr3Bztzs2dbhsOfcjQRBXMSknth5FZYm1CGKxC3IvEhoHszPXGxVCrtYczfelg6KDkOYAqVhH7XOZJXXu9scUE6VJGInpDHbtuEUdatU9SP59wbn/oZ9V6pHcrTXeO1nyu3LnD85yhoQthdMMzqGe9u1XH9HkJjDU4ncqEFDm87LjSJ/TNFHY3UoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d213580-0333-4dfc-2708-08de8375b77f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:04:34.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QugwJuDJBKvMIOH+u0qQ6BznhlrOqlxlbI2VCZ59vuoM4AZ8bbSvXg8CJQo0C7CAgZKGKfZhuREJZefTDZvLaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=893 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160122
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69b82a16 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=w1GKyzBUIPFB9Jlp5sAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13824
X-Proofpoint-ORIG-GUID: bk75jhnDi0rn4KZF-uG0hbRUzcvoLkXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyMyBTYWx0ZWRfX2+1RqWkoSvKj
 /emEIeThsSUWGJCpZ6sO3RVTbNUTdXtd5X436CDV8iPprC3RQb0V1+c9D6rbUZM44OTr5Dq1RL8
 kLQMu40L/6n/Ing00/EaHQz3Hqp/gDlzGi+/SLoZtvyZbWr8tlAN0xUH5rZ+G0fDdWXuDQgRZcX
 e/RRMl35VrThmZ56YIFVvuryvdpLnlGYHHbq13wyDvVjghETtyGlYOypnwmhwnYm57w3obIvtk7
 hx3hx8mSAUpW8Wlr/TEG4lNrkekSdPeTTQ14QZJCBFmcRFNVIeAXLXFipNGO9WTJjGPnhkVTYTi
 Di546U4UVRKoO7vyUNF6XdkkIcz0cydQ7wrT4g0grbfFG1RhnQMHvxlf2BY2VjfF13zarWKpLB5
 osTf0wA35UVsLEFXfbZh1MG9HDZufNUVnmFFxX1ZDc/R0wu1JPvsDvrDHk8rqSpG4XNxqe42z3A
 cpE7svW10h6b29CqDuM0fX2H17PU6GEYV7v/dUTY=
X-Proofpoint-GUID: bk75jhnDi0rn4KZF-uG0hbRUzcvoLkXa



On 13/03/2026 00:32, Sean Christopherson wrote:
> Drop a WARN in sev_pin_memory() that is comically easy to trigger, and then
> clean up the code a bit.
> 
> *** WARNING ***
> 
> The last patch impacts KVM's ABI due to a size restriction that's applied to
> kvmalloc() but not vmalloc().  If my math is correct (definitely a big "if),
> it will only impact VMMs that attempt to do KVM_MEMORY_ENCRYPT_REG_REGION with
> a single region of ~1TiB+.
> 
> Liam, I Cc'd you specifically because it looks like Oracle supports SEV VMs
> with more than 1TiB of _total_ memory.  I assume that's spread across multiple
> memslots and thus multiple KVM_MEMORY_ENCRYPT_REG_REGION calls, but I wanted to
> double check before potentially breaking userspace.


I tested the series with various sized large memory SEV VMs and all
seemed good to me. For the series:

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>


> 
> Sean Christopherson (5):
>    KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
>    KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region()
>    KVM: SEV: Disallow pinning more pages than exist in the system
>    KVM: SEV: Use PFN_DOWN() to simplify "number of pages" math when
>      pinning memory
>    KVM: SEV: Use kvzalloc_objs() when pinning userpages
> 
>   arch/x86/kvm/svm/sev.c | 51 +++++++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 26 deletions(-)
> 
> 
> base-commit: bfd7f4adc1230373c25e1b787a6f1ee407eb0656

