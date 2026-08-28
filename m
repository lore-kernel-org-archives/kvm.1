Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6343A7F51
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955546; cv=pass; b=oTaZdm1Dgg/BRQcEo4miuu9L5vdLUMGva9WFXrOrJhasQCXdAidyUsX84ofRbkP4KdzPvkw+ifQWhxysvoYgD80oipcfnycng5vk3YSzBfLM1ieMF0cyWLmjZZVPbgRPhcQdes4dJNsgrqM+056vuNXBznNJvmmNSLNumWjGNLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955546; c=relaxed/simple;
	bh=BMIGDWFwkO1RXH8rR2UOhGKndRufLWtM6RTNgfHf9Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L95CXEpbPyyzm9+iBI+8XwnKn9z/bdnQmmnlK2lFSie/Z97QG4FVTFPS+BJqIx63XeSX4C/xu8gQvdlw+d8jyoz2SZd5jqHdfTxYfllO/FOBmu+vhRTAUBotT+/GEV28vfLHVvNZvyuSZFy92v8M3B3uezWSw7lvEGZW6vzRncw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3j6mVZf; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3j6mVZf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52faa58bff5so77981cf.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 15:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787955544; cv=none;
        d=google.com; s=arc-20260327;
        b=DptM3arBBwb2uh5GZ2AHHwtSG/294VowedoGfi8GhqDlXbCkJvheCsT3D0P1qvLUfS
         eFEHn8/JNbh4m/B9qzLqypYp+1sTkumEIYA7/JMeqN2CdZOeevNnj5y72mICJpqkKe+b
         t/gXg0naY4OaKJqxRXlT+Oy4+lCiqbrzZdOFnrE+DAXZB+yhmUOm77WMZV96kG0wdmm0
         2mEEcfbI1NEpdA0FmS3CJvl7ZIYdoDrvtufSK5SNVWVgsdATMx+aC7yLcenu0q7nL/c8
         IiPJsGVrH5Snqb2PjCcNtV7YJQQhzUmi10XH52bDGWxnikpA4ZdA87F8+E0c8JdvuvLN
         kgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Z06k1eL56A6jAeIm3cli0ZxCvEv3ToPuyXt4lMC1e4=;
        fh=tD0T9ZBuCxvbSPgwoezpiLkvDHYO9i6NxnpQ+U4ryFo=;
        b=V7E0+fV1AQGx7o+h0UZx+ZENb+/3BbABCSgVbE8NOfGPI6Rrpk3ylU+AfoTUz4jxCL
         l2bSb6+XuInGWUb2QRj/3PDowMFjnsT1c/3JNC1hVt65376NdfsZvicDJfKOdVxEMo7g
         GpgFZsxTkg0rGUu53Q30zka74b7ETGQZIzfeAz/czw7OusNysvNZGgE6x7muMjx4hFX2
         Wnw4r+bWrYxTIVHiHs1Hp9dNjIN5Q3fhv4StHEvDPkTvREP7y4rc87DzouJ5lJ/TBHZG
         TPFLQiMtI4o30hP+/Dg6q0QcHb6iLw8cxTds1aczihBGDoApsGTwxaoUFi7RHuqxwkkS
         HMpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787955544; x=1788560344; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Z06k1eL56A6jAeIm3cli0ZxCvEv3ToPuyXt4lMC1e4=;
        b=E3j6mVZfc+2R0/xsFMmoqiZRFUt8BlgFX0tmfQUumgdM2tRi4iaJDaU5nIU5SOaGyf
         wTrC/K6vSXgmqZE2Va3x8oXsGwWcyUoq6SNGHEEe/qngfwU0VtiDSFnj+ueLw9/YOjok
         Y4MfGMZgZzHMAshYtHzEeSRm0XVJ75mmaiEuCHNhgdEn1l3gVAcGXjVg+swRIL1MNfaS
         0j4UL1XixaYTJP2x+AbwzhrT6LXuj86PlLjl38+0R2tILXULLOEPckPk76yGzdzlMx0O
         +rv4enFqzc6VIGM5RGpIkK3WPWEqoo9aJSBD1J71yFwvNvlX1vPPBcl4B8LAlRrPW456
         rjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955544; x=1788560344;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Z06k1eL56A6jAeIm3cli0ZxCvEv3ToPuyXt4lMC1e4=;
        b=bNEfNOqG34p6E7b5kzDJXDRd4cpF/ZsXT755J8qN1MjSuq1fjNPoRbNn1mY3XZwLWO
         PnP7FQBb+ahI6Wc+4d6W2ORfkaW6KG4/htzukFlVvGQMkEGSK/q4zxtIiae4AyUl7ndP
         nVd8YrrCPsiB1U0nmSH/C+Jp2nzKBBaLbjlZyy6eXTpKfjxfJm8Y9NVSENpmfbout5wi
         F5ozAXZzLpe9faoZhycMw4GTuJjYd7GiDgIcMwkOBEY0q4glkWQx0fR5J1fB/1pta79U
         i8nfRHpgvaIXn4mYVNYLusHLLFhQNMsv0jstB/ffg/fuGh7bIkkJyAYenunpOAsOxuzb
         YETQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBW1cVldlLX4jTaGRu0paEgGStBSYZB6v05gAVDPYSv3xp8CddKDgkzYMMCV9oXdNba8w=@vger.kernel.org
