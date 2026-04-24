Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AD2C324D;
	Fri, 24 Apr 2026 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020355; cv=fail; b=q1D2YwOXqy1cFLOQcBQLxZ1N32Bso6IR3rMi0MG1ihwfYtPR0f0U8ZxqdljsLUEiwve/sITIWA75TLGj+vZcvGpoJtjN9fQaXJJEp4cQ3j6IGHvfWVWKRP81ySpBXwewNcwr3HLFDsP2XF8O2HOxCBfoCG2AC8oXmmVlvXqFhdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020355; c=relaxed/simple;
	bh=P1/yk+O2UJuIzSp0//5QHuY8AXbXrVQ3GhaP6P/+6Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lNb/DtqsUjqiFT4snyUBP/8tkibgks3tQklYhoxSBoMoY5emPgfXmLsE2SxY8KQNy2mWBgWiE5ed/joMfI1StD57AdF+JxgvXBykStOAfhLDNXQieuMMlC5flhbazxMgYN2nO3QZfb8xGLEPOzzO4SZHpfOcvFAOLdAEDpo+5sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RmR7ACaW; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RmR7ACaW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6TIewr0/XKrm5K32qNtz+XEbcSQa1yGkYE2MfsUbfJ0/OM1HxwbtOltl1EhXjedFu+hX0XsxL95ZYMYV2QVNp5b9G9paRg78aEaaq3TVZaYSuQwNtS/KUb9PCVxeCnbzi2DscVMEPPs9mDB15VsyqNUZ4RBU1Y6UN2gStI8X1K9YzM5ZC143eWu/OGcTD9jZK1dzIBp22yjL2O7B+OfnVF5ed/AHPf1uX6Wj+L6Xs+2o+n9xubAr/hucQj05Q5CY07DPKd4UEAezYjU04bonX9JOV83TYr5TEsc6OmGbnqwG4jn6g1c/mSX6pDPGVpXslqMKA9zSJWEN5agQpHi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPTxEpJljI7bLKvXtTzHtrieDNMjjaQibdCKLab8fUg=;
 b=D0zBUMUlymKc8VAV1pTEGzzNuz/xnqkHMreq6rXxdL5J3aqSzn+Ew5l4GROEbrf7ryMHGC9YXI7NN3MyOw5Wu9OC4GvRXobc5yxaClf10++F1Gjbgc43kgi2IPvrCNgOHF70bDD8gIDMEL91+gexNLwkARNqGdkoh3En2N38FBMDVPcOLaKP1IccVkN1jDfM9vcgwo70SvZpbxVW4zHItHlH31/5CXvX9H6wwULLljtyuP/bTSaijLnohMV6naUDNbCHgXJ0fQEukw3XAJipHImh23DAyElFhRRMCrWJ0qN6hFUli0ecX6/d9E7/D1t+JZ3IC1Q30daXR05x8but8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPTxEpJljI7bLKvXtTzHtrieDNMjjaQibdCKLab8fUg=;
 b=RmR7ACaWtmdpqWyfFzYllvizflEI/MDVKHPA9SYjRsyIc0Xy/JFKUGrcbnSXmqa7dRrPkjx+JCGFtVRvr/ju5WSxNU5CpfOZzz2LZF/A9IR/ZEmZ61NSnFqxNZs+5U/DxAU0b8ZD/n3Hw3rlrpeE0y6wdPFhVMNGzGJx6/H5H98=
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 08:45:51 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:5b6::4) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:45:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 24 Apr
 2026 03:45:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Apr
 2026 03:45:50 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:45:48 -0500
