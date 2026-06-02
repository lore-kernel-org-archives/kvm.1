Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9373F54B4
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420166; cv=none; b=hL8IA87DfTlSihNRA7WhypH92LvNZRg2GHCyALX6ZDmu5d6ENONFxrNVJCtpyXDoyJViP1zZ80BYdrwbHxC7PbBpiMjf/eMOPcMTrvP7KWviYFpCB6Co3eeRJ77V4vpq7o6ovrsDKrGdlTif65VOuS7Z68ShblGg7zoGeCb9CiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420166; c=relaxed/simple;
	bh=3+kPv4TtW7jLOTZnSIcCHyq3wuntZsLYR6k0NapiTMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoyBIJl+WwW0hXLjpP/DO0t3/5p+Uw6ynGIz9UtGZPCyPdKwfWFJ8EWHyacqpsiKk47oPG9ALVnshRdus7z8s3m2NzNWsorWgsSN9vWswJhwOnJeJlP/bSEUA6bCGrs209DUNLOBUFzIF9AUpXY28SSm4EQCsvnMuMSy7TVJuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfyrqfL2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfyrqfL2"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b7f696b40so4775143a91.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420165; x=1781024965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8XTH9sU+N1YcSJPVOqX92NX4GFcg4rYmEDALS4TBQ9E=;
        b=jfyrqfL28VgIfz8b8gRfFgCoyf/7f59MgOwbUbVEDznqz1Shz/PnSNGPwW5Mh1ACY+
         gxGvtLNey/uiawJ8lzYHYQlBOSQ/k9My+PZxaQwnMsw+9crZi64xhjllg83XtC/1QArj
         RAxwWWlWrWzzJX/2RcnqUPKVmKYkYy/+Ctspw4S8IbmykNlSQR28NjmEg65K4rXpw4pa
         pbD/t+UYexR13gud2nVgcyThzySe429jyQT8THfrBUH8o5j6wT/Pa5ARssyw0cOlo3yi
         BXq/cGRQMQ1Rg0631l4dkU9aWA+UGV6ZfJnvEcnnC83V7ryohxPE4z+6QaakEUq580ZF
         dvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420165; x=1781024965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XTH9sU+N1YcSJPVOqX92NX4GFcg4rYmEDALS4TBQ9E=;
        b=WEnwelflhi0ixY5ww8TvDbMe1a0mIkslGdEZ79Y4Z7TX5UTdmW+TTzoEB4rkJlODZj
         Oa63yBrNusIz6CjQMtPg6CDlj0GvpZgIz9L5fQB5gk0/aJOlPfCiNOSGSPzv+oJSvBEL
         7nmSCkHrKk2/BzkYsW8853wRaRVZsqkrpsQ+qny4DP+UwAA0GQKXpwwwi9GKZDi8IINy
         6icaxIeNczw5g/1tPGLJ5dqqXoxbMWoQIzIcrR0kWRwmhGkozkW1hz6vNpcKgYP58mn1
         1qfmgqnJiqWxDHe0YMeidGYzE67vuqZuMBdiiyczZW9Q9HmSZRHgpW/ib2l1Z3gVfZL+
         4fzw==
X-Gm-Message-State: AOJu0Yw/z42U72c070Xx4+eRkL6C9giUL7D+fHek/2TV5tZwCrqx5hTG
	KGSd8vhv2FgY5rz2nw6dwUCG7Q9jTkjv+NFma8uNBPlwmnnPTtv8//ZD4ogy8f8tXff8w0mO6eM
	9VJe59w==
X-Received: from pgnp18.prod.google.com ([2002:a63:7f52:0:b0:c85:a9c:435f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58a7:b0:36d:5dbe:2a0d
 with SMTP id 98e67ed59e1d1-36d5dbe2d91mr10061468a91.7.1780420164631; Tue, 02
 Jun 2026 10:09:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  2 Jun 2026 10:09:20 -0700
In-Reply-To: <20260602170921.1304394-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602170921.1304394-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602170921.1304394-3-seanjc@google.com>
Subject: [PATCH v4 2/3] KVM: selftests: Expand the guest_memfd test macros to
 allow passing the VM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Expand the gmem test macros to allow passing the VM to testcases, without
needing to plumb the VM into _every_ testcase, as the vast majority of
testcases only need the fd and size.

No functional change intended.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 832ef4dfb99f..246bb408ecc0 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -408,17 +408,26 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
-#define __gmem_test(__test, __vm, __flags, __gmem_size)			\
+#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
 									\
-	test_##__test(fd, __gmem_size);					\
+	test_##__test(args);						\
 	close(fd);							\
 } while (0)
 
+#define __gmem_test(__test, __vm, __flags, __gmem_size)			\
+	____gmem_test(__test, __vm, __flags, __gmem_size, fd, __gmem_size)
+
 #define gmem_test(__test, __vm, __flags)				\
 	__gmem_test(__test, __vm, __flags, page_size * 4)
 
+#define __gmem_test_vm(__test, __vm, __flags, __gmem_size)		\
+	____gmem_test(__test, __vm, __flags, __gmem_size, __vm, fd, __gmem_size)
+
+#define gmem_test_vm(__test, __vm, __flags)				\
+	__gmem_test_vm(__test, __vm, __flags, page_size * 4)
+
 static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 {
 	test_create_guest_memfd_multiple(vm);
-- 
2.54.0.929.g9b7fa37559-goog

