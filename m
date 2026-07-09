Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BC39C012
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615686; cv=none; b=NGsZgxVGrPgvSksDhnUuVHyhOrrpoqYI1TZp+vPB/UNIykXoc/4kclZYTOPBa1B4OTE7GDqQZPwJuRER4QZ9eUtbNNRxoCUo0T+3liSIes93q3gL07lnnhtqV0wQqnY0dOhvQf0I48hnE4JH1WnFDY0sSEv8Wt9jCiw7h5Tpd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615686; c=relaxed/simple;
	bh=+W/qQ2Hv4LdS1GgtpOiv5LgnBmpcq9nVszsYmmeLclI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxb2AAfD06lxBTM2Zdi2sKa33LDuH1RZbFbJInWHS3HXvdOEIVe/+tezzW2TwM49aU8OLuYDMNLgbUOx25VmY57cZN22G9sNuN5svPKqK0s0KO2G3Jt3ImqD1hhh3ce0XxZqHCVclGrtJ0U371cOk3LbdODpA74WIgg0A6wzYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc5axp2J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc5axp2J"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso31060685ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615684; x=1784220484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJW2ZcrjPjx/PI62Gs3l5SSes4AcJMYW3LZ2O4zfkV4=;
        b=Vc5axp2JZk25IGW5hdAOhxMPu8lHl8k1x3r8+8Y6gsUe+A9tQMHU/VgOR/81b3BpAv
         dwMSJ4BeqIjOdicjpGdCPS6s1VhUyOCRuN03OLOMc5esDjrSRbHcDwtxHlO1s1940nRY
         z5WXE6LLPFoO+FnBrxmsKsxhE3yhvwQq3gdhfcGBhC18yvCjWIB6Lj9px/S3tmznr6V8
         T9cERXtJnSjFV46af+uFQ52ZxcNrnjTG1CSOd5k82pvNXAeOkl8BNeB9qmyww+x2yK6g
         sYZmKZsuhL3pkIiJb/lEIDbat07X3QxGSY4/8d3ksvZ1GcNkUuFLKY2UbT3ABVjnEgmY
         u5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615684; x=1784220484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJW2ZcrjPjx/PI62Gs3l5SSes4AcJMYW3LZ2O4zfkV4=;
        b=nZrbpgeZST4Qid5rkjkEeKP55O2AkqhKOx0sX/ncDVlZookrhbOBX8CJ4ALow6kyA/
         W80WUNxrILMmETmV7H47IzDJZcNYbGvjydpNpsOEU2gJlONZ8FdSeMQ/y0zvQGRyUa+p
         l8HaqN84xldH+pqVEeLyqN5a2rOgBPvo+9oru6b5tpr/r6fd+9RBSzQjydSXc5N5/dbf
         WfEb20Nfh0RjhEeihVIjc46aV2v40iP0MbAuTGcmY84FKcMmrKiiNBPH/A/cm5fqLAO8
         iBA6yXFcyWQnxw4SfI9vWk3TnvKnDSBVwjq+vM01RB6JVHlXyRdA2mtGtxnyDSbWaI08
         +5Vg==
X-Gm-Message-State: AOJu0YzGEgwjU8Ipv9e1HCjaO0yCgu3i6EiF+3agYVaOpoDjy0POy92W
	9mQ6cyvuyrbZNm6bjDxckZP+nKOVkcUYzCXkqZYmuHomWvll+7L75Cyk
X-Gm-Gg: AfdE7cmme+0k5XgH837BNt67T69sT1QpLLRqtwzypMqEKGqNXrh4mECD67Pq7CslTxm
	9dn2gjcsa6vg0zOByBu3dPRt8uFviw+OIs5ZkcjIKVUJuSBFr2pevGB/6oW9eMLtaIN8HTcEAZJ
	l7puHtdyMn0n9LGXwEonNw4MybfqXtRv/JXnZl//ICOwMoDj1hslyyeKDH3q/gjD3/7wp9c7BFk
	Sjj8ftW9f5nIZf88Z1PvFfri/24nYgNXmZ+EmD9XX5yQuUD134jvSKQWTsb5f2ei3qFD4UhBULA
	iqXWye102+x7NqS2imjPwKF4wuf4f/IwLxJTicwUloBDo+SulGlqAq++s0u1l4V6WFe17pfTTT3
	CSWYQ3j3dKabkSQyuj3Hn5f5JRfFRPgertA1++Vu42j9o68y7w6EM1pHktI4dJ5kgVTMQk5blQs
	3WHjUenpK+JpCVimD8TNAKoc4I44aQxVXDqK4DiLP3dG6gBQ==
X-Received: by 2002:a05:6a21:670b:b0:3b2:b1f8:c745 with SMTP id adf61e73a8af0-3c0bc93823bmr9807816637.20.1783615684503;
        Thu, 09 Jul 2026 09:48:04 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c4ddsm35709287c88.1.2026.07.09.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:48:04 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v1 2/2] KVM: selftests: SEV: Sanity check the launch measurement
Date: Thu,  9 Jul 2026 22:17:51 +0530
Message-ID: <20260709164751.621326-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709164751.621326-1-hemanth.selam@gmail.com>
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
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
 .../selftests/kvm/x86/sev_smoke_test.c        | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 6b2cbe2a90b7..795b03a6b7f3 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -150,16 +150,41 @@ static void test_sync_vmsa(u32 type, u64 policy)
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
+	/*
+	 * Capture the launch measurement and sanity check it.  A full
+	 * attestation-style validation (recomputing the expected value) isn't
+	 * possible here as userspace does not possess the transport keys the
+	 * PSP uses to derive the measurement; at minimum it must be non-zero.
+	 * SNP does not return a measurement through this path, so skip it.
+	 */
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

