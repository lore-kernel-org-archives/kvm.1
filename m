Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FB3B6370;
	Sun, 20 Sep 2026 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871380; cv=fail; b=qQNJnNc6Qdp4MkXJ3hEHOKvKnX3OwB5yhzEf35LLNAG8fJawW33zBlwh7sG9KMHfW3Xyo8o2PhD8jzd3aLmLmZPoTr3rL841TWBw1L+SzLpRGpXBvl9GWTKTeJbfihkD2/rVZsRVfRp+Isu/aTmujs832ExFm9AfE0xwSooIJBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871380; c=relaxed/simple;
	bh=NUgtRqObZVBwp8SSl9xmXFkpWErsa+nyO/a/luKhbQg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qpsnIW8SZrrU3qdnFyP1UD2Ytq97daL1jvmGfdZC+mArAPkghj4oxMrHoQyMBFX8W9DjqeqSvR4/6wg7QW9URWrn8BXXneEvBFCsiQk4AdxYoFHM/Wn0ItN37UNgBf/6hZB6xXY/1em3ZCr+RlCNGpBu+c4zXpSfhpBQJ4dwt2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dzd5yapp; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dzd5yapp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCIFTdzBTD2IBvs5TLf3imSV3Vm4oWjC89VyVpbnByJrrJ1WB+mHu2sIdji6lU+rsA+EoHx6tjihYj2mWIFPEPP6p63ZqlZSHqnfZna0Lg4J8td0L5GVHUkC54LeNh3lR8xcvQmGzfqdbgzyC1NVgIwdDh2N00MewahF5wX2+LubWFhX8Mv5QbeHsEX/H/km5m/N3LDV6fQt6Jr3Ofe2mj1ChRuN2GsAJ2iNpZ7PhNtxF2xRRz754FL/ns/9GPqgc5UEf144Jo9QIGJOVHTW/ARMXHqn9P1N8L4aIcyvvQHVKbq2gMCGK0FCWyxXPA7nogImdxrNThA2icnFRPhTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVPC2DcGJnxaYUhzpH6Hr2KJDiqnTiEZrJ7sdd4evDU=;
 b=EbXcCfdVtKQZLlixbyzMetfYiEt0spYZGM53MXwp2vR27miz+GGJk8KiZM8lvFJllDTSaDDxJinxMBj9zGarSohgYZpJQq4yjVJK2zuwV4j+Mk0xmpKYDqkIZMu8it+TaWIbpRY8lGOxNWCKTPSNAp73LHEbAp+g7ljzAyI/xf+ekURY21B6qvXb7TxqhkPY+o4xyJpM7NVuG5svCKRf3wlGa34wcwDxHc6zjd2ACs6//xsXVE6HMcSgQB+7VBU405n4vaelvzNXgObPcbDh1KB3hgFoHf/andsB9dxwe9uTl0OFHT/PDhq50BOGd/EqcpctAGl5EaUUrnYOnuDuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVPC2DcGJnxaYUhzpH6Hr2KJDiqnTiEZrJ7sdd4evDU=;
 b=Dzd5yappdmdbBYRF1K0d9mXJNkoRvnDgiKIFOfDmq3qSNCAYjpkpPrlSqCwgz94zeppmnFgB+bnF6lY1aX9YZU+GyroYoZ6OBIs+zpeSbyYOdS3hO5NVizoUafH1Of9cFvN9jVUnmDMOq6kwpqDOzzr10B6XsE00qbbB8S9Km64OKR5wi/XKxEonnPJXM7O/LCwNtZ0ofEVMl0cmsjf6mmjPOUiwe/8OqFaGukiFrakFeapGB6diQAU1nfGN+a0/unrGkZZ0U5C1n10Ay0sQdwA34scHqsJHYRRRMAvvYJ1vsVr4zDKGDoFu44+YuS76M1ogAsTVcXDAnn6maQfcJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:29:19 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:29:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:26:48 +0800
