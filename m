Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E33C0607
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900977; cv=fail; b=EGSi0iS2NHXaQh3Xgl6ScKAMb3BmpEiUn8aGQe7EOe5vJZjy08NOUBClAYoKoN8lbOEY43K8/MlACSgkQvQBXgcpIr7p8dyk6DHYSuOi65+VRuiWBFn8kVQranxthoy6B0QRaJ3WUSHfjS0O/hVnAJRXQjbnH8y8wf4IInWk9JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900977; c=relaxed/simple;
	bh=OapUjBSS9VoTLBC+92AKA1TNOalMlS0dG2MKnBTN3Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6G4KAzdilFv2dk3ZeGVNIXq570eHMoD7Dd0zwocwnHLEW8FEjZuWcd6rRPwPw3gRw0ab0yQ1uYR+iib4oswFExX8vApJRDacK6soat9jEy1czGmlkVR2iomnbFAqX80a4h5CLYC141Fy9MpIb0YfsjuZ2eOiw2u2mujmTJDy+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zu3kU/ft; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zu3kU/ft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNqHReKFTOyI8ixbcImmz0Q7Je8COZVsQr5mQUNf2sU7VdANHNzFZxp10dP/+Eb+l43eYylcZv+pAwcA2vjMoP1qv4yD2jl8S9CvH4bJrwkffIosUkN9CZw+95QaLMgLizttyt0+0XilPnGry+CgqfvD0H6qjgAP2fwAt6dU6XUqRmoSP0WaJSDO2fGjJYlm0LQnpRFFImx5ZnBDz2A37pBs+Mq2tJWGSovhKQ5som3AU2F3t2aIvr21bwQOFNLRqoz80mCKCULuN93FGkTMYUehNF1+ui9m3JnqSRt+mW4rIeCcwjq3qdxgUTnS9PH1CkQNngcq/gCpj438SPTuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tea/LF5pvPpUxA//TgGWg/hH8ZSKr2mZzuauEbsqPgA=;
 b=tzlaUk8JSin7hOQk1Uv/Lsz0+tL3jQbJ0xpvuKT0zdEFmTRCyXn/Z5K713l0z+UGaUK9kEG41NZVns1HjP9XIiONh6nMAC9pQeoqG31JUbTZmLr+Qo1NX/v0zng+QRgDDaXqW/dgAYpVpXbxY9YragdOYC0r9jNmTdmkAEo4EVRAoXpAEqVnYL+5/P5b3q7Ps/HWU2qzRAl22uaGzQROMEnwqVfMQswRDOKLrnb2T7tBoEiC38ZYewGWmg/3fTCOn8dgkBSG0g94y3F6HEEWUnOMjn5q5E37X6nO/tHtK+REcmIUKmaVycAVSGPN9cv2iPobwbdBYzZyrfe0l9rCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tea/LF5pvPpUxA//TgGWg/hH8ZSKr2mZzuauEbsqPgA=;
 b=Zu3kU/ftm8pAwGdxXhho1Ukopos2yfWe2lX8WayCzkUObcGd2dYhu4R0NIw3LgUtzCC/+EebytALhC+3GjoHIzmkiRUO3OFfLhPMULEGpWeA8sPEdu6C0tGWg3ElOobMk2ux4ItyJrlBBXJQ7lhKC9xIyXCC2c9o2jGhbiIqQTI=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:56:07 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3f) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 20:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:56:07 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:56:05 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 16/19] i386/sev: Allow in-place conversion for SEV-SNP guests
Date: Tue, 8 Sep 2026 15:48:36 -0500
Message-ID: <20260908205236.838281-17-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fec758-b3aa-472f-85b8-08df0deb9a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	D0nEehI3bEafBiTywAvbtvsYMzTnyaaoTwNVICJCPoHC215AXyRvjGaT4MfsK5t2CZSzkuqX2excp91Wf+rlY5H8LINoTdpXj5/+etIVDXPTF3Ka3RH1TFYrITYttlvKIqAzjtjJrvCU68YYeFz6XIQ8YSC0A3udY2uJwIBFRe1SSieaO6hlmhgaqDNaolnvegCErlOa0MuzMj9S1zCWqDipGcnxpKMsWW+NNfkVLi1Al6gtbKwhpBFt/AvRB3LWJW5UHGUErpfLn2ttXPGHf39rbE707pXUyjiW69CfEpvnKfcHQr9e5RTIhAoOKpWddkhXLqk27ltuK3mOrTXm9HuOwjzen138INgxofoCCQfcx4uMgMRnIJnYPDG9AdHFPeSuM07O96hcvEfqFEhGtWFPYp7AwtrThQnBY55zZZGaDJDW31vEsaM7Se0vCoAvASYyWO1tfBrZTGidrZDdup659/b7hpHwW5hKnIjMLMHdOPwYYsaxKeXiOqGEkXZXqvxL0maUwZAQDkAQXHc4E8YsLlVssK/9p6/NpbV9h6vLm+slOahLI4RaahynA7/kYNlA++my/rhdqNRpCnk5Bht61wO53ecH/1xQvUFvFLkqKTO6A2CM1s6brpjFLHnUTP4HSvAVy+ZTp9b5rlLaSK8BOGSeynWqm9PhCQrYj5EJxjk2IswtdUtpLvlpwkjQg/exhgr1TpAA+jLIcqQjlQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gMOIcX3BENtkT1dbQ0sZvzSMnG5VgFQuMMp27VxfYBacIL1kBivOsBslWwBkIoZ1OBUFLgwsmU3I/ACLPNAnt6bLa83OUnVNn0LPOD7Wkn1FhwMjU6rB6YA7aZXs2+Fr4pjchT8uHa7Hf/v8zJbfo79wo/cj/Bo/tbxNS5QiNfASWAvJoB4mj8mqbAQp7Hww/CEjdTiDzlEDVZjCgin+WuEtWJCqUeFmGcWubJTkR3L24t3NH/eqT1lR607XY57rhYX59a10M6+8Uev0NHV1wsvTVouvFK1NKX8ZsO9fFS7DsnJCwON9wNvXo+YlT02IftJrKfvCrer85WgFBBv7UlywgyhE6wrfNmdQmpzUJEymIRCizeMsHBPm2sbTh9fs3qu+im4T1JQ85AILCncALnQ5QuEanJqBlK4bbI1jTFfRdNpn8+vD847wqVayfJhZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:56:07.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fec758-b3aa-472f-85b8-08df0deb9a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

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
index 87d88b7920..dc9934d5f3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3313,6 +3313,7 @@ sev_snp_guest_instance_init(Object *obj)
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
     cgs->require_guest_memfd = true;
+    cgs->allow_convert_in_place = true;
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
-- 
2.43.0

