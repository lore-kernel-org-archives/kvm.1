Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CD446838
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568709; cv=none; b=q2OporYAbKyqgfzyqk24O/iQMtA4UZhkz/KTYR4qdKVg6xy3MqqCqmkOr9KKMLsx4Kmov7bsDXOeWhE5bXgiaD2L/TTVpuiQrVguYtjRFZ/4MRvpba5Ha7L9ZMzLuG0xlEdVQWNjQYJ/fTUTP7LjrYE1tcQIRLOebnfKJ73ZL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568709; c=relaxed/simple;
	bh=qw4JPuFzFFBPT4iH1s9YU2BZkhtjNYvO5TG+CT6T0gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJbpNkYSm7Y12rkNACs08uGOYnn4pM6gCSnFbPWpYrC3Qsq3MQSspoVQX/LWXJcP9wieFnHon+jfafddcajsYKblHOUXWwKCAHxayXW2wMY2xQ2JDIi3XU47bAvmZbwP7xyUQmqdyQYAQhmZCDoidzIUe3U/g6PV7B6EnVnWzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLbZDCVr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLbZDCVr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso398475ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784568699; x=1785173499; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=354gFNaVuvmOpRh2GIKgIn4uIuwVXTK+d7q38SvtQbc=;
        b=aLbZDCVr1g+cQ+xeb9Hgx89e9Au2lfi0EeVoMbmYGaxUb3l38v2UZjbtrMA1HO/nMP
         bBMH7bKc1q0Aw3scPE+BIJ4g+p+/qguzNCeO6QyZslx0LiM1A8Q9cMbjWBze23c1gM0r
         XLqtBkFGx2hCrnbbHO54fsz7j9gzKhGuM90U6wKfIzgY+Fm8R9AWvfz+qGLeArJuVRy8
         oMztjIVdMRRoskhcKqBGe0+8+yJZEFOTGS42oIv3gn22SerrVzeuvvByNQ4c8NLa6OrL
         D39j1tEIMiJM/4VGmxvRHr1RIlXU2QOpHwnKOvDyPQKyTR8Srz4VCSgUW9E12LLksDYw
         B5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568699; x=1785173499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=354gFNaVuvmOpRh2GIKgIn4uIuwVXTK+d7q38SvtQbc=;
        b=UgCt92WRz16YKN5RoOdOmwSjZ00s6o4JBI3YBXwdIRpq+GZ358rlvdT94bxwBV+aqO
         O0K83QjpSf+aO4LNyi3PLgu6L3vmDrG8Q2SUdzb4ys/2ZigRp/LenuXcYwSaT5meBbeQ
         2xD7HUs0IZAsjw9KwUrgy4ceQm1EfxUyds2OaIs1b7jgbB9+6Dwy08OdqOaJtpW4vpcg
         C2oj26Zg3ujppV/pOkdilQ1np+ih7LDfcYZL3e13DQsYmTR2HrIET4MMGemDCoViWumQ
         5js0WJzhQLeqCrZjkwuRq44dZuKCi7XeDaWXvgdCwLGrduPQShxTY+PgdptsVyw0DUqX
         70Nw==
X-Gm-Message-State: AOJu0YwtGAkCc019YSKoGJ2QKHM42wApSCu+iSpWfa62pnUGtRhiElt+
	GfUbEKKXYPxeWmgUmWzebc7iEgnvq/MjUWTECmt6QPZBK8P6wqTw5tjyyh35v3J8iotLHkkWt3Q
	5Qii/aU1h
X-Gm-Gg: AR+sD12J9y+Hs23jNOtb7kvA6srVTHM9fbHXsvaxUM/oMCJsa4kuAW8tNcPY2YoT34r
	7WUGvnINrO2w/UDYv3+4HXd0le87yYIdTkDNhZiIWjawfPxY7Re0FclsSIImMNfITa+fgvjWliR
	K9WDJF1m/QMSru1x2J2y4+AJDlorp719mqpVRsCBbTo3tFwJDVjToG84kR1doZB1KVT0mnEe7Dp
	j8b4Gh4cObReekKQE3RhezryYteEdSpJ3zemEsaBYywhXWr2dGIvyGe0KSwhbZVJHZTSPASsBzu
	Wa4LaJ9dCMAUMT4jIki8JxYObxKowqW5Jx4vbQPmwKiHbwnHtYeG+ju5onJjjAcwiBjbGfyZtBm
	dr0fGK7yatzouIrhdAfgNhWrKrGgCfAUetRu6twVf5K7U3UQDioGyU8StKMUB34PD/n5NSIyult
	ElINwIfZGw7/RF9NnUtpfovnoNaafFtSD0rJl3yAQ=
X-Received: by 2002:a17:902:e349:b0:2c7:df7a:859a with SMTP id d9443c01a7336-2cf7b68e207mr1146615ad.15.1784568698588;
        Mon, 20 Jul 2026 10:31:38 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e921f2e1esm116328a91.0.2026.07.20.10.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:31:37 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:31:34 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 02/20] vfio: Export various helpers from VFIO
Message-ID: <20260720172344.GD1191959.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-3-vipinsh@google.com>
 <20260714153051.DDBCD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714153051.DDBCD1F00A3A@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:30:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing EXPORT_SYMBOL_GPL for vfio_pci_ops, violating the stated intent to export the variable for other modules.
> --
> 
> --- Patch [2]: [PATCH v5 02/20] vfio: Export various helpers from VFIO ---
> commit fcee4889ab47813a22592eb00c453edea425e0f0
> Author: Vipin Sharma <vipinsh@google.com>
> 
> vfio: Export various helpers from VFIO
> 
> This commit makes several vfio helpers and the vfio_pci_ops variable globally
> visible by removing their static declarations and adding them to headers. The
> stated intent is to export these symbols for use by other modules, such as
> the upcoming live update feature.
> 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 0c771064c0b84..1fb4b276afe7c 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
> >  	return 0;
> >  }
> >  
> > -static const struct vfio_device_ops vfio_pci_ops = {
> > +const struct vfio_device_ops vfio_pci_ops = {
> >  	.name		= "vfio-pci",
> 
> [Severity: Low]
> The commit message states the intent is to "Export these functions and
> variable for other modules to use them", but is there a missing
> EXPORT_SYMBOL_GPL(vfio_pci_ops) here?
> 
> The other helpers modified in this patch received an EXPORT_SYMBOL_GPL() tag,
> but vfio_pci_ops did not. Without it, external modules attempting to reference
> vfio_pci_ops will fail with unresolved symbol errors during the build.
> 

We don't need EXPORT_SYMBOL_GPL() because it is accessed in
vfio_pci_liveupdate.c which is compiled in the same module vfio-pci.ko
which has the definition.

I could have done better job in the commit message log to explain this. I
will fix it in the next version.

> >  	.init		= vfio_pci_core_init_dev,
> >  	.release	= vfio_pci_core_release_dev,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=2
