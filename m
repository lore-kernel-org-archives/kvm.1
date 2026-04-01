Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9033F0AAE;
	Wed,  1 Apr 2026 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053152; cv=fail; b=VCpWXalUvEZBDJrgeUHBgXOQ6Q13vuG1Mslx7NcpEjZSwVS7e+0PFoskdt4Uq2T393Dnl5wOGlnu7SmTm3UEhmTIyGpZtkQPf6H3S8Pz77qGiGgpL6Zq0hGntOf3b3dYsZLAM+Wa+anJB3HM1aJVuji8FWmttYW/RDXD29so03E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053152; c=relaxed/simple;
	bh=y8HtYo2v0L0NG2EMaB96JxPDEH/6B3zmSKlS3pf9ciM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=miHcn39+a4n/5YgjlkNRoVc0b/WtgtmFXFFi3BObdZeqMk18a5YP/Iw2+oNe8QPlkkthO1b5ptsyzTXPzzJA7HgTqW0c6mdWdBsUBkZdCiB4sRgwBHeDrOfT2uzrc1qaVAPiIQQCig8O+VgupavykhEP8mX67q9ONaSrdUmi6rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PUogEf64; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PUogEf64"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydzcSljaztsUVxnqcPUQ9YINb2U8FAM2P56QHSWhNs3vhpPLDIOKIuCybpfnDqyGQiCyAe4XYBMmmdeWFrdd4EGsM/nyuGOtruZQkIIYxx81rJDqiNoZRgzL8PWQbzUbRLwIMrdyvYK8OxhljD2D3xda6/PHE+YaXqJOfpdINQJYvCivsslbuygjts5ctZrSTnNoxNXlj7a8WSsc0TPAGj2p9kb9kYkx/8YgUVXi2+2V69NUbPwAf8F1y7NJuM8h67Ed7vP7CBEU354P35jVg1XnZSdZ/6Kno7O8BNdOGhAlm2ZMI7zdiyL32lwJ6raOPce0rWVICEAEd3pQAWrNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRR8wHueRVdemVlOtbvQxeCM0SeFTKhFDNGLLLukHaw=;
 b=pFgFDmCAw1RKqltrzHaTOoYd53tbZKDSKO3A7SM7ERKC43PdzMuek9jo4I5EOYFlJZohZWVDcdP8u/8QbwUxde21E4OLjnphGxnMB0vRikxi3eMqkwlwtMsa/UCncmwiS8SEIsXTtKvi9wZOsfwhA//l2uBAR5HZdMC1hxLMuubwudGc55/QAjk2V6Q1TSJ8iZuIYlbpVKfyRhfz2p/U7Tv1KJEnkVljjyEAw8o262R73yTe1peAqk+acoXxDdAThFu/N5OIfdqahl9k4Q8cfgJW9NXlpB6Tu3vywn0A3fsH/sv6UY9+L3PDZZftbakpGDRYSE5J7FvurlKGuElb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRR8wHueRVdemVlOtbvQxeCM0SeFTKhFDNGLLLukHaw=;
 b=PUogEf64wPnYSR+VJGZwKapb1qUmd+uyo6+jvKaocVnZpZ6sqt0XKm3Xg+seG0L4X9CRjp5Sc2rEqKM7Df3D3QvsWYTncRUF1PDry7Q/5FKr+FmD0XyvCd7UxIDC41dDETkrUDOnSVoV4TKGAm1FLzFZNnW84pipYY2GbPsEJpI=
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Wed, 1 Apr 2026 14:19:06 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::bb) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 14:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:19:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 09:19:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 07:19:05 -0700
Received: from [172.31.185.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 09:19:03 -0500
Message-ID: <524fc5dd-e06b-4857-82e7-f0a969966bc9@amd.com>
Date: Wed, 1 Apr 2026 19:49:02 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2;
 smp>1
To: Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com>
 <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
 <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com>
 <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: c034d206-7bfd-4849-6d10-08de8ff9a1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Myp0DmUw2gu7LngdXRVsVBuSEjmDHly7VbknRLWXBsoQmrUQTE418ZfXRdRplc9Iqn4vGbm1Zx5MneuWjH8esIqwPf/+H7X2l3gMceIfgfkF17SStbOV98F1KgGM7bdXNfeTO+HQGH3pZPilbkdg+9PaT3xALjEQErHds3WfGSsOzZhReGBH7bp/0rUVbRizckMAtrh8RWU1q7yzbequsRfHFpxm2tztiJ0sox6ZPtaaAJxVTFN263tmgWtkzNHm0m2gBhUCrujyqa9Q8I4SwRAUI6xtbB1S9Y8sbNKD5cHcu1/V8wu3zhqMNU29Httwx+6d+/nKEO7O5B6F0Aj4SuhelJJqdi/sJZEMq+rCYXZbPe5PSnnLmTioz77fhfoFGon2IT2WE+qi7YnAqqGfM2nk6xw2ps0Z9084HqD4r5el2mo+ohSwfVcTOdzhsMxzV3uGQF3RfAQMdAVRYL0EBP+FnLQqmG4h88o9faOWdnkhcRSg3Qlcq068pcSSXX19UYtG1HBsh3wAbYEwFqScUMSsq5xWTJBCZKpoZif3A2LbETOI2BHTTv5ZkSWbtHW48POksdvk//+usqTDUZ4usgmle7r04258GXXtG+mryoUO81GzI7kyoVBZvOkdxMtaSqzOQB8dzi0LJN5EoSrY3ossHAHH2zqGhaoqxXQ7QlrlGzn02ChW1yCmiWn1BLZ+/f4X2ORc0k1pgAIdSeiY+xJX6bmwb5y95At1jjjz3+4SIK0awidsbOp4DWyE/DImL2z+DW40LYT2UlS6XT2AGw1Pf/Hhje+a2RnXJs5X5WQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zHGLCoMRzOynXaDIMp0w2wfx1ykUih5F1AqjQVYv+kaXJlZTRv0Bwp+ripmK+VKBVvbCGa++OyjGwQ/TuMZOQQbQeU8HjB2f56P/VufzllQHffcD9l86by0CV8qTGsAna2CEOrj6tg8IyG+zZdXCYFZetwAJq9uuUdDZw/Cd/n+nVnjnRSSjp8mhIW4CGNc3ha6wSjhoMNjLFjmdWcFUOSQ8k0UJPce0nla37cMT2g5OXXT4de0/Twap8Zu0IBQEFUUcy/MQUSk9l/cIvfyQgNnoq4mmb15WAQBtpx/s4ar7fS6/TlDVJvpec/nmQWwUozH4htsw/MJ/lB9iCxutIa0tUWkHsrt3ZMdNiE5JkZpkkjYibNYwOoS/XZ7WNc2k9kzcKKD7r8JNBuuyc5rL8Upq0/Hl8v0p8nqiYm5Yc8jb7O1OD328Mf9EYpbIwdmf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:19:05.6924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c034d206-7bfd-4849-6d10-08de8ff9a1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

On 4/1/2026 6:23 PM, Tom Lendacky wrote:
> On 4/1/26 06:24, Aithal, Srikanth wrote:
>> Hello Tom,
>>
>>
>> On 3/23/2026 6:40 PM, Tom Lendacky wrote:
>>> On 3/20/26 11:08, Aithal, Srikanth wrote:
>>>> Hello,
>>>>
>>>> I am hitting a failure when shutting down a SEV-ES guest (smp>1) on
>>>> recent linux-next, and narrowed it down with bisection on the host
>>>> kernel. The issue appears with more than one vCPU (e.g. -smp 2); with -
>>>> smp 1 shutdown completes normally in my tests. The same guest shutdown
>>>> path works with an older host kernel (<next-20260304) and is also
>>>> avoided with current QEMU master or by cherry-picking a specific QEMU
>>>> commit onto v10.2.2.
>>>>
>>>> Environment:
>>>> Host kernel: linux-next, tag next-20260319 [1] (also observed starting
>>>> from next-20260304).
>>>> Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue; -smp 1
>>>> does not in my testing.
>>>> Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested QEMU
>>>> master at 8e711856d763 [2].
>>>>
>>>> Details on issue:
>>>>
>>>> After SEV-ES guest shutdown , the serial log shows a register dump
>>>> (example below) .
>>>>
>>>> [   12.613383] reboot: Power down^M
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
>>>> GDT=     00000000 0000ffff
>>>> IDT=     00000000 0000ffff
>>>> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>>>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>>>> DR3=0000000000000000
>>>> DR6=00000000ffff0ff0 DR7=0000000000000400
>>>> EFER=0000000000000000
>>>> Code=b0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b8 <0c> 5d
>>>> c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70 e2 7d
>>>> c6 ee 00 00
>>>> -> Hangs here
>>>>
>>>> Host kernel bisect (with QEMU v10.2.2) led to:
>>>>
>>>> Good (no crash on guest shutdown):
>>>> 32d76cdfa1222c88262da5b12e0b2bba444c96fa
>>>> KVM: SVM: Move core EFER.SVME enablement to kernel (local build tagged
>>>> 7.0.0-rc232d76cdfa1222 during testing.)
>>>>
>>>> Bad (crash reproduced):
>>>> 428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
>>>> KVM: x86: Move bulk of emergency virtualization logic to virt subsystem
>>>
>>> Any chance you have the enable_virt_at_load module option set to false?
>>
>> No, it is set to Y.
>> # cat /sys/module/kvm/parameters/enable_virt_at_load
>> Y
>>
>>
>>>
>>>>
>>>> So the first bad commit in my host kernel bisect was 428afac5a8ea. The
>>>> commit prior [32d76cdfa122] did not have this issue.
>>>>
>>>> Later I used QEMU master and with same linux-next next-20260319 as host,
>>>> it did not reproduce the shutdown issue .. that was using QEMU master
>>>> [2].
>>>>
>>>> QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba (target/
>>>> i386: convert SEV-ES termination requests to guest panic events).
>>>> Cherry-picking that commit onto QEMU v10.2.2 resolved or at least
>>>> avoided the shutdown crash in my setup.
>>>
>>> Well, if it is converting a guest termination request, that is still not
>>> good. It should be a clean shutdown.
>>>
>>>>
>>>>
>>>> Questions:
>>>>
>>>> KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expected
>>>> here, or is there anything that should be adjusted or documented
>>>> following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
>>>> QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equivalent
>>>> handling of SEV-ES termination) be appropriate for users staying on
>>>> stable QEMU while moving to newer host kernels?
>>>
>>> That wouldn't actually solve the issue, it is just a much more user
>>> friendly error message. Is there a termination event in the host dmesg
>>> log?
>>
>>
>> The guest shutdown proceeds normally until:
>> [ OK ] Reached target poweroff.target - System Power Off.
>> [ 9.918849] reboot: Power down
>>
>> At that point the serial console freezes with the register dump below
>> (EIP=0000b004, HLT=1, EFER=0, etc.).
>>
>> [  OK  ] Finished systemd-poweroff.service - System Power Off.
>> [  OK  ] Reached target poweroff.target - System Power Off.
>> [   10.029330] reboot: Power down
>> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
>> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
>> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
>> ES =0000 00000000 0000ffff 00009300
>> CS =f000 00800000 0000ffff 00009b00
>> SS =0000 00000000 0000ffff 00009300
>> DS =0000 00000000 0000ffff 00009300
>> FS =0000 00000000 0000ffff 00009300
>> GS =0000 00000000 0000ffff 00009300
>> LDT=0000 00000000 0000ffff 00008200
>> TR =0000 00000000 0000ffff 00008b00
>> GDT=     00000000 0000ffff
>> IDT=     00000000 0000ffff
>> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>> DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000000000
>> Code=98 59 0c db 72 6c 94 71 3d a6 36 32 49 a8 08 22 bd d7 8c bb <4c> 3c
>> d9 bd 90 b5 2e a0 69 26 53 df aa 4c bb fe 5a d9 b6 ee 7b 45 02 2e cf d9
>> 60 48 00 00
>>
>>
>>
>> QEMU does **not** exit on its own — it appears stuck.
>>
>> Only after I press Ctrl+C do I see in host dmesg:
>> kvm_amd: SEV-ES guest requested termination: 0x0:0x0
> 
> So we would have to see what is triggering that termination request.
> 
> We can probably instrument a guest kernel to get some more info.

