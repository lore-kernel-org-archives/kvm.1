Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A033D75B1
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539774; cv=none; b=eK7wsxTuT6+X7Gv0y7U66lDdVj7vFSE5Eeq1gfy6LYGkPkjWy53cSDhNw5Xwufd4KIa6bveP4eXzR1gjrks/YcceCTRp2mpYRZy2+nCh/0KlH0VNNpuodJ/hrFeWYy3+421AXplGnoGjiCXdTtVbIIrL36z+l/YUBq4bmoBYqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539774; c=relaxed/simple;
	bh=A2ZszD5oB/5IQjIY93Gpv4YTCK5z3C0SzJKpHpheYqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4B5P9awo/Hbnw+fyoTr+BnkHw+ELECbH1ryslavBGvdjKZoHFM1OSfKmU0Io/SI8x0fd3aUs/Ir5AVmyhHseHffGRfPXPfofioBN2WrsGJj3C19iX9CUUoQOB2C/KCuKicml2Bx7xPwqw5D1ahaGXfuB8/g53RSXzj130z+qbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8OuXPAN; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8OuXPAN"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso2756630a91.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785539773; x=1786144573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A2ZszD5oB/5IQjIY93Gpv4YTCK5z3C0SzJKpHpheYqk=;
        b=A8OuXPANnLkDjarhzKPe24I6SF43B15rvif1t1SQ0QC67vSCeuD6AXVGy/D3nWeQNH
         Pav0kVzw0SgEy1O6C6cpRR7MXAUl4tz2Quzdj8/Un9nv4U27NsyY2Ly5RZbgBJM25zWT
         uOd0UGXyFkUXkVj+Fs24OSsNHhGtSIr8B0EFeo8CBFPW2M4EsQLoLlPsntwau+rxy0rv
         hWAEEF3RVWKmW+41MAQlwEGylETmDUiRym/EHVy/kwogCZFjncvpZ8pdClWKVMGbpFDF
         p3b+cddI/bBOLzuiReaGe+Q+I5EWk/HZT6uUxA4aEICIRh0aHVE18tHma2p7n0bHZDAu
         vV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539773; x=1786144573;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2ZszD5oB/5IQjIY93Gpv4YTCK5z3C0SzJKpHpheYqk=;
        b=eeM1GAMXw9CAyBzjZPHrNLEHY1BAO0cPeoZL6JcJYNpCmsMYLSiPEKeVfTDiOgXGxd
         zNisk050Pi0qABdIiWhjJqX9U++2j8gM615JxztbIgZ2wpzTlDFg4aCz/gzQWn3iXvWu
         zRC3t2sPatI4Vn7xHGBFZodVZ2VrQmCFshivwC1JfiSUnCgke/9VWwZvLT90ClXDpwIo
         JnzIFUnIqq+sNwQcJg3v9Gk7kOBe2LGhZcM7Sg20lQfC/AaNA/pVBqhuH7Fh4BSoveNJ
         mMx5RIn3u0poIYFsFJ+keYXGH7XzsfRN5BvvwNT0Ivb5w6anvn7v41AhAn8i2e43G9FA
         GBEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUSFwqd+8a+1HNSqKIPLP6pJUFzYrp6fbzU+bu2kOFfGEPokoawTD7r7wAU01jHwBgShs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhnsu7pwTBNyXcOR0npWBCsC3xXMAU4vChiJymkxiNgabOUyc
	wJvKn88OgGqEIrJkyzU27eEwptlhE4zP8HOUPzHH3ULTLb2rZTa7R62e1xlPTswXw9HdPjnDu3p
	lwjivIw==
X-Received: from pjbqx12.prod.google.com ([2002:a17:90b:3e4c:b0:38e:a577:5cbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:584e:b0:38e:76f8:fcbe
 with SMTP id 98e67ed59e1d1-38fbc561b48mr1327142a91.29.1785539772383; Fri, 31
 Jul 2026 16:16:12 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:16:11 -0700
In-Reply-To: <e8e7554debef481d13265f0870e847e2fa37f7c2.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703212145.343527-1-dwmw2@infradead.org> <20260703212145.343527-6-dwmw2@infradead.org>
 <amPWX8lKXw2KS_kZ@google.com> <e8e7554debef481d13265f0870e847e2fa37f7c2.camel@infradead.org>
Message-ID: <am0su482WLEa3ojQ@google.com>
Subject: Re: [PATCH v6 05/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026, David Woodhouse wrote:
> On Fri, 2026-07-24 at 14:17 -0700, Sean Christopherson wrote:
> > On Fri, Jul 03, 2026, David Woodhouse wrote:
> > > +4.145 KVM_GET_CLOCK_GUEST
> > > +----------------------------
> > > +
> > > +:Capability: none
> >=20
> > Why not add a CAP?=C2=A0 The check in the subsequent selftest is quite =
gross.
>=20
> Because nobody would ever use it in practice anyway.=20

Yes, the selftest will.

> Even if the ioctl is present, you *still* have to try it and fall back to=
 the
> old method because there are ways that a *guest* can force master clock m=
ode
> off.

That's totally fine, but userspace, especially for selftests, needs a way t=
o
know the ioctl exists and _should_ work.
