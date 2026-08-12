Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA23002C8
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550705; cv=pass; b=gf8vCzu/oPg62P25gf1Ub1LNYiOEoEnQjt2xgXt0MPWGFPnTHJingbgEWs6yiRAnfWuJCluMQPNTmPggVfc1syNEGMhQwWRQ/64NudPezROSNZNfXwVfcP99YTyexJnOLYC50+ITGrVkCJCmxgQgQePbKmgDc7cNS1rc2CpWGOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550705; c=relaxed/simple;
	bh=KNvFYWPxYeka6RYVhSJtPG0o9VDuxxFMEgnpnDdSwQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbA4Uw8docqpGpyYhCu9L9umXHVGLn/WwHfGVyN8p06mqnPkRi3lVaKpJiIOwomhXN2fU0LgTE4JK15eEyoQsyMqt5pV1lEKyA4L0sg/njcXYgRZO14iEL/RTe/fXVh49UuSXT+wSlDYJ7F+Tg33rowDJZx5FpYraKSBZ6mP/yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdYZ4bnS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGHuPm6j; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdYZ4bnS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGHuPm6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786550702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVrpa6t08jfvsuIkBMY48klo1RAJTpG8dCB8zk4ETDc=;
	b=CdYZ4bnSgChe7aYw9isAlQzANB1I3LBg35CkItiIcbIVVrDCYC6xzcxD5fTgN+I4o1ebMC
	DX+JsdS2IBz/wkYygKua111brE/P9+YPjD/SlLn/rfO7Owgrtejcd3vcrpsPKs8c8BhpBz
	E1MZDhzYwhKhne+oid/x5OEBB74iNLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-dP4toeBEMaCyuxvdd2Rbkw-1; Wed, 12 Aug 2026 12:05:01 -0400
X-MC-Unique: dP4toeBEMaCyuxvdd2Rbkw-1
X-Mimecast-MFC-AGG-ID: dP4toeBEMaCyuxvdd2Rbkw_1786550700
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f90dbaf84so900560f8f.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550700; cv=none;
        d=google.com; s=arc-20260327;
        b=WBRNqjmSKi6BI5X1MXEwptLMIzADqS2spmYBva18mErscFtvb3elhWmjbqc5Z3h+O/
         fAKpkjGWl1iIRZDbyzya4XFu64wx2kFf5YexK688CtJmm9Twhx7T+VQf5GHZzlAYl4Yg
         jCmmi8CzGebfF9SBC/n8so5pKMS7/00Xt+bHda9+kFwI/NH3LnPjZKhE2yqrY4Y2AtOP
         1QzHbg9k2qMvWz4ZUNQxfHD9lxbENeotwBE2N3gWIrnHDpvWxjvlPDtWDfYrhdTgX0HQ
         ku/AQhRxq3fN4Ugxh0Fe6GC4aCQVWSl1V4wukP3DYRbqRJpa15XyN4aGDsvnsVdid1rV
         1sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XVrpa6t08jfvsuIkBMY48klo1RAJTpG8dCB8zk4ETDc=;
        fh=MLjZ8/xeh8xCb58rHiLLp3S0XyAOc1+YunUWH8pmBC8=;
        b=EowM/HwLJKpRlRA+AJyt1F1Nzfxc2ebOs+EyDIlBS64WkPN5iDFHIjAkXqbZD/+q7M
         Layomk6rIMY6/BvBaL4dSrKTBtKZWGWesZHP2Ye4SOhM3uPMd+c0FeTVAvy5PF6PKMo8
         0DIXuYYZRBEClNeWgETh2a0uwvrEJuzWcuJXSN3+ulDlQtrhY7mB9lUJdkx+z3R8/LSv
         CHuHZb+kOS8zPEGUUjzOpXTHvbyOQF+KSd3iByo7OJadiobs3oIteHqqwCmjFsIstSLa
         m+K9BjH5VZiWNjVPWtn2UNeVONHe8uyKyJz5JlF1fOiwVb/CrRyUF7tZ0xUT1qVasz4T
         ekUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786550700; x=1787155500; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVrpa6t08jfvsuIkBMY48klo1RAJTpG8dCB8zk4ETDc=;
        b=fGHuPm6jzE36BlvA7r9S19w8ixNgE0cBf+Ccl0DVNcMz8AarBSypQ0WgBKV8vqFPng
         C02v7BWI2Uzy7SzT2q4B3X9we+QutnJ6PWLAYHu47b2ICdrqPFQjRu9fy+EwIoG/YnoX
         lfV1wG7OtqRFyjnLy0OOt2axAgNq41TJ2k+/XpLn9067wCWXw3rBSNjLLTM3iWP/I4zQ
         f8dLZXlVuiE4hHDGL04ol3g0AcBW1rUpVezZu4e8h3vjTUDNoKSup1sv/uuuEKlbidM1
         CpJCpWhMyytbPu2uoaFpe04TDxb4X9MXij0tpomWf4P/Bl5X9fsMkFPNGQ5lQBq0/JS6
         kwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550700; x=1787155500;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XVrpa6t08jfvsuIkBMY48klo1RAJTpG8dCB8zk4ETDc=;
        b=OczPo1SeOge3m9JPC++ze4visFh5qbzVmFyv0Kkz1oEw7HTFO+Q811qsTP/6h3BhkN
         EAlX37/ZfSB5sDxD733ZOhOWNeSrbPy3UNqd7DLhQUpJJnFr7uslu/A+/9NZa7Imtkvo
         yLDd3d3sPDEqV3c6JzieoYBysYHvjgYK84D28zJS1d1PGnu3V4uNa+6fhpUo7mJJ4g7k
         IjBCiVcvdLBu7stZb/RtvRQdQHdBSCfoLODRFYdr6N/EK31mXwNSuLom0qnndoY/MPBp
         ip0ymjY7Z8DuT46Yr2bgPBUCDydhycuXHFVhvRt3JR8sW6/CtjijYIe3/v+4KxTE0RTb
         hKHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqayIsCUX1SJLuwgm0T9oEVF7SUC1CjPu3FhIfDJYA9wml+bEMaTriMdCQ9BmkD8VatsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuMAl+h2qF4heGmQ8C0Nl2RJ8w1kwGsKP8xOSSsgSfUGDv3Wi
	HYZHyyEuKgklfAeW9uue26LXRc7l3G8YEk5uJS5M2NNYu1QrKFVGkIt4OdtngegWCK4cdIahcRO
	wmwrjIsxYrRvu21YigFpOpjtbg9gcYSJavrKxroc1ACMNCClBPqtoZqR9Tc88ackia1xGtSrdZ7
	u5wy1lucjDjW1WZCOpANlh3c2T6PhS
