Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE23859EE
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953758; cv=pass; b=riOHIn/ZEvcKT8GUjyg+1/HqSVeeNurgT+8pN/oTBmfxr1Ti5w/L8uree13hVWLWdcXZHlyHZthw5Xb2wZdDZ85K+y4WNxJXM9c2qTpaFdsHv8bZef7Ojwuexn0wyR8SftMZuW9MvdtMNvRut+Zzwes1oOL8coNe1c0/tim5rOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953758; c=relaxed/simple;
	bh=NS7ILyNRDwIZOyOLSfg3QhGucIcgXedbcky3j8j+fgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIBRoUMwhoai8bpdH660mG49hN7PFbRhJmeYatpXIrt+PlvYplkpTaBgILtIJ20ymNd9fV43n65RGkI1J74cHlt+UCJhY3pTgn4D9UEm3uMDh4F34ebRRR7rUwD/Q3YC/9FrGLtd0x3diC4vEtDLJHjTn5n2yPwFWxS9qN3+CHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIt3FcPu; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIt3FcPu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52fac937235so33131cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 14:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787953754; cv=none;
        d=google.com; s=arc-20260327;
        b=bzZOraMpWQVtf1pLq+xfFZhp/ZkY0zv2Y3chxaH9vt2KHnXK3HQqvL1YLunBl94OE8
         B8yVXYEZxNFb9bbrD1LNJLw6CLqHpneLM8abwtBejfHhKPh5ehsYFpWFZx/rR+bhJQsD
         aoBr/KF5OHQqKekHS8IrcI4Fx8/RB48m7LW2VdevpYNrAf5vrljQqC0Z6MUwp528AzPh
         4qMEfQq59dEMyERUXkWkpTC97igMjZXAlwqfHJ5u+Pi9lJmqGk1xlj1XQDwhHZKZ513n
         EAS3yp9INxGgsTMLdNjYjzbmDR4uLcGEkPv/zmLJsZHf4jWfPrsuiCprs0VA/nTcin4A
         H+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NS7ILyNRDwIZOyOLSfg3QhGucIcgXedbcky3j8j+fgE=;
        fh=Kox3h640r0NuHvO2yPMV97GK5ysIrOIW+wwvt0jEzSw=;
        b=T1bRpN6mZniX59HEX8QF49SKJ0Adl0XBgAihOglu75PtUkNv9ZF2zMV/oFBBMagj6v
         ZjkzynxK7pMyU8pQcTDuozH9k0PvAywvCMVLaIBykvtXmjhCnsN/A1SPLH5v1/fqnPDy
         qRlrUF+6FKchz9s+hAfe3JMsPtAWEFsQMWLeiYGuYJ/+J5v4sKtNgkZu9ZYirV0NN+az
         BSldJXeUdrU8kj2rpM78AKnGibSr76rYhRluQOvksY/M+/D6Dw9FbmxEQdnwciFMmcEB
         TCLJYNU3gopoK4FtzLbaQOeKCiGz4hRE5RACJOFvXvNsIDhqM2ep79Q3sKb29fxELl2G
         ge6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787953754; x=1788558554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NS7ILyNRDwIZOyOLSfg3QhGucIcgXedbcky3j8j+fgE=;
        b=IIt3FcPu4gwqfcq0f43QVaw7Dy4mof+meN2gRiV/1YL/6T6vUBCh8TtVKISBYcGVnf
         zIwHvuK6O38b70jcy3+QkDyZJgBVazXbOzxrX2OoA+jly3OM3tXP5DFpl4vPpuaKinLs
         iPEoUV92oh1OIGegntnS/8TELhCiXr0Fx8pp90rbAXE5v2S9Vjx+8QQrC+xrV7IxB4hh
         Mrj7NM8KEv+p95oZ5eAkHq/poNVcTw5curLEsp+YK9dcO75taU++qfXBWM0KGYQoZwXZ
         oAw8wV2Xb4ssZXg2Vu9nFGX8vwbFrHd3Dp+X4gRtr7BHMp6KB+jFbV8LhS2nyd7tw8X6
         wf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787953754; x=1788558554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NS7ILyNRDwIZOyOLSfg3QhGucIcgXedbcky3j8j+fgE=;
        b=PpP7aiAIJy5h8gvq8gdu2gtJ5XDf8Spo+wboTqTwSlnU3cF2q3LnO+a5T0T2V9DtAZ
         0re1YSfdr2FC8HCd6jxZAUZDr161wi/J8NHAsWcOM6DuIvED1fZRB+q91IpcjyCsQ242
         pBybiLm1SmdX4u1luaI0ujt1jrdY9VcyRE8JEDMybIq+8r+D22LGCSuNo3p3vaTAjGm/
         QNTOa62qHkXh1Mn0IQfU8m7hxbAWGtlXVFETOALxA8c4D8d96tnpCiMRX/3ezAG1l2El
         wnX/gDdQzmJq9dyiQfYTm20pbCnGI2N6TCcTPYJ/j+pp4BYKcpSAlhy2etWTdXANKG6C
         QXww==
