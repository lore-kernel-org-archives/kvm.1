Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763042982C
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170331; cv=none; b=QcAF7jljpqQUMBOA2r+5LWfDeTPOGmAOLT42cPSBW33lpZB8uB7FPT71/tvJDHhMLHPdw7YRHGi325mhr2MdRRo8E+T1WTmyqTG+GGtR3RKWGZtKXluyr9d5CaBZEKwWxCXKbeaK7MpUVwU1NwKAjPQ1cU/jbhJze8pKDo6Q4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170331; c=relaxed/simple;
	bh=PdQ/4PEBxEHnxLPBKFCMQ2uWLoFs1z5YPrbudFZilBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R32yvrBDOG+8cLNtnY13dsTkxFs2Wj7vr06XhKmgCdgIUFb7DAudDYAAMeXP2NDo4ca+QlDF25J6ylZRqD/01vzA6QH6rDlTzTTBDgppG89C8CYwVSGELSMi5YqlI+iWsMirBfxHs8x6NH/Bzxkg8fi+W0lMrEkPT7+8qc8q+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLOmPd68; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLOmPd68"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so1067965ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785170326; x=1785775126; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOk7ceT3TdQMGoh1uKZwPWload+wHeS5dtXQdx4sogk=;
        b=iLOmPd688pcTpMfByd3vmzwx5oPtE+aVGB4jukZfMCh/QcufZg6dsFw8BDBeWIFitz
         y4wJzodmJY7bA2AG9GHyUC7ZIz24wrpaosHcYbCMnq/I2w7rF4Ryld/KFpjJzZgqgFiY
         tE5qYdLc6RaGf3NkkkJXa/QBVFTcPSiOkA4TE9RcKIlzkL6UKAoALGURd99uhxqZlFhr
         IXRoe7V6Jt3mu+jS3n6RApTcN8+dnYy0WnRoCTD38yBbEnHWMtp6BGLTt5RpCvNOTqIa
         wABYqf8xnCJu6fUHBOQMHkM/Me5ufJlp36ivyMCwTXx0z+qtJePzLoOzC4qSGz+ZbWll
         vfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170326; x=1785775126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOk7ceT3TdQMGoh1uKZwPWload+wHeS5dtXQdx4sogk=;
        b=ZgKlLanYl3GFczqoQq4WEino04kuWuVpj5m0RvGsRPzVtx/zz2oGHnWDz/YqY7g3A5
         jUgUgpaed1Zjv2QnvunYCM/TwfqjgG/HfIE5WuEWULD/+SEMQtlRZGCfwFoRcT1u4Bsl
         P18GZ+iSUvxv7kGqr8uaMDzkFscYw6pWpv/GmOkVR+dqo1sUQGIjUX56onbC4ydYbTUM
         L3+NK0HRAq9++gBgXptaG89ldsv1m2ucqoVxsAkhZaF+MMLySezLeji0rojPoJh5F+Vy
         cQaMTxg2ShyYnAAW1MfYdEdPFQzDAo67epEEkx/k4Do4Mjk/LDNQcAuLI//b0C7b8ufO
         X4uw==
X-Forwarded-Encrypted: i=1; AHgh+RoH0MHtBepw6Gv771EUVJqQffFikJstQvNlJRvH++P6CrCbSghCnP3K6IoyxgvnDrBclZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFkvPcLpaXHxBgdmPmWwAylNiTFf6xXVr3TCaxPDPK1DZI1O3
	aSdVecWri5LVu02rdMBc5CPHo25eVPkK/d1F+tM31wy+ScRHOZzDzNeyng/NunhGoPLeSEqy5p0
	sDGSDrg==
X-Received: from plbbf6.prod.google.com ([2002:a17:902:b906:b0:2c8:1c50:a617])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1103:b0:2bf:13af:b077
 with SMTP id d9443c01a7336-2d00e7f7b6fmr1677645ad.14.1785170325443; Mon, 27
 Jul 2026 09:38:45 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:38:44 -0700
In-Reply-To: <CAO9r8zN9O=0cgO-ia1FtDQ-JvOau7fGUZ27wKP-WY7HmmKs9dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
 <amOl8kczWlZP_ftH@google.com> <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
 <amOuALTiqI9u4tFh@google.com> <CAO9r8zO15oLHXVhyE8rR7bOMM4Ks+qzRAsz=5W8kXMwKU5gbnA@mail.gmail.com>
 <amPL4b7x3cBxA_y_@google.com> <CAO9r8zN9O=0cgO-ia1FtDQ-JvOau7fGUZ27wKP-WY7HmmKs9dw@mail.gmail.com>
Message-ID: <ameJlMZbJtXs7bgL@google.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> > > As I mentioned above, I prefer taking a dependency on
> > > KVM_CAP_EXCEPTION_PAYLOAD rather than varying coverage. At least for
> > > the nested case, I think I can move the TEST_REQUIRE() into the
> > > 'nested' case, but then it's probably better to leave it as an arg to
> > > allow for meaningfully running the test in L0.
> >
> > The problem is that TEST_REQUIRE() skips the whole test, regardless of when it's
> > called.  I.e. if you go that route, passes for the non-nested case will show up
> > as skips.  TEST_REQUIRE() really is intended to be used when something is a hard
> > requirement.
> >
> > > Actually, what if we just skip the nested case completely if
> > > KVM_CAP_EXCEPTION_PAYLOAD isn't available?
> >
> > Can you use KVM_NMI instead of KVM_SET_VCPU_EVENTS to effect the nested #VMEXIT?
> > That ioctl is so ancient that I'm a-ok skipping any CAP check for it.
> 
> Hmm actually I just realized I missed a CAP check for
> KVM_CAP_NESTED_STATE here. I don't think it's worth looking into
> dropping KVM_CAP_EXCEPTION_PAYLOAD, because we will need a CAP check
> anyway, and both of these were introduced very close in time (4.19 and
> 4.20, both 8 years ago).
> 
> So I think the simplest thing to do here is just run the nested test
> cases if both CAPs are available and skip it otherwise. Practically, I
> doubt there will be a lot of people running upstream selftests on
> <4.20 kernels for this to actually matter.

Yeah, works for me.
