Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348A3B8BCB
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122444; cv=fail; b=lKxMn6VcbtPa9e4OZS+FaLQhOY72HnaO84OhsrVdJ4I/4cOEJOUCqvl6lbd7gZ2EGIXWOYqclYZFzKQusAEiXnO1rIioqMNqOv7LETHY1ilUgFiX9n1sTOiEYDfvoWwN5fx2n11whWj5lGPWz3W+nN8DM5BLQITDUx9WGrAF9aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122444; c=relaxed/simple;
	bh=1hTqA3hBI/e/Z0VbnPH0kDeGe2pSvdioSrZy2sscZEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJNdL7WBx/AsTRdIYj24MbEp1jAxhh/FNGUh7RiI/44dKc6KonjvLuq0TNJAuZYtzUmUaRhYnn7VHvdFNIPfSWhbxkluKiF86wVMHBasfSUhlkEqdBSB2QqoQ9HxyAVZInhmMKUnmGKjTfiLy2V4cJHXw4Iym0j5t6lyuiDFZ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SEtA0REo; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SEtA0REo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvPl6I2F+iwUtUtCrI4blMzTP2qBqdwlButlaKqy2VmNXP+vrYCvrDK1wm1jmrgPW2kqI3qo+DVRm9z8n8d2nunvRK1gYX982IVkEtN70UeHK/RXlTnsG4FVO9Ts/Hq7zRpr32rdy8yBYrqPUMJKKJMagjMykAhnBBXf78lP8Evyn37LoNlON/SIFipc8knSd69bB9WbbS7ucervHc7KJ1rrvfBtTTRCbYZwk9BpQh4eb73M6UNskELL2Brrsxuo+9QMW/sm06ZQgbPJIjb5VTd/pde2K8mJe6fBfYzfuII3oV5itHCGJQiguS22lscu+VsTKEtuKPlRVCyWgsFu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo8SrdSr6VlVV4MD9TrQiAVKfUVWUCyU512Bx9qjp0M=;
 b=R4Ybl6zmdCnpVMfNDJ6bR/jnCTSIv26I94z3yjV3kpYYiQ29FlQNTmeZ0Wd55mAMjp07+qqx+jje5gzXyUdFuOaqCawV8H00CpE+JY5oUZqmbb4h7xh6rAxooB7f7EK+Za10UoV7/tkxpKZq7iOA0U7aI8+DUdrkO7hszv+Ou9qTg/tn4ZiDeyjuHro6zmmCYk+wsrBfjIqcxNLoHww8ZoN30eljwi6ZeeCDGCXg3AQ6FL8juqTSChqDUAkyNgH9UV6tFvFwigkx/JvPz1Sg4IwXPuIg/ByIw5QW2wNHHFRLSq5CRrdgIIkybBtiYrjfz0m2OWkBMrBMm1FsJF0mCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo8SrdSr6VlVV4MD9TrQiAVKfUVWUCyU512Bx9qjp0M=;
 b=SEtA0REoDqPL0g6oj+QYmjmNgdbIOpmC5GwLzfsGMn1rNQZbDE8ccf0j5pumOH3JSK81X+QqB8UGsfM5aGkm245RvJ4s/uVRbyZ0Bhv8BmTiKLssfjdmdj87lTzq52p5NuMKeUws6dMLPAMKOqpEvSEGjmFairxMmXh8sgr89+M=
Received: from MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 06:00:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::2d) by MN2PR01CA0065.outlook.office365.com
 (2603:10b6:208:23f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 06:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:37 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:34 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 1/9] perf/amd/ibs: Fix race condition in IBS
