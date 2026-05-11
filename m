Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256F370D52
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510210; cv=none; b=BJypEL2AFQd3PZT8jT5NGZ+PJB9rRN/A+AZjA2qzkaW9N9p+qQ2qoIMwHjlb/aJiA0M6keg6OFHz4SP+SQ75DwWcZwLBS4Oig9mIkA4rlc7y+mErfoufcpUgtRwX0+Q1pG24eicLttVfJxpTygAPa3FdGUO5RqGl8u0uuYvwh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510210; c=relaxed/simple;
	bh=OCWkO9kiaVtlkjvw4jaBUr/0GwYS4dSFaaNA889cWuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ac+qoUYTg2Qd/IdHKCd9hg9gNT3F9LjxDvmtjOaeRf/vdnZllUmnrDp9o7yeYAJAVH9nffxqIxXeN/FWwXYgBZRrgbQ2s3gqoVA4JQUSRBTqApVmSbCGGDTYuo62aWTaJZIrIt2nxklcWdDgGO/H43bRzKYwmNniOgwnmFuyTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVwyXVXD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVwyXVXD"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67e9b3037dcso5963756a12.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510207; x=1779115007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvCAfW/ab6cqkSL7XlF/lvlNJfGaNVLCaQnRtMsWK2M=;
        b=qVwyXVXDXjOa+6c6PwSXZJxOkTjw/lPS7mWwagdfLA2KQrGISLN2rec/57KMU/o2I5
         ifAlrcfsU59+Qg03Xp7nYuZzPm6dWn9Mg++MhRM/6kADpxa/K4mYTEY+icnLoaIKo+7x
         cIO+chUzyLebYOxwmbNFm0RDZ6eq5ZweDWcsROX+PlFbboxI2vJS2va8tleDO1+r2Rq6
         7LZYDFAKAAjP6bEX1BvsJl058ZCog3KAvZdSSdAvi/JXY23hQ9ywYjeZFOfVLeJEAkX2
         T+w7PlT/Bc8oCLZdJntfBKLC8odkmQz4xyeonwcvvFJV56kDKM5BPR+DQcbKbn6mZLLu
         rTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510207; x=1779115007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvCAfW/ab6cqkSL7XlF/lvlNJfGaNVLCaQnRtMsWK2M=;
        b=EpX4ZO4J3NhwiCzGxhEQAQxD5gj5Gv3Wh4T0/FKTDRZvdMJupfzdnJwinszccMEAmH
         xdoqDngA74sPkChsLPzV9UBKk9xtMFjSpkuQ7vVi034EaINHX/Z0VhLGn5D13xPArmYC
         bNs+el9p3cacXkKbAHtWPSn8ccFL9UUmwYIe4svcK+Q+GCF3Dq26R2HTXotGibacA8Fx
         dMzlik5LKj4M5KQ+jMXUaj2p8zei4GI/4g0nRcqrBRTfIlYtvUp2wTuApGsbUSIEbqv6
         BKU4kmTJUGWmcH8tytzKAITrgBad2WWQJA3Ol8I6kEiGt/dut8x630j4X1iBNi24VYFJ
         lzlw==
X-Forwarded-Encrypted: i=1; AFNElJ9eMlk1BBObu3aIvUWuTNopl7O5gkGCbjnnd0/00HKB4YWEG1QPkj2SsObK6gbgZrUUMBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZ8Ih1JLSrj7h+K9jz2Cy/2uc2FeQsFX5fxTQXyJUKVCOxlK8
	9MEtFnS7JN2tElLFiGOv9lEIAp9EL0hunhnvEjO7BZqWxda9W51PTBSL
X-Gm-Gg: Acq92OGLwDs4OMc5KEi43nW/z2PFND7SMXDg68BZEH/jbuBONkahqBeyXzriwAVcNTd
	Xego4hz5resY+48Bw77HCF3QWPCqvRBbCdEfAub9aBnJiro2dywLnf1LDvcl5YK+d/TMbnTTNCi
	nMzEMfl0Dx3lpcuUNdzN1zg1Ct/SiDzUKmrLEJbarURfxSEWRvDWYDgwjcoLk5/D1vJM9n2l3hU
	HybPv1mHj+VZ5TcxJAQSubVDTosEZGs+JDRabwUtrISWfBBg5QRn4knRWglCBSZhLjQbS4R5c/W
	YyyDcn9y757h3exyhN4wHi98IJ7uFi12Mq2H59Vn+NVxBCo2iYZKQN7WeByam8xE/808PeXgR5c
	xbp+sKIFdYhdw9IQrLV7Zz7enXx1QHb7WZMm4wv7jeTitrHot2LpscVcAo7As0FDYTC5O73ffRe
	dzqvrpP+yCay0+55LJSo7dqC7Q95WleYq2ZvEEX3HR6N2R7njY1J/gvuaooQQ9VcpnuPWsmmKdS
	X2Au53Tm4WqM3jX4i/plvzxzy8=
X-Received: by 2002:a05:6402:3809:b0:670:8add:2b98 with SMTP id 4fb4d7f45d1cf-67ef07ba8f0mr7220503a12.14.1778510207251;
        Mon, 11 May 2026 07:36:47 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1c044sm3651347a12.27.2026.05.11.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:36:46 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH] KVM: selftests: sync_regs_test: use KVM_SYNC_X86_VALID_FIELDS
Date: Mon, 11 May 2026 16:34:26 +0200
Message-ID: <20260511143426.1242013-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use KVM_SYNC_X86_VALID_FIELDS instead of open-coding the same three
flags, ensuring the test stays in sync with any future additions.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 tools/testing/selftests/kvm/x86/sync_regs_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/testing/selftests/kvm/x86/sync_regs_test.c
index e0c52321f87c..8f9239f9d357 100644
--- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
@@ -79,7 +79,7 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 {
 }
 
-#define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
+#define TEST_SYNC_FIELDS   KVM_SYNC_X86_VALID_FIELDS
 #define INVALID_SYNC_FIELD 0x80000000
 
 /*
@@ -255,7 +255,6 @@ KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid, guest_code)
 	struct kvm_regs regs;
 
 	/* Request and verify all valid register sets. */
-	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
-- 
2.54.0

