Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADCD3CD8CD
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670872; cv=fail; b=IoQPA1wlA6JWZAskIVBWLoEf0N05/uZWGR0To+J8jApsOdc1/JSMz+zZnXScyEieUJftvct6szojf9vl9Uj0f4KRJafH+/RJazgo3BA0nZx6uRQHY4nDJLf0nnShl+Xlty27SAEOxWaSi9Q6nBqsoy/MhQF4p+2fd4lMOyDemNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670872; c=relaxed/simple;
	bh=lQfcI55bZxO80ff+SIZdW59ZeekkGbpZz+ZJsQUZLoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTSSCig8m9QXERST9QMycFFfXOU2KM3u7TeA09Tl8tVvY7RRNPTwt9vrXnuas9uZRReT6Dv6qrr4PXxV4piyvKfVleT0Wo2s0VnXW4asCUvRGfKAok4m1HcTpOYkFcnj3yJ5w+2hX6zcSD+CGLNT1lyG2G9dR+Lj3sY5ZPjY6ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EiPAg13U; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EiPAg13U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBdO7zrNIM6J5zGuBGLCsX5dAC7/khgphiEceLV44t+Avl4chOmyHmSictxlFNC+B9PyYyBdQfNMNpi8xfjDBqwPBl1tk3UjGMRQFucyrQdzbX1+zvq+hH9YrXCdEDMyoHlKFHfnKkG4zs8BgvOtDxDxH7U8XgRyPWNA+SCKkKl51RFdklXx2bhmYRV5TMHs2alelMy5YaQJabaxUcOD7Zqx+8uqFXzzI8uZXrOxqaCvGItlklqFOd40oaSywZ9pYoLQCJBUxZ0lttUnSsnF6xKV3Oe6luqX7N5NKz+YnN+UTXDRw1L0G1kfCdzFeUxfc81f3cQ+gJ2nvpzgBbvEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zh/hE3krLtQIqnhq158l+jFx++fVpceTKYC56DaCxQ=;
 b=YdNE8/iV5lQ1/D2BiXbbp/ZVXIFx5ffI5cfKW+Nnp0dL3VbDALc4MEY8GdtbSELX89HYbExf9juy1WjZVnzB4hCWDZw0CzHME+gOBN0QaIQyHELdASNs5GpgO0QwNeN1mj2jDsV/gP73W9XYba4Vsvuebnxm2eit0HTB9WpzytsHL3L0WC99YUfmm0vnmYaCt7+2sY2Ks42n90KlT78B1XnyWcRysutLS5jp//StN6hFoFN77KMo1J5jvhy9BIMZc66Qw3NI2epwfthWxtP5iEltswf2l9oBDnyiNhJwbZm+6352cLl1/rIO786LzD7GBY1uN+QX9v6ZiqvJzpfXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Zh/hE3krLtQIqnhq158l+jFx++fVpceTKYC56DaCxQ=;
 b=EiPAg13U/PlxL+JRXDPhxoOU5djTR9RzY/cZuuU2ooxPi5jJZRGzh004JPB1EYtYjSU8zNjb2Put/qy0Lkr/gpJEe91hfqzMqis2skvA/AVP2fD9Dmtp/LJZnXbHhC7ISUGrul/JpFcLexa+RUaDkJdvN5Jg3clqTdM7GHT7iD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 14:47:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:47:47 +0000
