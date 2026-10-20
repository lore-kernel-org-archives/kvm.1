Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792506066;
	b=tFmCJSfK1VgbIQ3WLBbPPSAY5hEaG7HgLgPaSdCCuHxLYxHUXPwvo88PGuPfsaHQaNit
	 +5ByS8tdkYUhP/bxkSzUdVY0x+o3by+I1PayIPlzDZyjUGzk3N+3VxJwno4zJGSPcJQfP
	 B2n40FLa3CzgPo5WMybkG+HMEjPdE+q2oL8M6ZgtP2I5WsGgjY5enuOvNDVG8GoNSbXAP
	 AgJcJvZ3UL1He+4rtlI18E/6baNzVNn4QaVSE9+ivPQcSVaWvB3YBy2s1cNhm26c+fZwB
	 GnV67wwHsX1CvzL0dr029z/H9p73tJ1xHMvqA756XxklwgE8puYV4PM+I9LPANXvHbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506066;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=x6ARILopmzH+/JgMa9xvtOXmlrQm/AfUB5O43VDYkZg=;
	b=qxuS81WihAS4xXFfl4OJ3IAkTVpcgUuv5caHEakIFN17GLQUn+fIiKnO84Vdq/8/fgBB
	 XXWDlvsKjWZbfPYXTlfH1m4+gcNtABKxFPI/XrJ7rWTpGKzJxetDZmA6lvi4UxRVVlME/
	 +cRCrF2zbKFZgtHZuJTqs3FAJc6i+NkpxQWAW+bY/RQUPZ0euo3q7WAm9e0fsV793zsV9
	 2uu6iWCVxym5DXLzz+fApTeVqZ6B/Nw0Msy3RegDpL0q5je4YPCjFync8qof0UVzTt9YZ
	 DwBoqMqBeRvn8TskasevwJE4ThYiOVS+pjmkde8BWutm/dCoZjRmpg6B4IcKjRkfJJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zd4MKYSk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603B606A329;
	Tue, 20 Oct 2026 14:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C603B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zd4MKYSk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYQrKzVFWzpW9bHCuoB4qcXs6mEG9YYjfViEAtSXHalCGt6g5B3uUbJAzW+2q0hJTJyuLmmgfxWEHCns5tUorfV3QwQ0wnGIEAQrOYeSMDu4Ul6biuGUJT22Okg+hGaKcKEhgEUJiwQ1CGL6c7KNknvTxgY+8yWH7GsyMMvDpX96WxHBbYsrA7+QrMIUJ0h7XBZABqg4Mv/kKKuCZTYWgHPGtazKRCrbdFmee/ZqDKa69luToY6V8jh5Iohi37yitEAOwgqj8lerkY3N8lHrbd3fUp6tC1bpCVmUMGrGLk+97FNDgzpOd3W1Mj207fl/UXqOeROCkCsIJqxcRwtCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6ARILopmzH+/JgMa9xvtOXmlrQm/AfUB5O43VDYkZg=;
 b=i2sTjATE4gxpvY5XB3qSWxGg/5uamLLF6glNHRvlRziW4BiOtYWZnQYvM5QGqClbwPejFWL26oMR+t7/Hy5wqEhFSEcpKLjQ6B8bePCpMSU9LfkJBseItD3WlPUaWUGIXnfgfqdPoMRXSZVMywMUyklL+HuoX+EXIQN8/SgvB8hPQLrVkBg76j3RjEbkwrhSy+gPS/FbRCVWqyyxQYWM7HZhjJbZwbkwvQk6cqWtNRmttr4jOBX6VYKOCfLA7R63GqWNqKdxeh4ovqaQcAAqYB6lNRgVopY37fYsyFeCDZ1HdBpkSKmTE1Sg/kZcHJbsuTre+7XQHjkXALELnSY/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6ARILopmzH+/JgMa9xvtOXmlrQm/AfUB5O43VDYkZg=;
 b=Zd4MKYSk4w2LfSU+qlHNJO7mC7oJXw278R5zp6d4m+n1pd85vo/FIQc5DU1doh/RcMF0rDg2543EAr0KjTnN2G7s+xZHG7O6Pk6RF+EMxtmNYZjNf2m2DXSlzeGu3bEh32iACtEsT1qVJdScvYcyE48I1xCsK/mHr4iBM0BVYvY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:20:58 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:20:58 +0000
