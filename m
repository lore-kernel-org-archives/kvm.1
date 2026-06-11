Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B44D2EC5
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203645; cv=pass; b=AybmfQsIhXwtMMGzB91R4p5P/gLVTgplmmUQtTMz63eFE5AQuIXqXcvLOowAV1IR6GXOVtZxgk0aiBE6d4HS3S5xvQeSkoQn28H0RjVxjIvbQB76S8gsCtNi34IAQhM20jSe5YsVTdzFFKPfQSzCPiKpsSKXvgW8y0Xd3PiLiNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203645; c=relaxed/simple;
	bh=MrFHJAtiz3l/SoMxwQsRd+iR3vzlfSRyOn6rVwZE7gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFG3YQe8b+uZXU6fggMKALy5Dn2ZPRxpGyMsW3ZkmilV42tcq8OiPvhJ21FF/IXJe5rRFi308dmgXZn9vAV7F04mzZyBwnOp5jpTm1rg8lL3FGBT6ApslG1vMue8KchmOy3PPXP0luEKji/rE45S0O4PkZVL31jgigN3NcTVdIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlOyrWWX; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlOyrWWX"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177d1ff061so68481cf.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 11:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781203642; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZ1ykEIO39SOiqP3etoiOGMUAU7IRS3YXGUuTfPzmROAg949S7e5vug35hIlNMoTSr
         gJtPVzXeczbj/joZ73Qfi/6usIv1khy+jwo3Zymg0jsSRMijk1POONQsYBah2SQDubgd
         OTscUaWNL7kWxHkKnFwppqL8yz1P8XWaJWuGTcJobzZtMvkoFrxFunGXWYtQT7zsydzo
         pWv2P2Xwe9vR9BBdIOAQU9iu8kG3zsh+1jQ5i3c9zx96oKxxfOZrvI5OiO4zexHUiT3R
         hB+mTFJsO3SkNfSzDiTo2xk8D4EOUDpq8j5HCeQKo4kBtZwEwta+SlGFPkyiT9aTzaE3
         wISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MrFHJAtiz3l/SoMxwQsRd+iR3vzlfSRyOn6rVwZE7gw=;
        fh=fvVkHhxTUX56/oTOHS8rbCCCWqnYME7wAGVGOh/bCzA=;
        b=d6cv6sYYNX93RirumbKMWymktogivQnaK+ETYYcFGafASX7PeTUza4xAa50lXBBoO/
         x2OJiYu/F8i49WiSTwnYK5ZYnApxBxL8ZK9vjhXNTZhvrXFR0Iv9jP4eGuryRZecWFMV
         0hTnOO5Nbv+T1+C2j2H/63O8S4SHyWS+q8aSzn5A3zmf3irnZWf+5T4QQOSwIJ2X6YZ6
         fRpue63ZiozVeaqx+XIJer80fW647/InCR4DLgZlF4kFWtDP8vfW61TRBH0XnWRh911+
         IKRKHJ6Sd6eIo6NLeeS6ijA7vO9R3I0XvVB0NcU4RIHJHy5i09URJPwgQsWS5Ld11fRT
         ERnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781203642; x=1781808442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrFHJAtiz3l/SoMxwQsRd+iR3vzlfSRyOn6rVwZE7gw=;
        b=GlOyrWWXyljN57w0qcrCOHSnEEGulh0DSdQKHSXkgJMO18VmFRkrb33ghtMLuUR6h4
         KaaR//NRqeu1LIQWvgvTFx76WEHDAXx50Dp74g0WlagMa1KG0TOd3ZnvohTemqpTQnky
         X2WuLNAUN/WnMlaxn+DdQBUU0PpYoD1T85N40ObuQih5PIhPJL0e0RgrG51TBYS+fPi0
         rBeRa4cEUQy2rw9CwjehyYGysbvN3jNeK7yZaRR16J5UqIynngIpS7v+WhXhhvNMT2kL
         ZRFomvexRap8ulrCfL6u8ZZKSXXVH4GeL1ZiV79lv7n/t9KtzEvHpzPPkOKMQIkjcX+7
         I2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203642; x=1781808442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MrFHJAtiz3l/SoMxwQsRd+iR3vzlfSRyOn6rVwZE7gw=;
        b=YK+Eoxtm9ODPGjnnF9oYuSbt1ZYWVLggZAflXHMpC4+M60yo6gaCDCx9vpL1NbFQcT
         weNxZZPqva5ICDg38CJIhJJmyGKJbvRjrzSi44Ke3BHe4Oejjp5sBJ0NjB1/7ZTMmW6o
         N8mgUfsztpR8gomD7XEfBPm3x04vPvlxUSwCiVggagk4IHTr8PkHydVunbxcGsbJlJkH
         avyvVLHwlaHH76AHWzcpG+vwV1yNMPLqhk1BOZxKPatdpAtkPQFO3f68eXkajZT/SErs
         uTqY2GTWWr36j6WoBlgb6OpmniawXP325QQKFzXt7GklYzPjehWKvmpz1KqZdEfZPkPq
         BVOA==
