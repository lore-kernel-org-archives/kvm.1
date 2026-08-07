Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DABF4570C4
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141693; cv=none; b=Vt/DW8LZT26gZM0tMm19Dh+QTVvIRsj/SA4IH2LLUdmDPkhsGUtmGerimKS7FDHztRATPBNxnatZ2oCiwlfTMJdSYGpb+vHT1AC33mObo6d9gez6k0to34/QvoiCBrz5IvK0X9ebtzjl4OpYMxXSZx/t0b7FpvGGOsVB+o3/WJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141693; c=relaxed/simple;
	bh=K0zsIsEW8Yn0Vht5R5cH081Ha1e8oN7aKLVhk3oUXX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT+6/6tPYWi+kyt5ndAstRZ16VVlABvGHSLWQFVNpQ5PSfL0VcFfSdwf1D1+5ltK07JACaDqFWAKfErTx0eFgorIJjQhSQDzs4P8iTgTW2edVOqBUyZnPDdTY5ji3qbOZSk2tGeRQ9cPFg0qCVmNpvrKeIUXhfE3dJd7dauw0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQzY2xlx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQzY2xlx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so39690a91.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786141685; x=1786746485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8g4CqNNY+lAFMI0SaWVSjLctp/XfPNWJ0tNY272o3EE=;
        b=IQzY2xlxyXHHuB8xkTjOM2Q4lYdOEsonMYBlIQ6sGnxNghN6boUEL2Sj+9YnfCuXEw
         BYOiIzjrSRbXqexnfg/5d03iXc+iHFlUCbtVeNNj/VvsQaL9IH7DIcvSUQJVtATmsFM+
         mPFHNubFatREccdNfiHP/BIhfz2TnctyCClNYIhjETpbH3JTb/2UkyZZJ0Yo76/2WnK4
         W/9RThR2McVethI9EqxFQkyaCwlHoChj7TpLDbi1aBDJAwwhin8uyMmR4SpPNO+LFzvc
         4Aci10HL9aRUlpdUfpdzJRjBf3DfKKr6qdoU/ElRRVBlzThMUiIu0XupN2i1IKn4ESwK
         dL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141685; x=1786746485;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8g4CqNNY+lAFMI0SaWVSjLctp/XfPNWJ0tNY272o3EE=;
        b=YZ8mhlNpgkNp72SUCR2hzOQ8z9mIxdMPRoaZ3WmymsRtfdrs4oSEOGGVgrGlPBOnlb
         ghw7x6dXm6QCpL+GL3B+DBaY26+cWtr4IhLC2aEB1dQGPpMOY8uAtWtq69/SpMOVW8dX
         +n5et01mCRCG8O4qTEo5mz9Bj6mpa+OEOU6vvT3P5tXvNItM0wKC1Oi28onID52mwS91
         Hu7Z2z0cwlVz1db8POAGJX5VrvGh/5R5DuYrUoN8ekn0BOMXxMv4odwaO4dZCE5J/ttX
         iIOoJsMdakH5RBGvHoxv4CldRvfd3Ah3NdegddVVCyrxo+6tf5l/Qn8MmeJsM1jclWUg
         8azg==
X-Forwarded-Encrypted: i=1; AHgh+Rpph0V1oVUGBiY4l/YuJEjhTBDbxqZKVOttTj/Y2+gd8is4NdVZko4BFbRHHjaXZZELsQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLJaXfDXdJslZBv6uiZnyf7pRo4Nw2JKl1WmjyLn1nHWLk1Qy
	0nJiWC5zpyHglQkH08zABR6mdiTX8JR4DRafASFj5qLB095Lu+80zNpyXfTekbJKFA==
X-Gm-Gg: AR+sD128yGVXU/YHx4+YgYK0UNz3xieSfbA0Zw5OPFEWDxQUJBjc+x7GNYGY0czFC5t
	9rLouDU5kwLYaPvh5xZeUahzDFmTkscRMpFoqOlz76wNzBcjzrRB4LT+WoXCOGNaT2j0u5Z/V1x
	cRPw+PRJ/5YOWbTA4JbQn/pEKhHRo3856cJ/L8F6CKIjiN1B+OdhCS616odWgNAGRZRVZH2IGL/
	/wLQSmk20w6FRwL+G0sxSD1iK6Sa9BYdlwJ9VEYjoelEaTbESJSiLzXg7AuglmlOju7asNj0KXg
	GvAY48Xo2pjRH+PPsFZ1h72xPn1alG1ucgEEL6G29LBJtZAg8BC1HqoOVPSZaaT1s3Zl9+flyDk
	QseeH8e6GPitIn7Iaj9BSCTRG6F4AncEcL+mZ8V8oL7Y9daZ5e+/lJTtXBVKQ7ErJ0f/nEU/au0
	1sG5EBnsaD3SuJclvThAhZ5lETTgBeuC7ELGnLpkzWlySAstdEEAYcwF6x7IutyGqDwTFblVRbX
	wyc4NF5KIBOW5fuRBduqRSHs6g7Pw==
X-Received: by 2002:a17:90b:274d:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3903c534d46mr29628863a91.4.1786141684888;
        Fri, 07 Aug 2026 15:28:04 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2c714sm6201387a91.10.2026.08.07.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:28:04 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:27:56 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Josh Hilke <jrhilke@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v10 0/3] vfio: selftests: Add driver for Intel Ethernet
 Gigabit Controller (IGB)
Message-ID: <anZb7DlyLSMgp6sK@google.com>
References: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
 <20260805094621.665d5ec0@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805094621.665d5ec0@shazbot.org>

On 2026-08-05 09:46 AM, Alex Williamson wrote:
> On Wed, 05 Aug 2026 00:20:57 +0000
> Josh Hilke <jrhilke@google.com> wrote:
> 
> > This v10 of a series which adds a VFIO selftest driver for the Intel
> > Gigabit Ethernet controller (IGB), specifically targeting the 82576
> > device. IGB is fully virtualized in QEMU, making it suitable for running
> > VFIO selftests without specialized hardware.
> 
> LGTM, passes on physical NIC.  Thanks for the re-spins.
> 
> David, do you want to double check and provide an Ack?  Thanks,
> 
> Alex

Acked-by: David Matlack <dmatlack@google.com>
