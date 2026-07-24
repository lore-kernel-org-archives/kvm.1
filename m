Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C044D693
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922742; cv=fail; b=ZC6BB6J2iCSIRIfrcQ9c+qpFy3aJ9g0bYMA9plKU+8cBY2Wavyjyq83zkTG2QlJDPyHTaghHLVDKuDRs6z1ojQVmD4YUbSklGmSA9FJ7WjBKDrxxPzbSZ5vHFNJXRK9u8BvtK3XwIVWdgU4t6H2UlQAsrVZXpVY/1lPMe9Zmqbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922742; c=relaxed/simple;
	bh=lBFs53b/dWZpuIjdGTWu3xEW3g6hoRzDjtNLpc839KU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rl8xsldjAsFKT6GQKFdfHFqO6KuYji/fZgiMzjbbkJ+WYgeLgvp83fuKF6HcUekPgdDU2iPteAdMBBwVlJfUbmIbxxdBOkyva2jFGWAFDyV9+R1mNeyqCUBlVviDr4Sq7UrkxUdJR9Q3KV17JQkwrRbRkhFB49OoY/rEjouDyOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rs5e9oVq; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rs5e9oVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq7QasVedUrHD+sq4zbr+bZCc07pZd4IBYGpSwW1KqEPrb2XU3xLO0+zN8JcGluTaGxztlDjOkzBXeK6rFJQwZlaongl8QkwaviCUT99msfa9GL0zIzQdGq/Zz9WOl1lxLeF7cBHHTT96O6yF+g6T3pSrKKkNmwsSAN5MJyJGfQZciSFZQAoDCv5JwupxkW9hx/VIvqWBJKB39b2FD5kiEaa+WMAkDXSTmq6Lj5XOg8oI3cKwd/IrLQxSTgXVzKvj7OiscAJCTS3S1kUSVn66DN5JsF63Y74x45/wp8zKqBQTesjwq+CQIHhJ64jq+EGY/AgD74T/fNr/zOix5PKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kKjomLKKDWYwGk1FAtsZVvrhmH/GNAf2gcC5BGTSzw=;
 b=lS9Nt6Dty1vkV+StVSIkCDhVBpMJje9twT9fUpBkFI9BH7HtrOlAzjKBOPOZV5DssP9irOtaVELESMfXvMy1kJp/sfvO7RA0AjCeeU06qTCj9VuFB4wfyh4/05UEnDtBau5aOZDG1L6dw3a+tHzaj0/yIwXHK1MyUR/D3grXW6SgFlnsEtv04DAhN2qM6aw719m54GBbd9eLvAVyjeY8/75VBENyR9tAGLwOg8eBUks8C5xmPMlVjLAQDk+PAEsyOwR5fHw27YdOiclbMz1rfRIfe3phbVIKQ5JZ4K7lwcMrKpSVYmT0zLSkfcVen8FrMUkuqjTCDYE80PWY4jfIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kKjomLKKDWYwGk1FAtsZVvrhmH/GNAf2gcC5BGTSzw=;
 b=rs5e9oVqcFOKN2t2z2Ib0JLNnnwah6Vk1+P5IcsM/fc2b7cZ6ig9q6R4pirgMJL2TIvhoD0c77yDnkZ8HxnZ1XlEqcEaWy/1dB5hVrqQ/j7D5kdQ9cIJVo006akfao/+mZFStkgf0ug073vpUaN5hWRuflhtQUqTrJvdZCp2CaM=
Received: from BY3PR10CA0024.namprd10.prod.outlook.com (2603:10b6:a03:255::29)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:52:14 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::37) by BY3PR10CA0024.outlook.office365.com
 (2603:10b6:a03:255::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 19:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:52:13 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:52:07 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 0/7] KVM: SVM: Add support for AMD LBR Extension v2
