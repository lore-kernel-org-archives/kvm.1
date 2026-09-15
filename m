Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF73E1201;
	Tue, 15 Sep 2026 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485674; cv=fail; b=c/7Msb3oPzxQcYuh+rdhUPgK1SHvJduMBrMvINEJldGcr1v6t36fHGcsLoup7RUX9Nq69IIduDGIENuzsoILgLqXl7zqSJ7tSGx+8iZD16FJu0aG6nlwfCxoRk3MTMfyaI+6sjpX1+ecPYbPF+zBWKzoWDyeDPt8OmSgOOQwffE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485674; c=relaxed/simple;
	bh=ib5JR7DzMBydSfOvgaHUs4Yvu/a7ftoCf0OcrEC0ZMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KjEIh6ESEJnmLD9HtKpbyUPgtkgFQpY3I6cBCQBXNudlS/O5uKYPFG8IIkxoxwHsmUI7S+ZMFpgS/2GzcWEjnIIe515qtSXj8FSUWwULKdoTHFDTZhWIj0OsUHsXiwwTmKxkDACO5mD3ODfERUnFWRu3V9msraT960LVEWNLP7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DR/9nmu+; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DR/9nmu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9QyIh9ccoDZYrydQU+oiZnjZJnqY35ZCHciZhAUpmRaOQsL18a8naxdPR5RgThJ4iZEDbXvkHdXi4sxFkbYnmZkLJB/08LVjZGWfCATGP/me5W0rrp3b8geINgRasPr4XdIgUSQwpsLO1CjOmITcV+Or4MdX1c8v4D/3QqjNfa/5G8hOXQ4uhhAQIn8N8UTAxEfuIjVL2LPTx5tI0UJ7CX20UPA5Ruxhv0tI04Ih4yZfhOi1iwfqEtToG/pYxcOOc8+0f4YXt4wvp8+50QUz2teCSAzDJeUccce33FHfhasgyYOfISjSULFeQnnhaGktkeBJ054xUUqPFbhCZCARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLmEHzitxFQ+WzgmwwGlCu/uKTdscgLtFhrDW7yMKNc=;
 b=wOaouFVxbipcPdTEN2hj1dNC8E7kxvsXt91H2wAAbfruuYCRGjFTNy0dKFGKD280BYAeyB95Z3fjmNTbKwI76NI42UO2OhfExJX3K/e0o4JzVmsxCEtih59p+MfXa3zHQMd3IlYcSAdGjMZLaW7ePxH/O/LYiWQHt1XFoC1l2rpgxwNMi2emyntYb/OM9HzetIQm3xpJinubhIFoBxULjh5Bzje7nLrYdSsjOGx3Zg07T/tZw+oAoxodNeIwzo0QqCN4XmSSVt2rubp41n8+yHoAlYCpBxZR04K230/BityrW5i4/uYCqTlIbyIn8CkIOqkWG5dy5bodsyFLnsy91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLmEHzitxFQ+WzgmwwGlCu/uKTdscgLtFhrDW7yMKNc=;
 b=DR/9nmu+HzDHFVVziFznbMq1u2+zmq2CO14cJjHA4k+drJBhVidm2HR3grqyz4Xd78sw1QZAWvquVWpwIPFZMU1kEBiQOunI9u9lD7lkRCwtu0aieCDszt0F7vhDzp5d5/A7VEdVKa9VxUdlAdwAzGyviL3Yf7nDVLuPXa3J4j0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 15:21:07 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:21:07 +0000
