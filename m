Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637A321445
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490057; cv=none; b=b/ebl6mCIKpARadRPZig9xy6ude66VxvBL3NnGDjU0+AlmhuHmseMKUqOHIxaQThulrO0EoL/RSsmAylLahrDO1rGZkzTp/tnN7qfdWsMxRvSUFdm5LRn2FzuIICIYGepuAtFHlmgksmTHCZosNq/GyiWyI/Bv04KrsA8yHQsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490057; c=relaxed/simple;
	bh=GeL5TklS9/MJdTTnMy6rhg+Erv9B1Kj4QIkaGUhKAHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owls7ApGS9cOnj/xeHLGVifUaij3NfxS3VYRezJY171kZE0vI9VDzNWfmoT3GjmScApB9YkslOB841rrs49w809waxQTU6ufhj/rpcV1Wa+NgcdSVt17EOuqHRpyPaL1H7D18Oe/+IawYtsejnj7OIDQBR1jOuFI0akuLl8dM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4X7xpRb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4X7xpRb"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c89d4ce16so2690750b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775490056; x=1776094856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3Kk35EVNlkIAvGN2qGdLIz8gWMcjgIydFJ5LWEu5vc=;
        b=T4X7xpRbx3SqsE9x8Ogvb887AovyFU3P/Wb5DIHyxjHDrJfcgMy9K3kVlVqagvtpxs
         0o4o6o/8RsA0pVXWEYcU4UX3MJF9g/iwWE/se4ZnC9+ZU06mg8zh+KPQASovl1tnDzEQ
         qAKYzTMpFEiJ6PfECKO5LCHH2nRZSwnuXtpkvlUgq2IoWKx/yC6xFCBtDRY7nC8AOyAT
         wpUVSzy83L6qqLNpeDvIWeMrpaE1uF2pHciVapIJhHoOhfyaCLoG2Hx+xpuZ7iq4QiU3
         oN4H8NJBxIFy6atCn+zfL971jItM741ETosSqioCZty/GMtatLTNcJIYdrbRy97j51XA
         tltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490056; x=1776094856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3Kk35EVNlkIAvGN2qGdLIz8gWMcjgIydFJ5LWEu5vc=;
        b=TK4/KIi3L9rb5IO46fCpc7DUcFzO0FruM6lhTnBDQJawOLpAYCbOCeIxIrq1/PjI8I
         uuPcbflH7J0G56f7Yi60iH1ZA1OkCVipdRI8NI9bRlNMeJ79gj1Zz4UHQY+tfrTWFjyo
         hv27B1gXMCDJ8cibheZer1wY2HFXUFMWWPHi0rKTNwsOlPvi9oio6LC30yxg1dWeYLU8
         0PcufwFLtEUO/3TJWlZA5AkqfouE+aHJScQDseF+WoIuqebE8HfkrAThSX69yIpaApRf
         469VFR5yYC15lco1GzhGX2bX1+fdvZutFl2dGOXgiBl6qdYBfuSBQpmy1imOhUA3zkbu
         LKAA==
X-Forwarded-Encrypted: i=1; AJvYcCVDjgac1ftCwkJ3/Ly+VsCTJKI9qoqj+BxbsZvQT/bhAVY1lS/qVhuXLQwLrN6d0eE7d8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3syoCjDkpjxOmvaZGBb7N/MVeggs3F1SXAFPebkaKxCeNdBG0
	u80BHoXTD+LFUFzAzsoJE7B0PDJUwz1q8R9Xe/q8wGUW+iMfjBnAZKt3t96IVUWShWe9Q5TXJsI
	K28Z8Ig==
X-Received: from pfblr14.prod.google.com ([2002:a05:6a00:738e:b0:82a:69ed:da7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f89:b0:82c:9c5a:4c32
 with SMTP id d2e1a72fcca58-82d0da45875mr11660901b3a.6.1775490055769; Mon, 06
 Apr 2026 08:40:55 -0700 (PDT)
Date: Mon, 6 Apr 2026 08:40:54 -0700
In-Reply-To: <fb9e61cc-20df-47cd-b324-1dd8d5985372@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <fb9e61cc-20df-47cd-b324-1dd8d5985372@intel.com>
Message-ID: <adPUBrHO9gdGG4k3@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 03, 2026, Dave Hansen wrote:
> On 4/2/26 16:19, Sean Christopherson wrote:
> > Do we know what the compiler and/or kernel rules for using R16-R31 will be?
> > E.g. if C code is allowed to use R16-R31 at will, then KVM will either need to
> > swap R16-R31 in assembly, or annotate a pile of functions as "no_egpr" or
> > whatever.
> 
> My _assumption_ is that the speedup from using the new GPRs as GPRs in
> the kernel is going to be enough for us to support it. This is even
> though those kernel binaries won't run on old hardware.
> 
> If I'm right, then we're going to have to handle the new GPRs just like
> the existing ones and save them on kernel entry before we hit C code.

Ooof, one nasty wrinkle to prepare for is an NMI that arrives after VM-Exit on
Intel CPUs.  Unless Intel extends VMX to context switch XCR0 at VM-Entry/VM-Exit,
and/or provides GIF-like functionality (which would be awesome!), it will be
possible for an NMI to be taken with the guest's XCR0 loaded, i.e. with XCR0.APX=0
even when APX is fully enabled in the host.

> I'm not sure I want to be messing with XSAVE there. XSAVE requires
> munging a header which means even if we used XSAVE we'd need to XSAVE
> and then copy things over to pt_regs (assuming we continue using pt_regs).
> 
> That doesn't seem like loads of fun because we'll also need to copy out
> to the XSAVE UABI spots, like PKRU times 32.
