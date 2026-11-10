Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299429;
	b=CzqpLdtWr+RYcM7G1bXESCgQTBHsKKotxGejEbVTjp0eCKHaDrpQwJzJJcRJjjyWcz/L
	 7qafTzAqx0dbwcBQGtVb4W2uHRNiCyKeU39cAIEU+GQzbdgIEkDlTpmLf4qJUbVv1YSCh
	 2rJMXeFMM0vSDXgAnl0bCCUqwW+hgtixwIqgthhJeTxx1Ub+tfXxeXBRxyvQmXs0XZVPF
	 c9KqBgOsNTCD2zMq41LdTkD3aF4rynRAPaDcSAKOcSpew1Nvk1tO89jjzrPVLwauZzEu2
	 X8ixiBMjFIuojLjPVav5N4P9Qo9toIfGneAI4qieaXUreaosGdDaxJ4mfM+bREO6GxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299429;
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
	bh=KA0CVTowymE8yK8vVpHIIZrxIuL4FKKxUMAKu29Kd/k=;
	b=oDNPcRRrfMs6aho7dKFNHjBLKZBbcUIh4tjoXM229j6YCONk1jeMh0l1xpLzn0iEsT4i
	 6PUaOtVjSFmy+6/1HDkLXhutLdFxpvI9pWHqrW2PNECENKnCWvTiUqWqKxcCRcQw+ki3G
	 z4ByeTjCpfO9ZR8tSsAKvsp8ei1nj5SAIKjUJmd1pi3XQjPpuyiOQ55puGb5Lj8+f+u5C
	 eRVDfwmD2X05gLyDgO3HQjQ+N89Dl6vMbWsYqqAle+NsVqqkCC217fx1rF+INEN+ep4+n
	 3E7usz6AM2xuBsIm/zoKQ7cgaEHcXxxNC09I4gP+nPFt0nxn5Gc95stFSlmu5LDKOmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uiCVQjHX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.12
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A50606A9B1;
	Tue, 10 Nov 2026 08:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A50606A9B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uiCVQjHX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMvToO5K6Pv3BXLLzmlfa+D7BQMNOZyDzFqXzTcgF8KNIu/mlA4r8wpaiBV/QQkvQXL9oLuEOaMoV7kFMQ057IWAnc+hWYezr1f8TDMqZgFrIkQLn7IweXhMuy6FXbpVe9pE8LC7kUH8tzWxgzfDPsoVcYuxkxobeY4GpmvG1Lwp8fUHv+s+1Ita0nj1CgAzs2+yqJKXvOFQW/PuXwqtX6Pi5z+rKiS30N2vUYdi3JuC0GYLitfUZ1iS0IcOYvRJkLjHPfSBRYWhNbvzk2Kn8gN6a2i75HJDCRXvFCgSEWj+4jKvykkdyqeaXdUvI7fGbSx0JLvTGhkXWOTgtBpb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA0CVTowymE8yK8vVpHIIZrxIuL4FKKxUMAKu29Kd/k=;
 b=LVLrlfuIssO/1/z4DbxOT1s1XCMzHmVPPFPvvhP9Q/ickhFBVvP0VeRfEmJW3c8ivaKr3mYHjmd6i9uO6g9Ap06tkxnGDVdwLLzagUPu/rWMZV1cnkT0Xu+M40TsRexQv9e2GDVeqhEJd8DDM/6bCCEnExCHr2kkWTKNDSWf6wM3LztAWwvgT0g8KYE+wo9+qr7QvzNB7zCHQ37xhwEtC9ldZGw0EgnDolHPJGAAv89efbXcbTcObWuJx4Zd9kWW4KCnbizSrweEgKeDQqusP9LMv8Mxtz/RqUc382CyesAEUl+YgTMRqa0IWbzxA3+WDk2QtnFKv+ccUKcY0j2Peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA0CVTowymE8yK8vVpHIIZrxIuL4FKKxUMAKu29Kd/k=;
 b=uiCVQjHXj1bT78XPmgDXQlZRX+wnV2CxvjgvmC5bCuMMcJYVB6HMlzT/LX6F07heWKnkeZbPK6+hEIA+pLs7M2V4D4iEj615qIzpBZMh4H8vqI8ZcWWjOzlr/F35EeDwmomzsy4D3bo5UdYwLil2fj4WfArayVigiiZ/MiQUqBE=
Received: from CH2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:610:57::25)
 by DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:30:25 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:610:57:cafe::64) by CH2PR12CA0015.outlook.office365.com
 (2603:10b6:610:57::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 08:30:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:30:25 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:30:24 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  6/9] KVM: SVM: Inject #HV into VMPL0 with Alternate Injection enabled
