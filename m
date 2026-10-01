Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043038DC50
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853189; cv=fail; b=dZzvcuzySmBe1VX0YqcjDP9BjRDavb09rHkW90PpqCPfYiMseT9D0DvWB9MzN7TizxBOMrym48mj2kZO7aYrW5rAkzKV+zCDwtlM8JfkMO1/hu1ISYVTDAQrFPd8ky9JbYONl5chQJROUDzHmRgCwW9uY60ApmlZeCuIpStk6R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853189; c=relaxed/simple;
	bh=E8gS5Z7EcGNaNlZdhByXCPEKnj/gRkX47jyVK4/V/TQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TbaFwmCznugCJlbs/DVrGyWHcegtEMn/Aw3GPwxDDceoEbxZ0HXWJg4ugn7OFtRvpg2vuSXfsQ15X12AR9whh++drov4xB7LZB1br9k13H3co6O2WLl6Q/BMSd2kpHeOS8jIXJAWuUeIxy+DLeB6Tpy5UgC/JiwxSwdPdSH0eIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1e6/DGAy; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1e6/DGAy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqr+0RMTCuCoIdueYPNfrlDG1+zwGqC3TokzaYUa3eJWnLaYYsG5TNHyA1mnmZENYlcv78LQ+cydJ5mnx8b4XFKTuT2Vr5KocNaT21VXdfPXPeigZSRNJhjVLoTYhF0QsDTDTEQCfPyEIo/5YNnpD5s+nOfAOBHFNrj4AtGdcPsIxONYoM7ooHExpFSbF6ho64zs7mCS9fBUEKfPm7kOPDwHHrfITJ+S2xLvoQ2GOMPaMWbJFLzYAmBLqqy3YQm8fxNBpDMIZleraKWdHTQ26f7f46gxtItUN5ELiU1xNCTbkOzCeOxoFYPbUDiJl/9WNeczEB0p4BnI/2gYhzS4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eGxVKZ3XZiKAD2Y4HttTheIr36sLjjaio08TgLD6IA=;
 b=vnAVDlTvEI4s9VME37Uez1tP4Jrtssv0+R0cct1LPR4HeobO+GPhJTxe0YYmKZ9a0eHgC4eZveLuBjz6SaeV0vib9roC7RC4IdQwwrAzJ6Ph8uAVEXHhNrsdkeynfFV7EHMyTSdR9hLCFPF5kP1gih8ZQ3l7yhaPtt3IFKBav+8P1ZlwZ2HhLp4E5mr6Y4uvZsaLm8y6lnDAkOkLT2Ri10tKDWvvQQcOV5EPqemVOvFtuUyhr4kWnZrR2MnrsbUVYCJyYFpSrk+nwfrJJ1gt74OVIvxwerfX05zUwWq5J5ht1KZoIxHk2D9QpB3bHutHQFW9zUteQRIleChvad8+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eGxVKZ3XZiKAD2Y4HttTheIr36sLjjaio08TgLD6IA=;
 b=1e6/DGAyxgpoUqxVHnHgvyTFqM16OkuwrEWkWDMFyGHQeQoYq/vfpLouS25OMnUKf4VP9uTSFDC49l2A8EQIreW7qBfRMpiDDqnTdmCDT7AexGEJQUFCBZU/ZoKor9GPlwPy0ztBROB7EKJ6zszlDdTxn9I6v6YP2O26cA+NbLI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 11:13:02 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 11:13:01 +0000
