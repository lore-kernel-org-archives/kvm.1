Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E216303A26
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838083; cv=none; b=ldwJDJXLWXPJJXRkiOJJKT+DGxbLo9or69An1HdmbMVTUJehE/g+peizXJJkFvKaT2zgUlkRvV2uZT/ks/jbfd3tZQ5oCDnZT/gu1hgkQsXMdXSbrQoyY9MTikDHcw70st/oc1Tnfsgf3cmvKeqTbgOQPPs85/5JtygoxFH2CCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838083; c=relaxed/simple;
	bh=I6W4M3U5C0LO6Qa0wQD+xffdC44snBWR6k9ZETyzMq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7FhfQxOwUe3hPYvzuvnwURORaE15WU/3g5r7P/8ZtG/Xc9X6RHzmMLUh+me+ntU0Ux5HaUQ6Tjk93yfnLBY5U5dIwnWYVFFQahOQRi5qpwBRal75Gi+RBkpjWHaQk1UeMK9twNmhxIDGQwW2AX9k+ffDBiN8kXL0noElfFig54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFm9fNSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFm9fNSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FBDC2BCAF
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 23:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772838083;
	bh=I6W4M3U5C0LO6Qa0wQD+xffdC44snBWR6k9ZETyzMq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uFm9fNSghCtzNU6IwzWjxD7jHiD0e1BHsT3A1C0iXE/fNN36ftmqADZDIaXSAz3oS
	 KohUdi1rjT5ZOLCQpDqVb0rof03FBiMKRWaghNJwAEvAwd6uong7ucGNvPUJKJ4SJQ
	 rZs3G9Q6C0orV+s582Qkz6NEqGxdPX3CvcXE/y4jo1DI7Zq0AUmmQatSAUtiSh86aL
	 Q6TxNShvzx5L2exaT2/Rg432PNUq5PRxMq7ggoatm+UgrZLb33oA5hq008V0xqY/bM
	 zwwg0/h3UjVWlOogEspWX9yAZW5lv+eXwDMVJj1QZF3l6kc5gjzBS3TYUTD1ZmvKNX
	 npkg5mF+x7O5g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9424501589so241411766b.0
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 15:01:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV74/8NYnxLaz3bngQbOGDRSBciMYmhUPRls2ux3XnM3Mvln0Gsel7wKoFPPoDCp0bOCpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzemnYcj39RMZX30mlaIeweDTaBB7Oxe/TI+BvSznb+Uq1LT9P
	ba1so4iKFemAGYfs4QCnR8a0vzqnxefqfGtE9GE/Wode6rnNB805Eliv06Cioxj+4xE79SfJxuB
	XUehPVaeUnIGlvPA96KcH8pHv/Jm/xXw=
X-Received: by 2002:a17:907:72d3:b0:b94:2025:313 with SMTP id
 a640c23a62f3a-b942dfb4897mr213053266b.32.1772838081828; Fri, 06 Mar 2026
 15:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306002327.1225504-1-yosry@kernel.org> <aar-gDulqlXtVDhR@google.com>
In-Reply-To: <aar-gDulqlXtVDhR@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 6 Mar 2026 15:01:10 -0800
X-Gmail-Original-Message-ID: <CAO9r8zO+sTttrKscx+9Sr+TECLrb5rHFTPThHYZG_e1qKSo+Cg@mail.gmail.com>
X-Gm-Features: AaiRm50vs2swz70u_HTOWE3CocsBXlJIjpWCDx3VaNJ77hVJzkg-sWu0PcGCIw4
Message-ID: <CAO9r8zO+sTttrKscx+9Sr+TECLrb5rHFTPThHYZG_e1qKSo+Cg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Propagate Translation Cache Extensions to the guest
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Venkatesh Srinivas <venkateshs@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"

> Hrm, I think we should handle all of the kvm_enable_efer_bits() calls that are
> conditioned only on CPU support in common code.  While it's highly unlikely Intel
> CPUs will ever support more EFER-based features, if they do, then KVM will
> over-report support since kvm_initialize_cpu_caps() will effectively enable the
> feature, but VMX won't enable the corresponding EFER bit.
>
> I can't think anything that will go sideways if we rely purely on KVM caps, so
> get to something like this as prep work, and then land TCE in common x86?

Taking a second look here, doesn't this break the changes introduced
by commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks
for host-initiated writes")? Userspace writes may fail if the
corresponding CPUID feature is not enabled.

We can still pull the enablement to common code, but
kvm_setup_efer_caps() still needs to query the host CPU features (i.e.
boot_cpu_has()) AFAICT.
