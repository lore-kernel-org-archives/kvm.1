Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794512122;
	b=f5XoVgvwIMKG9GU9sssNPPiXdx7sxgcDw5tm/lgARBgD9+Su0YNkKQQgo1YBVovXHNdk
	 jKluFu/8nvsjUSVOhA1zdHYQMpsAWl8vwUv/dOoCOyaT/tt8edn6NPKn5ciUV8iWdaVzz
	 VOhKgXdEDhEs2UPsNpcmuxqm1Vr0s2xAxwhCG7rhpCyNI6BLkBkjCGEz021XyVrltBOWZ
	 ntmMKY+yCB59/GLMDLC7gatl4ge5TcoTKwL+un2KEOIzLOur8Yl+GLFn2wnkpu4k9gR6G
	 HqKo8JWy+TOFBidVDnR7HnGurH5Zrvlwj7PZwHVq1XYxxTl6ZzU9ziPZ9ivt7FkIU1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
	b=X15IHSehuQPf1r6fE572CCOx8OQq+Ftj7coNS74IH9+4FBkPLjljhkLEX79e/okQv521
	 a6VU+vJGMj3Dgplzk2mLC5DqYAcbSLAKcp5RQvgDHtrbFsUKPDFSI0qgNLdmLMdVj7TCg
	 bN02WOwXm+JUuokV++biAusDRmPwY+K6uW9F2dUOJkEevorBP+YVjKth8V6cQbfJZJFZ5
	 9R9IH22xtxKvXzEnHsbw0llaqGIkY9oQaRYDTMVVzFqvA38c/TbO83e3tM9OtyjXO4T52
	 BdwVkIwjpkzlu70J924Q+Otn/DkZw3ML3aHt1fBgx+P4wkzycLQXfc/V0pfnsIgvDhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOvkPnaM;
	arc=fail smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8D606A330
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 19:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E8D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOvkPnaM
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91f0274f88cso216156d6.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 11:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794512121; cv=none;
        d=google.com; s=arc-20260327;
        b=PzLRywlV6K7T/p9fv0q2OOCRpvWlybr54NGCZh6elJ4vbOB4SrSEKMvrdV0SeT2LEw
         +YKlYNaAJnMeTQDX43ssucdcWCgrTp9fRTPEYxZmldnasQk4gNuhNlJP9rl636laU5DZ
         X8y8akJX6g6UaV4eZiZ15dN1AMIv5uW24ZGMKODbnua4LETt9pSbXE2Rap65i69MJk2g
         5uPtFiBJRUnRtWxaKuVDAvT7ebUazZO0BH4J2KuhCEOFwiSgRU+PoCX1TNAz4LNsrwrk
         hXlbzLZduvZCMGU/tdoHVZlk19IPjnFpWAtrbTiXo0Hz1fg0RVI7VtG/ChHjmX8o8u0S
         bRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
        fh=CIzV8Y6q4TTjsfgyebdX3EwtSbfHycdrWHAlQlUIaj8=;
        b=HjfZ0dKlJF/pH5uSa/97UMlNTTn7IBLeLX78aSxeKK+OQ2F/WsqoqG5a2rPPlgSGkC
         U6OBCxJBGK4+WsxREJ2RFdA4soDC0v1qK757T6W7ohtf+9JTTCiNb/+Vqb9zZufLGlbC
         mDBzboEVyzPPfdtcUJVopcs7H6RPvXsNd0BBjB+eqyfjlWe3Wbprr27PLYLLWxuU5ny9
         dtSPMhpP0+t5+gtphUogbph7XEBWzILBAaiySwn6uruHroSGJeP0u/IIwY/y0Mrnr5ny
         Qwynv97OD2iRn/AbyKeB2IuqgIVRXTs9kDgYiALuVIPLVwxGWtlK+VSnUJUejB0osXm8
         kTVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794512121; x=1795116921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
        b=TOvkPnaMiidIptAqmx2zbHxBFlHMqub9g0awZPe8AApCcNpJI4EHLPHNn/Btko25bN
         yLD9q/OHcEcJXEliYbDkVyTch9+v9kpGdAyFgvsEHZfHq1c1vhkqBQ/e9hFBjt63swpc
         5X8ISVDqpZ+LwEejsfNpLmmA3+GCryC6QocmXY0KdF7iFkmnKxGykVQw7Ro5Tm+ONneg
         1Mja5JR791Ia5qx8inHr+7iGE/PGeHetcMCG7qdoKc529QyB0uHfQUtifQXjKpEtq1VD
         0Rfkb2hvBiEApezIco8HGFa383afvQlTVuDOMjLy0ao617zfk160mMrKMrRGab8DP1me
         ImuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794512121; x=1795116921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
        b=K2v3KFfJArUgqJOaveOOFeSjeHwbWHdSmkZzHca+kEgEnulkmX/rP4+pXdK2g5teKm
         xF2B8hCIeCAjsZ90x0omQWhw4fy5gZUqxEeDpkPAEwDonN7tNqpniVa2cIJkK52MYM30
         31ag+337dy8khqJyhnUdx+IMBHKz61sSCooZfAzi4aokF5mQu5bi6IYn5NHSLUcRQfv2
         qm9tOhHQbVEljRNvlzCfkVdWo0bd9aRzBSjT3vThdHEdH7F3FEQOAzbBUCteakLD3IsM
         jeatJKmLIhP6vpDjGGaBWqJpqb0Njly0FDcFsKNL/FbPZUvItWDldGbC+LvaAhpXY7Vc
         xnkA==
