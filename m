Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE4248F57
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120133; cv=none; b=l6a7taR6QS1Ze7AB/lKN0Lua8oDfgENU+fdggZkZ784Rohu8Z4+l/AaLOi6obPXxtoPjM9Q6WlZ8SqT7jUIF7jcvIoe/z8/GmDmAM9ekJPuAPKIVTRGil7+ouVVrGKmcKfBEeK5lY0AlTloXdW39G8AFvvpULiNPFkwTczagiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120133; c=relaxed/simple;
	bh=LK7uQDvrcQgh523UutGordIYjAMZa9A3xyiaK41syLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sN8qfEL9CkSmLdBnxMUL+V8y1rZ4631ob8dtcCuvyKaWoCrt+SKIJfagdaFFvUQaVRXE2n8KekyyfVE/raynsBxzpWSDsp+7MP8ywPWzB6bfh5354rRdcQ+ZlADZmwQk1ostN7DQgAQKs/ohfhAZhRwWRTpdHnjmE7QClGwF1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKIG3qiE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKIG3qiE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso118788875ad.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781120132; x=1781724932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEoSZc/Ri3Fj9efC7RN3D4uVzworhU8OsOiH614JgHk=;
        b=NKIG3qiE6Ay3je2sSwl80PyrZJk5aX/GbVJnbr4YousSC98RlcONzC8e1cRMmN7N9k
         u2422AUNxJ+/xXpvlHuDhiqQjKVvKVapN/EvKfoQ0c6vMAOc555td0JNnkrMun7Y0CjY
         EhgXTbNQjU6fpYv/wkbH5Z1azCQozthBoQevOem3b64jD5FpEQUPWAHEHLXWiG9wqPjc
         AQcnwZr+SFSKX4j/2I7k5VVskQMBStCYoAJyghYaAAE8yFpHccUxJ9w0lxlJmmzvQun5
         juO9n8607dnTJAr8CzXxMTSsKBUcR3IS94/X/Zr+xmgM1nYzY/lpYdRwIlQ7uwW4SDJK
         VOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781120132; x=1781724932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEoSZc/Ri3Fj9efC7RN3D4uVzworhU8OsOiH614JgHk=;
        b=Ks7EFr6vTs7MPb1LBLalvsdQyXc4x/L7PBiq3eOLUkAG68HEVQjpaQWhM7NHnkPuTS
         RYqFC5mcVGIBkoOLGanv538c6uuQY5C4KmMbK+sN8dywnzu2+8x1VJD/pHu6UslTr6Uu
         mXwDcnvsBaeLkSKtXP5o0yZkId0Dpj6yda9B4VIZKgXtZjvyKVDZqTwH9bbWzlugrH8Y
         NrW/g4m4OgvadGjxfOTNXH5ScWlQIlw+xzJdHp9dYltOYHqxOc3GdTugFc+g604qqcXF
         1niJ2rWCl0satbixEt0P1rDAuivuQO2DZTmvl0cbQ+I3pX0wNMTCjNsahyqybIe/jLy5
         rEpQ==
X-Gm-Message-State: AOJu0Yw4sLrDFq7AMz9XFtrN+lzixNm0lraFfxzOyiXAshc50fcUOJUE
	f60jf8b//AtIUMOB7vp714MUo1WeexAs4CgWJTO8Ceh1Wyci3va+FWslVNrqGhBHcNdKHM66Jwt
	rAv+7Mg==
X-Received: from plbiy23.prod.google.com ([2002:a17:903:1317:b0:2ba:1011:efb7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3847:b0:2c0:c262:b917
 with SMTP id d9443c01a7336-2c1e80e429amr312731605ad.5.1781120131430; Wed, 10
 Jun 2026 12:35:31 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:35:30 -0700
In-Reply-To: <20260610010824.47A0D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-6-seanjc@google.com> <20260610010824.47A0D1F00893@smtp.kernel.org>
Message-ID: <aim8giv0brgyIuv-@google.com>
Subject: Re: [PATCH v6 05/18] KVM: selftests: Add an irqfd send+receive (and
 later IRQ bypass) test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> > new file mode 100644
> > index 0000000000000..9f8895b898214
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/irq_test.c
> 
> [ ... ]
> 
> > +int main(int argc, char **argv)
> > +{
> > +	/*
> > +	 * Pick a random vector and a random GSI to use for device IRQ.
> > +	 *
> > +	 * Pick an IRQ vector in range [32, UINT8_MAX]. Min value is 32 because
> > +	 * Linux/x86 reserves vectors 0-31 for exceptions and architecture
> > +	 * defined NMIs and interrupts.
> > +	 *
> > +	 * Pick a GSI in range [24, KVM_MAX_IRQ_ROUTES - 1]. The min value is 24
> > +	 * because KVM reserves GSIs 0-15 for legacy ISA IRQs and 16-23 only go
> > +	 * to the IOAPIC. The max is KVM_MAX_IRQ_ROUTES - 1, because
> > +	 * KVM_MAX_IRQ_ROUTES is exclusive.
> > +	 */
> > +	u32 gsi = kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1);
> > +	u8 vector = kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
> 
> [Severity: Medium]
> Is kvm_rng initialized before it is used here?
> 
> It appears that kvm_random_u64_in_range() is being called before
> vm_create_with_vcpus() executes later in this function, which is where
> kvm_rng normally gets initialized.
> 
> Because kvm_rng is a global variable and zero-initialized, the RNG algorithm
> will consistently yield 0. This causes the variables to always evaluate to
> their minimum bounds (24 for gsi and 32 for vector).
> 
> Does this defeat the intended randomization for this test?

Yeah, I'll add a patch to properly initialize kvm_rng.  I'll also add a patch to
seed libc's RNG before calling random(), because as-is, every x86 test uses
0x6b8b4567 to seed KVM's pRNG (and I assume the same holds true for all other
architectures).