Message-ID: <ff41c5c3-8cf2-4a8b-a80a-95f3503df8ba@amd.com>
Date: Tue, 20 Oct 2026 09:20:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/18] fs/resctrl: Introduce kernel mode states for
 resctrl
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, tony.luck@intel.com, bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <d98872b26051bfad280f72da3bcddea1e978b37c.1790867441.git.babu.moger@amd.com>
 <b2c67318-b52d-440d-bf40-fde40b47ae07@intel.com>
 <351da689-6f30-4f56-8f3b-ea62cc501d7e@amd.com>
 <a62cd7be-fb69-4d4d-8416-fc85f5b7a4a0@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <a62cd7be-fb69-4d4d-8416-fc85f5b7a4a0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:8:452::16) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bb6367-d00a-4021-463a-08df2eb55c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qFomFcNZb55a7tWJYx4zRGP8DQGER4um77mfEjITnjrEx0UrBkj/5FvSrlS6GUBbTqMVD9L2q8vkR4vHYKeIPbKGd2+xFsgBnTiKw0yfQXxFsbONR/JEmkI4dDEZDF4IrugVFUhj7EgFPzbHK9vrHJCHMzkSHj8Kca4GtCdQgYRdtnEqDQ3iVw0xRG7MYSaatUmSJUEM25FoA5xmWNY5Y6Hq+sfs0TS+fyZjiiwDCpz0+FiDf9RDWvC/nBXc8SAU1vO0NNNqmitqOjUwjAea4rh4w+hmmA0ac3lxOOfy1fV1otp7h4QeiluAezlVf1xPQeJ5NTRA8Y/ZYe/F1jG2qBMpngpS0uaHFkO5K1M2PB05ggxE/pf2TDbwgebL4USNfgHE8fEcND1EaHhlq9JFShThrChjfK/rSHYjbpGresP2i/hQyYjAwpgelVDRJYwv7c0Rh63bUDVs1ZsHYnqxzJVai8jGYrQkE2q3ZAWIJmeQoR+VO90ZzaU7QsnkKImav0tMWYbniiqfl5o4BsUkpmSC7s02Uy4b/6JV+79Nqa36vWbFgzEwKMSayoqO/vS+P3t0X6g8hXFXzsonrPC1xGo7dvG80+J7rEYFXfeui/dvcy1AyqVpwrpPJWQN/+xRphjE/wxR/mRYOwaPmXehRt4ALe3pTz96NvA5KRPBFEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWtFVy84OStOdHZFSWIrUjhRazlHYk9WckkrbHE1eGcvSkZOa1h1VmlpaWJz?=
 =?utf-8?B?cHhTT2hzbE0vVmFzbFBlN1JlTnNsKzRZTEF1SDVGWnNQM2Y0THlJczNRS0sr?=
 =?utf-8?B?SEhqWkI3Y3d5Szk2Wk4ybG8xR3BGUW5IVkxBVVFVNEhSWXB0NlBlOTk3alVr?=
 =?utf-8?B?cEM4Z0diTzdLcm5RblJrWlE2MFlyR0wvNzFyTjhHMWRIcTlFbDc2dUlEWVd6?=
 =?utf-8?B?YkRtVlR4aFd4bDRCczRwc0hUaXhTdW15bXFwUDhhMEVaallBNjZPYzZCb3hZ?=
 =?utf-8?B?YkFIb2syaVpsenQ2NkNMS1Q0UmRXbFk3MDk2cnJLc2JZelFnbDJMQURLakRm?=
 =?utf-8?B?VTQzVXVIREoyVUEybFUwYytuNmFlRHdQYnBPajdXa3lCUWpaRjZhd2hpMU1B?=
 =?utf-8?B?NmlPdGhjVThYT2gzZ1MwNU9ieGtEQ3FsbE82UVFOWVhDcnhnQ2U3QkRsU3d4?=
 =?utf-8?B?NnJrSm85Zm5tTWdENUl1bGYxRlgvZlhhS3JncS82NTdIdDM0L0xpcW1lS1A1?=
 =?utf-8?B?a1pObzRpelh2RGJBOXEraG5nbTh5Q3hERGNHNndMdUVHaXBhUE9LR0g5WjRF?=
 =?utf-8?B?a3lxUE1ZMkdqVWRLeEF1bFpTSGR4NzBUWlhjeHpZT0FIbEdYVEo3bHErYk5Y?=
 =?utf-8?B?RDRyZ29RNjRUbkhmeEdJSGIvcGN4Yk1acy9zb1plbjdpMzFrdmtvdnR2aUc5?=
 =?utf-8?B?R2szOFlFZ2o0bHluSnVrSEpYa1pjeVN3TU91dXNuVXM4d1g1N3g2dXRBQy9p?=
 =?utf-8?B?MVpVWmRnaVBZUjQ1cG1IbDRVaU1NeC9XU0FmQVJVMEVQYllwaXNwaks1aHU4?=
 =?utf-8?B?Z1JyZFdsN2VxVDkyblpOS0h0U0R6c0o2RFZBM3Vhd2dILzY1RTBxOGRLSmc0?=
 =?utf-8?B?cEQ5VzM2SmJFU1J0cnJxRjFaSEdFZGphZmp1d1M3dFR4cjFnaE4vdVU5RDNQ?=
 =?utf-8?B?UlVNU2hFWTJZVTVoUGJQK1I4T2ViQmZDOUpNQkhpSm82UVhWaXJZM0kxMDZl?=
 =?utf-8?B?aVNyKzUzZ3o1YUk3NCt2d0tPZ2RIeHoxM0RITi9uT0dTZUtDamRtSmhpUFgr?=
 =?utf-8?B?SFpwRnZVVnB0QytTV3c5ZGgvRnRDejFCaWNNVFhBNWY2MFFNTTd1aDVVUHdj?=
 =?utf-8?B?ZTFHRGZHU0Z4aUJJOERPNzkxdlMvdzc0MThjVEVPN2VGUU9iZTBvNndrYWtp?=
 =?utf-8?B?WlNvRWtaYjNoUythRkpmR0lXQmpyS2hCS2cxWlAvRWVrcDl5cW43N3hwWkVN?=
 =?utf-8?B?MzBEcWJLcGd3c28zdXZYN0dkVitzd0YwRGsvQVVrMklVd09TcGxOVXdacDBh?=
 =?utf-8?B?d29hRGRDY1hXb29GVVFOK3ZsZUhOdjBzY3MyUXlrOWQyNHJROEhuL0dxL0s4?=
 =?utf-8?B?Zkx6bFhIUXo2Z1JMQWRpK08zcUlKTUJuNHRaY2QxR3hzempoTTZ5R2lLRkRs?=
 =?utf-8?B?MnhWWFpmR005NHlYcUJsSkZWZTdIcWdYOWdoN2lEZHdlY0hhd2NVUE1HQmFZ?=
 =?utf-8?B?MHZBOWhELzZUQUxaNUV5WGZ2RmhXM3I0U1hCQVNuaTZUb0M1TkxCYko3dkdD?=
 =?utf-8?B?YUlIeWZUSWZDeEdQdWtoYkZJUTd4OUF1ZEVlRkNhUE91YzlLSTRLS29aSVkr?=
 =?utf-8?B?OWM0bGk2UWZnaDc3KzVGc1JMVnI0ZTBSaDdrSFFWcHpRUEozaWhXNTg2UkVr?=
 =?utf-8?B?Qkd2Q3RjNUxVdDk3RUpBakRkSDc1a3Npb21JWGhBdm9NNFlTc3lLVWR5VS9l?=
 =?utf-8?B?SFF0cmN3S0JxTFJxKzdwZmNSOHUwSk5tVDhWcXVZNThFb2tMSWJaazVZWnU5?=
 =?utf-8?B?aCtiMTdkODJLY3lDaEdhNHBNUVkySkJhZkg1Q1JnT013UGtCV0VHM3RCMTE1?=
 =?utf-8?B?N2E4c3VZaDVuVndMQ3dzUzN6bFVHbG84OXJhSU9uR3Z5U2lHTFhrL1dPMTF1?=
 =?utf-8?B?NmZxdVJLTEJMV1VjUFFCMG5tUzcrQ2xLd2RZbkNqYlZQeG1NUk5uVU9sc2JL?=
 =?utf-8?B?VFJCL3g4MkpyWEFnS1dYNDJoZU45dC9xS0JKM3ZLQmZuRkQrWjg2aDFiYk5P?=
 =?utf-8?B?S3ZSUFFOMlozTDY5RjBsaDlzMTZTemlqWU9EeG1HRllnR3p3NnYxK0tsTkVv?=
 =?utf-8?B?MFc4a1gzSkFFZlZNN2tkQXR5citWS3RncHRwUVlpS1J1azAyNWlhWVRlK1Yy?=
 =?utf-8?B?Rk8vV1p2dHdITjB6WjMyYkdZOVV5WGFtcytCNzZlbkZaa1IrL2JCZ3dVWWF2?=
 =?utf-8?B?QXBiQ0IvZXd4WVZ1ZDlCMlF5blRwdm94c0VTYVRwbUtyc3JaNlVwOGNhZDFM?=
 =?utf-8?Q?OLKTbnIEzKUzfa7GeP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bb6367-d00a-4021-463a-08df2eb55c5e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:20:58.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUWfSv8cdTUHOw7j9of0XCnn/sswoG9zXJPpr9q0jSqRNlzNd4VEyOnd564T44PC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A

