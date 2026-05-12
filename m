Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BF39DBC5
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624751; cv=none; b=Kc47YT4e5fOZru32+VsOTsr4K1o9agFhRs+jNOg9vxcfxjGVNdL0Ag9rx0+T5O5JbT6PbBPep/+3GlHby38thlyBX1J4oyfstxDbYzKMnJE8VqAIqjd5PFGbeuLVKExBsLylbljSwGYaX8utbtlYOB6KhZEoPWmm91897o9eItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624751; c=relaxed/simple;
	bh=Y4vMA2JNnv40MvcKeCvNyUWpztSVrcRb/TQy6UY4ySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9sXxYXohvJR44YrrlVsaa1uavnpX0NJLx7wmoUCdC5/yL7hjJiXhX9LiRHbadkYQCGbsUEJQYOBEvHkbU+wSYb/TWBuVq9JTAQuzJ5DtwFXGAjsJP/tGMzYpWG2oWnwhED4SdrqrIZKp6OywjDGBRhX8bWwbhLce1umtioaR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Knmdzr7f; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Knmdzr7f"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1336742714fso63c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624749; x=1779229549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xezjeDqPD8r5Y688yiRpTBbJ7F3pJULcyTn19qkHR5A=;
        b=Knmdzr7fjEEVpFckEJ5hkIW7D/Ul/rMLhiZMYovKf3u7YYuvXFzODoGtEIcHrIuu+a
         uPgkDPcdekSJR9rB0FidwBAbdNCVGaRpcdbe//Nph3LjBx4f1RfFe+K2heau1UXF0Tyj
         UQf4ioU/g8/CVLxmiL+IMCj0uLFBAeRGzam42rc7nXnUld0Nvi4qZjAtOoqT+KnItUpP
         BwnvuUpwf42zTsFYallB1aXbCTc2SiDS9zh7KmiwzZZk5qdacUj/WRQM98GJWUTjR3ua
         +OCg+YoOJXYxpdp8pY7wo3IcrinAuUK3V9MMVdYw4H6EFFao79ReNYIbPQYhBdoAITlF
         CwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624749; x=1779229549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xezjeDqPD8r5Y688yiRpTBbJ7F3pJULcyTn19qkHR5A=;
        b=XJrAJMb7HaVPbZoMwsS8Njn0S6tdtoFlivEoTylvFja0H23RI61tXcf00eJeMtjlVH
         NZNubnbTHjkqOtuJqZNE7zK7lTktlF8VKnhotfW5XJtpKaNjzbv2hf/fYN8VT1m6vLXo
         CUfz0HAHqQVETqH4I/XuL1TCwxq1tOrbBo3t/S4EAzTUidSYkWcNIkG1tzOpUAAiWnpf
         fX3gIyTrCB+xUeny+BJilxPKIdNbqCCqXexvm2+RzVDziOXngufgGSvKYx6j2pHOBHLA
         yu6SCcbC188w0HRMty6sIe3ue6fwMZQqMECA5i32GQxz8wLNzsqDhl/6UZBQDL5fvXPO
         J0Dw==
X-Forwarded-Encrypted: i=1; AFNElJ97BlGjmd2C+8GPq8NHNA2OxLXYdgAR0W9IbBsft9UEuFXjXdI1HloofhHzrWl9t43slPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJ9qM/UPJzsodePH/w1Y7+nr4C6v6Vhxi4IJX9dcDt3gUk3Th
	4uJeUJQbLTybb2ZjS9aAAsvybgr65CHTFjQFRM75Da74Cnew+iqyICQv+HToc/eY6Q==
X-Gm-Gg: Acq92OEJ6QMCOJgt7FfpIrp1PcjlssxqabRlYhDqXzuHTogV2o9OZZLH/GHeyLBMQaf
	xH4dT/N+cSy4rQyWRv4lh/sElodPW/EE/IB8VdwczV5Y93G7eQeJDmfuWWq8cuglVH9MtHm2PmG
	VFQnlwwGeWgn0QgXst4JTyRFACEUO93DnjwEYNDRpmMh/UgMN7SY2On884aH7r0DEvwYJhjYcMU
	RO4g0IaCCRdyQK7JBKuNyOg2jeVZ4/xJ9QXAvIUepMiQWbbqOTuq6wy7FlksWolj2xrASha3UHq
	tqHutzdnrCMjeTT0cx4m8JDajTss+znmELV0vu4arV4phOczXF56DdqSMjG+6NtA4XL7oTn5h5C
	xqmtsmQNPfD/aFLegsGQuSE8METos1Elkd+kPFkZjBJQpKerhOlqfpq6Ch1OTKDSnPhjhATx8QR
	KYhhDySsRHX/pKu8MB3Gw29odIcluKJDFA6KpAWi9f8Ai5haK9HuCT1O7pS3nqXOUfSKQsRjRwm
	zKaV1Ho
X-Received: by 2002:a05:7022:699a:b0:132:1e01:2d6d with SMTP id a92af1059eb24-13401ba684emr121609c88.2.1778624748249;
        Tue, 12 May 2026 15:25:48 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860c7accsm19638280eec.8.2026.05.12.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:25:47 -0700 (PDT)
Date: Tue, 12 May 2026 15:25:44 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] vfio: selftests: Add -Wall and -Werror to the
 Makefile
Message-ID: <20260512221637.GA3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-2-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-2-rananta@google.com>

On Tue, May 05, 2026 at 09:28:31PM +0000, Raghavendra Rao Ananta wrote:
> Add the compiler flags, -Wall and -Werror, to catch all the build
> warnings and flag them as a build error, respectively. This is to
> ensure that no obvious programmer errors are introduced. We can
> add -Wno-* flags in the future to ignore specific warnings as necesasry.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/vfio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 0684932d91bfc..e26917ee169c5 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -23,6 +23,7 @@ include lib/libvfio.mk
>  
>  CFLAGS += -I$(top_srcdir)/tools/include
>  CFLAGS += -MD
> +CFLAGS += -Wall -Werror
>  CFLAGS += $(EXTRA_CFLAGS)
>  
>  LDFLAGS += -pthread
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

Reviewed-by: Vipin Sharma <vipinsh@google.com> 

