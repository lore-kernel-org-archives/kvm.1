Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922213DEFF1
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564728; cv=fail; b=WceVJCJyoXjrYda96AtYfhzLTFGHvyqQnlceCGTAEHk3asuWK4h+4Jre+83FqDivHfWduuYn2dXKRCuv0xdxP/H3ei9Jt8rSh1Z0b1miRRE0+szF8sIgAwYv6xgCVa7VhTpKi+ABoIuV315JEbqQEySyWF73bqB2G24f43/aWO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564728; c=relaxed/simple;
	bh=5EHV5/PT03CTyUkO4EoJmMsA99SeuOM6pAttf3t2/U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=glmQbxwpaYsmMRr3a//r4w//Hf1A3ngGhYGsNWSEo5bWFhBEABvkP4TlKN9C7ch9RFjs8JkvNwhl+0Rvhhg2uXwJczgvK4V5qoddbpHVDYAKVdpYUG5NOdQE0W3PqsUx3WZlleZT6Tzh0RsdqqtOeMDP//wCrHICc9TfXldOFg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pB6LF5og; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pB6LF5og"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAMc2M8xnOGi7UPpyvx3a9+/rNb0/LfdTcUBlqQQs9IiKjb/NlpZ6+mZMpEQ/1IjjtBoV8AwDAcuMAK03tfPfuiiuBHuzcibBIvooLauhwz4CdpiRRaSMpbhvKjc8pRrouIiNoCG4hd0LzCGU74RvWsBgIF1Jp66sLac3YngGsnBDmqI+05sG7pbzadTiG5PFjdkU1iDu8UwEJyq5VgyDiYAlxj1pE2fIxEYb1NIqOyiaOBcYz2ClaP5DmjZ+bQtenTEC3farY7a++W2fMBAwzcJJBj65eSZfYw+puvnDtbwubUogwKIFX1yWLgWai5WQR0V9FLBIn8GE+6Ew1JaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfwAUR6oGj92mupAC07jGXeRa8NUzS/jMcPIpb/s8Lc=;
 b=u9HCQyrFEUsgpZO5ixklRkZXYAyV21EBGWgI5dLrTFanllmLBNHLzd9Zrl22ZMc/LDrb7NbPqpv2c8swNb8TC4exoUP3My79IdyCDLnN5eWMhUXsRL9ODWVtjIUsRFijy6YwxEBjzGTJx4ifbv0B/qHYd99SB9bA8I7kJzJG2j6h9W+dCTY3qepLV23M+PhfXFXqe7Ox2T86dMpdiC0ZvYUeZuxnWvwe5UB80mRn43rNqmp0MeAKrFj8AYGeAFeiiA4qa0GxRGRIytSKJLyF1hsCXk06BskcHQL74gilo6frOYRGmKOlyMV/iFa1HTSaCKsoFK4x2I+I76upZy/TFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfwAUR6oGj92mupAC07jGXeRa8NUzS/jMcPIpb/s8Lc=;
 b=pB6LF5ogR3Jkgf+RAG9UQoYzH5gsaQUOFzpOgFTP9IiJk719Wh/b3Qaipl5odXtKdFiJesV6rs7sXHYlZMU3VI54l6SsausSgTolPMjWuqKDt8FSU8gEVwq8fMuhrNz3FW3Yd5JQtviF1Wu4kR64b8LXVsY/44J0OD73ykCzEzA=
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 05:45:10 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::26) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Tue, 12
 May 2026 05:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 05:45:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 00:45:08 -0500
