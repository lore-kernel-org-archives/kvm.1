Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F856314A95
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366286; cv=pass; b=aMr0biiTLhRMcht/LpE+kETrdZOiWKoPOwHfQvJOs+VMJNLgTV2yejGx5NmgdqQBKfCrkxp19x0WJoq6MLc3FOTT7W9UmcCJon+HlF9nqSWiMHZbyJksgoMmVfvpNO/vyNYIDE1XBaXLtrnG2WC9tMkWO3JibdjVzZMbRBhMrYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366286; c=relaxed/simple;
	bh=ZqWVpOj6fMq4bOzwenk+eFayci0sBP705y2M1gKjVSc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnrO8UDUEIstzAM1BDdSZAy5i7D3/AObmM8tEq5Ml3vusYKJMe+XKSLo79tkuVLzuuKIWENFhMCI0MNNotHGuWrtfDIjCJmvqv/UXTX7hcUpopZLUhkaphq5AETWOTI/1eSV4CJVBtAROMPgyqMN/YjA8HZ6dWUTrDUZUJXE6FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgpMkLyQ; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgpMkLyQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso41750985ad.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 12:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783366284; cv=none;
        d=google.com; s=arc-20260327;
        b=TDYODQ+cq3nk4Stn5/+98OcP7g4ZzkBtZr6OvlANcQk/aIUvpk0aoo6KNMKva38Yzk
         QZl+bLyV+ZQtt5e6xa4AJSlrgqDBwK2vl8OSNPlzKe7topJs6xnilHnSNgjHZm2nqqaT
         Y3f6aIg4pHU7+SIRgRlBTDc6B1Ge0jzxAxSMmX8gtB5/DMT7a5FFg4ivjW6CGp32JiC6
         ObqJx9SW1l/B+vuQL5xQOT51P7GhXfjxLV/Qej8JIaceyZXj5c3gNTVTRcsLkQ0gXWVA
         yYv+T7CKCvP7ZHH3PHK/4r6+6wV7M+K2sNcd30A6ZkJKWarFoPTvsHSr+CWJCb7d1rCo
         JbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5sBbN6AQhjUw4Kzr8zci20KvZDn+C3bKKaEIfQEAul4=;
        fh=kgRaLz0mTHlSBL3KExW5dxpMcEGRJOTX5nat1qQJHu4=;
        b=aXxagQXXo43fYqbj/BppYtkyheNC6Kt5ALdaDAor6ud5titAs1rrQcQV1AY79bXMlz
         NVCCff+qL6CREKkX/hqEEk1konc7J90L4AjcEC0mSkkUqSAkEP5y26t9j5t2rzNBXhwf
         2HGxurq2HSaLU9xn0iICzMAUuRCxq0qRmupcrfTABkrOG2xsvDDckfpctZ2Mw3nH84XI
         bNODSmVuAjcUNy4KSeHri7C2JloaZ08NNR+X9kxOOzGAfskWPn60EByaNrc6/tZDbXSC
         2uSVt5HxB8fJlAGWukPfUOMhkPUJLBnJfltxBsWTCFaNoBCCU//sHtXkA/ljcJ1b9Ub9
         KazQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783366284; x=1783971084; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5sBbN6AQhjUw4Kzr8zci20KvZDn+C3bKKaEIfQEAul4=;
        b=HgpMkLyQAbE7kiJuX4f6XG1jTKmgl19svI3zJrxw8juY5eUe3UqNSc9v6DCrpqymwK
         NYlqycL4tEDwLieSg0lvkjx7W3eUWYUEUvBmRWH2CYz+IaWFQAK4HIg6Xdjjosk/c43Z
         7YurBFzAF/pP4hIildyYQ+5o9RgeImGuW8GhSE84Yben2mJxS2YfdV3hrettSEjZtKlH
         8lYzaJgYxtVJ54D6EiheLqcxADgOGMyrL8v+/adVp1dtADSzqqRU4ZRsFw2wzKwB2d5+
         gveZlqJFeTCXIsyGMItRjyW++fLwtd2q4CdHCh7r+1iM5XI39thkjAj18wt7JDCGFZ3N
         cfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783366284; x=1783971084;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5sBbN6AQhjUw4Kzr8zci20KvZDn+C3bKKaEIfQEAul4=;
        b=R6B9VLXqhIcvp1XyEKGc08vbJ31a6YZcNUX9Ax25vShmpk+0TJZUK4gAcwJyLmPtr4
         CEs9tNLKleRuxcgHGLM5fr9NtNUEqY4KtCo6on8MP752OiMV97rtqtgfkcO2na0Z5XP7
         Hdyujm03f2PGIAkB8+aCMXkBYHr1ov0RHEOl11jNFxC9H/ORB6owW8d+dyjeJsWYklTq
         Htm1hFSgL1Y76nYM7ZMiBjr7QjDn+PqVhzCMQvaHDIVXVI3/Ebe3082mU9mjMURn8anW
         U87ecnalN55VdybdLtjPB+yAn8VMMIc0x4e9nO3GWiUw+dPVR3s+2Izx9Nmsoq6LYFot
         2l1w==
