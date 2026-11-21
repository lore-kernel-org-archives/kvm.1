Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795282535;
	b=SkSCTz0Kg46vbAbANQYcWNK49NK8VcikVo1qmeSNidmo7SdisdgaRk+J4Ye2z2ZDBdxX
	 +DktLwfhevMms5seEMvzFnsFepJac0fc1rVIhjVXeUFub5X6SSvfrSuayeyxa8cShf/d5
	 tyh4K1376lCJCZ5y4KLCecxPxoaQXAVpyiclzMHUYM9JVOp8AGRWmUuhmdd47doK06bAs
	 YY3dPnSHMngCevEA4kGzsZPr6zX18W6z1qz+aLQHekNu+ErcQQ72CJgLjedJcBh7nr7Zy
	 6GQdOMjr7pV57/8usS+WomAQqUdUdbVVg0n0Z51evKeGxiE8qTa5TmkDWUfEoCi3wUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282535;
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
	bh=VkX3Axx/3CvwQtHf6tmihPGaYXb2b0AaPcAH2o1Syi0=;
	b=mXTgRzL3QC67XLb/1tH8dVpXVFRDXADUEJaUhwtcuZOEORY8ZCKoyFjWLUdGiFyWOfQQ
	 i/ldieVCEDJCI5MhU+XTMgMUv8WFWnrB5h51gcJp9jjzFvQ4bwm0r6+Cw7+2s5z3kHrTf
	 fu0aVlXCO8cvm9tVpBdDD6pVLQePZ3BKripXSGtvls4ONAURKQeSKQBB2riOzsj0LlLY0
	 /JyK+IqylCc9rOoxLLPBjzTa/yc+ZoJ7W7jaJwHBhQs+xlOIEfP3OfmyGV1xGFMMbPIYf
	 /anaabcUQ/6kjmG7wRLaQuR7gco8lNgh8457dMeJd8IDP6WAWa1mEUIQgWwjxv7hxnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=cuZkho5f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.120
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F3606A330;
	Sat, 21 Nov 2026 17:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476F3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=cuZkho5f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIMs8rWS9PFRIhFaTWiOcfJ/UaDAJ1oCtrdom9KKnt+jUd4BfsCzBQAzw28P3S/Be4xgpqwEoi2dV+vfMX25tBzXnG0lPduCZ/S7JIjZTNFLlHj4xhTCtFFebhusg0brZVNnhaBagAHMAJAZdRO88MPkw6rbcNlJl0MXX8zCPptYLN06U3FH0bVOsedr/Be8PMeD2Zd4SCD8HslgBxSqJq2XCjWKsJ6Aq5+JnriXd1nI8t6HsKMfTWslu+2TNLr8ntbkfyl+OTtQtXtPiX+PLujmhWwdwKicYYrbgKmCoS5eAYty+fpVwT3k+Vaw0W9JpGIEzZG4zEAa+sNb9D+hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkX3Axx/3CvwQtHf6tmihPGaYXb2b0AaPcAH2o1Syi0=;
 b=B3tpzeJk8lhqWd95RufV2bVJvsT0O/Zmzm2GwAoKFtDVdgKzOrA0d6MF2FAZQV2EX0aF6/q68kBJh3sAPvapTuWZhPO6VuNsyBsxQR8iVRyGQVsQzF/DxCmISyUZ3vi2SurHuz6hLlpZUW/k6MirRssI/0iWtNzjXZcuyt6/7c0U2+bRxwfKWcZpZYELNO+MAggBVuh9U7rXbIDQiRvokCWkMjOOexawdovLvQKl+1EQJiO+VIAD/tJPuNKwNdyarRGhQotUVEIUi85Gl+xmZj4/EKPU9snJSk1NTD8SSjIR0P9Kqzq9koZprgduHKqGm22g+dMTPqv2hh4ljZW/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkX3Axx/3CvwQtHf6tmihPGaYXb2b0AaPcAH2o1Syi0=;
 b=cuZkho5fEb3s/XGisGDPANjNTeh/hWHIK+rEH8u4zpDIgNRhyTixmCunkw4v2PWB29TAXfah1jJZWKf0UPycldUcqo4g01zISVs9P7NgU7/a/CuiCAbNxcxTzI/tq+UdeDWSIO0GICwbGJ9JrpQml97h1sWFkvQj+LOztrWFqdM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB5134.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:30f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 17:35:32 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 17:35:32 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] RISC-V: KVM: Order writes to the SBI STA shared structure
