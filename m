Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4B371892;
	Mon, 16 Mar 2026 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705009; cv=fail; b=nygd230D5LQD8h76Jct5RyYP85cHig1YvkBN2OWnDreuPL/Zomru2wGhh0nCaDgs9eBaTIjMglM3b0SKM9V+Lp6SAlqKprFwkVUrfo18qSqr1nGuZeMXc1vxNC6E/uvCaj3b9ZIRoZjIzGbDEjwyn+yjq0B7xEdalD0LC2gg+1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705009; c=relaxed/simple;
	bh=kkQa1JeO1WR6LIuKyFeo5LPkg83qNOSae1xrhFmlRNU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sumfrhGYL19CFGww8/3zl5h6Omu1NWFyAW3RKWGQPD2NNuIpzSbZMKLQbeyKja+EOr20PVGNW3CFNnC3WBR0j0MquDU6SynybB0iMXLxtd1Z1b9HxfLAf91Uz9/261NiJ2p0twaRLulZbz78pDmcyWHUfFMUHR4GvlWHrCx+H94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=az7jKjzB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tOV4uXyK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="az7jKjzB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tOV4uXyK"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GLEeII1337612;
	Mon, 16 Mar 2026 23:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u2+rhx9amyBFLpPLeu7gchvuorkpCUTb+NANIuxsGRA=; b=
	az7jKjzBYTtsYTnSTAJKLmegsDxjsvLzyhA61b+EsGN9bp7t6cTbAoK2NHzH1aJd
	6hOuKUoOnRIQ5UTpEQmr1KeHtcOOJfHeTe7Km2okOUiWG6JuEeXs5yEzPUio4bR9
	lmgWAGdj3IaiNiUzwpYOHxaAoMHF1B8NLKSWna8UyfanUsKrZ7P8FyKDU/EA2Krs
	p7RbivPZjxSYkVwrAJ5B7A+TrpzG18LFojCyR5pQC91jZ8AQrJXYfdd41R814cIr
	huQZyn090iZwAGp9zKbz7rZyFM6uqhJjA5D933qHxMn6BLbm7/8Qfz64fGafQrg0
	s4jS2iIDLq8PpQAD/JCBEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9ru7jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:50:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GMsU74030672;
	Mon, 16 Mar 2026 23:50:04 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx499q1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpmfFGBUDpW7YlOpp32H3BCo6AYjyscVWYs7H0v9TsO8B5ucI2OfYa0VTgwDBF8SSQJgxSCCSLSR67fqYXRQyD3qPMtfFHVaMKR76kkRyghA9+ojAefhxAt7V/yShln/J3aOn717pFSeRXLmS7yuihrjDxxQF0hL/wp5v7JCXPKXhf1MeCtZK454SQXreiWGu48KZaluuyt7WuIgWlBprBZh1GrR+UzgHDva5bnG6lVjEqprIvsZDDMJO75wxeuXu4M9wNdoD20GuA83C3HBAaCuvWVM99mN+qsqf1Yyl62DJfU1xSYPN0yUwyvBgkkXvkLLxP7BFgq2xQJb43OEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2+rhx9amyBFLpPLeu7gchvuorkpCUTb+NANIuxsGRA=;
 b=bGn6dPeD/umvPr1cpPLGT0AofbITata05EA+svrC0PcE3FjBQlRndBnM9rOsqE7bIhiVsHBAJkT5jyVClpyEc2iPmw6zhDtZhxksWSkhV5die35R9QbGryVdJegzdTf8NYr2WTcaBfjZOtQWBbpFTIfVboomYi/j5HbOXtQU7PWmm2LeeAW7Lg5f8l4E4iKhBF8D3dV90le6j1OTaE5vacwLRW6D4Qs+rm5pWW13rs9Aet7yGqZjwKWsCpUM9qhMwV33wAmOq2x+Qf7JKiRp7PrhOgEmy6tmBhvBH80A7K7CCM1RFrBk+cQyqUaWEx1SMQnQDnzH3IO3GBmrUBvcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2+rhx9amyBFLpPLeu7gchvuorkpCUTb+NANIuxsGRA=;
 b=tOV4uXyK0+EBWPZ4/Qx7HuATgdqBeIp6PZiGSX4IWRcc6TwzA15t+qRj9ZX6z6Ok4WrYalWotE9jm9NWJ53LTomTiQOzgh7tWA/7HKFuL7khWszxJ/ZJFI45njw+DDqzigX4sB2FpN92iRyZpvNOpkRmeJ2YwhfkjUF1uHII1Ro=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 23:50:02 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9700.025; Mon, 16 Mar 2026
 23:50:01 +0000
