Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563322;
	b=YRWU0Un473Ud1hc1oq0zWVH797sQus6xH8eSLsG5yhllU6Cu99f+NLLamwuakF6a1cN+
	 rPpkEMH1AKr0Pek0YoNaB5/LtADLWZ1JJ+aBrXf2uS8BOpFI88bdRucrh89FtI+Rxznif
	 DJPefBXwiXRhi648IPPE1tIHCerz1IHBjqI0NPoN/N1EaYGYINfeGBFl/GGD0L5os/Oec
	 VeEZLSwOjU41zN3xuLm40Y+yHnEZkHu8DVEShsv+TRbWpJ7i20gG1j4tSo2hBKFssOhU8
	 3RgnX+lnGVlwYkVaaHd4GIeNVxYqb66pwHsR8T3LgU4a/kXBBQEm6dcXn/HD+j+l2aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563322;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=uyB2d7JldGTrGzC0YCKTHJcf0w2QHiOdrCM0jtxiBRA=;
	b=VLEfEoFz9D75E8kAQvixpuSiA85Lodjhmiv2zSQomTVLy4oS3/kYj9zqm7p0JQY5/GVs
	 i8KtyKvRHvLYPeo5g4DNUhEmusZwhUBsDLqNsbBs4ZFAikJaBFGlAJpH47bwFfoNLQA3o
	 e0EriujvStcRCGGX5iRUPncEn4rw7i4O4WtusPko/k/R9xN2YAO1UZf/H2O0WVY2WQ2rR
	 ikCctBh4m5p/jFwNJbaWoRhZe28OUvkr2PyVfA1aL4IBJNHRBTtCq+y6wayHVyK9JFRhI
	 F0v3MXphPvVU6kODZBpVxcIvexjcOW0zGk75+mABtmWd6tK2S8G1Yu7ICLJv5+EMH9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TfHShXJp;
	arc=none smtp.remote-ip=101.6.4.70
Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9118606A339
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9118606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TfHShXJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=uyB2d7JldGTrGzC0YCKTHJcf0w2QHiOdrC
	M0jtxiBRA=; b=TfHShXJpw5nq3aIrXupXvTMO7Bq6j5SSPoLf30YI+RCR634oMG
	xBGMsM+IP7EJuzo+bqHYQN+Y5YTkRfvFSCIOaVKXs6IrHGjIsbwLfjmux4xYp6zA
	uoMzo0NvTCEYB32LcYYd2UvGcMZFj8s9PFsO2KMmhTYgQW4+NMaJewl/U=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S5;
	Fri, 13 Nov 2026 17:48:29 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	bin.meng@processmission.com,
	tangtao1634@phytium.com.cn,
	Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 03/20] target/arm: report SMCCC v1.1 support
Date: Fri, 13 Nov 2026 17:47:37 +0800
Message-ID: <220bd78f343a5d9d85a03e20c26ece7152a0feb4.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1DCw4DXF47uF47KF48Zwb_yoW5JFWkpF
	W5Xrn8GryxX343Ga9xArWUZF15Ga9YkFn0yr47t3W8Wws8Jry5CrZ0g3ZakFZ8K39xua9r
	AF12vr13KFWkXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeJPEUUUUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

Guests use the SMCCC version call to select the conduit for firmware
services such as SCMI.  QEMU reports PSCI 1.1 but rejects the SMCCC
version call, so a guest running with the SMC PSCI conduit never
initializes SMCCC and cannot use SCMI over SMC.

Advertise SMCCC 1.1 through PSCI_FEATURES and the SMCCC version call.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 target/arm/kvm-consts.h |  5 +++++
 target/arm/tcg/psci.c   | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 9fba3e886d..ab64c91888 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -88,6 +88,11 @@ MISMATCH_CHECK(QEMU_PSCI_0_2_FN64_CPU_ON, PSCI_0_2_FN64_CPU_ON);
 MISMATCH_CHECK(QEMU_PSCI_0_2_FN64_MIGRATE, PSCI_0_2_FN64_MIGRATE);
 MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 
+/* SMCCC architecture calls. */
+#define QEMU_SMCCC_VERSION_FUNC_ID                0x80000000
+#define QEMU_SMCCC_ARCH_FEATURES_FUNC_ID          0x80000001
+#define QEMU_SMCCC_VERSION_1_1                     QEMU_PSCI_VERSION_1_1
+
 /* PSCI v0.2 return values used by TCG emulation of PSCI */
 
 /* No Trusted OS migration to worry about when offlining CPUs */
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index d8e01df762..81ca2fbb44 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -95,6 +95,20 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_0_2_FN_PSCI_VERSION:
         ret = QEMU_PSCI_VERSION_1_1;
         break;
+    case QEMU_SMCCC_VERSION_FUNC_ID:
+        ret = QEMU_SMCCC_VERSION_1_1;
+        break;
+    case QEMU_SMCCC_ARCH_FEATURES_FUNC_ID:
+        switch ((uint32_t)param[1]) {
+        case QEMU_SMCCC_VERSION_FUNC_ID:
+        case QEMU_SMCCC_ARCH_FEATURES_FUNC_ID:
+            ret = 0;
+            break;
+        default:
+            ret = QEMU_PSCI_RET_NOT_SUPPORTED;
+            break;
+        }
+        break;
     case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
         ret = QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED; /* No trusted OS */
         break;
@@ -177,6 +191,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
         case QEMU_PSCI_0_2_FN_PSCI_VERSION:
+        case QEMU_SMCCC_VERSION_FUNC_ID:
         case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
         case QEMU_PSCI_0_2_FN_AFFINITY_INFO:
         case QEMU_PSCI_0_2_FN64_AFFINITY_INFO:
-- 
2.53.0

