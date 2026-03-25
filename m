Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622C359705
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431163; cv=fail; b=HdbEXzy7cSzlVw81dhDXUbjhDfusx3JTQe/fZqjDdSjRKizokigDLrzhOAafzM1XzwS68MmbX4fHMf+x5pqb1ZkDErWcdRRF7ClQkon2if918PHWmpKIdB/1M/bwM7InU7L8bXdcR8AvRwib6j8tZnwRBmEk7JBjmNh7L3wew3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431163; c=relaxed/simple;
	bh=NbGLhVfQyM3i0FGkO6Wwnc5NzBqleuwwER13Z6qJ8So=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qTqzw6aI7OHvxz99m+kuR56hY7WWMVH8Qs4GmR6DPcRsZVX9QBIfzN3L1XwHNxFlEVDu5w+F5sOk+Fn6qjU/OaO1McELi9NAILEQAoYPjsRfAqdqod3+eieQMpqSeLs+2NqoJra6OM36o5BJsUbp3duGpyGn6dlloRmUxXU19CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l9JEQBds; arc=fail smtp.client-ip=52.101.57.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l9JEQBds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK0PucL9NAvlPWXjTxCEgYjfsFE7GgU9wwJ4iQFaXf89+5bBeK7XTwu0ob+bKidGRW347o7AnlyA40OQT3mFPtNpzXAve4sjmRLMW2rN4rvwAijrIFM5zwM/vw83MCLsOyXmEs4tIPQUvJkNPtWI3meVjet5ntFPA/u0+fhSbGIzcHBIf3LTBapXEik40VdWz8P0qm0GuEI0eRfmb0/6XzG2cmiqRy4y3zpuGDqLs482WQUJ/nue+BqnWnke9GepWgqd86VnKnK2oRApNBcVveL8J2tKqLdlssc8uigIujPCAOZzfnKcHOkqZ0likwDF7mzMLLCCXfUvzaz/kUPJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w1iq+6hL9FW2W7+92oivACde+nNgNqZIR2nxZKjdnY=;
 b=hquWwyzqVXSOPAL9IOrl6HrA9u15cOWW6kY3LsNcVByNh5XC3a85UJF04ezrK8e75mzMJzI0Qpa5ogxYf0IKUpW5r2T7a+8OlJzYZ3NtPxnlUTGXTf7TAvbnwgIKjdAmSVAboB5RinC74267J2LBHtpUg/lmHDzhfcHar4tts6lCJHjAd7x6sDKn3UjaQiCntHWntrXJWLP3I6gU6uk2cn3kuEiEjZoSIzIpgfVtFEjD5WgxIypN9ui7IP2IEvanmUZrn3+lWS50gJNmmkB1v8GS2ANjq/iMlO6Jt86mdi30AIUDg5VX2kMtm40F+uigZMv1WyChJnsviSK84ZGswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w1iq+6hL9FW2W7+92oivACde+nNgNqZIR2nxZKjdnY=;
 b=l9JEQBdsUxDGD716+6IwdjUIvOt0iNxBc5ErhQCrYycjlnqwjvKKlv/Yd5q0mlNiXmIQOkBXDD6B2Ek6N4p5OcszFeLpETBlRz69KZTQpi88E9bnfdelJDzfcEFjAMtIbo2mW9acj7QT9Mk0bt49E6KtqxG6lfDGlAVscjkgpDo=
Received: from BY3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:254::15)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:32:36 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::c) by BY3PR05CA0010.outlook.office365.com
 (2603:10b6:a03:254::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 09:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 09:32:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 04:32:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:32:34 -0700
Received: from [10.252.198.192] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 04:32:31 -0500
Message-ID: <b3f3058d-c0eb-46e0-a443-5ff0f756df6b@amd.com>
Date: Wed, 25 Mar 2026 15:02:30 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] x86/split_lock: Provide KVM helper to log guest
 bus lock exits
