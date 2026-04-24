Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE921146C;
	Fri, 24 Apr 2026 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004960; cv=fail; b=DneJCIH4dTSZIWSFjnixr6Qd4LGct1HqEHVBuBAsqlL/rIKt/Jty3xlcB4Vow86cCwLTt71/vVw7AxO2+/nAtKZ7OhGatH40JORoV7fLpyGa9lpQY/xMTWQ+XSWHk+3g6p6DzBamQu+Gv9Fxj1IDHiPg6ZwaJaG5rApoFOPlKxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004960; c=relaxed/simple;
	bh=qA3pk4kI8NGOo/hBXljyOP8k+fQn9+PJnQb/P2e0Ids=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NOZZx2yrzYr14xu2hWrL08zIWAD2Mzxt5nnvbMOxRIk9MPmPDPKXTVmL4RwPCGI+/yuGrDE52TCAvq6olK91D1YPOS1X3xEcO9S4ACrUa4YH1tqj4ajO+P7PSekO6S8+flDOkSRF32LA9wEeDIPVgc8OuOZUpsN4xWgGdkF3esI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cmauERlM; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cmauERlM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzdvscl5p0U+EN2RaLzmlojC9lXTmy8a4VNHsyCWXpYLzqSZXW7OxkKKU076YjfhKLHVjovkA3EvGuFyIJb2L4mWsereWGrzVXQWjZUym5TcfaNK+H8syRRM9t0j2qBrvRyuOMiF+xKLjsa2uiqO0xl7KBSCkcpT8Ps/VfwiHqZrYZDKHRocsf55crPDalJ31scBUenh1gzapWUnu6SUpr7RRw8/RX5muQrI00j7VWAPiP49rqGhaet3ATvfmdUBbteovKIIdK6Lmtc/wNyfUkJjvz2ueIvJX6zg5X6XRopW3+lkZ8n+HsX6oV1lmRfJckgeNQgQjHsEWFpKFIL8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpd5DaAE51tu6T0xmSkgVUiRa0T527KKmBd1KsyYlhk=;
 b=peviuaQjYsh2+UJpLVImasaTBcl0dLOVDleL0eGtMYJjbs4Om52xAyJXz5Glh5hDU5xgbO8BWuRWsRYNqWf7UyNl0IPn+XVHoDEqgBvGGXcwtUBiqQL0r7FB0AMXbcRYTVQ4jDIqVHT9CRR01ZGaBBfNPpL3a0SfKjfJQgBuTCC/gs9vGk+5FcHLwvaVD1+AsUnNg+9tC2IcTGmosI2FqVzXhzm9cMg9+hFcf9klhHVXdJ+8HoRtFQ3hrDne3PmdFf3wevOq3sLX27ZTJQT6O4L+5XGL5OTWaSDHVtjLYq86gxCbVWIBLl4quDs/Rsvdm7vz9u+MC+i5DM96ie5B+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpd5DaAE51tu6T0xmSkgVUiRa0T527KKmBd1KsyYlhk=;
 b=cmauERlMJ5287RjoJcsJwHDun2ZNh3sr3hj3mh+x2fkOvmUBAwKH960XPCugGG0Nj8IvHxGEaz6ryfbk745GJe6K3wB+nXmM7I3LVdPoBL7FZL3aZfnB0OiDL7BjfzvWw5BZQ1pe8nE1QydjyNOtGXnb4IIenilAnz++J1u1qeA=
