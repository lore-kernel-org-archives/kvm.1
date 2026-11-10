Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794312242;
	b=re/Z6VyjAYUAMOEtZk45vo7Hm45xUO+kj/FS2RGZ1I4Ir6O1O+6u51f/xwiQOBadZdHo
	 pWFeDOITICkub6diLeo14k654SSHKX5XCbC8623NiW83GsO9VLVcm9X73FFLRoMhnAweX
	 BKsGwMwSxmmKkSB9ghjHtFs4JIeuP09FHDE5COkzCB/HjbKgJlTqcBqto0GDAxA+ytNjj
	 C+VMbnpgKpj19gt5frqn+w9Bdnl7ipA7gDrBDgXmDTXdL7HOWd4i0thQEOu2jqK7tXIfY
	 X70JxyZirwr/vuxUXKDlNucnbXXoO/HZm3/dz3R9JVz2yLIjDGcD3WEXradXOLyjxzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312242;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Xl0fVCch92j+6LkHOJo0qMLJL8zDliEYx5Jdv4lsA7c=;
	b=BIPegB+1c1UH0f4DI3PNMHRb4g+sOaPfw97hXWLpqGZR4DfhK7Iz5Um0Iprt+3Aj9F+p
	 hmJjesuwLBdwWZ71tQrMN35WE4tA6oitA56soRUka5OT0vzY6Uo42ViVuwNmTzfrzwvgj
	 qqPpV+40O6MLyQtVSR9b7pbQg3cVrtvNOHYh8fDebXDEbltNaFYYSDDMiXIzWT0r7Q2r0
	 1gVcnHXnDGwnxkuh36FltVTTSvyimvLc5W4OMrfZI62M8yXykKl+bVsMcOCanlmg1i9+X
	 LXZGsYrLKF0knF4k0BzNHnzZm6D8+JeN1N/Z9s1JRxM9+E2Ze/VA6BbdE7RT+YmACng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="l2lBwg/y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.50
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59660A381F
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 12:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A59660A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l2lBwg/y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8XO0s+yyBFUvvuQGZxjEr1JmC5yzR95LdwZ0/K2jtqzKRcWVleJv9YzESD61o+nULK0cFgjGC9APBNEY/WvH29gVOd1J+Oj2OYvGUsS/+kem52k5vHH2YcEGFTqM0H2hSFU/r8H6xEYSec8fNIbaNhUVS0QsY5JzIt06bMrXSDWdQOkh5w711g9VKfAOJSGz12bMJAO09rPTGl092OiYR4/PBLU5B1k4u9wJbn0VQqDCr1X7szXe3IIW554oSWYg3RsdATvTTwcpvGJNCiTF9MFuPRCm080FRp0OoaHty40iwGnGYeQNAwkMHvXuSs1lmz31ejMI2+OrCVvHaGWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl0fVCch92j+6LkHOJo0qMLJL8zDliEYx5Jdv4lsA7c=;
 b=zH5JIetS3+irfEq/35l5PrkM72CTUb2oif/TELpMlf/sqj9Py/vXDFhE1r13rrqOhwL9gepctuwVGCgADnILxMPk0/bZfxvx9VYXrM5DVDhkhSVo46bEGBov8gsCGJjzYOVZ1lRGGlBh2Dn4ihg1Vy6uuSxVLFBEAv9LsLDZaGu9rMGaHbdSHw6vQUml2jNjWFNpbO1cLxR+xdWaHk2EArNQjCuwTcOrfOztZd+m2vTeg4lTAcETN7ApHOI6YQB8m7yxRS7M+qtjNdsF/jopts1CUVfr51ZC8CFDmCe/h7fa8u9bFh9xFNVL+v/LThPoNOIGTegE8XLKhwgBvnPy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl0fVCch92j+6LkHOJo0qMLJL8zDliEYx5Jdv4lsA7c=;
 b=l2lBwg/yQgzWNFuNaHNCQxhqN+X0ndjn5jrXCVPB7zEH2ynw43mdZAsRK97V4JtvBNIC7bmEepNouJFemaL0El2CwzdMKJDZBXOfXVageY1Ks9AFSppp6NrKnJ8MfBlBWPrhET1lnccIYytI1PsXKVVKoQ5f6udCGHLUddu/6os=
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by LV0PR12MB850562.namprd12.prod.outlook.com (2603:10b6:408:608::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:03:59 +0000
Received: from CO1PEPF0001886A.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::1) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 12:03:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001886A.mail.protection.outlook.com (10.167.249.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 12:03:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 06:03:58 -0600
Received: from [192.168.29.87] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 06:03:51 -0600
Message-ID: <ccde63f2-6177-4760-9bc9-c40cd6eacd4b@amd.com>
Date: Tue, 10 Nov 2026 17:33:45 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] KVM: SVM: Add support for IBS Virtualization
To: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>
CC: <pbonzini@redhat.com>, <mingo@redhat.com>, <bp@alien8.de>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <santosh.shukla@amd.com>,
	<nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>, Yosry Ahmed
	<yosry@kernel.org>, <manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-7-manali.shukla@amd.com>
 <20261008191950.816113-1-jmattson@google.com>
 <CALMp9eRkd-kgBpWTS4nYHaCuDH-PPgB-zvtomBXv-GS7G7M1tA@mail.gmail.com>
 <atJKVRcCsAYewGl7@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <atJKVRcCsAYewGl7@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001886A:EE_|LV0PR12MB850562:EE_
