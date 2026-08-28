Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D04322B9F
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953870; cv=pass; b=AA/lM1lpokPGgdcKd7LBZV7vqNIfQTcvbeDeiL/5P0tD7W1rI60RBZont9UmOV5ELknpnYJZRJOGBQpI0Ex30ayGu8cwGqJl5788BQ5DVNly3M84acwpZpsodlMeyXHyVMQp9S4YjUncaPMcRCJ+emq7Jj7cNqrwaLd9ANHKc+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953870; c=relaxed/simple;
	bh=9OK73M8dTXU4RsAbZMeY1j1qUUYmedkbx17xriTUJOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZg+dZzGNr3NE2nxpYoSeyyNtzB59abjJ/I5CUKMDFJxvJVijpiKRcF+ss2ROy1jA8totWcnud1ohItqqa0YZtTjPDXtDRuED9omQuma6mH4VUcVZEyw+zVPsSeBTpGNA32ld7piVlpUkVUyfDJ431ioS2aSk0/M07X9Dg7ZfSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhKOVPVl; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhKOVPVl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52faa58bff5so69581cf.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 14:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787953868; cv=none;
        d=google.com; s=arc-20260327;
        b=gTB8lsaQ+F/E5Hvpu2s32FNV06t4AySh2tzVmDh5nGAHgsVdsc+J+CLyjsvTmguxxQ
         EWNjiKx3eYd8mGzdW9RdE0DX/78ZmpZ5HtIkz3ty/30HnjYXAPSNsq31fZhoJZtCvbzH
         WjzwiQoMjaJ7VCbucB/wVrNxifed+GHHGcFYXTA9zYvX85kVBXIqUgs8lnL5Da0Ypq24
         +cMmtsIjmF1ITtZEQrH+0QRwImz4EnnBVw3sub1HrPUg+GRvqKzuOFZquUHISDHoXcXK
         ZTw8ZlgRzfKyW6VCnecbB70jGqmwQAGIe476OZVZaYUWDnjpIv8Itq4k9seiibnJIWrf
         RHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9OK73M8dTXU4RsAbZMeY1j1qUUYmedkbx17xriTUJOs=;
        fh=PzmZGGNBRM6Kd8uRJVHFAbiiwyqdtLJElgczJBxE/V8=;
        b=OvMFVWFJeQlP2NZ8Sh6j65aLJgluUS0+3Uc1uCZUCkSwCBwz4pFAJyqMfFnCOB9in8
         vDlrNLT+DTctRolJcpFnfVuGa/PX3AKR/MBQIXhBsgGRD5Zgy5ItFWSG1L0Fu559bNPL
         yMquzgCJF4VylRFEia77gPXsTwxXwbPBAw2+kGy06hvb0wcYpM8+KvEOA505uDptZgBc
         zWHw2Hs53EFAQhqcZUVhbYVFWFqIFf9C0j/0KNnjrs/xm95hwKwDEi5e8BY+Guq2Q7s3
         h6RY+W2GbnhOSsyX2OtWJX3ODC9v6Svx1C9iFoGIsMWIArsQVvX6sIotRxH69ldqT8wD
         d3mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787953868; x=1788558668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9OK73M8dTXU4RsAbZMeY1j1qUUYmedkbx17xriTUJOs=;
        b=nhKOVPVlHx3BL3zTJSE38tj1HxbGb9p/Dd/ezT5gohNcrlV4+MewHI4HjyFjtULxTK
         KUd073gbcfGu3nX/a2NSojjM7jK1fxrta3py/ebC0mVuP6oaNc17uAgIHGvwvePPq87D
         SShO8vGriWlJ9ZFo2W0PTLSKTWeDEha9jLkbvHIpWyYsGBXU9XBFPwaBAiPZbrTOGdJl
         YGpVRcrUVg/iAsL7HmF0RL/ONdS7y+5X2OxHbuB97TTqQTFCmKpEYStDmLVm2yjZqEvn
         UBwLIAAt+hIhj9YMl6J/e4f91bdeGqdHJV0VBzYP1LEHiFzJCrxlVNa7diWHw3aQCywb
         tEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787953868; x=1788558668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OK73M8dTXU4RsAbZMeY1j1qUUYmedkbx17xriTUJOs=;
        b=N/TjiSgR3bSada6mID2G4eJ3T+/jzbNKvOgmbIjpQFnt5kp/QHMyK7UNxg7CRq7HTG
         NxhI5dpx0D4YPy41iZJJPWqFEKVTNVUv9R2XZ4G/iVKtCb2goLWyPAMWQRX5VyEW6dSu
         6xP630DRnakAMkOU53hvWh50xiycaFSipK4eOOJ8o9QU7sNjuXgcpwFPsT/BZ1/704GM
         9Tp3JV/jcTajATAWAmv39xGaRpy75PYeAm1v5qBOTylUSB3o5MNJtpJpJZMYmqop9XLK
         5aa7HFAX5xVTd6zr55Fb3y0vd+Gh4WW3/09ycLn56v8OQU7DhBp/qzGEXlKwzKCY7YrU
         Rw9g==
