Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB43A3E78
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741523; cv=fail; b=NKQtg67LNrjKPPEikdsZQSobGSVYJsea7i/L66CHerDDlIwAFBv9Me4sfIAT2SPKLgZ2VbB3KwxtQEcf9upnqTtpaBVfiM2xX/r7ex+D9BkfUnT3AC5MV8IZtfwn2YZSLnAkoEBV4rma/t+sbLrvrr7yvK2QpONna3UtY++cmHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741523; c=relaxed/simple;
	bh=YK72wCwn8dByPhg9rk/sVyRWBBtmQBfgA6RIG/RANaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gnkBD+z/fAjA0+9O/4JJZ+AJOyBjrVXJLMkBiqs68nflBHGRWDBuD20ooqR0cwCcDvGr3dYF3P+Xv7BO1WXnNFgPPTm8i7h8SRliwPmRZcTNfXlWEIORXW87uBVNiC0VaK+3GuSlvUxTSHDqGWnLErrGdfeJxaoPZptFpoy8Zd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VnTkKQFa; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VnTkKQFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNsOhPxssZYT/WxnwmlmOQMm2xQa2KZnYwLZkIzMpvELiqbH8RpS4GW3elmQgkhYoo9CNTASMN1k52vwK5KqX4zW8BOPjJeLUTG2/GPgPutBloHfKXIgRo+kECUJbtv+Lkma2GCK2XnM+S2IiaGAxralAS9h5ptMj/wV9ebLXUQrFZ710mdcIM75FPc9jdzv5fHcZdBisPcaLOh+VGMHwGHr0rr0ws4YsJWRnNuopAzRaDMZlFMFLqyrJ3c0CS2MiV0u0MfWFxCJTtwAM9GfG8JSLXfWAglHN8ORz0xNtQwSp74H/SWAdTl71HIwk7GNRph9Y6pr/dcU7zp1tVSRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGLJXnOjDckrx9LjuVJe2jt6G90gQHTMUn4njxMcMpc=;
 b=vTMr62xDXNeV5Tu7iSPEESBHs/lS1Sn6CLaPJF/s8l1SwQFilY5vL8zlfBnt5mrXWpBTDdksBMV6NFi4i8JI6a/cTaOija+cKk8fZfCQkBocWoDThwXw+W96wVhUdyZ+rkbKHnTt35HrtyBqw1SQJ+AyqFVnNMrgi7xvtoGwTfP1a55m9bmLG13eYBClT1sVYzkcRN8EiMnMNFd2WX3gc0say9JQYVdqjHnlD4Xt2nbc1XDVfKuTx3txrqH2r80yvqjZK0/HwChmToOQt2Iw35J1gM2qFGpgWbizt/8xoKfFN+vvqruAYGdKY5gSdG8fFW/9+OV8E3hYZY/GXyymFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGLJXnOjDckrx9LjuVJe2jt6G90gQHTMUn4njxMcMpc=;
 b=VnTkKQFa7X98BsHWKFlb+KKtlFrLi5DJmxb6NPPcLj9t78iK/7WNyhmLAo3A/KUfHOUwgInu/664xR2mQroEF7Jw99E6ZZeSVV7KUg+r1WQRAVSOJXUyMTS4aIRSj0XYoI+pmZE6bBAU3PvipuGLCCh31x0JGsI2PjqeDuPC7Ljj+1cp843tfo1o8hFQIHMtcg40t8IL9+X5GnRoFesfb56ybrWdZt/7sPK8zB7sEneOZxXy0B593Q0v71z9y/mR7RM/j6OA1xZixNf0XSRAlrvv1+sOgFbsGDGFahIPEcwphl6ZOyFpWIodDmreuCeWzEhQKUdHoVsBdDmF0TO3yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 09:58:34 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 09:58:34 +0000
