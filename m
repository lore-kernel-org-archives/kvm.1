Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810512F84F;
	Sat,  6 Jun 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750933; cv=fail; b=jydmlgWn7TyY1M51LVN7XvZfOKE/hgQw9YhYqwTqzZi+yeHl2l4QQidArtxjEzl4kfSpMwJuqSL7GUaLocWNzzJ1ZxdiRXnQEIOIS3dW8il95j6cZijMfCdRxQt4VNu/nOF06AxdX20+qI4wVaibjnvhf2vpFDRQtPCbyhHSk9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750933; c=relaxed/simple;
	bh=6nPdvUK5u0Irxu7m+mizuPcyaZbUsLd7854UBrtKmNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WD6+JyMhFPuEc3iWlzdt0KscqqTs4H1Aqw/2zpqHTgiYTG6UUaLN8xlTNSOYokLS9fHf3c4RxWDaggw+o1bWBzyUYL8hunESwXLMKNlUXQQ+gQX7k/36G7L00IA8qj6At4+Xhcylyr5HuokGWnOhp9I+a/U7/03vHDumHIsKJgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VDQsepJo; arc=fail smtp.client-ip=52.101.61.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VDQsepJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwABKZZXT8XXMnb0yWubKnATxWYw3PvTi3ulq/Cn0ATOQRdKdFbxWHmDVKON7YPI0XMAOj4c2nfT+BzeEpljt62um15bGGLn29m7Ic1RPb2BFd3M3jzdrcdedwvNPWHc7k8m4KURoWXzhxX6kP2ueNoORoUnFwCY2rSdz5GmGPZOiBwSjHWU1kzE3RO+xi6f8tGbzq/81uQDTlnuxvQ5yN50MHtoI94F0fHhVdjLzVlqv8sg13DyF8gAu3qJCqK3F5cedU6sJl+m9k0fEYIsGFft1MQdHWVuMZZ9rz1fKc+026fgc2hZXniuNbmcWYCIaNOkFgqnOCR3e+5s3VcnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYQmAl3CPYen0NQjyORuqcn4/NXXSLMPiraeeBvlqAc=;
 b=plN6jXGtkhzD9qA7L7WY8cK6crfVrmPwrCj/35B5quS1aV3jjbScRJvbNQr8mfOIIf45EXEkhxWYfc7GRv2WCv+IrqsyX47mNYo68VHCJ1QE3kbZaoy29fsejSfGdIx6P6McUJxX+eWetzn9Rk8UrNEOjNwoc37Mc9ucg6rYbi5gz/aa5Eg6wuAISjPa2KebUg4HCoCv/dx35UJ0/E1zJgXk7s7YITegtXgz4fPYHWteaC6ng9AJf+0nfVpiwXFNW2Gy96pAo0Omqk5c/1t9a7o5Sjj74uHwT8YUfn6wVHkJ2TfZ0rh4FQ6Oe7Yt75x3ebg1+nteIDBADa4Yw2gQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYQmAl3CPYen0NQjyORuqcn4/NXXSLMPiraeeBvlqAc=;
 b=VDQsepJo00wz7FHHaHK3c5MNNVbv6j2Zxy0OPS1vhP/GklarxHvxpxqK8B1oqsTa4sVKzhfzlBrnAJs7nuKq6hPaOQzatlP8bhMIR3gMEFFJQFGnspx7mD3gVd7c2NYWlUj2d4HrnerKLpGua2jj1E9cnnL5am+t1iW5q8RwbBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by CHAPR12MB999249.namprd12.prod.outlook.com (2603:10b6:610:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Sat, 6 Jun 2026
 13:02:09 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%4]) with mapi id 15.21.0092.010; Sat, 6 Jun 2026
 13:02:09 +0000
