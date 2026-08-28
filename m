Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFA37F30A
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946655; cv=pass; b=uI7fULvnm0KryX/Y5zrfb+s/jKLB1f/Y8EuCNTEpJHwdWEgY69akLYFY+QaWjWx9P1m/YviRu+AxcHBPYWwFY/USbIwGv+WZsYsh3SZ6R8W/IZVgPn2OfFk0Btc7HdZ+QRr/QZm0tGYjB8r4xkVOSz27AX7X9o8BELUe5TXj+1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946655; c=relaxed/simple;
	bh=V6Nh/imCu2DksXoUrx1x6JfWGC3imxXsFDlVlCThN9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8IL97TL2RLsapXhYwUPFJ+M1jEO6enjMQ+gA2oX53k5Ksu3QmI7ZjG9q4vLZBy2aeL29F1/qkaUCsXB3dKtNCxbnSF9yQ6/0l0aFcPr8/h3pxpvNCUZ0SyJQqopViVghTYDHUgx1PgaFrWTRGNjShI/IaQocfPAHfeVa7F14RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckaTpbj+; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckaTpbj+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10e86e52so5071cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 12:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787946652; cv=none;
        d=google.com; s=arc-20260327;
        b=QAwfgqsHyjOsyqzcGbLZmjFalL8fTlvRFFd13ko1Kghf/kSYS0/vG2kukRtma5bFNC
         Y8CnlrLnOQf58x+zWkyPSlOruxonzNBJq9kQkrgi7nEBYVI06LWhsLBRGEir+/W/MWPY
         VR/dHNSbQOk8vWL936Qus5ev0+P/YKwtPFmMiTcdAlDq4VXzbf5X9zx2qdq/j5M7zRCe
         a8p8i7vMcJJ310F5T2PquBHrNe+uqwMXsePSIxPf7ZaC1O1tJolwdKoSwU9tMl4XiYLX
         kE+dWJNDfHxIHCp1h0cexQQJXeFqaulws5OLHqHTtu8c8UBAR0VrjB/pDOP2GMW0RJRT
         amGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6Nh/imCu2DksXoUrx1x6JfWGC3imxXsFDlVlCThN9Q=;
        fh=VC17viYnPS2gwSeE0M+4PDN5/4arPJIK0PZGwSijCwg=;
        b=oOoI9nN8zRAnKblfudOS+uf0txqaaokYz53b6GvcX6Qd+S2ch31pBAolD5mYZFPvva
         XmcspbEEMPFS/XKiIdgyDttNU2b4a021FbVaw1MD5Zh4joiS+wNW2SRx76ncIQxsiiu0
         Mb0b0CjGfb98+qTrlRLdeQEoQ6yUz2wyszn/Kth26N6v2CjpQh9oI1FO0GJMjen3J1Ot
         AUnDj9GFVtTy7Jatidag1gwm2FyDBwvlvWDdfupnGlmuC8HLHxAd7BJZEa4Mc3qSvBrn
         1laRLN8Yz26o1CPnz5ChCYZU1oe0DSafEpcpVGm+OHR9sc2sm0eUONn5RpI7FsPaJbxy
         6WzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787946652; x=1788551452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V6Nh/imCu2DksXoUrx1x6JfWGC3imxXsFDlVlCThN9Q=;
        b=ckaTpbj+NxSM3jGyluFreV9L6TYg1sWUEFlLuxYQcxwyjbeo1xHw1XgmkjHFuBQnZu
         eeClPLkF3Eq3aYM48Pu5khSiKEdW3XhU59DuZpuRPa3q6qhZBNAaNb7Ih0sAw36tSqas
         F9c/XtGkNpLfTT/CH5NRP/svCTt3P3P54D24lGunh2vL+FPYtjWHtfeW7LxSEEN4yPcn
         z/Q/2SxZ06LiEYsawxRJtqPvum81kl5uVfe/t8zkOkJptbzidzimBItbJivDt0CaLZjf
         yrQRQ8gv4OnHpvnFfo8m8E53IcPOUOy4tDX7XXKBPGTjCG4sJrQ9k/46r1KnPEv05gPa
         42Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787946652; x=1788551452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6Nh/imCu2DksXoUrx1x6JfWGC3imxXsFDlVlCThN9Q=;
        b=Cuqu3z1tjfHEpNTec5LOMsQsuxun4kC9ef9eAWygLv9+z+o/OeoLc0ApmzEdbXI3IK
         xhm286cGlGYJWMPVJ1dB8pglwoxrq/+tJFgnuHHZGdLPCmfPLrQ/ojrySobtdhyntTiH
         pR06+XJtE0FHkd8tEjYQqtRH7DZLq6yGGKbcXq4332QbTXCD2bvbWCchLlgznUe/ee0f
         1BUAP2QuieLzpjS9sAIzxbob5OrjTY1FPDzvNG+znEUaeZG4+StUfAA3HZGpleFOIv0T
         1NxKTFwebYe+Y2f4PfDyTqVunX1KxWvU31MZZ1flasPgkAlgF513RnzHi1lgA9jPkZTr
         DhvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNx5dIU9Q+WJSSsgpN5c++TIoeHpt2hl67Vt2nmwhlstPQo7mOvxxwGct58QmxfzpHBWg=@vger.kernel.org