Message-ID: <accc2aeb-6ae1-4aec-867c-c9927e98f903@nvidia.com>
Date: Tue, 17 Mar 2026 11:58:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
To: Peter Xu <peterx@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, jgg@nvidia.com, kvm@vger.kernel.org,
 kevin.tian@intel.com, joao.m.martins@oracle.com, leonro@nvidia.com,
 maorg@nvidia.com, clg@redhat.com, liulongfang@huawei.com,
 giovanni.cabiddu@intel.com, kwankhede@nvidia.com
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com> <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org> <abMfLQPzVFK388q_@x1.local>
 <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com> <abhZBIe-vR-GX3TT@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <abhZBIe-vR-GX3TT@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8019516f-cd87-4b37-983c-08de840bc09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	LJhsmRFBkIIlWCdmrc/oukpMbJfnLZ8dtTOJTVilE3G743gFAF0gB1metYcyOwmAVr8UwdFsfucBIvEqRg71PLzC0ZkM54Ng/S/nE1hcttvprQy/Y4Y1JNLQl+TSQfrEtKWRQwXC4KFgMic/BRvVPwBrcFYqr/asoIMHfa4wzhrJf58cldn+cHVnr1f1V5j/DHUkKruLcpFmMbqMLxN5RYRznUDnRblwlNaM+uDj4iuhKJq8p98zrlFAdyIdUo2zNjR/8ikoEiOcu12NkGeFRgkf0Jfngh1LbSzphAJiYH58BGbPyRg/byB1GWpmtblYGrt8vedXK6E5JT5JGRrJ8sYJNI1HcXblbn8zigoZ0eA5ewOMaySEBKr2OW0iuOBk6jZcWD9JxbaZxAchLvpCzadkxZpiXIGQM/qgpvcxrezO6gRmkm42gNUzFEDbh1v0xC+p1wFnMkqFVtD2NlNHMvd868HJ2qguprLPi76vDHAjl1Zp1Io1sw8D3dckg1B6wITHkiCItqB7SFP1EBYgupjfqDevftzk+ne/y69bWQsMujWE2hWeK15PQGG8IAJ3uq+++yHhxTnOSAp7sXkIotJ4kbgt5KzZerkB1t2eMEppq0DvN4JXli9++B4Co0/gwul/BdoxH1u1LRBGgRwD0n2ObbrUsfBdcm8RsocnXyObDM7Ryur0xvjpjuiOoX/qs0XEve7km4Q2Ijk/yQN8Iq680hOeNZKfuPhJPIVqqhU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVdHVGcrRzB0OFJPbm5WV0FzYkRncDloY0tIZnhTUThCaHlQN01jQ1VVWjBw?=
 =?utf-8?B?dlhCdHd3NlBmK1hVck9lRWw5bjRNc1NHN2R4QmFnWk5xTDdIUjZTd1NPWFFj?=
 =?utf-8?B?OVRiUFgrMmFzWkxmU1BaUDVVRngrY2VOREtNY2NOU1Z6SGg1Yk5wazdzbHcz?=
 =?utf-8?B?endIaFVjMGk3aWkrV0diWmppU09ITDFMOVRHd1ppZnhWY1hCcTFVSFRyVkUv?=
 =?utf-8?B?Yk5LZldZeWF6R2ljaldaSkdRY0xOYmhLY1JPYVRHRkJYbEw0cXo3UnNTeVNW?=
 =?utf-8?B?aUR4SWY3VCt5ZW0zYnlMdHZqVS9ncGZtbFpoL3hWU3hBdlpKUDJDSEhkSVRR?=
 =?utf-8?B?N1ZEM3MyaVNLZHJ4WlBEcUZWbjBCbmdsNVpjeGM1RGk3a1BUWUJFY0FtT2JB?=
 =?utf-8?B?YmJGN3Y1SGQ0S1lPTXJrWFlyd21WMGZYMmJHY2ZSUjhUd2VOcDJ4Z3paaFZ4?=
 =?utf-8?B?Mjk1Y05hVVJWRTBoQ2lQeUU3MktVNmQ0czVPZTNkdk8rOFhpTTh5NjB0UGxp?=
 =?utf-8?B?bHRLa1dBdld3NGYvRG9YcFcwM2RWYmt4Yk5zV1B4cFFRT2hTNVZOZUZYTlFj?=
 =?utf-8?B?UDdZTnlFakZmZHlMcTJuNm5LN2hrQzhnY3lzNVI5dy9oNVRrUSthU2JQbDBC?=
 =?utf-8?B?ZlZ6cjF1c0RRbkVtRklsS0RxSUF1aW8wbDFBQld6TVVwRWpCNHRPVU5jNzNR?=
 =?utf-8?B?VGpHaWRCbXVyR3dabWZGdU0xVmZNQUxUSHFwdlhacjNVOU5STjZvQVhTOU1E?=
 =?utf-8?B?eVRRUzBIUnVNaVk3VkpDNnhCOWM5cVl3THk3R2VMZ0M3cFp6U1JhYVY1UDZk?=
 =?utf-8?B?YTdMUnhZTGFyRFJHQ1ZFc1lJVlpKR0pISjA0RGNmWG5pbWlJSzJ6SVRWZnFL?=
 =?utf-8?B?U2tReEl0SU02WVdLZVJMKzVqcmxTY21YZU9MSTE5QUVTemJxR09Ib2VDdkxo?=
 =?utf-8?B?Z25JM0FwVmlpUkRoeFEyelczdEplNGtVRHFEWDVOaHZQNUtJdGZ1Q05zTXcy?=
 =?utf-8?B?R0pJRXE1QTMvbytkN0NmVGxUN2xRUUs5NExMaWFZM1VXZE1jK0hBWFhjZmtQ?=
 =?utf-8?B?U3hPWmYxMFRvdFp3dEttaTBMT1BuTk9EVlFIRi9DZkgwV2pjd25nNFlNTjVD?=
 =?utf-8?B?NnNpM3k1SVZRYndhMFIyZ3Y5ejNPWmIvMVExYW5xeXQ3emtqdDZHRG1Fdlpi?=
 =?utf-8?B?QTljU0VBa3pQWjFQQWNYeTZEVFRaaHR4bkZBaG5FZGhCbHZnRlg0RjQxeGUy?=
 =?utf-8?B?WkJZL1lpVlhuZDVCaUs1VUF6NE5YRFpvY1AwcXdPbGNTK1hGYmd0UTJvMzhm?=
 =?utf-8?B?azlYbmZ3UVhyYjhrc3RqdGxYTjE0TGQvSlFMclJtc2VBRTJCaGZKaXREMkxs?=
 =?utf-8?B?RkpwTjViKzgveW0wZENRTUdpcktlVVNxTEtGemVkdDR3bWtWQkRXcGV1SzUx?=
 =?utf-8?B?dGowRkVoSEpsODB4eDFtSURMVFVsaXowZ05zMnY5UEptMTNQY01iWlNTQWdT?=
 =?utf-8?B?WjhEL2ZHMUhMV1V0dThvUzFVdDBqNitvY2d2Q2c0bkVtanJkTnFJSEUydEwy?=
 =?utf-8?B?N3hQdFJsOHJndXdqRzRtSU9LZW1TYy9CQ2JydFlWa2tZM3VwVkJDdDJPeEVk?=
 =?utf-8?B?M1hNdlRXSENFVG9heHRtbEZUbkl3STJ0U2VJaDFkZStPQUtTaE9Pb0tIY0Ry?=
 =?utf-8?B?TVBHVVFpU3JSYldDMjVNVlYwTGlvbkpIbjhUQ1R0cFBsNzVNaUc1OXZqb3Zt?=
 =?utf-8?B?d1pta0ZiUW5yVVNQSXYrVEd2YWpwaDl4SjUxTndpdWwrTnNINkxVd3V1cnA3?=
 =?utf-8?B?L1pieVF6dHU4b3ZQcmpqKzhneHAzdEhmUmprUkx2d0VXVDYvMm9ObXRUb0Mv?=
 =?utf-8?B?SXZ2a1hCYjRYREpwbXVZS3M2MzM3Zlp3UFZXdi9zWXg0dk0zR0o0YkpWOVBK?=
 =?utf-8?B?enMrTXNLVGpFY1pHQXRBcWR3cGU1aXliaVJDYnR5TXoyVDJnWlhQaUNFLzJL?=
 =?utf-8?B?Zzl6eHpLK2VMYTk4UVd4eFVsL1d3OWV3SmtDclQzQXB6cVNMT0VwN0pla2NL?=
 =?utf-8?B?SHZYREdaMS9UaXBWRGpYU3hVUFZ3STF2bjJ4UC9tQ0w2SFJ2cHFnVnoySURx?=
 =?utf-8?B?QUYzYmErb3BTN3lFUktnbzJzWS8rNWNyQU5oVWxRZW05dHdtaFMxYkxNV3hJ?=
 =?utf-8?B?ajFhNm5kMzRiZ09xY3pOVWp3aURjUW1UTG13SDQ0VlpqTE5jQWhGT3FlTTFn?=
 =?utf-8?B?ZVdQa1RrNmovbzc5U054anJvd1F3UWtpYmRjaTU1UE5MaXpJaGxNSVdDbHgr?=
 =?utf-8?B?bXRFUmRVT1VXTFNySEtzSGNzUGJ0Y0pEa2F2TEx3YjZKaFBvWFVpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8019516f-cd87-4b37-983c-08de840bc09a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:58:34.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyOpMcE6qLGhLwiQL4v46i+SWJqI3ygejFoOX999iuFAjpGLPNv1ZxPNkgy/ad3x3tdPtHZXjMWWJPDf1+j0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

