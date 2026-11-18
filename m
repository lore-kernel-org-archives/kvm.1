Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794982881;
	b=eIPaASJE8qOtp8X+7fMGikrU9E/0+Ea2iufgNHlHCR14FNy0pJ1l8K4Sf1zqtbO/dJ+R
	 80S0/J+vWRijSATzzOfCS81qFkSpg9HViijBWQZ22YbDkmtE8oGhtH5gDFzSazf0m1zPP
	 7ryjtSJefCK8KE0jZLZdvTpXANcuuThpcIgPNicgaHdh8WbQt8NvzLFSAPwlot108Z2GW
	 YOf5Wk0TOdoBLN2iR1IeH9YZFnfWdTOUyFTLu/pPW72UTIvsN76gEkCvMUekBkl2yRxYN
	 UcMBNhz3bd6kNVuo4jRNSAkkiM/Khk3v6nqLid5+zKn0/wfjMF6xkqhhohP06EvI1IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982881;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oelpM2mzKFfHexW+qARx7wbVnPdkEPWK/072/DUucNQ=;
	b=M3oQsO9Rib8M+p9v2vepnzdcEvSMD8cQG+L3EiAEh7AGUYBRgU1z8zJdUfjvcYnvaf7b
	 qE974rJ3NGFe0v6M+ebupG8IcZfzvp6oMnpFijCPkhPahZfCJfbJajXAkJyClKrjKwIK8
	 lw1SBPQVNuSg5FRtDlcZ+6s82NUR48x/ks+UsCcDfYR2jSApKL/MjCdx3u/92ULl/NvJs
	 2govLv1W3yyQQ++V+ttZP3toXza07FcvnPP1FDNpz1TYpEvs+jdTVotxnozKLt6UpzSS0
	 6faASDdofU0sGCPhVlpNSvwL6TlyoQ7NATv6IgKqeKqqZgwrPxKUlcB+6w5yhkWQGFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=D1sjfCr2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.105
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021105.outbound.protection.outlook.com [52.101.125.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A019606A325;
	Wed, 18 Nov 2026 06:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A019606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=D1sjfCr2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcT1tY+9y59iSO1ffqI76wNyxPvxJhg67+z3MYQXEuPjYlMHASXMqAmW9B7JkP2ARF6hSPLidpYDGK3EoIxwF5BSkmC34xxM7j8+fTrgoQ5IPTRyPuK5jCnzGipGFm4O+C0ipwYt4btgtI/ds95bFvYy6cxgN5YuQ7CP5RzyR+quT+MJeXPwMvxT3SqrVn7SZMFIxlhnaekyj0Oyc9BO3RVnGlziUkcNhx2K9k0vOaoO5P1UJ8lNdBcMdTJZ4JeDkIQ+QyHJQrhEJ62frz2x9L9/sMr3DmzWntA4kNX/sPA4KV7fGLwxfSbseLhjjEIz5xnQ7KLC/6wYklr0oG/VeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oelpM2mzKFfHexW+qARx7wbVnPdkEPWK/072/DUucNQ=;
 b=RZP2OqdQ7t7kF/rGAHNcNcqsPtLRTHjRdu7vVRO/lflLTBB5Y6nZuoyiK1iTkxJFW1uAeqjsdt1p18ygu4chxMocMgmozPbr+Q5xVTFy9et0OqcwqH9Gr7wY0iqAvV4WaQYhfJy67A+jq3zOAjI1x5rHrl4StgzcDCek8fjVcimNcu8lkB9F8dmv/4DFDNIvFs1UbzElh96oqLOHRppDhBGkATDo/5/0XkOepDv8WiWHMQf6NJ2gBlsZNeC+rM3ypkiXaxgGHGvDO+nurHOW9Ci2LHjeoY05DzwENMSxBoJAkBMQWSKbCQ4IJs7WARlAhgi8oKQfVPEg5hINAf4kWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oelpM2mzKFfHexW+qARx7wbVnPdkEPWK/072/DUucNQ=;
 b=D1sjfCr2zuwrwcIC1HybBYLlzpYsATVLbVY5uHA7Fyto230fDL7JgSEdcgFv+spCU1syD5rnqJBPVaUIb8+tzKVSlgnQpDkPm2vrWXIbC98iswi4zCUYCT2G+W1fT8HNDJV/YP9cChNCzFiDtCcDNsgg4gpwoFxrQ1eDLV1PUtI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6998.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:413::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:21:15 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:21:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] RISC-V: KVM: Run vCPU timer callbacks in hardirq context on RT
