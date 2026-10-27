Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793108526;
	b=BOAirjmjOvJehyRUe8Cl5SfNWNYRrzGm5doFa7E8BAAxJ0dE3DhywQlP6+WjA8PjfTBa
	 oTSm8Lgj4BihbJlXanDKa/zKJ01rNqRJw1GNuXv1sEvTnxGeoJW7zYWHUQVIJ/zvNe7J5
	 KQg/5HYcmOvsTDzAWBHGqsXjNYy/lrxFEJTDSC7VnVpVJ6PwN4+SBJogkHHsz3yj4iDjd
	 fhZS9N4yoZBrYRaD9B0IDTRSrIU/biRFbFjLC+O7GJI9lF+B3iAUlYD2K11co9ZZUL0qr
	 1d5eISuMz8B8I3ioP/bJl7REF81xlvSMILDS8dAhdTB6wETJW58VSok+/XxwIeP0TTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108526;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:Message-ID:MIME-Version:
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
	bh=00mkrx4CeYwTHt7fbdjX80h00qsWLbeKFq2biJCdqvc=;
	b=SSMT9yp9AxKUAfJ5FQUcFeMGxk4u2aq/JoJuIwbzejgmfnvWAq3J8B76MsRAJm8iB0Yh
	 slNzb+95kL9HU7B3mDBKDOUJRd6q5+JdKH7RTyyFK8/UkOml8kQseLhERfVBVTcSqYYEN
	 u+9qhfRxGReXEtE3RROIjZ8E3b293ZZY4jCfHE375eMJEwTqgvg1fq3juWA9OOK5UV0MI
	 q4ffWlF7c8wnQkQJjUo0/R9gob0daVSSVvyH/dJpDlOs+hjrcL1+q/a1/EbVnh9RqjR0Y
	 tnh0CuiLEppunZCEqCnDmpnO1JzwcM+e1xqED5+t3pgGJV2gYks8ENwnaXCOCsMQmUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IdR6XXYW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.81
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013081.outbound.protection.outlook.com [52.103.43.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D21606A326;
	Tue, 27 Oct 2026 13:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D21606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IdR6XXYW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnVApT7Rf+ZzYGBXrgbPb9TlXlVju5plgpzE59OlopfTH8esFcJrkeOp9fuaWtgjqAMDci3uIkxhDxffJFvM6qlK/9ON4XFgEwfGORlF/2/IhOunu6JllpXKgaurOcvSPamjDd6vb76tpr++7oPPptIsBtz0KE/Lx/ZBVr0nXXm3z192f3U7sSOjG7279ZedTb8ITozna+LI/HuTCO1rkJswAEc952VCdX7J3g2I41/eJzzNDLlKn4nzF9Ssi3HwfiRshMgKlWymR5rPpYhGVgwrNjQyMuwzU4X3hB7v34qC54fuO7IeBOy+9RW8u7tU2cRuNhl+YeE17B10a/EIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00mkrx4CeYwTHt7fbdjX80h00qsWLbeKFq2biJCdqvc=;
 b=PVwGdVE3ie/QzYO2HquAkEQUZBltDpkog3PPwO63rtUJ/GoW6uTmpLf3JXQ9/XLI3SIpIXM21MluNvKzECLAm2w+ZZK/dhkSzuhK+80YeESTOtxgq7ArXq25ykScqSxcwX/qXfpV0Kw5VpglIPr9z5xBVX4bYtdq3GO8CQOXwJNAHA6PWhyntV0BB529+7F+HJFg/8G55cPJ1ZssJKO7enDKUTjbUJ22o5JzDonZSFk3FM37A7LHXA5u62V8NZ86zr7rUbJj2HzwBmvgH9patCzdya/RQXSIIiBOolF6v/gvCioa8BBXxPkxswyFBS5F0BjpwqdWbWV2n/y0Tz6zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00mkrx4CeYwTHt7fbdjX80h00qsWLbeKFq2biJCdqvc=;
 b=IdR6XXYWd0DFKGB090CMHuSZgxAn8pzIb5rXtpTfgOVGIu27R18C5/3Dp5nM9QVkj535ibHAc+DOMWcCRVkj8rA7PxiVWiURfyUc104XWs6s35FlpTVQ1MY3yfBxpGuwC4BJL/90pDmORHyMq7mXMYnx/8uneY8dzBOBAJ8bAQz/IyJqHVgWJ25zIkG08PzqvvtDyiEct7uiCJsbjVgSaKKTOrP6LsyfEwlJbvF8re4YKLCEKbFiWB4tVwsDjZZGnTR81VcMOhoPrg9vcY+isGs6TnxC33qiYZ3LJ0VFBMTGBmaXaLtiahCTh89TCCkyAthmnh63LQRGcUS7xIEsaA==
Received: from OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 (2603:1096:604:290::7) by SEZPR01MB4600.apcprd01.prod.exchangelabs.com
 (2603:1096:101:93::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:42:00 +0000
Received: from OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 ([fe80::708b:59ed:4ad6:b84c]) by OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 ([fe80::708b:59ed:4ad6:b84c%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:42:00 +0000
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
Subject: [RFC PATCH 2/3] RISC-V: KVM: Preserve guest Vector state across vCPU put/load
Date: Tue, 27 Oct 2026 13:13:08 +0000
X-Mailer: git-send-email 2.43.0
In-Reply-To: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
References: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0149.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::19) To OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 (2603:1096:604:290::7)
Message-ID:
 <OSQPR01MB63262D568C71BC3510AAC4A4C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
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
X-MS-TrafficTypeDiagnostic: OSQPR01MB6326:EE_|SEZPR01MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: ce527d0a-fde8-4cb2-aa88-08df34301358
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|12121999013|8060799015|19110799012|23021999003|24021099003|51005399006|41001999006|25010399006|260925184616899003|440099028|3412199025|12091999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qgZDEtQZue+Ph/NqgxnoMjDDIHm1E0LgV/NWh3U5U78yLQ/IPqR3vsi4Ywg2?=
 =?us-ascii?Q?6BNlNfGyZXRaaMAQqQM3hLWSX1UqgVb7ITrmf8N0W69fqRXw1DstNywpQ/dg?=
 =?us-ascii?Q?uZaMVzxAUbuFi+ULuubhZuf8YJIv68o6Fv7ZyhAsSgHGFqMs2sk1HvZhGAMi?=
 =?us-ascii?Q?0mzSsUF8IUxgmeAHbrtI/zcDyhhdqJXV3YVQ+w62sSw5HY9N6DFx4QbuD5+4?=
 =?us-ascii?Q?JDeFXk3wmCigiUXIKn4yPcV1DJc+e2mGak/CFpKY5/Nd3g+3TKs1Y/RUZotj?=
 =?us-ascii?Q?ItD1sUiAjxCuXZiv6Wab+3xSGTM+B6nuFZYdH/zg9UgLjt/DMKhvMsTBhDnj?=
 =?us-ascii?Q?x4Lhjxa1YsbelpfcRrpnRGjSinGPm7RNzkobBFEfHeZlOaPQjGXshXk5HNra?=
 =?us-ascii?Q?uuYu5PlmCPXdrPABd59XjUMrXwsVbDzc0arpVokRh8HTLi/GB2oiKYHvwyFY?=
 =?us-ascii?Q?bQEJKzzGTFd8wNr690oSr5wMrkQjMY6/mIofPmmOfNdLHmsDEiGVGDGN3iuk?=
 =?us-ascii?Q?3kC+zqyVesdnkSGb3tI5v3liwLC/Fh3gA9l+D/RpT/EjJ1PgKcLjGHy245CK?=
 =?us-ascii?Q?t1ftYJb415FtPVuG3Di7kqBKs0qoQjX4WQHJVPLpHPakVIxrh9A4KQ8d3qEb?=
 =?us-ascii?Q?VkuCWr0Uo9AyX2sz/i541zSApHjQ74VSZzFnFXEJgBNng/1Xk8KC41JBtABr?=
 =?us-ascii?Q?0cnfGTsgR5s7DVkzZp3hpjoptsHCqqAwDVVlw5SeWj51CjoJtooSfEVin3qu?=
 =?us-ascii?Q?DuXvNmBjkvfivXohHcFHPQ7Qhsb5jqD4YxZQFaa4X6H1t9AGDjXkHK8Q4JrH?=
 =?us-ascii?Q?Lw7ILuTpRJL/sPsjaThEBzOcZZO63GjjFEO36o/DzutpPNqYzN6Gv+D/WSgc?=
 =?us-ascii?Q?thgtRL4dM7GmVVlSis6ygG9TbAtzdRM4R2QIPR0jnu489ixXvFWJeWmeh+2o?=
 =?us-ascii?Q?2z+KysgrTDTetQi1K6dsU/4jjRBtM6KQfem6VKe05u64BEIijFEvQWdnHOs0?=
 =?us-ascii?Q?llJt5fRv5qEcSxMph6TVdd0wemB09zj1alyuRuojLM04e4OQv/Rmf/dR2oTk?=
 =?us-ascii?Q?luuwLhZs?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YP6WTczdu/225GTWu+M3oR8a1Jkh+1twK9pFbckBXXhg4/LRQ2VOpz++FC/J?=
 =?us-ascii?Q?2GccPovqYGfqrrPnOX0ZnPgVchM/uGBz5iKeQJQky0ayhemrFKsKGAR8knMS?=
 =?us-ascii?Q?wfdc/uhZyQ4DIBdyfmBL3dTyurpPbM04yGF4evfrI2J8l+BA+f1S3KSeF6td?=
 =?us-ascii?Q?hsBh0EStzRF/zndcbYGGpqFV6AwafoYvYJ85tY6P1eittCXE9JvxcpWU2OOI?=
 =?us-ascii?Q?Awb5OhbaK2K6Y31wGH4HCA90j4Y2AbJ8qydJRhOmVnwBuWoJgYr6MXIkzvFh?=
 =?us-ascii?Q?Xbu8Z/03AY67Ci1M68r5g5LlUG5B3drOzXnQoRpTjyBAvVIVSwsHTAtbzK8h?=
 =?us-ascii?Q?PgBuZetpBI0i8YPUmth795zjPke32QTFI5vVwVyB7uTKEkYYoWHXRhRTIHy9?=
 =?us-ascii?Q?+8GqiYWO6OMYYhX4cztWMwRuCiHvSqBpCvFUsxCLGov5WzhASrvb8JX7149z?=
 =?us-ascii?Q?AzEZrOtkSm6a9GZGLzcN4oSBru78lEK7JDGX5nSUQxFEd1xbQCVyD8bU2ZrW?=
 =?us-ascii?Q?SZ8u7kz1zc38AzUuu8Uq3cCDEl01o7r0d+CEuxBYCgRwSJDkKPuMGSwMIiX0?=
 =?us-ascii?Q?GovrUD2EWn6n+MCXdortnjiAl1WLpN0pZZpeNFuD0T3/7PvXgjlsJz4WMz2F?=
 =?us-ascii?Q?24EA28YDGY/xzwHTSFAcG/L/IYCcA8K8KY3TXjP8CgHUO0xjjYt0jiCXlOFp?=
 =?us-ascii?Q?vGBqIVCbsc3OVwj8rfH/zAcjwI9jV/2vpkUqUJ17sfvIUfftNLaL5ATDOksg?=
 =?us-ascii?Q?pM/bFEVlFTbnA75pAN+v+D+tq5MaOAqOmPpNXCwaXuTr9S90d5b+WpXG9ZXb?=
 =?us-ascii?Q?XxnofANzxib1zXet1R/sN/OEhoiigEZu7JgPet+mNpzUJvGFA6bGuqMlgRJC?=
 =?us-ascii?Q?LQRGdgZ0w0nbnda2T1i4cAjQWtV2uvLzTO/EK28LY6HftK4UtfRIyOhmCWGO?=
 =?us-ascii?Q?En7rnnnvpVKj88JeHsoHGpIvsxqgUXZx1kAlikDx0PNbKub5Ysb/1Nnaqp1o?=
 =?us-ascii?Q?8805+FKWrXmh9mq3P1W+a0NTArPWlYu/OjsO43thnn0CHtDDPoaM7cBSAnLh?=
 =?us-ascii?Q?yME3McxVcklZ89vnTbbSp4VAp49jnQXqmm9DLKSqaxq6rjvnnZqEncdhKrVq?=
 =?us-ascii?Q?2YRISCB0Rcph1y/YSCNYFWwql6tONEGRNpS2f8I9X9vNqamOQCaBWsnUQ6y4?=
 =?us-ascii?Q?tuYp+2Aju0Lbejx5aNL0hmQoKhpBUQt7asoYQ8ruZl/j0EDrrA3d9G8vtfd1?=
 =?us-ascii?Q?MuHHW+z8r/KqPxDmApLCOTO4y9zbstsPQS1eDTGs+wBwIXlp7zCHLs+/FNlI?=
 =?us-ascii?Q?5O1Qsj+ri+mumXM8d5XQLAwkpv9OOX66oL7yv1CdTEOUvzdRCqctNatg/I0q?=
 =?us-ascii?Q?HM/JpAYeri1dHRaYExL6xhuR+dGa?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce527d0a-fde8-4cb2-aa88-08df34301358
X-MS-Exchange-CrossTenant-AuthSource: OSQPR01MB6326.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:41:59.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4600

From: Xiaochun Yu <yxcnew@outlook.com>

kvm_arch_vcpu_put() saves the guest Vector state and restores the host
register file. A later load on the same hart saves the host again and
requests a full guest restore, even when the host has not used Vector in
between.

Track a per-hart owner with an opaque vCPU identity, an allocation cookie
and a state generation. After saving a dirty guest to memory, leave its
data registers resident when the host has no Vector restore obligation. A
matching load restores only the Vector control CSRs. All mismatches and
generic Vector users fall back to a full restore.

Keep guest memory authoritative by continuing to save at every dirty put.
Advance the generation on saves, resets and SET_ONE_REG. Do so before
copy_from_user() because a fault can leave a modified prefix in the
destination even though the ioctl fails.

Register the generic invalidation hook only when the read-only
vector_owner_fastpath module parameter is enabled. The parameter defaults
to false so the existing full-restore behavior remains the default. Add
tracepoints for restore mode, owner decisions and invalidation reasons.

Development note: OpenAI Codex assisted with source analysis,
implementation drafting, test orchestration and changelog preparation.

Signed-off-by: Xiaochun Yu <yxcnew@outlook.com>
---
 arch/riscv/include/asm/kvm_host.h        |   4 +
 arch/riscv/include/asm/kvm_vcpu_vector.h |  54 ++++-
 arch/riscv/include/asm/processor.h       |   1 +
 arch/riscv/kvm/trace.h                   |  98 +++++++++
 arch/riscv/kvm/vcpu.c                    |  54 ++++-
 arch/riscv/kvm/vcpu_vector.c             | 252 ++++++++++++++++++++++-
 6 files changed, 439 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index e28f058a94d7..a6e2b3097644 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -204,6 +204,10 @@ struct kvm_vcpu_arch {
 	/* CPU context of Guest VCPU */
 	struct kvm_cpu_context guest_context;
 
+	/* Identity and version used by Vector owner tracking. */
+	u64 vector_owner_cookie;
+	u64 vector_state_generation;
+
 	/* CPU CSR context of Guest VCPU */
 	struct kvm_vcpu_csr guest_csr;
 
diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index ebc619ed67dd..7f3eecf4217b 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -26,29 +26,47 @@ static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *c
 	__riscv_v_vstate_restore(&context->vector, context->vector.datap);
 }
 
+static __always_inline void __kvm_riscv_vector_restore_csrs(struct kvm_cpu_context *context)
+{
+	riscv_v_enable();
+	__vstate_csr_restore(&context->vector);
+	riscv_v_disable();
+}
+
 void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
 				      unsigned long *isa);
 void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
-					 unsigned long *isa);
+					 unsigned long *isa, bool csr_only);
 void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx);
