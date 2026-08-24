Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2617BCA
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606497; cv=none; b=byuDrzW9gL7qjmg5hn3oWJ/alkou9xHQ4jGau0Y0aHiTm+4qlPdosMFrwcd4VecvIN08+mBebEGFI3H+MVl/ERpcAHOd820shnowN+U5EjvlYyKCGzi28/U3p6D1LwnPzlJdsaipsaEPXXBzrx9OT+iLsC/f7fYiRTlOJTOb4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606497; c=relaxed/simple;
	bh=Z+nC9E/REizDaGM/y1Zfk8lEpjdNkyuISxRBXNgQRvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qzgR/QvZTFbChI3rimKfyiifjmC3HtSDnk7p0Gn0YuaWYTcGMxQSC5uYhDhUi6SY128OsLGXR+l3K5HVbmc1IJCqsEjgcYR3+WWmHnRdB00YKU6etmB3PHNWyNO5iG6gRxyrM2H7/KMsLR5MLJD5is6AEgo88OT2HJW0HlP6U1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYRdA24q; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYRdA24q"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc132709c76so5854321a12.3
        for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787606495; x=1788211295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NU4DYUq1t/9abu87crupOiETuM25Ll46MNDzgrp8Cdg=;
        b=SYRdA24qRBga11J0VXdyoFaxvHAYE/L8Ef6LdBWG/cgoAls2PYy8pBuj/pQwo0FaYL
         dEHpLVdBUVjspPGBLf/v/vVuNRfSxj2pdljxN0ajimsjjdU/hqKxUzSxQT3gvdOJ8SDj
         HTGTtqcaianMc35xGbV9ODvZ33KgIVbvoZkZA3bZ01WnbmlsqL4UqwtMXuKvb30OoY8e
         fOF6G+Xv9HYU82ihLvLpsPGC3hGSBAK+2IaLQFocxF7mgIkQsFuid3mizf6+cw8gG//3
         +svT/NYGiGI5mk3Nw+P7rF87iWzp8z7VfoEuhxgE8WxZSf+0rOp93a+G05zJmLR0lT1x
         PuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787606495; x=1788211295;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NU4DYUq1t/9abu87crupOiETuM25Ll46MNDzgrp8Cdg=;
        b=GWrIXUHB8eIIuDjvOoAx0GAbymRfDsXSyz1Cl8C5TZ0kq8K++EwFrgiyBZCm+7opg1
         InW9MCKMDw+BHb9W2PtgjVWu2v0rNN2Wovt+pCxl3xauHDKEXywE4SSzOLmzF3+f7ktB
         3See4KZmlL23qHkyTamcq/ol9rbpPGp6qKKK4AtY3XrsN3KcJgrxP59sdcLyFHiqMBbH
         TPoD2PDYzKdOw5xEc83jHXD+i0xb8TJY9xRyaRTGO9AzKYLv8X4mQFURuGYEDKs6kHBg
         LlBFo22JAt/CyaZ3lLejBRZ2T0mDSWe2PjeATN46KpJof0+1RbbIwIhFiJonb9O/quqj
         t3Rw==
X-Gm-Message-State: AFuF++kRp+tFEwMc2rOTs5QFMWUi3YSIVzlNJOY0mcbmetsgN5X48F99
	+3MAJfSWunPGdm8QGRZcN3nqf+I95nmgHgkttbunazgnOIX8cdm40+1jZq0ym6TkOrh1PJjVzT0
	f31QzwA==
X-Received: from pfoi3.prod.google.com ([2002:aa7:87c3:0:b0:847:9805:8254])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:398a:b0:84e:2722:5d9e
 with SMTP id d2e1a72fcca58-851f9bb5de5mr47827595b3a.1.1787606494792; Mon, 24
 Aug 2026 14:21:34 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:21:34 -0700
In-Reply-To: <20260820220340.GC618052.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-9-vipinsh@google.com>
 <ampPd9szwRoGKwds@google.com> <20260820220340.GC618052.vipinsh@google.com>
