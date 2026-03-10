Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B23E2747
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146679; cv=fail; b=q31PdXoY6hrdI1iaghlkytWBx0s4UPjFGMrtmldjkUsR9PxxSnvdQHNrJG4uyjZLKsSrTpQcqEnrSyspf1c1yAFQmMU3DpM1+WBZCl+87Bpb6F/arCx2Z69z57U+V15EvKaJMtL0bkZD1MiSh2KJ5QFhHsVyrZWH5ZqeTpwC4xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146679; c=relaxed/simple;
	bh=E2RZVEXovHan6/W+S3b9Li/ULMY4JkT3n8y3KlRzMXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lUpIHKj5T4zNWGdqnMpGhnXncZTkRYjQVVqG02OII6h7udIskqMpysaUgxhQdEW6TpKBNSIgMXM4B+OBnh8mL9glflqK6iU+jue8ABdCCyxX/LJ4EQz4CmNOWWxhImXYVBHQYG1P2T76/goEC31LxQVOmaPsiK4zqMiUWBjpT2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jq4wPnju; arc=fail smtp.client-ip=52.101.57.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jq4wPnju"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da6IqEQ8xKl1TBb+pZiWa40alVAtdc7Y8JR7CiLhrVaEXD2jILI3AFEHqC3Z4rbW6c6piBZt3Wi9HSrGHsseyNmvMc+NAVrl0IO90w95c/H6k4N3fpiTfyh39+NRAK8M4Yf59M8G7JtylfhxnekQS1qUes3MoNblGQpKfWo5mwwN3nLZrQnb0XWnluMUJ7a/6olTcebWhZNvWmT7YFa2sRDs5eCXX/mUA3G9qMt3wCQYFYhCI4CFmeAsyROV7ux19TDNo5jq9dzLow80rouD4ESvqIRaLSH+RJJP1SutN8+TSLGPLmMykObG8AW4UcGjfWj0/IVDBvnXZ1aOavNDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga7vwpZzPlYU4/GYaaegRNWpId/gxQUIDOR9hNe6S0s=;
 b=d6lGqwLLiLN8cWrBipcoNnbaYrUcs8jHlQ71DclJbIwtNch8KKjzmeHs2IW8mx7pZ6gGeUFDXoqZ12oNCodpRTs/70/lirutyEx06G2meW4UPwOBrDIGU8Tu2lzephZSLCfbJ1nKxUsWc98o1KlvQmPukMl6AWShHkyNYUaN7TJy/CSIoFhk9JzNW95kC7yLY6TxdJoDAkZrrD8xvaaoCyBJSZv0HSKkHikd94apLf8c6GGKdkF5aaZrzWHgj2gPXGdHO+8EQJt7QHPzmtNcYXsTHCE+ExCF5KAb2ZZyMyAVpBezAL0/pzysZyMJmoMo/toq5cuMkpeFa3OgvEQT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga7vwpZzPlYU4/GYaaegRNWpId/gxQUIDOR9hNe6S0s=;
 b=Jq4wPnjuJRDfpQsdODqT/yTfzoBt9UbsQMg+SU6HHvM3l3JqGIo9QQYZcm55a6MTObfHdVUcx7DkdBIkop1AyqLHSmkRfov58qnjHFtnzRGcFQewpJcwY7yMIhJXRjJyGSmV005CC+2oqs2TtuMKYy+W1FPZnKcVVZ6fgwKGJcnVYqmkb3ycJn18iA2/rtTZEIGUwxsLTCWNyx+8fQNJB32tPOMizvCwwKrzFEc9DK1RkwPH/R+QYHOfbDxUR1G+DrDVvLx1H7PPXy8jj+yn9/0EdNZ52gyjEuRTaJBBOfAL0Zq8YjW31niJdP7QiBcajhXcY7OUzs04Uaq5fQzcug==
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 12:44:31 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b7) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 12:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 12:44:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:44:10 -0700
Received: from [10.221.201.248] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:44:06 -0700
Message-ID: <51f060d7-a7c3-40f3-b8b9-0c4010153b79@nvidia.com>
Date: Tue, 10 Mar 2026 14:44:04 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfio 0/6] Add support for PRE_COPY initial bytes
 re-initialization
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, Alex Williamson
	<alex@shazbot.org>, Peter Xu <peterx@redhat.com>
CC: <jgg@nvidia.com>, <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>,
	<avihaih@nvidia.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
References: <20260224082019.25772-1-yishaih@nvidia.com>
 <20260227132327.3e627601@shazbot.org>
 <f74867bd-02b0-40d8-98be-c22a4129320a@redhat.com>
 <b16fc66f-bea8-4b42-ae68-8e37a6d09bda@nvidia.com>
 <4da90bae-c087-4191-9e96-1bd815468a6a@nvidia.com>
 <97e3c514-a434-4cef-8d94-2f3bfd97068b@redhat.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <97e3c514-a434-4cef-8d94-2f3bfd97068b@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4745ea-e5a8-44f5-2672-08de7ea2c641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|30052699003|36860700016|376014|22082099002|13003099007;
