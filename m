Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2D3FAE11
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067294; cv=none; b=iqRBJBr4Puro7i86tWR3yuqPYXmTFcZkCXzNtuse/dwZaMCId9X+y3MnRQ8JHoBQFS04W32nyMnnTeBWCcQ1sxxBgbd5LmUjGJVNodDt2MTBRhaKKy0YRy/xom2RyetIrflKFyMKHre0BS7IQgtnZ5a1P4unUkwK2WyjaNM3LUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067294; c=relaxed/simple;
	bh=exJIaYP606/6I81t2u+ZeN9QwrdKHiAhDu05aj2jV5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSxsMUnoxVG3Ljt0sDusHpW3lcGuXnnZ5uKD8z3Yuk7F9KpwiXmSY1BHZTlEV4mdQKz04DeLOu6ZZwqnlG6Ekcz/C50jg/4szl5SNrTRA8qTMm6LH0AAzlDlmbLD5LIg/FghdtQlwibFpFW3gQ4gPyv1BeqLlEKNs15ngdy2Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wjh3olIL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wjh3olIL"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827adbf00cso6494549a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067292; x=1780672092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0jsX4kmzCmqMaCGwN5oKHLOUS2DjjzJWXK44/xdBtv0=;
        b=Wjh3olILxBugqfvoOFwFG+iNdahIJViFHp8S3c2YjV6zCK91YWRtTVvfUNVirjBcky
         hg7By0k/06qv+0FDkThy3f2YA3TwhEaQ1haPIKELN8pCwXfmNed5MdcLzC5VUD3YnD9F
         xBrrQo5iUhu1WlGlSV7EyIx3xBuRUfyhKa/npGyzsNLPmYlgkCrlXuiG6BYqbKeROFxO
         2YD7huKY7UmeKEHUkTvSqeryRbzcA/F8WOtHieIZO091SZxsXNQYkMTZXHR0mqviR0sQ
         gCWOhrCbrLRUGezc79zzKWWfC9ba4VbZhr0KJqgov6DzGWEvYHQYr0WbFK5PWDnt+xi4
         47SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067292; x=1780672092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jsX4kmzCmqMaCGwN5oKHLOUS2DjjzJWXK44/xdBtv0=;
        b=SXyfcNQT214/Zj5pkPGlMwq1AMeLWdbh8N4nzuBgDLhE9IPIu2vzCKph+gHlYNXfUE
         GcFkXkVrDF7U1kmRKi+65Gly6Sm1HvOInJ/pzSQUevqILQ2rNq2qbiZ7ej1XgyUscgOY
         LNIlY0sKd0L22ZJJb0BkmJkpdHwiBHxC3I+1JyZl+7Dd4wCds5Oa8aO8ltzkmltgDcGm
         oGnfJpHzlkzb+POLDuzdAObx4xsfiWzJillqigzZiAi6FlW14B7bzZ7Ac0zccr1+vCQ0
         cQK6Ic+NzP37h0MFEhTK+9AfWrwuta2fVQQhpUkW94Dful1TqSUV4yyff9jqmalj9ioo
         A6xw==
X-Forwarded-Encrypted: i=1; AFNElJ/jlru5JKWwM2Y4Zz+gyN/lFSY7v3jZdfWjBuhQe17UwiPT6wy0so91Xjcp/a6I4h56V38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1yAYsLfdJxQJZGTv0k5WXZQINaPLbPe/6twfi9AGPxfpoFl+
	UYFLoLCY1tM4ebUOmmCN+z7LTASy8hsnX942zl8VSA5mQijcC3QeqsdgNOVJKrItr8p8XsLahNE
	5sq88ww==
X-Received: from pgvi5.prod.google.com ([2002:a65:61a5:0:b0:c82:2dd8:9d49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b87:b0:3b3:d4a:793b
 with SMTP id adf61e73a8af0-3b411e5b284mr4378476637.43.1780067291927; Fri, 29
 May 2026 08:08:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:10 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150810.714572-1-seanjc@google.com>
Subject: [PATCH v4 37/47] x86/pvclock: WARN if pvclock's valid_flags are overwritten
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
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
2.54.0.823.g6e5bcc1fc9-goog

