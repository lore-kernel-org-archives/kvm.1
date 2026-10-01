Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF93FC5BD
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844903; cv=fail; b=OOwjlu0coUG6koGa+26GDKffLBN1TUyrs3dGyLhw3/j7zltdb07WgUwWDBlgzNhGqLBYU/IKG3bxch2K6zh1KYrGi/rCb2WxOZpRRngSypshZwf55YiPZmvHB4IODujN+/uYR59fKr55GGqqC6UFieW3TKR5AST3rA3V1uW0et0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844903; c=relaxed/simple;
	bh=l+a+W7rR928wYGUxu57bAPSgCj0x8BDSGb5WeuHPXpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nPg4fLWq/wJK2V4aDwItXQ/NlQc8PBaG7RQzcgUUAOwqPa6veUUGmTgM5qnZr/qKfdGVtQzPYx/2tEsM/j/6vPRo7kM/60xyHUdNqVP5xzID04lyczMCp8AV/Wgpi98wOICT8F62MOv4XLHubLVmrOrp3jMEeUpdAIkH/tyjVmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C58u5vwW; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C58u5vwW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liCUgs/ZAZG1z5qO8UCpZrS/mlILBSg0+e6vHl+UVs9cgiKeJwrkoAEvml1xM6vs7t7r5ywNl07ZB0AqtfUoQNu6Bs6ejfWJvpsJ0sOrIO+lm+8g4iH1Tau8uvfk030ikw1MDb2Wy+y2wNnudG+/7TN4/pSY/1akN2WqmnLEm8H0fKE4qwXvqC7EYoSttTt3XiBjqy87SdL7R3tiQFkXPW1/HIyGpDCVR+dumEZdB8yxS+AzVO8c5WpxQ5Xkm9qgR9sdcX4hA42ZSR08FcAweUW6bCBcmfmNTVDm3d5EquYS3Zac8uUZc/R6augGvHPrXcNqh05Vw3y8Bd3ith/Ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0iiT+EBH7xa5hSx8gQKxVr4jdAoN4RlgaICtyY3aYA=;
 b=khxSfuKb+WxrW0xyiZaucr6+HiJCP+PCS0tJIO+8dXESDTI85rGzb5+p3xno8i9MYq4VVA8/68zvEB8FniD7FTTPPHYAoM08hxTmIgskbmg5wU5LNkWnOU+vpBxjKYtyx03IIu3vXNZHaLfpPqHJ4CboyWjP/b7E+UEZXAHEesxL/SQ68c7DbWJq/LbtszAbb70oXSPxze2S8UZIGnynB0zv/9mzq21frkPye5zZqP5qDTcSMy+xr0gXDjtRkB4IXf/rEIs4LeETCvzK63IahjE2Sq9mI2L4W86/X2YZ6/Q0AsHHjf+SCuJJ9SFB/GDPyyiYxMxntJg0tyM1VuWWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0iiT+EBH7xa5hSx8gQKxVr4jdAoN4RlgaICtyY3aYA=;
 b=C58u5vwW8ssDF8oM0EHfoZnhQNXdcTPW0Kr8YPYfGH+9p68pjgzJW4IE9wzGvUNf0mCsmsYecTIdSdvoo4KtSNZpMPPZp2V0RFAe2IEbTnjr2f+Xs7qWivbKOoTfmhdXKKZvO5JGcCz7DSSIBmE2j8lHCBuhKWSZmpCRnN9iASU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 08:54:58 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 08:54:58 +0000