X-Gm-Message-State: AFuF++lt5to/zfn3/c0ldi8DqTmMvXXUVl0LgxaZv6Ww4tkXBb8uKXsa
	RreS8hdY5kyDM7Q6SlYn0HDnWHlMjE55vZlHZus5C+FKSHJPNh7eVItQ8ssFEftEh0p9SegyWvw
	hvFRTVUXantGvV3oSfLonrmvDk8V2fKTGjrgiIrWJ
X-Gm-Gg: AR+sD13aO85DgKGM3K6s9JiPN8jrQQETlJNp5ZUwBbHjspofr07FOjis5H+eowRHOUP
	ZVFoI99ajgzI/MGXYwocs18JOmut2FVhXGTkxvGKN6VAaOwwB5v54toD3+gXBXWw72tdTp8dc16
	Ii4RTP00B6vZHyDpZEehj/LBWrRo3GomxIuXvsupHkWxedawHTNkjOmfpDUOfHtsJ8u1zeDHmqv
	EXaSTw9erw7sEKh13t9L55oeT/CUqJiUd6WktvlISkvOf3+Ye+x9tjDabEdaCTe5r1xGXu4RCir
	o390joAHzTMJ52mxG1y6Keo+e1MwlH9lSoqmwllGbV+LXK5KUT/hyV+ttyDbpay/e7DHZ2VHiKo
	=
X-Received: by 2002:ac8:7f51:0:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52ff715f969mr2184691cf.7.1787946651120; Fri, 28 Aug 2026
 12:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-4-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-4-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 12:50:40 -0700
X-Gm-Features: AcwNN1UGA8VSxLqG_WtYxcyIroEJNe3FATQouEdY6s-KcMOngGCRN2JEgv1FXj0
Message-ID: <CAGtprH9ERb_fFG-4JYR1Bjxyyvnk3Ys4q=9ioQz0Cq6QCXtVBw@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page() helpers
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
> Add helpers to use when allocating or preparing pages that are handed to
> the TDX module for use as control/S-EPT pages, and thus need Dynamic PAMT
> adjustments.
>
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically.
>
> KVM will need to hand pages to the TDX module that it will use at 4KB
> granularity. So these pages will need Dynamic PAMT backing added before
> they are used by the TDX module, and removed afterwards.
>
> Add tdx_alloc_control_page() and tdx_free_control_page() to handle both
> page allocation and Dynamic PAMT installation. Make them behave like
> normal alloc/free functions where allocation can fail in the case of no
> memory, but free (with any necessary Dynamic PAMT release) always
> succeeds. Do this so they can support the existing TDX flows that require
> teardowns to succeed.
>
> Also create tdx_pamt_get/put() to handle installing Dynamic PAMT 4KB
> backing for pages that are already allocated (such as KVM's use of S-EPT
> page tables or guest private memory). Have them take a pfn instead of a
> struct page, as future changes will want to use these helpers for guest
> pages which are tracked by PFN.
>
> Don't CLFLUSH the Dynamic PAMT pages handed to the TDX module, as is done
> for some other SEAMCALLs, as the TDX docs specify that this is only
> needed on "TD private memory or TD control structure page".
>
> Since these allocations will be easily user triggerable, account the
> memory.
>
> Only one pair of Dynamic PAMT pages is required for each 2MB-aligned
> physical region, so multiple callers could trip over each other if they
> try to manage the shared backing for two separate 4KB pages contained in
> one. To build the logic up iteratively, don't do anything to handle pages
> from the same 2MB region yet. Functionality to handle this will be added
> before Dynamic PAMT can be enabled.
>
> AI was used under supervision to collect/apply feedback, split patches,
> review code and workshop logs.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com> for the
SEAMCALLs and the get/put helpers, assuming your are still thinking to
shift things a bit between the current and the next patch.
