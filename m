Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510566;
	b=PMti//RBNgl4m/bAHSzkz0/3rHf5pRP4I9+liDvzUPvFwADN6QJSz1tAKMXVJDrC6VdM
	 WHfftz/v9vkmnAzJQ4323QgkGhBXDErvEctjeRD2f5A7EmhJ8t0adjzKqNrYvE7mKGMh2
	 oa7GalsGcK+Y9vVIKs9xdLRwbm2X0bHDQCkOM6cZUz/rO8NVc9gWj2WqhuMcAC43kav17
	 nIhkW/zD/kpfDim2mioeqfokwmaV44KBABzIpu0Z4jmWkO0lB7dhouaZesNr4qcP/xuTI
	 NFW+hC7NfRwsvEfM3x3gFrr3FOmI2TB91BcUotZf1A3cPEphjfFEcYmW3/SjiSLr2Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510566;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XFSgZxya8HO4gvtYG1npe4ebxBU3i3lAYKStkE/kONY=;
	b=kpe0KhOtCADFzo4IRegzhDomR9BvIYW82PURe+0Cn+b22VEe3/V6qLajKJpaEXMeo8gL
	 6de1RjWVA/O5EQ8Ko7oLm7vva23tXudP8uppXNjQIM1VdkuDRqdLjMJjMyNMbgEhPE/Vi
	 IbvSUj2GYuKN2Ox0A8N26zH38aV4GsIvhjKVKPIX5OsxRnmsBWYrTYukJJugs+w0J20Xk
	 zzwV7rissosEzgkMUD1CmTCR7FAlLnx03A2qgSEAofRSIHJnQ49zu9C8owj602mei2VWb
	 a2fe3DEDbB/buyA4rILGNgoaZQxzTeLwb7gO8YYVlXqaeD7av4Ptrex0s+kRv6erOpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gZ65cjMt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.17
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E9606A31E;
	Tue, 24 Nov 2026 08:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gZ65cjMt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTiaZLdrV+1hyvjznkAkEhDT9EL/BEmRMboqHHXvHrnyofNIVIfvygBaUe0I1fjGZVILjkiZIuYb4YEqoiDbGBRwg+TWGoPa1pCt2svvh2/FirCuxKzyf6fmoAISwiV/SYaFv5qbkg4OaRf6fPWRhOEDdzCIMGtKEAg/aF58YmGKPozhF5pr5jQwKTtRWGgLD/4/fvq3vXCSJQMgmr63631nExpK4RYyXMtSTq3CXtvEgV1j2QBUbGNDWZJxjdPGYJm4ErkdFte56Cy9XpB6JLUiOhfdCRbq/kf2clTXh5QeCYfXske6lxwT1NLh1gnwMqaKv/DRPLnFp4y27+M+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFSgZxya8HO4gvtYG1npe4ebxBU3i3lAYKStkE/kONY=;
 b=VetNYurY0KEx61YcyGHlRXxf3Ks0q7s1XNgfMBq1Dcgo2TMGKy1YN+V7IljFwpz1w9uv7U89A6GKYoV2Fpiuh5iJdoQ5LI8Fn+KZKYmCBj5hncxJ4nm0ik/PYqQ9vVppM3TFHdnSe4kpF0DkwOoTxQfCg8NGLoDRBWV2AkBXP8Bi4DdM90exCeE6Trp876joDdWMozoelZUJslURmoNmxb0MAUY/Es/cjexmtQLHzKl+oedJ3bopO1aKXbz/9mP5P+q6IpOTEZRGmvY+8dltm4ZFkM57Qs5rcUk5Eokp0G4aYL78d0KVfobo8ShX/y5NR30ozTkkAa49HK29TBAGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFSgZxya8HO4gvtYG1npe4ebxBU3i3lAYKStkE/kONY=;
 b=gZ65cjMtznvzFsnDfCQqTRzSBE3VL5vfaSouqftR/C4oetSO9Nt2oxB9uyRKClHQmaO6vwKKonsmVRxxG+0NqeVNfDDV38YZnRn8FfSkHwyYn5RG9zWaej5HTI7gbhXN+8FL8QYETuz6dkp9XgvXp/i832DyQOU1CvkzmB2tERc=
