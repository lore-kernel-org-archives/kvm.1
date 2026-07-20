Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC3388392
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571249; cv=none; b=dhR0YmTsQYaonaLjMtpb7+96NzhFQj3VDoLzKdAHMmPvQ0OXWe5nYlwuEdELWwxBPi0I9pGe8OtNMTr1smobuQU/ilCz5FF1CWo4tLRTDVp2YaWfI8VaRGma4Qk3JRnE98aTMKeuPNNvEIeiKoRnrQ57qdr//P6yagtXp4CbQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571249; c=relaxed/simple;
	bh=+qvA1DAn3c4tmHb756vc3gqaw+6jkHIGpCUavjx6dPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQRLG+a7AtxXI1PXfTKZzkifkPb2CnlZLvMBVdGQPh585ESbf09fsnG0m/Pc3JtH3yv5UfAjppNq4/w9Uzt57a6VQ+zDi+dCGBJteZD+pfgStxIYWm7e+veUkISu5ne1reh790f8gHYwuh96J0fCAWqrfUbiPa9Q9+QcftGsVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENhhZzYE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENhhZzYE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cab97c86bdso424265ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784571247; x=1785176047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oSA8tKdyLlHK1z/E0CUcnY7QLdvcjeQOvJxYi4x9Gk=;
        b=ENhhZzYE3QqezhlFaXObm2sUEJuhSHw5fOZEBXdbNRzlIE99/ubbLTF31FmN+fX5y4
         TH9zoqmyKGRjahRM8VymrG8K5OWL73j9ErwaNbWRNQXjrGc/ic/8YqPFWw1MsOe6/JYo
         drLnlwqnfYtFNkcY/NiFgrkpsKEEaYo2NDxCWcsXHRHdrc4iDtEyrhwXuIkVLlQv/5DM
         B/nJuE6XXFwNmKJ3FQFpwp5M77sEXpia7usi0rgI36Rql1GisORNHk2j6xTUNMhP24G9
         RTcdqJur51VOsMqs5gAymWQtnuL0afEcMNa2MpXLO5DJpBs6e0f+pzuu+jqDbfiZ4Um/
         L9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571247; x=1785176047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2oSA8tKdyLlHK1z/E0CUcnY7QLdvcjeQOvJxYi4x9Gk=;
        b=iA8KcLYlOpj3DGUo1Z9ekP6SOO/5WoOMCM/wxsG5EXpOfRySiK6RXjajriz7EiRnkB
         IDAtKRc9PYD0vi8ZrI5TRNcxJGIwituTkJI4X/PXQEBL28vz2FgoeQgcoDsPJvHQEr3p
         iEArQJIKFrYO03vzG6sGoe1Ph7CKVj/qNzD5VJfffToNUHxThpBmIAe3a9I9cSffkYjd
         dKr/hlFF72PLd0zYXdbWLqZ05RE/4NLJIiMSBoie7uSxx3yZqgGYTj3aBVLkCcRk0lF2
         cQ31DKdymg1JXVpu6bsSTxaLCLuB8es9V5hyTy6X/zAhMVS8359LlZ4/8wI7SyqhSfc2
         I7dA==
X-Gm-Message-State: AOJu0Yxncqwur8sAbM0IZ9Kzc+VDeZUxSxpMK6s0zVmlD+zs2PiPRnND
	PUUBPXOzEGZcaleQIxn88wvZ6K0IC/wz+HyN3D9kMR9Hy4RgxDiIZ/FE8oaRZyYsIFdJrGW9ZED
	v2qYjSfKtipE=
X-Gm-Gg: AR+sD11owYciadcL8ZAQzmIawkIuGvodG1cpZ0zXQMHxrI3j/OF3HC/Jwn6A4KDgWrY
	O72TL3gN4jKrgKjY/gqAFi9dP8/SC9wzAXSLOgiDBmIX4qoOoMwXW2xB+JI0aoAZoeppuUluvij
	wFbL4x+gFJP3kH8bqmUgErqKJ/SdCL1jZEFPLrxaLeFa1W1IulczquJC+i3zVgjhuE0Gni7y3IX
	7R5ANiBU9qYP7AMkeAGt8Kf3ZyWuseNXTdc0SJx0Q/HQATaH36uQ/pQBeCB0njnXIg3OVo6/rp7
	Iw6m0q/5mwa1H2fsaliE50Mq4dOEv2r8sWQfVJKjvSYymtGHX2If2X1giB/AbjNyihq4HVWVxiJ
	DUcKAKjIEVEBbnOnNEjSWXBRCIbhVhovVB4AXz9sWHJgfrCFqLe6Ioa2zVUtI5HJz4t0Aka+zEG
	Oos9xr1TahWMIBtOqc+aBjePkt4kS2VyCTWa2md9Gx5f+LY+fVGEp1Yf0azA==
X-Received: by 2002:a17:903:4084:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2cf7b35e690mr1165405ad.0.1784571246672;
        Mon, 20 Jul 2026 11:14:06 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e921f2e1esm169813a91.0.2026.07.20.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:14:05 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:14:02 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
Message-ID: <20260720181313.GF1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
 <20260714153527.2F8311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714153527.2F8311F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:35:26PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing header and Makefile dependencies for liveupdate library.
> --
> 
> --- Patch [17]: [PATCH v5 17/20] vfio: selftests: Add vfio_pci_liveupdate_kexec_test ---
> commit 5f1d9fcb84decd9a67e94d71a492e75ba0113c1b
> Author: Vipin Sharma <vipinsh@google.com>
> 
> vfio: selftests: Add vfio_pci_liveupdate_kexec_test
> 
> This commit adds a new selftest to exercise preserving a vfio-pci device
> across a Live Update. The test verifies that the device file can be
> preserved before kexec and retrieved afterward.
> 
> > diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> > new file mode 100644
> > index 0000000000000..15b3e3af91d1e
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <libliveupdate.h>
> 
> [Severity: Low]
> Does this header file exist in the tree? It looks like this could cause a
> build failure because libliveupdate.h cannot be found. The other liveupdate
> selftests appear to rely on luo_test_utils.h or direct ioctl calls instead
> of a libliveupdate library.
> 

This series is on top of in-progress PCI Live Update series.
https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/

Same for the below issues.

> [ ... ]
> 
> > +static void before_kexec(int luo_fd)
> > +{
> > +	struct vfio_pci_device *device;
> 
> [ ... ]
> 
> > +	printf("Preserving device in session\n");
> > +	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
> 
> [Severity: Low]
> Will this result in a linker error? It seems luo_session_preserve_fd is
> undefined without the accompanying library implementation. Should this test
> use direct ioctls or are there missing Makefile dependencies for a library?
> 
> [ ... ]
> 
> > +static void after_kexec(int luo_fd, int state_session_fd)
> > +{
> > +	struct vfio_pci_device *device;
> 
> [ ... ]
> 
> > +	printf("Retrieving the device FD from LUO\n");
> > +	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
> 
> [Severity: Low]
> Similarly here in after_kexec(), is luo_session_retrieve_fd implemented
> elsewhere in the test suite? It looks like this will also fail to link.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=17
