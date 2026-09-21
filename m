Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3E4A3D4A
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999613; cv=none; b=tGL41x+DI6uvxpV729Qd3aiTm0DVhTmD2/KDBmy21SJDXsdOqw0W6pPyxudAP13RPfC8RZORi0jZEXREWdsJWTYGWBSgw9HRXI53VAcNCIa5LIFJ27CIC+6TdufReieugN0/nUgsOSjgN3Vh5bdOJzazxyjfKHHj3xwaVDseH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999613; c=relaxed/simple;
	bh=9DbB+fO0at60/guM4JWrHQTN+GOYW1w48uWzZv0KR1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dd1S7DEi3FNEWucMb07BaXmAMA6FnLhjy3eIl/foPCRt84HF5kiXHHkYlKlIO735tv2BuXFj4HXxCVj68YBBplCNiwhKVAJdMuQkggLYxV24GRiR91nVn7U4ACnC3PzMsBN8C/WsY9XfYJriGql0ckfBPGlieKRV2IA2whqgEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEMoeZAH; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEMoeZAH"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86a74698972so3507521b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999611; x=1790604411; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFozjASAAkxsRNEYPT4IGxp7pcPM6/9Z8WMRlei3dvA=;
        b=WEMoeZAHwJK/fyROSc9nMcsaz84dgSNKbS7raiQ7bGA4MBDV8KkfSo/2AaCvnzgxRo
         IAcb2gCsyVNbi547cRbkYkjFC4QCoqJp7gnPEtQDCMJIUFA5FhGHOi+jbJgOn8ekg8Q8
         i+CisiD2u970bZnTJwSbSU1snAK9t+sEoySOv8cX71+hbGCKzxcYL2eO6hNdxSKBkU7g
         NDGqovPt1YKmjn1R7GD/Y8kemkshbO2ti6nqlKNx/mSa010+v4NgHaN7dibjWu3eqU/k
         w7v+7IDEGkXaCHzeSE/sqnsMII/NulSV3wAXuDlH8Kwgn7gb2dt9uEmxmSOn95qb+vAe
         U4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999611; x=1790604411;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFozjASAAkxsRNEYPT4IGxp7pcPM6/9Z8WMRlei3dvA=;
        b=SSflFsxdXJtx8kBokFKizJqm2hFjFLkq+66v8MtHinwmbuCSzGmCdeD/ncqmUixYk/
         QIslqS2ALC/rIX9GbECL5e1T+7KLzqZkxjM8kSSjWi53RajeKbJPnG8Q0catZpy31tQM
         ZiKrQARJtLq5PsZFj98XGY0+hO6B9tZpkv5vektAUeoZH1YOjJJ7NkxSRPEJCw+AEaYC
         isSfr6J4wwk+xeroyUnA4dEOvPL3JzD3mx+isBLA0c6a0j9uqOZdlywtjeYDmkBe/zjK
         qP82Luf+SSA5xz4R7HcTeLAbsShnOWlK6BMYAZdCK/tmy4i0uCDuiIeJeR5sb5YiAc+k
         YdMg==
X-Gm-Message-State: AFuF++mFd7xMLozdEPgcEkm6YZLqZSYeSgIKVGdYD/C0TmTciqdziyhu
	EAIEPDRGwdhN19tMyrxzp+I6LUbRILqI2+D38CugQvU3QBVu4qvB6bL+NrhXKGbwFn5WoogkPXp
	rztm5/w==
X-Received: from pfiv14.prod.google.com ([2002:aa7:99ce:0:b0:853:9149:8801])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2990:b0:874:705d:f646
 with SMTP id d2e1a72fcca58-874de80468cmr13965258b3a.40.1789999610928; Mon, 21
 Sep 2026 07:06:50 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:22 -0700
In-Reply-To: <20260902211759.2700289-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902211759.2700289-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999884535.741435.243109419293478594.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Always guard rmaps with mmu_lock on
 PREEMPT_RT=y kernels
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 02 Sep 2026 14:17:59 -0700, Sean Christopherson wrote:
> For all intents and purposes, revert KVM's ability to walk rmaps outside of
> mmu_lock when running on a realtime (PREEMPT_RT=y) kernel.  I.e. don't use
> a non-sleepable bit-spinlock to protect rmap entries, as realtime kernels
> are highly unlikely to benefit from increased aging throughput and reduced
> jitter for memory-overcommitted nested VMs, whereas using a non-sleepable
> lock is currently buggy and goes against the spirit of realtime kernels.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Always guard rmaps with mmu_lock on PREEMPT_RT=y kernels
      https://github.com/kvm-x86/linux/commit/df269c8e097f

--
https://github.com/kvm-x86/linux/tree/next
