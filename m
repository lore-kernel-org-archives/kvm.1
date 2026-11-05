Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793919412;
	b=G2xzL8ZPdQms2Dug2CYEfPZKPoCHNPCrPCmlouuk1Kirr0XZJRMtSUbDcCLNyGCKRWL/
	 DpbfPKHisazSEZO7oByFj+kdmXfjSpHd5j4WrDprwjeVrNc1tuPO1xqpJqepVel5vVzuK
	 WQNzf8nTSZD2UajQmdLJACR05xu45+Jnys9OppgIIaKbAxRP3vMiTw93ZA7NZjTWUyUB/
	 NbCL6UDdoqEYiMMn9exFN52RaL07CuRZrDNXgL0LzDwzglhKdEVfJraDtMTbflUZ85JYy
	 smxZ3KS7gj+V9yVvVbsHaVDauIBKJkTH5IXBZtRr7//ddxKNJP5oQxoHRjKyA+LMnng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=beWRPlgAl/peRVZEkF/oGc+heGWLz/peIuKHHlXmZvg=;
	b=x6/JweIBPzZ1QbGEIq0uJ8obJHqehBd+lScmUZF7al+mbrWKkk9rRiA8Fe9ePlrGxiXa
	 cuwOMxiK+LWFZagDILYlZ/jmsHtaIOch3Vp2WGCBwuVKBmcClh8vwwBkk/7jIuW3IBFma
	 xvUFIqfJu/lW9Sz/2ZBkSLJ5EYMOoOTr6j4Cf8bvFX7Ca9OK22zptydnA08STpwiPulQX
	 1CG4zm/CdKd74PVJXiL61/LVtQra6vXprjZP/8HijpbPEta5Ifs1eUaW9Bl9X5FOrAP3e
	 etkLMWSK8MCOPd1DYKzpbA3KzQLH75lMGJsyNKmYVulW2YfjQTSHkUG5SXy+wCnxxKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XwnFB3pE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A26606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 22:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A26606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XwnFB3pE
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4395d31228so5654766b.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 14:56:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793919410; cv=none;
        d=google.com; s=arc-20260327;
        b=GuKwKrVRkE+Ll+swOB+OXuenldTtgIa0spGN1Y4/zrJLcNEW5lf1WQFX3bqKtyup/D
         OmRjfULCX6jKAAU+S7LYL0E+m9VAFNYAA06dTzm1FaPUtIw4EBZwZ+w4Q6ha4SEieGeU
         rusiSjdb80xmR06eqlFYnxUvtI02k2uPNMh1wfRqoF7dt7e95QzG5k4/BkT7m+0D/dxr
         RcmBtK/q+o/5Q79P+hcnTo+Fvg5CtrV5O/mrSOd5uZEGrtjyYuZC7bMLIF0H/npCh314
         DAKnGnqG4QYufbS+e/7o/6KDqaXKSPIhBut5mBlrv+JAsKYObitS/Pc5jRIN4zbFGdar
         JifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=beWRPlgAl/peRVZEkF/oGc+heGWLz/peIuKHHlXmZvg=;
        fh=HTjz2f1phudJMjJ9PbM7zyopFgxNuvYRxxBoyM/bXl0=;
        b=LC9ObxEfE2GkijUYo6l7yqzReqESIR7mR5Hq086idT1tPJg5n637qSRNovnvVpMoOl
         kNOCbm3gNmYGJUvj2v2+arjqIwqAdMvv7TWOto+Ct1MLQUXJnzVgNxNNjRdBsB1E96Np
         b0uw6Rlf6i8ijCsfEBXDzAqNxP5LJuox+gObkzsqPW15EL4ZyKlt5ESyv95Oi3Z0ssO+
         cTQjaw5cNvqtl7VHEL+WOHXtYY8DWMnNw3KuiQGAkIcFdRKZTy6dgWjjt5YcWBsmGE6W
         b/kpi6w1+BEUdyt+PTfWflOPDnccUxqvuSxdY+tPqYO3TykgBqlraTsizyWlFoOV2uVI
         cYqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793919410; x=1794524210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=beWRPlgAl/peRVZEkF/oGc+heGWLz/peIuKHHlXmZvg=;
        b=XwnFB3pETFUMoUj/6KBzwkdVdkbnR/jrtLE29gyRh8FQEeJ3BBs0+EBi40SfVeS6Mr
         0BOcZcKLKfjoeZYIQqbPO5EX9XAqc4M7jznEVvkiRNLn34aP6iSY2gxHWZVswUhOJQlz
         1poM9X8uv0KXQIbJEt5Cwld+Zkm5mcQdxg3w6nyhOobhXtUC4/Sv819zuAqqVpYT3dg0
         CBe8O8GAB3xUDzHoU5YIXE+PoPjSgZZmjmpiU2F9OXCsze29bNMiFh0g28yX55wdVXNO
         jbEXQDpUkT12V9VnskV3kAY6RcxRqq6qCSFFWoERQ9LcHtXbhfcOCOR9tEZOoViKsxkg
         OHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793919410; x=1794524210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beWRPlgAl/peRVZEkF/oGc+heGWLz/peIuKHHlXmZvg=;
        b=2Jeb63EvbPx0S2HWKERz25+4vXoraL6eLvHhh/aLGraCyt641r/l786ScOTKsM2zpn
         S5d8EfCEyrGK7RdDi0fxHs8klxfe+3snu/4obfPnePvxC4WOjuOSSiYbIs7s3S6zGE1F
         +FGy5yK9a8dbDaw2RL7Z6e0sbAq0GWNgwLbuY571SYGV+keaYBatRZmWeqahebL9Oo2k
         8EJaTDqQqVStT3SykqFJ/V2SKWIT36eyWRqFvWi/OIHJC1E74kN+GUHtdEDV46opiFGc
         IHkRxUNiP3YrBO9e264PpaQGg9QVmegrNnAa1d5kS0UNrOK9wvWVRk4EovXrTLWNYN4I
         zmNA==
