Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639453F6C2C
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872857; cv=none; b=pF7oTzqdmqFz9ecvQIU7bQxGCkdVsODj9oSXkCouO7s4tbXsHucUREahApVAHSAFG2AUu+jErDQgIAJXZDfcGbzRwjqzWg3imOaFsfrjkx3PrCuqrh7GMeQIwTjS0CZUEqBwX3HfKSDroQkXPJt+HuPEFY3zGM8UcejcoFReTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872857; c=relaxed/simple;
	bh=lbZq5HMMUdoKD8t+V1QOxdv8UCq5RsQl+bpxwZwTljc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOc/UcQl4xDkTQ33wJtrPOGdaGDqfBgpjmjXCL5sMTJDoeoiQ8zp/SRLPtmAl1zVbi9SDe5UYR3uqTlWpa7QINYqaM2VPGpufAUSARB7kgLw6E30zYhCwNMtVPHQSQbffoY0JG0wQBmONS0P9VxWh4PYTZNw6afyggOYnt5wFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eq494Ve/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq494Ve/"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso223397b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872855; x=1779477655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BtD3/8r1rxxPL0bRTCD1R2r93qIzEoWuEeKvRfTm7KE=;
        b=eq494Ve/TYFJex7FCne50MgPTq4OKBcYwIkoPj6cyggtcnY9i1TmQKg6ZTM+Txku8j
         kOJLYYGTyllSNMsjN675NMMSDIreI122ZtDQybkdBKcKczZMzfs/fVvmMoo+cO7wiHGx
         snpSgiqZNq1lXeJ6ISiHbGho7Efzlyqrjuo6M7FxHkVaB5NPGX4Y79BQHAx5s0WPrZUt
         7nTE+lZKutQv/wmMzKvsiD0EGjkDTj9L7meotK49TrMWpSfRBq3VsECae/R0hEyElNDr
         zYFTZ0KHgXzfaZ38nkbtqdzrwZ0nEE2KlefKRSjCMnc0a9LCe5VZUhwQVLVFIusR8uim
         fe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872855; x=1779477655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtD3/8r1rxxPL0bRTCD1R2r93qIzEoWuEeKvRfTm7KE=;
        b=c2dF9r3UEPWCoccr1X8Mekgoc711+RAHCfZ4PI5F3cbqE2LuUBVylsPbzup2X2YTwq
         ZJtpNfDYJgMNvBoGgbEXC2Q+sJFbH3SVCKIdDT6EEzanQoR8EeQ7c1ZPN02iIrep99y7
         U9Yc5n2t0kCM/fiDMUf/1u8uvSuXtLfqyHpAABZ2B/6KP2Iqde0bsLZBeWV+dp6azpFx
         4Y9eaDPxriMzjgt8fl1GH5W1PbF5eUo8KGiE5InPFJ5A1FAGS/z7oawMosIgw+YbPqeF
         y97yphrBRm0ewhFFFoxUiahhhcpFd3FWKQjQ2SDkbZHleku1FT0C7Gr7xd7wF0qGjUIM
         lQBA==
X-Forwarded-Encrypted: i=1; AFNElJ/8O30d9bszh01Uy9k1Vbf/w4byWWv0oJFEaP/vgZ6UQQQAl7J8amKNT/cG9R2mgNPv18Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ApzB/qYs9KozKKI0I33WZ4l4wEcEL2ACDuregVNjXI6bTqJg
	z6TuLFPQOI8uCMYadmeM0cQggssGYZ1VyrVcC3Ohq+A8FvVlQNNHf69hjOgVdfYzXliV1kucS7v
	eciN0Rg==
X-Received: from pfbly26.prod.google.com ([2002:a05:6a00:759a:b0:82f:a4cc:2fb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac86:b0:82a:805a:7e2
 with SMTP id d2e1a72fcca58-83f33c4ed90mr5838917b3a.9.1778872854522; Fri, 15
 May 2026 12:20:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:23 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-23-seanjc@google.com>
Subject: [PATCH v3 22/41] x86/pvclock: WARN if pvclock's valid_flags are overwritten
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index a51adce67f92..8d098841a225 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -21,6 +21,7 @@ static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
 void __init pvclock_set_flags(u8 flags)
 {
+	WARN_ON(valid_flags);
 	valid_flags = flags;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog

