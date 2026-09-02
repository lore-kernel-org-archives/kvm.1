Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E034ACC76
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367302; cv=none; b=GjRhqVTAgA9oaRcYhW7mEB21FL+WqYzgEJP3Imlr8jkGVGE/iOGASjbFPBZPT2cXMN6lAZX6nGANOOJzb2W8TTuMs7mhdDNlbdaCyJLGtSFhrEuuhXaHPhOfVOer18ulDI1vNinRV6iiFyPIJxdpy1npoOMJCUBxWcTmNA3vAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367302; c=relaxed/simple;
	bh=UVGy0HhxZ+yDIeNG6eDI6eU+6NSVSRJ/g4F95JRGveA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSh6k9AlRZZzFqGx+Mks9N01dTgAtyWvFUzm8WYgEI/cdhFaiHxuEaRkUWkyxzcwcImhvKLplyNT05QEFZmroIj3eIkfGAZ0OQ4Po/296jHhxnaXI6KzMaBBgs0eY6pFOFnAKfVPvU3bKzbzxONRWVsygXFD1GZITLBaWUTHkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFopY9dw; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFopY9dw"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8553305b7c7so1048649b3a.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367296; x=1788972096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wcKMUlmJ0lq2oBOCUrCto8mVZjPEk4eBpEgiK6nEFRg=;
        b=pFopY9dwt3xSCt9Y5ua9ISiGOTBWCuZGAAOtCNEaNpOB6hJ9uOkqiJjQupd5LT9OEK
         PpTm595a//ta9ZSpWaKORr9bTKStFzH2ky4pWMYKEBI3cGt6SJDLZGc9WqABiIQdQUI6
         2AdSeR7sQeX9s30zeZ+mhNLrKLujdQoWag9kxsZd1c5Xf47JmNf7wuiqP52r0J1+J+3s
         KZ9afw+lM+ehSAflSJFjArwxiNbKPIzjTXQM7Wx6aJKoF3uwv7xFqfAW52G9GnMra7tC
         vIMiTzhuuXptfjJHVlmJfaMwKZs44OtSmrOvE8S5baQgNrs9fMR1XGEz2LGklymYsE4k
         DOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367296; x=1788972096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wcKMUlmJ0lq2oBOCUrCto8mVZjPEk4eBpEgiK6nEFRg=;
        b=ANNI7OdpEq8kJW65Gh3kMEO/fvVv99muzca7G+lkOmYUVgKguGVI/Cq9O9iIbdTvxZ
         p9OoM3+l967XADPAGM7ZGeuHx2WaVnhZMx0fhKkeq6zJ3aqe4B+0tyzzY4SjCQRah80p
         0eb+h10M4eMlaqOjcfjda58387rh5vRlvJaqWPhWqjueEDV8OnXJsrsiWse7TJQYPEzU
         4LMWqosvy+gVBkolS63QTKxTBywH6UyLnbDk0OdVDRuIUdq2Kwl6YkEPma/RlWnbuUkh
         yALOenKNkTNsl+l57+FPNTLbkg3/59R5Bw5IkHhth+fCS8q3PzLRbFrjtRvyzz6MfcVJ
         h5tg==
X-Forwarded-Encrypted: i=1; AKwUvBxz2Ogl/TuxN+iVK/kN07zW4Dj+IV1J8r63IDtOuOK3tPFr3WjJtZshavY55XgzZya1xgU=@vger.kernel.org
X-Gm-Message-State: AFuF++maX8kmhpTMZwNCvTuI8GveXoQ6UhlAhrVVR5/UerKHJ2Q89t5b
	lQ2DFQRgADg4F3ijl7Henj6vX6gPBG1ma6Ik1wDEUrCPyQUcMee7np1b7ccwdTRvy49fhQHEvUD
	UVThHIg==
X-Received: from pfbeb17.prod.google.com ([2002:a05:6a00:4c91:b0:847:87ec:2a9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:997:b0:84e:f90e:492f
 with SMTP id d2e1a72fcca58-85ed25e06efmr8429625b3a.7.1788367295680; Wed, 02
 Sep 2026 09:41:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:12 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-10-seanjc@google.com>
Subject: [PATCH v2 09/20] KVM: selftests: Use the innermost page allocator API
 in s390's IRQ routing test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use the quad-underscores page allocator in s390's IRQ routing test in
anticipation of dropping the @min_gpa param from the primary APIs.

Note, it's not entirely clear that the test *needs* to use a very magical
@min_gpa, i.e. it's possible a more elegant solution exists.  But that's a
problem for a different day.

No functional change intended.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/s390/irq_routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390/irq_routing.c b/tools/testing/selftests/kvm/s390/irq_routing.c
index f3839284ac08..cd26cc1aed80 100644
--- a/tools/testing/selftests/kvm/s390/irq_routing.c
+++ b/tools/testing/selftests/kvm/s390/irq_routing.c
@@ -36,7 +36,7 @@ static void test(void)
 	};
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	mem = vm_phy_pages_alloc(vm, 2, 4096 * 42, 0);
+	mem = ____vm_phy_pages_alloc(vm, 2, 4096 * 42, 0, false, false);
 
 	routing = kvm_gsi_routing_create();
 	routing->nr = 1;
-- 
2.55.0.966.g6673acef38-goog

