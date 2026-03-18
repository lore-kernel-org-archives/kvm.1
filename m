Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E923EA93;
	Wed, 18 Mar 2026 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820636; cv=fail; b=a98WaqlCQzUHgYgmHty9ftZS9X5bdTGkxTeYIyuA+fCZd2znsgC3DbzFqvqtcJB6meDp6Ne0PtYWoFHYlnVD+RdLtDABk32sKXXLj7KlaQkM/uUE/KKmIEbXlJS2l/CB0gQ7HwDb+eV896Vv2OfcgqHEooKRfNMCVL8Z9/rT5uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820636; c=relaxed/simple;
	bh=g9e/aaHfomDDuYhnqvNxpxnvJne6sgrA+M+Emf7GJSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6ei8mPybWzZ2hJlzucG3lVG7Mpsa0HEu0LfhUbY0yRF8UH0lki6c1H8F7lzDY5LCFh8KJtfv5nZ2aDyhe4K38C1bJQAjW1Nuq5KQ6xIs16ffLILMq+bB3jkD1p8lKGBOL+Vd9Y9bbaBv4grEvxPfIh8/TptP8r/kVQ9MX4SqHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x2ZLn8XZ; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x2ZLn8XZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHh9m1h+o8hKMK2Zg9UrExKK+4fLVbCv1gutVsa13jkiICA41q3Jt9tyC+lbSITZfAcz16Qcpw66eEZlkJSx9MGUSiA0JB9lxaAuif0dcQTZoN7qLVGQ0jnwp7hV5CFq/jgKAIE+Dmy4RZZcbTslhDEeadjy9B95Mmzkq0js2wTkxDfyOIsjRv3yB5QjO3AXIXWfS54/kc+oGP8MQIvRJ2waXwv5NcZi301OXOJamkkNsln89o//fc7WftmBAAN8ZMk7WSp9JN46tHBvtkGkuWMHro5i5oW3ABnbaRUXeNFc3Gqj69W8Cif3gQRtAqvYBZDG0Tb1SgBpyGsgX/mbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUtsPlBA2QEWo1DTwA1yhUGfNO1XHbw6DMAEEPISVsA=;
 b=clrUHtg8+dYMkmE5O15PAd4NBLFiv+N67k8mhtQrxtIKiPSX/Ab6d3Z4tGiA5NeCZmbPw7w/KnCqE5JUzr06Px4cQk1OpPhp/LgjUC39pY2edSme1HsfkfmWOt7OMc3TFSkG/OWN46ApEGlgUrBi2Afqe2dojqOKwUNjqI1OY722yQNU5JicYepCTMfIBgh5RbO5gy8UbwqU55wXgMCFGvZp7fgJYX1unxsNx0eR79eaFXtCOCEOy5rlZ3X+3OBxiLYL5atmIlzFvfsYfMdvw7ZuIfNq/Hh6fNy5oIteXWG4dd6E1PJX5PH4T33fUYfOvmff55A+9UlYKoK6L2qE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUtsPlBA2QEWo1DTwA1yhUGfNO1XHbw6DMAEEPISVsA=;
 b=x2ZLn8XZadJfzwML1Z87oMnVdbmfSom+4fYQE7SEbtSp7JgQxPsQV8c6KsF1sZih3ubuHdaR3n7ZnZ1yHE1ZQcfziQoFJM3NnkiE/DFtzy0QldAFGAdpjdsI0DDlmZu1xdkfGWYniV3ux4ND+ZvKTUC+/isoHjyIdFyRSnHs8Hc=
