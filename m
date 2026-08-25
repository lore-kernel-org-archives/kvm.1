Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15E486E46
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670041; cv=none; b=CZvjTUJ0iX9zp0tSbOpPu8tzi+6BNksfV0qZOIz08OainGvgcwUx3vIlW/1TiYs3b90uEyl/sDC1hUlRj13PYCaVwwi9lEkZJWHXl3j8c5IBcrSGK5IcnHPIaF5aXlHp9gHtLCg8cZ9G+Uf+bgTTwh0Yr+o/GTOKV1mvWAvoAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670041; c=relaxed/simple;
	bh=lzu39/n3vWLMuX5lyqgMNOhmbNQ+sxv9ZSnyjU7pBLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+9U0fduix913ppv48q6y26jqNJ0OTfkVrIGz3uBqep0rNL9V6bVXRv0rwQk0Cp6ZdOVN7Lzzsok5lHuAWaV45ffwi6zYi+wJiW9kYkmXp0gZHe7fbLSTlHehe0R6M0U1tdHGXlJx0gXj56mkDTh8O8ZLmzXEhydf2D9xwmeWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQ1Li8W1; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQ1Li8W1"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so58013725ad.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787670031; x=1788274831; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmHT9WykXDCYDuHjAwkcEmxAcNUgfeeau0x6gYkHaWQ=;
        b=mQ1Li8W1HPUru6SSXhHmg+nGNZqBuU+RTp9KbxZjgvYwS2TfT0eflPdW1jZ5wR9zdA
         YAQvb48Dc0x7EHahO/vY9frXVsuyNFWJV1O0C6TCxHy5UMW1BlanDcEtnq+oulbs/C0i
         CZ1/kBrCmdtk1AcSzfoJP1NG8PYcHc/9bM28YzNNNCB/oaf/aDHKbl60G8JKKj0SFYOP
         I+LOR6wRtwG9MsH/kl0eCzKf5jeWItymGAlZWXtgPnD6Vbo+vVn8cMDV/UmAhVJkxsx1
         U2pKmua0707KDFMUpoaKyT9yxYFskc/XgWVffEzFw16dWyyVQ91A4zxVg5eGsC468MU7
         TpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787670031; x=1788274831;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mmHT9WykXDCYDuHjAwkcEmxAcNUgfeeau0x6gYkHaWQ=;
        b=sizJz8Buhsdt7MIoswFXNiJOjD7PP5ckoBgeUds1gAKwC7jefdJPUU0Fk/JHPJs3Ap
         QUzStYl5+MVpyuudCMt8l5Sd24WONX0tYhpx8vf4Fx7ySmg8P0BNjcfELwcR0rhc2fnE
         owmtMi68BfLDRj4yNoQh9oI9iKgBGAagMSCwClBzytJyG6i00eYXq01DG+XrYyrYoG7/
         SPGLf6+Hs0sK1PpDVGcErToRHwOUqOH2q2wLTHxwvTuXcUFU+mCgp6XEQOshLgzgjVfE
         8qofpFjuDXGBL1OtqlcjgiwQL+Iy4ivNbQeb6/B5OiTj5S6FULZeORX0zzgyNoSOQGCB
         akRA==
X-Forwarded-Encrypted: i=1; AHgh+RrZiJP0RmE9tyLQRJp/tmHPlsBtwuTblpEJVeRBXp/roJloFPB9iwtPO4UoYC+nP1u4TNs=@vger.kernel.org
X-Gm-Message-State: AFuF++kBA0t9V2NZ/ssk3Ta/jrc5w/tFq2LnATEefa6Pmsu+gXVNce/J
	vxET6N5M8OlcvF7Kol1BSryAmVaN1Q/1K9+LWV9tNnqaAS4vrEmn48fOCbjvzAOyOcXZzOH5mBn
	Ozm+Xlg==
X-Received: from plrf23.prod.google.com ([2002:a17:902:ab97:b0:2ca:b907:d842])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1108:b0:2cf:a108:7605
 with SMTP id d9443c01a7336-2d670cc180fmr463312705ad.11.1787670030208; Tue, 25
 Aug 2026 08:00:30 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:00:29 -0700
In-Reply-To: <20260825140159.70997-1-mamarang@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com>
Message-ID: <ao2uDa91H66vJizu@google.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
From: Sean Christopherson <seanjc@google.com>
To: Marco Marangoni <mamarang@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-patches@amazon.com, mancio@amazon.co.uk, zoumboul@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 25, 2026, Marco Marangoni wrote:
> It's worth mentioning that I also evaluated using the existing
> KVM_PRE_FAULT_MEMORY ioctl, but this doesn't work well for our use-case, as
> it requires the vCPU to be paused.

What about if/when KVM Userfault[*] comes along?  I.e. pre-fault memory when the
vCPU exits to userspace.

If KVM Userfault + KVM_PRE_FAULT_MEMORY is viable for Firecracker and provides
the desired performance, I would strongly prefer that approach over KVM doing its
own prefetching.  That way other architectures don't need to implement prefetching
as well (arm64 already supports KVM_PRE_FAULT_MEMORY, and RISC-V has patches posted).

I'm aiming to get back to that series "soon", this would simply be more motivation
to get KVM Userfault landed.

[*] https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google.com
