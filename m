Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BC3F6614
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420167; cv=none; b=korE5t3E+H6LPfCoKCkxDtH3A9pROqUi8MesmQOj0xjxNmvSOMEyAsFhlkpXEZumThzrACi89CrkYCGcODZDQ7NbI0p9xf0Puik6kihlJB2YyAZi0ttBPYD++Bnam2ZKPAqLXvLj/daiquYp5RigN7feWfZLpCgNNw2r1jaNOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420167; c=relaxed/simple;
	bh=GCvi8QXTW/Z8JarQzo+uw0cj5SOI/3SJYgspvt0tyXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ESVnJRMIpftM8vgXlSNMFy86YiBx0TUVO1CrGGrbSvH6qwC8eotxGaFA5p51qnYRPaq7U2V0wKQAXbibybmucvySd+x/v8VEh+h3s7T5aqZlzYPl7aqtM4Tm9FikP4yQMnD0g0ZQyrEeua2nflgSP8E894r1jaZaapgIGzrTF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2h+H5dP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2h+H5dP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32faa62so50044015ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420166; x=1781024966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0n2TkN12qK2IJ7MEU6lVCJRDKh5l/P+Za+C9ZbB5kjM=;
        b=f2h+H5dPhhlqYa5bFCu2f2ZumDar4GBAx48QAdrxBva4f8rnqjsI5H3DRRZJOblpCO
         qAZqaS0Pu7OlA0Zl5Tdmy4hhrMP4ZppI97ZALLTFge/X/O0/Rb0UHMoxXP+xKrbM6Ekf
         SsO/XeZavH4UGk+YxObjYvtrsDM6OUFjRKRS0pRCk/AHFg/o3urMlgAnhc9Vd5JsMuA8
         l762I+UBcepwPsN86+eBJM2zODHmhoxV4C/MPR8dPSj9Pb1S4HKZQCw7Su/hUhnNIIje
         qOkuxbS/WsEsjdf23iMEGxAjBDUvs7tXtZaF3/K9LvojxhBGvei+iIhYFSWKTvRa8Uyz
         dDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420166; x=1781024966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n2TkN12qK2IJ7MEU6lVCJRDKh5l/P+Za+C9ZbB5kjM=;
        b=mn7qze5B1pL32dT2Yxp1kwv/DA65+Z8B73fiINkfOAlvSqhnn2KKGo2eOTy+1lvRCp
         gyXv1AFYcU338W4Bsh3FaOQI6ScVuxiZN2gUk8DEkTwc4bng+PYL0k4YIBhfhmjnqGs4
         6EIdn48bRYHL8sSD+IaPgy93nmXQFCbYtfC5VSUYpGsFMJt4dsUQbdKl/Hn1oZZRX9WE
         7kcdaXo6ZxJmiGBiqboHxHDK6sOw5XS7tVeoEcAN+BJ4+DoSftsjCfK7/7CROz2dRLdd
         l+6qogaJn+v+ztFTIN5vfH6HNQnwjuIdo339r4b1+AI08Vs89l3+XtHFkR1J8XX+n746
         6+rA==
X-Gm-Message-State: AOJu0YxDIEnNEGros5SGDialZ6riTCq+XCC56vhauVydlQPKrefLWSc3
	AGy5o3KvbzG/6ZCUG/sRdobtkv6RETh0bhlqYs8hs2D2CD5SL45HZKsnOo9Z3ApFvdkOIyTWj8j
	pWl8U+A==
X-Received: from pleb20.prod.google.com ([2002:a17:902:d414:b0:2ba:856e:d046])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc43:b0:2c0:a555:80e6
 with SMTP id d9443c01a7336-2c0a555946cmr154631085ad.6.1780420165710; Tue, 02
 Jun 2026 10:09:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  2 Jun 2026 10:09:21 -0700
In-Reply-To: <20260602170921.1304394-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602170921.1304394-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602170921.1304394-4-seanjc@google.com>
Subject: [PATCH v4 3/3] KVM: selftests: Add guest_memfd regression test signed
 offset+size bug
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a regression (and proof-of-bug) testcase to ensure KVM rejects an
offset+size that would result in a negative value when computed as a signed
64-bit value.  KVM had a flaw where it would allow binding a memslot to a
guest_memfd instance even with a wildly out-of-range offset, if the offset
and size were both positive values, but the combined offset+size was
negative.

Use "0x7fffffffffffffffull - page_size", i.e. "INT64_MAX - page_size", for
the offset as the size of the guest_memfd file must be at least page_size
(KVM requires memslots and gmem files to be host page-size aligned).  I.e.
"INT64_MAX - page_size + size" is guaranteed to generate an offset+size
that is negative when converted to a signed 64-bit value *and* honors KVM's
alignment requirements.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 246bb408ecc0..2233d871a38f 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -345,6 +345,16 @@ static void test_invalid_punch_hole(int fd, size_t total_size)
 	}
 }
 
+static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size)
+{
+	int r;
+
+	r = __vm_set_user_memory_region2(vm, 0, KVM_MEM_GUEST_MEMFD, 0, size, 0,
+					 fd, ALIGN_DOWN(INT64_MAX, page_size));
+	TEST_ASSERT(r && errno == EINVAL,
+		    "Memslot with out-of-range offset+size should fail");
+}
+
 static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
 						  u64 guest_memfd_flags)
 {
@@ -456,6 +466,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 	gmem_test(file_size, vm, flags);
 	gmem_test(fallocate, vm, flags);
 	gmem_test(invalid_punch_hole, vm, flags);
+	gmem_test_vm(invalid_binding, vm, flags);
 }
 
 static void test_guest_memfd(unsigned long vm_type)
-- 
2.54.0.929.g9b7fa37559-goog

