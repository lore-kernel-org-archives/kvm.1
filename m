Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24693BE647
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900935; cv=fail; b=IGTtkxw6WQTb+NsSZcOdVioOnYBh5TKmvogE8gRRQDjHGjEyE+Vv9o/8c4zShWbHWPeEgOHdfKdAb3o4XkxzSytlUGG6Oa6ggONeumOP9Vez5g3Sf7G0FH6M2p57/v+CBiUZHLOjyQm4lz2Y+8cqGIKvFlt8vQBzefXNmaccsTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900935; c=relaxed/simple;
	bh=Q5f7TaR0M+W09kzJKoSRlzoW/mhFSw6UY0BIggAZkaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFxKW4WPA7e/4gelNG/i5SpHlUYNFc3q5Xi7+dF5xTehniTcOn/HV5PyNI03gERNkD8hUt3/BdJX9pNwFriqeKOJ16DLngso/9XfRTSjAeeMvf7QKkEGau/5l9twR+GoRmdVg4XBgf3QDMAvU3KZngqT9QIp0nLG9PoTK22G0Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ymz9/E10; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ymz9/E10"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5UxAg59kcfirDZtGYDAKSvdCGuFQtdJKZq1tMgsH+0Z2A2kQTtkXnF5HWzDmsBHW4wOlbs4V6JvhrtJ1apEE185OrotEW6cz+vRZWijx5Mv6i4IQUaWgOemWdCwary/We58dM931YI9ds81Qg3kKl1Tta2PkwI2JBkECo0msXjCbEwmf7XSJd49DLCem4uvP43M4JlBmZxJl2XhfUsh1zjIF6i5mOGlygASXLu2qX5pgogiJrLOhnAS2dD++HVP/ti/i6rxMKKsGn1LZ7VUSThgCqpXdy2slWcRDJr++IKFNnTVeF1IHyjJX3kOTTaW4JO7CQpQYs84nWPeNVw2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJYYvGTEhpMIKfqZ8I/hW2FQSdNffx3SA56d7j/SFLQ=;
 b=JmQ11XamltBc30pkaa7T7bhKzIduW03O8udPHNhW5Rgm0ztPj6yu6wsBMPntbFf4wD6obQV1BRXmQkY/CWvg8r0mTc+VJHHK0UnZeOhb2MTN2vrxVTUQ+O0NwqkpgtNWA+uTaAceN5KuOUDf706TcQyrgdA3YSlAH8BCH7WHgF8tuleyAC58YYrjgweGI/JB1AqBFK5xVhvLRpjQlv1EZdlZYDyWLdUBaE81AsyB4PV5ckJoRBO1HWJLxLmkETHO53h1uzd8rjNk7zPlNaaI70KAcMLE8pbS/hWoRD0oSe68t4DVLdNnukOYV4k+WFSmMqjtNMT+oZ+gqcAxvSMS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJYYvGTEhpMIKfqZ8I/hW2FQSdNffx3SA56d7j/SFLQ=;
 b=ymz9/E10oXPa3IzGQGTkex9UQZDh0mvERc+F2bqldVCrcqS3KKNwiEeuX1U1EeGjLkVZXEXBlggMnPFAwo3ms0RyHdCi4Fa9paUtPjhfdMxV6wAKHQ9Ycl51sinMZCtpQuhl/h1s2x7mz8fRiTWttFNJqP/91Bwj8/4udHPFIEE=
Received: from CH0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:610:74::32)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:55:24 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::7e) by CH0PR04CA0087.outlook.office365.com
 (2603:10b6:610:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:55:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:55:24 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 14/19] accel/kvm: Don't default to private attributes for in-place conversion
