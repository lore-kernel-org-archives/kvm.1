Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFC3CF670
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325732; cv=none; b=LzZhpp7F4zZRDU6BNegfGL8LzBZA75RDS9PtfuMfRGQhwJ6489OieU/zxoK+y5Ev15eW8fEYoAMuPsb2uxP5GSlgOzeG0y52bWi581Nj24f9gFzcP4poKUoLmaE6xcmX4jV1TN+4gd8AgIh9mC8mA9phoJbXIIy65KfBIEXFNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325732; c=relaxed/simple;
	bh=gjP8bKtMe6/5U89Ahu9h+eiDw2hr5Rdfcyhdg+vn6Do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e0fsAP4kRc2C83GtvyH8D2HKsTxJ3IkKAUal2/TIg3Q1La3m2UcCRBVj4nLhZ/PjKWrLAolpY2IurXZg5T7Et/uuPpowGlUj47PX9mT/Gei3QBY8vdWnn1kIywbH8ycEtrnZcfcUUNtxMp9+g9uBEsw4GBfOry80n4j200TIBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jes/p1Md; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jes/p1Md"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842692bf60aso57564b3a.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780325730; x=1780930530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucLWeQnsBGLAPiidynoEcPmhY/+QtzndcMzG67axfbo=;
        b=jes/p1MdPdVjcPSrGi+wURK7tgndDYfbASnHHF4T8HnJYw2Jxr0o6SJNI5H6UwBwYk
         6sk89jheAZ/Z8L29eDSycqzzCDWfiVlUaaryWFTlBP37UZckuGZB0g6Ogq0GmJNYQeDX
         lzD0dZ9qTulY7zvs16WHTKqHTBidM+glsbrMfLGMoJBxKSys3wcDTZVWVU9XlrJor3NR
         rRqM4t+FPeTw0nulfFmNAyFR6pV76Vq47dElbk8LGBca28gWbn3BikoqCl88a3pgxZqg
         NyhPAXuuJk5Avqv8n7NaNz2N44GDadOYSY1f+RH16yaQ2RFi8IBmlzZ2wKzlWHYixSO6
         J5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780325730; x=1780930530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucLWeQnsBGLAPiidynoEcPmhY/+QtzndcMzG67axfbo=;
        b=UMVAMupzF5dQLiHVd5FdGIsU6WGLYbWjDIuGjj+PozeaFmCzjMdD/3Az7c63/AMEOf
         BH7RriDagWd8LeH5WxVp7FHjKaEGSg3YbEZ2ynMat2I7iO1bo7sEzSuBW9GAA3BQIzhG
         L5h2TlLf8cSR3E1YsWaVEU5mvFU/CVwzHladljz9i4/dzHthxmSsUeYwVqJ1T0Rw/cJd
         bJbvOMYnfkcw4PE+0N5foGh2JbF+w3j6S4N7Le5wuDCYkI12cTB6GntXL0ZnbT8WSqko
         B1NqlD6xLyTP7oz2hMUA7fZMhwsxWC6rzyKIZnjEL3LBeLHssRxrGh4ULoanDF3wsYa9
         HdHA==
X-Forwarded-Encrypted: i=1; AFNElJ9pXLSZMLYTCBrcGYXpRUaBcez47idrFRLtvf6/gWYmJ6bpBLu8mgrDS7F+0nul/pcaU8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVy0R28r6/foh/7Dyc69oO+9fliBgxq1m6Ml2bB1vwf0Tt+KDV
	3rvNo+//nS4B/HaAzupn5Z0Waa8MP9Bwx1G4QwG3ou/WvodqZszMECYLEl0pQCztjfq7aUHXnxY
	Z82Y9UA==
X-Received: from pfbls23.prod.google.com ([2002:a05:6a00:7417:b0:835:4568:a5a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:992:b0:842:6482:aeb
 with SMTP id d2e1a72fcca58-84264820e49mr1460978b3a.12.1780325729404; Mon, 01
 Jun 2026 07:55:29 -0700 (PDT)
Date: Mon, 1 Jun 2026 07:55:28 -0700
In-Reply-To: <ahozqrW-YUAOEZls@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-20-seanjc@google.com>
 <ahozqrW-YUAOEZls@google.com>
Message-ID: <ah2dYFrhUc-v3tLR@google.com>
Subject: Re: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h
 and mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:22:02PM -0700, Sean Christopherson wrote:
> > Invert the include ordering between x86.h and mmu.h, so that x86.h is the
> > "top-level" include for KVM x86.
> 
> You're also silently moving mmu_is_nested().

I'll explicitly call that out.

> Aside from that, I thought top-level include means that other headers
> will include it, and it will include fewer headers. Seems like this is
> doing the opposite?

Yeah, I'm probably using confusing terminology.  I could quite figure out how
to concisely describe this.  I like my pyramid visualation, so about:

  Invert the include ordering between x86.h and mmu.h, and move
  mmu_is_nested() to mmu.h where it belongs (mmu_is_nested()'s placement in
  x86.h was solely responsible for the existing ordering), so that x86.h is
  the top of KVM x86's "include pyramid".
