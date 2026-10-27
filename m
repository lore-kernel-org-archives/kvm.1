Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793108532;
	b=bfZ/YydNWV8ewiPbom697LIo+pKgrFIP1sCWOa2fezToCYsSKtjfHXqdlEZICRE4z2py
	 LsSrAMOreToQo/UhnXbp8zA/J9nM0hduSdzTvW3fLXtq2E9gKTXBMM5GekvLdX2a7Y6W+
	 0p8cGLJhI1Or/p1lxfnESCByRV85a+g/7iu8cgA8FpJlMQ4mnqyO5Fc0u/Ks8Sa584ue3
	 UKwXqe2KvPEjzKrk3JmIW+Rm+QGF65ESVLmVU/zt1BxnVfv1Ce4kON2q+b+5gzKufQOe3
	 UtA7d/PM708Lf6MD2HMOGX2R0hNnTXk+iCCkZrppobfEFkbvR0eF6cBfWv/sRRUnzSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108532;
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
	bh=Dl6dJlVeKnNUVLg7goAZ1UOpW+vivMjC8tMR2KCSBOI=;
	b=c8sJz2SQhqkOqZxKco2nj/tulT1+8yR9jjGcIAQnsJIIsROKHV7w0zuuBmwZusuASqAI
	 +IwllRxJcKLr78gRcyfACHdOkJz9SuL/tj/y9xIlpnfySwJJAO7qUG8uBHm67w6KYP4un
	 R7cqzF1X8mjB0CGnU1DEyN04nJ1zppUz0dP0z1H9hlG8y14/QQs97mY4C3/3nCrhOJSEK
	 a9l5kZcYDCxSIYEvgwMT6qKy7VI+gl2AhqzmIl0WfV82PGdNgKgzFscJF/rNxM5hGrmVQ
	 EmebD5Okteafz7/4skfpybs2uq25m4bWLrLigM7zZOpWNhn1bYHo32kYVaxlwmolS6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tMngmM6j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.80
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013080.outbound.protection.outlook.com [52.103.43.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB1606A31D;
	Tue, 27 Oct 2026 13:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4DB1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tMngmM6j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMF0UF3LrKG3u5NQ6COZBsy5NeHH4Hs4MKXaPCmODXL9uvUBVoV88H4xFF78IOXIf8DGARNAXHeilfvb2Fx6EIfLfIDeXd0yKHHELr6ZG05hmM4zsyIySJWyn+ixluGV72zzcgIPUHdOkjcrak/7jKi6GrkiL81L6LsXMKdSyIDoalJObTzkswIIcxu1aw+w2pUrp8NX0EXtB64M2hoxzkCq6JvwhVXDGU2PSJXdk/fluAaFmtjQvAsFpLbu26K4eTfABFo1e4Bfdyl9YGvbCq4qy+O9fCXcJO3IKlKHP2wSAmotySkp9is1gKWTO30oSTAfivs7zBtHEsN1Rh6XXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl6dJlVeKnNUVLg7goAZ1UOpW+vivMjC8tMR2KCSBOI=;
 b=mKX/rZUJWJVHWjYi1snonXqo3NvvcHkT1M16xffpVw9BtL/Bi56TRDS02UtbMY2dRZAHCw1WoXYx1MljfFgLsoaVSEOx6IF1/ldwnqK/EON1g4rmQmaHzyjV+WaD6L673LH+5pe5cgemMVJsBRfXmR0gtN5ybt+J4HvuBpwqoAXQh0ETxUVEec3cM6yJ/FuW6bbIk9b6j9l3B3a5k+Cnw9VmN7BwQr2uEDj085E0EVejySWeJKsdtXZ/Zb8KrpLH8std0niIC8uewKJV9l8IiRzQTG9cj36F6lUoR6a5NL1gsHXicNoYPGBdGwq6qsxDQ9f2Ps7zBR6G3IbtCWBoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl6dJlVeKnNUVLg7goAZ1UOpW+vivMjC8tMR2KCSBOI=;
 b=tMngmM6jSYumkG0UOsHTlZTdAerzmLO1BrhtDZKpd9JRIZMOsiHU7rUGtxIeGvwK2rn/s4lOPDxNUpnOsLtzw17R/TlUFGkiTF8NkRSay/yomQKiWzC4XVX/nvsR1/JOUx9cpkMjbMQqBLrLV8tUkO4HwQbRKm5v4LcXHkKBi4DNTn4Tx6q4GRDHl5okP8/8cyCokFcv07+4W5NmvLoc+kKhAVT2LqTIqNgG+PscdcEMGjTC4gVdQmjR3Kih9cVLKp//gsi+IH7zle1HXciGi1TXEq78GPLKMae1v+q/I5ecjpTjWpzo9p3+1kBWbsUiwFU1kaIAEupYujk4nCyASA==
Received: from OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 (2603:1096:604:290::7) by SEZPR01MB4600.apcprd01.prod.exchangelabs.com
 (2603:1096:101:93::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:42:05 +0000
Received: from OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 ([fe80::708b:59ed:4ad6:b84c]) by OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 ([fe80::708b:59ed:4ad6:b84c%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:42:05 +0000
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
Subject: [RFC PATCH 3/3] KVM: riscv: selftests: Add Vector owner regression tests
Date: Tue, 27 Oct 2026 13:13:09 +0000
X-Mailer: git-send-email 2.43.0
In-Reply-To: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
References: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0011.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::8) To OSQPR01MB6326.apcprd01.prod.exchangelabs.com
 (2603:1096:604:290::7)
Message-ID:
 <OSQPR01MB6326D30F15C187093E41762AC2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11847c14-600c-41da-ca83-08df343016e9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|12121999013|8060799015|19110799012|23021999003|24021099003|51005399006|41001999006|25010399006|260925184616899003|440099028|3412199025|12091999003|40105399003|30101999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7Eh2W5kmOHPb6jWwpxjIMlQ/MgpaWyYfVXApDki4EUa9eECU4baqCB9jW4A?=
 =?us-ascii?Q?ZoWppYFcd+6FxZfCD2TuyBViv6lb5JY/3Sj1ZtHCzucto2GGFD0zd0TPl32q?=
 =?us-ascii?Q?YNM0ZnoVemBcUJkH8yl6e2z1cJUTPlqL169ejWLp1MeaW1UBZssIr3gctYN0?=
 =?us-ascii?Q?2weqHMXyJ6qiBGDCdzLcNboLFNukPR1nNLvjyEbp0SS26fplO39ysD6WRI3t?=
 =?us-ascii?Q?j6PUtQ9DHkvUm/waMmDQPK7KJHTS09MUS1bPJTig9PXZAWVjy83RtgsNUeAt?=
 =?us-ascii?Q?fBpHYu7gx9NgkFq2W3RhNmkmZnuofmuF7oVPblmB/I3GyY65xTgpa72WNB+X?=
 =?us-ascii?Q?+1J+eJ8Hh2sk5w2nezLSS2G0Hh2ADhsvqtpAV1gROSDorDDSleDV7BZgg6nu?=
 =?us-ascii?Q?p/w3NentohjmZYhas62BTp7azBVOuqLmsrcZ0t8QVEx/nI9LXw/t1ie/liPH?=
 =?us-ascii?Q?Zl4UcUXahZ48OLu5/Kcn6xyNNcd0OQtafXGdKWiZr6ZdpXf3YR6Hkiju+Uuj?=
 =?us-ascii?Q?eSbmftaf5x7Ad+fqRpJAjj1bpuFTUlI4NNAlOyriZnzXrwnBKuzgyd+35i5v?=
 =?us-ascii?Q?0Mw0EgJueqaE7BDV9WMd2CdNvqbMm5uyhR3s57q5v0YCtHl5vtaIVgrWced+?=
 =?us-ascii?Q?dtDGBXgEAavDUBnnHyxE9Phv8+zYS9TCtL3kswN+bUu6NNkBKuHAYgJGYnXP?=
 =?us-ascii?Q?vhh+karyVhIaEE6Lk9zyuQf/dOrD7VQ3cSpX0k5cvRFsKN+42Qw9SZauUxE5?=
 =?us-ascii?Q?aMGMU6DMyFWU+ulk+MHgADGTP9Nj+urjEoR+IKHEoXVD6svuwrpWs51TKh2O?=
 =?us-ascii?Q?fQLPjRf0VYorPtZkre2tdMv7ctiBNLXV+1avrTv5dGfThWveQUfnP+ZahHtE?=
 =?us-ascii?Q?LO+F6j6WR9Anz2OzZEUpgTWr5mLeE3emz77DFGQqYkl4KZm5rssTNBcJR41l?=
 =?us-ascii?Q?34/ntzl8YuINomYMrxuT+IrJrcUxM2QUHfBTmukq53OA6ZJaWkOgosP/KtY6?=
 =?us-ascii?Q?Z6M+SyE9Qw7GmybiTjx7klNnPAkkiQa6w4dWFUc5piVVnaRxjjtKa/tkeuJ4?=
 =?us-ascii?Q?GTBjLUU22AuUmgKuuzJztN6iRhINiQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3DCp3GkxkKdJxH3CxcKHXawCv6/uLLGglSGIXycjmUjQAinGttqYKHqVXTJ?=
 =?us-ascii?Q?OaMrXokGHZZ31rQxRf1idAF+EmLLPLFW9iPk8Fq4CDklsDPp2hajKnAIWFYa?=
 =?us-ascii?Q?RtPJI65BMelAWMAh3UuFVtz1QkIp3Nz4Bv7A9GonNKG07tL5Jcq1WUJ2ffHM?=
 =?us-ascii?Q?FXJWEFoawv2EfsjXxA5n5WH+5DRUvfKA1bVgGakC0RDooQjS216DPruYzSfM?=
 =?us-ascii?Q?zEZY1hpp7GXq9nLnSnEdU0Ozjv+8P5DyhQtyEiHdO6Jgo+076g0CBebRkJ9S?=
 =?us-ascii?Q?VmaEmHg3CHYuX1Tm7AXKsLd2NSeUVl9xRRAvr9lJDVR2PCM/lLnjBASz3r2p?=
 =?us-ascii?Q?qMG+EECMKDe30bZFgvyjBNfIcJCE+aZ6jTgC7QYp0/+gsAXrrQ6EPPWTqWdT?=
 =?us-ascii?Q?t1NyK11uRE3H54vSLaAngiY5nBps9n0WF3cJtIC6xvTqfRKwM8zUMl/TDcAR?=
 =?us-ascii?Q?OIKRMtQrJSRgcmukyzK/eW2rbexrqZSye2oOEecD+ExK+bGazZmcUSpHJlCc?=
 =?us-ascii?Q?u8xk09RBzQJxHsXQb8Os+D2tiM7Xj/+++HfOIZYONAp+86oPXP+l/LXcLbtU?=
 =?us-ascii?Q?Ic4/Mo5rZghFLP6gfmsl6Ur1BfrDtN6Y5FKXtqW0VGAkXLo+pL4pfBE2A0E5?=
 =?us-ascii?Q?N3DBDmk6MYRSfvl2T5P2Wd/zZt5UZkYk2X1njAQIDqbZyVpcG8b12VDzVASv?=
 =?us-ascii?Q?++mosqtuH0OtFq4Y8YV1Ek6U29fdxQ5GlLls9Vfo4qVpIclOZcCQtBjsx10O?=
 =?us-ascii?Q?dF46vNWG2PVg7AYjgACEIGlYS2C2N0DTJqOpnadyUHtjcJMm+rYWrplt/XQ7?=
 =?us-ascii?Q?o0QbMjq7IBVDeSayTolmycoBJnE8NKXzmH70rWV9ecKFhuN6fxZoTq4fnc4r?=
 =?us-ascii?Q?KyMaPZZvwP2knd0h+21TBhbJ3JNI47nv9mCG6Nri/vbwZQWr4o4Mhp49hrad?=
 =?us-ascii?Q?lZYqNJmQk7Ma0k5y9sLDgHciaISkoK5XSE/CvdzboeasVvhiZgn6znKBmrXV?=
 =?us-ascii?Q?SYxqd83LO15XqrhkkqifXIndxsuoihhKp2JeV8g7tP6sGLcb/RKo7mfObcYW?=
 =?us-ascii?Q?Q8PdHsjzhIKeIbrLzIc4qGjr5ZhY6xbPJOYMf93OT15DQjxnyWvdUdHS3cre?=
 =?us-ascii?Q?/b3SO31yw6IMr2u6+TfgWNQOfIjITB4G8W2JwjJ2PycRm2pgh3/j4j4wUh0E?=
 =?us-ascii?Q?lrVYTNeXYi0vQXBlxY004CyvL6ceTdZgfwDjOkQ7kkhET1j9pZHZk+7/AbOM?=
 =?us-ascii?Q?yabBVbPO1kerGbHCApybj/4ZO+86xEkKRvcuFlSo9SgcAtij8EFQVMJCPLTu?=
 =?us-ascii?Q?GfzqxqNaOugloBQ93CRcaoWQQSUxbw3wVv5lIheo24di6gFTW9P/osHZyrGt?=
 =?us-ascii?Q?HN/PPn1lpziy8PALBBPGRxOoxGmV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11847c14-600c-41da-ca83-08df343016e9
X-MS-Exchange-CrossTenant-AuthSource: OSQPR01MB6326.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:42:05.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4600

From: Xiaochun Yu <yxcnew@outlook.com>

Add focused tests for the correctness boundaries of a resident guest
Vector owner.

The lifetime test destroys a vCPU with resident Vector data before
creating a new vCPU and verifies that the new vCPU cannot inherit it. The
ONE_REG test checks that GET preserves guest data and SET becomes visible
on the next entry. The fault test crosses into a protected page to verify
that a partially completed SET_ONE_REG copy cannot leave stale hardware
state visible to the guest.

Pin each test to one host CPU so the same-hart owner path is deterministic
when the optional optimization is enabled. Size the Vector buffers for
the architectural maximum VLEN so the tests are not limited to the VLEN
implemented by the development platform.

Development note: OpenAI Codex assisted with source analysis, selftest
drafting, test orchestration and changelog preparation.

Signed-off-by: Xiaochun Yu <yxcnew@outlook.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   3 +
 .../kvm/riscv/vector_owner_fault_test.c       | 147 ++++++++++++++
 .../kvm/riscv/vector_owner_lifetime_test.c    | 127 ++++++++++++
 .../kvm/riscv/vector_owner_onereg_test.c      | 191 ++++++++++++++++++
 4 files changed, 468 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c
 create mode 100644 tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c
 create mode 100644 tools/testing/selftests/kvm/riscv/vector_owner_onereg_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 3cb35a6963d5..50a1f247ebc3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -236,6 +236,9 @@ TEST_GEN_PROGS_s390 += s390/irq_injection
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
 TEST_GEN_PROGS_riscv += riscv/ebreak_test
+TEST_GEN_PROGS_riscv += riscv/vector_owner_lifetime_test
+TEST_GEN_PROGS_riscv += riscv/vector_owner_onereg_test
+TEST_GEN_PROGS_riscv += riscv/vector_owner_fault_test
 TEST_GEN_PROGS_riscv += access_tracking_perf_test
 TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += coalesced_io_test
diff --git a/tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c b/tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c
new file mode 100644
index 000000000000..a25dd21db77f
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Check that failed Vector SET_ONE_REG copies cannot leave a stale owner. */
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <asm/ptrace.h>
+
+#include "kvm_syscalls.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "ucall_common.h"
+
+#define OLD_PATTERN 0x31
+#define NEW_PATTERN 0xa7
+
+static unsigned char source[RISCV_MAX_VLENB] __aligned(64);
+static unsigned char observed[RISCV_MAX_VLENB] __aligned(64);
+
+static void guest_code(void)
+{
+	unsigned long i, vlenb;
+
+	csr_set(CSR_SSTATUS, SR_VS_INITIAL);
+	vlenb = csr_read(CSR_VLENB);
+	GUEST_ASSERT(vlenb && vlenb <= RISCV_MAX_VLENB);
+	for (i = 0; i < vlenb; i++)
+		source[i] = OLD_PATTERN;
+
+	asm volatile(".option push\n"
+		".option arch, +v\n"
+		"vsetvli zero, %1, e8, m1, ta, ma\n"
+		"vle8.v v0, (%0)\n"
+		".option pop\n"
+		:
+		: "r"(source), "r"(vlenb)
+		: "memory");
+	GUEST_SYNC(1);
+
+	asm volatile(".option push\n"
+		".option arch, +v\n"
+		"vsetvli zero, %1, e8, m1, ta, ma\n"
+		"vse8.v v0, (%0)\n"
+		".option pop\n"
+		:
+		: "r"(observed), "r"(vlenb)
+		: "memory");
+	GUEST_DONE();
+}
+
+static void pin_to_one_cpu(void)
+{
+	cpu_set_t allowed, pinned;
+	int cpu;
+
+	kvm_sched_getaffinity(0, sizeof(allowed), &allowed);
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &allowed))
+			break;
+	}
+	TEST_ASSERT(cpu < CPU_SETSIZE, "no CPU available");
+	CPU_ZERO(&pinned);
+	CPU_SET(cpu, &pinned);
+	kvm_sched_setaffinity(0, sizeof(pinned), &pinned);
+}
+
+static void run_to(struct kvm_vcpu *vcpu, u64 expected)
+{
+	struct ucall uc;
+	u64 cmd;
+
+	vcpu_run(vcpu);
+	cmd = get_ucall(vcpu, &uc);
+	if (cmd == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(cmd, expected);
+	if (expected == UCALL_SYNC)
+		TEST_ASSERT_EQ(uc.args[1], 1);
+}
+
+int main(void)
+{
+	unsigned char expected[RISCV_MAX_VLENB] __aligned(64) = {};
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_one_reg reg;
+	unsigned char *mapping;
+	unsigned long i, vlenb;
+	u64 vlenb_id, v0_id, size;
+	long page_size;
+	bool changed = false;
+	int ret, saved_errno;
+
+	pin_to_one_cpu();
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	TEST_REQUIRE(__vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V));
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
+	vlenb_id = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR |
+		KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR_CSR_REG(vlenb);
+	ret = __vcpu_get_reg(vcpu, vlenb_id, &vlenb);
+	TEST_ASSERT(!ret, "GET vlenb failed: %d", ret);
+	TEST_ASSERT(vlenb && vlenb <= RISCV_MAX_VLENB &&
+		    !(vlenb & (vlenb - 1)), "bad vlenb: %lu", vlenb);
+	size = (u64)__builtin_ctzl(vlenb) << KVM_REG_SIZE_SHIFT;
+	v0_id = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | size |
+		KVM_REG_RISCV_VECTOR_REG(0);
+
+	page_size = sysconf(_SC_PAGESIZE);
+	TEST_ASSERT(page_size > 0 && vlenb <= 2 * page_size, "bad page size");
+	mapping = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(mapping != MAP_FAILED, "mmap failed: %d", errno);
+	memset(mapping, NEW_PATTERN, page_size);
+	ret = mprotect(mapping + page_size, page_size, PROT_NONE);
+	TEST_ASSERT(!ret, "mprotect failed: %d", errno);
+	reg.id = v0_id;
+	reg.addr = (u64)(mapping + page_size - vlenb / 2);
+
+	run_to(vcpu, UCALL_SYNC);
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	saved_errno = errno;
+	TEST_ASSERT(ret == -1 && saved_errno == EFAULT,
+		    "SET should fault: ret=%d errno=%d", ret, saved_errno);
+	ret = __vcpu_get_reg(vcpu, v0_id, expected);
+	TEST_ASSERT(!ret, "GET v0 after failed SET: %d", ret);
+
+	/* Compare with memory, without assuming an exact partial-copy length. */
+	run_to(vcpu, UCALL_DONE);
+	sync_global_from_guest(vm, observed);
+	for (i = 0; i < vlenb; i++)
+		changed |= expected[i] != OLD_PATTERN;
+	TEST_ASSERT(changed, "failed copy did not exercise a memory update");
+	for (i = 0; i < vlenb; i++)
+		TEST_ASSERT(observed[i] == expected[i],
+			    "partial fault byte %lu: guest=%#x memory=%#x",
+			    i, observed[i], expected[i]);
+
+	pr_info("Vector SET_ONE_REG partial fault test passed (vlenb=%lu)\n",
+		vlenb);
+	kvm_vm_free(vm);
+	ret = munmap(mapping, 2 * page_size);
+	TEST_ASSERT(!ret, "munmap failed: %d", errno);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c b/tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c
new file mode 100644
index 000000000000..c7b057b27cd0
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Validate that a stale per-hart Vector owner from a destroyed vCPU cannot
+ * be treated as the owner of a different vCPU.
+ */
+#include <stdio.h>
+
+#include <asm/ptrace.h>
+
+#include "kvm_syscalls.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "ucall_common.h"
+
+#define OLD_PATTERN 0x5d
+
+static unsigned char old_source[RISCV_MAX_VLENB] __aligned(64);
+static unsigned char new_observed[RISCV_MAX_VLENB] __aligned(64);
+
+static void vector_load(const void *source, unsigned long vlenb)
+{
+	asm volatile(".option push\n"
+		".option arch, +v\n"
+		"vsetvli zero, %1, e8, m1, ta, ma\n"
+		"vle8.v v0, (%0)\n"
+		".option pop\n"
+		:
+		: "r"(source), "r"(vlenb)
+		: "memory");
+}
+
+static void vector_store(void *destination, unsigned long vlenb)
+{
+	asm volatile(".option push\n"
+		".option arch, +v\n"
+		"vsetvli zero, %1, e8, m1, ta, ma\n"
+		"vse8.v v0, (%0)\n"
+		".option pop\n"
+		:
+		: "r"(destination), "r"(vlenb)
+		: "memory");
+}
+
+static void old_guest(void)
+{
+	unsigned long i, vlenb;
+
+	csr_set(CSR_SSTATUS, SR_VS_INITIAL);
+	vlenb = csr_read(CSR_VLENB);
+	GUEST_ASSERT(vlenb && vlenb <= RISCV_MAX_VLENB);
+	for (i = 0; i < vlenb; i++)
+		old_source[i] = OLD_PATTERN;
+	vector_load(old_source, vlenb);
+	GUEST_DONE();
+}
+
+static void new_guest(void)
+{
+	unsigned long i, vlenb;
+
+	csr_set(CSR_SSTATUS, SR_VS_INITIAL);
+	vlenb = csr_read(CSR_VLENB);
+	GUEST_ASSERT(vlenb && vlenb <= RISCV_MAX_VLENB);
+	vector_store(new_observed, vlenb);
+	for (i = 0; i < vlenb; i++)
+		GUEST_ASSERT_EQ(new_observed[i], 0);
+	GUEST_DONE();
+}
+
+static void pin_to_one_cpu(void)
+{
+	cpu_set_t allowed, pinned;
+	int cpu;
+
+	kvm_sched_getaffinity(0, sizeof(allowed), &allowed);
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &allowed))
+			break;
+	}
+	TEST_ASSERT(cpu < CPU_SETSIZE, "no CPU available");
+
+	CPU_ZERO(&pinned);
+	CPU_SET(cpu, &pinned);
+	kvm_sched_setaffinity(0, sizeof(pinned), &pinned);
+}
+
+static void run_to_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	u64 cmd;
+
+	vcpu_run(vcpu);
+	cmd = get_ucall(vcpu, &uc);
+	if (cmd == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(cmd, UCALL_DONE);
+}
+
+static struct kvm_vm *create_vector_vm(struct kvm_vcpu **vcpu,
+				       void (*guest_code)(void))
+{
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(vcpu, guest_code);
+	TEST_REQUIRE(__vcpu_has_isa_ext(*vcpu, KVM_RISCV_ISA_EXT_V));
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(*vcpu);
+	return vm;
+}
+
+int main(void)
+{
+	struct kvm_vm *old_vm, *new_vm;
+	struct kvm_vcpu *old_vcpu, *new_vcpu;
+
+	pin_to_one_cpu();
+	old_vm = create_vector_vm(&old_vcpu, old_guest);
+	run_to_done(old_vcpu);
+	kvm_vm_free(old_vm);
+
+	new_vm = create_vector_vm(&new_vcpu, new_guest);
+	run_to_done(new_vcpu);
+	kvm_vm_free(new_vm);
+
+	pr_info("Vector owner lifetime test passed\n");
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/riscv/vector_owner_onereg_test.c b/tools/testing/selftests/kvm/riscv/vector_owner_onereg_test.c
new file mode 100644
index 000000000000..a1bd83e4808b
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/vector_owner_onereg_test.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Validate RISC-V KVM Vector KVM_GET/SET_ONE_REG interactions while the
+ * vCPU repeatedly runs on one physical CPU.
+ */
+#include <stdio.h>
+#include <string.h>
+
+#include <asm/ptrace.h>
+
+#include "kvm_syscalls.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "ucall_common.h"
+
+#define GUEST_PATTERN 0x31
+#define SET_PATTERN 0xa7
+
+static unsigned char guest_source[RISCV_MAX_VLENB] __aligned(64);
+static unsigned char guest_after_get[RISCV_MAX_VLENB] __aligned(64);
+static unsigned char guest_after_set[RISCV_MAX_VLENB] __aligned(64);
+
+static void guest_vector_load(const void *source, unsigned long vlenb)
+{
+	asm volatile(".option push\n"
+		".option arch, +v\n"
+		"vsetvli zero, %1, e8, m1, ta, ma\n"
+		"vle8.v v0, (%0)\n"
+		".option pop\n"
+		:
+		: "r"(source), "r"(vlenb)
+		: "memory");
+}
+
+static void guest_vector_store(void *destination, unsigned long vlenb)
+{
+	asm volatile(".option push\n"
+		".option arch, +v\n"
+		"vsetvli zero, %1, e8, m1, ta, ma\n"
+		"vse8.v v0, (%0)\n"
+		".option pop\n"
+		:
+		: "r"(destination), "r"(vlenb)
+		: "memory");
+}
+
+static void guest_expect_pattern(const unsigned char *data,
+				 unsigned long vlenb, unsigned char pattern)
+{
+	unsigned long i;
+
+	for (i = 0; i < vlenb; i++)
+		GUEST_ASSERT_EQ(data[i], pattern);
+}
+
+static void guest_code(void)
+{
+	unsigned long i, vlenb;
+
+	csr_set(CSR_SSTATUS, SR_VS_INITIAL);
+	vlenb = csr_read(CSR_VLENB);
+	GUEST_ASSERT(vlenb && vlenb <= RISCV_MAX_VLENB);
+
+	for (i = 0; i < vlenb; i++)
+		guest_source[i] = GUEST_PATTERN;
+
+	guest_vector_load(guest_source, vlenb);
+	GUEST_SYNC(1);
+
+	guest_vector_store(guest_after_get, vlenb);
+	guest_expect_pattern(guest_after_get, vlenb, GUEST_PATTERN);
+	GUEST_SYNC(2);
+
+	guest_vector_store(guest_after_set, vlenb);
+	guest_expect_pattern(guest_after_set, vlenb, SET_PATTERN);
+	GUEST_DONE();
+}
+
+static void pin_to_one_cpu(void)
+{
+	cpu_set_t allowed, pinned;
+	int cpu;
+
+	kvm_sched_getaffinity(0, sizeof(allowed), &allowed);
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &allowed))
+			break;
+	}
+	TEST_ASSERT(cpu < CPU_SETSIZE, "no CPU available");
+
+	CPU_ZERO(&pinned);
+	CPU_SET(cpu, &pinned);
+	kvm_sched_setaffinity(0, sizeof(pinned), &pinned);
+}
+
+static void run_to_sync(struct kvm_vcpu *vcpu, unsigned long stage)
+{
+	struct ucall uc;
+	u64 cmd;
+
+	vcpu_run(vcpu);
+	cmd = get_ucall(vcpu, &uc);
+	if (cmd == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(cmd, UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], stage);
+}
+
+static void run_to_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	u64 cmd;
+
+	vcpu_run(vcpu);
+	cmd = get_ucall(vcpu, &uc);
+	if (cmd == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(cmd, UCALL_DONE);
+}
+
+static int set_one_reg_buffer(struct kvm_vcpu *vcpu, u64 id, void *buffer)
+{
+	struct kvm_one_reg reg = {
+		.id = id,
+		.addr = (u64)buffer,
+	};
+
+	return __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+}
+
+static void expect_pattern(const unsigned char *data, unsigned long length,
+			   unsigned char pattern, const char *where)
+{
+	unsigned long i;
+
+	for (i = 0; i < length; i++)
+		TEST_ASSERT(data[i] == pattern,
+			    "%s byte %lu: got %#x, expected %#x",
+			    where, i, data[i], pattern);
+}
+
+int main(void)
+{
+	unsigned char get_buffer[RISCV_MAX_VLENB] __aligned(64) = {};
+	unsigned char set_buffer[RISCV_MAX_VLENB] __aligned(64);
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	unsigned long vlenb;
+	u64 vlenb_id, v0_id, size;
+	int ret;
+
+	pin_to_one_cpu();
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	TEST_REQUIRE(__vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V));
+
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
+
+	vlenb_id = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR |
+		KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR_CSR_REG(vlenb);
+	ret = __vcpu_get_reg(vcpu, vlenb_id, &vlenb);
+	TEST_ASSERT(!ret, "KVM_GET_ONE_REG(vlenb) failed: %d", ret);
+	TEST_ASSERT(vlenb && vlenb <= RISCV_MAX_VLENB &&
+		    !(vlenb & (vlenb - 1)), "unsupported vlenb: %lu", vlenb);
+
+	size = (u64)__builtin_ctzl(vlenb) << KVM_REG_SIZE_SHIFT;
+	v0_id = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | size |
+		KVM_REG_RISCV_VECTOR_REG(0);
+
+	run_to_sync(vcpu, 1);
+	ret = __vcpu_get_reg(vcpu, v0_id, get_buffer);
+	TEST_ASSERT(!ret, "KVM_GET_ONE_REG(v0) failed: %d", ret);
+	expect_pattern(get_buffer, vlenb, GUEST_PATTERN, "GET v0");
+
+	run_to_sync(vcpu, 2);
+	memset(set_buffer, SET_PATTERN, vlenb);
+	ret = set_one_reg_buffer(vcpu, v0_id, set_buffer);
+	TEST_ASSERT(!ret, "KVM_SET_ONE_REG(v0) failed: %d", ret);
+
+	run_to_done(vcpu);
+	sync_global_from_guest(vm, guest_after_get);
+	sync_global_from_guest(vm, guest_after_set);
+	expect_pattern(guest_after_get, vlenb, GUEST_PATTERN,
+		       "guest after GET");
+	expect_pattern(guest_after_set, vlenb, SET_PATTERN,
+		       "guest after SET");
+
+	pr_info("Vector ONE_REG owner test passed (vlenb=%lu)\n", vlenb);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0

