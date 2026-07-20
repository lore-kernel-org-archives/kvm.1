Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D2388392
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571082; cv=none; b=VOrjVZhqobkj8tp+9c89+LTzyxGqFOR/OXIrocD1dUmwSraAETO3pFp/Lm6zNvCQ6OA+CQiCdqCu663YXKw/YfQpRbYjSAIgKCT46r/QcJ999Wtguc4XfRTr7nUTcnLJYBgR+67VYT/h9kVaMiE2y4HB2LPQBxEULeMQhfhff2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571082; c=relaxed/simple;
	bh=uRW2VCAeEQivysKbAUs/GHTCeHX+/o3EZ2/q9a1Csp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+/ZfgkRGkmX0Sn7KfsVlFCjBw/mpIs/tTr3RKEhgi6tIFa77gSuGtp7PJ1g9UsgCTl8fPVFzSodm6PGgPJguhhzb6c0ghxLIA9xfUsmh4x5fnJkvgZcQm+yyqChYtbn14PM2VxFXxQoEO2KqJNps+BD7vW+wqS+e5M4x/UgzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gmz+Kr2i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gmz+Kr2i"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cede6375caso354955ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784571080; x=1785175880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hPymPRaw1274m7xN6MjIxFPUWx7r7j9/WwTuQBapZM=;
        b=Gmz+Kr2ihnHxOnO7Gq8HuoEK2CwwTONEqwrSnHbIcCKWCm/DXyfKFDF8wFoPTI5EES
         483cr5kPaBgRY6iFPkPr3hFCiOqwQwC0/c8B4o50ZSOQUNNm1Pl6oBFcpHKeN2JgbY5o
         Y57rkGKj2RFzFg3AQdf9wI0ooVzAzvnY0uGKCe/peKsBo+D83seNtXPsJ5MciA42qzus
         VvVPeWRsYmU5ZHTehlB4pNDZGCIK2cLxQxpNAlW1GzILMavKWfwkvQG53rzu/FWgJ4Sk
         ZvX+yiSnrYPj2xkkf+57b18vS7BRknaTEAyXIWSLOwNyiC6VkYhbJwRFQYgOdtVxrueE
         8GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571080; x=1785175880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2hPymPRaw1274m7xN6MjIxFPUWx7r7j9/WwTuQBapZM=;
        b=Do/XBS0f0V1uapC5JS5vO3QrxugbZShiTQIYN31hlPdrVUtQ4dP1T1O9inwk33w00w
         Nna/FKd+q0IKcMcb5CJplGPAUi5wrklUOzGNFk4JpJFpMYorvrmndZep6nkRwlEwIjPr
         rSFF+R08hB7axN8p4+rRqVbewuriCtsrSByZ+VjMx+NCBlm49YN73tko9dzazLkROcEJ
         tuhj8KOPqouZfeGINe5mNY/yzbacR+D3S4O2bzei3wvD+dZmofOgLtuVhwWi9GTJxVbX
         mKBE7m6Or32DB4pFMN51PVoI1rvPE59nm3xs3Jq+UmHSsJUjJsySmIvB5XvqAMWTwLaB
         JPYw==
X-Gm-Message-State: AOJu0YzwY/LaILMnKO/K9v153ULHjoSCLGNdUldUojxjmhwG+V37guId
	nt3EeRXbpaHZjKqQJDy3zO8FDScUZFh+toW9gIPGM04b782s5ZeTKy3Sq7j3998gpOtOm7yVJXs
	F5FpQeOQ4ZQA=
X-Gm-Gg: AR+sD11UVKGlwE5CeqgulUR3LKjVOL74+kN3S6+nXoNnK485czd8Sv7j0ecMhAsRmn/
	nrHtjAJ1AvDJCI8Bno/IyJZ++8a5lci02LYvkeFwVwk0UU8xKiFcIQ0LYkxJANt7StnNbtBl1dH
	Rd7YBNJ8Mh6Vf2zfj2jQAsDEg4+ThRopunRnFbOLpv7q2PjdIuENrRWQxNC7u2a/GymirWYUS8v
	v43vOXUfrO32UdN05DhvD6mJGs5EweMMUSvyCSYQsOpkZjQP1w7k+89KrauoYiJyeuYc/12ZHiB
	MrIO4Xu+KOEJJB1ceRG3oFz4QZxKeJyb9vHBCkwnGP37GeovVDpUr36pFmOy+/zHOYJ7C5aDqn9
	AA0fWRgTdmAwanBwJnhVmnXfVeWO0Hgx56ddugUHXCNHF8vQLLSL5+CYnTmjahvBdQ+V8uTGaR9
	XiOBSuBTJN/n4BHNCNNz0DrEd2hsgAMtjoVpz48PNhDhsdvBA=
X-Received: by 2002:a17:903:b4f:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2cf7b6fd8admr1656055ad.25.1784571079509;
        Mon, 20 Jul 2026 11:11:19 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9208f6bdsm171534a91.5.2026.07.20.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:11:18 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:11:14 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 13/20] vfio: selftests: Build liveupdate library in
 VFIO selftests
Message-ID: <20260720181023.GD1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-14-vipinsh@google.com>
 <20260714152031.CB1DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714152031.CB1DF1F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:20:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The VFIO selftests Makefile includes a non-existent file `../liveupdate/lib/libliveupdate.mk`, which breaks the build.
> --
> 
> --- Patch [13]: [PATCH v5 13/20] vfio: selftests: Build liveupdate library in VFIO selftests ---
> commit 8a41a1e6305bdbe73648566ef65764a964e68dbb
> Author: Vipin Sharma <vipinsh@google.com>
> 
> vfio: selftests: Build liveupdate library in VFIO selftests
> 
> This commit imports and builds the liveupdate selftest library within the
> VFIO selftests to allow using liveupdate ioctls.
> 
> > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > --- a/tools/testing/selftests/vfio/Makefile
> > +++ b/tools/testing/selftests/vfio/Makefile
> > @@ -21,6 +21,7 @@ TEST_FILES += scripts/setup.sh
> >  
> >  include ../lib.mk
> >  include lib/libvfio.mk
> > +include ../liveupdate/lib/libliveupdate.mk
> 
> [Severity: Low]
> Does this file exist in the tree? Including this missing file causes a fatal
> build error when running make in the vfio selftests directory because
> ../liveupdate/lib/libliveupdate.mk cannot be found. Was the liveupdate
> library intended to be added in a prerequisite patch that was missed?
> 

This is series is built on in-progress PCI Live Update series.
https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=13
