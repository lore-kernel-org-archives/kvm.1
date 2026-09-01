Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CB472089;
	Tue,  1 Sep 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250976; cv=fail; b=cHAwZsVvu9LtHs1nWB5hgfX3H/Zr2+nNCbqeYJt1O1D242RwtE/ObnwnHoeobALzWwIlI5CMg0IrQVwpfGznGEdfKyOEW3oZIVMRzRaoeV6tIw8x9E9WKv0XJo1RH2tg5rOqDLroHWIuAqp/DtrMibtVPAuGtMV4cLCpju8qToA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250976; c=relaxed/simple;
	bh=uULm3+58swldolRx4XxyFhe5hMTja2qFnCGpdRR7w3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bYUjuwXjlI+Uv+6lHC/0ldofeFpVIa87b88Kb9o2tQkE43fH+9SBUlhJ2r7RcoFw3+PJx1DlIJX0eKRrVGBwmFQL6QTJhLgnNpEthD6aILiFM9JXk94BJ1ep+pyZ+gl5LoKs3tcTd2gxVsg8//qZfqV0O82cE/5vHQN8hKPKrfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDTKVWwa; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDTKVWwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSzveoYt1xbhjhcifdiOimQDzjbKTtCK+5YWU1zcrHEOIPxBgLdJhis6Qr+lZz7JmyZqsunfRGcRNPtxY4RtuxAZMCVJkEhasmfG3EWkvBo2TQ73jUJ5wGTiZF68HCRBNYWFG6GS/rnI2C8kbS2qBrtHhnCWo+3cxaXfjf1h3ddzAKN8V/rVqM1zS21aF1kla3Gzyxcct75C2148YYmqK/AzbVTTvKXkSR/MkeIwLDUXoV+JJnhB4JprhJF2sLxwKLmoP8jKFx3cjkbr6a3vFRzoBDsgBfNp2a3oOx2FV5E+NeMta3z1MRcbHWrsidg5szf2CnnjCQTJBKyU4RSj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZsoW4CXKCuWiZOL7BnrrsD+64x/efmspSZX8+b7RK8=;
 b=hq/iVBaijW51r/fjXJapL2G/azw8slP/NBuwXzFK0oeiTIS610IpBFsU8epnG8xvKlddEwQp5H8/Q5e+2dJzhOGuWXOssFgRYHntetDa7fRR3XtO7Slw8oGqyDkHk+Kk1xmNT9UvgM/a4nyebcwslzGHUVB/3Ph70fQacB4L1aqctm3UvAz1sbwG0fWNBcKdW6s/+lln8TKuJtU0Wck4T1IJyzo9pipnRN5RhQOe4qJYbY+nxce+kI7BaNQD3IImA+rLcJqXGjKP/n8jkazrNKQZwFpjz4+T1sWejGITodsXGtL0Fd65HS+a5A6FQGqWINjvEWLMShdTHQXIWT7euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZsoW4CXKCuWiZOL7BnrrsD+64x/efmspSZX8+b7RK8=;
 b=PDTKVWwahSr193N5FdyF2uw+GiRDPnSg2jqWBXtn7oirdeCUnFKCMbyUJ9uZRCY91yw13axtdztRE4MLJQ6qW80XXu8JaROjVj8Cc4YAFATaR73Tm2FtSU7yo6eZBPMI/Dll/tM4shEjswCVufsbiiwssEVYtWP9mxhzPZ7i2hU=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:22:51 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::6) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 08:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 08:22:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 03:22:47 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 1 Sep 2026 08:22:38 +0000
