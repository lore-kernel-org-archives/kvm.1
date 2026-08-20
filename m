Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AE31F9B1
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268571; cv=none; b=eMCevLtZwIyVHCeh/rbMmd6qh6qrlZ3pkuQnfCmepxlDz1dlbtuXXhWfoupOMUzk+Fzl2B0riYIuEYYGkLc3dfoKr5h7CpbYwNhphGZcJsYg1Nq7y1SQMzj2imm7QdEZua/YzC4dNT+Tt39ewaRpjX5lSNR4b6UF32WyXSUk5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268571; c=relaxed/simple;
	bh=FM2xAjw5wSTlcQCs5YuFDqE5KTzv01uqml/WI85WPpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDb2d9SggAYXXsegjc9xc/n6M57DsZoMPZj3oT4wh3tE98szLXpcT99VL6sg03mnb5G+79guMS7eR0TWmFzJ+RLybYoARnFFAEfGbC7hkVayyad1/w85AFAQzQSrbKee+IWm8Vc0vd6h6LrSsn3H+z0izimpbfbsNp9fIY7YwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVWLn14c; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVWLn14c"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso39935ad.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787268569; x=1787873369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/h3VNQtWr5Uh6IO9vIimUOFdkR8pd4y8N4EBbX0fQY=;
        b=YVWLn14cDCqsLy11LL4Ojm02glaBH/1ZKidj3xCmOErlexq5ldVP8mkB3GntQWQNGM
         O3BliIV9OYhJmw++KqPkyMmeeO1pGlkDGovZoD6AObrjDuoPWCs3UrSZZtxZQLf6xJNP
         Bclltz/YnMvf7MgvfI6OHZqrIfnIgAFsw2IOnxftMQmky7TDFIjqzpAnELXbjZQ7ga8n
         piVvGBwywW6UjY1jAYA0cXh3jbvou5kuHum3r4d7J/n6lOxGGn2TTdJw2F4t3WfvO26l
         0X4BuVAyQ+Qk8u0F043/AZAVWi3f51ieZWP3IAyHEnDDOwvPE3pMkEHqrZSVr4p4Fv+V
         MQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787268569; x=1787873369;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/h3VNQtWr5Uh6IO9vIimUOFdkR8pd4y8N4EBbX0fQY=;
        b=MkXQYctGULz/Xhw/RwMcNbc3AvhhrdgU6POH2Ijs1QHxJ5eAHKA8MMMC8lA11q9j/k
         KaY7eAi57+9XxhCXKtsEn6ni9E9FjkmFB0RDx9ttia+t6oyllRFjkEqUnrJnN+6WemCP
         8h1oSocNm7EM1yMltAuLeNi7i3mD8KtGD+YehzDGDQgRwlQnC84CiFgxl9AHB7GCT/SG
         LuTyICmfhSAIlJiL8VBcp8+CjP4/C342FvjIjTP+LyBPih1fRAbnx5pMPAdpnIztrA/1
         JgwuzUTmCHWOWhg8cyY25dxsH2ipo70LOmQhcd6WeAagfCLWz5Cp+ht+Hew0kdceo0bv
         wEfg==
X-Gm-Message-State: AFuF++mHQySGbnGV8YmW2gAwQcf1IQEzS65G4NgHDwSPSlaKP+RICdHM
	inTLA+YF3B8QG5w9gU1x89arBKzmo5SF9RpN4og9SRrBDISrw+Yuise7/o0oEmCZyA==
X-Gm-Gg: AR+sD12P6pdi1Wjp20FHmtKVfAlITO9PH68n2V8R/KJcejK9TqrXi6jo0VXZKNm6B/L
	GgARZgvjmaYjQVwVa3vtuH7JCriddbk4K4FQ3HlJvnq6rKetr1sPuBtkxA/vFQIT5MWaGQsjQ6x
	Um+jQgwIytre4gSgAEC/pDvqALk2sqLy9sWmHGzG2gnHgStkkKe6FbNxH0oQ84tXcFetBhxA0qB
	eqWEzQNpv77JVICNfEYUQJr2Bsd1X9fVi2bpiWYNa2Sge9Gnw+Ozimf2y4GrKyeWe5Vp7V6UtVB
	MYAmG2CQt7WSuQxmmDg/qMfhcZT5vSWMlfmpLZ9xQqNAyfi7ZHRH8p+cL5u495LikBkYs/CS2Js
	j04xRKrdC+i7eOyY+Z5NMipLQJ2Xsb0zgrZx9lPlwrje+LdJKkP6wCGJ1FNKkEe1uY2ZTqLA4kY
	fsbrBAY4HTVALvf63WvN4iqRIL18o9eXsEDUl66zn4XoKMX9Bvz6aeAQ/86rGU1l0em9UrcdA2f
	5czpvCzGBnXSipsJEgcE2k03A==
