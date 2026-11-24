Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795501502;
	b=gfH689887RS3EGfueXaw0+B8Y59amm9hNiAxzuReqjTu27EXqRUTzWwSjPPTpeQkvEo+
	 kGInhL4MkAOqa306EFFnPKeP1yDQOgOmFYH3vOiY6ZlR54CJ6xNT7cjVM+jAtoZxCm/Vv
	 WHdpRwHcFGmabBFSgvwQLA8s1Wxlu1pDGVR3KWuG5fr7T7rvDYBbIB5YQjwhVX1m+bQo0
	 AXe4LLUz37fkdTmil2Bk45ZQM/ogEyeEKVHZ7PcwDiFazeeVsUxbX4dqBoz2AtN1ylwqP
	 XTlUp1soqo/dGkpDUbbP+Ad7jtrfyYWOGw4u/mI0dD6is1AwTQLdAzu/Aibb9QZGAAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501502;
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
	bh=IoT0vIe2G3ihI/TsJQTNFkIU8eacPW9xi02yoe6lakE=;
	b=gW+bEgH06CctvEp0fjHDExqhlzgZAMhY8eZH67HqpROGaXoTvsDVlGp5HTvMvAIIISyO
	 70hppgLdpJNV6CBlPy1fFYeAwfY4Q/d8wxE++vXboXhKtr2Qn8Lk543/PWgyA6qEX3wkq
	 0kuwZSgFaWCPLQzm/IKtIc6tV70n9jPCHmCUSgrhKXL9CR0TsXIDUfSYkY8sKEuYhmhif
	 LKw29Gqw3KnP0KimwT497U5rSeeJkmZmcd8y+u6PUeEDCP09naLsVTaTVLDDZ4vdXDWJp
	 oZmcUZJfq+mV7AwpXBz0XaC9LRThQOYX9pYWujue/Py8/e42ARfAMd6de0N27drIyjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zU51z5Fu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.57
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692B606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 06:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6692B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zU51z5Fu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG53Qadw3apMWjjGbPPe1LJpQeBBKzS4zhoU1dsyxWZdywhF8R3xDuWDeH8/ztlBf1LfbUpwrs+G95QXT2Mbw9/b+WzItk04elRV5113cp3SO390WZ2/V/ZpDMdLm1U9kQZiPfEMOtgQlamtIL8uy2axxnAv6yV0Zi+CE2fltYEKwqsxPQR6kQRUhDbuDE4tC2HrnnIOLsyACricKskMkqPqlJuLVXocuzp8+jAMaq/wF1PDZyif8kX304d0ohMasylBYBcsPobHY2s9LacNcIf6HAJ0iEodty1kYpBnotadoplKGijV17OavpExX+vdqxdrGiEMNR3GqZvwuqKq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoT0vIe2G3ihI/TsJQTNFkIU8eacPW9xi02yoe6lakE=;
 b=VAfqOGrjD7QzTKfWOEdURVnioHteFC6hvgZqJy6LE66+Je129nFLhfLsv36rqOV9It5JfiemMJQpKg/rXY2ui9V1lAhurydvvtSAyBdfAcop316T9VwiiqJuQl3rMYZWxzpDEn5IHf/ivGzrhJobDdhV26aDDonER9V1wSKpWbvFAPFxQlErRuvFDNbxufQ1zGUSBt/uRMtnWtuFDqzXs09nHoMWpQar/BpuHFt7i/N/rBi8TgZvJI8a5shCWoZgdcLglSRlEndhqpc0+EiKwJsblkxbKkzvpFa7yeJT2Fh3nXcOTtCHUC761TkMDstAzc9RNoikOyMJV0Xm9emOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoT0vIe2G3ihI/TsJQTNFkIU8eacPW9xi02yoe6lakE=;
 b=zU51z5FuPrfXRQlpZnPU3LKexx70i1YsTx65yjZoD+G3NnlhRi27Y/aHxSnDg3gEpR68rZ4B/5nuid4i24NcooQRCHWoVXFk63fUdL2SGRcgg+FsDANNhhrQjLMq8m+HljNGOUNf0OMWd8TkzJBWtNYi4OWV1PjrWRD7e3AD7I0=
