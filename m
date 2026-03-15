Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5921189B84
	for <kvm@vger.kernel.org>; Sun, 15 Mar 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584383; cv=fail; b=X6pm7k71rP66z1txC9naSVGW5bK4CnWaJIAnDSWsTkailhnM2m2kix6N+Cmgo82RotHaj4RMnJ0v+1iG5ycbVw8MYApqLeDRAnYrgOVVKjuNbrmIs3nrwMxP+z9bW/v6tW7IPg1l/w7jYC7eEXxCYYKkub1dxTs+apPLNtxMSNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584383; c=relaxed/simple;
	bh=s5/TsskU+XkS7K8ofofQOFz0w/VEhRkQd8sOiy9yEOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9juAjj8+ADf26H/607v54FFDUrdvV3n45blPDbhGSy6SH+ZitzeHnyfOqRKua3U5MS3RTxLuuJ6wL94Adr6bUQk+Iv845i/PlOqvXOACLMgpMTW99UxJ/MCqHeJPKC34uZoMui1QoQDunfuRtsfJolTDaovp8gPRCmLxLOKRA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ncFV1nNW; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ncFV1nNW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjPEedz6314dxyP9cPJkYoVtmE2tw0EQlX0G+UD6NXkfZXcfRGV1VqD0mbjhZkzBUMuhMfH0EWuK5WGekjcr90YiCYwoDC0uMOUI+ecu8YyC6fF8uNPaKFIuOXxvXVzVWwpo1iOuKaQe8SYz/2yZopi5o5ypk+rgy5ESWGBdVB52QBO4Wnt7p0gLblYmboEPWiISnulo4jwh00hIS861uNJEXFCDuuwLp8rJYBYWKvgV9Vy/NR11H6Qp35DdwKFXZvEUYRTz5xZBVt7DID9yaEAr5dahVW54anD+jJF6A2rET4vD4otyFpjiKcEztnaLlfrHuHe0Pjryb+WiZiE+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRWeLZM0xTfv2L3rQpFnEm6gA0Dhp6vjW7gwV7prWhc=;
 b=nIIBu7ue46XhdAukXBPA9J2WcWBDJeniUB14X+GBHyC2hOanhr49rl0xdvnA7baFqUZii9IzY1/kQT52R8Qe9sg5sSGu0yWof183pOOsVhORaNnVl97I5uw54/V2w+TlBY0PhSTbc5s3CMeBQjP61U+UM8AGnrOI4CEBXJcIpaazB5siRy1O3jnC76FC9ZFRAuGp3cxxjwFA4+t2XK+SfPJPzG45mHbgu21YAKIBSHjsONq+9SlVBHJMsBPf3Ym0jNsjOoHHCr7AbMP0zIsEjaIJUBPD+ltpnep7ScuKpTGcyj/zKJ5LRq6BAEyNwKTj46F2m6Z0ruNBIk0ts7Yiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRWeLZM0xTfv2L3rQpFnEm6gA0Dhp6vjW7gwV7prWhc=;
 b=ncFV1nNWS7w8RCD66SKtXnnAx1aHUMOIdayOlbyhvIOIKnSDbte1mfbDpq+pg0ri7YTfLMSeqsW86u1PN4uPKCSbpqb+lAk8GpyjlDGpYVF5dg0ULuQ4blA6pfF9BMwoa5KrKchvrXnOtiKo8yYY9yvzgg+bkdLy2WL4kxVNl0IzARMpAyo6gqPfX02GE1/5oTiINYudpAJdXgKHOjXpiXayd9DbgG+111uAxoXAMIWZpwI8B91gp6iEmR+z5D1ExGFdfwKHrfWkHA7ltGyJuwVMsziXiansyFYtngGdRUB34kyhQY9I8B35n6BPCr8NcTUY0nPAMadKPcD6cH4Bxw==
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Sun, 15 Mar
 2026 14:19:36 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::c2) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Sun,
 15 Mar 2026 14:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 14:19:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Mar
 2026 07:19:24 -0700
Received: from [10.221.201.248] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Mar
 2026 07:19:20 -0700
