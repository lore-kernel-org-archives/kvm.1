Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF926AC3
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171133; cv=fail; b=pvJkSdQaEQYW+qMRoTeg26LD0sJBJlNXJ3lx1i/doKtYU06wzvpmbbtZYlT6Sb+aKtiudtXPl7jJMFLe8BbD/iSeHMvD7tGRFMYzle1OS4Bkkk8JplOMdQAuim3beqHzmw6fQlqqd0qyctwgH37gGfABD2FtHP9UL4j0zbXu0/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171133; c=relaxed/simple;
	bh=XL+3zlPHFRDDkOj2Dn0NBHosaekbZHlKx/lttHCvLz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oaFl7u+KVUugxirGbonTbB4EUDWY9ujjzQc57eR667ku/bymx8qVB7KIDhUnJHjJtikMAjKWZz64UKetB+57teK3pVNdthIuDFgtx9DC+mBKXWSyCxiLRsgZJvbciXqQcpbM1yKk7nMDlwYz0iu2mt02H0AlIbd/n2BU7V90RMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2WfXG9Vk; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2WfXG9Vk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJbj/k1g1QU2kItbOvVkbXDxmjfIOOrTvGB5FSf+M0q6mSmH/nEJoYy8ay+zPJk2mymbSP2eim7k8GQhGRbXpyDH+7HNpKDSWnp/bT+qoVzf0w8tXuVBwVruI36NKEJ80jwHNPeS6R38qj0CBLtvMluSTiEs6B3IY3CEuYkp3qDAujy53DsnAYADMiJd0B8WZsFrx0mTvGyuDcnwSQaBDV4dfgeV9BUXizfFS+oZ6gPTllxDQykN6I3SbgfdUxHoJ220t4FjydIZoC1sI2CvpoOCJNB/u07UTuLaylOqQB2CGkVFqLeGu/Ew6CmqO7DE7xplLt/HapMd+1y8DJ9iHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzFEZg14z8dSRL2QsSH0kkf669DKrVi88/IETHuHoi8=;
 b=cKtWIYAj2ehKbOqVh+Hfng2a3v7HGuhzC+lXg4mE+FhFGsgPCZCEJ5+2i13MeeklVDP3rEnL5TbufGZT/PK6Uj3cZ84a1YhNPRA/IWZUr8Y4xFcp5hq1cCL7Ik/ey+mPs9JJkti+tYWEzgdvOMBTh/9n0aD/Vp10bjzCRLD3RvmIePeH36NNQE/tf0wh0Vrs2BMBeOlGItSJUFh+JkrFMoKGxgOtBF1pk9nhJ5qVgSQ0W7usrMzgBF3+mKtoFyyMfY/5QqLK+rP/XS+352k3CHVUGIBIkZu4TX0BdivagJEi5Lg/iLseIFfbh4BW9wuRnkuXJ0DRZbFWg/teW1batA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzFEZg14z8dSRL2QsSH0kkf669DKrVi88/IETHuHoi8=;
 b=2WfXG9VkceqeFEX669q9pwjYR37fOn1sD7edIwDxGX8wRFq7SLxpYG8ms/sEd3q389cufghJogalYtGppcqOfT+ayttRmZYJytO4xS1Y27l9PKynJM2sbZL5q0oktMY8xuVQj9OPzrWV80RKDmMa2csfUkf9IcECeeXHSZmgkIk=
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 03:32:04 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::3e) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 03:32:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 03:32:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 22:32:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 22:32:03 -0500
Received: from [10.85.41.217] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 22:32:01 -0500
Message-ID: <ff3c9735-e95b-447e-bd04-b87217b10f9d@amd.com>
Date: Mon, 5 Oct 2026 09:01:59 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] KVM: SVM: Add Page Modification Logging (PML)
 support