Date: Wed, 18 Nov 2026 15:21:04 +0900
Message-ID: <20261118062104.2912910-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ac737c-6d82-4e88-0e26-08df453c2545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|7416014|376014|261021135927099003|10067099003|261021123027099003|260925021311599003|260925021911599003|260925022911599003|56012099006|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DpOLZXA3QIvLj+5saobQT9H4ioVkmFZ0Jihhx4QJ8YHnje4GQs0LwWEB5saZAqlv+0VkWmY725DcqDt2sF5fr8Qou9J3l6RfBR/LQjbPj+ww6jYJ49T6KLrEAKz0h8ORR8PnqW1yGtMm+OQpTIVpZjwKQzi9eln8dzoOAzdGdNE8Ee4UYUV/9nG+jlWEme5daIN3xyCMlTdMRbHWIk2+0vxDhe+1oNOT2u79iEXHSsipx7Z/67XF8O65zdqKxgXZwh4adoKYO8CBQTwhfY+WYjoJuw2ipoiRW/FXsz2WfGe0Iy0dXpKazfzcuKhOjisEffz4VPyqoiD+Gc/xRE/fLLjlthRAzYgw8PTFn+YsmcVLw+9A1CJS5uNURng3MC6s8mFGfBe/fBa1TgBrcBN/Ejzyk3ojlnB2WkVNLKeP8NuXAYHsNPCc4/7qqELwlPqoQM4vpC6GN5esuaa8CV6nkPTnBR/LOIODt/utZT+442gHB3SWIgHtz5Dcmu+KUBjxWI73IVs0gDd7Mw7ujr9a2j+rNIQe4J0MlVpjLlE3QPXVNOXRIhEBrHPJv5gzrZlRmIF4RIwOUbtV8gwbk7dBfojqMhpMFEg1dfJAsmfKiAGwn5yHjZGhQnurlPtsAG6mtaZLmZWjQSE51cFp3f9f1i29aN1ezBDnsrXmV/ApSF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(7416014)(376014)(261021135927099003)(10067099003)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FA918u1f9mW6LVstlvUmVIfaKCHCgC7QvyzVS2prh09mpBmovHCeEDCDrJpl?=
 =?us-ascii?Q?cKBy2Iv5fqhlOeTAjAbFPHdPOo1id/TvAOrKKAKsmSX4YWhYlmyTGwdj9Ww/?=
 =?us-ascii?Q?d54IXG/c4h1ISROIEB/Q1oH30j93NIxjSqb17QlUeiWISGGBdhAmL67Y/AMJ?=
 =?us-ascii?Q?kKcoZDcR53X05+T7Hym0n5esAJj8+/NDSgh1aGV3+p3iM0uL1Pes7C3IKI4Q?=
 =?us-ascii?Q?b3nSZvRqFa3I3QmPBg2WvMFnHFUh0lUoE7yDYafWKtuJiyNroukgOOPbt33n?=
 =?us-ascii?Q?qcEYd2EjIRhOYSxDdCJS+3ECEcenitMb6Nsb+WGBa9wPRGUhyYeSQqp39GCZ?=
 =?us-ascii?Q?8IYTnqhihGs2u0I9uCGnx5RpQKX32HM/EWRHmYNRoGRl4aKU/F+G3OuEAFcz?=
 =?us-ascii?Q?CvlpsErKpaBBTD80JBkNKoYK41lszM2CecCL7svlP8ub+K+gCc7uQFsaIfjk?=
 =?us-ascii?Q?41oZk9kgg9gY2DAShUpnoGBWYdVej3O/jS/okNthMjpoTp7t9QSlKgSlf2lV?=
 =?us-ascii?Q?QxgZZR9b4yB7alqic6MMynIoh/3FfzRPrzzK5AMAHAGdLfwPygUoqcQ5wtaB?=
 =?us-ascii?Q?a5Kmu0uyko5KEdttUU79/Gbf+YbCsceAHjN4Kkbz6uFp/NEQ3oeNb6nxtndM?=
 =?us-ascii?Q?C2OZdiJHsjS28vqKsgJ7EtpprwEp09p9IeBMOUMRwUHmx6tg/axAFUuYFOnC?=
 =?us-ascii?Q?2gwWisoBGXOvn+upg4nWv/m4ZYWp2yF44gRRrFNFkTzFRxVoDy3m5PgpTGuH?=
 =?us-ascii?Q?JUIwU/u0xyi4UI0GvWLyjb93Md2nOd/Jk+HdJFud0pPbm6pyBQaHGPwfbc66?=
 =?us-ascii?Q?XMAhE2XWfkQxfuyvcSuPXFPxqRpXQhtCTHn/ailLvd9m8gmOWWc9bfEgNwtD?=
 =?us-ascii?Q?ReX58ZGPyzDSYn1UX1ioTKQgblgETeFKsO4rN07SUQg/RyIoWJkbHd4p0Tuw?=
 =?us-ascii?Q?pQCdyrB2bQX0MB8LA4ibeYxwMs1oVaWx8zhHoM405RqwJlVM6qLZXUwSay80?=
 =?us-ascii?Q?E7pe9s/GNjnAhhuke7qxj0R+/aklzjy7J6ghwezVTnPsfExN1fIEyJzb6N20?=
 =?us-ascii?Q?7yofAKo0KkcfAKSY2gzdGGEdYBRZ4sPlJMKPfNbaLOZpBk+7SiqSzHAZJoOG?=
 =?us-ascii?Q?O89Uc6m3NSwbRfhqVmUVZUzF61Dc+1Gc2miLHWHrTsELzVXp2Y2W2kgEgl+p?=
 =?us-ascii?Q?ZH+EmnH3SWm+oCpjXEsIiOhkNrXkJUSDpn4WEMGeTlTVN+cTzXoM4NdB5Hdq?=
 =?us-ascii?Q?W9f1H7Utc4B8OGhHFzvjedKL2d/w/FtvQYTCg6CuQ9rZdpDKmeNVlohAewl3?=
 =?us-ascii?Q?jkvIPSzysAtKXiGzpWz+TPWT560DIy6lZsiH4oPq5m5eyC5jhIVTcTUDl7s3?=
 =?us-ascii?Q?06ZjJPZnRYHE7CmPV6UOtB7D4g37kqspItyAb6WRRrG/26CJWVdabXutL2wy?=
 =?us-ascii?Q?0sTj2uLj5Z+6c9d/7+heznqSt7G+Yl+JohKdzLqyZ3WX/wqsiofn99gLafrW?=
 =?us-ascii?Q?CBJfaprbY2Y2VGFOQBgRlDcsiQ0JO1y50domm1R3lyAo0UWtMPNjtQBS3e/2?=
 =?us-ascii?Q?f/dCgLBO32DIl7rF4Z8mby9G9RR2oXjc2uDClRzp2XHAXQuOBcKISNDn81Dg?=
 =?us-ascii?Q?03N8XGtyzWMCo+gztnmPvmyofYgVsqMHIAdf24vh0964d1IjL57bvef+x4PV?=
 =?us-ascii?Q?PIpsC7/NOkWQXu+EHCaTWOgJlFnKvsjfDRvkArE6B5kQun8bu8K8c9I8E6Fk?=
 =?us-ascii?Q?t7Vb+SEWIfcCEom6ZXlj9Pih2sP9NW4q1aUIlJXUBu3tVQcj8UX0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ac737c-6d82-4e88-0e26-08df453c2545
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:21:13.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4elWw0PPC7wxr6YkDafVchUd2DtCKtPgVOa9OlcIyyCK7QYlvB/EFC2BjvacMaCPKNUnHyAuur0I6KlhE9wIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6998

