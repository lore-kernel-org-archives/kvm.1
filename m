Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A929405;
	Wed,  1 Apr 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048015; cv=fail; b=S4zCiF9Z0yljysH+SNwNnLzERv/HVTNpFL31qCGMHOWyN4VOq8TjVZSoWkAgfYFqob8lZpbnNb9xVlg2sK0nJRe5woOnPT2tSWvk8RtclGdoPKe3Aq4Vintvi8BeTfnz+4JQk3UXg0poG+IofeKPoFAumY5PoSGerfklOT7CHtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048015; c=relaxed/simple;
	bh=7mS9MVMuROrJiBvnv6vCJkOXvLcLueI6SI9fRHsVud4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFuUrTqcp4Lxc2JuqP47pNws3fvXn870LDJo4rVYH06SChluBbjTC445A2xerE2K7v/gKt8Gi8yDHAL6YXu0wJCJNRK0ImZ+W7ZsusedXGL1p0FYEoDWkY9u52cVuRwqkN6E85W8iFxxwsQkk+nTEiPv6w4LrIWm7pOvhBlbPr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BeQEH5sS; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BeQEH5sS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiUEtq1AApLxscpFCSydkFEtu4DDijcsfc5hoh7OTgOA81357TGIPYWXd4ASq+fIoltFO3541oIJOL96mlrjfAr0LOFh/E0NqNPWdVRaFTgybsJYRqdVfkCTpy0CeQPRo7BeKpxShVeP2fFP2u6zowBb4IfRn73GKXDADDbNiYcfWIHDK2EMUQOFru40cR2YtWC+bYd4Pb7Bdp6kcHLUs9GA2NSDtT2OP2uZJMaPOiGtk5Bxn7faNjOn8ag8tQKbPVQL+EraHqa7k7CvSIZwHVuHkWcD0CLszvYlYYff+qriccjNCbnOXb4cBGX/TKLvfWfkokvs6cBRt3/M9pk6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqB76+weH6hDrTzTl2YC6E9U8clhjAVOwrcP5BHObjc=;
 b=uJW5fxRXRxwxkzaaLMjtep/CnpZPNqrCGMOlAzZOAUnoYuC3tJTVseb2GOZOcFzuj9yv6iIny3Yjzyzvsm4Xou4bllAsY/oSuK3HnYHTm855vUwwprV7Ai0BZHX6SX+TM4Z+oYcBrvET/RvZOTuzcZ0nMxz2YI4zjKC4Jq5Ob1PhcN3kBy6aOxx3TaYyU61MvxGReidNqQPvu/ylzgN52xJGEz6n2S9pJq5NcsTBr8KkYdfMrPMdXl2ptHgKK+rmv1kxgYIIdZ7ZdZY1Es/fO1XIpeJPRthDQDuiIl/0DcOlsMk3rhj1mPN0+OW/i11XvCHQtN5EcEXIHFssDJML/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqB76+weH6hDrTzTl2YC6E9U8clhjAVOwrcP5BHObjc=;
 b=BeQEH5sSVUz6togaCHj0xtEt+Cvcce8ZtR0ZtUuMNTym2TKMdeTciHvHxMB0oGvanankdwyJDv2Nmg0Wfj139c4vbopoB7ZPS//ZCVCrJ8Yj1otMuASc9l+PKBB2lLNA1VmCA5HDv7/wl2wBhZ2iERdOIC1KqwGRkxMTtEGmXJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 12:53:30 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 12:53:30 +0000
Message-ID: <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
Date: Wed, 1 Apr 2026 07:53:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2;
 smp>1