Hi Peter,

On 3/16/2026 9:24 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, Mar 15, 2026 at 04:19:18PM +0200, Yishai Hadas wrote:
>> On 12/03/2026 22:16, Peter Xu wrote:
>>> On Thu, Mar 12, 2026 at 01:08:17PM -0600, Alex Williamson wrote:
>>>> Hey Peter,
>>> Hey, Alex,
>>>
>>>> On Thu, 12 Mar 2026 13:37:04 -0400
>>>> Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>>> Hi, Yishai,
>>>>>
>>>>> Please feel free to treat my comments as pure questions only.
>>>>>
>>>>> On Tue, Mar 10, 2026 at 06:40:06PM +0200, Yishai Hadas wrote:
>>>>>> When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
>>>>>> driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
>>>>>> to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
>>>>>> value.
>>>>> Does it also mean that VFIO_PRECOPY_INFO_REINIT is almost only a hint that
>>>>> can be deduced by the userspace too, if it remembers the last time fetch of
>>>>> initial_bytes?
>>>> I'll try to answer some of these.  PRECOPY_INFO is already just a hint.
>>>> We essentially define initial_bytes as the "please copy this before
>>>> migration to avoid high latency setup" and dirty_bytes is "I also have
>>>> this much dirty state I could give to you now".  We've defined
>>>> initial_bytes as monotonically decreasing, so a user could deduce that
>>>> they've passed the intended high latency setup threshold, while
>>>> dirty_bytes is purely volatile.
>>> I see..  That might be another problem though to switchover decisions.
>>>
>>> Currently, QEMU relies on dirty reporting to decide when to switchover.
>>>
>>> What it does is asking all the modules for how many dirty data left, then
>>> src QEMU do a sum, divide that sum with the estimated bandwidth to guess
>>> the downtime.
>>>
>>> When the estimated downtime is small enough so as to satisfy the user
>>> specified downtime, QEMU src will switchover.  This didn't take
>>> switchover_ack for VFIO into account, but it's a separate concept.
>>>
>>> Above was based on the fact that the reported values are "total data", not
>>> "what you can collect"..
>>>
>>> Is there possible way to provide a total amount?  It can even be a maximum
>>> total amount just to cap the downtime.
>> The total amount is already reported today via the
>> VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl and QEMU accounts that in the
>> switchover decision.
> Ok, I somehow got the impression that initial+dirty should be the total
> previously.  It's likely because I was referring to this piece of code in
> QEMU:
>
> static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
>                                          uint64_t *can_postcopy)
> {
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>
>      if (!vfio_device_state_is_precopy(vbasedev)) {
>          return;
>      }
>
>      *must_precopy +=
>          migration->precopy_init_size + migration->precopy_dirty_size;
>
>      trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
>                                        *can_postcopy,
>                                        migration->precopy_init_size,
>                                        migration->precopy_dirty_size);
> }
>
> After you said so, I found indeed the exact() version is fetching the
> stop-size:
>
> static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>                                       uint64_t *can_postcopy)
> {
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>      uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>
>      /*
>       * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
>       * reported so downtime limit won't be violated.
>       */
>      vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>      *must_precopy += stop_copy_size;
>
>      if (vfio_device_state_is_precopy(vbasedev)) {
>          vfio_query_precopy_size(migration);
>      }
>
>      trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
>                                     stop_copy_size, migration->precopy_init_size,
>                                     migration->precopy_dirty_size);
> }
>
> Do you know why the estimate version doesn't report a cached stop_size
> instead?
>
> Reporting different things will also confuse QEMU in its estimate() and
> exact() hooks.  They should report the same thing except that the
> estimate() can use a fast path for cached value.

