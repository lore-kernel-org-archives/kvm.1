Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95051377AA7
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609496; cv=fail; b=CQvQ9We+Gw/BkU1Z6A+m0CZ1QhWA70YmnNHFKtHyI0vnhODczL4iEMhCJJ+mzB9sVs49/6pMXy9qfaE2HivZtn6AT3SRI5RXCBhdMAfIcbPVOXVYZicI8O72g3mkc3F8W0uqUIh42w8DCl1F+rQ1QS5cKZNOFFqR3SSehLTdlfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609496; c=relaxed/simple;
	bh=u1LjpsPIOPbyvFhHCASei/dy1LeCNPn1RsAqHUSZ8Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n7CUo5Xf/nk70+5QjuflQ9BHrfU7u+P1FA/v9d0vpr3m9CbdaPeqobTNWf+33Xd/E+/q6BHVu/RL/8/Fhs7bJRv7zt4aZyKVmbMZdFr7Fwd+YPAy1K2fJGUBRg67v6vFj4/lLNgFckonX+uE6J2ld3SeeyAXQlSLNifb9g+5BNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KRbEawub; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KRbEawub"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgjnFXjZ4eotz/zO0qLtrmsFp2txK4ZDy+GYwh0/0WrCCOpNi1qTJUo4msi9bpgmIEs1s8iqk4vNISWviOq+iB72sRJeGYx3aCuv7W1TOXDQDu222gSo2bleDRVZobxhEdH94T4ag7w2rm1nBmAtQYG+S39CTQF5DFBB4w4OvpAB54LHH+fopzRXVlW9seUYRKcpYsb0lcbmgqdmXsu4xC+jz2fBNQOSoN+kBBNaOhwyePEBm5LWvID79ilkNCI1hUnon4pg4u4AiiC/OeoFvSPoTQzEOibxMVhjZkbXyAlrhdX1GBwT1Tc2CYroLdALX+J6F5kPhYfnzrZyPaJxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIpqdqhUV+4/CJ24NW8XwfKdWio8niJt4rytzm5m7wI=;
 b=PluFb6oC1Y/6j1cpW7PzdRfNvJfzHKpymiAHeLMBh03EQ8dhcEjnlrUWJbvavsR4bqBsmVv99DfqO1ExHXoPkDji+xTzouEvRbMJfYy+tOXOQq3nQWBt/uLwnvXUxE3y5rLaGW1xlIez8op+ryqrK9qMGVBfsYon3IgEU5MgFOVG3qxFvzPPIa8zl9KkNXCEg+B+KJcgFMC6HioOI9lgptda3M7a0nM0072TrUj/+Gq3iSPmVNgUiKg+OQwraZEAjPViqtHG5JPrJewxPCFsT0S+iFZsR8rA+p6JCOTKhJqsraaAOWSQN9CHWPCMaRUoHZ9tK5+a+30LDuogp4n+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIpqdqhUV+4/CJ24NW8XwfKdWio8niJt4rytzm5m7wI=;
 b=KRbEawubO1CZ+ea7jF0e3Ejs81FhkFmolqI7fHCZIVlUqCPjy8vaCEU7XqRF/SJCRE7H3hKs2pWy4/NCUn7eN0WDzxaJ5I3RRmEyO5DUG8ujlHL/3JSWsnkOn0GOgBNodKdOvGQkaEIVPMBPtzZPGUFoMsyeQatzevxkoVbiiHg=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 08:24:51 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::4b) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 08:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 08:24:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 03:24:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 03:24:49 -0500
Received: from [10.252.195.98] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 03:24:46 -0500
Message-ID: <d3c82b96-3454-49d7-ace5-92c2331ccd2a@amd.com>
Date: Thu, 13 Aug 2026 13:54:40 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7.1] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<kai.huang@intel.com>, <kvm@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<yosry@kernel.org>
References: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com>
 <20260529063833.1660791-1-nikunj@amd.com>
 <b5f2e0a4-09c1-43d7-b700-c8760d70b195@amd.com> <an0A5lql-rinvm-n@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <an0A5lql-rinvm-n@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7a6074-86cb-4a7d-89d4-08def91457f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LmcVUT3fcFxY1hGyBCAA9KH46lX0E9pR03C8zvV25mIMb9eX9MS/A5wxBY73ON6gwTfXLRbXP6lctb+phHgrb+fMH0OjvlGpls++k2cnoFPhKzgxrJL2tNeWEjlDXpTJt8mfSt5WsC07RouzEPLW0OhfT2lx2UNLhjPzWAZrWx5Z8ZZSADoKoyor0RY2x3PUGGJUbnKsphtjm/5rngkUmxmxwDQZyFCxP8SQXJDkuDZiy+Z/JcTqdyZmGQZ2nt49sSmIP7n0kluT6hpBxYMcpAVQwIwX8MVcQLL53K8z175fQSon1VANuIiIZBKhDrDOy4Hn24eQukA7NJ179DYGCyl/ZpDWyP8JuyYEuksTDw+fpY61Nk/Q09zv8DukXn4kQhCbNUvEBUIhnjVqrNKYm0Igo04ftANoqH/e7DIsQCVhFN4Jb1yRxrhBvHVm9xQ9Yfgt30IlVZgQO5CddvTE9B4F0pHp/TtJvcFldXUELSTooAsrQItsGj7nN1qPaUKmxohSkDz+7aVgMyYJVK+UHz+Z1czxIXRrmue8ueAceQV3vEbjBNIKtd37i83rWB3X8GPr/Wpn2YW8xMMbVgUreo+H9CloFTZppToWoOEoTVjFCeS0H6P46McAtuOcbS9D1kQZ09aWaeeDWyy3JTC8BckL10NTNzY8vNLddSuVP6/F39HNrGJWK5nhjryAubpN90MX7WUhIcOxfn+jmClZOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dLktCtuga/QQ0wEy6J6ctmyBp/2PlpcOEoH3yVADAPSH/2tulBfqwDgyoR+nyotKZG+QNslIbl8t2QD5GuY0Trk9mqbMP+/vWNphzf4AhHzLTrPagPcHzKX1Yh6PEZDqj+D9po0FT9b1Tg/RfL8sJ2KkSXFnjGhs2SPtaVk1vv2gSK5oEugx8YArDr3sR7cZsVFlYYg/Bt/GTYFjnrTLIqqMMwSoxWhVMTg1YSLrNz+xn0nbn8pejDW7p5FAfWmbBlXmeY942omh6/9eGk1rwg06NjTrMMKM8gBPrS432jCzDySK3cLkI+6byheRVE8cLWQEZjOfadK4ORZp2pbbqeXcg9/fly+PfJuE6Xjcbaep8gN7Yyw3awdfpSRequR6jnnPqyEa7I/fHAu1/75O1KNHPSx0FCmmlQFgp1sMQ1J+JJ7pE1Zxu6d7cybbu03D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:24:50.3401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7a6074-86cb-4a7d-89d4-08def91457f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629

On 8/13/2026 4:55 AM, Sean Christopherson wrote:
> On Mon, Jul 13, 2026, Nikunj A. Dadhania wrote:
>>>
>>> Sending updated 7/7 patch here, rather than reposting the full series.
>>>
>>> Sean, any remaining comments? Happy to send v8 if needed.
>>
>> A gentle reminder
> 
> Sorry, I had moved this out of the TODO queue when I saw the "will fix in the
> next version", and didn't pay attention to the updated patch or to this mail.
> I.e. was waiting for v8.
> 
> Hold off on v8 for now, in case there's more to address (I'll move this back to
> my queue).

No worries, will wait for your review.

Thanks,
Nikunj