Received: from CH0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:33::26)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 08:55:44 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::14) by CH0PR08CA0021.outlook.office365.com
 (2603:10b6:610:33::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 08:55:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 08:55:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 02:55:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 02:55:12 -0600
Received: from [10.136.45.120] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 24 Nov 2026 02:55:09 -0600
Message-ID: <ffcba80a-9a75-4fcd-983e-decfc5f846f4@amd.com>
Date: Tue, 24 Nov 2026 14:25:03 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
To: Borislav Petkov <bp@alien8.de>, Ashish Kalra <Ashish.Kalra@amd.com>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
	<Srikanth.Aithal@amd.com>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
 <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c2fa03-2bbf-420a-bad8-08df4a08a794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|10067099003|261022075727099003|261026140227099003|261028144727099003|5023799004|4143699003|261022105027099003|261021121427099003|56012099006|261102123227099003|261026121527099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s5gbTJyimFszHcF88CDG7iAYWGyAQz3wpKWxvcJTacTcFmxBlNtGjOz1CKblN8KJmSkpirhNCepf26CQFxlN2LyaLwwa1WMZbax/wjEoDd2qW2ykEFwqMyjjboNB9w+Xa0FJ2QH0sUPqlQTLFXKUfNxdT2rEpmb+aGETdQ7Y+eKNRVDCDYxKXmZsz0uw3gujbZ/wyY0TOylsGNrTyySYrlxwn/GEpyrADQdrt6VXZRhO0uLrljztD750vVUKP3PPi5CrbJ3p7DrFe4b5ptcxq8uxnKQTqKUr24y4v0n91AjVaVSwKOnwGk5I7rJt2I6YCTLySlRXyPHAR4LFXYWdbMi0wpt0fStbLErcmE7j6LA9lOOZL2I3T4+zxzqTFOSjyBbOK7eIsiRzPmJPra/4q5B0HUxK7kexPF0eMx02FxvEFMWkl1rUiM8wvcmMc5FfWWcNp4dxxr06BsNPQ2Tp6zvBRo3AM5J1+31PCM9L1+0qoUsGLOlvsVKT4aGSLZVGWjuU/mYSRc1dr6UVH79VXFShvdTi7kpF3HrJaoc8PjfgJdceexDJwjDPJqf1TiYiVeR9Q654TtG6OCqlpgW/5K8C4Hq4PwF/vK6hPW8E5havdPNXhke4GPzCUxmsjmYjDpXj0xF9Kn6P04Pe95TGyJMN0piUygJacAfiG1VsQK63kg96kSBzSqHDvW0bCqokmpWuvZedzioAa+/kkdoPUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(10067099003)(261022075727099003)(261026140227099003)(261028144727099003)(5023799004)(4143699003)(261022105027099003)(261021121427099003)(56012099006)(261102123227099003)(261026121527099003)(261021123027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k9gMyk4CXoFxM66dV7IaDaYgRAhQBN/IOiYmxtJHPy2latwc3A1yH59bfAG9wgb57Ly9m4CuN4AdpSXyuYgimQGXjBwz3jDw+sszzDw+PGWDpJJdHd9RcaBMEgbAZVTZ+Q+MLNtOyrIIUAUusP4lMyCJnYL3/F1muUJtjsBOqugj6b6JYH+tXkYrVJqwDXz4NrLjFKziiTF2rJzutV0BVKkZzZ+9lV1NZPArEVfEpl/N/qsGuXrHEfErjwd/1/qO9dBVZwl2lHT+Opfm0xMXEEKc/3E9baHty+JVOa4QkqL94TpqNnuW0Gsj7w/V215CA0z6FwRjrihysBCsh/X6wGcap8IvGmybHRmjmm+edrGEUtQ1UME4LsofPpTW/J66XPx6ZRDgnwAlCE30PqlEGkJRQXUihtvJsp1PZPxXrUtYdg1sZfa9qhoWEQxzfC2C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:55:14.1206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c2fa03-2bbf-420a-bad8-08df4a08a794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

Hi Boris,

On 11/24/2026 5:13 AM, Borislav Petkov wrote:
> On Mon, Nov 16, 2026 at 11:03:35PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
>> SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
>> intercepted and delivered to the guest as a #VC exception, which must be
>> serviced through the GHCB.
>>
>> By the time machine_kexec() runs, snp_kexec_finish() (called from
>> native_machine_shutdown()) has already converted the per-CPU GHCBs and
>> the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
>> GHCB infrastructure. The DR7 write therefore raises a #VC that
>> dereferences a NULL GHCB pointer, causing a page fault and the kexec to
>> fail.
>>
>> The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
>> Fix early boot failures on SEV-ES/SNP guests"): that change makes
>> __sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
>> the previously-benign teardown-window #VC (a bogus VMGEXIT the host
>> rejected but survived) into a NULL dereference.
> 
> So, before that patch from Nikunj, __sev_get_ghcb() would return the per-CPU
> GHCBs which are not initialized. That was fine for the kexec case - I don't
> understand the bogus VMGEXIT thing - but apparently it worked there.

Before 3645eb7e3915, the DR7 write during kexec was silently dropped by the
hypervisor because the GHCB had already been converted back to private. The
guest did not notice and carried on, so kexec only worked because nothing
depended on that write.

Regards,
Nikunj

