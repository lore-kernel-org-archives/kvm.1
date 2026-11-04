Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809864;
	b=kGB7bCu5u/WlTB29uJ2ZGkhUAntYwQ5iaJdjFqUPqoIyVxNLUk0zTdmJXMXQ3tMlEABX
	 rYhcKot/IbOslF3qxlUYxJBlvMhq04hunGAxjCeFecEE+zj6xAhQ3leAlY9ylIakfMXAt
	 G00sLIo56TaaXvAXCM26PvevhLneQ2b/ZEzj7GoqGEIrlNGyggbAjyuT4IRFDqELdp4Ex
	 +1AHVK0vVYf2R/3U42UZpMhxjM6w1FjjQVt8q4prVef7Dcr7UYINPIyR1ExrlsVlMT6Zx
	 Kqo7hhBy6EBW+pmA6pUAZPtyfwmZl1NkQed+GVMgQZL1rU/f0mBwtUbgQhDV+snzhFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NyjRNFEeE3nmYhNk8vaSRwH7n51z01zX9N7rg1mXM0E=;
	b=PkMvzi8l4m6W0WFG5bj0y442Z5QfM7iuWQehCp/1utqe71liQcLSmv0vRkkbRakhnUId
	 S5H742i9bQleUhVkFrjiNzrTdH79j171V3FC8KiTzCK6eruhJoywmtXemyo79NIcHn3al
	 3SRnmFqAvIfeacRGYFYwVmCGqZuFEoajw6be6423BAOWKro7veZEvwPcFMTj9DzP+4+3L
	 DNhXI/ObU9HD7w93X8SfW3QNuRZRH4h1jgz+hZQczO33/Yi2zR3irJcLAPg/ahhQhT+wf
	 kxlbDIMrbRD6eXecwHc9mm2m1EzYVXO5fldZ8RZyWS7gg2GDpina3oGViypJtEe3tcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OdxaJB4E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C3606A329
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 16:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 111C3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OdxaJB4E
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso12248a12.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 08:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793809862; cv=none;
        d=google.com; s=arc-20260327;
        b=epXpdjtQTNNm33yHkmjpVrgHJIG3wk0C9Xxi0qW35izbngdGckEOXI7Cyi6SgM5bEv
         5SdzFQhmUMBICKoBZbgwUd0+HpJlj3qPyH427jRtnSIIj2tUnTtzVcoBKjORyBXhnifX
         +66am/ADXMz8agfsf0p/hNUPjf5aT5xFb0IPnmOIrULDthUWwxCPa9T9b1f6ZH9aatAN
         nbl+h+oChtSaFjC0pSZpDlL3XCibkQGPpkpBhei0lEmLG3S3y8Cfqw/9IwBjN/KnoxEm
         jV9dnHQ7xYUAxZMEtrWoIsr54ILTLos237LW0imVm8YRCoUAHWeYFLEwFT7yFoQAjr/U
         vMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyjRNFEeE3nmYhNk8vaSRwH7n51z01zX9N7rg1mXM0E=;
        fh=/O9Xqg1uVfGnt9m8i56nQljtAWU0hjCRwdWu0X3mLhU=;
        b=rwcAZu8zYiivuOdMN9k13bolJaprKcJV4Q5oHtrr2kA0y9RITgkNVcgC157nBJOzEv
         OL1ugqALS0nF5qIJrt71QE7T8UYbOAum5KSMzVb5aTlqMag2kMGnxeMsu/T02Q3nhTvl
         xSDbFVgVRIel2UomnmhnzzrUSOkrEv0cvODMgkekGHk1wyIB67w/UQ08c6fqnIk9Px/l
         kwGlZd8BSnURc20/Q2tY6dzS2eaTe2/YQdeXAeer17QF6Wbb74umd0Vkmy17a3fJWMF8
         noBZo+6yDt5ROzG7Hz8KuI6lkmutEbzYKZMdDxjFcgQL4BR/vHQc47eJSMAOG3sZs5VJ
         vKDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793809862; x=1794414662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NyjRNFEeE3nmYhNk8vaSRwH7n51z01zX9N7rg1mXM0E=;
        b=OdxaJB4EnDuV4Hidcru6kJitmdCqTBvMRu1+/AxM8mR29nxWHSzf1TGPtq08Q/FyeM
         BqiQ5UWsRtRzykRX9dHeDcMk+iJsYuP0Kdmb/FZTBnu31lJYAGiEwb2qv4bwAIm5qaGL
         IAHFIVaAlQ6RQHbPq3KVPxtIMj+aqGjGQz6ZxauYWKTClbyEeG1+dphKJcJLdKuhRKSF
         u+0Tycys46CnLNZ0EObmu0V61pUHh0NUS71EPx9l3Ys2ZgQT5SXC5pwkna3a5yBsZ+cn
         xLnBUt5xe4nNJKHPDJ61g3w9xSDjOZtQz1k8hoiXujknHw3C9rCYb8zZUkZTFkbh4cdD
         ADBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809862; x=1794414662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyjRNFEeE3nmYhNk8vaSRwH7n51z01zX9N7rg1mXM0E=;
        b=PxpNHZvoyof7iJbtKj+poaL59L9NQleyZbcHMs6RknxkgZlKb+UAuymH2rp8K4NbvV
         hVfZr/qqHN3C1UmlH09Y9s1Zfx3uQ99Y1nmBbj/WGVHa0nfO28JOVGy5TM0aqch2IIIK
         okkA5W6oybIzb1ekW9kItKBYuHmR8zI+VteZOjhOeo12mak2zheAtOiZxaoj/Ieo+xXM
         wlRfFKsK9S2nIvYBsvAs0lh/av2QkHf+9xypWOSRw+ZVSXhZzaoXznaaV6adqGwuTVLm
         XuofxgMvo2f2CRmvpRDkweEkoWCdTHW6kfigBT09mK2jMgHZIPv/XSNiZRakwlw0T5uh
         GSuA==
