Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396293A59A3
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350990; cv=none; b=KqWghF4luKWP6DuGn6xGvAgXHBr0T80hb9jOCAoHcvfjtWIHcwjgHU1nlwdntOUAJaDjd+WtnACfUyzklMsEWk6Ex+pb+vyOJsJQfUseOIkFPyDqquxfvAGfcxyrClfySFr5crpI2N0iEGVamgPmciypcUZ6JzKxO1QtP+/68xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350990; c=relaxed/simple;
	bh=5ISAKFzLpcb7fUsT1/w6p1mYGd2JrhVJPzKIJFAbXV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZvHJygMrIfUMRLFWQLEBbDaNY+x2ruOYhQlpwvIu02tm5aFps68s3j3Idhciks/zNF3031GzPc4l7AflKqh9+XtkD8epxlo0tTvMC52Fzw3hmUG9joSEPdG3/krWB1D9JD+PnlmzrUc/00W+uo9Mgd5mI1hLYNpMZLQ+ew1+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08302353|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.195864-0.0147222-0.789414;FP=3152376357097244031|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hML_1786350661;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hML_1786350661 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:01 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 4/9] target/i386/kvm: Use AMD MCE status encoding for Hygon
Date: Mon, 10 Aug 2026 16:29:51 +0800
Message-ID: <20260810082956.1768042-5-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
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
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4272b6770c..aa32b74f10 100644
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

