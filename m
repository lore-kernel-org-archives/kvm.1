Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475A3BE659
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362937; cv=pass; b=njEqzh3jSeH8YoR1bigmK5dU3tD67nt8lOr3F3yndSci3fwJDIp16oobNbyhljeRGlYYr0ac8TZTktvxrY5JMxJ4u+0p3eW3hxwxB2oCSenFRgqLIw9H8+VkoZAYiqhWSVwxffwi9Z50XJAKhl+gH2avAzcga3lPQMyoeAdRCwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362937; c=relaxed/simple;
	bh=HPrlRjR/87Sgv7afW4R5TLpUfuybQzJj2nJz3LNjgt4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPrZIpBKdKKxAxWFyWcNLs2mp4kZlg3Ipjjqe8oHvf8pJeRl6rixi5LjmTwFjgJtxj9pz0spOSEOHztzg7FceVx6jrIckarMyqD9RoWpR6f1KgSxsguViX8rQpDGPHupL2O8+wTabFavxg18rP41JZp+Gso5tjaOXyHpl0lV4VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3t+io6M; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3t+io6M"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847a52edeb2so2497478b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 11:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362935; cv=none;
        d=google.com; s=arc-20260327;
        b=G3KqJkBj1XF3sO9vECkUU+XueeQCZNi7C1/jJrn6bAim9kNsBRxcGckHqqDY/jzXDX
         n6B1ZAGZasGYtLwjXr/o3iwTVqjZc9csGql1kq+JmanfsT0UzjKFDurG2sh+RMcOpADq
         2a/EEKtEQPe8ZCOUAFjkUV5qm7V/mkrk7+NxD1EECKmF+PfgPYlJKubv8DQ/hCHA50nR
         fgN4VQe9W7MfwymrGsyJSJOmYRVWZ/BDyPUkr81rn+13LtjnnLTxxFBNNn8++Hqsguz+
         MTJBrLnNa4uE3UL8a9dk8xKwybMK+tfgHOkwh+VG4CJUoJhbVfepqhQfW/vKGL+dxxH3
         I+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WnS2RNIXat7zDN2phUDyBGT8PFFJ5aIBlxvkpKQm44c=;
        fh=YmqshVhRMEg7JVVfhGjSFR4GjlNJTPK7YAgUYCztYvs=;
        b=gCKsDjgK8J2boqBRa9inJ1sCZ9bsCMOEucel5LOS6Ev5p0sf3elnfJ+ZISeSSoivOV
         1hFWdJVu4gaQ1zvWN698tGOdcOo+F01HmTAfy1X2FuNlJEYRlfPWIVTQm7xfc1W15sK3
         F4IPIjsfp6/ROJEAc7E5ijM5qHxuPfxcseqILSCuwOiXEWn5lASJnO42zXdqtSYlMVtr
         l7WD0p3C6XlXvzR+FyJ4Vg+w4GoFktV5DoL3zzxG504j4XXabZc18K2PpXwB20ciWN+I
         XnhvOXy/sfvpY1b5zCfpFfwVsh1ZSmA5h9Oj/yKFL+JY2BBBjdxVyL2VfrbcBKX/UdcQ
         DmNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362935; x=1783967735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnS2RNIXat7zDN2phUDyBGT8PFFJ5aIBlxvkpKQm44c=;
        b=n3t+io6MUV6oVZqKUv+EkZCGqFBDhvPkntajDpa81/Yf5U97GTXkqgXGEW+YkLEjZS
         e6OS9E16hSOVLibDCiLKl9aWzML+644BdraflfYsGWR53fgiNAF/8hmbzSSZ53ZFbqf4
         kfk2OA9AKl95zdx2xIeWsQatUWKGPbJOlwOZ9KVzQEu5v1/++oKX5veR2FcLCWhDJ5c7
         Stbfg3VeDpCzLHM3PjrsODPYAY2cJwzVf8HoQhfYoiQ5WxcFZwKAVpZNwINK4kORCGfe
         RApZGiLYRXFhQ3WAJT6D2o0D+xbiZE9gvbxjXueQulU4axzExLTv8CbBb9LM/Dm0fSvJ
         WGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362935; x=1783967735;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnS2RNIXat7zDN2phUDyBGT8PFFJ5aIBlxvkpKQm44c=;
        b=JwAtLTPoEO618y9m0RpkDZlu5x+2GznntdHWZ8z/ZdQvVsoC8n7nkni4L3czjknP43
         v5QSkLW15mcUo+N1rQcFvEPsoZdjsxSd3TGl7TNvflh09wPgcerX1oD7IsDpbiB1s4yw
         8OywZwVJvcNHNjioFhh5n8Lk40X0ySxNekqbhynRPkqe2iAPqr7Cr57Ie0qT/G94bB04
         31kYxaplr1RPpASBZVSsDORzaZVN299LqR+K8jbGf6LVbUDjON7RxU/1eCcj7bTRd22X
         Iiq40+P9i2E4rAPUTJ0vTzz+9DdPfig8CMm1h2J8EHkMFfiloKAC+gDyl/Juiiio47tF
         NSrw==
