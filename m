Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EE534441
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886715; cv=pass; b=J2VJL9AyU0iMGWx0NG6q8MTfsOXVIbs+ghYy5oKxFcHiDDX8WYgN5WVsty8oygCBxtq7TVxFVFh62W1gKnGUOK8g6hsJ1u/uwquYwiAY5F3XnySynhdUbE9RJlUn/u134apttQ/gLhz8PkBTYVpuB3cbLI88OuV/fTdjj5QH+zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886715; c=relaxed/simple;
	bh=ULxa4JRrSAZB5pD9oIq2oZNnuuD6C8U1jqAHoElMSdA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve3FH7YI9dXJiuJ0oNoitej8VZ1PDhCnYZ4YXTeXCgfsVsDhcDkAItHX9HGQ66JGBC81rGQ5A02X9rXUpxcmmVfelJFuA9jbtaIZG9NVBn1HF8gDGrMm+fdOJMfbKQRBC/k2zeNygNwZVUpSIMMdy++jk/9+ISmXpdszjHb2Cgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMz+XpJH; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMz+XpJH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90e7d9c747eso62027566d6.2
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 09:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886702; cv=none;
        d=google.com; s=arc-20260327;
        b=Oe5UuxLiJ+y2TxFTq2os5Eap7MgdQMvZK/TkpiQ17P3q2wqoI8QFSKNmWMd3DSP+KN
         SwjCBrl1XyYrI5pmWy/WStdlkPl3aJM2+CygbxivMcYwmbLj0vH7MacP+bSJZt5xHPcW
         QbaTm1edcRPXJQqU3bAnOI0d48C1ev8Bq9JyW9+zhxmfmX2c6oLNe6Sb1L0P9gG1OB1l
         yx4+Lq3mgdJ5sznLZ0iVpCOtJn2YfrV9I0HU4Qc/6AyJpJTp9NdxLpdc5uKEeRVW6BQU
         Nwil2F3pQdUGVaRaoUUB5cG8rmQyaOA8iL5FtXSFYe0nu6IZ2pM6RDQHk3zgQEdJVNjW
         QwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8fcdr/hrzW8YjLnM5OVm+g395+cNXrG+fCcu71g0lZU=;
        fh=3BXSTPGv9B8MOYh3uvEus94xsh9ixwcfqdKeTKvSM9Y=;
        b=ouKJDicAbe9ezJaHCrAPafEWniAkjYh8LhRP8Z2Ke0llTPatOTNtr67FRRTvNwaJL9
         gTPsgkMek7JsKIe7A3CyQavJD5cc8mr1nZJREF2fID6wHd9pf+FwMW6UVRUhcAXlPaTB
         wG6xJG2xOa5NLKO+Yjfgq8xGwvcTRXhobetmTL8ZVXmt8pIbtWFe+9OiNsG7Taj9Bnn1
         563N3Q4+U4TMljH5Bjr6ha0rXSOTJBWC+QbekSc/xp2GiuW91hKA/rLFUQLB6GljIGF2
         0UVG+lxpQ21RhUSZwIVFtel2adlmGLvVyZgd0TRe4P52LcYHPy04BHZiCxmBelfgeV60
         QNxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788886702; x=1789491502; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fcdr/hrzW8YjLnM5OVm+g395+cNXrG+fCcu71g0lZU=;
        b=eMz+XpJH8AC4z0HU59N10CwiV7jWB2XkXiXfbJIdwPg9pCizkaqKgQ2pA+sDReAkRu
         symxpB9EJaTSk3ubMMpTtNNds1xRV/H1uDJHELk26ThbzxwBw0ZicDxeurCbCsadwFE/
         +tXRzwxQLtqQq83teNHqJZ4nd8xfGB7sLCwT/Ccir7u60wm5o+R8fFsyqG848ZI5pXsJ
         zG8B876bNDs/OPgeecJK/ktGSxXN5IT+eJr7oB4IdTb1tjj6a5sNSTZcgtNJYBCtpJJE
         bvRm8av7+CH9Tdmunx74W7KDnay6nWuFHB2Kidhh8mcdhtEeA5OOQvzbF4JDUEBkAC+3
         pRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886702; x=1789491502;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fcdr/hrzW8YjLnM5OVm+g395+cNXrG+fCcu71g0lZU=;
        b=n8fCHRpe9v+858Z1CA2XQ6+y40ml+nWn/xgma5qIzQGIuKfb6C+QlEqI0EpV12oJmF
         l7VzYAhxjcy4jqdjHAs/iQhILeuFwPb1JsMSX65Co1eL15H8qbPi/OXDgbYVCFjD65Jg
         faD3HFYfgLbfnxt1bJQpYHpjbmCpLJ89ZiwLFVccbH2iLyo1f7TdnJYQfSzrjpvgGdGL
         Plke9vuivFmqnLbOZvXKQtmrkEA3+4ImtXpJo4EtrnscJ2BaN4VHygK0CyqOM06rMMLB
         2p+fMJq/hWuBkdGGmWm+/z8cUPmhSsr4nJ0LS8Jee63xVXRzqzV+k/zMUd+b/Lah/Ahw
         yt3g==