X-Gm-Gg: AR+sD13GWKVdZ4KDpl9YaKpJQvDr7pEXVtdFunoY+kq8TkyCY8UdMoizkERq++F2IWj
	BfwTaK6vnS8ugwKMFOyw4/mSlisDFy3rVYpu58TfmXJ38Z/6Z5274bt2IlQNpiFeOhrx2M5Vm26
	KhsNirZqf0X3fAplJ44cOlvotmzykmcNPcHQGEbeEi4L+Js2xspkA/U5ouCi1XO8VPliN13PD0y
	n9FB0BQZy/ksyCJm5CT5OEHkNM7yFYWNOqJKxezdkHJ0GeWawQDCqw8CTA=
X-Received: by 2002:a05:6000:25ee:b0:47f:943a:45fa with SMTP id ffacd0b85a97d-48152b01a7dmr8831829f8f.29.1786550700439;
        Wed, 12 Aug 2026 09:05:00 -0700 (PDT)
X-Received: by 2002:a05:6000:25ee:b0:47f:943a:45fa with SMTP id
 ffacd0b85a97d-48152b01a7dmr8831732f8f.29.1786550700093; Wed, 12 Aug 2026
 09:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811135537.GC544626@ziepe.ca> <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca> <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home> <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka> <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca> <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca> <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org> <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
In-Reply-To: <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Aug 2026 18:04:47 +0200
X-Gm-Features: AUfX_mxYjj1lPDXZPmp8aW6GUhdMuK_6ly_mDoPX9KEz7UGbw_A0i1e76HlJ2LU
Message-ID: <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> + * Atomic-flavor readers run with preemption disabled, so every
> + * read-side critical section is bounded and running (not blocked) on
> + * some CPU, which is what makes spinning here sane: the wait is
> + * bounded by the longest such section. No index flip and no
> + * grace-period sequence update occur, so concurrent call_srcu(),
> + * synchronize_srcu() and srcu_barrier() are entirely unaffected.

Making synchronize_srcu_atomic() spin in CONFIG_PREEMPT_RT is a
slightly tall request - it's basically putting it on the same level as
raw_spinlock. But if the MMU notifier guys really want to make OOM
notifiers atomic, this would be basically the only way to do so.

If instead it's okay to remove nonblock_start/end under
CONFIG_PREEMPT_RT, for RT kernels I'd rather avoid
preempt_disable/enable and only make synchronize_srcu_atomic() try to
skip the index flip:

   if (!try_synchronize_srcu(ssp))
      synchronize_srcu_expedited(ssp);

Paolo

