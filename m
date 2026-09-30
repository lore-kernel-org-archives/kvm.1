Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF3348896
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730587; cv=none; b=o2hEIYmfYgB8f0tgL6FRZ+O5dvW8y7drR3wjATVfJljYiW5JDmdinpCeqRKX716ZqNXOLTKo6u2ZZptaqKt22nKbmaovH8vEvFNJLpoFFI4Jm9pCQ1Jo3D0x3P3bOMfirrZ+78YWf3gofvnN4+9uOzspQMsQ55FXa26DTQW39Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730587; c=relaxed/simple;
	bh=SezVP/uFBTMZxwx49txY9QcmGavw70qer/Mr8hN7hi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mE9HcgNv2H0cC9SnpcNAgimVN8RuoysD4jWfpdzUv6qKduaVfF6SXvaoZ0avDIYsERDOZ1Ai5lmdrSxUSPtDcVm2VeLuLjrzUBxU/gdJMYJyN7IAgP9xP4PS8qmkWZfugALQKUCo9SUhno/OtwYOLdHRD4xNpMxUhR53I7ucLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkRzdAa3; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkRzdAa3"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4fc935a11so3451591a12.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730585; x=1791335385; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kI5zWnoGu/0SkUW3WJKgj52/D/XlXm6qzd94iamwT1A=;
        b=XkRzdAa3fOFLYs8NwNpgrmBKMpWsdC+WdkCT/ilnANlrdEOmfuJ5GTtn36IsfU8Gvz
         PWat/aiWk/tdiLJWMIOxz6yURetbXWrgiHAuYqxn8CW/c5f90qvCQqJZA+xKlXSn6cxQ
         vy/NXnHaKD8g1C7Zk6oVZBPmKLJfzzZxb/Tdl4eluv2aq8Ze9zt5s35/UZ1T01ZAvEOA
         L1AfKj2R1LmS8n68hHmkQFPWhFrSr+zdfjM/1wyjLWagkcIDptdvcO84qUaN/36Zmlk5
         8Jewo6XBhSzgYXWAVg+rUUz0ppJ0Vz5LbWad5AsbfF57dbcNzyZTw7ThJ5aG8K79aPTL
         zgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730585; x=1791335385;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kI5zWnoGu/0SkUW3WJKgj52/D/XlXm6qzd94iamwT1A=;
        b=Ut0X5znen7FH/NQBt+Ea+WSq9cUvu/uSzbOF9UJ5yBfKc5gw5XVkYjRlqwNMqhX2IQ
         iShLia1DNY6PzZOX8BZXVPN4flFW8bjFgg9tgVChO03Go+WjWVjW8HNXzF0c+pzSsaRh
         VQVVfUtKq69q9ewSaVNAJ3L4wT+GgTl1o8jmPjwT8tQ67Mx9ojhfwl7BZ1OQ4BSgqOzr
         Ih/+53x6ZQxpQZucUZqJ2S/Iy5s0hMNu5KskFs/uuCak/kLoJRmaBwi+sLOnE/d386zu
         SKdp0uy5kQ26bn/ryW4aK9ALtCveH2yRdto9sGBhXLf7PruXW9N0D52Zk27cHsBZY6ZR
         OWSw==
X-Gm-Message-State: AFuF++ns7EOMVddRODwHOIMa1jzRbMmE5uWtvV8fz4CaPbvAcDcfAn/f
	AvZWOmppLmpFqFobZdjLAZQcO39NNXzsOTYCyFDs0pyVy9+o5mDmGLLFz93wPdH3mXyWAoLtgNX
	yLsiVYQ==
