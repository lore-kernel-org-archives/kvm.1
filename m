Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2720314A9F
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229257; cv=none; b=mNU6B7IhVvi2Fuoc007Z24H7t3BcA8ewyBYUWkFZWlhw+Q5ASnRcfXmNRtZbJH/okYAaRm6CN/Jr8UHD53v7T6QFHPMXSwSwjnjha/0unQF0AQrO581ljjassnE/9WyWhvY3bFCAisYsLbrv5Z+G0q4l6r20uij96A+jGr65rJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229257; c=relaxed/simple;
	bh=i0P1v935Ve7nlkCTImBk1u5ysw3KyJGT8qP476UqQFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nXGYbsbBPmAgE82sb9O+zIQZt9LfN7Y9GuLPj+UgUMG8hej98H4vyM2a87oC1BsIgb6bgXlVSxGPbHFSKpXZGtOzDzOOSVdXAMCvcTTU5MeE7EF2QTQrgZBIRnmekmEtOqmHBXNmYvUAaTnnMgPYm5wbMA1We/QMv6Kzd/Zfn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGBOZIxJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGBOZIxJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cd9fa608bso3545560b3a.3
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229255; x=1775834055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q26NlOID4Lyygee/Z6l7ft0YlAP75BxyxDFKlwVPiDM=;
        b=SGBOZIxJpodOKViMieX+CdmK4du2XryFsrb2N593jO2HpCbLx/2+6LFDV7yeijpfmb
         6DXc4S5gINpE35A3DaLQDQ2GRxFilOx1EuJwl+zdWVpY8qAsVjxTTe0xorugWX5TQPuN
         1o3C5MEW8Cwu6rseLaeZxCszBL5GJ52YqZwp6fV5VYULbbYa1oiftmryD6doDeDuwpqj
         vQNXmfw9lNN9KgxYvesLNSEA97NlyYDJ8B55+KsSLEX2d/n4ZQEbc+rHr7yZC6WNeQ9+
         HA6jTaGAGj0YxVRzedncIU/1VOzpLeAhPtnWxh856XSGJ549XfuYyUYubACvVS/xJcnm
         0Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229255; x=1775834055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q26NlOID4Lyygee/Z6l7ft0YlAP75BxyxDFKlwVPiDM=;
        b=kr2OWPv84uR1j92Qaa+SG+788+ePIW3afni70fxhmoMCfHJmaZ2VFiA89lgDXiBaU/
         MfdQvgjHBlTvEKbDYxC3UEZ6soYdHdfG1sxbvTgBezInM4CrnYTaXQKlSbOO5CHQZfzH
         JajgVEGckTzt4oLLkeWcPZEn1YKuvphV1Vqbui4o+9wiGiagKkGUfmNPAVRH5EIR5EIk
         oTvMdr1DQ5PcG2kzzell+z1fcgarmP+ieXO7p5h5W8l8ZxUUM9dm5DoRZyzSTxjWUU4Y
         sRVxd8byhNVZ9zanJLG+ikPtgFCM86S9ziWQHjqdHQHJn1BNRr0pRNRo/boe+rDSDYFF
         i04w==
X-Forwarded-Encrypted: i=1; AJvYcCVwtxojnD017uBl2cCY+1mprQmqfBU2lkHf7IzjETVEi4+8dusZqtmscgEou0njlj+bW38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6tmKRWXN2KuK4G+oFbKimmp+VtzrdH7B/aruefHbrGhQ78sD
	4T+SAgDLvMhYjaWX0LAgm/+Nnkhzzu+60rLVETtimnIux/oe4STEpbNJ025Im1NWjaBPHytviDf
	upc6eMA==
X-Received: from pfbca15.prod.google.com ([2002:a05:6a00:418f:b0:7b9:1e6:e516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:845:b0:82c:ded1:260b
 with SMTP id d2e1a72fcca58-82d0db7da3dmr3496918b3a.37.1775229254918; Fri, 03
 Apr 2026 08:14:14 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:46 -0700
In-Reply-To: <9d50fc3ca9e8e58f551d015f95d51a3c29ce6ccc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <9d50fc3ca9e8e58f551d015f95d51a3c29ce6ccc.camel@infradead.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522898009.295832.5140565994747415378.b4-ty@google.com>
Subject: Re: [PATCH] KVM: X86: Fix array_index_nospec protection in __pv_send_ipi
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Jim Mattson <jmattson@google.com>, Thijs Raymakers <thijs@raymakers.nl>, kvm@vger.kernel.org, 
	Anel Orazgaliyeva <anelkz@amazon.de>, stable <stable@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Mar 2026 08:59:52 +0100, David Woodhouse wrote:
> The __pv_send_ipi() function iterates over up to BITS_PER_LONG vCPUs
> starting from the APIC ID specified in its 'min' argument, which is
> provided by the guest.
> 
> Commit c87bd4dd43a6 used array_index_nospec() to clamp the value of 'min'
> but then the for_each_set_bit() loop dereferences higher indices without
> further protection. Theoretically, a guest can trigger speculative access
> to up to BITS_PER_LONG elements off the end of the phys_map[] array.
> 
> [...]

Applied to kvm-x86 misc (also back on March 12th...), thanks!

[1/1] KVM: X86: Fix array_index_nospec protection in __pv_send_ipi
      https://github.com/kvm-x86/linux/commit/00d572d4cd7d

--
https://github.com/kvm-x86/linux/tree/next
