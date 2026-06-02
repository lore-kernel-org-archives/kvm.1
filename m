Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26843F9F52
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419686; cv=none; b=esU/NH2B5uTxOWxun64l5fWF+SCQW6+8ipyRf+lPEoKC+6BZrD5LyXifwfTYdco9ItA/R/WaFaePrV4F3kdLJuFHcha+XWJpt/K4564slzg3axjNRsNvMjPP4xIkNCnCtDSv35RH9D3jrBYdaMjgwN22zC8vieTtpievzbPgvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419686; c=relaxed/simple;
	bh=aM1TnijegOeUk2RD0a+zXwxv4tdI1BFk/km16+4KNCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rx1YPFt4uCEFxECiAIwUcPM3QhSTq9KgFUHSvY53L3iTpirD7jFa/wXpCAFT2f0LSan2/MmKItCt7mzg2dSnyb5v6x58/4fEznB1TLkufSh64OLU30BLDr+N9DkBk9FTXH2PKPJUD9LbZeHFI1ug5UMyq91Mr5sjhQTj036ydF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7qYQ0Wa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7qYQ0Wa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b74447so2223455a91.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780419684; x=1781024484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WXlG6Rc2cDvBdZmBsBuRGMNG5x+hsCuxrGJiOFPZb8=;
        b=r7qYQ0Waw8w4H4f/EqyXcCOjfdHmmlG/b9me4A8vLRPDMrWIDSzwPuOEiiuhe9a4KM
         +7tQ/DWnr6bGW7Tiw6tFZP3unnJyYF9NYQ36edfD9tsTkDGpGo2TCi8Kxtl4CA8K1o/j
         JAjMm2Ld+TGt2eXKi3qLWDiz/GnyqEmWkEDXo88kF/PyXrxaP3cvZgYbnzCtGBLdMTZi
         BP5yH9WYQNBUriDA6UYC6GeSQ8QxKvmYgCvrh91V2/wNZslGDJ9UgG3OUyLHcImkFTdR
         UESScMGKu+UhxbwdOTsqMlxWQXH7s+GW7hPkj7j5gl0yADARIWh1AjLrOro26AwBOFtO
         gF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419684; x=1781024484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WXlG6Rc2cDvBdZmBsBuRGMNG5x+hsCuxrGJiOFPZb8=;
        b=Juh3HdaY5xtoZ5kcr9LaIsKjxSkUvH2DaLxMIZLXJs1DiCjdvSgT+3wPckofcM5QrB
         CEfApJer3oVnsMRd/KZYFGOcoMRLToxlWih5OctTh/0r1gRlIsC12jz1XGw/qhgOhd19
         Qrw6fv5KRfAREMo3MxY5j2sHumShiCrMUtsAxTiVlGgMHidgwzeark3JXVNPgGctVX06
         kuwSlPSwWzP+PKArQBAHsSZ57e586/f1VglpAMFauaz7XUNRm2PJzm5zc/6cK2foOMUJ
         qQrAlkt8apcBsI1r2YNUDOjp9q9KJ5mMlz2Oj9050ugOAXTCdJP+gexg249Wdw0YKneM
         9OHg==
X-Forwarded-Encrypted: i=1; AFNElJ87tO87NdNX7wcP6DiVwz/Rwy+HA/RhG41zD4A8XC+L9EAmrvZnOwqbnkHBnU7dg9iSNjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nnWbdB9nvGgbRuOM3mNcf41KuxcUZt4iHkCN2g6OzLVh/7fe
	j7lfQV2rcly7vA5SyI9XxMMGbSWbqIAPRuMGR2U5Zsb+V8aXmldwufkrTPM32XepPGCqPiYBd57
	Q9AYYeg==
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:36b:8abb:86b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5146:b0:368:b4a5:c4dd
 with SMTP id 98e67ed59e1d1-36c4fefb430mr15714260a91.2.1780419683971; Tue, 02
 Jun 2026 10:01:23 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:01:23 -0700
In-Reply-To: <CAEvNRgECjs5UqJsBjsgMc2JF8rRirCPAtB02dKxSgsTY0LAe6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528021117.107984-4-seanjc@google.com> <20260528032925.BBCCB1F000E9@smtp.kernel.org>
 <CAEvNRgECjs5UqJsBjsgMc2JF8rRirCPAtB02dKxSgsTY0LAe6w@mail.gmail.com>
Message-ID: <ah8MY3HwEQMYoQy9@google.com>
Subject: Re: [PATCH v3 3/3] KVM: selftests: Add guest_memfd regression test
 signed offset+size bug
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Ackerley Tng wrote:
> sashiko-bot@kernel.org writes:
> 
> >
> > [...snip...]
> >
> >> @@ -345,6 +345,16 @@ static void test_invalid_punch_hole(int fd, size_t total_size)
> >>  	}
> >>  }
> >>
> >> +static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size)
> >> +{
> >> +	int r;
> >> +
> >> +	r = __vm_set_user_memory_region2(vm, 0, KVM_MEM_GUEST_MEMFD, 0, size, 0,
> >> +					 fd, 0x7ffffffffffff000ull);
> >
> > [Severity: Medium]
> > Is this hardcoded offset value correct?
> >
> > The literal 0x7ffffffffffff000ull contains 17 hex digits (68 bits), which
> > will be truncated to 64 bits (0xfffffffffffff000ull) by the compiler. Because
> > this truncated value is very close to the maximum 64-bit unsigned integer,
> > adding the size to it will wrap around zero.
> >
> 
> Sashiko miscounted the number of hex digits, it's actually 16.  That
> said, humans also have to count to understand what the test is
> doing... How about this, which I think highlights the signed overflow
> requirement on the selected offset?
> 
>  static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size)
>  {
> +       const u64 large_offset = align_down(INT64_MAX, getpagesize());

Eh, I don't see any need for a local variable and an extra assert.  The size of
the gmem file _must_ be >= page_size, otherwise creation would fail due to lack
of alignment.

This can+should use ALIGN_DOWN().  Actually, why does align_down() even exists?
Ugh, because KVM selftests predate commit 10a04ff09bcc ("tools: move alignment-related
macros to new <linux/align.h>") by many years.  I'll send a separate series to
drop align_{down,up}(), and hopefully align_ptr_up() as well (should need a cast
version since ALIGN() is a macro, i.e. doesn't do implicit type conversion).

v4 incoming...