X-Forwarded-Encrypted: i=1; AHgh+RpUwP8jJHAHly74czlGBKLxsyMzuMn7iNftTjdrejTUokl8GnY78LICYyOP3X4uOyhbtT4=@vger.kernel.org
X-Gm-Message-State: AFuF++k8vWrqpZ65eeo6LThzOaQJ2LyHp9nJGEsYJXIrJug0VQ3s4IlV
	gLTpQ0xsvPrCMXmj6EDTQ+HskSeBKAywUjY56CYGRC1FdYZ3cGrOaVLWAR/9Hg1ObRQUaqFIH8P
	0bKaqFjrrJiWttYAdR8NvtOXKSHeRUhv9sJM7Scp7
X-Gm-Gg: AR+sD12L4lvTv1d60QIwxVLJDCNP5cztvpDqG/DzsBTxgfmYiWHx7crJHeh4wVxlos2
	T9CmYtsB/e6poWcFjHcZr09Pj+Go89hD7zl7X+e2Yjcp7ma7c1iFJWaE5Yr0FUOvFPjbrGTvTUK
	uydThR0XSEIGyK04leSa6Y4oF3p6VARuFYa14cUcNqPegogLkcXqbuZs4ZLPCXvaipx5bcsJid1
	UWBJxECCFnImEZLVVkP1lgqpB8/xi2aMjkaQ6gOW+044S8oWvx6sZUUNnY7L0EC9zym8zk1ZC2v
	6vDoa0yj8EqZR0Hcf4LEm14G3seYOoO4u673U0HyRVvNDqoL2OIBxKaQeGiG9tAoOt/8VDisvEs
	=
X-Received: by 2002:a05:622a:c18:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-52ff715be0cmr4613111cf.11.1787953867807; Fri, 28 Aug 2026
 14:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-7-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-7-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 14:50:56 -0700
X-Gm-Features: AcwNN1WH8NGHkZoUiv8RzQRpWDdLlBSrkCbScz0MXSyRTt5NyzGO5osqGDfsOxU
Message-ID: <CAGtprH_6-KDfDbtZCq+F+2_Qzu7+Wkc_2ukJRniWTgVkNvyVqA@mail.gmail.com>
Subject: Re: [PATCH v9 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, sohil.mehta@intel.com, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:09=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Use control page helpers for allocating and freeing TD control structures=
,
> such that these operations can work for Dynamic PAMT.
>
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So the kernel must ensure PAMT backing is installe=
d
> for any 4KB page being gifted to the TDX module, and must tear down the
> backing when all associated gifted pages are reclaimed.
>
> TD scoped control pages (TDR, TDCS) and vCPU scoped control pages (TDVPR,
> TDCX) are all handed to the TDX module at 4KB page size and are therefore
> subject to this requirement. Replace the raw alloc_page()/__free_page()
> calls for these pages with tdx_alloc/free_control_page().
>
> Switching between special Dynamic PAMT operations or normal page
> alloc/free operations is handled internally in
> tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around the=
se
> calls. Just call them unconditionally. Similarly, drop the NULL checks
> before freeing, as tdx_free_control_page() handles NULL internally.
>
> No functional change intended when Dynamic PAMT is not in use.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [sean: handle alloc+free+reclaim in one patch]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [rick: enhance log, reviewing, rebase, with help from AI tooling]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>
> Acked-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
