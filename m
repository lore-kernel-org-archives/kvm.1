Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECC28851F
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573040; cv=pass; b=G2g89bTVfVEDLFCO44YnLpg3RSMOg5GT4ZDqumIQyjxyNLmX1L6QQuh9exAP5hBnaIgeFtaDLYYXej+j1u1lAdatzutuH/+4PkwpIjf6WmQPZsWmSygMTh8Z1QyWOvgqDD3rqMnGucXGH63k3MqHRnwD0FSgfg7plG6nmiJg2vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573040; c=relaxed/simple;
	bh=/jEC7IJfBBxXHlgchTjCqACCqOEjsTnHcHLIw8XQ6Lw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Va5pepQMXwev9oiVuX1KcKUEo2zV3Wiwq1XWlbgGb3v4sFlK6hUrhyW8OfIjqN94/TYllu1mQ19TjxwtA781U3Mcc50mxdCeOtGJCbhcdHI98HDxy2FgrHwr84LuTdo4MDp9J5gzLcK4ZUmU5LDGpQp1UudMFVPotkQ1vhvYBRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9cK0n6R; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9cK0n6R"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-610aadb2d9fso405892137.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573038; cv=none;
        d=google.com; s=arc-20240605;
        b=CUSu1yjePP9xGyDMoY+OmPx1ijhWPP7ieTWxdnEFzeXGMldm8hVNfK0JQ2ozzxtmxk
         nT7SrDD7pyZ285w+dcyiGPKuE41Dmu+tQjmwM2ZylVzYB4xYP5OfhBQQPnX55/FQWDdc
         +GGlyARHROv4CZMm9xghnZSA8L0Nn/PsLTKpJ84Ym1ZRAoFdvxq3iIKHYkzwrZELQYi2
         omyWV99sAaBd+PgDPAIiSwV8mvjvWQi4LfJjD9MsvBGSxHC6xeVecB3IgNHNhPbY3tab
         vCkVtjjO/Is1JEp8kc9YRtMpf+ayREG69koRWHopdzt6/fCrMIGIYTkDQZmHNFNhdFjw
         9gZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=s/OJBjFU5E2BcXru/6ZaLRbo+YS3ANxLYhS97YcrWVE=;
        fh=qKUWM3oX6NKThNxoJIW6iLR3j2N5+NjMtAcWehkdlyY=;
        b=PeoEka9G3sAaEGXUdqoYVuDdAGlkp4Dr/i0o+TwBcAudQ9QwMqe8DCwPIPD+eV1ohW
         SzEsO7VCjiLFqEO5DR7cXNjyr59NPCoVFQpNeVffsx9AF6Dn/K0fCvZv+nitOprt6jLh
         Qw8BxpPKvLlsdSW6KC5x8gUFCGH3P5I1whyQA+aMxOI9NJiPQOpS5Y1+CqDpW/Learfp
         w0CYwOIJYnMgUi0CyszguLEMQEw032dXTlUaM1phgv4knJWpBFcrtRjcXTKFm68GoVYm
         GzozPPZe7Kztc1VQRMB3GeNtXQHKKeHNqovfhNG9d2VKqDPQucqu0ELpSv7WZf4dD/2P
         ge5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777573038; x=1778177838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/OJBjFU5E2BcXru/6ZaLRbo+YS3ANxLYhS97YcrWVE=;
        b=g9cK0n6RSxFFWA2YCRDDwgKtQ4RVHBBzQCXjiLZ4d2tLXHegPuGtQM5qulyxSfLiOC
         zC8mAjkVpQtR2rd7u4LNH4ssmBvKYRnsTCKWxEcaQpdhHeXyYvinTpP+iMBI10Q3dtD3
         iCsLky4bOAfvWGXdOC3p6yeLNJowA4AhVm4zyw3zFRWnqsDTZY67Y+mZ53z7qzEqq5Co
         wTvwa27dK4xGnq/PS2s+2F+x0BuPbQ+v9WtRf4OdpCGTNkzISzdvETEYR4VcbTLHhZdD
         SbKFwIagBncS981zozfdyi8cnkhaGsZ4bJtMY7wh3FZqZO2Mv0dbrmV7RZRpiJPunoXb
         +QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573038; x=1778177838;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/OJBjFU5E2BcXru/6ZaLRbo+YS3ANxLYhS97YcrWVE=;
        b=jHnv6QFvbzN1SB3OCAUb5ry5OCp/5i+IcYEcVL9nyAmzb+e7vdFxBCv6rXL9+1UQLr
         agYy6ZL/l/AMWLE2SgSrgHXZauMwhZFUT7S1IyyC8dGsuW7AFX+aXrnc+Q7ZhhIuRIRQ
         SqPGtjIH+lvswpdPsQhKLkvkM27po34F68I4oPnOCjTnNjmAYSJqjKduMP1OHYqNL7bG
         8+VRe/7zRI01ttB7FuITe8JKO266iU94+V3ksZdofiFzEkzTtoVfnps4ZDl344MeoPBr
         Ps2n+VPR861f++Om4VlkGIG8C/Cb4VRcPyGRFjyH6RN80EYWgyeM+L/0m9072Y9l3b4G
         B2uA==
