Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F93C062C;
	Mon, 14 Sep 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395500; cv=fail; b=R7vXqvv7p2uF74xA1rm4DppvRUEpCaySGjbujNoVUT7IhzXuOM1JzjbyK8rdsumKdUTuam5v/9J9cdEGoqUtiGxvaKJK+x2a8Q8mF2ILtaDxFuddcw156TnmWrKTZYZsq2XohfrsyGBx8C7zTzxmite49KRzHeF61ytg6j3gCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395500; c=relaxed/simple;
	bh=wKkmpHQsM6n/2InUYWjfYUt0uvCuaXB0lROX+X4aco4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=au7sTCXSn9dVJt7smNUeHCzznRhuhYQ77K25Axf5sBrStIy6dJHkSmvA7j2tB2CzJeXVYcjMzrDFuYjN/6GByIjtEB+yvmeIZsPiy8BY9qPVtD/uBfvwxfPXSQX7qn38wZMbsqhI5iWPqiwvihpBgcDrkQTKBWSnBh7WUN3mnPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lTYabTZa; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lTYabTZa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+K9c1iX0CRy6SNbbqbwF2voQNkjUKTmjTrGPFiNT3nE5WUXl70uABZaXx6rzW4ToCBvSRA2lgsORpWSv5Sfccgfu8KT+9F1mcWokK7PF0r4QF1P+9STXHEp8WiY0xnN983FknIsTfXCIgNKO5ZunTTR9mlkwdAQNf58y06xBK2t6PW1uPJkb/4H0kIWkwgefWMiiaeOG8EUlbCTImuKzuzVn+wRAxN+yVHOSf5VfXhIr1fqnxx1fG97y2kUa2iogFXly7uHarUjMDDfUihC5ST/QTowcVCaBKNCfNVSWtmTtxYoRroULUdz75TY8BXxdGu7GdVhDhe/j1NhXjJ/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVDTFwZ84eDszrZn1vCHIMG9DFCFvXAUYHPl815cKI8=;
 b=mIlBB68henPDLsdEuW3DUVM9W8huKmt+arDkIpjTGcMfeVmIEg4o0+kUthlY1AlcfJJwtY2B191Svaa+a8BUWobx19lQIWqhqfgCBgTHF6GU9MnAmwLpmhNWFA3BC0/ca+ZbZWupAa9/08sYBEZkvvkT8N7XUMjwJUTXO4hBvcIEDT3w5uhPwIURVv1gPTLjrojcsHhPRndrt1xv4wpptAXm9j0xBrcWCo33dMOnJKwBhh7WvxSQXVMy9tAJXcxK2bqlgKyJpveGqxmnCafgOAu5Hjz0l4skw6+9yh72rB+/Yzq5vJYPxvKUbhK2+pcqCamjkmvZQAYLAcP2iMXrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVDTFwZ84eDszrZn1vCHIMG9DFCFvXAUYHPl815cKI8=;
 b=lTYabTZalZKNFv/uPZOvosePnPg1RtXDV5PvhKWptRrx3vdDDeRghjo3wW/db36IQba3a9VprKoVlPNGGBWoJV+bQbcfGm7afg1CF4kJt/1/I9ja4WPmlDCJliJYJqN6uoD3jLy6XbqpZpnKX5wCQOf1zRUWBqNGX262jNgDEgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:18:14 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:18:14 +0000
Message-ID: <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com>
Date: Mon, 14 Sep 2026 09:18:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
To: Jacky Li <jackyli@google.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>,
 Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:610:54::39) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|DSVPR12MB449095:EE_