X-Forwarded-Encrypted: i=1; AKwUvBwCS2jtt7WywMgJ1QuPkxhNWdZMQndTCnND/4zoTECoJgE5NnqE/fT/28/hPHVSAiKo7ww=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ixhwHWbR9G80A95a3yy1NSIkyGNPA7ij3oHeZLYeBfIpbplf3
	LpYeky1vn3nWz2Kel8cmj/SJEOP0jHxwOcY2JxMPbh0ru1eDq8uQTam1lNi32gjMIcd1t8xdWny
	9KupYwOQywBrF4KLwcpTPBrezqCvkhgLchdUtkbkl
X-Gm-Gg: AYBFou0hWCeC6VyWfLco18Ui69zvN2ltfb8ahHxd5PbZmAB37SNuQXil+mDYNgm/ugp
	otOxa0JQEtoedl52T+iXyfcnN5oA/Fol3xe8gd0/BcKUNTi9rZwRxcH0LLx+kePVitOkmtZxFRu
	Vslpn9sGan1p3VPLpn4TKWJJCqAwaobvIYPFiUILZr6sAAT8wlJrr6AOe3zlF1HRruYQ72lffzE
	9o8ONj7H66RBvLuTsI/ltSgy7hmkYeO9yliL5rIV26TvjsWxWbCaMbnTBDgj+punm8gY58CKR2X
	9fUajdlrnoR6ngWTxe0DXq/Q9pnZjIQJ0gbOo0PT+qb8+BFPNHvDDuQ8JkXjkUG7wVChpF55gL/
	FcNqEFypHbJRvAZ6pFoAZJGxx8rSAeaBFtsjQmxKgdHi7nzV1Cpn102T4QWfpJwMnkA==
X-Received: by 2002:aa7:d647:0:b0:6b4:629a:6352 with SMTP id
 4fb4d7f45d1cf-6b556219774mr85656a12.5.1793809861709; Wed, 04 Nov 2026
 08:31:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102230445.3993629-1-almasrymina@google.com>
 <20261102230445.3993629-4-almasrymina@google.com> <20261103102721.5d76c471@shazbot.org>
In-Reply-To: <20261103102721.5d76c471@shazbot.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 4 Nov 2026 08:30:50 -0800
X-Gm-Features: AclHuK-9GylVYqo-TMtSosiXb5Ui2K5HFBRmFtb7498f4BCUrjDMBqO1v8NJ_60
Message-ID: <CAHS8izPfFpNQWLFW4Xgf_=vF5j37_Z7XDcuPMJXHj-KQzo=8jQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vfio: selftests: Test BAR write faults after clear_refs
To: Alex Williamson <alex@shazbot.org>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>, 
	Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:27=E2=80=AFAM Alex Williamson <alex@shazbot.org> w=