Date: Fri, 24 Jul 2026 19:50:33 +0000
Message-ID: <20260724195040.630468-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: afff4ce6-aa23-4b12-61b4-08dee9bd0ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HKLXVkfbbSJBY0SQEQl5fa1pKdlvocmwzMyiGS8SsFRJd9dq7uTiMx5GhwN2kwU+DoTvs01gYSO60WwLpz+NOfW4+Ah3cuIKh53JdIVWh31Z4OtVZokv+yY/vZjTKP5iUIwXdkqcOxb1ZXOY2Go3V6+6drLmZGld2JVfw0DInC4RHK0A/4xQJDqZRqzq5/+a5d5EPxwtJdPo1nC3gqocXzD1FYaHSG0VVIEYp590KtMQILJyJCkZaRwrvS6QK130Cx/G73fqfxyyUWxi8aSPo4wP5ye9l2PfFW0Wr3JQN1USfNsH9qvi3HssIFLI7QfPS6xfjs5/6O4VSXqQbbf6dh+XhQEb8M+jIodvQc2AV6rvHxetMpj+jYi5wqztkC3b4m4ntH1B+Dn7udCBHGNbRc8FI2eKGuAxlUYlEnSyMFST+ovpyOPlAHK3fF/Ma1qhZWC81Vp4YTRaC/PEVFIKgdWSZeCqSFQIq8RC3t7dmp7XHFAdeCKgGx9usA7Uj6PGHR6eWFEsdKhx66YbfQSITOnFvueJnHNxOwpF6K8XgaiFBtOWMDTxNUCXoRkcvr37ILdogTMpnqH/qKisKMuzTn54pLrVL+REPU7AsfF1xeQXXJdOWnUnwXcg8W3mOxWGZn9OGYqXCftSMUfZ0vYK2QfiK1edUd+JRNkgFxhwu8mmABk8V3zXPn4OLIEnALNoxIGFdFvfRB09QjbpEnr8EA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fp9BDcjfGRL0yB1+9tgjITmNA7RS4q4X11M/Dsj2p9JmdNJ1X7ecHoa4XrLYi2JxxLFgVOBjzb04BSSz6XagwHIYbwp1NdLA7W68Vgr2FSYFPCvCyP10tEKnPFg5Mq4nCzRtlbKkR40aTd6p/JkfynSd0xOI/qrTNzfIJfy6Zrm2jq5vMEc748feloOSnrZfWfwq13sf/BzLyiZedFPryA1wPkWU83M1gbXqBl5m0w1Wzg4biIjiN64u8ZPzKyl+59viGu4cSlwrsuUOBXgwVAbZwKQR9IeMSJK6gQah3+ITLOXlMmgXQG+/p/JAucFaYGb96zX6DAXWOFuZVYSTvJzp8omM2zxlhNfeSO+rp8FUZKIKHFCTK34U4oK7JN2qVAfU/BLIbwA6MI2fq9jhh4hf7QmfWK5JOWabBbDn2N1sbTCQKjnVpnrtFO/aFqDr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:52:13.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afff4ce6-aa23-4b12-61b4-08dee9bd0ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362

This series adds SVM support for virtualizing AMD's Last Branch Record
Extension v2 (LbrExtV2) in KVM.

LbrExtV2, introduced on Zen 4, is a branch sampling facility providing a
16-entry stack of last-taken branches via dedicated MSRs:
  * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
  * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
  * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs

AMD hardware extends the VMCB save area with fields for these MSRs. When
V_LBR (VMCB.MISC_CTL2.LBR_VIRTUALIZATION_ENABLE) is set, the CPU saves and
restores the guest's LbrExtV2 state on VMRUN/#VMEXIT, letting the guest
use LBR v2 without being intercepted.

V_LBR is enabled lazily, i.e, LBR virtualization is enabled only when
guest flips the DbgExtnCfg.LBRv2En (bit 6) to record branches. This is done
to prevent MSR save/restore cost during VMRUN/#VMEXIT cycles when V_LBR
is disabled. The dependent LBR and PMC freeze-on-PMI feature is added on top.

Testing must be done by first disabling NMI watchdog on the host machine, and
enabling the Mediated PMU framework.
$ echo 0 | sudo tee /proc/sys/kernel/nmi_watchdog
$ sudo modprobe kvm_amd enable_mediated_pmu=1

Regards,
Shivansh

---
Sandipan Das (1):
  KVM: SVM: Add VMCB fields for LBR v2 virtualization

Shivansh Dhiman (6):
  KVM: SVM: Add capability for LbrExtV2
  KVM: SVM: Emulate guest accesses to LBR v2 MSRs
  KVM: SVM: Enable hardware-assisted LBR v2 virtualization
  KVM: SVM: Advertise LbrExtV2 to userspace
  KVM: SVM: Add LBR/PMC freeze support
  KVM: x86: Use SCATTERED_F() for PERFMON_V2

 arch/x86/events/core.c            |   1 +
 arch/x86/include/asm/perf_event.h |   1 +
 arch/x86/include/asm/svm.h        |  16 +++-
 arch/x86/kvm/cpuid.c              |   9 +-
 arch/x86/kvm/reverse_cpuid.h      |   6 +-
 arch/x86/kvm/svm/svm.c            | 140 +++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h            |   7 +-
 7 files changed, 172 insertions(+), 8 deletions(-)


base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.43.0