Received: from CH2PR07CA0066.namprd07.prod.outlook.com (2603:10b6:610:5b::40)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.21; Fri, 24 Apr 2026 04:29:13 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::d9) by CH2PR07CA0066.outlook.office365.com
 (2603:10b6:610:5b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 04:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 04:29:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:29:12 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 23:29:11 -0500
Message-ID: <5a4a7257-c26b-4173-bdf4-3f08f9cf12b6@amd.com>
Date: Fri, 24 Apr 2026 09:59:09 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: x86: Ensure vendor's exit handler runs before
 fastpath userspace exits
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260423162628.490962-1-seanjc@google.com>
 <20260423162628.490962-2-seanjc@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260423162628.490962-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: dcef79fb-2ef4-4725-24c6-08dea1ba09d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hcDGfXhyFlpFCAFz5GofQ//eepjnLpZ+7CRdqEpRyDm37EQ6gWRyE3dSr79nnyZRtk9Nk+jqvptTZ5+rhOGmJJpAZ5GOLvwxqN+foYJeMdu9nS6hR6+zRCVGP8E6Ma+s4LIfdNWPMabloLdikEL+sjv9GB4Hc6qTsP/GZcFHqkyG0VG2UKDHWLj7V31Vfek/MbaT+dR4bZ0cFIF7o9YA/jBXPPH23v/HtaieHZ4H1kRHIkcfbDWwzjKHYlj7J/3654BjfYdlLiSYBwO/W7VyUgHPt/0d4vGdYI3qqsnSqPEMWQ0IuXuQTDO9C6jZ50+IeObjS47C/qvIcb6io4ulxMGTG8Olq426+DU9eO/reh9MT0Z09HRb8zsxvmndLJ4VN+naMrjwZiKRf/sVRTt92ULoWkZD7rWjP4V/jaj8gVC1/pnId0Qz9auMfJWthd2SMZ6o6gwr9gBdRD0syjIyaIa3MjQCtV5vqcGQYRt+M2AM8edDwt8eDVx83EjSvOXd4TfpOcIDnEuM6vgeJzBThVgdVo5DFxUQRkw2buHc16VK/nTmDjwKtTT4OEDm+qLlk6Y1DTx332BADxMkdfiBpOLSfdRRU8YbP5xJmiu2OhPOdby+fP7DzeB5LfMZJ/HZLJ/ttBDITMz04+XKFFlx4r9C9c//WHney5yylk2Ay2l63Vscf5hIG8as4j7Jh5swzz737S2mIQwS/cCY1zDEEo1p+nhEnNqEeKYy/GGJ3AH4KWylNIZbnitJEM8WDAnHHZ6qeJisAMI0l+KdaVObkw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xs4haZmGi593ia8EyYYYFctKPVXDrJNW8CB+YG+pq/6aEh5jpZB0AN+91R1PNHMPdMYy123WrZzbza91bToW86st5qA8Emw55mpueafgCQrdL2TJcDPu/j0muhlyreYI6SvHMItQbBMbHlA1SupuEOD9DbfiUjr4mpPsWoW14lqJ+3n859Uv4fM/sdw7/7peMez2FGSRhWfGiuAkPseSkY6HkQTV7EIaNwtd1nDSeUwl2iwCAOaqTkylCsUabgieK6lJfi0y57Muc+gfmEEYtjwcNCbh/rOyvblRX8XxD89FoPCWrODRsGQ7L0xCRCjHyAiADKY21FvWayFbWDLNr1C4qxxpOU3zCzj2mGo79dEQ1hms4cjQYrdtb85Kkum8kfmdhWU9Bd1L0FijV5Pm9yxOpGWeFlLickswevLgVy4Uto64lGXvj37jlB5FHhaA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 04:29:13.3626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcef79fb-2ef4-4725-24c6-08dea1ba09d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168



On 4/23/2026 9:56 PM, Sean Christopherson wrote:
> Move the handling of fastpath userspace exits into vendor code to ensure
> KVM runs vendor specific operations that need to run before userspace gains
> control of the vCPU.  E.g. for VMX (and soon to be for SVM as well), KVM
> needs to flush the PML buffer prior to exiting to userspace, otherwise any
> memory written by the final KVM_RUN might never be flagged as dirty.
> 
> Note, waiting to snapshot CR0 and CR3 until svm_handle_exit() is flawed in
> general, as that risks consuming stale state in a fastpath handler.  That
> will be addressed in a future change.
> 
> Fixes: f7f39c50edb9 ("KVM: x86: Exit to userspace if fastpath triggers one on instruction skip")
> Cc: stable@vger.kernel.org
> Cc: Nikunj A. Dadhania <nikunj@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Nikunj A. Dadhania <nikunj@amd.com>

