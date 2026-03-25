Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F630AD05;
	Wed, 25 Mar 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430773; cv=fail; b=Pv6cxrnkxTgKnHei1autfmK3lIt566pVnEyEO1J/bDY1xrKvGi3Cw7d1c0OwHu0C8+Rvk1Z6/0Q/rj4q9rtY4KZBtE2q9J+H44+yA+c+iIyD+uIRUvADkeSlLQYJAF4FwQE6UWiPLcFij7JAETAGygyC6UuVpTP9ccBkFfLPYRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430773; c=relaxed/simple;
	bh=FtPsuDu4vg1vEIUiWN4Wjlo9fAkpIK/M/Mnt28vZO8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h4TSJMb+YgIYzFSNWuA7RSwtQeNe7QHapMJE8lCS7n7hJVlGfWKjvi76ieEPewUgb4NhRlLQ7mO8y8XQYSAfQkDmvX9Mu4InWsqVvqNeByz5hLPRy53wWjwR0b3UjS4nVSUkth7Ihu1EfKbeKiV2e7EsZEhHfuXqTcr6lEI2baI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J1c7vPcA; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J1c7vPcA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCxIOHhb++FEo3UHSOqgd8cCvn5A9Cj9IHgOZ0HU7HspgmTtUNSKMM9tCnujBQlX/XXfnra0MpaiYv7wiI69NXkaH7aAcptZzeNscBsYWUxQTxrTRE2H2lurEYMCC7ER7XUKpXvYhoxb49VQIZ64pZHoDsO7qgWHDMJNGInCSbqGmvyIyaFRcG3o8omqRc1ACTVTds/c7mtkr6oXGVp/FdCnvhH+7fIHyu0NIoK+8dFZZ3M6CpA1js0cR2fz2SijABBl+Do2GKiv62LxPFkfx/uebF8vwRnU7k9XJo2Uq5e0KjqygXUrE2hqnKvR3KxMctb0RQ93eizxv+cw5OSZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx095k5PjhUpYyylWNVXV97RfIF+h3k6i8JDqlKKsQc=;
 b=lCxXVk8GdR8dBh1PpVFwUHnPqKsexLsSHs6rKZun2duyXitdntYmvj4gT9Frbjytx9JkM2ya/3SCnoMU5vbYd3Or+gvp9wPwDwoHw95AkuwBneGPIvBxaL4+MJNqcP5kDxjQ8mxyOaO14xiVPnGmhMx6rsCl2op5PxxK7F34SQ3sL/b7tP2qdjtyd9b4zSI7T9llLbAAv11m4qFALn8/FjLl/dTk/wfjWNRxzW26xUr7MeEJgeWEuOAH0bz/Sw7WDaRozxYR1aZBNuMMhBVBGSsq6Q3CpyD6XFZXUyqZkD0JommKGjCwqXAidmOslPEj+gnZQWBIiFcRE5b/Af5VYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx095k5PjhUpYyylWNVXV97RfIF+h3k6i8JDqlKKsQc=;
 b=J1c7vPcA5gxltJTCmNram/azztf8zGoq7VBIFhLpFAVg+C0zsGBsH7MSULWpuevzk2QVqcgpxdO++23ewaW1tGwCVtu3mdCQMOkTknOQkhLmVJ13Eg6mIF8752GGdEV1Kuju7w1VGCGjeffOiHQaVjBbmnaqBenWYM6WjkpHcwE=
Received: from IA4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::9)
 by SA1PR12MB999084.namprd12.prod.outlook.com (2603:10b6:806:4a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 09:26:07 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::33) by IA4P220CA0005.outlook.office365.com
 (2603:10b6:208:558::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 09:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 09:26:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 25 Mar
 2026 04:26:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Mar
 2026 04:26:06 -0500
Received: from [10.143.206.35] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 04:26:04 -0500
Message-ID: <ca466041-18e6-4935-aa0e-8c1501e120df@amd.com>
Date: Wed, 25 Mar 2026 14:55:57 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/22] KVM: SVM: enable GMET and set it in MMU role
To: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Amit
 Shah" <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-21-pbonzini@redhat.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260321000931.1947084-21-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SA1PR12MB999084:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bbf538-3280-47d8-6dbe-08de8a508b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LH4T1wXeKasaMqB06ocGHCdfJX+rsq6xiD85ZegpAH+H/hlz/gK2Ek6vIww1nS0ecB8AooKkRv2CEK0Ng2f3j0iOs9B583gvRLCnplgXcVGwTJ81ejFhDAcGoARRRLIEV9y9P9FpWdEDkICwHts6DGtHf5WKc9CmzHEnCowDupTbYHzZ6LQF5pxf/BbuNHXHcBQPwLIFz0atw0NPF9qW0HKrdn1lcfpjbTZ3B/bLlMkOacBDx266mTSDiXc4tYilgdnaOQf7b5Xf4ipC/g77UgK8SU6TmYlr7lUoX/Z1adWzMntNwEYs30Pawj0ihyroeLKh+0JtIThwigusDMXqAKBc+06PIlPAn+tlPgRng98zIsm5Tb0wfprdNpQ0c+les6d2PWzgW2+2YCOc48GDv/8z+e8eKTqJtM1EzTicK0DuPSQt94kBsPBORUVx1tVPq+fd7+0sY8rIBvhjADkgp9o33AR1g3WdSS5fozNbf5EjUnavGdlWLa/1U/AzBl0LI9oIvIt7rYzihYfsOW9GoGI7i/kiKdw/Maz/8tpXEC2Rht6GFukpXIXaKtiXifjyAwMbT9QGwzCMqT0AHYTYDm7S7ANstykw8PBdk8rIuUlz7bqjk8irFgQU6jFVRMzThCawthoyhgM2bGtI19iw3Y16LFrd4CALpjzKPApI75SFPyz4UfP3Kty34il1VD/mp2+gtJn7RFjuDcK/UDv2bnTtzSAfVPmEbGlANdIpGKrt9+vE8gWgZTexD5XmaxoavcOTYESbWGyz8jPotEE71Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+rhGxacDKFXlJGkpEeyE2c4lD8FN/m3YZQzkYfEM/OpdY29c4uERGJm9jw4tkfcCDzrPbrckdG0BBjRIlTqvDoFwjTuxZ13ZEIRPHHuMgDpn2z05EQvn7yDpqwWfEsaKxJIAW/GjMzzsRdh+PD/XapRLhZkYc932heTOtTrnlz+TXU4W2AOhKzi2jjOEzfMahPUofAVxJFTlylXn9Cy2p9KWPpumikuYaataZgfOmOYSBL2nztJinnbrwIg7H37srJcJtC5Q87kqh6PlxMvGQ4aD0axwtNYEO6oyAzijs7KO3kQ+xP6kgC2KQqqhJS55c5JncfBS11rWPY8HP9cW9qZrIH6h0HBeQedKgtILbnLP72JQhtE2iw5fEDY34fxnQb0v7dpxyhFS2REaGOULur/DBw3M7oUuwUJJITudJub4ApIreGVOVOK4QdhltqG1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:26:07.4886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bbf538-3280-47d8-6dbe-08de8a508b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999084



On 3/21/2026 5:39 AM, Paolo Bonzini wrote:
> @@ -1184,6 +1187,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>  		save->g_pat = vcpu->arch.pat;
>  		save->cr3 = 0;
>  	}
> +
> + if (gmet_enabled)

if (gmet_enabled && guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))

??

> + 	control->nested_ctl |= SVM_NESTED_CTL_GMET_ENABLE;
> +

