Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430893D5247;
	Tue, 17 Mar 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755734; cv=fail; b=hdF0Ae4Fm/rlHii1rw5u6wVODUeFFxpJqOdbn3aWnQxOwesWolZpR9UGaipZ2BmQxfiW43JPKwK8lHnZpRtb6doi3ZDHBsupJ2mhEC3MJSjwYuC+ZVJuR1O7pp99IPPwcOhEdPDWu9f7Uuk6BQQrtIVZyoeKKP/D3Sf6nia8Vzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755734; c=relaxed/simple;
	bh=pyXNuoaHPn9qEGMStu1+W2wljwGXR1ujpxHwzDkS+oM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W25VWK/6XZcvzjigkENVLlMT9kIstuaDZ7jNp15YtVoceogf4g1GlcAbpFsdIXj311KlXTrbBus4AfQ+Jw1zQUi7mvsc7f6nOBWDb132VhBRJasfnuezAFz9HSTV82Bc30sbXO9DimFnGLFw6uTmjmMFPgkz8Cr/tCbVKWOJNKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rZNFcpX3; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rZNFcpX3"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 62HChoMS394359;
	Tue, 17 Mar 2026 06:55:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=0Pkgy7mtSNvSG++vHjvYdJH+pzyTdZOxMn3GiZPpL+w=; b=rZNFcpX3pb3C
	1DBeLrrk4rGE5WQn0ytZwOhHrIYBgRU8nerPaq5ARIX730gJv/vnp1p24vKAr5Ti
	s4lUMcAHNQV8KHVmFDF4mHP/vvBQwmf2lOBkgTOU815UZ7cMHh3UqKU/YaXUsBHr
	taxBRLN7oPjXbTS+nwGUuiSJlGy1sMYxwIx5FFW2adIphxaXEAbj2KUrqz1UEGVr
	kKke8fmN2CHuh3BxYBzc7/iHFL8qmWFI0yms5n6K9WkKPPy0gT8d3YmS2E6llIZG
	QGaR9Ab9S5tUChTjWgD9J4PJKQVegVo7l5JBdkBrX2PDnZUD05DkWF6PX2QzFL1i
	U5MocbsIWA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cy77crw83-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 06:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFngRDR97lVRpLrCaWgEqw2yY9VkvX/KCakrJl3OqwbMoUGTYvUp/GsMDX2vx3MUfNUBIKusPxHJg2r8crWfPKwa0mm2D3EtqNIOaTO6RKnK+iqG9C0meRKYfwWMCXMfMxkZGauKuiJ4BtSaChwSZYP1jGtRf2ICxUN9E/DtcUgktrLVLeGlOaJGzK6OXI1RbUREQK9Vqv1NNoopUYmw00hZ1hqxzb22iX+HIp8ADhIjW11IuPR1TbBBioBoFgQbxIuuAElDtnEqcmm+BHl/gMesPf2ULWKJTjNeIfCTZdvdrv1uqfY01yX7/Q7//uF5uGz7325vOoyeVOHtz11YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Pkgy7mtSNvSG++vHjvYdJH+pzyTdZOxMn3GiZPpL+w=;
 b=VRNlJ0m5U8Z03ETyHZJR8k0IYPncL1UirjEAkNyKx5bpdg/MhFRomuMjk47cqinGvhbAs7yrzFWjh11AyDyvB4z2bVnRjeayVzPg11yUpLzKpgizF8vkFt1FjI7bazZxiaWXt/CD6T0sq8vej4UbnKoZaty5J1fdWEC2LdeNAQRaK+gALhBFwPD27TQu8WQ6uTizh6BNnGIjd5co4Se6NhHcTRGEfsAxaAePOxwm1QC4kufpGcr7IW87VKV5LNq/GbL4XP3R1eoBskB1r3KQs1nigR/zf5QB6mcSBKwPtw/4NwhnMqM6KJTxeLcarCkjhKrBKIBEoHE+cq9k75uZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB7038.namprd15.prod.outlook.com (2603:10b6:510:38d::10)
 by SA1PR15MB5185.namprd15.prod.outlook.com (2603:10b6:806:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 13:55:22 +0000
Received: from PH0PR15MB7038.namprd15.prod.outlook.com
 ([fe80::617b:b77c:494d:de19]) by PH0PR15MB7038.namprd15.prod.outlook.com
 ([fe80::617b:b77c:494d:de19%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 13:55:21 +0000
Message-ID: <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
Date: Tue, 17 Mar 2026 13:55:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
To: Ted Logan <tedlogan@fb.com>, David Matlack <dmatlack@google.com>,
        Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
Content-Language: en-GB
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To PH0PR15MB7038.namprd15.prod.outlook.com
 (2603:10b6:510:38d::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR15MB7038:EE_|SA1PR15MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: e9573108-5371-4766-9129-08de842cd495
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y8gWKdM4N//rIm8SsNuXEyY4zNH1pciU+ibhjvE42dMuXpKRET+HuZCnzK/k+n+CRLrKywHuLDw1AqCc6YpYkQm/2ELws7vAl5mSDHqi4RHGCu2nJfOgoVy7saFkhDivKauI/Nf/LKhwvlkhjXo4DaAPcNkADjc8V0MwWchS8n2EMgd015i6qfG6p2ApCIwk/+J7Y9dNyuTSEYpNgPxMWU+qF1NmqYksiskk8xF0+l4rKl2QlpW1AkX16Bhem/y1kgm1otf9krQ7P2JmtNnOHrpCSnq3GK5XQj3VAxxsXvqBUsRxokd6YQbgk6wlwpymYbiLyjhT2UfD+jrAaZwraVLGONvXsuH5PXN//VqJ/SfJxtAW0hwPQlhNw9JZV2TkXArB9yw2evn0rinCej9mPn7Y+t7pHddngjq/OoIftwesTyfS/HBK2I5cynW3eSv5oTsT6D+7ojMjD+K3ngLYrXefcBNPgRDUfUnlekgLzT3Oi+Bvonl1UBXT45Vd2Ff59VSN/oWydHD7I8vBUhfHAqJa2+g5xAgQPzcj34IJWKRbmD42RrfJKzlDuGuI28WN51Dx3VChkrdw9CVbXTZG2Sn6+7qvL9y/m+R+Nl14uyVs3qhweObmcSJHr5zYTgW4hF/iJLIXPxvZrHBVbdeapA0EHDSWMccnBLThZuyHKocSiVTqZ291c8fizvAN297kHrEq/d8DMLIA26M7Mz+1Da0HElWvPBHeB/qaeoTPW88xC6rXcPIUXug4t/2p+IRz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB7038.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhySVdINlR2V3YyZlhRSU5zaUMyQi85blYvTjBQaEI2d3hDZnhaZGhGRXVQ?=
 =?utf-8?B?NmtESmlDd05vY3JSRTRyZXg5NXFHUHRocGxtMFpSYXoxb3grMXVBWW55ZXpo?=
 =?utf-8?B?UjJ1RUk2ZzVDclpWWWI1T0F6enMvYmhkUUZROVFjYWpZNDh2b1V1TEdkSVdG?=
 =?utf-8?B?bElpR2JpOWR5cTcvUFVUNUNJbjh3TTBpY0tZYmZBUUQ0citMOTVKTUxZVk5o?=
 =?utf-8?B?dmNHUFJLUnZ3NENkKzM3NG9KcU5lRmhCTTJZQkRid2taQU9ybTE5MklCc0xQ?=
 =?utf-8?B?MU9PYjhIMTFFN2ptclYwMHg2Z1k5MnJDVG5PMGphTkMxS05PNzNYaUcrQWVX?=
 =?utf-8?B?ZnlkYmQ3QU9JL2RZZVI2TE9BMm5YYTdCeDBscVVIZDBxTmQ0VkRKNmkvaHFY?=
 =?utf-8?B?RnlTN3ZwZnprUTlzY0c1NXNtSnpYTXNSNm9EM05hR0VCVUVtOHl5K1RJU3dP?=
 =?utf-8?B?L1kxVDRXei9MT1lrMnRKd1o0TTJYMFZkS1ljVEdLREF0OGxYM3RNbXpPdmg4?=
 =?utf-8?B?RS8wbGdObE9QWnY2VVNFSlREb0hjczBRb3VZdWVHeldhaDRDcWF3VWVuMjZp?=
 =?utf-8?B?TGJCdzNuVFFGK1JabTc5RnNYWkQyZGtvaG9ZWTNsb0hMOFpJWW12OXpFc2pj?=
 =?utf-8?B?MWxrSTFkMDNVclNWenI5RmsyYXA2ZTU5Q3BWaEJXYzYvZWY2V21oVjNZWlZj?=
 =?utf-8?B?VFRkOTJtUkE4Z0RqcTRiNzNWSFJmcGoyT3hLUFBHNFl3TURkOWRCWmlXUDhh?=
 =?utf-8?B?OHVEbjVhQjhZbGdPWEpvTDIxL0FScVg5TWZkeExRRUMrcGgvY1N2UDlUQkR5?=
 =?utf-8?B?enNFbXhmNlBvSDBWam9yaFU4TSs1RTNCVmpRTEZQSmVkNStZQWRIbGlRajJZ?=
 =?utf-8?B?dTdJYW92QmN0K0E1M3hhK0FOZHhQOXp5b1dWTTVUK0JYY3JLSGtyRE9xYmk2?=
 =?utf-8?B?Vk9HTk10RjBhRXc5MGZ4dHYrc0E2UWFRK1A5alJlQ3RTQmNjcDBCQ08wT1JT?=
 =?utf-8?B?RDlmMU83OGxLRVViZDlNaXlWa1djSXEvdG5VWUpqeVhzNHRhMTlaTFp1ZlF1?=
 =?utf-8?B?ZFJKNVc3T2hnM2VNeTVLL252cjFwRzE3M29KaFZ5dlVLaXJ1RDIvSEFjdy9a?=
 =?utf-8?B?Q2ZYNEVXOXBzUHY1b3A5MTNrd2c1YmpOazNsQUhXV2JsNWFvQXdyNFNKbTdG?=
 =?utf-8?B?cTBVbmROdXptV3k1eitwd3B5eFR2Z2czNUNxeWJhWGc5VU16aDRjQURyc3VU?=
 =?utf-8?B?MzR5Zyt0Rm1jYTRsM0JZbThBSWJXWGVjMDMyMVUxZEozdUIxQ3MrdnlxLzVu?=
 =?utf-8?B?UXNObVNGKzJmeUFNOXZNbkU2SEFVUlBQQWRJaER2Q2krYzNmNitxSE1ndE82?=
 =?utf-8?B?cDAvWDFMU3lpb2FpMXhOREs2VFpsQUlyRDZIRTVWQWpCWGQxUGJsOGRmZmE3?=
 =?utf-8?B?YVRiNUEzZXorYktscmNqUTdLOFRHY1pDM2xiamFjczFKT05sbUx6WnRtQXZa?=
 =?utf-8?B?YVIvMjAvRFJuZ3JEdlBZbnQ3bFB4R3Uvek1uVGxHYytEQWlOT3BEQjU3bXkz?=
 =?utf-8?B?MGJNRFljSGpPQ0FFYlJWOGZvUVpQV3VZVGxEck5RNEVtdFZMQStYbEpkck9W?=
 =?utf-8?B?dUZObGVJSWlIaE5vTUhqK09DVC9kMmY0QThhNllqc3RpOEVrQWtRRm9jUkRv?=
 =?utf-8?B?NHJIbXRSd0czeEMzSTJVRDRoSHMzOWpkQ09JeDRQNkRrWFc2S2JJK3RSek9x?=
 =?utf-8?B?bGRSeXdwSWp4d3FOY3ZHY2s0TG15cTNkYnpreVUwbzZnb3owdHVnYk1ONlNp?=
 =?utf-8?B?eXJLNmxxQlZJTW5zcysrZXUrb2RJN3RxY054RkJPTVIrZHBOc3cvK3NGYmFy?=
 =?utf-8?B?eTdVMDBPcVViYUdpVUN0YkExVzJIVWt5eDQzL0w0SVJBRnM1Vk5ZYjNXVUcv?=
 =?utf-8?B?aTJnZjJnQjNMa2FLdGZwMFVXWUdiVjZJZ1VFOU91Q1dLZzFtRG9mdHJhUFA3?=
 =?utf-8?B?ZGh1eXdabXY5OGJ0REo0RWJRTXY2RmZzQXBXUTUyb3hZWWpnYTVjUnprR21n?=
 =?utf-8?B?YTVKZll6b3FuRlFVRmVRam1rMEI4Sy9NMkhDL2EvNnJPT3l5dXpjcml0dVhB?=
 =?utf-8?B?elUxclZJNllveUJGNGhXaEM2cXpSWGx2V1djb0E0RTJFU0JuUnhwTUFVbjZm?=
 =?utf-8?B?c08rRE90KzM2Qlh0ZCtqSzc5ZWdvNndaZ0ZENElVM3F0em5xWTR3R3pkdG15?=
 =?utf-8?B?R1k5Ym91MGNtNlJyRzRhSnBKK0Y1dnVoaXN5OTMwSElHM25MbEdrNjlYdFZO?=
 =?utf-8?Q?84i4kpq87Q6eCu3zqY?=
X-Exchange-RoutingPolicyChecked:
	pMpeGBQKdnCCta3v2Fc7AYBnTUyxM+8NjbiAF14KKzCI4uhCQ0ErLBg9bFEhEiqXGZT33hHGWmbHu6NQVSo6eflSzK8lmKTKFT0FDwcRsCC+p4m6wXxB7E4EVq8/fGvkZu93UwYwZ+QAlGD5t73WAs5GRvk3dg0ovPehomkjPlVYxJhB7uiz1qTRu9ugpLmQSwGJ233sIYPAJl0Ki1U34vU4jXQbsiMVNnXpOJXsk2unb9ib00CHnO+jvwyBvaUMOjmUEB/F1NCgHp+IA9okPkNuVtbOlHJbnes8mRGjfBPEi0DDGISPAEj/mEbI7nLYWxcYqOn3TnFjtp7Q5t1l8A==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9573108-5371-4766-9129-08de842cd495
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB7038.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:55:21.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCHoS2fNTA3LROokJVSYX8P0ryEEsylASDvdUY00ENFl8GQIuMupH/n4wY3VOAgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5185
X-Authority-Analysis: v=2.4 cv=evvSD4pX c=1 sm=1 tr=0 ts=69b95d4c cx=c_pps
 a=ERW18fiFji9WgYXv9zI75g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=FOH2dFAWAAAA:8 a=FFIxxfwi2EMO3RiUjG0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2X5ynyk3OB5WsWyGvUYknrbJL__InB_b
X-Proofpoint-ORIG-GUID: 2X5ynyk3OB5WsWyGvUYknrbJL__InB_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMyBTYWx0ZWRfX2dnyJZC/ym3M
 EVDIQS9vHk28PblwM4sLfferZmhffoeoRys3PTpT/6SY+LX/XOLUkpAiKsdZd5imL5sNV+J11QG
 Tia5IrPCdn7DpzITN33Yh3NWHXZ1t9dnqP5Ad8Y2I+qdTLyO1PslO5MHWoxFHbRJHbzbjrjSb/A
 vOzKMSKBzahdkSlYxlFqS8Y2mpfPkM0NAzjh5lbaxtyVw44q7QpfV85C+47YOpHeqxaN2REPFe2
 9FZkVIxvcYetf7Itlkve9UIDInULHGTkcMmRvwNGOZmV5aqgSH+jcVdDYiTu9fCUeyfEQ2Lmbur
 BLsOW+aTWheM/SFRuS0FhraViu3YJk8Hafq0eZU+svYwPSUP12NFLxH6ZoL/fgEGpUF1AX7+Jj9
 KrwcWzjt7AobQAB1BppaelFdRAmzFny/bUNkF0wo6FbnBhgFVlSn90BMU8I9Sgt6ErtD7xZ8xc+
 7k0SCzMwJEBGY8Svrdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01

Hi Ted,

On 03/02/2026 01:23, Ted Logan wrote:
> Only build vfio self-tests on arm64 and x86_64; these are the only
> architectures where the vfio self-tests are run. Addresses compiler
> warnings for format and conversions on i386.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601211830.aBEjmEFD-lkp@intel.com/
> Signed-off-by: Ted Logan <tedlogan@fb.com>
> ---
> Do not build vfio self-tests for 32-bit architectures, where they're
> untested and unmaintained. Only build these tests for arm64 and x86_64,
> where they're regularly tested.
> 
> Compiler warning fixed by patch:
> 
>    In file included from tools/testing/selftests/vfio/lib/include/libvfio.h:6:
>    tools/testing/selftests/vfio/lib/include/libvfio/iommu.h:49:2: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
>       49 |         VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:32:37: note: expanded from macro 'VFIO_ASSERT_EQ'
>       32 | #define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:27:22: note: expanded from macro 'VFIO_ASSERT_OP'
>       26 |         fprintf(stderr, "  Observed: %#lx %s %#lx\n",                           \
>          |                                              ~~~~
>       27 |                         (u64)__lhs, #_op, (u64)__rhs);                          \
>          |                                           ^~~~~~~~~~
> ---
> Changes in v2:
> - Add white space around arch checks
> - Clean up uname command
> - Link to v1: https://lore.kernel.org/r/20260130-vfio-selftest-only-64bit-v1-1-d89ac0944c01@fb.com
> ---
>  tools/testing/selftests/vfio/Makefile | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index ead27892ab65..8e90e409e91d 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,3 +1,10 @@
> +ARCH ?= $(shell uname -m)
> +
> +ifeq (,$(filter $(ARCH),arm64 x86_64))

This fails to build (i.e. elides the build) on my local arm64 machine,
because uname -m returns 'aarch64', not 'arm64'.

Are you seeing an arm64 (Linux! [1]) machine where uname -m is 'arm64'...?

This patch needs some translation, of the sort in
 tools/testing/selftests/mm/Makefile:15


-Matt

[1] Note on macOS/M-Mac, uname -m is indeed 'arm64', but not so on Linux.

> +# Do nothing on unsupported architectures
> +include ../lib.mk
> +else
> +
>  CFLAGS = $(KHDR_INCLUDES)
>  TEST_GEN_PROGS += vfio_dma_mapping_test
>  TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
> @@ -28,3 +35,5 @@ TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
>  -include $(TEST_DEP_FILES)
>  
>  EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
> +
> +endif
> 
> ---
> base-commit: c3cbc276c2a33b04fc78a86cdb2ddce094cb3614
> change-id: 20260130-vfio-selftest-only-64bit-422518bdeba7
> 
> Best regards,

