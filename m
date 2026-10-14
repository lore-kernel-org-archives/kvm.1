Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5244D7967
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017781; cv=none; b=nmeG8Qzu8bJR0K8+euh7aNE00+o+SSubXx8ZK5zOqunlLHlUydP+wQNK35RhGUolalsk495YYG6hQwbtd7sVqhRRVQ8QFZkwhjwBB26C9hC5BfMM+alR9v4+7eZL02lOutpPN1ZA9hfh6wFE7Xj7z+6YCL8GYPJJwrAkesoOLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017781; c=relaxed/simple;
	bh=6QMveXXpEj5QdPkVXKozi90KLuYOCVhf9Jhu27z3Jvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWhk590dMu4IaonyVa/iCrSlMTYq1pbQ52B8HNcj1UZgO3cUbobQ4x+ppvo7/owHZB43f+2/oZBg5lV8VN2meENw/2NAZAR4gS6sS5tzV/xCsZXTRC3i1KeoVQB5iA3ljnq67gQysHzW5fwgHlIg46nZvVjig1B+TuWtQIWOoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=FsyQyuYO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="FsyQyuYO"
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DEC73F98E
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792017776;
	bh=ZdiR6FLWYbNv8HRJW/cp7ACv/gfnAQ2Xl+ab8eRDEmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=FsyQyuYOUONJp/2rlriXx/UMmB5To269mupZAhVKDQ0v+77/jNw7d+wl9RD0FOyK/
	 g4j+U2pR6IR3u4gKqQRRtd5MLbct22J5n7aQ9ZhG1Mn4vEuL45/nxXLOQrrSwVNH3J
	 LceGO9aLiMmvpqICnzmiZ8FKoRJoBbBDqQjayyNUCfx8zEUeuIaO7lSU24XliMuHNw
	 2vTACYVsVUQt4FISzBYXlUvW1AZ2MV19FaygNEfKdZSrnRNoqED0ebxExo/xsH2+Wc
	 d070OUBfOtJJAb0ghQ2s16b25xKTcKQOoRu/gX1nAJJvK6Tyhob9QyfYufdMEe8iDK
	 8MKM7I4+gItFe8xQyr9sYChgpOIm7ZZfcWxjPFe1nbbUU3DPOvbg8JjkOODlTkF6DO
	 pqbJ8fswtxKJ3+XkjkVw3S71b8wEUgtQrOWyF5qeDWzVoFV0ZM7jhuGIZw8+XOkN5Y
	 3E0fyCOj2khgc5m6MJBD5t7xY21uEN+9vxGkTTvIFFY2Q/VZAhwWDm7qvCLGf1ogoM
	 IICR+8VQoSokwWTr2plID4Uk/ir4ulobQAYX8P+PW4Q+z8kj4J2oLQ/UHrjerKYY9V
	 SDr8/sG2+QzFKZuQ9xDiMoIvPllcNWVom3Kt9JN3WjpDwMilEowHrps61LAHw4+hO2
	 MXWG9I6IiVy8V6+vnEC2dPo4=
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c437ae81eso665233f8f.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017775; x=1792622575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdiR6FLWYbNv8HRJW/cp7ACv/gfnAQ2Xl+ab8eRDEmc=;
        b=KmTR7bGpY0ver8yCkO94zLl88GMOgbdLVQj+2+1FXcMtoy4X9lM75rrg7W3RCalgp5
         woDQV0DEm50UWuMkINLax37irGt/bLr6bNMlZVGplWUDhL0TZW1z51I3icE1ptdLCP8D
         IRLDCnBBJSJ9Z0SleWxo3SaEBlR/KV4CmH9PvHNe1W2FweoVxaHOh5Gi1EiULf69vsFF
         a7TGM+Xelbcm8nkVnj1SFPgcSz6x0aFpS/nV42h/C6moDaKJ47u/In9jmpyLGxqz3Jk8
         CWNVAUrOz1AhPbrLTu3RYpTj0Kie7zwixJA0lBlXT4coMAZWr05o+sWRAzIRjvGJbhpD
         Op0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwk58pm6JAO5mYsHPXBrlxiM+V3XJkVRUjoZunATZ/yG3W8O+wwFJYbxHNkQFPbBLNcQsQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUAP9Y6PLqY4BiOQNCZWAo8mthIvgPHQ8Fw1MzFvI2r+c4MV0H
	z8ek0lno673VZlwKpUra25Ju9nzzfqx1/cvVhufgg6mDYPUH9cXte+E/0jffqfbAD8Eg8wq5zgp
	zAXUN/JPBwsdUGDjjxCn6gJUGTFGHUGP6rwrnlRv7/kwnQzT8fdJSjdXXuBW7Swk/KnN21g==
