Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1A2ED872
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117747; cv=none; b=NzCre1yzbicRdMZAvICF2XenZCCCeCHxkOYj79hY4VGlL7fL/7gK9XYV8+9jQW3rTxX5PLlKmy8uKhSRKziFndIHAoXWeJJjD/5968gq6j7dPsu5Cn42rB8/8+sXWNtKSD+ddbRlT0WDVvQ1pKtjvf/mB3WPomDjGyvO8SRTeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117747; c=relaxed/simple;
	bh=2A+WE+JM8IjTHreBz91K8qWTCM6lNZ/W3gMB0zP1ED0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ8eqxhiUq6NzFK3kogONvdr56uulUWZYMrZGXBoPn/t+HXGnXub5qB9whjxf+CnqMB/AH4WIZ3B0z7QtYpdVSi52+s4snITxCIIvpzOqgbmm9rF/T6XTpV/NYpHeLJSTaGtJB7dSL79K4J885BN+OPAczUDfNgALkkubuHzcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=udCBIuQL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="udCBIuQL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D79CE1688;
	Mon, 18 May 2026 08:22:16 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73333F85F;
	Mon, 18 May 2026 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779117742; bh=2A+WE+JM8IjTHreBz91K8qWTCM6lNZ/W3gMB0zP1ED0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udCBIuQLdU7sVVT0XrMyXARWCgZPlRJKA1oKAURP9M8rdWRF65PP4VpCm0BGxiHgQ
	 JGLhQqjG+gVEB6H66vKISSyRHR1rDJMJUjbKI2XQDD7Xshv+tt79+n6SROB7wI2f7G
	 Yj/C1puLQOmPEmGM/RGEoY0Z8YZWBAktLjXXUqbw=
Date: Mon, 18 May 2026 16:22:15 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 5/6] util: Allow die_perror() to take a variable
 list of argument
Message-ID: <agsup8eUjERmsccV@raptor>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-6-alexandru.elisei@arm.com>
 <agl_7nDeUfkgHfte@willie-the-truck>
 <agrmKH2YfieGDDJv@raptor>
 <agsq9UR3n9YTcA_Y@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agsq9UR3n9YTcA_Y@willie-the-truck>

Hi Will,

On Mon, May 18, 2026 at 04:06:29PM +0100, Will Deacon wrote:
> On Mon, May 18, 2026 at 11:12:56AM +0100, Alexandru Elisei wrote:
> > On Sun, May 17, 2026 at 09:44:30AM +0100, Will Deacon wrote:
> > > On Mon, Mar 23, 2026 at 03:02:20PM +0000, Alexandru Elisei wrote:
> > > > @@ -98,11 +99,23 @@ void __pr_debug(const char *debug, ...)
> > > >  	va_end(params);
> > > >  }
> > > >  
> > > > -void die_perror(const char *s)
> > > > +void die_perror(const char *fmt, ...)
> > > >  {
> > > > +	char buf[1024];
> > > > +	va_list params;
> > > >  	int e = errno;
> > > > +	int ret;
> > > > +
> > > > +	va_start(params, fmt);
> > > > +	ret = vsnprintf(buf, sizeof(buf), fmt, params);
> > > > +	if (ret < 0) {
> > > > +		e = errno;
> > > > +		strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
> > > 
> > > That looks really confusing to me as we're effectively hiding the real
> > > error that caused us to get here just because we couldn't pretty-print
> > > the error string! In the unlikely case that vsnprintf() fails, I think
> > > we should preserve the original errno and either print a string to say
> > > that the formatting failed _or_ pretty-print the original error with
> > > strerror().
> > 
> > You have a good point.
> > 
> > I'm not exactly sure what you mean by pretty-printing the original error.
> > Do you mean that we should print the message passed to die_perror()? I'm
> > don't know how I can do that reliably. I could use vprintf(), but if
> > vsnprintf() failed, wouldn't that make it likely that vprintf() will also
> > fail?
> > 
> > How about this:
> > 
> > diff --git a/util/util.c b/util/util.c
> > index 0f116e0ac459..4e3704f781e8 100644
> > --- a/util/util.c
> > +++ b/util/util.c
> > @@ -109,8 +109,9 @@ void die_perror(const char *fmt, ...)
> >         va_start(params, fmt);
> >         ret = vsnprintf(buf, sizeof(buf), fmt, params);
> >         if (ret < 0) {
> > -               e = errno;
> > -               strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
> > +               fprintf(stderr, "vsnprintf failed with error %d (%s)\n",
> > +                       errno, strerror(errno));
> > +               strncpy(buf, "Error", ARRAY_SIZE(buf) - 1);
> >         }
> >         va_end(params);
> > 
> > but we're still losing the original message.
> 
> Sorry, I think my suggestion to use strerror() was unhelpful. Maybe just
> do something like:
> 
> 	ret = vsnprintf(buf, sizeof(buf), fmt, params);
> 	if (ret < 0) {
> 		perror("vsnprintf");
> 		buf[0] = '\0';
> 	}
> 
> 	...
> 
> 	errno = e;
> 	perror(buf);
> 

Gotcha.

Thanks,
Alex
