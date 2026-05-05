Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8E4ADDB2
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010811; cv=none; b=VbJqGoo7fNWlI0V5fvI7X0NT84wE7k4BRkHoY6ssqEBzIV6ZpdnEpOD0LLB2fLirW/y7I6+CQZT3Y3C769DC488Jkv8rxXt3KCHveqD0nONbZiyuMpvXOEUDgUIUHKP/GlEfWgqArHMQf+ycJL4VSRnk954qCIGcryNovjxEKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010811; c=relaxed/simple;
	bh=2pXIK+CdgvXVanR6B3Y07NvJzjvZnQ0FvEOa8rzUPic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2X8y0av7rF1ZotWHYxrGF9r/Rkja5/GHn0NJ2HLqI3KcHng2px4mrOq/AhSvdEvMXZaD0M68yzBIsIyFBoMHMLffIjNWnaLC4qxHGsKpn4SKnpkit2oJGY1cSlQaYCnMjJkt/POaGZjT1Da3d4zj22ZF/aT1AmcI/WbfiQAOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctH1cxwu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XF7RvkxL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctH1cxwu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF7RvkxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCtnCZH8ZoKxZPeVUzWtK/UQekMVfj0snT68dwdPoMQ=;
	b=ctH1cxwurVA5On86TDqP8lQpu6eH0gMUcjo83iZH99d2DO1Nz6GjRZGqLYVWk+R/di6y67
	6xs1LNph0RK60c8fi+59c+DuS9ID9POTv7yPcfb3j1HEU/kIwoFWHREnVaOAzTmAdBqV2I
	B6ew3pBwDP0ZaSzL2C1cbf6NVasFDzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-v7FKMVl_M5WnKx-vtfGzCg-1; Tue, 05 May 2026 15:53:25 -0400
X-MC-Unique: v7FKMVl_M5WnKx-vtfGzCg-1
X-Mimecast-MFC-AGG-ID: v7FKMVl_M5WnKx-vtfGzCg_1778010804
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d104d1d8aso14775315e9.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010804; x=1778615604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCtnCZH8ZoKxZPeVUzWtK/UQekMVfj0snT68dwdPoMQ=;
        b=XF7RvkxLqpgwpitQW7+I6LC0SZcgdmSlGlwtyv7fsBf76nYHQg2PAQA1Sv8Vm/TbO5
         d1TUTMw+p0hMqXl3Krcytr9d051Pq3qKGK7pZVLdhZWqgH/u+db2xh3Ie8NEU0r+Rcce
         H52e1zehCf3kjKGzsTDina8jEhWZqTD7VbTPN2lU0rkzsRlbklaQkIqtYo0ZQ/vSScn8
         9vY0x4R1wte31Ddw4LZWNNV/zIG1eLUfs7BbcpEmhnlX7YHVubCf5PQJDLJiRF9zuobr
         gn/SOHn3DDgMEpp2OtdWOj2s6u9ELpLOmHMnTph2SXZ2UQXexPi9f2J3xzWbuAAx+Lnl
         DiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010804; x=1778615604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCtnCZH8ZoKxZPeVUzWtK/UQekMVfj0snT68dwdPoMQ=;
        b=pWtOpwuxBU3G8ivJhzSjy+3iKwdmDLtgtcuQuJaJuZ7mndKoMulTbzbZlBDdA2OsrD
         j6p2x26DNaA9PTnqCSlA2B9BmZdvg4u/9khVWxWXKNA/j111Wyed28r5dnRnbJFrdZRv
         eZtgn7RwTQjXRPEWYs/b8t8t2fsr64jf4ETZkeU1nN9MYkMQXaVAr/pFRPgP01VY+bB9
         oNN0aFC4iHOfmXvsjqrvLHnhyWIdZ4870y9cLus7GddsRs8vJwWG58V9Qv2j5PNCZtmL
         P4Jj8ufFX4cxC8EMXHNrvMYffQy4LmEzR0fcswUyD5EE3iBv/m0wwt4INHghv5tBz5XR
         q9sw==
X-Forwarded-Encrypted: i=1; AFNElJ/arTFJPJztPhIucTqgg4Ataz7HxciqHOSQGBiqOJBdMY65e8Szjt5M/mKH5+IQyp+/pKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUtbaT05tbJp1lCPr/AxYi+QQCxhqWClXSBcZQZEFSTb6LNDE
	rZAfu6yl7kZE3wqOl6tbojVk0DvJ0CyNhNSDqXRv5d977ijjN6IznvyDeYBylhFmDxjCYB2BFCT
	rMIxEb+gUU9xpLKhKW+4M17CmCuYFLzkhy6njSgSO5xsZYkuQZqt7KQ==
X-Gm-Gg: AeBDievAIlstScpuugEjWOvZAF7vqX5nSDGuCwsvxElNprxe0bNkxszomyhJV2iBfWT
	p2M3li4NPOR2yEKZ+uYqF/iS4+xL18GMRmugGDslJyU+2iJwR/RC8hAXsjEymvrXgBPd12Uh8pQ
	GCde6BIQYwQMw7ULtcQv/oekyMwTLRNS0AhfehEfQxtD0XZ3qS9n87xUvwRTkjFHLBMWu7tq8jh
	rQdrDzg79TwUmDz+c0Dsx7z1t3/ebOWWwUKYbh9f0Oc8f9REvSCahUQ7YBKxkhFW8R7z1FWPor9
	pOxTmDBDxrzKFcfGGaGa/TjriUCP6IXCDPPK/mMxkVPgENC1lIm9B0XOoR3NdRdiFL+eI5Jo91M
	msy2o6k1VuEh19voGYJQWcDmi8W+wvqpf/meAQFkEffOuDVQ/9+kXKK2v5S0lOmU9t7XU77OSEA
	+CQN6jz6gummQdWCBRYdeMrKC8g4zneq8nzrFtLNg=
X-Received: by 2002:a05:600c:8589:b0:48d:5c1:bc3b with SMTP id 5b1f17b1804b1-48e51f410a4mr8256895e9.24.1778010803907;
        Tue, 05 May 2026 12:53:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8589:b0:48d:5c1:bc3b with SMTP id 5b1f17b1804b1-48e51f410a4mr8256585e9.24.1778010803501;
        Tue, 05 May 2026 12:53:23 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm760324365e9.2.2026.05.05.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 23/28] KVM: SVM: add GMET bit definitions
Date: Tue,  5 May 2026 21:52:21 +0200
Message-ID: <20260505195226.563317-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GMET (Guest Mode Execute Trap) is an AMD virtualization feature,
essentially the nested paging version of SMEP.  Hyper-V uses it;
add it in preparation for making it available to hypervisors
running under KVM.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/svm.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index de7bd88e539d..d58dbce83f45 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -379,6 +379,7 @@
 #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
 #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Virtual VMSAVE VMLOAD */
 #define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
+#define X86_FEATURE_GMET		(15*32+17) /* Guest Mode Execution Trap */
 #define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index bcfeb5e7c0ed..aa63431ba92c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -243,6 +243,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_MISC_ENABLE_NP		BIT(0)
 #define SVM_MISC_ENABLE_SEV		BIT(1)
 #define SVM_MISC_ENABLE_SEV_ES	BIT(2)
+#define SVM_MISC_ENABLE_GMET	BIT(3)
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
-- 
2.54.0

