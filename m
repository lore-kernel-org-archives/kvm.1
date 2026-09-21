Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2784F648A
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014627; cv=pass; b=fojXwbSbGmMYnJhc7suj1505dUw56ynoUBL1aUMHj0znxbhhDLnBAxPtB7mHD0Fs8340Z66CU0TniZD6yeY3unPT/RkZA3ll/eNTJdbzSaXRT3Ih0D2snkvSRM3v8wEvlSdATKumrwqAtrRUTCSWYwB7F7wZKAnwaiqzussXGpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014627; c=relaxed/simple;
	bh=i8TfSstM+nFUfHowVBq661f9yHcafviHx7y2Zv6Y+6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYWHv/5nIsuWFziWdQxSkLWrV1o80538tpJTI4LMf9qOZv7oEvpc2SiQKXg1dC3cjj76K+ThoDYc1SgCCtNDqwz2CtP7c6GdaS97vEtIetNyLd0NIWS/bwUIuT3Dba8O5LBVcXZR1WHGjdsVvCI+XbefheGPRkzA8QkTeAD2bHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoU1ScwZ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoU1ScwZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so1242a12.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790014623; cv=none;
        d=google.com; s=arc-20260327;
        b=UYlMXASvD3A6IXfD579CWfeV/+j0olKQYkMs4CABibQTY4Q1DEwQ+Xkfj+BA10aek1
         36FWK/SA8+jS+z79RN+okfCYiBqcRJSfT704c75qQQbRtWiCoLnMEUw8HCZVmcTfoMX0
         8Sdo74W7/lV5Up7bvPyha1TB+1G2AMJGJWYTHm2+UXtcnWEKugEgW8CSsVNmWuInz+OE
         U635SL+vUvlixOIE/Fgc0f0MOMtrzPnxLdhJKFnLGRYcOWXcecU2GiQZrU8sKz8NbM5W
         CPSo6JROJTCtq2ui7iKi185pmf/WdefwECMZTShVXZfQ5i5ubPk35TTXmBNUwm4o4Eq+
         86TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhkO8C1Km+Np1GICbpHNNLqCS950Qr/leZl7SKXOzk4=;
        fh=rTBIMKysrh/2QrV/3ga2zlwxsXARlx1xMlPqQYm5tVI=;
        b=Yn/VgTRywznph/Y3txSsQmH6gaVlLgi7hcV78CD/S3DwDsSLUBNaV/Zg/l4I+SVXld
         qTZbusn9WFyJUOsLEVwtRLXDw/09mElcehKFDxzgxg4P8d5XS68Dqoh/sIz7KYCp5xvk
         D1ZOdrF8A0CiV+Q0cd1ErGyvMYuxGTmuE1Zw7l0gzr0Y9WHMj5afOV9aDelapUX3/dtk
         SYK6ZguEDL42dUW6DMRCMbWFffowKA0wyL0R7Bf4PHYWr4ACh6zwycusXukSL0Tg9RVG
         gC9PVM5VIIfIw26VZyu8laEWQLQ6nfl/tM0jVUWIaKeOerRaofhDtYQINqHm8PXNDxI6
         5qjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790014623; x=1790619423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DhkO8C1Km+Np1GICbpHNNLqCS950Qr/leZl7SKXOzk4=;
        b=PoU1ScwZgzL7jxiwcYQR1YwcCf00EZDV1nmorhMZmMe0AcPJWuCfVa6pz1H4VlPqhQ
         XwTA8pWKMSZ6HdU9WXVgwiYnGVzSBMI3ghSKyL+l1TdQ+EuHhxUQpbq09BbDuAuMeLxT
         738Mr016C06w28DX208uWdJ5tId6ouwUEiigEuYsNIkKue7lF/X2Arm5jPtnvOz5m4Ly
         zaWVY0dhpPQFsXPlDquTwZozbgLOjl8hF20gIdGmIl5OWnJYGP1wQ3wDS9g2EEr5ee2J
         YNLGL+jP0bXUeuiAQ9KXggX6c8iTp/NCXk39b/B550GH93zalDaT7JCP7LtuMGwa1XNH
         ME6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014623; x=1790619423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhkO8C1Km+Np1GICbpHNNLqCS950Qr/leZl7SKXOzk4=;
        b=rzGnt1C9n11duZipHCVO3YjubQdFiwYww+szourAhfu+4zxTJxxqBKxhitWMrY1VbW
         uQLG0d47eQAO+KkZB4K0Bfk/LO4YZD+2ciKS3Zx20to6r91RsnlKT7U+GTqCF8w7Ii7I
         VVbKLB/9HyjtFCeEVixboIvnuvdVmrASmEGnWdBTr48PuX9JZDMbbjxa3zc7q91WREEB
         OSEyovM9CvWNqT+fOHXuPFY29qdAqmo/GYrbF1ValnWfTQsjrnFkOf7E0GTFpS1DKt5M
         hT/N+5s/oPe0CODLLoM/WBvAgzEJGODn+J6Y9UyQwsVBLfa2t+TPfShzHZgmAJjdZB+D
         UxRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzR2vKV05vvqXRgaJS0D2vdIlWXd+ny4PfBm1az3AHOnBcTiYi6mvoK1oSMO3DVFfJJ5tA=@vger.kernel.org
