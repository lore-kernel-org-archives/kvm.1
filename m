Received: from out198-13.us.a.mail.aliyun.com (out198-13.us.a.mail.aliyun.com [47.90.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5853B5E2;
	Wed, 23 Sep 2026 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172201; cv=none; b=kC++O/1inHBDHfBLG6BfR+EqApuzRRKEG4DNaGKuRSniajY+u9oczaqBFSgBOv7oBR29OFvgwlkwozNA7ZahdkC761gNYwQFwO/H05dw3ZgdDDvw0mCBiRGt6BEoJKgfZ40QXbBJzb4cPCyU4Sr8KtZondHifnxAt8PElBZEN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172201; c=relaxed/simple;
	bh=QZWNxZ4MgCDhMSom6fOG0nlRZxBeFW2QDH9whnu0/7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUh1L8mB7vf+NxX8A/lM4qbDhpB7uQuUWDdTYbLpThJQDyrHnLMuWdWMfYhDl442dGRjmo7z6CyCIZhvTEa/NXcXVzRNYEf9gzCY6KRoTx+/Lrq376v4MsmKhnue8ZUan09DOkdRf0CsWMCpBj0UOg7QFUNymjSn2w1BFGMSe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2073713|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00822565-0.00404493-0.987729;FP=16639321891949708779|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jL9oyjY_1790172177;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jL9oyjY_1790172177 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 22:02:57 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/8] KVM: nSVM: Advertise DecodeAssists to L1
Date: Wed, 23 Sep 2026 22:02:32 +0800
Message-ID: <46c9cf5d4b347b0147f9fb7781a06e0eaa8918a9.1790171702.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1790171702.git.zhang_wei@open-hieco.net>
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
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
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c   | 1 +
 arch/x86/kvm/svm/svm.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7c63ef90fc60..52dcde011987 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1195,6 +1195,7 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(NPT),
 		VENDOR_F(VMCBCLEAN),
 		VENDOR_F(FLUSHBYASID),
+		VENDOR_F(DECODEASSISTS),
 		VENDOR_F(NRIPS),
 		VENDOR_F(TSCRATEMSR),
 		VENDOR_F(V_VMSAVE_VMLOAD),
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e83e4e5e7b93..82de844f63ad 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5557,6 +5557,8 @@ static __init void svm_set_cpu_caps(void)
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
+		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);
+
 		if (nrips)
 			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
 
-- 
2.43.7

