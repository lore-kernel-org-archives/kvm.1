Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299357;
	b=Aj0U8XklzhEOLzsYGKVNiN1nwQOmtVjsD5l0W7Jp+DTdaAuEDB5alBtJTq+3e2Kvrfxi
	 y+G6ZVekqTgOlx7cAGTZpuROal8t/ot8+2b3RKzqWYBZML48cS77fH6WIiq7jCvpynoWQ
	 MS13sPIn2dVouzSHmnAkiKIL/pHlXAl5XWOMH1ToJPDVR6gpxYqVU8EFQedI/XhZBDz77
	 q30zwiL9h5yktQnjqv1RLmJ+80SMm1patyameo9Fhqa+/XbCzv6hCZfg83HZvkVmOMSYa
	 CLjENqM+xCpgdGDqiTn9cE1Obj65XQHqXBQop6ja2o4hOQyx8UL7ZW9CKxAQaY5RD8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299357;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=d4ul4TR3d8G9S3jQwECaBBIKo1SrgFJv1eUxDEZNmG8=;
	b=CKwwuMndDIbC+nDpzy0lnEYWMpHsLtRI8FmXSpu+kcIrhVPyGYHvAZorKnsOuVPA2sfj
	 MIHcCppQEYXZhDwrA7iQ3HAmmdMtkO6W/xAj5ZOHYE+W/z30BWFcI4zaSB+Sle2VqQkxV
	 rQ0kqBmOIzKnqf3W2Fypq34DjePwZ3y0xnUxCsFOFSixgSWYLSU8uU6fELvfJIqZpj42D
	 X6FhmuxjsKh9lE+oxcNy71oXFCYJZFqvIfVJKctAYQzW7qOqmLoOQqUbv0uRFGsr/CLP+
	 L8nHstCdYQKxh+HaQkib09dO6B/g9Jx+X0itboTXzSd71ClOyr1yYs45UlkPxFka0ZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=menKALn9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.47
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9460A260E;
	Tue, 10 Nov 2026 08:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA9460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=menKALn9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh1Iq+oalIrCzeroAnVR/cx0OqfdxnpYFMBsDMp2xm1PyuCyPNGLrIWfvd8WV4coI6AoFIwjugWH512OXbxuwFraS6htziwnS/bUQ85Rzc5O17Uwtwf7BkYULMBpUu1VPvIonnE3NrC+t7al+gPGQ91H8IpvfRiAiY8y0q5Jr0fo5arttuh+/Wi7JWr8clRfYCACWiMuKnZS3R46+WK09pXRI8dvOSgEmv527ijShKrhRzXh1NI2n9hpfV7yBmx2Q1bW/4MCaLOxdzj8r9zWeSIzCh07JmPbmLW1quDf42Ez/pON0mkysPwmbNF8RQAjssQhs98ItQORHzejNSgB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ul4TR3d8G9S3jQwECaBBIKo1SrgFJv1eUxDEZNmG8=;
 b=ngpeQwi4ue9PXLye1nVS4oUeZCbU0WFNKZ4Xu9NAAOG0dLVRkBsHi35paf5xbijMBHgZWzvB6Wz2Y9ZLEvjYyXMpv26bhb/I+Gtf1vbwTzTjjaudNwHOQftt3G9CzHl6hSpqAUOw227vHJrZ3qjBIdwA84GL84bntxTQACDwIVrU/eRsyoEaFaN41hyHb4d0vpQPnTh2Avids+kyE9eZF/TADBIvoSGTseG8/FJ+n70UH8AuIpGi17lWTTOyhQ89xbIiltHWpJLdtoolj2v6a3nTacVbk+MNhPxggwlD9L34jObaNFfLc8pDQh8EO66diLMUPczi7U0WXsHpNh87iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ul4TR3d8G9S3jQwECaBBIKo1SrgFJv1eUxDEZNmG8=;
 b=menKALn98A6sIsxvFNhq5oIo6OjkgdWQVQUnwhNvRVjmWCV5Y4r2gOzBzvjo+nq29l6G1tBRvRuHCruUzy7tDpi/ufw2JV1pwURaoFge1td18s5YH0uMcp4n2Rsoj7v6+IYMYwOHqb96eXT45ghrIeW0fSDY0rBiHJKtieUHzHs=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:29:10 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::7d) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 08:29:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:29:09 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:29:08 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  0/9] Alternate Injection: Secure Interrupt Delivery for SEV-SNP Guests
