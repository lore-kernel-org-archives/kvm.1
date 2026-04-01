Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682643DEAD0;
	Wed,  1 Apr 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042686; cv=fail; b=BaePQgEXgNKlTiXN35nQ3UjNE5+7BG6Fv6M+uKjgZ6wvYbCamFQa6hwYug9saQqVDZZpHZpnlHI/aEIAqy/a+GMmswaFg5GXaujkpR+G4wK6W4cYYX5JgCZSW9WHSyTAcnPmCu1OU/ClF57o1g3Qnh1j8wCQcjuPVcq+6sJQC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042686; c=relaxed/simple;
	bh=PnfhNJdrT/2PwI0UdMuBrKwYCUB/1h3v0KZLBZgr6Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dpR2RQxCai4SrHqWgUN+ftUgnkR1qThBaCfIxrqBztQJI1nY8diImVgLGp/e8FXodZBwezZvBAFZH9DSrqdcHUlEOVc3aizPjIknjm422XXXVnKHBpoDzGuqf2ZuQSgFdtX3Fcv9fZ7f/hiOmO0fJKsrEwLuYsECSa+rCKwXnUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=He91qtGM; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="He91qtGM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qblzlQCyfPEbF9bCAcISu1SON5Ig2q8Qb5BCouktUlZON5BOUXRF+ms+l6iBwU3J6WIDsHbQJszAqb/K1y3KVPknBjXL4CAJFtvyxSvbMoARAcaF5biIlWw4e3wA7mu7XlUBLD6N8zehoWi0u4xsDdkrrSQX1mpA64ENm2xVJwniwQDD7tr4T3Ef6Ql9XgoGWfRu+r61YgAASh6g+AS8Ju2dfLEJbup2WNeRSjvq34Mc21lzpT0D9olc1IUSZf4Cx4+NCD8FLupSUHpnWh62U444SxnVxBpV3xiR4A1GRauQ2IDPVci4sjYWIB4wIBqV+JwiYO2L/pcxbFfpiZmjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiLuVfFW9PfzXfcap2z04MArr+6eUcKnlSVl3Tv8hkU=;
 b=Izd0iI50mPDuOYBXo6fIV0yznEG4zib4Evv7BPvXbhbAYmDWysqB3uMUI84svnygLHS7qdoO4zFusl8dSGcD1ZMMrt67WdxSMUsdOenO+Hosz8s+U5Nkg9TazWnNYa3Exynw9USKr5e92okoCWsciEnQ3ZWE2fnfIn8DEIcdKyh2la4iRZ3a4dNXvoTrBmTM03Ag2ZmxqfVc+bKhQm6hx4+Fw8GLBV/1Qc5CRQTl8Zcy/nRtbZs6Bs98se9iH1G0u2wPAwD6WpRX9G/RR/I1CSoPqWHYdeMFGY3JbNl8vWXr+c0n66DAiNaE4HF6IUqlV1WC0zZ0ZXakIsOTtqF9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiLuVfFW9PfzXfcap2z04MArr+6eUcKnlSVl3Tv8hkU=;
 b=He91qtGMsO5n++08WN6ITY0i+2fwmOvdAl4PRe5if8witgu3Trm4BqFjigHN6A93bR1KCE6hDWIjZaZBNI8YOsQM73r5+saq0bA/FvnBdL98p80tGHMoYvs6sFUj5VNFUrd+mU8txhKZXqvFVE0KanOEU4Gq7LaAnCY408UhBvY=
