Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5382F83A0
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116794; cv=none; b=QhR6dOZ0xJePT22vczx0W/dyWgbFVLLVpOexKbGEVe/M8dGGu2q/8ep+Wep1Xp1/JEIOkKP27o64fzzILhrToTFU9h/WYXWwORKMKLAvDiv5T5L4eN+OpsIrNNJCejgzDM9rfhcU1+xNba3YUY5xgT23R3TcPgg/QOa3oWg6azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116794; c=relaxed/simple;
	bh=CuCtF9zBSt/jXqtiTrxHsckhICkhxH/eO39mfiWbP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FomN8rTSZlrVPhi1XbJUIU+Z3ZeyKtGpPVwtSIshYGdlEFlTuRMguH29Dc14OvZb4ZmhmPRMVusEHMovsFHTF7lFcO+4Eq8t0UGQc1GbF0lTPT+VhUgaz7b8pcm/zoul/7+TgOFQpPHBxo9bRXntoYd0LPdeG+AMDsxxAxO0FRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSl1TnnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSl1TnnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BFFC2BCB7;
	Mon, 18 May 2026 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116794;
	bh=CuCtF9zBSt/jXqtiTrxHsckhICkhxH/eO39mfiWbP+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSl1TnnYR0D2GodgQt4mUaKh2XpVBAXiapHwW1wPdhJntNuBbt8CXSXwRhjLv5Emm
	 jMOtCoFzy7T6ZJOeXtS2sieUHqHF5QYPOayI+grCnl86Q5MqBnY5Dws4A5JekRiLxa
	 zW4G5MBCCrEYMdbjmyBZEBZSc/KIj/BZCdlx5+orF1zj5VfAsfOiHdStYyXHrTZDRD
	 hHrd/zsQuuzCP55rLGipEgko59DwH1imojAbfW/S2Gk1yOWELSp6BXEwx4l9su7GdM
	 DLNFdO6rFWufMSX+sXqi8DfmfqKmC0DEVsT1P4exEy9S3VFV45OSIuZdt8BN9nImSV
	 q9LkralJ7Znyg==
Date: Mon, 18 May 2026 16:06:29 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 5/6] util: Allow die_perror() to take a variable
 list of argument
Message-ID: <agsq9UR3n9YTcA_Y@willie-the-truck>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-6-alexandru.elisei@arm.com>
 <agl_7nDeUfkgHfte@willie-the-truck>
 <agrmKH2YfieGDDJv@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agrmKH2YfieGDDJv@raptor>

On Mon, May 18, 2026 at 11:12:56AM +0100, Alexandru Elisei wrote:
> On Sun, May 17, 2026 at 09:44:30AM +0100, Will Deacon wrote:
> > On Mon, Mar 23, 2026 at 03:02:20PM +0000, Alexandru Elisei wrote:
> > > @@ -98,11 +99,23 @@ void __pr_debug(const char *debug, ...)
> > >  	va_end(params);
> > >  }
> > >  
> > > -void die_perror(const char *s)
> > > +void die_perror(const char *fmt, ...)
> > >  {
> > > +	char buf[1024];
> > > +	va_list params;
> > >  	int e = errno;
> > > +	int ret;
> > > +
> > > +	va_start(params, fmt);
> > > +	ret = vsnprintf(buf, sizeof(buf), fmt, params);
> > > +	if (ret < 0) {
> > > +		e = errno;
> > > +		strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
> > 
> > That looks really confusing to me as we're effectively hiding the real
> > error that caused us to get here just because we couldn't pretty-print
> > the error string! In the unlikely case that vsnprintf() fails, I think
> > we should preserve the original errno and either print a string to say
> > that the formatting failed _or_ pretty-print the original error with
> > strerror().
> 
> You have a good point.
> 
> I'm not exactly sure what you mean by pretty-printing the original error.
> Do you mean that we should print the message passed to die_perror()? I'm
> don't know how I can do that reliably. I could use vprintf(), but if
> vsnprintf() failed, wouldn't that make it likely that vprintf() will also
> fail?
> 
> How about this:
> 
> diff --git a/util/util.c b/util/util.c
> index 0f116e0ac459..4e3704f781e8 100644
> --- a/util/util.c
> +++ b/util/util.c
> @@ -109,8 +109,9 @@ void die_perror(const char *fmt, ...)
>         va_start(params, fmt);
>         ret = vsnprintf(buf, sizeof(buf), fmt, params);
>         if (ret < 0) {
> -               e = errno;
> -               strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
> +               fprintf(stderr, "vsnprintf failed with error %d (%s)\n",
> +                       errno, strerror(errno));
> +               strncpy(buf, "Error", ARRAY_SIZE(buf) - 1);
>         }
>         va_end(params);
> 
> but we're still losing the original message.

Sorry, I think my suggestion to use strerror() was unhelpful. Maybe just
do something like:

	ret = vsnprintf(buf, sizeof(buf), fmt, params);
	if (ret < 0) {
		perror("vsnprintf");
		buf[0] = '\0';
	}

	...

	errno = e;
	perror(buf);

Will
