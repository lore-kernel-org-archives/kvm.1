Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B39322B88
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186080; cv=none; b=T0sNE06SQve0t5H3QJjILtSPtEhhRs1JkLfA6D4HkCIohjfia0aSXbdA9W9d2DOYTTcp7Ex0F+3qnhluZfbEo4A3bNKIUqZ++c0gBsUaFmR4cAARYVJ29R2Tsh35jA4lCKZrktJ/AHkHw/tlllNC6v/xjvETnuCRvRgsjDIEB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186080; c=relaxed/simple;
	bh=GOjFoV94awk7GYninYEq+I3DCtzIDlhYvlgo8SkP+9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N787zwr/yEhGSKMtxxHXsl8q+xk4aFKXTYVjQoKhPccfDOl/MKUav6wmVSfX2FRAEMGBDCGJHn1N5x187ycRhQwbCUQeszVEtjPpjy/GSpN2fK/qwsV6cYK99/aJBuYGvNUgvCGxR1XN1ro9WSUZBBpZgbC9TItlyaHUX6oTFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axqqEJNO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axqqEJNO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3662eec51e0so344584a91.3
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778186077; x=1778790877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwdqijLGyLJ4WnaXvFgo9eGiQSeu4QsrqPYNc8/yMrg=;
        b=axqqEJNOhE9jSDrsvB/sNgxY5KKC7KwPN6q783aLHD0TZNub06H4qJSO03mHEcbnxM
         MYHI25A/3eg+g4vl4SRV/wy/Qiyp1XNnpif/fH5OKjoxr6gT0Le7BCovUQCaq0j7w3yS
         0oT1TLZ8orfGWrQlJ3o5QEo2spJN5y4AmjZ2oxHPh31ypSiDoIyr0/KkLRnPDMp61pJd
         +zIQfnn+YHutgtgDCv/PPeecKQkaetXfIhYw/xqXq5P0A+n/FLr/x/7xNtOR7Wa0I4i3
         MIaw4MAN50Yu2x17+dV2+oU6NsSBd4xK/SpLy0NSBBw72GEDUIxTM3wsE0hvJLmLTWcp
         ezEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186077; x=1778790877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwdqijLGyLJ4WnaXvFgo9eGiQSeu4QsrqPYNc8/yMrg=;
        b=pkyPZlFj0q5k+A3mMqIRCqownIgKjaBQ9N3jmykVzPLggGJ1xl8/MFZblXFQk0oNmv
         7cj5GoqO37ef91UFI9qDeBpuVIHKmskyX0bk6n0yLa90a23su+Osiw9vXRv5l8w3NvoU
         ueLlQhJmQS7l8ynRhJguzhPuC20AUAsy2qZlLhgBeaunLt/tTROaYSj6Jw6RWK2/4jhl
         lQpHEMXps/e/k3xYCnHjVS72v2dgWeGutKz1J5O9H7uBloI4JN0dWgy4QKkU4k9jqaFD
         Y1nZNVQobIok6VYunkOc0z7+QRK9ySTIfef2x59MIqZ9TLwL+u+ismGaGXhhzzsJr8wp
         Ookg==
X-Forwarded-Encrypted: i=1; AFNElJ/gp7AMQZUxCUtcAYlWxZCgTaOKg8XQtlhqYWl+mjzMJ44mrP3vjk3wmk727J4BboTpo7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshnFgDERTdatxeiTIcoyDSDEW9NvxMXsYaBONWchHTmhY0fkK
	1ZIitTvsFgu48tNb8Nr2IzcKuLrlelpq240+6/DO4dGndNu6PNKREpIkFd3dTbAja+ONf6223D4
	mZ5H4jNpeewp+YlvareubPG07XA==
X-Received: from pgac15.prod.google.com ([2002:a05:6a02:294f:b0:c79:5ec2:4a68])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:431e:b0:39f:54fb:e465 with SMTP id adf61e73a8af0-3aa5acd7603mr9313570637.50.1778186077180;
 Thu, 07 May 2026 13:34:37 -0700 (PDT)
Date: Thu,  7 May 2026 13:34:24 -0700
In-Reply-To: <cover.1778185936.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <cover.1778185936.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <b9de3cc382f0cda398ee928467147979adf9b06c.1778185936.git.ackerleytng@google.com>
Subject: [POC PATCH 3/5] KVM: selftests: Make guest_code_xsave more friendly
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, liam@infradead.org, 
	linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

The original implementation of guest_code_xsave makes a jmp to
guest_sev_es_code in inline assembly. When code that uses guest_sev_es_code
is removed, guest_sev_es_code will be optimized out, leading to a linking
error since guest_code_xsave still tries to jmp to guest_sev_es_code.

Rewrite guest_code_xsave() to instead make a call, in C, to
guest_sev_es_code(), so that usage of guest_sev_es_code() is made known to
the compiler.

This rewriting also gives a name to the xsave inline assembly, improving
readability.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 1a49ee3915864..8b859adf4cf6f 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -80,13 +80,23 @@ static void guest_sev_code(void)
 	GUEST_DONE();
 }
 
-/* Stash state passed via VMSA before any compiled code runs.  */
-extern void guest_code_xsave(void);
-asm("guest_code_xsave:\n"
-    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
-    "xor %edx, %edx\n"
-    "xsave (%rdi)\n"
-    "jmp guest_sev_es_code");
+static void xsave_all_registers(void *addr)
+{
+	__asm__ __volatile__(
+		"mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
+		"xor %edx, %edx\n"
+		"xsave (%0)"
+		:
+		: "r"(addr)
+		: "eax", "edx", "memory"
+	 );
+}
+
+static void guest_code_xsave(void *vmsa_gva)
+{
+	xsave_all_registers(vmsa_gva);
+	guest_sev_es_code();
+}
 
 static void compare_xsave(u8 *from_host, u8 *from_guest)
 {
-- 
2.54.0.563.g4f69b47b94-goog

