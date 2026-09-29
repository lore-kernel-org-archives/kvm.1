Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CF30D3ED
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790659661; cv=fail; b=jEs1t82sB3JSpcQPgVfhgCEBmsksa7MZWHvEL6ermZGu7AiydVE5IoqBD810toHDXwx+ZUh2lReGsrAQ6AGRxtIK2fR0mzGN/BWgPvD4YN4wE6XTOki35eTx6BcZVofrKYMyVR4WdnzezU74jge0q7EPJuXF7rr2+IzvJB+ixzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790659661; c=relaxed/simple;
	bh=Tj8g072UYyky8ZWO7ECzbd/32kJQEqWwKDEIWUv5kLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R5Ni6EStOIvMEFIymsbu9veZv5Ev8qoEzt/pf8jydA+LTHGCAo4ng1bOByU2+VDVBrUYrbtoxDel3GHlde7jqE0kAfsk626BX1Z2Wh+mZx9hT8a6nxZaDr4uQ+2jiZAzQrHUSl7lD8c9ntO2KXAMZz7jhDBkMINyWS8+KPSBhC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WwyApyMz; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WwyApyMz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh90od+ZV/d3eVKWa68ehobA7nKeFfnYHPmApruafUYZsr5rD4R20P1QcGKpgnXaVQYAY+I0FMJQWiYAOfhr4rO3QIlWV9klm3AfMY8L388i4TD7smGkihwPavO4zSINKJqvEG88sBPBpIr7ZhL/D0/vKbWRYw4Us7NB7bAYrNdMFjzVkuNWA7E8mEQv3je9s9DIurTmBunujQLiPtPsqQyv3ywCpjfiigOoIykDJSGGU9Lss4Eb+1lENEzv7/3MOhlJOF8IIkWqVL213ByyF+V8JQ4d9s19DXDFYoU92BWfkjyYwCIH9wtR8FsxbdqlXp7m8pyTqkYn1vkUg/cc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml1BCJ8siQqAM/Jk6GrnXi6sKudyWKysOEKmkro/v88=;
 b=jdxYuoNHRg4rYKGLpcBCzqQEWyGkzOH97QWVfnSF1k3bs94eaoRKihLF6I9K0IoCI2foKnR5rb+PEGGr8WqTO7185Vl/86+j57TprOafNuvSQV1bWE1TFUehFNKyxlBV276KRaev2NMHo256EDgnMDm7LKMS9kIUMDQ5pJra0QoNdt9kDSmY5iOg12dgxbtG3TtRjaVTDKZkjOlecib9i1GUmy7brmkPOkjnqx6ZZOGWkmByfVMj4TRoBjQm1iIkxaHMNnFdy5PWCpGU8vp+ozXanR/uFivT6JVEU7RvWdWnfSgf1xzyPfwL3D9yHFlVqjPiXcM8FPGwGB6l6T24iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml1BCJ8siQqAM/Jk6GrnXi6sKudyWKysOEKmkro/v88=;
 b=WwyApyMzCzkOSmASxLr0pOS2cSq4a/yya2NhJzIWKKhiH0X60vvCIiVJsf4/JfnNWe5txDjwqBy3kA7utG6RRptQjNst5pMHog22xIZG05OfvsgYZgkE6kR8UQHxr5AJHb0IBaH7ZebUZRsYKL2006He1gBgAQ1YMjVVTn1UPmA=
