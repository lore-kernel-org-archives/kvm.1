Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D73750A4;
	Tue, 17 Mar 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740207; cv=fail; b=gPaJbhWJ/HCnDrhLhBIKbxNWwMWbCqJm9mGJ62KOBeU8JgFQRudPmha5ZdJPaFlMyYteHxBFbFdre0+ESbsubFCE5ltDND3cA+Y1U3X3yAWfYaIUo/uoHQheOIvcJF9TGVjKCjUm3mOaPV0thCJbbJIc6rx9MBKW4L6YTxEg6YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740207; c=relaxed/simple;
	bh=vlb8FASApXmeFSKDT2pNnTe7p8Jz+gg4x6/4wXcFIvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gb8leIamioihYN8ihhGRapFkaLbVw7bsFLS4+rOYNPv+v5cpLwu7EYX+1wG8/2Pn0L0P+kb99CJ5oNsy+0tou94BKarwjlyMgAIsZr4jjKfoY5w6wZYAOos6RRMSXF/AOH2rd69Shs2cnss3Zx7PztrSBGPKGDeQBJC5yMwA5QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DZ5Zk8F9; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DZ5Zk8F9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw0cJW05XGsCOeuAeq0C0Z9NinJ2WIxGllRT6pPhwMh/ll4JgeM32JBi44TVDlnSz+2PYHycxC62M2oiqq37MqGjMNa3dY8zRcCJLYBVN/rcltUOvun8/+ZtCmrxU2/ZPS51/AaPIk0K1bTt7K13Tt9KRVPjjoI72OZTb333oLjGAVqyyZVcnnU2HW7e9d72Drrl+1CAX5cQwncsno22mID5n0alrYebg51ZmyPEv6DURuMF0AcT0haptmavjhgs0L361j+PrI92A9opi6lO2z8blaSb5HMpmpxLuS5ptK7UY1bhEX5yonZRNkuPhlzZ3OsNy6glTMtxWxR8XzdSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjjVg7Om1fiqRdb50F0NoyynwoEbG8RDOlhcm8/hqg4=;
 b=BM92WkT0GIXE4kNiG4abxTqFheJas+v/4PtDsf+UYN+oYi6/8OEWWYF9h9d1G3Z0HulotXGqyELuG/F3wrwgG1/vJGLSyowZEQN0fMpSiZqkNKhdM24JkizrhT3XKKM90vtlVmJGT7Mu0EG+vg2lKxbGq73zRo1UysI4DALPmwDQSLUI+dtoN9ITpLFnba4i8oEXHNowGJqkmZAdwmpsyvBSDKjLayjCQg8DlCJ6pf1gLvAxsGwQVJanLkxcvq+UF1YXyTLKhmxcKphFqyU3vjJowloDd2S3WZqLlujmD//HsYcnTPprCousAc70H8zKCzDPLnILhFyzN3r0iA0mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjjVg7Om1fiqRdb50F0NoyynwoEbG8RDOlhcm8/hqg4=;
 b=DZ5Zk8F9lmbyhLnZZzfu+CfKHNQ0GdemEFqNC6oVUJOMRO60YI2RJployFina/UuLao0wNkbnC3RiLQe2/F8lrM552FNZzcahTLaOzt0zm9122Qt61y86cKKRripI/QYHg0psoqluRdxaW3QP5MTxHblyVPr46STmeTpfW1TO0s=
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 09:36:42 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::d1) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 09:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 09:36:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 04:36:41 -0500
Received: from [10.136.46.44] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 04:36:38 -0500
Message-ID: <a2fff932-b841-4805-8d82-d0d5328f19c4@amd.com>
Date: Tue, 17 Mar 2026 15:06:37 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM)
 to userspace
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <x86@kernel.org>, <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <thomas.lendacky@amd.com>, <santosh.shukla@amd.com>,
	<bp@alien8.de>
