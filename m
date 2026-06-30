Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C76343D7F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796612; cv=fail; b=Qtp7DP9KraSG32vKJK7b+gFvd/bZe3ki8D1LoJmPZF4nnzB1tHgA2l8YAJ2/Ss8V7ucX1EjU6jk6BC/n0+axzCF7fyzmHpBMaJd/Iiy2M/OJZYkpSvGYT7Y+shXwCcZMlsgBl+X8a/CAOWnxEum3Q2i7ahqVYna3SD415YtHs+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796612; c=relaxed/simple;
	bh=yWh8t/gHkx73X7j6utkdbg733uC6kOt0Dn9HI69GAHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+ESf6/jSX+UPfht2KRGkhph8UL1zR05xQpsoJ9ytp9E/zp0dhjWyRg5oH7r+AswtXDrH3EROkN9gD9qniEWIr2tJtZypYiTqYV458M9Y0rD6F9dVXLK4HbyFDj+7Un4AMNyGIxphF3LCqcQ3TRrnhy3pEi25mPFjlhN9YnML6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YqrGDWQn; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YqrGDWQn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLDwG4oBojPU8ipaGI8EyiTXktHp65m+3yQyFLIHnJzqDZ3X60MDOExLIONsJkqC2spCgjNcu57yzz9xzuIrCPfmS9RS/f8ZL2eu2kb2k5AaZiH2Mfz775sGaLMao6Fqcbb1AZAndY8VE4wgrASzdtixzhJEMPU5jBca2+S48mOeHRvF/RZTztiDWKVZT3yPgsxOBM4ML98jrGN4MI4o3uZljCAcbqVFNlxie5Hi1KU8KJevDALZwTnFj91ecwn1hVmNWCNO7actXaIWFPf15kDmtVSu16P/tB7beoz3DhMBhbyoZlsxP7uPBoJrvFzgnlj/aKDRkGUiRU07gMLYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWSZHIIdhf/Z78p+7ROlvbXFJzsG+kLMmu5btoiv8LY=;
 b=eoEB3aC9otQuRtDCHeMocudA18YPseIQcZ+0+dPQj/gTOFA97epA83NFgkd759w7ojcanzcg4ykALaS7PY+7pl1KdVKCD0ZrL5xbHh9Qv+YATZggzaVW6tzDuH7eNCBYktMpdiVcPx9/ZntbxvPU4CzTisnXpt3F3GBh+ygtvdjDF3Ljag+fNJztN8MonFaiHwMLDWLD3Q7mszRn73jFe3BnQgWmnNM2c6p6DIaoUO373Db/O1depnqD+/jydqlP7oVhFFtOUtWTQM3p04xIDiEx1dMm+G0zQ97eWP39vylBpz6eA+PkJXAkRIe0OrDR6vlLmnNuTS6Zuw6BqdqVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWSZHIIdhf/Z78p+7ROlvbXFJzsG+kLMmu5btoiv8LY=;
 b=YqrGDWQnLURIHYKXI0knpb65nK8SR1lubK44wN+Ih8sTNsS/DkHt4iePjyqPNX+quv8jikU144RaSv0zAqtCXuEBmsEqvA/VTTg3s60Reg05HWzt40Zyeb+Fv3Jlj9IRZqckAH4DYa/FuIgXrCDQ+qpStpJNJ3EXhudwi32vAYg=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 05:16:46 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::50) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 05:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 05:16:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 00:16:45 -0500
Received: from [10.136.43.195] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 30 Jun 2026 00:16:42 -0500
Message-ID: <4ff05d83-68ae-4a2b-b225-c0eaf6bf43ff@amd.com>
Date: Tue, 30 Jun 2026 10:46:42 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] KVM: x86: Introduce KVM_CAP_LAPIC2 for 4KB APIC
 register space support
To: Naveen N Rao <naveen@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<dapeng1.mi@linux.intel.com>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-5-manali.shukla@amd.com>
 <agXHsttHBB6XQLMg@blrnaveerao1>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <agXHsttHBB6XQLMg@blrnaveerao1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c2d90f-69d8-4b53-429b-08ded666c7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dZOpQKoPE6A6JsEK1Y3qNYCpXQKJN1dQuHuOBJlSc7zQK6XS3P0KFbfcnyBFSlzeRWbE3Ce8qqTidYr5Du35dt1gK6HiBcf0sqvFWMegrUaSRLpP+d0yFPGtkeas1Nc7wtyPhUmfcwN8TIKvjZSLnvhGJwfpuztZgRz8bSvusscHsc0z4nT5uXe/IwuwT2qXB0TwYqIEVr/mPfl5i8oQz/a2yDBsxAw/KsDVrN9wukKZCy5I3EG/sDB7V/Pvrrc15F5FFy4UTE/a9txlmUi4L4SWdRG8s9yyWg9eAEIPfdJUVESuZQDH7hziNTXOXdf2M5dqtnJHWCHJF9SLthsGNlgn57AH/fr3z5eBQoEzSsteZfP5dJtIVSlTU/s3/iAJTiUpmaoUuIg5spiAv9VXEmHlhEhddeGDQU7RHe3+mBOSZov9fRw/TfjbSd7UEAKNJ3qFEpa1fUHLdT7P1CD6tponLhlA5n0yd67ltqTyiL1GOuBZp6nXxtAhjCdsrJhL+4F4XxbklvL1jPjuZEv1jNCfI6/KflgP3WYrySKFbTLjFyau0bWWruZrrnS5M4q0JApP7w1q7Mx8VdFShgLZe944s9fpB849eGAVkhboDJS/xq4CDTFXmbgfWv0cwZX1asMsfVBorcppoDWrSWPlJxD4/w8I6pRtkeuLGO49OZn0YsJlTT1sjZ0EocCSoWcQm1XB4FkCg60SMe5AMH89mg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OXxoOfUW6vsb2sJybTbuzMdg+779dVntgKH+n3STSx+6NeIjqr0ntVU2mwRcjTydfM7vJCrii/9Goh/QCi34LS6gS5p6W7iApgE/Rg16qpwlRxd+pK1JEK5a5s76ddfhqaFRBNC9atQKa7gVqbtTOZXFdy1KYKBM8Ua+1WWgM4z5wjakzPjfbhExfZiiq+KECKmTwuhEEGOsgULBysWu5jBmXFHoghe3/lGh3n49pDo+ymlJk/PdHC/RBCwjztj2l/GyVYqA94DCEXqQUFlvuog/DT1YpsqDveADF9eb9xIx6dt1POP/4411iQ4kmx6r8xd2y2UFz9bY0CdISg6KQc0nbJzDFaEsfvG5P3eefIlmOFuk+AXm/ODU5qOwSQYxD6/XCpYo4SdSZLIC5nuiBkz+ZnPx6uNIpywYco4HosR2iqpNWwa9D8gP1pVqRNp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:16:45.7590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c2d90f-69d8-4b53-429b-08ded666c7a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