Message-ID: <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com>
Date: Sun, 15 Mar 2026 16:19:18 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
To: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>
CC: <jgg@nvidia.com>, <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>,
	<avihaih@nvidia.com>, <clg@redhat.com>, <liulongfang@huawei.com>,
	<giovanni.cabiddu@intel.com>, <kwankhede@nvidia.com>
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com> <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org> <abMfLQPzVFK388q_@x1.local>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <abMfLQPzVFK388q_@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3d2747-7b1c-48d5-a02f-08de829de2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n7oZFzTBBjvFSsAq9XWdaKNmHMd9VNuCvRharD90mD4+N/YZWadfsAvTKpJQakf2MfZ8Hskt3cXhrWGQ2ZUbWIcDIsMrPgMRyQuAIjy5H3ad7K0iOhuO+FbkCTVNY4qb7+mSa/FuyokDbSM1JM2hn0HxeKhhPOaBBWlbszSp3dUAosx4lui51mskl1qhUhCHuJ3oqC9SwnlxMT0uoJ0x3PMZMIT393uWWULuZ455B26JQ9T8WyK/jQ5cOKqyCl3t0KOtsFTeE/elpUB+5yrJE8NNtiP1gKraStdtwHeKaLHDKtrOOrztOvCXF7Z4Zs0koH06cznIA7CWb6fLbdu2/S0TkRs3BsUHCQryIB3Pzd+JSE2nEayi+ZOsOWwD/g955YCDkgTu2h2fkQZHe90lwQcZcBajZ3T9xm6Fj35HyRcWBJOMV7omhnI3GQGZ1syuJ7lLUDLTRTUBTSUD7vxlB3ohxRW0rVWlocIQRYy5VsgjloEVhsWMcHnlHPr5zvolzAbIC1HW2KONURGlk+8rDd3KVXG4E8YTKWC2Cy6lfaWr53j6L3icOVrKnVWaO1YjYX9MpZ/1HTDEXBUvCqlE3/HBVnHDPqthp7ZoMqZ/xWAb57DehAJN3j/m8Z3pXBr+Nn3rN08G7kl+bMHen8KHXcEz/VwJ5lqY8+aI0UNOW+MqMkWQY0y8Rj64sCugMLmDXlH+zg+tBZdpWwnZK3ZFdZhDuWDw7eSwjvb+T5iJwai82WOinQRJlndc3yi29FH90RIAVeJuQXfjKbUtAwziZg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0WNgYGX9vZR1G8zZ6oQDK8ODYBgpqIfaN+w63QxmRuUTgwB/9ZIFaYuROikQ8RtckCMiynx3Gn9wn1+FCQ64IH22zUHVZPxRV4ouWDjd0lKhXVnMiMKaPln71Yf38Q0GWRXhvH2xl6hkM0CmKMw9KJGf+E4axO3QUpZkojCelUY0CBPGSyEPFOCgVCZg2UdyeBL8RAGRIzdDc3Q6F+tAiECPD0xU8bcR70xvZAbkf23+C447Lnj6R3R+DC8K6uWT/UIwieW/UDaMH+202v9X6y1dGFnBP819AUOnuwg55+pNfQoLTKlz34Ez3fzxq/Komb7WC736pqGeXYKhbCzp6EC1r1OqG6ENdAA1Pzlj3okhl0HQ5L9YpycJMDtTA8Gqv6jM4iWciV4kz8iu0ky/pvSOx70kBaRZIBYEoR0BaGJiJpxgC5Qb013Tenn2rXy+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 14:19:35.7094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3d2747-7b1c-48d5-a02f-08de829de2bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

On 12/03/2026 22:16, Peter Xu wrote:
> On Thu, Mar 12, 2026 at 01:08:17PM -0600, Alex Williamson wrote:
>> Hey Peter,
> 
> Hey, Alex,
> 
>>
>> On Thu, 12 Mar 2026 13:37:04 -0400
>> Peter Xu <peterx@redhat.com> wrote:
>>
>>> Hi, Yishai,
>>>
>>> Please feel free to treat my comments as pure questions only.
>>>
>>> On Tue, Mar 10, 2026 at 06:40:06PM +0200, Yishai Hadas wrote:
>>>> When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
>>>> driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
>>>> to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
>>>> value.
>>>
>>> Does it also mean that VFIO_PRECOPY_INFO_REINIT is almost only a hint that
>>> can be deduced by the userspace too, if it remembers the last time fetch of
>>> initial_bytes?
>>
>> I'll try to answer some of these.  PRECOPY_INFO is already just a hint.
>> We essentially define initial_bytes as the "please copy this before
>> migration to avoid high latency setup" and dirty_bytes is "I also have
>> this much dirty state I could give to you now".  We've defined
>> initial_bytes as monotonically decreasing, so a user could deduce that
>> they've passed the intended high latency setup threshold, while
>> dirty_bytes is purely volatile.
> 
> I see..  That might be another problem though to switchover decisions.
> 
> Currently, QEMU relies on dirty reporting to decide when to switchover.
> 
> What it does is asking all the modules for how many dirty data left, then
> src QEMU do a sum, divide that sum with the estimated bandwidth to guess
> the downtime.
> 
> When the estimated downtime is small enough so as to satisfy the user
> specified downtime, QEMU src will switchover.  This didn't take
> switchover_ack for VFIO into account, but it's a separate concept.
> 
> Above was based on the fact that the reported values are "total data", not
> "what you can collect"..
> 
> Is there possible way to provide a total amount?  It can even be a maximum
> total amount just to cap the downtime. 

