Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793821326;
	b=2jUsEwXgbZ4IT3wctVAt6ideCU+tNghmjAdPT9gLYJT/OXHgFpXQKc+LrFw5Bf3oqOpy
	 GP1+Xvvh2tbWi9AxzOTDTDOATq/s+QlQwVX9AOVX9lqHezqN85aW2J7pdOsoPlj78MuvK
	 oEwZDtiG4zbDhy/OCi9BqJO25bmU+Tu/ZtVcPZOi7GZWXcXbFVLtXgq2OdqqTgCw95Syx
	 C5crJT7c8lLkczqnH1sTEOSow+vHFnyZ+etbpi2AihgU11xmKJkpjnwNqDi7bHBb6etXi
	 fa9I8YC5tJHdrve+7tJ53UFXHyk7+ClbKoWWVBpYHYgPMBbiGqzl2JXHOrKdgWcuSag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Bv+92c01P1xFA5T4dnNNXL4Yn3gyyGMmodh6TXZQ/F0=;
	b=ioQ1/3qT9f16PdtmfaFrRKG4VmOlqGTIE99Bo/vw7EuiuS+DsstWgZe1H9bX6oU6cYhL
	 63tYIn7xu1P4KaydBDa5Vb0XPK73gr8yflCWwHrpvRVftphl+EanoT1Q0aumy8ortq1oo
	 FtVQIIRCpZet6ddGJ85KQxPTUFvoI3NGTF4ZeUwwSgLiqtICwuAyAdXMlQTrfeAsqkVZe
	 LEPMNW1JArGGBSITv9QHctfH5YTLq2a9NFxr/qKeCOCOumRRNmxNzqC94fHnP5uD/9p8N
	 yTvGyPM9jv+8Fz+SpSC30rL7yAjUv1o9oucWdoSXagzFEeZzERwAl8XmTUCrp05seKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IYJCJ3+v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789746072814
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789746072814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IYJCJ3+v
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c49b431f022so186191966b.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793821325; cv=none;
        d=google.com; s=arc-20260327;
        b=o8uHw50uvQ1KaTxXl+8JzJA+3HTZpclmzkTI0QmkwIfEP76O+oE9x/g7sBle1WO1LV
         q0d+gXZb1VGrqPKjPu39N9MRveWsXWmtOaFgncLcU7/CpDoyAtxM47cfpfkSk15hPJcM
         38FAGaJ6YYpfcKMZyYCIFxssnUDU1SgdlIb1De9KoR9jOJBgJWbmvFfuL/jwXw+w0IxT
         PfjQ/CPvaC/+3dka4DI818aEekMdQ3y/L8q7lB/3hxEdr4kfl3kOTAyj5Pbb7x2uukbA
         DAlhHd8xjWOjLxN/i+YMFJJZ4zPVWUNMHygTufshjisO6uWYpd6+akVAU2KBHkOjgya7
         y3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bv+92c01P1xFA5T4dnNNXL4Yn3gyyGMmodh6TXZQ/F0=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=NiMH0Oni4ROUwqt/TopZx83HwmOdj1l5AZi9UH5kbosxBKYwCJpWzGfNj2lPdsf5J1
         6kWf0EE+kp2RoLGhf1qGdTj9KCp3kIsk3/6oXsSI7HqF6qY+cFec9bkzM5js2FFOGmn+
         7fRd64Whcsp4CwEfVoV5DfqR4sN4TQH0m21qTsa4fxfQqlOcNA9aYIra2+wzrbX88KsD
         MWPdEhg2/ETAh/3Zbz3NKqlMx9iUC4SBkDdvrSZDe/dtphwdUfeMXinitxvwms1d/9ov
         b+rSZymUj8XOZThUH+djlARKBeHhDOCnr6MslYkamRUk9JxPc7jfr2C4bd5NaDcpE4JQ
         k0QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793821325; x=1794426125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bv+92c01P1xFA5T4dnNNXL4Yn3gyyGMmodh6TXZQ/F0=;
        b=IYJCJ3+vQpq3bkHiQ8vshcCLmMUBDJsNV/EseC+XrJEst5yp2dEgBfCRA4iGfQS28b
         ywk1VFJzFvde2CBaUwCCgvCRsGbbo6V8Gxb4A8ehthCECFbk3kqNyLbp4tM9qoOCCKMp
         4H4RtXqd8uu54YXAfU40yneuL5bj0+sIaRjbh6xdjLoJBOavEwpvWpNIxw9zPqcVBqax
         gTfgJCn0KTZJibiCdXg69BVKocOZkCW78vfpDyOuM16hfcO1oJTcyiJ8BcSdQiwCINn0
         V5n4H7syvAsAfqHaqgWoyEfoCMH+i83n0bKOhXgGF57pEcxr49mnteU+iL+SramAbZh2
         dUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821325; x=1794426125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bv+92c01P1xFA5T4dnNNXL4Yn3gyyGMmodh6TXZQ/F0=;
        b=qqPb7NqAVheJNlp2TsA9OWxhk+8x4zC9i0TzlaZfle+weGxS5GtSvs/892CbSLuoo6
         +WLuEE5hzSX4vZL/c4IYH/DH4nwz8eo76rT8F/XO2wi6a51vsy6InqxTq9/sNLp9dzjG
         ml4UqxCc/DzmC39PWinO8hvcDi+zv/1au+rH0IcVG2nI7AHU83lO8e3jmoUynQ4cXHEs
         D9nzeo5E9umkRpSCOQ3AUZj1QCsz5CNUPtc/qX1VoDxJTUKVaajYppe5mAjfvYW+jxWH
         Z61mb2G5H5jIwucuHBaGDhw3OBW8B/yAOPhkDuv6ZVx5h+0kv7yHkHeWN8dxVimd3ChY
         jDww==
