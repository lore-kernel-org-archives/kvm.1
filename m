Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C14DA53B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619410; cv=none; b=VVvKyK9OLwWyTcvMLIE1xFtYKXWNdP9g+1+yIV/52yXuzCF5X2Ue2dKl8PTTAQ8bdFM3cBZOua78pcqX+HSif+Ly9uJsG5oYGz/KCNutXv2ylDoripEdRgDOwcuUqChNCxEk7o1+WEwi+ZMn+oQ8h9SkeIPWqrUdlCrLodwTRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619410; c=relaxed/simple;
	bh=ZH9gUXanWZQyFamf65EPOVHin/vb7WyYMXAgD6w9ZNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4MxfjaWfGPzdisPhdD84DhE55xZCL8abAI9jpt72nHa1A7IkEhBMFC6tHit1EUxtP9KK7p+fm99Wel/jfNbho0X6+i2E/UusaB6fA3crOyLqs63zHv95GBWbtn3KJYGUSx/A/DLwRLtPGviP+t+k1CSwfh8zpH09CIT+KiOUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGH30+y4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGH30+y4"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso268846a91.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783619408; x=1784224208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBMHzicJyGTjDx4Sp0E+AdJJQvA9nCK0HkWtJMojLZs=;
        b=KGH30+y47/VGnqs0bVScnk/1d86q02HFQ8Su5nJuowxwlDgSV4KbjPrdS1fcY2xUXJ
         SrlH7uy9jzOC858QpJw3ET5qnvMZKW7VQP4zqCl1NVbEZhrQ4qtbYp8RlEZSrAD1mnd7
         ivMmZCe6QsJ8nLUNA4BSVSqQA/sbQ8e+0PUh8fSG2v6TCKJONt08rE81uPRrWzZCGvZE
         wQAjPvRu8h2GusuN5UPn6MxHWzuuEu8YWEdYX885ID/zoCiCeQnivbnviKbhG6hmeyNM
         gKl4hghuVDQlMfQFXbPk2YszoJg+5QCDxmLvtNBZ/wmJURl1a+IBhGzSLVpjQuGNTqfa
         vBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783619408; x=1784224208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBMHzicJyGTjDx4Sp0E+AdJJQvA9nCK0HkWtJMojLZs=;
        b=ePzRJvKj6Mq2OfkW8IT+9U8GUydvmOybI4S9oevK6/QOV/QaDWiK1sSIyRuZ7BGAnZ
         Y6y1v4F8cUB30FE1jcA19u75lOK2MMb/tSvwHq/PaziFMevz2CK13OLjiw+gvXaPas0j
         pxH9cDo7qtJeG+sUcMxzTWfinZXdwIGIIybl/dr4VGZ+yIGtAX3Os/Y3SZOv+ZAK/D06
         KKsFJWayzWktjCLK6RUe8vmTS1aUZU8azio/BfhtiJ+w0SRQxmLaVdorSOGJmga484Nl
         ozsxWPJl5HiZlDNcJT074aDwtvMhaX0pubYj2es0y4dfZIHmnG/2VlCTMvEOY30a6tmu
         NM/w==
X-Gm-Message-State: AOJu0YwFl4Bnmw0I7huWAJWUIGPxxr6kmqat2YFN8XPSvKVEp+yfZY/Y
	2pUwL/Mub2jlGrBkh3pTglr6syIajnUI93CUg8PJViuSHgH/UfLGskrO2EQCvbBu
X-Gm-Gg: AfdE7cnmUiBs8LR8nOuT3JJ6sRgzEueLIgs+GoovcBOJ10XqhSEkqQfuz2SDxtAEMvp
	b4GzBb3FaoOf+kbh2q5vArFPNzh7NFvaB9c4dJcyuchUAamPZFnSNoTfELT2CCD63U3zCjhAesD
	g3uZgtEYP8Wjr6aWPHQbgcMDc+HhBw4udIUL991kSyU8tPh2WkMwaDlIU2ZB1jbgPAWs8zi3Scb
	Amph4KqyFy+yyR3IuBCSeZ1zTESlk7WbYq4oeC4Z60IxKSHM+yVsKS05L4HOW3b5oCmwja+QNj2
	EHVDLUXOvk72IrZ6JgEFOXdbhQXAiFGm2fSfG5j+9QPeEDjjgI33CQ0PDoSecjfSx6aV5QPRgLE
	psIV+rtX9a2MzvYNuGS8mhDM/f5l5kDrq4pMhEUPSJHHQLbZG3nly/0O2jWAnLeHbJJf6f0vrnQ
	IzGJCCGh99lhgWhfue3cJg3ZPSddOLWNc8Cek=
X-Received: by 2002:a17:90b:2803:b0:381:abcc:c8e9 with SMTP id 98e67ed59e1d1-3893fd5f5b7mr8066066a91.7.1783619408160;
        Thu, 09 Jul 2026 10:50:08 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm2206765eec.15.2026.07.09.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:50:07 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v2 2/2] KVM: selftests: SEV: Sanity check the launch measurement
Date: Thu,  9 Jul 2026 23:19:55 +0530
Message-ID: <20260709174955.628913-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709174955.628913-1-hemanth.selam@gmail.com>
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
 <20260709174955.628913-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_sev() launched the guest while discarding the launch measurement
and left a TODO to validate it. A full attestation-style validation is
not possible from the selftest because userspace does not possess the
transport keys the PSP uses to derive the measurement, so recomputing
the expected value cannot be done here.

Capture the measurement returned by KVM_SEV_LAUNCH_MEASURE for SEV and
SEV-ES guests and assert that it is not all zeros, which catches a PSP
or plumbing failure that silently leaves the buffer untouched. SNP does
not return a measurement through this path, so it is skipped.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 6b2cbe2a90b7..9ce465b4a770 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -150,16 +150,35 @@ static void test_sync_vmsa(u32 type, u64 policy)
 	kvm_vm_free(vm);
 }
 
+static bool is_measurement_nonzero(const u8 *measurement, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		if (measurement[i])
+			return true;
+
+	return false;
+}
+
 static void test_sev(void *guest_code, u32 type, u64 policy)
 {
+	u8 measurement[256];
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
-	/* TODO: Validate the measurement is as expected. */
-	vm_sev_launch(vm, policy, NULL);
+	/* Sanity check the measurement; SNP has no measurement here. */
+	if (is_sev_snp_vm(vm)) {
+		vm_sev_launch(vm, policy, NULL);
+	} else {
+		memset(measurement, 0, sizeof(measurement));
+		vm_sev_launch(vm, policy, measurement);
+		TEST_ASSERT(is_measurement_nonzero(measurement, sizeof(measurement)),
+			    "SEV launch measurement is unexpectedly all zeros");
+	}
 
 	for (;;) {
 		vcpu_run(vcpu);
-- 
2.43.7

