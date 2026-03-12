Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0C401A2A
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345794; cv=none; b=Heov/kGVV9pFyRzmr4sAyatmYgHgSaO6i77ANghNuQErXmUYoQQ9Lvr+rYKIbegaGjOx+zJ8zB8pm0Y3p1mUt9XQhUwZldfi8DcHF5onFCox5WahQYQ8mrBOFKyEsuqAhb+39dqJOje1GU0T/7fvWdCjAIAA3DdSp3zqwCQmU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345794; c=relaxed/simple;
	bh=fR0259mh+52bm15BsPvXwGZOqygfHLZHvw67g2ySNmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ef1rypljFjV2rYS4eV1EXx156RMj1IqCawpkccHAx0cWH1MjsAeFsLh/TnJpIHOOomP+O+Z5DN/9KuAKpAIMmtTWBlIdgo26WWl/tbDhN+FQZWT7PmfoDD7M1i1hizoiIUtEhxISFfuWOFhUxGCZH8x7PMNHBz860AP+XUyFLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLzUGfWA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLzUGfWA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4b96c259so25853775ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345793; x=1773950593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6BiWr+0e19GGyFegbasXyEV9HIfpQMWPxkhKdKS6bg=;
        b=sLzUGfWA02Ib7jysBIG62sw+rQSVDULYPwnAcooUyaafZyM2nRmQoIGdIvIqyxvT00
         DlD70cH4tI9UdD87xno3KUxI5IJKaiZoREqDrFVbMQGhYmrrBddR5Li4jjdygnGblVt6
         nZaOhkoDWOxY2Fx8Db8DRuv2YTz7aBmiKOuIGFxiHFHepyoANCeO06idgCYQIw1gKC2e
         Iin3ZIskxdHVjdIsm+yswjGlAAzV+C7DzIjDrMWAmEvm/oxDh7QHjVqR6TA0PARa0VjA
         pLZ9YBfHaAa6RsU8mENEogxWDWtsBkJJ+6MzpLhz+2bUsZkSP/JGF4SrEqndSAetZW5Q
         7ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345793; x=1773950593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6BiWr+0e19GGyFegbasXyEV9HIfpQMWPxkhKdKS6bg=;
        b=WdgB1JZt7HXTmTZXNx+oMhxATxU0PgOp6sDdoUwfRbS1jZrcGyHuMw8Y/G61wHQ31x
         vM+3lf83JerUiKQOVwQqquJRh76guv/XPXApFeE+GCJqgy/XNckuq9PaOBQ/G/6OWlG1
         CgfQgpZWb2xu7XxsHOkkzlak4gdwxX6WB7wOXzlUrTqMBz37MzD37Rh5DppnRjS4J8W0
         Ts3+3u1krTxjK2yoChMJCxGERd5+Ig6yBAGkHycDnioeT/xJI5tC2Y6bia3Xg/HTJ5FO
         nnX8yJ4QPa0S4UCXl2RzzB2RmBhE9kIS9tgtLi6JmDMOnRVZAOCmFS5xRbnql3dJefCz
         +DRQ==
X-Gm-Message-State: AOJu0YzukaxklepHSj9LetSaFHgrcwbr71ifmjfs5nRBnePEJBaFJKVL
	DoPssGWZxq7v3q2/CQYNU2c6kiPiYNTw+eCIB+thV2pMtRTbZ3NVe7BaT3JOg2akfjFxPVmCeR5
	WzUX4Udn99W0M96UlmI9P3/0YSyAJ0OLAKYJWDjbshFr5fUWzq3xzGisG9FrMKOU89wlq8jpaBM
	7nMYSmIIssSabb8Ik/Z2BbXDOA03crPCy0o2Jlm+5hMA4=
X-Received: from plgo17.prod.google.com ([2002:a17:902:d4d1:b0:2ad:9f2a:e9e2])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64a:b0:2ae:5d90:9d95 with SMTP id d9443c01a7336-2aeca59ab46mr7533735ad.14.1773345792694;
 Thu, 12 Mar 2026 13:03:12 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:02:59 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-2-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 01/10] x86/svm: Fix virq_inject SVM test failure
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the virq_inject test advances guest RIP regardless of what
instruction caused the nested VM exit. This is an issue when
INTERCEPT_VINTR is set and the sti_nop_cli() is called in L2 with a
pending interrupt. The vmcb save rip will point to the nop instruction
on exit due to a one instruction interrupt shadow. The unconditional
advance of the guest rip will move it three bytes, which is past the
entire sti_nop_cli() call. This produces some unintended/inconsitent
behavior including test failures.

Only advance the guest rip if the exiting instruction was vmmcall().

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/svm_tests.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 376164764254..11d0e3d39f5b 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -1790,7 +1790,9 @@ static void virq_inject_test(struct svm_test *test)
 
 static bool virq_inject_finished(struct svm_test *test)
 {
-	vmcb->save.rip += 3;
+	/* Only jump over VMMCALL instruction */
+	if (vmcb->control.exit_code == SVM_EXIT_VMMCALL)
+		vmcb->save.rip += 3;
 
 	switch (get_test_stage(test)) {
 	case 0:
-- 
2.53.0.851.ga537e3e6e9-goog

