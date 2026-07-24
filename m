Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F421FF25
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922742; cv=none; b=twC9az7FbtOZdm5oDO54Z/01pnzuY3cUyJFDIDk1aE/ZBcD5/OeU6/Eg4L/SmnfzyfquPMIUkk5E1RhuS1PrqrSeGSTiOd0VurgxEipyo71L4LBDZoChJo0TczeJmP5WXnJCgZ1Oz/XQ8teQzLi+mjEtZVY9omRxgE0yAD8CFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922742; c=relaxed/simple;
	bh=A7EEfHCXDQhZbZc+7PwL7H/hPx0GPYjU++n5dKG0w1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQnUDhkfw7MPDniTspW/zCeKKBKNa3Mo43YkP16uIavZVVIINTVaoG21Os4oVaSqDjVBvxYFm8dLyPWulom4ZKKJsSe0s9zWH3/lBGRhlCZFcR4VSNQ8Y45FMlR714I4V2mxO30ViagMIWdL8Pqf792p5Ack1rXZuD8gV8Xmv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLKArikg; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLKArikg"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso1023685a12.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784922741; x=1785527541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIrEUXeMwkKPn3AMJe5EPVmRwSj/wiphCk2WS28J/Pk=;
        b=QLKArikgRCDtGcVe/3QMi03hm6MkTBR/N6R4UWh52oICYYEgNWMM+hZcmpsSNGW2ut
         sxAwHZkqk3/XwI7u8WIds9o8DC0NLJnUnmtNpCNTTLXk5oGnc8USQwTS2bTeo5lUBZ12
         KIzbrf6Zc4vXShnFVBk2R8Ft2I+jLWhw8fgdFJmsA1mCgMyVz2uKGC4I6jkE8Ulv4EgJ
         Oe6htBCpLVl64lzwtGlaejF4Z+0NSD+BFtJGfwicxhaxUOndAUiKynLLzpMUQSpxhor4
         LjYpErM9akRao87gXRqrfoc37UjuRZfRubAaz1nDQKCHSZYNRv6iYgs8fhSZh7qNGFVF
         6Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922741; x=1785527541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIrEUXeMwkKPn3AMJe5EPVmRwSj/wiphCk2WS28J/Pk=;
        b=WNNKI8mp3zac9kTh7FUDhjYSDFhmZoUebVPaAxjm+WSpAl9CDbqYBfJDoacsv+z5/K
         TDqXnXpVDf/s4VN2pqN1QLQSt1mnKZXMd/QbSJap1pj0RUBbLs8BRiXPg9/No5Bj5C9Y
         R9am1o2teP/1f08V42KFVqb4WCmRi/oNL7H1Vv2jFGYy4XlWLMfhYPWSvzC4Vjedb500
         D1pybc75s6/kvvXDTuz2YTsC1rX86GEx0Y1sfdq22BLOARMNtBVBqv624JFvjCk+jALj
         RI4djJ+G0goNxoo2tNWOKweB71Ab1Uzo9Ql34qni8Un61C1VT6t9SUrB7OZuffMyaMSS
         MMwA==
X-Forwarded-Encrypted: i=1; AHgh+RrbnAthDgdnCKjZs9VaRvB3ftYQYEulmS7RM9TnsXxhbTazwuMOa3LnBqDBoCHPrBdnyqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEoDyY1sBCnck/6vqa3l3MyPCiSMZ4PuXjYm97H9lpqNOf+9x
	ncITu9/r/ObuqwJivFEgRXb+0o4h+oGHnhMUNHIFPchZX+H5oZepzSwXersTrzdm1VOIoBgbtKq
	eCNMdUQ==
X-Received: from pgvf24.prod.google.com ([2002:a65:6298:0:b0:cbb:9724:6775])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e0a2:b0:3bf:e2dc:bc85
 with SMTP id adf61e73a8af0-3c44b1ca809mr9783772637.40.1784922740833; Fri, 24
 Jul 2026 12:52:20 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:52:20 -0700
In-Reply-To: <20260714160411.302386-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714160411.302386-1-alexandru.elisei@arm.com>
Message-ID: <amPCdAswlk24Xilf@google.com>
Subject: Re: [PATCH v2] KVM: Ignore MMU notifiers for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, suzuki.poulose@arm.com, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	david.hildenbrand@arm.com, mark.rutland@arm.com, ackerleytng@google.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 14, 2026, Alexandru Elisei wrote:
> +	 * TODO: Skip gmem-only memslots on mmu_notifier events entirely, once
> +	 * gfn_to_pfn_cache is also wired up to directly pull from guest_memfd.

So it turns out we need to solve a very related problem[*], thanks to commit
b9220d32799a ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA"),
which as it says, allows populating gfn_to_pfn_cache directly with an HVA, i.e.
without a memslot.

My not-yet-tested solution for that mess is to give gfn_to_pfn_cache its own
invalidation sequence, at which point there shouldn't be a need to process
gmem-only memslots just for gfn_to_pfn_cache, because it will already be equipped
to handle memslot-less invalidation.

Given how simple this change *should* be, I'm going to put this patch on the
backburner for now, and then assuming my proposed change actually works, I'll
grab your original change (or more likely, re-post it as the last patch in the
series weans gfn_to_pfn_cache off mmu_invalidate_seq).

It'll probably take me a few weeks to circle back to this, as I finally crawled
out from underneath a pile of urgent and am just now getting back into review
mode, but this is fairly high on my todo list, so with luck we might still squeeze
this into 7.3.

[*] https://lore.kernel.org/all/aj2hi-NcqUUCaoQF@google.com
