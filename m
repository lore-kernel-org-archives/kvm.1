Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D73B14AD;
	Fri,  5 Jun 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664522; cv=fail; b=RSvFI8u9xqUUakb/UBfpRCM91jBgrdzzKv8dPu+V9QV7kNOGb4nyLSVZSHYo6XQYg5rVbDB+gJ3gHw1ekKQHHRwKnx/dtTzjVm5LVzLF+aewhNCMXAMsslwVHszsPZvPtw4CWgY8XBCAlcu9hMJ2AekE8IB7N9u9OVcwA9hO4hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664522; c=relaxed/simple;
	bh=f0v792o6Qowjp7pVYYfMJI/Yp9ziB7pEG0IKODdg2+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubWo1ofR+LAGXnn8OdgBgwhR4PA6NhhRnJIGk4+fwnkiQbBKOXg2apN8SPGiyP6l9v2Nwd0Tv0M14duf/eAHF82rFsnO9viqSQyvBtzxJYPzpSRk+8z6XGpfT3NeUnez882X4biqHUqZ0ulra6FXwOMWWD/ttQ91co9aXPEQyds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xEqXfaWo; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xEqXfaWo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuJ2gc/Rj0n6Xqn8FI/OHTJ2OPVAdg3cAKyY0UaqK+bKfEM3OZECfp06OPSO1GCAUCcU6RrcT2bul0TBD9vzSlfIyXgR3F1OzbMYxJ1HjoAK5jBwGQrgXGUDCVF6M+ZQzcIz2f8ek5yCy0Sjfiw6hLtbcmgzFbco/dQmhAb9C1+6kTUHztMZ1dbFVa6HytwPACJgftG7Qhi2QDo0kdtFoHbMYxotrHWkJBDeq59R2WwD2V1t9FYdNXbncTatw5YDtEmtg36fNd+n2qfDpeeN5QfCXmzXMQEe/ze36XS/zsJapo1M8CNDhSGs24EaAdOPEwhTYefaM8QQlEKFvamB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50kSyJDApE24y6VXU+RBP/30rBU9PN7Kw+4rQ7GLgkg=;
 b=C68OKqbuFGvQb2v7scuQpCDVzRqz3j+LMdBlTB0ty7OC95UqbO+PCd2oziR3fS4bDUbVrG61VmTwRTGy9OPux2aXnQb/AFjG2IO+FPHarIdp80KXhHx+wwl+IdSqwrjwOBKlALi5MAuiM6LA20Gj6wVO236sx2tTe2f7Xmcyl92INbutuXZIcldwvWV66Dg/KmfrlQ3O57qOFHt4sBKyjcKj98U75TkdhSyq21tGB4Q2B+sLrP7MKt5yRtx8uzUqK2xUZ0Ra7pZnRkrJeavUTnPPHniX+fPSjyLuiVycEV/OQoTXOifSG69ZIzwq9HYtFiW37kFB6YGgDQM5wmS2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50kSyJDApE24y6VXU+RBP/30rBU9PN7Kw+4rQ7GLgkg=;
 b=xEqXfaWot4Bx3QOja61UD7R0bWHQi4PpxE7SxrsOsH1E2Ng9tU4l2K+hGgVQsbNvn6eTKAlOpMVf97SvYiPwnlXpSOfOvAoCZ7e8YZd+F06AAfYLuTn96+xKXh71PsR7uphJfmgQjIgg0NbkL7gG1i3Qm6X1YqvRdzAIxUtlNf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 13:01:57 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:01:57 +0000
