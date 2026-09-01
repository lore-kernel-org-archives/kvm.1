Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DE41E6CE
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275221; cv=none; b=CEhnIxOm9ecugb+YUKcxoKIy7ZrwkBS8V47qfOvi5jp9GBivqybuOLXQP6+fnoYwDN+EShhK5ajB4bHwFdNYP+g40cEgqO7e2rrsBcFxsmaJ2cevFFlvJCLhdZeR+lYue+SSJQdgtuUhjF161m1WZnzKX50bxl0CHH9ELSfJ1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275221; c=relaxed/simple;
	bh=IO1d1IK5naV0clT1y60mbzjUZ1i1Ufx4f9zvROWWDdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJKA7bqqDzIrT1QX4fN8qBsA0vPthO+sX3mc/FeCOU4PcfTXlG8Uf8eNQ+HXO4UrHGDZfz9WFoes1RY7+nj3m3AmwfQQJh4I5hopKypTK8m4ks0RkHjBdP9OafSQolcyR+Sm8eO38QlGR+nMJQWVXg3SKa4uP/tPeiGDYt/L/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVzIIKHI; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVzIIKHI"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2576570a91.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788275219; x=1788880019; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gW8X5PJ+vB6MltrnZZz8mv0H9sxjQGZjiNCW3Xegwfo=;
        b=GVzIIKHIkORbnLsLka2BlNxwyaZaKuD/ztZeqjB4UQ8IPy7P/64cQlHS2BufEgA31+
         E8eTGRxo/b/YI8Y2TZbbn9ENA+r/b2ZpmssswX+U5FhohtUXPI12BhLXSdjeFJI5BWkx
         PgPGAM3KOrYoi85s+jMH0a6o9o9rp3Rr4MjGcdAGEdE4ysQGu0IuGKLi2OQLmv11ey5d
         4NzIsabObDT3jV9XuU0XMJgD60ts8+Jv1pi4+2FEbbmeXhZcuxSn8jP+ArfUFDzauxy1
         dk5KoazzVo63Q0/mzsNDyPDfCoPxHgEB+2r/LmiCDLsMdSQFmezlp8mwU2OpcxUXAfvG
         ff+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275219; x=1788880019;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gW8X5PJ+vB6MltrnZZz8mv0H9sxjQGZjiNCW3Xegwfo=;
        b=VWuDpo+K9T0PAiKXatzvt6bjh8IRuQU2iGgk/xWBBJ5gbzN2x63ZK3Ht3GvQY6Uc39
         pJ8k452rFWLtkjVz2nTkFnSl0PdXFQbNfeRb8N0COJkXfjKdd4FOTF2qk4fS1bxNoDOd
         h0vUZcTXvlqmJenwqVN1gGbUfRHnPyRXE1G+95P166aXq60hAV6IJ120mGf1YF3KEP/F
         x7BXrQymm6FkNNg3zYZ4UB3rGbF+c2vHSE5ZcRXMXkkC4i9h7IRuF0z/MbQ0L5wkpz2Y
         J24qipAVVAWjrOekdtc8+jn5wOFYSO80ei4fvCYed124Qo+lJlUDbWhkdAMpMaYHTnD3
         OpdA==
X-Forwarded-Encrypted: i=1; AKwUvBwoCGJ/Z9MQLe++aHGH5+wxYh+qlFhIHw8YxamfhkedNkAYCzfATAIJUOT4ByBvbORUC8w=@vger.kernel.org
X-Gm-Message-State: AFuF++kIk2vpH/olKQqAeA9HXq2nxTefTeEiuRVl1R1NKakKDMPXYor/
	wjXpZVmSdgfMBG7iTAfkAJTR9tpA01WRKmX0AHtDZ4cBg1OsKB3mbsOH7l9Xgwagi45ar8/xhdp
	HJkHWpA==
X-Received: from pgee16.prod.google.com ([2002:a63:1e10:0:b0:c9a:53ea:434a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0f:b0:380:fead:448d
 with SMTP id 98e67ed59e1d1-396d0fd2a75mr54462733a91.13.1788275218580; Tue, 01
 Sep 2026 08:06:58 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:06:57 -0700
In-Reply-To: <20260901-gmem-selftests-fix-v2-3-5a273153354c@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com> <20260901-gmem-selftests-fix-v2-3-5a273153354c@amd.com>
Message-ID: <apbqEfeCQhgdAvKa@google.com>
Subject: Re: [PATCH v2 3/4] KVM: selftests: add get_numa_mem_nodes()
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>, 
	Ricardo Koller <ricarkol@google.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Shivank Garg wrote:
> The xAPIC IPI test uses MPOL_F_MEMS_ALLOWED to get the memory nodes
> available to the current process. Move the query to numaif.h as
> get_numa_mem_nodes() so other KVM selftests can use it.
> 
> Call get_mempolicy() directly instead of using the assert-on-failure
> kvm_get_mempolicy() wrapper. The xAPIC test already asserts its two
> node requirement.

NAK.  This is not an improvement.  get_mempolicy() straight up should not fail
for this usage.