Date: Tue, 10 Mar 2026 06:00:13 +0000
Message-ID: <20260310060022.15120-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb1e2a2-2c0b-4215-50f0-08de7e6a59c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	tLdXol18+QqwwBvU3Hz9quI3IsgH4oSeH4xTO6tTJK1BMgELlLOvINWMFZMnznXlAMZBFpPa/pEMHP5Cec7x9jnHoRQMNsQrqTj64nFAjU+lFKjCa4cFGKTHIWED6bwpxUtwxooh5JPP/vtkFfReHmekFSQelqrHomNSh8QV/v4CnYUGYWRqQLZdr769jOahK70NGVm1QMB2KyeKDMrl03c1e1kOqz9umU+yuS0rpIbb2wIeM2przXMq2C0pgdUTOvAwcez0+8EbWBh9olgD4FN7etn3cZhvT3mwQVIgxHRi6O5sr91N3id58Zps/s4wFS5hXW1NiKft5b/AAbUDRJONOLyk7MMsKUCI5cpOyRf2OiMH9h1C6bMKAeQ5duJLIsDZImds3NTCk7Q9GTIpdCogQJ3Yp28opgj5MnVAvTSpdVy8cfV72X8wxA7j8Vueb8eKupxlqs2uzpXTxNqrQBu2FMJGv25UK9z3yf7JeMmC1Bz8uckHq6aOxqNK6QhDqKenZqmKrtWcgAD4LvglmKPwyx6AfdFH8fjPwX0sY9IW/pXB812EVzCcC+h/rycxihkKvd8F1z8QjDD5jg/GfZtJW14VTfEWr0VUjOGU1RQDfEXdQLEsQXg098Jac/fA4rFA/R/1pNKu84SJZgg2lrxd9DkAzkhNqad9Lxed5j87pcNfeKURZmk6MLaa7ej31FcF8YzAZWFplN5z2k5p5JF4+mA8KjZ61vkW1vdShQ+62XFogTvt7e35sTJcDZCOPF/5S5bX6z6U21yXI2CedQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2ie30cJzjyg7gTTU3n1rvSPEPDQz6F5m4ZNcK+/eoX4r+Jj4x34JF8tvsF75hga7Dk1KsSI/AXfKUmUMgdfnznv453vJ6+kBzt4n6p+6pCmIdQescu6VDkbqw3ckTmApIzhgcPXqnMuHxoqRHXs7AQP/ityt7lI0a0nX3LyYQRJS7R/e1wp+JejEacKwDPv7KEjKvKt83QJYali7oF/Y3lAboP4Xz8UIkFpk/qC0uKr/uL324vmSyawV0HC1x3JPmI7CP0p030/yGxNhxeDwpwe01PiXndyOHBCR+nttw0K+3hjVbbGmhZhKnfYhLHK2ljrGxbbpDIHmT6VoGhrknZGMQHzcDABP+DONljdJkTfmJWUOzKyJoKUrgU9zv+filIvH+klPley8Eyz0GVhBv4EagzS7B+K1gFSxyvmEGOQZ1U/OIHjTL6XWTP9EIZWB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:37.0285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb1e2a2-2c0b-4215-50f0-08de7e6a59c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Consider the following scenario,

While scheduling out an IBS event from perf's core scheduling path,
event_sched_out() disables the IBS event by clearing the IBS enable
bit in perf_ibs_disable_event(). However, if a delayed IBS NMI is
delivered after the IBS enable bit is cleared, the IBS NMI handler
may still observe the valid bit set and incorrectly treat the sample
as valid. As a result, it re-enables IBS by setting the enable bit,
even though the event has already been scheduled out.

This leads to a situation where IBS is re-enabled after being
explicitly disabled, which is incorrect. Although this race does not
have visible side effects, it violates the expected behavior of the
perf subsystem.

The race is particularly noticeable when userspace repeatedly disables
and re-enables IBS using PERF_EVENT_IOC_DISABLE and
PERF_EVENT_IOC_ENABLE ioctls in a loop.

Fix this by checking the IBS_STOPPING bit in the IBS NMI handler before
re-enabling the IBS event. If the IBS_STOPPING bit is set, it indicates
that the event is either disabled or in the process of being disabled,
and the NMI handler should not re-enable it.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/events/amd/ibs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index eeb607b84dda..09b56bab510a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1582,7 +1582,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		}
 		new_config |= period >> 4;
 
-		perf_ibs_enable_event(perf_ibs, hwc, new_config);
+		if (!test_bit(IBS_STOPPING, pcpu->state))
+			perf_ibs_enable_event(perf_ibs, hwc, new_config);
 	}
 
 	perf_event_update_userpage(event);
-- 
2.43.0

