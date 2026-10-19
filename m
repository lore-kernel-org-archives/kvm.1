Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444001;
	b=WVcUdGXjdCSQ3ypqUJfS650A0L25hcH+Xt8VT4q0BwWQ6TQHCuFAd4HkEaiWKwVVvAdr
	 ceEGHhvknWHquUNo7sFn77imUpqBvNSget/m0M6lRMbVGDha9D576DJTSWdB75lXTLWq2
	 mZEdZNWEBERsRfH5akLDaf/ismFktb+h/HhKx5aIlCk3A3RVWTtLp4Nwmv7o1voSd+pTs
	 2NovuyoOY6c07cF4uukqjpwjRspzNZ18D0BowaXeeDs/cnR0eCp6Fpj37KpftOFS85olH
	 bYXpGqzcFUF3fh8cHCaUN+MzWof/hdCEuyQemcBuDrbKLbS4JbAwo4uKXUrWc2ie+Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444001;
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
	bh=vTWcOGOPNt5HSluTwf4eEqiv2/ydNqSqOvHp7CmdhDk=;
	b=j4Swb0/r8FmKh0cdUitbsTBMA0lRIJQFvxKDTtT0IhdI7CwwwAsvVJBgIhR6WMJVXM7L
	 eTLF7iE0VjVnYm1gYUpKOa4xKZF/1nrbspMBCUFgEA/HRVhgfEi3uxzu+BIHRjYY+MMJ1
	 ZYUCaUwt4B+LTAobK83D6mXO8nBTM+2K1xPpP8xmWiUpCen7DPky/3kM77DgpYwwjAT/D
	 aBwxGZ4qYYjc+W5agZl/1AdsW8357+ohEu/r0xJ9WrDuMGGkIimQLeDgdylDSTGiIa24Q
	 ijNvgcvHRfPLrMj6HmJSy7BnzeRhUmr7yiJTkvAFEbR5eB+8Uz7cbrexrAQhcroumng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uLzzgdpS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.19
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AB606A328
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9AB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uLzzgdpS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH6Vwgl7osj5awfzd7OXxdQylNMUONUv/UkMxRWxw3Fi9A4h4hKUKq8HFPxLrz10Xaii1woLOB8vErTdTpR8+fvpmRgw829bdxZ8NrH3foNT3fu+Bu7+Cq3exFmJR9ZuGddRZXD+EyoW4rZgcahpwbZ2QGDDfYh1X+7x1lZiAgIXDg1AbjwcYyYGr35ttriDb/Rru6w2R8X00FfE/6RwUl5SaYpDj69xTSWbCijF2dzZgeq3LczAqBNbosfx4oG5triqC2z8ueZA5p3rArGTZxLmsN8fsumkJRHlF73un0160z7jw6XndO6MqgIiR6t8Po4MUnsE91HjiQuXn3TrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTWcOGOPNt5HSluTwf4eEqiv2/ydNqSqOvHp7CmdhDk=;
 b=kI3A3+0C2U9Eq1fByhB6bie/bW/+1w+oJkbbEnxDBNgdxVzD5UEOee7Wc8FE1X91ZCxDIyGpKdWBmwvEflTCeY5nwWd649NMciy/5YadWWW/govfqdNwa3PQ0h5Fe551zcw5Q/PmI5yGApWtNuD6TVXgoutHnTXuh48pmy20OuUJ7uIKassFInleabv2JRzn/8bB0FdvWON7jY5MIJWLmQQLWc/8epTBEzmVTieUY71Y6Gscabpp+THGBeTXlSN54jxawRVh2M9F1mOUT8hcUTNe5lrJaVAYw1Iq4lAXPPpVbqqUL82lHyYeRnl2NtANF95R2Sz2coufO4vQBohmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTWcOGOPNt5HSluTwf4eEqiv2/ydNqSqOvHp7CmdhDk=;
 b=uLzzgdpS82Xc1cEobt+Zv6iBzNjJArl0Ko7Yb5CVYYjO1JbEGvbbMb34I4/lDCtlgT20/9L0kWQjXrFin7vnkRGtUF3jM9Xl66pWPCfjsr6fm+dH/0q77z8u0W7pvvnRjL34UVmVz99unPjMXGQkk5VTjPRhMhLUQF15lEeFuxg=