Message-ID: <d6179d34-a4b0-4548-8298-b790b333d22f@amd.com>
Date: Tue, 15 Sep 2026 10:21:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
To: Sean Christopherson <seanjc@google.com>
Cc: Jacky Li <jackyli@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>,
 Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
 <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com> <aqlWt4jb4CSPnecN@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <aqlWt4jb4CSPnecN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:610:119::6) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: b832de12-d742-4eb9-9499-08df133cf6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZyBx/TPPyUVfUuhgKjsx2B7A4d0NkI1t0FUaueJdzOW8jXqhd+sTEs12fnMqXnoTyvLvIZU4TStDiHomIL8Z5NGd+onBXeuRK+RAuWD654KszolPaGYpmEOo1U8/T5Sbo13LSZuqgH5wDcPf1BfenKe+1ZYXIMKTR7guB+QEpqPx6Y/hxkmdlF4M5LPiyfdcdfF+6ft3G3klWT+EzVKLFV5QoEQNT0TTKyaRCJMW6+a24feSq4ftXiGzw5KxxvM4hZeVnYNkt+gAyLKGQm2fhrUOA7u/TMahAmiizBn54rGnca+4C1u0ZasUEnWyyqiUJ0EtVC+GQIiYLbj0uT1JRYrVxr1zEEqHS4PxAM268RPnkw8Mx06L5gwN8mhAIDBTPKin3giAqpGazrz5xTpeTOzpejUpGZeuoBVupqR5CHWwYQAvCmqOxCquUpg3MfmEEzr4rIXjC7qAYwaRfgU00qJ4BLRO5jBMLekRR63rHKStMYkXDR+5OV6YVquSWqr8jK1HtYMKsWc7ZXQ0H6sRse2g59cHw9PwJh4JGUlw0lSev3HeKqNUHs6bdwjPX0uo9b8k4+/SSnZ2b5Dy3uPv/tU+1dtQeekoC9E08rm9/yYb3/TL+n2ORdh9GxUf2tV4sGXA4qp7uC1N7kS11m30DKQ362wkw6Nb0eesd1UqiYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlQvRVR2YmFXN0JVbC9GNkphNlAwRmpTREFsSVRySFFndlhMRlprNjRJRW51?=
 =?utf-8?B?ajZDbW42dDM2U214d1ZrdGU0YmRVaUUySUxRdU53QjhGZEFsNWRUc1FMcGpL?=
 =?utf-8?B?a0RVaVJUcENWYmJjcUhoRUNuUDRyYXJ3OEl2TjlVSE9nTjFzdGhySFM3aDhU?=
 =?utf-8?B?SkxBajhrYVBGRTJ4YzNJaStVZjhBYTU0bFRKeXpDWDJCZUdIbjFqLzIyUTQ3?=
 =?utf-8?B?bm1BNDVDNHhBU1YvL0FsZnRmYTJZZU9IcDl5VjVzdCtXZUhyYWtFN3p0L05C?=
 =?utf-8?B?eml6SUoxa092YmtlU3ByRTFiMmNqTUc0by9uK1hyV3VtWVVPMlZ2Z1BxTFUy?=
 =?utf-8?B?OHhIYzlnV3B6VGZqRE1BVHlIbk5KWVpYRi9BVnd0eUhkWCs1SlZDT2ZvNkJG?=
 =?utf-8?B?ek1jK1puT0JXaWV4WGpXYkFIajBDN2RMdHE5VTVzTkVqWk1Tb04yUE5tSzVJ?=
 =?utf-8?B?UzFhb1lDQnFRN2FrdFVGT2NGbkVZMlhucXRzSkF0UFM3Ni9oTTlMamRmUThW?=
 =?utf-8?B?ZC96UW9PZGZ1b3NNR2xHWksyMVhBMmZiTFprVWk5eks5NFZhVXRITTQzRnJQ?=
 =?utf-8?B?aVB1YVNCYjU3NWcwZTgxL2xTWkZlMXVtYk1qL2owVGhWaWU3MHZQNFFMQzNG?=
 =?utf-8?B?QzdOdVBSYmZ4dHAzd0lLbTR1ZTZydEtQcXYySHZNWXBDeXBsQjVhdmxRczht?=
 =?utf-8?B?ZzhsZVExT3dGVjk5RytqZ0tFaDZzMzkxdmZaTEFYeTYza3VWZVFSVjBWZFpN?=
 =?utf-8?B?eHNMQXpCcmszLzlFQzF3MHI2dURiUDA3Mkc4Zm5FTG1yQVhOWk5uRUU5TUx5?=
 =?utf-8?B?anc0NloySVJWcUFJd3Flc281QVBobzh0MGt6NmJ6d3BiTmNqREpiaE1oMkdU?=
 =?utf-8?B?UWNyS1hOaHR2VVlvSW9La1g3aTBEYlk5ZWZHMG5Mc0tZaDdxRWcwWXJ6b3Jo?=
 =?utf-8?B?ZS9QUXFwVVh3bkJuVVdWb1ozcitaRlViSGNLZVlueUVsTm9sSmRDbXRjOG9E?=
 =?utf-8?B?RUU0bEFQZXpicmJaVmJ4VkNTSlp2K3NCd1ljY0RIM3NPTUk1VWtVS0ptY2RT?=
 =?utf-8?B?QkdyNUFWSlVzampvZnpiUzNDQWVHdjhYUjE4MFFqWDhVRWY0RXd5WWJ0aDdv?=
 =?utf-8?B?WHBWT3dGdzNYZ2hRYjIvSzRYMC8wWDVIVjgxMU9RaUtOM1cyUzM2dGdlenBI?=
 =?utf-8?B?RmNXNmkrRUxRV3BSNERRckdFYlpTSHFNbERhejJkV3dydVVPRUFnWUNxVnFX?=
 =?utf-8?B?VG1WdktnQ3gyenluc0VZbjdxUG1IMFpCaGNKRER5OTRNd0lRRkpXamxJQVAv?=
 =?utf-8?B?NU9KTkJhRlRobUdtOElVUUFhWWFobEJHWjd0TnZUS0UyZzdBUktJZTIySFNG?=
 =?utf-8?B?WUlLbXAwVlNMM1lxWnFoMlJRclZXUkltYnNLMUVYUmx3dG9qYWx0RC9DSXF2?=
 =?utf-8?B?T0RCTUcwbzJTVm9nZXhiSEhtZ0c1c3pWa3A1WDZORmt0d2VwU0dVT3JTVjJD?=
 =?utf-8?B?eSt6VWg1VjRqenAzZU9oUEE1YUk4Rnk2RjVJczErMnRicktsbHA4UDIwbEZE?=
 =?utf-8?B?T0tFTkJydVFJYWhMekpmWXkrNmRuYzBGM3QvNm9RV24zTVQ0cXVoRWVCa2hM?=
 =?utf-8?B?WnY2dnNJQ3U5c2FVckp2MFFRZDNUOWtIalVSM1RnQWo5SFRkS0JYbVFVRDRY?=
 =?utf-8?B?OWRtQW8vdWJySEVjZEdOTXF5M0FCc1VGYmEvck9RdDM4YUNrSGExR0ZCUjc1?=
 =?utf-8?B?V0QrRkV3Q2U2YUQ0bDVOTlJKWnYrWjNSclRpTk5YaWpaazlaMVNMUFlacjlS?=
 =?utf-8?B?S3gyY0l1UUVUU0VxSHo5WjFXWGtaK0JxOEE2S2pyQWk1Ny83NGIyZkx1TDlF?=
 =?utf-8?B?RzhlZTB5QTVBYTZ6WmpFRWx6b0FBMC9IS3p0SFQ3M2N3SGR6V1FRMWZEZkdt?=
 =?utf-8?B?N0VhalZWbXVJQml6Sk8rejNNbTNWczJyTlQ4R3pyaHlqMnFDbVJka240c2ht?=
 =?utf-8?B?b016QkJnb28rNWRqbmY3YUZhbzVZQzNXTmtsYnRkOXFONGNGdmdad3JaeXoz?=
 =?utf-8?B?NUFPZWdmcTVXaTd6RUg4Wm1XcmU3MVI2SWtDY2lwbnJ0LzQ4bU90dTVQeVcw?=
 =?utf-8?B?T1JOUmx6SUtHRlNpTE44dWlpTFpGcjNydDlqd0V6eDZQQWlDNHNYSWQ1UlMr?=
 =?utf-8?B?Z3JEdnBLR0M1SjNsaDEzMlQvUVhNQ1JhRzB0ZTdGMWIzamZZTGZlUXNxUnZo?=
 =?utf-8?B?NW1PZWtWcW9Ta2hJZzloLzIzUDhSRU5RSFEvZVRkWHpiSkV1UEdzVnFuUGxM?=
 =?utf-8?Q?3u2+qHvxUTjOfKzOx1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b832de12-d742-4eb9-9499-08df133cf6c9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:21:07.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5lAK/Aozt7Hf05u85Jud4Aa592MEsB/hQQuMj7cZ87xfu5ctj3K3PpLB41A7WAE65VQ+oegLtgzR/F7o76Z+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