X-Gm-Message-State: AFuF++mZm/ODyRwNn7zovWWNIhDg3Wg7M9lMlSOC1i7eEOJjyJpUl25W
	y6QjlfJGFgk9s2NqHmU9nvxhIsg17mVgUCiebZkg0FTSP6gv40VnHmKrO+mJvUwzFBxKEyyTxsG
	Jd604yZ9DRkr2CvUzhr8JpMBCh/EK5Xl3644/4jH9
X-Gm-Gg: AR+sD10XdAxEZsZK0DZIK44KIOcYPQ756r/k2YVFPa9zG9z8eRSStrJM0JtQG8jtKxA
	ZrnQic57Zp0HpqVX+RVrkO7s0KEa5ersHKbvLQa44aXwRkVuNE4qnWkx/TU6WU98QSgt0I3BSp5
	zDIqEpmlHa44SAvHihxD9XG6w4JBWYpBCGc1gp+Zm093bJ7QaL8/+e/1tu0gMC973aKItU/AKHl
	yd9UezXZ+9Po6kzxagEJsMXvpUoFhk8pl2f2NNighRt5VB1BiyYrg1TXs1Y9SoJf3NFs252VTZ3
	h5S6Bp0/M6nytRB7OJoRGtiP3gfa4CQgTrPQcv+KK1hPEhwoJMM4qnQNvbPeyXFAkNfZTOcLH90
	=
X-Received: by 2002:ac8:7d8b:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52ff711656dmr4308141cf.1.1787955543697; Fri, 28 Aug 2026
 15:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-8-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-8-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 15:18:52 -0700
X-Gm-Features: AcwNN1VtKeCMrm5d0HiUDNcJteBwV9YWHV2SenRF5c-NodyaK5x5u2MCHt6fWJ8
Message-ID: <CAGtprH8XJ+SbxQLTowch3DR6N1NSMUKyVnGf0hv5N+iKWT3q7A@mail.gmail.com>
Subject: Re: [PATCH v9 07/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, sohil.mehta@intel.com, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

> +
> +static int alloc_pamt_array(struct page **pamt_pages, struct tdx_pamt_cache *cache)
>  {
>         int i, j;
>
>         for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
> -               pamt_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
> +               pamt_pages[i] = alloc_dpamt_page(cache);
>                 if (!pamt_pages[i])
>                         goto err;
>         }

If the alloc_dpamt_page() was able to allocate a single page (not
two), should the partial allocation in the "err" handling return the
allocated page back to the cache?

We observed similar failures internally with a slightly customized
setup which had retries for pamt cache allocations in the fault path
due to SEMCALL failures with older TDX module functionality.
