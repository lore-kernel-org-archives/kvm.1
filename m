Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7030B51D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115554; cv=none; b=DGXVrVf4RntgaoczWQtaH+pPv/rcK4fLgNTeE8fhDDk98spcvP+mWFGJv8/KuaVhMeZ1wu4C3iByHJSY/B6rFnsipDUV19GzA0hJID1fGes5wwrw6abvuE6SGJB6XEV5JOkXUeHiT0xMWApkgrPP53BPy1f7ybjNegRS27sCmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115554; c=relaxed/simple;
	bh=3uT7uCBdHK7Q6DaRVzxdqQ7Pf1aj9vdwZKSO+LExmHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H31NgbkbIKHH/YqRIhdiWaNWcgTqWl6VM+hFu+h1DSCWDzdGEtX2m5G0Gj9tM0vkvnCCJtefKvZswjaRNzNbffzW0uH4UzL7Dimp3lv2goSNnQJ7SjtKXhZptRSTg8nBzwEcyyDdJXx6Tg47t7Dz7lKaGXj9gvVwlWskABGFQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eHiOtfhv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHiOtfhv"
Date: Wed, 10 Jun 2026 13:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781115549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGw3GTptSdUZrSWoVBsdx3rZSXvewu+MVPBIyfKEYDU=;
	b=eHiOtfhvY62FsMW+ywCEhpWPyI2U5QDpe5TzSyI08nwUP/Fvjk4p2MXF/0tU8SSKbXoaj6
	XQzp0OhVJraggC03VQBl0qanxFoObbKmM+PanWrkjFt1H1nwx4GwftMyra5ECEpbqBu/y8
	EkQdggHSU7B2/4Q+YuoTevZmNJuzf88=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Giacomo Mazzola <gmazz@amazon.de>
Cc: kvm@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 8/8] efi: parse KUT_ENV= from load options
 into environ
Message-ID: <wsgckfz4gz2lrmr44yijsmb4ytrdwbmjev5r6c4cz7mhpv6eni@bdlwodcdnly7>
References: <20260609140901.95727-1-gmazz@amazon.de>
 <20260609140901.95727-9-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609140901.95727-9-gmazz@amazon.de>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 09, 2026 at 02:09:00PM +0000, Giacomo Mazzola wrote:
> Allow EFI applications to receive environment variables via the UEFI
> load options string.  If any argv element contains 'KUT_ENV=', the
> value after the '=' is parsed as a comma-separated list of KEY=VAL
> pairs and fed to setup_env().  The KUT_ENV= argument is then removed
> from argv so tests do not see it as a spurious positional argument.
> 
> This lets a UEFI boot manager pass runtime configuration (e.g.
> KUT_ENV=PARAM_1=VALUE_1,PARAM_2=VALUE_2) without needing an initrd
> environ file — useful in EFI environments where no filesystem is
> available to the test.
> 
> Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
> ---
>  lib/efi.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/efi.c b/lib/efi.c
> index d1be2bfc..650671e9 100644
> --- a/lib/efi.c
> +++ b/lib/efi.c
> @@ -13,6 +13,8 @@
>  #include <asm/setup.h>
>  #include "efi.h"
>  
> +#define COMMAND_LINE_SIZE  2048
> +
>  /* From each arch */
>  extern char *initrd;
>  extern u32 initrd_size;
> @@ -139,7 +141,6 @@ static char *efi_convert_cmdline(struct efi_loaded_image_64 *image, int *cmd_lin
>  	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
>  	bool in_quote = false;
>  	efi_status_t status;
> -	const int COMMAND_LINE_SIZE = 2048;
>  
>  	if (options) {
>  		s2 = options;
> @@ -397,6 +398,39 @@ static void efi_load_initrd(void)
>  	}
>  }
>  
> +#define ENV_STR "KUT_ENV"
> +
> +static void efi_setup_env(void)
> +{
> +	char *env = NULL, *p;
> +	int i, size = 0;
> +
> +	for (i = 0; i < __argc && !env; i++)
> +		env = strstr(__argv[i], ENV_STR "=");

strstr will also match something like FOO_KUT_ENV=
Maybe that's intentional?

> +
> +	if (!env)
> +		return;
> +
> +	/* Remove the KUT_ENV= argument from argv. */
> +	__argv[i - 1] = __argv[__argc - 1];
> +	__argv[__argc - 1] = NULL;
> +	__argc -= 1;

What if the command line is something like

 $ testbin KUT_ENV=p1=v1,p2=v2 -param_with_arg arg

then we'd get

 $ testbin arg -param_with_arg

We need to loop and shift all down.

> +
> +	env += strlen(ENV_STR) + 1; /* skip past 'KUT_ENV=' */
> +	p = env;
> +	while (*p && !isspace(*p) && size < COMMAND_LINE_SIZE) {

Do we need the !isspace() check? I wouldn't expect spaces in this string
since it comes from an argument parsed by __setup_args() which splits on
space.

> +		if (*p == ',')
> +			*p = '\n';
> +		size++;
> +		p++;
> +	}
> +
> +	if (size >= COMMAND_LINE_SIZE)
> +		report_abort("Cmdline arguments too long, or bad format");

I don't understand the need to restrict the environment size with this
check.

> +
> +	setup_env(env, size);
> +}
> +
>  efi_status_t efi_main(efi_handle_t handle, efi_system_table_t *sys_tab)
>  {
>  	int ret;
> @@ -434,6 +468,7 @@ efi_status_t efi_main(efi_handle_t handle, efi_system_table_t *sys_tab)
>  		goto efi_main_error;
>  	}
>  	setup_args(cmdline_ptr);
> +	efi_setup_env();
>  
>  	efi_load_initrd();
>  
> -- 
> 2.47.3
>

Finally, why restrict this feature to EFI builds? Let's add the support to
lib/argv.c in order to get it everywhere. Just add a static function
implemented similarly to efi_setup_env() instead to lib/argv.c and call it
at the bottom of __setup_args().

Thanks,
drew