Date: Tue, 8 Sep 2026 15:48:34 -0500
Message-ID: <20260908205236.838281-15-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de7d6f0-ac75-48ef-fe85-08df0deb8148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zp2iJWZqoax16aJHvSaydm+3EJXGHdPQjaeF9w7iWNJEbEuP72nlasd0yDYz6iauuiIcV0DG/JmxmePWLXbURqHTHFpWgSw8EkelhomCTzkaAZIndTh4EUhPzejohK/7LkiBbqhqb+h0icA0lU9XOF7bPefPvvVkp1lkRGawGs6kbC5XpWUsZcFplNruxR57QPzowXr4l2yT7FIy+t1HbRkKdLX4QJhrLEEhjEM6xWizeSrOODwYJeUgyFkPlLz3vITle5n1/sDth4UNdj3t+hMfl+jPQ4EPKBrAvNxs+cVCSyvYb+ZDR/3cgfAwQR/9mlqoC8TjoMiqMVyp8JKJjSRNS3LWYiYzUY0LGgyr2A6PFRyhvgzp3/BUvMdujBoJK40M9rzlsj1d87qBiWu6ztqbV9c4XERpTtlqG89afmpYNAXef1GbFglQ3Cs1wnGo03Wi+xsSJwN5MA8i3Kzr23kLebslpwE6N/ns43uSoowtxYFtMhq8Thck0vF9Ao6Dtyzrn5641599AQpE0XR7Tw15eDplU7nOmoPnm8ln6YgexQy+eP/Hx8xnI3IITeDTBQeargF+OWTggXOC4s9216kuHWjVxUxhn0S47HBwUmAywTCK/OOOfRorBx5xxM9CGuMsHnLZ1qLtMgPmSy5YIEuw/5amfk8f8ztoD+e3zHXFRkydgdP9a1KfNCgyA85YRFDTmDWN6R1yvey1gmVXXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cQyfwA1rBxkUzbcBMONIXxn4htTMcJgfnYus8fr1jq3KtJOYJ3my46DIAk1IXugMIHrMkq1NhVq1bVnow3RrRkw0Cgx4DEiVz+703mKpIzZO/yDHY7rYe7sRFMur4edJb0fa8Ck+n8juXnmXGthA1yA76G08KD+WmGSEnHkSJLRksXV51jljhUYUgmywzAyXl16Ghy3AriSO6noj5EKwpIQwcsNmZTZpYP8+Sy8eIsELI2sMXeQtXK7AuCRKVKE6QT9lHaDr9Lp/BFiV5uhwdk6OIokAxDSzINDU9DqGbKxp7/p1EaYgPrhSqjTYe6+MUl+tmMd8BCkXbUbcwv9ufTabstge5hjNjPuYzy3WmEj6uhSZJrxE1E7m89IJ7mXW8wTmnTyE6VvfkHT9452AB28PMtkvHTE17f4jVo8Ib+7+iOlnMzq9gfYWDP9o+LWg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:55:24.6874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de7d6f0-ac75-48ef-fe85-08df0deb8148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

Without in-place conversion, QEMU can still access shared memory to load
initial state into guest memory prior to launch even if the GPA's memory
attributes default to private, since userspace is accessing a completely
separate pool of memory. With in-place conversion, all these accesses
would need to first be converted to shared, then back to private, since
the memory all comes from guest_memfd and only shared memory can be
accessed by userspace.

Additionally, with in-place conversion, the most efficient way to set
the default memory attribute state is via the presence/abscence of the
GUEST_MEMFD_FLAG_INIT_SHARED, which is handled in the guest_memfd
creation routine, so if future in-place conversion implementations wish
to set the default to something otherwise then this would likely not be
the right place to do so.

To account for that and avoid sprinkling these differences in behavior
throughout QEMU when in-place conversion is enabled, just default to
shared. This does not compromise guest security, since Confidential VMs
will necessarily enforce this via trusted entities, and simply generate
implicit page state changes if their default expectations don't match
KVM's. However, in most cases a guest will explicitly convert memory to
a particular state before actually using it, so even these implicit
conversion requests should be rare. If this ends up needing to be
changed for other reasons in the future, the guest_memfd creation is the
right place to handle it for in-place conversions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fcb6f3bee9..ff07050935 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1811,7 +1811,26 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd_private(mr)) {
+        /*
+         * Without in-place conversion, QEMU can still access shared memory
+         * to load initial state into guest memory prior to launch even if
+         * the GPA's memory attributes default to private, since userspace
+         * is accessing a completely separate pool of memory. With in-place
+         * conversion, all these accesses would need to first be converted
+         * to shared, then back to private, since the memory all comes from
+         * guest_memfd and only shared memory can be accessed by userspace.
+         *
+         * To avoid sprinkling these differences in behavior throughout QEMU
+         * when in-place conversion is enabled, just default to shared. This
+         * does not compromise guest security, since Confidential VMs will
+         * necessarily enforce this via trusted entities, and simply generate
+         * implicit page state changes if their default expectations don't
+         * match KVM's. However, in most cases a guest will explicitly
+         * convert memory to a particular state before actually using it, so
+         * even these implicit conversion requests should be rare.
+         */
+        if (memory_region_has_guest_memfd_private(mr) &&
+            !machine_require_guest_memfd_convert_in_place(current_machine)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
-- 
2.43.0

