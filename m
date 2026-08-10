Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C0442FB5;
	Mon, 10 Aug 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404070; cv=fail; b=Cw3FJxTI7JJ9XcKc144zX6WxUraoYpVskgCCqxJlfJMuQ7ktmlVXgORUxG+/M2W0BLp+YcnD8qgvOUXdmhEiTn2PX77G9SKAgNwPT3iuv904cgfhHOd4BNU1gjiJpASuYna53CbxuCFJTNL4/SUnZoXtNlIV4LO/e40JnnQ64xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404070; c=relaxed/simple;
	bh=FP4e2HlTebRa/tHJ9diUb9mggqH1hEvrQzNMUrHw3R0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CV/TftFIDi6Hby2/O2utx7wqYngybjZw/dxe9EN+57sQlzpTrQgIVFNzJ84vop4h+pCBFrXzWaF0n+LJVk0RwRnff8FyqUn7vDBNPiA6zQr4xBSrTATj6fMfEQ0kVfS0r7pJzMrIraOvZUu7fpswrqQdvHZSBVv9InrLX9K5IMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2eu8nDRp; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2eu8nDRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geAjUMiB3IlG39g0dZgjNS8+9XN8n8Se5RRpKwRoxR7Ig5c4+3ZyVtEMfUujVksQ4upybz5MP7sOKdIyX3V1dgG3dKXschVqLl4rxfpRECgQeUtrS0O+YeuY+gZneiYxBu2WPTDpJo/rj6GRD70l9qB92i6T9Ysek173MptAXlIJVAWymN3RY0vpw/pcPXaNoi8km4515W/NGVE4TEmYK90yGewTkyEL7k6Af/UGGUHsySy2V/5C5Yp40hG56gNW8URiI+9GJ/nCWW/zxuVR/TaGxP2OE+aQeOBvuDi3Qzm9Sw//43LQDj6bfnQKr8nb3xxiLDDWWVO83YvlUVuuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsHLko1+/U1nNg27ssmIp5TbrD6Kk1zHLFPxSAFgGpY=;
 b=sc83EoZzsSqNCVTiIs0ICNm9o+fYk1Z7wQXI0/uXMg9n81UH9+ch07GQEg5P84Alah0HvDWFxZcLpne4IMyDBtmIMClOyUc65B9izLLgOWU7en+12A5mFPzvoQM1PkbH/0mFH/y31sZqVFRORCizrNEZ6ojI5BF6vtWugyuSJXgu3M25sgkpmAkPW5B/NMRe2AXUcXyXZV02x3+PZIPX739p1/4suTe2KHarIcXn01YW8FP0u4VnV30MISPPgbZ75TjT4KR8XzXeIy5m/wZqQ5CB+Y/kZePjQKQSBbv12gyL0DbV94T0Q2IAaRycLB2byX6SXgjWqK3PeSgPOfznrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsHLko1+/U1nNg27ssmIp5TbrD6Kk1zHLFPxSAFgGpY=;
 b=2eu8nDRpZCQxiLEzP4UaA5RIrZ7gthZswSpBX9PwPle+Ddd0W2nZ94KNiLJZhUt9L9SEYaB/92LehDMPMCvjvlJnLNbm6lgcEdQFQGQw/AtGAZljKhkDa7rY5MIgZIb41cvllfOl8hUOG0VjDgr6Ek0kAzuG6Ikc7a3slo0AJpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) by
 SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 23:21:05 +0000