X-Forwarded-Encrypted: i=1; AKwUvBwDvvrI3etdzde/YJyfBpzSLzYE4V9869IUQZxJt60Rk57dxCY58wR1Tslf907ZSJKgw2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WqkXy45Q3P1w0TW+PbV1Bp77mDzof5ndNtUIDQoDEvbsLNcO8
	VUm8yV1hm0Ea+HLnZFBD2g3T8Ab2m42IiOhTeQ1mVB4QGrx7nCxHhdErHW5Ed6lYUgpelmSBj0h
	hxP+RcOIlopvmqoQkh6+hqktia/SlNJD+gkGWEzUb
X-Gm-Gg: AYBFou3KChCMyegTePdIxrs4Q+9r34+yUORU0EizQZFqmCNRrGa/te2fggKFnWgpPS1
	yWRT8NsW10j7+leQMs3KXB0l0wpsTrTdZi+fsFx3TOBv2LhOfzWZqIika/6JGRaUKv6miQSki78
	2ZYyeg26tHwPFzIgC9+NU8sdfVaaVB0VfWclk7UMQnlAuLeWR5uamNIerC6FKI7lFmmdX+Q8ohz
	YFuNoiSXSYEkvr25Tq0nCswTOon/n8WXFYktf2u6ZmzZQ40xbzK0WVf7DnPWXBekD3X1QZxuvQR
	ZJN3CJjWVT3/va025EjhXGZpHSm+w4rv4FldQ8kPSIBLu6pJ6pp949MaDhEovm3aRPBPrNbxS4R
	G+l7XfRT6FIn8/+jXnynQndDO6y+DL2WWuDFwxg==
X-Received: by 2002:a17:907:9811:b0:c40:36ca:9d1b with SMTP id
 a640c23a62f3a-c4d354fc327mr75827366b.40.1793919410007; Thu, 05 Nov 2026
 14:56:50 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102230445.3993629-1-almasrymina@google.com>
 <20261102230445.3993629-3-almasrymina@google.com> <20261103115926.39e092b8@shazbot.org>
In-Reply-To: <20261103115926.39e092b8@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Thu, 5 Nov 2026 14:56:22 -0800
X-Gm-Features: AclHuK8Ff2i-kZKWxjfqjpz2XvgyET4nKGr7VQwICZxEIxfoafnklYeCqUTiYZA
Message-ID: <CALzav=fXeOTXXhxmQKidmO+vrxZDDeecvg2qrPAs6KEWLWPA_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vfio: selftests: Add vfio_pci_find_mem_bar() helper
To: Alex Williamson <alex@shazbot.org>
Cc: Mina Almasry <almasrymina@google.com>, Peter Xu <peterx@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>, 
	Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:59=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Mon,  2 Nov 2026 23:04:44 +0000
> Mina Almasry <almasrymina@google.com> wrote:
>
> > Add vfio_pci_find_mem_bar() to libvfio to locate a BAR (or range within
> > a BAR) of at least min_size bytes that behaves like ordinary memory and
> > can be safely read and written without device-specific side effects.
> >
> > Detection is backed by a table of known devices, starting with QEMU's
> > pci-testdev (1b36:0005) BAR 2 when configured with membar=3D<size> and
> > membar-backed=3Don.
>
> Should we test for this?
>
> We could toggle memory decode around writing a short, unique pattern
> with read-back verification.  This might be unnecessary for a physical
> device, but per the definition of this function it should also be
> harmless.  For the pci-testdev, which is our only match in this
> proposal, it validates the BAR is backed by real memory and not handled
> as an unimplemented memory range.
>
> For the use case in patch 3/ it doesn't matter, but for future use
> cases I'd rather see that we generate a skip or failure based on the
> test here rather than debug failures in the test case consumers.

Sounds good to me.
