Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743364
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926785; cv=fail; b=gCzz57R4AEvAvso3E1/s2A5al6h2BVv2fe4BtqB34DP9DUAAw2njvO8HOnHQCdR8jpgcBcy+vKcaqDKEYwAv6uW4kaoinatwh7tbyzBq8Tf32fxXUtAG2KF63wO1RnaPNghGBUJto7xSxoYc3ddNwAP4dqbyMA+5jfg6NsG0Z94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926785; c=relaxed/simple;
	bh=MgaaUZXHWGKxf7oihzEVJjKhnsnx0BNb8zwyxsTEP4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mguuEy/0UX8vEK1l6N5KrHoLEvOrnXz5nGTBWQNYabg6SfFQ0lGSa18Aesq3BpWabD0fi1qv6cGSr9a529Gtu2i9xDjS5vzrADogtK6YGGkCyggmH0OCeWVfaYsxhsYh4JIQVp07jgP1Dt4VuLA931YwKQYtnaeZ7ttI25aEUo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eqQvw9Iw; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eqQvw9Iw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qubWJtcLa9WTJIVwZvUf3rkcIYx08BuMpJTcZQbFQ8hJXyiIev9FL/9h+LDOb3xvLeZlpYGeAjw9xuUX+aaEe7ENNQPE4SqLC35fTHOD5BezlTNGIsx/HwC8iuQpSx911OyVl6ID8nvg8Ym8kjW8HefdwLVIj0DEAyFK4o2DAuktQukbIYdsTIDQyVFzUI21n6FJ9qED4rSFGfX/lVnegZ9EZdRwjmLrLsRjG1Qn7yqTFgkela/4wYWjBuAGs/GCe+REyJasPWG80SByCfAWyGYrDBbeZ+5TX0lSQyLHBaw70l9PyP4oxs4c18AEb5aBITa4DVenAQSjb+h0COYCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG3Q7+qHT52hwX2Ng4cfBIUV6VEH5tQo/77caN3Jw84=;
 b=VDWuJI6e8ZTevkJ7+ABVsMqxK9b+rg6+Lx0k34ravj+g43C59J8ULffQN6X9UoMZV4syyHwMhDrZ1bOHIraRQJ209gUVVhDbf6O5drF+N3AinXpVfmuVWax32HUpQCd3sn6p5yR6FVfXdfOuHJXRXlpvw0eI1NSvED4TTIcfL7muCN395XLEXaDwR8wGJd5cQSeU5zWfOJApPhdRbyiW6ViAQTUVXVfXqqr3q5nt0VfDpN8idnmm8D026SOM4OqnMjEGEUViPelwl9+6Eqz9yIbLeOQAKaPNbS70/fcWzlx10aeQUOfw0/xIpxEkIaACDY6EspqiU8G0nfaQ8IaqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG3Q7+qHT52hwX2Ng4cfBIUV6VEH5tQo/77caN3Jw84=;
 b=eqQvw9IwEFZETtGwzoBxObHC8BjsKzuoQzh5m77+TZm+kGF8QW4vQABpsxEjdPTXYaCeQv01DzK3rnxk/cvpPE/bkeUEf/F98cQbEncD+ek5BAPkBIT3Ht3blgS8EsHx/png+EshHcTgAaYNP/uWGbjTz8p6wyz9xNT+pTTm8TA=
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 00:06:20 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::78) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:06:19 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:06:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 12/12] i386/sev: Allow in-place conversion for SEV-SNP guests
Date: Wed, 27 May 2026 19:03:37 -0500
Message-ID: <20260528000416.8161-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b664089-72b2-4b03-720d-08debc4cf1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i97pEEyQRK0UrM6bHhS3Vi2wWNi55FCwFz8hQkTx49OYxOg1fh2YpeexEXZfmVIHouq26tqRQRkNaabuWZRyksLBoYjXmzBGYc304o9UD57Y7IEPxPcgbCuenYZzFD6VkhguuBkIOx9bQqSWvu5z0q9ShoGTFe8TGHWGG1u8MXvb3I/pyGWlQEYCv7lcoIQuMVhPnGs8V0PXjmiIMaANjBnmLsmo6rgRBPvbsORvP0sMDc3tXKh7AqkDL67Gg8VbFeQ8w290U1OHQv3oUT1AAvYJGbpWQB6t0hVZzumEE5mx9Eiq9wcE0OWPXRvkcIvrti7XYmqXjsAUIfczJLykNg8zceNZhIMuH3ki3EYg+SB2BaoBpTDAQnFeXMjY8d2n/2WfWzRIO2pQaP3U5LYDwT3iRXlyp9wfp9eKfnQb/DTWUPHEOrzHGqp7FwLczeaY5Q7gzh5LRwQ+jH+ywaJcdshiXoRLWosx8OLqieW5ADUy/XU87x6vQlIdx2pVGNs+J+rXSLVxsrS3bt+W+20Hisc1ZjdQDD8HORF+a05GllvbLkjegH4ZEKmNanBF9bhFaqwR6N+MuH9SknJrIIiU3nHvX4/uqLcsNYdc8LH6li26kOxF43IJIaeL3nI2RtK4e3nreEFUJI4Q4QmoUkE2jQnijgCx5qaKnFv2in2m7P7vad8ISAL9N7NOlUqYlfLET2//P/6TiQ6XcHUMOYikPVxHbE4PhJWJINbLHQZmkmk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bbdkIzd1TWXPRDIN9wxSYyT+LCXnLfbuJCuIoi8M6RGurYpUrzZdznRTppQCLZjdYMgnRK2NhrFlzr9ZxqTcUk7N0cYZqb8UIwXnwPlQj74i7kDU9uCUmQXa9jx4y9oiPa4c1VKrPS2xQcrhBAF1gLGRmteTojWwb6iZFnfAXQxtMTeSQc5JJAXHurk9fgTaAkLUhuOEm/WHrK1ROjDnfEkDxuU5+lPB2srAHpuyZe8zRGRw5d3OFmqM/oiLx83NRqzDISAaOTQnMFzplFGoLB72J7sW4jvLbkQ0Ls4hyGT6kTcgKtjvVQlpyE30CPWiE2cF/kxuPveWlIu2kK/w9PKfyKxTPxpDiDxCRF13w08BTbp6EmoOvMZnADychUrLfGsQGy0lXbMA9xvb6569D4FNjmaMJzcGXr8qpSzG05Mtu9p8dsFFcL18IP7VliH9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:06:19.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b664089-72b2-4b03-720d-08debc4cf1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

All the necessary changes are now in place for an SNP guest to be able
to leverage in-place conversion support. Allow it to be switched on by
users. KVM-specific checks will still gate whether or not the option is
ultimately allowed, this just allows the option to be set via
command-line.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 32a5e605bf..a56367aa5e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3198,6 +3198,7 @@ sev_snp_guest_instance_init(Object *obj)
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
     cgs->require_guest_memfd = true;
+    cgs->allow_convert_in_place = true;
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
-- 
2.43.0

