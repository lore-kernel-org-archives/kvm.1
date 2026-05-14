Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC033C507
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792832; cv=none; b=mplu21XnAOQCrELWOsHotP8ov4FXVF/Io7otqQq9yLiI8byfCMzJ3DDdv4wCp34reVeu45Nj/Co5xOEcviPHpgRNOjo1cQWqHLiKyxbUra4J2B1MypdFxejjd19Y6seEgU/qVGKJ0YM8Zt8GXR7MiRIRpgNz/ImuWrv+mxG/OO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792832; c=relaxed/simple;
	bh=vpFF+bbpc/y/ztzrvCKD81LQtBflFDk5tHkwZJfXdow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UUTVGoPyNBVviLmzxlFDSy10Y77ziV/xn8MxCYraeIVdKGy5sHu8/bCK8KASjEuxsGNBijVvWT/uL7Luuj0XlMw+/AN+/5BiNFJtseXiL/xuL/sWWmWTR8kNS7bO+E2lA9kKvP4E9Fgm7NL2vAaDcd6/Z73cl+f01a1zjbJhd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXZZ0p/O; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXZZ0p/O"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so3272588a12.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792830; x=1779397630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaDLDnpOneJ55K9/6LdA6mg1LOI57CTIEvERlTgohIQ=;
        b=rXZZ0p/OE0Kg2cKcCuXlihnnyU7XWibF1oOeM9R6AErwS2hjo5XUB/vuS0pSZQG1XF
         1eqXSVULQo/EntxIJsPmlANL3XQJmKTYN8ZDIDj7AB7BblNyaBZSFThbtq5s9GPDXzCV
         2C3yv+fdHRYreWgIF721Oh8WJN1z+Sdyqfei+OA+IwfoUPL6WjK3EWqwJ3I2OzIrVj0z
         clRttrdcEOSzyQI0KfugZaKDP2sqs5F0vc5rmdIx1masgfHQhAd9UgtSNheNbaTSCwfa
         F4K/IMTwu8aoO+3EoA1bMUa0tNFUIuSX15h5pdKS/956RQR0yNGhhp8Sdm+poFD9kNeY
         kAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792830; x=1779397630;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaDLDnpOneJ55K9/6LdA6mg1LOI57CTIEvERlTgohIQ=;
        b=IBHj95+GF1HrINfEhKJoKihoSfG3bvpfn2q+Z6IdJbcSoUZY+Kh9vy682PxKS+snST
         bc6mAv1XXgpsWzxi/ALyTHqlSMMhVHo3JCF+qjk6YFjJ1I3e7l9U6gXEPoo0JAej6bgw
         uSlJ6dds95DztVpb+Spwmv1CbS8KB4HZYXQAhvdhENV5nKXyHTlo0YANXQMmeBEYDHCj
         1wKwB32ZFq2Ve+RFKR6Dr+xxt/r9ziMbupLmkg2ulrlc00/FCeeW6bF9+NpB/rYPkdDk
         u9I3sAG0YxTrPKH74NHkVXymh/biVOViZe47ujw1ObZXT2h7AKSAzuc4IfYT637w623h
         KplQ==
X-Gm-Message-State: AOJu0Yyumv2CTN7QkRxz83XUdfiurury3gDEbk93OKAULyKmEQyK8FzF
	oEAKIIFV25JNTa8Px+oR20xxJlVOKghovrcbcN3it7QMQ/2L7Y4JIZCL4AvunjWaxUJmupCTvi+
	M/+7gYQ==
X-Received: from pfdc7.prod.google.com ([2002:aa7:8c07:0:b0:835:b5c1:ad30])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:39f:27ab:2438
 with SMTP id adf61e73a8af0-3b22ecac17dmr858487637.48.1778792829757; Thu, 14
 May 2026 14:07:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:07:08 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210708.1627866-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/apic: Verify LVT timer register mode reads
 back what was written
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Naveen N Rao <naveen@kernel.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Report a failure (but not a pass, for brevity) if an APIC timer mode change
reads back a different mode than was written, e.g. to verify that LVTT
reads via x2APIC MSR are accelerated by hardware and access the backing
page when APICv/x2AVIC is enabled.

Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/x86/apic.c b/x86/apic.c
index 0a52e9a4..fab15946 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -569,6 +569,11 @@ static inline void apic_change_mode(unsigned long new_mode)
 
 	lvtt = apic_read(APIC_LVTT);
 	apic_write(APIC_LVTT, (lvtt & ~APIC_LVT_TIMER_MASK) | new_mode);
+
+	lvtt = apic_read(APIC_LVTT);
+	if ((lvtt & APIC_LVT_TIMER_MASK) != new_mode)
+		report_fail("LVTT mode '0x%x' doesn't match written mode '0x%lx'",
+			    lvtt & APIC_LVT_TIMER_MASK, new_mode);
 }
 
 static void test_apic_change_mode(void)

base-commit: 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2ff
-- 
2.54.0.563.g4f69b47b94-goog

