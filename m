Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794982975;
	b=E+qaHot9KgLzZ5bKtbwck+SdLc7daAdoyK8v76evUMELECbow+rI3lPOrM0uIr46TIdb
	 jspMCV/zVKryt9dnxMbdd7dS3pbIKndfTtbJYWhWxu3BNr51DmqPkZLBVlAw0QMiXBTjb
	 kvs96W74CFsWWGp6jZYA/lMRQiixjJ284yEHH3SnfFdPjAX+Mq4llYGPB5kocFmfyq32n
	 WBXRnvL2ixlkapkxyZT5K4UKVVzQibr562WFAShZBjhn0e6w1l37UFnae5ckqlz9i/W7C
	 qXWKXIc0EUyxCIbGMUgkizyhRcwGjY3e96ZsWLrpu4JBvPFh3EHYCPlvPXt6q/G31ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982975;
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
	bh=8foUd0phx7M5jkONGIgS5mgqrjTZaGmpn0fcDDO+NmY=;
	b=Mc67HvrQf5guiQNdu+3LZUVIPhYi77U9poAsF4c69F4tAXpooOtumy1J+dyBDOOHd5JK
	 c/S9l7YNfB7zl9s3sCqaM8LzGT2jqM1wI1r8zj2aWD/ZQupFBWclfzTaur+goMHXIZIrG
	 zeaHyI4HPLy8YpDwyaMq3B1TJ4fpv+EX2RBkwsRbDmYDT59/kY/ciUbvYAKTEGrsIUdaE
	 oxVtznWKlQ9XO696LoPPwBg+0tiI3gs4kgdna+moQIDdFfcK1WsGZNAA+sitgMjw01wbl
	 5Y2bOk/BjYYMFJEJ1vYVK/iVsHHKOh84lFlBE+NQ7m6v4dPl1apuUVPS7hayl61e41g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Bw7U8f4j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B10606A32C;
	Wed, 18 Nov 2026 06:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09B10606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Bw7U8f4j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jq+LHQrmsNBxHTXp3tDP3/9OpNSrTY8iPWtJd8CroC0ldTSFl/8Pfi27lBB1Cyb7UjBiKO/ySXNpV2N1WuNIBtu9fiu0fPya1S13VO0Mi5VNJX9qZV3/v+bXKRvCX07KLUX+jGBxDY7iikeGXkfcir/F3NPvshTCUsLAXprXeJnxdfppQmBLm21QlfFVauMQ6lmTRX0y+nlJKcymzehtM802NLwUFYU3Wqs4gCBDP/zwppmEiK/5lBD6HVtrMdJIabUBT1kbPDxeOb6Wld/zNbh8uVV63BM8b3pvS7L9VlfIUF1YZ1QfNT/3xN3o0yRhdaaqvhtmuFn/IYzphPi8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8foUd0phx7M5jkONGIgS5mgqrjTZaGmpn0fcDDO+NmY=;
 b=ODHRJIDUaMSxarh2HC3oRNu5osHixcx+ir9wdbXIjEGm6T9wTfxiWDhg8Rhs2BtbkampzV9N8vLWRK4hAIPW9Vak75p7Eeg/milI8MbHyGpkRZKWi80ia47+hKPvd1dOvVD4vMt0ZrwprZDjTRaZiDBoDbsKzRpC0wgI7WbPFaDkfVSwC/vffuUxUfOf9GerBXVpngrv3GjvDTZZwwtaUSqmkTmTTrLmoJzk8fDfgjYaVWyfxdNOe8eBcy12HeFK5z27rGtN+YFI2BqzNHP5geuJZvfywN/FVqAK6Ap+NTmvLpxVyJ4bVX84SWJqUT7rMM5JbCrlmkg225Ll7x7UUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8foUd0phx7M5jkONGIgS5mgqrjTZaGmpn0fcDDO+NmY=;
 b=Bw7U8f4jWPzSwMTa89MMtVfgQHbvfoM1MPBmXWaAnq0/XwMjBEtTJrraM1XNgwURHwjH/AFRexiFi1Cr+Ms8Py1soqnhjYmBjvBtWOX9GN/GBnTC1N0+BE87RAAIu3pnd9Is6JI/r43GcFGA60AAmTVPFDL/30WNl5xSvqnTrrs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6324.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:22:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:22:52 +0000
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
Subject: [PATCH 1/2] RISC-V: KVM: Batch user accesses when updating steal time
Date: Wed, 18 Nov 2026 15:22:41 +0900
Message-ID: <20261118062242.2914385-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118062242.2914385-1-den@valinux.co.jp>
References: <20261118062242.2914385-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 3c613ca7-ab2d-4a52-8930-08df453c6026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|23010399003|56012099006|261021121427099003|10067099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ieEyqZsjCCLF81F5ns/V+jZm5yI1OXfKWPInVd0DnKwPJtEHBcjl4i3ztZDmuwKiu8MGke6Y/WhQvaCXZFo31I3Y+zPw0JJ5fGCXVhQlJNasjGa90DG8oyroGBkA4+E/LIJhXL9fnMwFDonOLh5IbPtAqDM5nQOAUx70nRPhDC8VmKyiNUpQBrFe3Ul8Ue2NJLXIi0gxpkrlVbOil1iJhGDurJNppehHLjOmWEiH0+ZvOolPs6OKk6GGNRIhfX8VK0T/Lh5m1XI3fuBwTAQF4APQK/9nFMyO1mzVgN8fbEPcqTHGMXDFJu0A0Fhoi04max4PTqe6N8UQbySl0diJEN7b2YnK8tFuR4qgNWe+YAB1KCRaEzS4dWCdDTRs9ik/2AHL6zCrj5Gy6GpLp3i8hVdOYEBpZwp/AW2hxjNYLnE2QtUqA9HNk8SHfpC9b5H5UYofFkLlJiMZZznjvlfxnpgVR7zSNzbWt3G2pIOk7oO6gAkF3CJhflcpw/Np1pFq9vV1uyQiJ6zNO2pH8dzpQxzOZIc0TMPgq2gHimidxtH6L6N+dpLrusym4DeZnr0EiJuYJVk99szQO2ej+75AnAUrOAV5Kg4Yli0TR0lXQFw13zKiKQVq/HEH5lKM/p0vxn4vnkiaUrEgG1tBI/DMWuUkjrXdTY68zdDU/IGNwn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(23010399003)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8ifqLB4uT3PEKOb9utwxk0ch/dVelBdD4oxVEiwbJlxjsAVRlSj9gSEAOBc?=
 =?us-ascii?Q?qUkYq8a2nOxa6r8V+pbGUGSVvsHIakDZw1CuL5eTBePFYGLgSUrBwn9sUGag?=
 =?us-ascii?Q?BN+KGPnnyu+ez+hnf9LpYQ+DLPudVsYkWdFgFqyaBMKwFlsw2jeIAHUsTmjF?=
 =?us-ascii?Q?3bU9VpSfkZL59gKBeHJ4Q/wToIQkpOH8PXcr/h1mq6Ta0YPjooyohwXlodh2?=
 =?us-ascii?Q?6K2l6abE+hPKNf/3D6Ysgeue4lxwe0fKYgM6/5UR0Wtwsg9BV5mWp9e3iIb/?=
 =?us-ascii?Q?jyhw8mEsMVGQXmagpIW8xf3MRS6yR2pXZPobHFjIychvGKd1Pwz3aqijxlnF?=
 =?us-ascii?Q?U0QxtT0FSIBaj7Z2KIrSbrjmwNWD01Zpl8QI2T+jBJqn0CvbdSgd35Vdghf0?=
 =?us-ascii?Q?ZtoeAfdQHFI6YwcoBjeyOtOLrtn5GGd9PWNkrhon/VhOuN6ljARw7NgDiHoQ?=
 =?us-ascii?Q?PeEI/tihQhDXoeWXB0z6SQIttdfILCdqa4Gjd1pxKvP9KLiC5yRj9nNrUtIG?=
 =?us-ascii?Q?DjM8+7UqAoS0s+eCyXxzYXr6TVaNHW0kYN3eKzQIbeltcHl2CFXlPpmP3ZTn?=
 =?us-ascii?Q?wS0MANFS9iLiniA7nkV+bLNld1WW8VeynmzPEf2wKbt/v8nNOrwPmqdbXkSa?=
 =?us-ascii?Q?VxZAeaZPNoN2JrsNAHA65z0EIfspGGvvBYgTXTk6dhliPSR5avILyd/L7St+?=
 =?us-ascii?Q?8NaFKUB8nJbVVTRG5WKpXQpkWNiJkKWxw/eN0opolBHkoxY4wA38nic6wFPA?=
 =?us-ascii?Q?2Ijfx+0TsBMTNB/XMc/kw6TLI60dlBO+XaZNeP7vTty31bJNewXixCFWJ/j5?=
 =?us-ascii?Q?FMijAZvD583DdnPbMswNgfDDpLE8GVjDfnqN/zxvScMphXQo5ueepvnlaQAp?=
 =?us-ascii?Q?cJ8EMP2hya6Wqkwv3dNMcU7yTnPFQr4Ku6Z7vu3MtXD+EzqvDvdu9ac7NXEC?=
 =?us-ascii?Q?qosdZjDwkmQbvtcWKV+J6gG3aS6YdwTx5fETYo26NJhSe/EVafrgjvehUwDJ?=
 =?us-ascii?Q?7MsQnmWcbSXMl0POjsvCVZfOl+xfXXLeaF0famAlAxZgydeDj45J8VtcTMwU?=
 =?us-ascii?Q?1fuABCcVABDLSLJl1OuB8BiCt6D8bkPEZaCOS+FvhtIMhlgnMjX/73oOJr1V?=
 =?us-ascii?Q?/E/NP6Igj5lW79lOrOzxRU8e7rSHE5rLB9lay/6AwIEsQs0arjvVyvJSNen9?=
 =?us-ascii?Q?iLBIeDNLTTsq/YLFSdrBTgxWOKTu9xVedhsif/H57saYuz3C0LCvx3dZNQIr?=
 =?us-ascii?Q?7N4UZI6uXGry9hi1fe4uMXoiXwT14K0lGppMf9mdpzElyBMvh8Or/DaKcZNj?=
 =?us-ascii?Q?Tzee3OMeb0qMVTtBXDN5utt+AjO9DJl1Q1GAA1b/uMc13jmwy0MjYArnP056?=
 =?us-ascii?Q?5NN4flYgsO4sHmwqIQPvfB9P7iRIbkjnnq+geGk6m5kRzpaJRj2efNNlQ+h7?=
 =?us-ascii?Q?HREMFu+HozYxuerv3ulO0wrD5BuOR9RBHkrk9cjolk2p2v0GW5+2Q/tgoXSX?=
 =?us-ascii?Q?CLTqhPQvV+jqABNCLsGBrsykSKMR+5AMutyLSIDTYONSIOyAtJfR/80lByKE?=
 =?us-ascii?Q?ai91u+YXbqLkOd4sIAMhMEBO91maYc+E/jzRKSYL+hHJt4aYaXNashk8JKzg?=
 =?us-ascii?Q?k1EIX54HOYCSIOLUazGt07Sxh0Yi6GhUGEVeSUUIPELt/u88Zkshpf5VE61D?=
 =?us-ascii?Q?iUPOZ6gjxaYJXekTbErGKQeE9kYBTQ9Sd53V1otb+P30L4TpG3nBseJAyke0?=
 =?us-ascii?Q?BMsqM3l+lfJh7++l5QqPwknKMzPwkK5x6r0tMcgYlnA6rJbq6n1e?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c613ca7-ab2d-4a52-8930-08df453c6026
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:22:52.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLkVQLnE3ICdi4aIsJTWSfqc6g4z+ElyARf2Z9uvZ9E1ts9LDc7jcxhgjbfhdwHvEIvXPQ52gIF1rYkgB1ahEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6324

