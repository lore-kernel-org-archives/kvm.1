Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB53ECBD6;
	Tue, 31 Mar 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949313; cv=fail; b=eXCdoXSmoKyjpYk9oD/Bt+6zptD419ZrZOLteVP34DXEP/2BQC1MiBJPbwTrI6oqfdyzFdcDUBTHwdJxYhREN1sjaykOeHPZ/DcVzanMmdFkyTsPngiTR/VcXPopEeZTd0XBgRF9QO8XpoQ30CtHL2zdk71NYgwKr2C9VHkRENw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949313; c=relaxed/simple;
	bh=uHQzTHKidC6zGehBDohrsvZLuzIJQhaAaGDT1fKJapo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZWYKbB7cAuWXnNVK4JoTwUcNN3jV+tqw5mQRbpCW0kIDmxSQDeKJO4oEDLAHjODsdmUohPbbFkgnKXdxyt0Fp3wZIridoKyGdmWqsx+IcpiKxAo9YfgV7PNew+GjIykKgxN6g+316NU/hAgqwfj/eUyE2uiRPGeknHnDH6KP68E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KDHeidxv; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KDHeidxv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLmKYn5YJn68D/G+afccdJoIxpFP3Vjmh/KZmm42UGBut2GZnENpp81skIAUjgnJDW49tA0XudHLvnkDoyXkMJo8+0sUNO9Igj9FAFdEPESW1bvVkeBRriwF3zURvvsBiUcn67GxUiwHBSs51VL8GZm1ty0tkQmoKbcKhCMiXfLWbPlMu1IsxhnQx3AXfHS1HKGzXfe7D4q0zAS0Go+jqlzaA/y87PAFLAl9RZ7x30kDsavCsD7rbm2GRbJyG5zyXw1t2i+pmqhEybYES1NSDZMpSidUt/bLzyqweWN4BzbYQzAXQBL5iuTOniywZb0Uq7mLyWh/ROL9yKHLuAY2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djSlYpWyg6z/P8Llek1Kr+XhDVAOqr/G3/8r+o4KRPI=;
 b=ur7ev1A8A1vx+aXb7igwEZ3U41ptAzpRLgsswKr1lXuwU5M72+c/+osuxB3psALLD+q/6Hn3LirnIeHpMEo/aX9918v9bj0WtCRigFaFAWFzezC1Dg97ibcAXjWlR47ZkTVCCwjcVolgy+UGxiuT5kUgY/HzXvloo0TR4kKOxdokwUOVm3oxJofGGTuq62RPWq0gfriwLTGdcVzcbMmeoCxh/X0F936jk0lX0A0YBnEWR5OzC+Zkp8QxER1itDcejlyXnUluWNuECW+O+BoUC0qK98WVq4/iwLOElaJ9hvINVJyVWPXOUt0pufnZQgl4hgmEXzRT8OHc9uilVqTFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djSlYpWyg6z/P8Llek1Kr+XhDVAOqr/G3/8r+o4KRPI=;
 b=KDHeidxv1tFE/XOxpI86KzRAIYmIPbQduMOPUxVbikOLadE7wS+ZjZ9AZrRi+0kAHtM6bjGLPJ9XWp27IPKMM8J9rIWj65sQBbbWhinl7x2wyDHfcehwKus8LAoWCRVbBpdx2QEwWfabFqDUjjvMTPEfT32FGZNfpgAQkFDF8nk=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 09:28:28 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f7) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 09:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 09:28:27 +0000
