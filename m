Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9B3D75CF;
	Fri, 10 Jul 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682545; cv=fail; b=B+ZhoM8CWNaFq4hmuTZlj4B1HwnWEP4avxDtIHWjOpJh0dF2FFy92ZMjY40je1kzrlPnLneN6fecE5+1qfhLxYVVtIDhE4w4BYsCqnT1GNMH96Yj0PaN/rUjQqyH9MKqwo75Ul3tV4NIbIyKkyCQ5uQAfgnW5MFKZ5fjyxKRGqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682545; c=relaxed/simple;
	bh=ginjqeghupiqtJCMdgZ+l5tm7bMUtj7BJ3xU7DsnM2M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Fi73k7xOIYX0d6tEz9gQxzjwK22VejotqzdkPIJzthWhz4S2YuL3TyeBwOjtD3fhueuFN9e38qL8QxHFeV91A8FZ7+80Xy4RrhFTV0VF5eKVGevzvgtwg0PNSC8TV9ec+TFf83hUIj8fzjbCFje3xajcQEAdSpQyyK4RR/w3eTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SmfVaEqH; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SmfVaEqH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcU9bc869HeXPVZRLEceWV8DQezr3qS8x998ufCty5KPlTdlhklC2DmamUc6/YIIvdenIL37P2CMq8By5oSSp1GEY7Wxq7iHn4MBYYU0ZLr+bAZ6eCXA2gRjYEbO4gmRLTdxWYHShdb3q0qgVPMRCBG7MPBe+Bsltyaei62VmY5CrLfFiFBWzryD/ROOdj+1/n08a8JU1au62vhEuWhVU2vtuvFKKTHm3RGPXQtIOpe3T10UMGvWSlws7EEy5ghoOyyXAoXjCT+77XBC0iwSUa/24aSitPIR8If3SwmNVx7G9fHTZmEF8HIgxCET5O3BUx0lWXrBEYrSX7rb0lW/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2UCwyxNCHHGFPW3SxGgZg1IsUMGQ2kWiajMdzkUwWc=;
 b=H8lMw455qYAjOBF7Of30+wQALDZQA5RThRQTDmB3qm2CmezclNkWD8VozVLun3gQMGd9Jo74XZZklON2rVHwzoBR2EgMhA4Si1VeW8pYtmqrCQX4WrTY4JvQMIOfC4dl1eJE4tryHlKuRMmAdWQMWyMx11tzlGM7NYF4q+fHm9e0gWqc+jlatupn23EFcTyh3O63U/KDKB69Ot2GakVDi50Rcpu/Rw8+ubG5ZrNrlEA81Mh2z9yfgLAk7S+dkW/Qr3xY2Z0rpTSqDEqg5gM//QXNbiTtW+4PN/1nhgqiGVT1nkk0+pxHXj9HG9M6bw2t3NpGZcSdOYeUHeygHKzN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2UCwyxNCHHGFPW3SxGgZg1IsUMGQ2kWiajMdzkUwWc=;
 b=SmfVaEqHJRiarKilrQRyco89E64tFDa+kehp6ayvAT+trXUDQir+c2ELR4L6ZU9XjHMOQ4J1LcC+lQ1Cz8VPgkg10m1pTScVzVfSuICVR8/5jYi0frCuPYgRtnyWD8hRbylGkvVNvDrQ261z5gXs9BNwGR2t5y9ncyYsT5myUBg=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 11:22:08 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::51) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Fri,
 10 Jul 2026 11:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 11:22:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 06:22:02 -0500
Received: from [172.31.178.83] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 06:21:58 -0500
Message-ID: <92849e86-2a87-4bf6-bf42-6a3430252fc4@amd.com>
Date: Fri, 10 Jul 2026 16:51:57 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
To: Sean Christopherson <seanjc@google.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>
CC: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Saenz
 Julienne, Nicolas" <nsaenz@amazon.es>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
 <afycwi4KT6xrQhMX@google.com>
 <beff5bd9-ae7c-4f2e-a718-7c8e92e78e4e@citrix.com>
 <afysu56g2dTFla6-@google.com> <afy2h3RxiKSBh_Ym@google.com>
 <85o6hu4k7f.fsf@amd.com>
