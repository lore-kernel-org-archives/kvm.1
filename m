Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F63326927
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513670; cv=fail; b=IEMK3CEQ9y62ZCY2bFsMYujQEfzvifTGC8PQ9X29CI9jEL29hVPHni8z2+ZEkmlljB1hKPvvGQPLMFWRDtz+jeRsqGS0YoLJEPd6/iu+j4Vq/aY4oNzfft9RexTAxum+pvoyUiJ08kZmnisu3kBNJVYBUlCqjFoKbPYttUnEkDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513670; c=relaxed/simple;
	bh=30BRmc0ZOHnB4s3dM6Fgn3YftSILatD8YHH5HTr0G9g=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PdRD2hTfIYgg5M5hRBG2f1hnQa/Iej9eXFY+RO2YW9O2/OkKKogcn/JAYc70xZF/nWAOL299/+nh9pO4KBTZwsAT1SCxnRyllcIR0HoHSCBn9qfbyxEjZsVEyyPk29qxpY1+jKiS3EcL+JcxF3jDf6FtiFIzQvcEi0yqIQM+F3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lH0cpcnR; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lH0cpcnR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO24vb3aNwA9flq5uezQw2/rU/t/NsUqcTXwkMlYZZ1u9Ue+/Q/D1kZQ4Uk6MfWl3LBEPWGc8UO8efOgIEzrphxbfB4zPXtDdCeFkDXZWWViYSePd8BsL2TYJ9GtXfOtkr4qOAkcp951rG2VshOoZiE1xPz8ELpneatR2uj7bKpBf9feTw3K/2xf/WKyXczeJkM761OBdgSAnl7B5gHRKyh/L4X7GDMTQIUhz/4Fl11pnwoCgjkBsBVwqsDssuyU5WLXLnlcEqnVcpV0CIxq1OmlbSFLLJ0W0FnVNkEae5CZuqfWfNO++8+gc0MiIjNmQCi4+jWqcDMSAustBhpFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5hWH1o/RZFIdmQ/q00IcB7hWbi3fNcHVFatxXxXbek=;
 b=P+D5+gI8Ubgt4gKrMmoQIvD7pRAckEt3L8rjZOXYtEp/l6d7uGrVTWDvCPPa8PClSywEXLzzRn1Y/LATFKs7iBK2LZEyROAdu5bAc9usM3Lj3OHEQW7tKOr1Ts9K7MgRgzUysFTDUIWtnoZhGG/T5dJ/qH2grScbie8+7zRVX0Qkth/FF7eegYNNI0vcqwl3beoRkCE5k/zNyJW7NX9nwWs8iXd4EYLEOZo8L0CCRm71Q7M4eC2FCjgC9pwgdxo5UHXI55n/vibm7ldoHwWR6xfb6fPkzAfLbbsBJ98Ftax72PTN3hPJQn85pCkD6PIgNN08klxrHnVqnziRpTqsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5hWH1o/RZFIdmQ/q00IcB7hWbi3fNcHVFatxXxXbek=;
 b=lH0cpcnRcjVrwgoUJ9mo/YU/Hkt4jsuvuAQNmvLWS5d1t5oD1qXMTPbmIAJufVSq1WvrV6WHQiho4PTVF0RUz+aZUbs+286CjvWX8q5ch4pi02MW2I7aS1cyctrYyHDXOI6vOSQC0lCbAp7s/IvwyDUDO2pB2ePVtr/Zho2KF+I=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 05:47:43 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::7d) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 05:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 05:47:43 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 00:47:41 -0500
Message-ID: <5149127b-32ce-4409-a443-02b5a9600e14@amd.com>
Date: Wed, 12 Aug 2026 11:17:33 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <sashiko-reviews@lists.linux.dev>,
	<kvm@vger.kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org>
 <b50b3535-eaa1-4944-914d-0eea8dac0e06@amd.com> <anpwS3C2UIHFz_Uf@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <anpwS3C2UIHFz_Uf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: a90f92b7-6c8b-4364-8b01-08def8353ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lxRNKRctfQ1B7+9Of9DADzKU8Kgtret2l5+t+EXS03AyjYLgGfoScbOYiTDmLy6/5ucHygmG/tiomQ3KiYAsjbuEyHdQWn0wHbBJB4X2GfN89ZazOQIgR5/+iwwITgD5xUIWas7GPGQrKZlUyRM2/sITux8ZvsXJ58ELm2IV4oR56q8JW7CSM4MZV9h4nRavpb+5E4WOpSN5oaL+mvsjFHcb8okLfGYeEoLtYHAIZr0dqElgaw8CP/nSKzx+uaemBYQyYRYWo9uyMxZ5oNAc2/UZb0Gdrvx/YplLC1cH6QYCU3vr51RtwG3ZcnggmCRgBrapRAkFgudndrUM6+kD75vXgP/DX+38FmqPJIJVGYWK2GIgb3nr4XXGbuc1CxK6o6k4/oTQjbqQ6+vBP6qP60t//15NJdvSFw3JuJdUWA0cGGoKoAFvwsjMrsHydLTr5BoKyZZYHSmXI8pg5sfD87S6ulqVkTEvZ8gzO38jkhAz6Ik/h3dMw207hPPbLfbZraaXWbpxH77TzxaA7wsXaDILRRZJDSzVEnFK52B8MVZwNIHAVIF3NQteG/BSt9lAZX+gG8ltqeuYk9i391ZtmEGBDe0MqfDasUy56KNThxp0mWC6sc6iFyesY5QtDRXEVlx8aZzUWa+9NqkqqPiAwp3Z90TslhlZ1SHWJMTElp/ZfrZvINtggaaPnp4L2VGf+Xu0cYJeONakfSMcd77WwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wU3aezBGZOKhbIi6InH3399iU4TZMbY0MbSn+Yz2a9QfN0CerHIxveRye5jJdeAtIG2/58g4popSH+GMg1TEUEmXaAuZoCRz55UmG+mgBHG0m0B4Rl0EocKK3BaBM0KI8MFaNugu+OPaaBka2NfTw3FoV3CG06gtUoREKc7lYK+gSBAntch9iYx+I2WGdeuqcvpmojxH29UBlny5QjeMWFrO88CKZdvdSSDfs8zAA3Semg5eYPJGNhyMAfDLm9xjHiNc14drARqW5gzS35zN98avn2p+4tlJlcOSGHBob16wHuiAqo3SSsgrt9AXRdTqXUkLj/S/OgfWeWoqgq/g513EtUvYPWuDr5ZCfbnOzee3UGWNZDPgqkjXtwmdryjfezL7CmFgkDAeKa51Fb7DDmiDDTSO+ryO5iuDFKAHhXvjkYNFNzbN72dKIj+EV5KN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 05:47:43.5650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90f92b7-6c8b-4364-8b01-08def8353ac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155



