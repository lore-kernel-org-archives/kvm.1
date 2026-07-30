Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FC372070
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393664; cv=pass; b=AmBNyWpBr+cc/nXCreYGo4nhaEm0b5NzLWeS4kpttvDhX+qVtuGaMspA+oLT7GuydGt5U6m+oWDfb0+sxCBIRNgVSm6nHdcl2bGmo58A7VDCmcnre3mPDYUn2mxqwycFnqDf8RXmpvJr/8hIhVH1DN5UMsUNBSK4Ywe9ZgzXK1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393664; c=relaxed/simple;
	bh=KVc4w40Uma0FaFG+WIZt0WqsEIGgGdlxSVnGRb/4478=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZOHicvOjj+LCInejtHiuvmwWOjeksVXlrCZKI8GZMDkleNUytqOU1FcAB8JBxA0mNjzBc1FGNlpln7lTkb0U3hrPB2AsXss7siZbMDjExC3pxb+MSmZICDT/IAHTLGE9GFHsiwD25nWUrtPYtLhguxxijTz1VYwPkw07CLOGD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=cI16V+Qt; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="cI16V+Qt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1586252f8f.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785393661; cv=none;
        d=google.com; s=arc-20260327;
        b=XnYFffDrIOlFcq6B9cRQfbZNo7f9KZK4RvcLNSRokYjPr6yOsDiamLKUCkEfiYcrgb
         +Y2GMkR8tJCqUa5BoTp0KrenQsINVP+5SQdm5g5XrZYXyQXkwqp4QU1iHUaJqWOYV1AF
         rtel2qXoY7Rps0D88uWtTZxtaqIDiVq7utZ7NOArUB3F5Ad3eSv0aAzy8i0T0AgnNOdL
         oW6aIiz4TZn6aQo/XI/n5700Jj+ltDKAmufafoD/w4w+7XYUza9PL2ivmAEH9yLoDJ2z
         BSVUFR8H1uBeAp2kCjr/dhuCNfLp+us2OMaKPZAVXzleuHHi++vzEBBzsAgLg0Ork4sg
         sVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gCSg4A13UG+ezvuOT5T/4OdsBnQnd/Owb7FoNwTVWMw=;
        fh=FIZKAHJHSqAcTAsmmirdkL8RBgbJSj4yW4KV765XQYQ=;
        b=D/fZ/yAy+g8sf8ZFYaFL4JcQw0WUuWWeEp8wbrRN5azhx6aweGAiOSR4bbbsobBIt/
         uHXoV8RlaqCY1HgAwyH1b0V2tKgkNlXngvbG4h88YO+GfmD8svZl2PdowhbYMvInw+jA
         olZMk/I4FR45OuPQKefgM4acR8v9P0lSK1dRlIYYW7+CalSahbLxuMT1nPbL1wRhcf3R
         xqnw6eexdI7BSRUfdmGizrhA617IGiUZ5Mr5AfeDmpGENoKhsMu87I8hCR7v+6wCaoH4
         sKofWtU6GSvPUsHDPq9MY5CvgKBnmx/KZXiaLQynDe/+msj3WF5xc+W8Xzdtj3U9NFZL
         Zv8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785393661; x=1785998461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gCSg4A13UG+ezvuOT5T/4OdsBnQnd/Owb7FoNwTVWMw=;
        b=cI16V+Qtk9Jz3CoDjFi8rO8s++9BSPuVwhdYoyHR+WOt/YNnHxgVQX809NhV29o5et
         Y3Xe5lBsqxggMy47HVq1k00fKH6uqxz8/4hc71RNusYqZcsUUBzITQwchBUGxMXeM9uj
         5/EHMejBXxek2GY79ToNz0ua3THzsnvfGTod0iGuY7K6XySrK6MBsUTT7M1/CERf8CrN
         F1UVMmq+cTW/PPytIHyAvPQXn6kw80c7XNMsitXDy15oi3OXS3tnmixczbz+Z/uL7Pz7
         hXpEaRiX/OgPU8JkgsNJHN+6COIWKUJ2eT97oF+iSu/Fx5Cphc8gE3VS2SV/vylZsRNi
         JP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393661; x=1785998461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCSg4A13UG+ezvuOT5T/4OdsBnQnd/Owb7FoNwTVWMw=;
        b=aPQrcTKIree00VT9LTDeB+/lvG2NPm9SsVOVqj4pWovNn24173aIwZu/4Ba1teRXaP
         6XViOskIWZRov6regaMdom9Zjdkm3TAzDa8bMHNO9UkquqOlG4NfRqQMrT5aFD/zTGZ8
         V7wNLrl0WWXheZfKCcsXob5x9Nfr2mqc+/zpGMsnMZK2pQsyr+yUy6vaDx2HKpbiZvQY
         dWpGjjrbkdAaJ2Y7hxQ0I5CXJ1sOJhrJYNo+5rZtZbXecdesKkVTE5fWVdGrUiGSbeKM
         yxHiIH/CfPeMJtHvhtLSHrTBYO2jOoVCtPivI0J+/cUAPJ4KZKLHybCuHNdalnfNWDh+
         9YcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqc6D9z+oDKi8gqLsVk55FJUlgFTTmkRj/FeJIx3i+gYfQr5CJCxNYGAuyVD4OSY4i2c+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJFWVZftacuqB5oudLtRJEuHEaa8xayuiSryT/EtkehsIYnA+
	GkYo3faLbw7CBrv7WaamgDGblCtaQZ0YQZoHO0mR58lEiylCmSgBq9BHQEdMjJqPCCTKoNPYMvk
	IoQOyoAY0IFXTu3SGxkU+PnUpdsjFc1JLSSRJr1VYaQ==