Message-ID: <42c42370-2cf1-4b98-8d6a-8d7cd62f95f4@amd.com>
Date: Fri, 5 Jun 2026 18:31:51 +0530
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
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20260604194613-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To BN9PR12MB5259.namprd12.prod.outlook.com
 (2603:10b6:408:100::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6626a5-bb92-454d-00ff-08dec3029fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+66VeFCHaZkear8zAxPRMATTHGLWDAykp3c1xLz4eH4rboi4rtyJTeoboHjIzOBfzkbR7j1931A+0vfx5WKFsoQ6jrvau1yOFwVZDctArmXqSdnzwC4MI3RhgNrHrcI4lECBWkvr+v0w8oXz3MOqnsosVwqIOM4iyflQbyKFW5M1AAIMWQ1so5u6Kqf04jO3akx+fTBZbUZ24FjVQbjZP6+aAiOJq2DXGR5HATn8JVMB8wCC7esXsyYbm5zknc+rac63qsTPllOA6Uxic220dQNehGpPo2jSw4XuwOY7NpIQogPNqBVIGIt/6oAyxQRU4Gl9YStIVv2HxIXDNJdv5Y/9goGd6/eviN518x9ojDBAm+D/tyFXFDHuroExsyudnw2tzopxJewPcwcP7OBkHENY1oOZ16SVT7bwso60zjpj399qMnA2G4ctguIArOeJwDIw/P8vf66R9YXME8vlOZTCqxqH5NCAonc8Mno+aGYDW5zqXup+d5/0InImeCSijdFOKNG+5PH3CFIGQn/q7zrovc6W9frsnF/klJNGQNc/MkOeBcB0Hp38si/BssJRvTKzLhGvhlmA71f6xUg/LPGdglEfCGMp9B7dXinRplZ8UBb+HvR54js082HV6MxV304Z7TDDWUOYYmLR8vyrevs/Nquk9KBwMEeEIXCR4SNlnyIfmht1YnLGo3vVGHDb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHA5MmlzRmUyWmlmdmlTaFQ2UzR6ZkRLOG9QV0Nwc0xJYjNsNmZYV2d1aWZD?=
 =?utf-8?B?aFBpaXNiSklNcG05ZHRXeWVKNkpoN0JyWjlLb1RkR3hqeWR5UEloUGJHQThy?=
 =?utf-8?B?cFNiQzd6UXBhbXNrY2k5Z1JpUUhqaWlLeFpuRVRaWkZ5TGRsWk5ERnlQTHg0?=
 =?utf-8?B?THFXK1gxTUFOZzdyK3hyUzJSSnZzODI5SlZRdHVxV2FVSkdyTjJNQUZvQ2xj?=
 =?utf-8?B?bnBaYXJMU1lmMG5zNXk1ZmZndXYvbWx4Qi9xMDZadkxMeTZoUHRYZ0FkVmZD?=
 =?utf-8?B?MldIVVdRR2VNK3BwOTM4RkVNR0VVd2E5UXJEc3dGWjFuRjVoTWIzSHpucnhw?=
 =?utf-8?B?dzhINVZjZ24yNzZKQlBiN0doK0NudFNEWlduSk95L2hYaytJZEdFSHZma0hn?=
 =?utf-8?B?ZXNneVBLZzdCMndkNFpSajZ4eWVwQlpIN3RMeTUxTndiT1lhOC9iL3ZTbytk?=
 =?utf-8?B?clFveis4ZHB4R1kzcmJGSzVwQ1dBYjBnQ2JDVWhLWUQvVjhRYVdvVDEwVnZJ?=
 =?utf-8?B?U0t6NFI4cTFIZ1l6L1J6VWpCVEx1UWZTZkpQcWJqMVY0QndGUFI3WktYN1Fj?=
 =?utf-8?B?UEVGbGRaK0J4RktQVXVTSHMrNlRybjA4dXJ1cUNTcW9EVVNOOWd0eE9DdVZT?=
 =?utf-8?B?UTRlcFpkT3kzS1VDREN2cDN4dEJLNmwyS2pJR0JGNVJmazBSSXZFRU1ZT0s2?=
 =?utf-8?B?bjE2cnRialc2eWhZelF4VEl3VGFxMjdIVjYvbUU5QlBJMGpSSEdqQWE0ZGZK?=
 =?utf-8?B?S3VtMWU0Yk5LQWVVaTB1d2JIdjVxaUJTY2lnQ0p1UjkwRml0N2RQS0t0VnZo?=
 =?utf-8?B?ZDJMcHFuZWw1UjVwcVF4dUo5SlV1bHluYlRib1hxeFlFUzdEMXBiV2JCckIy?=
 =?utf-8?B?cGtVMldBWDc5dFBRSC8wTUpLYkdzM2oxWnFDblU4RCtDMjUxQ2xlR3pwZ3pK?=
 =?utf-8?B?U0NXV3huYnFwcE9PT1VERHRuaGN3cDZaRmNla2hyLzVCQTY4VWR0MEtqQVdU?=
 =?utf-8?B?a0F4MFVQT1JWN25NWkFOQklOOE5UZjJ0SGE3Z0NnUXlSM2daV2oxdHFVVTd6?=
 =?utf-8?B?WXpNTm5PZmZhcFdCY2RiR2s4Z0J4NkhHWjU3L3daM09mR2ZZZVlobFhMYmZP?=
 =?utf-8?B?MklKT0pNeGprY1g4ZEMxZU1VSEZxTGZ2S3RIdUdMTzRGSUZzTlJwVENlZmlH?=
 =?utf-8?B?WkZvbEZidzZHTXp4K3pWdG83SGJMbmE2OW9UUUF0djBxYU5OZEVkSHJhMXo4?=
 =?utf-8?B?VzhRL21ySHRpRGo4aDRwa3RWekMwa09sNWdtV2NtYWRBS1BjUUh2d2orM0Vv?=
 =?utf-8?B?VGxxMGNrODRTOVNhOWc0aUVySUhwcDVBZXYwWFZkTVI3WDVwTDA1cW91WXRR?=
 =?utf-8?B?R0x6ZFBqalQ3eXlDU1I0UWNjTGRlWnJDWVFiMitNWmFrNDJKUmpMR3ZyWXZn?=
 =?utf-8?B?VHIxSzVzbkc2Rm42aEFNNGZZSTA0YkR6end5WGUwVGk0ME13TGtLbnhvV05w?=
 =?utf-8?B?QTg0Mm1OMXV6SXdBWjFnRmg0N001YzlURWYrZHZ3UTAwb1ZLSTA4aTRCaEFn?=
 =?utf-8?B?WmxIRWk5NGFqeDhRR2s3dDVuYlBOWk13WE1tOVFqS3hpNWVDUUQzK0c5bGJO?=
 =?utf-8?B?N0VoZUl3cUtaeG91ajlCVTkwWVdjZnhKZVpEWElNQnZLckwyTUdETDBaZHJ1?=
 =?utf-8?B?akVONEgwWDl3TFZBYTBJUFVGdHAxR0VyYWxXNjdrWlpLWHZxTmRYQ0NWK2Rt?=
 =?utf-8?B?Ri9ldlRWa0hnY3JpSlR2a056WGFMNTVwNEFJa3RrUDRSZXVXanRLOU52aVpk?=
 =?utf-8?B?RnQvMzQwcWRaQlA0cFNJS2dJU3VYL0ZIRzZJaDl0Vy9vUnBKSE1WQ01SZkV6?=
 =?utf-8?B?bVp6R3J1aloyZDZvRkY2a3hkSUZ2NzQ3UkpNT1pYUEJYL1hTQkNueFUyVlFF?=
 =?utf-8?B?blRFV0oxZGNiZG5Pc1VodmZ2dTlmVWprRWswSjV6NWtBVjZsU1U0Q1VjUjRY?=
 =?utf-8?B?NTlOeWlGK2k1ckl3SlVCVVQvamkvZnN5dDhPS1MwRHQzbThjcngxbVN2UU9N?=
 =?utf-8?B?ZUVVZkQ5WnFTWXhqRFgwS2ZPTkVoUzVibkhjS1pYNVM1ZkRsUDBXYlNVZW5W?=
 =?utf-8?B?WkdBTkxpbkk1UnNrbmhOSEI1ZmtIMG5lUkV5SStwQVdLT3ArWUhTUDB3WU9z?=
 =?utf-8?B?K3dRZGJkUXJicTRwWktXRm1JVjRURVpDbjdSaUVwQiszRGpWa1lDdFM5RTc0?=
 =?utf-8?B?NWNrbG4wWXJqQ2Q2cURrQWcyNE9rK2dhK1JnV2hUVHB3WkdxVlZBb2NOajd0?=
 =?utf-8?B?dW8yb0FPdVRsc01QalN6OFU5NmFZZjF1S01VYWFpaXFCOGdBT2JtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6626a5-bb92-454d-00ff-08dec3029fd7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:01:57.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18mL4yVndxyNOyz1SuD/YXRMcW8gxITdRSVk2oJWB/YofeMOi3Ml90Y2WYTUYhxfokq0wAt+hQ/c4jdi2WiiWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394



On 6/5/2026 5:16 AM, Michael S. Tsirkin wrote:
> [You don't often get email from mst@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Thu, Jun 04, 2026 at 12:21:15AM +0530, Garg, Shivank wrote:
>>
>>
>> On 6/3/2026 9:27 PM, Michael S. Tsirkin wrote:
>>> kvm_gmem_get_policy() sets *ilx to the full page offset
>>> (vm_pgoff + vma offset).  But get_vma_policy() adds the page
>>> offset on top of *ilx, so the offset is counted twice.  This
>>> causes NUMA interleaving to skip nodes: for order-0 pages the
>>> effective index jumps by 2 for each consecutive page.
>>>
>>> The get_policy vm_op should return only a per-file bias in *ilx
>>> (like shmem_get_policy does with inode->i_ino), letting
>>> get_vma_policy() add the page-offset component.
>>>
>>> Fix by setting *ilx to inode->i_ino instead of the full page
>>> offset.  The page offset is computed by get_vma_policy() in
>>> mm/mempolicy.c. The full offset is still computed
>>> in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
>>> shmem_get_policy() follows the same pattern.
>>>
>>> Found by Sashiko (sashiko.dev) AI code review.
>>>
>>> Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
>>> Cc: Sean Christopherson <seanjc@google.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Assisted-by: Claude:claude-opus-4-6
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  virt/kvm/guest_memfd.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>> index 69c9d6d546b2..0bcf6fc08e2d 100644
>>> --- a/virt/kvm/guest_memfd.c
>>> +++ b/virt/kvm/guest_memfd.c
>>> @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>>>  }
>>>
>>>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>>> -                                            unsigned long addr, pgoff_t *pgoff)
>>> +                                            unsigned long addr, pgoff_t *ilx)
>>>  {
>>>         struct inode *inode = file_inode(vma->vm_file);
>>> +       pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>>>
>>> -       *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>>> +       *ilx = inode->i_ino;
>>>
>>>         /*
>>>          * Return the memory policy for this index, or NULL if none is set.
>>> @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>>>          * can then replace NULL with the default memory policy instead of the
>>>          * current task's memory policy.
>>>          */
>>> -       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
>>> +       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
>>>  }
>>>  #endif /* CONFIG_NUMA */
>>>
>>> --
>>> MST
>>>
>>
>> Thanks for fixing this. LGTM!
>>
>> Reviewed-by: Shivank Garg <shivankg@amd.com>
> 
> 
> Can u actually test it though pls?
> Because I think another patch I sent in response so Sashiko
> is also needed.

Hi Michael,

Yes, I tested this.

I used kretprobes to read *ilx on each kvm_gmem_get_policy(), while calling
get_mempolicy(MPOL_F_ADDR) on consecutive offsets(0..7) of guest_memfd mapping:

BEFORE:
page offset:  0   1   2   3   4   5   6   7
*ilx:         0   1   2   3   4   5   6   7
  
get_vma_policy() again add the page offset on top. so, it will increase by stride 2.

AFTER Fix:
page offset:  0       1       2       3      ...  7
*ilx:         128376  128376  128376  128376 ...  128376

It store i_no, so after get_vma_policy(), it will increase by just 1.

It's hard to show any wrong allocation with the bug because this index value is not
used by allocation path, which uses NO_INTERLEAVE_INDEX.

Tested-by: Shivank Garg <shivankg@amd.com>

Thanks,
Shivank


