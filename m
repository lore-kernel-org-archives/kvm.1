Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5142E7374
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545883; cv=pass; b=TM9sWB0rijX0V4YXM0ReceeqLQUP6B9512SVcsbILffDh6WknOZwRXqI9UEuPyztP4e8FIujBrqc7FWbi814ErET3pkINTeCOBs8ZI3BcXDrlBkEqFHtkZZB3Q75HDHSbLt/x0Pq/QYaZrIGsKFSmoo8oqbr9BgqkfKkbgnPa/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545883; c=relaxed/simple;
	bh=lDrrfYFJVFsRx3CQk+VqGrwI811c1k/XuP3xOOBmtnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/RCytXaceXnOMc8JbcxUSXqngaJgfoQBBprCd1awjVAXOBIDewydrM/aDyAT5khdFsJ/RFl0Eki8Eq5AB545YbMb2ALQIi/3jDTXFEpTSpB/s6MJS7df/rwCoHyZ33Wg0QeXTtO7BEdUQugERp8KCBkh7zCNFLHan5x7TN0gZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Av57DHdy; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Av57DHdy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177d1ff061so26491cf.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781545881; cv=none;
        d=google.com; s=arc-20240605;
        b=HejTBGWh/Aoc9+haY5LptNdk8RJjxwTkLyfyxYm4mxUjkCnsyIBIBlolQUKYR52YHs
         jmrQW+R5iF/S3PhOea+bTfEcAmvmomHAcWPI8+08LL0MS3ZClL1n1in0wofvnyp+f1sx
         wVb4tjZTHYDpst1qo7IW7kWdfAaJs1ma1b31m0ZYAi5iNa1hjIwy6j3890OI9pyBSzVn
         PdquHkufNm1m+njod4egYIH/Zrzd+yuM/xAvOG5MTVUFsxBolxRsYo/ccoLdMhXe7cbX
         7k+VTLmtoxza+RchhVxfdCztmGFDejhPIpUbF/yJWCuPlpYWE12AiS3sdFjObiq+Q4eZ
         pYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IDvCdrY2Qfp0u0zoKZ+kzNoizLgu000mrgb5u+GdvOM=;
        fh=8FE3jRkAWpflqiyMhnNWDjA8MRf8BHWgcn5BH71pqfM=;
        b=ASzMSI5j3/pROHW7hTjhkmRg193xC+NizXqidXjOaplx1F0Vh+MpReD/nCaP9g9Ktx
         esX0ewJHghceFhffDBygIpVI+PktorCPOX5KGeYPh/Irhj9mpJKobfkXE2/qCFPdwNkW
         o+2Tm/SjAOGYpI3aAtAPrH10QOhzRZcrhvcfO8vAvdEoqJoyqvLySc3bxk/EAhb6CmNP
         IryfpqkFqJKUhBKrEVUoN+B7todKVMrWhfMM4Yt5B4lC/F37+BPVeFctiPR60sb+7rmT
         isnzJbcXI8XjxfLMTyIRpm6CMCeqvzw6385M/agVAZFC1hMOzLTglxvYTbiAdPjE8ByJ
         oirA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781545881; x=1782150681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDvCdrY2Qfp0u0zoKZ+kzNoizLgu000mrgb5u+GdvOM=;
        b=Av57DHdysKJw3IEAOYSmj/Bm8iho+H5TiAywS1X3kxXUn4BcaGeVhLqnvZpSH3OZ9Q
         VOiavahp1ZMEOKf3+k2xAYGqlTjzB25Qsrdvsj9gxx7qUPu7grbKPSecdEbGl1YtP1Jc
         aVzmap0WaFSc0iDlHgMzd/RfaSIvyesBb+5h/ZJNl47x0icxeudluP6wxl0QKt/LkKcm
         NegZRvJH1ErWXZdr9DSRvUyHL4P4Nz6azQrUnYChRrMc0zRQDptd5dV7fWy4hZme5DCf
         bCzoAMQFA5/5ULLyYrHms0DJR1bHi4sbB5HKW5czyN6PEHpjFxx3lzx0CVXsi+iGpP4v
         h2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545881; x=1782150681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDvCdrY2Qfp0u0zoKZ+kzNoizLgu000mrgb5u+GdvOM=;
        b=VjP6FeoV+62bALe7ukc8K4Elq49HXI3cG92D1K+lRdNlS8oTwwFpcankpHHAjiIjiM
         3J2U8QXmgS5hbizn/34wjL2F6InctjCA1uRmsGfIPI4FwuWkZanNChiLjhOYNi2iFGCr
         9zDRgVfh6Qlz1M56qu7BvlM6418iWCSmSfHek+49RUb9rEgXl6A4xYeHZ1gjJjhRyb68
         IXU53SgwpV7trmW+v7XseCRp9LDj0trA6hBuNmdW/yq4/5SaNvPyjY6WpiUH8Y/SGuAs
         QgGHIfWt+O9t9YwBX4L2dNQK2UCfYIJ8VKD03/iU27uvDYgVjDlEPJOBV2lTgbwr/tkm
         Wh3w==
X-Forwarded-Encrypted: i=1; AFNElJ/dHlwmBdbb3CMdu2RbLbEGdi7fd/W3pRKHzzadK1f3lcxAjN5DL3hBefgr/BT4RCEG3zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYieyXefu7hlMQbTjF0+NHWK7UDORUisVDqgTbGzK5rNzD3aBj
	2Dm4YaZSHyK8zaSUwXp+fuuxHguXfo5koPfcqcJhJoJzSZDtSnvRnMLBEBI7Lq41YDz0JNsusfy
	d8TJsjuXNApDi7ZynfyfMPrtHvUcAqlGTood4FB2B
X-Gm-Gg: Acq92OE+PdphUnOk9aG+huEBosz9gPeLQFqmantjioqUI1XV/gjzqX5zFIynMci9L0f
	T35kAqxb5fEkH85ZdjPYIdG2uk/yUyC4PuYJTfn14kkjFn9g/eGqK6nbfmK6HyRLTDIO/vWNtFp
	BgeH2MzCbECBGloJMNI+P3HThWhiLXYQIG/tKDDkTMuf3upMOOyGszvMJtaNI26/fYNAeRY/V/u
	4qkETy+PeZPeumTFNBXSc6Ag1l50REFzA6rrJiUvt4VCDms3+uekj416m3kbgUdYUiChcy+Rkrb
	f9fBh3g=
X-Received: by 2002:a05:622a:581a:b0:516:4f62:85e7 with SMTP id
 d75a77b69052e-5199046e87amr595701cf.18.1781545880577; Mon, 15 Jun 2026
 10:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-3-seanjc@google.com>
In-Reply-To: <20260612230113.684301-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 10:51:05 -0700
X-Gm-Features: AVVi8Cdxr6MRoMEcl88BtBI9-Cvy0XauC2lgToQZLFddjWDjejNHdJuFrnPO1AU
Message-ID: <CALMp9eTZ+bLR+7AG_+XckZUSoXHrRn=NEBh_Z=VKMLSJA23GNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] KVM: x86: Prioritize DR7.GD #DB over #GP due to
 illegal DR6/7 value
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:01=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When emulating a MOV DR, specifically a write to DR6 or DR7, treat a #DB
> due to DR7.GD (General Detect) as higher priority than a #GP due to an
> illegal value.  While neither Intel's SDM nor AMD's APM says anything
> about the relative priority, empirical testing on Intel and AMD shows tha=
t
> the #DB has higher priority.  And for VMX, where the instruction intercep=
t
> has priority over *all* exceptions, KVM already treats the #DB as having
> higher priority.
>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr regi=
sters")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
