Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C531A572
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793262; cv=pass; b=DTxsmHAg++kKFdZ03BwSLOYC46xMPuMCylgQGWUGCINYt4hhBJfSTzbr13yoLzJWeFafikcAv8+ZIO1eBmzI9qo5JrrqvjUb84G/YSGjtuCk1oUDYj1dKW9hCp3IBLfkwVMLDaj6ZHgi7ov4yDVyIJSi7z9wYR2g29PLZIWA0fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793262; c=relaxed/simple;
	bh=tCH8EMRzy1X9IMXq6R2TSgftHF1nceCRK1je/4RFR+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=App1krrbtv9zKl9vRQr36u8bz9Fw7kU9Bl7tgIEIkH9x8vjEoKGZKvtEwnPfGTL6Y1VIho4rKm+kSQVGzyB0JJntHSD4ZyeooQe4MZ2nAHLNkMQeEzxdYlenky0IX9aXRDoipQrId4cWJfAa4kI7ytiKqwiWpdGXH4dudDHa10Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbjgHHau; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbjgHHau"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38be5e86918so52975651fa.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776793259; cv=none;
        d=google.com; s=arc-20240605;
        b=AFqGAxNWINZw41nAiC6aPMPsqiujN8yRiydgW0OykXoEp9tLM6gLBdF6hAxxpwqQeM
         pTBlVcg/DoCOXEelrXweVftm8yKl9GDmJwifH7qgwAPSmY4UpA2UT7Xqy7Rmiq/W8Gjn
         87zO0cs9DbINHNgWk1Up1JkCiegEEYRJKWPI4uDKOUmG5GL336eGSEPqE0e75HbZlnhD
         zA7FDuZD4im7zV56OZgE07J+TZ78RLhMlfjQwb4alCKlLCHOaZTTaJjMWd1M22TNWu1L
         htnhfOCOuVFGxwuJvpcJXKKnqvPaU/rMpqzrQ09Tv6NDsIi4vbKr+pwkiUQfpbLgFyV3
         3bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        fh=K4cwKILjo1rIGSpfPkNXQwdEmUqx+fWZ1usjP0MDy5M=;
        b=hkEAv8FpaaOiC2j1D6cRcnSCPrpai+ses6RUdKtlUzwpv7MJRLz+RXDkHlVAiTjXtL
         hxi9BfPSUms1Rfs8lER5KpkVYENKY2yc3LNxEZz+6NXalffCYdcqsrI5npI+c7P2Ukm4
         OuMCQOPAaivBhlX//qE94XidfmNNtTGB8lst6Dl9mOfHtY7+JtBHJQ7XDZU9aGf3EONz
         HFatrfXn9ETfo6PdsPIrKHXu6rLFGzf8coM8BzKMDVtJIK+rK2xQ+9oo95gulDucd6lG
         +GJv+oe+8ARJXddXhAFGn9T0gbPomTNLsWEfX1NlqrdTmCRfOh3No4H2Q49GjK2xEBhO
         WvrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776793259; x=1777398059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        b=fbjgHHausqRnAQv/Gm0WB1KYT5Ef+TjO137SVJmjln5wwrHMvzEM38YMAuW7lI2DTb
         NmEcU9H8n+70Xuk4H9OKhUBfjM+y8aqzI61ep7qrPQsvQuLY4PBSJrvyNi54ZOD0lQEb
         hc9TLUSu55ru6RHCT9SmkNPdZUWzQ0RwesPUupmg+Vkq0H44zIrr6UN1iMayAsCbIDYP
         w2pI6PeAKZlgHOp1DYAQD7SK+YIsZxubN5NKtf+JS68fS9biWnuos4dDvBonRAl2iC0d
         1nUIA2R+ep93u2n9Fq+p91C1rVCx8xwQHIcIpKSIVBGgn85bcpA+5RwGL9/kDfPaelwF
         fr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793259; x=1777398059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        b=C+zi4yBzSWggqsjPRv+oXLy3E07ADxh1G1n4NaAooGDSeuCHYognvxn9k+Yymmcu+r
         E3bRVN9EmgMk+FCpe0855KZhaftgmf0sdKYCBrbDOCzqPYqG2hWxs8/nfWnVsl6VvrcY
         aDcQJEO2vC3C31HHZj/OQVY/jLV0bBCh+GiGN/6QFl/LaNOD4GxedIl0GzzIa4S11dSU
         VJ0xd9J4zPUHlrDhlK725AObq7ME9q+q6+Alh6/KnspP4Q2tGVqsCZHXkbmckeSoo54g
         3YeshyvKbwlcNsfKAp4ZycRUeex6rnbbEKNRO+NFB3rpAOQtOlaVimtxISDBlm1VzLnH
         ohaw==
