Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664229;
	b=r9ojPm9WdLGI3pdpHEY2TV8uaK2I/6m4vmoWDwhwJLLpnZQKx21bGS0nmKX/aHtLqCHN
	 Kjt9HsvC01mTRiqbIcIukKedh3qWBL8piURvAtT9fQru38Ds4wBz8uYFqyS0Z3qF6kEzR
	 3ywRMXjkhG1FAqoZemvAmo4MAb406U2Awh1vY9eWqjev6szN6x9hLkbTV8FMVi8YwDBrQ
	 n6N//qvDnbamRmUZuG6o7Vp9khXtBagECRhUQVPsBuITo4jzIxs0u62gLJFheY7T9pTp2
	 rZJOQGluO1vpPf7oDGzWBBbLzHT38B267YB0r3bqyhoYnIJLHwYji8yHDT9m5W2pTCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664229;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=6UK3AcGjkuBTMo+gLFEk8Dro7pk13qAcdxN0NoHSENw=;
	b=OTYkvLbnfidOteJopCm02sYeoDkm0+HYPxiqvbtCWYwUfhMnmOq1cSZN5OB8t9du2F7z
	 hxFmVHJtPUphMLEsXh7mKy4SwlHOjLfGc/ploB1KKHfPMmUvY1esYGVyUXfWcEJCfImhw
	 7NS3u8ibDeCFcqv91ULFR9aETcwN12RXRRYeBXj8bkxltKUr6pEbJue97z1rLQSGMxQVg
	 Ga8xtRkS7sU9HnGgteMJFWpQTc5MQZ7Ds3GFaZ24kPS9W31Z2bhWJTygIZuV9BHAKx3/w
	 GUb3lzWt65idNkFbbBVMlXe+IdbCaHFCI09gw4POfU2/3jtXVTB8EzmivbmbolAXuNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J5UacBUR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.7
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D75606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 10:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D75606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J5UacBUR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY9r6zlT1rT9adEEt59yCdlSEJfvocs2jXS0hbx0em/9oZUzExGQ4F8WXjm5l59f99c4IePXwHVJdzoa8QrkBdP3AZg8UA8rT/jPhmZnVhMGlF5kVG9eXItXzf4BPQXmF/Na3aKY8lloNMokhFccH9Rl2v8wtKmzfktmzB09nUUMQtUMAfyKJH0zwfHVjRIZzf3slA0vwjeXGIGvCCAzHlIXP9hTBIwENqXFy7T9SAglaumvnrLiQKIsk9WUwubwYTNBEIC66FuEVIT8ucSKhCRybjRcX0sa7F95khokCAgt2eIJrFwCqBSLpZsPC2u7nrdHwSZEjfVQV9bnA7DfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UK3AcGjkuBTMo+gLFEk8Dro7pk13qAcdxN0NoHSENw=;
 b=HjSUoftDFXyNGXExyayUWq/DqEkahwosZZkizwa1CKmqBMsZdDexPL3Fo+uYos9AlIgXOwZtdCRvdjm5wq0GXNXsF83JjhlqjO2SX4s2cN+wAztKf88hlxx7930mtb84FfMM3aUuoGC5UaJfUFEH4rl/lh9M7Io0tV3M/NoFCbLlmja3XlC4RDNsk/F+4TFDT25nJrWYmLrAKKnoMJUnOHV2DeR+hsiGo/vE1oext2/XkSqG3DmBaaSk+gL/51NEcWfyNsVjfpzN2LVtnslGhvnauSFn2BmMJ9RoBOWzA80/8bnMUnBZ+kukcEQqZmM6GYEJPVsi8M0ZJrxKvbAS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UK3AcGjkuBTMo+gLFEk8Dro7pk13qAcdxN0NoHSENw=;
 b=J5UacBURIz0O7PT1nN2I+PKwR706FRonPokTngEnaciu2W93Ih9YcxGUyg2vuMJvwYDZyupFUG9WD68g942uHmoeURTJ5ygUuKbiP3z7ikLu16eMBZlbH0wXTvFmGkY9QMhR40Qo7xrIUtMiXLNmC7yq0RQozJWA/N/roZrgNXU=
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 10:17:03 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::a0) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 10:17:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 10:17:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 05:17:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 05:17:01 -0500
Received: from [192.168.1.8] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 05:16:57 -0500
Message-ID: <100c5a35-e7e7-4bb0-9931-80cd078af7c6@amd.com>
Date: Thu, 22 Oct 2026 15:46:56 +0530
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
Subject: Re: [PATCH v3 3/9] KVM: x86/cpuid: Add a KVM-only leaf for IBS
 capabilities
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>, Yosry Ahmed
	<yosry@kernel.org>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-4-manali.shukla@amd.com>
 <20261008174424.717033-1-jmattson@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20261008174424.717033-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: e4212ca6-a65d-4c22-45db-08df30259dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	FZ6rb59lRugopdXkdE5GCDrn/NOLa82Kc3dnqF2k1NUHYYeugVQo5NZMptnFVvi2j6Q01qRUwdPQdWUrTZpx9HF9No5PefgrecEcPv2jwSzpIvp8HIXBPM8SscZl/eoMZRlID6qBPsQUGctpzIG+606TQaUzWCPeBiRNT4FJtNfj8gbD6/522YCUO96ZKngjvaqJpobjxzjRldh2ixrGDBmwSrhFS4OVDWWlq1y98LfawTFJhHGsLEGs1UAUMZHCOEpa/avICI2BqPs0HrXcUspZq0H8qAb1b6sZuN4BKXCe5/cx5Qvo/8LgrNX7iC2eTODwD8IaQ8Iv88axqy719kGTpSLIUwklM7Zs3nq2JuAszUEWwFB+ydXL09e29IBaX+5d/vQPvsAos9ea81ICwMdQHi8s2mBs1oJyH/n7kKqaQpFO+DWHni9DnHCBtU8JlvCg/Ky+IAN3SEntQ3d5rHIBC1RT2I8bMQ1s2RoHpmIkwELPzoQpp4sphsMBIEf5fVmWIMSlblgfdgqmuf6ZRh9YqLGOT4ylSDpiV2vJgJS9dVnW6IGKH2w/c5sQUAArbDohpv4fmfRYCuxj/6u7HB1ZLhIqzGZCEQO/gL5akCtRJoqSql+fyOa3Qe+0u+01BglXYDr/S3qZ+FhZVLsVnE6L4dGwsaPIZuhfIcivAd7V5O71Yokm9jg7fVOl+vhDiXO9FeiK9ua400trVEGtGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jokxjlMSxZvF22im/c3d867+9qvtvmSJ9T4g73yaMAXF8y+TdvYgbY2AJYknNUYFUmhFIV5qtebVMdGvjGYW7hgA6irNREKmLToJUKP0kuRCN+MGmGpCdSaUtavB6zOcIsCUurq7NuRqgc7cOb9gXxPQIhESaiOEuJEq2WZVM0MiUnu9TmEpszI1tDaP7VJMb1xIg0ppvc8uN6+KEw7eQKKXpGDLk/lwFeCdA4Akq4+vVJFbtty4a7OVhiBlb0vI27pjEcP0+BrCs/IuMDoDaDOa7RuSXtH/KC787SFtol4Fnn3xRHLpFUl6XPXE+/9Gw+++jciEuVA1NJNG4L0xF4etAyRK4WOCglk1TOiKjKgzoAioZw57N6/BLFJd0e/OBvIEpYbNAedDbC7YmBjAJbERX7p4I64pqoogPp6W+vCvZq3KYKN17A6XxM35t5ze
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:17:02.7745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4212ca6-a65d-4c22-45db-08df30259dc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