-void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx);
+void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx,
+					bool preserve_guest);
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_register_vctx_callback(void (*func)(void));
 void kvm_riscv_unregister_vctx_callback(void);
+bool kvm_riscv_vcpu_vector_owner_enabled(void);
+bool kvm_riscv_vcpu_vector_owner_load(struct kvm_vcpu *vcpu, int cpu);
+bool kvm_riscv_vcpu_vector_owner_put(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_vector_owner_invalidate(enum riscv_v_invalidate_reason reason);
 void kvm_riscv_vcpu_flush_vector(void);
 
 static inline void kvm_riscv_v_init(void)
 {
-	if (has_vector())
+	if (has_vector()) {
 		kvm_riscv_register_vctx_callback(&kvm_riscv_vcpu_flush_vector);
+		if (kvm_riscv_vcpu_vector_owner_enabled())
+			kvm_riscv_register_vctx_invalidate(&kvm_riscv_vcpu_vector_owner_invalidate);
+	}
 }
 
 static inline void kvm_riscv_v_exit(void)
 {
-	if (has_vector())
+	if (has_vector()) {
+		if (kvm_riscv_vcpu_vector_owner_enabled())
+			kvm_riscv_unregister_vctx_invalidate();
 		kvm_riscv_unregister_vctx_callback();
+	}
 }
 
 #else
@@ -59,6 +77,10 @@ static inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *context)
 {
 }
 
