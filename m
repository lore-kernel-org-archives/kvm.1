Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645C282F24;
	Wed, 11 Mar 2026 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204865; cv=fail; b=h9tYmjLpMv8R/6Ppv+ebUo9KPnl0yQtGY5X2/O+H5pNCxLtbCT9AJ3LITix5tfVIti66pkBhMdF3OTAoZRUfElFiWjY3nzw0z5fjNcp463QU5XgHmqgDdnMALnc8WQsFCJOIuk6iH0ph5n4TrGNXo1ZptxtBGyoIs00ngojF0FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204865; c=relaxed/simple;
	bh=VVmvl8LZFKp08k6gyMFOYB7CgARcHi7NSL4oUTrao44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RlE+h6Fw+spQzddG6NtHfToPiF+NrDY7o/SepwAexKKVC57ZurAYsglPwkzISS2K0cDbDtau7H6PKGJ3LTb9BM+5RQjoIz8OsQ9AirhPz/hZpomf58fXAknfi48LZ4UFfVrtfkHfWPQpCgZ+6GO/Ef2H7kzsApxDZj81KQ58NNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TRbzyqPR; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRbzyqPR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdNdTwxAQ99XiKlTj4K996Bn5vyoMnGp0uVp5f5fJRX5cycycTTRxdgk9zF6IxGbjprqRLagvGqwHONY+oWMLkYjyJqGyCElJbqD9V8ttfELpCwJT5ozo9qWU9/++Maxsy0uBRUci5Ucq6qyJmQ9MHFpBRdLOSag29umJVcoPksF4Ugx+L/UijLUJ8cQ+eqbXx8Svx1mHcU4v7MYufO9R+wS76cj8JIVrSqiN6RIxAWgrGQvN1hXCi1NFVKVb6INZLMkXwK86Zenk/qwNxt2JTW3btQYEMF0d8wSM3Dzlc+5g8kq86EnZ2vMx6Gltz3duV/QotEjY64iy0bdfdGovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk+gSaN4YBkCKyzbf9eq9uBGSCwFMuv9hiVgAeRlSxc=;
 b=fvatx7aJxGdak3mgTJj7Dkjb80Z2lq56UGdYBEAmSIDa5A/obCNX/Oz3xwpyeWh8wN042fTL6vYGCSi//mgKpg6Cxt15pFAcBmRwk9YKNSG/mzTzLuJXCvrcKE0yCD5nu9j3jyGxJW4svEGKgk2BBeMo7rD00TH0+ZgYjOKF/eJE470g3M8BxOGer1VHWcNJmmhsCVVJ6vur07sNAkFVHlPqu+hZvWUC793jCJhwLy+8uYEnYYV6jaZOh+ODAW5J6MqnjQtOhuLjBFTDJE4gvE3KnP2C7m1RKMV/CCvvlsIH9I9jothcIRc9vg5shNE7fc5B4xTVN/FBVi4/DCMItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk+gSaN4YBkCKyzbf9eq9uBGSCwFMuv9hiVgAeRlSxc=;
 b=TRbzyqPRLP4pkmGmIZJ2cI+SpvmtbmEL86z5MQCNOC3S9eWet1fGu5VwUpfa+egVhOa+XLTSEK+Oqe6VZRfQuq91CzBSh5UCmy5xLAyIcZVTVAnS8vR2WPNqbZLpYGrMxpApCXi2kT+QpsEnJ6FLSR4ONotV0uPKM0iHw/qgkJQ=
