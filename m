Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794982976;
	b=ZoPN3uL2/NAuOepONRvPzyP8NJwWqUrn9fihJHC+p6E6hzFEuFMpw3mZWt6D+IBDG6ZX
	 NCE7V0AFo8nqpxDkPn21QCjMvOWUe3/Xt4+aZQfz481xaUwWOjHOz3L/Q5mPKPu33axAD
	 j88FOOP4dRQhSTMzfel4WGgQds4T1Bmgyq3gS8wBJI+jSqIVntafrkvhx1kP+lWX4AfHT
	 Ay5c14zBFSf73936CBJJagke+ed6ruswnOdyJB73pvCOd2asdgLtz9EdeYQIY6T7bZuHg
	 fdyMVv5GUJ7NfPra1iNF0Ln4yG0YcsNb6BOEiGg4dgJP5FYm4A5OCj4qqVbSwmFpJUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982976;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NwFY9JKXIhc9qtEfHK23P9LsP+f13ZF4zeEyPN0y2bY=;
	b=r9jSlioaZlDGrktutnFGAhJxmJngwcwMcS5yylrtsWQxd3CKgCav6+KEE33ZbNXdAH/W
	 AgURGLP7Oh/ivmoxKu+fZmOgE4jcni+zz89C0XeiK3KqsNg6Lfuq9oUc3X7hGGuxuyICJ
	 Bhpg17fVgacNaDrJnv8qgEtxPw1X8HTDPjcG57FingyQ43tnVK+0u9E5mIP85qiH6sLK6
	 oVm1wBLMGO29zFpEF55QRHNb8bMcb2smOg4ZvH1NOvDbfLnbNo4vBta6accGthGerzzsJ
	 FQAuHH5MY5/X7Gzsjv908WJQJkWgh7iQEVrM4B35Kf338MmzLlMINNk0FpXp5TdbBSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LmPIO5yB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139C606A336;
	Wed, 18 Nov 2026 06:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B139C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LmPIO5yB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAHcKFIhou6BuDgQzPC6jmt2OK4O190pbAlvljORW1ZVKpwA6yXdRImAofbbZMSL/z5d7ZszGVkSKZDBwKUiobOx3c/s18ab5kWS7n1Ls2cqcP4JRsGYddTxy6DtolDh+wtcgmH0IoeeaW+vU8jMK4LFgFVTxTSMj64FkI01LXnES9f/g6uuGtH275+XQn2WNu18l7W8q85CrftKrDlAsum8SpQ1qyeD3I+IS66bc1n/+3zgli1sDvulKVqtmDyrH4ukGq9bFQqJFL8gr3g1c3Cnu0I5sPiZDup9hKBox4AxPXNIj09bWQUiVzolqLv+bdye2yDnHuDPhuK4hQHhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwFY9JKXIhc9qtEfHK23P9LsP+f13ZF4zeEyPN0y2bY=;
 b=cU+Gwu8yAkHSgDatSqmveFadpmW/GREFXU31Uq9Ccua6kBQY4guUqc80fapYqcz8g0pI5kfOp9WnTicJCJe4xnsZsLoaLPWg/bZan4EQd4MtwZq39bET0leBuvEvq9ASU9z5FpnnLGqYLRouxcLsYyKJJhVSbr72+vRihfVzpa1Iye0HcRwJA0RqoFZMjGfH0FSDvdQEupP/fjqr/0i6+d/y3QNpmd3nJGXlfnhBX5LjpqMKJIFeDD3Zm92J/q7ccQu63F0qv2toZHFVduHmoekNLCkgU7G58kTfaOKbGGQZhnXlPQ4DJ4zZYDvSGFvDyC8ergFBWoAQxzKftRQrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwFY9JKXIhc9qtEfHK23P9LsP+f13ZF4zeEyPN0y2bY=;
 b=LmPIO5yBjFITDmFsRiZV1FFoZHOw1CP52bs3tP/3NzQyo4D0NkO9AuOmaZdj0Ldy7JGRd6d88Y160KQUJYJiHfcVAM9WhGk5KA+m3FPIJ3/x1bVvV3awGXKvXnBmAXUWLmhaSZeX2vpNd5Mmi6zA8h2clCpkdu+oP0qxod7P/SQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6324.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:22:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:22:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] RISC-V: KVM: Skip steal-time updates when run_delay is unchanged
