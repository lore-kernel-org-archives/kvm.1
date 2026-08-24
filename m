Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13026D4C3
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602618; cv=none; b=movYgDeebY3pCIleXnRD938ewduoYwQQ710S4YIY4NM7GZCs0TL9xF+4t9cLZvZ8FTX2DUuOWNwCDWf6fzBx6wHfp63ezZQQbfmrjSosEOp2FIYOFhXWViGYs85HTvO2PVvFZMyi+XquutWMdvQS19N8FqJEmZXMtpyyIyAJLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602618; c=relaxed/simple;
	bh=hQjlGuZlCnDHfkbrg+tQFOHCoJBhwQJXTENokNCYpwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZNktKA9hQG3nC41IisFiJhlksPwfT1qSzwPu+BZ94M4vwRgdun+jljn76sylAIXvak2U/jz3jWTngtY2a+WYuE5GEiLgChNx4mpWcXwyQObBT/i5LDXsfiAFxnn9GhcFG7+aWGkjYcDt7b8kehqvdA2eS/dReAhTsMky2RV7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1kJfFje; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1kJfFje"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38deea72eebso4604676a91.1
        for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602616; x=1788207416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/UVYXaYGpqOjS4wy3Xiwfv8E1t/SazvgREqms2nJdOQ=;
        b=u1kJfFjeX5oFqFookgth1QWuJfUwok/5XqPn+10Hiuig05MQd4qqwy0hZn668UQLc2
         XsEzegKs/vGs+SXDYLDcYx2RvgCehiI+nCToZOPYAjzuH8H3tvasFG01Y6nCmCZIvhqX
         i8Ueq1JdlKCTPP//YhGV6eQxL+l9xxOFzGzd13hNF0D0riwkmrWV6UINM097j983faG1
         KdKh8eqt3gUgviys/sYp+7hV1ZZBE3jfNl8VFnb10kTA2mDnsYLlx8wJ3KAjlGT4omV1
         TRYwMHGt2i7Z4Eg0tNcLsWhJowtNMtt7YcPmDLY3TQJUbSFpr3eg7O22AZXLk50JEVMl
         OSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602616; x=1788207416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/UVYXaYGpqOjS4wy3Xiwfv8E1t/SazvgREqms2nJdOQ=;
        b=K2OlFMP5dyGiuM3BjxTKfOBSbCsRgkhjBPmnkNF5yLppaeXaPP7+YhzzkeJDhQE6/t
         YyOqMjjbOgSteNUJxdfCeRe0oiHrpMim5zvVefJh1jjEqel4GuJGKAwyR+JOqv/1sAjj
         hNkOn2NFfuJL4g9l/vpZcTV/cuctBopfYvJYDZPecCSJPWqzMjqEcN9B8ao/ht+9kXft
         ZMoHWWn9uvYvBLRKxUTI21JYlXvBAy60M0y6y8oEF7yTamA05x1D1RoeKLOHyH1SI57E
         5QEAszsOkwfsPzaRPlfe5KD324dicMir8WinEIZaKbt7wAwoUSY4uKydkhuziF9i5aWb
         HRsg==
X-Gm-Message-State: AFuF++lz4qaijWmWq4gRemRMMh57hnJY6PUBdqbSWaItUBay/HTcnxTT
	HFzAtJmgYm7esmlyXElLJydu5R1YFS52IjGqt6LSBiqn2XftkCgHlbWc4mWMfoKfQ9JC7/hpRWY
	jWXeGcg==
X-Gm-Gg: AR+sD11gpi4i6Q8rMgyEHSjVkelQHlFhg+zPeR9LOhdpgcPeK8qL54UbEzHmKu9Gylr
	8AvXUPtfwSxAZwOtOlN0fLvcepZG1VaUvN12Az5oXYoaO3zAgiv9vqiDVQamntr02XSd0HW/UOw
	FuyShE5cuKwfg2vxA+bu9gOVlScCJbTr4mGbZoDIeKOFU/EzYl2h++TXKuq3/XwDAvGgeldC5fB
	iBtiLsgo3H5wXmWNHLzVyEtvdfZhaoUk1GOAWFx637HC3w20MU1wYdRXnprUopBONYnIFNwjXxG
	ZygwsHWte0UnKwIHYaYK7ovWKPplCvG63G8Z0+mLa7K4w7JM3Ev1VvQ9C6HlLuewe8ofwCcIBM6
	MB+6ScmCgNFcPEne/V4OiDs07AAcus9YaTXunbZKc59j549+xiK3m9GhHZu1N2INmiCwCSlzJWv
	/VMjcTX4cB2/99MrLd7oRqniWjwDqdVb1O+x5I46u6RS19SalCAHJ8C8g9r0z66vGrLMrod6GFI
	SuSHXeuscCxT5rJFqhOfAfQ3LdLXOnrr6IvLmAT
X-Received: by 2002:a17:90b:1801:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-395df25998dmr35769803a91.11.1787602615899;
        Mon, 24 Aug 2026 13:16:55 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645bbf59csm809431a91.15.2026.08.24.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:16:54 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:16:50 +0000
From: David Matlack <dmatlack@google.com>
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, shuah@kernel.org,
	seanjc@google.com, jrhilke@google.com, rananta@google.com,
	vipinsh@google.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/vfio: Include <libgen.h> for basename() on
 non-glibc builds
Message-ID: <aoymsrcVYQ6SUJ07@google.com>
References: <20260821122110.902382-2-hisamshar@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821122110.902382-2-hisamshar@gmail.com>

On 2026-08-21 05:21 PM, Hisam Mehboob wrote:

nit: "vfio: selftests: ..."

> sysfs.c calls basename() but does not include its declaration.
> Glibc exposes basename() through <string.h> with _GNU_SOURCE, while
> musl declares it in <libgen.h>.
> 
> With musl, this results in an implicit-function-declaration error and
> subsequent type-mismatch errors at the callers.
> 
> Include <libgen.h> so the declaration is available on both glibc and
> musl. This is safe at both call sites: the arguments are local writable
> char[PATH_MAX] buffers filled by readlink_safe().
> 
> Link: https://lore.kernel.org/kvm/CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com/
> Fixes: a262fc49e0aa ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
> Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  tools/testing/selftests/vfio/lib/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
> index 11415448b2e2..daf117a299a6 100644
> --- a/tools/testing/selftests/vfio/lib/sysfs.c
> +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> -- 
> 2.51.0
> 
