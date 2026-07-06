Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80A3CFF72
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368327; cv=pass; b=MrAgm37w5M54o5ZBTEzhBknYbe4qP24ZjCWnuE/eb91HByMK5JeJYK2FTcQN1UzXEfkOr+yXLA2+Z67o1Pn8Hae2jHdcisSyEKcb64zrPlpLO240cF1i4J41izdZRdYkTpTQstCj9MrIwpLUtITR/c1XEEhoEcdRNIJ0QzM5Aps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368327; c=relaxed/simple;
	bh=cZzLDtUOUx2+M6TxkHymIb2lPpb+5tNDsr6avCKlGmI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgbqS7hn/Kx8S8I3OAGeV7/7zk5APHBARH7SIKwhJjFJ4um8iZ+VzgR6wFLMTCAv/y8NoIG5rifl70uKXPJAy6x3D5dGCU7zfb8ZxSn/mEnYTKh8WMphIjrQWxtKy2cslgF6LZ4Vo1R+7ijpxIWp8ZciltzpwMltjEL/5F27Lz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giEuSFaE; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giEuSFaE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so24131655ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 13:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368326; cv=none;
        d=google.com; s=arc-20260327;
        b=DjxF0hw+Lx+bZGCx50wOTqlLbN3jIgtuvJAn57f+KD7059jLmJYxML561SvPPewG1/
         6ZhyKIjrnyEpkSg2CrxrqEKafocUhD1WWOz1w24u+p8/Q/HrT3EjoEPeXMxfi5P0DDVL
         gl9b83UrsnF5YWZ7q4qUsBCs/uGKeTZhhpmeLV5S6tp/Hub80M0GmTTndBNTZbQvuw1T
         XRW+TE9hcdy+xNVH6RwHHm13L5y0rvBhJazQsA1hiEApABwWZs/mf4a85vTPSTx1Nvm+
         6NOeVRc+TPsYnY+cMsErdxeBuVP4HQ7GkPTL9uJdCUv9d6lnluh+74iFyxLRfasFjSRI
         Ds2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y1sJvcjfFSzHCYkLQviAR+AOvGzP6D3rFksnjCW+sao=;
        fh=uoEE7mjpJu9LH9f9rQ9WpqWXHvz7JYk16VAzo55/UPA=;
        b=cASiLHpYD80ITuQs44ZrxYOwiErOKAfrXTGZwCVBWtXrujlNMfBkw/q0lxasrgTyEk
         SAJvsNMsn/ZwrVvZQfLp56qjLowlMuIrmhpRAw9JRi6CF2hLm/kVAbowshVc+HVimHTr
         loLmarFg4Uzf5Ul+c5qhTxDyES0qu+KbJAnK8A/Q+vpvULmaGs10yJHJAqh4415Set2F
         ub9wRK2AFwURvbx3vrmiqg0Ez58ABbiDgM+dRy+ywwcMDFUmIxxXscMi2USfLgWDOspg
         OBJclFSNRkhzwoFRtimFau2O/hjuSwi5wRBlyf0Xd37MjUt7+IcJAPQl07dnPocDLa6U
         UGCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783368326; x=1783973126; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1sJvcjfFSzHCYkLQviAR+AOvGzP6D3rFksnjCW+sao=;
        b=giEuSFaES94oPLNtxlzSLGWTrYdHjqulVc0bXKs2L3S5JEmNYfFUpA5YOTtIS6nqUg
         2HbHOdAxImIcjWvWqvwRtG1L5ZXYO9FkdigxKnl8zoyTk+6zJ5AGxyLaYPU1q0JPdnLl
         LG66fEZFEUs/0scj73t3I77WPgDrMLj/0weBGalDk1bMKbFldBvLa/62xBwlR4Ra6MsO
         o1n/jjTZZkgyvrlcpqavJlPTFvvC7O0pwnmKLHFO+mVuIsBZACX6ZqwfuicN6venrej7
         29Oxkc7hgn3mmFEcrp+pSqVcDU+0Gp/dJ+BCqAeRPyBcuqClK+/qKo6zhvlRusSoaAAi
         hN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368326; x=1783973126;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1sJvcjfFSzHCYkLQviAR+AOvGzP6D3rFksnjCW+sao=;
        b=rPNEUWUQf5tt58KAVLA4z43QmYfyiCVd1fjQML3ZiZ9Ip8jLgnR7xlVyGBa4AqaBvp
         XNZ3VZQi+Dp4H1JNjax+IuBlUP7n5h0yvXRlVb+3VWHglZtKqPjQhvGn4MQu14Ggba+L
         r0nXAmLz/VNPbNZMA1uzDhhvhGVQpt1jiRSdffhn5GXNt5aIIW8+gDhv4SdX6jPMGRdP
         31BmAUkQD5yd5Wd2sI5Q+AfLqPw9dyEzTI1PecQR5s6mNl6/c4RCUV+jO/LLbeIGbhRB
         pRKhRoaaZDuJCJ8NBBNWv2oIaPZsUd7vFKDmNMPZJGn+hF0OtmvosO0uXzwzhpzGG7oa
         N3AA==
