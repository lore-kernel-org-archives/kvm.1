Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089E2C21F0;
	Fri, 26 Jun 2026 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505319; cv=fail; b=Q4vZU3r/cOyhwVa9JdP6/oVFpn2ylbnqK5Ib2byNk6mlRCFLS+EJ18t8qyM66q1ivaXIW5zQYAogWZU/I8IxGfDKFQ5dTwylneQYjYAB97qTxo7eMiIEp/TTnkJp+tsvX76pgIfcNXdk743yC1qlDS6ceHBQqJctl7qPToL9RJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505319; c=relaxed/simple;
	bh=70vo8ap4q/gWdvtRyS8+sxtaZBePcsrQ1w79jby/+bo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rAZrXPDIIIiEA/Oq7yt0lrhwVNLj138NRY/6Ic/QhXuxqmuPGlwzp6YFcsWwySzL5v4tbN5WPIUqfTNDYTI63AXZrSTLPQs3SUjRB91lQNGL7tJItwZ7Pm/S2N6UZys/B6gR0GhXJbBe4WNI/sl4YDoU8LQVMWQbGxNZU3Hjeb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L6Gixyi5; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L6Gixyi5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrxeC7kzW29zOZzzzIkOFK3YSgFA4SNU4L6LaNL8vP5R+ZmMhLU80T+6mFnuvxMpb07sME3BWV3DhDx/cOlfON8EvlUnf/5znWURV7vpAIxnKsu18f2djW2hN0iGttxyRXinjfE+LRibi0T2HoYTXjnbujdCL/yaZyr1dZvYQoc++kErS4K10kMcmN55uY/F26cNym9OlRIyWl7JaWnfarUMdM1y0nCUcclzLxodwoaRR53gnX/XuxgqJJ1kZ+yKikbGj/aaF0xGTNaKqMZWCK/Oso7Z1MzmrlpSh2VsuKfU9MmBl3VqImbkX44wMFc3V3YFU9e43qQTOqpRnbyjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN4tpXiFvEOdp1noKZ785Vs/MPeFaIzcoXS7eNHHfXc=;
 b=tUPv5Mi6dc2Qyo0O5FNwmJnCyH/CKDx5/HTPwS7wkyKEiXr1H2Ssq1eqH4YYfAPVjtRpvUzheQCs67gjxWTsrNY6SRkKLWhC9D9eocHurBJ3mDv7goki831klroir7JXNcBeyhrWhx7l+SZTjJG+qrplYEin5IhW1wQKREh/JXBsllKs2ZcxF8dh/juHtlQGphSNSKicy+MkI2CS3FSuvZsUjP8yGTH9MnhbFvcaDjEWtiQ0E+E3dRIplM4dxRlpXwoHkaVXvpAYbMWJu48S3kFqfapu4Z6UiYzee1HaLrOUAKLJ4+T5LqRFI4Iyqtc+XsJBO7fPFPyU2IZaHeevxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN4tpXiFvEOdp1noKZ785Vs/MPeFaIzcoXS7eNHHfXc=;
 b=L6Gixyi5wP2y9n9ks0ozviMwC2CVnASFiYUaAWFU7Beze/66U7/uaDgDongfkzo7sl/PLys+iBavns3E1ZE80A5c/8kOFIKBGPaPJChKPFWEaOG0W9JMRbQsyTrJvmcm+owolGzqaMa0FurwSzfR8q1qEHfkcGYaGney5esG4PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Fri, 26 Jun
 2026 20:21:52 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 20:21:52 +0000
