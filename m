Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840563;
	b=Wh6kTDHaUwGOdCgC+WmV4nnPKVzbCVLWJhgTI6U08k9xMMAEAKhFyeW1fBH7e3QC5rfT
	 p7LDlVdBVOzqiYzepfakzZlfXJTEOi21QRf4b7fnvualWjoGR9+0tJaEl9TbuTzFDjhWm
	 q11jtmSs11QFmU3XQJF8CT/bZIKi9oAf9wkEywDhDwWmzMwJLiUKA5pIB6lG+7oXvgBgD
	 ph98GoiyMOWjJ+TVLwlIoOjwVZHt8Vny7dvyN31gH4f+444hwjkcyQ6vrOw01rcfn8ePb
	 ePcARBK+Cdwd+AoAuHEyxIJMyBIEBCfAAOX+JpfcS9RKmsSPAXPdZBvTQ4rnT6auYyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pd5083dr9bSH8n1jTMbA4i3mKvFPliz6jrMQ78aFKC8=;
	b=pQ8S+RDk1GXPdLrEdbrVnW6WS0dOyEQapB2Otjl66+etDY125SO+nlvdY3e4T79zmsRT
	 zNrCYBmKQ7gomEJ3bAH+g7fCpv+rFXH3ncYm8dC6mlJTES7iqgpyXhM12YbQJ70fd4uTM
	 d69jwPd1NLMDeHUpX+7MFyfwyj0dHwoxHRPq1W+2O+dFIv+rbXh6v8DZ2fiGJF3uaF4h1
	 BXy6JlNJ49zQaMTig9I7JsbFRYKclgo0DngMB9VWBOmjaQoWIyrotsO32ZiVEMEkXdkjC
	 6Hb6j1trjGEFFphMLSt46Y7B56LI7XxTMTjPzFWLrWGQxiYNzizORvOOdqsP4DqauzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BMeV0/oU";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567D606A331
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 01:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6567D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BMeV0/oU
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6969473a4so795794a12.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 17:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793840563; x=1794445363; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pd5083dr9bSH8n1jTMbA4i3mKvFPliz6jrMQ78aFKC8=;
        b=BMeV0/oUgEUf1H0pqva9tSc+R1u6PArFg284CPniJAINpcFl5+ulnnJz8cOLttLvQQ
         jBW0Y2K4f92054y1Ad/Y0DcHpUJaWctqJRKH/VyJiuGVVAn2+vyLulpigfvSclMLvY8F
         HouyS3B4WDpuTPe2oqWykeQKYiw1qqZexIKfviXBs82zhtGM4c3iF5tCtvi0Rr2Jeft5
         KpDm9PMTH3xvtmhOfTlA7AzH/wu5mFcIOoYgpsCX3XH+C4tWz3cEyW704ibMvwMW22cq
         Rc3t2R8VnHXO2zHsM+NnG3oI+QlrrAK/j/zfP4v494gNz4OoR0cscy6PyCK9SqeKuxsk
         9rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793840563; x=1794445363;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pd5083dr9bSH8n1jTMbA4i3mKvFPliz6jrMQ78aFKC8=;
        b=o3LeNBeaBCOPHnMWaqVmBWVyb5YWzAqazm+q110wNddLWPLhNdswKlkgMmWpk+Z7ub
         JExhSfLNnwJlBZRBthhnyYRkWHi4PBgaYGyvmqOq1/KT/45lYyb5ZoPmtS6XNDd0lBpA
         x3a+hxyZxZu0QAtdScdOdjJ3BQYlvfAdIJG64/Xyaq1R/9K3Dj4jgA5Mga1NZlPcjBrK
         g6V5uAd0mjA4JrqsWjcN2nbbmsFVjq6RPMU1YNQFAFi+z1JR9gGJHvugGKZkYLSCrpD3
         vaskxqgBAQD82pJxdj9Bz/+LcrJwj5lzSAlYPAkWiv7YvMAafGht0uykBZ0TR9FVL7BF
         /syw==
X-Forwarded-Encrypted: i=1; AKwUvBwc2bYNva7t+WWPZ9ASANeqbC6MQSroYW2Zx8fF/0ZP20j9duPyUIbLQu0Uo5lSbG2hqpY=@vger.kernel.org
X-Gm-Message-State: APuU4Z90UcwHpkI6z7BosPZiCnZi0T7bYR7h0kt8pN4/6eHh+0pG16qI
	l1dno7kgs8ev+etzMcXD8h5EE/6EvoX+0zcc6bnbColbMSUsvGZf1GGw7O21EbGwX0EH0Q+MsDO
	Y/WPVxg==
X-Received: from pglk7-n1.prod.google.com ([2002:a05:6a02:6b87:10b0:cd6:b725:c290])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a08:b0:3e2:6e7a:bc13
 with SMTP id adf61e73a8af0-3e928abd4eamr15851564637.79.1793840562345; Wed, 04
 Nov 2026 17:02:42 -0800 (PST)
Date: Wed, 4 Nov 2026 17:02:41 -0800
In-Reply-To: <421ebe63-dd9a-4da6-a2f6-104a9473b301@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <50a3ff35-ae53-4372-a53c-c07f1d153627@linux.ibm.com>
 <20261023140506.336663-1-borntraeger@linux.ibm.com> <att35ilyLvAA8gM4@google.com>
 <421ebe63-dd9a-4da6-a2f6-104a9473b301@linux.ibm.com>
Message-ID: <auvVsbpFq4vApW1H@google.com>
Subject: Re: [PATCH v3 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, Christian Borntraeger wrote:
> Am 23.10.26 um 17:06 schrieb Sean Christopherson:
> > On Fri, Oct 23, 2026, Christian Borntraeger wrote:
> > > Add a test in which the guest writes to a shmem-backed memslot beyond
> > > the end of the file.  KVM_RUN must fail with -EFAULT.
> > > 
> > > On x86 the guest enables interrupts, and on s390 the test sets up
> > > pfault, so that KVM could handle the fault with an asynchronous page
> > > fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> > > retries the access forever, and the test fails after a timeout.
> > > 
> > > The test is not built for LoongArch, which handles a failed mapping as
> > > an MMIO access.
> > > 
> > > Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > ---
> > > I went with Seans name proposal
> > 
> > Aww, bummer.  If you posted a faulty_mcfault_face_test, I would absolutely apply
> > that and force Paolo to tell me no :-)
> 
> Sean,
> Will you pick up the fix and the selftest, shall I do it or Paolo directly?

I can grab 'em.  Were you hoping to get the fix into 7.4?  It doesn't seem super
urgent?  I was leaning towards waiting for 7.5, but tagging it for stable@.  I.e.
give ourselves a full cycle to make sure we didn't miss something, then get the
fix backported because I wouldn't be surprised if people are hitting this in
production without realizing it.
