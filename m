Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780941CEAC2
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777264503; cv=fail; b=s0DAaEUrGeSFyjBb9isQ+BPclT4vkPXfMlZx4H+0UCLjoSLDltuV/DBH7Enfap9gXdy7XelfgPPcgE1y8MVPikVHvlqGeC8H+og42IEx4SHD99O3v+4wmOG0MKUfdHJ4i1kCuSr75xw4QPzgAHLwKkbK6HN3eAiydhwievBwSQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777264503; c=relaxed/simple;
	bh=trioFXHNsFPwB6ZcvPLliIEfzB0Wbr24V/yEr+6Kpvg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=R03XKzkTqFPa95pOoByfAkcU21ZRZwSMTzUG4glxZLtl9aA80GiXExqg1MPVWHp6oT9Nr4CmGAyLaSzIZxtoniHcd50diehrsD1tOfB6+lDvCkamZbo6dw7dV+UFGsAWXasI9c3jsmq9zNNqeWoJDIc+Ki8uIXmEuDf8J7fgnlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ctc+Vz3u; arc=fail smtp.client-ip=40.93.196.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ctc+Vz3u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnIbPlRfweDzOBZjafhQLCEnCCxDS+4U5STwNBtgXl6ZLSBe+GH46Fa4KS9gHsqrQIdeyGsqSncg/pzbSUBVGIBOf4XX+D4V0c9c94EyHd5bZPmL2+75iIIpivD9P8V/XFVlIHFEOrp7XxCHt+YBGpimirgoRAPCsuzMnkTb4z9Ktt3+JpA3vbbJp5Lid4asaX8tp3nXJzFxvg7hdxhT2X8nib7Mve7XAQTRc7rYlFYdea4OUhf85a7hW+HKDXK9wQ5O8qdURkNle3Lh2tq95P3h9wxve01XdYUNO/9b+AilonbKL578nXNbr99UUaJS6cXmo6OpfDzDFv2RUHU4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBP3H1u7tAyp5rgiA0t4EZ4t62TelqfMF7suXgs+ubE=;
 b=hzfD0eGf3yItri8XnBBxh5FpKoMnFzWcxbSeFxxyUeLCPyT018yDBtxeMDav3jRaFlQRqaytpOMUyIYOFvosugYNAvU6cbhJt5rbV4QQKiRYX+prNL8zY6GpPcK0A97ceVkumHZR732BvsLDprmSbrXW0Pve0YLCiqjc5MPBWynxHkG+uMD4RjOnzlotz+xS+fuNpdngOzCiPGZU9Bct0YKwfEq8LxrgDkuIgw2i5fR6LHSVZJujWleOgBz0p48OQcCcG3xdDHCjoLmjNusOYx5TAo7b1WGQK+rkamEt7SHYkm2vCe5vi+TPfcCpNKnsP3XlLbLAWeKNVgZzNqvfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBP3H1u7tAyp5rgiA0t4EZ4t62TelqfMF7suXgs+ubE=;
 b=Ctc+Vz3uTPxtcrkoaZCTi9UoWCLhooAhhQsRPLM/kaVF23ZV2WiO2qQ1Ut4GM6Kr7m9A/t/Z0t2qF5pbYBV2xKRfHDOlsag18VWuhgIRASCPrwC3kV3bAInuHskyS2CktYYsxFQof5O6TxH2O3OtgrXkwGKBNxeVXlM7uhzckqk=
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 27 Apr
 2026 04:34:58 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::5d) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Mon,
 27 Apr 2026 04:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 04:34:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Apr
 2026 23:34:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Apr
 2026 23:34:58 -0500
Received: from [10.252.198.192] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Apr 2026 23:34:55 -0500
Message-ID: <9a9f712e-5f01-4652-9901-93cf3bdeef47@amd.com>
Date: Mon, 27 Apr 2026 10:04:53 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] KVM: x86: Add support for AMD Extended APIC
 registers
