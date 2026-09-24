Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5835C6B2
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286863; cv=none; b=CRXMWHCtmMby6IUYq3gm7RoDJRtOZZJqpDJUVMNBhdsYfA/dwGkiN6p6CberCGDbXgmwmSjlHSI5vzGZcxV1SS5fB2fg+VkmW4+GjGa5yNqID+0tkzyt20gtUiZ3d2+VaPIbrnlr3HYnL/e6yzbU8GaEuz+K3AmSfaeREsWUv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286863; c=relaxed/simple;
	bh=xTahTtFed8Jg3VFQn7KACSupmZMdDeChaT/0NazBTeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=je5XlGlVc6XgoNyYeJz1SWe4fRFwhiml0EnyQK2hwavU+5E1d/iW71H6n6AI3YNE+RW8CZewp7nreV2mT76dafgOAs+DAthz0dFVD4Vgx39ifXLlups0tMx1qZLpXrrEJLFDyBgCHXvJg70XpIxm8RpK1jUSMdIqbu1Q8JQvHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVzH35KT; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVzH35KT"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df375fb9b2so2281125ad.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286862; x=1790891662; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpjZi+2mwo7JweFezCYtC+Z8hNKRiKMEMcyjp829kk8=;
        b=wVzH35KTUR94X4cMYHUe6idOxJB+Zb5O7wyHQd+ZOIqs+6J90R7AFPFLWTsaSE0AUc
         +lCzfi1abpL2+jxcE4p2OCc2t7m2LjtBsbwyQSBzgboqD30gespdrAxSmKGOBnjpglaO
         Vw8+YoqL4poH8LNi8Aa8FX28SD6scpl4YG1Gm0d+vIZLjo7WhrFqgh36wrgD7m1Xo7Ef
         mrOX/dGwlGroLp7SPPeeG4cPcXJ1LnNYNDPmAi08+RAEvWEeWJfBIEXnX6so00EJ2I7f
         VklMfhvlgVgVKu1RPKUIQnjcPdO6hEvxZd+ADO7gLQxka73hQdZjdewrALPuGvzl+pGp
         UR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286862; x=1790891662;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpjZi+2mwo7JweFezCYtC+Z8hNKRiKMEMcyjp829kk8=;
        b=KnV9PX0IAmCsMQPuaQGvF62xAyWUAZLbXgyDUPXjNysr7dZD5t+2tUdxOzkFBtrDw1
         zHWgcYbeNl4jd1wEXnTpWlJtGcbX4O8BGOthGtsbe0bmtLAeDlcOq3kxzYfk/I2dHcqR
         nH+TO7afc/vqnPjLBw3amcCXMorXKV4tZJsGeVoMgFCDhUVaPB009g8A5TV3C/YaN8p7
         G7AoCh8gtdHPaufclXD1nx5ppgFj4LWsm5BKTCI8vivaXwQb/sVWsN8RKdILranDZuiY
         pOBXr4tctL81wuv9CK++p3nzZuTl/QvBpfz6ca/g+eAtw4NalIbAj2wXu8kaMehvf6qO
         E6Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxSt7gX57fJWZI8KVxpGRZw4XLcA6JHQzmOdzLkK64PO/jZtXwcBJsE5VC2tTeAR20OjqQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mCyd3Q7fuBS/Vy9ek9A/sTnAEHatkUjS3OXbR96LRaGUbm0cwP
	5aH63Dp3cuPfN+wnQnElN0UjtESKAoa3zRpyUwUmfvLTsMybTvuhXn2uBsJ6td5+IOFSSxmF90j
	tqEzjnw==
X-Received: from plei4.prod.google.com ([2002:a17:902:e484:b0:2dd:5303:f008])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b08:b0:2df:915a:6fb7
 with SMTP id d9443c01a7336-2df915a7362mr4516335ad.29.1790286861611; Thu, 24
 Sep 2026 14:54:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:51:55 -0700
In-Reply-To: <20260922001332.1121266-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028364504.2005087.210259701923191014.b4-ty@b4>
Subject: Re: [PATCH v5 0/6] KVM: guest_memfd: Fix binding bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 21 Sep 2026 17:13:26 -0700, Sean Christopherson wrote:
> Sorry for the spam, I am hoping to get this applied before the in-place
> conversion series, and I really want to get that series applied this week.
> I finally gave up and split bind() into prepare()+commit(), and I actually
> like the end result.  The only really ugly part is an extra #ifdef, but
> otherwise gifting the gmem file reference back to kvm_set_memory_region()
> avoids the TOCTOU issues and weird juggling that led me to initially reject
> a prepare()+commit() solution.
> 
> [...]

Applied to kvm-x86 coco.  I'll send another series to address Ackerley's
feedback (I would do the more agressive cleanups on top no matter what, to keep
the fixes minimal for LTS kernels).

[1/6] KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot
      https://github.com/kvm-x86/linux/commit/e6ecb88711d9
[2/6] KVM: Use goto to handle errors during memslot preparation
      https://github.com/kvm-x86/linux/commit/23a205797cec
[3/6] KVM: Only bind memslot to guest_memfd instance for CREATE operations
      https://github.com/kvm-x86/linux/commit/513333a55460
[4/6] KVM: guest_memfd: Split bind() into prepare()+commit() phases
      https://github.com/kvm-x86/linux/commit/83411f32b8ad
[5/6] KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after* memslot is ready
      https://github.com/kvm-x86/linux/commit/3fe5d2944e5a
[6/6] KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot
      https://github.com/kvm-x86/linux/commit/48252615eb78

--
https://github.com/kvm-x86/linux/tree/next