Received: from DS0PR12MB6655.namprd12.prod.outlook.com
 ([fe80::cca7:d50e:86e3:24fb]) by DS0PR12MB6655.namprd12.prod.outlook.com
 ([fe80::cca7:d50e:86e3:24fb%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 23:21:05 +0000
Message-ID: <330aca04-b3ac-42ad-80eb-0a00c6d6aaf2@amd.com>
Date: Mon, 10 Aug 2026 18:21:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] x86/bugs: Only log missing retpoline when it's
 actually the missing mitigation
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Naveen Rao <naveen.rao@amd.com>,
 David Kaplan <david.kaplan@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-2-kim.phillips@amd.com>
 <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
 <65d82937-113d-405b-9399-b70973e84c50@amd.com>
 <20260805224907.GDanO942iYDbai1kFx@fat_crate.local>
 <9e5183be-1f31-4f6a-8b91-0f9a92590241@amd.com>
 <20260807054443.GHanVwy9MnwWZQvfdj@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260807054443.GHanVwy9MnwWZQvfdj@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0573.namprd03.prod.outlook.com
 (2603:10b6:408:10d::8) To DS0PR12MB6655.namprd12.prod.outlook.com
 (2603:10b6:8:d0::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6655:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: aa472d17-7cd9-4174-1fcf-08def7360cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LK1dig8N/CTA7XEVniKNN6Z0C2XHpN0mzA6v4cXwalD9cHyTi1TjTl8nmGMujsdmBofu/ylMAXAiNIuPqpaGfhtVLJiR4W9LHfoj6evD++g0E8aOjLAZU145+go4Z9PqFne7q/UdNRt+F5O8/tLArUOhYaQhTYAJ/d2AC0pAyUPMgpaAlf5+aVC/gFqHZh6zj9s1P4bHheszkA+zAh8L2wjKiYjy2Hg3N0s/2fohvYj+MiZw3gIZlBh/Rqnn2/h8onsVw+/xntJ+IMnuzpPwP8jKs86Uw9rVNcwTSBLbvVanCh/0bs90h+XSJdowbXYS8M75ncvrkBuH148B6Do+MTPI16yGaxs4wMLDZTQno/5Uv8SKRFRlMJNvvTQ+0XSqZB7wRnSDbPg1YcoQSbU1QAHyuNrtZJAf71xuVN56jbUVNV+VSrOJjR9aBbngzJH4sb2+Kjcsz9b0kHHgYKYrOQ89AV/0lvYWFFvkCTdFh8sc3OZWhC7pxY9hohWKB4naU5atriunI95snQRRP01SQLz5RDnt60mib0hswrp2WW3lpH6KTKdxR/YSWTzYcNNGWOmyIz/y/YC837gTVcsr0XQtBNcD5PWrb51rWmGmQnCyMMJKC50JtoAFLXRDf5ttsY5gFQ4aCbwnwLT7r2LEfG+3t+YLOyDdSry5iQINcB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjUxVjFNMVNoRXRxb0JLNVlCRE52TlRwZFl1NmdWc0FFRWhOVTF3cXMxVmgx?=
 =?utf-8?B?aVAxLzc0eXVWTUVoK1pHc0JWRURtRDhtNDArRkJwRjlHZlFVY1dhWHRiUTJK?=
 =?utf-8?B?SUdOd2FGb3JXcHJMREFrWmRlRHFkMFFoU3hRVWJ4U0w5VnVqb3p6NkxJT1Fs?=
 =?utf-8?B?OTlodHBvN0dNS2t4NXQvTzgxUy9MVXN0NTRiWnlxVGRIMGFmUGtXY291SzNW?=
 =?utf-8?B?SlFyWXEwU05NemQ0OFJ6aXFkSy9QT1FRYzFiZy96WGNRbzRmSC9RMkl4UFVa?=
 =?utf-8?B?ZnVLVE5LVEo1UFA2UnQwT3Eva0NxWU0zWXJJd0hLT2sybnNRd09ldkVBMms4?=
 =?utf-8?B?UFlCTHQyL1cvenRFVk5pZTZhSHhDUGIyVi9TLzBEWUt4VktPcFV6QTk2RUtS?=
 =?utf-8?B?NngzWHN0N3ovR2JrOXVhS1VkWWI2Q1RVVWZGVFI3Mkp4ZHBXMEYzWWxYRTBR?=
 =?utf-8?B?MUdIRUs3VTIyYU0xWFJ5Zy9aOTlYOTJTOU4xNDdDb1o1aDhxWE1NT1dVaEFX?=
 =?utf-8?B?RUUzNUZWMGhKdGZ3bUFjcE05RDBsaDZEeWN5ekZjQy9FNVRlS3V4b0UxZFZ2?=
 =?utf-8?B?R2Z3aHZkcTVYNEJYL2JVWU1xVHFPYTc2QzV3Tkd4cHNYandSTGhVT0NXVEl2?=
 =?utf-8?B?ZnBtVS9yRGlCaDhGRTV1VHYybDRUQk1kWEQyK1FhRTYrS2doMmk1eWNmVnFt?=
 =?utf-8?B?NjBwWUY3WHUwYitkek1sM1VqamI1VzBLZC9iSjdHWlhuOXVSZmdhSk5xZ1NT?=
 =?utf-8?B?ZXJDeUNCRGVBQ3NTTE9aUEhUSndONDM2NXNBL2w4UmJMUjcvLzlZdjNQVkpK?=
 =?utf-8?B?YXhWeDhlWHNsNU5qVlA4TmhWbG4wb2JxS0lBQkV0Rm84RWNkeFNpZzhCNVhD?=
 =?utf-8?B?cUNiWS85S1NMRWZuWXAvZXQ0NXNrV3Zrd1ltU0kvTHJnRmkreGlBNEtCUytR?=
 =?utf-8?B?V3Q3YWNsUkFreklnTTlCYjRqSXF2MzdvbVI2UUxJMU8wZXJneWNqS1NmdUpn?=
 =?utf-8?B?cDBXTFZqOXVpem5hRG85b2EwRWxxaXlNZmNQZHVPd3lsa28yYWcvVjJsSEN4?=
 =?utf-8?B?NENBWVgyQldFUzJRQlpPSHJyOFk4dFFIY0dudWFRTSsxU3lLK05KdGhxRHkz?=
 =?utf-8?B?YUYrdnpuc20rdCt4cVRDTDUwU3NmVm9YclVGdHR1ekNXT2dWMlZmOVpEK3li?=
 =?utf-8?B?SllrRnNmT2VqMGU2c1RvdnpJWVBjVkZXREFSZTAwNEc4dExkMStvRVBQMHpX?=
 =?utf-8?B?QnVBMGlGUXFjRnhsV2pvOVpqNjdONzhSQVY3b1RmWXF6Q1QzV2Frek1zbzU0?=
 =?utf-8?B?aGdCay9Wb29GcDNxV0xjQysyWkJoR0Ewbzd2bDl6akVDTUs1bDBoc01sdXU4?=
 =?utf-8?B?U2gyNWxaQTlTT2NXZmJKN0IvbGxsMkNLUXN6UCt4RWM3czM2MEk2aWxrNVN2?=
 =?utf-8?B?UW1WcUNpcXgrOVVkcVRDU1NENmVUYTlGYXlSSUZBU0hoWTRqT1ZFbzRKVnZM?=
 =?utf-8?B?OVhtMlVTZytoYndGYndqNWpJOXc4N2lmNkVVa3NZUWI1SGVUcWJOdnJ4OGw2?=
 =?utf-8?B?MG5NcjloM2plVUwzdENITkJXZWNteDBuMVZkOWlmOTZsZUNCeisyK1FuakZE?=
 =?utf-8?B?ZXFBT2pDTVdJNTUrUXNtNHloYk41ZldTRkcwVjVTbCtjMDNZaVg2dVJBK2F6?=
 =?utf-8?B?S1Vmc3pkMVkzbnJ6bGtoZEU5TmU0eUhSMmJ6cDQxZ2VmTEV5ZW9kbHlobjIw?=
 =?utf-8?B?L1RKSkdyQTZKNys4UmJEeElFblBLdHB3eFcrV1FZdzgvUWlmMFVvc3NqajBT?=
 =?utf-8?B?R1owQXAweXQrbitiQk8xdThNbDh5WFk1bWh3QVUxcy93U3NXTlVqODFWMmFt?=
 =?utf-8?B?enI4aFpPcGI5cFY5RTlWZG9pRVV4Qy9neUJ4MDRqSVE3dVJQUTEraVFJYnJr?=
 =?utf-8?B?aEJ4MndURGEwc28xZjM5di9WVDRLZnB6b1ljcThrZEhjcE5oUC9weHVBa0pP?=
 =?utf-8?B?YTVPL3FDODRSdndyaytHTFBDczRRNnRRRklXRjhvU0FKNWJOWUd5bzNicUxx?=
 =?utf-8?B?KzVjMVRoRU1MNVRIbmxENlF0ellzRGRMSUsySis3aG1GbzFHOVlDWFJNMmly?=
 =?utf-8?B?Mko4R29FMTcxMHpXOGJEMWlSbjB4MnpSNEN0TWk0Q2NtS2lRNTJ3QytFR1pY?=
 =?utf-8?B?VTNGc3Z5REl0Z3A1akxhNlJBbWIrS0d3RHR2eGZ0MFF6V0FJZTZHU0p0a1VU?=
 =?utf-8?B?WTVzRU1ndmRtN2p3emcreUduWU4zUTZtSDUzT2ZPZjVaeVpWazFUVFFrc1g5?=
 =?utf-8?B?UTQzam4xZ2hxOFVheVlrcEdwQkdvOVQ2MGE2a01FVzlvTFZ6K0VKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa472d17-7cd9-4174-1fcf-08def7360cb6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 23:21:04.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic1kxFxiJTXW2b12LwmPRpL7pia09XoVZ96biZeOrszIfAgFInBid7NZaWzLR6zff8quyucYyNrR+FVNGyB+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

On 8/7/26 12:44 AM, Borislav Petkov wrote:
> On Thu, Aug 06, 2026 at 03:12:12PM -0500, Kim Phillips wrote:
>> If by 'this' you mean this patch, it's because it fixes a bug with
>> RETPOLINE=n kernels that sashiko found when reviewing the rest of the
>> patches in the series.
>>
>> If by 'this' you mean RETPOLINE=n configurability in general, this patch
>> isn't adding or removing that.
> 
> Neither of those things warrant to have this patch, *especially* in bugs.c
> which is a nightmare as it is already.
It fixes a bug.  If you don't want it, drop it, but know that sashiko
will continue to complain, and previously you said you had wanted
sashiko comments addressed.

Meanwhile, please review of the rest of the series.

Thanks,

Kim
