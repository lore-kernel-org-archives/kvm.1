Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5C39CD04
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269039; cv=none; b=rBoaY4gueHEyEBVTuCIiAHBPde9hQrR+ljU7RM6FAvKMJAhs1DtjsE6Gv4dSXY5ec9gZO1Txtf87+8IWA0J6Mal0YC5ffiW3yRTtQ+aF8+iWTCTvszL0l5I/10np0RlS7wfVK07TmOB4ZGLpEMsiKAlurPL8ek3nBuB6duwmzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269039; c=relaxed/simple;
	bh=v7O/Xv2cRLoJQi9cE/u6B3o+EIuWA6AO+/EbZpuhtaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKJg1qZePphYK4g8OizhVZHVXu6AsbCFDgPMSVBfMCNaYbugm1nQQCZ8Ibzg4fhiQk3nU06o6b+7RYR+PffFg/rQ5xSFX0FWh8/1to+ppou6R7/s4K/9plLowYrwEw5tAsUfRpdltnSytAXjKiUcRyaCVBunKGyV3JSYgGP6j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ic1PeGh+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ic1PeGh+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b440b97aso12125ad.1
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787269037; x=1787873837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k+xmfX7DA1IMWAYKfjmQ/Aix3ZtqaekUVXRTDYfDjog=;
        b=Ic1PeGh+RMY0DFo6d4+/PhjhWwLIacIdnZ+R/c7GICAJhy/JFhNhDGHGOxyTvdTWoh
         75yEt9N0GdGoHMH60f6++AwQavgq8hKgqAShB6SSkU4bsXVtMWXAqN0e+Pk/kJK44AAI
         jMsOCyyOYuyoKJ3dCh+MF/sPgFXTxZMwlmR1AbYzDy6QY/JSxLjAFRMumRuXbGjvjmYL
         XVYRJLbnuikPwDLG7TU/LAvexhtPyjETuMk6ZUj7plhVaUclxYkueMjsBm1LAtswbbux
         hSM8w7oIeGFvh0OJ3XR4Iskjcq9qtNwssoz4UzLvncIz6yZcRszNXCfMJJ/1EluXvl2j
         6Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269037; x=1787873837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+xmfX7DA1IMWAYKfjmQ/Aix3ZtqaekUVXRTDYfDjog=;
        b=boI4vxh5oPMwAEflxV0XxxV7cpOnmLotB12bWn7GOjg7N2nq4t83zGLXzL5Q9IEGGt
         x71+EPh6fvNKoVjBALZQq7mAEKFFcJCAkb2YWa9sSSKOWDK5pcTH1c7K4YH/u7eOdb1D
         RLM0cMGUeZw14dXfronuCNbeFHxcuiC55ju9mSocm9RIoZGaodsAQvsFufILCcnh7uKA
         scOpU0P6swqblNgpeP2yZRaXPcf7sXxdiLEKttCpFj24rdqGE8e24933Sh20YrzRYPLE
         rw4iMM2sNQarEyGGRrF1mnq6n++N+vEdzHdVZt6U9LjKoh8B90MQfh90fwTKghyShdtr
         Lq+g==
X-Gm-Message-State: AFuF++nfZmAJOJVOFIW/Do+TLzSMDfZmTwJPkvB6msG/B+aGu60ffTVs
	WXaKVr3ygsmocjFkRcHRkOImOyda+a6k8X9B9dDO1An22wMoRKZwABrhF0EDBY3zuA==
X-Gm-Gg: AR+sD13TDJNb6Qpr+Kd+603twTqfujoZ2PbjBQ2pM7fXgYlLUZKU0Grrj1vjnmIPcvY
	bLwUgbOa34ywVO/kzQx+p+WAR9GVDFP/BdZu7qrL+Fohghvj70m4etuo0kdBN9bUioDNein70GZ
	0CdVMtbD9Xc1GKdBwaRZ1RnJ+S+nT0xC5v2tvBS+mHCR3+ExXv2cysSzvkH2bt8richnElNnxtN
	/+S82UQ5T8kNxwioBy9Gt7cNuWJKbgHfTo7IRmZLI2Nggaryt2vJygiqRCcKnYjF/lXleDjkoTy
	k5u2e5csRPQAvLKZCFlLnEyY4rn8ZsWYGorIl7uNYFiC3iDcGxwgpvfy2sIj5DjLhBXZFmGORJI
	BOiCiMZE+TAho8XBqFczG59ZpDtu949wbwhFxR7HSQTUWFbMinzw6XoL4lJtcCamdy0mrqrjglD
	giXBmowDEPGIEO31iln2XBP6kF8VYt0y+iLEt/LeVQ0JGF3KJfFAB2jhHiHcE56CHBRcLhPToYs
	+JK6oZSo2gJWN/yA/TS/K9cqAJQ4/h4eI/y
X-Received: by 2002:a17:903:40cf:b0:2d3:153d:acae with SMTP id d9443c01a7336-2d64aaf3497mr3577045ad.0.1787269036513;
        Thu, 20 Aug 2026 16:37:16 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8e2d7e0sm116103a91.0.2026.08.20.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:37:15 -0700 (PDT)
Date: Thu, 20 Aug 2026 16:37:11 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, ajones@ventanamicro.com
Subject: Re: [PATCH v4 6/9] KVM: selftests: Add various print flags to KVM
 selftest runner
Message-ID: <20260820233637.GE618052.vipinsh@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com>
 <20260331194202.1722082-7-vipinsh@google.com>
 <ampREGtEqKh8_-Ua@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ampREGtEqKh8_-Ua@google.com>

On Wed, Jul 29, 2026 at 12:14:24PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Vipin Sharma wrote:
> > @@ -27,10 +34,14 @@ class TestRunner:
> >          return test
> >  
> >      def _log_result(self, test_result):
> > -        logger.info("*** stdout ***\n" + test_result.stdout)
> > -        logger.info("*** stderr ***\n" + test_result.stderr)
> > -        logger.log(test_result.status,
> > -                   f"[{test_result.status.name}] {test_result.test_path}")
> > +        print_level = self.print_stds.get(test_result.status, "full")
> > +
> > +        if (print_level == "full" or print_level == "stdout"):
> > +            logger.info("*** stdout ***\n" + test_result.stdout)
> 
> IMO, when the print_level is exactly stdout or stderr, the runner shouldn't spit
> out the "*** std{out,err} ***" line, as it's pure noise.  E.g.
> 
>         print("\033[2K", end="\r", flush=True)
>         if (print_level == "full"):
>             logger.info("*** stdout ***\n" + test_result.stdout)
>             logger.info("*** stderr ***\n" + test_result.stderr)
>         elif (print_level == "stdout"):
>             logger.info(test_result.stdout)
>         elif (print_level == "stderr"):
>             logger.info(test_result.stderr)
> 

I agree.