Message-ID: <1f44d452-a55d-4e36-b07f-9264e078ea65@oracle.com>
Date: Mon, 16 Mar 2026 19:49:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] vfio: uapi: fix comment typo
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316185617.166414-1-joseph.salisbury@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <20260316185617.166414-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR18CA0032.namprd18.prod.outlook.com
 (2603:10b6:930:13::35) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: c73194da-09d1-41cd-e1ac-08de83b6bd5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/k5NbbmNA15Y6BD/mA/6q1K2vqCfWLVkW+JgCmBuYl6ATN+nw6TLudWsO29cEMQvf9RPezN5OCtWHmyES3+/h6lPk/i4hRHxDnoUwjhaxz3XyrHtTLiYliteIEsZyf5O+CXNc6wm8ajV7rmChElsttYUOKaQtN4gT4wcRMtPj9EdMzRLcisxjvg309ljAV96cz7g9Is+YGl+hyCG8c9+hG+mEJhUiYS3u1qL6aaAkjQ4orr+uo8M/DMoWcybkaliM0Cr3c/dFkR2TNXD8JT2PE5m1P8DQr6Jz2zrysXShUOna74LYYezJWiNNGv8RNg8LoYgH1QIravG2h4gRRk4BC7n/7BoCV6Fm1bIea0v14zsB15C20imZ8cxm8wMnOmkXMXHCmUbZ4xOKSoXg+dDt5FG9aAGWwhWwGgwRBNMxyO82Fo8y6+GrNHNjWhx+br8CE4BBWcOrpfc4AcNh70ABX9ti/WPA88dukY7vXkMC5UmKPYchjvoLmFurQ71lMfOIIdgX+cmnF7+cSgn7BxwnhUrdeNorts20/nZ/L/fDo/ez1mG6TRyYKeWnSKK9mTlUI0QHq/ypF6tNT3MMgcd/DsxqnHtYaWWkZby6qj/RFlRvLF6cHmiVryHH9b/Hc8nytah+78Ix8DShag4ymCRVns91d5V0yl7kqwlPclooIAoOF12rlmwYaqC7Hn0o7Pw4Hqf9kglvx7wEmd8K4ZyEAcoEFbrLrWz5Cw0xScUJHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVrMndNdkFJMjc3RWZVZFdNNm0wdU9rV3FsdlZXV0pzejY2M3N5dTUyakRn?=
 =?utf-8?B?dEF0ZXh6VWl2TDFSaUZ1NmsxQ2dxMzBsSDMva1o0YmtVbHNTTG5oY1BTT04w?=
 =?utf-8?B?MkkwVVZvN016Qkp0bThuRHFweUwzcFFRMVduQUJGMkdzVzhMMGdBTTZBTzB1?=
 =?utf-8?B?NUhlTzRlWmw0Slp1cXcrVWZLR2RiMjhBcHVpRmFvWDdDMktIZlljNUorc00r?=
 =?utf-8?B?WjhKZUxPRHdLZEpqNUg4alo5a2RySFo2dmpxcFk4K1JIOENlVVJFeVplL1Fu?=
 =?utf-8?B?dFF0SC9kNy9XSW5CU2t2TFVvU0lxMC9hNWVLR1Z5NXMrS3pBV3Z3SXhhVmZu?=
 =?utf-8?B?MFVDTUdUZzRhczFsMEw5SDNZQUd1ZzhOajA2bEU4b0poT24yVjBCK0w2dU9Q?=
 =?utf-8?B?T0lXUUV6VkkyTzlNQWFnQmJVN2N0Z1ovWEV6Q1VHVCtvOXBDbnIxOUJnMVpT?=
 =?utf-8?B?RzRsNGppTjRGSUpJN0VDVnlpemdTcU0raFN4L2NNeStJdWRwY1oyYUt0Y0Vp?=
 =?utf-8?B?eTN3cU1pdjB1cVM1eVJxUDhGTDErRkpzRTN5RTJkSldkZnFaN0JHc3BwSDJ2?=
 =?utf-8?B?ZEhsM2E0N2hhM0RyVW1YUUhyRWpPUEQxQk9GcFNzMWJoVTl6UVZnYzBVL1dR?=
 =?utf-8?B?V1p4cUZGTnNhQUZ2YkhHVmhnVWRmVHdxSjZWYmdQYThZcjNrOFBGM01BN051?=
 =?utf-8?B?RWdiVk5UYllKSVhpYVFJMVpyTFJHRjllNURJS3duNFNiWlhJaG02SjlVS0Jq?=
 =?utf-8?B?VnpCTDRkN3lMank3dW1MTzhzTFUyd2VzZVhEcHhFMkdwd284YmpJc1RkaDQ4?=
 =?utf-8?B?L1NhRHI4dWlQM2VRQ1gzTVpEcS9wdDEwT3ZmTFloK1BrQ01aN1dER3ZMU2Jm?=
 =?utf-8?B?aEpNWWxWd1lTSWEzd2YzZ0huWHdHdGdEcDBYWktuYVpibnNJemlJWkNJeEJJ?=
 =?utf-8?B?RUxDc1gvVnlUY1U3Z2JCUUp4eDNTY3lYcnNjeExQRjM2d2prQ2hjaWFvTmpK?=
 =?utf-8?B?MkJKWFJLVndPMDdnN3hmUzE1LzNUZHZjdkNuaGgvdlBGQzViem9ySVU2d1A1?=
 =?utf-8?B?WlQxdnhacE5sQVNCNER1b3pGcjk1RmxyRnF1dHdIWHFGYWl3TS8zVFl3N0FW?=
 =?utf-8?B?RElSQWhJb1dyOTNHdk1jUXJFeXArY0ZPNCsrTGZWWWJycnpzeEltbTR6Z25T?=
 =?utf-8?B?UVBCUE9WZVgxVzhlaUx1bUg3VDdzSkJRb0ZQclBJbFlDYkdwWWp5TEFXNDVJ?=
 =?utf-8?B?bFd5emhBeGIxbFdXY2dNVExRTGVkYzlSdmxxUWNQSE5uOVZReEdadGlJeWp0?=
 =?utf-8?B?b1NuNzEzSy8zT1MzeW0zVXE3UmJZMDB2N0JXVGIweVZwdzBSQ1N3ZUVneHY2?=
 =?utf-8?B?QnZUNWUxUlNMUzJFdmRuSnhJOTY0emk4SFZjSWlzZEpBL1RibDQyaW1ibXJn?=
 =?utf-8?B?bGNGcDBoRzhRamorcnlxdmltV1pOL0NGY1djZndLcndlNzZEWFpIU3h6N24z?=
 =?utf-8?B?RHowRm1ua3Jsc292WHBqTXZIZ0dTYnlZQVJsdXR0cWpXNDl1R29CNmd0UVUv?=
 =?utf-8?B?SWZqTEdHMTR1VlcvbDJoaC9iVDRKbWgxcTdROXUzM3g4MndHVU5ZUTA3THBi?=
 =?utf-8?B?UmM5d2dXMkdNaUZOSjZWdWQ0VjJxZjhaelBEOFVqVjJrWlBVanpmWFJnZERq?=
 =?utf-8?B?UHBSWUJxM0dQazhKWEt1VGtlY0ZndTZBQUdKdWplSDRDWkMzOGs0WW4zUUFV?=
 =?utf-8?B?LzV0SDdDczRucUpFVzIyQW9OVEJXY0w0U3NBOTkveUY2Z05qSXNNbmJSSE0z?=
 =?utf-8?B?R3I2RDZCTisxRHdVTjZtdGxwSjk0Y0JUejlYa3FMbFo1Z1JNa1ZzNlRkSGVq?=
 =?utf-8?B?TmlUZmh6QTEzVmdDck9OY2hZajlmNWs5N0FtNm0zcUswYjRKa1ZxL1lQTElX?=
 =?utf-8?B?aWdPWDVhSTQxVy9adG5nK3E4NVFnd3pjTmpUKzlGSUFPNVQ4WUlrdkpzMTJM?=
 =?utf-8?B?VWk1bTJ5RHM3WkorZ3RYZGpYRDJXMXBOQmxUREJpaUNZRXVjRHpXdWtucUVF?=
 =?utf-8?B?VTVGL1BiSU9SRExabE9iemhHL0hBOHZDUGJucC9pS3oxUlQxMnhWVTVsWlBX?=
 =?utf-8?B?dWllN3k5cU9uTlVIYThMZHdvOXZVNVEvdTNGSmRNZFRNZ2VnYU1jbklLUzdM?=
 =?utf-8?B?TGMrRDZ5MUphUmtCVlhCbjZsWUw2NnBoNFRWYlhMOVUvWTFVUW5acWFmWnV2?=
 =?utf-8?B?MC9mUmtrdEZXZVdETGdPRjIrV3RpR2VIN3dqbWZiT2tvUEhjNnVKSGkrYk44?=
 =?utf-8?B?bm5xSUx4U3RBeWdvSE9kN3ZUWWpXd0J4MiswbGZxSmc0bmwwR201NFVGREor?=
 =?utf-8?Q?/cO5R1kBg7gMGBak=3D?=