Subject: [PATCH v2 1/4] KVM: selftests: fix maxnode arguments in
 xapic_ipi_test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-gmem-selftests-fix-v2-1-5a273153354c@amd.com>
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
In-Reply-To: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788250963; l=1369;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=uULm3+58swldolRx4XxyFhe5hMTja2qFnCGpdRR7w3k=;
 b=4Qxc4JnLMdaDwUdKmm1g6ucdNr60Qh1MKEdonbD0Q90J0ZAQ9a7Q+YJmMzhbSPJ6qygkLyJnM
 PRU2K30YASBDwCQPrWEqJSA5caXTUXELgBK7DeYcXINaFvokfCnT5jb
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: a0634849-e981-42a8-01e0-08df080236fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|11063799006|18002099003|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	PKBo1C4XCdiGns1q9Yjg/WJoksXsLrT0sZJn7OPz/pZ1O4cK8NWrYQ3aik/LJJVH9S5MZ6ouDzdSDFyXyYPa0rjOXLMZiqgrJ0Vm0Eq8ZB6zLjIU6FdCXql+HCDmPp7Y/PtElQq58ZQooHElM6mfeKdiWKYMvHj/HURseo5lGQB6iWifnN91HgsgF6rIHCpMOBkYfsQdBz4R3xko8R8msavuU3bS3NRSFmfBBpyzNZ39oWvSamG/uL1Vu/g1Rx7u423kHXMFz4gP4u2awAbCqeoTK1JyVSN3Ib8RTAY1mYLM60gyQ+XoIyFeC2OM4uoSq5HcW0pZd9IMTvvY18Xk7qpVyjNq6VBe+DpbkM7XtaELraskqmV0mNhgr3Pc2MuItmFrRvw4mO1PVW0YqgHADbsAgS9buOouHP3YkKEHliaNszdCGJC/JjvcqQn6HEKBWxYEaMcs/R2CbV/ZdIRl5/I3BS1Q3YH2YQmD9BzYLzZgYeZ89FU1isZZLBjD5yYQJwqsarlWGkOcb2dAFNJ/6GdO5i9kZTR6f1SmspyKcN+n31AK0FBQZxW8wL+k+qyw/mvqi1hYNT0f7M3WwIas3/3suJO1DRmDFUTzKqxZenYEtxbOZ17qDhX+gyWX5DpOEyNiqM4I5SGvRYHB2q06xgxCY24e0F/NYUJem7TH2S5l10j2EW3EynRn6/SxJDq6fNwzxTdpHReDfFZnbMLxhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dNKCNVYRWxkpawF5TCZwhhBmq5seITRqULTGTMAPW2yqBIzMS4nJoY9S/wKDwxcugbOUpQvutcPwxdMumksWWwNavGu/WM9FilTRY5fxwVDdgqV/CXDqaBroJsTCE5AHovXR5fjFJG3iQfIDrD1izVAZN4Kg5ElD7rvxQptCEnaVzVVzryPq+OLL7P6FjTlyuno87c7bZ07+ysRBFY/GZyWriwVwH4tiLIOKfKEXuu4JxUsdq+hA0hkLnYbgqpZEnm6WkoLeWcFcaqwtqUzpbfbC56GDzGz+Hn0mwo8HloGz5w7uwPmS9dl2r1DQvMgKYH0QJr+fiV5w/IMTKN9gkVhvWDryS2P6dJY3tgkbjjaIc8qrE94tkGAP0ve3XjibMZXrRPjNMbKaoyjIu3qkT6ORBOLBqf8dLOabKo3OiXaZaV/rgSiyOzrDQhk5ocm2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:22:51.4005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0634849-e981-42a8-01e0-08df080236fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

migrate_pages() syscall expect maxnode to be one greater than the
number of bits in the nodemask. do_migrations() passes the size of
nodemask in bytes to migrate_pages(). This sets the maxnode to 8,
so kernel only checks node IDs 0-6 even though the nodemask covers
node IDs 0-63.

Pass the nodemask size in bits plus one because get_nodes() in
mempolicy does --maxnode.

Fixes: 678e90a349a4 ("KVM: selftests: Test IPI to halted vCPU in xAPIC while backing page moves")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 469e3ab16460..0f11f4d7cc3d 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -291,7 +291,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		 * KVM_CREATE_VCPU ioctl. If that assumption ever changes this
 		 * test may break or give a false positive signal.
 		 */
-		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]),
+		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]) * 8 + 1,
 						&nodemasks[from],
 						&nodemasks[to]);
 		if (pages_not_moved < 0)

-- 
2.43.0

