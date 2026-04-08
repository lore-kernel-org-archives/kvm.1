Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297F30F92E
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663206; cv=pass; b=Ou0gy7VQK2OyylpMJ9ZLsczxXFZ/JT8cO4Dh1zc20UC4ESe4gLoKc8y5ej2riQPsnfDuEgMjpC2cPe9Ho1LBrnMyLsCXsXsXqc/R+WwcH5xDEJT/le+Z8IVSsTBLf5VEDJu+KegLc0ChwkDL5rSLZgHwqPXDiorfXMuxTr+cbPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663206; c=relaxed/simple;
	bh=iGlCaY95ctxPFwq4DGpRgakAtitHOMVBv7GGqPpjlO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk/3hpIvS6iGbt0dhFaBxcWXuVhhTBI9OcjvT2Z0uYk4nlIt3FJnPPhPIflkkERds98zOzmpPSrKh0OlRbT5mYSw2jWIBMQTVYIJYzYO8HL9MLNlMA/5KIvYYo+keH/Ptw9cr1zrMjHqJXz2YCsYxpX628Ie+gzgIp5uQg6d2ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A61IdsmA; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A61IdsmA"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d864c23bdso647901cf.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 08:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775663203; cv=none;
        d=google.com; s=arc-20240605;
        b=CObo3dwykXeIuSDOH6UB28HklKhUodT5v1XTwtVHfrbE/pnWwGAcpiR5fgpbXDnR79
         js0IoxM3NtCT/IgUFObyNKvlRIOV2zTQ7uwCXx0UUI7/aQhQftX92ZcBVDW/Ht4MAk2M
         ej6L2jylWx7dYoT4Ek47+qJ7T/w1C0YIMtdojh/AdNFSxaQJwk7L/bzLXX31jMZLpvlv
         5GEg41lOchMtzdiTw7h9fec9ucculTH0ALJswSFySkmkYgn+xpSvGDczsl7cImFj4Jmx
         /hfqQHqaQpqpCaj0ywv/WeS+tu6nx6atQeR00tYJqF9spmATv/LTNLKGlRC9oZoL0c82
         qKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZO1prpPysVLOyKd64GrZa335iN1sGomEoXMxaEuq4RE=;
        fh=7lFnZ+nwgQFVavV/XzURXJvjDfh41EVtMWfjtyq3t4k=;
        b=Vgz1iL27pTRgrywvsPj1Can3I+cF3CVU32/A97VwmCn1F1o7Ks3AHoTdxVFRv9AMUB
         HjPlxvbnSn889Tg2bqghRKwWXUUniguEpj3ZGhJpwWiPLjExuEze6tQXFmTvKK0UZK64
         rrzEXHS8q5WqsGnuzoKfaI1gGqXjQHp+ZpDesuu392KKQEoHVhndNPGGTheNx/sPzkRv
         UK0UCHbmC90nEznAD4sAcTbQG/Qr23DxvGlIASJMYkE+yuO6VXRGiyUFWymgFY3llysJ
         OukGpOSSisk8DrMlwEpUyWXpjph1WA5Hp8st8pPmYL+/uqw8r8ZsN3G+7EXosdeb/fDo
         Ft+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775663203; x=1776268003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO1prpPysVLOyKd64GrZa335iN1sGomEoXMxaEuq4RE=;
        b=A61IdsmAeyu4v4TIHrbflB4aEwBkhEOqZhpLYtZaNruV7zJdppuQhZbPAEcwisYEtv
         L/Z5rRggWHQ3ss3GbpS5WWu2fYVBB5wgihvYtVVcdQTN273R3DAKbaoZRqsPxnEpmtO0
         A1WfJyXn28m68LdT8GDoAZskewJn6Fcgzwi2j9dCiE79TMgZMsp9y4IYONhiOAcxzr8P
         +en3dwLMNnUEyvIWJqj0ts69JrS7qZIKf+9vwD+TdBT6RTtqbVBGwx+bsQ3UZjFWiD8x
         WWCDL4cyO2e7vvq88K+PTasBc1CXMKg28O1l0JBz18ri+pervnlyJQoEQdrMSSkObk1d
         Y6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663203; x=1776268003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZO1prpPysVLOyKd64GrZa335iN1sGomEoXMxaEuq4RE=;
        b=mpKEexUmd5LkOsyf17JgSxso/lioHjSxy4JXlM6XO1iEWE0JRw6JLKxIn4m8kQQKPu
         OR0rI2ZRYsUp0VWI5/B1JWD100yGd1f0zPTPvHTQp8FP+uav5bpO+/kWD6VTSCEY40qC
         3KVnmJtJ302FWYGKJuJRUqJ74VndcpQ4RUaabFAPV/80NvPWkpWOka23bFCG/xDHPkrE
         oYU7YY1GsD/8t5EweobbMXyY5LvLS2JkRwBfG6n9xhNWTHTXhrPvSMWC0aioEcCsHu6m
         AkV8ERa9Os1/CyHYJRYi9y/qKn/uomIf4xKL0W/vAdgVFDYSAi1H6J7KR3Mi5KGa9I+U
         aJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQWpjwbidYRvCOd+RVNng6g6ukUG8IR+BegDfy3K8ddUOg7PJYRgbAXpLl5dKLUzBCf/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mRWC/HCYlKoLXgWOyGNJiBGsspP4nt702TChCoDrqeJfIcH9
	ALtEiSxSH076P98N2roNUKowls3iKEiFu2d1/MyfBnM75dGL2frYVrcG0UMCliipS/keCm1lAXw
	sLdciX0s48SAIKQUWGhbayVp4OObz0oaA8ZXCNaca