Message-ID: <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
Date: Thu, 1 Oct 2026 14:24:47 +0530
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
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::8) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: afb3c118-d2d3-4f2c-b2af-08df1f99ab7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	Isk9RKvnFcf7qlBEodwT0AY76goGitvKpVbUwpQM/vWOEKOz9Ut5BWeNqKeAsxWG5YC42ZKDlE4S5UKgFmBu1xmtZKlE6mjpjMzHzZ1wxFNm2w93mcifUBRtUPmFx2yB/wArXbwJCE8Tv8KLlLqAgNKTwlwK1g+YgXKxrWBLNlSCKsTQI6+J6qguCFds9l+QPtQkYQXpU4H2rnHcJdCHv4ePtUS5NaldZ8S0gC23F/jFkN4jaFF/gHpKSHo01DzW1hs/3EsaxPk+SgEI41O62/WAiKubpN/+AmcBTFPzaw8sTbipDwAhL8bpBIrzROQd0BoBVULv40ppyQK8rtxwyp1mYiRNnCygxrSTXF0bNz3ekzNd9oQuYV/w6RtAhz/1iaK3wXujjMEBv1SpL1G5jw7K01KlswEycLB0nKdu6WDjDXvhWhqoVeWQin5Y4MMUUwK+XQDpX5147jZ6CuHztX0hrLY51bd9RbZ1v/FQIIO9+Ts3i3/IwsGROI9HUAVL4QOrtm+HxUd7NFEtZEwxTwyD49g8rrKqyK4ph3VR+PH6jf1u3RbCr1OWr2oPTMLQwKKJCflo4rviqurC8wbK8AuzxcYTkWPoQePgaUBFvovKAIUWaNRbog7nxW3rBO8imYVulweNA/NwXv72bE49wr6qP0WixGacLocvq06rWIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzQvckRmUzU1UklGVjc1bnk0R1g4RGFGRmhNc2hBLzJkNi9pM215amNJZloz?=
 =?utf-8?B?WkZZNThwaDV2dUhUNmNxSTBxZWNUcXRlUDBZREQyYjRCdGU3ZnFlbkxEaXRy?=
 =?utf-8?B?UkltMW5pN0dNUGxjM0hFcUdYRTJIajcvWFRkMWZWeUlvWUtaVXdxSFdNRGhj?=
 =?utf-8?B?WGoxNkcxd2VybnBpKzBuTktMdHAvdnVsU0lkQ0pYTWRuRnlHdnNsZGhneXVG?=
 =?utf-8?B?ZHVlWW5TeE9GQlBYUmpzc1FEWm5KdllRWk13TTN0T3FGR09UUzhvYW1SblRQ?=
 =?utf-8?B?OEZpZ3JDK08rclh4Tit2U1dLQUFwZFlGTlRiL1loTExvVjhlMUlGTjNMTkJu?=
 =?utf-8?B?YlRiRnlzNlFaa2lwZXJsVGo0blVJVVVBN2lZeG1Ob2pUcGlScSt2cmtDSjJn?=
 =?utf-8?B?dFJBRTl2Si8wQXNUNlJnMmxqcGowYldMdDF5YVExZHM5dmZVOXBnTE1ZbVZq?=
 =?utf-8?B?TGs4MG1xdnM3R3oxNS96N0piZUdsczU0U0RoZEpHcGNoUEJCZENWNXdSbmd0?=
 =?utf-8?B?Ykl6ZGRrSjZESWpWNHJBUFdpMzJMY2dNZDVZcHJvUnNVNHpwZVFpOVF2emVU?=
 =?utf-8?B?YjZBVTk1RXhxbklibnUwc2tUZk81MWVUb1lpcnZlc213emxwWmF2TDFtT09Q?=
 =?utf-8?B?TmZyYmgvakhsZzhrM3A2NkEvaWxxSTVRbEJzR2UveWlNNWNCMENLZ2lCclpL?=
 =?utf-8?B?TC9ETS9ZOTAvKzdJRHRwQnA1Q3lQWnE0anQzcGhDYmcrc3lRcFlGZk9uUHlM?=
 =?utf-8?B?ejFZZkdmNXZlSWpGWkF6NjR3ZkVqUnZCSU5lVTJQUXpuYTRlSnVwalpVWk5E?=
 =?utf-8?B?b3NxSHhxWi8zSm8ybzFvZm51aE5KWnhMQU05eHdDZnA3UHVsZHhZRkswMGVF?=
 =?utf-8?B?UlA0dGp2SDhRS2ZGZkFIeDl4MTJYTXdJVEphL2NMd0t3WXNGZUc0WGo5YnRV?=
 =?utf-8?B?cHdBanMxSWtWcTZobGJjZFV5aW9ESU9mWFh4OHRBdFBxcVpIQ0lMNW9qUHlZ?=
 =?utf-8?B?Tjk2a2ozeVlFem54UHA5MTRlK25aUGlTNkIzeU9aOXpWWXJVbC80M2JmM0hl?=
 =?utf-8?B?ZXFMZkVORFNoc0NKakhhMTlzdnF3SmluemNLRDNTeWFkNUFuOUdsdGtjY20x?=
 =?utf-8?B?ZWJSSitLT3NoNUJMUFBNREt4bGdTRlB6Q0lDWnJNcGplMWVKYkNSTG9oVEFK?=
 =?utf-8?B?dStpZG1WUnc3aS8rdDVCUmhaSUozTUc4S3c5SUtUcWNROG51cVhXRGNrUG1E?=
 =?utf-8?B?dXlGaWFZbEUzd0FTcmZDZ3h5czh1Mm44QVV2YTlERkFLTUNvTTZDT3NLV0hm?=
 =?utf-8?B?TUdvNnVBWm1iVVl1MnFtUWlSTUkvdlVuMU5aSmExcDNQOXhhQThhOVc2UEp1?=
 =?utf-8?B?YVptZU9JMktQQ1Q4MHE5SjFiR3Y3V09NcEt0NzQ2bHVBVkJobTh5anZXZVVy?=
 =?utf-8?B?Q2N1RXRkckU0ZDhZM3plaDg2WHdabHZEbFh3bE53bmVPdnYyYVJhZ0x0blNJ?=
 =?utf-8?B?WnQ3Z1lPdGdObU15R0pCSkVkK0tQYk40b0taazZRblR6NWdyYjdHVHArNnBh?=
 =?utf-8?B?OThwN0lCWnhmMnQ0MmEvVTRtdkhZQ1lzb1ZKL0hKbjlyTGJZQXpmaGhBQmdS?=
 =?utf-8?B?SVU5TStHWktmRmNrTFp2M2t0bjJ2d2QrNnlBLzZiNXNHOXVjc0V6bUkwUnNO?=
 =?utf-8?B?MkFjWU5oZHRCeExNSDhiSHY0aXJTUW82dFBtZDE3U0JJckRidk1jK09ncUVM?=
 =?utf-8?B?aFk5TWNiYnZHQm04bklHRXg3L1pYUERZM3hWc0JnUGdkTjMvT2kyTVNPa1hw?=
 =?utf-8?B?a1k0d2lyVXZObk9TUTVOSWlOaHVRL0VRbjN5WEJOR0xCQy9kTkRjTWk2OWV0?=
 =?utf-8?B?ak5QVFdFUHA4WjJta09TRWRzY3RDK242Smt3ZUR5NmR1VTJrZ3VNeHZXaTRa?=
 =?utf-8?B?N0NzUEJkOWcyczFwRVRDb1BJU1JoWjFHV0RUTm81TE1URDJLV25RZDV5R0xQ?=
 =?utf-8?B?UCtSY284T2Y4K2YvS0x1VTlreFBVSE1SV2JSRFRVN1JscU96RVRjNnhvYzFw?=
 =?utf-8?B?TWlLVjBjQitHV1JReVcya29BYXVTblFBTWpRbHI3QmtGWjZINUtjMUJaQUVy?=
 =?utf-8?B?Nmc3WFRCK3BaZTBwcHNsU281K1dPa2pCdTFEU0ptTzhXK3MyVktxQ1dHdnZt?=
 =?utf-8?B?Y0tYZ2hZTGRyR1VDVnRkbHlYOUc3c2MxVXBEcTdVSmZSL3p0WjhRWldZeHBB?=
 =?utf-8?B?UGwzNk8yazBhaHJkRytoLzJlUzBTS1UvU0xGT0pqS0RSMVJhUHJhUXNDM3Fu?=
 =?utf-8?Q?HIFkZTQJqGGrHEFbsp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb3c118-d2d3-4f2c-b2af-08df1f99ab7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:54:58.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmtepsesNXdShB2kpFanB+3DilvrH22FVYEqfaGXDmtjl2v4nkjNhnNVs8CZyTd0OB5gjoJaxLA1S8Z7ScTksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