rote:
>
> On Mon,  2 Nov 2026 23:04:45 +0000
> Mina Almasry <almasrymina@google.com> wrote:
>
> > Add a regression test in vfio_pci_device_test to verify that huge_fault
> > on writable MAP_SHARED VFIO PCI BAR mappings handles write faults after
> > soft-dirty tracking clears VM_SOFTDIRTY and downgrades vma->vm_page_pro=
t
> > to read-only via /proc/self/clear_refs ("4").
> >
> > Use vfio_pci_find_mem_bar() to locate a memory-backed BAR of at least
> > 2 MiB that is safe to read and write, and zap existing BAR mappings via
> > PCI_COMMAND_MEMORY before each sub-test to verify both:
> >
> > 1. Read-then-write fault sequence after clear_refs, exercising in-place
> >    huge PMD/PUD write-protection upgrade via wp_huge_pmd()/wp_huge_pud(=
).
> > 2. Direct initial write fault on an unpopulated BAR VMA after clear_ref=
s,
> >    exercising vmf_insert_pfn_pmd()/vmf_insert_pfn_pud() with
> >    FAULT_FLAG_WRITE set.
> >
> > Skip gracefully when the device has no known memory-backed BAR >=3D 2 M=
iB
> > or when /proc/self/clear_refs soft-dirty tracking (CONFIG_MEM_SOFT_DIRT=
Y)
> > is unavailable.
> >
> > Suggested-by: Alex Williamson <alex@shazbot.org>
> > Cc: David Matlack <dmatlack@google.com>
> > Cc: Matt Evans <matt@ozlabs.org>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >  .../selftests/vfio/vfio_pci_device_test.c     | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tool=
s/testing/selftests/vfio/vfio_pci_device_test.c
> > index 93c11fd5e081..323a316f59e7 100644
> > --- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
> > +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> > @@ -1,10 +1,13 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > +#include <errno.h>
> >  #include <fcntl.h>
> >  #include <stdlib.h>
> > +#include <unistd.h>
> >
> >  #include <sys/ioctl.h>
> >  #include <sys/mman.h>
> >
> > +#include <linux/compiler.h>
> >  #include <linux/limits.h>
> >  #include <linux/pci_regs.h>
> >  #include <linux/sizes.h>
> > @@ -102,6 +105,68 @@ TEST_F(vfio_pci_device_test, validate_bars)
> >       }
> >  }
> >
> > +static void zap_bar_mappings(struct vfio_pci_device *device)
> > +{
> > +     vfio_pci_cmd_clear(device, PCI_COMMAND_MEMORY);
> > +     vfio_pci_cmd_set(device, PCI_COMMAND_MEMORY);
> > +}
> > +
> > +static int clear_soft_dirty_refs(void)
> > +{
> > +     ssize_t ret;
> > +     int fd;
> > +
> > +     fd =3D open("/proc/self/clear_refs", O_WRONLY);
> > +     if (fd < 0)
> > +             return -errno;
> > +
> > +     ret =3D write(fd, "4\n", 2);
> > +     if (ret < 0)
> > +             ret =3D -errno;
> > +     else
> > +             VFIO_ASSERT_EQ(ret, 2);
> > +
> > +     VFIO_ASSERT_EQ(close(fd), 0);
> > +     return ret < 0 ? ret : 0;
> > +}
> > +
> > +TEST_F(vfio_pci_device_test, bar_write_fault_after_clear_refs)
> > +{
> > +     struct vfio_pci_mem_bar mem_bar;
> > +     int ret;
> > +     u32 val;
> > +
> > +     if (!vfio_pci_find_mem_bar(self->device, SZ_2M, &mem_bar))
> > +             SKIP(return, "No memory-backed BAR >=3D 2M on %s\n", devi=
ce_bdf);
> > +
> > +     zap_bar_mappings(self->device);
> > +
> > +     ret =3D clear_soft_dirty_refs();
> > +     if (ret =3D=3D -ENOENT || ret =3D=3D -EINVAL)
> > +             SKIP(return, "soft-dirty clear_refs unsupported (%d)\n", =
ret);
>
> My comment on v2 that this doesn't accurately test whether soft-dirty
> is supported, potentially leading to a false pass still stands.
>
> Please also have the courtesy to give reasonable time for review before
> a respin.  Personally I would expect self review and testing to take
> longer than the 80 minutes between David's feedback and v3.  Thanks,
>

Ack, my apologies. Will do.

--=20
Thanks,
Mina
