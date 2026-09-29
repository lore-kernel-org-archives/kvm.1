Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59160517BB7;
	Tue, 29 Sep 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678246; cv=none; b=RFXEz/Pe+6vU1xtzRpNgFQpO9JD5bLJ2XilcbuKuCskeICbQokhwJsuLZy0mylZ9LR+xgai301fkdGzoL06WTHl1denQoDZmO0xeY5XSA8zQk6EDgnKG9Bs+OEk1slyXWELYC5XNr3Ym7BjhuszW/dVM8j3AdY5E9GD61/THs+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678246; c=relaxed/simple;
	bh=VCK/D1enffulyRH5x8Csu7VvOKZsgrF+zTyKrp5uXPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEIxvO4p60MgVfZYO4n3ImA/9oPsSMzb7WWv6HNzhox6VnBnCqJChHP1BrZfKsE7X/nwm2iZaLH6H69w0dzR7tOnpng3OmM9ccrWdskgJ9q4QRJoU5bDI/IkisY/e3QR8UIPwUmsf6gjj0zZomA6TPq3X1j9cnoqDppezX4OKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JDDJTsEg; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JDDJTsEg"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AqOrdf3B364RLPq7aJIhgxV5z7+Zw/lE9opIsMCbaQE=;
	b=JDDJTsEgq7j1ogpi6CtZ7QCzXgQd1nj+Hx570qFh5Jhm0xN0BDjBZDNAiV4O3HSLfDqlGLET1
	MLC98FNAAdq5h3fiJu49Xi6+REzDSIqIe0KJeseYLy6kjLUHTQM9DixTBaNLgNvXWZD7Fba4bil
	/jyuR0D+XHpvUbz7+eHX0QI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hvDnZ4NkPzLlXB;
	Tue, 29 Sep 2026 18:24:50 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id B64324056C;
	Tue, 29 Sep 2026 18:36:59 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 18:36:58 +0800
From: Tian Zheng <zhengtian10@huawei.com>
To: <maz@kernel.org>, <oupton@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <corbet@lwn.net>, <pbonzini@redhat.com>,
	<zhengtian10@huawei.com>, <leo.bras@arm.com>
CC: <yuzenghui@huawei.com>, <wangzhou1@hisilicon.com>,
	<yangjinqian1@huawei.com>, <caijian11@h-partners.com>,
	<liuyonglong@huawei.com>, <tangchengchang@huawei.com>,
	<yezhenyu2@huawei.com>, <yubihong@huawei.com>, <linuxarm@huawei.com>,
	<joey.gouly@arm.com>, <kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<seiden@linux.ibm.com>, <suzuki.poulose@arm.com>, <fuad.tabba@linux.dev>,
	<mark.rutland@arm.com>, <seanjc@google.com>, <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Subject: [PATCH v5 04/15] KVM: arm64: Add KVM_REQ_RELOAD_STAGE2
Date: Tue, 29 Sep 2026 18:36:44 +0800
Message-ID: <20260929103655.85107-5-zhengtian10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260929103655.85107-1-zhengtian10@huawei.com>
References: <20260929103655.85107-1-zhengtian10@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)

From: Leonardo Bras <leo.bras@arm.com>

Add a vcpu request to exit the guest, reload stage-2, and come back
to the guest.

This will be used by subsequent patches that enable S2 HAFDBS and
HDBSS, as they may need to change VTCR bits for enabling/disabling
the feature when the vcpus are still running.

Link: https://lore.kernel.org/all/20260901171558.2674031-5-leo.bras@arm.com/
Signed-off-by: Leonardo Bras <leo.bras@arm.com>
[zhengtian: reword the commit message]
Signed-off-by: Tian Zheng <zhengtian10@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/arm.c              | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cd9b9d2462f9..86a4d6e50934 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -55,6 +55,8 @@
 #define KVM_REQ_GUEST_HYP_IRQ_PENDING	KVM_ARCH_REQ(9)
 #define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
 #define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
+#define KVM_REQ_RELOAD_STAGE2 \
+	KVM_ARCH_REQ_FLAGS(12, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)

 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0576c2022ef5..d9ad765943d9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1175,6 +1175,14 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_dirty_ring_check_request(vcpu))
 			return 0;

+		if (kvm_check_request(KVM_REQ_RELOAD_STAGE2, vcpu)) {
+			unsigned long flags;
+
+			local_irq_save(flags);
+			__load_stage2(vcpu->arch.hw_mmu);
+			local_irq_restore(flags);
+		}
+
 		check_nested_vcpu_requests(vcpu);
 	}

--
2.43.0

