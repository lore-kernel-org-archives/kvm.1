Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911C471D16;
	Tue,  1 Sep 2026 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250972; cv=fail; b=laDmmaScKvptBrDetZD5OBlmPaCG5Opin0xW+2DXnofs2hsdwSA/YW/ZEZACVu6qbJtVnyLDMM9/IYkTz+TUW09vmhMZYKQ2YmW4uOLLOdto8Xw91nSKYq+x2t1P83YxG0ml5KzjJRhMGur/lSOfbcCY3eljKKhBURS4ekoWLDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250972; c=relaxed/simple;
	bh=G9AdPpR2bQ438NY4pdK4d0AAgv9aWzr5zxwaXFARs2k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LIpCBhqKRXJWR6K8D2MPPj8rqGhdq5I1wcbFEkyPFf16fj2zQl8xL1lbnvkGHkfvGlo7XUQS1RYdcqnPlBBWynnLTVvbrnttw1vN+15Xfv/7dpHIFe0PlNkaYTO4U8/5afGePjzBK7BCZ3GVz8YCxiMDZEoXfjcqAimnu+bV9gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5CcntkkY; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5CcntkkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzvL+qAtTWHii3gV6X9IdS+5IZBzmuSlVFQW+ihQojCA04gsznYjkbuBKZnNdFaH7StKZ36M9+xMW2xzOpUA9EP+g003Aqb+KTJNky/Q/Tvtcu3sTaazVHysFShWXuDVTKHYp++v0+jLLsPEgm5dn7KM9SlvAajL15Q4TsDdYIn7U3nYMhghcbATtIqBnqoykAVRPHDNd3AkZ1X0Lb6yu2mlXlelnOOicnD4vxwcjj1ERsl4qwJIwVZuMEj0djQdPzJKgfWcX97DH8hVSOo+el8LrZeK9rg2tzBusksaq2sKa+eTihxGezT61j+jUt+mO/h3ErtC/4vidh4UG8kDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqiv1j/MS6G9XyOACaeKfRMEGqOMg6w8KShIC2ToeM4=;
 b=n0B6YUzcNaSl8o5p/B30ov1Wi0/s7Xu+21ov7aAxlg9vTRsJSU7i5u7tviuZdsSWAyHZICcrww3kLyQ+F+FArU5XGGB5IbOSNmUO5u3aFWLCcSVbPwP8cwPq6b1ojDpbHyDPOfS7VnNg8Rbsocq9ez13yOs7j1z7qHibDljYX8DfniipwgYCKvwm4HSa9Hm/ts7bkGkniPPS/sHCgUe52eVUbs+zTT2VLSdKNLf747bNk1zHm9YAbxQr9xIZ8Ex3qA+W+7f//gjRkMsYcR00N3Xfh3RCVIuwAElMCNah9Vq4TeMqICkmYogLBHH5VczL5aq92VKJdkUsv8GgGDsT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqiv1j/MS6G9XyOACaeKfRMEGqOMg6w8KShIC2ToeM4=;
 b=5CcntkkY3MkYs8RFnYUEhiPj0iIJOPrCttcpjHh4ktPLaJWKBVzyWf1a+1L8pg70arKlY9GoKNQIKquwCF0oxpylv8IpX7AFPEeGdxNfrMh78GODZTOYc9dLOrBfIQEYz4uZ4+7SCmxtjMcLs1vPdR4kwo4EcIdMyr6lcUfI7oA=
Received: from MW4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:303:b7::7)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 08:22:48 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::92) by MW4PR03CA0092.outlook.office365.com
 (2603:10b6:303:b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue, 1
 Sep 2026 08:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 08:22:47 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 03:22:44 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH v2 0/4] KVM: guest_memfd: fix NUMA selftests
Date: Tue, 1 Sep 2026 08:22:37 +0000
Message-ID: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2LlmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDSwND3fTc1Fzd4tSctJLU4pJi3bTMCl2jRNNUSxNDS6M0c0sloMaColS
 gMNjQ6NjaWgBMdP3bZAAAAA==
