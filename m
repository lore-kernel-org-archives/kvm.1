Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339A33937F
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851423; cv=fail; b=UFZhX1UGRmf71wrbHlyVrBc/XE6unpdZYsGNzYg/BD9sPaAsVUwJehwhKWH61F5g/nc31vHF/dYi4KgHajTRmp2Twj+WGClJ7dVzX/6XNShCdfWvsW4/Z6+oH+8Z0cDkfalO9jusIG6sFgJ2O6coIVmaE1qDIbdoVgvBjNOucS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851423; c=relaxed/simple;
	bh=wQ3+fddBh6rsA7riyeeeiwTMBg1JBfr/PFqUPGUI6TE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTwD9C5Ngzyzu0NxHNr4KQBMCj9pXcsO3+mMRrlroGfks9aYM5u5a3ohlzh/vx05D2AfpnMwtBppzC5ZoKymOePsIzoPxO+ULvutwN/FRkPYqeM9y0tPu5ZsDju49xCKmfX/cfSJg0Cl7J36C4cZgutgLsA64mLLQuuw9T1RpkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xh50RLPK; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xh50RLPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6mmtpK1/IIGxH9bUuOB856fGfshwzqFM63yrSfvESV9QOT9eojrtca7gXZ0RgueY63hm/Dmk5TRTFyzmMG0qxLpYi5GpH65xisXPzCTmxmxlMH7qYR0xVr76WWo3qheqP9EYmMtaoDcmHL3KAjJQTU8d+rO+R+vgQxnql7zEVh24JU3dhFplp7TTNHlCz+Nlg9SKgbwimC3Ttj3SqF3r4jIB1xI0/xqW1TDFnv9/meDNDMLJDMIkOtgdBZNPWot4YqJW8s0LskoGp32+Fu0tWKvYcEv8b1RN/SjonVT5k3wEQZ+aow2E+B2EOiVouo9DsqLQOlV9I38htSVBi9Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz+12wPx8qP5UxoeU6RETGqNvk5Ep2MIhAAwx8sKkAA=;
 b=iqR2byjncPM8yAJDPUyu/Te1sNDnffDBp1p6Nn48K4CcgitXCVK2CQNQUtI9lRbcXjQ2xWSQe1GEa7E8OOyeNcQdZFu/83qrvo94ZNKzwZdTmWAYRLOm1x46VdyQEk+T1LsO/YpDXZBQctVyuTRJ9YPYSgeMpVgnquWiyJXNpMTvPk5XogjV3a7szJI50vR+XWgJluHmwS7bx5UqdXzAb7Jw8litdsGXyTGL7OVghsU8cvIdtWeHcrLhOZMrDGkwoBRwaQ9zNaV/qeaSX3Ix0+4HnbDkrA5IOfrZ6pBGReeuDyBUqjRufqcFSIZPugXVPu3VymuNiyy1Vqpj8NOxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz+12wPx8qP5UxoeU6RETGqNvk5Ep2MIhAAwx8sKkAA=;
 b=xh50RLPKx5q5eZ9rt/20QIQJZNLM4q5x/2K+nM9BhP25qX9UxHpnvKZBsvfIL/tNxrVN4kwqE85q4LyQ2gpNCylTId7mpkKl0GKSwE6KGuqcXBdpIms1Yx/KLvlDe8wAS3qNlKwj0dKAiRGKPl4/OvV618f2zzrB5IlUhaI1mis=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 10:43:36 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 10:43:36 +0000
