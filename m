Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C513265629
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856439; cv=none; b=RJUoanUa8YrO+41bJo53g8YiL6vegGpTLhHxKFb/Rzgn8ceHM1/Ypyt11aFpRA/j9KHI7cBOQ5+u7HVRIPb4ly0AJteIH1KUeuNt/zmavFqlzq27FwoKSS9SItR8lYv1xtRIZNAGW6i7zaHBDKHoAxDhDC3YcbPQdAgxjdetmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856439; c=relaxed/simple;
	bh=2JOhToTdTr6yVs4wAFQ473V3hSoFLZW0ifRgTNN4e/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEGT8SgVoOixXbKAX7f3kbBapoe4zKIlb4n/7mR5Dqsd6VTXirGij7PmE10+sB8bBmOa/2wGpz9viYSrH79Ht1O9P3Q2mg5tJFBvk/Bipu5z27ohFGy2cJnJEqba1xNuaSY/CfYko2iMspcDfF+3L8Qh4wqjKHS/DHwheBJQH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8i5fqcj; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8i5fqcj"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d3eb307324so1357288eec.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775856438; x=1776461238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBvZdikgBdRF+Wn4G4dECwW8X4wf362wNDlrhZsu14c=;
        b=d8i5fqcj/QJ4W/UEwCICT2MpxBPWWAvttWXu228GRTjgjdw8/8xLIqy6d+51A9DWCg
         VhdRbG5mEK3qdALZYup8RKPjVSBSreJJaRhvFfuoPKCPMLifKI5efcMRqk77+4JcC5Fx
         HxCgIx4iknlnsAL0MGEkp/sPYqGC2vx4P+q3kzyNDVXL6aZFpQMoEXpn3fj8kKvfwChK
         TVn7f6uNybVWwXBPeYxHGF8eCX90gE/MqiGZ9MzOV8kfNOzGSDjGzqY/kF+TcGs++gpV
         AEo1CPfR4BS95C+VhH4eQM5Znq5RWn8o+crYl09YSPRPRv9jGpZlQdBjbJ6Bfatuf6Ft
         rSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856438; x=1776461238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBvZdikgBdRF+Wn4G4dECwW8X4wf362wNDlrhZsu14c=;
        b=TNoywAyNF1PZPMIdEF1xEpLazle2xWUWzkQCbr97MeXaJlbWA6EpNLvEaQ4RiQYcSw
         uExMbR8BPM5bAz4n+UFmDGZodGuZuwAZZ2w7TyaZL+en3vDib8WNu1DiH7S0CsUgJ3NR
         TKcuWL3G1aKmKUhkEVKAo0o0U3l+q6v8NAeKTnP8VMmuR8Ownen4cE5Q2aDf7U4bPGBM
         usNM+U9Udl2qZSz+eZiz75WL2CFr2WoanwPm8/imUxVVLe9CZZz1E41Da7lDw0oJBcqR
         /ofCgQuFFGttc7aJlL460zWxS0UwKFrgYvwAEpTOYvOdgos2ImZguOb+fPb9dWxRU+R+
         sOsg==
X-Forwarded-Encrypted: i=1; AJvYcCVfuT269kHIyf7+wXXaF2OvMIJIKvsi9nj2CjNYcenMxwk/7c8IezSzYNInQ/yUi558WSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhTgu6uOLUCsWwrhZfUPTHqpqlLtvrGCg2NldjBLgJHdZh1ht
	XuY/UK7oLe4GbUwjmLzmBrQLPlxUK+WNipZfn/QTGPy3NH5Tayt2k176lQ9EE6a5Sg==
X-Gm-Gg: AeBDieuuxZ+V80T8hXzswMLP7SOOafMiOrf0nyx2z9SAWICp+4PO0z/C+iv0l1QO/EA
	K3BdWBGmi4VO/4exj5OQdJKluUO29PMBkcxL1tg2/fdH706d5mV9sHbKj+wafqQsr4siNXFKOqx
	Ocff0lDo5udc1tiihfBVyJ+d2Ig2rhbMqwEuk9ZgJfQQAhAOfW7DoJtdc18YDy15gBO72on3XFl
	vfB+ZVRKLBL9lrdlsTS9k/aBMOSwjuEU4GHfwK/CPEdagouzYRPozVyLBO2ElVB7bYJh1eeNBgf
	qDmWmHsqiJWJJhDrelBAHom9FoIC3E2fhfoDphm2rEnlImrQDKpN8qK4tP9jdcw/s2McL0XOZ/q
	mTbYu+1KreZGpBp1glK6yePZ8mESRAzgFzy19aj7YKgz5UmM6405FgOJk8k4K9/SBIWRNcpCV2c
	uQBdnf7ydh+SCxlxKtasx0FzUquq6cU+PUAZZD8ayEwXRAolaF8KpZ05OhwnCcvWcJmPE=
X-Received: by 2002:a05:7301:6884:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-2d4101c7714mr4323460eec.15.1775856437082;
        Fri, 10 Apr 2026 14:27:17 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa5257sm6066771eec.9.2026.04.10.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:27:15 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:27:11 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: alex@shazbot.org, shuah@kernel.org, Rubin Du <rubind@nvidia.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/4] vfio: selftests: Add generic PCI command
 register helpers
Message-ID: <adlrL-Iurq5_ikkY@google.com>
References: <20260408225459.3088623-1-alex.williamson@nvidia.com>
 <20260408225459.3088623-3-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408225459.3088623-3-alex.williamson@nvidia.com>

On 2026-04-08 04:54 PM, Alex Williamson wrote:
> From: Rubin Du <rubind@nvidia.com>
> 
> Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() read-modify-write macros
> for PCI_COMMAND in vfio_pci_device.h.
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