X-Gm-Gg: AYBFou2yOD0yAPbrFlRrnZ/+C6JlUldEGPib33jRPqbVq7twahDJD4W0IqVW8q2PTZf
	cimA4OjFlx1l8b7Alx9JP0o+vbcIo+hPAYEEJW9fVFTSDw+ffQFHtocXdEETrwkSHMJip4M8+/A
	MBSUl3gGGtuFyMmHf1+/EEoB5T2JZFGf62TFO3SvMUuyaSNvpESdDnmMbSu7saaQLXgNwgHgIS0
	zlNyFZexV6UE1WyQPlDYwER3FMDFiMF7XbKArhIfwaOVjOiB8xvkz6Oba9Ui+1jxeMpw0v6KcmZ
	tzirp3nfMI45al2eHhAmMPAs7mbvLMKqNn0HGYwcJBe+SXmVW0yiN7XXrccZdpvXvmqNDlsamV3
	p/57h8s0M3hnQpSdxGSzN7dM6vtJOY5NrI+/0MGROINofyeth3fvBk59V
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id 5b1f17b1804b1-4a18e47aa9amr359760845e9.6.1792017775548;
        Wed, 14 Oct 2026 15:42:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id 5b1f17b1804b1-4a18e47aa9amr359760415e9.6.1792017774558;
        Wed, 14 Oct 2026 15:42:54 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:513f:8595:22d1:d25d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bf63567esm23227965e9.10.2026.10.14.15.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:42:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Sarah Emery <sarah.emery@canonical.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] KVM: riscv: selftest: add Zicclsm, Ziccamoa, Ziccif, Za64rs
Date: Thu, 15 Oct 2026 00:42:39 +0200
Message-ID: <20261014224239.963635-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014224239.963635-1-heinrich.schuchardt@canonical.com>
References: <20261014224239.963635-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM supports extensions Zicclsm, Ziccamoa, Ziccif, Za64rs for the guest.
Add these extensions to the get-reg-list test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index bf3980e9db127..71e5969142b30 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -63,6 +63,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVVPTC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZA64RS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZABHA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
@@ -89,6 +90,9 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOP:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOZ:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICCAMOA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICCIF:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICCLSM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICCRSE:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFILP:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFISS:
@@ -576,6 +580,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
 		KVM_ISA_EXT_ARR(SVVPTC),
+		KVM_ISA_EXT_ARR(ZA64RS),
 		KVM_ISA_EXT_ARR(ZAAMO),
 		KVM_ISA_EXT_ARR(ZABHA),
 		KVM_ISA_EXT_ARR(ZACAS),
@@ -602,6 +607,9 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOP),
 		KVM_ISA_EXT_ARR(ZICBOZ),
+		KVM_ISA_EXT_ARR(ZICCAMOA),
+		KVM_ISA_EXT_ARR(ZICCIF),
+		KVM_ISA_EXT_ARR(ZICCLSM),
 		KVM_ISA_EXT_ARR(ZICCRSE),
 		KVM_ISA_EXT_ARR(ZICFILP),
 		KVM_ISA_EXT_ARR(ZICFISS),
@@ -1238,6 +1246,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svvptc, SVVPTC);
+KVM_ISA_EXT_SIMPLE_CONFIG(za64rs, ZA64RS);
 KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zabha, ZABHA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
@@ -1264,6 +1273,9 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbop, ZICBOP);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
+KVM_ISA_EXT_SIMPLE_CONFIG(ziccamoa, ZICCAMOA);
+KVM_ISA_EXT_SIMPLE_CONFIG(ziccif, ZICCIF);
+KVM_ISA_EXT_SIMPLE_CONFIG(zicclsm, ZICCLSM);
 KVM_ISA_EXT_SIMPLE_CONFIG(ziccrse, ZICCRSE);
 KVM_ISA_EXT_SIMPLE_CONFIG(zicfilp, ZICFILP);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicfiss, ZICFISS);
@@ -1372,6 +1384,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_svnapot,
 	&config_svpbmt,
 	&config_svvptc,
+	&config_za64rs,
 	&config_zaamo,
 	&config_zabha,
 	&config_zacas,
@@ -1398,6 +1411,9 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zicbom,
 	&config_zicbop,
 	&config_zicboz,
+	&config_ziccamoa,
+	&config_ziccif,
+	&config_zicclsm,
 	&config_ziccrse,
 	&config_zicfilp,
 	&config_zicfiss,
-- 
2.55.0

