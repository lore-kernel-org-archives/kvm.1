Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CB32692B
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517153; cv=none; b=P7vSbC6RHkW4nx+aKFLCGrRWtSWHFY8L86iKI6gBEkaO4yOG3DZndxdqvGpRkp5KIcq/Wv+1AnIrPrcxMlvAx3mFuQhT4jqMvwSZ54pGqW85ilIuvWHCM+tThY2MxBEfi580Cxk13XZ+Oqril4cwRVBcV/9hO4n3aVmzIT+PEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517153; c=relaxed/simple;
	bh=WOp6SYYDY8immBhGTtDhVqEF4aEQt0yrJ7yko/SLIyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPjpmC6RterubXgfVKby8kllUJloFb+2LsQGq6PIkstX+tzKBsoLxlDKcgQmDGV8OpEK4/QxRZKjSYoEM5KQ44z1hxjRY1pD5+lWEV9/44kir4FLlLDV6nLOVzW+G7bHV7udif9OUIIiMHs1I3aK+WAjHgJOTtK0sli76QoMS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8PI96Vx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8PI96Vx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-356337f058aso2380290a91.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775517151; x=1776121951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siCrx32nh2+8OpasRtqXmP8hQkcGaPp8sX8b0aEt65g=;
        b=F8PI96VxV0MdhHMf/JpPWXiHG3i6g9t0cmSCQjPCmz6ZRRpeejsIejzhoTSKabup8Z
         H1O+mrWUE5t/8NWtN1mevUjXyK99kJRARZSmnC0j2XTW7srMn0ci97svt9SAYu2m+U+U
         DU0i3kleqXAcI741duSGSymNXoD0B1qUWtb8CyhGPabVTfF+Hu+HgKu9XSh6FfNWoMht
         0mrlnQNRH3y+MdysdP4pmLKCyUgt65i6YCCyZRiAxlzUjIjb/kHv16YCon+KxoH5tXar
         lYeTsiSq+vTDlq9mZfNM9KE28LRUjdbNqaAt5jR6WC+cYn57hjoe/agifoMQHj8bSy3t
         UWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517151; x=1776121951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siCrx32nh2+8OpasRtqXmP8hQkcGaPp8sX8b0aEt65g=;
        b=EPezKY4EckN/rcigYuMpIeBbiTxodSGPtJhJOCplwi0sA2rm5FW+okCgfAWJaA6mwo
         iRAoSWdqlw0Lhka8Z1fV+CgjyvnS2ZLAfy51jL8AmxtrXxarC2JDLRD+gp7O7Wo9dpzY
         +7hkn3T/jvpW/GlTV5y9U7rx1hlHtRoB39PXJeIm/mJO/DPI8VHrV8cyTxhTLMfuPWtt
         9u+8QIayy4sp9hUc3sEbxZix12LIKHMiTNU9gQ7nj5fMNCL99a5585HQeuNBTCDUNbEV
         g8R6J3boj0ypa+VPobN7FPKp/tDKEAoTtp2gvN7ONwukOyyAE2thA1RoIiaXxp/GnLaF
         b2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUKesZSGSSMjdkwzpB4FUX5x0tsV1w2r/mEdpaYCcfIYxlB0zB7js5eNDqGGoY4rNVJDxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxai7PJZMFz/SjtPITxgRiNr5OWzYNQtq83YsHdMkDLotYYjSgt
	A4J6vIHp6N0DnPC/1Gwge9gtK67zwF7nxpOdkkhCJHzWN1nm2sF7zfJYns+wSIgkdQ==
X-Gm-Gg: AeBDieuIcPOEFh1tLHN6Rb1J3Rm2FwAuoeEGlxTOdWtSTo30nruX5EgPPjdcRqtN+km
	MstiWzvIWGr1xviKeisy8A/zDTUIi7hWxNe2Tdrrnji9rJ1uHXbYPCO5gJ6tTWdcmOUnnFqLqTk
	co8LWvwuX1z6uZ3Q0ax8Mjse0E2FHxgAC4FGxe9/uhMg50iE2Jq5KgWmQcilNi/3dovNLxQqTnx
	PDck89NV9D0pbyNJaBGezcC7Csowy8xNgpMK8G6XcvL8O9Z9/VJsaKe1u2fCjugDl2azYQk+SJh
	rIM1/fWyBUuFTLGmGCR9r4qsuEoR2WL9ChIksDqqrHr3U7uhHFzRdhRmHfbx4X9CEU9gVauEPPb
	rxPaI3TV83eJZ/xfgZ8Pc3xDITeLgofwmS0RAVPJBaveLu9AgINIRvJCakGZpPz6VX3Pk1EOSiG
	qBCOmqGX3vZsHCGxXqF3nbomidvFhnShc+IXqPh/ekxCLYcZLLFm6s7EAq1g4lUw==
X-Received: by 2002:a17:90b:4ecc:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-35de67e8aa9mr13334095a91.9.1775517151102;
        Mon, 06 Apr 2026 16:12:31 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9379f3sm20116802a91.9.2026.04.06.16.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:12:30 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:12:26 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/4] selftests/vfio: Allow drivers without send_msi()
 support
Message-ID: <adQ92tHGZVGKG0t5@google.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
 <20260403234444.350867-4-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403234444.350867-4-rubind@nvidia.com>

On 2026-04-03 04:44 PM, Rubin Du wrote:
> Allow drivers that cannot trigger MSI interrupts to leave the send_msi
> callback NULL. Add an fcntl_set_msi_nonblock() wrapper that only sets
> nonblocking mode when send_msi is available, and update ASSERT_NO_MSI()
> to skip when the driver lacks MSI support. The send_msi test SKIPs and
> mix_and_match skips the MSI portion per iteration.
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