Received: from CH0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:610:cc::30)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 06:22:51 +0000
Received: from BN3PEPF00022BC3.namprd05.prod.outlook.com
 (2603:10b6:610:cc:cafe::24) by CH0PR03CA0085.outlook.office365.com
 (2603:10b6:610:cc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 06:22:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC3.mail.protection.outlook.com (10.167.248.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 06:22:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 00:22:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 00:22:49 -0600
Received: from [10.136.18.146] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 24 Nov 2026 00:22:45 -0600
Message-ID: <9c863ed8-a28d-44f8-8ba6-8812d3977f70@amd.com>
Date: Tue, 24 Nov 2026 11:52:44 +0530
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
Subject: Re: [PATCH v2 04/12] KVM: SVM: Enable hardware-assisted LBRv2
 virtualization
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-5-shivansh.dhiman@amd.com>
 <CALMp9eS+vfR=Gk5QhLFrCZ4MyCq1YrunViB=tB5OLo+L8Ka+OA@mail.gmail.com>
 <e09b97b3-7439-4b33-8c2b-033ba131a0a8@amd.com>
 <CALMp9eQSicA=nOaxOrU37Z1ROPYFhwKgBMX-Pav=qqvb+WUDew@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eQSicA=nOaxOrU37Z1ROPYFhwKgBMX-Pav=qqvb+WUDew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC3:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 89432df8-49c7-48ac-38e4-08df49f35d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|6133799003|261009223027099003|22082099003|18002099003|4143699003|56012099006|11063799006|5023799004|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a4Z6Cg0N5yuU8IMLY+MX2HvpNb+OomKW1hHruZZfplmXcbsfMB1MAvlAV2BEfV4oU3EQarU6qeEYMNJpGEp0tL9r9uIjWBG/zrTRT/DLidhviBtyCzP0KwZHlbBRft3n37/RftXGPfMEhluOM+lY7lkQMt0d9uy3wQ0OnVHoGS2nIs7Y0cCX/PmAA/YCVpTKNFqdLfcKSzgHZ21PbG+oFsb0ELLpRdDvsCDyItLWPcH5fKlTwVzjDMcFisi5h+AoDzQZUkrfbxnS4P8eh/3nrXJpBbZasNTQxTg55zsrs06lzwX2w+BJhn5mQ+bGJeCNpm+NhCJTZJ41RU+5utniR2aEoDzd+lpfUSnC72+3Mwh7EsAJiuIafSWFBXoDOzI9n0TIkHkp/FuCNiCFOarciys+GkwR1sXWZKkMKHvdBWvzWvioxdwQizUZ9JZuYnTG47wAD+iVgU+RlxUqjcGU/A+AaXn5varlXkSGqkkF04FiwoWNhFlL0GPgt50CtOF/EgqYZmrlYe15RzwljT/EGu9DaLUo+m+LFyVYbdr5rx/gnCxzDtbyWoBCu3HkTTflwTCw2fpKYHscTL5cNZechhn3frqNa4X46DaL8B2pXacHHM6rM+W27JmfwiFXVsUKUC1JQ+daoPqzrIOQ02AAaRrq6cKlobu/GZ8X08gyKuTWmKtOYbU+L89khGeOYfbZdN9P4wXxc6TcAs2NnwAWqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(5023799004)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MCkhAOTr7YfureappdQ0jsQzMZN1ST0G9MpNB4RnjqzApAmHTVX2/eUqKugFPbeqCKFktvEB+/UvBSN8ForiIhEpGbcVOGVdxTAGnB2mmDF1mpAsI9aZsYwkxKnCZdsfqVktuupDAAchZ4u6EsWNJPlfjJCw4hqE/xvRcJTIRk5YhFnWu2CFpAXEQc4uNpjZVTjEno1N+VNG7o9uUrhpRYuGgFHDUedrG7jEihhqgl5DrES+B6zosocNlBdQGXvmSa5Dtqzulx5eG6sfVJ5WpIJrmQnbinAC5rgI+GEWJgFTjSmB864nl3byp9pA7w0a9vLuCT/SiWXsqoAlLCo5iL4d502228ku0fs9DCbbkwrmRmUVmN4JHO8zCrvf5ATl0QCWPPBIPr72N+gsMu5AGl+fiCC7eDOtriJHbtfoeygYv+4Zi7PwD9K9fqtl6IUv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:22:50.3387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89432df8-49c7-48ac-38e4-08df49f35d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884



On 20-11-26 03:26, Jim Mattson wrote:
> On Sun, Nov 15, 2026 at 12:33 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>> On 22-10-26 05:04, Jim Mattson wrote:
>>> On Mon, Oct 19, 2026 at 2:07 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>>>
>>>> Enable V_LBR so hardware saves and restores the guest's LBRv2 state in
>>>> the VMCB, and pass the LBRv2 MSRs through (by disabling interception)
>>>> to the guest while it is set. V_LBR is enabled lazily, only once the
>>>> guest turns on branch recording, just like legacy LBR keys off DEBUGCTL.
>>>
>>> For a Linux guest, I think lazy V_LBR toggling is a bad idea for guest
>>> context-switch when LBR is in use:
>>>
>>> Context-switch calls perf_pmu_disable() -> amd_pmu_lbr_reset() ->
>>> perf_pmu_enable().
>>>
>>> The PMU disable clears LBRV2EN, so V_LBR is cleared. As a result, KVM
>>> intercepts all of the LBR MSRs written in amd_pmu_lbr_reset(): 32
>>> stack writes plus LBR_SELECT.
>>
>> Thanks for this. You are right, and I've been spending time experimenting
>> with it.
>>
>> I profiled the guest context switch and counted the intercepted MSRs on
>> the host. With lazy V_LBR, each switch into an LBR user causes a VM-Exit
>> for all 32 stack writes and for LBR_SELECT. The reset then becomes the
>> largest part of the guest context switch.
>>
>> When I kept V_LBR on, these VM-Exits disappeared, and the reset took
>> about the same time as on bare metal. The same workloads ran several
>> times faster. For a guest that has LbrExtV2 but does not use it, V_LBR
>> on adds a fixed cost to each VM-Exit, because the CPU saves and loads
>> the LBR stack.
>>
>> I can see two ways forward:
>>
>>   A) Turn V_LBR on at KVM_SET_CPUID whenever LbrExtV2 is exposed, and
>>      keep it on. This is the simplest. But a guest that never uses
>>      LBRv2 pays the cost on each VM-Exit.
>>
>>   B) Turn V_LBR on when the guest first sets LBRV2EN, and keep it on
>>      until vCPU RESET. A guest that never uses LBRv2 pays nothing, and
>>      a guest that uses LBRv2 has no VM-Exits in the reset.
>>
>> Personally, I think that B is better because I do not wish to increase
>> the current overhead of a VM-Exit. Which one do you think is better?
>> Or do you see a better option?
> 
> I agree that B is better, since VMMs will routinely expose LbrExtV2 to
> guests that never use it.

