Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163E2F3600
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854091; cv=none; b=Z784MTF3IkHAbSj/I+ncw6sM3x4v4SjEbKrY/3hApBzFfuInC2g+lyePurIw+se8iNzCfnRiJYc4PnsYMRL2sbVTjqZn7T+doR2xZRdDyVzz9x6jemVVBIgfuBFC6iolV032NWpYWuhGsO6ZfelWBmQS5qcZ+6KEuEbXBIaN4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854091; c=relaxed/simple;
	bh=qfluePufCYdT2dkLNE5ea2k26Dj9SDS77ApfPplLkUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=re3hahLKl2iRmQGxY1P51QxAjtDahGT2QtyQm30wo8fwrTLT1hoiiT5atRn5PN4Ntn0fFytrXIrupNgYhBbY4knC/IGqUd3waywhExS9gV41uSehZGQCmnmM/rRim7Fa/oFsih/d7IzPx9ZwWilyUECTiaENlgYgFO/S1X4YzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVZ4rpq0; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVZ4rpq0"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cae455cf6dso19762945ad.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854088; x=1785458888; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I3gB3WtQDQEpdFBx4UsnySvL5yUqMDwDBCfPJjwK10k=;
        b=RVZ4rpq02D/UZZuY2gcooCKtw6pZ1Luy5wNIznXcohQwvrdJSE32Svw9uhkJDeIPl3
         5L1cn9heVpFxn7PXD6/xXNJje8zxAlg3R6vQp5npCIpvBvWNY3tiUNCQpHXivMIytlb9
         ffe+WzF0R1UNCrZhoWkkPrguolaNvE9FJxtnDe9aARNNlIf89uYZq/Eb0KEDYfV1UN4o
         i3V4w9QUNQVLlRM4LFoBJiYt+fpuM2ZRPW95brh2TtvaxMkTkHxp9fedKKA9xQ5Q/F6h
         SqvYmOqQn+e3DIjgbLgcp9mYGbOhXPKSX+2C9HkguFK0LGVGio9gLshe77B08t4x0SHL
         qIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854088; x=1785458888;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I3gB3WtQDQEpdFBx4UsnySvL5yUqMDwDBCfPJjwK10k=;
        b=dG6aO/KM8mYyX4MMb67EpsSnrvxf/Ke3SlajcrqjhD0YUh2NcJxm1Khx1EGcQoAz1R
         5r71EdFSOGE0Q7IY2a8k2E0YMLybIsSf2fYx+nVK7NX5BuBNRArnag6KqkcmctdR+UbK
         qYJMYQ89OM9JKveL+J6udQnk2pXdxwhzDt2lQpff19e0MwcnBorY6BMSBRrxtXNsOkMe
         GLYv9xSCv9tcxWgD8mE+KwnF3X/cRfk6okQ35HTlGJPwat7G7zxtjbVQlUgfb5E22Chw
         aBiel/OYD5G8HrPWjBePV7kkek8Xk64Zizoras2L7trzyT5NUnxWowwCaidrX8d96fWn
         92rg==
X-Forwarded-Encrypted: i=1; AHgh+RqNicn3Ei2QZ24G20SXog8ekIQOkGP3bGHB7kptjStS+t2wgjXF0vrpaQeAZg3B+ejdA9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hLObfa2o5WtcReIm4FXRiOj6VKdKia3Ch7ZC8H0EzLNRgMhs
	3XOnNUzKJfVFlLP9uMbYI/Swn3yc2parh/KKf710j7ld0v4hdjOmvSzHA6gkPojwdvNG1yY2K5b
	qnY4pxA==
X-Received: from pltf3.prod.google.com ([2002:a17:902:74c3:b0:2ca:b3d3:7c07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0e:b0:2ca:c84b:c4a4
 with SMTP id d9443c01a7336-2cfa748cdebmr62759825ad.28.1784854087460; Thu, 23
 Jul 2026 17:48:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:56 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-6-seanjc@google.com>
Subject: [PATCH 5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for
 patching dcbz
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Convert the kvm_vcpu_map() usage in PPC dcbz patching to the new
CLASS(kvm_vcpu_map_local) implementation, to eliminate the very last of the
the open-coded on-stack "struct kvm_host_map" declarations.  This will
allow adding hardening kvm_vcpu_map() against memory leaks (due to
clobbering the existing mapping).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_pr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 2ba2dd26a7ea..da7a038e2700 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -639,27 +639,24 @@ static void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
  */
 static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 {
-	struct kvm_host_map map;
 	u64 hpage_offset;
 	u32 *page;
 	int i, r;
 
-	r = kvm_vcpu_map(vcpu, pte->raddr >> PAGE_SHIFT, &map);
-	if (r)
+	CLASS(kvm_vcpu_map_local, m)(vcpu, pte->raddr >> PAGE_SHIFT);
+	if (m.ret)
 		return;
 
 	hpage_offset = pte->raddr & ~PAGE_MASK;
 	hpage_offset &= ~0xFFFULL;
 	hpage_offset /= 4;
 
-	page = map.hva;
+	page = m.map.hva;
 
 	/* patch dcbz into reserved instruction, so we trap */
 	for (i=hpage_offset; i < hpage_offset + (HW_PAGE_SIZE / 4); i++)
 		if ((be32_to_cpu(page[i]) & 0xff0007ff) == INS_DCBZ)
 			page[i] &= cpu_to_be32(0xfffffff7);
-
-	kvm_vcpu_unmap(vcpu, &map);
 }
 
 static bool kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
-- 
2.55.0.229.g6434b31f56-goog