On 9/15/26 09:31, Sean Christopherson wrote:
> On Mon, Sep 14, 2026, Tom Lendacky wrote:
>> On 9/10/26 16:06, Jacky Li wrote:
>>> Currently, snp_handle_(ext_)guest_req() returns -EIO when
>>> kvm_{read/write/clear}_guest() fails while accessing guest-provided
>>> buffers. Returning -EIO causes KVM_RUN to exit to userspace, likely
>>> killing the VM.
>>>
>>> Fix this by returning GHCB_HV_RESP_MALFORMED_INPUT with sub-error code
>>> GHCB_ERR_INVALID_INPUT to the guest and resuming the vCPU.
>>>
>>> Per the GHCB specification, guest-provided GPA buffers that cannot
>>> be accessed by the hypervisor (e.g. private pages) should be treated
>>> as guest input errors. Because kvm_{read/write/clear}_guest() only
>>> returns -EFAULT on failure, treating this failure as an invalid input
>>> aligns with the definition of -EFAULT ("Bad address").
>>>
>>> Returning GHCB_ERR_INVALID_INPUT also matches existing SNP handling
>>> in KVM, which already returns this error code for unaligned or
>>> overlapping buffers. It also aligns with other hypercall implementations
>>> in KVM (e.g. Hyper-V returning INVALID_HYPERCALL_INPUT on
>>> kvm_read_guest() failures in kvm_hv_flush_tlb()).
>>>
>>> Performing upfront validation (e.g. via kvm_mem_is_private()) is
>>> avoided because it is prone to TOCTOU races with concurrent Page State
>>> Changes.
>>
>> I'm ok with this approach overall, but will we run into a sequence
>> number problem now?
>>
>> If the kvm_write_guest() in snp_handle_guest_req() fails, invalid input
>> is going to be returned, but we will have successfully called
>> SEV_CMD_SNP_GUEST_REQUEST. The sequence number will have advanced in the
>> firmware, but I think the guest will not think that it has and not
>> increment the sequence number causing subsequent requests to fail. At
>> that point the guest will need to zero out the associated VMPCK used and
>> move to the next one (there are a max of 4). If this continues happening
>> the guest will eventually not be able to make guest requests anymore.
>> But, I guess, if the kvm_write_guest() is failing, we're probably
>> already in a bad situation, so maybe it is fine.
> 
> Oof, "fine" is definitely not ideal though.  
> 
>>> @@ -4244,8 +4246,10 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
>>>  	if (ret && !fw_err)
>>>  		return ret;
>>>  
>>> -	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
>>> -		return -EIO;
>>> +	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE)) {
>>> +		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
>>> +		return 1;
>>> +	}
> 
> What if we keep this one as -EIO (or better, change it to -EFAULT in a separate
> patch?), but add a comment explaning why KVM needs to exit to userspace in this
> particular case?  That would be a good compromise; if the guest is attempting to
> access non-existent memory, the initial READ will fail, i.e. we still get most
> of the behavior Jacky wants.  The only fatal case would be where either userspace
> really did screw up, or the guest managed to find read-only memory (though I
> would probably argue that's likely also a userspace bug?).

That sounds good to me.

Thanks,
Tom