X-Forwarded-Encrypted: i=1; AKwUvBwt0pL5D5okpWmqNK7BGjJRIqQFCvazn2aPfy7BxeCuTi5QLsSb+M7UToXhNnu/KgcIynw=@vger.kernel.org
X-Gm-Message-State: AFuF++mk78eZ+77Z/p0W8frWMxqwj8Ain85oNBX3wWxvCX8iL9enjabA
	dd4d8Co7nFBn7jBoon5L7q6IlcHce1R1g/qNPgH5YZFiNp4rSEttECGwADFrm7w43ZFd+vIeRq6
	hlOqm6LNcLuD65F95pq6J+TW+1t06DFber9eSl3nt
X-Gm-Gg: AYBFou193PRSYOoY3RDw3X/y+EUCCeYN5NKBJyN8+MEBBWuzFadojKA9LcY0DQJGEoD
	rBFajSl/AnY0TJ9ESeFyNcLgrTel0MZvoAYYB4qVncbRMePOKxgfx3F+65Xd4bAQQ1FRt/Cvl9w
	sQqteS7wMvsARSEp/srWeBLQ7OjKQ1L5h+8bQW9CGiXZF8gVISV9GOd7d1egZEaV5zzMVzg5d38
	KfkCbq9fKItS6Un+CkfBcM++miozchdPHJKLdsaOjf3nlb9/oGugUoE9i9ct7Uhlc56RuwudLD4
	9MUTOoXB61qXe2xWqf8xJP1FE2kmmGAuVOLxTNsmr8rbrAzynHeh8AS8m+ryBFZxJBzC6RfFmwz
	NjUutCCV2SyFpnmafN4XYOEVlsONAQug=
X-Received: by 2002:a05:6214:c24:b0:90c:ab32:d9 with SMTP id
 6a1803df08f44-9103ef04cbemr59785766d6.9.1788886701269; Tue, 08 Sep 2026
 09:58:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 09:58:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 09:58:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-1-15ad654a50db@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com> <20260722-tdx-selftests-v14-1-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 09:58:20 -0700
X-Gm-Features: AcwNN1Ul0Nx7jhJwVNNvygXIUovvrGXjOMRCxh0xNG50wROb5Y6Vd7rvg4wlMm4
Message-ID: <CAEvNRgFgE3DFw1=zc65iMy1gNyPryVJuKPMrNF+ssXydtuEazA@mail.gmail.com>
Subject: Re: [PATCH v14 01/22] KVM: selftests: Add macros to simplify creating
 VM shapes for non-default types
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Sean Christopherson <seanjc@google.com>
>
> Add VM_TYPE() and __VM_SHAPE() macros to create a vm_shape structure given
> a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
> shapes for x86's SEV family of VM shapes.  Providing common infrastructure
> will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.
>
> Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().
>
> Opportunistically move the existing VM_SHAPE() (now __VM_SHAPE()) macro
> below the definitions of VM_MODE_DEFAULT so that all of the SHAPE/TYPE
> macros are bundled together.
>
> No functional change intended.
>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