Hi Reinette,

On 10/19/26 11:18, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/16/26 8:10 AM, Moger, Babu wrote:
>> On 10/15/2026 9:37 AM, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
> 
>>>> +/**
>>>> + * struct resctrl_kmode_cfg - Kernel mode configuration
>>>> + * @kmode_sup:    Bitmap of supported kernel modes.
>>>> + * @kmode_cur:    Currently selected kernel mode.
>>>
>>> Adding this comment during a second pass ... please consider later motivations
>>> about naming of these fields. This field is introduced as "kmode_cur" but when
>>> considering the language used in rest of series "active" seems more appropriate.
>>>
>>> @kmode_sup could also just be @supported (the "kmode" is redundant).
>>
>> Sure. Will change kmode_cur to "current".
> 
> Please do not use "current" as it is generally used to represent the
> current running task.
> 
> Why do you find "active" not appropriate? The text usually refers to it as
> the "active". Consider the resctrl.rst text that reads "When the mode is
> not active ...", changelogs refer to it as the "active" mode, user messages
> refer to it as the "active" mode, the functions are named
> rdtgroup_kmode_global_activate()/rdtgroup_kmode_global_deactivate().
> 

Yea. My bad. Sorry for the confusion.

@supported and @active looks good.

Thanks
Babu