X-MS-Office365-Filtering-Correlation-Id: ead8280d-5653-4083-792d-08df3f22b3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003|10067099003|261009223027099003|261102123227099003|261026121527099003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	bBLLrDFlZBMe+2UeOz0OrWjZCHdw1q7Pwnwuf56pOcD76qx3Vg6LYG/8qPGEYWE7n22vJi8AOQMjciKZCtcc1oZKdmJoOVlMuhIACvi/Om7yWxitSlqlG09cvPJAWjwQSJe2JWFC3e4qo5TvXprWM7JLlSXQbeX6Q8pSrWWCaPpnEtzGx6BM/s/Y1SDrQTnA2znYVVHS8xAnEoYmIRKgB5n+dZ0m/71QNwS9LhZ3lr06cOsrzvcolvS9vWf8WNF+ZZ3iFhplewscXYG2M43Ync/AtXZZ0oOrm0NdbdwkvY2FcTndLfjJETjXqpFfW+xUNQpyOpJqZL633tl2UMrqJU24T4tuZ6zikhulDQeXThjw1ST8YZ+enIoJOjwJtSCgmUhJ2wyk8F6ZsfrQ3qBSCPdMscKCXUDQ97Ps3IuhcYYoW80zqawSt/BsiZ9NrmPv+i+mA5BeCHunjPrOlFYoJoAl57RuSvsP1Ho+YsD7o0y/B1T3cvyq6oHYoJ4mkfb4jbHaFKG4mXz4gmAPqDmLOs7py1/3NvJ5hUQ/Ua5G+VMbzcatEzgFl4Ktm4IkkIbU1s7t/eFQDSo1aFbVRHyG2JeYB5xgpP3LyXCjo7dPX/foBcJiL4CsFcJ0bKbRj5o+TL+wrhOkzmvrKXSRBViD98bvkkGw7GIX7koSUGCO4SN7kkuO9eIDc5Z0xrU3P2GBlT5/zP9kXTsAleFPtrwgMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261102123227099003)(261026121527099003)(261021121427099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BYF6RDMXra5JrUNV57hjDWG5CWZ8cBzqYW8DMVOPiMAh4Bi4HNxVI4CoHSUht2pEJRYqlvtDYVTxEGPHdFjSFUOA7cyLFG7NKth6/8cZCABziCRICiCxLhu/4w1cZwBbyFIEAiDHDrgbh0cDUXsuIb62V4UlXAdThaP1orOuzTrwSXR6hUS/betk4PRdD1Y9Qy4lGjtHTcMHc5Z5XTQ8yhQcgx8X1bVSaapx85vtNTfTqZsiXn/c/BE93x0qxxUGUpNvg/xeTztGo9aeQ2sSTD91WRXNlbkNYcdP3ugurls4wn5CgYbk5Z9H19iUBAXlQLJqS07lmq4zoKYY+oHvDCxKOP2IRHGXish8QJVykL7MskEdzVMHH/2gcTsl9lxwXkO/Ixawsb44ipsIEdR3rOaA0Kig/EQURhqJK6YKB8GCR9QLtVkNBmN88QXB9M9u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:03:58.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead8280d-5653-4083-792d-08df3f22b3c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001886A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB850562

On 10/16/2026 9:31 PM, Sean Christopherson wrote:
> On Thu, Oct 08, 2026, Jim Mattson wrote:
>> On Thu, Oct 8, 2026 at 12:19 PM Jim Mattson <jmattson@google.com> wrote:
>>>
>>> On Tue, Mar 10, 2026 at 06:00:18AM +0000, Manali Shukla wrote:
>>>> +     /*
>>>> +      * When IBS virtualization is enabled, guest reads from
>>>> +      * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must return 0.
> 
> This is incorrect.  Hardware returns 0 because it (presumably) doesn't want to
> translate the address on the fly.  KVM isn't bound by such a restriction.
> 

Agreed. I will correct the comment in V4.

>>>> +      * This is done for security reasons, as guests should not be allowed to
>>>> +      * access or infer any information about the system's physical
>>>> +      * addresses.
>>>> +      */
>>>> +     case MSR_AMD64_IBSDCPHYSAD:
>>>> +     case MSR_AMD64_IBSFETCHPHYSAD:
>>>> +             msr_info->data = 0;
>>>> +             break;
>>>> +
>>>
>>> These new cases should be conditional. Before this patch, KVM synthesized
>>> a #GP for a guest without X86_FEATURE_IBS. Now it returns 0.
>>>
>>> But, is this even necessary? APM vol. 2, section 15.38, says that when IBS
>>> virtualization is enabled in the VMCB, the processor returns 0 on guest
>>> reads from IbsFetchPhysAd and IbsDcPhysAd and ignores guest writes to
>>> them. Can't we just disable interception of these MSRs when VIBS is enabled
>>> for the vCPU, and let the hardware handle them?
>>
>> Doh! As I realized later in the series, KVM_FEP requires that KVM must
>> be able to emulate reads and writes of every virtualized MSR...even if
>> virtualization just means "ignore."
> 
> Not just FEP.  As proposed, the MSR is intercepted and so what hardware does is
> irrelevant.

Yes, as I mentioned earlier, these will be passed through in V4 when
VIBS is enabled.

> 
> I'm confused by (at least) one thing: why can software write these MSRs?  IIUC,
> they are outputs from the CPU.
> 
> If these were read-only, couldn't KVM use gva_to_gpa() with MSR_AMD64_IBSDCLINAD
> and MSR_AMD64_IBSFETCHLINAD to get the GPA for the guest?  The MSRs being writable
> is bizarre.


As per APM, vol 2, section 15.38, with VIBS, hardware also clears the
PhysAd valid bits in IbsFetchCtl[IbsPhyAddrValid] and
IbsOpData3[IbsDcPhyAddrValid]. So even if KVM provides GPA, the guest
won't be able to use PhysAd.

-Manali