X-Exchange-RoutingPolicyChecked:
	Wh1wpc43iTkTBbX01Q+brhMHGs09sgqrJYdHNRJ295Aku/kRTvJ4W6RwNrZ+BoSI8C5uCeJQbTLv9eqnWc1WQnOdc6arIqKm6Y4jrOK136tT5/dRF9ZxMq8sXU6jvi5L7jKLFCNRkoay7eFQjh8kXIt2RCthL03zO6AUnreyHvbVH8P2/cgi9COvkUwxopH4MExfA6G+/gP5XJ0TF4vqetfEDEx3LFw2ftYhd1pHTpKpec6APCzB/8Q+kQbxq5RHU4VWQWv47QwX1JBQKKiTtzSup7SXCgmZLM9cRz9+afdOQFZ4WvwQGT8l/Rx2HUWxLWwxdntNgR04HLfYtvFEbQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6yzC+TIfQxU88zbnvlKvw3MPVVMPHsjdTlNCVgBs6bpemkMzyWAtWquQHfoWkrS8hdHi0XHHdulXBzLh57wwqOI/BoB5N0tkSlCzTtPpVvhGq1BolOt6TphkSqiYz2Q5SWSKBE0JWWm1ma+xli7azjR0+7VupT6eYzjgXQHXsIu4ZJeTKVdz6XpqByXHKGtYq5FvXqWdffnYH4/MGPUkstKYxA8Bt1j94z40c4d5icMMa3sG1xOLPgRZHWj9nr5LM84uAQkvtfnOFhWmqJnEJtRcWQKk1HYpM+rSs/yVFF/y+fhdU+p0P2iJZTyYbrD4ReB5tZ1ntHi4EKQozYIeeUAFdZitR0q1SZ2QdXiTL91aCQWG4BwyeJKT8NJ6cVYJZnl51tnmCKDLbBN7JGMRYlr91RLEt6jIwnXVA4AMLbvzy0R3q+OdpdnuK4nTytCv15I5PZrj7PW5wIW/rvwGhpmB8ozCfGWbFuUCs5OdSCpbXLwlPkhe9LkqrhnIgdpADlikZzJnOdIg6D2ELjqGejYF6dh4o5AoH2Rs+WWImcAnnrE6SdxKLVrsDH8XUEQr30fK83fUPB1tKSUOYjxTOBCbcb43xlypo2X79VOx6HI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73194da-09d1-41cd-e1ac-08de83b6bd5e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:50:01.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r/b4/FVvT8MYVokL3xXUAN8PJlocgaQIgasv5VbpeynNFWVWQRSXiwv/VmgyK4b6ZG4uww4Xbiw2Uw5IUn4mfMBoYLx7OZ9lRqxUt4UOmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160197
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b8972d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=4EuQdLICr3JgQ-1d--wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5NyBTYWx0ZWRfX0AG8n7P4Asvy
 67OMkyj1rDleA+sE57Wnhv/cAtdumXGWhM+ymrD/qgA4fquoXEd8lE4Zmiaj0pMKGHlTEUMg7mI
 8mgRK/FtzTr5H5c1jKpdw9fs5adcT1tKAQFN3sblsbszXUL26GkfOks1YPZhHt6xNiXjoQLbrN/
 tjLDoCCa3w4XNLUlVASb6sec1nvCyMTPVxtCfrb7Exoq53vt4tj5iwGmxmcvdV3CNw5GEexdPhw
 YQvWjusQ4JDvQJw3Kh06y7nt9QezePFWVsIlN6fbM8qrDWW4OHGLUotl6/5jkpnf4MhjIYr+Btp
 Uu2iDInc00QsoAyFSq3sMRqxM1T0PgP+72bB/o67iFSNPEWTrW0H4marxROw0I3NUdZ28Myiu1a
 MSp1/Elq4+Sk2/Q7DUPaI1aBHzIbCvedIHRbbGrIX3DEqQySEdgJ2fW/0SjB++nkjynBSs5KYJP
 BIF/Ug6RATCg9C9DmOA==
X-Proofpoint-GUID: OR5n3oIhiHWOPSOdwkBK8YV_TVeF1qlh
X-Proofpoint-ORIG-GUID: OR5n3oIhiHWOPSOdwkBK8YV_TVeF1qlh



On 3/16/26 2:56 PM, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (succes).
>
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
>
> Replace 'succes' with 'success' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
>
> Fixes: 607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>   include/uapi/linux/vfio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..63d56c1fbf6f 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -141,7 +141,7 @@ struct vfio_info_cap_header {
>    *
>    * Retrieve information about the group.  Fills in provided
>    * struct vfio_group_info.  Caller sets argsz.
> - * Return: 0 on succes, -errno on failure.
> + * Return: 0 on success, -errno on failure.
>    * Availability: Always
>    */
>   struct vfio_group_status {
I inadvertently added Fixes: and Cc: stable tags.  If possible, please 
remove them as they are not appropriate for fixes to misspellings in 
code comments.  If it's not possible to remove them, I can send a v2.
