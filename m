Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385120;
	b=nkCS5tIYflP4SMQJSSdG6pfejuz6IpYcSF1xViyRyVsY5QcWWXTm2zlI9MjBzAt+jDtS
	 5tyiKo+HRINZdeJ17VJ9HXRNT/uVyMVyu3BViNJtkh8Q85UDGjSd72sR+2SisXToLSPg2
	 wsRAFPXKrdYwlpUoVsYcvByy8M8X8+0Vl+1j89c9pB4qb7CkzS32xlEvxGnkuu85ro7cH
	 ncCMtcWyoyW6agxJh3Ye1W6NVvwKYSU3BtWw4LQ7fLrHuNyOD4Yvw1CQbwOdoZyiIP0pC
	 bTLS4fDKCEdJ2iO8ZW7ofIDPPLsYBkP8WHXORSWG8HSABrkIMP17zuUdWtD4lRs93hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385120;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=VnybPefRESdO1ApreizUoK/GZcifV+vbb0Q/Cy6Xtbc=;
	b=s9PH1LDEAZRKBPDXLPxm0LDOkrFaQO4Ln38pO3iMVA5Z/THJqleOWRKkqa95Dq6sOK5B
	 YmJqy4B2wZqYJJ68GZ8O120vDCQ826XcvZX6ugvnkwidJRHSzsuFD/nRDMZimhPMPDxZQ
	 Y/19dWgmf3KY3OhnRl8qkESm6tyiE0G+X8VdN2IUasOiBv44DUUos89ndXlHSYChj8x1j
	 aDREnRc5sYqUttYBNtpH1KN/ykVILjaZ4pqJdxUbAaqRZ0WcOdqqWjXtEmP9yzNe7it6F
	 sbSqi7+pXGAo7g4K2u9qms20kHU3pHCkdXgMXfPWTiSnjwiAauZqaAoQIc0NH0mawrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+fM5pI5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4229606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4229606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+fM5pI5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794385118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VnybPefRESdO1ApreizUoK/GZcifV+vbb0Q/Cy6Xtbc=;
	b=Z+fM5pI5AVgF69envAqDKxd63bytWfQgxriHkRJfWqnyvAj4R7aephXbeuEaVZIlPzE68S
	T8jbPqIINJEnbCMuz0hD6f0B5UBn4JPDqSmJ96IRAqtd419mZaUX8dE5G7IscwB4E/aqeq
	XaVf55uYYQL9sR56HNPnA1QZvloUzfA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-FRRxnAuoMvWlrpKlhWZweA-1; Wed,
 11 Nov 2026 03:18:36 -0500
X-MC-Unique: FRRxnAuoMvWlrpKlhWZweA-1
X-Mimecast-MFC-AGG-ID: FRRxnAuoMvWlrpKlhWZweA_1794385116
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12BBC180035D
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:18:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.37])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 037C6410;
	Wed, 11 Nov 2026 08:18:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH] lib/x86/desc: Remove unused variable "exception"
Date: Wed, 11 Nov 2026 09:18:33 +0100
Message-ID: <20261111081833.69641-1-thuth@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The variable used to be the return value for test_for_exception(), but
commit 932ba2d2f530 ("x86: simplify test_for_exception trigger functions"),
changed the logic of that function, so that it is now unused. Clang from
Fedora 45 started to complain about this:

 lib/x86/desc.c:483:13: error: variable 'exception' set but not used
  [-Werror,-Wunused-but-set-global]
   483 | static bool exception;
       |             ^
 1 error generated.

Remove it to fix the problem.

Fixes: 932ba2d2f530 ("x86: simplify test_for_exception trigger functions")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 lib/x86/desc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/x86/desc.c b/lib/x86/desc.c
index f4cdfbc9..b5d40562 100644
--- a/lib/x86/desc.c
+++ b/lib/x86/desc.c
@@ -480,7 +480,6 @@ void setup_alt_stack(void)
 }
 #endif
 
-static bool exception;
 static jmp_buf *exception_jmpbuf;
 
 static void exception_handler_longjmp(void)
@@ -491,7 +490,6 @@ static void exception_handler_longjmp(void)
 static void exception_handler(struct ex_regs *regs)
 {
 	/* longjmp must happen after iret, so do not do it now.  */
-	exception = true;
 	regs->rip = (unsigned long)&exception_handler_longjmp;
 	regs->cs = read_cs();
 }
-- 
2.56.0

