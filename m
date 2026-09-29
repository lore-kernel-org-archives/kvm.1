Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5051AEC7
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687305; cv=none; b=skeI70XyOUEwltRZWjXL8EwbHSfW6xN64AX6w8Oy84DOQKmquPkA1QHFCskocn7LCdZFmXo2OeczFZ1hAk5/IgQHIRbWnIaFWhU8IV3GAj6YAczNxBm/pcELUFMTtwfaHFWAMABtNsIOyqkVEkpvqj8guLlJa20ENEE6N/bhQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687305; c=relaxed/simple;
	bh=uaXy1AnqfLSnUDMwwNF1+OLNUhz5wbsELYGN7SWq6fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5G9mHv7vjyDlSIaNp+IFoVwjZl6lDgHKf0yYqbH7zbKShIN6/OJwECiOWpc95LVvvWcbVRJgAo2iAz2N51PZoPE7MMHi+h0Kls4uZC8TPe9n38vRZvODDMtmDDQSuySP2/O5AwhD8LZX75Imxz54Y5JwKZ4rE0oprtmPTYROMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vxFTBRr+; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vxFTBRr+"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uaXy1AnqfLSnUDMwwNF1+OLNUhz5wbsELYGN7SWq6fc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790687301; v=1; x=1791292101;
 b=vxFTBRr+qAbXP1wxmXHQlO8ldesQGqJppVh7CiwzdXfsZrVWD6K5gE3jm2D6OyOIZO/Lc8+m
 p7R8maYq3q7WVxbY0HxxOqlHRa9PcoTTJrpH3XxDHsdT7Tcynl6jvcTf8YC9EuzWlgStflriM0w
 cm4xcBzAMpOBw+50mj8sYS98=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2a8a6d2cfa55f8d5;
	Tue, 29 Sep 2026 13:08:21 +0000
X-Mizu-Trace-ID: 2a8a6d2cfa55f8d5
X-Migadu-Flow: FLOW_OUT
Date: Tue, 29 Sep 2026 15:08:20 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Giacomo Mazzola <gmazz@amazon.de>
Cc: kvm@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 8/8] lib: parse KUT_ENV= from command
 line into environ
Message-ID: <z5uivx36dfvxwkjndaankge4mhwuo4kakfig6p56avmudtu56a@ze25zjnlv3wm>
References: <20260609140901.95727-9-gmazz@amazon.de>
 <20260625140452.24159-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625140452.24159-1-gmazz@amazon.de>

On Thu, Jun 25, 2026 at 02:04:52PM +0000, Giacomo Mazzola wrote:
> Add support for passing environment variables via the command line.
> If any argv element starts with 'KUT_ENV=', the value after the '='
> is parsed as a comma-separated list of KEY=VAL pairs and fed to
> setup_env().  The KUT_ENV= argument is then removed from argv so
> tests do not see it as a spurious positional argument.
> 
> Example: KUT_ENV=PARAM_1=VALUE_1,PARAM_2=VALUE_2
> 
> Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
> ---
> Thanks for the review, Drew.
> 
> v1 -> v2:
>  - Moved setup_args_env() from lib/efi.c to lib/argv.c
>  - Use strncmp prefix match instead of strstr
>  - Shift argv down instead of swap-with-last to preserve order
>  - Drop redundant isspace check and COMMAND_LINE_SIZE cap
>

Hi,

I'm not sure what happened to this series, but for this patch

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

Thanks,
drew
