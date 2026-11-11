Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399098;
	b=SVJRUgZMgJ2qW0nmO67nXXCe66EgCchilNncQnVVHLu2BdDb16UuF1N3+0YRybbvISFR
	 WD9B1EINhK2npUZwoRKRJtMdEBK0QH2nP3vBBqOuyD1c2iG3Y/cK+21dAU6RHf6SpM4Ml
	 pQC22kDh2un16hxao3KEUAi0OF0xtR98wV41Xwit4QtZd1qUDMnzRlDJZE3BaOIFIQ2zJ
	 rLNAfxfLM6Nu0jWoAw8jLUc5n2LQdN3SaLqU1kuONg3MbD8f9+JiSEtv+Fnge1vVzPROx
	 3z7UMDRRml8TVbikGOHtvdvBS1td0nrRtD7M9H4xUdnde41imRJw3P7iB0Sw/jMFsOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399098;
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
	bh=fOZSW/175Ur2Yeh8IetDMcpjcCwDGcA7PDqfosVSRcs=;
	b=r3y4QqhqVunlKO7TlUZvg37NbXMU8vsk8w/AJOiThUVqUZg6Mu/1tggB3nzrM2NUHIJ4
	 X6JMRPuWjMsq3He0tif8SpYdTgZ9q0jCb3mVIS3F2w0DgJj6hcB1j9iOnYPv7WVAgsvu8
	 HgFkynZfbcq6qRAWddDzPwH4xYXAM7OOO+Tr7UURo8ccuhy+HKYd390co4YzpI1bYT+6b
	 2v8nCHT7l9xf0GKy7javuz1J/EsmAqHW2Ro/qV6WZ49oStCM0sKJoH3HFdot41SDkjQtV
	 86zS/8GT0vteVgcw7QEL8lyBA0ekLqEdekE50id1+ImiTgn5IdehSh/XHQydwV0z9+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SmdZGMWq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.41
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324E606A888
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 12:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C324E606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SmdZGMWq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTroZ8SEwlwI8M6iT7nGfNfKCkEwMLon5k7wQUbgkWzsm0k2lMgsLFRz9XX4/Q77Lqv4ReN9V3X56cryskm+a/lradmf+GxRnva+x8E7CkLXq9oDjHJBJ0+Q63CXqCyhmJwp4cex3Pky/vYSAH0d6Y1YfJaiGrnvsYrBZcr8ZujibdTLfIehy/F8x4WWoIAmIrEGMpGUOnCffAjHCkO+guMMoTk0xfsTj/o5Pxf1v0UM+7zopN3pBgDyhF6sGOAnE9rD8GLMtQYClGUehTXf2Qd37u6RI/yjNInY5xlop70pexVd9d1ywDW6mvJxPi/qrDMWtx8i7H8VDnBwrO1gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOZSW/175Ur2Yeh8IetDMcpjcCwDGcA7PDqfosVSRcs=;
 b=Myly3BUXOR4w2oxlpRISNKs4ZwR85Tx3mXkpVCBTLFHY4hZBR3U3sN3XWndGDteF06q9yFajkREDHi2kc9RQXiRgo/urfovuvUpVqa/yeH+GRPcvIONqsOD3TKasrP51BGsjEbNsvEobwReJM/P8N2p6qlYhUUrnusobgod3V3F7yxGgumdg4m8CofVmLyimwl+7lHv2ROBAxKNJHCEOVA/DIJJ4+HSh8Ii6LSntMEmpzuZJeRzAJJoyfjNzuQmfZ8vuzbV5tms0r5M25dB9LygbSqI0bX030Iz5QmVddF3Ep0TUms6NxUO+5+2XcX+qIGCouVOcZ4KSf8Hx0Zctlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOZSW/175Ur2Yeh8IetDMcpjcCwDGcA7PDqfosVSRcs=;
 b=SmdZGMWqKtVA6otL3Pcz6Giz5IwGE7WiuBWy+ZEgEeKer9y6oMquyPXJBQ0TXXfEc8SHBXhiAs9/usz7NcZHUa/xACGlsmMMXo1PVeyFbh1XV2tPIY0m8zZlP4RXVM/MZO1wCH2JaYz+mB2Cam6EDveLj0aPaLVHsm/+Vm9+cqQ=
