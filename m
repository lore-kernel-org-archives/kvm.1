Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA049E5ED
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476971; cv=pass; b=aO7rkTxKF3ieILrwaNqzMvGv31Xf1K08dr/hxMESYRFtqzfcKUr+jDINy2UJeAOoyomKClrLhGB4YfREi+bg844HxRm1FQCzpcv+zz+PGKGN3Q4ci+EoJBxo/9EN2K7m9YfuKcexdcvAIhy7eQXac+PunVBCGj8xZWojfOp0/k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476971; c=relaxed/simple;
	bh=Ai7LgQ8Udb+lmv5fOzlzMtys8hhAwbhpQ8yP4JRI2dc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ox5f4CyqWp0p0L2AR/2HDouHSiNmmdiALr5X8s64GNM+V+MFx9n2DJGDiqnjuPJr7IBygezPwyY3w57WaaxnGPZvUD3omCSpuDUE3o8OMyf5IfkaisaeLAV10+SkT03ulvabOq8BhXxpjP4Nb+B56dZiIsoWcXM7xPFVkVPUQ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TltG0X4u; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TltG0X4u"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so18293765e9.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 05:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476968; cv=none;
        d=google.com; s=arc-20260327;
        b=PKrGXkzHyq/NjAzFsOGXtwsbt2Yx0Q8PC5rRP6gPhs6pkv2zIVOYUX7xAhB1jg4sG7
         nhAWEaQzYwAwKAZlW2XXaGobiKCxFWTTLIIQTQyl/OxS2XP7cGnyrNau/GuyOA1qlWI1
         N9njREu+kXAW9dFsely1t5cmArNr1af0opy9qjSVhrfOgEvaXcGUEt6YFAnJGc6jSXzB
         /iE4HkEU50zUdKeRzWEHlfpki6GwZSfm0l6RJj/0OppoGZ4jr+boT3kSlG+9RcStjMxz
         VQvY11wgf/qEAtA3FCfU5fSfiNb39Ar5Sjp7FitIEHhD+eFVEipMoZMxlz6IgF43dE2o
         xucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=bf06teX+xGmwIkLs0Z/cwpo8oC6a/oyJ4tvPAI1ACCI=;
        fh=Fr7JSTctbettG/LnaFkdWeaq62JLX9bWTAuPN1Q1cgQ=;
        b=cCDsJLWU99Bs5Sex3EciCkK1IV4n7gwQoRpxuqBXGn20p0oFxR7G2oV4ukHbfT1WzU
         Ph8aoXWoNrZlXTf3AYt5My/B/Znt2zk+knttNgdntl7ScNd7q2HqEscH+4NvvnjvXw1q
         cK1RKNsAs17PFu5vkw6pXzwH6Fq7/FGOXL7SB3Kt+nMLS6MPfsdKUCdUgouxIQg0mECO
         3kZBCK+loMXpkXqQsTvQurqDtlwfWcv1zFZHRjl3OyTfTuGHM234DspxNB8Ag5dpqZEl
         eyALJ+rRRMp12AC7rm9IQX+4iqApu9C5n/Deg5svo/bUr5WwkPmi7MsQQIa7KUFdzUbp
         E8Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476968; x=1790081768; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bf06teX+xGmwIkLs0Z/cwpo8oC6a/oyJ4tvPAI1ACCI=;
        b=TltG0X4uZfqmSLMjdLo3r7yLRxtcpljsE18eh+AAkUHWh7fZKcMshq8yqx8E+W/CWK
         dr2pLf5TxyDd5Ha7/Ac9GB0NxC3kTItO1XwKBWDrh7i2cKVLXXu5PwkNF63SvwHGzosO
         h3WqKqaTg5am8f5u/Nu6isIYsLX7U6bh/6kwZkwWa2PqhCpDqvIDJDj6lRjB9RZaII6Q
         Vpf2llEGtE00ZgAcBztW2WTB41jCfZoZbZsrA+Njl0VK4X5H+vhqrND1khs1cqkISi5s
         3tqe14tEuGnXPozSXPGk/fiJ3PJOvSeA6DCSkBSlJrcSmr7nFdYIyLUGgZEEOSxpzqp5
         sBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476968; x=1790081768;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bf06teX+xGmwIkLs0Z/cwpo8oC6a/oyJ4tvPAI1ACCI=;
        b=IvLAEN+SOcOZgn76eDPdGF7yLzUIGcPSveBaRCRGRfl1/bV10xlZTLQuAXsp7qSED2
         JKm9QM/h3ZRwQkmgSGKEy8AsFqWzFkSjDiwh2Gm1HmPB5ipKi7mFh76i3V9tj4sTbvzX
         L3+2O+8ruGPoog8FkkkMoM4BCLUbuarVa6N+k3N7veprFxhl8w3KxHveY5pWIiLWx52R
         jNtjonnXL2FtvFVOkA8l8tZpdi9RbAomG1VI9HPaa0HTD0nyAyffatXMfiwBVpeFz9dm
         YosoPEAq1XeC/ZD+iTHaaMPxAKxTGsmiQ2hTZKBb14EqKocLqXFADUaMIyvJK9FXhRoE
         f79Q==
X-Gm-Message-State: AFuF++knE4a1rzr5Jv2iNMceT9GtICcAI/OEhnYvNFl29X+hmLSopwrc
	Pb8YcaiBLpxfkWHrFGOrq6bm6vly+8kUGZIy80sTmMCCfnRLyWjZTYtzgr4aizXKrTVobNkRnd7
	pCIaCoYdzJuJwO1mN47S1ACnwfJP+vLhATWaM4wvptGOf
X-Gm-Gg: AYBFou3FKogB+Cqy7bPnxOMDDvRcSaQmeTpx74AcVl8Bd2EyB/wULa7D+OmKcGe+aKP
	0ulKQ9beFk9wsC9ThthzzAdydYzYA8t+yZ7HcYc6WhlAVCU48lzswijq+FZY46PsVQ4AyHI59Xu
	rbD6D/dLqM27fcNXSWB3u7dO/vxan26Kcfm9R9Jtpa5QQl/ZKL3Qc8I9/moEMHM3x6JzDlls4fi
	iWBZuzpZqEyC4LiNKLyxyS3iXKk/9oaKXBHCnD0ldLLbzdydL5kA0ex0aJ0vCReb8uQqWcFlD/t
	48XtYv5Jfs9Sb1buxp/gSAEdSKdZBVTIST2FdWqhCg1Q5VZiBDix1g==
X-Received: by 2002:a05:600c:4683:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49e7a655872mr82749065e9.15.1789476967992; Tue, 15 Sep 2026
 05:56:07 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:07 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:07 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:07 -0700
X-Gm-Features: AcwNN1XmsXyw-9kcjeoL7Cjulkir1XL4OulDqYZqSIusuvZtETwHk4b0L8AnkDQ
Message-ID: <CAF9RqJ5HCChiwhLSuxuX_weD2-mek5-YMiW=-W-52nWefC7EGQ@mail.gmail.com>
Subject: [PATCH] KVM: fix comment typo in kvm_host.h
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, 
	Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..681df0b96477 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2461,7 +2461,7 @@ void kvm_arch_update_irqfd_routing(struct
kvm_kernel_irqfd *irqfd,
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */

 #ifdef CONFIG_HAVE_KVM_INVALID_WAKEUPS
-/* If we wakeup during the poll time, was it a sucessful poll? */
+/* If we wakeup during the poll time, was it a successful poll? */
 static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
 	return vcpu->valid_wakeup;
-- 
2.54.0.windows.1
