Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0755155757
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727100; cv=none; b=NkvFJpiYV1drKcC9i3xBSXJAUltng4QcZM8u1M/Oi0s77FZpQQb7S08T8vyjIxv8KIrzBwf49Lpu8/65fS3Busx62U7XT49l+ITB6l76mV/zw0QYdKHaaC53cGmGHDHahr+yIdJfBB02hj5w9dYHTr5muiyoK8+UbukemUEG9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727100; c=relaxed/simple;
	bh=A7IRWuPMCa9/K6ayW7GZntUsPEZAJO7D1Iq8/qQOpAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mNR1srnI1ZztKVrO/Bvjb1uLXFI/O67Z+qJ85CVg6SbJxPUzTQniajD6Rag87El/bAfX4tgjFSGauSGOlPeiUwAU+c6e3Uaf+IV+FLV8GVOMsfbR3SSGOWSgO7gmxO052nT0wg5fYmpAUb4VTfSKKo0vdvib0Cx763bTsIyn15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZVzMVzj; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZVzMVzj"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso8180049a91.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727098; x=1791331898; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jH3B8GV0tS9VtL5MIP+jFUJJXxCC4SF+dpbD+h0RZUM=;
        b=kZVzMVzjFdLJdtOCRKU/JAQJ0M/wwktoLGDeQIR15WParOIVG+ro3AlRwihjNQZRzk
         lH8Y3JrRBD11GWNeetH2RpmH5LxpHriUcWmq9KA2tPMGr6E2OgkhZZskLosezTmE1csW
         Ww7llXb9J5SEpXNJW+OAfHNic9PKCiwYVIiTwv48vzIqIP2KgUhkPC47eAKeZWK8WYR1
         yjJYgzdR8cXIdrNO8kEdDJPvbvhvQ3rg9Y/x4LzebcyI52bIw3b4dFf3utMQopMnURLN
         WYGsVP64AqxkOzJh+Y08AmNaKuUohxRj+6cvHVXiS0ySueUW3GZ7w7xNLPeh5R+8ZRN7
         qiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727098; x=1791331898;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jH3B8GV0tS9VtL5MIP+jFUJJXxCC4SF+dpbD+h0RZUM=;
        b=gZLp49VxQPA2UNO+LnCbmlOY1wpj2cdmwg3Bt51Mtg7ao1PZe/jxytNBFu4I2NChwI
         Az9yVX97SAqAZkxf3/jXZpOIJfnXGpHaEObazLQ7QciUNwaz0qjTAqJXyKnoZYYrQ7TT
         3DDOaw+3wQQv2klWHJehx1J09zTViB7n+qwAVjlBwBSFraa5yN0kzK5tn5PZFAQVVZyy
         /oLOWDtF40oe9NiQr1RD/wDagi6RvZcYgIYDTuXyceR+NrWiZUvCJg3RRC8LuXT6QkPz
         43Gk0c1KbEveuK9bS/VYAX5Pg9oJCeCJkawhhnZaWIghtBioJg9SszYCTnh/zxn5WKE/
         5jyA==
X-Forwarded-Encrypted: i=1; AKwUvBxcplVk1nsqSZNhhl+km0KHR3Y/1rDhf+zt+zdZjZWIjss+3xjfLM4JaO0f052JGdbyvQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCzdsyNCzW//m28U6YOIJK23s6/u/T3CiQESk0XRMx0lORM3GT
	Y5ZcDcMqFYUQozvf4JmDoY2ivOM3VYsv6fIpkgl5TdL6H08/lMbsnO/qnSf49UvPcUQNOemC3+q
	E0on5nA==
X-Received: from pgdu24.prod.google.com ([2002:a05:6a02:2f58:b0:cc7:d188:3fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8e:b0:3a4:ba95:5731
 with SMTP id 98e67ed59e1d1-3a4bfe553d6mr786254a91.36.1790727093138; Tue, 29
 Sep 2026 17:11:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:11:27 -0700
In-Reply-To: <20260930001127.3170009-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930001127.3170009-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: TDX: Ratelimit the "EPT Violation on pending
 acceptance page" warning
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Ratelimit TDX's kernel logging when a guest accesses an unaccepted page and
has opted to disable EPT Violation #VEs for unaccepted accesses, as the
pr_warn() is trivial for a misbehaving userspace to trigger.

Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260923164348.2DB2D1F000FF@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index e3723f1222fc..4cac43299851 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1937,8 +1937,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 
 	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
 		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
-			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
-				gpa, vcpu->vcpu_id);
+			pr_warn_ratelimited("Guest access before accepting 0x%llx on vCPU %d\n",
+					    gpa, vcpu->vcpu_id);
 			kvm_prepare_shutdown_exit(vcpu);
 			return 0;
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