The total amount is already reported today via the 
VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl and QEMU accounts that in the 
switchover decision.

  If with the current reporting
> definition, VM is destined to have unpredictable live migration downtime
> when relevant VFIO devices are involved.
> 
> The larger the diff between the current reported dirty value v.s. "total
> data", the larger the downtime mistake can happen.
> 
>>
>> The trouble comes, for example, if the device has undergone a
>> reconfiguration during migration, which may effectively negate the
>> initial_bytes and switchover-ack.
> 
> Ah so it's about that, thanks.  IMHO it might be great if Yishai could
> mention the source of growing initial_bytes somewhere in the commit log, or
> even when documenting the new feature bit.

Sure, we can add as part of V2 the below chunk when documenting the new 
feature.

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 90e51e84539d..bb4a2df0550d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1268,6 +1268,8 @@ enum vfio_device_mig_state {
   * value and decrease as migration data is read from the device.
   * The presence of the VFIO_PRECOPY_INFO_REINIT output flag indicates
   * that new initial data is present on the stream.
+ * The new initial data may result, for example, from device 
reconfiguration
+ * during migration that requires additional initialization data.


> 
>>
>> A user deducing they've sent enough device data to cover initial_bytes
>> is essentially what we have now because our protocol doesn't allow the
>> driver to reset initial_bytes.  The driver may choose to send that
>> reconfiguration information in dirty_bytes bytes, but we don't
>> currently have any way to indicate to the user that data remaining
>> there is of higher importance for startup on the target than any other
>> dirtying of device state.
>>
>> Hopefully the user/VMM is already polling the interface for dirty
>> bytes, where with the opt-in for the protocol change here, allows the
>> driver to split out the priority bytes versus the background dirtying.
>>   
>>> It definitely sounds a bit weird when some initial_* data can actually
>>> change, because it's not "initial_" anymore.
>>
>> It's just a priority scheme.  In the case I've outlined above it might
>> be more aptly named setup_bytes or critical_bytes as you've used, but
>> another driver might just use it for detecting migration compatibility.
>> Naming is hard.
> 
> Yep. :) initial_bytes is still fine at least to me.  I wonder if we could
> still update the document of this field, then it'll be good enough.

As Alex mentioned, initial_bytes can be used for various purposes.

So, I would keep the existing description in the uAPI.

In the context of the new feature, the uAPI commit message refers to 
initial_bytes as 'critical data', to explain the motivation behind the 
feature. Together with the extra chunk in the uAPI suggested above, I 
believe this clarifies the intended usage.

Makes sense ?

> 
>>   
>>> Another question is, if initial_bytes reached zero, could it be boosted
>>> again to be non-zero?
>>
>> Under the new protocol, yes, and the REINIT flag would be set indicate
>> it had been reset.  Under the old protocol, no.
>>   
>>> I don't see what stops it from happening, if the "we get some fresh new
>>> critical data" seem to be able to happen anytime..  but if so, I wonder if
>>> it's a problem to QEMU: when initial_bytes reported to 0 at least _once_ it
>>> means it's possible src QEMU decides to switchover.  Then looks like it
>>> beats the purpose of "don't switchover until we flush the critical data"
>>> whole idea.
>>
>> The definition of the protocol in the header stop it from happening.
>> We can't know that there isn't some userspace that follows the
>> deduction protocol rather than polling.  We don't know there isn't some
>> userspace that segfaults if initial_bytes doesn't follow the published
>> protocol.  Therefore opt-in where we have a mechanism to expose a new
>> initial_bytes session without it becoming a purely volatile value.
> 
> Here, IMHO the problem is QEMU still needs to know when a switchover can
> happen.
> 
> After a new QEMU probing this new driver feature bit and enable it, now
> initial_bytes can be incremented when REINIT flag set.  This is fine on its
> own.  But then, src QEMU still needs to decide when it can switch over.
> 
> It seems to me the only way to do it (with/without the new feature bit
> enabled), is to relying on initial_bytes being zero.  When it's zero, it
> means all possible "critical data" has been moved, then src QEMU can
> kickoff that "switchover" message.
> 
> After that, IIUC we need to be prepared to trigger switchover anytime.
> 
> With the new REINIT, it means we can still observe REINIT event after src
> QEMU making that decision.  Would that be a problem?
> 
> Nowadays, when looking at vfio code, what happens is src QEMU after seeing
> initial_bytes==0 send one VFIO_MIG_FLAG_DEV_INIT_DATA_SENT to dest QEMU,
> later dst QEMU will ack that by sending back MIG_RP_MSG_SWITCHOVER_ACK.
> Then switchover can happen anytime by the downtime calculation above.
> 
> Maybe there should be solution in the userspace to fix it, but we'll need
> to figure it out.  Likely, we need one way or another to revoke the
> switchover message, so ultimately we need to stop VM, query the last time,
> seeing initial_bytes==0, then it can proceed with switchover.  If it sees
> initial_bytes nonzero again, it will need to restart the VM and revoke the
> previous message somehow.