+static inline void __kvm_riscv_vector_restore_csrs(struct kvm_cpu_context *context)
+{
+}
+
 static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
 {
 }
@@ -69,7 +91,7 @@ static inline void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx
 }
 
 static inline void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
-						       unsigned long *isa)
+					       unsigned long *isa, bool csr_only)
 {
 }
 
@@ -77,7 +99,8 @@ static inline void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
 {
 }
 
-static inline void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
+static inline void
+kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx, bool preserve_guest)
 {
 }
 
@@ -90,6 +113,25 @@ static inline void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
 {
 }
 
+static inline bool kvm_riscv_vcpu_vector_owner_enabled(void)
+{
+	return false;
+}
+
+static inline bool kvm_riscv_vcpu_vector_owner_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	return false;
+}
+
+static inline bool kvm_riscv_vcpu_vector_owner_put(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline void kvm_riscv_vcpu_vector_owner_invalidate(enum riscv_v_invalidate_reason reason)
+{
+}
+
 static inline void kvm_riscv_v_init(void)
 {
 }
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 815715c67f94..abda84ca9548 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -105,6 +105,7 @@ struct pt_regs;
 #define RISCV_KERNEL_MODE_V		0x00000001
 #define RISCV_V_VCPU_NEED_RESTORE	0x00000002
 #define RISCV_V_VCPU_CTX		0x00000004
+#define RISCV_V_VCPU_CSR_RESTORE	0x00000008
 #define RISCV_PREEMPT_V			0x00000100
 #define RISCV_PREEMPT_V_DIRTY		0x80000000
 #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
diff --git a/arch/riscv/kvm/trace.h b/arch/riscv/kvm/trace.h
index 23a5fd1b686e..c805606c704d 100644
--- a/arch/riscv/kvm/trace.h
+++ b/arch/riscv/kvm/trace.h
@@ -133,6 +133,104 @@ TRACE_EVENT(kvm_vcpu_irq,
 		  __entry->vcpu_id, __entry->irq, __entry->level)
 );
 