To: Borislav Petkov <bp@alien8.de>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <ravi.bangoria@amd.com>, <peterz@infradead.org>,
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>
References: <20260324124002.7670-1-manali.shukla@amd.com>
 <20260324180449.GMacLSQUJepcHGCjTX@fat_crate.local>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20260324180449.GMacLSQUJepcHGCjTX@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: c19baf93-353a-4a01-3306-08de8a5172be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	35nfsW30kcZyUKz8ibh8E0nGONrD89p/9AMAUH/BJYk0etoNS1ZFYJfEyOmEK5domOgK3bhSwhbBxTyxxHB1Oesi+8UheE4j0vD2xU3wi4Lt1tfZhBle5Ft76IVR2h7P6oNJu8yzLTq7VxGR+JQhOR5vVvi4lF3+8L3Wbgn3HmZLzhUds5DugSTIKhZrOF6iYCBGYz7ytj+XUMNna3OYWImidozJzbBUyTghRYTj9DvU8gMkSDwdZmJhgnsMMH80FDOZkAcUASmNuLTnwOH2ucJzCg8dP6yE/jBLkZL+Rv3KL7ZX9LZ49ZsrV5uFqLPpwgeYXdwhMZk6Bd3O96BxIJuzN/J4Uy3fEMh7MogVJLqdg7AdNSJzQiqLYvY3YK19psGiD9xnELExkMBUEACkBUKZXc6Ud2GDYSWAqr3qMN0vL6HXeZcWKTXzeW2OOMuknYWuJrelNlMo9j9H1rRN/bDkbMEWVYmtTqIhwYCfql0lJx7JDGuEUW8PR12EWQg7T3hdT3moEfdyIj2PvlDruYInGwjbcuosa8CWNbIqI7Nn2YvNgau4PmvzqxrycMlwcva2nDUUDngkvlUGbwi+3KFSLjTJimzNYyXYrpvo2AuGU2U19fg1jTD5RFKmhsdm6Ry1P5ubdpjkW+36U400U4jpdgwlfhhr3rvU/KtnJy0VUcNYOsPeupjTCJ4G20Y+XTdH+K98/4728ScXnJMwLkc9MeEo2nJmXNpoZ9Aypcff0kh+SRMHm4K/MVt/IVlcXveY4fhuvuRvs+xPeQmeUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RtILIA0Td4YFMtJz9w4oNOgNJSq/JaQ9egTaVDbDz+ERcN4YLdi6a2QB5hEjzBwcYGZQNKSFqxgzy/is6/DTJDTPrs4PAxt61b6SXBPLZcV2R26yvvv9nGWv4J7QeuHFgbTRLQ41IZeB8IElwiJXaqNNXciAxcMh8JtW+LBcr3XAUG+VuA0wI7+MFVqqAVGsEhfAIWwXNs265zwv9jZRerifvZL3eGQyMjQH7XAzoWbMGDqiFCVRJ7i/qBKVULxlnm6V0hE7YfKVs/RXvgqg/12FflUk41O81Ba36c09K8jEn+pSmx8fhg5RQI1tzzAvjFSBBq8IIxU7LG+9+4LBhJB9FjXGSPbNfKii3DJhEaatkVZcS5rlwmeQU1BPCUivaNXeL/FmBfADAEm2F4RURfg3uYP7ExJH43voycznhzeOcWFa7Kuf16DwIQ7Qlh7w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:32:35.3840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19baf93-353a-4a01-3306-08de8a5172be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

On 3/24/2026 11:34 PM, Borislav Petkov wrote:
> On Tue, Mar 24, 2026 at 12:40:02PM +0000, Manali Shukla wrote:
>> Bus locks monopolize the memory bus for thousands of cycles, stalling
>> all CPUs and degrading system performance for every workload on the
>> system. Cloud providers running multiple VMs need a way to identify
>> which guest is responsible, so the offending VM can be flagged.
>>
>> Bus lock VMEXITs on AMD are fault-style, i.e. the vCPU's RIP points to
>> the offending instruction at the time of the exit. Log guest's linear
>> RIP and vCPU info to give operators the data needed to attribute the bus
>> lock to a specific VM and instruction. Keep policy enforcement to
>> userspace via KVM_EXIT_X86_BUS_LOCK and let userspace implement
>> throttling or other mitigations.
>>
>> Reuse current->reported_split_lock to limit the warning to the once per
> 
> s/ to the once/ to once/
> 
>> vCPU thread. Note that, current->reported_split_lock tracks the vCPU
>> thread, not the individual guest process, i.e. the warning fires once
>> per vCPU for the lifetime of thread regardless of how many distinct
> 
> "... for the lifetime of the thread... "
> 
>> guest processes trigger bus locks on that vCPU.
> 
> I guess that's fine since you're ratelimited.
> 
>>
>> ----
> 
> What's that "----" supposed to denote here?
> 
>> The intent is purely observational — give hypervisor owners
>> visibility into which guest is generating bus locks so they can act
>> accordingly. No policy enforcement is done in the kernel. Suggestions
>> on the approach are welcome.
> 
> Oh, sounds like you want this paragraph to be...
> 
>>
>> Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
> 
> <--- ... here, after the SOB block and above the diffstat.

