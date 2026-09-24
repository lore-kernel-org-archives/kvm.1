Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523894ED1B9
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286905; cv=none; b=LbPQ4+hp704HbDu1Q44rejMmAo26lcIe3ySCs2ssxcu2VVml/s2XwWcVcfYqIpB6xaAvPAbJGfS9YyoHT6vqiPprrWA+/pyEit8pDKEn07EAaAfSiax0WLqMUGVIa5WesDJhifY4CdOWkCWPhVy02OdPn7SbDtNjz/di+2ueti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286905; c=relaxed/simple;
	bh=wANjnZ6VjHCT3Et5duiCN/uEpRPHOryOydD78oDxXhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tsjeb6dIHSO0Ub0h7FfTK8nTZt9d/rqVjwmDuYV8cGzuH8aAttragaPe55Bq6REwqVUxIG3KQjYsairJB8FpYqmR8dbwrkSG+xz8sEwjuRxDf6Tvm5eLRT9Y0YcMa3ytlIaHr6xdFOKsqniOp6rdd+sc1SL2x3a9qoyvm2dBMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isFqEYi1; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isFqEYi1"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a0ae3eac32so301936a91.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286904; x=1790891704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dc/37vZOnRoLP9xi4DdWqpUDaxAkc6wukk/aoyxwa2M=;
        b=isFqEYi1TPI4ecFAPQDGSUMnnaJrjULGOQ4xwfRz+TtEmr84ule3MtyLnFmY3tvkEN
         /cA08WXePcHHcXZUV9fHXOqaIAAE6e3HxO3bYtubBFGq1phfe5noMQNgepo/fgH97Az+
         UIisC0yDGQfQG/0mvTz4qMj8dM/0LUZGUi90lUduF6OghmEZO7UYEQ7iEobaQMphC9Sg
         8CDNlaWq7fh04glEgb4rpfVXkEYdLK3g+04SLkLm0uVPAx5QETq2cTg2cBq/e5HWSCL5
         DdoZqIB4fZFjxOCg7pljUTwRCXDFz9PY3kUgXVXUpDwHRQu4926NELv0a8Vs9Vy03uPx
         99Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286904; x=1790891704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dc/37vZOnRoLP9xi4DdWqpUDaxAkc6wukk/aoyxwa2M=;
        b=eSwo+AzsxrLTa+HYRd1DfldAXo+4O+XXmxujvDxpAVSpu2Zj20saqJJkZcJX6LEtJF
         tgsBUkdmtYe3U74PFad+58nmDy7YxKkcenC8cP5n0Y9BYn2VFgvdAQj0luVlbej4dHCj
         7G4KMkjZhpqU+TRQJXvrtqkRttpJyquvic398Sf78xB5/free7yVwIy+5MEyy81WtJDK
         PudhAYVUiXJbWDi5SSRq/3emgbUvlxpQdoNAn+s2jBUD5FvoFYs8DeC13d8HapGpHc9V
         tysO/7HOgS/NN1QldSRccQDgE4qnCAQLoqy+lEa1BLy6nr1ULFio38MF274GyBpm5ZKx
         1EKg==
X-Gm-Message-State: AFuF++m8tBrM9kVV6EA/HgN6OMPO91/0jZvMEIixKnzNx2lLRxI92SAq
	hvg1fDHnVH4FF1vKwxrEF8as3GitnGiOjMIxH8S3IVh90tazJGwysHGRA08ZDBN/eo06bfkxrbO
	jvqvRBA==
X-Received: from pjre4.prod.google.com ([2002:a17:90a:b384:b0:3a0:618b:a5ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8f:b0:39e:6c69:f478
 with SMTP id 98e67ed59e1d1-3a098cf4ef8mr3712540a91.55.1790286903417; Thu, 24
 Sep 2026 14:55:03 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:52:05 -0700
In-Reply-To: <20260921235656.1107929-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921235656.1107929-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028366129.2006410.7179106384799013251.b4-ty@b4>
Subject: Re: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used
 for failed VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 21 Sep 2026 16:56:55 -0700, Sean Christopherson wrote:
> Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
> to stuff the exit reason on a failed VM-Enter so that the magic can be
> reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
> defined value (though the whole "dead" thing makes it pretty darn obvious).
> 
> Opportunistically add a compile-time assert to ensure the KVM-defined exit
> reason never collides with a "real" exit reason.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
      https://github.com/kvm-x86/linux/commit/d85f7dc8cf3c

--
https://github.com/kvm-x86/linux/tree/next
