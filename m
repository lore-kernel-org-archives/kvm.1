Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5023644C1
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348777; cv=none; b=WJHLlPgLLsEZ1PQdhJ4kic6O654FayIQPbsHpKbMik2gczi0BK3HF+DsjBpEDti0gEUTVYuIVb1DqJb/9P4RjoD5caPmu5nyWp01ErwPnf27hzAVlMk/qUoUnQXBD6DUOJxB081r32/9q1DInBgqa0EixOZMKqrTrTU4xbGMKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348777; c=relaxed/simple;
	bh=5APlCdtcJZb/rE7v+wyM2ncadlp41SgLUmZsZoQeoJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/y7DX5kLSZ+DTvx33thyLVahxikKJKIFTuf3R03K1YnpMAL2z/sW7n+6/hnmwo9EF/O9d8IiRgcr+Jr0sfgOjhfIsugmjZay3hA682d8lOFuedDT3/Q2nnSCfrHFPHOiLEo8fExr3MXm066jscBQtUSYVwstWYt9ckJ3emWkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxilk/8O; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxilk/8O"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85c530ddebso429329a12.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780348774; x=1780953574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQoTn87Se07PYu57Sswj/cdy04dc5s9UilXz/c5El3U=;
        b=uxilk/8OS4l07WnAFuTW7qGB3PQ/oPGAXsruM77OWJf0wD2M75EVLtq881mOd/KUQS
         QZWZqb6EOb9u4iUlkc7mYQBUX1KiyUPOaLh08DjZzLem7qGew2Ve+k1dpz43OdQHs80v
         7nRt911u0em/8qdjcguoB9d9K31NPNcEgBP991cTuSe3jZJB+h7r+GJRxxXAM0jGDXnC
         rIMSZj8WBOXd7scBen1b4f6Zw2vbXQNM10PYy8lImJvFsS4HDCsTEn9PhH4Nz3N761kk
         VcyHU1okLgxVnWLLzdbD6wFe7z2+eFBRwJpq7gfdNYU6bVc7qA/f5GzxGqsFbeiveRf6
         XZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780348774; x=1780953574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQoTn87Se07PYu57Sswj/cdy04dc5s9UilXz/c5El3U=;
        b=ruLMhfKAqoR+zYc4kWb2vy4TUancU5Otgv706RJG+N8Q0haa9e0/twVnUV2dwkfzSj
         p9PL/GvP9EwbCDZEOBRXjyQzwUmJZFs1NQTRBLdvhoZPcdc4xlX/KP7D0mG7yWW1sh1k
         7UYibdcg0F/IzuovIU7kLrdQWDcKmwLP03skmvj77u2o7J8IczyjbqAS8dYwRTVGJtIG
         Mi1s6+WsLADP2i3YCCKSc1v3cHIqDDiYvSarwg8XIMV0D+tFAFVcOC4AeNVm8spSLlbg
         7dCI1UxQw3PZTC1NkmwcpHvz88HFXeVwT1bsFvmJp0b7g0fj7x7Guue3YmIZgf88DLYN
         0kkA==
X-Forwarded-Encrypted: i=1; AFNElJ/cJWgO0nXKOvyAwNpWevkXek523JOyua0FWjvT/r7wySUqZ5UNtFiN9SwbX/2EV4Cipl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VeKdIl8Z8gsKi4JlZy55gFB6VhHdZgWYLt8DBYToWWeFuEj2
	sLXHnMMNSMu3tLuXi94742mcwWhQm0LpkssJRoZlxXChU/xH1ZPuyOQsU3Xg3j4nUVdgG5TcX86
	Dw3xWQg==
X-Received: from pgbcm4.prod.google.com ([2002:a05:6a02:a04:b0:c79:22b6:a344])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7018:b0:3a2:7ef4:81df
 with SMTP id adf61e73a8af0-3b427f7b98amr14533049637.26.1780348774215; Mon, 01
 Jun 2026 14:19:34 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:19:33 -0700
In-Reply-To: <ah3q7ftEUTRmrBSf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-20-seanjc@google.com>
 <ahozqrW-YUAOEZls@google.com> <ah2dYFrhUc-v3tLR@google.com> <ah3q7ftEUTRmrBSf@google.com>
Message-ID: <ah33ZXE06C7WDjOA@google.com>
Subject: Re: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h
 and mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 01, 2026, Yosry Ahmed wrote:
> On Mon, Jun 01, 2026 at 07:55:28AM -0700, Sean Christopherson wrote:
> > On Sat, May 30, 2026, Yosry Ahmed wrote:
> > > On Fri, May 29, 2026 at 03:22:02PM -0700, Sean Christopherson wrote:
> > > > Invert the include ordering between x86.h and mmu.h, so that x86.h is the
> > > > "top-level" include for KVM x86.
> > > 
> > > You're also silently moving mmu_is_nested().
> > 
> > I'll explicitly call that out.
> > 
> > > Aside from that, I thought top-level include means that other headers
> > > will include it, and it will include fewer headers. Seems like this is
> > > doing the opposite?
> > 
> > Yeah, I'm probably using confusing terminology.  I could quite figure out how
> > to concisely describe this.  I like my pyramid visualation, so about:
> > 
> >   Invert the include ordering between x86.h and mmu.h, and move
> >   mmu_is_nested() to mmu.h where it belongs (mmu_is_nested()'s placement in
> >   x86.h was solely responsible for the existing ordering), so that x86.h is
> >   the top of KVM x86's "include pyramid".
> 
> Not to be pedantic, but I still can't quite figure out this
> analogy/visualization.
> 
> How about just spelling it out:
> 
>   so that x86.h is not included by most headers (but includes them).

Works for me.