Received: from SJ0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:a03:39e::32)
 by DS6PR12MB500340.namprd12.prod.outlook.com (2603:10b6:8:52c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 05:27:36 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::96) by SJ0PR03CA0297.outlook.office365.com
 (2603:10b6:a03:39e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 05:27:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 05:27:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 00:27:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 00:27:35 -0500
Received: from [10.136.46.160] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 00:27:32 -0500
Message-ID: <7911fb0b-5b8a-4a4d-8495-e82555fa0fd1@amd.com>
Date: Tue, 29 Sep 2026 10:57:26 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] KVM: SVM: Add Page Modification Logging (PML)
 support
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<kai.huang@intel.com>, <yosry@kernel.org>, <kvm@vger.kernel.org>
References: <20260907063906.1964557-1-nikunj@amd.com>
Content-Language: en-US
From: Nikunj A Dadhania <nikunj@amd.com>
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DS6PR12MB500340:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f58322-3226-42e2-e209-08df1dea5f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	56Xc92Z3eXub9JcuB7Z5uFSc54PWilpYs4V8yM50tbaT5prrSZ0yFZEZWDP2+2WQQ5Xs8pNrLLPzvOOHdyq4eHhHKYUGLxLhoZwF3yx9CkERSMpGvrgi2HFAKzcDVgXDa1bCbjklp+cKYi5CfOgGwSrymgJX0cez42o56/kgmXQRiXLh04Ye8orRuYb7wtgvebEwJ/ya/nlPZ/orfCcady5WBCF9/QYLsZS950ToQN8AW56OczGI+Kn97zd+0an4LcKjnWDE3IE4RFqZWMcFDY5CPCaz8lK2SFkvTgdcMSprAUGInD2/uEBfMI2hCef+Wipf5HMgm8E+08HzxDZEdaomEmp+0e1nQH6ofINvojk4eOAiEARYAk0Hm+u9o4VF4Y3yaCA/LE7s1LO+6K4aREtlBCTYy7IW4EbjK/QJb5SJ8bclxNCD8PxlQiGaKNhEqtL551p93D3WI89o9q8h1rUddO9QdFdStiWYju1tquHkra6b16wD+6DgDz4VtmWKEoARdViJOQpbfuVcwZcVF3mrCi8yKVnUMK2Oec+zjZM9cmjENWQQZZ4TQsmuy5EaYXdLEu9FqCV9WfxgDPMJ8j9W/OhtWWnP6rnnGKM197j4O5PThngMit4XOqzMplocx2plIEFyhRUm+sTaDsKkXIEwZEfCjRYwpvX3cNLgaWMyujZvzMATJDOIyx40P1LyKL0Vil7Ia+nPcbyYmEqhgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bfzWTYEU5LYnHTQNKXrZTcRyotBCnD6PtaBl2D+kLiekDZv5UMWKJVF3TNsilOq6sgInGq0iEaveaLAUQbN6OSmCuR4smF/Y7WmXP4aG51oFytBQ8Wt5lUgCp+UP7dLrM1BS5eEfh9AxKkZeYkTA9+o8qSzTsP+rXe9Ygh25Z+X0wpq085VeVTIFrIgFRocDj2bHfzvNy5QvbHLpYuOStdq9P2jUkqcdZkz3enXXssUfhSRxQlh+PKX8LKiC5VcW2AFLR9sEmbeUYtutWGSvLjescTmZ8LXf8nmsuBMr09QDX99t2V6yRZnmNGvxcTjA03FPa9Xme5o9EBNcj1+vhmjVnBleADtLnSBf+mJLcWftIwfC5C8bXOmq7eoSbUwH6jXgl6YohNhUx4iRzf5IW1eOHXwvKCK/n7oblwIvmtjxwOJVnAp1VF4e6D00x8od
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 05:27:36.3717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f58322-3226-42e2-e209-08df1dea5f19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB500340

On 9/7/2026 12:08 PM, Nikunj A Dadhania wrote:
> This series implements Page Modification Logging (PML) for guests on select
> AMD Zen6 and later processors, bringing hardware-assisted dirty logging
> support. PML is designed to track guest modified memory pages. PML enables the> hypervisor to identify which pages in a guest's memory have been modified
> since the last checkpoint or during live migration. More details can be
> found in the latest AMD APM Volume 2 (System Programming), section
> "15.25.15 Page Modification Logging".
> 
> The PML feature uses two new VMCB fields (PML_ADDR and PML_INDEX) and
> generates a VMEXIT when the 4KB log buffer becomes full.
> 
> The feature is enabled by default when hardware support is detected and can
> be disabled via the 'pml' module parameter.
> 
> Changelog:
> v8:
> * Rebased on latest kvm/next
> * Drop redundant pml_addr=0 in nested_vmcb02_prepare_control() (Yosry)
> * Fix misleading comment, pml_index=-1 is hardening not stale-data
>   cleanup (Yosry, Sean)
> * Route nested SVM_EXIT_PML_FULL to KVM and treat it as unexpected
>   exit (Sean)
> * Refactor update_cpu_dirty_logging() to common code as a separate
>   pre-patch (Sean)
> 

Hi Sean,

A gentle ping on this series. Is there anything else you would like me
to change, or does this look reasonable for v7.4?

Regards,
Nikunj