Hi Jim,

Thank you for reviewing this series.

On 10/8/2026 11:14 PM, Jim Mattson wrote:
> On Tue, Mar 10, 2026 at 06:00:15AM +0000, Manali Shukla wrote:
>> Add a KVM-only leaf for AMD's Instruction Based Sampling capabilities.
>> Multiple IBS related capabilities are added to KVM-only leaf, so that KVM
>> can set these capabilities for the guest, when IBS feature bit is
>> enabled on the guest.
>>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |  1 +
>>  arch/x86/kvm/reverse_cpuid.h    | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 32dd2d55e6f0..01abdf7f112b 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -782,6 +782,7 @@ enum kvm_only_cpuid_leafs {
>>  	CPUID_12_EAX	 = NCAPINTS,
>>  	CPUID_7_1_EDX,
>>  	CPUID_8000_0007_EDX,
>> +	CPUID_8000_001B_EAX,
>>  	CPUID_8000_0022_EAX,
>>  	CPUID_7_2_EDX,
>>  	CPUID_24_0_EBX,
> 
> The other KVM-only leaves are in the order in which they were added, and
> reverse_cpuid[] uses the same order. This patch puts the new leaf in the
> middle of the enum, but near the end of reverse_cpuid[].  Please add it at
> the end of the enum, after the last existing leaf, and in the same place in
> reverse_cpuid[].

Sure. I will move CPUID_8000_001B_EAX in V4.

> 
>> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
>> index 657f5f743ed9..22cfdb331e9e 100644
>> --- a/arch/x86/kvm/reverse_cpuid.h
>> +++ b/arch/x86/kvm/reverse_cpuid.h
>> @@ -76,6 +76,21 @@
>>  #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
>>  #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
>>
>> +/* AMD defined Instruction-base Sampling capabilities. CPUID level 0x8000001B (EAX). */
> 
> Nit: "Instruction-base" should be "Instruction-Based."

Ack.

> 
>> +#define X86_FEATURE_IBS_AVAIL			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 0)
>> +#define X86_FEATURE_IBS_FETCHSAM		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 1)
>> +#define X86_FEATURE_IBS_OPSAM			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 2)
>> +#define X86_FEATURE_IBS_RDWROPCNT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 3)
>> +#define X86_FEATURE_IBS_OPCNT			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 4)
>> +#define X86_FEATURE_IBS_BRNTRGT			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 5)
>> +#define X86_FEATURE_IBS_OPCNTEXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 6)
>> +#define X86_FEATURE_IBS_RIPINVALIDCHK		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 7)
>> +#define X86_FEATURE_IBS_OPBRNFUSE		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 8)
>> +#define X86_FEATURE_IBS_FETCHCTLEXTD		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 9)
>> +#define X86_FEATURE_IBS_ZEN4_EXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 11)
>> +#define X86_FEATURE_IBS_LOADLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 12)
>> +#define X86_FEATURE_IBS_ZEN4_DTLBSTAT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 19)
> 
> Bit 10 (IBS_CAPS_OPDATA4 in asm/perf_event.h) is not defined here or later
> in the series. Is that an oversight?
> 

No, it was left out on purpose. CPUID Fn8000_001B_EAX[10] (IbsOpData4)
is not set on any platform that supports IBS virtualization, so there
is nothing for KVM to advertise that to the guest.

> Three of these names are different from the IBS_CAPS_* names for the same
> bits in asm/perf_event.h: ZEN4_EXT (IBS_CAPS_ZEN4), LOADLATFIL
> (IBS_CAPS_OPLDLAT), and ZEN4_DTLBSTAT (IBS_CAPS_OPDTLBPGSIZE). Please
> standardize on the existing names.
> 

Agreed. I will rename them to existing name in V4.

>> +
>>  struct cpuid_reg {
>>  	u32 function;
>>  	u32 index;
>> @@ -105,6 +120,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>>  	[CPUID_8000_0022_EAX] = {0x80000022, 0, CPUID_EAX},
>>  	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
>>  	[CPUID_24_0_EBX]      = {      0x24, 0, CPUID_EBX},
>> +	[CPUID_8000_001B_EAX] = {0x8000001b, 0, CPUID_EAX},
>>  	[CPUID_8000_0021_ECX] = {0x80000021, 0, CPUID_ECX},
>>  	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
>>  	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},

-Manali