Received: from PH7P220CA0134.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::34)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:06:34 +0000
Received: from CY6PEPF0000004D.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::90) by PH7P220CA0134.outlook.office365.com
 (2603:10b6:510:327::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:06:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004D.mail.protection.outlook.com (10.167.247.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:06:33 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:06:31 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 02/12] KVM: SVM: Add the LbrExtV2 CPUID feature bit
Date: Mon, 19 Oct 2026 21:05:22 +0000
Message-ID: <20261019210532.378628-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004D:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c400530-06c9-440e-8004-08df2e24daed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZzD2tIbjAH7d4PJ+CEGsQwet5oqdkF6qDjLUzyMIDXRmvxrlKdGvjGq4tqrNhhMhy2GsVXEs4xOhKc/xmG7V0Y4hLbyLLg0wjsqkoe/XqHZ53mOMNKTCDj1KjPACUdIIcNIYokVSO3bNRkH4SQJwea/TU0+jkCJUSqxRRP0p4Le/Dw2pKhSkRw/Qyce4VlGYs4dqi44zMXu7E/Nk1QwuvS6lsTCQj5/X1+M/IR8bQoXmDXXGFb/ITPlnrM1NRMjC0PqJImNgtsOmeg2+FyWTjZiuIsbMffRiS/RHnQ5gm+uaUp/frWGLFzVr3xGuNvZn2Hn1Kbf9W8W2xc6V9i55pP4c92Sz5b4GPdlZPRuAX20WqTuhfmZwG6vYYpQe3mKaw7RREh6tvDDNCAj0AKAHxd8IgdbJrDKoHjwfiaGFQoWiXTzul6eHXvR21h0ihICI0/nA2wNTPc/qAtXkD95AGhw84ZlBNDaHgi4LFVjVu2Yobrqyf2zNhPjhVnzujH6h/6E9HXIAVF71fZqkJNz0SYkQvKx2UVHnnKNWUrYXe8aBqZZrWSX310NS9ObuiQPVJrBezn1avpgoZbaRkc4KS8doUTzHmk/y6EmXG9H0htRhT/v/KsFbYeO29nAtrZxpTeidYCXe6dBstyEP6zFVd20Ob61B+wjCC65j5SiXJFDdzb5zqOMFidRhUQcpTkDbzszEdoFu0h90vI8bYQHkPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AeF+PL6IIKHdhJa3OKigplY3uFk6JAgu2Wz/nlMyJyl2aBwrr1bhlG5/R7k1j3Iybi5GbHyOKKXdwMXV+2U031ng/pneLboIb+UqEitSDR1i9mXGxCFoemZqn6+mSxYPhkKKvx52937InXSvbePXPwDjvDI2HKZPAk2wvZ6NPrPWnLAWiDPSfn403RRYPmPNFa+qzIVwDfIDROHhuwaRdTISvWvqtEpMQ2FR/IiokTE2FPm6ANC57CDHtW96xIqtA+juDP5D1CKTceGFRJbHHnSkduebMw9Rbl8JNlPFmWCKSx6UeAfXenLyOcYPiUL7qXYH0KMGgRB/urHNDnZ2yczMFxgh2vkPlDePrNP6kx3iYzX8z76CD50O2DgRUHZZ21ewl32IPk3hRF9WBh0ez1iCW+ZZwLYi37hrA90QeBS+4BiezN/57e6B/20yriJX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:06:33.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c400530-06c9-440e-8004-08df2e24daed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

From: Sandipan Das <sandipan.das@amd.com>

Define the LbrExtV2 KVM feature (CPUID 0x80000022.EAX[1]), so that KVM
can track it in guest CPUID and advertise it to userspace.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch. Split from v1 patch 2, "KVM: SVM: Add capability for
  LbrExtV2". The perf change is now patch 6.
* Set Sandipan Das as the author.

---
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 89345af0f7ad..8cb8af2d8c70 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -73,6 +73,7 @@
 
 /* CPUID level 0x80000022 (EAX) */
 #define KVM_X86_FEATURE_PERFMON_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
+#define KVM_X86_FEATURE_AMD_LBR_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 1)
 
 /* CPUID level 0x80000021 (ECX) */
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
@@ -148,6 +149,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(SGX_EDECCSSA);
 	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
+	KVM_X86_TRANSLATE_FEATURE(AMD_LBR_V2);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
-- 
2.43.0

