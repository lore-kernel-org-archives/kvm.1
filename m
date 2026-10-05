Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD832ED3A
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235617; cv=none; b=l+14bXhCimVIb9EC3HoR6sRx8nEXTrDQ/90+kmicU32Q6Dvbr02QuUlS2Oetf71n0MiW0ScgKCMkC+nxYH6d2HKemgSVya5Lj785YkAjhffxvGWLwK7AC5VJKsrvrK2+08ofqV7G3JATVB67Dl4u56Ura06eT2M8cUyuo6PNUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235617; c=relaxed/simple;
	bh=dViAwycqlhC94szZBFseDic4iSpt+fVVDuPkQGr//aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3BumkZjN0jUYAJZdxLt8d6elIZtML1o6dfjI2anFn5e6HNGAtMRXYrZqwAsHn2AhuCbcTsLCsUWO8oxWAGhrL3u24tMPohB0ORL/t/pfXlDUGxQj240XuidliNIRew9yqEuCWfu5UMz7oI/w0hz4oKNThKMzXX4lcZ39P+D9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5yPwRVT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5yPwRVT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b445a84fso10505ad.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791235615; x=1791840415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0delO3SDUwNPg2/XER4kYXkLDt9VJFcjmgwYxx8hZ4s=;
        b=b5yPwRVTifaYcBsoxPw6MxDzxsEwwok3ASRv4cIvZB4KURDasgUcr7IXiSrD88EPxf
         G3ByTECAFZSaBQnix3ZOJOZD6agb7i3lhHK3+OJIm1lUlsiw3rX3AJznBYMzA/lbhoNA
         l5hyLJ96hiLK5XBDTIhV+f+acDF11HOgh0wVEDRP+Dap2kYM717I2hd0GZktGhNmww8G
         xzVLQ5JZCwWy4DtuKWl9SgbtIbQIDRdSgGwqDC5iiKXJ6wWMlRMPEWpq5UFFwJsopqD1
         2YozZG6YjpCLfq64cYb4z7DFFpKR5wzYrZTATMi7OqwlTj+fYEqUyNZwZV4sPHEWj6vN
         4dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235615; x=1791840415;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0delO3SDUwNPg2/XER4kYXkLDt9VJFcjmgwYxx8hZ4s=;
        b=B9224ML4b4a/yO/GCXKJDmaFO47X3ah5VzV2hlnPWW6Iwk7xkKVD1sKeFe4j629yrD
         51DxelaQT8bZuTB6OhOqePdSuwLouC14fMxCZMFxGumItoYh5gW9AZY5AuYvpMjMImf/
         odFbxOgSsrQ2xs4VLdGbu58RO33eF3iiE55CIeL4XX1dLmR3rnuy75gwMHRpcilghgL3
         6zwmuB1P/XzwWd4TQzEDZsutnlxQmhJOFGQKnjvWBbjg5ZaTkEcaL53ERIm/AraABh5/
         SEa/B1VbVoIwxfrKJ+dAorfNtQTPek6lEk13vHbJ6x7XOJunwEnDs/opXd/nnTFAsstx
         5FVQ==
X-Gm-Message-State: AFq9FYK5C+u0upwplF45zkyWxXXbtgwyuhvgWmYA0KZC8hlaXfl47VqE
	MnUBvfHZke5Upg4qXbAiAi7MCxcLrd2E5CdYpwkF0cHusEAfz5+7CfKAzN9nukcCaPwz8nuCPs3
	AoqpvVQ==