Date: Tue, 10 Nov 2026 08:28:51 +0000
Message-ID: <543cea39401178c827e260ecbefa5552fecfe741.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS5PR12MB052986:EE_
X-MS-Office365-Filtering-Correlation-Id: b77aa79b-e045-4f65-188e-08df3f04de84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pbSf+xpsaFO6oE9Qs7cDBDNRlpkcu6RopIEKmffVVfatVPUkbbYitV/860ZxIMUEtwSVksHbQea0IiBCcFc8Glr1qIBEvxkBZ68m9YaN1Ohb0Vt5Y3RmbzKwFi93xTTbO73hGsvXCErjGlsmvY57vM/4WISPzvNZniHlYCX+EcT8cMB3oRC+TL5vXLNEuGFlTakFmos77JT3d/MJ+ly1USbH8SH2lhg14nR8HHLNRUbD/qFjTvg0FqQXJjSFcn4GrwOPr0RT6dGjeEGXIYXwMse9S92snF5uG6E+u0SGI6OP+Zb8DJnhMip2D7qar+BxcDU8QfhyaVlHhLBKRbS9pZZoj6+e4NTLZptjLBAW+xJWbdYOmMH5m8EoF3YssV7crjrE1f64t1SQ/B7Ur6yCGEZcI9WhppGXZ6sjIvgcf2TsaAFOqHwbiDYQDYCv6IXd8X0+D6UdNfzRqwxyGVq+BBjK72wAoj58clo2M1RbhxlK8UV4m+fkgtvZdWT5dL/VQmACtF0rwPGVeeCCXm/1U/sguj1UpzzL6RuBgwLlFYNzDnne9EVKBIn4oX6vdOeiNzoBPh9RUOVFjf8PSwnHNhbjjfTtiNNuIKE363mXb2psfeiMyJGIgzVsxS4qpOhZayGRBr/QaIB5bOWupdxe/6uXUYAy4MpQiB24mWQjj7s83mNebAWV211X/uwZb/v6nPCQQEIfwv117oKOJxEt2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	imi5e/PT1/hEnelUUpCEuPLQLGbA5Zp6v9gU7GFJ7IAa6sLbPipHfWvOtLgn7dUSxuCCNcmsiwiYjriVRNlyWTUbSkJrP89gkr5MvgpP6SFuc7B8vMIZdunNj2hnYdZKLzkC7M3bdFNUkcNvmguOj8pkzUiqt1nHf8JeO/yK6b2IkSMQo5bmO7H/mbFGtUQq/3K54SwRGJ8Pxq9w40fwEMTYxKFk3YikSPycpwUfZGKuoZ4wh7FP8+ER9J/LHACTaKtncPUp7XVQO94np0xkgPRRuQF9VO+KwK0ODZEh53QpaNjBxLlmkC+1t3CRePbOZZisJNRzaOi1LYZv6E8eUNH0Jc6gnjw11Ya2vqS35lDgbX958dQTthw2bSalwTwR3+QSzWHpowA9g7cox8Jp26TA8RuIGLdp42SxeKSkm9MpFu4JRu9MNo3BWm2TcJT1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:30:25.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77aa79b-e045-4f65-188e-08df3f04de84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB052986

With Alternate Injection enabled, interrupts for VMPL1-3 are saved in
the doorbell page, and by using #HV injected into VMPL0. Then, the SVSM
at VMPL0 is run to inject them into the target VMPL of the guest.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/svm/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 543851bfb94d..40f55e7a78e3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5836,9 +5836,11 @@ bool sev_snp_ai_inject(struct kvm_vcpu *vcpu)
 	struct kvm_host_map hvdb_map;
 	struct hvdb *hvdb;
 	struct vcpu_svm *svm0;
+	struct vcpu_svm *svm;
 
 	vcpu_plane0 = vcpu->common->vcpus[0];
 	svm0 = to_svm(vcpu_plane0);
+	svm = to_svm(vcpu);
 
 	hvdb = map_hvdb(vcpu_plane0, &hvdb_map);
 	if (!hvdb)
@@ -5848,7 +5850,7 @@ bool sev_snp_ai_inject(struct kvm_vcpu *vcpu)
 		goto unmap;
 
 	prepare_hv_injection(svm0, hvdb);
-
+	__sev_snp_run_vmpl(svm, 0);
 unmap:
 	unmap_hvdb(vcpu_plane0, &hvdb_map);
 
-- 
2.43.0