X-Forwarded-Encrypted: i=1; AHgh+RojUxvTUeTXlWq06n/9YqnIQHHgKORFAgR1EsZkrJOFviNMC3r7O42YFJ3H4mNepAyGqs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7iSQqFygbG+HWJg60jIpCXijPBk71G4Fdh36NYeBhDkpY+Qe
	5mlhgVT6Uapx7cKyj+tbHUW0NOJMOhA7flxcJd/RDR4Xs5WzdX39pKWDYA9cZDvr4iMfDEpuBd9
	Lj6r3HC3aGtEIsA8/ARf8XzesiOIH+yjG8v6klGdn
X-Gm-Gg: AfdE7cniJ2llsqozAOA+fBpakRlZ5bnegO6ZKOvHG9Dgu1xSoIJdFLmEROaoLnUvLx4
	rcASgAvU4mGsF+y2+mh6Cc/fD4+JRHkC8E5L4nM3JBscBsbRHEWuXLSRbqyEZyw+enux95aAk7N
	BPcbmBc/iEwq6GqtdIlTKJV23R/NTFPWLc3envnGoUkbUw0pRaAwWDIfiIl5xZBagQxMf4Eq2ZF
	ccd+N8+nqss2EI3C5Cj05uOYxZ2iPcDpqPh+scQxcQ2IFAf9ZoUBRHDIp0T71vPtuDviq2yZI+S
	wzrfYS1+G4rXmaob1vpwL6YiHhGq7kH86mkLVGYV8u2fnA6gPqmyuub0mJE=
X-Received: by 2002:a17:902:eccd:b0:2ca:a284:a136 with SMTP id
 d9443c01a7336-2ccbf188823mr18530635ad.42.1783366283312; Mon, 06 Jul 2026
 12:31:23 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:31:22 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:31:22 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-27-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-27-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 12:31:22 -0700
X-Gm-Features: AVVi8Cc5ZxA9qF5433WWwdnaZDh9j1Ge4U5yFtnsyhw7BB1GFtQumPojoRxoK00
Message-ID: <CAEvNRgE4fbMWpTJTMLru-8QW9bJyUEan=K1GYWxvpXY8+LUBrw@mail.gmail.com>
Subject: Re: [PATCH v2 26/31] mm: Add __free() support for __free_page()
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Allow for the declaration of struct page * variables that trigger
> __free_page() when they go out of scope.
>
> A example usage would be in the following patch:
>
>   static struct pci_tsm *tdx_tsm_link_pf0_probe(...)
>   {
> 	...
>
> 	struct page *in_msg_page __free(__free_page) =
> 		alloc_page(GFP_KERNEL | __GFP_ZERO);
> 	if (!in_msg_page)
> 		return NULL;
>
> 	struct page *out_msg_page __free(__free_page) =
> 		alloc_page(GFP_KERNEL | __GFP_ZERO);
> 	if (!out_msg_page)
> 		return NULL;
>
> 	...
>
> 	tlink->in_msg = no_free_ptr(in_msg_page);
> 	tlink->out_msg = no_free_ptr(out_msg_page);
>
> 	...
>   }
>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  include/linux/gfp.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 51ef13ed756e..d37e5564234e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -391,6 +391,7 @@ extern void free_pages_nolock(struct page *page, unsigned int order);
>  extern void free_pages(unsigned long addr, unsigned int order);
>
>  #define __free_page(page) __free_pages((page), 0)
> +DEFINE_FREE(__free_page, struct page *, if (_T) __free_page(_T))
>  #define free_page(addr) free_pages((addr), 0)
>
>  void page_alloc_init_cpuhp(void);
> --
> 2.25.1

This is nice to have, independent of this series. Perhaps it should be
sent separately, and some existing function could be refactored to use
this, maybe __tdx_td_init?

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