Content-Language: en-US
In-Reply-To: <85o6hu4k7f.fsf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cefc51c-acf4-4324-c9e7-08dede757a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|4143699003|56012099006|18002099003|22082099003|11063799006|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	1WNxw8/26Vaurt/ORvv/NLtYUYL3WsCxwJEV8oSDIQyJ/4+mKK9g8VZM4TVZPWu7Tnv531tR6j3S7oZoqf94led1RnZyqh8oWw9gQkcC/zJO1tIIZukNOX73dCHz5YEfma9mUuLhHR1H8RamI2UfhGN71bZiV2wxpm3a7eAp0pa+5sOAU4Da5wQjUJHkIxQKp0xKnZ6wCqU3iQ85ULnFuqTG4fe7navAhbxLZ7ctOkLrhPdcWA7ts3rHd9JqtNtN4aq2w3/Fz1c5uzhi67XXGaxT0eeiDdxwd58PEDxXxBfsi5Ht7bT50cncRdEDC4vi6UAcQpbvn6ajkLLe36ysil0IOLN+fOnqA1KMBPWAQ5ysNFSo5AzfXjTpEAWnHnD5UT3kpVISd8MQJsWwNpDQ9Sfp2rmfReKMsr1Xg+zzZCo24+sVFsrXPYCM++505Q2hgpYa/rqLZwJIFg1S00qQMPE3Zq08lOPNBMjQQR3NNNrlI8PyXUUFOe3r6qEVCkjAn/GbKDrlWtbsE4uOVFZzpZMDyjJTjkSthyQjQjXcodJcMmYL1r8owLiLLusQ+wi9SFTjiO667cE5Tf7LPs2uLl/4Rzay5KomXtd95F1yq7FOBwWRBrF+xhKf79cBv1VD0Cf2nkaGG4CC9AXgGWWh85reqCxSyF3NJlDqA18dkK6uO+Y1WZAlk6xuE2EmE+3x3G71u37fqnd3KIYzXaZ+Lg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jkr3Z6VmR1VJMG1x8tOPgnQiHm+Rkf2sE6lT/6bfkgG1U+Yr3n08XAoiyDKkoErz9j4BHaix8OA2YCBLmEREavoNXUUxXSYW2YH71+OJzKtUHFyjGYjbRwroOJWWbVR7zw4iss7/deAle1D8u1dXSQ5fsr+At8av0P3P1WsQtpor4CK3WKBJbxSwUU+7TsJE+g+Y51QHilYZvRO0BEzw4dXGPMgqMdhd5PbsPpdGrXZpzndOgYdCSXN08TLqRqm/1wZc/A7KFlM6r3BPL26IUrZIKy5+WSGrlzQw4ysIK4UkO/mE17lIskSeO+undyGBv9U0AJRH/CEh6BrC9xavD+e8KInbFjFqM6eckrthxBhMUW8imweZLJ52cLOG24LxwRtt0HJZQwtr6jcsPglR52TUY303Z7hCiK64i0RtsNo4878SH6pkNfL+jv+mA0o/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:22:08.0210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cefc51c-acf4-4324-c9e7-08dede757a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127



On 6/1/2026 4:10 PM, Nikunj A Dadhania wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
>> +AMD folks
>>
>> On Thu, May 07, 2026, Sean Christopherson wrote:
>>> On Thu, May 07, 2026, Andrew Cooper wrote:
>>>> On 07/05/2026 3:08 pm, Sean Christopherson wrote:
>>>>> On Thu, May 07, 2026, David Woodhouse wrote:
>>>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>>>>
>>>>>> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
>>>>>> trap, but on SVM it was not always intercepted. Unconditionally
>>>>>> intercept ICEBP on SVM to match VMX behaviour and ensure correct
>>>>>> event delivery semantics.
>>>>>>
>>>>>> Add two selftests exercising ICEBP:
>>>>>>
>>>>>>  - int1_ept_test: verifies that ICEBP works correctly when the
>>>>>>    exception stack page is not present (EPT/NPT fault during #DB
>>>>>>    delivery). The IST stack is evicted via MADV_DONTNEED before
>>>>>>    executing INT1.
>>>>>>
>>>>>>  - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
>>>>>>    task gate, exercising the legacy task-switch path for #DB.
>>>>>>
>>>>>> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
>>>>>> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
>>>>>> of after it. With the fix, both tests pass on both platforms.
>>>>> Hmm, but KVM unconditionally intercepts task switches.  Is this effectively working
>>>>> around a bug in task_switch_interception()?
>>>>
>>>> Not really.  It's a bug/misfeature in AMD CPUs.
>>>>
>>>> When you get TASK_SWITCH (which always has fault semantics), you look at
>>>> the vectoring event type to decide whether it was logically caused by a
>>>> trap, and therefore whether to move %rip forwards before entering the
>>>> new task.
>>>>
>>>> AMD CPUs don't distinguish instruction-induced #DBs (i.e. ICEBP) from
>>>> exception-induced #DBs (all others), and also don't report an
>>>> instruction length for an ICEBP-induced TASK_SWITCH.
>>>
>>> Heh, that explains why I couldn't find an equivalent of INTR_TYPE_PRIV_SW_EXCEPTION
>>> in the SVM code.
>>
>> Dragging in a comment/concern Andrew raised offlist.  If AMD doesn't provide or
>> *allow* the equivalent of INTR_TYPE_PRIV_SW_EXCEPTION, i.e. type 5, then what
>> happens when KVM needs to inject an INT1 #DB with FRED enabled?
> 
> I'm checking internally to get clarification on this. Will follow up
> once I have more details.

Following up on my earlier response — this has been addressed in the
AMD FRED Virtualization specification. Type 5 (privileged software
exception) is now supported in both EXITINTINFO and EVENTINJ for
FRED-enabled guests.

Details are documented in the AMD FRED Virtualization spec (Rev 1.10):
https://docs.amd.com/v/u/en-US/69191-PUB

Regards,
Nikunj


