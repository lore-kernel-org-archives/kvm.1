Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF23DDDAE
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305593; cv=none; b=UPNfkcxlnhUYWOCiNWKsmgpwNPyt6tMoC4uMggFQuAUAR29eClL8u9Raizx6cmvbaVUGUwd+oZtUkQSpuxRKMqW88tuzotL3+iJHwpy8JwndPbL6v9xD757d3vQRemEHj5GonTQDGadEi8WXlZd6o+30Jy4Jft3yxo4uMRKzDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305593; c=relaxed/simple;
	bh=6eQiEssKQC2c4js1UbQi49lxWZxkjELs+LqLjtbU2Uo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JsYIkwKATa0CD7JJjW1/rr3uT/dMnEnVN7NH7v32NF/FsSZIZOfyWp3Q5VtjBgMNx4kIULQreD2cL3ZWTRjzAhE51ZDvZ/1pFasNHJ0x3gSP+7GWaimFFwJcXPpEU5yC6T7fC/6s3+zpdf5byka1DoH0jhgYlJ0SgKXu6kc1Qn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHJZDT7d; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHJZDT7d"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84238e83851so1006663b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305591; x=1781910391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qhTktuVCXULSuX/UFAv1vCF49/raqu6/3zhwlwCn86w=;
        b=SHJZDT7dOoflOP5nZwVxND/NnMTp9jcaAJEP5MvM3bNVDKWi9Xs0z66L2VzzvUhCUb
         LEoVvMvHJVAYL19CvXwexiBFEE1ScIwcNvtgurZFempoViu/+nTJyiddRLsHDWuwNYJB
         HTuEyTWTVy3jAtRupqEmwINxtCKG2iPRaL1d0sjyFLBcfCbHjXDb+Vn5PbBExJLGnSpv
         rCpZHdARfrIFXAa18YRpAlOkiGcAAB8QDR/hQDTdZNiv9Nn1ONRZK10jXhJugiPGb6eN
         NCLrJJSRdPOtZII173ZtbewsUPJylFhdP0maHe9Odc1z/Gcgt9mRpRU3WE1y9wpWz5Wi
         5xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305591; x=1781910391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhTktuVCXULSuX/UFAv1vCF49/raqu6/3zhwlwCn86w=;
        b=YkBcxIR0jI80xwO/ZXs2gUHl3wvLmEeoHOuG9NAeF9bVDMbN57uXRBMDj7ntK1YID5
         nPW+2t9cTtYGtsBYuRA+8jTV1QKdf1aTXBLLdNBsdZW2Hbxd6MayfHSzW69+ZLIT6UVT
         cHc3PzvM4lc06J1CMs+oBFrJ3jsjUp1Bon9qh+rVTTgv8WrS2IjDLSbK+LTI8szvX89M
         g7ASE596MdEkJwzErD6oj5G1YIjVVH4iG6vLkbeR2jcj9T/8Q6mmMXzM6NU2xvJ1G6pE
         Tlfc3aDgAJCaVq2UbznsJSkp4u8gUS3E7Rqvj0NbaWQR6Y5y14Qzrw03qt/E0P380hpz
         Bb4w==
X-Gm-Message-State: AOJu0Yxb5K72hgyymocKHIQqDCjWftiz0fKkAseI9JyTJnzBeJp98Q/c
	01Fa7sY8m72LJgiW6AOgUeku21LEgdWTA6ukWZd40aadZPczTEsvfWmyQ00PUiXLavWhEY/CE8l
	eJgQivw==
X-Received: from pfjq17.prod.google.com ([2002:a05:6a00:891:b0:82f:473b:a2d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e12:b0:83c:928:6e5a
 with SMTP id d2e1a72fcca58-844e196615bmr1794416b3a.13.1781305591149; Fri, 12
 Jun 2026 16:06:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:18 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-5-seanjc@google.com>
Subject: [PATCH v2 4/8] KVM: Initialize a vCPU's index to '-1' while it's
 being created
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Invalidate a vCPU's index immediately after allocating storage for the vCPU
so that KVM doesn't incorrectly treat a vCPU that is the process of being
created as being vCPU0.  This will also allow detecting that a vCPU is in
the process of being created and thus otherwise unreachable, which is
useful for avoiding false positives in lockdep assertions on vcpu->mutex.

Note, kvm_wait_for_vcpu_online() naturally does the right thing thanks to
vcpu->vcpu_idx and kvm->online_vcpus being signed values.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..b3d2a678210c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4188,6 +4188,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto vcpu_decrement;
 	}
 
+	vcpu->vcpu_idx = -1;
+
 	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!page) {
-- 
2.54.0.1136.gdb2ca164c4-goog

