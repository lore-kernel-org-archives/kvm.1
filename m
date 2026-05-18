Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF831714F
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099184; cv=none; b=BMuzoY0Go/1tC30C1bDkrHM4BL828YwpHMeJuIT7RYWC4jNV25Pv8acZg5/hIMqLpFAyH2NGkjv1h4rzjNoBJxi0xVqXc/8+Lk0v+XPhCcbf4CpYPVFgY+ecu2SIKle4xfIPuO0iU/BdTXB7rKClPomz93XoGFJIVV+VodsLrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099184; c=relaxed/simple;
	bh=eCNpxxaX6gwO6UjdvrI+2YT3BcgGny3lqj1BrayvRZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMSONvH1JYgJEeMUeoEqLoF1oBQF3lit4lhyOm/UOhQGxDv1ijsj5mGWe4cBMqBDS0JCTSl2k4pWba0kWzdmDcSmBUo2/fApe7vRkkjyi8p6XZkLuTwXAFkYVfF5D19oaMIy1wDFzFLPFEaBliGeBliqcevtxanljyr3raxb4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F2hcgTYK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F2hcgTYK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 577054617;
	Mon, 18 May 2026 03:12:57 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B043F85F;
	Mon, 18 May 2026 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779099182; bh=eCNpxxaX6gwO6UjdvrI+2YT3BcgGny3lqj1BrayvRZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2hcgTYKlorivlPTTb7SbtAx+WTWklUbvRVUCnBg21xMGnwdSX+TxhvwBItIfS0CM
	 uY9A87fAXDBGGl12JAxjmseEevNRluM+GzpUl+GyLeGphG3y2rncOHTvERQw6IT/zC
	 7VfYT7nOQKJy8IFSIRHOzya4fhtcSWlcZUTQXhYo=
Date: Mon, 18 May 2026 11:12:56 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 5/6] util: Allow die_perror() to take a variable
 list of argument
Message-ID: <agrmKH2YfieGDDJv@raptor>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-6-alexandru.elisei@arm.com>
 <agl_7nDeUfkgHfte@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agl_7nDeUfkgHfte@willie-the-truck>

Hi Will,

On Sun, May 17, 2026 at 09:44:30AM +0100, Will Deacon wrote:
> On Mon, Mar 23, 2026 at 03:02:20PM +0000, Alexandru Elisei wrote:
> > Make die_perror() more similar to die() by allowing the user to specify
> > a format string and arguments.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  include/kvm/util.h |  2 +-
> >  util/util.c        | 17 +++++++++++++++--
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/kvm/util.h b/include/kvm/util.h
> > index ac8515f8c46b..a6dba1147d68 100644
> > --- a/include/kvm/util.h
> > +++ b/include/kvm/util.h
> > @@ -41,7 +41,7 @@
> >  #define MAP_ANON_NORESERVE (MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE)
> >  
> >  extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
> > -extern void die_perror(const char *s) NORETURN;
> > +extern void die_perror(const char *fmt, ...) NORETURN __attribute__((format (printf, 1, 2)));
> >  extern void pr_err(const char *err, ...) __attribute__((format (printf, 1, 2)));
> >  extern void pr_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
> >  extern void pr_info(const char *err, ...) __attribute__((format (printf, 1, 2)));
> > diff --git a/util/util.c b/util/util.c
> > index fc732200f2dc..0f116e0ac459 100644
> > --- a/util/util.c
> > +++ b/util/util.c
> > @@ -1,6 +1,7 @@
> >  /*
> >   * Taken from perf which in turn take it from GIT
> >   */
> > +#include <stdio.h>
> >  
> >  #include "kvm/util.h"
> >  
> > @@ -98,11 +99,23 @@ void __pr_debug(const char *debug, ...)
> >  	va_end(params);
> >  }
> >  
> > -void die_perror(const char *s)
> > +void die_perror(const char *fmt, ...)
> >  {
> > +	char buf[1024];
> > +	va_list params;
> >  	int e = errno;
> > +	int ret;
> > +
> > +	va_start(params, fmt);
> > +	ret = vsnprintf(buf, sizeof(buf), fmt, params);
> > +	if (ret < 0) {
> > +		e = errno;
> > +		strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
> 
> That looks really confusing to me as we're effectively hiding the real
> error that caused us to get here just because we couldn't pretty-print
> the error string! In the unlikely case that vsnprintf() fails, I think
> we should preserve the original errno and either print a string to say
> that the formatting failed _or_ pretty-print the original error with
> strerror().

You have a good point.

I'm not exactly sure what you mean by pretty-printing the original error.
Do you mean that we should print the message passed to die_perror()? I'm
don't know how I can do that reliably. I could use vprintf(), but if
vsnprintf() failed, wouldn't that make it likely that vprintf() will also
fail?

How about this:

diff --git a/util/util.c b/util/util.c
index 0f116e0ac459..4e3704f781e8 100644
--- a/util/util.c
+++ b/util/util.c
@@ -109,8 +109,9 @@ void die_perror(const char *fmt, ...)
        va_start(params, fmt);
        ret = vsnprintf(buf, sizeof(buf), fmt, params);
        if (ret < 0) {
-               e = errno;
-               strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
+               fprintf(stderr, "vsnprintf failed with error %d (%s)\n",
+                       errno, strerror(errno));
+               strncpy(buf, "Error", ARRAY_SIZE(buf) - 1);
        }
        va_end(params);

but we're still losing the original message.

Thanks,
Alex
