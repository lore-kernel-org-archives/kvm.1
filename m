Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610573AE719
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805770; cv=none; b=C7T5xhKhrtJYG0sRk8qNHIB4Q2ygJSFru4ol+Jrd807YVMZdwoprX9jxC+oGpK0A9qDn/oJsIW2aDDheHf7daxIEjlAYgOorLjwp+ks8gl5fhXogZJoU3Fgo59CNxJS8XoXJNduBrjTvcMWtQE4wo5OQJYEQwuUV3qUBf5ub+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805770; c=relaxed/simple;
	bh=dssjA3u+VFXpsFKHFhYOAlR5Hr1cip10VgtJuYqdW38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhTEAvf0WjusAjZCh6P67h7pHz90hNskWtBcg/wQvTj+4T6ZXsoQnDFNeUDejp2iU8HWY+ZY4QOe4ZGappAhk+j7FRXgul6TtmyGqZlTIqkhNXbNOSVfovkFw+GkqUSw/CgFBehj6OsY6T3oipZPUuND7vki4gRM2bobj1GJPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llTxi5K0; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llTxi5K0"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6614741a740so2353555a12.0
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 06:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772805768; x=1773410568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrle6LcPHnpw57JFxD6jZW7nwqfyHVVEsUa7FBi+veg=;
        b=llTxi5K0TVYEySHGstMrHyVkLT43VQahQiAc3A1+e/11EhsU3HNs4Hp1n/QwrCootr
         84DVUDsFZLUMQv1a9vWJLmy3boQVIKUOdRR/XDPdJ/nRLYZPzjbD1Sm0lDF0Cxi+vNyk
         kXbZJIiM6s9HCtEnUjW9p7eHcLVPZHqFl5fGP7rNx4WGw4v8VdoEhgNpnPtxMHkVPKcd
         ewPpS+rPhCLz6wqZNbfSmf+5ebJGmaEsMfIkHgUCWwKLq5iA0db0cmcQnnwEKuhuAhDl
         N5C4tlqvvnCQQ6U7T68BamNLW6ez6DGDgYGRxvF1iHPIXwc66F5YchikiDRIvnfb1O31
         Ulkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805768; x=1773410568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrle6LcPHnpw57JFxD6jZW7nwqfyHVVEsUa7FBi+veg=;
        b=p+DJsntCirk5AqFvx3nKIj/RRKqel0/N51Hmd0xed2Vf+/tpzCljpG8YM82GvCPO22
         AoXhzCvfMbo1ySgSt6ZKSn3VnqMNddzqiEnX+vmmhIKazHILd1oz/c1HqYu/ri+opxvv
         MzSC27FTdcPQoXciOmV7DlLhRg+ZA3o3Z8++ni3ejQXLKFrSXTgwXRaplZqTpXZLD5YS
         OgGmRHHzytKrYFC1d7OQFpD0AXRCIgiFO4cYOK/lf9QbhSQA6nOrUY6eHYPnj8Wi3ltw
         mJ9JNAr/MQfZb4XHCFMsOSRz9AbAonj8uKKbRM7ED6hWqfElEvX+lrDTRkqT8UEMI8wz
         u2NA==
X-Gm-Message-State: AOJu0YyEjMrt0PZEa2YHl8yLJMwCB8A5xl6aBOrdmnDMS2YvkVtY8CIW
	ZmQaKHwFrNH7jfoBdO3ZpkehN7braf95F5cqiD/YO8zTpM/4/M9XPz2X2/JoZtg4GVikeZEku8p
	7M1gbAcyIecJSM77G2iOmPxkuVOdXpdLTSRDkxZLrUnZ2JQ6jEuzz1+opRVZfKIer6KKi8t90TO
	emtRSpF/INJb+r0xpPfDkJhhxPUus=
X-Received: from edn26-n2.prod.google.com ([2002:a05:6402:a0da:20b0:661:18d5:ee37])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1d48:b0:65f:9c21:e68e
 with SMTP id 4fb4d7f45d1cf-6619d45a9f3mr1338158a12.5.1772805767541; Fri, 06
 Mar 2026 06:02:47 -0800 (PST)
Date: Fri,  6 Mar 2026 14:02:30 +0000
In-Reply-To: <20260306140232.2193802-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306140232.2193802-1-tabba@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306140232.2193802-12-tabba@google.com>
Subject: [PATCH v1 11/13] KVM: arm64: Optimize early exit checks in kvm_s2_fault_pin_pfn()
From: Fuad Tabba <tabba@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, qperret@google.com, vdonnefort@google.com, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

Optimize the early exit checks in kvm_s2_fault_pin_pfn by grouping all
error responses under the generic is_error_noslot_pfn check first,
avoiding unnecessary branches in the hot path.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 2d6e749c1756..9265a7fc43f7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1791,12 +1791,13 @@ static int kvm_s2_fault_pin_pfn(struct kvm_s2_fault *fault)
 	fault->pfn = __kvm_faultin_pfn(fault->memslot, fault->gfn,
 				       fault->write_fault ? FOLL_WRITE : 0,
 				       &fault->writable, &fault->page);
-	if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
-		kvm_send_hwpoison_signal(fault->hva, __ffs(fault->vma_pagesize));
-		return 0;
-	}
-	if (is_error_noslot_pfn(fault->pfn))
+	if (unlikely(is_error_noslot_pfn(fault->pfn))) {
+		if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
+			kvm_send_hwpoison_signal(fault->hva, __ffs(fault->vma_pagesize));
+			return 0;
+		}
 		return -EFAULT;
+	}
 
 	return 1;
 }
-- 
2.53.0.473.g4a7958ca14-goog

