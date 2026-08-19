Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E914370AD9;
	Wed, 19 Aug 2026 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118728; cv=none; b=AP6pr+97XJpZ97W6Xfc+K71BfV02ttJI7+9m2EHt6Mvw7Z9kCTVdWaAdlbMqCkF5++V4QX5zzbbUmiXAiaucys10C3oJwG7CAMGthvExGLgjG5Uk+FODvXTPGARtLmeTkFPPYB9i/J5q6V3uU0xbwYb/HG1vn90sqO0zzrZ/3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118728; c=relaxed/simple;
	bh=xX6UmGvQtqv34E+M4uK/c1U+pveJKFRbRv4RctjgfOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp+R+KKpVt1Qr5fMNhVCkQQRiP5ulbIFCiZ7GALHQM7ICa2SFagYO5IerzDJz33loAbCY7f6QlcaRi4WOCgOW5X2SJk98ltsKS61Yb8w8KZgfBQcX7Y7DxdAkp6VFe29AIn7X4cD6d9Aa6Fw7x0AbtDvjAoDxWBXtqIQyxNWKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1855173|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00382595-0.00199159-0.994182;FP=7415947660366644459|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ir-3Hjc_1787118712;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ir-3Hjc_1787118712 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 13:51:53 +0800
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
Subject: [PATCH v4 8/9] KVM: nSVM: Advertise DecodeAssists to L1
Date: Wed, 19 Aug 2026 13:51:23 +0800
Message-ID: <aee0faae3637736b4e6db21288e365a3de69bd4b.1787116250.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
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
 arch/x86/kvm/cpuid.c   | 1 +
 arch/x86/kvm/svm/svm.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ddb022cb203a..b644e45eac71 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1208,6 +1208,7 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(NPT),
 		VENDOR_F(VMCBCLEAN),
 		VENDOR_F(FLUSHBYASID),
+		VENDOR_F(DECODEASSISTS),
 		VENDOR_F(NRIPS),
 		VENDOR_F(TSCRATEMSR),
 		VENDOR_F(V_VMSAVE_VMLOAD),
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b85e43112db9..23e087d65f49 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5566,6 +5566,8 @@ static __init void svm_set_cpu_caps(void)
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
+		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);
+
 		if (nrips)
 			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
 
-- 
2.43.7