+TRACE_EVENT(kvm_riscv_vector_restore_request,
+	TP_PROTO(unsigned long vcpu_id, int cpu, unsigned int source,
+		 unsigned long host_vs),
+	TP_ARGS(vcpu_id, cpu, source, host_vs),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, vcpu_id)
+		__field(int, cpu)
+		__field(unsigned int, source)
+		__field(unsigned long, host_vs)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->cpu		= cpu;
+		__entry->source		= source;
+		__entry->host_vs	= host_vs;
+	),
+
+	TP_printk("VCPU: %lu, CPU: %d, source: %s, host VS: 0x%lx",
+		  __entry->vcpu_id, __entry->cpu,
+		  __print_symbolic(__entry->source,
+				   { 0, "load" }, { 1, "kernel_vector" }),
+		  __entry->host_vs)
+);
+
+TRACE_EVENT(kvm_riscv_vector_restore,
+	TP_PROTO(unsigned long vcpu_id, int cpu, bool csr_only),
+	TP_ARGS(vcpu_id, cpu, csr_only),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, vcpu_id)
+		__field(int, cpu)
+		__field(bool, csr_only)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->cpu		= cpu;
+		__entry->csr_only	= csr_only;
+	),
+
+	TP_printk("VCPU: %lu, CPU: %d, mode: %s",
+		  __entry->vcpu_id, __entry->cpu,
+		  __entry->csr_only ? "csr" : "full")
+);
+
+TRACE_EVENT(kvm_riscv_vector_owner,
+	TP_PROTO(unsigned long vcpu_id, int cpu, unsigned int action,
+		 bool eligible, unsigned int reason, unsigned long host_vs,
+		 unsigned long guest_vs, u64 generation),
+	TP_ARGS(vcpu_id, cpu, action, eligible, reason, host_vs, guest_vs,
+		generation),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, vcpu_id)
+		__field(int, cpu)
+		__field(unsigned int, action)
+		__field(bool, eligible)
+		__field(unsigned int, reason)
+		__field(unsigned long, host_vs)
+		__field(unsigned long, guest_vs)
+		__field(u64, generation)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->cpu		= cpu;
+		__entry->action		= action;
+		__entry->eligible	= eligible;
+		__entry->reason		= reason;
+		__entry->host_vs	= host_vs;
+		__entry->guest_vs	= guest_vs;
+		__entry->generation	= generation;
+	),
+
+	TP_printk("VCPU: %lu, CPU: %d, action: %s, eligible: %d, reason: %s, host VS: 0x%lx, guest VS: 0x%lx, generation: %llu",
+		  __entry->vcpu_id, __entry->cpu,
+		  __print_symbolic(__entry->action,
+				   { 0, "load" }, { 1, "put" },
+				   { 2, "invalidate" }),
+		  __entry->eligible,
+		  __print_symbolic(__entry->reason,
+				   { 0, "hit" }, { 1, "empty" },
+				   { 2, "other_vcpu" }, { 3, "cookie" },
+				   { 4, "generation" }, { 5, "guest_off" },
+				   { 6, "host_on" }, { 7, "migration" },
+				   { 8, "put_candidate" },
+				   { 9, "task_save" },
+				   { 10, "task_restore" },
+				   { 11, "task_discard" },
+				   { 12, "kernel_vector" },
+				   { 13, "cpu_state" },
+				   { 14, "not_resident" }),
+		  __entry->host_vs, __entry->guest_vs,
+		  __entry->generation)
+);
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 7f1636c44d41..a59cac26ca7c 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -35,6 +35,7 @@ void kvm_riscv_clear_former_vcpu(void)
 	 * via the fast-path optimization.
 	 */
 	__this_cpu_write(kvm_former_vcpu, NULL);
