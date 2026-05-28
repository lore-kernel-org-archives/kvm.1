Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEECA15B998;
	Thu, 28 May 2026 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010751; cv=fail; b=sULw+wGsrIWYaQvUhJ9syCVAnsP3doU9vRVk02t+phn+7kYLSbBVkpahOPmwMiKs23laMlGB7TmM/+3dqULPkPCynOs1CvSaRahJNT9XLJF0K6yxBvgqlzBWDwF4V/jU40W3PTcsZDDqXZn9/MHAJ6WBiuzgp0A5YKY6AXNppXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010751; c=relaxed/simple;
	bh=s0CXPHKQsGVlDQqboSNc4f0So46jb0kMPN330DrseKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgZMGanWgGB1boUPvETyEOftF+YfLLNc0NnX1Pl/Y5/3n5ZdUmOahFdQSvPo58vYA6964L0rjUj1LCj2Zrr5HkgRrYEblP0nuVxwoMZf382Nkj6eGKOGN3KQUyFYhuIO+ckAvnr+z/UFI2BEGLHEKGrG1IrClJtdF/u30EOYlG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tWRQBo+z; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tWRQBo+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCf15c4jatadm9Gz07t2G1s1xPKyhMjCcIR0vQwSKOoEWsB6N/awmt3zNDuCXtTpk0BRhRGF99Ux5aqMBn2T/shHTLM7IfKrIbux9eq4pSvUp8DzURkmwxqm55k27eVjo1uQrtvmU7ZkXp785sPtl/LOTPFsX41dMQFB9i8bd/Oe7J12nQhZX5S3eCtriQu23NCVVf1VPfC+JXDeiwwyl+c9g7lKkmQDVwc4Og/NuIXS9zgLfPNEteJYBbZ0YCkN9NhfkC98avahD6Ax8kOL1l9j8PJmKZixo22ncUr+46jKNljuXZP3XJ13THhzYM7ZNJcPAKe/U92mQ4Vf0NQ3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbeDfuWPg+eJSt+lQl1+vmMElwX/ky4iJdp1+/V8j20=;
 b=xPHsdRRAUTbWnMTld2lA9aUCGXp81zyKa74SDsFfEkfopLK+TVWrjg2wocwXWlVt0ZSdJbP7rGmCxDxWyDDawJS/uQpjVtgs2vf6K2NdJaSP41gr51WqAheGb3xaI2TjG8YJC/VfqgsTF1OsnJT6CbLVrNtLce5WZJ9fwco4EOTiWCY5I6Ce384s7igfaJCRTaLNbatBMHIHx4oC8d6fYOLuOAmqQjpPoiNvAwsMQQjnlb+erNjNpa6geChUxfyQuu6Tg/EDdB2f/v/It/rGptiNIW8dGWap/7XF3QWzUF6leKeiSns0m0xe4CHGb1d7NiQ7S7HBl1+500iXAn7NIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbeDfuWPg+eJSt+lQl1+vmMElwX/ky4iJdp1+/V8j20=;
 b=tWRQBo+zmvSLlSBExDnCJJ3gqzEelrbCWwEitaLudLjlrxqAZnNrDa6m1bxGl08l5bGUl2exJShv/2tjplWv7aNAX71weCDoJ4Sm1zh9xldtqA7bgRpEJuE81jsT148T8CYab0htaMJj/IfayLXqlYkCIOFC++0KaN0fygWR5Xo=
Received: from CH0PR03CA0403.namprd03.prod.outlook.com (2603:10b6:610:11b::13)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 23:25:40 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::23) by CH0PR03CA0403.outlook.office365.com
 (2603:10b6:610:11b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 23:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Thu, 28 May 2026 23:25:40 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 18:25:40 -0500
Date: Thu, 28 May 2026 18:25:23 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v3 1/3] KVM: guest_memfd: Treat memslot binding
 offset+size as unsigned values