Sure, I can apply any debug patch and provide the debug logs.

Note: I'm heading out on PTO until next Wednesday (April 8th). I won't 
be able to gather additional debug logs until I return.

> 
>>
>> I also set `kvm_amd.dump_invalid_vmcb=1` before reproducing, but it
>> produced no additional output.
>>
>> This issue is still present on latest linux-next next-20260331 [https://
>> git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?
>> h=next-20260331, tag name    next-20260331
>> (e5da3eef8dadab4e98b228725ca8948edd9d601f)]
> 
> Is it only with linux-next? Which would point to a kernel change vs a
> Qemu change.

Yes, it is specific to linux-next (starting from next-20260304, bisected 
to 428afac5a8ea "KVM: x86: Move bulk of emergency virtualization logic 
to virt subsystem").

- With older host kernels (< next-20260304) + QEMU 10.2.2 → clean 
shutdown (no hang, no termination message, QEMU exits normally).
- With linux-next (next-20260331) + QEMU 10.2.2 → hang at the register 
dump after "reboot: Power down"; only Ctrl+C triggers the "SEV-ES guest 
requested termination: 0x0:0x0" message.
- With linux-next + QEMU master (or 10.2.2 + cherry-pick of 
56d89db2cfd8) → no hang (the termination is converted to a guest panic 
instead).


> 
> Thanks,
> Tom
> 
>>
>>>
>>> Thanks,
>>> Tom
>>>
>>>>
>>>> Thank you,
>>>>
>>>> Srikanth Aithal <sraithal@amd.com>
>>>>
>>>> References
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> — next-20260319
>>>> [2] https://gitlab.com/qemu-project/qemu — master 8e711856d763
>>>>
>>>>
>>>
>>
> 