+	kvm_riscv_vcpu_vector_owner_invalidate(RISCV_V_INVALIDATE_CPU_STATE);
 }
 
 const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
@@ -589,6 +590,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+	bool vector_owner_hit;
 
 	/*
 	 * If VCPU is being reloaded on the same physical CPU and no
@@ -647,9 +649,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
 					vcpu->arch.isa);
 	get_cpu_vector_context();
-	kvm_riscv_vcpu_host_vector_save(&vcpu->arch.host_context);
+	vector_owner_hit = kvm_riscv_vcpu_vector_owner_load(vcpu, cpu);
+	if (!vector_owner_hit)
+		kvm_riscv_vcpu_host_vector_save(&vcpu->arch.host_context);
 	kvm_riscv_vcpu_guest_vector_restore(&vcpu->arch.guest_context,
-					    vcpu->arch.isa);
+					    vcpu->arch.isa, vector_owner_hit);
 	put_cpu_vector_context();
 
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
@@ -661,6 +665,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+	bool preserve_guest;
 
 	vcpu->cpu = -1;
 
@@ -674,7 +679,9 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	get_cpu_vector_context();
 	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
 					 vcpu->arch.isa);
-	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);
+	preserve_guest = kvm_riscv_vcpu_vector_owner_put(vcpu);
+	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context,
+					   preserve_guest);
 	put_cpu_vector_context();
 
 	if (kvm_riscv_nacl_available()) {
@@ -793,6 +800,12 @@ static __always_inline void kvm_riscv_vcpu_swap_in_host_state(struct kvm_vcpu *v
 		zicficsr->ssp = csr_swap(CSR_SSP, 0);
 }
 
+enum kvm_riscv_vector_restore_type {
+	KVM_RISCV_VECTOR_RESTORE_NONE,
+	KVM_RISCV_VECTOR_RESTORE_FULL,
+	KVM_RISCV_VECTOR_RESTORE_CSR,
+};
+
 /*
  * Actually run the vCPU, entering an RCU extended quiescent state (EQS) while
  * the vCPU is running.
@@ -800,12 +813,14 @@ static __always_inline void kvm_riscv_vcpu_swap_in_host_state(struct kvm_vcpu *v
  * This must be noinstr as instrumentation may make use of RCU, and this is not
  * safe during the EQS.
  */
