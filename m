Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F253AE706
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805769; cv=none; b=nSYVx1munzKj9kV11Y6ejaeWjCbmN9SHEupztm1waPGN68dcz+wHrXWDSSFLwOqwu8dRK33ypmz5QXB72CrjYvAFLl32N5aPAZ26cJ9UlgpoX3b0AS03buNYzHjh7ZPKH6bxc/WlG1nsEgCrfGIT1Rp5rNe1AYOO/MePmLWohtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805769; c=relaxed/simple;
	bh=S/H77lj1fZtAFs64c4lKzj+C7fMo4gZ7VAm/tqW8ncs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h4Jzgj/whGP4R6d2mkvrsb3QIUoBZKdGVwI8QQWh0YKb8DEZzytAtZE4QhsP9OApQT9a/iBbqgWypTyebhR3F/ouY/93uP5Te/W66Awnw5xY4ma+k8ALoEjOHVcextQZFKARjjeoJynDKVAmlJrQRGjud1qOsF6tOYpDcWCqTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hII195Nb; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hII195Nb"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-660a2f72cccso4185041a12.0
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772805765; x=1773410565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPUDEvHAsE2et1uSdvC7qqWK/vawe6dJIioQ+SXcGgU=;
        b=hII195NbHrftgwxncDcQTBQdPU3EZXjLBB3YRtJF9ZL5xUU5gXS9S8DUN9sQS6JmDM
         2wsZmZ/M+NGCRmciF/PU32Wa/9zX3YF8QDENwVgSuUfqHC9Psi2+Mv4Oigo3AZx8Qs9I
         iAjzcRhWwiypLOp6Ww/PMUyi+STUKl4UWu1P5c5QJdRSCob73TR6/0g2f55zHgPQ+fUC
         QijC8hYN1CU8qcP/tEEn34zEaW/C3nucdZghFKhFoEtZexev4W6M4l7Q5dQbFyyIkPn+
         aFM2y+gHbVmFYuEQmJvwFI/hRApRuZvqyRzG5J3+xYDt+ieHS9ZdfOh8hjGQbgq7Z7Yf
         FxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805765; x=1773410565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPUDEvHAsE2et1uSdvC7qqWK/vawe6dJIioQ+SXcGgU=;
        b=gHuQ3b4Z+RIdz8DK5QQOP1xwx627vsTe0WuxUnFZWC0j+emUGz7B7mcRFlePBEJuxY
         vKWg5TnHgqYiFRZ98xoLUHGsfDSOK05Y1qkIolOH91vMM2QVEv2wrFcEfa0SkQNCz4bl
         cAVehzsmhFjA2Bplb+hRCLGLGfA+j/eNBEGSnZlPtnbyGAlJox9kAodoCN+GljyKxhph
         GfI2qxIp1i1FY8PPyY85w6sGIMKx2vV/BkG9c9HGWqeI+qkzhaqwQUc3BqqaQfMjTftI
         fNnauGzrTfOE/rnDvLWP+iYtGEPcJXHWjf0sNFBWk28NrG4Bm0VerEWoQC2EAY8y36Md
         P3sQ==
X-Gm-Message-State: AOJu0YwIJRfX2zb3MXF54OcXrf/eBY2R01ROEnHr7Dvd8MEIfA0/3dt9
	5rpnzogGBsfUvf6DFMd2U1U18OOBTmGEbYNg+LucvGDjE9OpZ5V7dW7FKJj39xeHQLnxmdI7eyt
	3oxDwAEE5GV2U/SUyqxyAxHDQyDdohYpQtZTqCTQpWcGw62VsSfi/iZpkV5Q+BBW3BUpqaC/4ut
	PhnPeA71LPIwbUNxABlCdl/ItoPik=
X-Received: from edqe20.prod.google.com ([2002:a50:fb94:0:b0:660:bf3b:b289])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1e8e:b0:65c:209e:32c4
 with SMTP id 4fb4d7f45d1cf-6619d51fd74mr1077641a12.20.1772805764944; Fri, 06
 Mar 2026 06:02:44 -0800 (PST)
Date: Fri,  6 Mar 2026 14:02:28 +0000
In-Reply-To: <20260306140232.2193802-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306140232.2193802-1-tabba@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306140232.2193802-10-tabba@google.com>
Subject: [PATCH v1 09/13] KVM: arm64: Simplify return logic in user_mem_abort()
From: Fuad Tabba <tabba@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, qperret@google.com, vdonnefort@google.com, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

With the refactoring done, the final return block of user_mem_abort()
can be tidied up a bit more.

Clean up the trailing edge by dropping the unnecessary assignment,
collapsing the return evaluation for kvm_s2_fault_compute_prot(), and
tail calling kvm_s2_fault_map() directly.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/mmu.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 01f4f4bee155..35bcacba5800 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2005,22 +2005,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (ret != 1)
 		return ret;
 
-	ret = 0;
-
 	ret = kvm_s2_fault_compute_prot(fault);
-	if (ret == 1) {
-		ret = 1; /* fault injected */
-		goto out_put_page;
+	if (ret) {
+		kvm_release_page_unused(fault->page);
+		return ret;
 	}
-	if (ret)
-		goto out_put_page;
 
-	ret = kvm_s2_fault_map(fault, memcache);
-	return ret;
-
-out_put_page:
-	kvm_release_page_unused(fault->page);
-	return ret;
+	return kvm_s2_fault_map(fault, memcache);
 }
 
 /* Resolve the access fault by making the page young again. */
-- 
2.53.0.473.g4a7958ca14-goog

