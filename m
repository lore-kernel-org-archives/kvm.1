Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334D392828
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264555; cv=fail; b=k5XNBgSQmzZ9ZyMoGAz7bC+juFIrW4k/LezTnx4lxTU4SI7WmsglODK3FW6p/MoAXa05iocsbNtYKT3B3P/vZY4XuaFdpPJn/W2r3ucaOBjm0n5OXKtVFhgs3rj/a70eayVmAbC3AmXt40KWNquyGsOqx65GAvRP+O9Kg+f6Zy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264555; c=relaxed/simple;
	bh=bp1CzVDGvhqYpxQtoC9aiAwTeg7uRsHi+SeGBNF9h2o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=pHuQb2LtaSBbmwmn0LaBY/Q0k2wg8XnZGXY27z9wupp3OSNI4F6VwzdcKzh+Xa1ubKI86bEbUOSYJfgTJnwiMFNrnG4MdJbPPSVCw++Ja8o1nfLOY/pidiXNOLEr2L44PNmuencbOjfzhcIcSqCTJum8SDiiFbpOE2Esj66IGd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJM4J8Ok; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJM4J8Ok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8kWZE875Gbr/7PhTO4PdRG281cp0KwsPGaQc5R4JrIi0jtDHJE6sE+sSuSOtEWzyTWMD/jrhJqdMwqk/8emYzWDbponPfauBGbfmXm/kUUBtepyONvbIaGfEfeNtUERkUl9riElm7g08DGAHNdt/Ljf1PbKDhRN7kHjrEUUjIrmGBqg0xIq4wtfu1qFXmmbvIyzor/st+mr9Va7mgQqGbQkbTBsL1ZG//hEmSQlBVRgirXgbFe2m0HKXsQlaB4qBM6s6m2ibOHvzFHBatJl38+inUIyxtjT9ZIPY9t1isrtxTSzMtxbzXDjHDkT0AFTv+ka3yDVw1pt4wddIfimeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjbE2jZTXKyS6XORDdX/DRZywkAB6Ch8bQYEACinfns=;
 b=wMJLPr+eXwAZzlUlPG3pskPydxaQd+3TrcrGNlxY6aQrmMsd5vo91G6KTg/ZC9sMIABhEMV+aOG1Ok7+kLe30rZmJuR7Dz0Bm8UtLswd9D70SDaU0YE2mgbOizrtoczxogJDxgHHuNHXwmfDQxFIdmclgoWhsX8LRP+RTK5GxKQsWA8Owx/BNrcPOH1SYhSuu+pt4yX1PxScxMfsDOKGvr4X7uCHLshYjQgCnum9BlFbCtZeOMQaSvHDa/unciDmtxbz9hqLi/pnRqarVcFO4bSK9ZkYjB0hNw44g6Kqyj7JkFZp8SibznbdPtt4cSe9/ibFXaaV7849oAshYhpn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjbE2jZTXKyS6XORDdX/DRZywkAB6Ch8bQYEACinfns=;
 b=MJM4J8OkXWPSQLINyx4C0bSVYbbj4la+f+uQOCUwDZsy9GmHb7631gWgCOjSQsy3B6b9pzEHBlBQlQqhh96y1v3cBv7SOujGTWWQmfz91V9l/QHF1Kj1pBx6OyhiodxOyfH1dSVHAlV+Fo8j42wEy364hyT+f8W5cGbeWfcFNjU=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:15:48 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::6f) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 11:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:15:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:15:47 -0500
Received: from [10.252.198.192] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 06:15:44 -0500
Message-ID: <f9784824-0c12-4c85-887f-b079285d4a6a@amd.com>
Date: Mon, 23 Mar 2026 16:45:43 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Manali Shukla <manali.shukla@amd.com>
Subject: Re: [PATCH v1 6/9] KVM: Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 for
 extended APIC
To: "Nikunj A. Dadhania" <nikunj@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <santosh.shukla@amd.com>,
	<nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-7-manali.shukla@amd.com>
 <4f0d5601-9580-4a11-9ca8-7f242d3f0c6c@amd.com>