X-Gm-Gg: AR+sD10MT+CQH4nqV49XHD7jrb0jO4OFtgjFo8tykhXKe67NWOuXbkFqr5/F5vTehXe
	EAPF3kMbczXub/GxCGLs/l6xJGAIVlzAWgl9YjlLkkC09vEnCgDpAS4BSkaPIi+MneKr+zpzzQO
	vJITHzIL71wHixuH3fdqUZfrBiPhKHuw5adt7NHCX69S9mtKcWJ5SFyxJFmeVZQMlV2EFO8Y8ig
	pM+yVvU56hsTOCXqf4NA0Q51l01z2bEtxoxnHtHCW50zWvrByF+lrUHPlZafstzozKlgoiO3let
	ppvKTTwU2OLZkZcAwCbsa/c6XEBueZ9aoNw5Sk01qQTD8wSiEk6iWsZtRA515PTfI2rQGbBoi+o
	MoFBqWKXC5gqgm5OAjLuYhLhq3hHdWB7/YXx0FOgOr/E6DPrEfCOpvyqJmV76AIU=
X-Received: by 2002:a5d:64e4:0:b0:47f:81fe:12fb with SMTP id
 ffacd0b85a97d-47fc82029fbmr1441430f8f.47.1785393660872; Wed, 29 Jul 2026
 23:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729232527.139183-1-inochiama@gmail.com>
In-Reply-To: <20260729232527.139183-1-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Jul 2026 12:10:49 +0530
X-Gm-Features: AUfX_mx-1OMiSrp_cztB7RBUzQgECxkWV-SuPzBeqXIqONCE7eUdTY36tN80PSc
Message-ID: <CAAhSdy3W5LQ_iKLgb6qLNSswgh1OOjgjyAizHZ751=yq7UQTkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] RISC-V: KVM: Cleanup SBI extension status when disable
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:55=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> KVM SBI FWFT extension has multiple internal state can be programmed
> by the userspace. However, when the FWFT feature or the FWFT extension
> is disabled, the internal state will be kept as it is, which may cause
> some side effect for the vCPU, cleanup these state when a SBI extension
> or FWFT feature is disabled.
>
> Change from v2:
> - https://lore.kernel.org/kvm/20260706021154.210289-1-inochiama@gmail.com
> patch 1, 2:
> 1. Apply Anup's tag.
> patch 3:
> 1. Remove the csr_dirty set.
> patch 4:
> 1. Add a new patch that sets the csr_dirty for FWFT extension.
>
> Change from v1:
> - https://lore.kernel.org/kvm/20260701094731.1022163-1-inochiama@gmail.co=
m
> patch 2:
> 1. Check support callback existed before using it.
>
> Inochi Amaoto (4):
>   RISC-V: KVM: Add SBI extension validate callback
>   RISC-V: KVM: Add SBI FWFT validation support
>   RISC-V: KVM: Reset the SBI extension when disable it
>   RISC-V: KVM: Mark the reset callback of FWFT extension always dirties
>     CSR
>
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++++
>  arch/riscv/kvm/vcpu_config.c          |  2 ++
>  arch/riscv/kvm/vcpu_sbi.c             | 30 +++++++++++++++++++++++++++
>  arch/riscv/kvm/vcpu_sbi_fwft.c        | 27 ++++++++++++++++++++++++
>  4 files changed, 63 insertions(+)
>
> --
> 2.55.0
>

Queued this series for Linux-7.3

Thanks,
Anup
