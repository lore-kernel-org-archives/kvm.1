Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441E416D0C
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684342; cv=none; b=KSkXTROjyUDBwDicwJ5z/KYmJsOSArUow5bDwN9f2Az/qGrsGZbEdZMyda9+PAU7TEBIURMz2vbq0WGm34vCIzm7ONiuaMw3SavsqJvTRyT3N1K1xVJ1VZq2K6iVXIZIREvaLCibO5vb1A8b5qfSVQTKeb2glXnRnVweNNAwunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684342; c=relaxed/simple;
	bh=/nJ32PLszFDIGEJ+QzufApFTwEfIKzxIz/N/zTEErKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bMArbPu4YoBz0+q+354YTJg2M4IF7IqHP23w6L5GtqawWn8a+2R3Tt6U134gndUHediCYy/ub/UxPbHmeWgI2wK0I2Ai3/dQ3P0r9/jtwHeJ3LeImpK1fh7lnw6qCcSbvnhJkOhJy73NjG18OO3m1ZI7ZdA0QKX4UR8WRTa/UZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqQ/r4Ib; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqQ/r4Ib"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8425a9979e1so1474082b3a.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684339; x=1781289139; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Us+nSr9bxYgEtrMiBqB11Vc7P9EfZTwdAYTagdoMsJM=;
        b=sqQ/r4IbYcFPSzquMEpXtALSqe1GmMKMnUyF2Id5Ro3P5V+oYL22hQ+JDFgV77z+qT
         JaTNqDddjKJoiFJQNHSHp/ud5I8hYjCkzbvLjmXKqlirV/2XtvytXyJLz0GVfcGev8Tt
         KcDx9A7Fv3c2jWPUFXj+1RCEZpUSCedftkLFAVa0HWFnqMXMwx5Djl/+7F+UGcMKL6Oy
         5s49dahAOOUCKWg0RM5spRtdvnYwtll+E/vtJU8D2O8jOgD4C7iCgbP8x1YtHt1bRFYV
         AdYuP95nqR/j70Xx7mcDt6mNOs4GJZkh0wXH0CwVVI4oLo0p7w3ijLTDZQ/Ghdi9dXT/
         k06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684339; x=1781289139;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Us+nSr9bxYgEtrMiBqB11Vc7P9EfZTwdAYTagdoMsJM=;
        b=K6yFLL/1cgcj4ANZidegnI9lWz46MO6pmSyVmRe514Xdd218BqRE+Nfeb/ljs34ik3
         M2lPqq3hg4Pz8uNmmUDomTjpdHMK2xrju1iEFxri/hNRA4v6GrOcaS2MVNuKjLBOlex1
         YYut4qqjw8rOiKdUqUUDVUo/HHJ3Zbim69RUCGfxfrmON9dwG6QqpVHr6hg2wNN7YQCm
         DlDveOInRh+GJapnHxnDjMDZienrgpU6CJr834BulJDnD+oTytNE+viNLRQGlndREzco
         FQE20jXRZBDXtIL7s867kOA2fqlRcwKMLjDB1cY1qZGbyLnMVgl0LvlCdgbIETKhTK27
         1Ccg==
X-Forwarded-Encrypted: i=1; AFNElJ8u0cyOfpC4LAf3q+YpD0qE996dYT00qGwyVouhlRFFKgtcalutCG8bcq0/o3f1cIQgIDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeq40il3RyR6hIHwSPh0EB4bx0x0Qk4xtVxLnF0mUTvmnk/2/R
	FRoaCWvlhuHwAVXltaNW+h458IrC2klVdNRoiYgRlGystrmLzb4oV0GoSwuSEpYgWPQ5Op96gST
	xAazIQw==
X-Received: from pfh21.prod.google.com ([2002:a05:6a00:12d5:b0:82f:7242:4cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1989:b0:842:614e:cc97
 with SMTP id d2e1a72fcca58-842b1006f44mr4608126b3a.23.1780684339364; Fri, 05
 Jun 2026 11:32:19 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:31:45 -0700
In-Reply-To: <20260528124043.2153-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528124043.2153-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068429525.2237206.8544719207328373026.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Use fls() instead of ffs() for rmaps histogram bucketing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, lirongqing <lirongqing@baidu.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 28 May 2026 08:40:43 -0400, lirongqing wrote:
> The kvm_mmu_rmaps_stat_show() function implements a logarithmic histogram
> to collect statistics on the distribution of pte_list_count sizes. However,
> it currently uses ffs() (Find First Set), which looks for the least
> significant set bit.
> 
> Using ffs() leads to severe statistical distortion for any count that is
> not a power of two. For example, if a rmap has a pte_list_count of 6
> (binary 0110), ffs(6) returns 2, forcing this entry to be erroneously
> counted towards the bucket representing a count of 2. In contrast, it
> conceptually belongs to the bucket spanning the 4 to 7 range.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Use fls() instead of ffs() for rmaps histogram bucketing
      https://github.com/kvm-x86/linux/commit/c3647e582e15

--
https://github.com/kvm-x86/linux/tree/next