X-Change-ID: 20260901-gmem-selftests-fix-2a5e94192f79
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788250963; l=1372;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=G9AdPpR2bQ438NY4pdK4d0AAgv9aWzr5zxwaXFARs2k=;
 b=8LbWwJMtmFe/oXl+R9ZoyVohoae6Fx6GSu3Q7mQKG3/NbSvgVykcrgkShskhiqqHflQmwU2Jt
 FFh2uNSLdAlAyHtD9wbt0RpRv3p+mVhyp6secSNzi3rNCwPlqQLmHSK
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 682613ce-85e6-4e83-b9df-08df080234e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|13003099007|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iPss1w1Foml2h3t5oENHDHoutUGLI44aDuG11Spqt2eMKaeNlAnpZ8mLxAqbt5anBbsqg0w1HIsIjdljhkJpyOZNBwWrvdpUFVH4U+H5Bvb13cbCwLepdvSaJlr6r/C+GQl0htEpbYJoRLer1uYDBIROkRfjn6iEwSRWsAnbRqt9INOY+ayX/AA/+kdN0RVFaXoTZVnwZpc2AzHCoNvZktJXky6qEKLJ67YiXQsakFWxrpWHvaGnliSZ11vTF6MLrBLalAnt0v+RfxpYwsrGX55v8Zf1xsZFGLQ38pzb2Gj0H2OXcmmHvtwX6WmTMk0lMfzG0PuY5iWN4YNWmO8VNmDGsHwallO5IzTA+I52bOec6pjTWfTVWg+NqI0YAXbSV2Uy+YR/K07IELMwpxg2N1TZaTCBXKbLFnBJjDyWLpbAL55YMr/iuAhvNdZ1S/zt87O9s2UJHxFtX9XflCGN/psibtYAj7ERIF/OvuahqCfnsWMzneEXpSBIPdNFi0lElU3uvy2bzO+tzR4CpB4mPUsiYP+KSMHklA/mjPetLHkzjoILMFJFlzW/Fp7MgjsuhBfi1N4HhBUfh2BHAIg6goGw7rqIqJvq+t1Hvm6Do0XEWC5PFFQ5P8sbr1B2aAv7anEoJ6Y8/biYDyOMcBAkKXFId9vAESz7e2kOurQXrf0ZtFmDNZLA3kqWsrW+5mePbwu+B6e1YgeUIWBV9dDE0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vhIGldLQgUuRu9Tam/SgZatR5DdZedpkYU10MO8FkYDuVi9/W7Ui5Z7xJoTcPh9WFdwsWLwAaQT+oIAT/a64pyjKnJ2KJsWNRDT92LBDO7Zt/zW4TyK24cFyu/G7M79QBR1HW8t/laUG/Mxv9572iJ4BCkKfb9wRMf0CYLmSZQs1L5a/xyw0+KnEwTNqIQpbUcuCkhyMI4EG2PLdToWdKz8vbGctDuM/hqFRtmKW0qik980YsFGxU0FKR/sG6sWPNoZto3hJ5Zdkwy7h5S+UuC4JTTvMkT7DMLRC++2d/YgI+V/ebNg7SOy2n650lRqYZvWz3FYspsXtwJajEfNBqsrAPR7MJxDTsvipWjVBRRx1dfKKwb2Vlk+m6DVhUhC5GzAE3/jBobdn01OTM+/NOKCDb80PTMrCEhwbkUpm3cyzAZIZb5CYQMKOWDLfIzZi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:22:47.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682613ce-85e6-4e83-b9df-08df080234e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

NUMA selftests in guest_memfd_test assumes that node 0 and 1 exist and
have memory. However, nodes can be sparse or memoryless which would
break this selftest.

xapic_ipi_test pass the nodemask size in bytes as maxnode to
migrate_pages() but the syscall expect the number of bits plus one,
so the kernel was only looking at node IDs 0-6.

Tested on a 7.3-rc1, AMD EPYC 7713.

Changes in V2:
- Split from unbind race fix. (Sean)
- Include <linux/bits.h> that defines BITS_PER_TYPE for self-containment. (Sashiko)
- Link to V1: https://lore.kernel.org/kvm/20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Shivank Garg (4):
      KVM: selftests: fix maxnode arguments in xapic_ipi_test
      KVM: selftests: use BITS_PER_TYPE() for NUMA masks
      KVM: selftests: add get_numa_mem_nodes()
      KVM: selftests: use allowed NUMA nodes in guest_memfd_test

 tools/testing/selftests/kvm/guest_memfd_test.c   | 86 ++++++++++++++++--------
 tools/testing/selftests/kvm/include/numaif.h     | 53 ++-------------
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 14 ++--
 3 files changed, 71 insertions(+), 82 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-gmem-selftests-fix-2a5e94192f79

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

