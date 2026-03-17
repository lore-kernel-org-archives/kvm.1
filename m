Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819773EBF00
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760964; cv=fail; b=P79OsOeAvUrd8xYyrNclcI6iq56NZbdnR07GybZ1rnCERbJ4ymjUw8Xb4VsjlDsO1RHRz+kl/F17TITdvFrnkifgv/+uC2yZTHa1okP+zwHKRr3MyhWToswIcXL5P1SB3k2iwpYfq+hwV7zJCGQJDA5gs9PpOW/VxzBAcTqFSmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760964; c=relaxed/simple;
	bh=OSkTdpATPc9/qD6cm60drqveMfig9pN113nGGqA+7y8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKrQZAZvaj04ZWpj7WA4rj3RWOdHD8D3Id3tzK23jtPXcoW3hhnv6RdAW2O7jzYncT1QYSBGa3iyPM+YSoXH33+SKO0cCA+Hj01m5Gon+56pfDP41zzs+5NVLGJSSpnKMuT5YZU1SCJMWQsliF5jSLT6WEMk6SNb3M66cJ5ObbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jg+C2qgB; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jg+C2qgB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/fsSbL8N+SOosDnHnHmlRxSjh3DqVVbKHP1VGG6xbAFoAsJu0umWInc8wBvSpMxBaIRoGUw2cib6OQYIXZCMOmxwsE0QSfjWv23cjrLWwgFMCel9pIO4zEVVm4Az9a83q+Ztbfnet/3jjspQ5j2IyqgMBpklLnWUuN+jdBit3YCKpfqyygf5Fi3T2jkIf7JoHOGQ1N3Z3pba3Y5cKLK99E1R8BPdsi/dJRU/HVDWPfC/CZqLhAJE8qqPZlq/QxNs5EeWJT1C9iMcpc98D5gM0xVJKgfW0Gcgjnn9MqOPtZI7khikaCDyVWemp61vjAwkEZJVSsxWxLItN9zbiC1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiD8J8UaOZtriVo8q/QTFeuwCxgWj6QCppWPBIXG/ao=;
 b=BGXNaG3lGjpLOjGck4e8QiGa5Tn4NzpiINzOp6SzFnnhtyFt0bKI/IB+UYJLwntSpiehTzoJRbcq2Vyxy14LeKp22rb03iYjow169i8im5re4d9Lwg/yQQAwXDQyo1rnbglDzdVx/HspPcOCKcpLFjMLN3puHcp1k/qTrwV2mVXT6dYs5crXQP0PR35t1ShnSQJFdTFft2TcF9TwAnIVrTV3ne3uHr3lHnG3dtI+hErH8MTWrGp5v8RTjtpphD7nT2hkM/lwBfWvPILI30yRJhv/JXzBF3Lt4NEoVm9CY8gPnBpqP1O+bJKPWcqlsAaVekHbbzIw9th36l+rB9XKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiD8J8UaOZtriVo8q/QTFeuwCxgWj6QCppWPBIXG/ao=;
 b=jg+C2qgBNOeiEOoi+Pwp4MQeX+Nd9IcDIoUBMqa6UmNEF2IYXhxJeXXtiM0qjAU16wJjM6XqkYIcvlu8JLwDq6bJsuh4DHFBlKqbug9kCfbof+OU5DwkMcawoHGARyZXHnavG45QLqoC28ieps+eRcQS202oivXuIByLsT3+zT4r/+A5C8IwtraoRLQeYuwxpU76Qn2o1iAljTInG7f4Y41wY+DoHNZN+Ax0iHIrCLf9QMSkjFxxRzSgfdAnTLX2vClJULUUkqTj5dUOguwVhiS9VEUoY4O+kdBkysP9AOWrN0Dodumov10e3EX3P43DnIAVGOHMWx/6EMeSUfk6nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 15:22:37 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 15:22:35 +0000