Received: from [10.143.201.178] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:28:23 -0500
Message-ID: <99507d9b-c3be-4a77-8b84-79a30c7dd402@amd.com>
Date: Tue, 31 Mar 2026 14:58:15 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<nikunj.dadhania@amd.com>, <Manali.Shukla@amd.com>
Subject: Re: [PATCH] KVM: x86: Add support for cmpxchg16b emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>
References: <20260306102047.29760-1-sarunkod@amd.com>
 <aar082uQQhXKNiSQ@google.com>
 <d2cba245-8532-4f89-8a95-0661b4c3eb36@redhat.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <d2cba245-8532-4f89-8a95-0661b4c3eb36@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: c412de38-dcc6-4f4a-0c37-08de8f07ddb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Xbd/cY32atkcLgz+wHmzBJ6aiiW94mdmaM//MiL8hxsYhVm/fZtugjC/m1AcTV2EZtxgGUa+1l1LycMfQU5u/SVWfdsvlI8Zkwrb2XoBJeuTCwr4UvfAvql0otDylGNdM4g+0Vm/ielEB8Iy0yIJzHfTZaGo48BFQs8A+OhmVb+6dBWHoghqfKHkG1d+FJjXYbx7Pd2AVeMiO2HP+KaVBtHOxfp0nV752oc6+eHyZfrlWcs6olxXw0BaYUpCO6bsEIXlVe3Bzq3Z1gLLOxsjH0ptpRIRGUznfbQPVsgfcdy+RXfxKqVuzv7iJIqqvKncydXbJsEdxotl7uDhiBxp8IH05JEhHQ/M8GeeBwMPkJ/d+XqO/HqzX/aHXq5dY6LVQPhP0O8sSJBj9qPGJZuBhKbJJECuB63ApiZKujU3NdnOAm/zCk39aK8MPL7/8+FKhtbGy8f+a6pO1E67VGv0NoCTTXzyez7Xb1d75geyUlw78QDnoNt/I4BOu4P/Gh8kfkMAdm2yymhvF0W2+fPdFIM8meV4vGU3bc6LEemzj6I1nuaTMcMCwk+BQcs4A0dQeP1TlnWyzPez/7NT5eaOmXWroxVUcobuqF9kLfxIIrHl3dTS0Z9QJZVWuc5hS3KAzbpMY1m0MRxqdhp5i/dDYu1Gj+teiOaBoFp8DWozMLErylW5+WlIwNEuKOnPmO58MxcDuolHGtWjomvxwWUYS8/LUXTc51Xqt+7PdDmHXdKBawZolHeP6fdlTXWrMJOSN6ahev/jXL0BAbii0s/Xlw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DLT/1WjmL+TUg5ejIoVZqdvRr8eCh3d2f+Gb7pI9I7TddZrlrzF0KNxC/667JvxsyBUbNtMKjObOnftLDbbx4U6LGwHyg58pVy0auXeAsfwWLW4SpuY+grhKh3A2IOtzH8F+hnPyagiOtYiHKzslF8/Rblnc+wNXtj/jiOWwtrHG996+3XqEXKNkFx94B75oUJ8pISO44V7XmPunLkODCRNbiRWzVF3jbh6YEs0yrEb7owqRR+ttvn2kej7GNjm29nZrgauwrnGNg3zE1NsBuME6kaeKkc68Bvz9OlfO0YSgBLzM4XidCU56x+wrncWLTo9dGsLdkYbLpRDSfhNvyBX69UyK/ptWqwqkP1iiQk8rIqHAFHUc/ky9LzXkttCRR0H0qDUnYKoWqWxrbWIOdTdcE09MKuYCklICOTvICHR1QEAGScifj4VBNFuJjoZC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:28:27.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c412de38-dcc6-4f4a-0c37-08de8f07ddb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823



On 3/12/2026 5:16 PM, Paolo Bonzini wrote:
> On 3/6/26 16:38, Sean Christopherson wrote:
>>> -    if (ctxt->dst.bytes == 16)
>>> +    /* Use of the REX.W prefix promotes operation to 128 bits */
>>> +    if (ctxt->rex_bits & REX_W)
>>
>> Uh, yeah, and the caller specifically pivoted on this size.  I'm a-ok 
>> with a
>> sanity check, but it should be exactly that, e.g.
>>
>>     if (WARN_ON_ONCE(8 + (ctxt->rex_bits & REX_W) * 8 != 
>> ctxt->dst.bytes))
>>         return X86EMUL_UNHANDLEABLE;
>
>
>> And then emulator_cmpxchg_emulated() should be taught to do 
>> cmpxchg16b itself:
>>
>>     /* guests cmpxchg8b have to be emulated atomically */
>>     if (bytes > 8 || (bytes & (bytes - 1)))
>>         goto emul_write;
>>
>> That might be a big lift, e.g. to get a 16-byte uaccess version.  If 
>> it's
>> unreasonably difficult, we should reject emulation of LOCK CMPXCHG16B.
>
> It's actually pretty easy because a kind soul already wrote the
> cmpxchg8b version of the macros.  Compile-tested only (and checked
> that the asm does have the instruction):
>
> diff --git a/arch/x86/include/asm/uaccess.h 
> b/arch/x86/include/asm/uaccess.h
> index 3a7755c1a4410..f40e815263233 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -388,14 +388,13 @@ do {                                    \
>          *_old = __old;                        \
>      likely(success);                    })
>
> -#ifdef CONFIG_X86_32
> -#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label) ({    \
> +#define __try_cmpxchg8b_16b_user_asm(_b, _ptr, _pold, _new, 
> label)({    \
>      bool success;                            \
>      __typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);        \
>      __typeof__(*(_ptr)) __old = *_old;                \
>      __typeof__(*(_ptr)) __new = (_new);                \
>      asm_goto_output("\n"                        \
> -             "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"        \
> +             "1: " LOCK_PREFIX "cmpxchg" #_b "b %[ptr]\n"    \

Hi Paolo,

I think its better to keep two implementations separate because this
adds an additional complexity while passing the upper and lower half
of the "_new"
The cmpxchg8b expects ecx as "(u32)((u64)_new >> 32)" where as
cmpxchg16b expects ecx as "(u64)((u128)_new >> 64)"

Thanks
Sairaj
