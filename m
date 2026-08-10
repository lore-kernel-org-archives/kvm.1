Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5B4457B1
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402525; cv=none; b=B9AT0l2Wtbf4qLNPVmCMSk57p4MOgAXO/ueFU0/klXZdHf4aM18zjWT0vsLeLA0X84HTQ/iGAN9EhXsFKz4kydo2Aw0w7LQmVYDqssPLHmgUgGNmSj/Uz43jZnyKH1Z/OSL+F+EjBgPkxyCv5ZQRokImeNlzSN3P9F9emGG2JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402525; c=relaxed/simple;
	bh=HEa+JxnqvNvLIMvTG8Br8LXOSsVcM74pllbSgSYeaIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T5+H69qL+A7tHBTOAhlHcqQBemXpYM7Y2GvMTIvQPk6vHAjWI56WpvPR9AMnmtOJQWs6kCEnE0i/0CwKlVqFcvfm4L07YjliARN2/wxgBPPiC2TxqJFTOOdi98Q0aCSRlx1DYJL0xVTjgACd6rtqEDC06rEDGt63uRVgK3wUa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQtUMhw7; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQtUMhw7"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so2866297a91.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402519; x=1787007319; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O2Apit3dTRO/Avi3ufPqsCY55zXXjY9yvVr1aPW3ZCc=;
        b=tQtUMhw7NGiElkujDBG0t1AWlNBS2ozUJ9QGKq/lvi1TD4ukxVyMWcjg5qfRw4ShfM
         WPu1Z9k0NF6zP8YjrU/DzOzavVT/H/CJvRQ+3uD+Y3p13zpcaUqT0WscWZzdte98lkqr
         Z6jNHIJ8mLi7Fig4z//MWd/Y/v0drPBlaROBqR7sdJmOkIyRrXmzvCPA0Bau6KUnHjrr
         Vj84X624S8vvyO4eN/8WDRiVnvHLfKj0tSlCOaWgcsM0q7Mv1IBAHyadq1kOiefSznQZ
         +KFhzD6Ip8xysay25sevzxw7pSoKv5drnU8SJDIKaKJjES/Bo6z3SbKXd8gOe92axkRD
         pmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402519; x=1787007319;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O2Apit3dTRO/Avi3ufPqsCY55zXXjY9yvVr1aPW3ZCc=;
        b=O6HM1fYyZG+tyLHpy/rXFDMrKuyvoE2GkU9F5LImdkptKZhu1aq7UCEcTs3Ieizum9
         r5tSS0qmejodd84zasHMbtQgZZBlOdqIAqzHqU7q78BujPm6wRtE+Xqo/axWLX+3EIHW
         7aFNg5k4Zv6MoRW9M5PZy2MTIKbmoKaa6/EhEqhWIiKzn4cDXSknPXMMZ2n48v9Iw/UH
         nLhSnxvKgc/dBowNUGF0knoBtUU9zYpm2bHXBrH2c4LoQk+vhS3VO6pKy6bpwezh+MBo
         t5ZeoKQBgPkPl+UKEdVlLnMsepQPRSo50E8HkoJLiSzpq77OCEhh0ogM9jbg2qPPOTsZ
         sP7g==
X-Gm-Message-State: AOJu0YxLqGB70/mHyNthKF6US7/nMuyHjVI10If6YVqTlGnFjHARMH8A
	jJxRFHwmIDNACvxovRK04x1d4+l1zBuuekqcpRx0P44m6zDiFNuSJ0VxiaqJeTGY9dLDZal9eBN
	qR3Nwcw==
X-Received: from pjbsb12.prod.google.com ([2002:a17:90b:50cc:b0:392:b872:81b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390e:b0:38e:9ef9:eb97
 with SMTP id 98e67ed59e1d1-392823ea541mr21595524a91.16.1786402519296; Mon, 10
 Aug 2026 15:55:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:51 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-14-seanjc@google.com>
Subject: [PATCH v9 13/21] KVM: x86: Fix compute_guest_tsc() to handle negative
 time deltas
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

The compute_guest_tsc() function computes the guest TSC at a given
kernel_ns timestamp. When the master clock reference point
(master_kernel_ns) is earlier than vcpu->arch.this_tsc_nsec, the delta
is negative. Since pvclock_scale_delta() takes a u64, the negative
value wraps to a huge positive number, producing a wildly wrong result.

Handle negative deltas explicitly by scaling the absolute value of the
delta and applying it to this_tsc_write with the appropriate sign.

This is believed to be unreachable in practice; no path has been
identified which invokes compute_guest_tsc() with a timestamp from
before the vCPU's TSC generation was established. Fix it for
robustness, in the spirit of defence in depth.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 50e92090ba65..76c16a15f059 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1054,11 +1054,15 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
-	u64 tsc = pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
-				      vcpu->arch.virtual_tsc_mult,
-				      vcpu->arch.virtual_tsc_shift);
-	tsc += vcpu->arch.this_tsc_write;
-	return tsc;
+	s64 delta_ns = kernel_ns - vcpu->arch.this_tsc_nsec;
+	u64 tsc;
+
+	/* Handle negative deltas gracefully (master clock ref may be earlier) */
+	tsc = pvclock_scale_delta(abs(delta_ns),
+				  vcpu->arch.virtual_tsc_mult,
+				  vcpu->arch.virtual_tsc_shift);
+
+	return vcpu->arch.this_tsc_write + (delta_ns >= 0 ? tsc : -tsc);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.55.0.679.g6767b8d81c-goog

