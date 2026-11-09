Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194369;
	b=lfSjdj2dVNxgLuw5XEYvRsW6hozO332tbkP7ZU5L5jdIyWjIPBD16Z6rHmktKJdnGMZi
	 Pbpmpkox+UjH9xOOJ98vrjyLEC+h1IYdHALwtXu69N5yvvW5FSbvPLEDwzuMutKZTkSn8
	 2W7c9cJHAZGzPKqCMtYQRv6aBPc8YVi/vHg4P+SEPb57vHw0+1lcUw241LLhOkrzOHb7I
	 uqW+QbthiUrd2NqusWlFLOU5d2lFmwQPDEzKORmiL54fVX9JJAYQXOljJbKPmlDsEbKMw
	 Gdbk8sfpmdgFoZgUL8W39zTJ4kTUk3QoqF117+lU3yRkRq7NLDOsszmuFaR+HUfsG2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194369;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kPY7arwXuEtURxQbqMyv1j9dEFZSWpGu3x0b7J1fKbg=;
	b=Of9kyhStzWoftWvLZzOfEUgdp/K5DQKj/mTBb4tTVDnsl+67XrsCsDmz7KSwkJYStILD
	 whQXRL9S68GhI7vO6Hf3Ms/d4f2YMcMDzQ3EzNdwE7ZhPvojllxih06IaI39yY+YSkeq5
	 oLHftVwvhdrQ+DyMc9hHfyQJbui0aXLtm/ukeu9e8Wr16lIUA3dcnGUdFlEO0uylIaUhi
	 NrKZPpfo+vXMoKpvGP6RJMcUYLM9y1e/5yMcAuHeLwPCesRraWMuHm+VINgj0qJTR1/Vy
	 YSh+XXUNGfBJe9VE8ARCXJ0AXTN28mIC0Xj+bG06J92cSLfoflD/Y8+R5RrtqRsqhUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tg0m9kAh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F77606A31C;
	Mon,  9 Nov 2026 03:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tg0m9kAh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBdLfbpfnUMYL9bIRwRuAHJUAS6l4slJ/Qzokz3XpXOn7+/RvIFQcy5xZALi2vXkvghl6n3FemouwhrvkoaFPZPk9+wrICzsuXf9t3QxvhVDqHo5pEXoHP52AJj4kWX6Wgw5YzNz+fvTWPxPowdY57SLyusuqbb2DqZKmoAZXc4Y8gQZcMgUBpb9iQSMrB9R/z5uwdtugm1AxZ1jLOj2cadJ0FsV6zh/MXikYhW5P5tLDripuKH/oONZ1MOhkh8XdkCaKsaRn6gTLWGxDITS41GmdSrRKHdzv36xFON/lRn7JVBhp5keQDgbsmSuS22GlYwMtacJ7XkmiteUBotO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPY7arwXuEtURxQbqMyv1j9dEFZSWpGu3x0b7J1fKbg=;
 b=RAKJYrEkHvzYFH/1xODZlwfWuv2AwX3cFiXvR0oCpt2tGGkE8cb55f4f+GwR7WM/KIc1dNc/1DgJis83kRX8UyXG+QvvedFx4BTZseQBlbBUGOGewH1enRKYqco4U+EktUwCsR/fDOzw/9BK5gEtvyWgh6B+LstqU2jdBgCkOCmmffth7RS1xQA8tDBOkjUaTuoYodGOp7141zkl7x7b1JgVqbxRXav76UTB3Sn+Mxi5VfLiGGkFRbCMFCA471/7EHdN3dZhpvEftvgqltSf+z9dY+ige29PlBvHyPdjaltRKciSFmHnFmtDx8EzGY8PlS+hMgfRONJN4qen22gOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPY7arwXuEtURxQbqMyv1j9dEFZSWpGu3x0b7J1fKbg=;
 b=tg0m9kAhcu30u5rAN1T4X5e/0PuYGZcF9ZVv2Z8w5QuKtoaBYHgKrVeMoSKhi7bDhu2RnOoaaHfP6lu5ilLHxA8+yiPgeO3OSZ3jmdONeJPvdigolJjOMbvyz4YwhpW7ofRdm7FAi/FwtODsmM9SfwaoOMN2oYH4AdCqfpOAP8o=
