Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FF3CF682
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681005; cv=pass; b=uGXcAuUjGe7YWfpqd5K+RaNUZiCWGxu+1bNqz1rkv47Ea0lCcnnxWmE+gJRfMzWBA6vYYvAJcjWvsSiE9g7ErauZQQOwNdxn09ocALpYcBR7XWkViw2HXAY9ngWmKLFYLc+28rfBcTAhK6C43fZ/GVlHzgHewYiYtR5q4wx+cb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681005; c=relaxed/simple;
	bh=dkI9QqpDtG36LgG+kw8ZEzl8s+Rk40Z2naIpV+PYS9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANuw72mxAw4vJAyb7s5Z/6BcneasgdusT9Ru+RsWDEBTlHLMKNBGr1u0Kk0D4YJqUbGicHAXj5lNDAPWnDZoyUX0qYSNCm8AOT+tYCo9KdCFPoFDm+nzpUjUl2hO5LG3qmPwbQ+UavwxGYx8lYhNniAU9GYM38/f4UnAiVn9I9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA8sNSIY; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA8sNSIY"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a140efd2d5so8761170e87.2
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 10:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681002; cv=none;
        d=google.com; s=arc-20240605;
        b=llFqPg2XAg8/4PfXI7nnqzcGAZFYo7qYVVOdQe7RgMXhGtY6Hd40/DAgfCdsbylH3e
         VJdHR96YcQr+EzUbk7qzCso60hGSr06zXntACc1c7oKAnKDzDKT74zTrDl1ESVobanxY
         emGsp0H0nF9ALUDi7D/ZxSAwvGDcAJolLFadGbv6guMdmHQb23XnE6N0EFOvhPby1Q58
         t8szO3gnHDsDxyDGny9xmPT+pLOYWCLepCsPncw/T1NH4xj4g7HrTWpFyLRvBn6LyEQg
         lWZWL3z+bm8lSgwNW4TgTAi089kQT++ak42xSB2kh2zhU9psLiTgUo2Vu5JZ4P985kOl
         BLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        fh=Svx2PujXVbyKKocrPBLGGhtkI0Yi056q4Y6NuvTVha0=;
        b=AY+91rcVfPQQ5r1/mO8xije0QtPP+8S6sM96q6fty+X4D5/j14LfOv5FzyXO6gaxva
         lVvoJ1nUTIvizjZxwl5b3g1HrJmHDfkDNOKW2AX2vMrk2Nn/GZMah3jvGtT2+lCgZVGs
         rqr3n/Tv6nK0afFXAcgYkTOE0gpRVG5Qub8hh6thYKWuWl+Li4ZlsiYn+T0at0qzsIxe
         LXjnkHOTPqyur5aRYZ5Bh2wBTJLNKzViqKry02r/h/h+CjKkMQ82oNBtI7Tv0Wlo9nD8
         gOdHcyxvNaO/KYfWTqAEZFt8cRccrizsElZqqrQUfqtSOcdWiezaR2HgjwPrBwPQRwPU
         Ja4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681002; x=1774285802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        b=vA8sNSIYf/v4LksXXda0XuPKnMxUj1Ibw/V/HMiYc0uWmvIPLbjMjZutFH3c/xTpU1
         RAACgDVXP6gVNYR/uFS9P972GPZRJDMuLumL9oCN8g6TCQ5IqQKJmvZeOtsCc7GMlM2S
         Aa/WFaphNihK40YrMJShq2dVVayP7l5bbY8YUPt0AF6KmANG+U8Csv3zxhf2DSR7QsHq
         jHtRDTb4g0voHjGWEzKpDs9CSbsAig34r9K4wIz0rzOcvVmAPXinmzrWqi9oZxytnRsY
         dPAMooGHWuj0Ty2OwKmypVsAHPji3dnmov2T0RsZkDz/9yTkcc/BUuauM0YpgKZMaP+u
         sGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681002; x=1774285802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        b=bfC6BjI2gBfz2VjEOyspQ61muLA787//+FzOTjWBXYQMJBlcoF2e+L+a8/ju0waLmW
         QNWgSRFO0Y+UpaIqz+YPmHU/aIpkcG/whrlTOLTZfFAdQ9MO4e+X+Jem+X7fGno/vBu0
         /lsow5HJPdrh/M4zMdlnzezAdIyfEnDnhD6YY3dQrCu4/XyR60wDsaj+FwXSkOtDXSEx
         jSHhZO1QFJleZT5/do/FTMUrUPTlB9aaasSP0nKjIsbECXIDedWJqettFv5JY2vy+Gmj
         lLIWpWyBL0usztDovYmDHMhh3oAOBsN1Hbfw2lAkSzuGLnj8t03/h2wr+z6WfV2BjI/4
         sSEA==
