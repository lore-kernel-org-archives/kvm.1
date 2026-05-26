Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205229D264;
	Tue, 26 May 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781398; cv=none; b=T64UgnVEgrYtBDYOYaxb0axcKtk25V/vuAcqhFt7yKFCI9TsgPPgTFVJRvnaOIMJZiWtOqg6HsC7XTx5tWnR6z6YrKBC21WZKrN8BkGwotsF/nS20ezDkXnRqnisfs2kjIzon+SQx5ipg6Ty6/7ax5BlN3Q+29+S4Rc5/lgsZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781398; c=relaxed/simple;
	bh=LS0JEM2tAJSAT3CsJ5ysDZoAWEkp+8C9WOpgsgpPmt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jCvV4V2sYs6GadGs4V1gSM/wCtfNFRYPPOnEamiOzODRqGWI9J+eMF1ICEchEvdRv02ffG4VYA8Zdl5mGdF7ENa9nXLeMulIGcfrVdVwk/UJfMrzzC7GIhLDNCMq4cDfCfuM5GlW4AUFuEtZJaOWHYcp3Qi+Pu1g6JoSVIZQD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZsTKxYxp; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZsTKxYxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779781344;
	bh=MbiuGqwVnztPNeK56AOQhnIvz1XL9i5qyp7Uojx3a3w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZsTKxYxp6YhXQ16avEqo8Rtb9mdVq+IEFuFXoVp3bJrXyqpOzQXdKqgI6X7RF1B61
	 Tu7Jb8cX4Vn8XXud6mdpp3patW97cfx+fbQIn28aJWPDfvcnQojRxH0gtfUIThVqsE
	 SrDSmsO+zZBV+FqBpktMSWEB1079zw8lx6Zc6kLM=
X-QQ-mid: zesmtpsz7t1779781338tb77f8adb
X-QQ-Originating-IP: uMkWWbUKhiYh9+DU177NbnHbmLH5b+a22fAuwPNAou4=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 15:42:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10348446116461712637
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
Subject: [PATCH] LoongArch: KVM: Check return values for put_user
Date: Tue, 26 May 2026 15:42:02 +0800
Message-Id: <20260526074202.789799-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OCrOINyfR5I/6l6j9u2Me3DswMrpgtdJG1hgpEBEZV4RmjPc77gvS/qo
	GLvs2ACii1eoypnx3yzk4m6kyNt1zp6REr6lILWqD0Xr4MjzY5QO9QmOb7Y3RoJoheC6Lmi
	czUKzOAPlOLkZ0VUu6oBTjhVGegKeRFLZCkdJCDEm1tlrXxpzjqSIJ0E8c9yDL3Qtf33IkG
	pa++CEYgtm+FXZV0aIlxyKaJ/Aa59dV4fc0qIR/K5ihdXciCqmuAJ+BHXZGw2mLRuoeBi8h
	7MUVPsOYsITj+Pl8kt/l5uvU/Gs078GNDeA+USabx5k7eaI3Jb60GyfCvT1QgjbkJ6HzYHX
	7NIZg3z5v8Yi2U/LXJwiXfw4G2F+5QvvIEKmf7f/eeGnfAsoWc9VVrxK8Vh3ivCrHYaYtgD
	lHEM2RTQscO8++2hu48PViiH+I4rgmf4+93LqaneOorS1VAQPZ6k9UZjfWH4lTyqcAy6hPU
	BPsXhwqe+AzoxyCSvIMOg3BmFbCWH2cjRVhIJpJIyIVSuwRTo1DOEG+vmZx+CEWAwGcbG84
	RNm+14uFbJRMnDRThWF1qDxFqqabR4W+AF+Ze77lX7IS+v/T2zvVMWmQDVKubES3dh09ZMz
	tJ9ym22DM4yy/ibvso/U7UW+iqGp9Mlvg4QDkfOkS6f98Ij0Aslh4ZURCx8HzZcXiUJe2zW
	jkdXjS0tZrUKtSsZeaQFK25Lwu4R+8/VNS3tpou5K8W4r16jfWKtM8DDn+KOkkL1gazatHh
	39TStCdF5lINFVY3ZU0aMIjv/Y1fgMjMQcPNBOxjpq5K8ywNMS6p+dsQPK8nDHjr4uQg1qT
	4oAnwVaZexABm2q5NpcA/De96p18fF6oEoQzHZxEPYQKp1Kqz13FX6B/xKsuqoo+6/viBNC
	nXHEWJYHL7QEJk8Ifq9HconHtzoTlbVwlC5Bkfolmgexs0zQHXAXf+VrNlMt2+k27AHjuQO
	WvCmsUmvhPU/BqGbP51XawvSUP97T00Jeum6VdWM16iO1I/HqN3SgnSrYMc3vZ+5AapHpkP
	wVEk44nsTBzhj5fN9befliHJpXIYs=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

put_user() may return -EFAULT, so, when the user space address
is invalid, it should return -EFAULT.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/loongarch/kvm/vcpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 782dc1a36e29..67441edf0e1f 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1104,7 +1104,8 @@ static int kvm_loongarch_cpucfg_get_attr(struct kvm_vcpu *vcpu,
 		return -ENXIO;
 	}
 
-	put_user(val, uaddr);
+	if (put_user(val, uaddr))
+		return -EFAULT;
 
 	return ret;
 }
-- 
2.20.1