X-MS-Office365-Filtering-Correlation-Id: 547e965b-10dc-4654-1ef0-08df126b0391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QJY3h8NWWMfTmknaJwwzPrNM1EW44ycjiB9QGr/ZphLc0jHcyQl1HlKxmS+A1yvN8DKkI6FRFf7xlC8iKpzFNFWOU66A1/3qobLJMsq9GDBgmn9JcpX54fGGguPVHVXWbG69rqfVzbWWbZgh981jw197o80VVdZoFT5MesDcLo7hFEmJAGy8S+FtSRpppRYrp102CoOSFGBvQYnWgNWN75WKLXqIpw6OLv4b47JWL8RbcGiUnQr/4ImFzSOKwnE35TJqkoAfp4rJKQQ3x3PQBjVq5LITMPtbncESSDBL6Or4lRpmBeK2Ue8ps+F0CID5nS8r5lrbJPz5ZEYeX/ffCae+Z9yx4qTXqt0xqG/YkFp4euiNs1hbrRJ0mSM3ClsJ3MTCBqgWPeuvDzCBgVHJXE4LO68T/Xc4HYCLPfuUJ90VO2OvnkeQmqysHdr3TOH9pxn/fvkGqt43zKAzCX+0Qcmz3PwVHz3c/XIlu9o0YQIY1UUIxX3DnfYs7XoHfDA4d+SYhPzhNF85lCSoQRI41Z/Gyr3yGXyIrHh/zIZNN5cjIrPc6/5uQIyk8fg2ggJYV6+vX88gBkVJNIRwlnYqVo3Iw4FiJq9VOemN4L7MrqY+jUVmzmy10UYqfK6yS44OkIRBnrNAxpAvMXFb+M86r6gGspZHJESvsAu4fWol0Q8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXU2Szh5VlEyUGhmUVBJdEJiZEFmdHJIN3FLTVpWaHhxS0kxYUoxcjcvL0hN?=
 =?utf-8?B?MlhoWnhBODY5QzVFeTg0NzZGVlN5alFBSURQdGtUeXl2dDJ5dWJmRmNvcFZ5?=
 =?utf-8?B?SW0vbXZBVmFPK3VmT1pqUjB1VGJhYjk4Wk5tSnBpVHI2eEQ3NlJyaURaTXd3?=
 =?utf-8?B?eGVmS3VKYzlScnBWV2xqVWxVc3VZWTV5R3M2WjRRYVZMaG05NHFSZG5EWFUw?=
 =?utf-8?B?QUl2RXZsRmpkR2Y2ak1RV1VZaDVxRGVTNFE1KzhQaGdVN1A1UE1BS002RVRt?=
 =?utf-8?B?Q0FjTlhmSTZYbXJEZEJsZ0pKcFBOT211SFo4bm9iQUNoOGI1WDZTOTUwMmc2?=
 =?utf-8?B?SUZaUkdCaG0zaE5Sd29mTFpiN1oyb1NpOGF1YlpEWUx2Vk8vUDFVYUNyU2pO?=
 =?utf-8?B?QTlhU0VQVkxOc3pJQU4ycVZKM3d2QUZQUjdrQS9SRm5FdmN0RHZQY2k2Nk8v?=
 =?utf-8?B?dFQ3QXdrSGZZSjJMTzZ2QlRWR2dMMDVHbExzbmtoWXc0K0kwdlJ6QXBwdTds?=
 =?utf-8?B?ZGtpK2lsNHNMNXZlMDhRbWNoWHEzdEN3dVNlMGIwbVp4Q1FjallSMzFIdjFa?=
 =?utf-8?B?amJBdHZpbWVrL1hvckt5M0JYODZLMVpBOXN4OVVoN1YxL2RoT0hUZEJUWlJR?=
 =?utf-8?B?b3U0c2FoYkx1OVhKaWIzNnJhdDNWWUpKRmZ2ZmJMcEFZMlpVTHZTM2s2VlF3?=
 =?utf-8?B?VFQ4WXhOTWRxTXUyMCt5RzcyeUtCcml6NjVZQ1A3czRCZEpqM1hVNE1kZVdF?=
 =?utf-8?B?a2JlazhSNElHc2dJbzBwWXBZSW82Z08vVm1RNTBHWWpaaU5rSXE4SXZBT2tw?=
 =?utf-8?B?YVBlZU9rMGg4SUFvTjR1a2RaeTRtYW84YnNhMlZqTTFSN2gySDdwbGRTQ0p3?=
 =?utf-8?B?YWRCaXE5QXpETkFUZVlnQnB2OXpCNDZXcU5jLzl5MTVDTzB2ck5wc29GUXd6?=
 =?utf-8?B?Sk5idWJhVkdFK3U5aWxIamVMN3lPb1UvNDBvVUR4QTgwZU83cGRGbXlzV0VB?=
 =?utf-8?B?ZWN1VTQvTU1wUDZTNEM5SnpFWXJkNjlPRld2dkVvQUpCa0VGdVVKcTYySjBz?=
 =?utf-8?B?UmpvekJvb2dLVGhMdUF1NWpZQXFVS3BvZExBdlBUNys0RjBQYUlYY0FuZWh5?=
 =?utf-8?B?cU5sM2FjTnBTT0hFbE05ZjNES3BTajJxMk42bzRrZ1dkWFl6OTFtNVJGVENm?=
 =?utf-8?B?Um50QzBiYysrck5vNGwzR0VrQ01uVWIwampkUndiS0U5dEJPc29IR0FUYk5B?=
 =?utf-8?B?QzVqYVNIS3NjUFBEdmJvbXFzdEpJK0VXQVlneE9FUjBZUW85UHo0b3A1bENG?=
 =?utf-8?B?RTU2UDh2Nzh0bVJob1hleWovamZNZE1OZkc3VmR3OC9vSzFRckNqSlBvVkF6?=
 =?utf-8?B?MDlKRjdaY1I0bUx3aHl0cmFBUWdkQ2JMSDVUK0x5R3JyY20ralpjTU1CdTYy?=
 =?utf-8?B?SWMzL2ZCWGhvZkQ0bC9XUnA1NVNFS1pZTk56UWV6ZHRaUUlPMnhPZlJsMGZn?=
 =?utf-8?B?T1hUb1c1WE84MHRjSzlUNGpaVUJJb2lDZTBTa2J4eXk0bmY0RzJBSzVrQTIz?=
 =?utf-8?B?YU1YWkRQV1lQc1dYL2VLMEc4RmVrSEZGTk9uYU8rdE1GVEZzZDZ5Z2hnakdV?=
 =?utf-8?B?WFBXZUxpTVV4djd1ZzJhRk9qOVpkRGo2Vk5WU01XMG9qM1hxRTFaSWJUNWQ1?=
 =?utf-8?B?cFBERzU5Wm9PSnFEVXlpQklNSWNqZlNwVXNDTlBNc0lvelBQRjhLNDdJenMz?=
 =?utf-8?B?WDRRMEk4TXhSeHJLNXFheFN0RWkzZ1NTY1c0SkVjZC93VUFlVlMvajVVZXRl?=
 =?utf-8?B?V20xT0tVVVNtSnFJUlgxTmpKVDNGUndzNkxyUE14NVNpQi8vdXc1YVc4KzIx?=
 =?utf-8?B?bU1id2YvMzQ3OHhBRmpJQjE1ZXo2UENIVkE3bWY1SGNETUdBV1NzeDR2aFpD?=
 =?utf-8?B?VHdNMEtUektDWjNlYVFCRFExK25DVEppNU9nUXk5OG1SNmt3Q2ZKVWVXb250?=
 =?utf-8?B?azFwRndCZDNPSnB0OEI2aXlFUHhBNVkvM2FBZmNQWWQyR2RzUVVkSFE3a3pC?=
 =?utf-8?B?M2J1OTJGQjYvRXRZNEFDN1h2VkRjN2J3L056ZFVQbERNamY4T0F6cFJlSUFE?=
 =?utf-8?B?UXF3c3JHWUpZcGNuSmx6czNEbkNlQWF4YTd3aHNQOVp5YjhOK1VTQlBWSVFQ?=
 =?utf-8?B?K0V0dGVKRnV1VkJqckpxQ3BwQjBzb2ZrMzdoUnNySFJKcjRCSVBTUzlzU1lU?=
 =?utf-8?B?dXBReG9oWnF1QzJ1SnQ2aTNPVmNxUFI5TGRiVDlMSGl4M216MGVSY2hKRVhO?=
 =?utf-8?Q?4xdDz8VOyQxBxR2WZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547e965b-10dc-4654-1ef0-08df126b0391
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:18:14.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KRHKjqWw9R72oDbB1yiZCvAMTPS1t1Mmkx/vYVXXkamr5b1GyoMUks3qCL/wcF+nWwOdYJjQVlD5WLOGsIw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB449095