Oh, my bad. will correct in v2.

> 
>>  arch/x86/include/asm/cpu.h     |  2 ++
>>  arch/x86/kernel/cpu/bus_lock.c | 19 +++++++++++++++++++
>>  arch/x86/kvm/svm/svm.c         |  1 +
>>  3 files changed, 22 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
>> index ad235dda1ded..4ac5011e10b2 100644
>> --- a/arch/x86/include/asm/cpu.h
>> +++ b/arch/x86/include/asm/cpu.h
>> @@ -29,6 +29,7 @@ unsigned int x86_stepping(unsigned int sig);
>>  extern void __init sld_setup(struct cpuinfo_x86 *c);
>>  extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
>>  extern bool handle_guest_split_lock(unsigned long ip);
>> +extern void handle_guest_bus_lock(unsigned long ip);
>>  extern void handle_bus_lock(struct pt_regs *regs);
>>  void split_lock_init(void);
>>  void bus_lock_init(void);
>> @@ -44,6 +45,7 @@ static inline bool handle_guest_split_lock(unsigned long ip)
>>  	return false;
>>  }
>>  
>> +static inline void handle_guest_bus_lock(unsigned long ip) {}
>>  static inline void handle_bus_lock(struct pt_regs *regs) {}
>>  static inline void split_lock_init(void) {}
>>  static inline void bus_lock_init(void) {}
>> diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
>> index fb166662bc0d..a6d231410535 100644
>> --- a/arch/x86/kernel/cpu/bus_lock.c
>> +++ b/arch/x86/kernel/cpu/bus_lock.c
>> @@ -292,6 +292,25 @@ bool handle_guest_split_lock(unsigned long ip)
>>  }
>>  EXPORT_SYMBOL_FOR_KVM(handle_guest_split_lock);
>>  
>> +void handle_guest_bus_lock(unsigned long ip)
> 
> Exported function better have a prefix:
> 
> bus_lock_guest_handle() or so.
> 
> But, the only reason this function is here is because you need sld_state.
> 
> So, instead of doing that, you can add a helper called
> 
> sld_enabled()
> 
> or so, which is exported and then you can put the guest-specific handling in
> svm.c in case you want to expand it in the future and there you use
> sld_enabled(), etc...
> 

Thank you for your suggestion, will fix the naming in v2.
sld_enabled() could be added in bus_lock.c and called from
bus_lock_exit() in svm.c. However, the other reason for keeping the
function in bus_lock.c is the current->reported_split_lock usage - it is
already used in split_lock_warn() and handle_guest_split_lock() in the
same file, so keeping all reported_split_lock accesses in bus_lock.c
seemed more maintainable. But happy to move it to svm.c, if you prefer
that approach.

>> +{
>> +	/*
>> +	 * Log bus lock exit when called from KVM exit handlers. Policy
>> +	 * enforcement is delegated to userspace via KVM_EXIT_X86_BUS_LOCK.
>> +	 * Let userspace implement throttling or other mitigations.
>> +	 *
>> +	 * Only log when split lock detection is active to respect system-wide
>> +	 * bus lock detection policy. Use the reported_split_lock flag to
>> +	 * prevent log spam from the same vCPU.
>> +	 */
>> +	if (sld_state != sld_off && !current->reported_split_lock) {
>> +		pr_warn_ratelimited("%s/%d buslock at rip: 0x%lx\n",
>> +				    current->comm, current->pid, ip);
>> +		current->reported_split_lock = 1;
>> +	}
>> +}
>> +EXPORT_SYMBOL_FOR_KVM(handle_guest_bus_lock);
> 
> Thx.
> 

-Manali
