Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688E3F54C0
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186553; cv=none; b=KfQDwledcAG94iFywd1KCpilAsiJqhTyDzNoygJD0SYRJUKkEQqqiuqRfKXy4+DrCvogqs8jtypJTrF5gCRvIg7kJ/EnZdq1H/PV4JvD8C3y4SHy6KvJ2GkZbmFAt95o27PrcoSHokKzWQKOAhY4BAejiAPW0v6UH8/vjApas5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186553; c=relaxed/simple;
	bh=lQVINFRBfCNVeU648cAxFtZU2dxkYDd+1iFEZqJg0K4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+utf24vwIaKq1Drb9mo2qQipDLnJXuhQOacEfAnnm5nEDss9duGI/kGBUwzwwIr9kIWrWNcWqkeIwsxanOOaOam8MExmIk0g5WWTxvSGapViLUwjU1G50M2RPJkxk/gbFb5YPJ1FtRs3lRCv61C16VkBb3OBgVhWrCwQvpl8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKcY62KK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKcY62KK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7385e8fa73so3644152a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186552; x=1773791352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGe66xfGbOxCz1mpJAIyMP4Fec52GFDEzf1ERh019gQ=;
        b=XKcY62KKxm8ZcVKVlCbfG0B/vVU3BRe0ff2dIClw9DEHuq9XnqgvdqAJroF84ivftI
         TQykyxTXyZuslrPb1h5CbXSEo8pTGI2OXUmcAt569lgfLinugZDwQF1v4hXA3CLNyK5v
         YipkomTscxtjAxFc3DENBaqdZencVq5YRrTvgqSw26fnXY159Odgkg18EGz+TZvdCL2r
         xIC6MlRMX96strefSJ+HdeFWOK5WQO1GuI0d7u61Rx2iDNDtz2zXn9BXoPOKFFGarc1P
         OQTQQA7QfCMeNr42I/qpr9i7Yht0YS0LLC5vF1Z17pGzY2NTnkysU08fQZR5M0SX/j8o
         lidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186552; x=1773791352;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGe66xfGbOxCz1mpJAIyMP4Fec52GFDEzf1ERh019gQ=;
        b=pTjS/PpcScM3AzQe+34kiyQvDx+SochN3N+m9AnP1OJI4Ov0a1wrfTimhQIR+YLWgS
         tsrhRSlpt/WdGEre+ez9tcnOhH3S4ugeMk1+lDkpA0P0VycpZSaCdAm76JdZeLx1s72x
         ulovVx09HwN7He9wtP9R039wfg2vvRhVXwy/RMHxu/037HcfFw00bnk3yDjmTS3MZYYh
         vw2789bst6i/alabNoWy428N8NnkKWAsu8T3AJOcbzFOEIfkWB60oQESayqsYsewUR4a
         /EQB2KDYxYOYiG9YzdwlX3h97kDGZymFomrIxdJIvMQKfmRHFL82hBMsjTns0ZVeK0qa
         //Lg==
X-Gm-Message-State: AOJu0YwlMujqQNH1jrShJlv7FTDbEaqcqkzEW5MuH/9s6D/3icuWcaOh
	kqLc7iB/UVMVMwhuYhm7sHvr/a/X18czRTA7VjLZ+xOxBCaQ9GEzHforsxwZyA3qAA7OwTQ48yX
	yKHprKw==
X-Received: from pgam3.prod.google.com ([2002:a05:6a02:2b43:b0:c61:35ea:4553])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:691:b0:394:5ff3:2a98
 with SMTP id adf61e73a8af0-398c60e3834mr350163637.46.1773186551520; Tue, 10
 Mar 2026 16:49:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:28 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-21-seanjc@google.com>
Subject: [PATCH 20/21] KVM: SVM: Move lock-protected allocation of SEV ASID
 into a separate helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

Extract the lock-protected parts of SEV ASID allocation into a new helper
and opportunistically convert it to use guard() when acquiring the mutex.

Preserve the goto even though it's a little odd, as it's there's a fair
amount of subtlety that makes it surprisingly difficult to replicate the
functionality with a loop construct, and arguably using goto yields the
most readable code.

No functional change intended.

Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
[sean: move code to separate helper, rework shortlog+changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 36a33e8ade4d..c35eb9e30993 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -237,6 +237,28 @@ static void sev_misc_cg_uncharge(struct kvm_sev_info *=
sev)
 	misc_cg_uncharge(type, sev->misc_cg, 1);
 }
=20
+static unsigned int sev_alloc_asid(unsigned int min_asid, unsigned int max=
_asid)
+{
+	unsigned int asid;
+	bool retry =3D true;
+
+	guard(mutex)(&sev_bitmap_lock);
+
+again:
+	asid =3D find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
+	if (asid > max_asid) {
+		if (retry && __sev_recycle_asids(min_asid, max_asid)) {
+			retry =3D false;
+			goto again;
+		}
+
+		return asid;
+	}
+
+	__set_bit(asid, sev_asid_bitmap);
+	return asid;
+}
+
 static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
 {
 	/*
@@ -244,7 +266,6 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsig=
ned long vm_type)
 	 * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
 	 */
 	unsigned int min_asid, max_asid, asid;
-	bool retry =3D true;
 	int ret;
=20
 	if (vm_type =3D=3D KVM_X86_SNP_VM) {
@@ -277,24 +298,12 @@ static int sev_asid_new(struct kvm_sev_info *sev, uns=
igned long vm_type)
 		return ret;
 	}
=20
-	mutex_lock(&sev_bitmap_lock);
-
-again:
-	asid =3D find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
+	asid =3D sev_alloc_asid(min_asid, max_asid);
 	if (asid > max_asid) {
-		if (retry && __sev_recycle_asids(min_asid, max_asid)) {
-			retry =3D false;
-			goto again;
-		}
-		mutex_unlock(&sev_bitmap_lock);
 		ret =3D -EBUSY;
 		goto e_uncharge;
 	}
=20
-	__set_bit(asid, sev_asid_bitmap);
-
-	mutex_unlock(&sev_bitmap_lock);
-
 	sev->asid =3D asid;
 	return 0;
 e_uncharge:
--=20
2.53.0.473.g4a7958ca14-goog

