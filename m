Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3743711B
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571173; cv=none; b=mBnOhbba59YELm9QqycLuxbcpXyH6RDF/bF912HbfGVQ9IUQ5rLF1aIWEPrabJ3hTNcO/jOjKJygz524KOkAgMU6TzQDF1/qgmIqZg0h2tqrhqUlMu8S4yQaNVO4YPMWDeE8CufkgCITkB++5viflo2qdGw5zUdFAOG/fatwOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571173; c=relaxed/simple;
	bh=Ynfe6G02XWaPRrihbfperCWnlNOvk+Q31z7WR7ZtVF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMmdf9QBcHG7ZOlbJO+kB6IlN3xH8i/09JOPpO+WfeOiEDcENNhmdgsjadYFYeYffHNPHu1zhmbo+03P9GhKtUR38UKX/Gq6Ffb3OkoQBCsAiTiyRJQKf+RpnMZ5xcg0SYtkUnzxLaq6u/K8MbW9bqJ0+lMCcGNBzegx+4Uz88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJJkjLF8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJJkjLF8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacef7d299so394355ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784571171; x=1785175971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQg5MSn5GIQMrrHb/N0B6MSuNfWqtdsH4Etxd7dMb2I=;
        b=uJJkjLF8j4iWZD3/RJytyOhOqz2MAVuC8JcJS++RfkBrJtOADDMq+AoJWDnG0I465z
         2wpbfEC/+OimWmxViO4Rh1VPo9x+8jS5fK7Qcs+HKo96wkD33QDkUQBJ2/r+zVcDOwR4
         glDQ5qHiaOE/+3NP0Frh/xWg7mDrBDvGDnydyL96SLdYx7RH3+h/lA2XIQl43MOxMzgs
         o+n1ZZhzNaxT0B6chD3fDt0vQ/In/ZMpmKaIGSPoeN08ImkwxPVuxEfhYBKwQGo8wMyA
         yVG8NAC6KSMPN13ZaHKeG08jhiXRfrQiNEWwSUIhnKM9DsedNVfl0VKYFk+eRrFdEh6d
         XCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571171; x=1785175971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jQg5MSn5GIQMrrHb/N0B6MSuNfWqtdsH4Etxd7dMb2I=;
        b=PsiOWoO4z4vZqPpOM/JpjrbE3aAIwwFZbX5LFcXGwPWS345uxx3QDIQ050XHeopAr9
         GxVTyw0I6aPUXcudg3T7YynXouqOPL/6L3tZKzALkSwPiaL2aBXSO4EN7pL8SKPRJTLv
         rkrvwgenmPnJG5MRgwgiyZfu3QHKPT7WdpnP+9hX/8Z2XCW+61F6Phhv4m/J9wAs17z8
         P6JOJDMZF09WjGBpheK45/GC8/fhipXD3RevnbhGAhQtY8iGSXuZRQqFVw7xUbHEDafQ
         B2yNwyAFLhUbTQnOMbn0keCD7qsSGebxZrRdIM61wQZwjSCA2D9Sczp2tBwytCbGalb4
         MUxw==
X-Gm-Message-State: AOJu0Ywtt9A9uGpAtgQ0jqHWuVrp7VOUKTuBb0jWKGMjNbRbBmxlTAiD
	bPs7daFCWxOC1IEcI2TIRRPMfoGvKluGREBbwYuQYYmB9slvwPH0ea+eVhfHAIBiEg==
X-Gm-Gg: AR+sD11jSQbAH7uEsq3uo5+nl2GIsmQAElZkZxCMIDiIgx83jYefhRU2RaKioK1ivzL
	a19r9r+TsCvcDUbLSpr0u6gNILQrOv3g4BWfWmhDiZMzLTs1f3MI5+11c/eJgSsdJVhL2C48vok
	DXfvXkkXAHlzGnzeXu4NIBunyXMboEXijGtssFjFSstxiFXENQkud5eHt6CtMA0wPIoK8ytA6GT
	bPDidFFE2p31nJzqfEcqKawZ498sl0We6BZxwW74SGnL37sOIWINQ7Dgfb3RHEAS6CdiChPugkD
	Il5EPlYBqXoF4PNk237+Ss4Suodxrjy6Tj9qWCvkFP7yMUGD0nYjBgScZDPzjCeufuTccFsqO5V
	roIpCt3e6zv9fogPhR466CaZq12y+lF4z2pWTyJFpOYdi7Z5VityFABgWAbbDpDdNht6tWpekaq
	n8UGib4E8bt0L3OFn+lDo2avzqJL8aPOCG3txh
X-Received: by 2002:a17:902:ec92:b0:2ce:f9e2:4646 with SMTP id d9443c01a7336-2cf7b71d50emr1730055ad.27.1784571170441;
        Mon, 20 Jul 2026 11:12:50 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448db72sm62309825ad.1.2026.07.20.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:12:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:12:45 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 14/20] vfio: selftests: Add
 vfio_pci_liveupdate_uapi_test
Message-ID: <20260720181201.GE1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-15-vipinsh@google.com>
 <20260714154402.D3C651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714154402.D3C651F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:44:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The selftest `vfio_pci_liveupdate_uapi_test.c` fails to compile and link due to missing headers, libraries, and undefined functions.
> --
> 
> --- Patch [14]: [PATCH v5 14/20] vfio: selftests: Add vfio_pci_liveupdate_uapi_test ---
> commit 4ef2d85343eb23f4f743330b67aabe0e09e08f3d
> Author: David Matlack <dmatlack@google.com>
> 
> vfio: selftests: Add vfio_pci_liveupdate_uapi_test
> 
> This commit adds a selftest to exercise preserving various VFIO files
> through /dev/liveupdate. It verifies that VFIO cdev device files can be
> preserved while group-based device files, group files, and container files
> fail.
> 
> > diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
> > new file mode 100644
> > index 0000000000000..f81c8ab21db3f
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <libliveupdate.h>
> 
> [Severity: Low]
> Does this header file exist in the tree? The build fails because
> <libliveupdate.h> cannot be found. 
> 
> Additionally, is the Makefile missing an include for
> ../liveupdate/lib/libliveupdate.mk to ensure the dependencies are properly
> pulled in for the build?

This series is built on top of in-progress Live Update series.
https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/

Same for the other issue below.

> 
> > +#include <libvfio.h>
> > +#include <kselftest_harness.h>
> 
> [ ... ]
> 
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> > +{
> > +	int ret;
> > +
> > +	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
> 
> [Severity: Low]
> Is this calling a kernel-space function from a user-space selftest?
> 
> Looking at the code, luo_session_preserve_fd() appears to be defined in
> kernel/liveupdate/luo_session.c. Since this is a user-space selftest,
> calling it here results in an undefined reference during compilation. 
> 
> Should this be invoking an ioctl directly, or is there a user-space library
> wrapper intended to be used instead?
> 
> > +
> > +	/* Preservation should only be supported for VFIO cdev files. */
> > +	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=14
