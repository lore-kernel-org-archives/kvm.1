Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5564594A
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876687; cv=none; b=h8a4tCQRy4DKxMcPtp8uvz1EzcROI848SEybDCKGuLjMN2Qdb9Yr/zwCM7avEHNWlPp7Y3ZU3IFvKpE2eHi7TDQgdAdJehRrCoAF/AFDzFjbvGBwunAfCvcS/Db3wHgs9g924EHFzgJ2BZXzOPckDTljs2TqeQLT/duixm6wNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876687; c=relaxed/simple;
	bh=TsTEW844cnAtWu7hlRH8Q6V/4AkhN4EyndxafojPyvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRi/z3GAjPVjDtZRnE1UHNYnvxi/PrKsXedE8BC0bpJgTey5DLAr4BKU9dNkNEvNg1LGe7axu5jsDhHuajEFPevyqaOaeSjPE/TDXgq1xdpsUfIO10V2oXMjM4DNmZS+5gaPB0844gij2UF/1qVXYUH9bzUJyDpbyqAOj4+NZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nns4xFXh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nns4xFXh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b4d734678so319449f8f.1
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773876684; x=1774481484; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPESgE6Nig2k963E/tBvH++66JZV+AKWoFevLTVVc+c=;
        b=Nns4xFXhRKW1eFzlJnanrDrfvDAUl/SE7XnCMGnnzT4hgWyu3E2C6nUP3h6f+PeOQc
         FUda/XW7fVJ3Xj9sHMrv6nOdolfUKw9345qSNBo/FGr5YNinWCQmhskjQYCNoKWrGD2i
         hX0ivqEonMW670AZhY973S/6VrPHKJXs8NcwrAlxWI1v814AFhdG5gDnC3ZfQJWRECGa
         qhesgkf7UbvSktSUH22JcXnrzBWP+z+p3Ib3T33tvRhsoHbyQ9ko1IxLANPrjCdy6OK7
         Ea87B/iJC4L4T0bEtzuEvhNyOZpPDPKjGoclHmPzJPZGwKgfhXBqwleVFmennMs+Bvxk
         3AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773876684; x=1774481484;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPESgE6Nig2k963E/tBvH++66JZV+AKWoFevLTVVc+c=;
        b=YxZFo0rKp7pbA+41LT5a0L/PD5ZDuF/O4p30tdlagmWbWKrNK7iFtrKhQe9Y/Pfo7y
         f5Ft+OHO+rhId5QCWsz7RqmeHLwkrRzts0nkFvfVfIaG5iSO8PDAlGbydoH4AsRsZa6f
         4y8vRsllXht9e24lfduIJSCy6/GTJehmGQHQBT/7UYOfp/9H8ugpUtvARM+9X+dOgAe0
         g+LL1L3FUK3AUq5jgzjPoz/YwSjqDzju3fL/05TIds5+pQ0mHJqLp48e61twNEqXtnLb
         p6ar/biplbwkO4WFLH0zmbdsGQLysmYz+LKxE+6sWala6BwN1MH6axUtlLLBUK9mkiMa
         wmPw==
X-Forwarded-Encrypted: i=1; AJvYcCU3LRETNp6M63JaZShfV6IYyLbtcVktQ87ho/Lp0E78VQTfI2Klbn/QShRHwpNC20gEmEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00R8dU1jVPk17QZcoHq6PpWyPYR8OReGRgwL8OWLi5r5FgfRG
	5yW3xkzICBc8amU6tgpbyX/4c+kwJruf6phS6EruOLCqG91TO2svDfxMOHB7S+g6aQ==