Received: from BN9PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:fb::30)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:19:21 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::4e) by BN9PR03CA0055.outlook.office365.com
 (2603:10b6:408:fb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:19:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:19:20 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:19:20 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 2/8] KVM: SVM: Add support for the SEV-SNP #HV doorbell page NAE event
Date: Mon, 9 Nov 2026 03:18:34 +0000
Message-ID: <5a5e45dc16184cd1f5b2be01da0e7563d346fdb0.1794171754.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794171754.git.huibo.wang@amd.com>
References: <cover.1794171754.git.huibo.wang@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: ae31cb35-35fa-4871-ac35-08df3e103f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mLKCN8GO53h6K8KP4gjWVZNFKWIcAsFSYN4/RDpx6l7bB0LsLYZ+hu8cCp+zswhl5sQU6UZL5Z+Dfp4wf4DC3ptmEslMdAxeXvwAsWrrZ2Ub+hJP+FZsO149Xyee2gHA7HdB99udtUrpM4zo/60Wai8itTt0C+ZDUm/nyWXj7JxfgX9upRwS1F2+1dKT18W44FffxFitfmm5ajmmgrmlDVwVPovJKtSIyjKqblNsd4xQYXIzdtpqECsR6mudEb71QUFlFKoXQSHWsYmwlfXSorVxEZMcUhU37rfrfeo4Zzj6jiV4MlB7FJkwTJwUIOb4Mx0eUbwzkeBnhuk8iXZ6FZo6D8alwsbPSAn/bT8ba3w1tzM6xjLYupvLMEpvLUfkp4n9kasGP/Iob4qiDYKhYvyxXa9UfeXwNyuzHVHvkNLs5zX/wiSOvpDzvovdU5Xnl5lwt6S+YdFO4Jp2TyWn6zeMKsgtr0GwB5S77Lm9sjKNdFOMK07+NbEb1H2ZD8zeDyHm3BSbzYpz+NYlrIJ1FRzJ3SDAWZFRUqUytqoYpnaGZxOuue2+LaQseTDcviOxyNE3yYsnNEIzZqg0ku6eOzo3N2mzoD0XKmT14oI/txlbrEB741yEA3YJ+29C8NOLBS2NdlvBMtwAUpVjtvcuw7bEfsRbgvkDqEfJEvhP84yJ4rARsgZ4DJe43btLruHssWjcMbdWP4vOVjTj82nggg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4OFKmtnkK/ivzUIn2COgUD9ZGBGOvAcPZlnJENIPxmaLJ6ZOi8A6idWRdOw0uWBsX5CoWneql8qDjnsWXVfhzLCSXF8CHUG+ZtNRx3J+BjNbs8MH1VQ7QJYcIfvj4omY8C0vNXwusVvl8+FsVCfAs6uQzzpJ+6l2+1rJSNGGOeqMGaA9byFqh38xKA76jkWWa+4BODpvSHye5gayRPArm6AWDALOGzFX5M0tJ/3/G4h1brvMWUwDTJouXKyOqnQrsumUZxRNEIZ/5quY8v+AnmsA716Id3CRaBYIs03IUTBHKiV8Ip0R/7HIgHJ+VOSixldPBTmSh0YN3O2q1dz3xxo86qugK/exdLJUVWzKACTUROYNYBQw0++Z7MVEp3jSz/XSGhtYVfGJxOAD9QoDRpWLajwy16L4xywGLWfc85Djfm4FVGqtIdQJ8RsRAYBK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:19:20.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae31cb35-35fa-4871-ac35-08df3e103f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

