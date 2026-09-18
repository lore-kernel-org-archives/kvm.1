Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56503DDDBE;
	Fri, 18 Sep 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721808; cv=none; b=Q955J1R5oV2dh4HADBK6OtO8pYMShEwGmSuOhiOyhpcLCFcDKYSas9Ox+ajhciDRhguNuN5UxMcwDgCGQwpefnDt0UBIxOSHqu8cTi6oSt3/Bb7cx//tdggWtm0wRu94DWBhrJhDax83+aaJN68sO2J4ajkeTSe2iFO3VlZY4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721808; c=relaxed/simple;
	bh=QZWNxZ4MgCDhMSom6fOG0nlRZxBeFW2QDH9whnu0/7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWKB9ryqGRmA/fiVzmGmyjvGlXFKIiRMKHAHVPIoyxdzZBNx5Dnqb0bnYfm2XNNzsHClW6Amr3Cofya2iT8GUa6lvMUEg1oWkOGS+32TwxIgW77mzKd5B0atfSpMXrPvGUsQs1yJa9mLniz4/bXLdO2Y+Gc3scTDL44km+wYqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2010712|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00822565-0.00404493-0.987729;FP=16639321896244676075|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGgS5SK_1789721790;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGgS5SK_1789721790 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:56:30 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/8] KVM: nSVM: Advertise DecodeAssists to L1
Date: Fri, 18 Sep 2026 16:56:17 +0800
Message-ID: <b716bb603fe3fff0160aa7b2af102cb5e9738086.1789721173.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1789721173.git.zhang_wei@open-hieco.net>
References: <cover.1789721173.git.zhang_wei@open-hieco.net>
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