Message-ID: <502e4c1f-3f5a-462d-87c3-076612935784@amd.com>
Date: Thu, 1 Oct 2026 16:42:50 +0530
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
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
 <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: c8435812-b2bb-4481-f8ea-08df1facf491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3XBBcQMj+3pmiPrLV16OxZcU/o+zLfc7igUZnu2d543X7ME6GFEJXNyd+KawDTAElaDdcUMdFBTpHigx3iuy4TGkTWqdcC2DDu9mJpXUaPnFj2tIl9Ec/VgaDAVkMfnLkRQE9jeOr6PKW6QmJ29pZmUgTY1PXVbpM+bmsQBCQ/z+So7TfIwaesajtuky8e9pqdDxLuhjrup39Gpl2rnlkT/anJDvt+XCVOa//sHoCpfBYSxZhtyXFsgkItz24jfnNRB8U5/DHPUrUFKpjHQsZQ0F4+bjMB6lkX7MWmwEKEuXdD6WiPPR3yUQdPZtujCXfqUiMQL9YSMlsCmHWkBLNReJ1smtnun2p312OIzTEBlor5IuhGgzWeD+177i5Xs+EQxdJlrCk2kyEFlQqzArgUQSZnYt3csTB8q2DiYEkZmGkl8Fg88KkqpX8Q+ZbOkqZ106MXwSBNAbCKRuPuy7yzBjNtMIvUcYJkFhKJRzoa9bRb+57cg26UYtN9DMiru/tMHezzB9xCQmPP/YjjAVxaYsUvrCZCM+vRNzvJy8FvnjpOn4S0O9N+aHUqCBOM2Z+KVB4/PiktUvjMAN6qKiH/3yTQbvznr5+RuCOI3Bw5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZJR0NNWjI5ODVhYnhhMzNOak5GdEIySkJucGYwUjM3eGlrYVBCRFdpNWNH?=
 =?utf-8?B?NlI1Q2t2aVZieDh5TTV0ZnpNVjVKdnpHSWlLM3IxQk1nZTdpMTQrczBWaWZk?=
 =?utf-8?B?bDAwNWNPemtZbDlQT0pZQlMrbDhKZVNVaUw1WGZhVDVtZDY5MmlDcEhkN092?=
 =?utf-8?B?YSs1dTE3d1RxelQreHhyYlhYUGlybXFhRWF5Zm0rUnd2amd6QmQxa2V5VTRG?=
 =?utf-8?B?UG1GVXZqaGhDVUxMUzByNkpnVnhOR280ejY3aVZ5cTZYVFVLbEN3WDZmTVRm?=
 =?utf-8?B?b0JLQ1NNRFNrRmd0NVZDNzJCSHVTNzZlVVM4U2ZVL1ZSVTdiNGgxK2hTQjRO?=
 =?utf-8?B?Rk52aGtqdVFpRUYxVFMzTmtBMndZdS8vY2VQR3N0UXdKRnZjOUNvWXpVQ0Vp?=
 =?utf-8?B?U1ZUVWRGNnN2TkRmM3ltSDJYeUpLajdOQ1Z5Qjd3Z21qZGdQUWdYZDZvVGJn?=
 =?utf-8?B?ejlLZzBGd0w4YVNqeHBVdWJLSXRzKzZhejVoK3RmTWJxcGI4aDc1MmVtUSth?=
 =?utf-8?B?Yk5XS1l5TFpoQ0dET1VGZklhSGJqLzJGR09Ja1lmSU1kaUNjWUVaZlRRT09o?=
 =?utf-8?B?TUxheWlkc3ZZZGZ1akZybUh3Q1dXRHBpbTN2L0FsY3Q5TGNvU2dGOWpTYXlk?=
 =?utf-8?B?T2lsSllBMzQ2cUdLQnprN3RXUHZDd3U5L2tVUDlEV0RkTTAxdE5qWE1TcFhK?=
 =?utf-8?B?cmhyeDZXajFMSENMV3pTa2dpc3BWRW9kbkRRalE1UXUxM2tZRkw5UUJucThy?=
 =?utf-8?B?YkhPejkyU1lzMW90V2ZSTmNtSitPZUl1c05vNEVJUk9hcThYc0dZUFhLeWdt?=
 =?utf-8?B?am9JL0V5MktWTG5IZmV4Umdhb0lERG9VOFdhcjFNWEtEeS9ob0tGTlVtaUtI?=
 =?utf-8?B?Wi9qbHJ1WFlQNzVicnF1bFFjWTN6dm8xQmNJdjErUGN4dTl4VnVUVkdzK2Uv?=
 =?utf-8?B?azNkbE1RQ2NYUmREN1Rvd0pOWC94emRCU1FwbnZmanhDVGxmbjdKV2dlejRw?=
 =?utf-8?B?Ly9mNzRNVk0wcWp0USswRlRPZkt5SDVYYXFqM2J5cmdSajVUckRocy9ZSG9v?=
 =?utf-8?B?bjI1ZDRHazNQUzFYN0tkVmg3T0dBTTFzdHZDTENIdTF4aVk4ekk3dy8yVWkx?=
 =?utf-8?B?WW5FT0pwOFNhTStnSWE2ZmkvdVA5RE5FVzZ5WXVKRTRuRm82R3BKUjBXbjJs?=
 =?utf-8?B?dTZHOU40eFFad25IWGljOFVGRlBUU2xzdzV6SjZsZ1ErWkkrOXBIbHJmc3E1?=
 =?utf-8?B?ek9VT1hyeWR3REgycGpNQm1oMDRIc1Axam40aGZiK2FSMGxFZVRQbWZ6Sktx?=
 =?utf-8?B?QTdybXZxSUJmWDBZanMwR3B2RUFzUXgwMXhRRTdHSE5GY1UvS2UvQ01nOGVN?=
 =?utf-8?B?UGhub0lSNXErbWgzS0N4ZFBMWmNCVHBKcGRvN3FrU2Zud3pxakg5MHdVYWFS?=
 =?utf-8?B?TGNvL0F0MXRvOXJTVWltQVFrdnlpUG5aK3Bzak9oeXhqMm5JR256enY0a28r?=
 =?utf-8?B?eDFaNWtzZmRGcGZWWUhDZEJ2NGlyUjM1c01VR0tPUFlOa0N0ZXp1M2R0S25m?=
 =?utf-8?B?MEU2MWYxczZrR0ErS1R6Y1l5V2VQeXZFTGZodDh5dHhFZnFPVForZkdGS0c0?=
 =?utf-8?B?aUxCeHZ0TEt2OW0yVXY0UGFacnBQeXNlRjhXaC9aSlZ4L2ZSTGZqVmorSWxo?=
 =?utf-8?B?cThaakd4QTh5ZUhnZ2g2WEplemtMSTAyRlUxSzZXUnFNenE2Q3JoT3VLWkt4?=
 =?utf-8?B?S3Z1RFBBaU1ibFRHMU5pVjBnYmtpNmpMODVhaXF2Q1JiZWIzSWxZUm53L2Fr?=
 =?utf-8?B?bDFQdWdKR296VktER1BYSnNCRjV1ODhtbXRJVXFCMnBFaEM4U3FDQjV2c1la?=
 =?utf-8?B?eFZvY2Zxb0RzdVVzUUVVQnZ1bGUrTXptallwdk9jMFE4M0xkYnpLR00ybGQw?=
 =?utf-8?B?cnhBOG5HOFFFMUgyVGNtT2xSNTZSU01ER3d1L1ZyUTY4aTJpUGN3QlBoU3NS?=
 =?utf-8?B?Qytsa2lzRXZVaDV1Q09EbGRsL2pnbXp6NGZUL2M2RndMTXRpNGpvYmVKalIw?=
 =?utf-8?B?VmxZUVVvZnI0d2NvM25mWXN5YnV0WmE0aHpDNkhmd2s3NnA5QnhmZGFIaEFC?=
 =?utf-8?B?cXZIUjRnT3IySDk3UWhGZ1B1YllHSzVrUG5mS3NudFl4eU53UFk3Q3k3Y1M3?=
 =?utf-8?B?ZmNtWXNzR3dFTFhuUm1GYit4SldrYlNuRlZubTRmYm5wcjAwWHVlQ1Byekdi?=
 =?utf-8?B?M01XYjFSaWtSVDV3QXZ0S0p5V2ZCZGlreFFUL0lyK1R4YmlEbTdxSFVCZmNY?=
 =?utf-8?Q?DpZPqenqr408GggtuX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8435812-b2bb-4481-f8ea-08df1facf491
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 11:13:01.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q172Ehx26tcIqrJW99IWS5cky5ttwMDWejyO3jrB3K0MOVqEERYHCPgFemoHlguEdvTBbVKZ84HyZTxwZyhkEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292

On 01-10-2026 16:35, Michael Tokarev wrote:
> On 10/1/26 13:43, Sandipan Das wrote:
>> On 01-10-2026 15:30, Michael Tokarev wrote:
>>> On 10/1/26 11:54, Sandipan Das wrote:
>>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>>> ...
>>>
>>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>>> it starts showing up the rotating circle (which shows boot progress).
>>>
>>>
>>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>>
>>> With that, it boots fine, just like before this patch.
>>> I checked current master too - same, +pmu fixes it.
>>>
>> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
>> it. Linux runs a basic sanity test to determine this. See:
>> https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c#L268
> 
> So.. what do we do with all this?  :)
> 
> I kinda see the intention of the original change, but it results in
> non-bootable systems (linux too, as I think you demonstrate above).
> 

Because of the sanity test, Linux will boot but not register the "cpu" PMU.
Perhaps others should also run a similar sanity test on PMU hardware rather
than making assumptions and failing to boot.
