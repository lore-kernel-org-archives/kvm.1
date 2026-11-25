Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588206;
	b=dLkiKAk7EON8EHcFBP4bthzocjOyo/g57GdfnywfNxSORa6DcsPVSIf7oaqWswr1/kdu
	 qqGzQfzGzpYbfdzOtbYPxoCnGovvpxte4soUJKIuFHQrbzU9sYWuuKlAMl2iL3ueOxAkY
	 eNYnQpvltL6fG3GjB3Gu6XKPp6DURBhb/J73JyRn4CKrP6Cpe6UMexSOQvazTOhgC/dbo
	 Khau4xQxeXeBCbVX3TCL1DhP5W2tWKWzBmWGaxcmlSvAt/XKD/V3OU7ljPWNM0tHzSReV
	 +CL503G8FKi66uDFfoe/jUoIcjt1UIn0uSFxpCxW0R6643FAmJ8B2886L8n9WC9197Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PClTuZW0DsU/l7BXsxBD8FK+P2OxUWW6O1f9RJ3UfPA=;
	b=cqszR294DR30a9NoIzff3jZ3m5OL75c40bZ3ys8dvNgjin4J2dhk3K8e4LO7kRNfUOKk
	 a/BvjS219tYM3jkirvt4LUTed1duqI0O9oJjIu0vgJoBaS8bDdFQrMv6aOGy2OZzBX7y4
	 GzUBS3PoHPKilMkmvz/lXgN3hSGlq3ajUiQpIXGRmJUIcONraZp2IXWnIzZflTZrW130Z
	 xAK78zt+6lzycqUy+FKZ9PL9uDMk5F7FxGKLoBJyUus6eTVx0gMogaHTNHxLxkDnvRi2F
	 md/CDEIO341d/0ip6LiKH58ejvC1yxbecKVjPlOy9QBz6bHHR1jJjf/vH5MppUvSYXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BK8pilZV;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD4606A684
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FD4606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BK8pilZV
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a594d313a3so3565378b3a.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795588205; x=1796193005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PClTuZW0DsU/l7BXsxBD8FK+P2OxUWW6O1f9RJ3UfPA=;
        b=BK8pilZV+eGRQvALauP5do8aykm4ptRFa8X3TD1kNYs+Hyni1XJwWtIL0NVRs45qQa
         E2Yj1ayVKokg6wnJLPfffWekhoifup0q/OB//gB7liz55XtBXQ6PUQJoznT3PJ8rPE2t
         efkoP5y2kpQIjC34uLAhpOEfFMvVyXoVDv7kR5NoiWToqIjAgSwQlIOx6Yty5fmGN79h
         QrFn9+KLaK9UY7td1cSpRMXwL1uFH46nPH5qSwYpcXNjpSLBJYw9AA8fUBRrmGF7yeVC
         G2EoI+s5jykc2tiScwApYHu+eX4GlRC5bjFsFNVTTW22cWkitO/Q6DRgxtVPyFaqLeMX
         Q8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588205; x=1796193005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PClTuZW0DsU/l7BXsxBD8FK+P2OxUWW6O1f9RJ3UfPA=;
        b=W++tDAv814AG05iKO1mNZ4FzK27gV8xB9SQyE50HLMSvT056PVo5SAA5Wdk7xkPxyw
         oXU3iNhqHkQGOJN4+yVCytCRvMHY4dIy/bDSuh64C7w9FaButkZwsVHT8YjAPewNJxMb
         a+2ZaCfNIuQ1JjbJ5ahN2HQi6elG7nUMZMygv+PzTDDx0yrPMXNwWHs8Mu16+mx32uGw
         0hydLtice5Tzoc8DhQXSKAmqNS2SenKEI4HqC5TThKsn2aV+9NtVFZFlU0BmyVCXJIN+
         ZTPFGs7NGOGbu9rh/PbkDPz3Vu1I4e/H+o+ZOinIEVXcBMdd3TRqJkQIKNV6p+oqe4T0
         +R0Q==
X-Gm-Message-State: APuU4Z+HEz04jWbEqaLAJK9qB7bCVRsOlqomqZirQ1i4Wo0NNY01HVts
	8LYbf1s/Rv3mn/eKwevlHcLDGkSpo8NKge3ovXI7ph3+HO3Chc1CoYVZ