X-Received: by 2002:a17:902:e951:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d650d6510bmr1764635ad.11.1787268568429;
        Thu, 20 Aug 2026 16:29:28 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8e07801sm97051a91.0.2026.08.20.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:29:27 -0700 (PDT)
Date: Thu, 20 Aug 2026 16:29:22 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, ajones@ventanamicro.com
Subject: Re: [PATCH v4 8/9] KVM: selftests: Add rule to generate default
 tests for KVM selftests runner
Message-ID: <20260820220340.GC618052.vipinsh@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com>
 <20260331194202.1722082-9-vipinsh@google.com>
 <ampPd9szwRoGKwds@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ampPd9szwRoGKwds@google.com>

On Wed, Jul 29, 2026 at 12:07:35PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Vipin Sharma wrote:
> > +# Default testcases for KVM selftests runner will be generated in this directory.
> > +DEFAULT_TESTCASES = testcases_default_gen
> 
> That's a cumbersome name.  It was also written by Yoda :-) How about default_testcases?
> 

No fun, you are!

> > +
> >  EXTRA_CLEAN += $(GEN_HDRS) \
> >  	       $(LIBKVM_OBJS) \
> >  	       $(SPLIT_TEST_GEN_OBJ) \
> >  	       $(TEST_DEP_FILES) \
> >  	       $(TEST_GEN_OBJ) \
> > +	       $(OUTPUT)/$(DEFAULT_TESTCASES) \
> >  	       cscope.*
> >  
> >  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
> > @@ -363,3 +367,23 @@ cscope:
> >  	find . -name '*.c' \
> >  		-exec realpath --relative-base=$(PWD) {} \;) | sort -u > cscope.files
> >  	cscope -b
> > +
> > +# Generate runner testcases in DEFAULT_TESTCASES directory.
> > +# $(OUTPUT) is either CWD or specified in the make command.
> > +tests_install: list_progs = $(patsubst $(OUTPUT)/%,%,$(TEST_GEN_PROGS))
> > +tests_install:
> 
> This is very much *not* an install.  In fact, install is broken, because the
> runner isn't added to TEST_FILES.

I think this will also be not a good approach if we are moving towards
opt-in. I added another option in your FIXUP below.

> 
> Another issue with install is that it flattens the directory structures, i.e.
> drops the $ARCH/ subdirectories.  That causes issues for the default.test testcases
> due to them using partially qualified paths.
> 
> And coming back to this with fresh eyes, I don't love generating the testcases
> for the "normal" build.  It necessitates adding default.test to .gitignore,
> effectively requires copying the runner to the output directory, and is pure
> noise for folks that don't want to utilize the runner.

Yes, this is true.

> 
> Rather than generate testcases for the default build, what if we make this 100%
> opt-in, and take a hard dependency on install?  That should obviate the need for
> ignoring default.test, because if someone is silly enough to install testcases
> in the source tree, they get to deal with the noise.
> 
> And we can commit to having the default testcases provide completely unqualified
> paths, so that the Just Work with the flattened output.  If someone wants to run
> with an unflattened tree, then we should update the runner itself to handle
> multiple paths, a la the actual PATH variable.
> 
> The other nice thing is that we can make the runner opt-in, without requiring the
> user to run multiple make commands, by chaining testcases => install => all.  If
> we try to generate testcases as an optional step to the normal build, then we'll
> end up being able to run install without having generated the testcases, which
> is "fine", but probably not what we want for people that are trying to use the
> runner.
> 
> The obvious downside is that it requires doing an install to get the default
> testcases, but IMO that's an acceptable tradeoff.
> 

I like the opt-in approach. However, there is a subtle difference when
using 'testcases: install' vs 'all: tests_install'

Test cases can only be generated with

  make -C tools/testing/selftests/kvm testcases

We will not be able to generate test cases from the selftest directory
or the source root.

New command will be:

  make -C tools/testing/selftests/kvm testscases INSTALL_PATH=<path>

