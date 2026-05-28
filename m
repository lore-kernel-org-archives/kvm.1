Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBE2F3C18
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934284; cv=none; b=s28npsnT7+pqMdMYTiJXJdQZUpsdNK0SC3wYd75anBBzYMHcbdqbm7YUBFqRrucn+Z+QzOCeG3ay1PYtHJBf/1Z6e48jyERqEYBPlwV9f2QImkePKWA49tF2O6ISbuCGzbSgUjX0/K1PiEne7LGWDyWpuRX/5CVYVT3j6h4T00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934284; c=relaxed/simple;
	bh=OOoGlX9f6OSAiQ3GyqX+LpIZQEspF/7CtixMWwK8oVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzBLVW2hv04DRHgs3EDarh3LQScUs/J+suFSEAb44Mk7ia3d9Y669JzOuLRndqnpw/rcE2IcV3qfmGr9yLjT/lJg/Ew0ZG0S5/Nj4NoMnHtu/PBwtIg1nw1pJHW1kzW3vJDyXfebz1gG+fD5/l8HsWvhQeV0iqjt1v6/YrFXnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXzG6kJC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXzG6kJC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso17700222b3a.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779934282; x=1780539082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EY3B0s+cLLSBGjN5PAA77gPX+Mj+wDNCxr2wXa+aBFE=;
        b=tXzG6kJCnqz0OL1shbPreiipKyflvDboCmnwRjPfNHTfMgghxeQLl5+5Xvm+WH9o4A
         mlMFcbyoy3vzyGM2GZ/r+a8c3jvppu/diIg2Q42GZ5gX0ZzDPiBRFRsnoJV7D1XPoAgn
         GCZKlXBOApvVi1H9znvMXhHOdB/SAOtJ9oPysOvcqJbXlIZ/7uIRnvAsQWbkLvSyWpK+
         6tnUwwlDv37RDbgV+xjBFyDCXA1NT5K9f2U4PnbP26NQx+YONgLn0sRaOCK539dz3Gtk
         znzUXaC+ofRbUhVZS2bUCD4easZrwVCA2cji3Tdy1xvYnI4z55BVSeQoMXDULbhGvLOq
         j7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779934282; x=1780539082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY3B0s+cLLSBGjN5PAA77gPX+Mj+wDNCxr2wXa+aBFE=;
        b=gf+QLYl4aW8N03G0sgVD8oGBuoohPxfz+1a5DPWLeokXefPABNnrMydZH2u2IaTZ5z
         C+bRUo3OhBsCTi6EDjqd7B5hZ/IohKj5BH/f2wiAnBD1oJm9A5/cLzGu9+l8KTXbi6NQ
         qczxDQgCm2jMSeSXYG1HZGHl7WScz3ntcuozpqDIempg0EZuGXNSKRdJDGby6w+oNjNR
         weuaRfJ4nWOLRC8Om5EdvUISIXo+cIxw1sHJ5lG7JtQ4/TUoJ33Hi7drgf6UCYRsxUGk
         TyjXDnZm9nUgGCdUN0KMeENF4z4ekRS1MfexmJC/vKky+vM3XTcDko8124XtEBYPQifY
         S8+g==
X-Gm-Message-State: AOJu0YxaEf8syGbIYevNZXoEeo0QgKhnbMt8TDQrYzkvHJ9Wgjnlb3/f
	54t0TLl6KDQYL5G9hO43kGdm5Wvx1bg/YHGP+QrV2FjJcC6lzSyAmaUFIx4M0PP0rQzHQArAY5z
	EZKolXA==
X-Received: from pfau12.prod.google.com ([2002:a05:6a00:aa8c:b0:83f:24f:2ea7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad02:b0:835:45bf:9659
 with SMTP id d2e1a72fcca58-8415f37e604mr26029378b3a.41.1779934281643; Wed, 27
 May 2026 19:11:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 19:11:16 -0700
In-Reply-To: <20260528021117.107984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528021117.107984-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528021117.107984-3-seanjc@google.com>
Subject: [PATCH v3 2/3] KVM: selftests: Expand the guest_memfd test macros to
 allow passing the VM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Expand the gmem test macros to allow passing the VM to testcases, without
needing to plumb the VM into _every_ testcase, as the vast majority of
testcases only need the fd and size.

No functional change intended.

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
2.54.0.794.g4f17f83d09-goog

