Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E133AFB13
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317694; cv=none; b=T1F9wOT/E9KXR5EWyv/hTSIpQvsGgHgUQqu1dbGEwc6xKsa0jHEwYAamWjezC+OTre09D20XU56OeLinrkuN+JVm88CKCgn/fQp8LrDuYBhOiLAarVp2vVTOGtt2h3r7IQ/OaxE/XC2KFXKKCcrtVgtGWjVQB/7yjj11cWON+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317694; c=relaxed/simple;
	bh=U7k0dEsnEbDnBsgHMJeDCeIbDA+x8Synf2B4dHiI2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r13BeCdjP5UmlqjRqvzMPZZZzscqkl4Cvn+lK3DxtgBnTywEYSJy0w/x1z0y4VJv3PQdcKApZlc6RVKuovyQnfpRvFPFJyxmJbAzaXxNe0unid/CHK3NkRwKYxqfT+lEXyILumoStGnOGnTTTGq4L21wXyOQCVI9tORYzMF8aPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07472231|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00900542-0.00101272-0.989982;FP=2852828158138205695|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStqt_1783317365;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStqt_1783317365 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:05 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 4/9] target/i386/kvm: Use AMD MCE status encoding for Hygon
Date: Mon,  6 Jul 2026 13:55:25 +0800
Message-ID: <20260706055530.1752094-5-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <zhang_wei@open-hieco.net>

QEMU's KVM memory-failure injection path builds synthetic MCI_STATUS
records for the guest CPU.  The status encoding is vendor-specific:
Intel-style records use bits such as MCI_STATUS_S and MCI_STATUS_AR for
action-required events, while the AMD path uses the AMD memory-failure
encoding.

Today QEMU selects the AMD status encoding only for AuthenticAMD guests.
Hygon guests therefore get Intel-style injected status bits, including
MCI_STATUS_S and MCI_STATUS_AR for action-required events, and a
non-deferred action-optional record.

Use the AMD injected-memory-failure MCE status encoding for Hygon guests
as well.  This does not depend on Hygon exposing CPUID 0x80000007.EBX
recovery features such as SUCCOR, and it does not advertise any new
recovery capability.  The change is limited to QEMU's synthetic KVM
memory-failure MCE status; it does not change CPUID, MCE bank state, or
migrated CPU state.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64cc421abe..8e2bfbbe1d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -698,6 +698,15 @@ static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
     return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
 }
 
+/*
+ * Use AMD-style MCE status records for QEMU-injected memory failures on
+ * AMD and Hygon CPUs.
+ */
+static bool kvm_mce_inject_uses_amd_status(const CPUX86State *env)
+{
+    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
+}
+
 static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 {
     CPUState *cs = CPU(cpu);
@@ -707,7 +716,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
     uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
     int flags = 0;
 
-    if (!IS_AMD_CPU(env)) {
+    if (!kvm_mce_inject_uses_amd_status(env)) {
         status |= MCI_STATUS_S | MCI_STATUS_UC;
         if (code == BUS_MCEERR_AR) {
             status |= MCI_STATUS_AR | 0x134;
-- 
2.43.7

