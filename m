Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E5288AD;
	Fri, 24 Apr 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052642; cv=fail; b=iX0lpzEMUfiToa571aNM+30bJxv3X5bqKib0AgiiLkIDgl8RIMTWiHLJvRnrolT1bTfr6ViMqg7qfTmgzB4/Qxd53A/E4m5xL1KFbJtKV25NJ8YvqvWLvyaNbuHiaZSsUPd0jkOc1aHxk/gCY6yooK/VMDiD4FMiaNDeVYoC4lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052642; c=relaxed/simple;
	bh=6Mmur1PBLk3bGFEQuvv6cXbdHIVhKvcVm2YTIcPxU6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAOQ/gWh06cuJBdt7nXxX00ao5i70aX+kYX7tHZY784J3S5J0UdI3XJFF1i5tmJpu1PpK2/hj9hny2ZlMcEn5OFHlXF672bQrfHqbcFYCGVITxHsc1o8MA1UPvCaD/5xi61VgBd3NFrg0xVyANGRSGCWODEKFX85PFwDZ5szdM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tf+bQU+8; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tf+bQU+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdTULx2zFzts3mWeuq/m4oJ5UzdTwLYckrBmFc1RNrtMs3+lySxTgg1VyFV0f6r1M6ptC18lT3VR5t9AWfQsWDPMM482jRKZ7em210iQmqh+y3bW2HgMC5PTG32B2v5e2W2PPVqI/OMrq22pAa2Whj9WPwgHxdmSPcDRZblD2JnJqtOXXL8HidYt2VRjPd9IRCyfixoQMYNV2eHuY5szptQdZ4e+EY2+M6vGvZ4tP7JoZCamqBNvJaM5qjE4ZEFTI46f7fy4dV1zHRWvbSykTph/6wBxG+XH3OiNgzGbJGLg3CdekSxPRKmI3QLwfsevJzmjPz6cOfElrcqNCDefOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjiTZWvGMKEqrE8P24CMX3ZTnlS7VBQZLm6QA7bREGs=;
 b=hHP8eWbwFZkuGuSux+orcdqvryDcB2ep/WS8rlt4tOQjv5J54fbsE/Xb5C1vQhlvQlZVYNe+ZzJBWyrxpPW3BSf5RXHson+2FbcfXkietXLHpBKn35iCdYMUIDJ142jDmzg902E8fgtFHqAQSBAqpvNzixOr2Nzcp9oOAtAloFNxfYI7shIsRRveoy8ArqW1XB68BY2vbUO824HnBAw92ZKLjyOoQ7/T8tdPpqvAhGLNzRgvyGfN3jf0sARNBfA7Ha6Ksaj61D6hD8aE//lkpL0uAAgiTrhAXUgIUkgTJzHW1rric396Sjmw8NDjoJrg3r7M+vZ4P7uCn850oaSAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjiTZWvGMKEqrE8P24CMX3ZTnlS7VBQZLm6QA7bREGs=;
 b=tf+bQU+8IanfE7IaaIp/J+r5A1BmZb6XrSBc7F7brqwN7vTcDcuITnjwx01BbvRDUsaTSNrlztWeAiaZPcAESx68DX+DipcGJLt/YHTHK2lU7q+/X7cWEk3gNZ3Li6/bUUG55Kj4bjSqqwVdOJKvBV6PSwKowPoQpBnfkcVB/7w=
Received: from IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::15)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:43:52 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::43) by IA1P220CA0001.outlook.office365.com
 (2603:10b6:208:461::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:43:52 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:43:51 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 3/7] KVM: SVM: Inject #HV when Restricted Injection is active