X-Forwarded-Encrypted: i=1; AHgh+Rob89Kac19Ko4UCgupOUbSyvXzng2L2LLSUKP++6WwMk1V2PmgosvhuF8qnV7ipcsO1Log=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPgav5vaQSgXFqBHy0JrGeGfPZndXwetFpM8GoA9x9X8XWcxp
	p6FThIaiw2NWa6gpTeuHaZSkglBhHv4b+stE9oem/xKqk9KFG4GO6Kz8+mk8kXS697yQh6xjJdg
	mBh6oyIX48SoYjRxtv9domrdPMHqnJfPNBoYyy+yi
X-Gm-Gg: AfdE7cnruhbM1azhBCNHw49wi/qGUDNg7HznNknAKL9hpgEwPMFJd/TEX2T9eDB1Y43
	PEC+LghgYxFYth7RVau8WY5/SA/W51bWt6DQsonsqe2q1jHD3HBkIhMqnCjqpq89Z1aud57mqJ6
	r5h8wbiRgUwLy9486BGUleXhbI5e1+cFFrBnWtog8i3ikKOkPwGlucwVFuqMPvPJuEX2C72SPnr
	BUnaRT0GZSpvF4FAfVegD5Viokxpkm5PSzsMYGrAO/yVTYbc4v9GK4PKmQe4eD1yikjkeQObO1g
	s8vu8QrviySN+9LtCJrwtrkiAaNkc6IGpKTsA0rXdysilHLaNQsibSboPd8=
X-Received: by 2002:a05:6a21:1f83:b0:3bf:6c04:a812 with SMTP id
 adf61e73a8af0-3c08ef1dd4dmr2080840637.51.1783362934943; Mon, 06 Jul 2026
 11:35:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 11:35:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 11:35:34 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-23-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-23-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 11:35:34 -0700
X-Gm-Features: AVVi8CdqD5g74lv_vdWGXV2KWJo0HCHGQ2q9sBsYTjhrRT829V9HzSMACy2bRlo
Message-ID: <CAEvNRgG-6aOgtW9cB6zE7278B=0fB9KSEH18Kw8qNF2sBtUBsQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Enable the tdx-host module to get VTBAR address for every IOMMU device.
> The VTBAR address is for TDX Module to identify the IOMMU device and
> setup its trusted configuraion.
>

I think this commit message doesn't match the commit subject or the
change, unless I'm misunderstanding something

> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  include/linux/dmar.h       |  2 ++
>  drivers/iommu/intel/dmar.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 692b2b445761..cd8d9f440975 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
>  				dmar_rcu_check())			\
>  		if (i=drhd->iommu, 0) {} else
>
> +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
> +
>  static inline bool dmar_rcu_check(void)
>  {
>  	return rwsem_is_locked(&dmar_global_lock) ||
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 4f9571eee1d4..eea9ba691f99 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2452,3 +2452,19 @@ bool dmar_platform_optin(void)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dmar_platform_optin);
> +
> +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *))
> +{
> +	struct dmar_drhd_unit *drhd;
> +	int ret;
> +
> +	guard(rwsem_read)(&dmar_global_lock);
> +
> +	for_each_drhd_unit(drhd) {
> +		ret = fn(drhd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(do_for_each_drhd_unit);
> --
> 2.25.1
