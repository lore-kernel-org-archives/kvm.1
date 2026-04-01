Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618847DF83;
	Wed,  1 Apr 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065210; cv=fail; b=BCZxpZwTimPc+Jn4C0oGILHed5iq9HlCADL3BN9m22c+mVX44GnrIgPvnET9OzKvPp0yLjt7nkZr7xO8lv192fMD8dQy8mk6ttxggdixWN5sEML3pEtahcgLNAtZ3gbyQHHtE/fss5urthjrnsQ254iDXTsIe7T+1AeacHX4a2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065210; c=relaxed/simple;
	bh=LSC0l+f48HuQfZsePTqV9rHkWa++E7ZKtTIwWk8f0Fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/A0RlXd0jjRl46qE6IWyvB1jfNr8YgwcqQvE8k+g88wOO6DFAQSvOAFpS7sqpZbuIHLjlEosc5P4mmMQhSuuFIQ7zSClvPNF/A6eU+6fyZBynZf6KlVA2SXXAzKP+EkIW4Pzw5959pwYgacCelKZCrIltbohhf54SwVfLOpuos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kI6PGBgz; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kI6PGBgz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1ipNlNHpdTmyEUpEgjEaPYJJHUZlwm9QVKgEDaGh56uepXUJvX3yCiFZK44P/ZOwx4UTXzlTKl8AF0nv6zO5yz78mArikeIlEKSN8AIrRtj0Hew0VHihrajEvC/ZXb6yciO5bkrv8rtHo0VrxvXuJLzMphUWkgwVukJoGjs3i3SiN9a46zLkBacfr/t+dz5eB+HsGH+DPWK6zY0klPI+8ohXDgfNRnUtQpcQ5g1cYSNhGp2+VwwDeNtE2DNZgxQe5fsoqxONqKzBLzeeFbDs3GT5hUcdFBtyRJPSfavLGWcRJVGerbwnAL916cNRlYyM58AbZHwO+TDC4t1jRBkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW1WW8qm929rQJMmT4sfkqW/k73X+oepFKUEgY4N8rg=;
 b=MuF+USNSXDPRzRh+xQ7E7eBaxRNyC2n6tbBp97fKKHcsR0M1c/bGhVM3FykVjhREYFNodCa4yyzGOiwoPK2gH8Cxxp59Qtp8fm3yvHWG3rpM11RftoM9Yx1+FMgTQQ15XZndSsGfQtDfgJMy+iudej2xheSQrCXqNRvl8BMC2BoCMISpUkAfNcWSR9YF504BLpqwsxpyy6gvYmr+5ToCNf7vWLNGE2uDfwcObCgLh9mgr44pWLlYajEJwv22LscEhd9lDVHtuDXcZZycdr/QE19cfWtN4qYJj9JABUIDyQvnyIMcbiKT2fGlb0of3YL7Fs5GWHaZy7gzqF1z2iu0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW1WW8qm929rQJMmT4sfkqW/k73X+oepFKUEgY4N8rg=;
 b=kI6PGBgzxfbEXAdUeAYMJzluMMwsqyL1Uzg628XdlNF9pDZsyrOIMT9IGU647PB8LHixjR+V4xmqStngFzFdJyz0wBDICEgymeHPImar6UzIXY2zeLwz8g4MwLJT5ozr3y/Ry4IoGDiUdhzAKQe+fDxdAHxqFgY680FH8gOviOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:40:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:40:01 +0000
Message-ID: <689a6c1d-d476-42d0-9ee0-444bfce2ed91@amd.com>
Date: Wed, 1 Apr 2026 12:39:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2;
 smp>1
