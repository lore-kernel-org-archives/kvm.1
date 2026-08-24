Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F13161A2
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547232; cv=none; b=nFbGeIHfgaf2yK7x0w1eB0v5BikCiqU65JNoFq6kaMBrO4qBIRAeG9rj6eNOAFlyd5gD5+lqUtJQPUdb18vvRB7t2gBGgCV7xLxIcc/ISqJR9wIFApNliT/rIJLc6n/5D07Qd9YKk7GjlhjhzyOextSuGFecSILGUUP3Ac8PhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547232; c=relaxed/simple;
	bh=YDyMraD26cg4ZYD7uoSD3yT6aba3S/PrXuuenjWlqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jx9iLFtctX4qdf8pEPOTbvtEy+MbF0/ZFENrDO7A4nBH5FxmzhEsWh0flDUdE9ScjGTy8FpR50LtB47o7QGbeYesTheWI22H/AvzkHt8QwQvr8FpE9a7qKsQgp6AA+t4dLpJByIfYF7urBqoa3zo87xkgjfoy52cyg7wb7XlDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08060261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.195864-0.0147222-0.789414;FP=3152376357097244031|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivXOSph_1787547221;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivXOSph_1787547221 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 12:53:41 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 04/10] target/i386/kvm: Use AMD MCE status encoding for Hygon
Date: Mon, 24 Aug 2026 12:53:08 +0800
Message-ID: <20260824045314.162941-5-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QEMU's KVM memory-failure injection path builds synthetic MCI_STATUS
records for the guest CPU.  The status encoding is vendor-specific:
Intel-style records use bits such as MCI_STATUS_S and MCI_STATUS_AR for
action-required events, while the AMD path uses the AMD memory-failure
encoding.

Today QEMU selects the AMD status encoding only for AuthenticAMD guests.
Hygon guests should use the AMD status encoding as well, but currently
get Intel-style injected status bits, including MCI_STATUS_S and
MCI_STATUS_AR for action-required events, and a non-deferred
action-optional record.  That can prevent a guest OS running on the Hygon
CPU model from handling the injected MCE correctly.

Use the AMD injected-memory-failure MCE status encoding for Hygon guests
as well.  This does not depend on Hygon exposing CPUID 0x80000007.EBX
recovery features such as SUCCOR, and it does not advertise any new
recovery capability.  The change is limited to QEMU's synthetic KVM
memory-failure MCE status; it does not change CPUID, MCE bank state, or
migrated CPU state.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a..d1c6dbe636 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -707,7 +707,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
     uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
     int flags = 0;
 
-    if (!IS_AMD_CPU(env)) {
+    if (!IS_AMD_CPU(env) && !IS_HYGON_CPU(env)) {
         status |= MCI_STATUS_S | MCI_STATUS_UC;
         if (code == BUS_MCEERR_AR) {
             status |= MCI_STATUS_AR | 0x134;
-- 
2.43.7

