Received: from out198-25.us.a.mail.aliyun.com (out198-25.us.a.mail.aliyun.com [47.90.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE834248D7;
	Thu, 30 Jul 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413344; cv=none; b=hw8QFQLA8s9BCi6pvw1yEpYYlUw+BK1rDSAjlj3CxGxpKMXwh0rDkvR4Zb/G9QuIy1+IPBgw6pKjhfoQRJh6+sJpWf22dLLRb9LAJKL+ReZvY7kr0pc7GGQGCqM39wtQ+58A7Q4CwpEooSymp1Io57STsphgWyiawpl2Wkwv+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413344; c=relaxed/simple;
	bh=sFFttQ47Or4yTB7LMYs0NwoYIXkh9MZsAQ+D1PRBjoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ryet1e/Q4s1kpMMViXK1ydHuuk2EqXP0w1ecSdWac58LLOF14zQMHyCs9kjMh94gmz9pga9LIImw0p3IqAnbMGQT9f9hjl2PE0IPEuMmJz73T7Ouyz4ITrXbAay+Epe0nnavGxX3+JbWI0VZYhOZL5ro3hSCyk/2oKFuLTv8E78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3818685|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00661982-0.00579744-0.987583;FP=14332986305821738475|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrwK_1785413321;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrwK_1785413321 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 20:08:42 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 8/9] KVM: nSVM: Advertise DecodeAssists to L1
Date: Thu, 30 Jul 2026 20:08:11 +0800
Message-ID: <29c2042af283e6d1a0b928b78d944b499153dace.1785411877.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise DecodeAssists to L1 now that KVM virtualizes the
guest-visible DecodeAssist state in VMCB12: EXITINFO1 decode data for
MOV CR/DR, INTn, and INVLPG exits, plus instruction bytes for nested
page faults and intercepted #PF exits.  INVLPGA's linear address remains
available directly from the saved guest rAX, as required by the APM.

Expose the feature only when supported by hardware, as KVM still relies
on hardware DecodeAssists for VM-Exits that are reflected directly from
L2.

With DecodeAssists exposed, QEMU configurations that require the feature
(e.g. "-cpu ...,+decodeassists,...,enforce") are no longer rejected.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6e2ceb700567..4e01a6ede424 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5588,6 +5588,8 @@ static __init void svm_set_cpu_caps(void)
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
+		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);
+
 		if (nrips)
 			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
 
-- 
2.43.7