To: Sean Christopherson <seanjc@google.com>,
 Srikanth Aithal <sraithal@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com>
 <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
 <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com>
 <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
 <524fc5dd-e06b-4857-82e7-f0a969966bc9@amd.com> <ac1FT4G_VpFHRIWl@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <ac1FT4G_VpFHRIWl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: b657a5af-5141-4c3a-1c31-08de9015b373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9Y1Zc5YQHfqjCrxCAaARaVOCxpnW46ZbMRVbPHQ7SZH3Dy23vHmkOpJfkGXn5i7WMb2RRGRZ7ofLLGA13hXQ0Wh99MkY7Gqnv3fMX1+y5czpeNfdyOepDHZkGzhFVJ/RY4MkCkf7r6KS/v9JpjDx4q0vhHM7s0lcCl06w6QlyjpuMwOv9SabMLT6RwrV4AOlmLy1K6sUsAnlr+EdrLRf9ur5w8kaV2I0t4Cl/rWJ3tuaRT3m3SgKekkyo71FmUy/3pgVMZBWp+AYNy5ngtNV4UubPpy4LfqZHOHxBFmD4ErDkdGHZca5LlccbKXXjaAEfNtJm0aBIYLQn7BjscjOMkMVSzLVsIXDTsraPPZUFEMqz+ro/lsa5pSjNrh0lqHl12Ztx1VvDMbpIHrfdreoSh52Q6HGD/90TegyaWhj+x+MTnkzvXPbTqeZ2Bza2HYDnotnXnz7jM2kUxSlxG0fBh8kyFbK6qp7fMgmCmKKsfWeE7SIPnl4R1XdkRVZcSZ83oOX4VOBt1oxzH49WOFxxcgDPWoS5oA/axkQSLplTL+rZGKZRRCo8PDUNY7oIRsav+w6Qkf/fSpyJHrb9gTyIIWR20osPRKTnRzt1bm1pftX3jBqVarF1qc9jWuaRy8354ogGZMKNEV6ACsSQyo71aeR4USy+IxAD3tGf+Kx/unZlKAcj8qd0YdeZOaEc7hCr7ihR3tzXYFDBuqX/8dWAVpcfrZyRWm/dxxpJtCZTJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGdqSXFUUVRDRjhxV3hSOGpiMHU5SVloaFJUNzV5alpYYkR1QzB4UHFIb3BC?=
 =?utf-8?B?QVBlZXJMTXVnTCt4eE5QM01QbjNPeWVnWkRqK2lSMEMyU2NBNVBBT1JJZHMz?=
 =?utf-8?B?QXhqRFZpL3A3SE1QZnVLUm55WTZTa2Zzb2o0MmpvdVhRbmIxeTlORU5HbTN2?=
 =?utf-8?B?dVlodTl4UUs0RnB5Q1dxZml2MVkrWWZ5UzZrYVdpKzVSUW81UCtYeFFKekNl?=
 =?utf-8?B?TkdyQ0llekJwYUNkVlA2OTlWMGlwOW1wZEhIYVNZckQrWjNZTGY2blc4MUZn?=
 =?utf-8?B?QVd4ZFRVOWZ0WTh2MjJ5eTNqSGkwSm1mckVKM0RQTVltclFnaE9ad00wdWph?=
 =?utf-8?B?aGo0K2N2RmRwbjhkb3YzTHc4MVVMSzlQY2pSQy9vQmE3UVdCTFZONzJTc1pK?=
 =?utf-8?B?c1p3SS9lbGtaZVdjQ0VHcWVSYlNyZGl4dnFBbWdiS0JhMzB4V1VaTmlONlpN?=
 =?utf-8?B?VW9oSXJidG9seFpaZjIzc1RwVVppZUFXY1lEZG9naHFwaE10MEFvZCtPVlhX?=
 =?utf-8?B?WHRLVDF2TzkxaWZ3b2VBYktkTVdmRXdleldoR0JCdnZJb081a2kyaWFZSGwv?=
 =?utf-8?B?SEhwSFcrU3RLL3FuQkhYSU5tWUo2TWkwUkNaZzl3aXFCQTdVbGN1SVZNSERM?=
 =?utf-8?B?eUhJZCtYL0xhU0sxb3d6clFPcmVhS2lWNU93Tk9CMGx5UW11ejdDNVUyd1pu?=
 =?utf-8?B?RlNiNktXdGQ1TlpLZHYvTkxiakY2SXpZZTFlRjFFUHJCTUliVDRKRUhoRThI?=
 =?utf-8?B?NVowdVE2bllORXJzOW85QVlXNUZwdmswcFA2OXQxa1p2VDJQZ3YwMkYzR0NJ?=
 =?utf-8?B?QzBjOWlWWW1jNS9qaXQ5K0k0czg1VWI2OERRa2dSbEowRS8rZ09majE4ZzlK?=
 =?utf-8?B?SEFINDFuUUtpbEk4TWt6QWc4ZjA2TE44dm1QNlcvdHFrUWdjY3BHV0U2UlVQ?=
 =?utf-8?B?SmtyUlFMVTdWSWlpRUNsYXdwejF5YVR5ajVGZkljRDZYTmJBcFRBMEZ2K2hZ?=
 =?utf-8?B?cjhZdmEyRDFiTTU1Z2ZsZ29LVUcrak8wTk9tcDdFaVluMDh4YUtQUHdxbHR4?=
 =?utf-8?B?dUI5UkYzSDN3a3lrL2R2YVc2eWhHSGlrTnpiS1VkN1JIV1lrZTRFNmhyTFM1?=
 =?utf-8?B?TUtvWUNzOTJuME4rQStsYmhSOGJSbFR6UXc5aWphU1FtRnFiR2RrZk5YNUx5?=
 =?utf-8?B?THFSendIanV2cEZYMDdGV0NiMUZFZDB1cnE5UTRvUlhoOHRHaFo1OGludEJ3?=
 =?utf-8?B?L2NrZHM0WnYxdHZwM05aaW9KMlc1a0hPMzcwRVBXU3JZd3lsbHM0RGhJeVZj?=
 =?utf-8?B?bElZQldPNU5UTDk4K0pyVzNPbFp1TFBOeUV1T2tuUDUyRERhN0FGbDZLZEVr?=
 =?utf-8?B?bjVPNGdEVzQwSkEwVXNva2hPYTBGYnlyclFvOE1DUEd5aWdFazhaSTFtSG1H?=
 =?utf-8?B?MEg0MmRCcG1pc2wvM0l4QnduQUhjU21ubEVRMDdhOU1UL0FGV0NDWHhPM3pD?=
 =?utf-8?B?R3FDbmp6ek5tdEd3c1djaENuTVl1WFVkSk1tNmxoRk15ek5HNGpoTkJOdWMy?=
 =?utf-8?B?cFI2c1BWWG5MMnlHMTVFNlBZMHliM0dIK3N5T2lQYzFiTlN0VTZXbVBGbXJx?=
 =?utf-8?B?ay84MUFFZmxBSUh6MFY5N1UrRzRrRCtNNWduYzNGMmMzR1V5SW5pU0I4VTJT?=
 =?utf-8?B?VU9ZSEhNR1FIYUlGMG9LTDJjcFBaYi8rZDg2aWVjem1IQXVUSGF2NmFlQita?=
 =?utf-8?B?SkVQdDI5TzJCb1hvTS9uTWR4TFVlZGcwR2ZJM3hVYStXSC90VWV4bEl1TU1u?=
 =?utf-8?B?Q05vaVZmQmNNNkVsVTJ6ZEJZNG91NFYxZzYvQlJPcFptOGFXRlZYbjNIRVli?=
 =?utf-8?B?MVNKRkFvdFNLRlVnQ0w2NGtOZzEwTTJucXB0OVNMWWJhWkMyUkRIUzlES0Ew?=
 =?utf-8?B?cGt6RmE2bVlYczF5SEtPcitISTZ5SkdWQkhyV0tLWmVLUW9MVi9qeVJZL2RM?=
 =?utf-8?B?VW9JdGUwRUF5Vy9aemd3MFpINUVsZ0FxNXFEM0pwSm53R1VhSU0xcmtHVG85?=
 =?utf-8?B?a0lIS1d2MUF3ekFJRW9kajVNUCttRlJJMkFrU3BjQUZlbXlpTlg5UzJPOU5K?=
 =?utf-8?B?R25nS0pWUDRCN21BQ2xCSmg1VTR3d3hWTFRzZEVER2MxYTM4OGp6aWJPVGFD?=
 =?utf-8?B?Z0U5RmVkNGVWSHhJeEFIdVZXN0VLYWJMWTkwTmE5aktkS3Y4d0o2RXIvL3Na?=
 =?utf-8?B?c1RiWTAzNnc1MWJkV3k3bVZUbVZzemVpaHhaSjZBaFFFaDMwSkxLUkVwOENm?=
 =?utf-8?Q?iHH7FQfjlQCHBvoTzj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b657a5af-5141-4c3a-1c31-08de9015b373
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:40:01.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnpBJxPBYe5hL5HFG8iKT7U0iXny8hbwHnyLSOTgIFgpy43dNGku0SlrURWY31BOwFGQnCylBck/W0agZ1L3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