Message-ID: <b680f308-2dfa-47a2-9ff4-05669259a09c@amd.com>
Date: Sat, 6 Jun 2026 18:32:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <916681a5-dd66-4773-a46f-2273a72c11cf@amd.com>
 <20260604194613-mutt-send-email-mst@kernel.org>
 <42c42370-2cf1-4b98-8d6a-8d7cd62f95f4@amd.com>
 <20260605105455-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20260605105455-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::21) To BN9PR12MB5259.namprd12.prod.outlook.com
 (2603:10b6:408:100::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:EE_|CHAPR12MB999249:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5123d6-181f-4142-9800-08dec3cbd171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uHJ0xZSFW1KYlwRGWMet/R6UiMU32f0p+rDARxiKrBEPgc/8xtnLNJI0C0BF3jZFeI+0OqUygyNAkBAkAL3KWEyvyUAQcFcDZIuWN6B685wXekyw9x77it6aAlqS/I53hzOqSLcDCV54+GQxN0b0o1fo4xUsFyfnJhNmO77UvcvjaeGJCzkcaAqqsJGIAAKWyT0N3XeqqrXPkJiZh9OhEvRzSMvm5CMT2Eslfh4U6v4ErODPASG2ZviUgOZHBc4d5LUt+gGTMXsuALhEY07xTMSpKA/Yh9o1xpzbMzpCQNGPUteyTEvT5clyvhyQyTeiDvC+C/avWBVTB7npLI3NVbVrCp6bnGv+RRSlnzs9jKo/dvDX9CfHbc2OavBmogbQMYKBjcUI2QYEBB/j0G8A7OHmwnv37Z+WTRvse9R4U0qgoYY5kJ7u/GbXKodg0sMVEU0zQ6wKxqSXup6uL38zvG5TxX3NA827ymwhez63MSDbhqF7CBfiKmYD9f0/DOa4k0T5EnyiRWOPaJEoIQaP9WDVdl8nXcv/nJOaM7v7GmZrJeKl1LwF6M2+MncVwa6JBBDF2m9pMFx1BSaNvH6ORh2WPjEuesGP6luNVYNg1H1paPTB6eryKnEt5Pvw0EmLaobOeXUcRrfzNiCKE128RjFG1rKk/5BEXUh0n/zgMLVrOZbS08xbdJbJXwa98ooj4guoeTScbHEr25QEOt9TMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkxGZWZuSXF1cThKbXVrUGRVS25KQnlvRUExc01nSzY1ZnZtTXBtSWVQNmdG?=
 =?utf-8?B?VitvOXpnT0tzSE4wdnFFRUxGQWx1SndCQjNvODZ0VXVlb3lBRkMyMDM0RFJN?=
 =?utf-8?B?NHRkT2tUVFhZYm5IakVTK21YNlozMW5HeE1yV0kvdFFIMzAwOGllUlFUaE84?=
 =?utf-8?B?WG94WkhBNXBXcnhXa0diKzVvL1J3ZllaQllBczE3cHp2TnJFK0ZDSVo5aDFE?=
 =?utf-8?B?YlhNNHRvRjQvNG5PdllWTWRjTmUveXJFcE9LZ3JPRVE4dVNmUkp1dktYZElV?=
 =?utf-8?B?NFZ0U3FXRzFIQmRhbzhzV01zdlkwQmVCTmJaZ2FPUmRqNmZXNEVseGJ3UEcx?=
 =?utf-8?B?azdRQ3ZibGRDd0hseEpFSzN6Q24wQlhNelNSZE9Cb1FOcWZYODh1cE9MOVpp?=
 =?utf-8?B?TDBWT2VaR2RsWTZjN2lQNG5rdFpRWHJadkJyOXlrWk01WXk4MVhIWHB3SzVk?=
 =?utf-8?B?VE4yOVVtQlNITWxwdnZ2VVh2QVorS0xua1NMRzN2RldpM29ud0J2dElmTFQ2?=
 =?utf-8?B?TmVLbHJhalg4U2FhUnJ1V2U4U1Y3SVZmUXgreFQ1cDRBQmFzS29XUTFrVGFr?=
 =?utf-8?B?M2pNTjdSYWNJNGVUWkJidkYydlFhajNMc1lmK0IyQjJlQUpyRkZ2QkZKajZz?=
 =?utf-8?B?dTNkdjMrQWVTYjQrditreTNqTmdmWE0rUm9xalIwSW0xRVFXVDVqTnRSVmpa?=
 =?utf-8?B?UFlBcm5iN2UyY1NWaDR2MWFDZTg3R0JBNXFaU1h0Y0E3b09wd01qWHZQZXlu?=
 =?utf-8?B?Ukd4NE0rOUo4dkY3cFdKU25TUHZ3NkxaVGFqcFpyUk1uazNXM2VWVlgwbnQx?=
 =?utf-8?B?UEplNHFJdW5SNUZUcGFtbVFsaDF5S3hwMUh5TE9kcHFCZkRvZXRxdVRPdlBO?=
 =?utf-8?B?Q0RTNC9TaW43NCt6dTZVYUx5OTZmRnhSRm5Bb2NpL2NOVHJhR1lrYzk3UFkw?=
 =?utf-8?B?WkJrWDBTMzJ0RXRhaFh2d1lpUG9RSEJHbU5KdzFSTkhDNUxXL3JEOWhrb2NK?=
 =?utf-8?B?bzNsVEhVRFRRWHY2UTR0OHFLOHBtaExaaFFoWkVKM1dpQldkVFhqbmRZNE9R?=
 =?utf-8?B?YzYvemR4ZXdLS1RrOFowSEFkS0RkazZWalJKSUxLY2Y5TnNPaWl1VjgzM2xa?=
 =?utf-8?B?RVlVU3lPT0dPVklYbDFQL0NhS3FmMXNTbThWa2FGWDNMUUJvaXYrN2JRZFEr?=
 =?utf-8?B?M1Q2c2xJNlIvbXNERlMrV3Z5ZlVmY0JrRWc1QXJ3YTUvcXZOeXRueHIwMjVt?=
 =?utf-8?B?eFRtSk5JUmxKeXMwLy9tbk8wL01MNzJOOEd4b2hQeXZiSXBFWlBlVndJZEhn?=
 =?utf-8?B?QzFMV2JDYi9yQ0NHdEtCVDFxOXViUGxNZUVTdmJVVmlmVXlKVHlTYnpURG1a?=
 =?utf-8?B?N1ROdmVud1dNT2JoSWg2T282bGdVWW1lZTIwOGRmT2hsV3NhK3hBTkhLYnZ6?=
 =?utf-8?B?RjQybmRmTmduSENTM24zWTBTUDcxR0xPdlNBMEhLZlpHVXZxa0hGMW9HaTBB?=
 =?utf-8?B?OHdZNkUrRjRNeW42eEJtQkdaMkt2YnVvMWdva1Q0TTBwdzFPK1Rnc1RLYXBk?=
 =?utf-8?B?TjYwSUNqQzBTQWxqRmgwV0JSMHpndzE1UzUrckM5TWV1REdYOGRDcC9sa1dl?=
 =?utf-8?B?TFllMWh0T0F2bjRGRDRwV05lbVVRUlBoa0U3bmxvOW9KK0U0WHk2M0s3QzJ3?=
 =?utf-8?B?TmFlU1RzaG9DZ1llWXpSMVdyd0NrNXAyVFlyeWczWDh4R09RSDlOV0I4NTZ2?=
 =?utf-8?B?dkUxWm9mNFBaR2xXbUNySEx0TzFlVU9LS3FoS0VSdDVRZ1NsUkYzTmw2NXUy?=
 =?utf-8?B?R0JSZ09HRytFbnhlWUJ3cURaS0NyWllKWEtnUTAvb251U3ZROWxrZkg4TURw?=
 =?utf-8?B?NmY3UEFZZzloVFd6WS9VaDFlRkhCVlAzeStoSFhSL1BKMDViUE5FU0h5WDhD?=
 =?utf-8?B?aURseG80M1NhVkkrSzBMbWk4WnlHd2E4UkhaSnVma29remRFaVRKRTFXaURG?=
 =?utf-8?B?d1YwMnc5ekJLVFl6K1o0RkNnT2FBRDc1bjYxWm5JQXhyalRScHRQMU9PKzBW?=
 =?utf-8?B?Y3NsYU5zeVdBVkdkc2dqKzQ3Q0x2UE5kODdPMmVyaG5ndHZINUkxdUtmZ29Y?=
 =?utf-8?B?VERZRUR2SzZROC8xeDdvbFJGNlBZeXBZQUxRS2MrbWVycU9MY243VHg4VDIr?=
 =?utf-8?B?WVJlZkRvc28yc0p0WUh1Tzdac1dHSWNyTTVUREVMeXFqNjE2Rkl2c2F6dmFE?=
 =?utf-8?B?dHR0UzRFaHpld3pQTmZvb01DbnU2aXlWeTBXVzUvcUUwU2FybTErd1Nabzh1?=
 =?utf-8?B?V0g5RlJoZG5lUkN3TVFjT2l3dkliR1N4YWJjNVFoaURkQXdiVzByZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5123d6-181f-4142-9800-08dec3cbd171
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 13:02:09.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjPX7gGLhLmiC/jSWuUHnvpn3zdGLEUz8cr/2dLBS7cSv02Un8hYCgN8rXuwXJo/EuUM00VU0flA1MXS1FegOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999249



On 6/5/2026 8:25 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 05, 2026 at 06:31:51PM +0530, Garg, Shivank wrote:
>>
>>
>> On 6/5/2026 5:16 AM, Michael S. Tsirkin wrote:
>>> [You don't often get email from mst@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Thu, Jun 04, 2026 at 12:21:15AM +0530, Garg, Shivank wrote:
>>>>
>>>>
>>>> On 6/3/2026 9:27 PM, Michael S. Tsirkin wrote:
>>>>> kvm_gmem_get_policy() sets *ilx to the full page offset
>>>>> (vm_pgoff + vma offset).  But get_vma_policy() adds the page
>>>>> offset on top of *ilx, so the offset is counted twice.  This
>>>>> causes NUMA interleaving to skip nodes: for order-0 pages the
>>>>> effective index jumps by 2 for each consecutive page.
>>>>>
>>>>> The get_policy vm_op should return only a per-file bias in *ilx
>>>>> (like shmem_get_policy does with inode->i_ino), letting
>>>>> get_vma_policy() add the page-offset component.
>>>>>
>>>>> Fix by setting *ilx to inode->i_ino instead of the full page
>>>>> offset.  The page offset is computed by get_vma_policy() in
>>>>> mm/mempolicy.c. The full offset is still computed
>>>>> in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
>>>>> shmem_get_policy() follows the same pattern.
>>>>>
>>>>> Found by Sashiko (sashiko.dev) AI code review.
>>>>>
>>>>> Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
>>>>> Cc: Sean Christopherson <seanjc@google.com>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Assisted-by: Claude:claude-opus-4-6
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>  virt/kvm/guest_memfd.c | 7 ++++---
>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>>>> index 69c9d6d546b2..0bcf6fc08e2d 100644
>>>>> --- a/virt/kvm/guest_memfd.c
>>>>> +++ b/virt/kvm/guest_memfd.c
>>>>> @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>>>>>  }
>>>>>
>>>>>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>>>>> -                                            unsigned long addr, pgoff_t *pgoff)
>>>>> +                                            unsigned long addr, pgoff_t *ilx)
>>>>>  {
>>>>>         struct inode *inode = file_inode(vma->vm_file);
>>>>> +       pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>>>>>
>>>>> -       *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>>>>> +       *ilx = inode->i_ino;
>>>>>
>>>>>         /*
>>>>>          * Return the memory policy for this index, or NULL if none is set.
>>>>> @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>>>>>          * can then replace NULL with the default memory policy instead of the
>>>>>          * current task's memory policy.
>>>>>          */
>>>>> -       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
>>>>> +       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
>>>>>  }
>>>>>  #endif /* CONFIG_NUMA */
>>>>>
>>>>> --
>>>>> MST
>>>>>
>>>>
>>>> Thanks for fixing this. LGTM!
>>>>
>>>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>>>
>>>
>>> Can u actually test it though pls?
>>> Because I think another patch I sent in response so Sashiko
>>> is also needed.
>>
>> Hi Michael,
>>
>> Yes, I tested this.
>>
>> I used kretprobes to read *ilx on each kvm_gmem_get_policy(), while calling
>> get_mempolicy(MPOL_F_ADDR) on consecutive offsets(0..7) of guest_memfd mapping:
>>
>> BEFORE:
>> page offset:  0   1   2   3   4   5   6   7
>> *ilx:         0   1   2   3   4   5   6   7
>>   
>> get_vma_policy() again add the page offset on top. so, it will increase by stride 2.
>>
>> AFTER Fix:
>> page offset:  0       1       2       3      ...  7
>> *ilx:         128376  128376  128376  128376 ...  128376
>>
>> It store i_no, so after get_vma_policy(), it will increase by just 1.
>>
>> It's hard to show any wrong allocation with the bug because this index value is not
>> used by allocation path, which uses NO_INTERLEAVE_INDEX.
>>
>> Tested-by: Shivank Garg <shivankg@amd.com>
>>
>> Thanks,
>> Shivank
>>
> 
> 
> So for this to be useful at all
> we do need the patch I sent in response to sashiko, right?
> Mind trying out that one?
> 

I could not find the other patch from you.
Are you talking about this response
https://lore.kernel.org/all/20260604034539-mutt-send-email-mst@kernel.org?

If you send any separate patch to test elsewhere, please point me.

Sashiko comment:
> Doesn't this defeat the purpose of the shared policy, causing interleaving
> to be randomized by the chronological order of vCPU page faults rather than
> deterministically spread based on the guest physical address?

It doesn't defeat the shared policy's purpose.
This design is intentional, The shared policy exists so the policy is a
property of the inode and selected by file offset, and that works.

I don't think we need determinstic interleave now, it can be revisited later.

Thanks,
Shivank