X-Received: from pgbdo7.prod.google.com ([2002:a05:6a02:e87:b0:cc7:9970:4594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2288:b0:3de:4db6:9805
 with SMTP id adf61e73a8af0-3de9525222bmr787304637.37.1790730585402; Tue, 29
 Sep 2026 18:09:45 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:09:44 -0700
In-Reply-To: <20260930003120.1DC101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930002140.3174449-1-seanjc@google.com> <20260930002140.3174449-5-seanjc@google.com>
 <20260930003120.1DC101F000FF@smtp.kernel.org>
Message-ID: <arxhWBSLjT5560mM@google.com>
Subject: Re: [PATCH v3 4/5] KVM: selftests: Add module param API to check if
 nested virtualization is enabled
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] kvm: selftests: kvm_is_nested_virtualization_enabled() aborts on Intel
> - [Low] kvm: selftests: get_common_kvm_vendor_param_bool() returns int instead of bool
> --
> 
> commit 680296c2620e4e5c37fadd1bdce211406dcc250c
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Add module param API to check if nested virtualization is enabled
>     
> Add an API to check if the nested virtualization module param is enabled,
> e.g. so that tests can verify KVM's own enumeration of the corresponding
> CPU feature. Provide a big warning above the API to make it as obvious as
> possible clear that tests should use "kvm_cpu_has(X86_FEATURE_VMX) ||
> kvm_cpu_has(X86_FEATURE_SVM)" when checking for nested virtualization.
> 
> Link: https://lore.kernel.org/all/20260910115414.3015260-2-ewanhai-oc@zhaoxin.com
> 
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > index 6e6f70035508a..1608ddb91b6e6 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -1429,6 +1429,14 @@ static inline bool get_kvm_amd_param_bool(const char *param)
> >  	return kvm_get_module_param_bool("kvm_amd", param);
> >  }
> >  
> > +static inline int get_common_kvm_vendor_param_bool(const char *param)
> 
> [Severity: Low]
> Does this function have a type mismatch? It evaluates vendor-specific boolean
> parameter helpers, but returns an int instead of a bool.

That part is intentional.

> > +{
> > +	if (host_cpu_is_intel)
> > +		return get_kvm_intel_param_bool(param);
> > +
> > +	return get_kvm_amd_param_bool(param);
> > +}
> 
> [ ... ]
> 
> > @@ -1472,6 +1485,16 @@ static inline bool kvm_is_lbrv_enabled(void)
> >  	return !!get_kvm_amd_param_integer("lbrv");
> >  }
> >  
> > +/*
> > + * Do NOT use this to check for nVMX or nSVM support.  Querying kvm_cpu_has()
> > + * for either of X86_FEATURE_{VMX,SVM} is the idiomatic way to check for nested
> > + * virtualization support.  Use this *only* to validate KVM's own enumeration.
> > + */
> > +static inline bool kvm_is_nested_virtualization_enabled(void)
> > +{
> > +	return get_common_kvm_vendor_param_integer("nested");
> 
> [Severity: Medium]
> Will this unconditionally abort the test suite on Intel hosts?

Ugh, yes.  I had a brain fart and mentally inverted the X86_FEATURE_SVM result,
i.e. thought I was testing this helper.

> The VMX "nested" module parameter is a boolean exposed via sysfs as "Y\n" or
> "N\n". If this helper uses the integer reader on Intel, it will read "Y\n"
> and pass "Y" directly to atoi_paranoid(), which throws a TEST_ASSERT because
> strtol() fails to parse "Y" as an integer:
> 
> tools/testing/selftests/kvm/lib/test_util.c:atoi_paranoid() {
>     ...
>     TEST_ASSERT(num_str != end_ptr,
>                 "strtol(\"%s\") didn't find a valid integer.", num_str);
>     ...

OMG, I hate KVM.  I'll just do the obvious thing, and then make a mental note to
call out the semantic "conflict" in the pull request.  *sigh*

/*
 * Do NOT use this to check for nVMX or nSVM support.  Querying kvm_cpu_has()
 * for either of X86_FEATURE_{VMX,SVM} is the idiomatic way to check for nested
 * virtualization support.  Use this *only* to validate KVM's own enumeration.
 */
static inline bool kvm_is_nested_virtualization_enabled(void)
{
	if (host_cpu_is_intel)
		return get_kvm_intel_param_bool("nested");

	return get_kvm_amd_param_integer("nested");
}