X-Forwarded-Encrypted: i=1; AFNElJ9baoYXY2M+cFHwe8HtRxZu5E9kMghzhKYGdUu0SOh4o3PqbNhLY+0h6m8epEFziu0g+lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8UZXpKqtJxf4f90A6H4Xr3MhJpJ6IYcKgBnSS4tu9cZMERzB
	dEyJm/BM1JFeP+/Xl3jRAKaZCfT4ml3UcVv0Ay6qiVIRQRwNc+LbyzVMCRsZv8Vd0hOIxF+VkeT
	qVz4ThGohU31tItPKcvtW6/f2rQ1TBDTboHe7kuQ4
X-Gm-Gg: AeBDietvSiYqKR01g4YL6c/SpEwAA+z1cvqrY08iVz7bDZCmsEA7Ubjqh/p0l1wBbUU
	o5Md3osM7nHS6mw5q6mm2/xdAwWeZes29NpQrs1q/NhZA5YQZvsJFUtP0a6BVi1uzQLB/ltsr9C
	00N17PfHlBj3nQ0QHKO/cyOck9ESrhYlWCPXUSjkuQAXmciS9ejXvpefEzmd7leRbcpQNTaAZ3M
	4bnQMJR9XxsghDUU0bERgWhDc+BNYmdVrsYXi3HvAvJZ+tbroUkW/mVUqhTmr3fs7xzpEQMG2rm
	nWj/PRpt8M5/rO9nmqyi3S24HlTXFcyalAlms+yhProBmnouNM/QrILJa8eumwAkmLUb8p+iNrz
	bxVjrX4XhZn2QtgRvoZtSNRSD4w==
X-Received: by 2002:a05:6102:508f:b0:611:6fef:90d with SMTP id
 ada2fe7eead31-62ad52b8422mr2417607137.31.1777573037446; Thu, 30 Apr 2026
 11:17:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 11:17:16 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 11:17:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260430014948.24226-1-yan.y.zhao@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430014948.24226-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 11:17:16 -0700
X-Gm-Features: AVHnY4J9PCIVECZvrtLYhw7bWhM7_gjG-2ujkDrQ3DZ1AfQmK6yn52gKG4WOSMs
Message-ID: <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>
> [...snip...]
>
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index b24b81cea5ea..e5a37ea2d4a0 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -710,7 +710,7 @@ static __init int tdmrs_set_up_pamt_all(struct tdmr_info_list *tdmr_list,
>   * to normal kernel memory. Systems with the X86_BUG_TDX_PW_MCE erratum need to
>   * do the conversion explicitly via MOVDIR64B.
>   */
> -static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
> +void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)

Could this be updated to use phys_addr_t base and size_t size instead of
generic unsigned long?

>  {
>  	const void *zero_page = (const void *)page_address(ZERO_PAGE(0));
>  	unsigned long phys, end;
> @@ -729,6 +729,7 @@ static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
>  	 */
>  	mb();
>  }
> +EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_paddr);
>
>  void tdx_quirk_reset_page(struct page *page)
>  {
> @@ -1920,17 +1921,17 @@ u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
>  {
>  	struct tdx_module_args args = {};
>
> -	args.rcx = mk_keyed_paddr(tdx_global_keyid, td->tdr_page);
> +	args.rcx = mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_page));

Should mk_keyed_paddr() be updated to have a return type of phys_addr_t?
I guess in this case since mk_keyed_paddr() is pretty much an internal
function, returning u64 also makes sense to indicate that it should only
be used to set 64 bit registers.

>
>  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_tdr);
>
> -u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
> +u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
>  {
>  	struct tdx_module_args args = {};
>
> -	args.rcx = mk_keyed_paddr(hkid, page);
> +	args.rcx = mk_keyed_paddr(hkid, pfn);
>
>  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
>  }
> --
> 2.43.2

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