X-Forwarded-Encrypted: i=1; AFNElJ9ylZh5RzgzGmQ+ywKfho1Kp6FCVDFnZum/oHiShqWcug+3PaFs0gBQhru4gLw/voS54BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPvySN1uHO4yB0Hgb/J3OWeJBG4I24oePD/PPja3UbZnFjGkU
	J0dTQjT6lJ2L97Z0erFEPrKbF8/bXGlVAC6EARkJlq/WY7owCIVyT3biT8jMg9h8DotrMjkKpiZ
	uURU759+eKL2v6A63gIa+daE0iP91hE9P0/cTVtlc
X-Gm-Gg: Acq92OFMTEAFM2VdvXx4M9uZqLgOuop04Ki1nDpfi0DKhqI7t7qlLJsyi7aWDRannrp
	HHJMa90+UzzOZkZ6HPLpzdeLGwKV/j67BXsQRhzVTNgDu4wOuPnwck/lixwPRMQWcV4x/wkzc+x
	usf2N2fZSLl0DqbRlzQzs9Xyyoj7MKAYb8mLHovXULB1nzLsqp6cEhpSAgsq3ueCwVnO5Sj1MEG
	Mz4673HSI9mBfHDnYtr4Kq5y8rs1LdBU6bDWO7swn6p4ihneH1ijSfc5Uz7og8FIMUZoYshkS2d
	dAOn2RGjY/JnEjHnRVaqtrJ13fqSXC+fnjIbcK22
X-Received: by 2002:ac8:7f96:0:b0:517:38aa:c2b3 with SMTP id
 d75a77b69052e-517fb07577dmr1124901cf.14.1781203641487; Thu, 11 Jun 2026
 11:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com> <20260526023515.288829-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20260526023515.288829-3-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 11 Jun 2026 11:47:09 -0700
X-Gm-Features: AVVi8CfMS_qzgZKmmT0RbAyGSJmggudRfRKARlOu3o-uoZD12JuItpxRuWOmlpo
Message-ID: <CAGtprH-TzqYbwp0_8ah0VJcccOwHnUz11Ve2Fk8Y-zwqqGFMsA@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:35=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> The TDX Physical Address Metadata Table (PAMT) holds data about the
> physical memory used by TDX, and must be allocated by the kernel during
> TDX module initialization.
>
> The exact size of the required PAMT memory is determined by the TDX modul=
e
> and may vary between TDX module versions. Currently it is approximately
> 0.4% of the system memory. This is a significant commitment, especially i=
f
> it is not known upfront whether the machine will run any TDX guests.
>
> Each memory region that the TDX module might use needs three separate PAM=
T
> allocations. One for each supported page size (1GB, 2MB, 4KB). The
> TDX module supports a new feature designed to reduce PAMT overhead called
> Dynamic PAMT. At a high level, Dynamic PAMT still has the 1GB and 2MB
> levels allocated on TDX module initialization, but the 4KB level is
> allocated dynamically during runtime.
>
> However, in the details, Dynamic PAMT still needs some smaller per 4KB
> page scoped data (currently it is 1 bit per page). The TDX module exposes
> the number of bits as a separate piece of metadata than the 4KB static
> allocation for regular PAMT. Although the size is enumerated differently,
> it is handed to the TDX module in the same way the 4KB page size PAMT
> allocation is for regular, non-dynamic PAMT.
>
> Begin to implement Dynamic PAMT in the kernel by reading the bits-per-pag=
e
> needed for Dynamic PAMT. Calculate the size needed for the bitmap,
> and use it instead of the 4KB size determined for normal PAMT, in the cas=
e
> of Dynamic PAMT.
>
> Unlike the existing metadata reading code, this code is not generated by =
a
> script. So adjust the comment to be more generic. Also, start to adopt a
> more normal kernel code style without the tenary statements and if
> conditionals assignments that the auto generated code has.
>
> Assisted-by: Sashiko:claude-opus-4-6
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Kirill's comment make sense to me.

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