On 9/10/26 16:06, Jacky Li wrote:
> Currently, snp_handle_(ext_)guest_req() returns -EIO when
> kvm_{read/write/clear}_guest() fails while accessing guest-provided
> buffers. Returning -EIO causes KVM_RUN to exit to userspace, likely
> killing the VM.
> 
> Fix this by returning GHCB_HV_RESP_MALFORMED_INPUT with sub-error code
> GHCB_ERR_INVALID_INPUT to the guest and resuming the vCPU.
> 
> Per the GHCB specification, guest-provided GPA buffers that cannot
> be accessed by the hypervisor (e.g. private pages) should be treated
> as guest input errors. Because kvm_{read/write/clear}_guest() only
> returns -EFAULT on failure, treating this failure as an invalid input
> aligns with the definition of -EFAULT ("Bad address").
> 
> Returning GHCB_ERR_INVALID_INPUT also matches existing SNP handling
> in KVM, which already returns this error code for unaligned or
> overlapping buffers. It also aligns with other hypercall implementations
> in KVM (e.g. Hyper-V returning INVALID_HYPERCALL_INPUT on
> kvm_read_guest() failures in kvm_hv_flush_tlb()).
> 
> Performing upfront validation (e.g. via kvm_mem_is_private()) is
> avoided because it is prone to TOCTOU races with concurrent Page State
> Changes.