To: "Aithal, Srikanth" <sraithal@amd.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com>
 <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
 <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a1572d-48ed-4c43-cb27-08de8fedac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/PAnviMenoxoJpqR/YAhOhdRzY9vj9VK83wnHisXZtILMu9MR1sXZn1bpdSoHFxL5AZKz10QtM8uHxs75iFp1M5bAXwtzmTTsjA6Imc9y5JjlN/AAzSX5uSi5Lzfe2Y7//9WIpRMIrJK8TUTdbD6aw4OZxVSp2eEgFu5g8rFxQruAMPwGId9uu9BH7eWJP5JtCChSPMYsmjzl3KwCID61ds9BDGUgJUim7S9eox2bQpKAruQzrx39tGyMGB1S8YhpZZ4yxBgmEpEvH8eO5pBwo6tjOelEw8PDaGKqzZW/aRDw3LEUZID+MuD9+7kuwMDLT2JAEKzygq1l6tRuCOL8g6wkdBBelRZQFFZhUhNyXas8nw9rDuR86uGjL0eMrKFHEaOesdV2FOHWlS49m/XJTUv2/1zgVtyFHajHvqDxGvKwH0e2bvysvgAK/7TVKJiJzouBu5UTnb6YYnpN2pYkGt0TGZhzy6Hx3zYaMru07P4w8RKdDu+wzEo6H859go2YIfssYj522WTscLsmgg10xt3mJPadMKnHIoFQzfGNupo0OT5eIhxy9Bz8pDmBkBOUimndOqqkna1nTLAjE6z8XHKPZeemh8AbLovPEkT01uXK/TUJqYXei7lPXuY6ASLZ0CCkwpakh57zVeL/wQ2Wm4qAy1EvkeXuKCalJ0YbsY/cyIhCXm9ny0IJ1hAB8Y5On32pd5fydsxRRb4iba0rvQR9fOXz+kpcDbZCtxGDEYjC/xT7IrwJO046jJkAZ3B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGkvRXhQY2U3emp3M3pXYzBRem42OHJFbHJsQi9NYXRsUllEOEp0eGRqQk53?=
 =?utf-8?B?eGtJZ1UxcXV5VGZKdTZockFlK1BaWWZ1S29INTQrZDA1YVNnT1RlRldzS1dB?=
 =?utf-8?B?ZEFBbHJkdlpseFBHUElDMml4TG9kcE9HTUM4WDIxNGZtOEdWeWhwcWx3NXlV?=
 =?utf-8?B?Z1FmeUNYZTNMZXFHV2pFRThqTVBIdkRzRU1UakErY1JOOXJGdmF3UGpRdWM5?=
 =?utf-8?B?MFErZVlva25saHBidDMvbmNEd25oSVROem9FYTRIeVZORWlOc3VHWDBxckFS?=
 =?utf-8?B?K3ZzOVEzQkpSdkM4ODA1TlpnVk5YajJUc1hzbDJnKy8yVmJ2V2dxRDRmVTRC?=
 =?utf-8?B?T2RoSEkyd3hzNWxJak1aMjFCVC9UREVWWVFWZHl4ak41YXJpSkdseCtiREFa?=
 =?utf-8?B?L1NYcEJRdDdYOFJBZTd6OWdCa1FsS0dLU0ZPN1JNKzZLbktvV05WRzdhRS9U?=
 =?utf-8?B?Smh6cGMyVkpCL2JLUmpHbFFaWEc0NmIrcEp2UTc4Ylh3M3NibnBnQnpLNkh2?=
 =?utf-8?B?Q2FLU1FlbFRNMVlGSDREUUpyS3daRzFFdXlZTjlRczJQeXZVV0xwWGt6WlJp?=
 =?utf-8?B?UE4vN1FmUTMvRjRRenc0WXp3QTJvbXQ3Q284RElnS2Z5MnFwMlBMRlhJRGFW?=
 =?utf-8?B?V0RuZXZ4REpNRklpdThlSmRGS1dPNG1mMG9FSkxYQlc0ZEZIazMyVnNUR0Vs?=
 =?utf-8?B?WkJILzgrcVhnRElOeVJwYS9CYVcrbTh0SUlQaXBtWlY5T3JUd0VHNTEwa0J1?=
 =?utf-8?B?MHBiT1pXSERwUkw5eUE3KzQxOEw2NFZtZ1YxK2NjUlc4YTNFRnBhMzNMV0JM?=
 =?utf-8?B?NjhRRTlYKzZQSy9ROHpkak85QUFybHpVbW5CT3RxT1I1NzM0cksxRTF4NzN1?=
 =?utf-8?B?b3NHc2VpeWNvRURPWE5xZ2ZQUHRaMndMS3ZUaHhEcmNCS3ZraTV2d1MyVnlT?=
 =?utf-8?B?L1BHbGh3clRUN3BzSUFOWmt5TDgyMlk5b3hmci9DblhpRm02ZHp6ZFlJbFJS?=
 =?utf-8?B?NVdiZHhLQ1p3a2FVTE80eGs5NThkV1JqUGd4aFFsK3BlVnhYTjNOd2RKcmJa?=
 =?utf-8?B?eDdvbVllY3hzUHN1Mm5KVnFmeE9scUdwcGlMSWZOVXVMN3ZHTmU3VlVLNkVz?=
 =?utf-8?B?UVdSVDlpVXJiVTVUcG5tekgrYW9xekxkLzlKb0w2T2VtMlRNeUdnQ212WkpH?=
 =?utf-8?B?anpRS3orS0svRTVoN0Y1NVBnY0xKUlNXVkk2dTJnV25Wam9nSVhKZ3hNeGFW?=
 =?utf-8?B?Z3BKamthS1c2enExeERQWlUzaElXVDdOdjFkM3lLRkFmYVJ5YjE3Vms0TFJ6?=
 =?utf-8?B?TFdkcENBWFFUY2hyUlgvaEUvWERTaEIrOFJKeGx6NEhSOStiTHM0N0VGNjJn?=
 =?utf-8?B?eEExVWdZcm9yVXRrTDlpSEFtT01ldklzVjNnMks4TThUK1BRdkhOdEZtMHdy?=
 =?utf-8?B?YWhYc1IwdUkvWmkxVWV1ajNRVzhlNFM3Z0YraVg4dzlFNzFXdG0vblVjVGlN?=
 =?utf-8?B?Ny9WaysvWGR3SmgyWjBERVBDdGlzSDBSVWt0OXU4NGpSR2xLdEV3dkI4WkxW?=
 =?utf-8?B?NGdpaDBKa1o5NlJodDZ0VExmWXQ3ZVRTam9MUFF2RUJkTnlOUTBkZ3FoRDJp?=
 =?utf-8?B?dG8wVWorYmozWHB2YU10Y1luL0dGWjdBcWx5bWpITHZWQkFOdUtXOHZtb0RM?=
 =?utf-8?B?MytYNy9OVHM2SDlPeUtMTXh4TnJKc1NRMGFZaXlsWjdiVkZWSkZoeDJBVytq?=
 =?utf-8?B?QURIQXRlZmxBZno4YWdJU1VJc2loZjE3c20zdEo1OE5lVEJmMmRHNWQza0ov?=
 =?utf-8?B?RkFjMjRoZmUwa0NaR3IrWDVRUzVvc2NybUZnUkRIQmNpbUJtMDFpMno3NXNi?=
 =?utf-8?B?MjY2VzQvSWdyeTF6MEJBeVJvUlZrblV1SzNZUTFmTHBMR0pMNm40WXZpNXBB?=
 =?utf-8?B?TVFnczRiL05rNldjS3N2WFRWTTZHTU1xRjJWZlZLYjNMMVlMTHgvT01PR2Fl?=
 =?utf-8?B?VE9CSTRPaWdYeURQaHRLaVRpb3EvT3F0bWo3bE9hcnBSaFNQR1NOQVdNZXBs?=
 =?utf-8?B?VCtZSkFvakgzcDhwVTFQbjIyWFM0eU1qWFlVRUZDRStkc0xjV1dCWFk2TDFM?=
 =?utf-8?B?UWRNWkF5Mmc0Ujcvd3l0bmZoT3hFL2FFcW8zdXNILzJIUXQ3TFpRaDYvdm9z?=
 =?utf-8?B?RkFYY09hNWZWcXIxdHJ6TFFjNUw5NEpvSlY1QjdlSlYwaVhzUERFMmx0RG01?=
 =?utf-8?B?Z3hpS1JsSFMrTWZWLy9kS1NyQzZ4L0Z4dS9wWGpOb3BMMnZpL3dyLzB0cENI?=
 =?utf-8?B?b3lQaVJwczdTdjdRdkZLZ2VVNlEyTVgxbkszWFV5UlV5Y01SQ2w5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a1572d-48ed-4c43-cb27-08de8fedac4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 12:53:29.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITgzLWFmQc1JQ72eIYUVFTlLRz1YMXHUD66MUn/JjDqWM9S+WcKNwizuct0hh8SxwIu0/Jwbjx7BcBD2Uuevdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E

