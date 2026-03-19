Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886B3F1640
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943206; cv=none; b=qol2ED7LuYK1vNp4HT+8o8xDoyq0TDzERQvTCJTmpd3eeoiXDWwLX2foznW8p8RXQyxrvlKxRvF2waX7sVlQkdyf9sOppoxBFFoqiMfbUsZacifFqEmSdh9SlnGWnHDu1O/B6lrQgTCF4DRjwxGcnAFkilEql8dQHtiq/tB+bBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943206; c=relaxed/simple;
	bh=mXLAjSFqN04nOAHia0KTAMGaR4TecROWc5whlp/KWVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apnUGXm/PHmPPCjv3IDS+xYNgFQrav27YfCAB31faxaPPaZLnbYFeARh2FK3DJG5xR3tj//jBgx26e/jusTJwgXqogrF+RzChCsVlaK12pgwyDalL/dnAXNgf2fwMofD0ZXnywdHRRpPi6zm242DsL5a/+Gsqti5Kwhy7Zb5EcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asVfC5jh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asVfC5jh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so5581745ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773943204; x=1774548004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsqPGslUel1uxBrizy1vlfn3ckI3geGjJLxULvs8ikE=;
        b=asVfC5jhV2McZ8sXT9UzV4vsELMfkE0qT7hF+i9ti6yOMTescfgCofnHKlr97kyCLX
         pcy5hGkFJNedMCDVOFhHnNvdJ8P6kv05lVYLyEZIM8h97jVFo0IDGmaOdPlzUCn6D2L3
         KGFZB2gDBYfbCs8CGiXWv/vZkFk7nIrUWDIu0W+y0/gD1dK58YA6iqsx6f+wgvM+f7qR
         b2ouEjiv1B59g/4MK6fEXio6no9yUfAjUM03kCWmyAGUY+ZIAnc2H2PEwPS5QuomTRvZ
         araNsPpLstBHOFVIfKQpZKqXsWTy4tqpQCGrEXHqIzP2kKrTOssGIWtj4LfBBBGMNAzg
         1d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943204; x=1774548004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsqPGslUel1uxBrizy1vlfn3ckI3geGjJLxULvs8ikE=;
        b=aRrrOg0PrRTPo/Zzj+Gp5kCxw1+1/1KhkK2QKrq30qreVtG6QbvKXcWmAVomCsMBwV
         l2Uchy3JFQHHaB6swK2lauEqmqwJAVxr23l/kMB6X+NXRqlNmK55Kwqo9iIZ4q10q/yK
         thnAXCsxpCfdx8m69BAsObmLmWAIGtuUEHtfxoJDyP2eX8k6bsRHFqzr+Y2CLU9jB8vx
         OUTDIrTDU0QcPxmVMUrqK037dUdyb9SjMh7nnAr44MGwUbgprq4sb/LNwfsrUEC/edu0
         ztkmBUCaa/oL89w4EWi47MAl8c6T3hwUnsjUVdQ9R0gY6VBuydlsPo1LmFM+9aPYRogn
         8GMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSLDQYwDOWR5HnGmgJ87tYzULCztIDG+D6Bq/OjjFlJrL+yv8BQ341VSyWOls+PycryVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblO3Zi2+mHI/BdUkDqb4zi4kp5CV+ADJh46Q98li49ey7JzNo
	KHOvIrVLpinQr5STvET0psKo9LtLd6VksAoFzyPHlqFz8W681uWsI9MYYPQpbdgEag==
X-Gm-Gg: ATEYQzzECOcaWHf9akk5ZNXr8o9sY+yh9HVnQ/U4lORjjdBaV07T1EgqwOxXHKT1R0p
	1cL2CT/ImasMAkg0gdMjEDBCzsdfJDLZcshjyLt8Fbb8LxD1TopvlI187mhr4eYppGMzGfj0Uzj
	Kg5pbxnnsK3sjFPm/kA0G+jATQTgmYW7mDuDKfH6f+atlkGwMDEsqSH+wXtPkbp35jWM9/V7Qov
	6yLdTgWJEsa4ixawI0LrB6PNpA5MvG6W82Vh1s9IVfWi11zEQhvrehOc4kaQDD/zA8UivxBTTvS
	323IEerJxL6n9HP846/ECl2x0IrMDoHBK6yecrhwXe8IlQdGk9e+3MnqslWyDA2DV1WbJ7XdaJh
	nEpIvjZ9BuyCLV2od6lm+Dk+PIZSGbKXRMEozeUrgO1+gk+5K0JhPUBZFEa3rZXFwJ9gUPeJg9a
	HIaVfy6M9BorxOpgjwaC95Ta5i6t4+km6PVa9cIU4FUVYCULUTVZzqUH0bYJ5IuQ==
X-Received: by 2002:a17:903:2449:b0:2ae:c8b4:6d9e with SMTP id d9443c01a7336-2b0827134b5mr2112115ad.13.1773943204122;
        Thu, 19 Mar 2026 11:00:04 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5ef42asm80250795ad.40.2026.03.19.11.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:00:03 -0700 (PDT)
Date: Thu, 19 Mar 2026 17:59:58 +0000
From: David Matlack <dmatlack@google.com>
To: Ted Logan <tedlogan@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matt Evans <mattev@meta.com>
Subject: Re: [PATCH] vfio: selftests: Build tests on aarch64
Message-ID: <abw5ng4M14Je2OfU@google.com>
References: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>

On 2026-03-17 04:25 PM, Ted Logan wrote:
> Also build vfio self-tests on aarch64 variants, in addition to arm64 and

s/self-tests/selftests/

> x86_64.

This could be worded better to clarify that this is about fixing the
VFIO selftests to allow native builds on arm64 host platforms.

> 
> Reported-by: Matt Evans <mattev@meta.com>
> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/

Please also add a fixes tag, since it was not the intent of the original
commit was to disallow native arm64 builds.

  Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")

> ---
> Signed-off-by: Ted Logan <tedlogan@fb.com>
> ---
>  tools/testing/selftests/vfio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 8e90e409e91d..98bc8d6271a4 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,4 +1,4 @@
> -ARCH ?= $(shell uname -m)
> +ARCH ?= $(shell uname -m | sed -e 's/aarch64.*/arm64/')

Perhaps we can just include tools/scripts/Makefile.arch to avoid having
to maintain yet another "uname -m" translation?

This would make it harder to prevent aarch64_be though, which Alex
indicated we might want to do.

>  
>  ifeq (,$(filter $(ARCH),arm64 x86_64))
>  # Do nothing on unsupported architectures
> 
> ---
> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
> change-id: 20260317-vfio-selftests-aarch64-636abf0f7674
> 
> Best regards,
> -- 
> Ted Logan <tedlogan@fb.com>
> 
