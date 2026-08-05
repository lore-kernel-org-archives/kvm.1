Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C3375F65
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948699; cv=none; b=IAQbIBiRovWTXuzh3OoNLAPt80+OFV5FNW5NEu095O9k84u1OORgBJhN5T1k1J7tkWNnDGNIlyPe5vS2ubjVY40AB5OiyDIxzMJ7AiV0+qtY7kxNSM6D69W6JefcuhLX1h7agY6iGESa1dBEVxLmH7xNgsSAb6XA3TokZ7XoOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948699; c=relaxed/simple;
	bh=znCg1pIG50r87E5gHsrlxKjtDzfxjrhq9/lFHlcvwv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AdkVO4bCLgbN615MoU8wtrANRa9i5VTbNZ58xRE2cVE3G3Pqw00lpNw1VaVzbjQ1wwAaHezuLJMpjAKTHSXU+UuWt9u/gcqvH02jdH9mfKxDUroUWKYJkZifHSEWsB22zr6JzkgzDaeMuwpox8/lm3yc2HbVItOx4sXCHN4s5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S30PIz1F; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S30PIz1F"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so31238295ad.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785948697; x=1786553497; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nxbsVT+xN/Gkf9g5nmtvos9vBDowTib7BrvA9Pibs4=;
        b=S30PIz1FHQKvjNpBG4LtLrsWG0qd+ce9VhrYXJdqYUQEgBBF0N4kAUEcNDQ4d6X5Co
         ZySwCqN16k1Icy6X+p7UJDW1d/jAand7EDRFxDCaNS3PPQKlcoN67EMc3ty/92+oqxUB
         xIPAM5Dyovf2HwsktqHy6eD0iX6DrZp2SRMDfaxLpmPCj2Ctb8JwqpTO4pNgKyf77d1f
         azsGb0umQ8P0/9MYKa4KEvzEZt3uOravnyVSb67llNq7zVXhJbU4+HnOltScYcc9met0
         /0/VqvmJ7vJWg3iGaIeXj4mSdZMTyYjsN2Jp7nCyDvZUezkk7OhjbooIW1B9nJlYAHIa
         zUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948697; x=1786553497;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nxbsVT+xN/Gkf9g5nmtvos9vBDowTib7BrvA9Pibs4=;
        b=E2o7ZQ27+NP7pQ1+DRQhl+Gw3j1uIk5r1QTvznm03o7Z7RTPEbZlQLt96aig/O8/09
         qr7nsxFwIc93+VtR0lRK8uQfkn0xUvu0eQ9E1IDo9cM5agZ7Xzl6kZwZUTjphcEqZbsa
         fmlguL1BhPkSZw9gIPraN8jGb+cxzgEEg0vydLQRnFx4H+HbppNaMYUmfXxq6Jt9UT1y
         W5zcEKRo1UgcFdCGIM2AyA9v85qqgwg5rkc3YFY1+EntENR0vMX9V3pdCEpxQguXvvaB
         ZRAjMTU2vfdTssUT2YOTQtpUWHXkd4t9IPWsTClsiPClLGRHGjXm46mfQCpOMtVkvu0M
         cSzg==
X-Gm-Message-State: AOJu0Yy6CttDM0sh2qTCeaFzZ4GjQ5HXA0Sfok9KlvolQw5ET5rNlRFg
	J+zH9Tp+7qB2cdSmd4siyXEEFWiwIISOhaz/u+k7JdntjXem6/MePWXM0lBOLiF3blIGWopOPkD
	r3k7hZA==
X-Received: from plez11.prod.google.com ([2002:a17:902:cccb:b0:2cc:70ff:9465])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d486:b0:2c8:1c05:16aa
 with SMTP id d9443c01a7336-2d0ca984bffmr81453095ad.19.1785948697433; Wed, 05
 Aug 2026 09:51:37 -0700 (PDT)
Date: Wed,  5 Aug 2026 09:46:08 -0700
In-Reply-To: <20260730165159.1988017-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730165159.1988017-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <178594835841.3639792.16829670093985664287.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Only link to VFIO library on x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Jul 2026 09:51:59 -0700, Sean Christopherson wrote:
> Link to the VFIO library only on architectures where it's actually needed,
> i.e. only on architectures that support irq_test, which is currently
> x86-only.  The irq_test series, which pulled in VFIO support, effectively
> raced with commit e65f1bf8a2db ("vfio: selftests: Extend container/iommufd
> setup for passing vf_token").  I.e. when the KVM test was posted, pulling
> in libvfio.mk didn't require linking to any new libraries other than VFIO
> itself.
> 
> [...]

Applied to kvm-x86 selftests2, thanks!

[1/1] KVM: selftests: Only link to VFIO library on x86
      https://github.com/kvm-x86/linux/commit/2f0c30d0d175

--
https://github.com/kvm-x86/linux/tree/next
