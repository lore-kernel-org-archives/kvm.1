Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB642F39B5
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224235; cv=fail; b=aua53o7q0ZHCvTLFStRPuM6L4zhovIwsAG8+GHgpDJFiUQb3AEGDKjB/LHIc0AdHmOkepOhacDYCSoHdV4gYJWIkvYIleSZIaVfxZ/HI6JnmvBvwlS5S6zBou+SkPsp7F3XtAFxGiF7SheiRuWDZCssXp2rYsfH6NCmkZKTsxOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224235; c=relaxed/simple;
	bh=Ua4FzgwDyZ2UgnVKhsXDnkYpJ5I4qphNLYp6mG+HzJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o1we8Muyzp5vWW+R/4dYEJIjR7zy+ZBSbzIt6sRu35GR7bOuvHdktbNyZhyz26AJHNOv/ACFNEqfTiMPIynUl92yUJkLrxwBwuyS9TIy5XLjxg47w4kRfaMkbx/sTLAmb7BTkTBoGb2jT8iayWqDFywvIaBA1gEHhIb1axhYN28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cpdTi+op; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cpdTi+op"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llWv+sWEHQJKaaz1GNcxqsp8zujGnMmCeq/AQXVwBEa5D5GUc5HEKUKq1bWfOtrb/j4mn/4itlrTqdkiPJNu7P12WI87dss3fNyopaUxP15k7vOGXQqT52QqO+icPlSi5x47WpvYXvSRdUuVaLhqDgmm1SaAHflzcT5jyrdpzc5EwsQlfO4oqN6oc5DhEh3XpFoHShYR9YCpsnC+3iKCZVZ00Kxz9eNafWWiBRmya0uGXhPbE+A2YDXVofUrjJyPPnJEJ+dGq58IOJzOnT9QGHlTe5k4nc3pLPzV9DP+vxQNsA8BGPmj5na/7s8v74qyDWRuY9PoqS0yB6kC4xBVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYz5RC/aqEzYKHPv0llBxyf50VYvu4ca04cdqqpv8/o=;
 b=YVq1Dn1oDZ2no7K2B7027xmrGq1cr81Wfnr/Hia8WWCsxv7amoOicsgL2SKTRVKeLZpfOjXNTc0ZhMN6XiDUHRB5TjZiYxney1+8jJCvfsJLKd615Gem0Q1M9pGnrxZxEXwUorlZZI9nDPaRqzOt/kB4QRHf64iwc3leulUPF84KMUxuwYWgA51DCbSrbaWn8U/HuwNA/cMtV+IEGktJAzahDkGsZNRDW2Yi664Y4pSHIq7CmElg2nfY6op7xCka2QfjPuebgeNMtJ9Q22IgVQyn7fhdFRP+j8l5Cy3Y1j6o5vKJyTyXfOt6M4+BLbXN1mNF1UvttfiMWVEU6GJPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYz5RC/aqEzYKHPv0llBxyf50VYvu4ca04cdqqpv8/o=;
 b=cpdTi+op7fKUBt1YAM13xyXOiMV32Cvnc+xuX7eyJAgPX4uELzMS9NTGDQrS5Vnr2N4yl7iRnhsZ87IXjwMQgfc1n0dPvqJEMp7X6PYnGkOhzMJDP4C+njUXF3QTHDVn7wNH3rApAXixLQx+ntVrea+r26ARbxVA7wF2qrCawsQ=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 18:17:08 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::30) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 18:17:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Mon, 5 Oct 2026 18:17:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 13:17:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 13:17:07 -0500