X-Forwarded-Encrypted: i=1; AL+hErH1hFAUCD7n1NdfEw63cISUbQ7tOsjw30GEAcv2cTUUIWmc9eWlq2a0vQ6BHwPekDir4gI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dNPa8XZFJxdKdNiiMoXWG+L6JRo5H9prdpyAuRR1Dq85LXFlI
	4jc5jMBopZeg1BCRiMjGf5eMDVX2RGmJq/KNMn4ahTmChy/YKnNIBBBlItaA8Rz/36Et4LpQHJ3
	PMPBHEoI/0m9c5cRw1HVQsl9VSfS2CW2dZQ==
X-Gm-Gg: AYBFou0D70sVSp25fRSplt8cZaRAo7fAqIt62Cagja435tuOE88w21ti8ZTnsXrwOIA
	p3bTHc6PqakVkWwXmVomv85DD5j/s8BtAb1M0x9txtCYhIL3tN1iMlwOtOElRV9Q8gyg2AqBpWk
	iX111oonZpiWOASMXkLLGX9G+tGoJX6rq6k78vQjEMyc0XOBgEoSXwUzfvz+louIvqxdnCjFvS1
	ic2M8km0Gb4bcNxSZXFryJYTp1ZG/VMWo8cFH8KNfVSZN0+kbtzs6XRlydwOESKwRyIUvOMQJ6e
	8wsaxnRMPC+j1LR1QKLyinZfz8C4gi9tr/C1guAvK/5m5eDZ3EaFJUolRa2I5oXoXSVAiBahb/b
	boQXQqLKI8L1xkyJ263C0fzvgGAYZmsc3G+wAuEsVOGJ5cpAlNgXdNCbvh24frgFQmX/gRKeSeu
	1KAGdkOaViTvTc6z4S/zEanTjnMNVVDVaQEKbC6Q==
X-Received: by 2002:a05:620a:1b81:b0:93c:c405:3215 with SMTP id
 af79cd13be357-9494bbccd6dmr77956685a.44.1794512120789; Thu, 12 Nov 2026
 11:35:20 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Thu, 12 Nov 2026 11:35:08 -0800
X-Gm-Features: AclHuK_BvMs_YVdGy0WUpg4okUuBQygcvvwgCF7Igbxb1UybigcTBxXa87y20ak
Message-ID: <CADvopvYQDLx81gDFNR8MAg9E010K3yJNEByAwawQHFahRYiXzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:20=E2=80=AFPM Matthew Wood <thepacketgeek@gmail.=
com> wrote:
>
> Many PCI sysfs attributes that read from config space are using kernel
> accessors that don't wait for pci_cfg_access_lock() holders before readin=
g:
>
> - serial_number
> - max_link_width
> - current_link_*
> - *_bus_number
>
> If userspace attempts to read from these attributes while config space is=
 not
> available (e.g. during a reset) there's no telling what values will be
> returned: All ones, zeros, or garbage.
>
> Looking at attribute addition history it seems like this was an oversight
> instead of a specific decision so this series tries to resolve the attrib=
utes
> above to match the sysfs attributes that do use user accessors: config & =
vpd.
>
> Patch 1 is a prerequisite for the rest of the series. The kernel
> accessors these attributes use today skip devices marked disconnected
> but the user accessors don't, so switching over alone would make the
> attributes start sending config reads to disconnected devices. Patch 1
> adds the same pci_dev_is_disconnected() check to the user read
> accessors.
>
> Note: That check also affects their existing callers. On a disconnected
> device, VPD reads and writes, VFIO config reads, and VFIO writes to
> PCI_COMMAND now fail with -ENODEV, rather than returning ~0 data or,
> for VPD writes, timing out with a "firmware bug" warning.
> pciconfig_read() fails with -EIO, and the sysfs "config" file and
> /proc/bus/pci still return ~0 data.
>
> Changes were successfully tested by continuously reading sysfs attributes
> while a reset was issued.
>
> Changes in v2:
>   - Patch 5: check DSN read errors in serial_number_show() and return
>     -EIO instead of an all-ones serial number
>   - Collected Reviewed-by from Keith Busch on patches 2-4
>
> v1: https://lore.kernel.org/linux-pci/20261025000836.58294-1-thepacketgee=
k@gmail.com/
>

Hi Bjorn,

Checking in to see if there are any concerns with this change or if
the premise makes sense?

Regards,
Matthew