X-Forwarded-Encrypted: i=1; AHgh+RofnHQSvvqxccZBHNBkakXHdb87C3F+nmkkyExvleoHSEBQV+vdq04OdSScvFIAehxDU4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yiX6wU/KKgpz6BRu8Zj4j/QdiBuSav3swiXl9fAYMGh8E43M
	OI8pFEXl4pWduDnnaqiPWazA7ec+ZOl4i/CvUZ+Gin+Rscui3000iCdsky87Mj9QItAIkU+IVJ/
	1QDvoGcssKil25aa3GtkjfT0ixpXb30TVcBd9GLXp
X-Gm-Gg: AfdE7ckAlVD5ni+ZQHdBC3We8T2wSeUuec5LlTU/R4v8DDkrwcitzfBh1zSu+eV023z
	0Xck20t0R741NZeGCOYX7wP1JCR0mgBHBzmGV2OCrJE8O6iyUi6F9+fHEV5uv33zdS4R3QR01Wo
	/oePUAGu3K6HqZNnBkSIfqzo5X7yx7YE28NbHNlYNiBQahuItCMssjbkocWk9S3Wd5Y4jYvRX3l
	FRLyhuHsTB6twyZik1LD+1XbjsHJfndiUHd3iRKFri5R53An6GgkLm7cw3moBOah2bY4isBygM3
	VeoBltJk/OWHt50tlphPe0KRzOKCYnUzkJh/bj9f8n0P8iZeHvsaN6BOADM=
X-Received: by 2002:a17:902:fc8e:b0:2ca:e0ff:e696 with SMTP id
 d9443c01a7336-2ccbe509767mr23472615ad.9.1783368325085; Mon, 06 Jul 2026
 13:05:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:05:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:05:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-31-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-31-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 13:05:24 -0700
X-Gm-Features: AVVi8CfBjO2gULD3GETeRHh9h0KndZBQaojE74hhluZ7n9qbjhbk_11LUC5m6bk
Message-ID: <CAEvNRgFpD3xOAPJPziVy0EvT61a0jjAf2VH0X3ZeHC2z3Om8nA@mail.gmail.com>
Subject: Re: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream setup/teardown
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

>
> [...snip...]
>
>  static int tdx_tsm_link_connect(struct pci_dev *pdev)
>  {
>  	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
> @@ -362,7 +579,15 @@ static int tdx_tsm_link_connect(struct pci_dev *pdev)
>  		return PTR_ERR(tlink_spdm);
>  	}
>
> +	struct tdx_tsm_link *tlink_ide __free(tdx_ide_stream_teardown) =
> +		tdx_ide_stream_setup(tlink);
> +	if (IS_ERR(tlink_ide)) {
> +		pci_err(pdev, "fail to setup ide stream\n");
> +		return PTR_ERR(tlink_ide);
> +	}
> +
>  	retain_and_null_ptr(tlink_spdm);
> +	retain_and_null_ptr(tlink_ide);
>
>  	return 0;
>  }

Would it be possible to define .connect = tdx_tsm_link_connect in the
patch that sets up spdm, and then update tdx_tsm_link_connect in this
patch?

I think it would help in showing how the spdm is associated with
tdx_tsm_link_ops.

Would it also be possible to bring the definition of .probe in
tdx_tsm_link_ops till after this patch too?

> @@ -371,6 +596,7 @@ static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
>  {
>  	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
>
> +	tdx_ide_stream_teardown(tlink);
>  	tdx_spdm_session_teardown(tlink);
>  }
>
> --
> 2.25.1