X-Gm-Gg: AeBDiev2m7vuBLoXc2UnFXI3fenrQcipZWAQDVCzo9ZPOvSkWFp8p+XleRViZHFHf2u
	JGJHHQc1yqWpscnYssEKniZ5JMPkLXvoBnSLCAd3ad2Rt+wGA/+VE3tXFBxGQr9jqs7cnyMeenB
	hIOBVGzI4FBuzwabu3g1X4xnda6YmfwMjHRCrqayQx/+o35lKKiVVjABYCbTRn5uTqL/jJZR/+w
	bMMuHDkxgOPqyBwBz8LTqRpCvLiezKbtLfaOArLDCpdmSoUp3jq15zk4r+/2h8RSZYzgKFcIGjD
	mVvDlD7bYTH7r1AjSZyPbvNueo6tvDWsjSupdw==
X-Received: by 2002:a05:622a:684b:10b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-50dbe119703mr336571cf.0.1775663202429; Wed, 08 Apr 2026
 08:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHc60zTBn9xMksi-_UBK=W07rp2vGVZ9ToYhFyadNz4zCVHAA@mail.gmail.com>
 <20260406223428.GK2551565@ziepe.ca> <9eea53cd-77a7-474c-a552-92f3531f13b3@app.fastmail.com>
In-Reply-To: <9eea53cd-77a7-474c-a552-92f3531f13b3@app.fastmail.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 8 Apr 2026 08:46:30 -0700
X-Gm-Features: AQROBzC7jAFG31AnwyQJXAuZvzekkebL_ahv65C4jCpFAAdmu_3OBL-hSAmzAYU
Message-ID: <CAJHc60yiJEfKxyv=to+QWXxuGNyzMW9h7gqhOrC_tnT6M_D6nQ@mail.gmail.com>
Subject: Re: [RFC] Observed lockdep circular dependency in SR-IOV paths
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:00=E2=80=AFPM Alex Williamson <alex@shazbot.org> w=
rote:
>
> On Mon, Apr 6, 2026, at 4:34 PM, Jason Gunthorpe wrote:
> > On Tue, Mar 31, 2026 at 10:23:06AM -0700, Raghavendra Rao Ananta wrote:
> >> Hi Alex,
> >>
> >> While running the vfio_pci_sriov_uapi_test [1] on a CONFIG_LOCKDEP
> >> enabled kernel (7.0-rc1), we observed the following lockdep circular
> >> locking dependency warning:
> >
> > This loos more like a class issue, the locks used by the VF driver are
> > different than the locks used by the PF driver, and even though the
> > devsets are shared a devset should never have both the PF and VF.
> >
> > Maybe shifting memory_lock into a different lock class for VFs is
> > enough.
> >
> > However, I think it is a bad idea to hold the memory_lock while
> > probing a device, I'd prefer to revisit f4162eb1e2fc ("vfio/pci:
> > Change the PF power state to D0 before enabling VFs") and change it's
> > logic to rely on a private flag instead of pci_num_vf()
> >
> > Then we don't need to hold the lock any longer than just setting the
> > flag.
>
> I agree, that's cleaner, only hold the write-lock on memory_lock in vfio_=
pci_core_sriov_configure() to bring the device to D0 and to set a flag on t=
he PF vdev.  That flag would replace the pci_num_vfs() test in vfio_pci_set=
_power_state().  The flag is cleared without memory_lock if pci_enable_srio=
v() fails or after pci_disable_sriov().
>
> It's a nice compartmentalized fix.  The lockdep splat is a false positive=
, but this would eliminate the memory_lock -> work_completion arc of the de=
tection.

Thanks for the suggestion. The pointer to f4162eb1e2fc helped provide
context. Based on the suggestion, I tried this diff and we no longer
see the lockdep warning:

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_c=
ore.c
index d43745fe4c843..f857a23c034a4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -271,7 +271,7 @@ int vfio_pci_set_power_state(struct
vfio_pci_core_device *vdev, pci_power_t stat
        int ret;

        /* Prevent changing power state for PFs with VFs enabled */
-       if (pci_num_vf(pdev) && state > PCI_D0)
+       if (vdev->sriov_pwr_active && state > PCI_D0)
                return -EBUSY;

        if (vdev->needs_pm_restore) {
@@ -2294,8 +2294,9 @@ int vfio_pci_core_sriov_configure(struct
vfio_pci_core_device *vdev,

                down_write(&vdev->memory_lock);
                vfio_pci_set_power_state(vdev, PCI_D0);
-               ret =3D pci_enable_sriov(pdev, nr_virtfn);
+               vdev->sriov_pwr_active =3D true;
                up_write(&vdev->memory_lock);
+               ret =3D pci_enable_sriov(pdev, nr_virtfn);
                if (ret) {
                        pm_runtime_put(&pdev->dev);
                        goto out_del;
@@ -2309,6 +2310,7 @@ int vfio_pci_core_sriov_configure(struct
vfio_pci_core_device *vdev,
        }

 out_del:
+       vdev->sriov_pwr_active =3D false;
        mutex_lock(&vfio_pci_sriov_pfs_mutex);
        list_del_init(&vdev->sriov_pfs_item);
 out_unlock:

My only concern was clearing 'sriov_pwr_active' after disabling sriov,
since the PF would still remain in D0. But from the f4162eb1e2fc 's
commit description, it seems like that was intentional?

Thank you.
Raghavendra