Message-ID: <aoy13na7ceOOeh0K@google.com>
Subject: Re: [PATCH v4 8/9] KVM: selftests: Add rule to generate default tests
 for KVM selftests runner
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, anup@brainfault.org, atish.patra@linux.dev, 
	zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 20, 2026, Vipin Sharma wrote:
> On Wed, Jul 29, 2026 at 12:07:35PM -0700, Sean Christopherson wrote:
> > @@ -347,15 +345,13 @@ $(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH)/%.o
> >  $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%.c
> >         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> >  
> > -# Default testcases for KVM selftests runner will be generated in this directory.
> > -DEFAULT_TESTCASES = testcases_default_gen
> > +TEST_FILES := $(selfdir)/kvm/runner
> 
> Downside of this one is that if someone is not planning to use runner they
> will still get this directory copied.
> 
> Should we instead add 'rsync -u' in 'testcases' rule below which can copy
> runner only when it is updated or not present? This would be similar to
> original patch but instead of 'cp' it will be 'rsync' command. This will
> also copy runner when someone is explicitly using it.

Hmm, but someone could be using the runner without (re)generating the default
testcases.  We could add a "runner" target, but that seems like overkill.

I'm good with either option, but I think my vote would be have the runner get
copied on install, i.e. just do the "TEST_FILES := $(selfdir)/kvm/runner" above.
But again, either way works for me.

> I think we should also include 'tests' directory which we are using for
> custom testcases and they also .

Heh, they also what?

> >  EXTRA_CLEAN += $(GEN_HDRS) \
> >                $(LIBKVM_OBJS) \
> >                $(SPLIT_TEST_GEN_OBJ) \
> >                $(TEST_DEP_FILES) \
> >                $(TEST_GEN_OBJ) \
> > -              $(OUTPUT)/$(DEFAULT_TESTCASES) \
> >                cscope.*
> >  
> >  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
> > @@ -386,21 +382,18 @@ cscope:
> >         cscope -b
> >  
> >  # Generate runner testcases in DEFAULT_TESTCASES directory.
> > -# $(OUTPUT) is either CWD or specified in the make command.
> > -tests_install: list_progs = $(patsubst $(OUTPUT)/%,%,$(TEST_GEN_PROGS))
> > -tests_install:
> > -       $(foreach tc, $(TEST_PROGS), \
> > -               $(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(patsubst %.sh,%,$(tc))))
> > -       $(foreach tc, $(TEST_PROGS), \
> > -               $(shell echo $(tc) > $(patsubst %.sh,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> > +DEFAULT_TESTCASES = default_testcases
> > +
> > +testcases: list_progs = $(notdir $(patsubst $(OUTPUT)/%,%,$(TEST_GEN_PROGS)))
> > +testcases: install
> > +       $(foreach tc, $(notdir $(TEST_PROGS)), \
> > +               $(shell mkdir -p $(INSTALL_PATH)/$(DEFAULT_TESTCASES)/$(notdir $(patsubst %.sh,%,$(tc)))))
> > +       $(foreach tc, $(notdir $(TEST_PROGS)), \
> > +               $(shell echo $(tc) > $(patsubst %.sh,$(INSTALL_PATH)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> >  
> >         $(foreach tc, $(list_progs), \
> > -               $(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(tc)))
> > +               $(shell mkdir -p $(INSTALL_PATH)/$(DEFAULT_TESTCASES)/$(tc)))
> >         $(foreach tc, $(list_progs), \
> > -               $(shell echo $(tc) > $(patsubst %,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> > -
> > -       @if [ ! -d $(OUTPUT)/runner ]; then             \
> > -               cp -r $(selfdir)/kvm/runner $(OUTPUT);  \
> > -       fi
> > +               $(shell echo $(tc) > $(patsubst %,$(INSTALL_PATH)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> 
> All looks good here.
> 
> Should I send a next version of this series with the changes you have
> suggested or you wanna take the diff you created and apply before merge?

Go ahead and send the next version.  Given the number of tweaks, it'd be helpful
to be closer to WYSIWYG.  My changes are at:

  https://github.com/sean-jc/linux slf/runner

if you want to use that as a reference and/or grab changes directly.