Message-ID: <a1ff85c3-2021-4c22-b74d-cafd490221dc@nvidia.com>
Date: Tue, 17 Mar 2026 17:22:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
To: Peter Xu <peterx@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 jgg@nvidia.com, kvm@vger.kernel.org, kevin.tian@intel.com,
 joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com,
 clg@redhat.com, liulongfang@huawei.com, giovanni.cabiddu@intel.com,
 kwankhede@nvidia.com
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com> <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org> <abMfLQPzVFK388q_@x1.local>
 <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com> <abhZBIe-vR-GX3TT@x1.local>
 <accc2aeb-6ae1-4aec-867c-c9927e98f903@nvidia.com> <ablf_dVtYlZOoIcp@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ablf_dVtYlZOoIcp@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CH0PR12MB5059.namprd12.prod.outlook.com
 (2603:10b6:610:e2::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a7043f-8436-42b1-7eaf-08de84390398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UNJZ2d+0noYNmFihanVORN4zYivYwpCphP3AT1QRy+R5G56jV0VdKOkl2sI+2dpXNO7eEGyRW+XsPeRqsXirMYU2MY2X0JjFhTDcosYYIwCNAtXdSkaWNjL1tGYppTAs2NQ9SJVUjpvAa9ktjaAwukTOslLJ5cSW0/0mRAizc1lMhCSPp9JQXLaJaMieS7gOFyB7YR/jWct2Q2q9VE6UaDuQzXa1XYawL4uN2suBLY3i3b+J4D36zCC+LraOQy5RhuGpY5bQHVbxeoYt/kEjGfd5f5tr4Wh55Z9ZTZV3529npTgA2lpjfY+rjISXSvg54oMbjm4Kl6UoJ9FF4k835BMgRM6oxJKJejMjm/lm3gbbFLbaVdZrBPp0OCztRP1cKQiGOjMmHM1zQ3lIk7+nxz7B3OEZlJZE9s4OVrLRuVoceM3j9ldVFxgL6nQCHBux5zbSySrzCY2/rdEoIhZsGPECw9UEmw4Al01hcfCyewtyM7H7PUu8elsCSX7QledN8ZeUw+fCJYigj6kdgoUFUh9DfQ7YSEDGNWy1V4wwLH5m5ZK8xpobBPu0uL+WUg7Z6Ibw4UDfwr1N0NI+64zsxjSCTZorKwC2wBuwBGQUtL/QNwYEl48KHuGxCEkiKJr2/dQeaXfZK6Dasp7LMTN3vKE3rku8w7R4Am8SOEMPYUjMEE7FyFvTrOiZillHfScixNKfJjg5ZDLK+ONhSshzwKKzCFK0MmXNYJuI2j214mo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVFyWE4xc2c1VXIvL3JrVjZraGRTTFlvWVI5QkpUZmUwRk5wajkrMzFLZngy?=
 =?utf-8?B?M2JTQUErYW5EaDMzTVB1Yk1ibjlmY2RTY2x4SVR0dVZlN1BGQ09tODZSd21D?=
 =?utf-8?B?dDdtY0VNNGk3YnE4MVZkRHdvSmJjMUhBMUpnOTdrWVJaSHNZQmJvVHZhODBT?=
 =?utf-8?B?WjZUWGxFbVdRZjlINDZkYzBaeFl5YmxXSngveGpuTm84b3FLWnMrZ0EwUFN4?=
 =?utf-8?B?K3lYdnRLcExqUlhuVTVCWE80MisyVlBSUGsrSEdWQXBsZTZ5MFVEdy9TY1p5?=
 =?utf-8?B?V2xCOEg2bmcvSU5rZDgrbnh6UVpOM2d0ck1lTFRFVzl5NFZLWURkMjB5UFJL?=
 =?utf-8?B?ckw3NENxWkpiRmpYbDR2emZsSG93Zk9yQ0JnM1pnSEllZHZYUDhjSVBLcE1Y?=
 =?utf-8?B?NVk1eE9UZ1FGNmhGOSt1QlBpQklBSmd4QTk0Ry8zaHMrWVM2elB0MTFWemFo?=
 =?utf-8?B?QzZnajBGZGxNNExkb05PaTNDZ3pjNUJwV2FhSDQ1cUVuNFZ6UytCajdQKy9K?=
 =?utf-8?B?d3diRmF2ZzU0ZUdDQ1RNcS9JVy9vQjhMOFkzUU5HWktnVjJWREZ3UWM5bTlN?=
 =?utf-8?B?ZzB6TG11Z0wzejJ0ZU5tcHI5QW5EYjluK0FpM0RKSllWNmxRUnhxTXJwS01K?=
 =?utf-8?B?b1RZWEMwZDNkZDN0RGQ2TFplanBFbTBrUkw0ZzlPMmh0K0tkRE9hNVJ0dkRw?=
 =?utf-8?B?YWpMNGFKVUUyRzNlWDIyY2hZRFgxVFJEYm81bHd5Rk1Db2lzdHJiU3g4R3Iv?=
 =?utf-8?B?TzU3TGtjMnJGbDZsSmhXMG5GNnJJZnhFUU5xc0FranZaNnNVdDVjcUtKNzFV?=
 =?utf-8?B?dGdnM2VGNkpFRXduZ0xkOUVCWDNyQ0xsRWVGMm05WkFjNGJxbFF0Yy9IU3Bz?=
 =?utf-8?B?S1ZsUGtUMUx3WHRVVDVZbFFYL3pML01ibVUyc3FENTBJR1BNc25XL0JsR2ZW?=
 =?utf-8?B?Zi9VYlVrTlRFRHVtVXEyQmpxRjB0b0NwanFKYVFYejhhOEs1VFF0M3E1L3JR?=
 =?utf-8?B?TFZ6WkRaNlhyUG1CemcxMTUyRGtoRkZjYkV4YmE1ZkVXWUNvVUZKbE1sTnZU?=
 =?utf-8?B?V0Zhd3FUWDBUcGwzZHZmbW0veWVFMGxocFZZMWU4bTRmWFpua2Vja2MyaTY5?=
 =?utf-8?B?VkFHemp5Z1E3WXVpZEZ5MnVhWkVyYWVldkowZWhVUEhSRnFrYkNtRjRHQW5a?=
 =?utf-8?B?S3drRHoyT2wxS0NHdnVjMVAvWjVKV2hQMmhVRk1CY0NnU3dadmlyci9IL2tF?=
 =?utf-8?B?MDVjUWFNb0JmcHoySnNEVjJEMUxqVGQvNnpOTm5SMnNRZkxhdHpvaHEweTZj?=
 =?utf-8?B?S0oyZXNDdFpHbU5La05GRDlNNmdVb2Yyb0xVVlVwbktZRHN6NktVaHR2QWRw?=
 =?utf-8?B?Y0JyRE54RFo2TVBlRW1sN0l2a25KTTg1eGY5M2FUNGJxUlFrL0NhRnVZZlEr?=
 =?utf-8?B?YkZEd0J6cXVSMDJ0VFlTdmtsbldpQWZWVjNHc0Y3cU9mMGJneCtETytGWFJI?=
 =?utf-8?B?UWhubzMxYVFUTVY1aWpLNE53bG1VSUlicG50QWRBV3pXQUkxTW1CT21xODVn?=
 =?utf-8?B?ZzEweUhMbGc3TzdYN0ZOd1VBUklFUmo2aDZ6K1FRcCsyNXRIeXM3amhuaUk1?=
 =?utf-8?B?RDhoZDlpVWVlNExpeWY1VExmZHNNTVhlWm5Fa0FyUTFtbmRPd2JUcnFBa2J1?=
 =?utf-8?B?SW56eW85VUhsa0s2RExRTzluOFF3a0NyZ3VQUmRmeElySUMwOHBqZGJjTGd3?=
 =?utf-8?B?aVZzelZqL2FQTmdybVljTUtHdzhmUGwwWk1pMXA0bXc4UWxFcHFKa253Znls?=
 =?utf-8?B?QmlzY3E2QUo4UDBORUtVWk42UzFDdWs0T0JKN0NPb1hSRFJZaUNQd2ExejVJ?=
 =?utf-8?B?dnNycVZUNzdyeTcyRU44MDVGc3RUQkl5T2YzTVlhZGI0UXVlLzJjdVNtV3FX?=
 =?utf-8?B?TDkweW1kN0ZHTWFtcmlqNWF2Ty9tRGE1WDNnREhSc3J3SVFERFVKNjlHMyt2?=
 =?utf-8?B?akJpbEhadEppcytONlRkRmR3RW1ucXRhTUUxZGNobHcxODdUK1Y1aVBaWHZU?=
 =?utf-8?B?cEE5Ti9vd25ZMW9VQlNZeW1ueXdVK0lBajR0V2FqNmI5RzdQU3UzTkovUnNh?=
 =?utf-8?B?YjgrbzFPcGkrOCtCZElFUm1hby9SankxOEpSNi8zSys1dmc5U0lCb21Gam1X?=
 =?utf-8?B?RHRmaXNGVDQraTF0dkJDVzVjM25VZmMybEpqOWJJZnJ1MCt3WUdQcTVvSHNt?=
 =?utf-8?B?a3pzSHRjKzdQTlB5bmpuclFaRGxNcFdjN0w5Q09SMXhGSnpCV2RDRWoyaEV3?=
 =?utf-8?B?SlZFOCtZUkJIblVxdmo0T3p6aTJMVkRnN2xpSjN1YzZYenF0RTdOQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a7043f-8436-42b1-7eaf-08de84390398
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:22:35.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyRUW6p5iyFcAo68Q+xhx1wIWoaFzEEc4bAsByOTqzVXHAJuUywLT5BClCcSCwWJYBqOti6N/HVxfglDHpxuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360


On 3/17/2026 4:06 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi, Avihai,
>
> On Tue, Mar 17, 2026 at 11:58:28AM +0200, Avihai Horon wrote:
>> Yes, this is because the VFIO device stop_copy_size may hold data that can
>> be transferred only when the device is stopped, i.e., during switchover (as
>> opposed to RAM which is fully precopy-able).
>> Reporting it as part of estimate() didn't seem right, as precopy iterations
>> will not reduce it -- if it's big enough (above the threshold), it may block
>> future exact() calls as we can't migrate this data during pre-copy and reach
>> below threshold again.
> This doesn't look right either. I think we should stick with the exact()
> being only the accurate version of estimate() only.  The problem might be
> that the current interfacing for both may not suite well enough with VFIO,
> because VFIO is so far the only module that may contain stop-only data.

Yes, I don't think either approach fits perfectly. We can discuss this 
in detail as part of my QEMU series or as a separate topic.
However, I don't think this is directly related or poses any problem to 
the precopy REINIT feature.

>
> The other known issue (not directly relevant here, but we will need to look
> into it very soon) is when VFIO is involved the query-migrate results are
> sometimes not containing VFIO data, at least "total" and "remaining" fields.
>
> I'll see if I can prepare some quick patch this week to address them, or at
> least raise these problem explicitly so you can have a closer look if possible.

Sure.

Thanks.

>
> [...]
>
>> Yes, I agree, but it's a delicate flow in QEMU and need to get to the
>> details.
>> Anyway, this case should be rare and we can further discuss these details
>> when I send the QEMU series.
> Yep, that's fine.
>
> Thanks,
>
> --
> Peter Xu
>