Message-ID: <b3b60c37-aaf5-44b4-87bc-6aacd49be717@amd.com>
Date: Fri, 26 Jun 2026 15:21:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kvm: sev: Fix user-space triggerable WARN_ON on
 snp_launch_update path
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Joerg Roedel <joerg.roedel@amd.com>
References: <20260623091556.1500930-1-joro@8bytes.org>
 <20260623091556.1500930-2-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260623091556.1500930-2-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:610:e6::14) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: e284c0f0-8520-49a7-75c6-08ded3c08f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|5023799004|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fLU0INmcf3wB2kNPUw12LQEwEjncU6594pXkKGJHRjaocdZhSX73I8mtaZc5E76MASwtBU7krYbBx5xxTDR7H7+dSrWuKHeabpvLkdZCwKzzvvUotGrYMQw2VhmGp2Txpg+wliBEsKsR/pDLYwnn/AQxDLZ0KwcWgMj0eLFEaQ5h+BEVzRKeBBjiQm2RLvAyL2gxul7TnFALAI8PG/3rx6bZDCo9OLGXzf+u1rDLrW3t13X++NWuR+d/KCLPVTdAnL8QQ3WuvC5MOQAOQI21ToiivyWsndUABBG1KS3ChbaKMoyGuP7p89Zjaq/dmmQij6fycTkzi9GXinB9lTkyCmrMz2sMXUNNHwxBivHxZIznxLCYBmaImlQYiNkjJ0Dt+uA5P0CH/0bBY/Pc957xgjAKf4Cxgq/3Kyx7ei6xOT85jtsDA6hTuHyzQy4NWfSD3cSBqsAYE0Fze9lFsqH1ctoecoVZMG/kufMsb/Hr2YuZFmt0++Sd9AGNLRxbfYCDEJuGsK4b66+ec5cMteS07gzh5meSkGCc+tm4LWq2Njkf3yLfqGtDcjTuDSdvovsD308rCseBDf7BKNplDzy7TWBDYbHlxo+DiTBaQPDod1+uPiHC/UY+yCljQB7ICn8ruFR0Gw9BqNhY6w8aDQxYSO2cVzYXqMsa73BRJZ178qc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enlubFlaVTFrMjJCREMyT3F5L3lOOEplTFJQMk9xWHNOLzQ2ZDZPdFc1VSty?=
 =?utf-8?B?emRTdU5ZVVdYWk1ENGMvNGJRR3ZpamYwQkxwTk5QSXNJVWl2RitIODIxOHlE?=
 =?utf-8?B?NnRXaWR4Sk5tUis5MWlycithRGRxNms5dWM5YnpodHZKK0l4d1dUT3NtWGs1?=
 =?utf-8?B?RVE5Q0tLbXpxVzMwSTdIaUI2eGJNTHljM3dQQXVLNFVpVzZCSEpweW1hZHpT?=
 =?utf-8?B?a0Nxb2ZmVlNabGhmRzl2RGdUbEhNZ01DaGs1Uk9TaDdJUERCUjhYK0cxQUtO?=
 =?utf-8?B?QmJZRmsxNFQvaEVwQWpRZ1NqaFgzVTlrbFRJUUUwZnlWazlkUm5WVUZORlRa?=
 =?utf-8?B?VnMrZHFnUTE3UUo4dmwxMTJVZnlrOUx1Mk5mNVM1TlhYb29TWENYV3lxSUoy?=
 =?utf-8?B?RWQvczRVYTZFNUoyLzZBV1E3Z1lnVGJqclY0c3hINGZCVVRsMmE5ZlZGbXpi?=
 =?utf-8?B?VjRzY2tJUWdVSUcxOGtXQmEyWEt0OUlobU5lUmIrNUQ3bzNWeUs0NmpYZCtP?=
 =?utf-8?B?Ylc1L245ZGlIblVZeDg4VVFkelBxdVNxSUNNTk5UOHhMK0dzeEY3bmx1dnFQ?=
 =?utf-8?B?a1dyZEJkc0hzQXBKMlY4UlNVV2N0c3ltcFlCQTY0MmN6Z24ySElmMGRLa2Va?=
 =?utf-8?B?Q1ovbFZHLy84RStEVUJRV25tMTBNOGdZam4vOTY2UmxXMTYvclQ3aW1FNWNw?=
 =?utf-8?B?M2FELy9yeHlndndZaENweUYvTHhoMVQwNEZqUnBJdm5xVnN4YzdTL0lkdkNu?=
 =?utf-8?B?TE9TODdHWW9ISFA0TlNLZXdkNkxTTCs1Qmw0UTk1UGVpeTY5S3Z2eHpCYzVU?=
 =?utf-8?B?eFowV0J3dDU4bG9WQWVEZ1R1TFhYMHFhakZGMGM2K3duRldtRVVkdjd0Zjl4?=
 =?utf-8?B?dEdVRDJ6UiszVmU2S0hvZ1JTdmxhTE4xZ1dBUzJhU2JxWkJnMndqUWZJMXAy?=
 =?utf-8?B?QlQ3QldmRTlVdy9KZ0dVMHJkdTFYV0ZhdFVJZk5UT3VtVFI5dWF4UXFlV050?=
 =?utf-8?B?Y1puMGY5MkhaWmFaRnZlYzFQQkhGdjlrbDZacFgxcEpQcnAvSisvbjVHMWd3?=
 =?utf-8?B?QVFyYXhhZE9FdlJUSk5TOWNzMTREaGNZWHAyM2F6K25tUS93S1Z2SVExWGNJ?=
 =?utf-8?B?VnFJalBYN09TYk1DNmcwWjk4dUs1OHJyY001V3FRdFpBdjVLSVFrTVJiNGJk?=
 =?utf-8?B?UzJhL3BzUUM5UTVkYjhIWmgxeVZ0NThLOW1JUjhjRlgyMGEzNzg4bUwwWjRq?=
 =?utf-8?B?cm44TjdHeVE0UmNFYjUzMlE4Ni9WY3dIL1BnWUVGK0o4S29OcmJhcXBpUTFp?=
 =?utf-8?B?NjVWNWVsaFFYaFpmZDBENEY5RFF4MW1FTC9ZalFWWndKd2FJV3ljNDhpQkFw?=
 =?utf-8?B?ampWYmFYZU5KNkMxME5CK1EwUDZHNHpMSnpGbEo0RWFXQmlBVWhwNkNaM3h1?=
 =?utf-8?B?d0dJdy9xNk83cUtqZzRXSTc5TnFaZllUTWFVK1RCYUI4bDNrSjhnUEcyL1pV?=
 =?utf-8?B?cmRyNGhydVBJN1JJRmpTeThXMmg0ODQ5MzlqNlVYODhqY1BtdTR3VGNCUWIw?=
 =?utf-8?B?b05GRzV0SVQ0WnBYamVVeU9FNXg1WDdhR3I1S2VRblZYMHJCdG5PQVZXOHVh?=
 =?utf-8?B?UFB4QmJWNWJTMllOSWRwWldZcG5WNVJEQ3IvdzRjTmlRZy9pSGNKd2hWdDdw?=
 =?utf-8?B?eVJDNjdhZ09HWktiMFZJcTlHc012YTJWaHNRdzlhOWZ6WXpHVEg4emM0c2Ns?=
 =?utf-8?B?QjdySFB3MjB4QWFjM3hsenUwNkxERjlrRWpMMkdSR3E4aFprenlsVjdLQkF2?=
 =?utf-8?B?KzVxVllPNXF4a3htODJQSlU2MmFSTlY1UXAzYzNqalJJdzIrcXZZMnptakNJ?=
 =?utf-8?B?MG9CSzlGc3JJSkJPWWg3MEk1MTYzcmUydU1FWFFTVVlVcVlhNUVMSm5ya3dk?=
 =?utf-8?B?T0JHV0pKTzNOanJ3MUlhL2t6ZFdoYnc1WE9zaTdWN3IxcU01Z3cwZHJ3OTFV?=
 =?utf-8?B?b05URmNLTzk4b3BtSXhZWGNpVTVkbHA2bkF0SUtuOHlDK1NDWDFSRnVNbnZm?=
 =?utf-8?B?WHBteEE1QVdMQTVZcWRIc1UvZ093b3dsWG5jcExRVUozRGZINlgwb3l1Ujl4?=
 =?utf-8?B?NXZ2YXhDRXFhVVR0RHdVQi9Ib2ZTTmpxT1h4bnlGWHZZYWFydGhVek5IVW93?=
 =?utf-8?B?VithM3c4QVdXTGJjOU5nSnExbjBjQ3ZwWjVDMVVXOVBzZmJ0TlUrTzNHYi9q?=
 =?utf-8?B?UGJaSERCNlJmNFBLR3AxR1Fta3I3bVdIM0phdUJDbUpWbEpWNHJ5SWxZUGFI?=
 =?utf-8?Q?RTEwsh/kD9ha3EGxiN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e284c0f0-8520-49a7-75c6-08ded3c08f4d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 20:21:52.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfGc3FUHtR+PfFVbsJ+hsTAHPG5q6XTAkaM1ECpCVUhTTiZ7Kg8UvmIjO9YotVux/h6bPKkOX7FoqOfq6rNUQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

