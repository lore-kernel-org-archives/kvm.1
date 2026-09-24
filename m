Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399C49DB80
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286821; cv=none; b=kNVIaOUcn2yTxr3wAMGuGRBg3Wyl33xdGgLV4A7wAn+FdtbAdEIBpfmVW6ZQK6rASHITQ9zfIo57siF70Ih0PtinyUoED4a8O/wP2cGSd61dGXUCuF/2AA1iTduoWCRUFIoj8Z2dP576wq11nNwczwC7ZcQv+Fx8q+jsrcLngoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286821; c=relaxed/simple;
	bh=TIp+gIIdLq4cktELq+hOpwoqupHiH3XvzAWI33S58iY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezXX/elNkJ/ViHVNpm1HY7HYQlJMNu7Sg37Ra0K7xMuygNSTWL8otHkYHeUAwbwdfjFSdofn9jtz+kUjKkzicblBLvg6ZxnBYjJ7CzTLzG0SUtoCEC9/CKXrQOPHdkJErem/3Ci8O7/7IzC44gevuMrp6IWt1KLV0kG5fFfga0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRhgWsZC; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRhgWsZC"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so1514145ad.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286819; x=1790891619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Btaghd/Mv+1f+gI69Pd/U/027XFnS34zNCKX9stSM6A=;
        b=vRhgWsZCULQspL3VOACTDa+IkoSPtgY7S6rZ3XRl/btt/7++ngSVq7oLtVZPpokpxm
         iaW1QE1Tn1aRVvqX2XFNKe2KrJDyZguLuPwZXsjR34w3NXvkrHcBxYCBsnfa8vVBbJNC
         E8IVvkIaAxuac1nPwHZpk3dSAH3Ftapm18I2ntZC0Ms2D6HGjFlY0FFMKyCtV68K68ll
         ia+/v81A7D7JoiVlaSwZYZu9aaC8SJeYDEFJQLDgELcpEDEuikzZIapchGa+AoL1bpR3
         nyjkp5V0A3Sq2baUhRoq0mx7osLZR9ZuAUJySeJRDF1vOBfwlIf9GpS3F9CuOQ1gTUg1
         CWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286819; x=1790891619;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Btaghd/Mv+1f+gI69Pd/U/027XFnS34zNCKX9stSM6A=;
        b=2VkghFPSNKSaOK2LAIuqiqJiNiWcGVZBysz4yZo492c1DBUerMoLMenMLRb1Uhz0xH
         mrRdn95iNEE0vFsuUPHWWRI+N8PRRz37n6A9OXX1oHmT5+KQh3iDT18XBVi/JK0Ph76x
         KxoXS8dawnuaZCncDDLmQGOOnB8XuQRSjUjoc4DaGRgZFyLdhDcSoHvABdeXsLg6Yb7h
         812lGBUI0o+/kc6YGJQxx3C1jU5uq/myP4Yp+Ip2p6xcEBGUvV7yh2TjgbHaXJLXXavN
         szHw2ZO1qOqJVto8gEnZNOf6kzDJzHOghfWbwt5ajZ9X40kUyJVC0m0x+38KhoAhx9/1
         0X4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwSSUTfioi6xpSC7pzwwUwvcmvdngpHGrkCBiQFVHH6DXXGpdh6nH0Q6CY+zy0h9Qy6zM=@vger.kernel.org
X-Gm-Message-State: AFuF++nrq8SStqE2qQhx4l3q5cGiNWI820xxappqJAL0TIoJ3hy0dwAP
	7JElQ0r3Xo/Eb7NOFfewSbkkBrCCJrs/Zz3u95fizIcLk5H87HHuYTwqgZW6+0RWgZMjj9QIhKU
	X9xgN2g==
X-Received: from plss20.prod.google.com ([2002:a17:902:c654:b0:2dd:a9d1:e5af])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26d0:b0:2db:257c:9fd5
 with SMTP id d9443c01a7336-2df7dc2a162mr30302595ad.16.1790286819065; Thu, 24
 Sep 2026 14:53:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:51:53 -0700
In-Reply-To: <20260826165647.769231-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165647.769231-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028369147.2007668.960049765709883203.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 09:56:47 -0700, Sean Christopherson wrote:
> Add more context and information to the comment in kvm_gmem_release() that
> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> from slot->gmem.file")
> 
>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
> 
> [...]

Applied to kvm-x86 coco.  I'll follow-up with another cleanup for get_pfn() at
some point.  Thanks!

[1/1] KVM: guest_memfd: Elaborate on how release() vs. get_pfn() is safe against UAF
      https://github.com/kvm-x86/linux/commit/53c34396c19e

--
https://github.com/kvm-x86/linux/tree/next