On hosts with Sstc, kvm_arch_vcpu_load() cancels the vCPU wakeup hrtimer
with preemption disabled, including when called from sched-in preemption
notifier. The vCPU reset path also cancels the timer under get_cpu(),
with or without Sstc.

On PREEMPT_RT, these callbacks run in softirq thread context, so
hrtimer_cancel() may sleep waiting for a running callback, which is
invalid with preemption disabled.

Let the callbacks run in hardirq context on -RT. They only rearm the
timer, update interrupt state under a raw spinlock, and kick the vCPU.
Similar to commit 9090825fa997 ("KVM: arm/arm64: Let the timer expire in
hardirq context on RT").

Cc: stable@vger.kernel.org
Fixes: 3e1d86569c21 ("RISC-V: KVM: Add SBI HSM extension in KVM")
Fixes: 8f5cb44b1bae ("RISC-V: KVM: Support sstc extension")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Tested on SpacemiT K3 (which has Sstc) with an -RT host kernel.
- Without this patch, with the vCPU thread running at say SCHED_FIFO/50,
  just booting a Linux guest triggered "scheduling while atomic" splats.
- With this patch, the issue disappeared.
---
 arch/riscv/kvm/vcpu_timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index adbd1617b78a..79500aa61130 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -98,7 +98,7 @@ static int kvm_riscv_vcpu_update_hrtimer(struct kvm_vcpu *vcpu, u64 ncycles)
 
 	delta_ns = kvm_riscv_delta_cycles2ns(ncycles, gt, t);
 	t->next_cycles = ncycles;
-	hrtimer_start(&t->hrt, ktime_set(0, delta_ns), HRTIMER_MODE_REL);
+	hrtimer_start(&t->hrt, ktime_set(0, delta_ns), HRTIMER_MODE_REL_HARD);
 	t->next_set = true;
 
 	return 0;
@@ -148,7 +148,7 @@ static void kvm_riscv_vcpu_timer_blocking(struct kvm_vcpu *vcpu)
 		return;
 
 	delta_ns = kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t);
-	hrtimer_start(&t->hrt, ktime_set(0, delta_ns), HRTIMER_MODE_REL);
+	hrtimer_start(&t->hrt, ktime_set(0, delta_ns), HRTIMER_MODE_REL_HARD);
 	t->next_set = true;
 }
 
@@ -256,12 +256,12 @@ int kvm_riscv_vcpu_timer_init(struct kvm_vcpu *vcpu)
 	if (!kvm_riscv_isa_check_host(SSTC)) {
 		t->sstc_enabled = true;
 		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_vstimer_expired, CLOCK_MONOTONIC,
-			      HRTIMER_MODE_REL);
+			      HRTIMER_MODE_REL_HARD);
 		t->timer_next_event = kvm_riscv_vcpu_update_vstimecmp;
 	} else {
 		t->sstc_enabled = false;
 		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_hrtimer_expired, CLOCK_MONOTONIC,
-			      HRTIMER_MODE_REL);
+			      HRTIMER_MODE_REL_HARD);
 		t->timer_next_event = kvm_riscv_vcpu_update_hrtimer;
 	}
 

base-commit: e9bf49bbc4227048685c78f97e1446845760df4f
-- 
2.54.0

