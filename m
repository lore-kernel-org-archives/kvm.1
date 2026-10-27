Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107371;
	b=eiVuAS3//sqGmHZiRux/v6zpLsGLIetFPHXeXpilbffdwvzuUu3b38PYfAfIBpq1m2s7
	 pxhDksVRo7nCh5e+PiUSQ/HjxJDNnPNor4VUie2mB2uFENJrgvU9bch7Ia+HempPjXRiy
	 QZ/MNs6BDPsKYw24Z+Gr4RHO6pANrEwr2jBW8HU1jHJKZPQBT1QkhSEt3ZfHnEi9b5yzG
	 BrEwMfadqVd9WPXFYsw8dOuhk5oDnDmBYWU0jIjk0FICoaOlDIYBW8/GkOANReVfroaaP
	 DQg8hGAX1jLgBRX9NmTXvuY1nv3l1iWG48dsFQwxYkKplugHIRhtMs75+2Wf6uH8LtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107371;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QIhQf0Wr/lT1jSVw4dqBBu8EvYeSTKjw/fvM+D9Fi08=;
	b=xd9FaTOthVIYFM3cVgBM6qNszYo7QzkX6r/US8BQGGMga15pWi1IZmMnyruXTpesx0pH
	 1J6jzhPHnt4CrX754QD6Gel2cYQD0IFTvbOfPkMxm1FoGj6LuMzsqd8HOFQpvTJ7/5d5b
	 Jwr2SKlTC5Bq7Bx+JxwkPsSn60stcXTthP6p+a1TSdJBXFKGGDFnCMNAQp5LegU3Yoosz
	 8ecXOibpw/dfY3HBkLzo/U4pEasAihxaNCy4jrKaqpbpUOaB75quHF87tKHxAfbvO5aaU
	 AMDcxGn8PgENkDVaM2BhIY75EV8TCb41CoZMhyXSyp559rEr5lIw0BaPxDRSXVfdKSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=SLXHUfJJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.81
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013081.outbound.protection.outlook.com [52.103.43.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2592606A31A;
	Tue, 27 Oct 2026 13:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2592606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=SLXHUfJJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhxTh3zAAZA3JFh0SqaSvT5Wda6TOyUqdWFSvx7nmW6i7OzfC4bdu7hh4GvD2Woc3dhb/4QYM3N1a7u3FUkFhXR//PWEQFetvLRGyPWEO30Xbh9LL5iwIivjCThmEnM8uPiTjRv3EwHE7cA39NAr2wrc7gn5Q5mhFuB4ZRxX9PIxv1Nj45WwPdtW/waHsCYUdAzyvLloidhPtBuzwNg2je93jGJuRhkAqQkbtgSM91Sa9pCk6eU58ZeJkpsBjTsVrJo27ca2ll+ZhyVvwb0oYIG9uSUXpAxXjiyLPLG3iEP5xzUL2eLblh5aZRP9H5Owjo5qrCU65ZK47aIIsr9V1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIhQf0Wr/lT1jSVw4dqBBu8EvYeSTKjw/fvM+D9Fi08=;
 b=uIuAoExJvXEO48u5K5S7XaNgaDS/vb7oB7fBZjU+h2H9JPjBC+uGheInsVkPyIrRTPI97f21G7c/J8f0TI4ugBWfauWUbzRClMOM4kxWe3fZSuzUsM0dHM3vNwQylLc3OHNraRCZVjiZglAeqcdxyQtdaHTNs4uT3P14YdlPIKaKc4GrzNPsuQyOD5JJoKU49C8iGcozeLyYjE2yYEa933VNfi3uPiLqYzU4D04gYZX27NNWS6iimt3AXc4Ko30XjbZUpD3ZuDT9mVN3ILxnFxwaqmUermJsWXHMu3ODoF22KozO6WHxzj9En0z868SnrTRfb8CXTZ+zAAHfaG8pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIhQf0Wr/lT1jSVw4dqBBu8EvYeSTKjw/fvM+D9Fi08=;
 b=SLXHUfJJsV0evib8Ju4VwpRcSq1yaGFHhJVwKoYNng6eqkw8pDEHfhqRMwNARwLn/FjAeT6zWLFI3ElqbXovCRRvq4LWFyw/7gxd8LdxAGlfXwJdKIRQVgLiBJOPbQMAM8VXRnejIpi5/rHyOpnZujiNvdQwtx9yoq1rsLFV1WWOchwtL06VQpwr2lYBr8pEMCZHhVSMp+wJ2WYOtIAKRSlIJ9J1CNhbrGlo1a220Lw0E+Rp9RvNBBhz9sk8cjjh8M6a1JsXVd0mjuES4JxNIDbM7K/3VWtbraIk9fjpwi1f+hdojLab2nye55TuB81TVkNk+IT3R6FFNcdbRD1lKg==
Received: from OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 (2603:1096:604:290::7) by SI2PR01MB4451.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1be::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:22:45 +0000
Received: from OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 ([fe80::708b:59ed:4ad6:b84c]) by OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 ([fe80::708b:59ed:4ad6:b84c%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:22:44 +0000
From: slack up <yxcnew@outlook.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xiaochun Yu <yxcnew@outlook.com>
Subject: [RFC PATCH 0/3] RISC-V: KVM: Preserve resident guest Vector state
Date: Tue, 27 Oct 2026 13:13:06 +0000
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To OSQPR01MB6326.apcprd01.prod.exchangelabs.com (2603:1096:604:290::7)
Message-ID:
 <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSQPR01MB6326:EE_|SI2PR01MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 024603d1-0258-46e6-0841-08df342d62a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|51005399006|5072599009|19110799012|8060799015|24021099003|15080799012|23021999003|41001999006|4140399003|25010399006|260925184616899003|56899033|4302099013|440099028|3412199025|12091999003|10035399007|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jiEZxCCdddCbpJmDfFzv+Ws8+n+ejnn6qahF8mgcrsxndWmy/v/ci4fV6J/3?=
 =?us-ascii?Q?mgIUyrXRh/aMFAGqS8OIKZXCmgGeFCKuUc3oXA8UYPm/qEPjqEBJRv5Gw1W4?=
 =?us-ascii?Q?WoxdL/KwErpeyYKWzbfxxnqqaW82pUDxXSmXIWRCkVYtYmhtDfBjuHDGY/1g?=
 =?us-ascii?Q?JIrvQ9/dkdxrSbfqwgnZ7rbg6P9trlaUiG8Xp8AmfujHCFZ5Tah4MLgl78hL?=
 =?us-ascii?Q?BoltDF0kzDXDhSlPdrKpdAb1Ofg85SEYN8FdXqdRyoNUF1+7xNGHF4mGGeVN?=
 =?us-ascii?Q?rih5+xqJFxWvwUY35dMKNDi/JVGxwHRbpDP2VIFWycbni0wo4t4gldVW9+X0?=
 =?us-ascii?Q?q5aD0SqE3jR8aJSW2ucAiYl8L8rL9z6+6dJi9oM8gCAXXy91q8ihsnxOD07N?=
 =?us-ascii?Q?5AMwW4L9D77gHdqa5JJjxCf13Ehul3FVYMd1ecVuAovOL4WSpvHQiUdt4R2G?=
 =?us-ascii?Q?SJXGdqQ45femcZEY9YC8RbWiJXfChcSf+5CetlVhBNU+Kts2a0deT4YvnVvC?=
 =?us-ascii?Q?8qY6RQjkK68Ge7qQutwOoqi2BAt0H0GVSq98QZjnlP1rU2e8lqbpEferB0xY?=
 =?us-ascii?Q?GU6+j7AEmD0FhpsngH5+DQDdXT86SWkR7edcGVVK31y7lppFWNy0SOdHWSoC?=
 =?us-ascii?Q?cwoT4lx9afITd7pmApSQALwO/d7zQv/ufy8uT0yOPpEYnmf5IoNjELM/q+ij?=
 =?us-ascii?Q?Qk8v9JPzT/5Fyt8O8Cdw3BYFbfIn/CrON9Oz20FkantClScYeFx0ouLAxWq3?=
 =?us-ascii?Q?T9Y7+7WyOExduBeYjpmxR5HYMctf9frpv26S0BUoDcplGO28nVou49CNNAKE?=
 =?us-ascii?Q?Ckb/wDdGuwW6bnkonlEZdWLzbvqAS7wTcYoUh8U37l5SQW4z6OeTaCzEr4+g?=
 =?us-ascii?Q?xxQzx8rEB+XM0c4ZPjt5WJKoaxFXpm+83ZWViLLjLB8/UXv7J6Ed54wU/WtO?=
 =?us-ascii?Q?ptp/6oi8cAygKe5m5oOmlExiyMH+Uw7pos2RW8/6zulH24BqYIVbxzLwO/PV?=
 =?us-ascii?Q?pkXdfYm5c9iNrTxFPziJ8R0BOH3CQrT37hVMjaMo4gEhxBLqFXYqCEPjQFBZ?=
 =?us-ascii?Q?PDSAfhZl03iiVZbDarM/cZTcLItv7QQ9Z/d820jeFGcB+dAaksg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vn41hMXv1gqM4R+QQ1gt7PATxcwQXBG04LZ5X85YFJ4JLbp5+/HQcyci8m/p?=
 =?us-ascii?Q?R5ujYAtn3T5EUuKZI/3cJkHab8GVA1nKFhFMu1zfNiawXh0Kqr/mbPmLtZ7Q?=
 =?us-ascii?Q?bO8lg/+VohaGD9WNRgxpwUUqL4O+oVJeSbuggvCgMdcXQ0pCIiQtqvKbyAb4?=
 =?us-ascii?Q?F1nU1GJMoY6qYYj39exk6bTmDKxdx04kx3hdl0qtBYQ534GPRx6cXBf9dpdu?=
 =?us-ascii?Q?ZK8F7yBh39A3BxIbblvfuPINwtyVEO3gpfuRQfZuu7cGg0z8FuLxbcSuomKd?=
 =?us-ascii?Q?ryxE/qtyS3CqMMgUmuBS6Nt4EDWg3z8pKVgjhocRgXbbIcn0NM6pxF5FQYR1?=
 =?us-ascii?Q?rs4fyCIuYG6OA7GBGdrhk2NUZEzXTAZMq9Psj5YcgrjTW7apXvypNTPO/2fR?=
 =?us-ascii?Q?v0K2VFuCAh24fzObKyZqqsFX5SbnjHAz51O8yIN1g32Vcq2WPn/DPnFRDN09?=
 =?us-ascii?Q?tBKqQCVHQlgAN+4QQUQLPRpcn61B1zBhqMzj7e84NUdaGQMS9TeQ2KLzuEBw?=
 =?us-ascii?Q?ISod9sgzspHuliBATrZe5IS8wPx67pwK9aBLexHPah/RGTHfL9nMaInbjRpg?=
 =?us-ascii?Q?43AxMsm5FFRmDpE0sqosn+VlsuFDok89pWOX16dCO0jBcNdATnBa9/ndQU/Z?=
 =?us-ascii?Q?SvSHln6lpyjqAAZd9YGTzwz4hzn4/Sr+y8ytax/HlPck9K87R0B9702JX0ka?=
 =?us-ascii?Q?XrTTLkwyxuYSQzakOCdN/OTpeZZvlWtAYWEOWqVFSB6GfMfHgxe9s5FNilLm?=
 =?us-ascii?Q?IyYFspfgK4X0dY+aCoWawcsXZYZd85aRMkC1s+4eYFujNkSPq48eON5IdBET?=
 =?us-ascii?Q?+fgGpHjcB/iZfoYGtvF9WAI+SDmy1uVQkWhwd0BLTWUOSiCQy+L3Sk2iy6oz?=
 =?us-ascii?Q?Vd2Z4pOBW0qFiTIVBuTDUWxk+pJQ9K5hSDt77Z9d3klyKa1hQECUFpvplGfM?=
 =?us-ascii?Q?/j3+2FZNg9PI6lnpgTYbznVmTWeIgF5fK4Oa2GOINKUrsyVPmtrzbgrEXG4b?=
 =?us-ascii?Q?fR9usxutP0WHPkggmGIEWOyZJp4cfgvWPFXAon2pE1DxFQcg38yoI3NBP1Mj?=
 =?us-ascii?Q?rHgnXu7tpJcg/4+JAVJazG1BG/himUazv3T9RzEuPFesb0myy2WMwSTZoses?=
 =?us-ascii?Q?oLoqBkzypx8Iykwcd3gY9rD+3rcZelR1ZKS5XojBfbhQERvhjFygtEDg/kNC?=
 =?us-ascii?Q?ULXRi/hUyu/zR/avvMeympeiRiAeN9sxEOs2d3EFNrsV8LChQ53d4iuvEjo/?=
 =?us-ascii?Q?5tBXyZiiZ7xxm7EjiCiHuURr+4k/dE5rk8o9HsChZ91Qmda1LKYAMMrOg6LB?=
 =?us-ascii?Q?Btk/94bxao/z7co0E2INFbzXISnDvGETEhbGkLBMwuuR59lBlT1+tdTfbw3B?=
 =?us-ascii?Q?6BNp7bSyL4htDcahSszu9KaB+Mlf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024603d1-0258-46e6-0841-08df342d62a5
X-MS-Exchange-CrossTenant-AuthSource: OSQPR01MB6326.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:22:44.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4451

From: Xiaochun Yu <yxcnew@outlook.com>

kvm_arch_vcpu_put() saves the guest Vector state and restores the host
register file. A later vCPU load on the same hart saves the host again and
requests a full guest restore, even when no host user touched the Vector
data registers in between.

This RFC keeps the guest Vector register file resident across a vCPU
put/load pair when it is safe to do so. A matching load restores only the
control CSRs; all uncertain cases retain the existing full-restore path.

The series is intentionally conservative:

- every dirty vCPU put still saves the guest state, so guest memory remains
  authoritative for migration and userspace access;
- a per-hart owner records an opaque vCPU identity, an allocation cookie and a
  state generation, without retaining a dereferenceable vCPU pointer;
- task Vector save/restore/discard, kernel-mode Vector use, preemptible kernel
  Vector task resume and CPU state changes invalidate a resident guest before
  the registers can be reused;
- reset, dirty saves and KVM_SET_ONE_REG advance the generation;
- KVM_SET_ONE_REG advances the generation before copy_from_user(), because a
  partial copy can modify the destination and still return EFAULT;
- the optimization is guarded by a read-only module parameter and defaults to
  disabled. The generic invalidation sites are guarded by a static key.

Patch 1 establishes the generic invalidation boundary without changing KVM
behavior. Patch 2 adds the owner tracking, CSR-only restore and tracepoints.
Patch 3 adds focused lifetime, ONE_REG and partial-fault regression tests.

This series currently depends on the separately posted build fix:

  Message-ID: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
  Link: https://lore.kernel.org/all/OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com/

Ze Huang <ze.huang@oss.qualcomm.com> independently tested that prerequisite
with GCC 16.2.1 and Clang 23.1.3 and supplied a Tested-by tag in this reply:

  Link: https://lore.kernel.org/all/DMCBQSJ0B22A.2TDXAXPJNPZL2@oss.qualcomm.com/

Validation on Torvalds master 21a7f44fd076:

- CONFIG_RISCV_ISA_V=y, CONFIG_KVM=m: full Image + modules build;
- CONFIG_RISCV_ISA_V=n, CONFIG_KVM=m: full Image + modules build;
- lifetime, ONE_REG and partial-fault tests pass with the fast path disabled
  and enabled;
- nested KVM/RVV smoke passes 3/3 with the fast path enabled;
- the smoke trace recorded 785 owner hits, 784 CSR-only restores and eight
  conservative full fallbacks, with no trace-buffer overwrite;
- no emergency, alert, critical or error messages were present in dmesg.

Development note: OpenAI Codex was used in an extended interactive session to
assist with source analysis, implementation and selftest drafting, experiment
orchestration, patch review and changelog preparation. The prompts focused on
modeling per-hart ownership as a cache-validity problem, enumerating Vector
register invalidation boundaries, reproducing partial KVM_SET_ONE_REG writes
and reviewing the resulting patches. The build and runtime results above were
collected from the stated test environment rather than inferred by the model.

The nested QEMU result demonstrates functional behavior and event counts only;
it is not presented as a performance result. Hardware performance measurement
remains future work.

Feedback is especially welcome on whether the generic invalidation callback is
an acceptable RISC-V Vector/KVM boundary, whether the default-off module
parameter is useful for the first version, and whether the behavior patch
should be split further after the interface direction is agreed.

Xiaochun Yu (3):
  riscv: vector: Add a guest owner invalidation hook
  RISC-V: KVM: Preserve guest Vector state across vCPU put/load
  KVM: riscv: selftests: Add Vector owner regression tests

 arch/riscv/include/asm/kvm_host.h             |   4 +
 arch/riscv/include/asm/kvm_vcpu_vector.h      |  54 +++-
 arch/riscv/include/asm/processor.h            |   1 +
 arch/riscv/include/asm/vector.h               |  31 +++
 arch/riscv/kernel/kernel_mode_vector.c        |  38 +++
 arch/riscv/kvm/trace.h                        |  98 +++++++
 arch/riscv/kvm/vcpu.c                         |  54 +++-
 arch/riscv/kvm/vcpu_vector.c                  | 252 +++++++++++++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   3 +
 .../kvm/riscv/vector_owner_fault_test.c       | 147 ++++++++++
 .../kvm/riscv/vector_owner_lifetime_test.c    | 127 +++++++++
 .../kvm/riscv/vector_owner_onereg_test.c      | 191 +++++++++++++
 12 files changed, 976 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c
 create mode 100644 tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c
 create mode 100644 tools/testing/selftests/kvm/riscv/vector_owner_onereg_test.c


base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
prerequisite-patch-id: 370f0468ecd4354950ab075162058e4b7c31768b
-- 
2.43.0