Date: Fri, 24 Apr 2026 17:42:07 +0000
Message-ID: <954d023cc355d1ab867c7f983c8fa830b29ee659.1777048608.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777048608.git.huibo.wang@amd.com>
References: <cover.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6107ac-291e-4ae7-dbfd-08dea2290c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NbSq/JtIDVnUxzuLrnNGYGO6QdvcX+R+enxj862q3hdnQgUCVVc9Gtd6R7ZijX/pwJvgUHgqkSL8UjYZPiJ6GTOkknu2yGoLvgW3eyLh2uZSFFg+BttDKEG2RAGsxtXhUmK6/NsLCbeOVCRzb6Iil67HdiQWEMr5EuIHFW75jch6/hmg/7yREitgx/W+eXWYuTQE3XAPwx2x4ff1KwZBKl3vauGnlNTAJXJGsJAQR+QbYMFK/5YAJDC8UmJJdimI/FnveEkm2W1bwC8kDLSDz6aK00qGiC4VIx7IB39r2j39kFF4BbN0JU/RUfSCdWAbzmA+zN76XgU4ikkNJQxyb5tevtALu8jrzLCkoQ1SUlZShn2wD338cEYJOGTzNGGEZBeiEqrKK1wE4NVuH+JzizYpY0NknfLJQlTmglhjWiAjHExTh5bHR42qS2YMUuKunPOPpHGB6N7LKXHWr0827ssSw3ctvP6hx07ouxrUBBxULW7omnW4tndBPp4wyscXsH8/LnS/B4HNMWU0XbxPXWOJ7U0SNSCJj6mA6iiNT1e6UwYWA9MmwlPXyxBNq/Cq0pt3228ONtIPp+UJ+Lr5QYN53wg2R8UPbQnhRMwZsgnJRV8e755z+jEUwph4QiTdWTav/O1xCKW8um66lXgd8ue5KDE8FdXfH8Ru3oN2GoJhRISB07IRai6qI12mA5tPfC47/evRpHGphblJgZNdiazZKeLzWSNVyXWYMZZCwu7iBze1O5DYoPDYEjxj/Ju5vh/SSx/YcwBJrHLttmXm0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sqWIh54R9XijY5uL6ytxEEJb9+kXZQGm0SzjRlxW3kE1uV0qO9cL8Fcm+B3W5P7e7/90UnoC9cyE4+6rD5aNO2L354r3C4+U+WNVJ1CWqAplRAVDT33LcAINS2/XbeBMYhFd+haXqoC6YN7hDQOlzS/0FZ7O/581YUjo9Bu0bZaRo4SklfSl9czmHq15kP4FkoeI5Lqi9NcEWALc381uhRQbBe+ay17KZ/IssZJuIcGpuhaDljds0zfPlYv2jsaaAiYffKcoyheXrSHoAP1N44o/CC01EQmBmsIMkkoqNn9dCViyumAwl78TrkkviaDsMaazm9rf0Qf2BgzAaxWu50f3bo9aYvjGyaQjSMX/DcjK5uNM1iHPyXC9TaDne8jnuOcNTk+vq1FdpCPmhT0xHK4mOAqnjNLQ4mMmUyMe/GgaeL5ORUEP7PK5tH6InMQA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:43:52.0923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6107ac-291e-4ae7-dbfd-08dea2290c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

When Restricted Injection is active, only #HV exceptions can be injected into
the SEV-SNP guest. Detect that, and then follow the #HV doorbell communication
from the GHCB specification to inject the interrupt or exception.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/svm/sev.c | 164 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c |  14 +++-
 arch/x86/kvm/svm/svm.h |  21 ++++++
 3 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f09c4236fb5e..509a4f8b5073 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5321,3 +5321,167 @@ void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa)
 
 	free_page((unsigned long)vmsa);
 }
