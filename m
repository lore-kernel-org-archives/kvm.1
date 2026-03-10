Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE53DD539
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186547; cv=none; b=Eo9gIpGhNTwdCjkllnuNt7dPNO1A+qCFArOu0uToaPjmDQ41eiH45LEudCO56zCXk807jOuhc6fP81g+BaEpmqcvKZmW88jVoVVf9q0XsVPzYFs7L8EkDFMhdgXvkNCbIZ0pMOp2gX0POKr9Lb8B+TP0PhDTUNSlRiBkId1+mJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186547; c=relaxed/simple;
	bh=a+yWtnTa9sO4rPU2hZ741rzOJs/zu36KXomkjGQRtys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsNyBPAf8g5yciC9/6YRw14GJ8Cle2y+OlOL7TWTMTIwFOVSupyUQjYkj1g6SVTNX8IgdgrUbfQA8FUqD7MFY0R7Ch3WXHU1C+G8iADnLNs4TidYfBEI/aQ18kZjqJbPist8bJP2RfaWoYMdIPMNMO/JNg7rXpGPoUn0Dltxd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3NRK5Cm0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3NRK5Cm0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae502a1dd9so122822315ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186543; x=1773791343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2W+vx33PxDPD5fB6lzV3xxuVrFoYQtOIge3J7XoMco=;
        b=3NRK5Cm0DbusptKEFLOnfW1qLtPVgFKkd/Gi36q8dbeOcyUCxxX5Dm725NwVt+HVul
         f92VoGeIfDgUAEW7ZJFQFDRdxC69wxGoZj4CGWmqTsIUjrYMFEzR9/NGMFcwstJts8g3
         Yt5q3SXCpljEsykgONZKTbxg1041MGMHXQFUgJg55SvUvQmS89UpxIZv3CQOSWJ9siUa
         b2jmWQixDA6BEgaZlrHbARTYIwT71ULRSG4triY+MtQDuUwUCBM0y6GMCmrJTr2QRJeP
         SH9t1rHdTvgL7qPVkUuASVEi1xYY7nDH0N7QZ+Xa8PzPoNAjf9xY6O836pxL4QBbWZQw
         nsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186543; x=1773791343;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2W+vx33PxDPD5fB6lzV3xxuVrFoYQtOIge3J7XoMco=;
        b=s2mwFHmFvg+WbXq4vShZ2UagD30vjOo2TOn2yg+97XbCMomhb87C3yLX5cAM0JWfPg
         4EH7yztzcQRDWzvsLBSr09gEVITMhtSV1YoZvpGWRfZH4Ib1DQMnXDROkS9skOun1yME
         LD+HhH+UkDCQ/IVQL5vihjI8GrHJq3i3HoIMHuJtsq4rxm6GOhymaSH3S/z6ck1IVkTr
         2x0/da2ahxRhUgg9RCRfi5oZJk48C5MvuFzM5FyK9+ecBf38qkfsB5xyihuV1CXI9HM5
         NvsQxyTGl02koPVZaZqjgn6+aLMnhOHOzZkCrWO9mL6xhVXEmvi7ahKpvWf7hnureuzv
         RXIA==
X-Gm-Message-State: AOJu0Yx7m9eJfHFn1zLI9MWmJV8yUYAuGdITT0e3SnW3t4RYLUwRigyP
	GisqobHFU4/EsypHOXxVOuuGuOZOi3ELhS6Ua9n+sRxmxlqx5jB1VA/aVPpzTUyPOjtSVYGrW2d
	itJ8u2w==
X-Received: from plmk8.prod.google.com ([2002:a17:903:1808:b0:2ad:ca86:4f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8c:b0:2ae:422d:6ed1
 with SMTP id d9443c01a7336-2aeae7a32c3mr5261305ad.10.1773186543260; Tue, 10
 Mar 2026 16:49:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:24 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-17-seanjc@google.com>
Subject: [PATCH 16/21] KVM: SEV: use mutex guard in snp_launch_update()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

Simplify the error paths in snp_launch_update() by using a mutex guard,
allowing early return instead of using gotos.

Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Link: https://patch.msgid.link/20260120201013.3931334-4-clopez@suse.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cbb5886304fa..b559d7141ae9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2405,7 +2405,6 @@ static int snp_launch_update(struct kvm *kvm, struct =
kvm_sev_cmd *argp)
 	struct kvm_memory_slot *memslot;
 	long npages, count;
 	void __user *src;
-	int ret =3D 0;
=20
 	if (!sev_snp_guest(kvm) || !sev->snp_context)
 		return -EINVAL;
@@ -2450,13 +2449,11 @@ static int snp_launch_update(struct kvm *kvm, struc=
t kvm_sev_cmd *argp)
 	 * initial expected state and better guard against unexpected
 	 * situations.
 	 */
-	mutex_lock(&kvm->slots_lock);
+	guard(mutex)(&kvm->slots_lock);
=20
 	memslot =3D gfn_to_memslot(kvm, params.gfn_start);
-	if (!kvm_slot_has_gmem(memslot)) {
-		ret =3D -EINVAL;
-		goto out;
-	}
+	if (!kvm_slot_has_gmem(memslot))
+		return -EINVAL;
=20
 	sev_populate_args.sev_fd =3D argp->sev_fd;
 	sev_populate_args.type =3D params.type;
@@ -2467,22 +2464,18 @@ static int snp_launch_update(struct kvm *kvm, struc=
t kvm_sev_cmd *argp)
 		argp->error =3D sev_populate_args.fw_error;
 		pr_debug("%s: kvm_gmem_populate failed, ret %ld (fw_error %d)\n",
 			 __func__, count, argp->error);
-		ret =3D -EIO;
-	} else {
-		params.gfn_start +=3D count;
-		params.len -=3D count * PAGE_SIZE;
-		if (params.type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO)
-			params.uaddr +=3D count * PAGE_SIZE;
-
-		ret =3D 0;
-		if (copy_to_user(u64_to_user_ptr(argp->data), &params, sizeof(params)))
-			ret =3D -EFAULT;
+		return -EIO;
 	}
=20
-out:
-	mutex_unlock(&kvm->slots_lock);
+	params.gfn_start +=3D count;
+	params.len -=3D count * PAGE_SIZE;
+	if (params.type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO)
+		params.uaddr +=3D count * PAGE_SIZE;
=20
-	return ret;
+	if (copy_to_user(u64_to_user_ptr(argp->data), &params, sizeof(params)))
+		return -EFAULT;
+
+	return 0;
 }
=20
 static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *arg=
p)
--=20
2.53.0.473.g4a7958ca14-goog

