Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794982974;
	b=JbDtJ04ujGQHHwY12447GEi2pjB3AC3LrgVZH/hakp25U4uKmP1eCsRQPHsa9h3feP0u
	 JOJDWVSWj1U0QSPVxiYMytodzHwCUJVnsBj1h12dg8YflcHxmdk9AvpReXpCbjCxUT3zs
	 2r6fvI5o//ol3sE3kELYslYl+iA5v5XFPrGtjBrojJDydSUMS2hlBdSkRDTlhJRtY/+AG
	 Q+dDvlUzVx0UJJmqX5nLfdxaBS+0N9daT4tvAly7jzySdWFHf23vwDQg8pnVPBMEtdkyO
	 j/q/YPJ24+8nW0aulAwyjs4vhUS2ae6jiCW8INjsYaJswmC4fYJLQftEDfBjfRI1ugQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982974;
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
	bh=CCQDWKqVN4WXQijrMmk8Tn1JsGCvY+dy7I/PAgGcn30=;
	b=kP7Y65JwPceq8sGh/kR9TClNE5Ork6vTqAtsP/27muyRBgPCbFaaim5sMLSg1HmdAOaZ
	 dC6GMzDX7rXTjmmBCazVLOUd95kQ8da79nUcTbADUCL33gcp3Z2BWV//wbCK4q8JCMmQ5
	 1hHHRoYHVNP0OKR0eJNhrjTKPPp2+N4tLEX9JynIxG/liAXkopUx+gK9V4qhlf7wPu97e
	 r6J9r4mQjaXvu5OsfPfZjonm/HASoDwGgcV8cIbpYBqNtlm1Ar7n0bDmHr67RAyA63r3l
	 mvApwwRlgaIR6LA0du1rhU9Em7rfiqtZeYc3RFL1uqXSF6/XOn2pHrhHGxvTSXkDt2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="tB/V740Z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56545606A31C;
	Wed, 18 Nov 2026 06:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56545606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tB/V740Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4tWr/F7kulo9LSIoydTnwT9P68BBJTFQWGD6dzwp7Y0DE0NTgc41AQRy62vc9CjK+PzqdGadxOilSAw25+Jl6gzOKMvqfT4vU2UdnjcWRVv/kbrXEmheCBndm1n3QrzWYohdanAu7NdRYPg5vzx9Zdj9VYesb9CCfxdR0pIcgmnoiE7J4GMdjy4yb/YYNFeseHsiOXSMFjl7/oTAbG1YZ+SMrhpWZIfeYfB7ui6lDM841a/ZbFau0KenLNUUvrQn9mhNyl+SgdMfQThfsB+cno2ScMrq4wNHQ516oNzVvFSrDI4ktUOJUW6u84SCJ7P443qgJrF9bnPlzcn6pTUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCQDWKqVN4WXQijrMmk8Tn1JsGCvY+dy7I/PAgGcn30=;
 b=K7pFOo3soke2Fv3MVDKytGEx3/bijJyhCSijFRlzkHimyddhnlN17PSG8sKBlqpBjcqxmfCpc8UZ7FXuLlqppy/rR1kSy1NnET1lVyfU6/HAI3ox2OrZqf1kLw3NFvHN7eSPHEwBL0wTP9bPSZ/xOdd9G4f9+V4bimUbEX0Qtf/2I8rEptv48rt1HdUZkJN2HbOCE4bSQtgC+XIGgblUc1DTXq02ubgLFU8TRaDVIjRbu8VaoygbwBC+SAm8Fy1bQkNtgTsw2LYFcXWlhVdjH1tr9QL/JhpWbOhURY8Mmvd/RAjjvZYVVAQLLXJUf4wk/4zZSZ0bkdL1newwmoXwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCQDWKqVN4WXQijrMmk8Tn1JsGCvY+dy7I/PAgGcn30=;
 b=tB/V740ZOF0gkujCNqzhSwXfYHZ8+J+us6QhC7zNIHJwdXz4+XAOO/Ha58czcTyqp8CI5DmUpiIBQkCMfIX+w9nnIbTexlQObjMOzfREuGV31hrpWIv2gWQCljijQu880qIWqaDZ4N4SUboxlhnZqTq2Ttv1dDFgDQCUqqPPY+0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6324.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:22:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:22:51 +0000
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
Subject: [PATCH 0/2] RISC-V: KVM: Lessen steal time update overhead
Date: Wed, 18 Nov 2026 15:22:40 +0900
Message-ID: <20261118062242.2914385-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 801e1521-60ef-4538-fd8c-08df453c5f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|23010399003|56012099006|261021121427099003|260925021911599003|260925021311599003|260925022911599003|10067099003|261022075727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8ny7qc+uafqNZNwKuHVd6j9hqm3arugN4xL9pEetetQYZfXGQukBsic4fqbulB69KaNbtHqAQ5dqsjhvZc/DeiSCgqwBRDnKN1kCt8zenHhN0hAo+TDBm6E9hBxHmLZRawrfxXVCVDOBOqwoqzFxe8WaYXzT6fB8eWmMySfQ0BwwYJWOf72LFdCyDgVTzNi8dXDoqZhIsHaUMW3K9BZ7Hzx1L1US1zosDeN/S3mcEv8MY6wXo5XePpYLVINFz26aWgG/Y9sFBUgr9+CHDzGnff0BWqaTibIK2sX4ivFxAcuZbCG4OW0oKYwnPIOiD4A4cH+luC3inSBI3A3kSk8ULLfbeDKZy21/RY03rlrxt4JcX/MlizEdWZlWqbL7e7go/A8rq0Otf/Qom7Wv0Mr6DCpNbhDXvbDavP3aYfjLO04P3rebT2b+lU9kPDhtOY+VIeAqSEzU6Fb/KPBZdwLOboRy+RPiPlDiU0kB4bSR4RLFv0KVxZXQWvO1KeY4f/KnifKlAMgCTngLhxx+3eWpafbRPHNvxKGrgK3KY+53Y8sAA1X3cEvgYVV2Rwy3lAGCSPk+SbDllPDu2G5/XNcRV3p8bM7qKI6Q9Gh24vLWL4ygPL50LZNd8eylFS0ucuvhA2Kw1cv+5+rNcF0BKSnnkkiMaJyZrdowVyk7fwER8Bg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(23010399003)(56012099006)(261021121427099003)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(261022075727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3OWiDr8R0tR+WBF5uwoPbCx4tJ+lfNp5wawh++QHZD3KVZUy8ZSEiEZBidkw?=
 =?us-ascii?Q?4j7VjeFVmKnZHxybjjCWJz/51o2mEEQJpBVjU7NLcrbvlkVRbdI5vXw9XlhI?=
 =?us-ascii?Q?LjiZ6gaPywYn0EyrxuTDzWe5uvKPpw0Q8tBNya3X3pyY7aLLcaADK7MuO4Pg?=
 =?us-ascii?Q?yaao/sNyizKyvTve5nksH/qGaOunTT8NVcrulIf17n+ueS4QnJXJtCzmZydU?=
 =?us-ascii?Q?xADnJPB32JVySZLlWlAWQjN1JSI4KV70gyGBzsBnYhY4Mub5mjjVDqOtZoks?=
 =?us-ascii?Q?897RPcOc1jANZ0eb3ijvUADuKo0xy2Edw5odSO17126C7bp/8PGwB/cXBUOa?=
 =?us-ascii?Q?oUX3qoYVvg3Pcqbt0BuQijWG+oXe9ZwpeIWZHy780TvAaSGtg+tu1fx2h54W?=
 =?us-ascii?Q?4l6KRj3ju5/jOm/V0Xg5t0x1rogO94qkSViA9GrzlY9E/DZUBEXh79U8Ne/f?=
 =?us-ascii?Q?BtgLzVDZqlxOnDzJFzF5zol0YycEVZvKDxILhDhCjxzjTFXCD7dy0B59eubD?=
 =?us-ascii?Q?nOi4U1G/8BkuUADoP9pKv3QJKHa9PPCt31/Wqp0V8DwhG3wz3ScjZ881aDIs?=
 =?us-ascii?Q?rpR7CluGVTIiO1Mv4gXULpaFRsfIj5SEZZJgi1OjNLSooYfYUgju+pBAf8u2?=
 =?us-ascii?Q?QCzTSumSAjIgxVns22ZVG+2AMySJfr7KKbkrOE32O8vVIuBZZ4eyP6bnVIZb?=
 =?us-ascii?Q?SWBaSgDNotavZitpTwn27tJCWvVPJc+8keC+fIQRNmrwzFrfEOVPGZKWRdsE?=
 =?us-ascii?Q?joq9NcJub/onlIKH4yUn6vOsNUJkJjPWbkEO2FtIu2ggZOTMnQiVbZq0Kq6R?=
 =?us-ascii?Q?+5N/oaEjxLgppFEWvn2rHQZsLpwv6YqJzQ4UbCwtx5cWCmPBAJ3wUyywIv+W?=
 =?us-ascii?Q?cHxAz7EXnxwgegSsnscmggxd8SbVPv0O9s9WXur/LAhxhDQ77VvX5w2ZnXL/?=
 =?us-ascii?Q?81r6jWB/s6KwjqckhJu+WdZRTp9X/1GWfN1Q7fjXGUV09JQCnCNDrHlfsSrg?=
 =?us-ascii?Q?iy2Q7Jr7ZE0UEQ+/MHMUnHsDdo7E68YauUIxhVZ7bEPxEgTJYZZL33KxT6rS?=
 =?us-ascii?Q?UaGlUp0fjrmbGUq/Ml2oBlKluyLV1gZsDQuiqXTkyNBpSogSFVrsqKowYNZm?=
 =?us-ascii?Q?0MY8qGnmrQThG70ZShzNTGd+RSqN1QS/rVN/mCkGti4oKESmiMVhBKEdhf0z?=
 =?us-ascii?Q?qtYXxmXTwOfObAkG6uHPWkUpXRr/Rr9Oje2oJ8NLkcXTEp0UIv/Ne4W0fCjI?=
 =?us-ascii?Q?F27AKuLES9C4+5yQl/+BWPk2bxACAEz2ibpfojrM/TViaZv8s5HBQbJBiIwA?=
 =?us-ascii?Q?HyNyRNSeaGo9OSjhLV1cWSh9viyv5hBy6szlCMtpYJ9ENqmIIn6OQ3Erj8ID?=
 =?us-ascii?Q?hm+JWB4ZEOMceYvvFLjZ4LmvoD+uHieaKvn4j7MN0fkY+8jA2L+WDydOVoXs?=
 =?us-ascii?Q?a4epuHLvA6ewC6iDplCQ/6PCGZqZ5hZw0aqyjoXigMV62ClRyvDoatqLsnuI?=
 =?us-ascii?Q?pn0vL4EKyGJOhcPrDxBLUypGsmxJzLbLE1YnxFuaCR5aGkOUd3MPHBM0ttHs?=
 =?us-ascii?Q?Qt0pWZ0gJ7gVVjCAkDSkGG4eXQw9AcqmxoR775lXKWEFKOxtEW+er9BbAEOi?=
 =?us-ascii?Q?I/8CzujhRp1lQkl4j9Pl7QH18uev1quq/CkIsK8uKTvWkCzzA9SbIZee2adL?=
 =?us-ascii?Q?nmTWpBtMiEmz955ZZy/QGtDXFX1lK7Oc3hhAcKlL8ftYlUZ+F1DrxbKtPuzV?=
 =?us-ascii?Q?oCND9pCHSkfqzQ2jpgj10QEw3FfW7N2GXYh0WV/VdDBLiOnV4vtl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 801e1521-60ef-4538-fd8c-08df453c5f96
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:22:51.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEM0Q9E+UX78Cx4pwGC7vTpC1UDxgbWyWXwix68zlQU/DPqvh1xVHB4gBFtpNcCyHZk9WNGVtS9oB4iXilUP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6324

Hi,

For guests that register an SBI STA shared-memory area, this small patch
set reduces update overhead by batching user accesses and also skipping
updates when run_delay is unchanged.

Tested on SpacemiT K3:
The benchmark uses KVM selftest helpers. The guest registers its STA
shared memory and calls GUEST_UCALL_NONE() in a loop. The vCPU thread is
pinned to one host CPU and re-enters KVM_RUN after each exit.

The table shows the median vCPU thread CPU time per round trip (from
host userspace to the guest and back), measured with
CLOCK_THREAD_CPUTIME_ID. Each case has five runs of 1,000,000
iterations, preceded by 10,000 warm-up iterations per run.
Below, "contended" adds a busy loop on that CPU.

                Before      After
  ------------  ----------  -------------------
  uncontended   2966.51 ns  2703.26 ns (-8.87%)
  contended     2973.46 ns  2717.72 ns (-8.60%)

Based off of riscv_kvm_next, commit e9bf49bbc422 ("RISC-V: KVM: Fix
G-stage page table memory leak on VM destroy")

Best regards,
Koichiro Den


Koichiro Den (2):
  RISC-V: KVM: Batch user accesses when updating steal time
  RISC-V: KVM: Skip steal-time updates when run_delay is unchanged

 arch/riscv/kvm/vcpu_sbi_sta.c | 61 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 24 deletions(-)


base-commit: e9bf49bbc4227048685c78f97e1446845760df4f
-- 
2.54.0

