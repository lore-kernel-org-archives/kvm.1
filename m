Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED635E1B1
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068021; cv=none; b=sAvxD3SXNYYQMuV6mD6rj0WUisJkRp8L6L6CsehFZB6ntz3UADrg85QveSKYEI/ncRl/DZ62wPbDU/gnIjvJAUEW/adiatIkIh9lEbMQB0gvlPUIaFmjbgwo73T4D3KrRCQzbnw6rFsvoaZUCNhrM24oZpQPePGsgY9qNr/S76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068021; c=relaxed/simple;
	bh=GgWICAJ6ULXuhZrnJ1GDvr4rACkDtSLJFtJqrYBi9o0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxYqVpnVU2MMw377ZZSxe00ICvbeYZbTsQ145/6NRs/GWx8lojzxg1oPNw9fhFA8sAlh8OLZRSVfU1UrNWV0EnAPBGhUuOlnaBdzC0aokFZDBobmwmOaa4EDfP//DqAvhNu3YjlKqV8BAZO25C85wOA1rs9oSqtWcl5q1263l+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAgiL2pc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAgiL2pc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so902357a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780068020; x=1780672820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJMTj4VYzeK/iqbxUOSPuBGx3x19/ygx54Vai3TBl/s=;
        b=YAgiL2pckSZ29Z97cGGdkKcrCHR3T3Evnm7BJqUq7YPzn3DY/mdZ2v/CG2OliPlMIu
         gxBM8E6VP/vs1eRD31bvwiqCrfIQmzW1qJcM/bVckX1Ke6tfaQACSuINAmfyxbv/aeiA
         iiuUkG7o/8CPZiSafvjpogYn6y+dUggLtiajWc8asTnxWtvltKkfAGxQGzYnA4Ez1R5z
         2XTTdZdLWi7avkF9432dhodpmjwr51SEixaCtRmILAqTG1n09QH+WuxuzwnLJe7vzXDj
         wD44ttqfZrSiYOfdsXWhsZj/0KgHvH397Q1qU1ADVanOn++0a6fg8j/CYVyaVCFTlI++
         ip3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068020; x=1780672820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJMTj4VYzeK/iqbxUOSPuBGx3x19/ygx54Vai3TBl/s=;
        b=VviwQUFg9l45WeTBnoq8u4xrBr4fAIoVm6Kxd8He5VfeRKdhoUpQPkmteo0whQLtY5
         H0wEJyLhSdLQKufO/rD570HlNK7ZDdqIkNMkAk4haTMD9yezxNOhaDHlP1+6XaKIrUl9
         1liVpbjWQC796T7RUjtzIYrzVhZFwr3EN3T/ImHWL8Lt69qmbW4aaRyA2f9f97VoyS6C
         2OKafENqaTaFEOWRi/I84dkAoRFBZiWM3hkCcM2DH9RDFFxEwauzgguYPlMcKUbRk8/e
         ZA2ua11BvW7126Zt1JF/roIvDCYRUybMMyJiHXTB4+YX3pNXF08xKD0bAm8j9CK13t51
         wj4A==
X-Forwarded-Encrypted: i=1; AFNElJ+oViOhnDKMU8ezejVyfWXajNN9nNo6kWjkdH5o7iMSOXBtPmY+JszAf8zYHniXG5h3PKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuoqUJEmO64mPYRfGaJSxglaeTUooOYPMMLmS7hjKLcNd3lVl
	jdUzJb0R2B9JlTDQiUrTq50RD3Rmnnzoo4e/Tm6MkGvLtUO2voIf+SISwdd8ExY6uqNY35zG4aZ
	EEJEDqA==
X-Received: from pgh1.prod.google.com ([2002:a05:6a02:4e01:b0:c82:7761:9940])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:730b:b0:39b:8905:4e13
 with SMTP id adf61e73a8af0-3b411be88c1mr3904729637.6.1780068019640; Fri, 29
 May 2026 08:20:19 -0700 (PDT)
Date: Fri, 29 May 2026 08:20:19 -0700
In-Reply-To: <20260512011502.53072-19-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512011502.53072-1-chang.seok.bae@intel.com> <20260512011502.53072-19-chang.seok.bae@intel.com>
Message-ID: <ahmusyis7qn4fe4P@google.com>
Subject: Re: [PATCH v4 18/21] KVM: x86: Expose APX foundation feature to guests
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, chao.gao@intel.com, 
	Peter Fang <peter.fang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Chang S. Bae wrote:
> Add the APX xfeature bit to the list of supported XCR0 components and
> expose the APX feature to guests. Update the maximum supported CPUID leaf
> to 0x29 to include the APX leaf.

Almost forgot.  For the shortlog+change of this patch and the next, the changes
don't expose APX to the guest, they advertise support for APX to host userspace.

This patch also adds support in KVM by allowing XFEATURE_MASK_APX, though I
would argue that belongs in a separate patch anyways.

But the next patch is a pure "advertise to userspace", e.g. a VMM could enumerate
and expose APX_NCI_NDD_NF to a guest with or without the patch.