To: Sean Christopherson <seanjc@google.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>, <bp@alien8.de>, <pankaj.gupta@amd.com>
CC: <thomas.lendacky@amd.com>, <joao.m.martins@oracle.com>,
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>
References: <20260907063906.1964557-1-nikunj@amd.com>
 <179097502898.4082124.6984085314381773615.b4-ty@b4>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <179097502898.4082124.6984085314381773615.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: b78a5d20-9b11-4c87-a201-08df229139d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1W0r/PJug2N1lVppFXm1D4BVwfNxf6y25D/uyiwWyHuGyoTVuxlonBcG4oZsUaHFZwqXlWOZahEMC/apPfNese7L6/eO2QVjUILR42/iT8KCZFPWfkQb7GI9ADhDr9zkLqtk3r6drd5aSnSEGjel7FTit6CK6T3lDBU9/mk2XAqDRYY0L2dF6+AEYd4ogGWBtZJ44q4V5X2qAu5HGwImCl+RbX5DCjkfFc3V1/vFP2Mm88k3bk+B8yeT0i+jSVWtm+4Jk2zR0vKOJ+1gfQptOj7QJXCdyUumUS4euoIDV2ydJOGnRJlff0QCYl7/0AUa7gZc4bQ36qIxX25ZI4wuOmIC7P2liWTqN1qJFHKMI/8ZfrM+FFhth+3739NKV5fgXcD9BHOj1+EXljjWyh7PrFKmFuKm+s5U7kw1G12SaOp6yDahNgduCgiK19rtrdaKNpjVjaXaCy1aoVrc2JXt79oP+ENN7YOXLC8/hJwUy753RHQFWn2zdiI8Rr/fw1B+BjN+1Nb28++bRdxGjtLmdPFValc9krR/XtG1qq8nHauabyC+DM1rvMCsHLbnxEsBBKjZDx01VyZG/1rt36qAA+Uy5zlpQCSLNHPbYe6HArc4qYxr5TV1FQ5pRkSuwywYI/48DwxG/UbRxNOee0iDJtcP93Wu6+l+N5ZM++jHXHB6D00Dq0i6GCJDvavZ6IKAdYwwVO0NRqBP9Wze6zedjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1ahiBGm7FB6Qy+15EumVg2lp/NDZyEzeKnDBtsqL57oOckZ+0gJKKno/aFD7QgE9tOVi1Y35Tdv7aQW0lirzeJxk8WR/+cHDcZG71P6hb+IXvg9cgjRKzVtAQMb+m5kALqQarjS6b+paKuFgEZEeosh3LwzKGCn0oG1fuiv69lv1Dog1u6UQD1Oi5Y5ZKRogEuGfL4fERAh+t5DgkRGw9P0/fYUR7lZlCjE3kcxMgTYn9nMcc4MG15f3aRui/3SFCqyo0ahHvT4p+VkN52IDkSES1XGaqN4GQ+xnioE2ELtWFbqwGqt2RE954S/oCcqP6UjzMgBD4SS54Yzzs1okI76Cc7N3B5WvmSjZTbrpbUIazpX4ZufqBtHbMaX6Qx/+dtF7gnGPLl+kbgJYYbC6evveEquZTKEa8aLSCOa61Gh3WQo/1kjrGdmLcMVQGvGX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 03:32:04.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a5d20-9b11-4c87-a201-08df229139d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758



On 10/3/2026 2:37 AM, Sean Christopherson wrote:
> On Mon, 07 Sep 2026 06:38:58 +0000, Nikunj A Dadhania wrote:
>> This series implements Page Modification Logging (PML) for guests on select
>> AMD Zen6 and later processors, bringing hardware-assisted dirty logging
>> support. PML is designed to track guest modified memory pages. PML enables the
>> hypervisor to identify which pages in a guest's memory have been modified
>> since the last checkpoint or during live migration. More details can be
>> found in the latest AMD APM Volume 2 (System Programming), section
>> "15.25.15 Page Modification Logging".
>>
>> [...]
> 
> Applied to kvm-x86 misc, thanks!

Thanks Sean for picking this up, and for the review through the series.

Thanks to Kai, Yosry, Boris and Pankaj for the reviews.

Regards,
Nikunj
