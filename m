Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618646AED1
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267582; cv=none; b=RzA/PyjMoTePoeoXK0VudHvDOf10t/A+9jmaU5O3bynhVdc6F7dC/zxMVKJ1WkUQc1aFVYOtYvHmYogLQp/lBni4a3UN3ra2htJPuUo9ZrbtaskeONbtY03mAgRW/bRJdPggQ/7O2w3AKbDPAwHaQCYfaaZWD5cnGM7r8kqBdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267582; c=relaxed/simple;
	bh=6jk4WNq35FvtRPXwxvwFFQkIMdTLJNaw0ZthxIMDruE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQmInMTPULyIXXB/0g28XbsTW98ZN+JB6KEJABBFWx0JLYZcwZW53uuEt4rpswrOPWnc7XjFgvP6m56vG4ylYjlDR8hbwIEyu4yK7X1dWkBUxEpOLfI5SP3QqWZlC9bEF5Y+l3InQOF/Vyq9Hla9TSmoTnMk31yZj7PYvQ3fML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Liz9XyzJ; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Liz9XyzJ"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc76d91f6a7so504004a12.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790267580; x=1790872380; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FrL8f+6ILVgPFeXZ79NGmNXRfQTnNh/rpX573POM54=;
        b=Liz9XyzJXHDZLtyzO+Ji1OVq/7HSs0ajW1gz5T6luK7zemEnHnhchgrDr6ZzxcSePt
         4qmTTUFQuQmy4/tX/7B3kCzQucc85DWhXjlj3XAJ5A+mMoOJZgrF0c2xl6N99gtwIMtZ
         6w7xdUdJvrCY0eBzNbGoGknJLOw1w0yuMIPrW7zhcxGX31zja3ofXdwzzX1kwKC8NsYg
         ELqfBmHK+uL2xCFxgrnPL1e6rto9WptOqJ4jSLSwhus5kus4NqtjrUt9uZ8/Dd451Lk4
         LzKIf+XxmieZ5GkffQrZ9hxBAD754W2rnWMqN7LZzkffZHvYa/9DrX9jGqWqe74RogEA
         L1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267580; x=1790872380;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FrL8f+6ILVgPFeXZ79NGmNXRfQTnNh/rpX573POM54=;
        b=Kgn3HYYLzVh4ne7l58vpQEp/N0fcTIXt5wOY5KpARMKwFKF/T2ZE2cQMpQtlnEDWL3
         tLQgL8ui4ziqwvJASIIPIDFZKgw35NMEcpZj2TLg0OM4Z1S7vQ8ZVVyYAvO8dH4P7inb
         UoCbtSSEMoMndz9BpXRDr2++zb5vaW5vdF97SuNTUAQG7dL6sp24+mWFMB+YQmkhKQbX
         jiSh0Gqi/r+QC7Tmx/OCPgQvt3lNW2hE6cVA8bPlGu/6rX89Mm4S/Qr2Pawln/4raiZ2
         lujjZvEkI8Bz0ADr6Lm0J3ZoANz6+tzIVIbiPtribDk7kqfclwXkGu/JqsJuGd0iFcxU
         T9RQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7saBZDg1Igh0sNiVzk/jurqPYcgMmtE2gDBK/NRQfzZeXzNYbbhDUQDzUSoY2l/QA4C0=@vger.kernel.org
X-Gm-Message-State: AFuF++nzLpfyjAW4dZ76YPs+fSND4AuLVCUsUjXnud98WpxBS+yPG62t
	lNhy6YPzm2gho30q43msHhBKCBegkaxYM/lAVCuzuX9AKCAN6wnnKv1w5TKFaBP9pYsFVBSrEvL
	Tf7oGcg==
X-Received: from pgdu19.prod.google.com ([2002:a05:6a02:2f53:b0:cc7:5e81:4448])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2250:b0:39e:4c7f:8b1b
 with SMTP id 98e67ed59e1d1-3a098e37392mr2572091a91.32.1790267579477; Thu, 24
 Sep 2026 09:32:59 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:32:58 -0700
In-Reply-To: <20260922071945.693714-2-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922071945.693714-1-fuad.tabba@linux.dev> <20260922071945.693714-2-fuad.tabba@linux.dev>
Message-ID: <arVQutV75u2gGVr4@google.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Fix arm64 sysreg header dependencies
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, James Houghton <jthoughton@google.com>, Will Deacon <will@kernel.org>, 
	Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Fuad Tabba wrote:
> The rule generating the arm64 sysreg header targets the generated
> directory, and its only prerequisite is tools/arch/arm64/tools/*,
> which expands to the inner Makefile. An existing directory looks up
> to date, so an incremental build never regenerates sysreg-defs.h for
> a change to the sysreg table. A selftest referencing a register added
> to the table since then fails with undeclared SYS_* identifiers. Clean
> builds are unaffected.
> 
> Always recurse into tools/arch/arm64/tools, whose Makefile already
> tracks the generator's inputs, and target the header rather than its
> directory. The recursion leaves the header untouched when nothing
> changed, so the dependents rebuild only when the header does.
> 
> Fixes: 70c7b704ca725 ("KVM: selftests: Avoid using forced target for generating arm64 headers")
> Link: https://lore.kernel.org/r/arGRhHgP_izSwW4T@kernel.org
> Assisted-by: LLM
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 96bab7002d39e..81dca3dbc16b4 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -303,10 +303,16 @@ arm64_hdr_outdir := $(tools_dir)/
>  endif
>  
>  GEN_HDRS := $(arm64_hdr_outdir)arch/arm64/include/generated/
> +GEN_SYSREG_DEFS := $(GEN_HDRS)asm/sysreg-defs.h
>  CFLAGS += -I$(GEN_HDRS)
>  
> -$(GEN_HDRS): $(wildcard $(arm64_tools_dir)/*)
> +# The inner Makefile tracks the generator's inputs and leaves the header
> +# untouched when nothing changed, so dependents rebuild only when it does.
> +$(GEN_SYSREG_DEFS): FORCE
>  	$(MAKE) -C $(arm64_tools_dir) OUTPUT=$(arm64_hdr_outdir)
> +
> +FORCE:
> +.PHONY: FORCE
>  endif

Definitely doesn't have to be now, but at some point should we split out some of
this arch-specific sub-Makefiles?  It's nice not having to hunt around to figure
out which tests are supported by which arch, but the amount of arch specific goo
we're accruing is getting unwieldy.

>  no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
> @@ -359,10 +365,10 @@ EXTRA_CLEAN += $(GEN_HDRS) \
>  	       $(TEST_GEN_OBJ) \
>  	       cscope.*
>  
> -$(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
> +$(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_SYSREG_DEFS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> -$(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
> +$(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_SYSREG_DEFS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
>  # Compile the string overrides as freestanding to prevent the compiler from
> @@ -372,10 +378,10 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>  
>  $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> -$(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
> +$(SPLIT_TEST_GEN_OBJ): $(GEN_SYSREG_DEFS)
>  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> -$(TEST_GEN_OBJ): $(GEN_HDRS)
> +$(TEST_GEN_OBJ): $(GEN_SYSREG_DEFS)
>  
>  cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
>  cscope:
> -- 
> 2.39.5
> 