X-Microsoft-Antispam-Message-Info:
	+1SU78Xggo/DTwM4tOVKTF281HVHWrBtqjiL2tDUVTR2j3vz9I6tZntREaPfBC2QxWCbekvdPqFrbD+JyzECHPEemEmgz5AocRuR3dnNP1ewMrTxF0IoVqL5f1QjEdQrgqoOJM+ZVR3dLd3z5VqgnKDwpv+pVbb7YOLLjn8wJLkPGoKwWhvmfzvprAaup2YYUV7BfdPgAXMXXw2D1DwQ+3dheyTZuQqvSxlFtlgaQvey15s7zxGNJk2FNbUbPvmspEOsvAtqgUdOemNNrpYsJNy+JbKxKAaQL2mq4PfyJhQS+CPt6n4v5O3+ArtJxmVALUE8YhEk4yjJ6mesp+ABLPrMRo1zkH6MwaWo88MsOmjEms5xsJIhHvF8t80RKL5qSdx//qeZZ9twKED18F4lUQimqKacvTl+BDhA4m9wYtEB/nG8OeGtwm4gHT5rRjcBj11f5LG+qy5lJjLaao4vVFfhwvLG3CWe8DrL4b3+XdFBNGKZhSOHFFf6h/aT+hcr4peZLkQxdrhZzGLiFOlZvjDoatjhDUCcuI8OsGZIq+sPk2Xst/1od1BVl3jqoYtPWNrLT+6RUsoDLrZAIN226JJiKSNW7m7v1zwFAaJYZMwVTjgeJ5h0ollV44XfSMXP6uERxkXT7gOILW47Ac7KLzPaTtL87iQAcSmL7IAFweiYNmnidN4+6vOQk4XdmI8KRgYpiTggM+Cynqkl7RBv/0M65TbKKPxPbeNfIG1pp40mjvSQG0IeMNpgSUi5zHZUMA68+6NkGP6DaaJpi/foSw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(30052699003)(36860700016)(376014)(22082099002)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QFMjpEwmyVKlr4LnEuy/f2IeIwLkAmvoP7PdTPrpSAJ+/+Y3yBbfUMHYXQyOUJRkcwgTM9ZPeCBS4Cq3AxME85uNK7dGN1+IlJHIZrZ+bxngQnX/2LgryaUn5bRmJEcGfGhArPEkjUAnZ/X5srQDFZXkydqRTwtwP3eXA+ZwBlMhOZrKR7c613lCIRG8d1snK9sRRyksj+yniU9uoq3lFZQN7Aaybq68xWlENPkhLJEgx4ONUqSxPgt8WOG5frfGk0qWG5rzzlmZv+LvgXAUiLH4de6aKHETsoY6umwbIv8H1egiX5Ii1/JbXnJk6qEUaISLfC+O9C2QDUHgWgEvZCwbwHKHyVN3/QYbiKp69KmLeNhD/PwwQreQEF9+0dE/44zCLLd2HvIu1fKo2U3TcMIBzbVKGEq3qMWwg6pIIwSnaVVWLXQSxaZgfurCDDC4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:44:30.7886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4745ea-e5a8-44f5-2672-08de7ea2c641
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

On 10/03/2026 12:09, Cédric Le Goater wrote:
> On 3/10/26 10:46, Yishai Hadas wrote:
>> On 01/03/2026 14:43, Yishai Hadas wrote:
>>> On 28/02/2026 8:27, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> On 2/27/26 21:23, Alex Williamson wrote:
>>>>>
>>>>> +Cédric, +Peter, please see what you think of this approach 
>>>>> relative to
>>>>> QEMU.  The broken uAPI for flags on the PRECOPY_INFO ioctl is
>>>>> unfortunate, but we need an opt-in for the driver to enable REINIT
>>>>> reporting anyway.  Thanks,
>>>>>
>>>>> Alex
>>>>
>>>>
>>>> I took a quick look. The series would be a little cleaner if
>>>> vfio_check_precopy_ioctl() came first
>>>
>>> The motivation to introduce that core helper and adapt all the 
>>> drivers to use it, was to centralize the common code and ensures that 
>>> output flags are cleared on entry.
>>>
>>> This can be done only after that we have the previous opt-in patch as 
>>> we would like to keep the V1 behavior for compatibility reasons.
>>>
>>>> and some parts are little ugly
>>>> (precopy_info_flags_fix). Will take a closer look when back from PTO.
>>>>
>>>
>>> I'm open for any better name, any specific suggestion ?
>>
>> How about renaming it to precopy_info_v2, which is closer to the 
>> feature name ?
> 
> I found the prefix '_fix'  confusing and saw no connection with
> the names of the new flag (VFIO_PRECOPY_INFO_REINIT) or ioctl
> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
> 
> 
> Based on how 'precopy_info_flags_fix' is used in mlx5vf_precopy_ioctl() :
> 
>    +    /*
>    +     * opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 serves
>    +     * as opt-in for VFIO_PRECOPY_INFO_REINIT as well
>    +     */
>    +    reinit_state = mvdev->core_device.vdev.precopy_info_flags_fix &&
>    +            migration_state == 
> MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_INIT;
> 
> 
> a name like 'precopy_reinit_allow' seems appropriate to me.

The opt-in allows using the 'flags' field not only for the reinit case, 
but for any further usage.

See also its usage as part vfio_check_precopy_ioctl() where we
set info->flags to 0, based on it.

> 'precopy_info_v2' could work just as well but that would tie the
> precopy reinit/reset to an ioctl which might me a bit limiting.
> As you wish.

IMO, renaming to precopy_info_v2 seems more suitable to describe the 
feature/expected usage.

> 
> 
>>>> Is there a QEMU implementation ?
>>>
>>> Yes, please see here [1] the candidate QEMU patches that the kernel 
>>> series was tested with.
>>>
>>> [1] https://github.com/avihai1122/qemu/commits/vfio_precopy_info_reinit/
>>>
>>
>> Cedric,
>> Did you have the chance to look at the matching QEMU patches ?
> 
> I will this week. I just got back and work has piled up on many fronts.
> 
>> For now, only minor notes remain open, and I would like to send a V1 
>> soon to make progress.
> 
> you should send the QEMU series. Naming is not a blocker and it will
> help assess kernel support and compatibility.
> 

Avihai may send the QEMU series probably next week.

In the meantime you can review its stuff in the github URL that was 
published above.

I plan to send the kernel V1 soon.

Yishai