References: <20260210053511.1612505-1-nikunj@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260210053511.1612505-1-nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: f49cb7e3-b189-4584-78a0-08de8408b265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	nVoscJaJzsZynPFP4FA5VSc1d2Po+dHEeAXALCfX89t6fBK3Xdi766NX1nZs7Kgo+XXTAB7xtZAO8V38ODgErdQlarWjJ5YEFyBvulkCShsrdDtQ2/byh2Nyux8p9p1JRry9IiAT0fOOM0gkjYmCp2ejKNNdjcRPEVndSEv1BqschpnQSP9NqGdJX11MefHoH7db9Zdv0X/SBCzNsatwEU31YdGPegGNW7r1Cp3yoEfghH4EFc/jOp7WAGpEL+9cN1HDgdcWWwJHxg6GZR7v9dxFKf6YO4JXhVw53UEMF/KznwoQa9IyCWSizqtGHI2OGJVN5tELKZpUJuVvZScuGS8I4n01yhdFcZQ8mwMqw0+P990WJ2gpegQo1wJ7fu5P0HWdx2t+eD3POrIs+/9UlHGHAlsM3VxpYP/PTBCkbtJZBVrE/vfuoCngrhSEtrX8o+esossRobHLzrSJad40ErlgCmf1erFIIavdqm6vfvz5TPf66eGGtqbyzaeh5UMsSInD1OgdTmvLd3mJiTwnvasfijDnoOd1Wrbb7ohMCaRQk4GHh0SDTOXETpTB7V8aXt1sQ1jmVclyaPH70S8bVi1DHLQC4FfsohValJNLRDIOMtI0xyAcFfZZrEsacHYecE//t/5ONF8nrLTG/uBrdWw7KQkS1AZsy9XylVxjm4lwHZFKQ2Q8Zo0XmN8btErK39Y4hOB96IR7OJd4Ly5lboaym0OygB5WbUJ8+Qb3uyeTsIzl0Y4/n4sIBz1w880KHydexOY+kD+GcXBn4NyJrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gnJakSnTvvIRXMwoVUqJSNtbfhS2ymTTFpwL4XcZViFgJWQBcitYBKeKAJ+DKuculXq2vA2UuLHrtEbAoz0mZFudnn3LDW1jjm/SzmxoSKD9TKWTbB4KddIDn0LtaIS1NBiAdfQANcLI2NqFiThPXpvgilixawnAXUrne/a3jFbI2HcxoOJQ/U8Kjqq/vNjWT9N6x+F+pQFU+8Y+UXBH4HARbkG4uT2wFUy43DD8m+1u5PIRqQeQUBrzb0EgDvixttLYmqITi3EbsV4lsYEnp5PAIkTQ0zXZ23G5cYOnmYbzb7l/E6N3Twvnj7sVPJAo7DY5mJ4TeSvSz1TLXnzYruN6qk1SiGYhBmvwB4gpKZkR9pq4D5UnyyBjRJhccpB5gy19bPLfot5+eol+oYJcwbPB7yDcfhanzcDv1lCiO/nlT1R5SIzt46q1c5VlfUw7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:36:42.0312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f49cb7e3-b189-4584-78a0-08de8408b265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B


On 2/10/2026 11:05 AM, Nikunj A Dadhania wrote:
> Advertise AVX512 Bit Matrix Multiply (BMM) and Bit Reversal instructions to
> userspace via CPUID leaf 0x80000021_EAX[23]. This feature enables bit
> matrix multiply operations and bit reversal.
> 
> While at it, reorder PREFETCHI to match the bit position order in CPUID
> leaf 0x80000021_EAX for better organization.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---

A gentle reminder.

> 
> AMD64 Bit Matrix Multiply and Bit Reversal Instructions
> Publication #69192 Revision: 1.00
> Issue Date: January 2026
> 
> https://docs.amd.com/v/u/en-US/69192-PUB
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kvm/cpuid.c               | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
