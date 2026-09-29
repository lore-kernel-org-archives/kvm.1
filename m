Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74A51AFF4;
	Tue, 29 Sep 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678241; cv=none; b=P3syKnXVFKdiQRJCzSH2B/ndZxz4JZ2pBIl5S/QFdvRVbRzOcBHVz+Rq2p5tf2XUlsYTyCkkY4TmQQIGzUDHUYu/ztdgIYTT2mihO//pPuBuMQGXYZaPkAvb4ALFrAn1w2tSeHSHJGq3J/FfOGa/dvLCZXALhTxpTRxJtxIcrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678241; c=relaxed/simple;
	bh=z/tdji+muD5thyoQZz35Co8SqEbd39Lu5zGPtMX6Emk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMRFI3wFw+hH3yTpRliFX8tw0pKTuEQVgJwtc9d2ctoSmULDH20fN4szcXTALxZNxAHzYjT4r7cf6VdoF/gkt1BPVT3NHYv12uXWzpcMpqDR2mfJZbNh3cx+1EHsjaQSK6At+92P1UOsDqJv+j0BOommzaVjPjIkqigd7m+p/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A6Wu2124; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A6Wu2124"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uSdBNVs4UefFpSGY9jG3xM3F4mLYxZd4t/C56DealMY=;
	b=A6Wu21241SK7i3HCYQ5++Le9OVxNG4e6TP5zR+W/m0dnIUiTneqw6/KFyqtR4tVWxg86uXJZ5
	opfNqN39X2nUcepz8UK0oZPg5TetNGTNYl0Eb+fbKfRcKOKKThX/0YybKVVPLkEcqSdZw/V6cXe
	+0Wr63O3iLFOkLiIo8f1KBA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hvDpN1vlGzcb49;
	Tue, 29 Sep 2026 18:25:32 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FA1A4057D;
	Tue, 29 Sep 2026 18:37:07 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 18:37:06 +0800
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
Subject: [PATCH v5 14/15] KVM: arm64: Document HDBSS buffer size ioctl
Date: Tue, 29 Sep 2026 18:36:54 +0800
Message-ID: <20260929103655.85107-15-zhengtian10@huawei.com>
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

Document KVM_CAP_ARM_HDBSS_BUFFER_SIZE, which lets userspace
configure the per-vCPU HDBSS buffer size for hardware-assisted
dirty tracking during live migration.

The capability applies to dirty-bitmap mode only: it is rejected
once the dirty ring is enabled, and enabling the ring after a size
was configured resets it to the default.

Signed-off-by: Tian Zheng <zhengtian10@huawei.com>
---
 Documentation/virt/kvm/api.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0430cc750c9..3a3a14cae134 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9056,6 +9056,34 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.

+7.48 KVM_CAP_ARM_HDBSS_BUFFER_SIZE
+-----------------------------------
+
+:Architectures: arm64
+:Target: VM
+:Parameters: args[0] is the per-vCPU HDBSS buffer size in bytes
+:Returns: 0 on success; -EINVAL if the size is invalid or vCPUs have already
+          been created; -EBUSY if the buffer size was already configured.
+
+This capability configures the per-vCPU HDBSS buffer size used for
+hardware-assisted dirty tracking during live migration.
+
+Userspace sets the size in bytes via KVM_ENABLE_CAP. KVM allocates
+per-vCPU HDBSS buffers of the requested size.
+
+KVM_CHECK_EXTENSION returns the maximum supported size (``SZ_2M``)
+when queried without a VM, or the configured per-VM size (default
+``PAGE_SIZE``) when queried with a VM.
+
+Constraints:
+
+- The size must be a power of two in [``PAGE_SIZE``, ``SZ_2M``].
+- Dirty-bitmap mode only: rejected with -EINVAL once the dirty ring
+  (``KVM_CAP_DIRTY_LOG_RING``) is enabled, and enabling the ring after
+  a size was set resets it to the default.
+- Must be set before any vCPU is created; a second setting is rejected
+  with -EBUSY.
+
 8. Other capabilities.
 ======================

--
2.43.0

