Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB431FA859
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882429; cv=none; b=hulJtJaxNQ6iik5G+hzkGmUsoaQQr7jDmZ+sgJYCm+A+wIQJHF9CU5s7W5McVg2O1+xWLQ8imX9++KzjH8/v5ojFsUvsBLoI43RHB7wUnmnUiF+0JxUiltmjQtOfSymNOegohVmLFEbK7J96sHmdCw5T9LR+/t7UBtIZWzGkX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882429; c=relaxed/simple;
	bh=rMpl6zJE8LIlALfkumz/McJQE6oSytsbFrYL8PD0nRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NItQgTgMxbJzxJFL19XCmoIPcAuibPDAQ1gowqnB0NDPyqJyomF5y7orDEyZN0d/cgddu6f7k/Z+KTvfhbc/HL38z70LSgXBGbdVob3LGjndxQsjbl72kKLiVhE2eM0o9BvC3HSueMz7A4sXJjMLzOXerMhqydsrOTS6i5UEi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HduAKKD4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HduAKKD4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso2566948a91.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781882427; x=1782487227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8+cVPUrTar714s2C43zoZOlLtXJp8h9CqlUBsNQwWA=;
        b=HduAKKD4CYYpY+3OyAZwBDzQQ9sXpCDVyCKQEs1w4HW6v/vzQaYuwlqwcWyQpUtWkG
         I4p4WG/B6O7F00FewnZk5Av3KpslZHZ/A7bnubhSmb7FcvwEFDMiVx2XKeOCSVhxjEFi
         TYEYMbhuUMNdL+AL+NunrTjdZxTTk4BB5Tphf+kIESJ+o9KEgBE042ibcwb5OjJ7b/fp
         aE3aQd60iSSeln9JQiw5M+iKmsk8bkTWQ6NYIE6xyQ1n/SeDkF8eQwHCknl20EwqtiE2
         kq2WqXQbDz2B2ij7T+0ZFMz19qVNfqSoQfYSxkZR947ZPj8LEv72MWvyjhdwkXiYaQwo
         aN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882427; x=1782487227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8+cVPUrTar714s2C43zoZOlLtXJp8h9CqlUBsNQwWA=;
        b=kdS1dAsH6QeFemnVHnDds4wPvUHDlXkVlqaPiib6uRa5zbIVUVZdwuGzV1ycKEKCtx
         e648OzmTFWa3o2gkcYDhJZwwKYIG+kjdt64XkWrczqJS3csPqon3dgfqBZFZMREYCwfN
         t8quyd0kPIQxIZ1FtJXcmlFeXiz8+gw4h9qjqx/XS9TVge1dAKdagmdXBzNcEFjjq1pn
         WgOAissJg56yj1RK0tu/jX6RWksslJHgRwfUzM/q1AxLg6fuUxiBgi1+1dEZyxmykdBb
         2z+telXmCyiIIi+CbHT/bdKSoftfkModENnAh9YwZ2Hj+akk/lD3wpW5H62DMLvVs4BN
         DOfw==
X-Forwarded-Encrypted: i=1; AFNElJ8BIOARHqYRn5v9B+NR9KnvmTaqJgtTGqP8xlLgaMPG8V8bjluF+7RKdDGdh09dRa7gyfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+8kBKlQSSqQVBUltDMN5wC9XJzzm8tT2GP44kLLkbzdcC2L2
	ITiJbaqS6TfzOBrU+KWCAZ5KyO0LC/TH+iH0It4W2gxparMVWOefYX3mLESQDfC5JSw9tNK1O/P
	QviGzb6uYVYLUPg==
X-Received: from pjbhl11.prod.google.com ([2002:a17:90b:134b:b0:36b:ac0b:8c3b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d644:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-37d15dc1067mr4398703a91.1.1781882426804;
 Fri, 19 Jun 2026 08:20:26 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:19:27 -0700
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260619152006.3684428-5-jmattson@google.com>
Subject: [kvm-unit-tests PATCH 4/5] x86/apic: Introduce pv_ipi()
From: Jim Mattson <jmattson@google.com>
To: pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract the inline assembly hypercall from test_pv_ipi() into a new
helper function, pv_ipi(), to facilitate code sharing.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 x86/apic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/x86/apic.c b/x86/apic.c
index 65198ecfb3c1..eea0c8d8e0f9 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -638,6 +638,18 @@ static void test_apic_change_mode(void)
 
 #define KVM_HC_SEND_IPI 10
 
+static int pv_ipi(unsigned long a0, unsigned long a1, unsigned long a2, unsigned long a3)
+{
+	int ret;
+
+	if (is_intel())
+		asm volatile("vmcall"  : "=a"(ret) :"a"(KVM_HC_SEND_IPI), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	else
+		asm volatile("vmmcall" : "=a"(ret) :"a"(KVM_HC_SEND_IPI), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+
+	return ret;
+}
+
 static void test_pv_ipi(void)
 {
 	int ret;
@@ -651,10 +663,7 @@ static void test_pv_ipi(void)
 	if (!test_device_enabled())
 		return;
 
-	if (is_intel())
-		asm volatile("vmcall"  : "=a"(ret) :"a"(KVM_HC_SEND_IPI), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
-	else
-		asm volatile("vmmcall" : "=a"(ret) :"a"(KVM_HC_SEND_IPI), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	ret = pv_ipi(a0, a1, a2, a3);
 	report(!ret, "PV IPIs testing");
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

