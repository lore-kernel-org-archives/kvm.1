Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95319D071
	for <kvm@vger.kernel.org>; Sun, 17 May 2026 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007475; cv=none; b=l85uHY+Q1DCAmH6k/M5E+c7r6Dy0yURXHRYkEYMbXjKV8a0EivdlQ93AaqaJLRpzgYxnSe3PwiqTraI6Yt2WX+ZvZa8STRvGMsWnqYQMGwcb8PcMH1GjoLvXG+1UV+UnvYLDErtkhzGusnKjfau5u47fKdSXk1jjkvlrmNYUKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007475; c=relaxed/simple;
	bh=zM1cKM1FUrgDR71HI0ThCgI8mrCsaGkil6Lx2XYtOoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCKpE7ltF3r7Tw8ztJqoqkTyoh6/FTL01FXGDIJTyLQU2m8lnON4SKLmqgYGzL18AtoSlVCm30qROTjrO/I4ZIlGipV54BdPoLP1FrugJCvuy/4rKxt/sjQTgZqCjyhrUF9Fcbq5xGHql7H+SX2W7e+Kor4P/xTTVmEVUM1Ed98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ4OTCa/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ4OTCa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7873BC2BCB0;
	Sun, 17 May 2026 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779007475;
	bh=zM1cKM1FUrgDR71HI0ThCgI8mrCsaGkil6Lx2XYtOoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJ4OTCa/A6UVqm/hZRXjzzJnnUWJ6TcagQVb/sE4UTaOzRO3gD6YGIqFhgTc6B/4a
	 D7t/KTkU4phaxCwrRtJSePBkYW3eACsqsLE2k3lv1C7vEhP0cyREbX5Lp3XawdEW8w
	 OaovR2P88DVkh6UwLOnZfpWSJf8J2jBTgJlqBvXTo5ee00DNSAZsENlGBtWkzmngjc
	 IHOve+KZeHHYBUna5ufm4LHaIt3RB8UoUKB2F7PqTq06EnD3kcg+jRjO7UvcfuZ5jU
	 rW35qeghqj3mnsu22QvwuUMs7Qgws4iOSUrhy1M/06d4qx/gk9jM+lcfkZCqHyG8tN
	 iiQYnsAzo5/2Q==
Date: Sun, 17 May 2026 09:44:30 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 5/6] util: Allow die_perror() to take a variable
 list of argument
Message-ID: <agl_7nDeUfkgHfte@willie-the-truck>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-6-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150221.49256-6-alexandru.elisei@arm.com>

On Mon, Mar 23, 2026 at 03:02:20PM +0000, Alexandru Elisei wrote:
> Make die_perror() more similar to die() by allowing the user to specify
> a format string and arguments.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  include/kvm/util.h |  2 +-
>  util/util.c        | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kvm/util.h b/include/kvm/util.h
> index ac8515f8c46b..a6dba1147d68 100644
> --- a/include/kvm/util.h
> +++ b/include/kvm/util.h
> @@ -41,7 +41,7 @@
>  #define MAP_ANON_NORESERVE (MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE)
>  
>  extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
> -extern void die_perror(const char *s) NORETURN;
> +extern void die_perror(const char *fmt, ...) NORETURN __attribute__((format (printf, 1, 2)));
>  extern void pr_err(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  extern void pr_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  extern void pr_info(const char *err, ...) __attribute__((format (printf, 1, 2)));
> diff --git a/util/util.c b/util/util.c
> index fc732200f2dc..0f116e0ac459 100644
> --- a/util/util.c
> +++ b/util/util.c
> @@ -1,6 +1,7 @@
>  /*
>   * Taken from perf which in turn take it from GIT
>   */
> +#include <stdio.h>
>  
>  #include "kvm/util.h"
>  
> @@ -98,11 +99,23 @@ void __pr_debug(const char *debug, ...)
>  	va_end(params);
>  }
>  
> -void die_perror(const char *s)
> +void die_perror(const char *fmt, ...)
>  {
> +	char buf[1024];
> +	va_list params;
>  	int e = errno;
> +	int ret;
> +
> +	va_start(params, fmt);
> +	ret = vsnprintf(buf, sizeof(buf), fmt, params);
> +	if (ret < 0) {
> +		e = errno;
> +		strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);

That looks really confusing to me as we're effectively hiding the real
error that caused us to get here just because we couldn't pretty-print
the error string! In the unlikely case that vsnprintf() fails, I think
we should preserve the original errno and either print a string to say
that the formatting failed _or_ pretty-print the original error with
strerror().

Will