X-Gm-Message-State: AFuF++nUyx9lfdWrn8ALrMEOvDLKKpXxwRMFcIv3VaZtGf9lwvO1XunT
	TgBhEAA7fZyM65XvZ55VpAJU6AOVippFqv8AncNOprKV3MsQ1Jw5WO462dEQXJyGIT0ZcYBXt1W
	7ADy4CRBc+/oHRu9f7aVtGHnnkHRJmck9Pm90Uc4=
X-Gm-Gg: AYBFou3iOzlrlgVLwWVlqMwsbtY61De4EtHhxSbHinXEWSi6Cd3GvPVYetG661aNYbU
	NCUrXlJ5psajK29Fa978WUFFXCX5MHXZj/01+Bejr+BMZJyfWzD2zPkUs1wvyPpYvIiQ7dqtvkB
	BqJaVk4CkwZZ6B+9va7OJbV7BmowTlzlRgpZkfyN3kMyVnr5w9o2Ax1qUfgBEitSFpMsrc0nqTf
	L0sWbBdOUj8LkxQDf7+DqAJepmQ6YpWDSzR5zX+nFesDzrFpSS6KFnYgW1eoM3ks1SW7mXAx6XS
	jSp9HyrghoGIZ2gghkER1zWnla1yOFZf5IkjndRjTo6SMBzHicd6h74iAXQNw7dLKP+M4XpYsie
	0NWMglAK4BUI0oLPFvhEwAw==
X-Received: by 2002:a05:6402:1042:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6aaa0b62266mr3710a12.9.1790014622395; Mon, 21 Sep 2026 11:17:02
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
 <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com> <aqlWt4jb4CSPnecN@google.com>
 <d6179d34-a4b0-4548-8298-b790b333d22f@amd.com> <CAJxe5ctcVxmhRSw3Gt0POQTzRKoxXo7+Y3CPDe7cUZvC0QPK+g@mail.gmail.com>
 <aqrhFvwFJsQTaEkz@google.com>
In-Reply-To: <aqrhFvwFJsQTaEkz@google.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 21 Sep 2026 11:16:49 -0700
X-Gm-Features: AcwNN1WyjYSX1uzNk8-9L0xtWomFK3mRNzacv9CeIaSJ0csFTNXZn02hHr10_0g
Message-ID: <CAJxe5csCb0DHZmJo9a-asXZ-tYdcyK1y0Y4Y9Uoixqn=sa8zRQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:34=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> The problem is, I don't see how the guest can know when it needs to disca=
rd the
> VMPCK (post-request failures) versus when the VMPCK is still "fine" (pre-=
request
> errors).
>
> FWIW, I'm not terribly concerned about bleeding host issues into the gues=
t, I'm
> more concerned about ending up with deferred fatalities and a mess of an =
"ABI"
> between the guest and KVM with respect to handling failures.
>
> What if we "tickle" the resp_gpa before doing the request?  Similar to ho=
w CPUs
> probe bytes early in XSAVE/XRSTOR to avoid having to unwind later on.  In=
 this
> case, the response is restricted to a single page, so we only need to tic=
kle a
> single byte.  E.g.
>

Agree. I see your points and why this tickle idea is a great solution.
Actually, building on that idea, what do you think about using
kvm_vcpu_map() in the exact place that you did
kvm_write_guest(kvm, resp_gpa, &tickle, sizeof(tickle)) instead (and
unmapping afterwards)? A few reasons:

1. Like kvm_write_guest(), kvm_vcpu_map() also checks the existence and
   writability of the memslot via __gfn_to_hva_many(..., write=3Dtrue) and
   faults in the host page as writable, plus it pins the page across the
   firmware command.

2. kvm_vcpu_map() has cleaner semantics of acquiring and holding the
   guest response page in KVM until the response is delivered, rather
   than doing a dummy write to test the waters. This is somewhat
   consistent with the GHCB page itself, which stays mapped until the
   response is filled in.

3. Pinning the page prevents a malicious guest from converting resp_gpa
   to private between the pre-check and kvm_write_guest() after the
   guest_memfd in-place conversion patch series [1] is merged. (This
   assumes a future guest_memfd implementation, so it's less convincing
   than the first two points. This was also my original TOCTOU concern.
   And once we have either pre-check, on upstream today the guest has
   no way to change the memslot state before kvm_write_guest(), so I'll
   also drop the original TOCTOU commit message.)

[1] https://lore.kernel.org/lkml/20260830-gmem-inplace-conversion-v12-15-85=
e5fd25252a@google.com/
