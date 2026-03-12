Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E63537F5;
	Thu, 12 Mar 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327216; cv=fail; b=VGnDHpJwE1fJXMb60VCZDzb5fWDVyJwMt4AEVIr1ANCAqR70wN7qo89Mv1BxH9Sw8Cy1CR+5ZkgbuD7jC7P9emagpkZjn8ADk5HvfqJRegNH2kViQM6h+Gjrd92lJjo4CgNnkZLBfXTTJx2it9cSaTsmAs0kv57e5CIxLaShLVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327216; c=relaxed/simple;
	bh=LHlfyf4RlN01796cjNI0oJsO78NE5JZ1e/hC/GxNu94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sHvPArjLu3d1H1pAQXpWaVUVdEbz9flrAkmdsdwsZeWibSs4S/2+/mmFEKyaeJt/YTV66YXsSJKYPslMI3f5qDgYDbhy0X+WEvLsrRDDQ2ObKG96iFTgy1W6CN5zxqMefHCOIx3T94UT0YlxosN919hA5Fji42IMndvL8Y5Z7iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oSjzliNS; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oSjzliNS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEcVlKDHY8cS0wBX+reaa4E+3pN2JUvP2AOfwREAIFhbU95fvCHkm+ddAhCjD9RPqnSxHN1EB6xN/yN9ri13rgCzoOXRupRb1J3HxqC0CL5ZE7QTkc83JLmGcVXj12P2G5Q9RGjOmQtNrnI8MAfTvORc6oS1iZOxMXPsT22PhvIfwRkatO8ZbCvQibjr1fFUSzmxd62c7PuBAdb6drNpYiyoBe2daIZQZC2gcLF+gcuUxDef4iOU4eh1/2jikslO0rtuUT6pei7QEMNISfF7HSC6tjfA+eJ2RTbEghPkUF4CbDZ0CdhsrIVX/GpchUUabpVi3rhEi/tP5L4qHQP/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2L7tDdJ0IaT4cM9ImKsM7I/MEEppUJ677XKkmXHgvQ=;
 b=p+WTP0IQ7BoqdgYEd3czDeYqcqplCMrwGKmzYo0aOILM6T4rhQhaMYNQUqEGRGcO4hm659JzNTg+Kr123O/YTC4WIfjpFIJ4ToN0oshQ5yPOpWwajtbjZZrFo4+QaX8LHlreGf1J8QEXZsgs2DmjVQhud5MUcltIKKmfgsAEh20oSNlH6zkKHWUzkFc5e705wpwJlvAq/l9G6ceSI3OjWw1Aucp0TkJeCp6OdAOd7NQKAVqeX7xnAhjgHX/wL42fYrKR1HuP4gDbtZ4dpRk7h6ecGNXW7ubezI5MbI8qUVSV7iXquhvgJhIgV+TbrKu7UJGc98S3ygBJbCNSLANJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2L7tDdJ0IaT4cM9ImKsM7I/MEEppUJ677XKkmXHgvQ=;
 b=oSjzliNSTQ3bXG6seFS4vCNuYQzjeylC6NFul8qqm1viXbNH1dnxvT6LCkVhLFCEHR4zQRPqc0rDiQaz4zVNkjzHMjV7kBZpjY0EDZpssKBeMbys9bX9JIA6Ph7YEEGE2AqERDjFrqwCJBUpPuH62AvzwVItO+GIxLMayss5BMI=