Received: from DM6PR14CA0050.namprd14.prod.outlook.com (2603:10b6:5:18f::27)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:57:11 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::ac) by DM6PR14CA0050.outlook.office365.com
 (2603:10b6:5:18f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 07:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 07:57:11 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 02:57:06 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <bp@alien8.de>,
	<thomas.lendacky@amd.com>, <dave.hansen@linux.intel.com>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <hpa@zytor.com>, <xin@zytor.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <x86@kernel.org>,
	<sohil.mehta@intel.com>, <chang.seok.bae@intel.com>, <jon.grimm@amd.com>,
	<nikunj@amd.com>
Subject: [PATCH v3 0/3] x86/fred: Fix SEV-ES/SNP guest boot failures
Date: Wed, 18 Mar 2026 07:56:51 +0000
Message-ID: <20260318075654.1792916-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c8da80-1fd9-480a-547a-08de84c3f5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	xoAAwQopNMUQZHvVi3nS5ZVIvi9v6ueESwWDZQWSppuwHMfLMMioJ9PKyY5DbFU5NYpaS/PRR+9EpL0dfiEQU1SrCBSlMamuVChZuwdxWBo6kpgk89z8UMWb9g/7Ayf862xOuo1yyLRaDItQLUzSiNop4nfOozKc8Uvz4xjDjZSsovclAGVBh73dKIy6O+gMwPGQUpTrZo0OGzse16dnlTb+1wZ5xRB+9SySDjhBDzphve4IVOu0FNddk+c5KOM9hXwcu3VX2oMeGEzHWYjlJQpYpanzeMBd3RlXxkGRRRIm1vh0sVsv2J6Yzr5e7HraccZdxfrC3Ip2CM3z+PP8RfpMdMg53lVlHnCaymxuw7HJIb45t3qr+DeYJV7LYsUE1PQOix9iYcTac4j57maXJs+j7jToKwqVJUtxfnK+gDyPDuZvCFen9+7oT72870tLovaWdRCvyzqfXa1oAayCyCykwU7b92oFvCmsJyXJH7zxG9DcMx/Vz7R1ZA9H54KqmYWek8hsYLk+Ev93gp42QsdHSa8tirKSCsxoxTD7lhtgJ0tl1Ce7EYDmkjV950E40yPzBciv7hHgq38Y5uXmVc7wzzeXuZUavzJs5f1aJ85KVNzTHFtHSyInFwhCeersLGd/y4nkqlmTydumdaI0/tRNL2+a9XGjqupES1a1jQ8dHWNY/Q8l+oBMbrxRrcLb5TVcoPfiSBAR10OD10SP2b54ZNL5EblLnVSJrzwUh5zCunAeJ0HaVX0m1vMoGi0YjMJXOZmaoi+6BJ2R3HL4fmMKH5dHjWsUrFc6emneu9M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hd5n32g/yK3rRX+GK9tEVgzYAAOCEN2fCgJ8Ht0PD5T699FswkABHTyhpyPFTouj6/BflT7zmgKHpbvfs8JZ6jMj8olXL0V0CbVPa/4VhHd1ypT9ReGdfWN6soxTPmF7jTEoq55/i9OpHoQKMk9G5ngQLYxHMGjx5svd5Mo5YTYAdlKWdgVQdQb/MzfdfgHpHcAMgp1tt6waAOrVB8KV+zrcpLz4ZnbMkfDXJbWnutqLlq1Jzh4+90cWVpEqI07R6puu2PUvGFq07ew8ONEci4hCAb5CNW9Sl+qjvcosU4604raInilNOQDNUF82AHlcTtn+djNJrw9ZhbJns++7CMQgmUAU3jDoSeE9HtcPTFZGIwev2BdX3MYNbtYPLzBItdxK99LD3lSxVLFWnXzoHZ7yK+pM53SdtGD2pD14Hz+jjrCTnso01ct8MLyos9/D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:57:11.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c8da80-1fd9-480a-547a-08de84c3f5d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

SEV-ES and SNP guests fail to boot when FRED is enabled due to missing #VC
exception handling and a CR-pinning issue that prematurely enables FRED before
its MSRs are configured.

Patch 1 fixes the implicit FSGSBASE dependency by moving FSGSBASE enablement
to cpu_init_exception_handling(), ensuring it's enabled before exception
handling infrastructure is set up on both boot and secondary CPUs.

Patch 2 fixes the CR-pinning issue by deferring enforcement during secondary
CPU bringup, preventing FRED from being enabled before it is configured and
able to handle exceptions.

Patch 3 adds #VC exception handling to FRED and fixes early GHCB access to
use boot_ghcb before per-CPU GHCBs are initialized.

These fixes enable SEV-ES/SNP guests to boot successfully with FRED enabled.

Changelog:
v2 -> v3:
* Fix SNP guest boot failure reported by Borislav Petkov - the CR pinning
  disable patch exposed an implicit FSGSBASE dependency that is now fixed
  by moving FSGSBASE enablement to cpu_init_exception_handling() (Boris/Sohil)

v1 -> v2:
https://lore.kernel.org/kvm/20260226092349.803491-1-nikunj@amd.com/
* Instead of moving pr_info(), fix the root cause by disabling CR pinning
  during secondary CPU bringup (Dave Hansen)
* Use unified #VC exception handler in fred_hwexc() (Dave Hansen)
* Collect RoB (Sohil Mehta)

v1: https://lore.kernel.org/kvm/20260205051030.1225975-1-nikunj@amd.com/

Dave Hansen (1):
  x86/cpu: Disable CR pinning during CPU bringup

Nikunj A Dadhania (2):
  x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()
  x86/fred: Fix early boot failures on SEV-ES/SNP guests

 arch/x86/coco/sev/noinstr.c  |  6 ++++++
 arch/x86/entry/entry_fred.c  | 14 ++++++++++++
 arch/x86/kernel/cpu/common.c | 41 +++++++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 10 deletions(-)


base-commit: 270b06a2452b0a20b149591ee90e22e3d8d55358
-- 
2.48.1