Message-ID: <7f27de9d-de4d-4aa2-9ce9-35b49990c894@amd.com>
Date: Fri, 24 Apr 2026 14:15:47 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to
 invoking fastpath handler
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260423162628.490962-1-seanjc@google.com>
 <20260423162628.490962-3-seanjc@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260423162628.490962-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: eea52954-b7b4-4a21-6d45-08dea1dde383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZrmwcuQ8F9PQ9VjQxEVTlTIZIfE/JiFoHmJS5p7SZ+4tOP1YoX3mfemuMYiLWFqkgpzVEjoBo0TUamtJRDNtrvjtNtcYgooyP4Vrf4lbXE40FsZigYpn4qXJlQoiICN4VvVle67Zgs35DenQy2pKwcTOcjS5LB83OhWkYUt+T0nYxVGM8LbcEZHXZnSI/6SDcPvYXipgrxqwpO8nytx8nDR0NzbZuAEcmCmYhwzqB15rAl8sTih2Pe3Y8fgY/XZQsZMyWjqSU2WXa+NfibZmMEeJWepYnjjQfLR8kS7r8pfHRiRdh7XvgJT2fBq7vj6QhIVXu6gpuQkI+QwV2TBjyhZVQFvochqPxzva5GHj1IFt6jsQa+pPrb9RXkwHSTOjNUTKgGE2Zwd0diMoSKWLy0h2tVxCLtx7cSIzlGz5flDz/M5GtDmLIJYRsO0Rk87I3w7+w1lpjkhkAIIHBfOBnJNGvEC597rrM8iuxicAuqqjNxyBvm2RPdhyamj8qKl7VHSjIJNlyFzP3T81nAWEAcW1qqwAqcKGNcNNaZ1BYa7wL5hH2g2kgO52guJgbJtr90z6V73h7jYZ5QSRqnIr8o9rYeBhMe/X9uJGz2cWY2taDp0TPpvQaxCODZPnv83/8CgwiYU94NIxvZ1NXDgL+4S0czjrUGAXpMmh8CPRMFP7GgtsO/cqN3Eu/SFc2S+DF3Mx+LANjcUKOuhN9nSaChyLomXQ5eEcq7XSb3nSOFSnIUpSJ24vEc9Vms9XKUV4zjhizHvonv/6YUEl6HFzuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XCFRePWKtWDFdGSLumdV8+6gKzvhgE9a55Gp05tuw69UXR8rQVWmWYzQlIoWeyVC1DKyARxJxKclqykryAwkYwy39a7dJkXKlAZA5Y7xsY8R8uKIlWa4wpeyFPaLlAOSSQgFzd9EMVH85P5Mx6z+cmVjJf/ZSfYGjXnPx1RTZ5yclgqapev5+5lyyhcOHzb3SqQ3yb/+GeybJ32fYWXsSQDlT9kcq3b0KA/rk+FMLZB8TeFsxY8XBWb6wT4nBegsmD1cIdcftphkW0thpcxMdmXILvh1S7ZC9+8Ghv1XKPYthEqj/cwGepQWVtlcwxVswOM/rrD/7srklrQPuBeeWYm0zDh7l2fYK9tQM2PGqcx97GDuyQljZyRBWqLDMIe8Q6nrtbHn0wlWR2xtP93dyxbeLUsQ3xDD9KilJ2DMsYcvHyan3r7wd3trh7uf0v53
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:45:50.9634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea52954-b7b4-4a21-6d45-08dea1dde383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB



On 4/23/2026 9:56 PM, Sean Christopherson wrote:
> Refresh KVM's copies of CR0 and CR3 from the VMCB prior to (potentially)
> invoking a fastpath handler to ensure that KVM doesn't consume stale
> state.  While it's unlikely KVM will ever consume CR3 or CR0.{TS,MP} in
> the fastpath, grabbing the values from the VMCB is inexpensive, i.e. the
> risk of subtle bugs far outweighs the reward of deferring reads for a
> small subset of VM-Exits.

This also keeps CR0/CR3 current during the fast-reenter loop in
vcpu_enter_guest(), which previously skipped svm_handle_exit() entirely.

> 
> Note, KVM doesn't currently consume CR3 or CR0.{TS,MP} in the fastpath,
> as KVM requires next_rip to be valid (i.e. KVM doesn't read CR3 to decode
> the instruction), CR0.MP is never consumed, and CR0.TS is only consumed by
> the full emulator.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Nikunj A. Dadhania <nikunj@amd.com>