X-Gm-Gg: AYBFou3NB18YsvS5OfHF9mSoHJjGkFVWhjDEL2Pd4ORze9cQx460rSAi4LjGFj+7OzH
	VSgi3UWoo34VT/7jxg68tz6WBu20kfQzeJIuZ8oOUD2d/aWAEuOdrg4KPadw2JwWuR3FQ1kwptz
	WMUGaXRRi4JFaYI7G1XOPcDTillKa3/ufPJ0hJm2ypWo+qFnywpHFmWJ7aPLKDAx4Y6jRJoNy7y
	gUTpE3sQV34gFNI48uSomWHlLUSyy5VFoL7SvK8EY2XtFpejLzbeszYkFau4JHGJfg6WQBatbFS
	qk3i1aJY+HiC4Csrso2vM9lseLyrsQdxuOvyBcOwg+qjdh6P+RqZoHia0NK7Pn1tf/X9JYSMx/B
	WkyURM1s4t/q22kmpcnt/qwi5aK9ShSAnTNeviiEpWW25k9xo2zwz1akacczJbNg0xx6ZzJyeWU
	3AatqOsKpoq0cUHeArq8AJ11oAXJADgx1MjXC20+FYnKaKdoCDDWOaiefToo6pMbJmn7rsdyKuK
	+7jPCXDFJ0ZzUHdcWaLzZnHoCQe/3XGMg==
X-Received: by 2002:a17:902:f60f:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2e5ccdbbfb0mr556185ad.9.1791235614423;
        Mon, 05 Oct 2026 14:26:54 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543e8478sm1491257a91.17.2026.10.05.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:26:53 -0700 (PDT)
Date: Mon, 5 Oct 2026 21:26:48 +0000
From: Lisa Wang <wyihan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v15 03/23] KVM: selftests: Initialize the TDX VM
Message-ID: <asQWGLagCRTuEaEk@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
 <20261002091331.1148B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002091331.1148B1F000FF@smtp.kernel.org>

> > +
> > +static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
> > +{
> > +	static struct kvm_tdx_capabilities *tdx_cap;
> > +	int nr_cpuid_configs = 4;
> > +	int rc = -1;
> > +	int i;
> > +
> > +	if (tdx_cap)
> > +		return tdx_cap;
> > +
> > +	do {
> > +		nr_cpuid_configs *= 2;
> > +
> > +		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
> > +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
> 
> [Severity: Medium]
> Could this realloc() cause a data race if multiple threads attempt to
> create TDX VMs concurrently?
> 
> If tdx_read_capabilities() checks and reallocates the static pointer
> tdx_cap without locking, concurrent calls might race on the realloc(),
> potentially leading to memory corruption, a double free, or a
> use-after-free during test execution.

In KVM selftests, VM creation is performed on the main thread during test
setup, matching other cached helpers like kvm_get_supported_cpuid(). I
don't think we should care about potential race here.

> [ ... ]
> > +void tdx_init_vm(struct kvm_vm *vm)
> > +{
> > +	struct kvm_tdx_init_vm *init_vm;
> > +	const struct kvm_cpuid2 *tmp;
> > +	struct kvm_cpuid2 *cpuid;
> > +
> > +	tmp = kvm_get_supported_cpuid();
> > +
> > +	cpuid = allocate_kvm_cpuid2(tmp->nent);
> > +	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
> > +	tdx_filter_cpuid(vm, cpuid);
> > +
> > +	init_vm = calloc(1, sizeof(*init_vm) +
> > +			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
> > +	TEST_ASSERT(init_vm, "init_vm allocation failed");
> > +
> > +	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> 
> [Severity: Medium]
> Does this memcpy() copy uninitialized padding into the ioctl payload?
> 
> Since allocate_kvm_cpuid2() allocates struct kvm_cpuid2 using malloc(),
> the padding field can be left uninitialized. The kernel's
> KVM_GET_SUPPORTED_CPUID ioctl does not clear this padding, and it is
> subsequently copied into init_vm->cpuid here.
> 
> Because the KVM_TDX_INIT_VM ioctl strictly validates that cpuid.padding
> is zero, could this cause KVM_TDX_INIT_VM to fail with -EINVAL if the
> padding contains garbage?

This might not happen in practice, as this allocation happens at the
beginning of VM creation. It would only happen if a previously freed
chunk with non-zero data is reused by malloc(), polluting cpuid->padding.

Still, we can set cpuid->padding = 0 here, or change malloc() to
calloc() in allocate_kvm_cpuid2().