Message-ID: <a42547a0-f4c9-47bb-b151-315069b8d855@amd.com>
Date: Fri, 5 Jun 2026 20:17:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] target/i386: Don't save/restore
 PERF_GLOBAL_OVF_CTRL MSRs
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang
 <dongli.zhang@oracle.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
 <20260604025546.19378-2-zide.chen@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260604025546.19378-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 06454d6f-8a4e-488f-1f5c-08dec31168a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1MSwJm0J8OfrXy76o2xvFLn5h0CH7yeVlxhFvgHGYtaXS8dYy1A22oSKfeI6BTtOi1E8TCCfDQAy2fMiWON6D0ZULlBNtnobkcNtm2Qb4cyjealaZ/BD+/jW5WfF84Ar7ZQiI1esrjHDYX/Fm7xTFaX5kfFcRtZ5ElqL14UA/SuGp/hCjND/VibybyNNsMb1XtIcB4t5Kd+7KRntzrEAB7tG1h7i+vl0z/7wWQqcXwfYMbEsTFKeq2zaR1jySI57PUCUW+WD2bEq3DPb3oK4xvx3nz2actWHTuilp1+F8ZdNajB0TQuPIkB//jOvp/AP7zpxy58sZ9wuLCicCg5GKlyNStlKAccL/pyFdp6s+Zp3pp3QuF5qo2AwMCLH9loeNMOsOU7kuvxlocCB+g0ADYaTOVsGxGCyLEslPSM+9G3D2u7ZZR5H7U0NoiYypMkSAQrIyNJjEjYT3s/fYMv7LHMq/CVx03a/7IQjqx2Ba1vD7PHuCOHMu0vlkugjU4L3tOlcVonKKTnD/RkyTqdknSZvYGKsDyFPx663/ZTh/riDpSb8IFhXSqv1LjCbpYMPSE6xoChLbaBLOiWeZhjgpcZXLUO3yfznAg/Ogu1QCbrqP3skca31IHessWPqrxSry0J3s72sLkgUEnncoCPpVyGb40nt5vtCyERnMzptBciIug4vT/EX5kaasZA+bhC9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThQa2xRc0podDVFZVJmdThDOGw5NUV3ajlvNkRjNjN0UHE2OG5JSExoR1cx?=
 =?utf-8?B?eWJDYlVDNXlIOWEzR1dRL1dmU3V4NnRmMlEvclpOYXBFbkZnSXBuaC95RnJO?=
 =?utf-8?B?bjAyb3VicjZSeHNUNG82eDA2ZS94ZkhxVEFkcWxXeUNWY0EzUE1vSEFuZGVj?=
 =?utf-8?B?SU56WWF6RWhBMUEvTWlMenZBVWtNazI4dk94MVdWSXVZRWIrSlErTjdBb2V4?=
 =?utf-8?B?Vkp0REwreFpjRGFPUW5PNk8wKytoUVRIa2NOb25IZ1BPb0diNjR0QlZMTmtY?=
 =?utf-8?B?S3l4NTgxajBoYUhWZkJ4cURMOE1wVGpDdFpTeFdXaW4rTmZDTEE3NjJFeFRM?=
 =?utf-8?B?VnpTZXd3VzIzc3NFK3pvYkZIVUJHQk83OGNZRzVja28zaHVqMEZrL2QvamVX?=
 =?utf-8?B?aktYQ0p5bEZOWnZsZnVjaE9oa2V1VngycHBFNXEyVEM4cHJDSXNOdWlBakxo?=
 =?utf-8?B?TjVFekpxeWFHdkZydFYwK2hDQTh3YjJPMjZxY2ZUMlNiTG10Mmd4UlNKMUl0?=
 =?utf-8?B?OEpJZTFOaEVzMVN6SmMzRDZzYmQ2NEJIQ0JFMkdnSUZYeHB6NUxyOFBld3k2?=
 =?utf-8?B?bVlWdlpDZEMzZHd2d2VTd1hvaWNHTnkwaTMwL2NQbGg0YlF6S3VvOFNKbG5J?=
 =?utf-8?B?QjVhcVJkenVJVjQxd2JMMFlaNmdQZDZsYlpZbFYrZ0pETDYzZlZoNitTT0NY?=
 =?utf-8?B?TUxFdHhuWWxHRC9uQVFLdFJuNzBPRHFMRG9wTU1LNUk4WlVScGRtK25WS2dN?=
 =?utf-8?B?NnIrUnJwMmpuS3JOd0RHRkZaakhDR21xYVRhckhNSEprQ1dXQVFZN0R0SGhr?=
 =?utf-8?B?S3Y5RnE2bG1KZHAydHA4NEozMzNHRjdsY3JoSXgwWEN6YnZZU05VNytCc0Jz?=
 =?utf-8?B?aWpzNFNFVG1iYXc4RnkxRFY1YVZGM0JodmJoZTlUSVh1ZGUzK1QxWE91cVVC?=
 =?utf-8?B?cWNWQWc3TTkvS0hoQU1za09KMzJ4NEZvQmxPT0Q3VEIzZlg1RGVqNytUckhP?=
 =?utf-8?B?d3o3bFJZUk95UWpzT1Rrd0FKODlZMkdqTlFMaFlHbUlZaDlXN1p3Y1h3VnY0?=
 =?utf-8?B?M0ZWS1Z1VDV1UUw4dDJXNTYzYXo1Sytac0hHZ3lSZFBMMWJ6Lzh1bGwwSzdB?=
 =?utf-8?B?RXJQaEhxNDExaU01MkZSd2hZRGE0T2R0WnNZbFY1dW1GUWxDQkNWZlZaQmc2?=
 =?utf-8?B?S2ZpS0hPTXluQUJNQlJ1aElCeEU4dEpkaDV1ejNUSnMzVjdSS1BJeHhUTCty?=
 =?utf-8?B?Q2QvZGhPVkZhS0ZBSHBCT1dkREZRenZvZTBqUGN0MGtmcnc1bGRxcURjSksx?=
 =?utf-8?B?L0VhS1BzNVdxcWZidlAvZlZwcjI2b2lNdmhYazJUamY5TmIrY1ZiT0J2NFhj?=
 =?utf-8?B?QitTNU03TmF1R2lmZmxMWCtpbW1OQi9lT1dEaFZESDk0S3lCd2JnWjZvOVpH?=
 =?utf-8?B?TVUrRDVGOUR1dU85ZWNrbWdOam15ZTJnQ1IyNndLbGtjYWFjY0NSQ2VSNllL?=
 =?utf-8?B?bW52S3lPYzRFQ2xlVkQyN1MvWURWQkhMOUppc3graGU4K2hOdDA3aW4wTWtI?=
 =?utf-8?B?UGFhbCtEQWEzcGI1R3JwRHZ0ZjBOZ1BqWC9ZQ1FIcWYwR2Q4cDZhdldzdzFO?=
 =?utf-8?B?VVNRS21aR3JmZWhLVUF0MzkzU0h1SmEvcktrb3cxMWZSVmJaV3hEZW1sYzJl?=
 =?utf-8?B?VTAxZi9sSHBqd2xBaldZS0FhaGNIc2pCUG5jTVY3UzcvcmdvSTdRclJXSFZF?=
 =?utf-8?B?VklrZDJQdUh2cTA2NlZlc0hiTkVtN2Zjb3E2SjF0SEs4U0JDVTZYV095RlZ1?=
 =?utf-8?B?SHhpR1NVVThuSTY3bE1jVEx3d2pIYVpuNjFJLzBZdFpTWC9HbmZIeDg2NytG?=
 =?utf-8?B?ekRZeFZDS2J4d29iK2dhY3lsZ0lmZjE2dnhSaDdkRWtPSW1iaUNGWi9NNzN6?=
 =?utf-8?B?YTlYU1B2QUZ0T0IvME91dWJmd3pHaHlCWjdFdldLbDRlT3g4VUZCSlo5TVlG?=
 =?utf-8?B?TVNucUJEd3VNcktRKzYvZzMzNW5rb25jeFRiVDV0OThCVnR4ZGEyT01ONkp4?=
 =?utf-8?B?bEtVeStJL0ZRZ0ZieDk1Q04rSHJCY2hEUngyOEZZKzZYMm5rWkx5QWVSL0Ew?=
 =?utf-8?B?VVgwdjVjL3lYbjVyNHlCVGdoVDFUVWJnMDM4UHlXb2pVSjR0emNjcDZOcm1E?=
 =?utf-8?B?eTlmZUhFNWpmV2gxbjBWNCtDUjg0dWk1MnVOQThkRjlkRlYxUzlJVXhxU2N6?=
 =?utf-8?B?U1FiOFNSU2lWVU5iUDFpT3VsR2toc2t6ckk1dG9CbWtSMVVBVVd3NjRycm1N?=
 =?utf-8?B?K21mMFZvc09zdnZoZ0VxRXNreGxXTFNQY2lnMTk2RFIxRFNxWjNLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06454d6f-8a4e-488f-1f5c-08dec31168a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:47:47.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFqO+c9zteG9bxuag6lhGMCY0zd7DBcF51yjlMQ7u01RnEjSo7EjLqcQPyG8PUL8W3kPNwMYog4BNcVj0EYYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441

On 04-06-2026 08:25, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
> are write-only MSRs and reads always return zero.
> 
> Saving and restoring these MSRs is therefore unnecessary.  Replace
> VMSTATE_UINT64 with VMSTATE_UNUSED in the VMStateDescription to ignore
> env.msr_global_ovf_ctrl during migration.  This avoids the need to bump
> version_id and does not introduce any migration incompatibility.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Fixes: e587632c228e ("target/i386/kvm: support perfmon-v2 for reset")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
Reviewed-by: Sandipan Das <sandipan.das@amd.com>