Received: from SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 04:54:18 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::76) by SN6PR05CA0026.outlook.office365.com
 (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:54:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:54:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:54:17 -0500
Received: from [10.143.197.5] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 23:54:16 -0500
Message-ID: <c6b5dee0-9b64-4a6c-aaa3-e293b6dd33b0@amd.com>
Date: Wed, 11 Mar 2026 10:24:15 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: SEV: Don't set CR8 write intercept when
 disabling AVIC for SEV-ES guests
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Naveen N Rao
	<naveen@kernel.org>
References: <20260310211841.2552361-1-seanjc@google.com>
 <20260310211841.2552361-2-seanjc@google.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20260310211841.2552361-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: d49a298b-0df8-4e1d-0e67-08de7f2a40b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|13003099007|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	zyw5KyvsZnp6f4OhrN1P0F7jVBoKJAdxiZKwQOxrhz6Jg7NrNats55Vep1NSInSJ6xfEb9Je+zbxt/qQlMmQFLoPWArxTN/oDQOH2jxLZ3eyHtSE1y8AyaaTfUmgNY2j5nQB654/mtJIxJ/S0UadFEzUy2AaxMbdxZsMfzf3LRntpymjgbGbVAkNwoRUZgg67vStHYGukmBn68GLivoADa/u+6tBZSJCAoFWBQwJ8cC7rVDcekruJ/Lx5LyG/R3B+B2BL5R8MkzbtwivUAJFhngrpiFe/Ev2T1DNojyuz9k7nEuT7kPgr9EYq52yR69dsqIQDHaL2KTUKr9+vWKSXWxBrXyTDbLPYrktziReVnIECVF4v9uMNZ04dkjpkz864fS5tAxOul++4Ocm5Eke3nzDgJEeWgFGVDK9bKQYZrVdwbbLr9f/87RZl8Mjnk+pEZZ+r1wKiwbezlkUWAVhgjhyQh9DQlbYxlnP66Q05w4D5fTtbOMGbEQ2HvadLlSjHEkvwp4w43cUO9JmC+puKGvarcfXMmjwk9xrf2cEwoxJVog2eSjasVMzbeDAMFJNYv1bLUbSaUNOlO/TU5PvppZGBDmP+qk8Q/aSfzSL3KpMfwXZwwvcIBO6a6MBbJcYD+rhHsWxrNMXtrQ6QOStTan2pmOblW5ve7GspCR62ROBS/im48vxk+FH1OTg3+nM4c+CygmBguBZzH8+rJKF8Iwx/uZLElaaKDGGh4R9lkk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(13003099007)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5p1AZa2f0Ztocgdnv08V5TkUJQ9TcdshwgVL3jvORnw+PXe4oVJsxs3GV6lEVr8rr/ZIN8McT4GzZ9ta1/V1z+ObvJHGaWlwKBKDnoGTCwyDL6fz13t/VpR88f66n6NZ92bWILcXmGrZ4TQETjQkzqFBtoxWwVDc7dVkJpeih0Mee24pCChq7jsa4gEmQ6aQm9Z7lgAH+GHxPKhSO8jFU3VbXPHgOrGoyAs7cBauifoiXd+Azs9s4n5mxOdbkgXaBXw2/Q5pZoAU7OeRlKBkp4O/H6IqW25knE8YU7bgxs3+eNRKHEFhja9h8p1E06FC/0WMqD4RALaupHAKVNJG5mIPVzl+hKqfnW66fGm7rryLrCCEf2X8X9cFgyXbJHyUBK8gFWy0k4l/QWE4wkrusqyKB7CH1SpdtiRPx6GyoSZbL8qDulusv7lAA89vp6v+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:54:18.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49a298b-0df8-4e1d-0e67-08de7f2a40b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580

On 3/11/2026 2:48 AM, Sean Christopherson wrote:
> Don't set the CR8 write intercept when disabling AVIC for SEV-ES vCPUs, as
> attempting to intercept CR8 will generate a #VC and in all likelihood kill
> the VM.
> 
> Note!  At first glance, one might think KVM's handling of CR8 write traps
> for SEV-ES is flawed, as KVM traps CR8 writes even when AVIC is enabled,
> despite the fact that hardware updates the AVIC backing page as well.  But
> KVM unconditionally inhibits AVIC for SEV-ES guests as current hardware
> apparently can't support it (see c538dc792ff7 ("KVM: SVM: Do not activate
> AVIC for SEV-enabled guest")).
> 
> However, KVM's overall handling of CR8 _is_ broken, as sync_cr8_to_lapic()
> will clobber with stale information from the unencrypted VMCB.  That issue
> will be fixed separately.
> 
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Closes: https://lore.kernel.org/all/19935696-36cf-411b-af90-aabe6a98d7e7@amd.com
> Fixes: e992bf67bcba ("KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated")
> Cc: stable@vger.kernel.org
> Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/avic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 13a4a8949aba..f7ec7914e3c4 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -226,7 +226,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>   	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
>   	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>   
> -	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> +	if (!sev_es_guest(svm->vcpu.kvm))
> +		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>   
>   	/*
>   	 * If running nested and the guest uses its own MSR bitmap, there

This fixes the SEV-ES boot issue. Thank you.
Tested-by: Srikanth Aithal <sraithal@amd.com>
