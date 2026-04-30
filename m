Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597947D93E
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575194; cv=none; b=sN6wU3f9lyhSKfz8uYkcnx6f0I97QkG1i/8E9LUiEYIqinuMOE6hVqnbn/hgCa6REc147HFqe0ooDsrnnun4O3e5GoCnZcND5tAbNEgFpuJ7PPQ4zFytOJobpI9Vq3Vw6Uf7fg0aVCO+cJjaH/4MGeVH8DkOeY3uKuNGgaxyLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575194; c=relaxed/simple;
	bh=wtBL2U0Xkh0eyB8blC88iUzhR5Ul+5Qw6+NY0rU5ToU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoHFSufOGkM+OZ6x/s+t/URY/bhqp7uBYmH/Ofefcy1VWMeCGcQlgrRE9Zjz6DAG/E+rqlTHwoPnrO5CQppJGVpNboBMFVdcoGhWCZ0cQ7IEYobhmulbH6wvbX55xShpRwj1eXSJ0l1L/nfgpUITRYro7c/738ojuzj7bZI5l64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2/Fe00U; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2/Fe00U"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so1775719b3a.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777575191; x=1778179991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBCWAdysHTAwufJ78WBJefPH7uJgf38wD6pxMISh4DQ=;
        b=C2/Fe00UaQUB/c2FlspHGsKujc5BaicgKfrn+OWcSKEQ/Ub2bd2hSs7/714gM0KJuY
         RH8HeEpEDSSQwIbVmAKGbNniGq3J7Z3IxfIfMP1UtHPhdUBIPg5+HmoX/P+zmkZu57qt
         dyjtwvWbozxuD+M/XlrvpdMGoDXYJgKs0ejlZamn5Ij6ZNqZrQBFpt+ggBd6hILHBxQf
         hFTp1JwLwT4x9wdUkmbGy6ggdQmQZJjTXF7fYOnrevH/tMlwMNUZ4DOA04jqUJTIHq7s
         JJa+0buT2V9MiBWGpsS2RI++bpswDbU1KGP30BJh+onVrEHAmD8jRuXdDaZFY77/KnjO
         SxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777575191; x=1778179991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBCWAdysHTAwufJ78WBJefPH7uJgf38wD6pxMISh4DQ=;
        b=i1iidByohEuOMJ3mXQbYX6nOwzv+QeecCpBBjqlzLd42ZeajVGg09w98VM1+ZQKgom
         Bm3KsNGlN+o9f7yVMsL1mnRLT7q6yQneKF055/8XVblI1sptyUAbUAlr1tt4VU0gr0wW
         //clED9PS6MycR7pecG5kzUHxtSGt92oCvqrMjPXpQeNlm1CRkNIQdlu++b0qIm+pTgr
         6DbO0mOtJn0UvCzUt2IZ2nmzKqHMDQ+8ulFr2rePbnoaOsj0J8IPvVpshVVISFeDtKJu
         MTEUDoalrt/6XsGXJD+m7gh9b1rlmCK37J8lKttqR9nZiu2Wtnba0m95smaQV79Z/FW8
         /p/A==
X-Forwarded-Encrypted: i=1; AFNElJ8RX5S75M8BuGsy8LiCz/iHvzm8S17XPPLiBy9JmtCad6lFH1F4KrKoTdG5yyywVhuZMgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0r5seHhSdTm9ZrBi24NgQyUgoMC0OLEH9qA6GfcQN3gAWy0f
	nZiLIsz5aAb1WAWp42ENzXRfHrfUL8DDZe11cGHwZSfw9lVQQoxy1ElcxzjCP3gHfKZJnWYbv+p
	LEnktXQ==
X-Received: from pfbdo7.prod.google.com ([2002:a05:6a00:4a07:b0:82f:b98c:2101])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d88:b0:82f:c1b4:8ba2
 with SMTP id d2e1a72fcca58-834fdc9a7cemr5359655b3a.47.1777575190877; Thu, 30
 Apr 2026 11:53:10 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:53:09 -0700
In-Reply-To: <20260430150747.76749-13-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-13-pbonzini@redhat.com>
Message-ID: <afOlFSfWO6oTXmk3@google.com>
Subject: Re: [PATCH 12/28] KVM: x86: make translate_nested_gpa vendor-specific
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> EPT and NPT have different rules for passing PFERR_USER_MASK to the
> nested page table walk.  In particular, for final addresses EPT
> uses the U bit of the guest (nGVA->nGPA) walk.
> 
> While at it, remove PFERR_USER_MASK from the VMX version of the
> function, since it is actually ignored by the tables that
> update_permission_bitmask() generates for EPT.
> 
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

...

>  struct kvm_x86_nested_ops svm_nested_ops = {
>  	.leave_nested = svm_leave_nested,
> +	.translate_nested_gpa = svm_translate_nested_gpa,
>  	.is_exception_vmexit = nested_svm_is_exception_vmexit,
>  	.check_events = svm_check_nested_events,
>  	.triple_fault = nested_svm_triple_fault,

Paolo, do you have any objection to adding static_call() support for nested_ops?
I vaguely recall you not wanting to do so.  But we're reaching the point where
quite a few callbacks are in relative hot paths.
