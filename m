Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D2433BC6
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355901; cv=none; b=P0GdDcjmhfcJipiYO3AyJdoAT5ZnoK16yEA+r4VdXhh/+q0DIC4SSF69aZz5QwxvIGzSEV6rZhRC/TlgpdAQkIL2MUxGhfrWWK7KShGiBiUE1PxrP1fJpB600YzzZvSStXeOBVvMD1Gx31F7fvGOfpyDYTgfmrZa57twN1hmyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355901; c=relaxed/simple;
	bh=UwF9jbW7z5Rcv+P0PwnoEl6y3nQ7k1YZUnxUDdgc0iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwEj0DJMPUuJBi9TQmNG2KJnrBuQ+K0TJTW5ysXqKkVC+ucDn+fKDBNOyb5aPxzEkakYazvJmwb3ixWoSlrpYzitC6RERzxbhr8y4BzaAlzrhybhgwjFnyOs+gy6KAMUjHDNq2lITMbYon4HnpxT7EX9iWF4vFSYlGR4e886nTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrZJvViW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrZJvViW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475417f010dso1791280f8f.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355898; x=1783960698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6fxd414zjbKl4/fM0nOf+lIyo7xTqgthi3ysLKzw9U=;
        b=qrZJvViWBIV2jt1efHYbAjBg4MRHUg+YIgIeq+0JIWno2qlCGf710mzw/UBZpg8ds2
         FRWaNsWubaKd1n4OH250FFHEL1qSWnMjxmZIhVuk48dRWfaDAIvEVa/i1eVyApzU1hrl
         cOPE2cxQc5/Ltk6cgqOTgl2d0ZQAzaCWB89VybEPXIakz6dUS7YR7JaomZPNDTSAf+V/
         1gqD1ISIhy1/wNeIdNYV4J/EoeV+kKWs0pbFbYEGKNMZiW5BVQndF2X23x6nYKcJAdWo
         UkBC5D8fqf51+Laai5lnK95H6pTheu5ik336T0bv5RqDcxpUimBavQU6cNtt13FNwF5V
         I34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355898; x=1783960698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6fxd414zjbKl4/fM0nOf+lIyo7xTqgthi3ysLKzw9U=;
        b=V4W5GNnrFad1T4WyPqd1AiX1blbEpcb4aTTwDoxN4MuQcyU5hKOk2FFyJQgaLkDlVG
         634oJ4QToGsoRQV1FuCRgCxGPh/hIVZK9BNuH7wLuc6xW1RB8NkvqU9xya1iwKPiCu/J
         Jp8UB9nnskOFsRQrVBlAE8uRcVXb69Sc4OeY8eSS7KbcVt9qqDKWBmjjqXsj24CxotDt
         ojmqpwKw/aFyYilaeBmSR4vkxZIAtbYTaJi1IcKT4ZoejYQIboKblZF2DAk5D1g5KGUr
         2Buvmo7s96iHsFJE61IDitBm20UKISE+Lkz4EGZTmvl/ADG67Yi0EkNA0XJbEPjyGE6U
         swyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGcKgTEbJCaPIWTyywHcT0byHuTWNYbGALKHmA/b8mKkEjysxT+TkqKuqKpk3EFVOVKkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWGTmdSING+NSisBdAdaEvcyGAs0nHH+SBTaFiBdcNc+gbEaG
	oM0crfDigo7gwtFFo0/DrRljMvh/MdH0wW7oSU9thVedSMths0nk3YSB
X-Gm-Gg: AfdE7cn8zJfNDtl5fVAgbIHgFEbDKV/U/QW4uSBjQ2wXNHgTdl0GqEDqnUkPo10o27s
	YEiTJBWhFOfKsINBS6Mwqbb2UH/gG1JH2VxEOshcBsPuKuI4dEM8SfHPdfxc3j2F1+k3xLTeus6
	t7UbIzvQehAd/3JNlc3eBhP50HMc4zR20qSqSq9tM09j+89g4DFulL9S0NvaVCGleajUUnmF3hS
	6xQcAOSqsButTonQjKQh8D6VverZAxpmB0NWuW1yqHe4bxhaajKfeDUYvgf83Mq53rT9Op+kbfI
	1+er020muhhg0WYOMLU5atANwrPpilLKkMs7fXO3XBKnx7NeC6t3jGtE6oLc5i+AxTIuYZJuO5l
	Hb0kVRuUAimNSFsGC1CWqUVriwT+IE+6lCROMTf12SlewsjE1n36tohgyywKyeJNmd+yDN/AVcW
	fIscBS06DfsW2E8W+a3A1zQ0tUjftJ9Y0vqoMhraS8hNRX
X-Received: by 2002:a5d:6e44:0:b0:46a:168c:3795 with SMTP id ffacd0b85a97d-47de66763b6mr1056438f8f.16.1783355898114;
        Mon, 06 Jul 2026 09:38:18 -0700 (PDT)
Received: from hisam ([39.40.20.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039afacsm24804721f8f.19.2026.07.06.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:38:17 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: pbonzini@redhat.com
Cc: shuah@kernel.org,
	seanjc@google.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aqibaf@amazon.com,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: [PATCH] KVM: selftests: Use KVM's task pinning APIs in steal_time
Date: Mon,  6 Jul 2026 21:36:49 +0500
Message-ID: <20260706163649.155548-1-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Use pin_self_to_cpu() and pin_task_to_cpu() to pin the vCPU thread and
the stealer thread to pCPU0 in the steal_time test. Eliminating the usage
of pthread_attr_setaffinity_np() in particular allows building the test
against non-glibc C libraries.

Reported-by: Aqib Faruqui <aqibaf@amazon.com>
Closes: https://lore.kernel.org/all/20250829142556.72577-4-aqibaf@amazon.com/
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/aLIroyJSWQ26wnY4@google.com/
[hisamshar@gmail.com: resend, fix changelog typos; original series was never reposted]
Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
 tools/testing/selftests/kvm/steal_time.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 76fcdd1fd3cb..19a97d6a3607 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -508,9 +508,7 @@ int main(int ac, char **av)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
-	pthread_attr_t attr;
 	pthread_t thread;
-	cpu_set_t cpuset;
 	unsigned int gpages;
 	long stolen_time;
 	long run_delay;
@@ -520,11 +518,7 @@ int main(int ac, char **av)
 	verbose = ac > 1 && (!strncmp(av[1], "-v", 3) || !strncmp(av[1], "--verbose", 10));
 
 	/* Set CPU affinity so we can force preemption of the VCPU */
-	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
-	pthread_attr_init(&attr);
-	pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
-	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
+	pin_self_to_cpu(0);
 
 	/* Create a VM and an identity mapped memslot for the steal time structure */
 	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
@@ -558,7 +552,9 @@ int main(int ac, char **av)
 
 		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
 		run_delay = get_run_delay();
-		pthread_create(&thread, &attr, do_steal_time, NULL);
+		pthread_create(&thread, NULL, do_steal_time, NULL);
+		pin_task_to_cpu(thread, 0);
+
 		do
 			sched_yield();
 		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);
-- 
2.51.0

