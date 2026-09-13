Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D338C2B8;
	Sun, 13 Sep 2026 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281845; cv=none; b=VyOMcbQTJvnLe1xgCRkTQEd18U3eNS4dNPxKn0s9f+31kl4mCnQJ1nzlUEhXzkHnaZnBEr5OgHD2eaShm6QmHlVJSxB06muDwD+F2ys82reTr3JcySLhkm4S9Nd9FYzLP+uZBDHxy/A5hGBMbNDyOZHaAOujPvlWi/BnjGralFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281845; c=relaxed/simple;
	bh=V/tNwE6yy2+TPTBaO5Fg2lHvoBwPkiRXP9un/Uf3FjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtUwHAu2hlns2sD+vI70X0og7SA7Rn1G3FMNuUdl8ekuXRi1WYWFe6a6ABI6al/WyH/LS1gEztQG0lApTR/Ag3DIWEYHm1d3puDS+x194FTZWrwYdr8FLmvsXVOzTIYsmYeGLGiAoCfOXmtWQmJDz1ccU+GS8ohZCl5DtKGSxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1955635|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00758271-0.00380057-0.988617;FP=16639319697221420267|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvpH_1789281839;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvpH_1789281839 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:59 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] KVM: nSVM: Advertise DecodeAssists to L1
Date: Sun, 13 Sep 2026 14:43:47 +0800
Message-ID: <d9ab1f65fa658967e6a50fe65a49cc0d58824166.1789281096.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1789281096.git.zhang_wei@open-hieco.net>
References: <cover.1789281096.git.zhang_wei@open-hieco.net>
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
index 6834e1101bb6..c91561a9a49f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5560,6 +5560,8 @@ static __init void svm_set_cpu_caps(void)
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
+		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);
+
 		if (nrips)
 			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
 
-- 
2.43.7