The counterpart QEMU series that we pointed to, handles that in similar 
way to what you described.

The switchover-ack mechanism is modified to be revoke-able and a final 
query to check initial_bytes == 0 is added after vCPUs are stopped.

Thanks,
Yishai

> 
>>   
>>> Is there a way the HW can report and confidentally say no further critical
>>> data will be generated?
>>
>> So long as there's a guest userspace running that can reconfigure the
>> device, no.  But if you stop the vCPUs and test PRECOPY_INFO, it should
>> be reliable.
> 
> This is definitely an important piece of info.  I recall Zhiyi used to tell
> me there's no way to really stop a VFIO device from generating dirty data.
> Happy to know it seems there seems to still be a way.  And now I suspect
> what Zhiyi observed was exactly seeing dirty_bytes growing even after VM
> stopped.  If that counter means "how much you can read" it all makes more
> sense (even though it may suffer from the issue I mentioned above).
> 
>>
>>>> The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
>>>> caller that new initial data is available in the migration stream.
>>>>
>>>> If the firmware reports a new initial-data chunk, any previously dirty
>>>> bytes in memory are treated as initial bytes, since the caller must read
>>>> both sets before reaching the end of the initial-data region.
>>>
>>> This is unfortunate.  I believe it's a limtation because of the current
>>> single fd streaming protocol, so HW can only append things because it's
>>> kind of a pipeline.
>>>
>>> One thing to mention is, I recall VFIO migration suffers from a major
>>> bottleneck on read() of the VFIO FD, it means this streaming whole design
>>> is also causing other perf issues.
>>>
>>> Have you or anyone thought about making it not a stream anymore?  Take
>>> example of RAM blocks: it is pagesize accessible, with that we can do a lot
>>> more, e.g. we don't need to streamline pages, we can send pages in whatever
>>> order.  Meanwhile, we can send pages concurrently because they're not
>>> streamlined too.
>>>
>>> I wonder if VFIO FDs can provide something like that too, as a start it
>>> doesn't need to be as fine granule, maybe at least instead of using one
>>> stream it can provide two streams, one for initial_bytes (or, I really
>>> think this should be called "critical data" or something similar, if it
>>> represents that rather than "some initial states", not anymore), another
>>> one for dirty.  Then at least when you attach new critical data you don't
>>> need to flush dirty queue too.
>>>
>>> If to extend it a bit more, then we can also make e.g. dirty queue to be
>>> multiple FDs, so that userspace can read() in multiple threads, speeding up
>>> the switchover phase.
>>>
>>> I had a vague memory that there's sometimes kernel big locks to block it,
>>> but from interfacing POV it sounds always better to avoid using one fd to
>>> stream everything.
>>
>> I'll leave it to others to brainstorm improvements, but I'll note that
>> flushing dirty_bytes is a driver policy, another driver could consider
>> unread dirty bytes as invalidated by new initial_bytes and reset
>> counters.
>>
>> It's not clear to me that there's generic algorithm to use for handling
>> device state as addressable blocks rather than serialized into a data
>> stream.  Multiple streams of different priorities seems feasible, but
>> now we're talking about a v3 migration protocol.  Thanks,
> 
> Yep, definitely not a request to invent v3 yet, but just to brainstorm it.
> It doesn't need to be all-things addressable, index-able (e.g. via >1
> objects) would be also nice even through one fd, then it can also be
> threadified somehow.
> 
> It seems the HW designer needs to understand how hypervisor works on
> collecting these HW data, so it does look like a hard problem when it's all
> across the stack from silicon layer..
> 
> I just had a feeling that v3 (or more) will come at some point when we want
> to finally resolve the VFIO downtime problems..
> 
> Thanks,
> 