Content-Language: en-US
In-Reply-To: <4f0d5601-9580-4a11-9ca8-7f242d3f0c6c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: daa7fa69-ce39-4a1e-3189-08de88cd88d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S4KPE5+rXfiPrmZGoi+utsrLYy5VdPySOI+ttfMG8uRGoAQd89vfgj2WhJu+Ava2GuaqBJkY6LVVHvysS/pZizEiUB0uM0/SRwZp5XtK1pyk1JAwXRkPAjPE3FKWKHTCnTMPAHj3699h5fjioWyFgPFE+rpCCw3mawC4UuJcDxZNaBcgStkY4G0fiQJzKjJwwRVjgDS8kUoMfCC/UrIF7RLh/K93b9/gfmAct8m3bE3FFhvxIPAEpH1FD/94Gz4O5PuUKXkGTFvLZg6xVNzeoALIQskdFH8iH6NmeWTR3vDbQTXYUmCPaQvpldeLfKtRsV2Z6XAAMy+atULRi3LzoMjCcWnKQSuy5Z6fWuTUmTCf5+7+qaRd7Gda2rQpM4o6eiTJN5eDtFm58RfZvi0T+d6eXr4ZwBeBYlr5EJLnWl3bNDtRE6IESF/cL/WeiQNwOS5m1Ty4MdEuHSswbMwezZaR2FdlSOaywBKcfioHVcjLG85qULUi8HviZh+G4+pGBtJNuiypAt4n52fDMLmFPc+gjlFP99r5+X4lUrQ9DiT86oLFjE5akE08u7L1sdFSBYo3vARP3UBIELpEg8dVZ5lpjm2nsTS0S1uCmKR/E4gh50Yg89ZSD5e3sf5V560dV6AeQ4tDwhbmx6MJa0wxfsgKRi3HftZ4TKDonZsHmBQssDQvJDoYF3Z+nVcSLfRWvsjCeA9SeiMyyjGDVefo3A47YrY9QkieZKxkWeXixDukwU0J2yUaEKWVRozoCT1sPeJVY9VAr5hovKeR3Zmk9Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j+dob+1iu+rpqkU7c3oPSBON0Bv3xVbjyxMUWyWgoVbbfm/kAwM5nBJwS4WhrNAxy5T8TanymhdvANVY4Jeii5rV+oVywdH5jO4DXe1lwKrAM2tBtIeXwpr0fxtdydmKjfyk19ZLCes8KfP45iFPujxyZ3OhlVU3kAZ7HSU5fGEfH8A4cYfYk/IAsEj0j9NfgWIOZFFSC4HawPRNeGD9EhDUXNPs2kkimDIX0djc1sBp6tAIpQzrurRofCIXJZqNZ4SXC4EC0vd2VkA0NsnaR6SOfSCb1GrUmwps/ZGu5AJvXhkxxXGE5pwh5LZW4MVvkeaAdxXOunrAgjxEkam9rBXwF9n/6gsgPRM9tKslgcVWVYI3E1K/Xku3dDDLIKgCMUqJte9VxhE9/esiP3mb1CMFqsFeVseQXcLzZ6xm80Gh1R85/QoRtt0gWgSi9JMN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:15:47.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daa7fa69-ce39-4a1e-3189-08de88cd88d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

