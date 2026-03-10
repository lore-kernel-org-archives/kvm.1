Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CE43C044
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136003; cv=fail; b=Ru2UGPLfr6s0xb17vSZ0DDkNstowcpeS5/iSx+MrGMX8xwcvfSyfa8IHfjLKBE2gm5XeYApbLpsuAhvV3y167jSeV+9dVbfe7WkMrbqKPGc6Of8tjhMUPBdk/FNtD31iQA7nFtRg2e2Y+fm932Ssh5sWmSBx00ahOtk+K/5Pz5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136003; c=relaxed/simple;
	bh=089BHo771v047G+WA6C+YVfQmFlG54rIPa0mtUuYvsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ObsT0uSQj8pqv46oFDRZPNwvotIgQqBcK7ikynbFuLgOZFW9LbJc6XytFbC4y9eE3FFq8x5bIHgBH327OgErH6jOO7ro2petR0uNkYlVp2Iu1rS6mXifXOd3RutPtwRUEpmwXiBPQsGaC8by36qnV9r+d21pCRVXuBP/oEA58go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CO17hY4b; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CO17hY4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9OCekOaFQazaXt3d9NH5Aq0CrrWOT94pSug5vZtBg2fcU/FIcjBw6Q0B+crM6tFLExlMW6OO9LcMkSvOyTJ7lGDI1sFYIMUaGjDDUeWdVgXMIqlj/hrWitdbjIwQzNet7x5FHeI5K0seR381kwq7DVyBRgm0O3LB1u5FBic44FEArPp9obmSom/35bUtC+rVI34YikpmNfklQqn/i5b6BrDJp+MJuJvTbEDKMwSFTeDo/ePGeNkw3OcuJt5q01DKv4dzP0nVKBz5UXbHNYMYDwYK9TvOjcK7DY3c2Hy30nAgDeOKXJRImqoB4OAteqc31lwoe/k2m1JlR8uzNK5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ydduuyg0HQg89FDE9XcEPH+vi/E7JsizLz+9LnJ8EI=;
 b=j8RtVsuftz2KJAB/kEbwX0Yc2eX0idno4TQHs1GXXps7GvZVOS2mlyTsVTi6viX/JcC4TCocKdVNtrcbS9VIq9etg63EHiI4+ZHx3ky+oPobQFdDQfYu9N6jD0OMC9k4OPPTto7U+4V16MNEW5yXs0ET/Dw6z+5qHzPG4TLI08MeEk2y9sO8+WerIT6NV1MPrkg194SLXkmWfOQnLwCrtPXxvknW3+fDoTxMkpeC+wldt0sku7kneRMW2WQ4Z/Tn4bV+BxtS1a8i3qHNnYz3EUQppqDWOlRHCXaX9AynD5g4MoG2yzhMUGb06futPG8N/2Bcj9qbQmPxi4cP8C8rTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ydduuyg0HQg89FDE9XcEPH+vi/E7JsizLz+9LnJ8EI=;
 b=CO17hY4b69MagwwdU2L7kCCTU/mBFu0px8VkQ7DS9ek+uDiG/WAJMHShjUt4sHwO0vTLvFRivzwNkVUQqeMhrVWLThPssWDIewa77muS1QBA4nnGeZiwgafKSxfy1Ueh+QZEbWMBRUbJmgbWpJqqdfzSURdAW+HYxeSFnRSdVRRd0/6OmwbhntMxZybC0Pg3LVoUd/AJKDu6KLmjCLYT7Qi7SNvTBxS1Ksf47Usht4j6rdJNBoN/j1JR9eKhU1a6pYX8LN3FPNL0yIeLNybGun2h4briaT3gNduE44nVrOAq6/MLVOu9lWNSihP7gpxsMISxwj1pXLOV1tTLC90FyA==