Date: Sun, 22 Nov 2026 02:35:24 +0900
Message-ID: <20261121173526.892344-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121173526.892344-1-den@valinux.co.jp>
References: <20261121173526.892344-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 87370727-f270-4871-3c73-08df47f5d765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|23010399003|18002099003|22082099003|56012099006|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tHrQmvLnJcMXIJxU3xoPACjVAUXKALXVl0+Ow1bWxMt5OJs8MfsUwA1VL4QKKzdwILhWY6OsBC9BWYJRWYTIcQnAfy4zj6hsguo1aDmpsxqCQ2WZSYE8sffoPTJReKu2e3hH1W7wLNyQkRfTAJy7yzMn3AzYcK/SlhLjd6MKS53dFhLFXViNtl3KIwb6XZiJ+KvwV+wW6WjsfT6u64GnweDVYfWZxeRwLvPL4NQ43OXUOTI5ZcHgUdgzGl2qjA6sLkRMQYwL66meWdtKYZiPI7VllMSie8yh3n7LBeDLLUD1sPDsA0nLxlujOPFOjeHvnuwCd6RMVDMJvaauTyuVCJyMbr2/p6yj/yWAEuL10InwAGrnQ83CFdg27vQf3h/Q6p0m1yhT9czDHI/mirY7jnGTRJnzoqhxORW7xCud5i3sy+jdoeKQoy6m+UutEGX7B0d9kl0uF1RBp602YZDMOJcUOY7uMD9rvYl6itmrR2WKnYXRu8yr45u1lPQI5z34gBAcI09XfUU1sHrXbFDO5kgED0Xac7ZPvIBLxby0aSo7P0abz05p6iDW0s5XUibjzV1lOZ9+qdlDScd7Dkni+eSEaHGbjiG4FcsN35ysn1GI3jjf09dWs5RIq4egZQ2bfTLhvG5k8MlM4mobirTa8435YOGcqBROLrEtGPNXpH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/a3cL8pK1TBH+5d6Z6vnbUcoAtBOusqJuJZbr0lb8zfpLxQoepvKoTrbWnzV?=
 =?us-ascii?Q?pit3BFwRBZbZJfq25/INPbpLypx5lXDsa2MdqQ+Fz7GxyufE6Og7AbDxwHNd?=
 =?us-ascii?Q?hM/qU7qQz3uI2U8gwqLfGTcua/ScLRNPhtGGw1u6Zii4gLWqnuadEsfJkQZ1?=
 =?us-ascii?Q?z8u/AibOPlp/40+WZ/k4WwrgWLDoSkR47tHZnpzMZuQsNHKCy8SMfSYp56Ty?=
 =?us-ascii?Q?UTYY4b/flEUtQahtA4tOADjXkyIl5h/vIGAy7yIMqidS6mLjDWeHOKa4BQyC?=
 =?us-ascii?Q?SWHblagMRf2mNytdfeN22GDB/L69S8ceDfB79/IcgW+CbxgfmTts4mA9NXXa?=
 =?us-ascii?Q?wIKlDnogwZzVKI7l6wEuTOhDYX1l5LUjZQEqeXy7NC2wNQtjLY6aGcblwaAW?=
 =?us-ascii?Q?O5ZbP5Jf/NYwVCFZSFCMh2ePV5+K81DMUGmWbKNHMr3mV7oYOZagKFlj7fV7?=
 =?us-ascii?Q?bKGSpYwzrR+6Rs9UXe5QMHLNXWnT4+hBzwuf4EmnZrjAbs4Q9TCIZfTBgtKa?=
 =?us-ascii?Q?8L/eTcJxB6pBjOWezg85K3rNUrauv3iozrVqX56s+7+r4OZrcBa+W7DWwlkH?=
 =?us-ascii?Q?LEnCbl/dVSeXbOEzta5xruSBcRI+lnrnROA2+kWi8IH7pAju2MWy25znLGj8?=
 =?us-ascii?Q?HCZ480Xhh1GN182/BP9oaaXfpgcZUorgaleVdsIADA9Xozt1WKt6eOAX24B1?=
 =?us-ascii?Q?f8pzUB/ahQAR9Ngsop+MJqb3TT1kIcW3LIGnnMaIZKUcbXKM8dAOm9OHMEku?=
 =?us-ascii?Q?ed4DdMT1oO9XVjOBaFHFvrxYF2sMJa+4u5uvolJ+DGQINxCAVVWuh8ELYlsu?=
 =?us-ascii?Q?dxfCCPxirb5mwtbvKLdr0uY7KYK9X40A9ZlYdh0kOmNJxnTyvoEha1dJKDRt?=
 =?us-ascii?Q?jAkEa89vc6JlnoViVYwTF8M6v/i1X+oF5u1cdmlnDsvXdA6HZp+Om/tbF/kZ?=
 =?us-ascii?Q?stWpwyqknb373EgSe8PPnzkGItwauAsJAG6RY9vX3kd3UMyOZtsx8ELEe8RQ?=
 =?us-ascii?Q?K2uZfehRyB3ui7xlkor/g6wdjGd2NA+ylpqsvZGpkzxDnaSSjc/bNXZkO5Jb?=
 =?us-ascii?Q?FBxnr1Y/dIaHW6jVft+67vpilqPoYafmCoGTJiG0AFGwF7EuoYjQ4Xk74kW3?=
 =?us-ascii?Q?fzrDb3hkeZb7MuKBDSPoG9DKhki1KAukdivjgCRocPHynsROSv29YwPEXDJN?=
 =?us-ascii?Q?F97KW6IiCTUNPOy5wcTB1MGnqEDtzS8vD1D62twKZwBddiUg/VetP7cOWXSU?=
 =?us-ascii?Q?TaN9RRBzVSg1wu7Swe3Rp5A1yvffkUlOdJiaUgYedB9z/rx5qGQy6GE2ue0W?=
 =?us-ascii?Q?z1L6fWC8zFKW2lXYekhbxZ2JBlwxAZRh4nSwj9qxD6AYKYdOoBcu+j3800aY?=
 =?us-ascii?Q?jblpfwP4wCz8SP5Bx98bx3xueY3GvoSHV9yJXOcLQTnlis9giIOEZW6/GKDU?=
 =?us-ascii?Q?mtq2bF4hhwB6HrBGqloyHPRTCle0zky60+xzQIDNsXAv4AZce5v0qpAB3tw/?=
 =?us-ascii?Q?aJ3Cs9EnELDtwDxc0HOhgvroXeR65lwis2Dzg6Dv+x3wDTKsFO+b4k3SzuJe?=
 =?us-ascii?Q?F+VJIorutha2HGGF4VokJxGWmx4iDifV4xvyn2POjcw4w9y1gBWe4t+wvaDu?=
 =?us-ascii?Q?dvtL/SRNSx4YdXr3mQm1TdASKmx5RLbZgSzWbLIdFDUnfaNOKv6RQv1bvdV+?=
 =?us-ascii?Q?QObkHIPNx+3EEMCfoJTEgOiL8w8TZKoqMaqDx6nU0pQLdTi2JnZudEU2TeoG?=
 =?us-ascii?Q?KkMnQxtXy6n6cW24coYSw/xk2pJmwv+djrtc1SE82RjtZ6DeyCyd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 87370727-f270-4871-3c73-08df47f5d765
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 17:35:32.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oAmJLbKlmM+tMXigH4KLYIRe1JjxvehPngjKtJ7Mrje5yv0aSXfee+8CkQ8cOW7ylOaRfkeMVYTtxBTU9hrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5134

