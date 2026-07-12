Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8236BCC3
	for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846854; cv=none; b=e+Jh/4HbpiRlOFlab3JF88hcVGN8WG0FlF3GZo3tfWx8+DzJ15JRquigsMmqwGjY9tmKwpaRxZWxqibKOWD9P7ygPOcoO//U1mVgHR0gHaUKij+zBEh+72Z59UuxkKVukLtdv/mU5dykCaRojOfOemijXEm7djSnBQ1xRBcQ6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846854; c=relaxed/simple;
	bh=5WdJpF05mXgMFI3REZfS7otqxKxE5jvJ9kZHgW1xNjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrsFVOGnZAE/8vQg9IGGEzbq8PFbJ/IfwcuRr1x4074aNng+YN3ek5CoC5ijbmC5Degpqad/raPAzTUHgEmJ6d4psR+BQ4hNaWJYhi+ljbANCmy4acvDi5CSNV29+6Jl5f1cke1H4RHFXnWmrwxDwLafMxAmHTiD45Vd+zasj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaA8wlSS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaA8wlSS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so22014565ad.2
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783846852; x=1784451652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2z0NXTQ4WspU6NiaqWleR3H7oNVIjIlwseGetO8dygU=;
        b=YaA8wlSSSXJQAvWRaDaavbMAaAZ1Sj10YrpBX9bkgxEc+FCdGKTF//7Ml2ZEQGSyzJ
         /F9rdo/G2aKQhESM+964Gwq16+HmDt5Ds0v8r30fiIkdIVvmWGSewSkqlIndhkQqIL+h
         Ot0RTjHXFCopWJGZ+EqL8YgkeBoDaKdwO0QGRB7e8FkFW+gGAbn5KICGV9boUEPISUks
         7ZJ6ieKE1oVYYHrNH0s8AtXyWydN3sJU5oXe07+JQs+VeMYnVv64Xnx0yBgBjQpyE/v6
         rQFFpfOn0hS4ZKOiZI/iShmFAhIsmiBKjXo2jt3k9xknSyl25dtZgbANVHZ7f/UUsIkg
         Is4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783846852; x=1784451652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2z0NXTQ4WspU6NiaqWleR3H7oNVIjIlwseGetO8dygU=;
        b=YHCpTIp5MbnIqR9JPjXIf2oToxSHwT0HSceBg/LMEf+W8qZNl6UnUIP/WmYmE8RDaE
         RYH9IIKf0B2mNHhOBhP+jLaBlCbxeZ1KGPUy5j0o9L+7iOc9/PsDA5sd1j2h5851nMfy
         HsturGRkjizoN2TzUi7StUQSjbKj+ZN8NbzND44t6960aCsNOj57sz27uLTtArQ93mQ/
         EPw4Fe5quEQadFya3+puGoUF3sBkkOS2tM7EhuSMcsRovQwIwZuNHfYaT+puJr2xMyoE
         pFPYL+EpeEA9ufAP0VO89m+361tTmjhcy9eEBtzOyFqp35908hwbrjkUPz+KnydA3zMn
         0V/A==
X-Gm-Message-State: AOJu0YycWFTQ5+cYw8GGz9srpAVdp08vVOLXeZkqH9BYgyDy9ULZTadB
	+hdYTQnQex+hg9RqyB2uaYdm+NOyyH6yO5cHrOOsfwtbzq3jgJA1+VbP
X-Gm-Gg: AfdE7cn5rIJU1TibGLiWClGUmOFlx9ntak0OGKaK7C/lHf+TBBbS7dmaekUiMpzwcAj
	RGKhkFcYa3v4vo0DRX6Dp3hZDKqWi1SojzUjtsijw0Plu9PpZNplR+NmupwCbxsarpT2K/cNM7m
	7YmnOvWfuBlROYD9oZsZMjtgcnbaFUBzuJysLCM+BO7s63CXl5VUFpiXZ+aewEMhPOq+36M7kR3
	XGMaJAlJOlsO0Vz+s8Ph5qdllyZ1McUdg1Pbru5DhsDiflnYZVzaEi7SZWJS994AY90ukoZlPRt
	BnsX4aKR+hRu5Taxi/p66k6LzwqTeuSs3ARa8wJ1ZB1yyhdlbZ46rJKCS6JzUJmzvLAiiw3+xr6
	GpGPL3J7cmk6Hba2ykI8ycJ5iutPo92xdkrA7sNf0z2hv3kBQNal+OB+jMe0iUVbXVVsQqqUYB8
	8/QR9u7ARsoxRWLTHe0F3V1dgJNh+SG6UoYYzw3l/NBiknPUjObY9lImC1EeeYyh1HE7CBlw==
X-Received: by 2002:a05:6a21:6e4c:b0:3b7:9c18:c681 with SMTP id adf61e73a8af0-3c11063219cmr5454526637.9.1783846852155;
        Sun, 12 Jul 2026 02:00:52 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:a539:da8b:1aa5:412f:1c54:710a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9081d5c3sm11920181c88.9.2026.07.12.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 02:00:51 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9dcd0a11dc9703a49511@syzkaller.appspotmail.com
Subject: [PATCH] KVM: x86: Handle -1 return from kvm_cpu_get_interrupt
Date: Sun, 12 Jul 2026 14:30:39 +0530
Message-ID: <20260712090039.36038-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_check_and_inject_events() checks for a pending PIC
interrupt using kvm_cpu_has_injectable_intr() and then
fetches it using kvm_cpu_get_interrupt(). These two
operations are not atomic with respect to vpic->output.

Between the check and fetch, another thread running on
a different CPU can call kvm_pic_read_irq() which sets
output=0 before taking pic_lock(), making it immediately
visible to all other threads:

  Thread A: kvm_cpu_has_injectable_intr() reads output=1
  Thread B: kvm_pic_read_irq() sets output=0 before lock
  Thread A: kvm_cpu_get_interrupt() reads output=0
  Thread A: returns -1, WARN_ON_ONCE fires

The -1 return is a valid result indicating another thread
already consumed the interrupt between the check and fetch.
Replace WARN_ON_ONCE with a graceful goto out to handle
this race condition correctly.

Reported-by: syzbot+9dcd0a11dc9703a49511@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=9dcd0a11dc9703a49511
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 arch/x86/kvm/x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..36bf479a1164 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10797,11 +10797,11 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 		if (r) {
 			int irq = kvm_cpu_get_interrupt(vcpu);
 
-			if (!WARN_ON_ONCE(irq == -1)) {
-				kvm_queue_interrupt(vcpu, irq, false);
-				kvm_x86_call(inject_irq)(vcpu, false);
-				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
-			}
+			if (irq == -1)
+				goto out;
+			kvm_queue_interrupt(vcpu, irq, false);
+			kvm_x86_call(inject_irq)(vcpu, false);
+			WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
 		}
 		if (kvm_cpu_has_injectable_intr(vcpu))
 			kvm_x86_call(enable_irq_window)(vcpu);
-- 
2.43.0

