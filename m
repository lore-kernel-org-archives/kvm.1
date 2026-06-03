Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CB4BC003
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528042; cv=none; b=DyenHTP1u48To8X8mov8RS+6aHf6LoK4og8k0ADtSP8pvc70OBdEAQcaK+uqTpKJUj/d6KgPM+q/FZdQ/cp9StUWOCtbkKMAcwzo+KGEUukzgT6qaggl1ufU61AEouBwwe+oAzRqpUjj+zcFJhKMZHeeBcLd8RXRa+6aX/Ig9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528042; c=relaxed/simple;
	bh=pLvvPeDwAgyJdeFGiyMwllcwEqjKmtrj8SdTUoCOFSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IhAZilYQ3DPmJbtzFrmogvRFnELj407cEjv+Wrtco40m9KzayZSQsTgvaXJ5t4gjjZeJ2tE5NQE/1traC5IwnmjeJtLw3DTB7AHB8+W4ZBtJe1hbRLJcZnuDun2cq2Ih2eL8gS08cYQgj7xwkWUrq2cVdkfjg49UguIDVTc+qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bewaiFQ8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bewaiFQ8"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f19558so40277a12.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528041; x=1781132841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMkZhGG+frwnxufTYUp82wrNMIQvEvIuJF33kB+uepc=;
        b=bewaiFQ834jOzuGvuyWtESVY5F1nJlKg6sfOK0Q0ZOIP9M9IcNY0xPqNqurVNRGdug
         MIJLM5nd9bmixBsjQbGsy1UPcsXlFt85UTB8Ql29HvRsdlFdmSeMYw3hrmPhTlY2vdPg
         87qlxbx5kYr+yQVBfI2ZC5DcZIfynaK/yDog9JZsMVPkmaUNxv8agHbjWKhVhPvmR3+L
         VxzwNVxTmubIZfz2qBypxz4uvPTUDqXmrXEnYhT9Tmtsr1xF8VQLwHkBvg0I9mJNxh9i
         sBN4s6KRR3ZpYlYXPUGUT06rSdla2Et8p0Rm3NvW9+/xbfCXRR9aUT4YmGBIcBoxrM9V
         d0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528041; x=1781132841;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMkZhGG+frwnxufTYUp82wrNMIQvEvIuJF33kB+uepc=;
        b=Ub5sKo1yTPtayI9J248tbybNfooevdWnBwWwfH5AnSXFydIqQOnI1804Ju6ervSvwg
         rSjomylbMFGvKipwe04/VprJV/uH0S4DUWcebA024Jn15CltcktBurEsnu8oNZJYjjmg
         xpRzcPF4OxBo2k8cH6I6prmaM1GOHfrzR0OCLlqVij/cxN8N4Sqh00DhSHF5cNKZ1uq8
         j1xM2AQ80GfkWRC4yWHKfL/F/rTa8yDS4v8KrVzBFmrdWj1o/HhH39SSW8CP8ktLfojJ
         YEzahTM20T0Z1hWJE7QphfWRrjOGcOUEWjh0o955PXXZgocFZfHm97AJAPgZa22Yxdou
         VsPQ==
X-Gm-Message-State: AOJu0YyT9j/s1RwUb2AiTm/FlJsyEu5JyS7ZNIARG9Ohzy9sEW04/zEf
	FJFDpQXTrxbmhb+0V/q6VEsGZ15hhtCs2swrb3eOyGnxWLcFC+VUSrCTVCW7su0dHP+0KgZEpy5
	kqXovNg==
X-Received: from pgv31.prod.google.com ([2002:a63:155f:0:b0:c82:72ae:396b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c783:b0:3b4:72bc:5b86
 with SMTP id adf61e73a8af0-3b4977e30c7mr5496339637.16.1780528040789; Wed, 03
 Jun 2026 16:07:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:13 -0700
In-Reply-To: <20260603230718.1733483-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-2-seanjc@google.com>
Subject: [PATCH v2 1/6] KVM: x86: Treat any non-zero return from set_dr() as a
 faulting condition
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

When emulating a MOV to a debug register, em_dr_write() calls
@ctxt->ops->set_dr(), which is forwarded to emulator_set_dr() and
then kvm_set_dr(). The latter checks that the written value is valid,
otherwise returning an error, in which case the emulator is supposed to
inject a #GP fault into the guest.

Commit 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr
to callers") changed the contract of kvm_set_dr() (and thus
emulator_set_dr()), returning 1 as an error instead of -1, but the
caller in em_dr_write() was never updated, checking only if the returned
value is negative. The end result is that em_dr_write() does not detect
the error, so an invalid write does not generate a #GP, but at the same
time the register value is not updated.

The practical impact is limited, as check_dr_write() already checks DR6
and DR7 manually. However, it misses DR4/DR5, which alias DR6/DR7 when
CR4.DE=3D0.

Fix the bug by treating any non-zero return from set_dr() as a reason to
inject #GP.

Note, the manual checks on DR6 and DR7 are flawed, as they incorrectly
prioritize the #GP over a DR7.GD=3D1 #DB (the General Detect #DB has
priority on both Intel and AMD).

Note #2, relying on ->set_dr() to detect #GP is also flawed as all
exceptions have higher priority than the instruction intercept on SVM,
i.e. the manual checks need to be extended to DR4 and DR5 (after the
priority bug is fixed).

Fixes: 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr to ca=
llers")
Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Link: https://patch.msgid.link/20260601133320.91479-2-clopez@suse.de
[sean: drop explicit "!=3D 0", massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b566ab5c7515..75cd8b6136aa 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3299,7 +3299,7 @@ static int em_dr_write(struct x86_emulate_ctxt *ctxt)
 		val =3D ctxt->src.val & ~0U;
=20
 	/* #UD condition is already handled. */
-	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val) < 0)
+	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))
 		return emulate_gp(ctxt, 0);
=20
 	/* Disable writeback. */
--=20
2.54.0.1032.g2f8565e1d1-goog

