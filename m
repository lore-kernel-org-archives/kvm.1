Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788A2E22B5;
	Tue, 28 Apr 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362553; cv=none; b=FWMt0jR/xKYoxQsSoxqmSxGpYZWEr6xSl0EZZvMEt9WAZsTD+gnwsjvHrUR0Ezmol0GypzWRYLjr3bA3qipHnSRBvPmK7FlFQ9HxjawgeBYqTKcHzmzP6aN8peqIUWGfmFVp9Mx+OuFoTvtHSzEEE5TdHoVJmLF3bJYf47LZAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362553; c=relaxed/simple;
	bh=UbJfs54DsXuusjTiJcOxBH9PA6kkpnP2o+lq341iUgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DtQHpBxHjvvdtVQKCh5bdDOA7eA5rZwaqzFqXDCpC4K1wppf5QhrTr+Iqk3r7IK7LjhpKRDTbT0X5Som9ma0jskD4vdCUrmoFQnFwHt/CoCk1IyEJCwEam5k8812safAv+a3iFgnDADIRcuwhsDzYcHtwMKOxNRSHOOUIQOOI78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CTwQkEQJ; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CTwQkEQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777362505;
	bh=5S1dzxWVAlesG7+RLkk7aYfapROTEeYlOxWi2PsQGUw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CTwQkEQJtwJ80iPdmKuCP+ZTzrgOuZMdGFSDh0isZFMvZu15Y2sjyHUnIZcqFDOJA
	 C7NTcB6qxaiE2o8v614BLJRLeqMSOs7XeTNrrX+7Zyfa04QKUM3dTKq3OZm2QnVFG5
	 0lCqf2SpZq0znC5PpB50e+5OW4UcY7Mnwp6Ghvks=
X-QQ-mid: esmtpsz20t1777362500t9eacc23b
X-QQ-Originating-IP: /55V7HWWci7kYnl1SiQw/jSM+z5+tZuDLIwaukJtmNo=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 15:48:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11065973348417640269
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
Subject: [PATCH] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
Date: Tue, 28 Apr 2026 15:47:42 +0800
Message-Id: <20260428074742.2274610-1-maqianga@uniontech.com>
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
X-QQ-XMAILINFO: M5aCtjAndv5OIlH2F1wOFwZKxL/SK7BIKKshGBGGorlVf1SmKNnaeu7C
	YBga9wOQI9LXGVZe6knYUecHX6Ho62Ll82W0ojgWF6wbrNKsVh4Ek9hQeKWCqIR5u9AZkDF
	cdjJKmfGr3UBks8GEWMqWpGOtD4nUD0pxToKDggSGTOwr14VJdE7NmisycqCgoAmJObnKLf
	7F3/uUFVAc67n/VfoEqugIwJStUjFHHjxQHiK0clt+eJmaitdh510GaFO6d2JXh+rID0iVc
	0hPZvRtIYMtROrEHiieKTjUhFS4JLBbZYO+yWyae1e7ACr2a+5ZnGkA8uEaDIPBxgdt9Iwn
	U1jt4umnWllUIv7SFF3N23iFZdix0G7+TicbI8uZxPitpYhtLgycY025+mRkZFhVZABjHw7
	75EyV+yXxUnoDgI0s+DG1XE1MlYhbDhU42p9IIl4MuPLmOKMLN1tY/1zgYb7eaIOOoTZ6CG
	S3NAAuG3IuX9D12aEitlgFeXUyfiAs/QTRGoba2UMPvw1aX21/VVLTJZimZAZC9gpmycWap
	LR0oeSuPcZODqC3BjmuNsV7zkW4GYwH02iznp2Hmvm3eByXCVyBZAhWR4OQv9bbOJFridvv
	YSAovzImY9mip8tmsRBRl8vPoYMZhNprK5tgoDyZivMfEFDTgBKgOBZ2YX0lzgW3fggxaZU
	TPGOGcOjJTjuzfbz7bdWRLMjKkW48bK2K4cSTIaTvGe/tRexkzDSV8ha+Wx8fagbntBXIas
	Gc+ogeoarr8F/NziLRZV5HU4Ez34b5d1u2Q6ODVWvX4s6cNxh0Tho3rz5ULatIlmfRMlkAf
	YF2i62mTtdwox3BJSYvePksImWzXFyYmRWm/CciuNVx08hkjQbhEHZASeaywbIuT7q39xLz
	DAb0vYWNk66Sp1W/MJIxGWTaF+ZCO2WPLur8xPGQs0tjNOzPcdPc7X23yNvNyxer/J8troj
	rrvwrHN3CTdtdpGZeslwXnrWyJkHWN5E71ktuVJdNLGkrPicN2EgUpUzSpG/XPz/43vzZ/B
	RRZgF4pX+AXF6Nra2mirLPVUtZgdc=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

It doesn't make sense to return the recommended maximum number of
vCPUs which exceeds the maximum possible number of vCPUs.

Other architectures have already done this, such as Commit
57a2e13ebdda ("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")

Fixes: 482795cb62aa ("LoongArch: KVM: Implement VM related functions")

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

