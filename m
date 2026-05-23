Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E79347BB5
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779535252; cv=none; b=C2phEsYNxR285sJLtCTe0lSNz6O21lfLxxwsvFovsfjOzdiAeuuD10DQBIKjDLJWfvvBCnXTAY2CO6pT/TONgJmZko/KS7uhnwI9v3deQA/Rbu8JEWueGgHEeaRc4J8As4SlePz5E2K+40v1bJ8Bd21Pv/GuR04BQ3bePbf5S24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779535252; c=relaxed/simple;
	bh=Drxci6DRbRjEyYilJsznSmhWQNBWme4JLl4MKzSwthg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFhYmUQIqBecm/GUA1zgFYjGGxlgCx+D0WGM27opKAptOgTR9BVcff9/7xnF82rIiFIsnNCX9eNtv7eiWGWrw/QfvFCt1E+09W5GPy84uWU6j8vHi0cy0GHgaOi84m54/8NLIXmZkgM9x+iRHuiwjUA+Ix2zoltHJg2A2sA+0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8sNiQ62; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8sNiQ62"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso13517183a12.1
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779535249; x=1780140049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nqpg0cE/A26jNSG7hnd21Xe9lvVMA7stypHYfZTce8=;
        b=c8sNiQ62js1O+/Yjasv3AhBkkrBI7ZZfVmiuGzdkfiboqdNYAoNSso3eUlkjQOfzUJ
         JG5OX5HwIaXydmvFmNTEVH3XgtUG0dlVgscM82kOMONDodokWpcP9PbvrsAI06G+XRYH
         fCeUz0RjOMyKK4vYAzflVsQ1Oa838/CTDRb+fmOlmmuypWB6XUErro58TFEVpKmwI7rk
         jW/B8PdUMlIHn7KeU62qKgrCr7T9zpTrocmbur8gEPff3p0WQThsCyDtMXajIEFgp+RJ
         Lmw+m8AcYLc0/tI3RZMwdq8H2xRFVehPdFN+52g9Z06Ie/wdiTO2b/XYL0Ng+KP5peDi
         yY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779535249; x=1780140049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nqpg0cE/A26jNSG7hnd21Xe9lvVMA7stypHYfZTce8=;
        b=JvKP+LF/M6xbXhsjwIGUhIkh8gVYJ29Jbk6tBpwXtwQ27CUe4MkIFt3ep1h6tsAEpV
         yj0whpIkz6KJWs+I5nVOz2vqt+4kPEJkJ9GE7tzBSCRxfRO3Kq8RHz5ghiGOBYSyMIEz
         J5Y4iVR+liNUuHfOZnM0GKx2AYQQ8pNlRswz2GjO4opPnJX3umu6D3Yu0YEYinjVMwob
         hv1/rKCBzTTX/H8+utIsSeNjFPuOlS7ZquQfyYBSS9D5OxWSMmOCk+tWdIPDOqK4uYWR
         eDPMyBP0PcyK8M+NFBytNLTcpLSUpNk/AAfzgHJX5NN3kRWI97O8WQBk7JsV3QnILar1
         wWKg==
X-Forwarded-Encrypted: i=1; AFNElJ/Eh9FhTNzGw37EJ7gJeH9/fDnDk7+QfYEd6yqZzDEGZ8k0QVRIPT1XPic7heG93K2wpaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAVp0+PoNBhs9xA2R1LL3kjK98f2PICy1LRiUtkHU4ZMAb5dw
	fyERWofupcUjR9xWzerff/z3r4+pfb1RXZ/2FiCTTSnkJNVdPYUa+dkb
X-Gm-Gg: Acq92OEGD4GEz5anfbUbCZwqr/zLfUMBxq5RwGGiCJRu9K0FHGILZDohakgTlfNcoLU
	Ar9hNWfilc0q/qw36p1/xd77DGFN8MPRFw+9ZdyQHoqnbjUN/u0rGgKbHZXZb3PAEsSlvctEFdb
	9+Y6ppeypK658gl3KNr6H57UMsSKr89q5wTGoR317lbRjTNKUL1beytygL9uEUdWBW1gZ3Q/cbC
	Cp6GXTBB9Kn42I3Qpq0WxieN7uh795BBVBJ/HSqL5pPBCfcTuZgjBIx6p7NKE464QF1UzeqVKho
	LMiWsT24AWm8VNSOsZSe/C/nH1n1p/fOqsUulxnNnkIk3wxuUK0zU/YjxvuVKvdap5NBKfq2Nw/
	CEcJpk4vUoM6BNQr/ZIC5kodmemO5k2mKKUGgkfofBBDTxLDCs7SBVwAaC3rG7ImXnTCAXPG46t
	bSOFJoLmYVW5Atz/SXkuifINF3ikb1mdNM1SXKDzKmtCLkQXGR2wPErx81Ksw5dVIvDorZcDnEx
	cgTJH7ilAGGbqoCa53ijNZlgGuZnv7Y3dLd9G09KqKesdAc
X-Received: by 2002:a05:6402:5293:b0:687:e07f:d860 with SMTP id 4fb4d7f45d1cf-6889cc6fab7mr3860415a12.26.1779535249220;
        Sat, 23 May 2026 04:20:49 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1e20asm1806980a12.15.2026.05.23.04.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:20:48 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: vkuznets@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH] KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET
Date: Sat, 23 May 2026 13:18:57 +0200
Message-ID: <20260523111857.195396-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing 1 to HV_X64_MSR_RESET triggers a real vCPU reset; the test
was writing 0 because the host loop was not prepared to handle the
resulting KVM_EXIT_SYSTEM_EVENT. Add the missing handling and write
1 to actually exercise the reset path.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 .../selftests/kvm/x86/hyperv_features.c       | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_features.c b/tools/testing/selftests/kvm/x86/hyperv_features.c
index 7347f1fe5157..7c8afe43eef2 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_features.c
@@ -26,6 +26,7 @@ struct msr_data {
 	bool fault_expected;
 	bool write;
 	u64 write_val;
+	bool reset_expected;
 };
 
 struct hcall_data {
@@ -267,14 +268,9 @@ static void guest_test_msrs_access(void)
 		case 16:
 			msr->idx = HV_X64_MSR_RESET;
 			msr->write = true;
-			/*
-			 * TODO: the test only writes '0' to HV_X64_MSR_RESET
-			 * at the moment, writing some other value there will
-			 * trigger real vCPU reset and the code is not prepared
-			 * to handle it yet.
-			 */
-			msr->write_val = 0;
+			msr->write_val = 1;
 			msr->fault_expected = false;
+			msr->reset_expected = true;
 			break;
 
 		case 17:
@@ -497,6 +493,15 @@ static void guest_test_msrs_access(void)
 			 msr->idx, msr->write ? "write" : "read");
 
 		vcpu_run(vcpu);
+
+		if (msr->reset_expected) {
+			TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SYSTEM_EVENT);
+			TEST_ASSERT(vcpu->run->system_event.type == KVM_SYSTEM_EVENT_RESET,
+				    "Expected reset system event, got type %u",
+				    vcpu->run->system_event.type);
+			goto next_stage;
+		}
+
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 		switch (get_ucall(vcpu, &uc)) {
-- 
2.54.0