X-Forwarded-Encrypted: i=1; AHgh+RqCj5OKKI679Qs2flLGzrFX7wYsBPURO2VO/iMqbKaK97M7iHLqTHn+LeQ760W/iC1lL4w=@vger.kernel.org
X-Gm-Message-State: AFuF++mVb3W8beX2JIzsmEYFvDAPfalyJs9TMFJK9wIkO2Vof68jmyDU
	nOawlNcj72GQCk0SZea90ObEtwI7iq3RPC+T5Kc5nJKdVwU9QIxfmB60PAXC2wluXLyChW6udox
	KSxagnXHhMCBKkdlftcyMTL4EuaKt9Xvavhl0dsnd
X-Gm-Gg: AR+sD12KNgkOd1qM1bDwWAaEUxKLLUgv0bHkOpQ0LbnRGiVhGTQKx+PSjYZ+1EXDOcL
	rSXUkZ+PcrMaaKco34Hei6bMjn7CN5RzitPpvK0EMLwPIwLK1QmHXIVa1e/aatNWs2Uv+Esos6f
	MLKDanI57zeKDpLz3W83vV62d5L0RM4sKKwzcimfKHNjs/YySSViuoC1Tm6bAP5V5GPTE9v4UXJ
	MgzTRxYo9UzNj5+xxW2A/tBiKArwzW+y8bf63SylvlT5XD+Zpl9cpxrLa77p2WyURtEPR4OQ5Z+
	lDZ+nxaRCBtdQK0M246RWkjLeoOam0evfD2kbK8YNuxjxsmXjknl6TYCHWAXt4wZ6qzXMUZ4XKI
	=
X-Received: by 2002:a05:622a:598e:b0:52d:7a3c:8396 with SMTP id
 d75a77b69052e-52ff6f30c8emr5308471cf.2.1787953753102; Fri, 28 Aug 2026
 14:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-6-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-6-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 14:49:02 -0700
X-Gm-Features: AcwNN1WQxsNINsmJYKS21-W-S3NINHdKdRHcQQhWHhl_kYf3xtibaEfoC6rNsbM
Message-ID: <CAGtprH8Rax32PfiCk54aY_SUPkpfCKYdK5ZKaWJ5-Y8vtFSPng@mail.gmail.com>
Subject: Re: [PATCH v9 05/11] x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
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
> tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
> backing for the 2MB region covering the passed page. However, multiple
> callers can add or remove 4KB pages that fall within the same 2MB region
> and in that scenario only a single PAMT entry is required.
>
> Make the helpers handle only adding/removing Dynamic PAMT backing when
> required, by refcounting each 2MB range. Gate the actual Dynamic PAMT add
> and remove on refcount transitions (0->1 and 1->0). Serialize the refcoun=
t
> check and SEAMCALL with a global spinlock so the read-decide-act sequence
> is atomic. This also avoids TDX module BUSY errors, as the Dynamic PAMT a=
dd
> and remove SEAMCALLs take internal TDX module locks for the 2MB ranges of
> the specified PFN and the PAMT page pair PFNs. So simultaneous attempts o=
n
> the same 2MB ranges of the PFNs would otherwise encounter an error, which
> would not be handleable in the put case.
>
> The lock is global and heavyweight. Use simple conditional logic to keep
> correctness obvious. This will be optimized in a later change.
>
> The pamt_refcounts[] are atomic_t's. They do not strictly need to be
> because all access is protected by pamt_lock. The overhead of an atomic_t
> in this situation is minuscule compared to the global lock. Leave the
> atomic_t in place to enable future optimization with minimal churn.
>
> AI was used under supervision to collect/apply feedback, split patches,
> review code and workshop logs.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