Date: Tue, 10 Nov 2026 08:28:45 +0000
Message-ID: <cover.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: ce54505c-c095-4c6e-cc8b-08df3f04b13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261021135927099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	h4BgTrL7VuX+ilPqolFjbhkoq57qnPTx2Zlt3YCT18ElW5/OdDGqxxmO+QUeVIRlOGAWhjOQlpSKMZRuSLsDL44VHU1fkl+bxRTvc5IOnDux8MUtWtUj9CV8c7yhDD0JRPeGi4woRDUdJu1vfs94l3frA34HSpHdKj4trerGhTMqSHGD0n2jZZPydXUROV2iQA8/pnqaU7EjU/F88uHJR45kA9VDtDGd/n7a0+m/OHYk2qTK0iYGpPO0YNz3s5lf5uW5eNpAG6AKVjhZ/cW1R3Ta6jUqlckPGH0BEC9eUJIjsQWb+p6R+e1MduMV1MRtS4A3C7tb7il7VeETkO1DZsNMtTcOtaZjYdiAaNvsbdx+gTgLn3Qfm26e8S1I/wUU+UbXvQEHfGiBdgrthrsjG3Vzl/q4Bs8u1SqiP+Jz0ftXf/iJ+exRNk8FivlCtb+06BzQX1EJOgcOrAU6mvzj9tw0nDwGRyI8V2l4GJxiDH8kmKCj/89pLwt+GzMNIZn5VHeypAM1PR7zKWHtyU9qFmMItMgAtwUF60IIN/qCIBaCN1gdHfwwY4Ej1TYp/m1MlmaIp7q4bSb0dVVzaYFUB4Dw2+usLtqxmce0mu6lwEE/w2RT//3BS00Y1hfTAU0hRFsFoITJvo07Q+OkLET5yA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/bw4M9POG48sLrqzVzyiqee8/0wAcLlrj6Nb8xBMUkTENvfXbJa/fIFHPdqKhIaNUgLoVTsVo7I2oda0Bs3UfxM0riCWaqwMY7D/QHw1eq/k6ddEUTxHdgHi/6pu87bknsUcEc48W+oovQS1OyqUVQo/I1QhjmusSYx4LGcWJTn3IIT/kcqufTtJn2b53YXbswtsaYMsxhDmeGBvQTvJc4dBXqiSk0ieTgOlEZ/fud0m8nZmnREPdSXFmIGhByk1hglFhodYiusoHsJwRRfKkK4O1ilbTqkVEvmkoRmSxPGRZyCpX37afUNcQsaelgnrafRiBhj2k7pxKx0u4rfu5Afsk66IYn+YgcfdlLTOFUUq+mPFTX75a9fEaz6/eU8elWWHT2/06X/RGPfj5nM9PcAlMyT0xlwTH/lAzqp72Qxo8m+uL5IX/5FWht6t7i28
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:29:09.5644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce54505c-c095-4c6e-cc8b-08df3f04b13f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

This patchset introduces host-side KVM support for AMD SEV-SNP Alternate
Injection, providing secure interrupt delivery for confidential guests against
malicious or untrusted hypervisor injection attacks.

Background & Motivation
-----------------------
In standard SEV-SNP deployments, retaining hypervisor-controlled interrupt
injection leaves confidential VMs vulnerable to unexpected or malformed
interrupt sequences. Alternate Injection mitigates this by shifting interrupt
injection control into the guest security realm. It builds on top of
Restricted Injection, leveraging the established secure communication channel
to interact with a Secure VM Service Module (SVSM) that handles APIC
emulation.

Series Status & Dependencies
----------------------------
- This is an RFC patchset intended for early architectural feedback.
- Rebased on commit 6efc8ea4653f8bfd4d59ea5fa9589d028e037909
  (joro/kvm-planes-v7.1).
- Tested against:
  * Latest SVSM build
  * SEV-SNP guest kernel (rebased to latest, with Alternate Injection)
  * EDK2 (rebased to latest, with Alternate Injection support)
  * QEMU commit 8db5273ca97f26043f64d1390f906e434c675db2
    (HEAD -> qemu-planes-linux-v7.1, joerg/qemu-planes-linux-v7.1)

Next Steps & Discussion
-----------------------
An alternative design approach has also been explored and will be presented
at KVM Forum 2026 in the talk:
"COCONUT-SVSM, KVM Planes, and Secure Interrupt Injection - Upstream Alignment" [1].

Welcome review and comments on this RFC series.

Plan to refine and update the patches further following feedback gathered at
KVM Forum.

[1] https://pretalx.com/kvm-forum-2026/talk/ZB3GWA/

Thanks,
Melody

Melody Wang (9):
  x86/sev: Define extended #HV doorbell page structure
  KVM: SVM: Add support for Alternate Injection for the  SEV-SNP #HV
    doorbell page NAE event
  KVM: SVM: Add Alternate Injection support
  KVM: SVM: Add Alternate Injection path
  KVM: SVM: Bypass lapic for VMPL1-3 guest with Alternate Injection
    enabled
  KVM: SVM: Inject #HV into VMPL0 with Alternate Injection enabled
  KVM: SVM: Notify the SVSM an intercept happened during interrupt
    delivery
  KVM: SVM: Clear AVIC Enable when Alternate Injection is enabled
  KVM: SVM: Enable Alternate Injection for an SEV-SNP guest

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   2 +
 arch/x86/include/asm/kvm_host.h    |   2 +
 arch/x86/include/asm/sev-common.h  |   1 +
 arch/x86/include/asm/svm.h         |  60 ++++-
 arch/x86/include/uapi/asm/svm.h    |   2 +
 arch/x86/kvm/irq.c                 |   4 +
 arch/x86/kvm/lapic.c               |  10 +-
 arch/x86/kvm/lapic.h               |   1 +
 arch/x86/kvm/svm/sev.c             | 371 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             |  66 ++++-
 arch/x86/kvm/svm/svm.h             |  30 +++
 12 files changed, 531 insertions(+), 19 deletions(-)

-- 
2.43.0