Updating the SBI STA shared structure performs 2x get_user() + 3x
put_user() calls, each of which toggles sstatus.SUM.

Keep SUM enabled across all five accesses to the shared structure.

Note that write barriers are added to order the odd sequence store
before the steal-time update and the even sequence store after it.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
To reviewers: please let me know if you'd prefer
scoped_user_rw_access() here.

 arch/riscv/kvm/vcpu_sbi_sta.c | 59 ++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 60e50296a008..cfc6f22c3e33 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -8,13 +8,14 @@
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/sizes.h>
+#include <linux/uaccess.h>
 
+#include <asm/barrier.h>
 #include <asm/bug.h>
 #include <asm/current.h>
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/page.h>
 #include <asm/sbi.h>
-#include <asm/uaccess.h>
 
 static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
 {
@@ -26,13 +27,13 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 {
 	gpa_t shmem = vcpu->arch.sta.shmem;
 	u64 last_steal = vcpu->arch.sta.last_steal;
-	__le32 __user *sequence_ptr;
-	__le64 __user *steal_ptr;
+	struct sbi_sta_struct __user *st;
 	__le32 sequence_le;
 	__le64 steal_le;
 	u32 sequence;
 	u64 steal;
 	unsigned long hva;
+	bool dirty = false, success = false;
 	gfn_t gfn;
 
 	if (shmem == INVALID_GPA)
@@ -51,31 +52,39 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	sequence_ptr = (__le32 __user *)(hva + offset_in_page(shmem) +
-			       offsetof(struct sbi_sta_struct, sequence));
-	steal_ptr = (__le64 __user *)(hva + offset_in_page(shmem) +
-			    offsetof(struct sbi_sta_struct, steal));
-
-	if (WARN_ON(get_user(sequence_le, sequence_ptr)))
-		return;
-
-	sequence = le32_to_cpu(sequence_le);
-	sequence += 1;
-
-	if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
+	st = (struct sbi_sta_struct __user *)(hva + offset_in_page(shmem));
+	might_fault();
+	if (WARN_ON(!user_access_begin(st, sizeof(*st))))
 		return;
 
-	if (!WARN_ON(get_user(steal_le, steal_ptr))) {
-		steal = le64_to_cpu(steal_le);
-		vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
-		steal += vcpu->arch.sta.last_steal - last_steal;
-		WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
-	}
-
+	unsafe_get_user(sequence_le, &st->sequence, fault);
+	sequence = le32_to_cpu(sequence_le) + 1;
+	unsafe_put_user(cpu_to_le32(sequence), &st->sequence, fault);
+	dirty = true;
+
+	/* Publish the odd sequence before updating stolen time. */
+	smp_wmb();
+	unsafe_get_user(steal_le, &st->steal, update_sequence);
+	steal = le64_to_cpu(steal_le);
+	vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
+	steal += vcpu->arch.sta.last_steal - last_steal;
+	unsafe_put_user(cpu_to_le64(steal), &st->steal, update_sequence);
+	success = true;
+
+update_sequence:
+	/* Publish stolen time before completing the update. */
+	smp_wmb();
 	sequence += 1;
-	WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
-
-	kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	unsafe_put_user(cpu_to_le32(sequence), &st->sequence, fault);
+	goto out;
+
+fault:
+	success = false;
+out:
+	user_access_end();
+	WARN_ON(!success);
+	if (dirty)
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
 }
 
 static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
-- 
2.54.0