Yes, this is because the VFIO device stop_copy_size may hold data that 
can be transferred only when the device is stopped, i.e., during 
switchover (as opposed to RAM which is fully precopy-able).
Reporting it as part of estimate() didn't seem right, as precopy 
iterations will not reduce it -- if it's big enough (above the 
threshold), it may block future exact() calls as we can't migrate this 
data during pre-copy and reach below threshold again.

>
>>   If with the current reporting
>>> definition, VM is destined to have unpredictable live migration downtime
>>> when relevant VFIO devices are involved.
>>>
>>> The larger the diff between the current reported dirty value v.s. "total
>>> data", the larger the downtime mistake can happen.
>>>
>>>> The trouble comes, for example, if the device has undergone a
>>>> reconfiguration during migration, which may effectively negate the
>>>> initial_bytes and switchover-ack.
>>> Ah so it's about that, thanks.  IMHO it might be great if Yishai could
>>> mention the source of growing initial_bytes somewhere in the commit log, or
>>> even when documenting the new feature bit.
>> Sure, we can add as part of V2 the below chunk when documenting the new
>> feature.
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 90e51e84539d..bb4a2df0550d 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1268,6 +1268,8 @@ enum vfio_device_mig_state {
>>    * value and decrease as migration data is read from the device.
>>    * The presence of the VFIO_PRECOPY_INFO_REINIT output flag indicates
>>    * that new initial data is present on the stream.
>> + * The new initial data may result, for example, from device
>> reconfiguration
>> + * during migration that requires additional initialization data.
> This is helpful at least to me, thanks.
>
>>
>>>> A user deducing they've sent enough device data to cover initial_bytes
>>>> is essentially what we have now because our protocol doesn't allow the
>>>> driver to reset initial_bytes.  The driver may choose to send that
>>>> reconfiguration information in dirty_bytes bytes, but we don't
>>>> currently have any way to indicate to the user that data remaining
>>>> there is of higher importance for startup on the target than any other
>>>> dirtying of device state.
>>>>
>>>> Hopefully the user/VMM is already polling the interface for dirty
>>>> bytes, where with the opt-in for the protocol change here, allows the
>>>> driver to split out the priority bytes versus the background dirtying.
>>>>> It definitely sounds a bit weird when some initial_* data can actually
>>>>> change, because it's not "initial_" anymore.
>>>> It's just a priority scheme.  In the case I've outlined above it might
>>>> be more aptly named setup_bytes or critical_bytes as you've used, but
>>>> another driver might just use it for detecting migration compatibility.
>>>> Naming is hard.
>>> Yep. :) initial_bytes is still fine at least to me.  I wonder if we could
>>> still update the document of this field, then it'll be good enough.
>> As Alex mentioned, initial_bytes can be used for various purposes.
>>
>> So, I would keep the existing description in the uAPI.
>>
>> In the context of the new feature, the uAPI commit message refers to
>> initial_bytes as 'critical data', to explain the motivation behind the
>> feature. Together with the extra chunk in the uAPI suggested above, I
>> believe this clarifies the intended usage.
>>
>> Makes sense ?
> As long as Alex is happy with it, I'm OK either way.
>
>>>>> Another question is, if initial_bytes reached zero, could it be boosted
>>>>> again to be non-zero?
>>>> Under the new protocol, yes, and the REINIT flag would be set indicate
>>>> it had been reset.  Under the old protocol, no.
>>>>> I don't see what stops it from happening, if the "we get some fresh new
>>>>> critical data" seem to be able to happen anytime..  but if so, I wonder if
>>>>> it's a problem to QEMU: when initial_bytes reported to 0 at least _once_ it
>>>>> means it's possible src QEMU decides to switchover.  Then looks like it
>>>>> beats the purpose of "don't switchover until we flush the critical data"
>>>>> whole idea.
>>>> The definition of the protocol in the header stop it from happening.
>>>> We can't know that there isn't some userspace that follows the
>>>> deduction protocol rather than polling.  We don't know there isn't some
>>>> userspace that segfaults if initial_bytes doesn't follow the published
>>>> protocol.  Therefore opt-in where we have a mechanism to expose a new
>>>> initial_bytes session without it becoming a purely volatile value.
>>> Here, IMHO the problem is QEMU still needs to know when a switchover can
>>> happen.
>>>
>>> After a new QEMU probing this new driver feature bit and enable it, now
>>> initial_bytes can be incremented when REINIT flag set.  This is fine on its
>>> own.  But then, src QEMU still needs to decide when it can switch over.
>>>
>>> It seems to me the only way to do it (with/without the new feature bit
>>> enabled), is to relying on initial_bytes being zero.  When it's zero, it
>>> means all possible "critical data" has been moved, then src QEMU can
>>> kickoff that "switchover" message.
>>>
>>> After that, IIUC we need to be prepared to trigger switchover anytime.
>>>
>>> With the new REINIT, it means we can still observe REINIT event after src
>>> QEMU making that decision.  Would that be a problem?
>>>
>>> Nowadays, when looking at vfio code, what happens is src QEMU after seeing
>>> initial_bytes==0 send one VFIO_MIG_FLAG_DEV_INIT_DATA_SENT to dest QEMU,
>>> later dst QEMU will ack that by sending back MIG_RP_MSG_SWITCHOVER_ACK.
>>> Then switchover can happen anytime by the downtime calculation above.
>>>
>>> Maybe there should be solution in the userspace to fix it, but we'll need
>>> to figure it out.  Likely, we need one way or another to revoke the
>>> switchover message, so ultimately we need to stop VM, query the last time,
>>> seeing initial_bytes==0, then it can proceed with switchover.  If it sees
>>> initial_bytes nonzero again, it will need to restart the VM and revoke the
>>> previous message somehow.
>> The counterpart QEMU series that we pointed to, handles that in similar way
>> to what you described.
>>
>> The switchover-ack mechanism is modified to be revoke-able and a final query
>> to check initial_bytes == 0 is added after vCPUs are stopped.
> I only roughly skimmed the series and overlooked the QEMU branch link.  I
> read it, indeed it should do most of above, except one possible issue I
> found, that QEMU shouldn't fail the migration when REINIT happened after
> exact() but before vm_stop(); instead IIUC it should fallback to iterations
> and try to move over the initial_bytes and retry a switchover.

