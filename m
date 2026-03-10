Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C673F32D8
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186550; cv=none; b=BmionVLG5naWQuUaGOqC1SPkvPCcKU2Ddd4iyoRwNBGSmbTRwyLsoaI9MCAuVZeKtlDTYNed+pWsQxAlcYMnmIEtKupwgUutqRPQ3Wvy4SmjZNwO0/rDw6ZsUJ33nSEALOhgkF/qPAAzbfkZjGmmol4ZtYoOvxDuOO2Ptr0lYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186550; c=relaxed/simple;
	bh=NYFo993tTkJnZVxYyi8yhYGD0rwpt0fJ6Qw67xx6DSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hoNxaM2PKqiKWX9h1AzoB/0qxngb3AP7z9bK53sC2cQFLMeRqhOrrixe/Ba6rb6oYFykZuQQfyijjuZra7th1vfG+IsPcuwwa4VpFsnl2HmkJUqOfJzxleY5wlLNn2ahPywXQHsBG2etWwStLahcbOe8qtC/ML5Yzf9fzkxVq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ab2Exknn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ab2Exknn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c738f71723aso3401915a12.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186548; x=1773791348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBZkGpoLO8YBRN9uFX112erAiueHmjShOSeCtGMnrhs=;
        b=Ab2ExknnJ2jiK3t62+6QQjIaGpu/EIYCXMIgURREeh4gK04vwilZkR8DTHAy8rGsNH
         kuarvQ9qttW/h4WNuuxjOFofdvV4JTNj50Gkrh8+Ois5yagmO+Sipd323TYbz1nqhwN5
         83Ws20RKdiMYBC4qkDH5F90E0GbN5HLfz46B8NYBf5NogJWbdlwG0kPJZskVRY+3icDW
         dkaOTJkZg0n9krN4jbkDojZUh6KyjzDp3u3UIAj5D0B7XF+BxHQH4dx1NXCChpsMvtjn
         ykRZKfQH4cm8AEv5biQUxSZvVIyEpFaLKL74HiUjrs0T0mc6zqjWyk9l6xVgB1CW59yC
         iaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186548; x=1773791348;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dBZkGpoLO8YBRN9uFX112erAiueHmjShOSeCtGMnrhs=;
        b=Skqi5gPW43leHE/nJhKVX2y35zI4PiHKDv42c6z061ThzCrX04P7/ahgwFrgtG3vOs
         9cvEK1zo0+hgY/qqS6G6W7dM2Ljrj4mgigOKpN7Zb14wUe3IQ7DpJEM5YJFNsLvbG7cv
         VpT27cPIU1ZCGWXCqAVI22LGA4Ud5hXZJDYyE4RZYHq+Goybz23xZgvellZJfTXP+42t
         dp7XnQ2r1SqpW8i+Zf+1v4rSDYNp//YjIwYSMh77DW9FbhOzP+31nVpz5JfbdhG1SHXA
         so9zk4fcAGWUoB63hkzpDjrA+wxATdMcaQ9f0Md7TWqidFv7jJqZfqRs8zqNnaMClJbc
         Hllg==
X-Gm-Message-State: AOJu0Yw3N2w2Fpp36i0RDM54rs5dnZBlmdabwJMYvb9mPMYZMwvr2KL7
	oelXXUL0ekJHkjxdqTB/6ijj8cu5GGXNMwBWYG7prJ4aceCG7tgds4P/IRXTzNIq3SV2QlN+c23
	lo8KhHw==
X-Received: from pgx11.prod.google.com ([2002:a63:174b:0:b0:c73:846d:a381])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:700e:b0:398:b5c0:587
 with SMTP id adf61e73a8af0-398c60d925bmr346250637.42.1773186548043; Tue, 10
 Mar 2026 16:49:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:26 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-19-seanjc@google.com>
Subject: [PATCH 18/21] KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

Simplify the error paths in sev_mem_enc_unregister_region() by using a
mutex guard, allowing early return instead of using gotos.

Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Link: https://patch.msgid.link/20260120201013.3931334-7-clopez@suse.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d71241e8de95..61347d8508f2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2814,35 +2814,25 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 				  struct kvm_enc_region *range)
 {
 	struct enc_region *region;
-	int ret;
=20
 	/* If kvm is mirroring encryption context it isn't responsible for it */
 	if (is_mirroring_enc_context(kvm))
 		return -EINVAL;
=20
-	mutex_lock(&kvm->lock);
+	guard(mutex)(&kvm->lock);
=20
-	if (!sev_guest(kvm)) {
-		ret =3D -ENOTTY;
-		goto failed;
-	}
+	if (!sev_guest(kvm))
+		return -ENOTTY;
=20
 	region =3D find_enc_region(kvm, range);
-	if (!region) {
-		ret =3D -EINVAL;
-		goto failed;
-	}
+	if (!region)
+		return -EINVAL;
=20
 	sev_writeback_caches(kvm);
=20
 	__unregister_enc_region_locked(kvm, region);
=20
-	mutex_unlock(&kvm->lock);
 	return 0;
-
-failed:
-	mutex_unlock(&kvm->lock);
-	return ret;
 }
=20
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
--=20
2.53.0.473.g4a7958ca14-goog