+
+static void prepare_hv_injection(struct vcpu_svm *svm, struct hvdb *hvdb)
+{
+	if (hvdb->events.no_further_signal)
+		return;
+
+	svm->vmcb->control.event_inj = HV_VECTOR |
+				       SVM_EVTINJ_TYPE_EXEPT |
+				       SVM_EVTINJ_VALID;
+	svm->vmcb->control.event_inj_err = 0;
+
+	hvdb->events.no_further_signal = 1;
+}
+
+static void unmap_hvdb(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
+{
+	kvm_vcpu_unmap(vcpu, map);
+}
+
+static struct hvdb *map_hvdb(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!VALID_PAGE(svm->sev_es.hvdb_gpa))
+		return NULL;
+
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->sev_es.hvdb_gpa), map)) {
+		vcpu_unimpl(vcpu, "snp: error mapping #HV doorbell page [%#llx] from guest\n",
+			    svm->sev_es.hvdb_gpa);
+
+		return NULL;
+	}
+
+	return map->hva;
+}
+
+static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb) {
+		WARN_ONCE(1, "Restricted Injection enabled, hvdb page mapping failed\n");
+		return;
+	}
+
+	hvdb->events.vector = vcpu->arch.interrupt.nr;
+
+	prepare_hv_injection(svm, hvdb);
+
+	unmap_hvdb(vcpu, &hvdb_map);
+}
+
+bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return false;
+
+	/*
+	 * Restricted Injection is enabled, only #HV is supported.
+	 * If the vector is not HV_VECTOR, do not inject the exception,
+	 * then return true to skip the original injection path.
+	 */
+	if (WARN_ONCE(vcpu->arch.exception.vector != HV_VECTOR,
+		      "Restricted Injection enabled, exception vector %u injection not supported\n",
+		      vcpu->arch.exception.vector))
+		return true;
+
+	/*
+	 * An intercept likely occurred during #HV delivery, so re-inject it
+	 * using the current HVDB pending event values.
+	 */
+	svm->vmcb->control.event_inj = HV_VECTOR |
+				       SVM_EVTINJ_TYPE_EXEPT |
+				       SVM_EVTINJ_VALID;
+	svm->vmcb->control.event_inj_err = 0;
+
+	return true;
+}
+
+bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	if (!sev_snp_is_rinj_active(vcpu))
+		return false;
+
+	__sev_snp_inject(type, vcpu);
+
+	return true;
+}
+
+void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return;
+
+	if (!svm->vmcb->control.event_inj)
+		return;
+
+	if (WARN_ONCE((svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK) != HV_VECTOR,
+			"Restricted Injection enabled,  %u vector not supported\n",
+			svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK))
+		return;
+
+	/*
+	 * Copy the information in the doorbell page into the event injection
+	 * fields to complete the cancellation flow.
+	 */
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb)
+		return;
+
+	if (!hvdb->events.pending_events) {
+		/* No pending events, then event_inj field should be 0 */
+		WARN_ON_ONCE(svm->vmcb->control.event_inj);
+		goto out;
+	}
+
+	/* Copy info back into event_inj field (replaces #HV) */
+	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID;
+
+	if (hvdb->events.vector)
+		svm->vmcb->control.event_inj |= hvdb->events.vector |
+						SVM_EVTINJ_TYPE_INTR;
+
+	hvdb->events.pending_events = 0;
+
+out:
+	unmap_hvdb(vcpu, &hvdb_map);
+}
+
+/*
+ * sev_snp_blocked() is for each vector - interrupt, NMI and MCE.  It is
+ * checking if there is an interrupt handled by the guest when
+ * another interrupt is pending. So hvdb->events.vector will be used for
+ * checking while no_further_signal is signaling to the guest that a #HV
+ * is presented by the hypervisor. So no_further_signal is checked when
+ * a #HV needs to be presented to the guest.
+ */
+bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	bool blocked;
+
+	/* Indicate interrupts are blocked if doorbell page can't be mapped */
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb)
+		return true;
+
+	/* Indicate interrupts blocked based on guest acknowledgment */
+	blocked = !!hvdb->events.vector;
+
+	unmap_hvdb(vcpu, &hvdb_map);
+
+	return blocked;
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 826d60527297..739cffe12cd1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -392,6 +392,9 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	    svm_update_soft_interrupt_rip(vcpu, ex->vector))
 		return;
 
+	if (sev_snp_queue_exception(vcpu))
+		return;
+
 	svm->vmcb->control.event_inj = ex->vector
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
@@ -3807,9 +3810,11 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	}
 
 	trace_kvm_inj_virq(intr->nr, intr->soft, reinjected);
-	++vcpu->stat.irq_injections;
 
-	svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
+	if (!sev_snp_inject(INJECT_IRQ, vcpu))
+		svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
+
+	++vcpu->stat.irq_injections;
 }
 
 static void svm_fixup_nested_rips(struct kvm_vcpu *vcpu)
@@ -3984,6 +3989,9 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (!gif_set(svm))
 		return true;
 
+	if (sev_snp_is_rinj_active(vcpu))
+		return sev_snp_blocked(INJECT_IRQ, vcpu);
+
 	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
 		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
@@ -4334,6 +4342,8 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_control_area *control = &svm->vmcb->control;
 
+	sev_snp_cancel_injection(vcpu);
+
 	control->exit_int_info = control->event_inj;
 	control->exit_int_info_err = control->event_inj_err;
 	control->event_inj = 0;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4ab58307bf75..b4627884c36f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -55,6 +55,10 @@ extern int tsc_aux_uret_slot __ro_after_init;
 
 extern struct kvm_x86_ops svm_x86_ops __initdata;
 
+enum inject_type {
+	INJECT_IRQ,
+};
+
 /*
  * Clean bits in VMCB.
  * VMCB_ALL_CLEAN_MASK might also need to
@@ -968,6 +972,17 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
+bool sev_snp_queue_exception(struct kvm_vcpu *vcpu);
+bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu);
+void sev_snp_cancel_injection(struct kvm_vcpu *vcpu);
+bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
+static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;
+
+	return is_sev_snp_guest(vcpu) &&
+		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
+};
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1005,6 +1020,12 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 	return NULL;
 }
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
+
+static inline bool sev_snp_queue_exception(struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
+static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
+static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
 #endif
 
 /* vmenter.S */
-- 
2.43.0

