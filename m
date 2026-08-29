Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A41374A08
	for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787982631; cv=none; b=ET10DoLcND165/1Mx3UVOJu8hocGJWruFEEfJ0H120QWBFT4BiLNv5Fv1Wbs/EBTlmhWtkhk03hj8m3Yoo3Or17azhQNMpJEVBQQFoOknzYXSCDXaEsU79hGrkMM52H5MshPJJZWKAv+QoKSNRkwCm0NaY7B3nGrLqg3xPrDm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787982631; c=relaxed/simple;
	bh=Q4xDvcP9DIiwYXTXpczLlLyq7Kd7CsRktQVDTGiaDVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFEqG1gVT2j0vOMc+gYoJT5skAtqz3Ybxf82e2N1VCmVsp63IXFPGFlS/v2v+cf5q/EzewCyxP21ol7TuZ/+mVqxMGQoJPzoZPirBsHTG93Vnlc5wmom0fXXJDVu0746dnuoVjwoATEvGNmEZx+tZbpSwhTbnJd8q/TsqbrKRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD6QDr38; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD6QDr38"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so14889885e9.3
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787982625; x=1788587425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmU2GuULI4+ubbU7oraX4k5FiAqeW6B2DekgWiWauec=;
        b=HD6QDr38uOdg2inY+Mqbd8HJB2s4sC1jnKT1/cLmDMfe+q8ZWY3RiNc+Pbl4QMf7/4
         jqFK4DCYCL04nFph+fZzOIQ1m7SV2h2j5SUaGYZkHox2n8Ck+WoEsz2TW3SJGWzKXfXn
         NsLrYQkfqF3vPx95ahD6uaYUpcopTflEVaplfa0mkK0sUst0Ncal7OKkyOMRbX1EDWlj
         zJzbDvFRl45PUPCs8JOSJBLWUOZ4vJsowCJVHIBIuES+8JKu87Seu7PmzSLofHxy8SRk
         23+969t79Fln2i+uB2WoRaet05BiKpr8uScQOfIhnGoidi3PFv1OFp5u1POSkBUu+swk
         6TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787982625; x=1788587425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmU2GuULI4+ubbU7oraX4k5FiAqeW6B2DekgWiWauec=;
        b=rGHmQPyyN7BFmJGXKshIDaiLdvMBTREuG6hBtxjKUxADI+Jb8VDaPI1XJbQFQ1LoEp
         SvGvKgffPoK81ouNx4FBkFnRMSjw1EbC/efX2Xi5PvNmr2Y7rm9/7btBjtQbQFQ3X3WN
         EdljNQ2sysFb3o06L1M1GyKnSWPT7FxiCuPV23G6YsS/ggFWOqkqj/pP7KJZ/FVjZ7b3
         B+SbnJbqOC/T5606MJFYan7qsa663PXxOGka9oP7VvAv8hVM0ZV2ukA0iAuDJnBk2WYY
         IwPYsmp+3GpF6LWIpsnDc8RbBSLH1KliUwnPfwuarAxMU4awNft0l8xVc+5Exl7jr6TA
         Td2g==
X-Forwarded-Encrypted: i=1; AHgh+Ro9UzfJcuCcvRuXirg5QyW5PdmcG0PboLS6/7SEDxaSKPZpmmUFR3+yMAk7qe4d/NH7/hs=@vger.kernel.org
X-Gm-Message-State: AFuF++k7KKvC5CbW+h/5GNv7AN72V9NrMad+gx0phi0SvCbpWdO+CmUb
	U4mKphDNE7oFEC2vENirVHNp8kKhpOst8uQbDULrcoS0Q+XUIw9o17jc
X-Gm-Gg: AR+sD128U4/izTpfR48wZm3Qu1yMLX+6bnvVeBU/TW0KTCrjrpR9yVBz9XtUgE+wn1t
	hSsnK+QHaNrtMc2DXB+yjAHhSKvJE+b/JdClvut9pmDus506bxuql9mGK1AAKj1OdX+uZt2A28P
	C0IrZp/3TyvuY6FHzgy/ww8KKdbicBfMxsOvtgXipJ5Whnh3VaK0sB+8nn2e4mrlQ/IzVnBUd0a
	M+kp7MNEtBOxPGhiURTDhOuGB0CSTjw3HXso63/siWmsG8AvpfmEHtTLJEZOEPg9gIPG3ruVjt2
	MYhWGlB3OWpOvI83dP342WShRd3e9q/RFoRjy2QHPak737CZPz8Hae89VAIuRFWl1pxzTwr3oU+
	gMJ0smZEkGQFYfFXzHf0xyKHmB6XjeXQmkBxf6N9oQxQM6cvoduYljSGVNE5etwUBfhNixS1BrJ
	+rSA3GWOk9WnbS4aAPYiQyW5GRoo8/MEbczf4cKmmwgtnXl7Buxn0X6+hn8tav4/Iwv0CTRWeP9
	x6SOY5w9s74J/a0ohCZXft2tkVqsWhQ0otYYZJ80cQisNxK+EnAnFzo1goZKkp5o758O73K71+E
	hbMsAPV+etzG0X1/69Vg
X-Received: by 2002:a05:600c:1f8d:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49b91c17c41mr163125035e9.3.1787982624717;
        Fri, 28 Aug 2026 22:50:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-015-136.77.7.pool.telefonica.de. [77.7.15.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca3e642dsm35357485e9.2.2026.08.28.22.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 22:50:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: arm64: selftests: Test empty SMCCC filter range at base 0
Date: Sat, 29 Aug 2026 07:48:56 +0200
Message-Id: <20260829054856.70549-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260829054856.70549-1-kmehltretter@gmail.com>
References: <20260829054856.70549-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_invalid_nr_functions() only checks an empty range at
PSCI_0_2_FN64_CPU_ON, which KVM's end < start check happens to catch.
It never exercised base 0, where the inclusive end wraps to U32_MAX
instead.

Add the base 0 case. Without the preceding fix it fails with EEXIST.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 tools/testing/selftests/kvm/arm64/smccc_filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/smccc_filter.c b/tools/testing/selftests/kvm/arm64/smccc_filter.c
index 21e41880261b..a41ed3e016ba 100644
--- a/tools/testing/selftests/kvm/arm64/smccc_filter.c
+++ b/tools/testing/selftests/kvm/arm64/smccc_filter.c
@@ -140,6 +140,10 @@ static void test_invalid_nr_functions(void)
 	TEST_ASSERT(r < 0 && errno == EINVAL,
 		    "Attempt to filter 0 functions should return EINVAL");
 
+	r = __set_smccc_filter(vm, 0, 0, KVM_SMCCC_FILTER_DENY);
+	TEST_ASSERT(r < 0 && errno == EINVAL,
+		    "Attempt to filter 0 functions at base 0 should return EINVAL");
+
 	kvm_vm_free(vm);
 }
 
-- 
2.39.5 (Apple Git-154)

