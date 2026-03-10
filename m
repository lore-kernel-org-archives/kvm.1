Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2023C8704
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186548; cv=none; b=BaPFGYzbMZ8KZ3NGfl6LCv29WZGlb56Jg7q+cJI1HSBOeAzrIw7sc4b6cDJpPZObTrz1hHXzOgd25Lhu36fUg3cARvA20+7D/9FtOtp7zDYD+WudctvXd9Zik47FLn27Oy/vdMXYbo69v5Qb5JTeCHKimddqpnF9QMsuawAZBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186548; c=relaxed/simple;
	bh=UAGJsfn4uITqChnO7v2b/A3dIcvrCY5sndUyVXMl/+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVrEzVJixRirCU8hFGuXYTJbpGIxm+2nuBpvvwSvDyJ7uhErTSVMP2JhwS+ymo+GjVkuKG4YvXlnFzjhuKPoNeMoSq0TIhFkMn/hI6ElFR/v98r95+uIgP1ZDwdX5ieA6tx9TdjdWEwAjvO/qKWkEbqdNqEksfncBQq6nZ2IOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9D4uwwD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9D4uwwD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4f27033cso101408395ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186546; x=1773791346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN/R+oBH3CWqA3Eu2CQ+n5bQS63N2Tp/FKIbWvw+0KE=;
        b=f9D4uwwDaMh+n3lTRr0akA/M2s6VZjoQjRkNzcllA+7kL+vg5w5DpwynFzFaOr8G89
         H41SvGhRmblojZWdz1xCe1IXpKqnoFIOcIcsyTuLaSJ3fqVaC5lhrU90bjjnp7yli20d
         rTfMs0NKof6UhrYEuE4XKykA1wKBXUiRt4Z9eVvxU/VDUSiU5ISLR/AASjTnjlzf6+GY
         IhtrQUWSGRIAmmaRWpTswf8mXN0+3cAzL9Rc0WPP6khLGb0Wfk1m9SZPt7aFaAwMm0QO
         td/1JbKwgomX9wxd+Gs2kzhpSWR/br9CFiyT57EM7I/9d/jnr7L3+3/xqcQ7gFpFYx9C
         Bz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186546; x=1773791346;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hN/R+oBH3CWqA3Eu2CQ+n5bQS63N2Tp/FKIbWvw+0KE=;
        b=LAsWOIVjsa45kyb8b30Nxy+1C+Qab9AeF7lBACCytVBhOqH/DyI/Vii4OMpmw2RiOb
         wLSi/J+BfrIek3lL0j5vOxwNvcEz2DTuMAPETfFx5m5o2lkK0a/zJEwg2lBikv2fYTlF
         rhL3TOrzuSU1kXXxKRGe2rCnhslkuID3xjMJoEdiAs4rsgbwqc5T+xN5T0bE6Mln+Yl8
         kLxH5uBtbKhCX2/WmTZZlkr5F9ObQOZZ46kE+kAVwp7U3EQmeO5IVUlThCceVUi9vlzC
         wYkEb0ZoQiGTIGr7S65d5hPiR75PilFwwqRuVkZJ0R7IpYbZ+TEzNtYhDbJCnb+1efSY
         TEJg==
X-Gm-Message-State: AOJu0YwgxTcxUuEWkxFnINaqs4tFuo72vINHbNHH60KI2+DbuZg5lQAP
	oPxcONnsLSILpCuStUFjOGHUHra74GAPNNyX6tvh+HDvyvod/PA/puYEJUKiDx9j980tJblvV5R
	MDgI4qA==
X-Received: from pgbca14.prod.google.com ([2002:a05:6a02:68e:b0:c73:98e9:27c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:482:b0:398:9301:b9ac
 with SMTP id adf61e73a8af0-398c617126amr308413637.69.1773186546203; Tue, 10
 Mar 2026 16:49:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:25 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-18-seanjc@google.com>
Subject: [PATCH 17/21] KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

Simplify the error paths in sev_mem_enc_ioctl() by using a mutex guard,
allowing early return instead of using gotos.

Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Link: https://patch.msgid.link/20260120201013.3931334-5-clopez@suse.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b559d7141ae9..d71241e8de95 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2637,30 +2637,24 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user =
*argp)
 	if (copy_from_user(&sev_cmd, argp, sizeof(struct kvm_sev_cmd)))
 		return -EFAULT;
=20
-	mutex_lock(&kvm->lock);
+	guard(mutex)(&kvm->lock);
=20
 	/* Only the enc_context_owner handles some memory enc operations. */
 	if (is_mirroring_enc_context(kvm) &&
-	    !is_cmd_allowed_from_mirror(sev_cmd.id)) {
-		r =3D -EINVAL;
-		goto out;
-	}
+	    !is_cmd_allowed_from_mirror(sev_cmd.id))
+		return -EINVAL;
=20
 	/*
 	 * Once KVM_SEV_INIT2 initializes a KVM instance as an SNP guest, only
 	 * allow the use of SNP-specific commands.
 	 */
-	if (sev_snp_guest(kvm) && sev_cmd.id < KVM_SEV_SNP_LAUNCH_START) {
-		r =3D -EPERM;
-		goto out;
-	}
+	if (sev_snp_guest(kvm) && sev_cmd.id < KVM_SEV_SNP_LAUNCH_START)
+		return -EPERM;
=20
 	switch (sev_cmd.id) {
 	case KVM_SEV_ES_INIT:
-		if (!sev_es_enabled) {
-			r =3D -ENOTTY;
-			goto out;
-		}
+		if (!sev_es_enabled)
+			return -ENOTTY;
 		fallthrough;
 	case KVM_SEV_INIT:
 		r =3D sev_guest_init(kvm, &sev_cmd);
@@ -2732,15 +2726,12 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user =
*argp)
 		r =3D snp_enable_certs(kvm);
 		break;
 	default:
-		r =3D -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
=20
 	if (copy_to_user(argp, &sev_cmd, sizeof(struct kvm_sev_cmd)))
 		r =3D -EFAULT;
=20
-out:
-	mutex_unlock(&kvm->lock);
 	return r;
 }
=20
--=20
2.53.0.473.g4a7958ca14-goog

