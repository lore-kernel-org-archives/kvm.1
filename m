Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284F38657D
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622184; cv=none; b=WhXSNp46ta57Aww45tADhcdDIRiEgcYcpdK00OODqEc9Oxy7fmPZmqyE0yaEg2T7N87ZnXHKdZmPFjBcFcr/QQn/QqHI/XZdsj8/hTT7HYpIPp1/7qC7xEPv+NyMb9WE5QjxwIWrhXbMzfdVkYW/dDeHji5/GG8xMAfL8XEN+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622184; c=relaxed/simple;
	bh=ldiMr/jTgzTdGMeoBI2w86wn+gSPvhUxkb0okNLJePA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QnqCn2L+Z39aY2SId3bB7jsUSxof8gLFFm0sbXiHpJU2DQF7Z6Wj8+FPOQYQuVdtZ4IpEjSJ6n/kq/f0vTRv+9N5ESIwRxeBw6VJREcKPf6E42JqW9KnEH3sEhvcCcZbzCN9rCLBd512USSLpvS+NFfH30no4W8J5k+LJIxH0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEIYJzLg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEIYJzLg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83836443305so3447486b3a.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778622182; x=1779226982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj9D1BDvzoYZj1BL80BFHCMOi9+t7uJndAu3/Hrv+98=;
        b=qEIYJzLgSaP51g+DDtvzYZVvnO54ZZpdeCy99IYYqNI+ZQ3QnHIyD4NCqa6AJesRyj
         mZlwuP7/cb4w7L/Z9P7GqFHG6yV1+MYjWx76IBtqCFsoKtcOWgozoo7UbgJCU9j0oH+e
         n0fkHzTqXZOhT7y3VSEHMh0ib4peFa+5YpiDHnsC/1/XZdyaGE04rp6gWFpIaBSacjwg
         7bHC+BXgiAA21hB4JpYsBRyQA2KleMWTE9E5HHYFWh0svBJCXCwbear3jCLEomeua3/F
         10UevhwMEzedvW/STvwhl1mCt+N55Rq8X+9/wF6k3UbAe0CFXcTo2rf+l/CXSjr1eoPv
         rKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622182; x=1779226982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bj9D1BDvzoYZj1BL80BFHCMOi9+t7uJndAu3/Hrv+98=;
        b=Ha6KC0v2w3FPzCL8NUNaDJtX7TlcnNnFbH1XNZaZfrx/tmVYwTyi99Nj3GAJHfr6fq
         Uk0/WIAJQjec6HrC51oQcdqchRevGeCQFUJrr/jXNlLxKqSXV3NQhRl5agKB+s6ZmzLK
         DyUQqNBo/Mp+8GDtegvqB9OKgJoI/bKMgMTwJs19rifOSHrKNCbIBzQm+ftRDdI/+GRM
         ZkYVH7iPwBU+0Q9x5tEVXhiep4FRExGKRZSdxThxwqJLx82KU+3zMplkUgEPYb2c9n5o
         LdLTtS0sd+4u9lF8KGpMmvrzje0FSGBJTiS0OcUIFx6gbc39GPFf0j3rZyAZSOwZIWbR
         /Itw==
X-Forwarded-Encrypted: i=1; AFNElJ8NrZwatzenrIUfA9yHRoMu4VFRNPIaCl/AcL2hb5we2HJq2oQ3KOnmWIPXtWyG/vKSkUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXcQjDcGDyyyKO8xHe7Y7O5jlg1SiG6TfXpGmd6Whnjmd4q99
	GR9zLh06J/JkzWRTqIRI5G7h/4Djwh+KhLHxA7YnpPOiv7+baqoN9bYMCx4cWohh9rNhr1fg/so
	o9HTcSA==
X-Received: from pfxx23.prod.google.com ([2002:a05:6a00:117:b0:82f:c180:a882])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1741:b0:82c:9f7e:518c
 with SMTP id d2e1a72fcca58-83f05bf569bmr64985b3a.25.1778622181819; Tue, 12
 May 2026 14:43:01 -0700 (PDT)
Date: Tue, 12 May 2026 14:43:01 -0700
In-Reply-To: <20260512203545.3031339-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512203545.3031339-1-pbonzini@redhat.com>
Message-ID: <agOe5WU8-wV6CMJt@google.com>
Subject: Re: [PATCH v2] KVM: x86: use again the flush argument of __link_shadow_page()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Paolo Bonzini wrote:
> Except in the case of parentless nested-TDP pages, mmu_page_zap_pte()
> clears the SPTE but leaves the invalid_list empty.  In this case, using
> kvm_flush_remote_tlbs() as kvm_mmu_remote_flush_or_zap() does is overkill.
> Avoid flushing the entirety of the remote TLBs unless the invalid_list
> was populated: instead, use a more efficient gfn-targeting flush (if
> available) and skip it altogether if the caller guarantees that a TLB
> flush is not necessary.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