Thanks, I will implement B.

> 
> Note that KVM doesn't have a post-creation vCPU RESET path;
> kvm_vcpu_reset(vcpu, false) only runs during vCPU creation.

I see. Then, with B, V_LBR stays on for the life of the vCPU after the
guest first sets LBRV2EN, also across a guest reboot. I think that V_LBR
must turn off after a reboot.

1) A SHUTDOWN, for example with reboot=triple, makes KVM INIT the vCPU,
and that INIT can turn V_LBR off. But a guest must not need a triple
fault for this.

2) Another option is to turn V_LBR off when userspace writes DBG_EXTN_CFG
with LBRV2EN clear. On a guest reboot, the VMM writes the reset values
of the LBRv2 MSRs (QEMU does this with KVM_SET_MSRS), so this also
covers a normal reboot.

Is this acceptable? If not, I will just implement (B) and document the
behavior in the commit message.

> 
>> I also have two questions about this:
>>
>> 1. Legacy LBR. V_LBR also covers DEBUGCTL and the legacy LBR MSRs, and
>>    KVM toggles V_LBR lazily on DEBUGCTL.LBR. Must legacy LBR keep the
>>    lazy rule, or must it use the same rule as LBRv2?
> 
> Legacy LBR can keep the lazy rule. The four legacy LBR MSRs are
> read-only, so there is no 32-MSR reset loop on context switch, and
> keeping legacy LBR lazy avoids paying the 256-byte LBRv2 save/restore
> cost forever if a guest only briefly enables DEBUGCTL.LBR or
> DEBUGCTL.BUS_LOCK_DETECT.

Makes sense. I'll keep that unchanged.

> 
>> 2. DBG_EXTN_CFG. For non-SEV-ES guests, KVM intercepts it only to see
>>    LBRV2EN. With option A or B, KVM does not need to see it after
>>    V_LBR is on. With the reset fixed, the DBG_EXTN_CFG and DEBUGCTL
>>    VM-Exits are most of the remaining cost of the guest PMU disable and
>>    enable. Is it acceptable to pass DBG_EXTN_CFG through while V_LBR is
>>    on, as KVM already does for SEV-ES guests?
> 
> No. If future hardware defines new bits in DebugExtnCtl that KVM doesn't
> virtualize or advertise to the guest, passing the MSR through would let the
> guest enable an unvirtualized hardware feature and would break live
> migration when svm_set_msr() rejects those bits via
> DBG_EXTN_CFG_RESERVED_BITS.  That's the same reason KVM keeps
> MSR_IA32_DEBUGCTLMSR intercepted for non-SEV-ES guests.

Thanks. That also makes sense. I'll keep that MSR intercepted.

