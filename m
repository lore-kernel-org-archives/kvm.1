Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B93D34AC;
	Fri, 14 Aug 2026 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676868; cv=fail; b=Tt/EriAZtvEhR5DxSw3RTa4ko4HsIXLHYRzuuea7Mt+svkgVUFEam7yrUmFDXHcUiJ13dKEcnWAwtU389XrS89ZKRxuj8nBrzMISwtEASOAqnmA+r3JfybrWJRAZm4Eovj7XwkawdV9rBGJjbk+CfBGJviDLS6DkGaqN4dN90Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676868; c=relaxed/simple;
	bh=TWeG+tHm2UHXe1sAUBfFkkKA8oL+UbkWYs5YaT9HKOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=amTVbkQtYOV6ixoSEZThMZy3vN4GCB7FM6qs4zB97LkwhBEPt/S9FDUMxBB3Nb99Gsnjf4B8/JYIM/ElEFULPrDfpq2NcxoJVmzVhx6lwGzwyVok5rTwsYXqLtGa1l2rdNlkx18EEO7Z6w+hiXDH0/k3ds9hrUEmzh407PkyGCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOZ0qhf+; arc=fail smtp.client-ip=52.101.57.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOZ0qhf+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJSLMy1gW6SQFpFsnYGfYX8UISsMRHPMjsCx8aEO5+J+ewhEgJycGDEAou8GxgBWTw12vkN5w9u41iGp7mBBmrzeLVa64kw/zqUUy1emuus+eQf8eSiYSYnY69gpItDBk8i1XMk5u53513qhHYzK19neFX+mF/OGA0ku2bvsxcMVn2L3vpsUsEPzShKMsvWpUSN8ZEAiwFuik/8fpgw+ufB7hwny9rx/jDMSEs+WgF6ie3oO00pmDD9g1LH3kyt+m6NfQZV5XFbJJGuC+4p+7SLsw5Oxxxgcnd06Fv873dvh+0OM0Una4Zid4P/bO7wJMYXUzFojl5ngCXea01Payg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJiu51ZcbJNtzcuG+pTuZmCk5KLSPlBVOXIvN3cVLzs=;
 b=cZ9quUQkU83qjK/AE5/5f0/RhH3/MJevgUZtOXaSKAEZM3PgPELJOvNFmYrAWNUhwuHBD0RWsCAPYbTQUn61ecbOprlx4uuqIYEop9sghiNmzxNJu4q5xpCTU6TZ7Ivfo2stgwvn9dJowKj1t9th4nTyiwqOe1xwUq8wVMvUrk/jZx9TyrlILU4s0NKHKReNGuvHerpTwjzja3NwcF/HWfJuGUrSQoIhUZe1Fs2Kr5jNNjX+PleqyhtTLcGL05IJ9tfrbnSIF0SvLsASUzNAqBKjimpocqycduwa5quSVZ687+Yt+Q6ufusHfyXM44/VFMovWqNIwjGsnTM9xOgnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJiu51ZcbJNtzcuG+pTuZmCk5KLSPlBVOXIvN3cVLzs=;
 b=pOZ0qhf+bHxwRgA6w32RZlbV7884LCzEXqDBI1u1DO8yj+nFabI+DEHsuPunuCFcKyNcdH1aPYN3N9SyPeqftjJSEOegnkcrmeY2g13lJNPxAoqsgs112UOK4zKvjTUjEmqSHGAxux49KdW/Sx0AvNcA5+plf0SwqnxWIzHjTyU=