On 3/16/2026 6:30 PM, Nikunj A. Dadhania wrote:
> 
> 
> On 2/4/2026 1:14 PM, Manali Shukla wrote:
>> Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 ioctls to save and restore APIC
>> state using a 4KB buffer (kvm_lapic_state2).  The larger buffer allows
>> saving additional APIC registers beyond the standard APIC registers
>> supported by the existing 1KB KVM_GET/SET_LAPIC ioctls.
>>
>> The 4KB buffer size matches the LAPIC2 capability, which enables the
>> full APIC register page including extended APIC registers for AMD
>> processors.
>>
>> KVM_GET/SET_LAPIC continue to work as before for backward compatibility.
>> Document the new ioctls in Documentation/virt/kvm/api.rst.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  Documentation/virt/kvm/api.rst  | 45 +++++++++++++++++++++++++
>>  arch/x86/include/uapi/asm/kvm.h |  5 +++
>>  arch/x86/kvm/x86.c              | 59 +++++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h        |  2 ++
>>  4 files changed, 111 insertions(+)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 71b4d24f009a..c49cf3104b2c 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6517,6 +6517,51 @@ the capability to be present.
>>  
>>  `flags` must currently be zero.
>>  
>> +4.144 KVM_GET_LAPIC2
>> +----------------------
>> +
>> +:Capability: KVM_CAP_LAPIC2
>> +:Architectures: x86
>> +:Type: vcpu ioctl
>> +:Parameters: struct kvm_lapic_state2 (out)
>> +:Returns: 0 on success, negative on failure
>> +
>> +Reads the extended Local APIC registers, including both the standard APIC
>> +register space (offsets 0h-3FFh) and the extended APIC register space (offsets
>> +400h-500h and beyond).
>> +
>> +This ioctl is similar to KVM_GET_LAPIC but operates on a 4KB APIC
>> +register space that includes extended LVT registers available on AMD processors
>> +with the ExtApicSpace feature.
>> +
>> +::
>> +
>> +  #define KVM_APIC_EXT_REG_SIZE 0x1000
>> +  struct kvm_lapic_state2 {
>> +      char regs[KVM_APIC_EXT_REG_SIZE];
>> +  };
>> +
>> +4.145 KVM_SET_LAPIC2
>> +----------------------
>> +
>> +:Capability: KVM_CAP_LAPIC2
>> +:Architectures: x86
>> +:Type: vcpu ioctl
>> +:Parameters: struct kvm_lapic_state2 (in)
>> +:Returns: 0 on success, negative on failure
>> +
>> +Sets the extended Local APIC registers, including both the standard APIC
>> +register space and the extended APIC register space.
>> +
>> +This ioctl is similar to KVM_SET_LAPIC but operates on a 4KB APIC register space
>> +that includes extended LVT registers for AMD processors.
>> +
>> +::
>> +
>> +  #define KVM_APIC_EXT_REG_SIZE 0x1000
>> +  struct kvm_lapic_stat2 {
>> +      char regs[KVM_APIC_EXT_REG_SIZE];
>> +  };
>>  
>>  .. _kvm_run:
>>  
>> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
>> index 7ceff6583652..516d4a0be25a 100644
>> --- a/arch/x86/include/uapi/asm/kvm.h
>> +++ b/arch/x86/include/uapi/asm/kvm.h
>> @@ -129,6 +129,11 @@ struct kvm_lapic_state {
>>  	char regs[KVM_APIC_REG_SIZE];
>>  };
>>  
>> +#define KVM_APIC_EXT_REG_SIZE 0x1000
>> +struct kvm_lapic_state2 {
>> +	char regs[KVM_APIC_EXT_REG_SIZE];
>> +};
>> +
>>  struct kvm_segment {
>>  	__u64 base;
>>  	__u32 limit;
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 669c894f1061..ccd16bdff56a 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -5331,6 +5331,17 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
>>  	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
>>  }
>>  
>> +static int kvm_vcpu_ioctl_get_lapic2(struct kvm_vcpu *vcpu,
>> +				    struct kvm_lapic_state2 *s)
>> +{
>> +	if (vcpu->arch.apic->guest_apic_protected)
>> +		return -EINVAL;
>> +
>> +	kvm_x86_call(sync_pir_to_irr)(vcpu);
>> +
>> +	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
>> +}
> 
> Should this function verify that KVM_CAP_LAPIC2 was enabled for the VM?
> The KVM_CAP_LAPIC2 documentation states "This must be called before
> creating any VCPUs" which implies userspace must explicitly enable the
> capability. However, this ioctl doesn't check kvm->arch.nr_extlvt or any
> flag indicating the capability was enabled.
> 
> Looking at how this interacts with kvm_apic_get_state() in
> arch/x86/kvm/lapic.c:
> 
>     int kvm_apic_get_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size)
>     {
>         memcpy(regs, vcpu->arch.apic->regs, size);
>         ...
>     }
> 
> The function copies 'size' bytes from vcpu->arch.apic->regs. Since
> sizeof(struct kvm_lapic_state2) is 4096 bytes and apic->regs is allocated
> as a single page (also 4096 bytes), this works. But if the extended APIC
> capability wasn't enabled via KVM_ENABLE_CAP, should userspace be allowed
> to read the extended register space?
> 