X-Forwarded-Encrypted: i=1; AFNElJ8PohUScDwVweQ61M99K+C9SiD+WV3evrs8ylP2HphS3fZSKdhu5zmT6xB7yolWgmTVnhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVkqLsrkD/s6EEH/DsMjI56Romfalrw1TVyFhAmMH5AhHv/p9
	SwFquGau0hsoso0vrTsDP5zByVsip2fJSJxN+Tw7QbtFNPfU+ZpApHZoMBpqR7kfAZDpsEiFVK5
	gHjH/QU+TM8ss+CVrQ/ISgv5AUSP0HO0NipzApBpv
X-Gm-Gg: AeBDietOuS0mClCt8Mrg22V9Kb0il0txwXXxqbHIZWbWpLm45Fl4cqvbnvK9oRTd/iQ
	K7RZx0j7lIikRfTkcCtLFMb81rpGR5SzouVDb99gjN9K4bJRu4YPm0u6wgmXe9ne+7EMdfc/KJ/
	Ci2ddUJGsFYs9w85LP8zgh1KI2mNJxnHqGxk7Yk8YZJNmwVSSjD2rSQ/F5kcIPbnQYGEzYhom85
	nvLhMrHNk6JdGtzimxT0rTcEu0uMNXUTFhx/Ebl8oihe/ArF+TqYE7wibUa8pMUZSELgPnPoo4T
	KhWlX/wyFmIsXfU5l3Bm9vrBqS0wTg==
X-Received: by 2002:a2e:a594:0:b0:38d:ed62:f1d5 with SMTP id
 38308e7fff4ca-38ec7aa4a03mr63977601fa.17.1776793258292; Tue, 21 Apr 2026
 10:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
In-Reply-To: <20260323235817.1960573-8-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Apr 2026 10:40:29 -0700
X-Gm-Features: AQROBzAxQqecIHMlVLo5_fKuOniGGCbgFfk1LcXxhbCrQbMNTrTkqomhARN-2eM
Message-ID: <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:

> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *ar=
gs)
> +{
> +       struct vfio_device *device =3D vfio_device_from_file(args->file);
> +       struct vfio_pci_core_device *vdev;
> +       struct pci_dev *pdev;
> +       int ret;
> +
> +       vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> +       pdev =3D vdev->pdev;
> +
> +       guard(mutex)(&device->dev_set->lock);
> +
> +       /*
> +        * Userspace must disable interrupts on the device prior to freez=
e so
> +        * that the device does not send any interrupts until new interru=
pt
> +        * handlers have been established by the next kernel.
> +        */
> +       if (vdev->irq_type !=3D VFIO_PCI_NUM_IRQS) {
> +               pci_err(pdev, "Freeze failed! Interrupts are still enable=
d.\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D pci_load_saved_state(pdev, vdev->pci_saved_state);
> +       if (ret)
> +               return ret;
> +
> +       vfio_pci_core_try_reset(vdev);

I think a call to pci_clear_master() is needed here to so the device
stops issuing memory transactions while VFIO is trying to resetting
it. Otherwise I see these timeouts when running
vfio_pci_liveupdate_kexec_test with Intel DSA: "timed out waiting for
pending transaction; performing function level reset anyway".

Sashiko also wondered if pci_clear_master() is needed to ensure that
the device has bus mastering disabled during the kexec but I don't
think that is actually an issue. vfio_pci_core_enable() makes sure
that vdev->pci_saved_state has bus mastering disabled, so
pci_restore_state() below here should guaranteed it is clear during
kexec.

https://sashiko.dev/#/patchset/20260323235817.1960573-1-dmatlack%40google.c=
om?part=3D7

> +       pci_restore_state(pdev);
> +       return 0;
>  }