On 4/1/26 06:24, Aithal, Srikanth wrote:
> Hello Tom,
> 
> 
> On 3/23/2026 6:40 PM, Tom Lendacky wrote:
>> On 3/20/26 11:08, Aithal, Srikanth wrote:
>>> Hello,
>>>
>>> I am hitting a failure when shutting down a SEV-ES guest (smp>1) on
>>> recent linux-next, and narrowed it down with bisection on the host
>>> kernel. The issue appears with more than one vCPU (e.g. -smp 2); with -
>>> smp 1 shutdown completes normally in my tests. The same guest shutdown
>>> path works with an older host kernel (<next-20260304) and is also
>>> avoided with current QEMU master or by cherry-picking a specific QEMU
>>> commit onto v10.2.2.
>>>
>>> Environment:
>>> Host kernel: linux-next, tag next-20260319 [1] (also observed starting
>>> from next-20260304).
>>> Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue; -smp 1
>>> does not in my testing.
>>> Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested QEMU
>>> master at 8e711856d763 [2].
>>>
>>> Details on issue:
>>>
>>> After SEV-ES guest shutdown , the serial log shows a register dump
>>> (example below) .
>>>
>>> [   12.613383] reboot: Power down^M
>>> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
>>> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
>>> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
>>> ES =0000 00000000 0000ffff 00009300
>>> CS =f000 00800000 0000ffff 00009b00
>>> SS =0000 00000000 0000ffff 00009300
>>> DS =0000 00000000 0000ffff 00009300
>>> FS =0000 00000000 0000ffff 00009300
>>> GS =0000 00000000 0000ffff 00009300
>>> LDT=0000 00000000 0000ffff 00008200
>>> TR =0000 00000000 0000ffff 00008b00
>>> GDT=     00000000 0000ffff
>>> IDT=     00000000 0000ffff
>>> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>>> DR3=0000000000000000
>>> DR6=00000000ffff0ff0 DR7=0000000000000400
>>> EFER=0000000000000000
>>> Code=b0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b8 <0c> 5d
>>> c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70 e2 7d
>>> c6 ee 00 00
>>> -> Hangs here
>>>
>>> Host kernel bisect (with QEMU v10.2.2) led to:
>>>
>>> Good (no crash on guest shutdown):
>>> 32d76cdfa1222c88262da5b12e0b2bba444c96fa
>>> KVM: SVM: Move core EFER.SVME enablement to kernel (local build tagged
>>> 7.0.0-rc232d76cdfa1222 during testing.)
>>>
>>> Bad (crash reproduced):
>>> 428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
>>> KVM: x86: Move bulk of emergency virtualization logic to virt subsystem
>>
>> Any chance you have the enable_virt_at_load module option set to false?
> 
> No, it is set to Y.
> # cat /sys/module/kvm/parameters/enable_virt_at_load
> Y
> 
> 
>>
>>>
>>> So the first bad commit in my host kernel bisect was 428afac5a8ea. The
>>> commit prior [32d76cdfa122] did not have this issue.
>>>
>>> Later I used QEMU master and with same linux-next next-20260319 as host,
>>> it did not reproduce the shutdown issue .. that was using QEMU master
>>> [2].
>>>
>>> QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba (target/
>>> i386: convert SEV-ES termination requests to guest panic events).
>>> Cherry-picking that commit onto QEMU v10.2.2 resolved or at least
>>> avoided the shutdown crash in my setup.
>>
>> Well, if it is converting a guest termination request, that is still not
>> good. It should be a clean shutdown.
>>
>>>
>>>
>>> Questions:
>>>
>>> KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expected
>>> here, or is there anything that should be adjusted or documented
>>> following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
>>> QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equivalent
>>> handling of SEV-ES termination) be appropriate for users staying on
>>> stable QEMU while moving to newer host kernels?
>>
>> That wouldn't actually solve the issue, it is just a much more user
>> friendly error message. Is there a termination event in the host dmesg
>> log?
> 
> 
> The guest shutdown proceeds normally until:
> [ OK ] Reached target poweroff.target - System Power Off.
> [ 9.918849] reboot: Power down
> 
> At that point the serial console freezes with the register dump below
> (EIP=0000b004, HLT=1, EFER=0, etc.).
> 
> [  OK  ] Finished systemd-poweroff.service - System Power Off.
> [  OK  ] Reached target poweroff.target - System Power Off.
> [   10.029330] reboot: Power down
> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
> ES =0000 00000000 0000ffff 00009300
> CS =f000 00800000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=98 59 0c db 72 6c 94 71 3d a6 36 32 49 a8 08 22 bd d7 8c bb <4c> 3c
> d9 bd 90 b5 2e a0 69 26 53 df aa 4c bb fe 5a d9 b6 ee 7b 45 02 2e cf d9
> 60 48 00 00
> 
> 
> 
> QEMU does **not** exit on its own — it appears stuck.
> 
> Only after I press Ctrl+C do I see in host dmesg:
> kvm_amd: SEV-ES guest requested termination: 0x0:0x0

So we would have to see what is triggering that termination request.

We can probably instrument a guest kernel to get some more info.

> 
> I also set `kvm_amd.dump_invalid_vmcb=1` before reproducing, but it
> produced no additional output.
> 
> This issue is still present on latest linux-next next-20260331 [https://
> git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?
> h=next-20260331, tag name    next-20260331
> (e5da3eef8dadab4e98b228725ca8948edd9d601f)]

Is it only with linux-next? Which would point to a kernel change vs a
Qemu change.

Thanks,
Tom

> 
>>
>> Thanks,
>> Tom
>>
>>>
>>> Thank you,
>>>
>>> Srikanth Aithal <sraithal@amd.com>
>>>
>>> References
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>> — next-20260319
>>> [2] https://gitlab.com/qemu-project/qemu — master 8e711856d763
>>>
>>>
>>
> 