Date: Wed, 18 Nov 2026 15:22:42 +0900
Message-ID: <20261118062242.2914385-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118062242.2914385-1-den@valinux.co.jp>
References: <20261118062242.2914385-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 043cb4fd-4e35-42f4-c05d-08df453c60b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|23010399003|56012099006|261022105027099003|261021121427099003|10067099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+a1JoSfp/CVG3NFCNmrQu0fO+615ydaRRGfQabuKVqKLGRWJly8vN5oSyVoW/Cu1L/zTexP3Zxpy+1OA51Dh5ZDzdIMX+XIjFiM/dLbZnmTfgKnqDkF8iB2CFr9Tr1Z4lmjaZL/+wIAuedEJQNJCmKHAW+P7Eo5cq8d919M7GhzgoNLEZ/w3p4eFVefNOv3fwUO9Hoh9ivsEDBxReE3IOdDqxp+zhcxt2c3XOCJUl9Xr+2I7Qe7dqykcnM54xIgODDKU1qMP4/O7EE3DTlTuDttYwlBEghQeGJ/39su/v4102d+nlgFvI6e4n7RFV1lluNCOc5XC8ZSmGM15ZWxf0E8mr2fgZUrrRex5kiMHgq9+Di/KVhldcCEK5A1uv8jlBgTExMJw0wLnrw7Saf5LX8KTg+DTCGTrGOdgynRJUrNhyebYA3cXCkmIi+Bmcjg29U1mGA4nKxY6eZJAeAJbWBP/dnlbP8/aX6Pg/9WFKsjYNvmXqISAkbnxtZsTbsAfY6h+y3LsW/SiWx22AbcJ5nCIk1lnXNULm8WmfzxdH6vD2MNj/a5n6S3CpLjKFCqcnXTUCLg90oFwcWlqh+ScN0+EumNaQOXRgq25Irl41YAQCWD6tVfNrr6scNrurbYcroZBbXhnIz/a0ucHgvINdSioKMJRDMpJY65KU6xMMLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261021121427099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oGrmiOhEuVUe/W1s97HJPXNhaLSYJUE0FcgKDjwf2NWsO1uUBZnk9/giGOLH?=
 =?us-ascii?Q?E+U8k4gOEAfaxeUT3EtS50vNtrFKDwsJzPPTOthJ2hG25emFKRXgHEVSnw2J?=
 =?us-ascii?Q?5UMqv1sg/bXA6e4eSJTdrFTxKlNStmplRKEXJRTdwxDyKdJ2Mpy6a8eDeBm+?=
 =?us-ascii?Q?fs3y2HBOb7f8JKPwuCIstr4zQs0bHifc5wGmTH/SBBxgUHTN4wbODubCEcWq?=
 =?us-ascii?Q?fOv8EB5qq6/vTOACq5j1CwnXPwUrjewIo987lKToW4oG63K7WRqWAS3ABAwA?=
 =?us-ascii?Q?TzinOvSAJexc9DB32psy2bCC6YrhsHpCnnR4h70ISKhkwb5SY0lZilBp9T02?=
 =?us-ascii?Q?nvV06ZXLMc0bQYYFNPP/zGCqFtt1qkMa1qalIgzKocm30aQ3JPsWWwcTIVsf?=
 =?us-ascii?Q?F70nkSwUe55F4lJwRXZ3g9jx/naL0r3TylF5f1IjyuwKEr+L5bsvcVztYd1c?=
 =?us-ascii?Q?TLUHyCrY+7TIaUJFYqRNHMoK1orH26mNbnoMJ5y9qOphq85FFyBkWpw8VMpC?=
 =?us-ascii?Q?+c83DIQrT1cuJESBe+12Pa3uG79fNumXBuqpnue8l7gg09u5UGuxdTffEfFv?=
 =?us-ascii?Q?EIpcr2MyaR/NPCB/yHCXbwkS15wSxNNnzGVELgW9V39qYtuCni2JYT0G3wO+?=
 =?us-ascii?Q?zGfpvW9nnettk0uVq1hwm8fxxAyM1zE+IrC5niwawRwHO5VxX4DIgS44C7/v?=
 =?us-ascii?Q?wt9hGV+uzI35WqSZfqNP7MB3fR6rUp4nBIi+/rLt7Jzv0iFF94uIg9YNF2n0?=
 =?us-ascii?Q?w+Hqq1luG7pPX0BQ6lZd0PJrITPdVH/J8p+4dzVRD+jsBE1YYkj1dX0Bj4Ci?=
 =?us-ascii?Q?neT0P7/cXHdM8U7M1tlyo4pPH0hpXtW4J1edUceC+fSkrHzAClLJdUGtZuPr?=
 =?us-ascii?Q?AbDn7898PMU26KZusQSLr3avxR5JEt8H3VLidpzbjJzjl4VSa0RlsGKE9bqX?=
 =?us-ascii?Q?D9wxLK5XUW296bWOHKm6DhvM+mjlAl5meFDjLAey9JnrxAyVCxdWs64f3++l?=
 =?us-ascii?Q?tXAP52DEsuLIhC5Ichaq6+vus3F4xEoC1fv62CA84KUa40Ndw4jl1U+IzCHZ?=
 =?us-ascii?Q?kfaVAKFPJJM+xM4nROJUeEg7+Nx9K9982CaTLUJeuI6C5YAlWhj0ZHGcHjl+?=
 =?us-ascii?Q?P4QQtW8qahdEtqNSb3P2W2deLIfPXDhHISCfuMMJI5BfrVsglNnUNUsvIrbE?=
 =?us-ascii?Q?zGFqeiRgTNadBFPU57skCmLm9bXafYhLQdN2Xx+VnQbHgAncFPdAmLYHyMN1?=
 =?us-ascii?Q?TnfMQTz6EkARcGdNna18x3QBBpojiO0d7Xg/fOfT3fiD4Cec+dzNVDoIajsJ?=
 =?us-ascii?Q?H3TzVmGWrt8Iv2zKrLc1Nio6gbgQhC7wRc9Mc4BSCJXGgXkHjtFnkQAtExZQ?=
 =?us-ascii?Q?s8CDvuftTPFsZo9H/4aMPsdsmk1vphhH6dLZdm1OUWgTRFAvlFpgaCGbsw1w?=
 =?us-ascii?Q?d/wmmxD9OPi1aVxFgQj49R3vMXjr30Dn2VgP+zUgz3Fpoiftzd77cpu44ves?=
 =?us-ascii?Q?4ESItbxrftvl6mfQPLfPE0kKhUIpM5Hz9joAFkt/m3ba9gJ7jERTsb5rQgMX?=
 =?us-ascii?Q?lzzuFhYTg703DQ+qMA75QunX5c3jb4pTk3z/ODV1kdcSXsFz70rhmb40uyIH?=
 =?us-ascii?Q?Rj/PRqMb0ZnQgJaU0x2AJ8QXpqumIUtXwXabftSW0MHtMBviHjkT8NppVsjr?=
 =?us-ascii?Q?WU5ZCfZ3b0SP5zcCl1Vj/N3ZoabgPAQVPCG6fg2v1qqYuzix0e6yxf5ngwVC?=
 =?us-ascii?Q?eSbYfjUYZcXE4xWGL5JtDc2gf+fVSSO4rc6oDIK8Brk1mvpWNN3R?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 043cb4fd-4e35-42f4-c05d-08df453c60b9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:22:53.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuHGnNSD7EB2pZObyo8sHh2oi5xCYRlMqRAHfcyrqrL440kb/fUKECFNTS8ACG7IeTe+tTxp1en2k4W3zxZaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6324