Received: from [192.168.1.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 13:17:04 -0500
Message-ID: <533a53d3-cd7c-498f-8f5f-c22774fc1e58@amd.com>
Date: Mon, 5 Oct 2026 23:46:57 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB on
 shutdown intercept
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260824131824.6040-1-shivansh.dhiman@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260824131824.6040-1-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: be36e270-fc05-411d-9456-08df230cde61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2f5U3gD5BMpcNImIJdXF272044CCEv9XuODMN/Tq5QxytsfgmaAr+ZKfZyrWBhhmmFeeTR1JSVjuFG57EGObE8lsbg0xcMbB5Cv1jFOrIPTjll5R5EfMGDQLYFxYI0x1G7wdmZ11jA/2LD8Tk7zaRXD7cersIetBxUozXGa4LerIpV4VlhkIz/Ng7GTFTuVCjKglECPo6FyCRQjjqO1kKr+Qxm0JAj0Ng4AsBVZQfnGdHbiVJeYSH9lKwlJgDi1szAU2NLN7rgof+n5Kr4C5kEXys5Jv2aJBcj33KDSrhF5e8R6TCwZeLfnrN/PT2e1cVy8pDKRCnzRWObbrtlCOJN3iPHN8fBUMol9q/Dk7nzr8aG5B7STTD61+Gk1SecFGRh3BGdGga9dCGhByVPtuICKWDv5qkCWGRGHorC9y7maQ7+TYWkQmbtB2RUm1mk8wpRJC+4LbMwqzXYjF8qtR0mIAxbXUYDhu1cFQDR/rlAb4B83T8z09wyRY2+2ajfIbq6k26NGFpRYQ8UleMWwVxqeibBCKGFJfmhAHiQKfy2vuKfpnQEOianRp7IVIucMRA1bZXIq/kQ1lBkSH/voRa4aM3hXHvRauufrXgS+16aDAFcoCVRYEUnB2/1pDqsJ9xP4+3g+wuQoqXtdkvDNUf6CkEE/MPCdGNkONc0SLvXjwgXJixTM1jYh6jHbyJKapI6vHQCRC5eJLoKhITxH62g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K4bmDtldULXMvoFJqmGuHlT6gVuBW0/Y2jF5H/lehf4SSwFTfF1QccA7H54y8AD4Fna5MwjKiqCOD1PSCQ9HBy17499CXvcCUmoTSgK4reSZkq1wYboh/Bx2yduqaR9/VO9YrOfY93SKO48mUdPDoykX8mnyYCgXh0FBRZSb8+6BpngkH7DeZTb8yNfeFaoOJOKjxEVE4U4VHenDemy7PRX/4375ZRIPb42bFoYSUYdX42Rx4a7wERdBCK/6IXdBLpowiZtHCnkWVdA+bU1f7ei7VJSGsc+4MaSXDt+UH07OB6r3n1zmMgrFJR4vN0QouW3LIlGZPOHUo4oSUN9SoFqhvgfOlGSg/aP3BYKZj2EE19C3qGDhXW7+103ZvvQktJ6x9YXVHbO+AFykV/Dw2gZlaXZ28re2KraPvN1DtlGOTJzkfROu7oiBXXLOoInF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:17:08.6162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be36e270-fc05-411d-9456-08df230cde61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053



On 24-08-26 18:48, Shivansh Dhiman wrote:
> The AMD APM previously stated that after an intercepted shutdown, the
> entire VMCB state is undefined. In practice, only the save area is
> undefined and most of the control area remains valid. Revision 3.45 of
> the APM now makes this explicit:
> 
>   "After an intercepted shutdown, the VMCB control area is valid (with
>    the exception of offsets 60h, 61h, and 68h) and the VMCB state save
>    area is undefined."
> 
> KVM zeroes the entire VMCB before INITing the vCPU based on the old
> wording, discarding control area state that hardware preserves.
> 
> Clear only the save area and the three undefined control area fields
> (int_ctl[15:0] and int_state) in line with the updated APM.

Hi,

Gentle ping for reviewing/merging this patch for VMCB save area
clearing on a shutdown intercept. Would appreciate any feedback or
guidance on next steps.

Thanks,
Shivansh