Received: from CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 09:46:36 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::cd) by CH2PR03CA0024.outlook.office365.com
 (2603:10b6:610:59::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 09:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 09:46:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 02:46:24 -0700
Received: from [10.221.201.248] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 02:46:20 -0700
Message-ID: <4da90bae-c087-4191-9e96-1bd815468a6a@nvidia.com>
Date: Tue, 10 Mar 2026 11:46:18 +0200
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
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <b16fc66f-bea8-4b42-ae68-8e37a6d09bda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: bee79e93-957e-494d-6622-08de7e89ebdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|36860700016|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	FVuARuG95VIUDN9L/5q2sHhxVCAbrUNeCnOIcz6dXnY0lN8R5hU6lKWGwI0U2SAfPA1G2dH1I5WgFLntfCU02EG+y46zjVepkAm/l5+W5ULsK+AqYI99TIi7/kC1EijoGkylkc1nSynIbk3j/cPNOudNd8MffQanVwnoo0FkEb23RzWW5ObrCZRlo9ZJ1ahNE9IRGIRZXPxwjWG5iNZNht/1uAOPnQyahZRdctKF9HiV2meQm7I3Oc4EMzNunkE7/cKPhtWiRXWijUiI7K8ZTt+nRTaMLLAqOyBkYUU12tYCISJYoVTjSj6YS5MvYq5Lb+5v08lEO+MYsxtcYh5KL7G/hqLYKQvSXhOP75Gz7U7CwyHLiTymDAf+LRo13OuUWA/oManIdYUJBwiPFeeZG/+s8VRH0tSCMhZ+x3vyf2LqtyNKSlSHNlKdV5UREG6wV8nKJKZnh/yWOBW0QY8EzZxfzChRrxkDxaWYXWnGUqxY0PD1BxlH/3pYtnW9YsrYeAWEZaFVijseF2QZKY4GILQqRpfhpt036nWmAQT0W7JRYAWC6sDEDCwsE/E0g/N2/GT9qoNgAdNUQgRZtvedKm2/Nzec6MHCw/cPlpMe/EvvdHNlQiLZ/D2ZR9MoK+q07D0u90LKa32qTwTKThB5DMKdclfJJMSUKXp6vimi5WAGYIhtm1FE52AlGUAz7bHiCSWvempGdyC4p3HGoCFYEMnq4tKPgeaSJjgF0v921jFqvKdSNNBn//L6ShMsaTZMf/BHCLYI0RRt2+GyAZgRHA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(36860700016)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iowYEtReSJ0eT7T57XAdda1SFFSOTF2KjOuduQHpd6emc5EW7fbhKSMNu5XUYwhQV98634kKAcf33Xa2KePxMCwiirtwCkY1N3p1/KCEO4RnMYQXPLV9lmfdRl+ZSwtKoEzDyQaWNvYibgSCJLVuY95BK5+OzpcppXmXCD/pM1u2U/svnP+SaeiaNP7WGl93oM6SuPbSxoQbVOc8CY6kJPLIwEbjQmXGbLs4piXYI1Y/UnS5bGcRI2jslT0HkzmVstnItTtdTlm4DhZWddRNRcVZIcKR14RzQPcoCd+aJO0ASHnN9yyrnfe5OQP79uXVLUnOpQKrKaSF20o9nS/L5k69SYAZxGL9i8jGW5zMnlp6ZMyqkfxih5zQCf0/F3gCnafRDYRNEu7QokaWzxICcLEDGGCvCTkkaVI3Wz5CBJVRbRj1XZtLNugA8J9gk9ok
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:46:36.4248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee79e93-957e-494d-6622-08de7e89ebdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835

On 01/03/2026 14:43, Yishai Hadas wrote:
> On 28/02/2026 8:27, Cédric Le Goater wrote:
>> Hello,
>>
>> On 2/27/26 21:23, Alex Williamson wrote:
>>>
>>> +Cédric, +Peter, please see what you think of this approach relative to
>>> QEMU.  The broken uAPI for flags on the PRECOPY_INFO ioctl is
>>> unfortunate, but we need an opt-in for the driver to enable REINIT
>>> reporting anyway.  Thanks,
>>>
>>> Alex
>>
>>
>> I took a quick look. The series would be a little cleaner if
>> vfio_check_precopy_ioctl() came first
> 
> The motivation to introduce that core helper and adapt all the drivers 
> to use it, was to centralize the common code and ensures that output 
> flags are cleared on entry.
> 
> This can be done only after that we have the previous opt-in patch as we 
> would like to keep the V1 behavior for compatibility reasons.
> 
>> and some parts are little ugly
>> (precopy_info_flags_fix). Will take a closer look when back from PTO.
>>
> 
> I'm open for any better name, any specific suggestion ?

How about renaming it to precopy_info_v2, which is closer to the feature 
name ?

> 
>> Is there a QEMU implementation ?
> 
> Yes, please see here [1] the candidate QEMU patches that the kernel 
> series was tested with.
> 
> [1] https://github.com/avihai1122/qemu/commits/vfio_precopy_info_reinit/
> 

Cedric,
Did you have the chance to look at the matching QEMU patches ?

For now, only minor notes remain open, and I would like to send a V1 
soon to make progress.

Thanks,
Yishai

> Thanks,
> Yishai
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>
>>> On Tue, 24 Feb 2026 10:20:13 +0200
>>> Yishai Hadas <yishaih@nvidia.com> wrote:
>>>
>>>> This series introduces support for re-initializing the initial_bytes
>>>> value during the VFIO PRE_COPY migration phase.
>>>>
>>>> Background
>>>> ==========
>>>> As currently defined, initial_bytes is monotonically decreasing and
>>>> precedes dirty_bytes when reading from the saving file descriptor.
>>>> The transition from initial_bytes to dirty_bytes is unidirectional and
>>>> irreversible.
>>>>
>>>> The initial_bytes are considered critical data that is highly
>>>> recommended to be transferred to the target as part of PRE_COPY.
>>>> Without this data, the PRE_COPY phase would be ineffective.
>>>>
>>>> Problem Statement
>>>> =================
>>>> In some cases, a new chunk of critical data may appear during the
>>>> PRE_COPY phase. The current API does not provide a mechanism for the
>>>> driver to report an updated initial_bytes value when this occurs.
>>>>
>>>> Solution
>>>> ========
>>>> For that, we extend the VFIO_MIG_GET_PRECOPY_INFO ioctl with an output
>>>> flag named VFIO_PRECOPY_INFO_REINIT to allow drivers reporting a new
>>>> initial_bytes value during the PRE_COPY phase.
>>>>
>>>> However, Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations
>>>> don't assign info.flags before copy_to_user(), this effectively echoes
>>>> userspace-provided flags back as output, preventing the field from 
>>>> being
>>>> used to report new reliable data from the drivers.
>>>>
>>>> Reliable use of the new VFIO_PRECOPY_INFO_REINIT flag requires 
>>>> userspace
>>>> to explicitly opt in. For that we introduce a new feature named
>>>> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
>>>>
>>>> User should opt-in to the above feature with a SET operation, no 
>>>> data is
>>>> required and any supplied data is ignored.
>>>>
>>>> When the caller opts in:
>>>> - We set info.flags to zero, otherwise we keep v1 behaviour as is for
>>>>    compatibility reasons.
>>>> - The new output flag VFIO_PRECOPY_INFO_REINIT can be used reliably.
>>>> - The VFIO_PRECOPY_INFO_REINIT output flag indicates that new initial
>>>>    data is present on the stream. The initial_bytes value should be
>>>>    re-evaluated relative to the readiness state for transition to
>>>>    STOP_COPY.
>>>>
>>>> The mlx5 VFIO driver is extended to support this case when the
>>>> underlying firmware also supports the REINIT migration state.
>>>>
>>>> As part of this series, a core helper function is introduced to provide
>>>> shared functionality for implementing the VFIO_MIG_GET_PRECOPY_INFO
>>>> ioctl, and all drivers have been updated to use it.
>>>>
>>>> Note:
>>>> We may need to send the net/mlx5 patch to VFIO as a pull request to
>>>> avoid conflicts prior to acceptance.
>>>>
>>>> Yishai
>>>>
>>>> Yishai Hadas (6):
>>>>    vfio: Define uAPI for re-init initial bytes during the PRE_COPY 
>>>> phase
>>>>    vfio: Add support for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
>>>>    vfio: Adapt drivers to use the core helper vfio_check_precopy_ioctl
>>>>    net/mlx5: Add IFC bits for migration state
>>>>    vfio/mlx5: consider inflight SAVE during PRE_COPY
>>>>    vfio/mlx5: Add REINIT support to VFIO_MIG_GET_PRECOPY_INFO
>>>>
>>>>   .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  17 +--
>>>>   drivers/vfio/pci/mlx5/cmd.c                   |  25 +++-
>>>>   drivers/vfio/pci/mlx5/cmd.h                   |   6 +-
>>>>   drivers/vfio/pci/mlx5/main.c                  | 118 ++++++++++ 
>>>> +-------
>>>>   drivers/vfio/pci/qat/main.c                   |  17 +--
>>>>   drivers/vfio/pci/vfio_pci_core.c              |   1 +
>>>>   drivers/vfio/pci/virtio/migrate.c             |  17 +--
>>>>   drivers/vfio/vfio_main.c                      |  20 +++
>>>>   include/linux/mlx5/mlx5_ifc.h                 |  16 ++-
>>>>   include/linux/vfio.h                          |  40 ++++++
>>>>   include/uapi/linux/vfio.h                     |  22 ++++
>>>>   samples/vfio-mdev/mtty.c                      |  16 +--
>>>>   12 files changed, 217 insertions(+), 98 deletions(-)
>>>>
>>>
>>
> 