Check run_delay against last_steal and skip the update if they match.
This avoids accessing the SBI STA shared structure and marking its page
dirty on vCPU loads with no new steal time to report.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 arch/riscv/kvm/vcpu_sbi_sta.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index cfc6f22c3e33..8b2499876fb4 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -31,7 +31,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 	__le32 sequence_le;
 	__le64 steal_le;
 	u32 sequence;
-	u64 steal;
+	u64 steal, run_delay;
 	unsigned long hva;
 	bool dirty = false, success = false;
 	gfn_t gfn;
@@ -52,6 +52,10 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+	run_delay = READ_ONCE(current->sched_info.run_delay);
+	if (run_delay == last_steal)
+		return;
+
 	st = (struct sbi_sta_struct __user *)(hva + offset_in_page(shmem));
 	might_fault();
 	if (WARN_ON(!user_access_begin(st, sizeof(*st))))
@@ -66,7 +70,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 	smp_wmb();
 	unsafe_get_user(steal_le, &st->steal, update_sequence);
 	steal = le64_to_cpu(steal_le);
-	vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
+	vcpu->arch.sta.last_steal = run_delay;
 	steal += vcpu->arch.sta.last_steal - last_steal;
 	unsafe_put_user(cpu_to_le64(steal), &st->steal, update_sequence);
 	success = true;
-- 
2.54.0