Received: from CH2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:610:4d::13)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 12:11:29 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:4d:cafe::6a) by CH2PR19CA0003.outlook.office365.com
 (2603:10b6:610:4d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 12:11:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Wed, 11 Nov 2026 12:11:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:11:28 -0600
Received: from [192.168.29.87] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 06:11:23 -0600
Message-ID: <6a206ae1-cb59-4d80-96a3-0fe417452d5c@amd.com>
Date: Wed, 11 Nov 2026 17:41:17 +0530
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
Subject: Re: [PATCH v3 9/9] KVM: SVM: Add newly added IBS capabilities and
 MSRs
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>, Yosry Ahmed
	<yosry@kernel.org>, <manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-10-manali.shukla@amd.com>
 <20261008210306.938803-1-jmattson@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20261008210306.938803-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f3ae8-1f22-4662-1e72-08df3fecea9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|36860700016|82310400026|10067099003|4143699003|11063799006|5023799004|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	G7K9KOPrGGfdAeI4Qbqf7psncQyE3JJFRB0mehhO3UZ5aMNHwu9VLkMhZ8PxnzHCW8NRWwhI6ZNKeDL05OK6J7oAkoA18xJ21HAnWcWVSKlMY7DmsKlRWcd3MfxfCgXI5IECfX81kKBGIJadQodmPAOG+wpnInoehDhTivTDZVYHLORCZ6r0nzB/AJ5g42gZdieZI/3nScPlTbCUGzRjknUYxTsSbxqUO8BAkpEyA2NZZ+BSLbLB5kYUtU3UWuUHcO8pulWnNn5wfKPwtW3zHyfU7dSdGoSg9qZ4/BEQeofD1DtGvVGmaQqd9H3/PMfa22PvCvgm6qy+CABwDzkhcChDoIU0dRKwzZeEExjJ3JjOXl9vzAUz/qPewBjeky4Oi9INeWUQEW7vSgOEKELk0XMa3moENLnqbvtoosfOUi12Plc5UFpjat3VIefwOGT5gHGNJ5vG86yXidVpgJ34Zk1Y9S2rqQSj4uSz4Dsk1zfPCnao9Pi9ws5WL4KD//M7XI2nbNoqFybvsvti8nkRa0swcCh8lIUSdEkR2UEe73JiuGMLI5pBUnpcOivH4JjBD0ced8CS3p3ky3PRYCiqrEajZwTgdxzFcf32sGIF0JXFyzYyE8pbSsC07Bxh1Qf2YGb1VYRpEyCETWleAmyJ2vNdqAFkjhrFT8sTxvpfihs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(36860700016)(82310400026)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pWCTRo/gg+lNDd3aTkoV3s1qA//9T9JfE1AAfBLUtRrKz2VLjuq1dTq5FON8QL3UkL80vX8qaui4QMJch9+b2lUYkKhIuDTHsBi+WRkWAI8n2XESFJuCatV9sK25hyHqTJqnizsD1Zk3csGIQeOKEZHA+3YfAE/DoVuX+U7/OdIZruDarTclLBphMZxFCgG3Wa4Vgq33kAQtZ6psnl2rdEzokU4C44de4bwWul4t8hhR8nwrOhKQUXHLWKJ7rfogjfgFYHdhZsIopvPRx2VFU1xDhTUystfuQI33NegGj21+aG1rKALlbNnNQNxhUf5YzSivqdgv4jvW8etwthW7lWend4qnj67iFBOxRJAquZD3ut0Amg33pr/L8KPo3XD64x8krWRossUqIyehARjsqmZaNS24sd3fbxFMc3GWoCePyUWDdbCcMYg6nHbEUMkX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:11:29.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f3ae8-1f22-4662-1e72-08df3fecea9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E

On 10/9/2026 2:33 AM, Jim Mattson wrote:
> On Tue, Mar 10, 2026 at 06:00:21AM +0000, Manali Shukla wrote:
>> IBS on upcoming microarch introduced two new control MSRs and a couple of
>> new features. Define macros for them. Add these newly added IBS
>> capabilities to KVM-only leaf 0x8000001b, so that when IBS feature bit
>> is enabled on the guest, these newly added features can be used by
>> guests if the hardware and guest os supports it.
>>
>>  - X86_FEATURE_IBS_DISABLE: Independent IBS disable capability to
>>    avoid RMW race
>>  - X86_FEATURE_IBS_FETCHLATFIL: Fetch Latency filtering
>>  - X86_FEATURE_IBS_ADDRFILTER: Address Bit 63 based filtering
>>  - X86_FEATURE_IBS_STRMST_RMTSOCKET: Streaming store filter and
>>    indicator. Remote socket indicator.
>>  - X86_FEATURE_IBS_BUFFER1: IBS buffering v1
>>  - X86_FEATURE_IBS_MEMPROFILER: IBS memory profiler
> 
> APM vol. 2 (rev. 3.45), section 13.3.7, says, "Hardware virtualization and
> IBS Buffering are not supported for IBS Memory Profiler Version 1."
> Moreover, the memory profiler requires additional MSRs
> (C001_0380h-C001_0386h), which are not in the list of IBS virtualization
> state in section 15.38.
> 
> KVM should not advertise X86_FEATURE_IBS_MEMPROFILER.

Agreed. X86_FEATURE_IBS_MEMPROFILER will be removed in v4.

> 
> IBS buffering *is* virtualized (IBS_BUFFER_BASE, IBS_BUFFER_SIZE, and
> IBS_BUFFER_TAIL at offsets 7D8h-7E4h in Table B-2). However, this series
> does not add these fields to struct vmcb_save_area, and it does not disable
> interception of MSRs C001_0390h-C001_0392h. svm_get_msr() and svm_set_msr()
> do not emulate these MSRs, so a guest cannot really use IBS buffering.
> 
> KVM should not advertise X86_FEATURE_IBS_BUFFER1.
> 

Agreed. X86_FEATURE_IBS_BUFFER1 will be removed in V4

>> Extend VMCB save area to include to the newly added MSRs:
>> MSR_AMD64_IBSFETCHCTL2 and MSR_AMD64_IBSOPCTL2.
> 
> s/include to/include/

Ack

> 
> As with the other IBS MSRs (see my comment on patch 6/9), svm_get_msr() and
> svm_set_msr() do not handle IBS_FETCH_CTL2 and IBS_OP_CTL2, which breaks
> KVM_{GET,SET}_MSRS and KVM_FEP. (And to correct what I wrote on patch 6/9:
> even if we disable interception of MSR_AMD64_IBSFETCHPHYSAD and
> MSR_AMD64_IBSDCPHYSAD so that hardware handles native guest accesses,
> svm_get_msr() and svm_set_msr() still must handle those two MSRs as well,
> for KVM_FEP if nothing else.)
> 

Agreed. will add them to svm_set/get_msrs()


>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
> 
> [...]
> 
>> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
>> index 22cfdb331e9e..1af2ba207b8a 100644
>> --- a/arch/x86/kvm/reverse_cpuid.h
>> +++ b/arch/x86/kvm/reverse_cpuid.h
>> @@ -89,6 +89,12 @@
>>  #define X86_FEATURE_IBS_FETCHCTLEXTD		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 9)
>>  #define X86_FEATURE_IBS_ZEN4_EXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 11)
>>  #define X86_FEATURE_IBS_LOADLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 12)
>> +#define X86_FEATURE_IBS_DISABLE			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 13)
>> +#define X86_FEATURE_IBS_FETCHLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 14)
>> +#define X86_FEATURE_IBS_ADDRFILTER		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 15)
>> +#define X86_FEATURE_IBS_STRMST_RMTSOCKET	KVM_X86_FEATURE(CPUID_8000_001B_EAX, 16)
>> +#define X86_FEATURE_IBS_BUFFER1			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 17)
>> +#define X86_FEATURE_IBS_MEMPROFILER		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 18)
> 
> Three of these names are different from the IBS_CAPS_* names for the same
> bits in asm/perf_event.h: IBS_DISABLE (IBS_CAPS_DIS), IBS_FETCHLATFIL
> (IBS_CAPS_FETCHLAT), and IBS_ADDRFILTER (IBS_CAPS_BIT63_FILTER). Please
> standardize on the existing names.
> 

Ack. I will correct them in V4.

>>  #define X86_FEATURE_IBS_ZEN4_DTLBSTAT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 19)
>>
>>  struct cpuid_reg {
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 421a929398da..9bf0d5f66239 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -800,6 +800,13 @@ static void svm_recalc_ibs_msr_intercepts(struct kvm_vcpu *vcpu)
>>  	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSDCLINAD, MSR_TYPE_RW, intercept);
>>  	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSBRTARGET, MSR_TYPE_RW, intercept);
>>  	svm_set_intercept_for_msr(vcpu, MSR_AMD64_ICIBSEXTDCTL, MSR_TYPE_RW, intercept);
>> +
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS_DISABLE)) {
>> +		svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHCTL2, MSR_TYPE_RW,
>> +				intercept);
>> +		svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPCTL2, MSR_TYPE_RW,
>> +				intercept);
>> +	}
> 
> First, this function never re-enables the intercepts for
> MSR_AMD64_IBSFETCHCTL2 and MSR_AMD64_IBSOPCTL2. If KVM_RUN recalculates the
> intercepts but returns to userspace before VMRUN (e.g. due to a pending
> signal), userspace can still clear X86_FEATURE_IBS_DISABLE with
> KVM_SET_CPUID2, and the intercepts stay disabled. Call
> svm_set_intercept_for_msr() unconditionally with the computed intercept
> state, as svm_recalc_pmu_msr_intercepts() does.
> 
> Second, IbsDis (bit 13) is not the only CPUID bit that enumerates fields in
> these MSRs. Per APM vol. 2 (rev. 3.45), section 13.3:
> 
> - IbsFetchCtl2[IbsFetchLatFilter] depends on IbsFetchLatencyFiltering
>   (bit 14).
> 
> - IbsFetchCtl2[IbsFetchExclAddr63Eq{0,1}] and IbsOpCtl2[IbsOpExclRip63Eq{0,1}]
>   depend on IbsAddrBit63Filtering (bit 15).
> 
> - IbsOpCtl2[IbsOpStrmStFilter] depends on IbsStrmStAndRmtSocket (bit 16).
> 
> The Linux IBS driver already uses these MSRs for IBS_CAPS_BIT63_FILTER
> without IBS_CAPS_DIS (see perf_ibs_init()). If userspace gives the guest
> any of bits 14-16 without bit 13, these MSRs stay intercepted,
> svm_set_msr() rejects the guest's writes, and KVM synthesizes a #GP.

Agreed. I will add a helper that checks CPUID Fn8000_001B bits 14, 15,
16 with IBSDis (bit 13) and use it wherever CTL2 MSRs are checked, so
CTL2 is available to the guest if any of these bits are set.

- Manali
