Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022241A76F;
	Mon, 24 Aug 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575244; cv=none; b=iAVU0OVZARLQffgTAgK9iUGeFDjz+95i1qeiTi9VEVur4PSTT250uUKpyOd+5HScUpTZgRr5SWKb9MZAgXQl+z4EiIFe+qmV4o+vOtTxwu7J5IpFFus+sAGmbXHXz1MCF7je2s0GKtPyrAoA6XzJpisL5c0Tk+yMATj+BQx1aME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575244; c=relaxed/simple;
	bh=jd3bO3RiRO2rc9g7ej7oNn4oAcN8Wf2tabH6c8wrUqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1eoG1icXgjwpTJWDFAa2vJ6+PdWQkuWa+oAc9IUghbpVuaEui0bB4CZP7pXfTdr5XVYlx1e12y2u3eK6/l9EIZ98ZyGtI81PuvOhlSbt0+bGqdYN2D77WPjkdRiLuZ0+nB/WDe0YAlRFU3RMGMzYhGvGaJ/UqNBGL21/pMvNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1917552|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00349696-0.00202938-0.994474;FP=16639319697221420267|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1ghFb_1787575234;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1ghFb_1787575234 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:36 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v5 7/8] KVM: nSVM: Advertise DecodeAssists to L1
Date: Mon, 24 Aug 2026 20:39:53 +0800
Message-ID: <20260824123954.315112-8-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824123954.315112-1-zhang_wei@open-hieco.net>
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
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
index 5426a9669053..a99a1dc3426f 100644
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