To support Restricted Injection, the SEV-SNP guest must register
a doorbell page for use with #HV.

The #HV doorbell page NAE event allows the guest to register a doorbell
page. This event consists of four actions: GET_PREFERRED, SET, QUERY,
CLEAR.  Implement it per the GHCB specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  5 +++
 arch/x86/kvm/svm/sev.c          | 68 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |  3 ++
 arch/x86/kvm/svm/svm.h          |  2 +
 4 files changed, 78 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f614..d84a13ac4627 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -117,6 +117,11 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_HVDB_PAGE			0x80000014ull
+#define SVM_VMGEXIT_HVDB_GET_PREFERRED		0
+#define SVM_VMGEXIT_HVDB_SET			1
+#define SVM_VMGEXIT_HVDB_QUERY			2
+#define SVM_VMGEXIT_HVDB_CLEAR			3
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018ull
 #define SVM_VMGEXIT_SAVIC			0x8000001aull
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..da07fe476f3d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4346,6 +4346,68 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	return 1; /* resume guest */
 }
 
+static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm_host_map hvdb_map;
+	gpa_t hvdb_gpa;
+	u64 request;
+
+	if (!sev_snp_guest(vcpu->kvm))
+		return -EINVAL;
+
+	request = svm->vmcb->control.exit_info_1;
+	hvdb_gpa = svm->vmcb->control.exit_info_2;
+
+	switch (request) {
+	case SVM_VMGEXIT_HVDB_GET_PREFERRED:
+		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, ~0ULL);
+		break;
+	case SVM_VMGEXIT_HVDB_SET:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+
+		if (!PAGE_ALIGNED(hvdb_gpa)) {
+			vcpu_unimpl(vcpu, "vmgexit: unaligned #HV doorbell page address [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+
+		if (!page_address_valid(vcpu, hvdb_gpa)) {
+			vcpu_unimpl(vcpu, "vmgexit: invalid #HV doorbell page address [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+
+		/* Map and unmap the GPA just to be sure the GPA is valid */
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(hvdb_gpa), &hvdb_map)) {
+			vcpu_unimpl(vcpu, "vmgexit: error mapping #HV doorbell page [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+		kvm_vcpu_unmap(vcpu, &hvdb_map);
+
+		svm->sev_es.hvdb_gpa = hvdb_gpa;
+		fallthrough;
+	case SVM_VMGEXIT_HVDB_QUERY:
+		if (svm->sev_es.hvdb_gpa == INVALID_PAGE)
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, 0);
+		else
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, svm->sev_es.hvdb_gpa);
+		break;
+	case SVM_VMGEXIT_HVDB_CLEAR:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+		break;
+	default:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+
+		vcpu_unimpl(vcpu, "vmgexit: invalid #HV doorbell page request [%#llx] from guest\n",
+			    request);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -4497,6 +4559,7 @@ static bool is_snp_only_vmgexit(u64 exit_code)
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 	case SVM_VMGEXIT_PSC:
+	case SVM_VMGEXIT_HVDB_PAGE:
 		return true;
 	default:
 		return false;
@@ -4680,6 +4743,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 		return snp_handle_ext_guest_req(svm, control->exit_info_1,
 						control->exit_info_2);
+	case SVM_VMGEXIT_HVDB_PAGE:
+		if (sev_snp_hv_doorbell_page(svm))
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+
+		return 1;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		/*
 		 * Note, the _guest_ is reporting an unsupported #VC, i.e. this
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..da7abf0c39fe 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1291,6 +1291,9 @@ static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
 
 	svm->nmi_masked = false;
 	svm->awaiting_iret_completion = false;
+
+	if (is_sev_snp_guest(vcpu))
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
 }
 
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..f212f2e68d87 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -276,6 +276,8 @@ struct vcpu_sev_es_state {
 	gpa_t snp_guest_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
+
+	gpa_t hvdb_gpa;
 };
 
 struct vcpu_svm {
-- 
2.43.0

