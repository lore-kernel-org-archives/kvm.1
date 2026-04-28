Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C6421A12;
	Tue, 28 Apr 2026 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378760; cv=none; b=hEadjbvjfIoHvQQVBF2S1oeUfpzH7JCHxFL0lvzYSA7l78153mIxxEKBQt14PUSqW0XRHO0cUjK9aV57a96O8/v6t75zHkxUTjuqkMtIh8StsnjF4BTUzXZvydVwRKbNzY2A1TZ52R7f1bLinkr27+onxlBNKYOly4L9SuMjQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378760; c=relaxed/simple;
	bh=sfKTaLfzwXfWIcTTsG28baPo+gAhiR1sLiN+NEiwZl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8+ci+619XbpaCDLHKiO2bIkgd0kA/GwG8ULtUfHNeVb81j84ecB/gabTBzHVBgohQrI65JhJYl7UovjoZR+63vhYCnAtb50ir+dAVnrVc2ZKp0fSnZ/+i2QpvuXFWSVAzK/j5MVZufCeA5+OVA/mmM2xthnD3IMasOW77x89so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bNQYgDaF; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bNQYgDaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777378710;
	bh=sJclKYEsHRVPM6t5Pr0swhz6IvHM0TzAOaXQaeMdxCM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bNQYgDaFRB41/aAiSHd8AEQrRdQ0cz1sAaMlAmesOuCnW2Gp/90ruRfz6jFoygtiW
	 q7Ksf5JJ8nVV/4/DH+6PDWavV54H9c5AC1azixPifzc4JOl52L17rPf5WDvjhWlu9V
	 wCI8SYsKIfjOMYI8utavu8hHscr+IcdgcA0bO1EM=
X-QQ-mid: esmtpsz11t1777378704t0ce20d58
X-QQ-Originating-IP: RIBOKZVcy4kvYwe88UrGP7vtAwSvlsOg6gkyUUCpWfM=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 20:18:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5879521332131796442
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
Date: Tue, 28 Apr 2026 20:18:13 +0800
Message-Id: <20260428121813.296781-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M5aCtjAndv5OIlH2F1wOFwZKxL/SK7BIKEwte6og6JuoOA/RFtNGjG/3
	scKDspQa0+g0DZN4HFgo6gM99d54ALv2ZvHDFzmKLCBGF0ydVyU7laYy8GuMoJw/nadASfL
	dzFG5xuUKeoAh3YNoDgW3yaFfnhGHBYTd+qL4fHnV5Ii7lbX820lk9FsaIfQjRFMNaePjLg
	RbepqFX/OXLtgp5ApDMfhvCcE1OLj0WxxeepF1wjijfiNwUeIhSGHchyPX9tTreCalM+DHy
	LvV7oTGoT59KzWeJqXmfDdT0IOKsCj2wtKFOLJTTp8Y4bb0ZolIgjdWhEn3opu0hHmBYMVR
	R0gEYdX74RQKR9moNtlq/fAohAEUrtuiqrRXDkmWea96+ZVXPrU4BLTIMwXgk7+8WVAqojj
	GstSNNEEktEqNX9AJ3Zb9B6EBHyKgC/PURifqL4lWCZlDz+F6sUFbE8lDBwSfuZlhFJu4od
	bJDCmptsgjeCscvaxika8Ab9oy6dBG7FgZYE6JS5IBnDEb9q/aGWYDkejHRXLfmNd6Y/6sp
	yqc9VmBeGww3aWEeuB5GnvjDKinuZHa86FhRiyxWX/mXHv0gjZ8l8UUwnvvtLE1ztNOX5c7
	dBYJa1TpxoKEGroUXshtkesMCwjZ7PZopD+hq3G32CrSnvaA3Fg9NDK/qAP2dw5D9ct86Fv
	OYJNC01Q244OazQniEJ3HjLIrBVFmj4BEVEKpczBAGmc/Iqje5T4x/CAtMDAqBIlX6+F8Ss
	+bBzEv49rmKr4BRmt+7eFBbOLKJa760kPyYeur/3dqF8hsNAUk0UXySz/Sev/cbI73/XJAm
	mVH5OtdPG148g8ysUbYVSYltAKwfsmxPZEIDJ2FzYkI2V2YjkOyTS7jTwN567rDx0M/zWk8
	s53Y65qmJBYUlYz0V8x8J2SlKdiLhxun35Ze4tHwQN1MafwWxAb3Ll4zug42PD1+oF7vL4t
	Qam/SVQxPNHR+NmEq6gQG6gC4P9Bdixsf375lIkVPjepkfteVqzUN9rpU3GX9+2MCJCPKHb
	szUFOVhyvsKPDDNrrMhMwGp1MJ3W4CfoYOoMKtEZiVSJ/yNwLn
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

It doesn't make sense to return the recommended maximum number of
vCPUs which exceeds the maximum possible number of vCPUs.

Other architectures have already done this, such as Commit
57a2e13ebdda ("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/loongarch/kvm/vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 8cc5ee1c53ef..1317c718f896 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -125,7 +125,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
-		r = num_online_cpus();
+		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
-- 
2.20.1

