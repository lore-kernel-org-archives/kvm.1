Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D538F63D
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489660; cv=none; b=gAJsUJ8KiW4uShafyfLYoGaJYiN5UUotE4wE4//pP3JhGFEBWiB+B6IV4HfoKmwnaNshSRQR1cAguiWfWn8+6zLrOR0QJxFu4ObbGzdYl4B+kXQ1HzyPXpt4yzI1eA6BrOmgwSbC5fn2KbV1ndiaFzVzPGnHf0DxvpGljbFj3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489660; c=relaxed/simple;
	bh=QlKCarQpTs0S5O3qv6nymBsauPruUAakuykggcKDs9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2XUnSROrZc5Qo7wb4gloEa5bCNqV08aYnnbxJ8UVldO5kOLriyb+RuGLwZq/PB6eYRVZ004L//oLBm2s74xS1nkkiOL404lQweWkpKRGI1gJulX99LtN/uG3nrFMUfnTEBrvBsJNN6J1nsIHk6RssE6zqMkC33wkL/zDqzRUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSQ0Ztya; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSQ0Ztya"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b99eb06178so181788395ad.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489658; x=1780094458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObH5PxgW1tY/Cptx/+ADLCZSx6CiOrfWCelMhJ7vjzc=;
        b=XSQ0ZtyaQpzVP8IO8RDZUisWVK2ZMfdf+JwGGYxoI78jNT/BtfAH4wB50s9mjF5qv8
         +ZAGYE3+szB8G0+txMPyAMR7kK8AeGkbziktg6USiVMYl9oOxocyDyJhqZrTnTWAahpu
         //JCubj+6fdu2VBvF9aGNYqVdxaZv+WylfOBvFkxngEffhh9tjC3Jr12hbHrba+zKNx+
         A/BodotqlZ66lOC5jMsJII5/bojEZ8KhFRW/2UD2Ty2wySAMRK//VIhyhRwrez1AnFUT
         FYjWdrB4NwV0igJnIkLAMAuQwuQ9txlu08sxluTL8/DXFEfWj4qOURViWgB3dVPSo2pD
         lD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489658; x=1780094458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObH5PxgW1tY/Cptx/+ADLCZSx6CiOrfWCelMhJ7vjzc=;
        b=DAYGP4ghP+lpwt23IvCoqpm+PVtegLCkitRsvqugh7FpMvkYJKX35uGE59dtQkgjHt
         iPo0knYDgSnVGRoyVUQEAWpEE9xzSl9HicLtFOe3T80ympN88Vu29N+te5X2Ow0rHFd5
         naNcAmQD6L4UfpmJcrWU8CoEqbz4s/3pY+uJPxSXR/ZiK385YhLZy8ozxrUDg0g2d5XM
         2grhJ8xHvZnSe8sauupZNBdwRyOu4Oiw+ERHkby2fSFKjaLEyXwwKl4q322X+0UgTjND
         jD10sJ37JYOhjih8peks4RfBfGLZko0ZU4QHTJU7y1Ra0Vs04kMqYz3iZI7jVMvpI1Or
         6Pdg==
X-Forwarded-Encrypted: i=1; AFNElJ8OdN5qWW8fLZ4RuUbqjTYYwg5sdGsDkWVqYRRh2Kcgt7Mb5nm9DSur7726VGwdq7unIvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLDUMOnhP6RGYUeVr83QfWbbwOipQxwuzX8pOpcs0sJNxXeFY
	WhSSGzzGslLLIn/GJxTeyHgiFaH5ZdJiyYQm+XzfLypnWi9Izb8FMAN4qiZ3iO9XvuoQnqNe2ra
	8Vl2EOg==
X-Received: from pllk9.prod.google.com ([2002:a17:902:7609:b0:2b4:5bcc:fc4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b43:b0:2b7:abc0:3bd7
 with SMTP id d9443c01a7336-2beb035b8edmr61076785ad.9.1779489657741; Fri, 22
 May 2026 15:40:57 -0700 (PDT)
Date: Fri, 22 May 2026 15:40:57 -0700
In-Reply-To: <20260522215442.F0E711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v1-2-9fc8d6437b65@google.com> <20260522215442.F0E711F000E9@smtp.kernel.org>
Message-ID: <ahDbeeM7emoO9G-I@google.com>
Subject: Re: [PATCH 2/3] KVM: guest_memfd: Fix possible signed integer overflow
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> > index 9fcc5d5b7f8d0..23813d74ce709 100644
> > --- a/virt/kvm/kvm_mm.h
> > +++ b/virt/kvm/kvm_mm.h
> > @@ -72,7 +72,7 @@ int kvm_gmem_init(struct module *module);
> >  void kvm_gmem_exit(void);
> >  int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
> >  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> > -		  unsigned int fd, loff_t offset);
> > +		  unsigned int fd, u64 offset);
> >  void kvm_gmem_unbind(struct kvm_memory_slot *slot);
> >  #else
> >  static inline int kvm_gmem_init(struct module *module)
> 
> [Severity: Low]
> Does the fallback stub definition of kvm_gmem_bind() for !CONFIG_KVM_GUEST_MEMFD
> also need to be updated to match this new signature?

Yes.