I think this is fine, considering it is opt-in and user has to know how
to run it. One advantage is that currently when a user runs:

  make -C tools/testing/selftests/kvm install INSTALL_PATH=<path>

They don't get run_kselftest.sh to run those tests. With the new rule,
they will have a runner to work with.

> > +	$(foreach tc, $(TEST_PROGS), \
> > +		$(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(patsubst %.sh,%,$(tc))))
> > +	$(foreach tc, $(TEST_PROGS), \
> > +		$(shell echo $(tc) > $(patsubst %.sh,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> > +
> > +	$(foreach tc, $(list_progs), \
> > +		$(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(tc)))
> > +	$(foreach tc, $(list_progs), \
> > +		$(shell echo $(tc) > $(patsubst %,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> > +
> > +	@if [ ! -d $(OUTPUT)/runner ]; then             \
> 
> This is very wrong, as this will fail to pick up any changes made to the runner.

yeah, I think rsync would have been better.

> 
> All in all, this as fixup?
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 83aa2fe01bac..91d2b21d396f 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -8,7 +8,6 @@
>  !*.S
>  !*.sh
>  !*.test
> -default.test
>  !.gitignore
>  !config
>  !settings
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index c5821d495ea6..fc9dc41fdbeb 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -1,8 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  include ../../../build/Build.include
>  
> -all: tests_install
> -
>  LIBKVM += lib/assert.c
>  LIBKVM += lib/elf.c
>  LIBKVM += lib/guest_modes.c
> @@ -347,15 +345,13 @@ $(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH)/%.o
>  $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%.c
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> -# Default testcases for KVM selftests runner will be generated in this directory.
> -DEFAULT_TESTCASES = testcases_default_gen
> +TEST_FILES := $(selfdir)/kvm/runner

Downside of this one is that if someone is not planning to use runner they
will still get this directory copied.

Should we instead add 'rsync -u' in 'testcases' rule below which can copy
runner only when it is updated or not present? This would be similar to
original patch but instead of 'cp' it will be 'rsync' command. This will
also copy runner when someone is explicitly using it.

I think we should also include 'tests' directory which we are using for
custom testcases and they also .

>  
>  EXTRA_CLEAN += $(GEN_HDRS) \
>                $(LIBKVM_OBJS) \
>                $(SPLIT_TEST_GEN_OBJ) \
>                $(TEST_DEP_FILES) \
>                $(TEST_GEN_OBJ) \
> -              $(OUTPUT)/$(DEFAULT_TESTCASES) \
>                cscope.*
>  
>  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
> @@ -386,21 +382,18 @@ cscope:
>         cscope -b
>  
>  # Generate runner testcases in DEFAULT_TESTCASES directory.
> -# $(OUTPUT) is either CWD or specified in the make command.
> -tests_install: list_progs = $(patsubst $(OUTPUT)/%,%,$(TEST_GEN_PROGS))
> -tests_install:
> -       $(foreach tc, $(TEST_PROGS), \
> -               $(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(patsubst %.sh,%,$(tc))))
> -       $(foreach tc, $(TEST_PROGS), \
> -               $(shell echo $(tc) > $(patsubst %.sh,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> +DEFAULT_TESTCASES = default_testcases
> +
> +testcases: list_progs = $(notdir $(patsubst $(OUTPUT)/%,%,$(TEST_GEN_PROGS)))
> +testcases: install
> +       $(foreach tc, $(notdir $(TEST_PROGS)), \
> +               $(shell mkdir -p $(INSTALL_PATH)/$(DEFAULT_TESTCASES)/$(notdir $(patsubst %.sh,%,$(tc)))))
> +       $(foreach tc, $(notdir $(TEST_PROGS)), \
> +               $(shell echo $(tc) > $(patsubst %.sh,$(INSTALL_PATH)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
>  
>         $(foreach tc, $(list_progs), \
> -               $(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(tc)))
> +               $(shell mkdir -p $(INSTALL_PATH)/$(DEFAULT_TESTCASES)/$(tc)))
>         $(foreach tc, $(list_progs), \
> -               $(shell echo $(tc) > $(patsubst %,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
> -
> -       @if [ ! -d $(OUTPUT)/runner ]; then             \
> -               cp -r $(selfdir)/kvm/runner $(OUTPUT);  \
> -       fi
> +               $(shell echo $(tc) > $(patsubst %,$(INSTALL_PATH)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))

All looks good here.

Should I send a next version of this series with the changes you have
suggested or you wanna take the diff you created and apply before merge?