Message-ID: <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
Date: Thu, 1 Oct 2026 16:13:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Michael Tokarev <mjt@tls.msk.ru>, Dongli Zhang <dongli.zhang@oracle.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4ecd86-2169-4134-6af3-08df1fa8d8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bosfeqdYBOfixkNe/llq58p8aBRzTkwj+9AGgIoW4acHE7k7GWPk4rMBVhV1CbDyQZiSBbWae1XpZ2TvqbN9+gSFxhSI9RxCthIcKBltAUmh6XkNBi3MYP6WFlOjY4Wz8kw69tEkMmWT4mERmT2OxKGgxLZIuTZbd+Q+VwaSLeewz32NJ8fUcCxYv4HpbRb3UaCdetd1K/wE/BTaua7AyQ1lG3XLteIaUDUcrzkDB1KJBZIztYAu2Gvr/87JyaT6xXj3RqHpPpO23rvPEXJ39sghy40ZEDgdKHSGLRICJBFncuBlhv3lB6SupekDP56Fi3lCAF9ufKt5ZG/s26SGsnwirFM+Ofk7U4uPLXJeUTZMVGqGOl901zIKyCvz3WNrrCNchxtdE9qhJ4awDkpn5UAvsmeMqAkdXpsugtiTzUoZ6BFnv4uF+vDZ2ldVGD0Pt0IQyd/cHUj4Yjwi5Y/EyiyFL+0sRVf2x+1171c/Z39uxQK/C3znGqfxd44Dpk1hMdQlXRMJZa0dFr6sYAV5/Jcqr4Z0ZySbOKItB1qlEv3bTOg9ty8QWcyNLfQA/YkEgwPbfVxclS0LckVXuNLvH/1tXNT8Nb8oATIJKN62p1FAp5jDSFM8T64kNt400nu5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1A2UGJwYllreHQvNGc4b3RYSG5JWVhXMG14eVJLRzFaRTMrNk5DNXBsbTRX?=
 =?utf-8?B?NGxOTXlwcmtMWW8wMVBnanZrcmVueXJ3ZnVrdFBVT1BtY2JKOVZsTXh3dEdh?=
 =?utf-8?B?QXRKaWVTQnVneGFQUktwR09nbnllR3RQWStiTmVTNmtMUkZGdTFpQW9vZFM4?=
 =?utf-8?B?OHZaUVFlTVVmeVhZZmVLVUtGZUc5WlRuQ2RwcnVDUWhtQ1FyUFZLMUFjaVFz?=
 =?utf-8?B?OThrS2FWRktUcnBFYWFLVzZGRHpJTWJ5WjNsdHl1RUVscDZ3c29KU2QzcWRv?=
 =?utf-8?B?T0s1eDlwa2VzazYwcUI4M2hvYzd0Nks0UXpUY3hvdnU5VThvVDJTcm1URVpU?=
 =?utf-8?B?ZWFwOHRpbDVvbW9WQnRZbkRpNGh1bVF1QUU1VVZQT2ErSDJzdmVvaUl0Wmto?=
 =?utf-8?B?bHI0STNacEc3dkJ5dFZleTR0WE5pS0w5SEdxdFFiVmdkWDdQQVduR2U4RUh6?=
 =?utf-8?B?ek90ekZOMENXSGNibG9HcGU0Z1VKWlQ2R1gra2lxZ1NSdGp3MkpOdkZnVVZt?=
 =?utf-8?B?NHFNUTVWRWFmSWRQWFVodEpnN1lmTGVhSFh5UERWdk92WWEzQ3c1VXdrWkVD?=
 =?utf-8?B?eVZGbmVMVkZwNEYzdWJTZ3IzQlYxVHZaa1EwREo5VW9pZVJ2aWxPbndWSHBO?=
 =?utf-8?B?dUJ6Z3B1YklwS3pOUjRQK2xiY2xwK1U1dzFSL1piWDJFR3Exbi9tRkxWNTVC?=
 =?utf-8?B?V3h5eWhnYVNsNkFkVmQvOGJaZk5VY0JqT0E0SEZCVHFqWHdSa0dYRCs5S2Rl?=
 =?utf-8?B?ZDNWbUV2R2pxOTNCQmlSc1VydlZ5MVlRK1FmWEhNVTZWbHh1TzJ2VWZBbnox?=
 =?utf-8?B?QlJISEZpOHhrSkNxblR1MFZqNTUzNytCUGMvYmRxTTNBTWhLdGQxeSszZU1i?=
 =?utf-8?B?bzBEd0VmNzNGK1VnYkdwcG9ubm54cnJzVk5oSUZMNGhucEZiVlRWT2hpci9j?=
 =?utf-8?B?SVRob2M0eWF0TGVNcFRIVHVYRlFNV2RGdTEwNjMyUnNSMUdwNWIzcWQ2aW1T?=
 =?utf-8?B?aEJ4SXUxbldzWXk4SUI1VXBtbnBuOWgrL1l6VFloL2ppTWVrL3VWcUtLbTR3?=
 =?utf-8?B?bXY4MW4rWmJibEJZdThnL1didDErL3hBOVlCU2h2d2VrTDRZQzRTZmNDbjNy?=
 =?utf-8?B?eEFmbUJEQXByVXJnMGJmY3NOM1I2TkxNa0k3K28wRlUxb0dDdmVSWkVid3NK?=
 =?utf-8?B?M3NzbTErbGZQYU12bHRVYjhMUmNkcUh4eWs1eGN0aDNad0pnSVdMditZVzlW?=
 =?utf-8?B?Rk5aMWpPanpjaVRGcmM1UHBMVjdkZE1QeXJYTGdSeDRCUnVWUGt2MnY0U09l?=
 =?utf-8?B?cHp2T2xscGc0Rmw0VXZWN014S2xOdk9MWW1DTS8rOTJ0M2tMUDBxWGZkTWNq?=
 =?utf-8?B?SGhmWGlHbWQ4Y1dWcXhGWUdiMzhKWjlxQ1VoNmRlOUpCdmVUQVJzaFlkUjBs?=
 =?utf-8?B?RjdTM0lpOEtqMWVwN1orTTZxaWRjVWV4ZnFIVlhMZGUzMGhpQWlINWh2Y1lJ?=
 =?utf-8?B?ZnZxNHlnVHptTG50VTRaZWpzZTRrRDJuWXAwL25KSVhBVXA0c0FYUGhmT2pC?=
 =?utf-8?B?Rk1KdkloamhRblc2Mk92ZC9MVWhyOFpkUFJmNmRzeTI0MWpZd1dTaGZsSGti?=
 =?utf-8?B?SE9HdDVSYWFqbHJMd0FpODh5SVZUaEtOY3VBZjEwQ0FJTVdzN04xaDFLMHBj?=
 =?utf-8?B?S3VZbVZ1bW5obDF3TE1yQUdvZU1IMzBWU3kzUkN5bU1XMUNhK2s2aGY0d2Zq?=
 =?utf-8?B?cnliRW1od1NBWGtGS09qUlBuS1NyTndUQnBEMm9ta05aME1ORVVIRmxseXVR?=
 =?utf-8?B?SGtxQm9WQXl4dFhlQmVjV0FCUkY4VXhwUG9RbzYwQ0tNcWtWSFVEbE00SEtk?=
 =?utf-8?B?WEt3amtadEpiMjh3VTJ5YisxMjBmVlRZQU83eXJBQ2VhUVNpRCtlN2JzV2x3?=
 =?utf-8?B?N0dLZHJ6N3AvenMydFJxL3ZlUU8xWW9Db0NqNWlnL1ZWUC9VVTdDTHJwdmRM?=
 =?utf-8?B?cCtuZU9BRzY2dDFUdzljU2NjMmpWS2d6Qmk1TWdZSlBnTm1OdllZZEUzbTNx?=
 =?utf-8?B?SmdGSUVwd3VTczB5d0xmVWpvODYyQVU2bXJSV1ZWcnBoNFEwMGs1WlRDVTJk?=
 =?utf-8?B?ZiswOUNYQVdLQkhkTVBCWE8yUzdUdlhDeFduYUsyYmVjMmpOR08yYWtlM3N5?=
 =?utf-8?B?MjIySFV1bTBhdy8xMHpvVEVSSzluQjJLSDZLRml0Y24xREpueUJESStXS0x4?=
 =?utf-8?B?VSszRHgvQkM4V2tLWHNVVmZKaFFlYk5WR04zZXNvVVVRR01IQmNJemVCaG9I?=
 =?utf-8?Q?UCVs2zEQfRzniVi8el?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4ecd86-2169-4134-6af3-08df1fa8d8c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 10:43:36.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlvrkAlTd/XpEw5XLx5iaaBKRqMmmVYDh1JIsY7+2d6+foZxx0HUJOWMwi+fn0mHOVvQx564uvHPeHcXQIyYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

On 01-10-2026 15:30, Michael Tokarev wrote:
> On 10/1/26 11:54, Sandipan Das wrote:
>> On 01-10-2026 14:02, Michael Tokarev wrote:
> ...
> 
>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>> guest enters tight CPU loop while displaying a boot screen, before
>>> it starts showing up the rotating circle (which shows boot progress).
> 
> 
>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
> 
> With that, it boots fine, just like before this patch.
> I checked current master too - same, +pmu fixes it.
> 
A guest OS cannot expect a functioning PMU if the hypervisor has disabled
it. Linux runs a basic sanity test to determine this. See:
https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c#L268
