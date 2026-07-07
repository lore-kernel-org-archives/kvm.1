Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC643C7D7
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448442; cv=none; b=s6kjukJFLI1TcWta+1zvD/ZJsY/S1+pwUfxfYelm+Gf+Zi61k66F4OBjcNwuZlGVuTJ/1uEgIej18O1SWSMcW0aCIW6EEiIAnhIK3ZNp+rDthUE2HHn8/nPpRnpqo/EUwh+Ofp817Kyqef/4wNMZKYdHEYKMxwL4YByZR/gyEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448442; c=relaxed/simple;
	bh=UDasZKmMOBj8tCIrs9cG9hotdvzWxOf/LN+VsZ0dOnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7iPDT+7GojN3MIDbYxmPuoBbt/ifUGVem8+eW6UZi1peiqi3vnQVNR9hg4Y/giT5GscRDyXTpifR1dngj1eKPJrl3+1J8Abgl0i9meWHhRPB6RKduO01c7nZv6vEkDY6ZoLDDbnvs5/pV9NUGOefeBnGifF0ATozG5KOMFiGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHaXee1i; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHaXee1i"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88fc985a65so7527196a12.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783448440; x=1784053240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjWkSahi0jCSNXvLcUFBKEX+gJBCx0CbslHegi5+Rn0=;
        b=EHaXee1iFBlNBVAFN4/f2qkL933Sa77HZWFm8r2e425T1i2j0t0EvcgZx0gDivW34B
         DkHKC3ycUPKgnloQyg1QUMt7W4kgiG9831uouVCkbfZ6dsfwiy3nyA0nfH4l8T5hExSo
         pwdzcs60FZNeIuXCejkxi9jBMn7dZFhrroy08poiT2P80/UuNLgkIp7rNcyKk7YDgmeM
         WtR+V5+Yy277L/wog74PfUYvCYp8NiAxMAIvH9Reyg9AUf6ty+rRGUdgF34Rh2kqehwN
         dzh5Kc3Qh2FDZL5jQXPLuCki+kmw5EQ66XnkRKBK05oBmAJ3IMvPNIN6Ty+ch0nd964h
         ZyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448440; x=1784053240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjWkSahi0jCSNXvLcUFBKEX+gJBCx0CbslHegi5+Rn0=;
        b=Yq6U8mVlS4JYDZOjOBxFjpqWpwHIhS76lbw/C4DcQLArMb0fUaYCX+HE027rLS3o6H
         IQh2ywOj1dLDOIV7MEsXC56zTUtWle/81zfI89oshTxBKcK3HCQby4oh8dZHHaAJVCZ8
         aptWZjNyOxQpFMqfe+zy6oxbFgRi7euCmQZYERUcVpnb0YCHnMy26p5akvnVYjqAVhBP
         J8UALl3lkhfgBClu8iZKLnMfxIQ7E/zM54+9+MFmcPJU6mFn4UOGJJsCBe7rRaEyyHW8
         9oQbaHGokiPyGSo1kX3j2Ev9wSkDTpJRFJwtx0D5CysxtCjsySI+jegQN9aujXy+FlTd
         eCsA==
X-Forwarded-Encrypted: i=1; AHgh+Rom5YzOZDduv77bIPJAzEMsz4RT5WG9QTPxrAsSMGAm7hXbtN6DwhuNqJUJSRRlHbmzSXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmqW0VGZsPtj/bK5VD+i3r483spTcOOLx1YRMDFhlbME4SJCp
	jW8Q0iMQ4xuPxVTXlGqmcxDvM8S1gR7wogthekAMTf4DzH4bnb0eWXWwiy4x5gDaNqidu9/tOe3
	BG1Xflw==
X-Received: from pgwa12.prod.google.com ([2002:a65:654c:0:b0:c92:3cad:b6c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:390:b0:3b4:731e:6f95
 with SMTP id adf61e73a8af0-3c08ee92ceemr7626847637.39.1783448440124; Tue, 07
 Jul 2026 11:20:40 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:20:39 -0700
In-Reply-To: <20260505065849.81691-1-1234567weewee457@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505065849.81691-1-1234567weewee457@gmail.com>
Message-ID: <ak1Dd5M6EtzOFlk_@google.com>
Subject: Re: [PATCH] x86/kvm: Include linux/types.h in asm/kvm_para.h
From: Sean Christopherson <seanjc@google.com>
To: "WEI-HONG, YE" <1234567weewee457@gmail.com>
Cc: pbonzini@redhat.com, vkuznets@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thuth@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hank20010209@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, WEI-HONG, YE wrote:
> arch/x86/include/asm/kvm_para.h uses u32 in function declarations, but
> does not include linux/types.h itself. One user, mtrr.c, carried an
> explicit workaround for this dependency.
> 
> Include linux/types.h from asm/kvm_para.h and remove the workaround from
> mtrr.c.
> 
> Build-tested with x86_64 defconfig.
> 
> Signed-off-by: WEI-HONG, YE <1234567weewee457@gmail.com>
> ---
>  arch/x86/include/asm/kvm_para.h | 2 ++
>  arch/x86/kernel/cpu/mtrr/mtrr.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 4a47c16e2df8..26e86db37b05 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_KVM_PARA_H
>  #define _ASM_X86_KVM_PARA_H
>  
> +#include <linux/types.h>
> +
>  #include <asm/processor.h>
>  #include <asm/alternative.h>
>  #include <linux/interrupt.h>
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 4b3d492afe17..cdba5bf4a51d 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -18,8 +18,6 @@
>      System Programming Guide; Section 9.11. (1997 edition - PPro).
>  */
>  
> -#include <linux/types.h> /* FIXME: kvm_para.h needs this */
> -
>  #include <linux/stop_machine.h>
>  #include <linux/kvm_para.h>

Just drop the kvm_para.h include, it has been needed since commit bf3647c44bc7
("x86: tone down mtrr_trim_uncached_memory() warning") from 2009.  I.e.

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 4b3d492afe17..db5bf4adfd28 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -18,10 +18,7 @@
     System Programming Guide; Section 9.11. (1997 edition - PPro).
 */
 
-#include <linux/types.h> /* FIXME: kvm_para.h needs this */
-
 #include <linux/stop_machine.h>
-#include <linux/kvm_para.h>
 #include <linux/uaccess.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
