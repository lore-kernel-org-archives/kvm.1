Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572D212554
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862956; cv=none; b=MUDQSC2G8QhhvRegS1fMngr0NdZ/2YTdBS+hc/kTMKfa8s8TwNpO5Z3Y/SOmrs7rOc7jME63k+GRNj51LQP3NzB/RmLXjIu+VlmEX/HSSIuzZdHl7hKZuhAdnqIwA1M8OI9pvUOjcxUgctKnm1f+ts6UjjRFLnAoEHN0pNj1AcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862956; c=relaxed/simple;
	bh=at7f5AKTH91oYlNvw3aVXQ96KLv8B399FbxI2NTz3tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIlBc7QLYeODUD9x1VAFv6gpDOPSuMx6tn8Sq7T6Ha5tr52xUozfKy4R7zZvWBuxh1lNQwi3XOR/2I0Ou/N1VNdFZISrb4viIBuqj3bkzqSzjRsls91pzi6zxynXPVB3zPNRH8J83r2Ct9BaX3brg40EwN2/e+OvoAXnxmwrnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8EYuaMC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8EYuaMC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so43413145e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862954; x=1777467754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
        b=K8EYuaMCauEPRy8QvB6BFomdAnEPT119OMqB9XlXQ6Baa6ZpFAmSVR4e3AyakDaW3X
         fWhBc7yO1FWauV8xbtUk0v4yPZfKBQoCr3yeWEEW3D5bMtdIk3Ycis35EFXIc6/JxIvB
         e/udQWHoscNXDzxfqUgljvCL9+hweyvB/1QoLtVm6N1vjFXnZhsGr8hE46flRIDRItDq
         WCxPgt3//h+OlsxrI4ZC4N88PkEVdqSpsAvtUGOfKQVh/gtH5FuF0xFgwPq3u83AKtBP
         MPqeeKQ4p/xrmb2EToGRm/5ieOoHGAEXKdylKgx3GfXami4+KbYwEP2oq3JQToKiVizQ
         i7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862954; x=1777467754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
        b=TuJGfyuslGml9xFXwLe+JxSduiA6J5CaQZ3wUyTlSHDn+zWnX2Q0DTyOLGrnPRZKOc
         90jTG7LLlAj1KDJTRnHr//aCfmDH8KLkLZhrjurmRcg1YN7E0hMRfL3pMrLMX+NUI1J+
         OI/ZdyM5NpO9BkoywAPwm3KJkGUxSwyq++3VIDVub59XRXNEwPn9zWhq/dFv9QP/7Au3
         +h6p9Nu+oeSebkbgJEiP9Km0UM1+BoI7ol41rXzpQLNU+GHb9jPFn/Kom7x2uUEZwvQK
         G8TJmO5TcpN4blypRwS7tRsgn6n7Lry5AQvZAWxJ2TkNgW/1g22lbXceSwDMeaNeGQFd
         gtQw==
X-Forwarded-Encrypted: i=1; AFNElJ/GBqlB0P1nKu8fKViz3FidnEpbaMznylcwU+kgdeXvbDCwyPyuCxEkcYxfHFFkJ1hoqzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuUDGyrSolnD20Wn7kLX8acb4yjJmkgVYUMH9wVJJm70eG9ZT
	Vu9S/tilE/lQMq4Ih0WVZKiCbNJMSZXsfAXmknVhBdafYLa2RSn3VkITlH57jJAHHgU=
X-Gm-Gg: AeBDiesGRRRf0DqQLvQpSER98vQjvkNiCSYz390Db4cWAQcqn6LI0rS8Dz2P4AAzCh4
	Q+Ph0hNzyLR7CnfqQT5Pz3YTwl7weWM7BVpF/V57rz/DnXL1azB1L6xQy6v/B8Npg9ggjW5N7yT
	49E7CBnt6XW/XAWmg36hOE4ValyD+ay7opr3j0gRJJGAFzSTa66NU1UW5vyVHgYERb7PLZlRxAu
	lAwlJIOCSDEz+88icbKWIy8oRi7W6W1rIRfjUdTsHO0UhXJcWndxyZX77sDkCvFWzQzUo32nRpR
	YkUKWcYiL0XbA3aacRJ/7cEbuswRwau1PFsEXLf04pxbKpv203IanNPXAwO1c3yfNfdjXpNk4ML
	8nZvB8chLFQ2a2YzHaSvlGadDfCOI7SMhDV/w6mAVBGsr4H472yh0KI5MzzexPqY6vzSQBo5Pu9
	sOm0Qt/wYXOhEYkkrkSCT5BP4R9hIyJQ9g7xqeRUuw5jOa
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-488fb785901mr358408635e9.22.1776862952412;
        Wed, 22 Apr 2026 06:02:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm230894695e9.2.2026.04.22.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 78333611CD;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 19/32] target/arm: make hvf use syndrome helpers for decode
Date: Wed, 22 Apr 2026 13:52:36 +0100
Message-ID: <20260422125250.1303100-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..1c1c31f0b15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
+        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
+        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
         uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
+        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
         uint64_t val = 0;
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
-- 
2.47.3