Message-ID: <evegopwgjm5imjibprosovtzxwrntsqjrapnfumlocbozh2h4h@67l75d6vvdd5>
References: <20260528021117.107984-1-seanjc@google.com>
 <20260528021117.107984-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528021117.107984-2-seanjc@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e5b541-fdee-4f57-6d9a-08debd106e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	iQ2aux+Q6w85r0Z/sZWBOFrovQB3c0/WLoWAngkuabGhbbAM5bbWG74XsZhFoVyPME5GllYWOLobBw2Ms5zbM8rTK32lZioT9OxmZTJ2/milgcGdQeVj8dNji4wdH9iKfHJH39rv6yIbty8RX817WLwES8l4LR68jUG2rELDiLFKFiDQwvTOvwnHp1TZULWrz8qA3aTjPst8bmHZVj7EXNfR+f4LnlWbzyC8knI2nTJ98Tyj6D9RRz/ivbSfPHahCyi1BXQMbQklzEzSbaXZyE8ccAWPdMYPqPVzvc/BsMWWVKtc0Lbh6nyENLBX8ECLGFwiBi/dA6qRwz9y5NNi+NTRto0U/A51nDTM6dzZrE1sZkE5BB06qzA0UImkPaJ7lnu9aA1AqZUuUOGG9n8a5PcYZfRPhtpzcOIKRDM/F56lnicsXYm9H6aHh2Fa+sVI0TNZTLjlQDDXL2uwB9glbesXQ5w7g7KyE4oxdGxXOpi4je+DhFA+7mjWDcN3N3f0NZglxczlI82vF98Od+z6x2Om7gMJOImYZ77vKqdmvFa7Mok5OykhPWRR2WFwu1qzO7FWP0sH3k02wgcBgGxs2JUGehook6E0fkigbXxOp/hTFKVnql5lYarac1ScpiOZZBdcBAHGEoFScHtzmC1yxugDug6Oihu07eOQ0qg5JP8+RTW6jsZZFwmhQ/SlZcmt+7qAlMjCPUP/kSqZyC1OJ+/0sjnp0S0ASDFFdjPH4sI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qH9faBqAT4B947FTHrdqgRsZVYRWDWONftXMSNc5oDyI9Kp/3OF69/ktlwIRMmu/4t9xLSQA0Rrm39kmAV62OXUl9SUZybRpEZRqup4vlLXP7u44AzNajuUzagTOagyVPRvlLQZRocQRwUAX7/HqGn3W4QzHxxo+oZd7KB2Xm1edJ3K8Q/Rxs0xNtZrNGw3lTNIVnHfmL/TJZBaNPM5kVxQvcdCrmDYIARYr8/GeuK42w3DpM55GNCDwphDcV36d4wr5WmkYQqqX10yXA0Ft1JRxPTAoUNcsreGpw/Pln4RrE7WkG14Wl17dQpeczaI1pYQAcHqnm73SoZNZEL73nVs0bAC5yCrSB16ettkVsCL+x2qrIGmibfmLFocaW88HgHCberGdCm0i/KXdeefwr5GIOnaR+qF4V56PoFDJbNPVTYUotGXAL9SJ4j3nZzhv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 23:25:40.5243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e5b541-fdee-4f57-6d9a-08debd106e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

On Wed, May 27, 2026 at 07:11:15PM -0700, Sean Christopherson wrote:
> When binding a memslot to a guest_memfd file, treat the offset and size as
> unsigned values to fix a bug where the sum of the two can result in a false
> negative when checking for overflow against the size of the file.  Passing
> unsigned values also avoids relying on somewhat obscure checks in other
> flows for safety, and tracks the offset and size as they are intended to be
> tracked, as unsigned values.
> 
> On 64-bit kernels, the number of pages a memslot contains and thus the size
> (and offset) of its guest_memfd binding are unsigned 64-bit values.  Taking
> the offset+size as an loff_t instead of a uoff_t inadvertently converts
> the unsigned value to a signed value if the offset and/or size is massive.
> 
> Locally storing the offset and size as signed values is benign in and of
> itself (though even that is *extremely* difficult to discern), but
> operating on their sum is not.
> 
> For the offset, KVM explicitly checks against a negative value, which might
> seem like a bug as KVM could incorrectly reject a legitimate binding, but
> that's not actually the case as KVM_CREATE_GUEST_MEMFD takes a signed value
> for its size, i.e. a would-be-negative offset is also greater than the
> maximum possible size of any guest_memfd file.
> 
> Regarding the size, while KVM lacks an explicit check for a negative value,
> i.e. seemingly has a flawed overflow check, KVM restricts the number of
> pages in a single memslot to the largest positive signed 32-bit value:
> 
>         if (id < KVM_USER_MEM_SLOTS &&
>             (mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
>                 return -EINVAL;
> 
> and so that maximum "size" will ever be is 0x7fffffff000.
> 
> The sum of the two is, however, problematic.  While the size is restricted
> by KVM's memslot logic, the offset is not, i.e. the offset is completely
> unchecked until the "offset + size > i_size_read(inode)" check.  If the
> offset is the (nearly) largest possible _positive_ value, then adding size
> to the offset can result in a signed, negative 64-bit value.  When compared
> against the size of the file (guaranteed to be positive), the negative sum
> is always smaller, and KVM incorrectly allows the absurd offset.
> 
> Opportunistically add missing includes in kvm_mm.h (instead of relying on
> its parents).
> 
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Cc: stable@vger.kernel.org
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>