The guest checks the sequence before and after reading steal time. If
the final even sequence becomes visible before the updated steal time,
the guest can accept a stale value. CSR accesses are weakly ordered;
toggling sstatus.SUM in get_user() and put_user() does not guarantee
that the guest observes those stores in order.

Pair the read barriers in pv_time_steal_clock() with write barriers.

Fixes: e9f12b5fff8a ("RISC-V: KVM: Implement SBI STA extension")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - New patch. Split the write barriers out of v1 patch #1 into a
    separate fix. (Andrew)

 arch/riscv/kvm/vcpu_sbi_sta.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 60e50296a008..f1be90b514b2 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/sizes.h>
 
+#include <asm/barrier.h>
 #include <asm/bug.h>
 #include <asm/current.h>
 #include <asm/kvm_vcpu_sbi.h>
@@ -65,6 +66,8 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
 		return;
 
+	/* Publish the odd sequence before updating stolen time. */
+	smp_wmb();
 	if (!WARN_ON(get_user(steal_le, steal_ptr))) {
 		steal = le64_to_cpu(steal_le);
 		vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
@@ -72,6 +75,8 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 		WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
 	}
 
+	/* Publish stolen time before the sequence becomes even. */
+	smp_wmb();
 	sequence += 1;
 	WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
 
-- 
2.54.0

