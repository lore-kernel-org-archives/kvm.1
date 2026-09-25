Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4049C4DA;
	Fri, 25 Sep 2026 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336575; cv=fail; b=qLhUAzaIEoWfIHLfwyRUrx5zNKSlJ+kMX6ThjhXV3VHfz3gNhABR+vRrzkZZMzx4QRVwSQMT1n8BlBWpXg0lQkDBPnznHk83IOu3DM3uN7+5G8aC1+t8Av9XxCJGzG3fGkYqSnx18RNm1Y9U//MQ4CRLkimSiw/092/bflvRDmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336575; c=relaxed/simple;
	bh=UEmLzR22JygE142fC4Y8wGExT/0oqmcgTa1S3IMBtUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1oYygIfh0u+KkXIAwyQi2pFhyNdEozKXEa9cu3wBcRrRqAMRExy0lkppoqOjO0rn2IGfgI8A+fWeg/TuIplbksCfDYXrCM5kqQIoVhTXf9bCEDovMxcDmy/SPxdE/z1zl5R76HWPgpAMvYLKA4/4ty/ZmULlJ0plc5talfB/uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TEem7zpl; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TEem7zpl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUfhbX6oS70mHuyinf+efd5gzc4vZX5IhXOdiVRUD6Vh/79fXsoKLIMs5tDxNilkM04wyflbuUdIf2bmS9pJ4YSymTGLzCWmNEywHczJglOUwTDH0tPdoBIHj9A3oOCYQuJ+IC8pppcZoQvPduScwdymAjyrUvLxjzOv/xm5Rbc7utwEFZk97Wo9jVS1aWoSdBGDV8Rfpyqt74fDEFhTfbgL/UKgHYwxtRgGi0uXaYhh0VQMVLYQbWmPnC6wwBMlODrt4eQciVc6qrY9Cja6HE9E4JxEDnXi9yg3wLjkYCBQ2fu+2C48NpnlTmB3ZolYUhCGKZpoisnewsaUt/EcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NPWIPxE8xVoa0EuHRJjXsi9MhDdwsxuJp24sLXyUkY=;
 b=ZiJHuuLRepUQKDjbf58Ve59YL0DIG9mRx4+XakR7CRwvX4RjPwBjZnFjwsi1GiuXUqT7/hx9vNqmU5oIzM1AJx93CeettthH0Z45Ifn3+0OdpBlFq8sKGvfDWxIlwIEZlRqhi7DuLye985wRkx1jdcbTZsNI2xXFgNZ5n7L2+qHJqmF/WQTNEw4qPuD5Ffd5Oa4Vrgcwgsgpg1NhysWG4uLLbbTr7ghIMp/Rc4ItLtgJVOrje3hJ+582/egdkHb9No/vyTnyQxzQ2YYv1fU7bPTLVuK7hOCmFsrFebtUkGvD1H6L2tD803GQ1UKGBBA4XciG/Jfwd15xqUxqMAPfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NPWIPxE8xVoa0EuHRJjXsi9MhDdwsxuJp24sLXyUkY=;
 b=TEem7zplxMua/ljhDloImpHghEmwEgfBglGlm7yrgNqbwYcllwOEPn9I11Gb70QF7RfkX/kTac+/qXq/kZhQxxaiaLmGeTqFZqW09lD2iBCco1eqJy1Ur45Ig+ivieK6y+2DH+XzgAzPusUZjL1/PZ2ZlbSzjXZiCbhjes8pyI8=
Received: from SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:42:50 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::24) by SJ0PR05CA0191.outlook.office365.com
 (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Fri, 25
 Sep 2026 11:42:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:42:50 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:42:44 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 1/9] KVM: SVM: Initialize FRED VMCB fields
