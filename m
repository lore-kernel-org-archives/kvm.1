Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142A35C69B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350674; cv=none; b=D/+NpZs3E5gtc8X4OOAVPy2DddHRVhq5Jleg3wR62dhP4+SOvmbSsYdVLMNT99B6ufQHxV3bs2PXdwzd1tpV/GaZXP6wZDGvas0dPpPJ+f8o5NM+1ttYzUj+p9WeM2Dzk/PmS6s+XV1fIpuOYj0lvWX5gr2kBso4aJsT5kXorvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350674; c=relaxed/simple;
	bh=jGlK3jwFG7vXfFjp7xMMqSlPjGkdBREBlnsO9JPew4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyOnSve+gvlsrE7LdjvuEdeOKpR6tddzs4Tw7ROZCOJIO/YeJSCynCQUm7nycKpAiE0MbLgr1YoRN4X5rXx3Iiz85YhEObu6REQAWS2ousmwhAtsCslnzx6WsgHnKQGNMggk6pocu5W/LOJA5W7QN/GdFZuhlRNZn/Ub9Plv5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09693278|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0628494-0.0109224-0.926228;FP=7187561936658883669|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hO7_1786350662;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hO7_1786350662 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:03 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 6/9] target/i386: Do not broadcast injected MCEs for Hygon
Date: Mon, 10 Aug 2026 16:29:53 +0800
Message-ID: <20260810082956.1768042-7-zhang_wei@open-hieco.net>
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
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 6836214162..c5bbe9715b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -95,7 +95,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     int family = 0;
     int model = 0;
 
-    if (IS_AMD_CPU(env)) {
+    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
         return 0;
     }
 
-- 
2.43.7

