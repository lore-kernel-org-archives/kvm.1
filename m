Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F83C108D
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813538; cv=none; b=Dnegcn8772y1T50Hb8kNdSgY9elgC13svNSnprKEpLERW7Flp1jj0vHKAoFSwFr1imv4J6DsrY5TLHVVFEwTAKDxecODDtSF0KemGWBwME14daJuFu96GdMWiib4pJ/c7ZIXfRUk7/vnQUlUgnb6hIOMSQa3cqoEeOyX4WkrRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813538; c=relaxed/simple;
	bh=B8fYPQsF3fjjjyxm4tLPdgSy0mdz8Y2/OEmL8RLtKQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H13EEmWOtIiqLqgdNQ4+9Cy6NGpH+mp69tIL4rUF65cfBCbmPXfiATuEDxbzRdpYSvzkZ1xOSBJhHlhDNr9DJciXeiWUGMHAwUkiBR4zr4MSkI/n7OUv7rcSPSiavoD2KpEK3ilt5f0qyFGcwistHbmX3igU7yAv8cpzsBEcRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oz0MUfSP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oz0MUfSP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a061a13884so16678975e9.3
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813535; x=1792418335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkfYRiKWPJSEEeybOhY/J1Dk0z/38ebHl0Wzyd5gW/I=;
        b=oz0MUfSPP3M0yLey3mtfCp0OO8wwoujC1at5Y0AmOCkKRJnkYevY4mF3LYzULmOWMY
         870gTf0GTs+8texXXFubibHcK76epk/GR5Y5mOrF0ubW0U0h4rZrcuifK56BTPfFcw6W
         jpuhPgaFOEZmHgUL72XO09pBNp6RozZkCpNlfv+VWmlOk9RJODe4nG86n26mffpmF57O
         mHDA2z4KE7eeyRN53QUeUXML2fCB2PsciFL6dK2PGvS4eF2t92DibcAXfqbLLHKJ2Lou
         WxhHqzGbPw/o2ODQ/Gv3khmpdtnNGxqsWf2ntobbuPbeE08uHcVzAcrkl2K/02toixOa
         Hw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813535; x=1792418335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkfYRiKWPJSEEeybOhY/J1Dk0z/38ebHl0Wzyd5gW/I=;
        b=ZcAXsoAhQdoLQkhb+xUbBFuppJDtF9dAb27SwnJ16zDLjrqYsREjGP/APWBbcpio37
         npSBQR7IW2apuJ/BJ/ETAXcN4EKooTuiHICRr4iQDY5RehUFoPlGHo2AEb32ZzGl9iDE
         Xg0ccO8jy6UjL+SozIizmGrLPzqvatKKQ+Bkmggof1R2gD6T34Dehl7R1J2+BP6gLrGQ
         cA6N1l+g3hgIVewsIOh9mQEQAnVbyxpdj6qfJlfri6PMykZp1vvq8IPnLV6XQ62QHYpn
         2CcFd61ySzsUbEW8wzfaXgXYNiXwbsmK0q9V1CqRJEX+6g+0tH6WOe+5hfLJa51eARHA
         doFQ==
X-Forwarded-Encrypted: i=1; AKwUvBykNFQCwVmeAPl2TTAdssUW0mP6TSex/O9ge4dHykJXj3Zr7CroT9Or3OtokiDhwc7Vmuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxClVRrzTGyKN73sc38jlhesLH0wwniONgRIf3iYXM9AzG8IW/
	9TflR7opoxmilqZ5UDqM7spnRs6cAN2xILrquq2qVFOnDh4qeqdkPivVlcsLDAFB
X-Gm-Gg: AYBFou1g28pXxBN/MgnzIsickLfk5JDH8h/7ffyfS3hWJ0mGG1EDOrUw8s02hIvDJqO
	E40Sf4wkQqdLFU7BBnERkyWDKIl6RFITnSb+TJWgx1aQgzPl4hanQJXd21qHzhYrygNfTIZ9jgY
	eRD0XKtgXFUXUHlbvjXEL7AYk+DhgYKXEwpte+ooyjnvFK4mcNmpu4jqgBYocygllsDPbRuX7yl
	AvzZjRS7WRQHq/0GH5W7eqfOHSgbvruHT2EbBGLT6T2J4mh/VNAFClJEK5bJ4LOX+IATKHKl3zN
	ESVX7AVh+tRqmIv7+jwCo3OMfqeV2x1Paph+pGjwHEC8vHsm8qR6AVX1Jo6t2Y2BeITRGlYrW42
	OEL1LMXQTq3Yp/KnDS6DX8ycepQc3cBQShG5bx26bY9f/0WnAna4+GRo8hmLiYGRFcTnOqvOeCp
	l9OhIPjwjGPPake+h/6+MY05bCX8gEn3RZRk7r8IwPK56ZnA56x7YDSKmPEVREt2LHKUVTabxHG
	+QrY1BtYGXWWGP1b/bYsHIItdSOzt2N56EneRrA4QhI
X-Received: by 2002:a05:600c:4e55:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a18e49c008mr167950485e9.12.1791813534960;
        Mon, 12 Oct 2026 06:58:54 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm281072835e9.14.2026.10.12.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:58:54 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/nvgrace-gpu: Skip PFN registration for empty memory regions
Date: Mon, 12 Oct 2026 15:58:41 +0200
Message-ID: <20261012135842.152928-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009135203.33f3806d@shazbot.org>
References: <20260925161024.189771-1-parri.andrea@gmail.com> <20261009135203.33f3806d@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 01:52:03PM -0600, Alex Williamson wrote:
> It seems to me though that the reason this bug exists is because
> nvgrace_gpu_pci_core_ops.open_device is trying to handle both real
> nvgrace devices, where usemem.memlength cannot be zero, alongside
> non-nvgrace devices where that can easily be forgotten.
>
> The above patches the failure of that model, but maybe the better
> approach is to split them such that the failures like this cannot
> occur, ie. a core-only wrapper that just calls vfio_pci_core_enable()
> and vfio_pci_core_finish_enable(), or some other refactor such that the
> core-only path never handles the nvdev.  Thanks,

Agreed, that's a better fix.  For v2 I have:

  1/2 gives nvgrace_gpu_pci_core_ops its own open_device, which only
      calls vfio_pci_core_enable() and vfio_pci_core_finish_enable(),
      to pair with vfio_pci_core_close_device().  The usemem.memlength
      guards from v1 are gone.

  2/2 drops the remaining usemem.memlength check in
      nvgrace_gpu_open_device(), since only devices with the ACPI
      memory properties reach it now.  Not for stable.

One visible change in fallback mode: open no longer fails when BAR0
cannot be mapped, the same as vfio-pci.  BAR0 was only mapped there for
the readiness check, which fallback mode never runs.  Ankit, please
shout if the fallback path relies on anything else from
nvgrace_gpu_open_device().

With 1/2 the reproducer from v1 (QEMU cxl-type3, fallback mode) no
longer hits the -EBUSY on reopen or the KASAN use-after-free after
unbind.

I'll wait a few days for Ankit's comments before posting v2.

Thanks,
  Andrea