From: "Shukla, Manali" <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <santosh.shukla@amd.com>,
	<nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <0a9b715c-0476-469d-a09e-b56cb9f41455@amd.com>
Content-Language: en-US
In-Reply-To: <0a9b715c-0476-469d-a09e-b56cb9f41455@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c686f2-146a-4c6e-5813-08dea41656c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info:
	1U4FuZhRIv1KUDlBryuvB5KzUpWKqtgfMOHwKQ3CmJdXIon4pdtCAJxzX2cpwYKTx/4U9JWDt5Q1v8+JB0ZVJfJHIE2UlrA58NGHMMzhigvbNrp4VWJDnw60OI2b798jlz3vac3GXxs6iF1WqToAK4rXxAY2TPZe0feH4N4RIh6UbPgDa99pQ2bRhMgKtkOHmU+53ySCYP3zlyn1rABW8cxv42iRqoV6taPFc0lXe8LREsoq47WwSu1W8sSUed0vKf0c0adkFwm3EhPzr3tF9LmLJCl8qeaDmcN8cZu6W4WPlydHozo0bmcEqClu1OSBJIDeO0TVUsaP+Y92uY8cqbLCSarH/+bTQorLoQWkj05dfQgq4LzzPQFO6L1s4xDRgWwg0KK36wXkHL3xYh0vmlngbaX3/1nyecwVVb+8rg7C8bHaSIkGR0G1IyRBOk7tEZbGJBL0J2S0aN8rh8gma00RbYnm6ujEuoaKdOSixMCTo+gxbBD50Jy8XXcNxENZA6Gw4RaNOe4FRrvFb8X11E3QPMNR5tjdjIL/hXV7anQV/buPNYwkTvtNQHDAhZnLc5cD7tDhxBcBD6tDhpDHR3WRdFPukuJrFK0dieC9WjxVnSEjB1s/PwYk6DrkkNzxunVLJ+2ZHzg7OTatELw0l4e0WtFLy/cLPsZWVygyNAh1ETh8ukPsCkDVm/+thMEtJJ5uVrJ8Y5cQeMxgtndQqVokQF4rZ4x6yLi9kG6/mbw9fKhDP6ceY+YXIRUXlwFj+IsFLciQDGUwaq7qmlhyKQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(13003099007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8e6g5ZSc8eC1Cs7950JquZa7uXBx7fl204RxBOtBj1JqfocaiES5uC0rj+ozEifTsGnQNQgwQ2ll+uWKip/XONRZJ7Z12UXv0WMluZNZM0HilB6csOs2DWqRt7Q0DagT8RlS/pzEuG0iDjPcG+qI/Fr6ps/dSi1yoU3Rq4FFh7L4zTL1EcT4eFQQjQIrcsonjuyMRILIK19WgDlJujRcKRyIchUEZdK63/W2CJTpZd/pISbK67xAeYLOH4mCMmHgI7i/9TElNtSsSTh1KvmFD4/gpDx7Bo2Q2gnJQ3dk39YJccARzX4YJ/9YPihTpHphHfQ+sl2DEXAf92GvmvBqPyV1TEIbjqqatEghRIkaKMqluplSwBhZOdComJ71JACas4uwNm2Y2WdvH/FiyBdbYnbPFp7fWBvD7khJ28+Qsg9yBbcn5Lz3MqSnYKJ7CjqW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 04:34:58.4695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c686f2-146a-4c6e-5813-08dea41656c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335



On 3/10/2026 11:47 AM, Manali Shukla wrote:
> On 2/4/2026 1:14 PM, Manali Shukla wrote:
>> Add support for AMD's Extended APIC registers, which reside in a 4KB
>> APIC page instead of the legacy 1KB APIC register space.  Extended LVT
>> registers (offsets 0x500-0x530) provide additional interrupt vectors
>> for features like Instruction Based Sampling (IBS).
>>
>> Introduce KVM_CAP_LAPIC2 to allow userspace to opt into the full 4KB
>> APIC register space. The capability uses a bitmask to support different
>> APIC extensions:
>>
>>   KVM_LAPIC2_DEFAULT: 4KB APIC register space (common foundation)
>>   KVM_LAPIC2_AMD_DEFAULT: Extended LVT registers (AMD-specific)
>>
>> Add KVM_GET/SET_LAPIC2 ioctls that operate on a 4KB APIC register space
>> accommodate extended registers.  Legacy KVM_GET/SET_LAPIC continue to
>> work for backward compatibility.
>>
>> Emulate extended APIC registers (APIC_EFEAT, APIC_ECTRL, APIC_EILVTn)
>> when the guest has X86_FEATURE_EXTAPIC and userspace enables
>> KVM_CAP_LAPIC2.  Current AMD processors support four extended LVT
>> entries, future processors may support up to 255.
>>
>> Integrate with AVIC to accelerate extended LVT MSR access when
>> AVIC_EXTLVT is supported.  Reads are accelerated without VM-exits;
>> writes trigger trap-style VM-exits.
>>
>> Tested on AMD hardware with Extapic support:
>> - Extended APIC register read/write emulation and AVIC acceleration
>>   with IBS driver running on the guest
>> - VM migration with extended APIC state and without extended APIC state
>> - Backward compatibility check:
>>   Fallback to legacy IOCTLs when KVM_CAP_LAPIC2 capability is not enabled
>>
>> Equivalent Qemu changes can be found at:
>> https://github.com/AMDESE/qemu/tree/extlvt_v1
>>
>> Patches are prepared on kvm-x86/next (003f68c79227).
>>
>> Manali Shukla (7):
>>   KVM: x86: Refactor APIC register mask handling to support extended
>>     APIC registers
>>   x86/apic: Add helper to get maximum number of Extended LVT registers
>>   KVM: SVM: Set kvm_caps.has_extapic when CPU supports Extended APIC
>>   KVM: x86: Introduce KVM_CAP_LAPIC2 for 4KB APIC register space support
>>   KVM: x86: Refactor APIC state get/set to accept variable-sized buffers
>>   KVM: Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 for extended APIC
>>   KVM: SVM: Add AVIC support for extended LVT MSRs
>>
>> Santosh Shukla (2):
>>   KVM: x86: Emulate Extended LVT registers for AMD guests
>>   x86/cpufeatures: Add CPUID feature bit for Extended LVT AVIC
>>     acceleration
>>
>>  Documentation/virt/kvm/api.rst     |  75 +++++++++++++
>>  arch/x86/include/asm/apic.h        |   1 +
>>  arch/x86/include/asm/apicdef.h     |  18 +++
>>  arch/x86/include/asm/cpufeatures.h |   1 +
>>  arch/x86/include/asm/kvm_host.h    |  12 ++
>>  arch/x86/include/uapi/asm/kvm.h    |   5 +
>>  arch/x86/kernel/apic/apic.c        |  17 +++
>>  arch/x86/kvm/cpuid.c               |  10 +-
>>  arch/x86/kvm/lapic.c               | 169 ++++++++++++++++++++---------
>>  arch/x86/kvm/lapic.h               |  14 ++-
>>  arch/x86/kvm/svm/avic.c            |  14 +++
>>  arch/x86/kvm/svm/svm.c             |   3 +
>>  arch/x86/kvm/vmx/vmx.c             |  10 +-
>>  arch/x86/kvm/x86.c                 |  93 +++++++++++++++-
>>  arch/x86/kvm/x86.h                 |   2 +
>>  include/uapi/linux/kvm.h           |   7 ++
>>  16 files changed, 390 insertions(+), 61 deletions(-)
>>
> 
> A Gentle reminder to review.
> 
> -Manali
> 

A Gentle reminder to review.

-Manali