Received: from BN0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:141::35)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 14:53:30 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::ac) by BN0PR07CA0008.outlook.office365.com
 (2603:10b6:408:141::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 14:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 14:53:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 09:53:28 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 09:53:24 -0500
Message-ID: <a078ceb4-6e31-4e8a-89d8-023b95f56054@amd.com>
Date: Thu, 12 Mar 2026 20:23:19 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b30234f-eba0-44e7-0d3e-08de80471f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/BIv1DJfvNU06Zr+Gwuo5frJONH0duIRtkYSu4r/Fiwub6rpBDCfTqeHjnu2EMo/yzOxuNHrB+SK3kEjIWL1omt5Oi0BS5quznbZHBkzBEN/53t6d0t69htgSOlBpEpg/i/MdMR0Ii6pBzU/XBHzqCYiACwbrmFjTwQn5Q3+YzvA43buDN+koq+0DCuyfMkhck3r+9o0PXWlq++CsHqERnJTpbalhSRwHN55aHZiEckQD/mJ/D7mvmzB08Iks94LZNmlwGVlHD7MYE0UGa0x6r1dAAj/shpxxnUHSNg+k/NVsEIpi+m+8FT8cE36pu/e/Gk+dnWGVr3qW8gWyCHzoF2DNKkHfHbatxCAdfn0Yp8ZjpYYHPJSruCi1idV5Yt09V0ovXxFqRcOVMOAhwqyTKuwFeCC9utdp5kQJdoDHyyLHj1Y/blMmHyW170X18NMR7zK4cyl9INc03u7xst0tsAgkdPh5H3gGdyAHt8aPb5uKOWDbLmYi6mvJSHQhJj9bRR8gcu6QirM2n370R2jtR+/44NgJQCqZWfaOIG6xosa9E0y0j8TiwfR9n5+Yi05PoBqp1orxcR9ehTqUkDGpPuHhDLV0NbXQtbpYtrakZYKFzVjpOkr4gS/4Tw6WjZjRTSbh9d9UxMJpS8j/hQgEGdx+6spxJ34GVW7GKLG7kBZW0K1faqDKNC590lY6nR0HdZWpXmkJzuUWIlidjh01EKp6+guVKp19IPpoX2duJVtk9Rt7vyLebdqZktcn8zwLTqkNG5/IlP4CXfFlUfijg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5tvyyHz5V4lrbgtQT6YFKdBsT6clwCc8mDZf+tG57mZFb708wdBlP0PIlqZ2cRYBT4QtgeU10HyGswQ8bT84aF5xSj40s/rZ6FMgImZVvbTu+xGKURHISNtykLrSCF4qj+my1xISNgxBFX2JxdeQgcSJd0wNHss0FIKjGg5/7QLq4dgr8U/2/tdmwvp2PWIwXKhpNmvto5JNkebmetyaYyjPBPNPEkv+a/WPoXA/vYv8KsUyEJ3cgDFCZJTTMBuFgJnZB9b87gkaPGTjGzUXQSUPuCK3iyVLSWEqjx8igFXzA87gSi00SEjNgdow+mF8pQMY1SI8uDQcL+B12XPJQGLAld5PZJXGpR7Q4Enh/sI9WiCt9TIQKLIKDL6ZPTGcBtjU06ZSdeMpMkaimViFOoeJ022YHSS3rx5067aw8BZgwqLRhr1hUXR/VkRXPNjK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:53:29.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b30234f-eba0-44e7-0d3e-08de80471f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385



On 3/12/2026 7:50 PM, Dave Hansen wrote:
> On 3/12/26 07:08, Nikunj A. Dadhania wrote:
>> 1) Back-porting complexity: The current issue affects kernels (6.9+) 
>>    where SEV-SNP guests fail to boot with FRED enabled. A simpler fix would
>>    be easier to backport and verify across stable branches.
> 
> The simplest fix is to disable FRED on those kernels, fwiw.

That would work, but disabling FRED means LTS users will not be able to use 
FRED with confidential computing—that's not really a fix.

This isn't just SEV-SNP. Xin Li confirmed Intel TDX has the same issue: FRED
is enabled before exception handling is ready, and #VC/#VE can't be handled on
secondary CPUs.

The initialization order is wrong for both SEV-SNP and TDX. The fixes are small
and targeted—just ensuring FRED state is set up before it's needed.

Regards,
Nikunj
