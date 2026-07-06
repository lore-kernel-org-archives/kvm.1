Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6F381B0D;
	Mon,  6 Jul 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350727; cv=fail; b=SHVVZT3NoTbxvEVVE709nTBZcZt/hfj6gDUHrLZrA1w3/WRHbAtQbYQGeaWx1K8rYgD3Yd+Q8NMXJ95In047ZpkK9PCk9H2adi0Uk5entP2hjRrUkmoXitOEyXwJnMw4IKRNHYDadl3dj+ZKk8zXmYCSbYwrgI/VtQarvoaFdvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350727; c=relaxed/simple;
	bh=JTRFUb4K/7/OftxdANu121EcW0XkP4NtbDF9Za0cZ5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MubLHVPbV4Tv/htRthWkty06QiIOmfcN6nGbebzxviBkwAKhY68x6OT8XNGNbc+/GhCoi+hOdZwK6YMOb5JWQ6NMvnWQpcGYqEZ2bB8GjpQgrrfxddxSsRK/b3ZFRZh6bRmf0iIuJsFYLrk8wMIUpTl0OHvaOfFj3qpkRUfDTHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5LWwXOfZ; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5LWwXOfZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iig8jw1mHgrjh1guShatb2G41V4COQF6s2LrIiu4Wr9fQhif4w+ML3ZvSNMVrYFdSC/nemKLIM22V+K7OorduQIVCp90V2moZrp8AkmNQXzSNbrnzfknj6+dTaAknn93v0aoh3rBCY/HhddODkTdS3wKSlEUpLbur2HVmL5A6TYCoQ3AfDIkhjN16vdB5GJe8v5FDO3yK/KNK4E5kDca1KahIAg8BirbYc5pooSz2PzLiMiQ403isx2ZsULBOiEl9pV/NfrXQ9eW6YPcf9CkmPjUMHUdoI0r6OIRc9XLd8cTjd6c3gbQTN0/xCryRF96A2KhDUzpMOvqj6kv273BOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTRFUb4K/7/OftxdANu121EcW0XkP4NtbDF9Za0cZ5A=;
 b=fyJEyIfwF3Cc5iBflUgnWSVzJ9R8APCjW+mDfTYoteZVpm+Rpp986oOMMi8+tAmngAqbM0AVNpw8qD8VECX+m8yarud3dzy8W/UhP8CKyJtCt09mlRvQDB0gcpBXbQojn4EQ242x+3f+UegfM7k0xzMWSUppC7SV/vzeRbyejQC1XvC4OETEJcQ+ItO/dyi+sGHvdWeSpGNXd3nyy7NCum8D9uoIrEfJA1G6OTTVeDNUFyW4WqkCiGhmNAw5CnPoJmCg/Wq00ns9nbo8h/PPWhrA6kb0hea0sOotZ177ICH+5GlvP8BZxdd8eYsNrxu+8YnnpemOMAK3vVE0/WDGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTRFUb4K/7/OftxdANu121EcW0XkP4NtbDF9Za0cZ5A=;
 b=5LWwXOfZJtf2RJgMJxLclVqfl4nDDJ7tFCRjOULlt85VV/9OSn9/rIk8xb7SXhZe22B/KpEyicbHS6srn+Cnw8w5NPEm2xaa133T8WM4tVl4uJYQ2LbgNVLbvdKmXyTxa53YlhBVn0u5+4pqjYXIKPm6TcvGIjmNuDNqtlGVUWw=
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 15:11:59 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::81) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 15:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 15:11:59 +0000
Received: from MIKCARGYRISD1.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 10:11:58 -0500
From: Costas Argyris <costas.argyris@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Jim Mattson <jmattson@google.com>, Borislav Petkov <bp@alien8.de>, "Joerg
 Roedel" <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: selftests: Add guest-side test for AMD HWCR.McStatusWrEn
Date: Mon, 6 Jul 2026 16:11:40 +0100
Message-ID: <20260706151140.5086-1-costas.argyris@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508161444.23676-1-costas.argyris@amd.com>
References: <20260508161444.23676-1-costas.argyris@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d34c88-6c05-4ffd-658e-08dedb70ed1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bUGcDmK7KAxiIiaOfSXV8wp+gOg9s1GIpoLTnZuWvAaE/AJTOwGCmE+hw/42jvfFMqY7uMdXfi2Kki9DvCtZAtK2gW56gOsLh+ZpPz9wHJB6YUfDeaaeHRGt4ZFdtVP1v+JFnPtfm7JknHC6+/j7GPNWs67iWa6C2ByzoWQFBp3DwPY6hdJTPu+8x/5QUimBfpbZOJ6TPj8/VNuYPeSusYoRtVout9zt0qZsYLQbC6Pa03+vgOjdxjoJDpINSYR0uDSOL2AUfU+plLVIn+mq/hX5aEDGxwanow8CtyZhhHt0I1/9BxvEGGaATufiHb8KON0YAQedl5TrhFU7DdaE8pLO8vGC9HH7d8J29KZmvOxwnE885vTPaBGwGA0rdgXTrmHq8YSGX30DgH8v3s06JkZTxqaR9rX5rF4xzc5MPoDh5leBTw93+PLby8ZhlInefW8HfekYwwLkjNduk0zcOI39ByOG/2RARFk9UYLvS+s+6kPWizOfG6mFzVqrBVxqgZwqB2N9E9t1jJvgLe1ZxZf/3Bv/2jXguf/jxELuE/3JLb66nrEJuVMP+nidNTxaU3uUu3xkU8NxZA1lsz9LUqWjACMIpbgSc1XOqeEnRgVrw4+kWAoWw3BmC9aYHb4X5HW6OW+JHUE0NLPnOrdZjGXkcyVlAOAKyvHzg+/nP50T1r+0zMzlk8kTUgXvHav7uHZGb/yIw9DE5E1crSI3Kw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3lUw88aHPzgUxvd5GITBj4ryKKuP76QxPGwN2CXwtwk7bobEbX6e/IozKqxPuoBdFA+srqDow8qeeJCrRiDuawtM/nczObfp8tY4pXMNaEIdylfQaJs4RnfF+3iUmsyoHX/1nUJSk2T18ieOuKSCxT4SAXAxFRQNWc7F1HBGEcmKBPQjb40d7p2X4JYSdMsKwcgNLFnLCpy7QBcNReulXAJSBfZB6UFbZf8peI7fgMvCDqqOj5aCJZLQsiuxShDcXc6MgLsfI4fT5zCtoERzG3cm7J3sEjeRN/9Baol4IPRKQrqkLHpY3Us92ORKYE/5xYZ0BRLGna3RyG+4npvEaV4ztcUiKLRzm6zixtTtSyZwlGmZiTKatpVj7JRjlv6fSRReoEMezbaLf+SuCZhsiGyA+zUbOJ/aB4QWes97jOvJJjumFLwCNJYIbIeYqG5n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:11:59.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d34c88-6c05-4ffd-658e-08dedb70ed1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

Gentle ping.

Thanks,
Costas