Message-ID: <20260920022649.3145701-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: a166bc38-ae66-4276-d263-08df16bef916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	boBSQvWd7nSYBaoXuAL9WGIf0SirSQ+Sp6qrB5aZPESQ1/a+9FNyT4M2L8zVHOU6tFCRjVKCYe+TcQU4pYdJjoyR2wbxfoP089OnEiY6z42Tjnaoiha8mkhC9iNDFXUgUkhY0BdYMN5vohprPPoBABszhCoaEanbzYH0pNOX3/QUvW+j0rpR5UeBqxX6ZCqu7AsowVxZmX6NtWCEx+XW2PM1etLxGUORN8QWyh8ALBB5pta1JvdQSjChWfyw26jZB6w8oZuy+gPnucja+YEzwqgbuE8q7IhzQt5CYYCdpRBr2JK9Gpo8Af8oS0LdVhxZW28rhdsXMJqQK6QHC4YH9Dpp9CCKjG8A18XnFEQhVPrN/41y0L7HtsbpXhIMp8NnzusvKAhlXWuxPVkpmJbm3HnbkFlEkm0YSLeAW/D7xOxCSxTYpz1p8sm6RN3tG+b0qwR711Sy+RXtRmx4sAnYpNC4og7zLraQqXhSpAdAOid/Gn9UlA/pwI9qbh8xU5s/xBcPBMY7HvR9vBPWvlnepssY/OxfjxR/3vntQBRyars6D/3rTP3F45EDZuu31B2I1ZF6nCVIaoaD9mkYXOQYN9kt5BCH1NzUQTp2b2okGhfgkTszQDYXu68aZnj6FYa/djp7Cjkh9uOpzJwn/ZX7eHp8IW61T0xF3XJJSnV9BYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znwod24xkFi0gE3P+uDCmwVDbLefD2EFGPWoqJUoEJFbN3lNbYEzpZx3CwXL?=
 =?us-ascii?Q?k6VQGs4NLHP4evdD9H9PaSMtrd5DSY7jjG1dfC2N1Eu7ZVrrQfEQavVlsm1O?=
 =?us-ascii?Q?QDNp4IqwpA90USMM4LuvETrXsjIIOMC1JyYmGUJ4sZo/D2LeU6YMaB8oe1OT?=
 =?us-ascii?Q?00XQA5rGCr9SsyHyaVWHF2gBvY/bEXsj5+ARZrBFsttuNRtcgEIaNz13gwAm?=
 =?us-ascii?Q?l2d1+irgF19K5W3im2E8RJrLp6r6XP12Dy8/35oy9f/gtHL9PZ4/GVMBXaQB?=
 =?us-ascii?Q?aJFL+8YvgcFzOpCyDX7eG+YuZi6PUtWEyR7uXca3YJ4HeivrrGGDVs/ht6GJ?=
 =?us-ascii?Q?FZEJcOLTJzFDA71qCUpNyfucLoLf8qBaifIQwU9TLnu03ByRUUqSW8Q9amfJ?=
 =?us-ascii?Q?Mbbmiwi7uo6lNa+Qf5bKqhTfHvcjYqTlP1wjgpBAQmzFTbI3mG1NMMhCE0Cw?=
 =?us-ascii?Q?bl8pIrmPSmoWETalrckbLEdt4iuOuvJCY3OcpLJn4OZr2ulTJhbncDE/rNLr?=
 =?us-ascii?Q?BGAt1e8kbGgxdntvsjcb+kxbkZT46GO3X6nrPmMnpsOdTKDGiH7uaZFBUC6l?=
 =?us-ascii?Q?kPT0ufEJFcpEAb3J1ysgsx7C4oHn5saN+la+u4IPCXt2aAda4qUx/mnUsdaG?=
 =?us-ascii?Q?U24rKKJ5y091UV3dSgfadyIrBwydh5ESydXRK8+Ke1UKIyyMjo5jUfs/TYLq?=
 =?us-ascii?Q?pVinGFCK1T/IWTWq3T/5MQz4V1cD0OMNIH4XyaXuehO7h108+B17gb9YPvv7?=
 =?us-ascii?Q?SYMJedQoGX0DhRTgyH0f4nZ/ooRslfeIiZEFtDJIsh57XrAaBa0gnRW9dalA?=
 =?us-ascii?Q?p7C+YEvEcD2ZTGxV1WQFaHEzELCOWZ1Ww6xqpLHCc+nw2TOHsP18vvVb2BKm?=
 =?us-ascii?Q?4QedHm58JNjA1JR4oO5ea2XeqomkBcp3MazRtxh9JaD1B/SrzlmQzTy2lIhG?=
 =?us-ascii?Q?7OnrvI5Drs1DLRyLJOtEoF8q8q2b/WwbvGZsne0UM0w5Sy4vC7UPUzYXzelD?=
 =?us-ascii?Q?mGUuEw/dlYsDSPnbNW14DHX1eyXpfXCM5Wr9Tcl6KGHaap+i/YGHRqs2bTKU?=
 =?us-ascii?Q?c+y5cvUcMYNVOhCy27aWWnzYMWhjGfyN+xWLCRBNcwOvFey6Ta8Hv0UlBlKy?=
 =?us-ascii?Q?LdOw7yMSSSE8hcSNah7PZCMbcHrBFBRfi4GC+OlK5C1MLmn9VIRPmQn1P51w?=
 =?us-ascii?Q?88ZjfDk6lkpfbkTVkJ7xZcsbeE8szWTIjbr7fAKTlQP+Fb11qhNIUEuo5gnS?=
 =?us-ascii?Q?xWXhMerf7FefO/cn1PDzNVJvj7fFi+uADAy4w91EGdktScfVmNaP2sKMaEtk?=
 =?us-ascii?Q?/nwYEgb9CxRpOLvfLMkViCpN6Ry9+Exg8e6GFVUBFVSLRDJTlhZpajgRbwce?=
 =?us-ascii?Q?Wvxn1qUDNIak8/QSWXkvwE9e8pdQxSlvSSec2wZngLQavWAsEryOeQRrQrUD?=
 =?us-ascii?Q?T531YJdCFLRAFxw0mn+jrpVacBUermWaqPUMly5MXSz9Xylog9FWwFn6YIcs?=
 =?us-ascii?Q?zzUy+lkwMj4Gq0aj/qnwS1VPzswD3ocPEm5iuQe3DghJxF7O1cCQDm2+33OT?=
 =?us-ascii?Q?6XntDGOEBLwQjrMwHWigBOplrbbNXYaBBojZAUUNYiLFhdjemuGzzcdZL5bF?=
 =?us-ascii?Q?ol6vgSrTskZ+BPfhIwCIcfh63zf7Fwhi0WxW4g3gPLPktwKJfvJchYuqOt7s?=
 =?us-ascii?Q?/mtonj5ysTeoZSatT1yROV9Jn9+Ql2IunLqrFg5q1ny4JMsmZMlj3gccsbnA?=
 =?us-ascii?Q?eqvxpVUDQECdRCbx6n91AlKwU301QfMXDWH7DQ8j1BnW5pd0lj8Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a166bc38-ae66-4276-d263-08df16bef916
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:29:19.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfI73YfgmuLhGSHCocWIsympW/VOlQZUXK2xPpK5wr6qM4wwm+wUDTmBxY4AuvEUkPbEI0K8L+GMmESm+DeXsHW6ALzQ2DoSllXwpowM6zMeNNJz4xExpgYABDxaNEp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API.