-static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
-					      struct kvm_cpu_trap *trap)
+static int noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
+					     struct kvm_cpu_trap *trap)
 {
 	void *nsh;
 	struct kvm_cpu_context *gcntx = &vcpu->arch.guest_context;
 	struct kvm_cpu_context *hcntx = &vcpu->arch.host_context;
+	int vector_restore = KVM_RISCV_VECTOR_RESTORE_NONE;
+	u32 vector_flags;
 
 	/*
 	 * We save trap CSRs (such as SEPC, SCAUSE, STVAL, HTVAL, and
@@ -818,11 +833,21 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	kvm_riscv_vcpu_swap_in_guest_state(vcpu);
 	guest_state_enter_irqoff();
 
-	/* sstatus.VS != SR_VS_OFF is guaranteed when NEED_RESTORE is set */
-	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
-		current->thread.riscv_v_flags &= ~RISCV_V_VCPU_NEED_RESTORE;
+	vector_flags = current->thread.riscv_v_flags;
+	/* sstatus.VS != SR_VS_OFF is guaranteed for either restore request. */
+	if (vector_flags & (RISCV_V_VCPU_NEED_RESTORE |
+			    RISCV_V_VCPU_CSR_RESTORE)) {
+		current->thread.riscv_v_flags &=
+			~(RISCV_V_VCPU_NEED_RESTORE |
+			  RISCV_V_VCPU_CSR_RESTORE);
 		current->thread.riscv_v_flags |= RISCV_V_VCPU_CTX;
-		__kvm_riscv_vector_restore(gcntx);
+		if (vector_flags & RISCV_V_VCPU_NEED_RESTORE) {
+			__kvm_riscv_vector_restore(gcntx);
+			vector_restore = KVM_RISCV_VECTOR_RESTORE_FULL;
+		} else {
+			__kvm_riscv_vector_restore_csrs(gcntx);
+			vector_restore = KVM_RISCV_VECTOR_RESTORE_CSR;
+		}
 		gcntx->sstatus = (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
 	}
 
@@ -886,6 +911,8 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	vcpu->arch.last_exit_cpu = vcpu->cpu;
 	guest_state_exit_irqoff();
 	kvm_riscv_vcpu_swap_in_host_state(vcpu);
+
+	return vector_restore;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
@@ -893,6 +920,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	int ret;
 	struct kvm_cpu_trap trap;
 	struct kvm_run *run = vcpu->run;
+	int vector_restore;
 
 	if (!vcpu->arch.ran_atleast_once)
 		kvm_riscv_vcpu_config_ran_once(vcpu);
@@ -1001,7 +1029,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		guest_timing_enter_irqoff();
 
-		kvm_riscv_vcpu_enter_exit(vcpu, &trap);
+		vector_restore = kvm_riscv_vcpu_enter_exit(vcpu, &trap);
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
@@ -1026,6 +1054,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_enable();
 
+		if (vector_restore == KVM_RISCV_VECTOR_RESTORE_FULL)
+			trace_kvm_riscv_vector_restore(vcpu->vcpu_id,
+						       smp_processor_id(), false);
+		else if (vector_restore == KVM_RISCV_VECTOR_RESTORE_CSR)
+			trace_kvm_riscv_vector_restore(vcpu->vcpu_id,
+						       smp_processor_id(), true);
 		trace_kvm_exit(&trap);
 
 		preempt_enable();
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index fefc2857f753..c197d3d7b539 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -7,9 +7,11 @@
  *     Greentime Hu <greentime.hu@sifive.com>
  */
 
+#include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
+#include <linux/moduleparam.h>
 #include <linux/nospec.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
@@ -17,7 +19,50 @@
 #include <asm/kvm_vcpu_vector.h>
 #include <asm/vector.h>
 
+#include "trace.h"
+
 #ifdef CONFIG_RISCV_ISA_V
+enum kvm_riscv_vector_owner_reason {
+	KVM_RISCV_VECTOR_OWNER_HIT,
+	KVM_RISCV_VECTOR_OWNER_EMPTY,
+	KVM_RISCV_VECTOR_OWNER_OTHER_VCPU,
+	KVM_RISCV_VECTOR_OWNER_COOKIE,
+	KVM_RISCV_VECTOR_OWNER_GENERATION,
+	KVM_RISCV_VECTOR_OWNER_GUEST_OFF,
+	KVM_RISCV_VECTOR_OWNER_HOST_ON,
+	KVM_RISCV_VECTOR_OWNER_MIGRATION,
+	KVM_RISCV_VECTOR_OWNER_PUT_CANDIDATE,
+	KVM_RISCV_VECTOR_OWNER_TASK_SAVE,
+	KVM_RISCV_VECTOR_OWNER_TASK_RESTORE,
+	KVM_RISCV_VECTOR_OWNER_TASK_DISCARD,
+	KVM_RISCV_VECTOR_OWNER_KERNEL_VECTOR,
+	KVM_RISCV_VECTOR_OWNER_CPU_STATE,
+	KVM_RISCV_VECTOR_OWNER_NOT_RESIDENT,
+};
+
+struct kvm_riscv_vector_owner {
+	/* Opaque comparison token; cookie rejects address reuse after destroy. */
+	unsigned long identity;
+	u64 cookie;
+	u64 generation;
+	unsigned long vcpu_id;
+	unsigned long guest_vs;
+};
+
+static DEFINE_PER_CPU(struct kvm_riscv_vector_owner,
+			      kvm_riscv_vector_owner);
+static atomic64_t kvm_riscv_vector_owner_cookie = ATOMIC64_INIT(0);
+static bool kvm_riscv_vector_owner_fastpath;
+module_param_named(vector_owner_fastpath, kvm_riscv_vector_owner_fastpath,
+		   bool, 0444);
+MODULE_PARM_DESC(vector_owner_fastpath,
+		 "Preserve matched guest Vector registers across vCPU put/load");
+
+bool kvm_riscv_vcpu_vector_owner_enabled(void)
+{
+	return READ_ONCE(kvm_riscv_vector_owner_fastpath);
+}
+
 void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
 {
 	unsigned long *isa = vcpu->arch.isa;
@@ -34,6 +79,8 @@ void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
 	} else {
 		cntx->sstatus |= SR_VS_OFF;
 	}
+
+	vcpu->arch.vector_state_generation++;
 }
 
 static void kvm_riscv_vcpu_vector_clean(struct kvm_cpu_context *cntx)
@@ -46,18 +93,35 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
 				      unsigned long *isa)
 {
 	if ((cntx->sstatus & SR_VS) == SR_VS_DIRTY) {
-		if (riscv_isa_extension_available(isa, V))
+		if (riscv_isa_extension_available(isa, V)) {
+			struct kvm_vcpu *vcpu = container_of(cntx, struct kvm_vcpu,
+							  arch.guest_context);
+
 			__kvm_riscv_vector_save(cntx);
+			vcpu->arch.vector_state_generation++;
+		}
 		kvm_riscv_vcpu_vector_clean(cntx);
 	}
 }
 
 void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