X-Gm-Gg: AZFdTZfE8hMZQhGWprhXv4/LFToeMni+p/5/Fya9gcWNZ5ODWj5Z8fxARGyNV10LyTl
	cKlPel58mLPWQQu92pjv36VlJXEvAx5PcCsB6REwVVqB3e+NBPDyjVyJKcbXbMATBloxvkqbHi5
	nc9S65/I7nKg1hB4aaFu1cIZv00SeM2gpzI1qKTDDG6MLuJghxE48aLNoj0e38KQHsK1PgVbbYO
	C3RV6gmYOKJyxJU9OODyZrWKQRspBRWDd1Z4ooSjXZ22asc33JxNVKXe8yYUYCujNLNfi3HzzuH
	8icaGswnIdJPruAw4WExJ2ypnP30ZdTwZbFdxPmUuzi0Kio78fdN1nfkUuIMMpgxdviz1Djbj3I
	5jgflrAgf3kOxu9wl38JKDzcIDnz0lvcqDv/PA8r3046EVrRarcZq2RdOxJAk00BudlIWJazOwc
	W35JiveZcimh0b3H5h0/+peE00uDdDHLFsGoHyleMMHfUQS3dXKP4oTri9IPMVAr2PVbKHAEOZQ
	Oq3tCnN55DuBTpjp9uzxzHQUztlPMuIC+H5CAF6IUiLQ5J9tePbw7Nnq00i8Fb38lml6sVRsXHt
	XJGgpAW4HEWCZFNJqPOl0LfrIaCkZld0plsOHYxSMzPAvEWgj7LNUBGmj25AssxxNaDBQ3mI1vR
	BTww1Vpc5IBVm03anaC4=
X-Received: by 2002:a05:6a00:13a7:b0:89e:9c7e:fd5e with SMTP id d2e1a72fcca58-8c87bdb41f2mr15276827b3a.9.1795588205198;
        Tue, 24 Nov 2026 22:30:05 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b278f0sm8355165b3a.51.2026.11.24.22.30.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 22:30:04 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH 1/2] KVM: SVM: Don't clobber RFLAGS.RF loaded by a single-stepped IRET
Date: Wed, 25 Nov 2026 14:29:59 +0800
Message-ID: <20261125063000.92971-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without vNMI, KVM opens the NMI window after an NMI handler by
intercepting IRET and then single-stepping it with TF and RF set.  When
the single-step #DB arrives, disable_nmi_singlestep() clears TF and RF
again unless they were set in the RFLAGS snapshot taken when the
single-step was armed, i.e. before the IRET ran.

That is wrong for RF.  By the time the single-step trap is taken, the
stepped instruction has completed and the CPU has already cleared the RF
that KVM set, so RF in save.rflags is guest state.  It is only set if
the instruction loaded it, which is what the stepped IRET does when the
NMI interrupted a context that was about to resume from an instruction
breakpoint: the OS sets RF in the saved RFLAGS so the breakpoint is not
hit again, the NMI pushes that RFLAGS and the NMI handler's IRET pops
it.  KVM then clears RF based on the stale snapshot, and the guest takes
a second #DB on the same instruction.

In a Linux guest this shows up as a duplicate perf hardware breakpoint
event when a PMI happens to land right after the breakpoint has been
handled, e.g. while sampling with perf at a high rate.

If the single-step trap fired, fold the post-instruction RF into the
snapshot so that disable_nmi_singlestep() leaves it alone.  RF is still
cleared on the event injection path in svm_vcpu_run(), where the
instruction never ran and RF still holds KVM's value.

TF has the same problem in principle when the stepped IRET pops TF=1,
but there KVM cannot tell its own TF apart from the guest's after the
fact, so it is left as is.

Fixes: 44c11430b52c ("KVM: inject NMI after IRET from a previous NMI, not before.")
Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 581bc3a23c95..118c2ce4742d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2087,6 +2087,18 @@ static int db_interception(struct kvm_vcpu *vcpu)
 	}
 
 	if (svm->nmi_singlestep) {
+		/*
+		 * If the single-step trap fired, the stepped instruction has
+		 * completed and RF now holds the guest's value: the CPU clears
+		 * RF when an instruction completes, unless the instruction
+		 * loaded RFLAGS, e.g. an IRET returning to an instruction
+		 * breakpoint that the guest has already handled.  Don't let
+		 * disable_nmi_singlestep() clear the guest's RF.
+		 */
+		if (svm->vmcb->save.dr6 & DR_STEP)
+			svm->nmi_singlestep_guest_rflags |=
+				svm->vmcb->save.rflags & X86_EFLAGS_RF;
+
 		disable_nmi_singlestep(svm);
 		/* Make sure we check for pending NMIs upon entry */
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-- 
2.43.7

