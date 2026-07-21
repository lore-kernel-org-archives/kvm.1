Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7020388392
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616023; cv=fail; b=LKi1k796Oeq2ZucoNCRjU8cv6/Jb2KYcDxoRFfyKjNMb79CwTYApq5sBF0nGAt9VUb/Qv3oM9+SuAo7FSyVplwBeFiKuZxqqJBolzLcXz7jJ9Gwu/T18L1P5hJlgGtaKS9WjKj95UvyfXB41STPowuD1zj76ij1+a1oKz9H0FUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616023; c=relaxed/simple;
	bh=lUJNEN2ecdsM/heydnhc8LSsuEMDk95GS4RQUtXyrSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M9Vc28puJLSI9+MYzD6DbWpYPPXxIQhv1GZWiAmmfvQ7whKQi4lI+/s0Yv9WA2N/BtlFNId3XjlPWFqBlDiHKRe4vOeLUrbgi7Q9GGz9BdfviZEU168H3NvjkSDyPTFq3GOIfanfnde8Ts5i19kPlxRFCYHSqq7eNZoAyEId8Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qF85nmqo; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qF85nmqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rP3JjWRuCVQb6rCEXAhKXGcl8g1BK4ELPTVHTE0dI7Ppf7RPnJ9UxTujWrXkb9kUACJCetOJ6S0gg5CUfZ0Ymm4prjMOHhKFiqNCrfGHYyanLYwNoL3e7VUQJIWnMgvXAm8/kotpt8X1Mb6OPiWgfCU0wJIinXUJJ7hy2GShL2pzape60Cusw+nbPm4AeM1Auv3Oha7R4d7iCT/AyezqLvY+ekvTfwNng8YOIvRq1dEQ564nGOizFk67s/kGOHh7LGi8ucWtd2I/thelSC43OB9qztFPTbpPES4nU32tVZZ3L19BSt35PsnekvQMRuOwQ2hFyuhg7tsleMUWTWCf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8L3TpjopB02TUsuEFO5QFYXvOiSks+bHip/xJfjBmQ=;
 b=cfU8w40fik6iqtqc3iyTXP6Un+AlR1AL8/dscJZl+l1SiQQOCUvUFS1jUoORRjUUgxx6sVulMXrfatczxEjoYtzZL8OIXhUGZdZ3yowPLmrAP80i8kLnaLuwceYbadeEwAaO3LrRGYuDrdKmsIfRwp806Std4DC0QYhC8jIpfn7VZunKvdgvyxh0ezGVA6rEwy1WUwQXQrBzAW8DftjeWZNpxPfxxZ6urHb6LKSrvTJePt3QiXOHEEnMk/nlDPeHHglz65rCHsMOtElAITjWTbbJ7CnAIb9RouTeGNIb+Rvguw+o3ynlw4J/7uJwFAr2Xg2XP5+m/FqVkJXRiHQfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8L3TpjopB02TUsuEFO5QFYXvOiSks+bHip/xJfjBmQ=;
 b=qF85nmqoAnCRWcJIFrWdO7oMbSgfZ2ucAkg0HzPH5fqF7UJMDTKIax3HuscFwVq4TX/WocKz/usHyxLTIVuhMLgnX2H0DYhB2OLlAKSFpsWg2RIaFOgynehP+wiAEDMg7Ht53yGkcMHFGualEKQHmY+Ps0cU1GHZleFuPDpFoxs=
Received: from SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::32)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:40:18 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::42) by SA9P221CA0027.outlook.office365.com
 (2603:10b6:806:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Tue,
 21 Jul 2026 06:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 06:40:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 01:40:17 -0500
Received: from [10.136.37.58] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 01:40:14 -0500
Message-ID: <9dbf6e5d-c367-4caa-9506-95d9cbc74769@amd.com>
Date: Tue, 21 Jul 2026 12:10:13 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] KVM: SVM: Refactor svm_update_lbrv()
To: Shivansh Dhiman <shivansh.dhiman@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-2-shivansh.dhiman@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260721050600.87268-2-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: c596c37f-fee8-4c95-2947-08dee6f2edd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AmVPuwpv7hUye/nsYwfA4/bJ/lBadQ0ry39Qq1CugO7ELl2CKVJeYNEl1xIt9Ziz+a6knpJbzJhl3iTBZ/+Hy4LCAQQ5Bqc3CeJS0rgWB2UQdTHKA+tpblAhh2B61/0nIboLBPVtOokW6ncMu0ubDT3g4Y0lr3+JNmu24pjpw5wkO+JXvBa4ez8lIIafuasoQdFDrrJShV/ZOCoXqMq79Zj4Aw9b1l4YX3s+PKNF5ELmIOPD6o9k9hPqvmDlt2sUW8JkL1FAuIpyVrHuYtB8DTZg6hTFI6uu/tEcjGNtZmq7H5c2jdXn1y2y4t4amJojwaHaieTZenzRqDVURkZH6HgZMv8aOpPl41VyZHhxBnTaiUmkFohL+PHimI8NenJ0s8jIcU7pUXGNaksb1rItRtxZmnlC9XUNeHy9uu3YW6MFxs+0h2TwH/OSgpu8l2yWaHjf0fZjYFUsRcAGteoYlxWxWsdxNrYF7YU7TFQYdGJgFsZnTJpYQdLQvN0oEU5KkEkTcNysHXoZwAhGL5nT2QF6NaG/xx9pD9LYsuuqg+Xx9sMjHP0ipNC/HoOZ1u80iTW5S5emvCxa6p/QPWrD8Ig3Mz93xhxoUZkJ/bskNF0RwDQtOAqDoBb0aw2Mlx20wDteWnNoaIEEX6RvGpjKC+Qe+Knr1vrEapLFROkcWXNkp3ixjSzCsHj40S27u86N4IEWaS47xWiM0oxdhjcjHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vh6GVWSdRoBQsMm1o+Zu161ZH6Bkbhwxdxno6Qv3EiH4TCxv7Q/6tDXlGljrqfk10DPMEy9nP4qZwG77zIv9anKxmxGO2QzwX0yOE1h+8uUMam+FkfmEqtTIBhSGXSE4WjZ1+/FGYvja/2OyjsnIf96Z98Nb6xJyEbDqHaJI4s3Ae/U3jwEEwgmeQ3THuUKWnsRUxxMaXo1JvKKyugPlgmHpiovvjMdLu+hm6HVHZ9eFE1ZEQbGtofOQ4Fw+WOfjp6HNINOwGPAJLbgHaHk1nCo8CTeEbq0Eupyn0k8u4cTMoFsW8svPIhMKQJmn19ZCcyCGIJVF03g/ZnsQg1SqPDKtoUODjrUpEBcaoAylwF2N8eOqZLLEsFdkG2dpaqSnjluq3sWHXbNYMJdsQfjYKXJLftpaPa+1QCOjnFc8F0HMmqLgJADxD2DiR4PaVb+w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:40:17.9315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c596c37f-fee8-4c95-2947-08dee6f2edd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802



On 7/21/2026 10:35 AM, Shivansh Dhiman wrote:
> Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
> 'if' statements. Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled(),
> expose it, and use it instead of open-coding the nested LBRV check.
> 
> No functional change intended.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