Yeah. Correct. If the capability is not enabled, userspace should not be
allowed to read/write the extended register space. It makes sense to put
a check here. I will fix this in V2.

>> +
>>  static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
>>  				    struct kvm_lapic_state *s)
>>  {
>> @@ -5347,6 +5358,22 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
>>  	return 0;
>>  }
>>  
>> +static int kvm_vcpu_ioctl_set_lapic2(struct kvm_vcpu *vcpu,
>> +				    struct kvm_lapic_state2 *s)
>> +{
>> +	int r;
>> +
>> +	if (vcpu->arch.apic->guest_apic_protected)
>> +		return -EINVAL;
>> +
>> +	r = kvm_apic_set_state(vcpu, s->regs, sizeof(*s));
>> +	if (r)
>> +		return r;
>> +	update_cr8_intercept(vcpu);
>> +
>> +	return 0;
>> +}
>> +
> 
> Ditto, shouldn't it verify the capability was enabled before allowing writes
> to the extended APIC space?
> 

Agreed. Will add a check here too.



>>  
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index cb27eeb09bdb..f45d313e30ae 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1339,6 +1339,8 @@ struct kvm_vfio_spapr_tce {
>>  #define KVM_SET_FPU               _IOW(KVMIO,  0x8d, struct kvm_fpu)
>>  #define KVM_GET_LAPIC             _IOR(KVMIO,  0x8e, struct kvm_lapic_state)
>>  #define KVM_SET_LAPIC             _IOW(KVMIO,  0x8f, struct kvm_lapic_state)
>> +#define KVM_GET_LAPIC2            _IOR(KVMIO,  0x8e, struct kvm_lapic_state2)
>> +#define KVM_SET_LAPIC2            _IOW(KVMIO,  0x8f, struct kvm_lapic_state2)
> 
> KVM_GET_LAPIC2 and KVM_SET_LAPIC2 reuse command numbers 0x8e and 0x8f.
> While the _IOR/_IOW macros encode the structure size into the ioctl
> number, this still seems unconventional compared to other KVM ioctls
> that use unique command numbers: for e.g. SET_CPUID / SET_CPUID2
> 
> #define KVM_SET_CPUID             _IOW(KVMIO,  0x8a, struct kvm_cpuid)
> #define KVM_SET_CPUID2            _IOW(KVMIO,  0x90, struct kvm_cpuid2)
> 
> It would be clearer to use unique command numbers like 0x92 and 0x93.
> 

This was discussed during the PUCK call and in [1]. The _IOR/_IOW macros
encode the struct size into the ioctl number, and since kvm_lapic_state
and kvm_lapic_state2 have different sizes, the final ioctl numbers will
differ.

In case of the KVM_SET_CPUID / KVM_SET_CPUID2, both the structures
(kvm_cpuid2 and kvm_cpuid) use a flex array, so are of same size, I
think that is why it required the different IOCTL number.

[1] https://lore.kernel.org/kvm/aWgRvCdPsAFHRwcU@google.com/

>>  #define KVM_SET_CPUID2            _IOW(KVMIO,  0x90, struct kvm_cpuid2)
>>  #define KVM_GET_CPUID2            _IOWR(KVMIO, 0x91, struct kvm_cpuid2)
>>  /* Available with KVM_CAP_VAPIC */
> 
> Regards,
> Nikunj

