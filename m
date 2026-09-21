Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF134A3861
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999607; cv=none; b=N6BQjrL/Kg+xUN2sUL//3Z1IjI5VdMoDoT0BRI4i0980IkjG5f3yfre0Eve4sjz1oISv5S8IT+BH3my54w5nZqElfcC/dT1x8s9if8ryk10Np6YRANPkr6NZo4uNM/XIvvmsJBX3FtUFMctucUfAJ24spOTOewxbqDOWJWGBjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999607; c=relaxed/simple;
	bh=fpBLmgxXsUTMAxMvhlHGt2eiOf23VOCv+d+5hDTfupM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NU5hYX7Yic3UjJC+RmZQDy7FUzFyXjiKCMQmTutnYllSgnwbH5TDVaxinE/UykpD7CfKxgbsLqPvb0LGKJhpc+OGRGtTeJScOyGUZGLzcNHwcuIPAtLgNOOig8UacaDVCTrctp9Uo0xgbsqwQoSAT4zJ/s6SuF3xXwBPRkyxVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxKv6jfI; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxKv6jfI"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so3515460a91.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999605; x=1790604405; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiGmBjrOtgjkXABDPlqRosHtZi2K9f2nnRWisetnxbk=;
        b=RxKv6jfIzQef28U8fv2T3lEj6nEnI2ecfrfv5FvxWCuWroevzrGLxrlwtxDXt29L+I
         0B8j5b7N2fz7u1DbCkUl8abI3Li8a9mAIJWI6O/JyA+9zrejH4rTA9Wz6iNAop3BvT31
         bQxth/c/oKzMkioiy7RcALEXVikKIDxwiKiClnWABvXAC6YMBDy+VfWI4ZaijeUHBd8s
         GsriBXERapWbFTNxrDInrKHyiLxCo5OHBPA+JieXK7sDYU2JsWaw4NH5LbWAQSa8uSJA
         jX3MLasQmn/2FPI4bB1KDZRxP4eGsiWlhkgJOXeH+vzXHnVc7NPMciZLLqPXrJNt+DnR
         KiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999605; x=1790604405;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiGmBjrOtgjkXABDPlqRosHtZi2K9f2nnRWisetnxbk=;
        b=J0G68K05peQsUCDzR8Q/H2Eh4AmjvKKhXOsoYBXX2N57YED9S7o5z2h3lrgsS5Oxta
         er6tuMlW2oTFMhYxXUo2yPh6j2QI3EtlyT1pHbEmEuDjuzax/KKlct7iqs+bonfBmDyt
         ci46dNlcelU3948ViKThu0wBAtFFcmVtzXarshzSpDmWqA5Zt5+SDYgzfbqi3OkPaSQF
         /N9Pap6S6t0H016rkbTdvVSBjSq2NNEL9Q7CJkEvTyLkjEzy/jOUx3AKwEoZDZJWk3bH
         2fp3ddc25AXVEFg84I1RR5haXoO5zAlk4RPFECqlfxwrQZJ8lCw5I/CNoQSr/s96f8g/
         hgGg==
X-Gm-Message-State: AFuF++nMlY4T44bkuwMu/zO6b/dk6ESHT8mvIMy/aF2l+q/WJRYzTlat
	olMvyxRuPeiv16g0lH9BfYf30QzfkSyYc1pQuUK2lKkg9no+ZrPE78AEd6R+9xOW6j3WgAjm5TI
	VlIoQrw==
X-Received: from pjblc7.prod.google.com ([2002:a17:90b:1587:b0:39d:9543:35b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3909:b0:39e:248e:fdeb
 with SMTP id 98e67ed59e1d1-39e54d10e41mr16431189a91.19.1789999605212; Mon, 21
 Sep 2026 07:06:45 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:20 -0700
In-Reply-To: <20260825183924.237727-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com> <20260825183924.237727-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999885970.741699.14696191820725166112.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Take SRCU in kvm_zap_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 02:39:24 +0800, Chengfeng Ye wrote:
> kvm_zap_gfn_range() walks memslots and rmaps and may drop mmu_lock to
> reschedule. Callers that do not already hold kvm->srcu (or slots_lock)
> can race with memslot deletion: synchronize_srcu_expedited() does not
> wait, kvm_free_memslot() frees the old slot and its rmap, and the zap
> resumes on freed memory.
> 
> The VFIO noncoherent-DMA path hits this by zapping the entire GPA
> space without SRCU. KASAN reported:
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86: Take SRCU in kvm_zap_gfn_range()
      https://github.com/kvm-x86/linux/commit/b59a87c1ba3c

--
https://github.com/kvm-x86/linux/tree/next
