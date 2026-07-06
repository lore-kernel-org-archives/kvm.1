Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9613E9F7D
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370979; cv=none; b=UfV2Z2uD43bpUVZ75RvlQPhH7s9c8Z5N1eTXznaUFcDjw/WnfCZcnyyMUrgui5mXuh7vjAjjslicxTe5QgifpL7FOwMGr1maQDnpocqett8v6wXEAdU1Tj+aFetSgKLVc0wdEl0m8wPllXA8fgXojf7W0zcgAM7cXMA01FYzey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370979; c=relaxed/simple;
	bh=d4S7sDiFbTc53OqWoIai9pPjYCRzDsWspPHPSQWAR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6ZYMg0FbRzSLY+KPtOpDq+iwxM3pemgMukRr6guOXI+dRDm3/ITgSLPBVBggMyaOKR9KYz2qS8vficVSl+TRVS2r1BTW1pgmfMrc+5AVeSZqGCM8RkMOxlTFXULGQxEjLxoJ/kr5VY63clLULpwGB6MaWbCAiwd3jofzxZVdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OY1t4vVq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OY1t4vVq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cca24023edso19593595ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783370977; x=1783975777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsAw/f66PDO6A23XewR6r4+zQzL0h2Tt+CMeAp7uytE=;
        b=OY1t4vVqWzXz2P2S0YE0yDxjR2ucGA4vXE6BjGcBif3ysuJXYB+ZVgozYKtNxDu7cf
         2F/eLTGMmzzc6fvRlfIWV1AaIVdNIDuilgCk4kjCUnd8YL5iZo9cxlu0N1dDoC5Yrgk0
         sZej3/FI29aBt4nFwdUFg0ZNx4oOPiFAf7CF7SGvemWK39Rkz2GQulWpIJ15qP4Ti8gg
         7IEUHBGchhNLZvDXZA2VOc6KzHnfirEQoZRDQnOBWsidJ2vsiYqSrQQ62xvA9et4Tjd4
         3p1vwPX47dF1qFJyFvAtL7QPS8Aa9zdFSZ2gsMRR+W2XGrS52Xt7GUHQEpJ7ir3dPJK0
         M2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783370977; x=1783975777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsAw/f66PDO6A23XewR6r4+zQzL0h2Tt+CMeAp7uytE=;
        b=ELUtPIFM8JfJ5CPR5NYojLZ/KD4GYVeh0zqVaqSgqQQMVMikQUK/818HnFTuOixsa2
         oV9lychB7mhpKTGaixcABRdAwJ/hYa00PIu+NiJXEU5maVvRxAGmVa7eEBXxHyv/srW7
         /r+crJPmT1rY+xCyiO9ZUmTmtwNoDyQJTP3tcHnFvGN610kXCp1ZL1RvEgpTaRJAreev
         ef6YYZcygq7/PRSuUzhBFERYJcGflMbcrvRjD/+5uPZbWWlrvLRa4t/j2S6s3ZDuExrV
         zxqZ2/4zcbiJSsAUX7LMw7Mry7VLjSPPypo2px2kHZXa9XZ7uoKogXZsz8tUsn3kJLb/
         KY6g==
X-Forwarded-Encrypted: i=1; AHgh+RqirFvHAP/ZgVxsDHa6mfgKtBQJVmqvceJSXatUL/UZRQTExKvIWgvi010GGgDQtC06w0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5LYbwYzW32X4s5Vdc2WJ/XB8gIHrmBIO/erz4uPeqC1Lfuc1
	fBNg2PoqQ/mvyFuSACsZK/Wk/fnr17rh89H1AuT1ehuqYoixdnw6QhdzOF1clDw1iA==
X-Gm-Gg: AfdE7cnZUxzfo6DLutONiXDeOG4Sg1kJdPo/1r3CHY7Gh6GZSuKLqirI6J2KcV3l/DW
	AWSYKRY7S/1rjyPyl5S91boySkqXXEBragM8hEykyYa1xnBU+TePgXq4lFAa4NVzqUY6CNFqhsR
	T+gLPGwS+2j/AcUbMjX3ZABYUjru9Ns46AbkNJW0i+OzV/AKIPnafswUZoCokJvfITwOrzTnTp7
	kb3T/dV5mHr90LNqZbNAqHdKX+uArO9bmIcgIa+Q2ToyUyE8AOsmwdQlJbTcV9V5G/zlB+/8TVC
	eG7y5mYArngOjTt/13n6jbSeygQ/K1osidRfWV3Hp1dcrDoQTSqGcxIBKSAGWMXjo9XJNF8mTjz
	oJXKlz8ppin0Ymb0CS1EV1Bnr57GlQmW3BQ/B4e0tjh/Db07eBW12hSSYN7O82BApkOSxPmkSDF
	VPBvXi9COdqJvERbkU56nkZ1HKvvSvjPlY0/Z2RcU4FmkWAi0mRRc=
X-Received: by 2002:a17:903:390d:b0:2ca:d151:383a with SMTP id d9443c01a7336-2ccbe729b2bmr26058305ad.20.1783370976544;
        Mon, 06 Jul 2026 13:49:36 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm302005ad.71.2026.07.06.13.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:49:36 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:49:32 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 10/10] selftests/vfio: igb: Use offical IGB headers in
 selftest driver
Message-ID: <akwU3DIBQlPCXFmQ@google.com>
References: <20260526235417.2058313-1-jrhilke@google.com>
 <20260526235417.2058313-11-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526235417.2058313-11-jrhilke@google.com>

On 2026-05-26 11:54 PM, Josh Hilke wrote:
> Include the offical Intel network driver header files in
> tools/testing/selftests/vfio/lib/drivers/igb/igb.c and refactor the
> driver to directly utilize standard E1000_ prefixed registers and macros
> found from those headers.
> 
> Delete tools/testing/selftests/vfio/lib/drivers/igb/registers.h as it
> only contains duplicate code found in the offical IGB header files.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> 
> # Conflicts:
> #	tools/testing/selftests/vfio/lib/drivers/igb/igb.c

This should not be in the commit message.

> ---
>  .../selftests/vfio/lib/drivers/igb/igb.c      | 159 +++++++++---------
>  .../vfio/lib/drivers/igb/registers.h          | 127 --------------
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
>  3 files changed, 83 insertions(+), 204 deletions(-)
>  delete mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/registers.h

Please fold this into the first commit to avoid adding registers.h only
to then remove it a few patches later.

> -#endif /* _IGB_REGISTERS_H_ */
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index 1f13cca04348..0075749e2f12 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -23,6 +23,7 @@ LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
>  $(shell mkdir -p $(LIBVFIO_O_DIRS))
>  
>  CFLAGS += -I$(LIBVFIO_SRCDIR)/include
> +CFLAGS += -I$(top_srcdir)/drivers/net/ethernet/intel/igb

Please create symlinks to the specific header files you need to include
rather than exposing this entire directory to the VFIO selftests default
include paths.

e.g. Take a look how how the DSA driver does it:

$ ls -l tools/testing/selftests/vfio/lib/drivers/dsa
total 12
-rw-r----- 1 dmatlack primarygroup 11648 Jun 11 21:18 dsa.c
lrwxrwxrwx 1 dmatlack primarygroup    49 Oct  6  2025 registers.h -> ../../../../../../../drivers/dma/idxd/registers.h

$ head -20 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
[...]

#include "registers.h"

[...]

>  
>  $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
