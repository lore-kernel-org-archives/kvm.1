Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6923C3425
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564189; cv=fail; b=ut9FJzNQenJofsBS7hYY7VPOKx4RHPlnMEfD1EjI+3bHY9HSjoe4NkEznGrXXTEiw509ufiQMfbhKzThQg0ZOBaUwtJT1ne99Y2inwelHVIVnerCKMDGS35/dvyNCF4hc74MLKoOyDVWLygGzlONYs/AdvYcOZSbFZS0TO3nL6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564189; c=relaxed/simple;
	bh=bjfiTSqED/RW3OWGfULlnFVMVKZrJ9mUWbSZdQt53jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lUEDIZbudO1C3sfFqoDRSxM409E0EgfR3WlWgRDfWYSBOwFedsOsyeUX/FE2vM52yP8xsxR0xXYLvWbyUurHhCp0+oB3EyYqLbv9P7htsDHCmIO2daoeZOcM1A0G816u3mUucR2iCoBW3/VwaoTzsGZSGJUWw6Bz/71mDOha3aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M4z9NUTf; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M4z9NUTf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDtgX+ZtxPmbvY8gsabRYKQELVDhClpA8Njw40Y5Rop+c36LQjifJRJ5CHSOa79+UPsZL3XedXcHmvJwNGY1W7BGB2zUlAGoSxDFjDh8A8RiXo5iFj430682QtrGYxwl5WdbVceEYb+yLZYdl9kwFsqkJikAxBTjWGgtJEHxq7KihrkQu4dNDhKmWSCy9KTxbzw+JZS9RoufinUDy8NCsYYinLa+33PXch8uVRL8fgz6/jp8Rjlz48pfOcW2yxrHBBNZ4BRxMpeEDPdDchkKOKuebC12qgGEzQ4gT/IwP+tvCzJAaLhYS1YK66i9oF7nsgERjT/QyM0JJvKiZiVqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/IvfoYcYug/bgsmCY/Lx4eKGksU9BKQ/oxLX7MpJmk=;
 b=StJbb47zBQme3owdDR2eTpjfKd2bFxYQWJj/QGNM1vnOGn+oZe9L4ykM+qpGvzSc8T0OIOAd4vSmSwq4ICbo84Y7j2eO+5uZBRTO4h1iMJySAkltyx19jiWp1eK65c5szfkK2toOHj++aqxwRbWGLab1r2gab0XQDZzRUEi+LM5tS6ngqYquFd3Bo70Z1UxQSlVXNhJzSYejZ31ah5IFv5gobAkif4PZTQWWgnu/MiSKpogzQE7Ntom+oX7IYFkIBIhZfqQIJvx+HaKiXl4bcqKSq6RzDnkBVgB7jw+jBx359LiApS4jjtreVPe9dYJXZVMiix1KUs4T9ubjHH2L2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/IvfoYcYug/bgsmCY/Lx4eKGksU9BKQ/oxLX7MpJmk=;
 b=M4z9NUTfH94iyAByP6Py5BAlsREc8eU1fDD/GI/eBEKbi1j1ixK4yfivKN/3o59hjFEaVREYT6rl0flyTW2nHmQJyQ+zn+3uS1U8cqiPvz4Cno3he54lz7/ibULCY3q9zxBwWytw8zvYWo9sOarSj7hp3eZAILXLUaB37EZNG+A=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:36:18 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::da) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 05:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 05:36:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 00:36:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 00:36:17 -0500
Received: from [10.136.32.179] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 00:36:14 -0500
Message-ID: <5e3c6707-ec77-4ff3-825c-6b15e89582c0@amd.com>
Date: Tue, 12 May 2026 11:06:14 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] KVM: x86: Carve out PML flush routine
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<bp@alien8.de>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-2-nikunj@amd.com> <af5pLI6MylNvpZVy@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <af5pLI6MylNvpZVy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e508f5-800d-40a0-5c07-08deafe86451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8Ncye+Snu6kVyZ1lMwIvYosz4a8egRStTy+B4z0DlDZx8Y2uO7tlWp/eqEP6O9kKlcxsPtFs4baN61xvOC67gr5OR27SbMGR2GfCi9ZVXMOo2yVHMH9PH7oIN2gaRhJTUtXY3uRsPBINjbIu1Iz/hxg/X910SheKJBLdrWHU/0E1rbU9HZEhi8tGejk4L6MrAbMQA7qqwUBce27G7Cu580k0riy4AbMu705AauHoF5eNB6Ndg8NQp0Z/52m9fTKsa5WtdcFE54l7QlGTGa5eMQCXwKaW55uMVZnmxjuxThxyNJR3w9oeeTqx1tPq66wK5GO3WIuMXG5J6k3o9uRTw7on2moCAtInomi8wwGGLwOM6rdW0A9qYynALPckdEDX7GKzjkJ1iq2dU0qqvWf2yQ1LuoeoI29M/Pd87lFyzVcc84UaoRbfg3mcdyfktgxPzHuf9ok4fSM18qiEiHWZjzej3iaRag/DYmRLEMIh1IzMkgOMpdWDirAp1mFdE+Sgo/S/3mqvlATudZ+MNpqVMyYpgE7+nkfCJfSVyxR9GK0mS1BS4abZ16hNQRvMm/RkCXHS4AScubM8KeFHEO0uXDZWOGHfEnQQiDKMOz7XJSwzHSklgVpEXdqm9ck+yZ1oFDqn0b8KZO4EXwqzoKextiSBFarrHQEmsZdV5HLES0oRjvoyOm3qGKNTVio+VrcaJHjuTsV4gDHZ2RpxqgZ6bWyVRrhE2TT+tfefuAyGgj8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T13WptKIdKyh2yYeGhOspwwmZ+Q2gKQfexTlsfLFglJiQdi+UDm73RxBt7i/+7nnTqOfG2m3Vj6F/y5NlV9YXi5zGn24dPGbvqF+sfhdP26Zs/ROwVnuKpdvnY/ywN8VXSEPSqqCqPWoypRoIVmJRIvfXdc2GcIx/NWQXY0oXVm0z5PtD4TVnrrQnxF5isoIwAxXyoLKz0eM/pnZQASWo3i61bipUK1gusFtWOy92/j7GIOQaMmRbQq34jzUUJ912O84A1blmDjkYaegqtQqWsS3sekhMYNI7lcOMHL8V6pHAc9KkKBRUoRtoXdx3l4spx41VJkdsMrAMuKrjA7xPo4Ujx5Xud235LaKKaG3jcSMendHtYLOwwOFsw4uEGla6Nlk/8bnax+rDkM6UsQX1XPLMFTmIyVBlpxVkKyBHEIWgTW0lqpAUTLAtPyuStTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:36:18.2671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e508f5-800d-40a0-5c07-08deafe86451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488



On 5/9/2026 4:22 AM, Sean Christopherson wrote:
> On Tue, Apr 07, 2026, Nikunj A Dadhania wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fd1c4a36b593..628b6f51d2be 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -6720,6 +6720,37 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
>>  		kvm_vcpu_kick(vcpu);
>>  }
>>  
>> +void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_page, u16 pml_idx)
> 
> Swap the order of patches 1 and 2, then you don't need to add @pml_page, only to
> remove it one patch later.

That makes sense—I'll swap the order of patches 1 and 2 and address this in my next revision.

Regards,
Nikunj
