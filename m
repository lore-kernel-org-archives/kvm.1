Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683337F8A1
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855839; cv=none; b=GxT+6kwUK35veuKJ958/f+Esx57r5+sEHnFEUos+PRVqGyk2DMRoENShYwsXtPjK6irJaFeCpRJIhJsEnUXB8SMBGcQ6hyyQ4P8pBDX0PDSXylWX9xENA3xjYvjH7UFmRzQulLdea2u1tRJQMS7NoB08Jnn+XCDOZ2IsTQrm2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855839; c=relaxed/simple;
	bh=fg6GTljxP+sNZrgLDUd34929OGbtblqfj2IPZjIvfdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U8fuP9CCj40o/8WU6C0YmjVV+h4j67BzW+wrrN321rYI9mU8rkiIJjt7a3sqnNhqTjCq7tCIcqXIKO5P4cYBsm2B50Cpmtdv2KpcPlQVBsl6cfeatIJk19WUjAKFeI93Yv7P1bv5eT8HNiJ6YgwRnzZs/VUUvemArhZGLmdKdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KObc1aSU; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KObc1aSU"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so3327a12.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787855838; x=1788460638; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fau6peshe7Kd3BC89rhl/hcEomF/+4LQ+lryrOtlT9E=;
        b=KObc1aSU9GON1K9HMRQJPluCdT4esqEm010FGYXVjcIhoAl6gLQJq4IKV46TvfEtOr
         Fa3Ks27fZGFWBwsm3sj1iZXAO/KkPrQ/ejsU1Ziqp+cNbd1UDLF7jHgbq8+rVCMkrCwN
         QyB5/lN6KMIq6M5dlRPaydswQtmN6tGWbYI0dYSvDYlEml44cEfwSKQEchgTXMQJrVeq
         rjk/JuzwmOwzD9ieCGNQKm7pjfi4gSsV+zgGqdvknjEMvePKoF7XQ1j5R/zJl5s6hrFT
         YjaPN7M4eeav+BC+VY5tOjKhUKINEJIgPH7F0iwBrpUGgqfAn9ezirbXAn8uzcVLVAl7
         b/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855838; x=1788460638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fau6peshe7Kd3BC89rhl/hcEomF/+4LQ+lryrOtlT9E=;
        b=Ty6/gVTsrGcq1IYJT9cMRU79DrwqVVLWsf8xeb11gNYZV/gNEnHcNdZEiNPMAtxZzX
         mfIEFJB+3iXrlY5dJqY3dJHplAxNKizWNJPoV+SPubG8BUFkKS/HL6Hkc+fyXDgIS/9h
         UBt3xDMax3Y/dvbfJBxMC2qIUs+dlnhNysmPyVJGjJ4Zga6glGsvJBGgoiYNyVNlFyBK
         K3yU1W1QPhH7gC/RbaUbFTc2VBcKKBXoO84uecr4ooJHUhyCni2wikDYkfeFD0jg93Si
         Hz3no9wYaR/VHMnKaICgSMuAfgtYy7INW4icJJpZPLZMJUFqSFhzsZ5cb6tUvI7h0Og+
         HLXQ==
X-Forwarded-Encrypted: i=1; AHgh+RorL+L5iupUSOlms1rq6b0f5pJ8PnjlVjlF/DOB3z5hIW6Ua+qVTepmiK4iVm/879rMS/c=@vger.kernel.org
X-Gm-Message-State: AFuF++mHwrjApPcBMYL7zfH9FoZnPfluXcqyRIJxJupzL++N9rk38JQS
	2E2QzTfRGgieTKursyosgFhZ7kqGiIBBcUvvwp7HSP0LCCHQJ0elJXS3QCQ+DCMQ78mKYvMIujl
	r55H7ow==
X-Received: from pgcga11.prod.google.com ([2002:a05:6a02:668b:b0:cbe:e160:452d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258e:b0:3d1:8876:fb1e
 with SMTP id adf61e73a8af0-3d26298fb6fmr1977514637.0.1787855837632; Thu, 27
 Aug 2026 11:37:17 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:37:16 -0700
In-Reply-To: <20260827110558.457891-1-zeng_chi911@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260827110558.457891-1-zeng_chi911@163.com>
Message-ID: <apCD3F3oOyC6E5oN@google.com>
Subject: Re: [PATCH] KVM: Release reserved xarray entries if reserving memory
 attributes fails
From: Sean Christopherson <seanjc@google.com>
To: Zeng Chi <zeng_chi911@163.com>
Cc: pbonzini@redhat.com, chao.p.peng@linux.intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zengchi@kylinos.cn
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> kvm_vm_set_mem_attributes() reserves an xarray entry for every gfn in
> the range before modifying any attributes, so that the actual updates
> can't fail partway through.  But if one of the reservations fails, e.g.
> due to -ENOMEM, the entries that were already reserved are left behind,
> as the error path bails without releasing them.
> 
> A reserved entry is XA_ZERO_ENTRY, not NULL.

Lovely.

> xa_load() hides the difference, but kvm_range_has_memory_attributes() uses
> xas_find() to check whether a range has no attributes at all, and xas_find()
> returns zero entries as-is.  As a result, a leaked reservation makes KVM
> think the range has attributes set even though kvm_get_memory_attributes()
> reports none.  On x86, the next time mixed-attribute tracking is recomputed
> for the range (memslot creation, or a later attribute change that straddles
> the 2MiB page), hugepage_has_attrs() treats a fully shared 2MiB range as
> having mixed attributes and refuses to map it with a hugepage, until
> userspace happens to set attributes on the range again.

I'm inclined to fix kvm_range_has_memory_attributes() instead of unwinding the
reservation.  Because this isn't a memory leak per se, e.g. if it weren't for
the false negative in kvm_range_has_memory_attributes(), I would say this is a
complete non-issue (there's no leak, just a maybe-unused reservation).
working as intended.

I think it would be this?

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..a01b2af1cb17 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2447,8 +2447,9 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
 
 	guard(rcu)();
-	if (!attrs)
-		return !xas_find(&xas, end - 1);
+
+	if (!attrs && !xas_find(&xas, end - 1))
+		return true;
 
 	for (index = start; index < end; index++) {
 		do {

Side topic, does storing NULL even require an entry?  Based on the above behavior,
I assume not.  So can't we also do?  This feels like deja vu though...

@@ -2573,7 +2574,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * Reserve memory ahead of time to avoid having to deal with failures
 	 * partway through setting the new attributes.
 	 */
-	for (i = start; i < end; i++) {
+	for (i = start; entry && i < end; i++) {
 		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;

