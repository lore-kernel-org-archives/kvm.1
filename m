Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E33495053
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998235; cv=none; b=hUzFY1Bm5KNoli2G4ioQM9QJPpbRDHipDjzFplgUTebGaktY1UwTVQ/11LCUAdMNlTWOjI4f1FDc22rw5dglTwIwGulFXQjzyjUMuwa6nCV8n6v+/i2txUHd9MckX+jtp6G0ABAUzvUirqNNufPLbAyaJ7RZtZ+bFqSNxdioW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998235; c=relaxed/simple;
	bh=5tx5XizZncVVrjtJjf25GLTO3kI5sA2X0Tbettr4tWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MinmJiLjU/TVJ+kKcIZrr01G+SU25nntCVLa7J4vBo7x++YtROJ/XtN+mLt348CuuCFG58QYPJ6Qcve2J9z0rld5CHGtfL7m6VbqN/lT3hT2hk9q6YQNrycA0lpobRMLmgeMjLdEfMWzwbQCFRdCg1tmBx6D7Lge6qXONBndVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l61FUIpm; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l61FUIpm"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8663802b58fso3273245b3a.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789998234; x=1790603034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGToDF/wkFG2nzRyC/j2VVCnqjpnpN119KpUk0dOnOc=;
        b=l61FUIpmbdLjhbydYiR/5wv9Nn7gE1MLcBF18HTJCM+tZdATUHNXR7K5Y149wVQyCm
         qqVRqVi7qn3q8DlzYCCHgSHTPPL7s+OoRfpTPW5zeYosZiCHltcgyfOVTGHNbTSU5cDE
         Xd7xqddeY2LtdhGQakIhMHZhvZt0fNIEX/IiCId6BqPHmjb89RZM+zaRkWJRQ+GkyDRi
         EnmUw95fI+K1NCPUPXEdXdDxapZ+FbDr4KIxKj9Nx//XZpm3husb7ozSAHyfP6F1zHkI
         NCzMkRldaPEmpZ6YCzgQDYvd22b04EJTBbeHOgxFuxCDZYNd6lk+oU6DQVWbmji5YFQX
         r+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998234; x=1790603034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGToDF/wkFG2nzRyC/j2VVCnqjpnpN119KpUk0dOnOc=;
        b=ENuBcs/zaYkrEayHOvVEDuQJSNtEPgSmGWH3RbKuLenkNbc8s94Z3Os1qdN+Aim8kq
         5Ke33ElFw5KExfUD2+3Ip7m1w7OvsA8MWE0/tp4UUlQuz1J8LDAPeW4Wwl5onzTeOVPq
         VjGPlbVR9cd4b2ENTxKc0Zn8slQ/m4O2bAjGd+ttgDsViQfD0fbzElSy4mFvoBQo/u01
         9mQT4xmpAPtXeP8ZVT+T4+HfQcPmwQlK15Fnebg4PJpGq1LaOtpcwlNCEyogLJbcAlPe
         seB5dtx89MJqL5I//Mh7EnZ9VVVU7sjZdBkKOskIQZsw6CiPrf/ywrXWGlWY6LqYjBb/
         x1rg==
X-Forwarded-Encrypted: i=1; AKwUvBxFJzuSk9LrcgameXLtoi7VrC0y1w6zusbl714o+CTe+TAERnN2XUdZgGfgvt1qeFHFVAc=@vger.kernel.org
X-Gm-Message-State: AFuF++mGA6J3+25QkPtgmFkeXQlKT2CgUif/q/FgCxe3lK8X9joEFA7x
	Vv4u3Cj2XnNjM8Q+k8wZOA6p4YG93PjQs6Y7QvSg8lyCAvgNXYeZsJZtlrkQcAkUMr4MF/xYDPb
	62c329g==
X-Received: from pfpk17.prod.google.com ([2002:aa7:9d11:0:b0:86b:a074:218a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a9:b0:874:705d:f64a
 with SMTP id d2e1a72fcca58-874decf71f5mr14455216b3a.44.1789998233584; Mon, 21
 Sep 2026 06:43:53 -0700 (PDT)
Date: Mon, 21 Sep 2026 06:43:52 -0700
In-Reply-To: <arEzv8b2IMHYcHsZ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165647.769231-1-seanjc@google.com> <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
 <arEzv8b2IMHYcHsZ@google.com>
Message-ID: <arE0mEJaW44HA39e@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 21, 2026, Sean Christopherson wrote:
> On Sun, Sep 20, 2026, Yan Zhao wrote:
> > On Wed, Aug 26, 2026 at 09:56:47AM -0700, Sean Christopherson wrote:
> > Do we need to update the code comment in __kvm_gmem_unbind() from
> > 	/*
> > 	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
> > 	 * cannot see this memslot.
> > 	 */
> > to
> > 	/*
> > 	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() ensured
> > 	 * that kvm_gmem_get_pfn() cannot see this memslot.
> > 	 */
> > 
> > to align with the above comment.
> 
> How about this?  Because the "rule" is that kvm_gmem_unbind() can only be called
> on a memslot that is unreachable, either by synchronizing SRCU after uninstalling
> the memslot *or* because the memslot was never installed.  Simply stating that
> synchronize_srcu_expedited() makes everything safe isn't the whole story, as it's
> specifically synchronzing after removing/deleting/deactivating the slot that
> makes this safe.
> 
> 	/*
> 	 * Note, the caller is responsible for ensuring the slot is unreachable
> 	 * before unbinding, e.g. by synchronizing SRCU after deleting the slot.
> 	 */

Hmm, though it's probably a good idea to preserve the connection to kvm_gmem_get_pfn():

	/*
	 * Note, the caller is responsible for ensuring the slot is unreachable
	 * before unbinding, e.g. by synchronizing SRCU after deleting the slot,
	 * to guarantee kvm_gmem_get_pfn() can't see the slot+file.
	 */