X-Forwarded-Encrypted: i=1; AJvYcCX9t+m6u2Wb+1I56rsOr1Zw4LGzf8GukAMIxF0ap62w4Xpy/LB5Yx+/WDJcl2dGdZpYpSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3vsN+7pZ0k4i+FPpXu2qPPR+4BR7Hz4aEQPLueQXVky8HGP3
	SVS4JIHKUVyz5tR8XSoqmaT38QxjA/tPOmbujvZ4agcSnK85Ftm1Yjs1ZtzzwCgObOHwPQl6ir3
	SjqFYOb75vqcIfY2FRelg9VC27svv+MYXQ0cAK0Oa
X-Gm-Gg: ATEYQzxW+ugySFlOkOgbggEDu02z4KMBSkOVAoKQyVAM7vPRnqr/Y85zoeUFW1YiE0x
	qVFVqH5B9DG3ZTH0ehlaP41okiosww5N0pHMlYzTycy9vtyWnQjjyuYcUWt+51VXLmUB9omUren
	9XWE5EcnKmbYNwIHWZKUuH6vjw+4RwE1bMUcLrhACl+W4gpScLNFGuqB4z2Y+nb7DUit8TyYFx/
	n3YQLf00555tggZXYmp1AlczehuW1C8SMzOgyK0uXfdA8hZlPO+D+GR7aii9MDfh65BMiN7te1E
	r5dVqIMj9imQ3kDHeto=
X-Received: by 2002:a05:6512:145c:20b0:5a1:3207:694c with SMTP id
 2adb3069b0e04-5a162b0c23emr3396226e87.29.1773681001667; Mon, 16 Mar 2026
 10:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-17-dmatlack@google.com>
 <20260314073250.GE4177610.vipinsh@google.com>
In-Reply-To: <20260314073250.GE4177610.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:09:31 -0700
X-Gm-Features: AaiRm539MAtTSlMtJ9cZiQMw7S77YkLj3Qx3YTaEKJUIvtilcVTIw0VDB1yQ5S8
Message-ID: <CALzav=fWmv_+BACzTLq2Nj2aUux575EnbLRwJTevH4aYZTXycw@mail.gmail.com>
Subject: Re: [PATCH v2 16/22] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:05=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:25:03PM +0000, David Matlack wrote:
> > +
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> > +{
> > +     int ret;
> > +
> > +     ret =3D luo_session_preserve_fd(self->session_fd, self->device->f=
d, 0);
> > +
> > +     /* Preservation should only be supported for VFIO cdev files. */
> > +     ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> > +}
> > +
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
> > +{
> > +     int ret;
> > +
> > +     if (self->iommu->iommufd)
> > +             return;
>
> for iommufd variant, should we mark test as skipped instead of showing
> it as passed?

Will do.

> > +int main(int argc, char *argv[])
> > +{
> > +     int fd;
> > +
> > +     fd =3D luo_open_device();
> > +     if (fd < 0) {
> > +             printf("open(%s) failed: %s, skipping\n", LUO_DEVICE, str=
error(errno));
> > +             return KSFT_SKIP;
>
> Both can be combined using ksft_exit_skip()

Will do.

Thanks!
