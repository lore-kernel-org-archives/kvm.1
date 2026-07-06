Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7763BE646
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317376; cv=none; b=m036eC6z2EOJE/A50mTCX2FA4qM112IU1ykO59Q4xXLKQCOtA20nspWObnZnEsMfQUp1sRix+XUuRMJoJKreuxxlo7/QFRnPPdhrlOG/Mmnr9tqPBUnC/JVs5pV+x5vDWwuYuCYiSgirvYfVZa2sxn9GMrhmWyMAckTI0cfdH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317376; c=relaxed/simple;
	bh=4IHyiidSii0scxYzD7MlbGKj7Sq6S5efmnjMQVxXkBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQiBAVzMYloiyWSn2W62s3piaR7HjxTbFJa+XxKnjNPyH4Ocvo/5hIyYP6dfgZU0Y3cj8EJgdQKcwmaQLWRLDS01aqqGXofHhQBD2r3s3r8F5iLCvTlWE8mc55xN4e2hOEruBUdoghW/6CQEIyCrIrVv/yPoH0UkL1aM8L9fe+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08311087|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0297137-0.00931817-0.960968;FP=7187543794714895573|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStsW_1783317366;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStsW_1783317366 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:06 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 6/9] target/i386: Do not broadcast injected MCEs for Hygon
Date: Mon,  6 Jul 2026 13:55:27 +0800
Message-ID: <20260706055530.1752094-7-zhang_wei@open-hieco.net>
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

cpu_x86_support_mca_broadcast() excludes AMD CPUs because QEMU handles
AMD injected MCEs as local machine checks, not as Intel-style broadcast
MCEs.  Hygon Dhyana missed that exclusion: it is not an AMD vendor CPU
and its family is greater than 6, so QEMU reported MCA broadcast
support.

This affects QEMU's synthetic MCE injection paths.  KVM memory-failure
injection uses this helper to decide whether to set MCE_INJECT_BROADCAST.
HMP 'mce -b' uses it to decide whether a broadcast request is valid.
With a multi-vCPU Dhyana guest, QEMU could fan out an injected MCE to
secondary vCPUs and populate extra bank records.

Linux routes Hygon through the AMD MCE feature initialization path and
does not use Intel/Zhaoxin LMCE broadcast handling for Hygon.  Do not
advertise Intel-style MCA broadcast support for Hygon in QEMU's injected
MCE paths.

This is limited to the MCE broadcast-support decision.  It does not claim
that all Hygon MCE/MCA behavior is identical to AMD.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 6836214162..0e71b52f13 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -95,7 +95,11 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     int family = 0;
     int model = 0;
 
-    if (IS_AMD_CPU(env)) {
+    /*
+     * Injected AMD and Hygon MCEs follow the local MCE model; do not use
+     * Intel-style MCA broadcast for these vendors.
+     */
+    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
         return 0;
     }
 
-- 
2.43.7