On 8/11/2026 6:13 AM, Sean Christopherson wrote:
> On Mon, Aug 10, 2026, Sairaj Kodilkar wrote:
>> On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
>>> [Severity: High]
>>> Can an unprivileged user-space process trigger this WARN_ON?
>>>
>>> When a vCPU is created, svm->gappi_cpu is initialized to -1 in
>>> avic_init_vcpu(). It is only set to a valid CPU ID later during
>>> __avic_vcpu_load().
>>>
>>> If host user-space configures device interrupt routing via the KVM_IRQFD ioctl
>>> before the vCPU runs, avic_pi_update_irte() is invoked. This will pass the
>>> uninitialized svm->gappi_cpu (-1) down to this function, hitting the WARN_ON.
>>> If the host has panic_on_warn enabled, this allows host userspace to trigger
>>> a kernel panic.
>>
>> This is a valid concern.
>>
>> If host userspace attaches a bypass IRQ targeting a vCPU that has never
>> been loaded. Functionally, there is nothing to do in that window. A vCPU
>> that has never been loaded cannot be blocking, so no GAPPI wakeup is
>> required. The IOMMU still posts the interrupt into the vAPIC backing
>> page, and the pending IRR is evaluated at the first VMRUN after
>> avic_vcpu_load(), which is also where the IRTE gets a valid Destination
>> and IsRun = 1.
>>
>> This can be resolved by assigning a arbitrary gappi destination, without
>> actually updating the gappi wakeup list of that CPU.
> 
> With the disclaimer that I haven't look super closely at this series, and haven't
> thought too deeply about the feature itself either...
> 
> Why are we doing anything different than what VMX does?  vCPUs on the wakeup
> list when they block, and come off the list when they wakeup.  It's literally
> one flow that's guarantee to pair put()+load(), and the logic for manipulating
> the list is quite simple as a result.
> 

I was trying to manipulate the vCPU list after is_empty(ir_list) check
in put() and load() path. Which complicated the things, since
pi_update_irte() will have to add the vCPU to the list if it was a first
interrupt assigned to given vCPU.

I think its better to keep the list operations before is_empty(ir_list)
check in order to simplify things a little bit.Note that it may increase
the list size and potentially increasing time for gappi_wakeup_handler.

> Going a step further, why is GAPPI not sharing code with VMX Posted Interupts?
> At a glance, the only meaningful difference in the wakeup flow is the "should
> this particular vCPU be awakened".

On Intel there is a level of indirection: KVM hands the IOMMU the
physical address of the PI descriptor once, at IRQ affinity setup time
(vmx_pi_update_irte()). After that the descriptor is the only thing that
needs updating, so vcpu_load()/vcpu_put() just write NDST/NV/SN in
memory and never call into the IOMMU driver again.

AMD has no such indirection. The destination APIC ID, IsRun and GATag
live directly in the IRTE, and there is no per-vCPU structure that the
IOMMU dereferences. So every vcpu_load()/vcpu_put() has to call into the
AMD IOMMU driver to update each IRTE targeting the vCPU, via
avic_update_iommu_vcpu_affinity() -> amd_iommu_update_ga().

That difference leaks into the wakeup list handling. On Intel, putting a
vCPU on the per-pCPU list is self-contained. On AMD it has to happen in
the same ir_list_lock critical section as the IRTE update, and it is
conditional on the vCPU actually having posted IRQs (ir_list being non
empty), because the pCPU that the vCPU is enqueued on is also what gets
programmed into IRTE[Destination].

Because of above complications I did not try to factor out the common code.

Thanks
Sairaj