Received: from BN0PR04CA0152.namprd04.prod.outlook.com (2603:10b6:408:eb::7)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 11:24:41 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::77) by BN0PR04CA0152.outlook.office365.com
 (2603:10b6:408:eb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 11:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 11:24:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 1 Apr
 2026 06:24:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Apr
 2026 06:24:40 -0500
Received: from [172.31.185.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 06:24:39 -0500
Message-ID: <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com>
Date: Wed, 1 Apr 2026 16:54:38 +0530
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
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: sraithal@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae75442-c087-4838-fc02-08de8fe14484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|30052699003|1800799024|22082099003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oezBeQyoSdj+KmDLn4GvslD9mFsuSnv1i6ukih7n2YCfocOIsWtrEMTbfnRxOxoT2vBcOf/7wYb0gYd5DK63Rpmgzu9hM1aUEF8n5q+7kQnxJx4CWJB+pcgOKSjLgrnakFbMiVYHFEhDfI2qLMlDhY1f2NuO5ZZ4mkaCuQdXxo1D1RHV3+hDG+s6yG5FlNz6yUggQgZphapaiK0Fh/rK2Ao5mhppT0pEuFTlY1YzLbv/azeEAG6a/vtdvP69mNAgGmBqj2WGf157DFh4+kYs5//AWuKeuykNL4Zt2AsjtZBz67PQeHjDA+fBfZZOhlwIEv+YiA9wLPArit2VvxcfE5kMFao6Kn6f+0hrl1avdXNkd6z5VotHOG9L1umXAAbd9w5ja4ut/L6KzTiVt4bZkazm87uJeph3gN+Ud2VoGZiB6FbfvRyVks9faDJVFLE7R6og+vLbFesXPrCElYIWK3WQV1IoX7U18kph0Y5/yc0LvMgbKFk9wf9tM1OwRj+qrE3UKMyz3XkJO+8/Pibn9KXjX8z03zR3aiQF5oQMC9UKy4R5lAxZovOCtZk5w8yOCSTQfQWyd/rxTaceF+o4xPZCL/WhRIZLzZCsJ+6Upp/kvrPK6SSoJ+ntFOiRwxepGtfeGd1Fka9tiBkvvr932KcqhOLMhGwSz2OorAivEQdHIagCHXjFJqOVT1vK+XZdlMZyEcLjhjkzKR6wSCs53MEP+OMvpI7e/PBwNlxGd9G/+xQpwEpoDP3F1zhTFis28twP5OKYKX6iV5yXvy/3pqLdku6VZvOFITIXtULxS1s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(30052699003)(1800799024)(22082099003)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mhMMJvfJqi8TyG9SEcu5NaATkY5315QnmLaHmRlgn0g+34zEImWAXo5Xv0/T+OzdEGJGYX3jTuPhwFhFHt3OClBJpgZwfyFt4kAkQ8/Oxqr3y35Hlv9kNm/q2W7rejzu6bOJpZ1KWLrWNfzjZnvmB07ECG0vjCy65LJLVZPL9+bKHmTKUO5dXDk8ODj8dtGdeNW9iPrg2wO4l+a9rEtRRa3EvSqqRnk8D5vwb/XpXLtRO/pqX524IPKyvf5MUxTLPadVSY7DQcJXjxZDxaJxOGff722WyXraLjk4VF0t19AkQiEsX7APKwgibACnVgrwJHKyp+v0qg9d/ujfwFcN3OlHxO5thZBluHdZfK5srJqNBZ9fOfqycNxh7GaPD93FytFMXPWNyIj8TvVUUJ1CRY7Ewfj1wRB3wSPpR7qv8KMTlh1xjK1T5CD6tvtc2Qzp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:24:41.2729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae75442-c087-4838-fc02-08de8fe14484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Hello Tom,


On 3/23/2026 6:40 PM, Tom Lendacky wrote:
> On 3/20/26 11:08, Aithal, Srikanth wrote:
>> Hello,
>>
>> I am hitting a failure when shutting down a SEV-ES guest (smp>1) on
>> recent linux-next, and narrowed it down with bisection on the host
>> kernel. The issue appears with more than one vCPU (e.g. -smp 2); with -
>> smp 1 shutdown completes normally in my tests. The same guest shutdown
>> path works with an older host kernel (<next-20260304) and is also
>> avoided with current QEMU master or by cherry-picking a specific QEMU
>> commit onto v10.2.2.
>>
>> Environment:
>> Host kernel: linux-next, tag next-20260319 [1] (also observed starting
>> from next-20260304).
>> Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue; -smp 1
>> does not in my testing.
>> Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested QEMU
>> master at 8e711856d763 [2].
>>
>> Details on issue:
>>
>> After SEV-ES guest shutdown , the serial log shows a register dump
>> (example below) .
>>
>> [   12.613383] reboot: Power down^M
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
>> GDT=     00000000 0000ffff
>> IDT=     00000000 0000ffff
>> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>> DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000000000
>> Code=b0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b8 <0c> 5d
>> c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70 e2 7d
>> c6 ee 00 00
>> -> Hangs here
>>
>> Host kernel bisect (with QEMU v10.2.2) led to:
>>
>> Good (no crash on guest shutdown):
>> 32d76cdfa1222c88262da5b12e0b2bba444c96fa
>> KVM: SVM: Move core EFER.SVME enablement to kernel (local build tagged
>> 7.0.0-rc232d76cdfa1222 during testing.)
>>
>> Bad (crash reproduced):
>> 428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
>> KVM: x86: Move bulk of emergency virtualization logic to virt subsystem
> 
> Any chance you have the enable_virt_at_load module option set to false?

No, it is set to Y.
# cat /sys/module/kvm/parameters/enable_virt_at_load
Y


> 
>>
>> So the first bad commit in my host kernel bisect was 428afac5a8ea. The
>> commit prior [32d76cdfa122] did not have this issue.
>>
>> Later I used QEMU master and with same linux-next next-20260319 as host,
>> it did not reproduce the shutdown issue .. that was using QEMU master [2].
>>
>> QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba (target/
>> i386: convert SEV-ES termination requests to guest panic events).
>> Cherry-picking that commit onto QEMU v10.2.2 resolved or at least
>> avoided the shutdown crash in my setup.
> 
> Well, if it is converting a guest termination request, that is still not
> good. It should be a clean shutdown.
> 
>>
>>
>> Questions:
>>
>> KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expected
>> here, or is there anything that should be adjusted or documented
>> following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
>> QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equivalent
>> handling of SEV-ES termination) be appropriate for users staying on
>> stable QEMU while moving to newer host kernels?
> 
> That wouldn't actually solve the issue, it is just a much more user
> friendly error message. Is there a termination event in the host dmesg log?


The guest shutdown proceeds normally until:
[ OK ] Reached target poweroff.target - System Power Off.
[ 9.918849] reboot: Power down

At that point the serial console freezes with the register dump below 
(EIP=0000b004, HLT=1, EFER=0, etc.).

[  OK  ] Finished systemd-poweroff.service - System Power Off.
[  OK  ] Reached target poweroff.target - System Power Off.
[   10.029330] reboot: Power down
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
ES =0000 00000000 0000ffff 00009300
CS =f000 00800000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=98 59 0c db 72 6c 94 71 3d a6 36 32 49 a8 08 22 bd d7 8c bb <4c> 3c 
d9 bd 90 b5 2e a0 69 26 53 df aa 4c bb fe 5a d9 b6 ee 7b 45 02 2e cf d9 
60 48 00 00



QEMU does **not** exit on its own — it appears stuck.

Only after I press Ctrl+C do I see in host dmesg:
kvm_amd: SEV-ES guest requested termination: 0x0:0x0

I also set `kvm_amd.dump_invalid_vmcb=1` before reproducing, but it 
produced no additional output.

This issue is still present on latest linux-next next-20260331 
[https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20260331, 
tag name	next-20260331 (e5da3eef8dadab4e98b228725ca8948edd9d601f)]

> 
> Thanks,
> Tom
> 
>>
>> Thank you,
>>
>> Srikanth Aithal <sraithal@amd.com>
>>
>> References
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> — next-20260319
>> [2] https://gitlab.com/qemu-project/qemu — master 8e711856d763
>>
>>
> 