Done with Coccinelle semantic patch:
    // set_bit -> clear_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        set_bit(bit, addr);
    -else
    -        clear_bit(bit, addr);
    +assign_bit(bit, addr, cond);

    // clear_bit -> set_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        clear_bit(bit, addr);
    -else
    -        set_bit(bit, addr);
    +assign_bit(bit, addr, !cond);

    // __set_bit -> __clear_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __set_bit(bit, addr);
    -else
    -        __clear_bit(bit, addr);
    +__assign_bit(bit, addr, cond);

    // __clear_bit -> __set_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __clear_bit(bit, addr);
    -else
    -        __set_bit(bit, addr);
    +__assign_bit(bit, addr, !cond);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/x86/kvm/hyperv.c  | 12 ++++--------
 arch/x86/kvm/svm/pmu.c |  6 ++----
 arch/x86/kvm/x86.c     | 11 +++--------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8d2669d8ef34..c131d9a3c550 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -114,17 +114,13 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
 	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
 		return;
 
-	if (synic_has_vector_connected(synic, vector))
-		__set_bit(vector, synic->vec_bitmap);
-	else
-		__clear_bit(vector, synic->vec_bitmap);
+	__assign_bit(vector, synic->vec_bitmap,
+		     synic_has_vector_connected(synic, vector));
 
 	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);
 
-	if (synic_has_vector_auto_eoi(synic, vector))
-		__set_bit(vector, synic->auto_eoi_bitmap);
-	else
-		__clear_bit(vector, synic->auto_eoi_bitmap);
+	__assign_bit(vector, synic->auto_eoi_bitmap,
+		     synic_has_vector_auto_eoi(synic, vector));
 
 	auto_eoi_new = !bitmap_empty(synic->auto_eoi_bitmap, 256);
 
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7a..4c13a6345277 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -169,10 +169,8 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
 					   AMD64_EVENTSEL_GUESTONLY;
 
-			if (data & AMD64_EVENTSEL_HOST_GUEST_MASK)
-				__set_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
-			else
-				__clear_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
+			__assign_bit(pmc->idx, pmu->pmc_has_mode_specific_enables,
+				     data & AMD64_EVENTSEL_HOST_GUEST_MASK);
 
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af3ceee714c9..a33ef4ab4e60 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3074,10 +3074,8 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 #endif
 
 		if (lapic_in_kernel(vcpu)) {
-			if (events->smi.latched_init)
-				set_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
-			else
-				clear_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
+			assign_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events,
+				   events->smi.latched_init);
 		}
 	}
 
@@ -7224,10 +7222,7 @@ static void set_or_clear_apicv_inhibit(unsigned long *inhibits,
 
 	BUILD_BUG_ON(ARRAY_SIZE(apicv_inhibits) != NR_APICV_INHIBIT_REASONS);
 
-	if (set)
-		__set_bit(reason, inhibits);
-	else
-		__clear_bit(reason, inhibits);
+	__assign_bit(reason, inhibits, set);
 
 	trace_kvm_apicv_inhibit_changed(reason, set, *inhibits);
 }
-- 
2.51.0