-					 unsigned long *isa)
+					 unsigned long *isa, bool csr_only)
 {
 	if ((cntx->sstatus & SR_VS) != SR_VS_OFF) {
-		if (riscv_isa_extension_available(isa, V))
-			riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RESTORE);
+		if (riscv_isa_extension_available(isa, V)) {
+			struct kvm_vcpu *vcpu = container_of(cntx, struct kvm_vcpu,
+							  arch.guest_context);
+			unsigned long host_vs = task_pt_regs(current)->status & SR_VS;
+			u32 flags = riscv_v_flags();
+
+			flags &= ~(RISCV_V_VCPU_NEED_RESTORE |
+				   RISCV_V_VCPU_CSR_RESTORE);
+			flags |= csr_only ? RISCV_V_VCPU_CSR_RESTORE :
+					    RISCV_V_VCPU_NEED_RESTORE;
+			riscv_v_flags_set(flags);
+			trace_kvm_riscv_vector_restore_request(vcpu->vcpu_id,
+							       smp_processor_id(), 0, host_vs);
+		}
 	}
 }
 
@@ -68,11 +132,167 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
 		__kvm_riscv_vector_save(cntx);
 }
 
-void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
+void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx,
+					bool preserve_guest)
 {
-	if (!kvm_riscv_isa_check_host(V))
+	if (!preserve_guest && !kvm_riscv_isa_check_host(V))
 		__kvm_riscv_vector_restore(cntx);
-	riscv_v_flags_set(riscv_v_flags() & ~(RISCV_V_VCPU_CTX | RISCV_V_VCPU_NEED_RESTORE));
+	riscv_v_flags_set(riscv_v_flags() &
+			  ~(RISCV_V_VCPU_CTX | RISCV_V_VCPU_NEED_RESTORE |
+			    RISCV_V_VCPU_CSR_RESTORE));
+}
+
+bool kvm_riscv_vcpu_vector_owner_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct kvm_riscv_vector_owner *owner;
+	unsigned long guest_vs = vcpu->arch.guest_context.sstatus & SR_VS;
+	unsigned long host_vs = task_pt_regs(current)->status & SR_VS;
+	enum kvm_riscv_vector_owner_reason reason;
+	bool eligible = false;
+
+	if (!kvm_riscv_vcpu_vector_owner_enabled())
+		return false;
+
+	owner = this_cpu_ptr(&kvm_riscv_vector_owner);
+	if (guest_vs == SR_VS_OFF) {
+		reason = KVM_RISCV_VECTOR_OWNER_GUEST_OFF;
+	} else if (host_vs != SR_VS_OFF) {
+		reason = KVM_RISCV_VECTOR_OWNER_HOST_ON;
+	} else if (!owner->identity) {
+		reason = vcpu->arch.last_exit_cpu == cpu ?
+			 KVM_RISCV_VECTOR_OWNER_EMPTY :
+			 KVM_RISCV_VECTOR_OWNER_MIGRATION;
+	} else if (owner->identity != (unsigned long)vcpu) {
+		reason = KVM_RISCV_VECTOR_OWNER_OTHER_VCPU;
+	} else if (owner->cookie != vcpu->arch.vector_owner_cookie) {
+		reason = KVM_RISCV_VECTOR_OWNER_COOKIE;
+	} else if (owner->generation != vcpu->arch.vector_state_generation) {
+		reason = KVM_RISCV_VECTOR_OWNER_GENERATION;
+	} else {
+		reason = KVM_RISCV_VECTOR_OWNER_HIT;
+		eligible = true;
+	}
+
+	trace_kvm_riscv_vector_owner(vcpu->vcpu_id, cpu, 0, eligible,
+				     reason, host_vs, guest_vs,
+				     vcpu->arch.vector_state_generation);
+
+	/* A load consumes the cached owner; the next put publishes it. */
+	owner->identity = 0;
+	owner->cookie = 0;
+	owner->generation = 0;
+	owner->vcpu_id = 0;
+	owner->guest_vs = 0;
+
+	return eligible;
+}
+
+bool kvm_riscv_vcpu_vector_owner_put(struct kvm_vcpu *vcpu)
+{
+	struct kvm_riscv_vector_owner *owner;
+	unsigned long guest_vs = vcpu->arch.guest_context.sstatus & SR_VS;
+	unsigned long host_vs = task_pt_regs(current)->status & SR_VS;
+	u32 flags = riscv_v_flags();
+	enum kvm_riscv_vector_owner_reason reason;
+	bool eligible;
+
+	if (!kvm_riscv_vcpu_vector_owner_enabled())
+		return false;
+
+	owner = this_cpu_ptr(&kvm_riscv_vector_owner);
+	eligible = guest_vs != SR_VS_OFF && host_vs == SR_VS_OFF &&
+		   (flags & RISCV_V_VCPU_CTX) &&
+		   !(flags & (RISCV_V_VCPU_NEED_RESTORE |
+			      RISCV_V_VCPU_CSR_RESTORE));
+	if (eligible) {
+		owner->identity = (unsigned long)vcpu;
+		owner->cookie = vcpu->arch.vector_owner_cookie;
+		owner->generation = vcpu->arch.vector_state_generation;
+		owner->vcpu_id = vcpu->vcpu_id;
+		owner->guest_vs = guest_vs;
+		reason = KVM_RISCV_VECTOR_OWNER_PUT_CANDIDATE;
+	} else {
+		owner->identity = 0;
+		owner->cookie = 0;
+		owner->generation = 0;
+		owner->vcpu_id = 0;
+		owner->guest_vs = 0;
+		if (guest_vs == SR_VS_OFF)
+			reason = KVM_RISCV_VECTOR_OWNER_GUEST_OFF;
+		else if (host_vs != SR_VS_OFF)
+			reason = KVM_RISCV_VECTOR_OWNER_HOST_ON;
+		else
+			reason = KVM_RISCV_VECTOR_OWNER_NOT_RESIDENT;
+	}
+
+	trace_kvm_riscv_vector_owner(vcpu->vcpu_id, smp_processor_id(), 1,
+				     eligible, reason, host_vs, guest_vs,
+				     vcpu->arch.vector_state_generation);
+
+	return eligible;
+}
+
+void kvm_riscv_vcpu_vector_owner_invalidate(enum riscv_v_invalidate_reason reason)
+{
+	struct kvm_riscv_vector_owner *owner;
+	struct kvm_vcpu *vcpu;
+	enum kvm_riscv_vector_owner_reason trace_reason;
+	unsigned long host_vs;
+	u32 flags;
+
+	switch (reason) {
+	case RISCV_V_INVALIDATE_TASK_SAVE:
+		trace_reason = KVM_RISCV_VECTOR_OWNER_TASK_SAVE;
+		break;
+	case RISCV_V_INVALIDATE_TASK_RESTORE:
+		trace_reason = KVM_RISCV_VECTOR_OWNER_TASK_RESTORE;
+		break;
+	case RISCV_V_INVALIDATE_TASK_DISCARD:
+		trace_reason = KVM_RISCV_VECTOR_OWNER_TASK_DISCARD;
+		break;
+	case RISCV_V_INVALIDATE_KERNEL_VECTOR:
+		trace_reason = KVM_RISCV_VECTOR_OWNER_KERNEL_VECTOR;
+		break;
+	case RISCV_V_INVALIDATE_CPU_STATE:
+		trace_reason = KVM_RISCV_VECTOR_OWNER_CPU_STATE;
+		break;
+	default:
+		return;
+	}
+
+	preempt_disable();
+	flags = riscv_v_flags();
+	if (flags & RISCV_V_VCPU_CSR_RESTORE) {
+		vcpu = *this_cpu_ptr(kvm_get_running_vcpus());
+		if (!WARN_ON_ONCE(!vcpu)) {
+			flags &= ~RISCV_V_VCPU_CSR_RESTORE;
+			flags |= RISCV_V_VCPU_NEED_RESTORE;
+			riscv_v_flags_set(flags);
+			host_vs = task_pt_regs(current)->status & SR_VS;
+			trace_kvm_riscv_vector_owner(vcpu->vcpu_id,
+						     smp_processor_id(), 2, false,
+					     trace_reason, host_vs,
+					     vcpu->arch.guest_context.sstatus & SR_VS,
+					     vcpu->arch.vector_state_generation);
+		}
+	}
+
+	owner = this_cpu_ptr(&kvm_riscv_vector_owner);
+	if (!owner->identity)
+		goto out;
+
+	host_vs = task_pt_regs(current)->status & SR_VS;
+	trace_kvm_riscv_vector_owner(owner->vcpu_id, smp_processor_id(), 2,
+				     false, trace_reason, host_vs,
+				     owner->guest_vs, owner->generation);
+	owner->identity = 0;
+	owner->cookie = 0;
+	owner->generation = 0;
+	owner->vcpu_id = 0;
+	owner->guest_vs = 0;
+
+out:
+	preempt_enable();
 }
 
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
@@ -88,6 +308,10 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 	}
 