I'm ok with this approach overall, but will we run into a sequence
number problem now?

If the kvm_write_guest() in snp_handle_guest_req() fails, invalid input
is going to be returned, but we will have successfully called
SEV_CMD_SNP_GUEST_REQUEST. The sequence number will have advanced in the
firmware, but I think the guest will not think that it has and not
increment the sequence number causing subsequent requests to fail. At
that point the guest will need to zero out the associated VMPCK used and
move to the next one (there are a max of 4). If this continues happening
the guest will eventually not be able to make guest requests anymore.
But, I guess, if the kvm_write_guest() is failing, we're probably
already in a bad situation, so maybe it is fine.

Thanks,
Tom

> 
> Fixes: 88caf544c930 ("KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event")
> Fixes: 74458e4859d8 ("KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST NAE event")
> Signed-off-by: Jacky Li <jackyli@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5705723f1f41..d07562310519 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4228,8 +4228,10 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
>  
>  	guard(mutex)(&sev->guest_req_mutex);
>  
> -	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE))
> -		return -EIO;
> +	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE)) {
> +		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
> +		return 1;
> +	}
>  
>  	data.gctx_paddr = __psp_pa(sev->snp_context);
>  	data.req_paddr = __psp_pa(sev->guest_req_buf);
> @@ -4244,8 +4246,10 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
>  	if (ret && !fw_err)
>  		return ret;
>  
> -	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
> -		return -EIO;
> +	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE)) {
> +		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
> +		return 1;
> +	}
>  
>  	/* No action is requested *from KVM* if there was a firmware error. */
>  	svm_vmgexit_no_action(svm, SNP_GUEST_ERR(0, fw_err));
> @@ -4296,7 +4300,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
>  
>  	if (kvm_read_guest(kvm, req_gpa + offsetof(struct snp_guest_msg_hdr, msg_type),
>  			   &msg_type, 1))
> -		return -EIO;
> +		goto request_invalid;
>  
>  	/*
>  	 * As per GHCB spec, requests of type MSG_REPORT_REQ also allow for
> @@ -4336,7 +4340,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
>  		 * certificate table is terminated by 24-bytes of zeroes.
>  		 */
>  		if (data_npages && kvm_clear_guest(kvm, data_gpa, 24))
> -			return -EIO;
> +			goto request_invalid;
>  	}
>  
>  	return snp_handle_guest_req(svm, req_gpa, resp_gpa);
> 
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-snp-invalid-input-5dbb6a408e7f
> 
> Best regards,