Date: Fri, 25 Sep 2026 11:40:09 +0000
Message-ID: <20260925114017.2208531-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
References: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7d0646-c77b-4ab4-1ef2-08df1afa20b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mLVqVx/yUMk1xhGf0rXBmEl1IXiwfwcqD7MOpewhK3hiJcE8Hrw9RctCrEY4aZ4AToRFzyKFeKBYsV9QWmhF+kIWj9hYwbTJA6+T4yYLAFRkhYcYmFLfJ81fpnFNblnwSW6Q3DxEI1CY1A5guimn7PaKWiyElZYKxg3bii39SwGRgroEffhDZZRkaC8ClUy4yzAvGp2nqcRvLzxsa6Q1HciT5DbfX2zO9XLe23ktt215c8rso4KaZAZqjxWnTN0bmWCR0aenwuheyYnIB8vtTjwH/O/a7KTEto3WwslQxktTytIxEHPFt7iGkBjUZFfG7xhn/auoxW3lDE4Y7Gyutd8yDP0cDhfmcBhbgJaR8b3kVzsnG7LPVNKIJ72/DRyShJmmzEGKQW3aAACXjkVci5E9Mt2p/xQoBK+C4Wm4CrLewTldnp5GA3Mbw8ddO54UeK0fMRt9HU0tZw82IVjEmbZr5tgrlAHRXH31psl2Yx5y9TDkAs9fFQmpOY6oHzTPpkbFfkLycpXw8y1wom5hmYj0z5/fi4rIluG9NCiji51kpf7rtTX1VH6q5LmVFZdDf0nEy28kzd+oRKPKgWBJZisP28IwTCASu/DpioLqJBuz7CpPzFqBLpKWxftTyYy9UA8v0CFlyzfV2K7yTRymA9UBv/aBWDboGiRYMGrqOtvGOFCxw23r1UaZd64jj79tMViyzha0nvPj5ZPAbIC+xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f8gOc4yWXRgKwssHR1ZQKEIE1FI48WEQX9jRFvLtFPl5IQrWP+ofAetEwPOB3hT+nqGmNJQbnsfTZ03lrIbbWvBpsETWj9hoFlcGSKXMs/cVtfTW65UlX1C/P2FhXszYKDl5ngOXPpcFikjsQKjmubUz1KntLlNfrrPQ0/TP40onCP2jmDgBI3Q2PV2MmUj3s5y7XSjGMXIKoADu4UOB3cXZG7q4F4TrtWznavA14GrfbJm5+H4B9QBuoYD8q1IzUPjOuOzD5aEVH2YOSGONVj43W76NdozxoXULT1uyspOZf3EAicZ2AdVxeLxlWKxWktTH5bQtyWeWQU1bMfPaFvT0O4XgS+1zrzVL356g/G2GtvwryyOPdyorr/SOYfAZT3po2xSM8ieBPPQT8nxzEca7TMAwTlfIQ7wAr7z/e8qATyDOlK3Nq5rkGYoXpXin
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:42:50.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d0646-c77b-4ab4-1ef2-08df1afa20b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

The AMD FRED (Flexible Return and Event Delivery) feature introduces
several new fields to the VMCB save area. These fields include
FRED-specific stack pointers (fred_rsp[1-3], fred_ssp[1-3]), stack level
tracking (fred_stklvls), and configuration (fred_config), and the
control-area fields exit_int_data and event_inj_data. Note that
fred_rsp0 is only saved/restored for SEV-ES guests.

All FRED MSRs are zeroed on RESET. Reproduce the HW behavior here to
ensure that vCPU starts with a valid FRED state. Also update the size
of save areas of VMCB.

Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---

Changes in v3:
* Update the fields and offsets of FRED MSRs according to the latest APM.
* Dropped fred_rsp0 from vmcb_save_area. Hardware doesn't save/restore
  it for non-SEV-ES guests. Move its handling to patch 3.
* Updated the commit message.

Changes in v2:
* Modified the zeroing of FRED MSRs from INIT to RESET and updated the commit
  message (Sean Christopherson).

---
 arch/x86/include/asm/svm.h | 31 ++++++++++++++++++++++++++++---
 arch/x86/kvm/svm/svm.c     | 11 +++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..0570581e251a 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -165,7 +165,10 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[664];
+	u8 reserved_10[40];
+	u64 exit_int_data;		/* Offset 0x170 */
+	u64 event_inj_data;
+	u8 reserved_11[608];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -370,6 +373,15 @@ struct vmcb_save_area {
 	u64 last_excp_to;
 	u8 reserved_0x298[72];
 	u64 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+	u8 reserved_0x2e8[1496];
+	u64 fred_rsp1;
+	u64 fred_rsp2;
+	u64 fred_rsp3;
+	u64 fred_stklvls;
+	u64 fred_ssp1;
+	u64 fred_ssp2;
+	u64 fred_ssp3;
+	u64 fred_config;
 } __packed;
 
 /* Save area definition for SEV-ES and SEV-SNP guests */
@@ -482,6 +494,18 @@ struct sev_es_save_area {
 	u8 fpreg_x87[80];
 	u8 fpreg_xmm[256];
 	u8 fpreg_ymm[256];
+	u8 reserved_0x670[568];
+	u64 guest_exit_int_data;
+	u64 guest_event_inj_data;
+	u64 fred_rsp0;
+	u64 fred_rsp1;
+	u64 fred_rsp2;
+	u64 fred_rsp3;
+	u64 fred_stklvls;
+	u64 fred_ssp1;
+	u64 fred_ssp2;
+	u64 fred_ssp3;
+	u64 fred_config;
 } __packed;
 
 struct ghcb_save_area {
@@ -552,9 +576,9 @@ struct vmcb {
 	};
 } __packed;
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		2304
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		2304
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
@@ -578,6 +602,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x180);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x298);
+	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x2e8);
 
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xc8);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xcc);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dd19c7b4e904..6d55b0a576d9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1217,6 +1217,17 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	save->idtr.base = 0;
 	save->idtr.limit = 0xffff;
 
+	if (!init_event) {
+		save->fred_rsp1 = 0;
+		save->fred_rsp2 = 0;
+		save->fred_rsp3 = 0;
+		save->fred_stklvls = 0;
+		save->fred_ssp1 = 0;
+		save->fred_ssp2 = 0;
+		save->fred_ssp3 = 0;
+		save->fred_config = 0;
+	}
+
 	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
 	init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
 
-- 
2.43.0