On 01-10-2026 14:02, Michael Tokarev wrote:
> On 12/30/25 10:42, Dongli Zhang wrote:
>> Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
>> there is no way to fully disable KVM AMD PMU virtualization. Neither
>> "-cpu host,-pmu" nor "-cpu EPYC" achieves this.
>>
>> As a result, the following message still appears in the VM dmesg:
>>
>> [    0.263615] Performance Events: AMD PMU driver.
>>
>> However, the expected output should be:
>>
>> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
>> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
>>
>> This occurs because AMD does not use any CPUID bit to indicate PMU
>> availability.
>>
>> To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
>> when "-pmu" is configured.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> This is commit 4f0dd09e61b080c27589fe35b575503783c5a256 (v10.2.0-1114-g4f0dd09e61b)
> in the master branch now.
> 
> This change seem to broke booting windows 10/11 on an AMD host, in paticular
> with -cpu EPYC-Rome-v4.  It were initially reported in debian qemu bug tracker,
> and I verified and bisected the issue on my AMD desktop machine (which is AMD
> Ryzen 7 5700G, Zen 3.
> 
> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
> guest enters tight CPU loop while displaying a boot screen, before
> it starts showing up the rotating circle (which shows boot progress).
> 
> Before this patch, it boots ok.
> 
> There's no other fancy options, just
> 
>  qemu-system-x86_64 -m 2G -enable-kvm -cpu EPYC-Rome-v4 -smp 2
> 
> (I'm replying to the original email message with all original recipients,
> hope it's okay).
> 
> Can someone please take a look?
> 

What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
