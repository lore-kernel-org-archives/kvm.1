Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E57406825
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738197; cv=none; b=V7A3m+pPJIbi1JwPI6GFxjxLH3FyNL5Yld+5OTyw1hnT2aVTufir/GqdHs7zMVjuDoOxwWEaeWpsG4t7BhRCg8ksKB8Dll+WxaKbv/VbFdioP5p9tuGa91PtLt6qTwS5QY/1kylkL5Ik8wRI8BemgKGhzehXlqru8hlZaXeFk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738197; c=relaxed/simple;
	bh=QzHO9rY/CtIAv8HXfSnkdklYNx5mKbH6Pdnr+ICvII4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d2LSVgj3IsR7sc0L4FcRnaEwK+1AXbFpHYeCWrHGHLzCgHLIdEweT24g6824M5kI7pqGKl0uerCWAwN++etu4m50HpfG/h9+CsZxDBBuzFA0bl/pA7FYBgJepDrO0V2Ge1GyNEftRoMairZknHfKAyut8yVdTZn4CsNOtcnRwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bciugSKj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bciugSKj"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c916d17dd43so3319385a12.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738195; x=1783342995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yl8TtQXyuolL8nZ6HbtJnqrxGIxfLdq+rZHzfl+wTig=;
        b=bciugSKjHMNRr7un34Bmm3RtJRp/0muKSi1HQMHsdNAFtQ1y6mx2GW+97LBoeGhnVc
         HurZ289cGrKfJfzPH954CH+rxeuMJOrvESewj31UajcsvSl/CYdCDP/8MnNnH507Wts0
         9hqblfUON4vOJdd4XXAmLzVVSf1QLa2tO02aNP2qdqCxCDWD4r4sbLunTSFuey0FowKm
         dLrlHTNX028NSDhaFYU7qolfphPV7dyk3E5VybraSqvUTUGVIyLWGNXUV2U3V9vj3HG6
         QxZCqx4Z/Wj6WADRVvQG04umvy2POhyJttecTkUXYpsApDmbukHg6HCTA13Pao4SJRz7
         LGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738195; x=1783342995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl8TtQXyuolL8nZ6HbtJnqrxGIxfLdq+rZHzfl+wTig=;
        b=et0nWfkXKAMce2HOAQ7MVDyLQa9YhPPf2kIsVO3j7FFoXDUrWvPH/dP5mt3Ttr5Ytk
         vKyckda+JwxC6k6K11wHq7SUyuJmaLD5HGFe8Z7IjfIfdtQpCxwzFAclisnjP5YQohEx
         XR0i++1JY8nsDlVqTl7l6xzcHHDicXGfJhoI1aovL4b6LZBXQ2VYEwH+cdXvURxCXGAU
         vS75AwQFRe7uX0bkop58PlKBilFHADgM5Dh389oHA68cAFDsUGZwZ+Q5CpB+5S8SRbGG
         HTYv6anNM26oPbdK8Yww6EjB0lejallSFCTjpe+bqWqH+JdXzsRWfi44xvUcffQ9x/cl
         6KLg==
X-Gm-Message-State: AOJu0YxN4gD1oylarQlgRi9RDvHFqG0dTsnGnOQdwouiSt+mpxlnCA3y
	vGMInaIIpiV1HYuo/fWZeadmB+BrANDAH2zV2YqY4hD5eD00LC1DRnyeJHyM40exYV9i1Y1une4
	QksW4bQ==
X-Received: from pgum11.prod.google.com ([2002:a65:6a0b:0:b0:c91:e464:eab5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:48e:b0:3bf:6c08:fb9a
 with SMTP id adf61e73a8af0-3bf6c09144fmr7741718637.60.1782738195142; Mon, 29
 Jun 2026 06:03:15 -0700 (PDT)
Date: Mon, 29 Jun 2026 06:03:07 -0700
In-Reply-To: <3c0f96a316a968e5e0301f355bc05962c4b975ad.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624220516.3033391-1-seanjc@google.com> <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
 <aj1KP2h49GzfNHFz@google.com> <20320c7b5e6e9a01f2607761c934bf47ec8e2f64.camel@intel.com>
 <aj66ZyxVdLjF_0dc@google.com> <3c0f96a316a968e5e0301f355bc05962c4b975ad.camel@intel.com>
Message-ID: <akJs_pOD_MVOxczP@google.com>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Kai Huang wrote:
> On Fri, 2026-06-26 at 10:44 -0700, Sean Christopherson wrote:
> > On Thu, Jun 25, 2026, Kai Huang wrote:
> > and because KVM needs to know precisely when the pending IRQ is unblocked,
> > i.e. can't lazily wait until the next VM-Exit.
> 
> Thus KVM needs to make sure guest will actually write EOI to APIC (thus PV EOI
> must be disabled)?

Yep, KVM needs the guest to trigger a VM-Exit.