Received: from CY5PR18CA0048.namprd18.prod.outlook.com (2603:10b6:930:13::33)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 03:07:40 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::1) by CY5PR18CA0048.outlook.office365.com
 (2603:10b6:930:13::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 03:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 03:07:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:07:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 22:07:39 -0500
Received: from [10.85.32.230] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 22:07:35 -0500
Message-ID: <4f58be1f-74de-411b-9aac-896ad7af57ee@amd.com>
Date: Fri, 14 Aug 2026 08:37:29 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
To: Sean Christopherson <seanjc@google.com>
CC: Shivansh Dhiman <shivansh.dhiman@amd.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <xin@zytor.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com>
 <aauJ80pZrw_SfF31@google.com> <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
 <an0BbcxUNRKqnUSJ@google.com> <fede3476-5c56-4cee-b0a9-2e89e5a334ae@amd.com>
 <an5XdrvIoMKreMLp@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <an5XdrvIoMKreMLp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0b270c-30ae-48d9-dd6c-08def9b1332b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|376014|1800799024|82310400026|13003099007|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SBKCuRwkscvuVjXdkmhlMoFzzSBY1r1/Utp8ZrxVedWLFUZE9eRXE7SYMDbhP3vsxKDxgV/sjytu9IEjWyq2huRX4pvOv3/vWRHWHd+OO7b03sgALlTbXkMQ63db8IlqEWlxWpGkiJLNcA+xgxXQUUW9q0GJE8MjkpTcH+HQNysDiqNAFClihxdvxiR5jM6u+RtNRA1pdjuxX6/RQ532LldNX3NVzQz8Idm/viq13zotoDY2jIYFUOfG/pnTfHxI29sBEPchQ9YjmYh7pYMC3ia4D3Hbgi8gQnVXKAGrTZNH97m52BPSYm9WEj3yc3roDfjpVxiUrMlnL451DgOfANpr99xMi7TvxUFudOFBoAwFvB3VDlMCgC5OCswesSDTyGEx87rFFKK9M8E9osVz98fXB7kIOknsoXb+eE1KqehIdDLn4DQ6U7irCe4RmW3aMbNJakbvWODq2hDt0jTJL/sOq0Xu0MBueojAmvYLFPDx06SC0bWFPbpurHKYqXe1HONQ1RV1hLLMKNXiw8KNNsEHZlsV00lruEEetfrlVA5gpltlR7Vea68QcAQKHmqxpyEMU3vR1m6QPKhH8QCiiFXRiDB3RO6Ni7F0yvWowVCxiltSAf3G2cp1yDmfCLv739SFpg4ZgbSZwt18nbVRGH68mT0jVo1fokL5vHYhs9/77eaqsHgh3LgDvNL+dc1L96PG8iy36m9LKNecha1nCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iyD3Q3Ab3TTMcsry5b4wxHzAfJTBbpkCo43IQST/y7ZgCm1WIpMV0RS8UIPqHAgrFUDKYRWjRPc16j2qtjYy+nMijl5jZwCQl5LjG4p9p8sQ/JIDNu/9i4+Nfm1qopONQN1fxVT/DA6Lj2UTdb/8QaJ+4LNr1SDdsVRnSlRUYGjvBDG5uXOOxiECGOIkgLTz9Z1+4llFhtwy8kJyxN3jqP7I0Fdrxaf8WSjz/AA+TmYbMBoRioHPEBEYTTg63oMWW0CqYLuBCo6kNLbk2aGxl8G1oE2yyXbwFhGkw0NdbHsiAlbp6ERjkScx4GgvHQwoKFS2auigFQHlprGS74rP+paF6OOwxLkveFOm7vwZfM7zQkUD/qta0EyPevN+xYNMWMRF4/56WZoIx6Vtq7O7YJ9isdchuXWB6gG+L/IZ7U68ODkruZ91hthn44k/lDjt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:07:39.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0b270c-30ae-48d9-dd6c-08def9b1332b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301



On 8/14/2026 5:17 AM, Sean Christopherson wrote:
> On Thu, Aug 13, 2026, Nikunj A. Dadhania wrote:
>> On 8/13/2026 4:57 AM, Sean Christopherson wrote:
>>> On Mon, Aug 10, 2026, Shivansh Dhiman wrote:
>>>> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
>>>> while setting intercepts? Or is there a better way to deal with this?
>>>
>>> Take a hard dependency on an upcoming APM update that states the control area
>>> is valid after shutdown, and rework KVM to not clobber control fields on shutdown
>>> interception.
>>
>> AMD APM 3.45 [1] is now publicly available and has the updated wording:
>>
>>     "After an intercepted shutdown, the VMCB control area is valid (with
>>      the exception of offsets 60h, 61h, and 68h) and the VMCB state save
>>      area is undefined."
> 
> Very tangential side topic: are combined versions (all five volumes in one PDF)
> of the APM available?  	Having to open five different PDFs to find information
> is a pain in the rear, especially since I can never remember what's in which
> volume.  I can manually splice the PDFs together, but that's far from ideal.

Yes, combined version (Vol 1-5) is available here:

  https://docs.amd.com/v/u/en-US/40332_4.10_APM_Vol1-5

Regards,
Nikunj