+	vcpu->arch.vector_owner_cookie =
+		atomic64_inc_return(&kvm_riscv_vector_owner_cookie);
+	vcpu->arch.vector_state_generation = 0;
+
 	return 0;
 }
 
@@ -110,8 +334,13 @@ void kvm_riscv_vcpu_flush_vector(void)
 
 	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context, vcpu->arch.isa);
 
-	if ((vcpu->arch.guest_context.sstatus & SR_VS) != SR_VS_OFF)
+	if ((vcpu->arch.guest_context.sstatus & SR_VS) != SR_VS_OFF) {
+		unsigned long host_vs = task_pt_regs(current)->status & SR_VS;
+
 		riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RESTORE);
+		trace_kvm_riscv_vector_restore_request(vcpu->vcpu_id,
+						       smp_processor_id(), 1, host_vs);
+	}
 }
 
 #endif
@@ -229,6 +458,13 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
 	if (rc)
 		return rc;
 
+	/*
+	 * copy_from_user() can modify a prefix of the destination before it
+	 * reports a fault.  Invalidate any cached hardware copy first so a
+	 * failed SET_ONE_REG cannot leave newer memory hidden behind a stale
+	 * per-hart owner.
+	 */
+	vcpu->arch.vector_state_generation++;
 	if (copy_from_user(reg_addr, uaddr, reg_size))
 		return -EFAULT;
 
-- 
2.43.0