Hi Naveen,

Thank you for reviewing my patches.

On 5/14/2026 6:38 PM, Naveen N Rao wrote:
> On Wed, Feb 04, 2026 at 07:44:47AM +0000, Manali Shukla wrote:
>> Add KVM_CAP_LAPIC2 to allow userspace to opt into extended APIC register
>> space, i.e. to expose the full 4KB APIC page to the guest.  Extended LVT
>> registers are part of the 4KB APIC page and are AMD-specific. Extended
>> APIC registers provide additional interrupt vectors for hardware features
>> like Instruction Based Sampling (IBS).
>>
>> Use a capability negotiation model to allow for future extensibility.
>> KVM_CHECK_EXTENSION returns a bitmask of supported capabilities, and
>> userspace enables the intersection of KVM and VMM support via
>> KVM_ENABLE_CAP.  This allows KVM and userspace to independently add
>> support for new APIC configurations without breaking compatibility.
>>
>> Define two capability flags:
>>   - KVM_LAPIC2_DEFAULT: full 4KB APIC page support
>>   - KVM_LAPIC2_AMD_DEFAULT: extended LVT registers are supported
> 
> This should be split into two patches to separate out the AMD bits. The 
> base patch should introduce KVM_CAP_LAPIC2 and either also introduce 
> KVM_GET_LAPIC2/KVM_SET_LAPIC2, or should be after the patch adding 
> support for KVM_GET_LAPIC2/KVM_SET_LAPIC2.
> 

Sure.

>>
>> Require that the capability be enabled before vCPUs are created to avoid
>> the need to handle runtime changes to the APIC page size.
>>
>> When KVM_LAPIC2_AMD_DEFAULT is enabled, set kvm->arch.nr_extlvt to
>> KVM_X86_NR_EXTLVT_DEFAULT (4) to track the number of extended LVT
>> registers available to the guest.  Future patches will use nr_extlvt to
>> emulate guest accesses to extended LVT registers at APIC offset 0x500.
>>
>> Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  Documentation/virt/kvm/api.rst  | 31 +++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/kvm_host.h |  1 +
>>  arch/x86/kvm/x86.c              | 30 ++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h        |  5 +++++
>>  4 files changed, 67 insertions(+)
>>
>> diff --git a/Documentation/virt/kvm/api.rst 
>> b/Documentation/virt/kvm/api.rst
>> index 01a3abef8abb..71b4d24f009a 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -9291,6 +9291,37 @@ KVM exits with the register state of either the L1 or L2 guest
>>  depending on which executed at the time of an exit. Userspace must
>>  take care to differentiate between these cases.
>>  
>> +8.46 KVM_CAP_LAPIC2
>> +---------------------------
>> +
>> +:Architectures: x86
>> +:Target: VM
>> +:Parameters: args[0] is a bitmask of LAPIC2 capabilities
>> +:Returns: 0 on success, -EINVAL when arg[0] contains invalid bits
>> +
>> +This capability indicates that KVM supports extended APIC register space of the
>> +whole 4KB page.
>> +
>> +Calling KVM_CHECK_EXTENSION for this capability returns a bitmask of LAPIC2
>> +capabilities that can be enabled on a VM.
>> +
>> +The argument to KVM_ENABLE_CAP is also a bitmask that selects which LAPIC2
>> +capabilities to enable for the VM.  Userspace should enable the intersection
>> +of capabilities supported by KVM (from KVM_CHECK_EXTENSION) and capabilities
>> +supported by the VMM.  This must be called before creating any VCPUs.
>> +
>> +At this time, KVM_LAPIC2_DEFAULT and KVM_LAPIC2_AMD_DEFAULT are the supported
>> +capabilities:
>> +
>> +  - KVM_LAPIC2_DEFAULT: Full 4KB APIC page support
>> +  - KVM_LAPIC2_AMD_DEFAULT: Extended LVT registers are supported (they are part
>> +    of 4KB APIC page)
> 
> I don't think KVM_ENABLE_CAP should be necessary for the base LAPIC2 
> capability (i.e., for using the full 4k space). That will make it easy 
> for userspace to default to LAPIC2: it will only need to query for the 
> capability and can use the LAPIC2 get/set ioctls always.
> 
> - Naveen

Yeah. Makes sense. Will take care of it in V2.

-Manali