X-Gm-Gg: ATEYQzxUifGLuybPTWv3nS7Tut0yLwf+UUjAWLTLQ9vpYjHI5E13mib/5hKs850kMEo
	T6zh4ntSuBrF+FOtUyWf9R8B3dKKh8tOAWXCRcezF3/gcllfOleiwB2q/sp5Eu5CsZRHcGqzd1q
	umbNETECQtChRMKpVRPSZvZ+Uo0iYfDfu9uCGN+sj4TMcysZTkWHYjCwXYJu5Jm0eb9LYd+ZSH/
	36J2RDbHGoHzzQW8nG4gn+aIUj8kBedflsUQidpMJbsSWF9cygq/S+8beC855yKct12Mg3nMARk
	EADaZCS8jofImNzEo2e/EA2OIhrHE+Q3zzsBq+zLr81NSbQ7hVOlN5CIU5tB8gNLi8ZSf6PxVvL
	MWYREUA/I6tj0bvvxT5uMR65C3y9bl3gHL667Ad7L9Q5kfd2dcHIKLCClU1GcQryuP1InQIMI1F
	YS8p8uPa8K4dvrR32nYOUEa5old3P5OvRNO2Y7YLNaomspaZkxaQLFDafcfY1U
X-Received: by 2002:a05:6000:26c8:b0:43b:3e0b:721a with SMTP id ffacd0b85a97d-43b527c8099mr8704888f8f.38.1773876683581;
        Wed, 18 Mar 2026 16:31:23 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:90c2:7bc8:af6b:77c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3dedsm10785914f8f.36.2026.03.18.16.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:31:22 -0700 (PDT)
Date: Thu, 19 Mar 2026 00:31:15 +0100
From: Marco Elver <elver@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH 01/62] kvm: Make pi_enable_wakeup_handler() easier to
 analyze
Message-ID: <abs1w28YCs8Qj71w@elver.google.com>
References: <20260223215118.2154194-1-bvanassche@acm.org>
 <20260223215118.2154194-2-bvanassche@acm.org>
 <aZ3r5_P74tUJm2oF@google.com>
 <7a22294b-1150-4c55-a95a-ea918cfb9b76@acm.org>
 <aaCHS5ZRuW-QJkK7@google.com>
 <CANpmjNPKkFxg0gLu+n+PaGgkq0AQ70DdHi69D3iEwGFO-r-yiw@mail.gmail.com>
 <e3946223-4543-4a76-a328-9c6865e95192@acm.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3946223-4543-4a76-a328-9c6865e95192@acm.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Feb 26, 2026 at 04:19PM -0800, Bart Van Assche wrote:
> On 2/26/26 12:13 PM, Marco Elver wrote:
> > The goal of RELOC_HIDE is to make the optimizer be less aggressive.
> > But the Thread Safety Analysis's alias analysis happens during
> > semantic analysis and is completely detached from the optimizer, and
> > we could potentially construct an expression that (a) lets Thread
> > Safety Analysis figure out that __ptr is an alias to ptr, while (b)
> > still hiding it from the optimizer. But I think we're sufficiently
> > scared of breaking (b) that I'm not sure if this is feasible in a
> > clean enough way that won't have other side-effects (e.g. worse
> > codegen).
> 
> Does the thread-safety alias analyzer assume that function calls with
> identical inputs produce identical outputs? If so, how about changing
> RELOC_HIDE() from a macro into an inline function? Would that be
> sufficient to make the thread-safety checker recognize identical
> per_cpu() expressions as identical without affecting the behavior of the
> optimizer?

The below works:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index af16624b29fd..cb2f6050bdf7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -149,10 +149,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 #ifndef RELOC_HIDE
-# define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-     __ptr = (unsigned long) (ptr);				\
-    (typeof(ptr)) (__ptr + (off)); })
+# define RELOC_HIDE(ptr, off) ((typeof(ptr))((unsigned long)(ptr) + (off)))
 #endif
 
 #define absolute_pointer(val)	RELOC_HIDE((void *)(val), 0)

That preserves original RELOC_HIDE intent (hide likely out-of-bounds
pointer calculation via unsigned long cast) - GCC has its own version of
RELOC_HIDE, so this seems to be exclusively for Clang.  For codegen, the
temporary variable was just optimized away, so I'm not sure what benefit
that indirection had at all. So all in all that should be equivalent to
before, and looks a lot cleaner.

The reason it works for Thread Safety Analysis is that TSA's alias
analysis strips away inner casts when resolving pointer aliases. Whereas
if there was an intermediate non-pointer (here: ulong) variable, it
stops.

Unless there are concerns, I'll send that as a patch.
