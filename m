Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5334888F
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528626; cv=none; b=Rq2VR1KQiOG0i8QdGKTJWdvgDSNWWqmV3BIetwGcb9Wc+mzz57y/YYNIfJdoTCBh/4WWZ8AyOkW2dVAXa4IoDM8qeT2EVIgh29B63s6eSFchYTAfPk8FZdDCcucae1MNPpEsdL6WQsUHcPLxhVhcyyKj159tF5RN/SAu27GEMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528626; c=relaxed/simple;
	bh=UdU/ctJ7nwZVXBbAaQ7/HWpUzSsjaRxz6+LT2oIZV6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sxr9MyOgxiMvEU/c35YHUG4SSzLsUvsi0lwY0lgir4fQhUZYikUf8D2zqqetW58YtmvX70TjxcKBh62jRQl79kOHs3R/nQlSan35MxtpPmC+6ql0W8hGEEKe2fdHZPzPOyL2HTqpN3rn47BCEZPJPijYjyP3JlIDYE8TQWVxCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg4euuDX; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg4euuDX"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38edd45cbc4so1479300a91.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528625; x=1786133425; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUb0FXAJQQbYRcsf05xKruWeQxq5USJJyQBWGslQZsY=;
        b=Jg4euuDXibjpziXuDEgta1KGONJOwGvQIBZR7K67wJP/qDYn7wKpBQERV1p5OHtbvY
         PnIHNrb+W4H4TjV5NSb2rrwZWNLCm6mF3X+gGrFFVz73pqi+YQHeiL640YmKSobpxK0c
         +Oao/6wwGrn/TWfykqApsgF2rUVo177FQGG79mWNk5bphpvShGD1XD4mryBeruw+0vZ2
         0CmDavnbDtC9/q246xVafza2DB3n9goypB9jbe6pfch475BM9oP4vn60tZ1MevKg/21C
         C6ZrjQAiYCBM6MW7LTQBntVxQ/YqJkn/RlNOyVTkgj5GCqLnI5bUWB7SeIw97rzvx6Kv
         /tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528625; x=1786133425;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUb0FXAJQQbYRcsf05xKruWeQxq5USJJyQBWGslQZsY=;
        b=GmE/uQlEgNH2nDz/QFb+ydJktM73eWWLtQlgYCPUHuCglwPpuWZy5vRLU4PjJ04kHD
         8/7N6CjV2/GzMA8WKLEHqX7kYhFB7vph2TqMHI/T0VfbzHD3bpoutZ22u/BdSHUGZoDA
         g+1v+63nAsKqkRMA8BVsPFp9TrV/Fxa3L68gblyWbFszz4c5YgNxVe34DkxrlDU9EFxW
         H7fr9nmKsYz7/LaV5Hss1RPZk+tG9P98PM80v2lsCforTK5Uj8WPxm5Nb2u2e+lGQHg/
         IjABBao5r9uBkhbLDnbPQdob5LyQQFo1j5QVAqK8HxNkH8VEU4IL+/Tbo3DcD1NcWRbp
         ZM7Q==
X-Gm-Message-State: AOJu0YzZ5FaiVcsXnnkpVadrz1J9F2yd15AsO8qo8oRg5jn+AXNcb7W1
	VuWKhsEWj+IN4VfAsnR4Paq2rcASrU5aiYU6RZV63BNlJiydBsSL82GjWJzTjaV1BSajtCL/qIE
	zfKUpHw==
X-Received: from pjj16.prod.google.com ([2002:a17:90b:5550:b0:38e:68b2:e344])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590f:b0:38e:7a05:9c0a
 with SMTP id 98e67ed59e1d1-38fbc493f0bmr1047002a91.18.1785528624490; Fri, 31
 Jul 2026 13:10:24 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:46 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552814603.2702891.2747556663887859375.b4-ty@google.com>
Subject: Re: [PATCH v6 0/9] KVM: guest_memfd: RECLAIM+CONVERT cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 23 Jul 2026 14:08:02 -0700, Sean Christopherson wrote:
> These are the cleanups from the SNP VMSA series.  Well, that's how they started
> out, now it's full into prep work for in-place conversion.  Oh well.
> 
> Rework prepare()+invalidate() into make_private()+reclaim(), with direct line
> of sight to adding make_shared() for in-place conversion.  Have the x86 backend
> use make_{private,shared} (no reclaim()) for SNP, as reclaim in SNP-land just
> means "make shared".
> 
> [...]

Applied to kvm-x86 coco, thanks!

[1/9] KVM: guest_memfd: Pass the number of pages instead of the end pfn into .invalidate()
      https://github.com/kvm-x86/linux/commit/0f0893ac5af3
[2/9] KVM: guest_memfd: Rename invalidate() arch hook to reclaim() and isolate it
      https://github.com/kvm-x86/linux/commit/7b8529e70a11
[3/9] KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
      https://github.com/kvm-x86/linux/commit/f3c073e25476
[4/9] KVM: guest_memfd: Drop the redundant printk on arch gmem_prepare() failure
      https://github.com/kvm-x86/linux/commit/0f68fabe68fe
[5/9] KVM: guest_memfd: Add helpers to query SHARED vs. PRIVATE for a given page
      https://github.com/kvm-x86/linux/commit/19e612cd59bf
[6/9] KVM: guest_memfd: Only "prepare" folios for private pages
      https://github.com/kvm-x86/linux/commit/3df611b5a04e
[7/9] KVM: guest_memfd: Rename prepare() hook and Kconfig to make_private() / CONVERT
      https://github.com/kvm-x86/linux/commit/2131c4f763d2
[8/9] KVM: guest_memfd: Explicitly pass number of pages to make_private() hook
      https://github.com/kvm-x86/linux/commit/fb50ca77b672
[9/9] KVM: guest_memfd: Make private exactly what can be mapped on page fault
      https://github.com/kvm-x86/linux/commit/2abcdf03fda1

--
https://github.com/kvm-x86/linux/tree/next