On 6/23/26 04:15, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Sashiko reported on an unrelated patch:
> 
>   [Severity: High]
>   This is a pre-existing issue, but can a host userspace process trigger a
>   kernel warning by passing a NULL user address (uaddr = 0) here?
> 
>   If params.uaddr is 0, src becomes NULL and passes the PAGE_ALIGNED(src)
>   check. kvm_gmem_populate() skips fetching the user page and passes
>   src_page = NULL to sev_gmem_post_populate().
> 
>   That function then unconditionally evaluates:
> 
>   WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO &&
>                !src_page)
> 
>   Since the type isn't ZERO, won't this allow an unprivileged user to spam
>   the kernel log?

It would only be one warning that is emitted, "spam the kernel log" sounds
like you could fill it with warnings. And I would say that the severity is
only "High" should the kernel be configured with PANIC_ON_WARN.

> 
> The assessment is correct, so check for this condition earlier in the
> snp_launch_update() path to avoid the WARN_ON_ONCE.

I'm not positive, but isn't it technically possible that the userspace
virtual address can be 0? In which case, should this be fixed in the
kvm_gmem_populate() API with maybe a new parameter that indicates whether
src is valid or not?

Thanks,
Tom

> 
> Fixes: dee5a47cc7a45 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e29..41dcba5180ca 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2438,6 +2438,13 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	if (!PAGE_ALIGNED(src))
>  		return -EINVAL;
>  
> +	/*
> +	 * Make sure user-mode did not pass NULL as src with
> +	 * type != KVM_SEV_SNP_PAGE_TYPE_ZERO.
> +	 */
> +	if (src == NULL && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
> +		return -EINVAL;
> +
>  	npages = params.len / PAGE_SIZE;
>  
>  	/*

