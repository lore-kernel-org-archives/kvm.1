Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794775234;
	b=YqoWu4dUiQYe+9vAzc65tS/Ej91Tej67FnPvjZd2g8/ujIYUlOKRWln1mwI96jMBtXRQ
	 pfmdKSj67ct9w1WyGHTykp5dNifeISVpc84KaCkFe93i67K6FFmwr4W7/bfBM3ExVG9Fo
	 0FdBykf6mGR7LWgrOUZ3BnK+shLGJdTm2mMzQ/fkteizBEK33wDd++ZmszGSUKshm9mFa
	 rnZAyYiuDnGsMkGO+MF8+i/woiq0IElt6LIaPULzVJx0Ne3VU76+C+z7rgULHU6txNYkz
	 G4E5e+JkyedrdrCv/srysort9oo4iPWCmtUAtL4wt4yF9qjYJbWpOI0E5v8keuYLqBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775234;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=Sah+R2l03bgIr/ugBF/Acr3NWAMg9rQSyYUcFpRV2uQ=;
	b=UGmfo5B5aDpJ02KRI39AvTvnxeNJQv73TOqbSwyBPJOtHVrd0M6skXYRrkECESL4Tunn
	 KIwIKhNxIyU7nObWq2W0FeRH87dceOYYkjazMDKvYRJaDDDI+ZS+UDv2G6evkriYws0QQ
	 RoDFqpzwCgTbRc6mU1pp9CXvrasC8KGWX/2Hplaxclg2G94KX1ZitPIOK+FrnVrhc+5x4
	 K5wgeK8goMmv3oidGN7JvcR5czQRQjhzE9PXiS+W/gdWz/TCyNfAIO+xRA2WpNuaf2Rtf
	 qkbTs/YYUXfpSkjXZ7V3cG8BwN03zqyAW9uBQw0hGAfGFgQ/5z8VmvrgsnlZdZnADkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nc4VUYQ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.33
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE475606A329;
	Sun, 15 Nov 2026 20:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE475606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nc4VUYQ6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krxJXSGrTBnGVNDrZfaxxiHdT8sam7aN6DwkZqMLYfn8JWYdUJxvkOZZjaT/oWvbz6X8W3yFIGDVkaYBnnl+fY9AEekIi5uJlePhKN/2z1gnt0KRBdnFH9XdZHj6WK6IX9Xt6L7lZIqpei21YmShAC6suP8cXOXT0emFFwRbu2oNGpZHqWW0uBiofOaj10/PaHJvL00xFXepCBHSSy9pQTJULMWS+8c9d2Ah06gj6Zzhf+Dqld+S3/r48+c0IrdBuE1KU1+G/vz5tfsEQfWDV3EPc4s17I840lh6UytfsOb0FPYKCmKNvTwAwfM1kn6ttmC2l4+HfJmg9Qg70aY+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sah+R2l03bgIr/ugBF/Acr3NWAMg9rQSyYUcFpRV2uQ=;
 b=UGhhkBXL61btbMYZcKK0BHVdOr4KPQOy6UmYY4L3jGZsIa+KkKUm28IXS9JAlcmObTZ+3CMjjp5j05QW9C3yc0L6p8WQMqT5BS7EQlqElnzXXPb7hDhcvnC30hcHn9BxKetz1ihhIbq1ry7UWR80JTgQqxvDJM6VnatP8qTJ6PUetxXcaoxokHlXXIhewF0KLfaInnjm/+TxjY9LRF0mQHd0IeEo0+ZADWP+4UB7is6D3Dfq0twTI9ZWQBpU3GFYtd+W0PvAMk4eUwAn7kiwY4J+/gBtNwVmjICf0i8LxQqJuGHx9v6JlQkjBu6KjJ2I7kw1gAOZh9Jqxp07wVHjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sah+R2l03bgIr/ugBF/Acr3NWAMg9rQSyYUcFpRV2uQ=;
 b=nc4VUYQ6a55iJcSjkfyjkqt68UDSEAh+xgYgk737qI4Y+qXzcQG0+fEjFM5ZWOQ4gCH8+PMIiU3hrRs7z5l+bYgXudYMt9gcePoV2LltDnm87oDfEJnhMEn4Zl1hb46GPoXj95VqeXoHmk04r8HFbkQH313J38wtddZp05KZEPU=