On 4/1/26 11:18, Sean Christopherson wrote:
> On Wed, Apr 01, 2026, Srikanth Aithal wrote:
>> On 4/1/2026 6:23 PM, Tom Lendacky wrote:
>>> On 4/1/26 06:24, Aithal, Srikanth wrote:
>>>> Hello Tom,
>>>>
>>>>
>>>> On 3/23/2026 6:40 PM, Tom Lendacky wrote:
>>>>> On 3/20/26 11:08, Aithal, Srikanth wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I am hitting a failure when shutting down a SEV-ES guest (smp>1) on
>>>>>> recent linux-next, and narrowed it down with bisection on the host
>>>>>> kernel. The issue appears with more than one vCPU (e.g. -smp 2); with -
>>>>>> smp 1 shutdown completes normally in my tests. The same guest shutdown
>>>>>> path works with an older host kernel (<next-20260304) and is also
>>>>>> avoided with current QEMU master or by cherry-picking a specific QEMU
>>>>>> commit onto v10.2.2.
>>>>>>
>>>>>> Environment:
>>>>>> Host kernel: linux-next, tag next-20260319 [1] (also observed starting
>>>>>> from next-20260304).
>>>>>> Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue; -smp 1
>>>>>> does not in my testing.
>>>>>> Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested QEMU
>>>>>> master at 8e711856d763 [2].
>>>>>>
>>>>>> Details on issue:
>>>>>>
>>>>>> After SEV-ES guest shutdown , the serial log shows a register dump
>>>>>> (example below) .
>>>>>>
>>>>>> [   12.613383] reboot: Power down^M
>>>>>> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
>>>>>> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
>>>>>> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
>>>>>> ES =0000 00000000 0000ffff 00009300
>>>>>> CS =f000 00800000 0000ffff 00009b00
>>>>>> SS =0000 00000000 0000ffff 00009300
>>>>>> DS =0000 00000000 0000ffff 00009300
>>>>>> FS =0000 00000000 0000ffff 00009300
>>>>>> GS =0000 00000000 0000ffff 00009300
>>>>>> LDT=0000 00000000 0000ffff 00008200
>>>>>> TR =0000 00000000 0000ffff 00008b00
>>>>>> GDT=     00000000 0000ffff
>>>>>> IDT=     00000000 0000ffff
>>>>>> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>>>>>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>>>>>> DR3=0000000000000000
>>>>>> DR6=00000000ffff0ff0 DR7=0000000000000400
>>>>>> EFER=0000000000000000
>>>>>> Code=b0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b8 <0c> 5d
>>>>>> c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70 e2 7d
>>>>>> c6 ee 00 00
>>>>>> -> Hangs here
>>>>>>
>>>>>> Host kernel bisect (with QEMU v10.2.2) led to:
>>>>>>
>>>>>> Good (no crash on guest shutdown):
>>>>>> 32d76cdfa1222c88262da5b12e0b2bba444c96fa
>>>>>> KVM: SVM: Move core EFER.SVME enablement to kernel (local build tagged
>>>>>> 7.0.0-rc232d76cdfa1222 during testing.)
>>>>>>
>>>>>> Bad (crash reproduced):
>>>>>> 428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
>>>>>> KVM: x86: Move bulk of emergency virtualization logic to virt subsystem
>>>>>
>>>>> Any chance you have the enable_virt_at_load module option set to false?
>>>>
>>>> No, it is set to Y.
>>>> # cat /sys/module/kvm/parameters/enable_virt_at_load
>>>> Y
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> So the first bad commit in my host kernel bisect was 428afac5a8ea. The
>>>>>> commit prior [32d76cdfa122] did not have this issue.
>>>>>>
>>>>>> Later I used QEMU master and with same linux-next next-20260319 as host,
>>>>>> it did not reproduce the shutdown issue .. that was using QEMU master
>>>>>> [2].
>>>>>>
>>>>>> QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba (target/
>>>>>> i386: convert SEV-ES termination requests to guest panic events).
>>>>>> Cherry-picking that commit onto QEMU v10.2.2 resolved or at least
>>>>>> avoided the shutdown crash in my setup.
>>>>>
>>>>> Well, if it is converting a guest termination request, that is still not
>>>>> good. It should be a clean shutdown.
>>>>>
>>>>>>
>>>>>>
>>>>>> Questions:
>>>>>>
>>>>>> KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expected
>>>>>> here, or is there anything that should be adjusted or documented
>>>>>> following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
>>>>>> QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equivalent
>>>>>> handling of SEV-ES termination) be appropriate for users staying on
>>>>>> stable QEMU while moving to newer host kernels?
>>>>>
>>>>> That wouldn't actually solve the issue, it is just a much more user
>>>>> friendly error message. Is there a termination event in the host dmesg
>>>>> log?
>>>>
>>>>
>>>> The guest shutdown proceeds normally until:
>>>> [ OK ] Reached target poweroff.target - System Power Off.
>>>> [ 9.918849] reboot: Power down
>>>>
>>>> At that point the serial console freezes with the register dump below
>>>> (EIP=0000b004, HLT=1, EFER=0, etc.).
>>>>
>>>> [  OK  ] Finished systemd-poweroff.service - System Power Off.
>>>> [  OK  ] Reached target poweroff.target - System Power Off.
>>>> [   10.029330] reboot: Power down
>>>> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
>>>> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
>>>> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
>>>> ES =0000 00000000 0000ffff 00009300
>>>> CS =f000 00800000 0000ffff 00009b00
>>>> SS =0000 00000000 0000ffff 00009300
>>>> DS =0000 00000000 0000ffff 00009300
>>>> FS =0000 00000000 0000ffff 00009300
>>>> GS =0000 00000000 0000ffff 00009300
>>>> LDT=0000 00000000 0000ffff 00008200
>>>> TR =0000 00000000 0000ffff 00008b00
>>>> GDT=     00000000 0000ffff
>>>> IDT=     00000000 0000ffff
>>>> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>>>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>>>> DR3=0000000000000000
>>>> DR6=00000000ffff0ff0 DR7=0000000000000400
>>>> EFER=0000000000000000
>>>> Code=98 59 0c db 72 6c 94 71 3d a6 36 32 49 a8 08 22 bd d7 8c bb <4c> 3c
>>>> d9 bd 90 b5 2e a0 69 26 53 df aa 4c bb fe 5a d9 b6 ee 7b 45 02 2e cf d9
>>>> 60 48 00 00
>>>>
>>>>
>>>>
>>>> QEMU does **not** exit on its own — it appears stuck.
>>>>
>>>> Only after I press Ctrl+C do I see in host dmesg:
>>>> kvm_amd: SEV-ES guest requested termination: 0x0:0x0
>>>
>>> So we would have to see what is triggering that termination request.
> 
> IIUC, the termination request only occurs after CTRL+C.  If that's correct, it's
> a red herring, and the real question is why a graceful shutdown hangs.
> 
>>> We can probably instrument a guest kernel to get some more info.
>>
>> Sure, I can apply any debug patch and provide the debug logs.
>>
>> Note: I'm heading out on PTO until next Wednesday (April 8th). I won't be
>> able to gather additional debug logs until I return.
>>
>>>
>>>>
>>>> I also set `kvm_amd.dump_invalid_vmcb=1` before reproducing, but it
>>>> produced no additional output.
>>>>
>>>> This issue is still present on latest linux-next next-20260331 [https://
>>>> git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?
>>>> h=next-20260331, tag name    next-20260331
>>>> (e5da3eef8dadab4e98b228725ca8948edd9d601f)]
>>>
>>> Is it only with linux-next? Which would point to a kernel change vs a
>>> Qemu change.
>>
>> Yes, it is specific to linux-next (starting from next-20260304, bisected to
>> 428afac5a8ea "KVM: x86: Move bulk of emergency virtualization logic to virt
>> subsystem").
>>
>> - With older host kernels (< next-20260304) + QEMU 10.2.2 → clean shutdown
>> (no hang, no termination message, QEMU exits normally).
>> - With linux-next (next-20260331) + QEMU 10.2.2 → hang at the register dump
>> after "reboot: Power down"; only Ctrl+C triggers the "SEV-ES guest requested
>> termination: 0x0:0x0" message.
>> - With linux-next + QEMU master (or 10.2.2 + cherry-pick of 56d89db2cfd8) →
>> no hang (the termination is converted to a guest panic instead).
> 
> What guest kernel are you using?  Bisecting to that commit for just the *host*
> kernel is baffling.  I could see it preventing KVM from loading or something, but
> it should be completely out of scope with respect to guest activity.
> 
> How are you initiating shutdown withing the guest?  What's the full QEMU command
> line?
> 
> Can you also provide the OVMF image?  E.g. in case the hang occurs in EFI runtime
> services or something.
> 
> I want to get this sorted out before the merge window and so would prefer not to
> delay root causing this by a week or more.  

I just tried linux-next/next-20260401 with Qemu 10.2.2 and the same
linux-next kernel in a guest and was unable to recreate the issue. So, a
re-test with the latest linux-next would be good to see if the issue
remains or, yes, more information is needed (including the kernel config
used for the build, too).

Thanks,
Tom