Received: from [10.136.32.179] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 00:45:06 -0500
Message-ID: <23012b23-31bb-4b9f-80f0-ffaea65c7d63@amd.com>
Date: Tue, 12 May 2026 11:15:00 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] KVM: x86: Move PML page to common vcpu arch
 structure
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<bp@alien8.de>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-3-nikunj@amd.com> <af5qVIXf06WyK4XG@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <af5qVIXf06WyK4XG@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 519eba88-fa7a-499d-28e0-08deafe9a164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Stw9HW8wPXUtkxXODP/Jk/zT9L6WzWRigdmt0IVuCeeLP4TlVSYoWUibL5h0u/IiGcVByQateBLjru9el8YrdTN39HHdIRRCxCw1t/rEDj46Ad/clO6tylJT2fh2/olMwP3Ve5kBCMQkRni7cD/DyuGOQQVX0QXlu2PN/KUgZZjSpe0RlkDfrgOZCeNUmNKSQbBWKLLvGzcF6MUAZGJJ6BMuoOzVCf8HcU6wGDxV15x/i5WxS84xdgdsTlErN6fH8UwnXJ3WaIZCsBoc+jX0afbyM4/E1zsxguDe3vpkPyuLSbwKDXi1TYXSIzJJL+4Mj56oA757LLMeHZlk9VyMfof5gkpgIJfHWuM+WMxlQazwwBY0p+uePrHtwLTv+cZQorCZhh3PUOo21Of8FvFpWQuNwcXZRrV7UeNjHXLllMdYitnuMTA9WJOsjiRROK8v3Y+pTMBNVnnExG2tto+k78VLlbMKooWxsWwdJmY6CP15VAOfu/OdDVeo58Q0o/ucxrlOvFy0p8om+qGWqtHk0TC/Cu24aLcjDiSMkg6MEuyfbxbo7X7MaKCavrNl/MQEuMR8dR9GT4uRSNipmrik8gNIls5OIiL3VQaXNmT0D0BtDHrbnCyfS+Gy9P5myVoFULDUs0q1mTCMweVzik7IwRc0OcRF1smRudd/ZPSzZXNVg0ASM1H9XtEAOnZFLCbMgXCvKYPRI8DnmidNZYesBrh6lOJoLzkd+nMiSAfmIsI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rj7Rn8WCEjR+O4tFhEsNmAEUfS8xJYnL2oss5WzVgON6wKs8EzcrtBLunr+TgwuTo9mPlegThzbM3i8PF/No4ntrX2NUrFvwAWwuJwsJrkPr9ySpR1BshV0/OZP7etO4iPXe5rTvwJ05IRlq5TgW6C5731zC+f7YTfQF72dZPUU5hQSsAdfhRgl3uO/Ll/yCBPfJmZ+pRnNfMoTg+JdlHOzIBtwAxsujHx/xJdnPx51YrwKJk6/Hx2F/oudiQlnLxB3WTt20GmVAp0cTa634lINweB5pp5T8uY/pva+bPSA4CioZl0WBJiZL1Hi+O20eYS486z+D9SvMbaiKklkvIOiKlPwLoEJBnJWJ/RhbbtnXkirhj+bRg2hN2pcrFPYMDKm7g9G3miUaRji4VV9NuMCf2WHjX6KFH0woLkKT/DauxuO0n1dxrVdpl+T3CtgZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:45:10.2027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519eba88-fa7a-499d-28e0-08deafe9a164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293



On 5/9/2026 4:27 AM, Sean Christopherson wrote:
> On Tue, Apr 07, 2026, Nikunj A Dadhania wrote:
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index b77750a2efc2..909085a5dfb3 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4934,7 +4934,8 @@ int vmx_vcpu_precreate(struct kvm *kvm)
>>  
>>  static void init_vmcs(struct vcpu_vmx *vmx)
>>  {
>> -	struct kvm *kvm = vmx->vcpu.kvm;
>> +	struct kvm_vcpu *vcpu = &vmx->vcpu;
>> +	struct kvm *kvm = vcpu->kvm;
> 
> There are 9+ existing uses of "vmx->vcpu" in init_vmcs().  I'd rather insert a
> prep patch to pass @vcpu instead of @vmx, do to_vmx() at the top, and switch all
> existing vmx->vcpu usage.
> 
> From: Sean Christopherson <seanjc@google.com>
> Date: Fri, 8 May 2026 15:55:55 -0700
> Subject: [PATCH] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
> 
> Pass @vcpu instead of @vmx to init_vmcs(), and switch all of the vmx->vcpu
> usage to a simple vcpu.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Ack. I’ll include this as a preparatory patch in my series unless it
lands in your tree before I post.

Regards,
Nikunj