Received: from BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::20)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 20:40:27 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9b) by BL1P223CA0015.outlook.office365.com
 (2603:10b6:208:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sun,
 15 Nov 2026 20:40:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 20:40:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:40:26 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:40:23 -0600
Message-ID: <e30d1ae3-1c1d-4797-904a-e6fb6b857fa0@amd.com>
Date: Mon, 16 Nov 2026 02:10:17 +0530
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
Subject: Re: [PATCH] Documentation: KVM: x86: Update nested live migration
 status on AMD
To: Sean Christopherson <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<nikunj.dadhania@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261008095935.1237325-1-shivansh.dhiman@amd.com>
 <179441836288.82026.13479268434351715518.b4-ty@b4>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <179441836288.82026.13479268434351715518.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ab8f18-4d00-465e-e1f4-08df4358ae76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|11063799006|4143699003|56012099006|261026121527099003|261009223027099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	AQ94Kvy8b1TH2dD4vOTs6AH5HJVAbvh8Cm1yheiQdJ8pEeGYR+n8MsHlEok8BZqRxphBujDRo5wUtO69LQagmddLCdZBkIsTu40H3sbXLPzK2T9+Pdvh8mdPYXO08hcDJxVT7gZyT5nl/p+qeyhAdxStqgaptXI5IlqWDDWtFmBPMf81Z8+R2WPA4jxY9LmUoS5T7uA4Y6kuI0EGp96Zg9XvA4jiTHHL98qUuFZn4+OyM7fSmWbDvKZg//BuRAxdqc+DWXsC2qpXCcVAcd0Bim2lhNc071Q470SJ+tO2/4IDRSVvrL4zmlmAVmrHwJR3zx7APCMkDClWR+Pq3SxuhQRB8jMSYeWmDswhWLhwp3QgoUC/9jWYoUIqxOOBP+tbHvmYgYCApVN7bnJ1YV7SHWUUMUlsLT7lEaiT+Vm6U8PCZO8Wv7llg7Eo4L0SNkZwPcULhyM5v1JASQp4DwoqJbZX8nx4tIMv652LrKLJXkQceZLRnyR2wxunikZTcuP4IGi+WteMidrxlgSrE8uZKD7CbUhJyNTg3pipyN4T38G1T8daODM30Hgv+Zo1flLAhH8Zx8zJd1vEoezrWNBuiIyVVH8+4DJ2NqXaBumtj33UcLfwMTgszJ6H9F4ClRIoSsyexKTFhc9i9zF+lErfar8M/wBTVKoEqJIemSfHXV2fxMeSfh6BKLZCBuv1BmTLtOlJ/KzviB9Cx8RtA28smw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NUMJyb1YiZ1TZBNycRIy8/4nqQN1IA1i4KgTJp5B5PdhMR/m2VYLXUInFxu50FkyV2Ka6XMFMqizWRnFN0KpDvI5wTfZCoB01/OLQhFfIGtesYaWHPBJ2CdsEG720a3yGS7waLTeVW06Q3L3pUUKHZkEJdbhIDPHxp16+izg03jJ021hSJIIIgOeMUrOOxqT5fFhmxdsSSt29R3ypujIxho7qyUerCiYQuyYAHxMlYWfauGUHSp3o7Be25f+kwSG9ZptwuAORKaNU3+2qSFvarI2Zu14LSlhQiYKfvBYsy0YYg2iXScnFUcOiiSsg/tYwhv28ekpBxmMu1rS/uKtSTAEJwGtRz9RGmhupbXaKBPo4YTCsJFFA6KrxnrJilVv0+/y4r/QcOB8719mHIrhxp0UbP5G4GqSfiO4pjyagyQsadQ0aME9b3pz/m04KRht
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:40:27.2670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ab8f18-4d00-465e-e1f4-08df4358ae76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807



On 13-11-26 19:17, Sean Christopherson wrote:
> On Thu, 08 Oct 2026 09:59:35 +0000, Shivansh Dhiman wrote:
>> The "Live migration with nested KVM" section is stale for AMD systems
>> and needs an update.  Migrating an SVM L1 guest with a live L2 guest in
>> it works, and has been tested with Linux 7.2 and QEMU 11.1.0.  So,
>> replace the AMD-specific caveats accordingly.
> 
> Applied to kvm-x86 misc, thanks!

Thank you for picking up the nSVM documentation update.

> 
> [1/1] Documentation: KVM: x86: Update nested live migration status on AMD
>       https://github.com/kvm-x86/linux/commit/a9dfce9b3fae
> 
> --
> https://github.com/kvm-x86/linux/tree/next