Yes, I agree, but it's a delicate flow in QEMU and need to get to the 
details.
Anyway, this case should be rare and we can further discuss these 
details when I send the QEMU series.

Thanks.

>
> Thanks,
>
>> Thanks,
>> Yishai
>>
>>>>> Is there a way the HW can report and confidentally say no further critical
>>>>> data will be generated?
>>>> So long as there's a guest userspace running that can reconfigure the
>>>> device, no.  But if you stop the vCPUs and test PRECOPY_INFO, it should
>>>> be reliable.
>>> This is definitely an important piece of info.  I recall Zhiyi used to tell
>>> me there's no way to really stop a VFIO device from generating dirty data.
>>> Happy to know it seems there seems to still be a way.  And now I suspect
>>> what Zhiyi observed was exactly seeing dirty_bytes growing even after VM
>>> stopped.  If that counter means "how much you can read" it all makes more
>>> sense (even though it may suffer from the issue I mentioned above).
>>>
>>>>>> The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
>>>>>> caller that new initial data is available in the migration stream.
>>>>>>
>>>>>> If the firmware reports a new initial-data chunk, any previously dirty
>>>>>> bytes in memory are treated as initial bytes, since the caller must read
>>>>>> both sets before reaching the end of the initial-data region.
>>>>> This is unfortunate.  I believe it's a limtation because of the current
>>>>> single fd streaming protocol, so HW can only append things because it's
>>>>> kind of a pipeline.
>>>>>
>>>>> One thing to mention is, I recall VFIO migration suffers from a major
>>>>> bottleneck on read() of the VFIO FD, it means this streaming whole design
>>>>> is also causing other perf issues.
>>>>>
>>>>> Have you or anyone thought about making it not a stream anymore?  Take
>>>>> example of RAM blocks: it is pagesize accessible, with that we can do a lot
>>>>> more, e.g. we don't need to streamline pages, we can send pages in whatever
>>>>> order.  Meanwhile, we can send pages concurrently because they're not
>>>>> streamlined too.
>>>>>
>>>>> I wonder if VFIO FDs can provide something like that too, as a start it
>>>>> doesn't need to be as fine granule, maybe at least instead of using one
>>>>> stream it can provide two streams, one for initial_bytes (or, I really
>>>>> think this should be called "critical data" or something similar, if it
>>>>> represents that rather than "some initial states", not anymore), another
>>>>> one for dirty.  Then at least when you attach new critical data you don't
>>>>> need to flush dirty queue too.
>>>>>
>>>>> If to extend it a bit more, then we can also make e.g. dirty queue to be
>>>>> multiple FDs, so that userspace can read() in multiple threads, speeding up
>>>>> the switchover phase.
>>>>>
>>>>> I had a vague memory that there's sometimes kernel big locks to block it,
>>>>> but from interfacing POV it sounds always better to avoid using one fd to
>>>>> stream everything.
>>>> I'll leave it to others to brainstorm improvements, but I'll note that
>>>> flushing dirty_bytes is a driver policy, another driver could consider
>>>> unread dirty bytes as invalidated by new initial_bytes and reset
>>>> counters.
>>>>
>>>> It's not clear to me that there's generic algorithm to use for handling
>>>> device state as addressable blocks rather than serialized into a data
>>>> stream.  Multiple streams of different priorities seems feasible, but
>>>> now we're talking about a v3 migration protocol.  Thanks,
>>> Yep, definitely not a request to invent v3 yet, but just to brainstorm it.
>>> It doesn't need to be all-things addressable, index-able (e.g. via >1
>>> objects) would be also nice even through one fd, then it can also be
>>> threadified somehow.
>>>
>>> It seems the HW designer needs to understand how hypervisor works on
>>> collecting these HW data, so it does look like a hard problem when it's all
>>> across the stack from silicon layer..
>>>
>>> I just had a feeling that v3 (or more) will come at some point when we want
>>> to finally resolve the VFIO downtime problems..
>>>
>>> Thanks,
>>>
> --
> Peter Xu
>