X-Gm-Message-State: APuU4Z+6ypbCMxwbidYqdx1kAHpxYlYoiT6H5/9bTaMIm/r+0wt/Ws5N
	At60kxLFCsb6ftowakSbKVjrFO5Lhcf/+988G7/eAtXBZd829jK4uZtJ+zmaDzSpbIBkhFphBiR
	SPHnKho86J8sDNeHmHs3tnYkN7VRpyxUGqIOlhJ9Zz6A0dyty6EoKlHSJ
X-Gm-Gg: AYBFou2SKvdlOUnJT5/gKgSIdpQXlyZ1m/MtueMu/9Zp4XKjM4kxsG0gpyfRtEN/W2B
	vQzp9ekj63NqyTjo5h57i3UuBqg0+b0oqi0bLaiciCMiaP4ieZHFXUtjJiVVmGHGlFh+0+qW1+x
	S4yYSuFasicWipU/Q1y2UqfTBHm5QH9x5WJtnwZi40+z7IF+zLlfAm4Dmuze1d5hRrWbarqFBgZ
	mQblVdj7pgagc4WtSIaC5GkEr+oiGsAb2bbgLi6/jn6hsizRs3Qu/57LFfoajYKR2eA+NEeDSyg
	Kse5Kuhfp/5NHTRni9bEH0LecFkuUSxGZTnv9RqnxJk+rfxiZ9HAqvyE6rt2XEi7Mlcq/rWGzOT
	fXli4azjbNWUQH1ZB+32D2EtZC/Dl97AYdxxV1KVqpNd4SLMxYVfd0XiAg+o=
X-Received: by 2002:a17:906:ef03:b0:c2e:350b:7220 with SMTP id
 a640c23a62f3a-c4ca7a4b5dcmr1479602866b.9.1793821324322; Wed, 04 Nov 2026
 11:42:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com> <20261103002205.3348519-3-dmatlack@google.com>
 <sashiko-outbox-194380@kernel.org>
In-Reply-To: <sashiko-outbox-194380@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 4 Nov 2026 11:41:37 -0800
X-Gm-Features: AclHuK_VLO359ovTghTiGGyUy0_jJXc-n2zdfwttkbViK28RoUHrb7gt43Eq9pw
Message-ID: <CALzav=eZuhAFoYm5s8j9ei+6Zhf7zAWKHXRug+No9o0=rHUypA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vfio: selftests: Skip tests when the IOMMU mode is
 not available
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:30=E2=80=AFPM <sashiko-bot@kernel.org> wrote:

> [Severity: Medium]
> Can iommu_mode_is_available() return true for iommufd_compat_type1,
> iommufd_compat_type1v2, and NULL when CONFIG_VFIO_GROUP is disabled (for
> example on a cdev-only VFIO kernel with CONFIG_IOMMUFD=3Dy and
> CONFIG_VFIO_DEVICE_CDEV=3Dy) or when the vfio module is not loaded?
>
> In tools/testing/selftests/vfio/lib/iommu.c, iommu_mode_probe() only chec=
ks
> for /dev/vfio/devices when !mode->container_path:
>
>         /* iommufd mode requires VFIO device cdevs (CONFIG_VFIO_DEVICE_CD=
EV). */
>         if (!mode->container_path && access("/dev/vfio/devices", F_OK))
>                 return false;
>
>         fd =3D open(path, O_RDWR);
>         if (fd < 0)
>                 return false;
>
>         available =3D !mode->container_path ||
>                     ioctl(fd, VFIO_CHECK_EXTENSION, mode->iommu_type) > 0=
;
>
> For iommufd_compat_type1 and iommufd_compat_type1v2, mode->container_path
> is "/dev/iommu". Because drivers/iommu/iommufd/vfio_compat.c is compiled
> into iommufd unconditionally regardless of CONFIG_VFIO_GROUP, opening
> /dev/iommu and calling VFIO_CHECK_EXTENSION succeeds whenever iommufd is
> present.
>
> However, vfio_pci_device_init() and device_init() in
> vfio_pci_sriov_uapi_test.c route all modes with a non-NULL
> mode->container_path through vfio_pci_container_setup() ->
> vfio_pci_group_setup(), which opens /dev/vfio/<group_id> and asserts on
> failure when CONFIG_VFIO_GROUP is disabled.
>
> Should iommu_mode_probe() also verify that VFIO group support is availabl=
e
> (such as checking access("/sys/class/vfio", F_OK) =3D=3D 0) when
> mode->container_path is non-NULL?

Good catch. I will add a check for /sys/class/vfio in the next version.
