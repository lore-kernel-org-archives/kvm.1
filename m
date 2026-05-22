Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6869368947
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470517; cv=none; b=rXOMuJdiFV7THnBRllK5tuV10Jgp8tUX3H82Ui8RETKLzMiWU7vxXyGL0N2FaxNTgo3HX7/N9hKifjfKf+0al/aKNbibw4Lu2EIRHbDPTsiiqdtKyQ1/eYTHOn3TBPMIN3likU8lv34333jMwkO1qKsDZtLMjyyWUlctDTeWSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470517; c=relaxed/simple;
	bh=ayQtNuu0KAGI/GVpUUq/PzEm+KPC5bq0/iohzWO2RXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jY7u2jm7jGfJQ6kczfOIpeAUtO7EH0Vs80M3tL2nlgenrsITnHMU/1p9v9B2zePkmX3BrLq7rNtUvHBx7pmuxOW9VLghLfCg3CbZFDS4EcOIpyMyv0WRKPViO2dmsqHoPMTvhXN8YxPIe2g4ieNlZRihTurzkttQqBldE1YQlYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVSufxdN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVSufxdN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so1411030a12.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470515; x=1780075315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yzw6ZBZmJ6GLsKKeZffOS4D7Mu6oc4MX0x50fzU1G54=;
        b=UVSufxdN6A8mHOcpDPxbQOi3K0fT1Q/SQu8erU7w8b0rZIWbx6tjGMPE53cpDXvjOw
         ovznUYEx/iXb6N4n5heqnJ2Xa4Y1fnVFA1t4kxY9kK6mDDNUxxWYpWZtczEnbusjKlNF
         r88FY8evtBzCOBt1vHA1MFXVL381kSVlq7NPqS3RQUldRTq+NftWaZIfJrOuBDwAQWfN
         fiWWiIQOvvAEoRHuHVnB+kqTHEUJ7Zu7EGPR+G/LdEQh9zadQjfMsBf7HAOtfHA5O0vG
         yhIHh2/e5VgDzL/tEu1XLB+GEmVutFA+Nn1iQfBTJYEkNyDqOzr2+N592qp+e+qd7f4V
         oBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470515; x=1780075315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzw6ZBZmJ6GLsKKeZffOS4D7Mu6oc4MX0x50fzU1G54=;
        b=Qr8Kl7dhHjbkyjS+9lggZd7gMqLywX3AEeE9CMDNxm5nU6OWGo7MTpcXV84w9IcKkX
         d3ZqzZloJpt5S9G5sOhf4LkDzJTZZVorepTe4PgOTOQg3WH2z++Q1EaXCwrE45t040uF
         Vf+JJPrG+cAk1WyTE78cN4DwSRc0jmOxZduKl4RlqcogHORvB+/Wj73nkr3XO3yOVyjw
         f2+I2v08QEujHzriQHESaK/NVjHaHo1zlXM637iY3TpyLunzxbzlOA0Nt6aDN53fYH32
         WzqWkAahQZq1Sns6cGZdxvCY7UMiru3Xd5cmXRtJhoCCZ894hW0XiKGVmP809uFLhIX4
         9BmA==
X-Gm-Message-State: AOJu0YxeWdiLIR+md9qEOxx8P4gtYdTOH8oEng74QEcOde6gd/GMuolm
	9huiQHt2Ta+Ib64Gy22yctM4mMHfuXJleqe6baDOB2lcFl0JH5zXdQq653Fnh+h+C/oZqQ0Z5Sx
	eVzEf4Q==
X-Received: from pfbkt5.prod.google.com ([2002:a05:6a00:4ba5:b0:82f:9be8:3f2c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca8:b0:837:6bb9:acd5
 with SMTP id d2e1a72fcca58-8415ef52165mr4423320b3a.0.1779470514560; Fri, 22
 May 2026 10:21:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:21:49 -0700
In-Reply-To: <20260522172151.3530267-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522172151.3530267-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522172151.3530267-2-seanjc@google.com>
Subject: [PATCH v2 1/3] KVM: guest_memfd: Return -EEXIST for overlapping bindings
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

KVM_SET_USER_MEMORY_REGION2 rejects guest_memfd ranges that overlap an
existing binding, but kvm_gmem_bind() currently reports the failure through
its generic -EINVAL path.  That makes binding conflicts indistinguishable
from malformed guest_memfd parameters.

Return -EEXIST when the target guest_memfd range is already bound, matching
the errno used for overlapping GPA memslots and making the two types of
range conflicts report the same class of error to userspace.

Note, returning -EINVAL was definitely not intentional, as guest_memfd
support was accompanied by a selftest to verify that attempting to create
overlapping bindings fails with -EEXIST.  Except the selftest was also
flawed in that it unintentionally overlapped memslot GPAs, and so failed
on KVM's common memslot checks before reaching guest_memfd.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
[sean: call out that the original intent was to return -EEXIST]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..46727539d08a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -675,6 +675,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	if (!xa_empty(&f->bindings) &&
 	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
+		r = -EEXIST;
 		filemap_invalidate_unlock(inode->i_mapping);
 		goto err;
 	}
-- 
2.54.0.794.g4f17f83d09-goog

