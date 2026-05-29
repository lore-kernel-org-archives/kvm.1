Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE53F8EAF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067288; cv=none; b=EwuDuCGNW0AXOPrmz0YrzLO8TZIGmlcy/4/xJ7/S3mcviAxSrPEADUhqncXsF0d47O0ePB3byAFpjjikUAYtZpuetIgW0FUrgd7tCvPPWmiPRW0Bgqu1WHXCBe6wqLJY8YVPayxGO/2xu4MfmUT62D5vkLP86VP4RNC6obi8NLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067288; c=relaxed/simple;
	bh=he0WfZWWdERYD7ChG87MeYfoSX2HSFZ+ZmjDHyI6dIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVNC+CopLO8gB/j3BLu6QOyuRKa91LjqlUTg3D/44TSbYCI05NHNlI8tSWZzUZeMSTKjmKAk36KZgHYnTsYlHesWVCSvwELwEdPoMbPwU381bX3iMYok5udTsuKoohXf6uxGozcwKSz7dFde31hiypNzIeT0QHlFODr8oRQNT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3wQ4poY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3wQ4poY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba718173d1so107097705ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067287; x=1780672087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=juhHvibOKBbL5R/8TYL0oDxVwG80NiQFMLoZ+aO+Nyo=;
        b=u3wQ4poYP2eSyy1zEVjY0WHILnDf1cSwHDndkUc7IvC/yCRmr2YBGSs8oNtQBEs1cP
         Vf21HPDas7ZFNepSdMVYgkFhXqS6lPxlxJqUK36CwJvgz+nskIpSIxOkbx6g6izn/A6X
         Yjrszv/vE7z/P3kzocBh1R0QG16IwLr9Iz6X9EGr+Wd+4vzZulRSWG8EuJeTM5EPwbHv
         lE37h0CnR0DES0ojJtVtMXCKNV8+QV2ctneAXeIqK9Fpn/PMvCRgVd2sNAPH1c1t0SLN
         j4tbZefDK3OnstUvTwVHuqNBUxCbHFJJVL3t2xJBEK6gKO+pMGb2M6jOK0i15Cqsz5Bi
         8Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067287; x=1780672087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juhHvibOKBbL5R/8TYL0oDxVwG80NiQFMLoZ+aO+Nyo=;
        b=tXVq5YW1XFeIVtmNzW+gvUFs12mm3WKI5IdXt7X6hsxWvhWXvz4L4U+oSIQO88oDZB
         lGkft0UuNva+JH8ooUs0FmSjJ42597G+tJNdf/9tD7PgnU9fqpFTs34sXvqpbSJOenZp
         cwl50YCakZlqRNgMUucV5/ExiiLywNjk4l7XMkp3w9OXa9n493+KQnNECNs7LW9HNTIN
         EuOgiBZfE71ErANHMVb/N8vHJEBUa9Q3ckOJNStbKCG7q95xOquq1bTfJQI13SUwYB+Z
         xykzeCMpsYnIiyzQ9v75OgU0D2Si4E3eiPSVQaw8f978G3zD4hh8SPRDxw1/EnDYJ0wF
         DQ6g==
X-Forwarded-Encrypted: i=1; AFNElJ/HpGYtqvrwWo77y9AaJZ4AHnOahKeP8P/kkVDnI+k/Zr1gk7y+bhFRB3LDXT8JVPQoEkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq50lMfShwLTYJ56e9JMepjaZnaqZSfBAMuoy6NhU/r3PbhARg
	9Nn5k3zX8dw0ifSG1kaNPB73AsM9W3z1LtbPq4rzASibr2dlfp3HNwLtDeCIXualqrWp0bnM08v
	jF+hmJA==
X-Received: from plrf5.prod.google.com ([2002:a17:902:ab85:b0:2b0:5538:b55b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88c:b0:2bf:2188:a90f
 with SMTP id d9443c01a7336-2bf3687a3f3mr2296425ad.32.1780067286623; Fri, 29
 May 2026 08:08:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:03 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150803.714504-1-seanjc@google.com>
Subject: [PATCH v4 35/47] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 91ef83b1e540..8f4511f91d16 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -454,7 +454,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.54.0.823.g6e5bcc1fc9-goog

