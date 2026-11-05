Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893838;
	b=SmKx/zXz6Eoybs03YJc2OgcKt5NZEEvKxGDPTnEuQl1Gu4xeGMERv2LCrDGLdfDhzp7f
	 gSUs0AzL9uDLntjF0HMNbpJKMSfRjJQkSnxm42y6RkpkLxuvZqGdXRA03ITln8Dq2Bsye
	 43G9Nd90EhLfJGRfGY6dr1rKfem/O3Ivd2tg7SLfoBg8zvTa5VEBIX90Bx+5Cpr9aLAGr
	 qEBK3dnvj/jKHlrfltWEZ9oOZoSkAi2cb2u0b6IfTWzT+8LcJungrLtfMcgQ0v2EFWux3
	 6ZHBvj75eyFttiIX+i1lHljCHuBO2FznCEoXWcdOPl4UODXZR2arcQ6MYX81UVcc7aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893838;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NZay7L2nryhfKnNMEqZkGMSJNXNIWBCGAWm4vFCRCqw=;
	b=hv/nkW07zDmC2Os/8ahcSk+oS4aMLhOWQzMJWGuzNj3BlnB+6NZAK7F9XJ+r5RfunNMY
	 UvTd4UwPJuS6mEFY84n2Ww6zmO5PMiOuGiuvh9yBCx0AOKiucbU/Hz+7PtOCkpYgNYkH1
	 qNuLQF5mTrg+XaPuHH7JpiDWOPeJOYhhDTmghQlLzlfBXl6gY44bk/QvPmSF5cslhBwDY
	 nJFdsofcqa5fZklm7aaF0G+Nnu3fNOV8dXV+6cEkfDZRm3N4mJSpBZTJOHw/NpHedcR4B
	 WNoPMZJonTDV/uiQFT+mQZpclmLdDWHY0OlZD6jfeO7NzIJN3LOkbqck5QNIhVPLydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=0tMbQth0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qshhmKdc;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D460730A7
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D2D460730A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=0tMbQth0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qshhmKdc
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 18585EC01BC
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 10:50:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 10:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793893836;
	 x=1793980236; bh=NZay7L2nryhfKnNMEqZkGMSJNXNIWBCGAWm4vFCRCqw=; b=
	0tMbQth0NQkeucnyD4pkjvlZIplB32NHkn7gDWXcul7odnqIdd2R1jhLLCYM1IEr
	GmY4zRZMirpAZwiyVKF155d3IS49NUsl8lGh7iCWFVk6vxek9FytUXvfJKwIjIMm
	1RdKsCvG/bH7IGLfCpmIjtUlN21JflxZvjBxrMhyQ/7etugY8FXWJD7QY3noBJeG
	I8VHYc8AvAesoPuVuVgxJ1dZmEK0Y8TbUitZihkAzZ0DLet2RFUhact0/CmsBkH3
	UKW7gJwhM+RvJmyH5EPr/zchaYwDfM6qs6wYVmgkG6fFXjggHVd4ga1tJ0Y86JaL
	1J9UTM+C98+C1QDfcOO0Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793893836; x=
	1793980236; bh=NZay7L2nryhfKnNMEqZkGMSJNXNIWBCGAWm4vFCRCqw=; b=q
	shhmKdcCRMesRoKxOq2445nS5tbya/hufPlil42QSWFUPlDNV5Hpsu77VYZn/isv
	t28ooYUwsjtw6TMTKJ9OIv9xhf3XPS+9jORge8ebYcpSwqLtietu5hU4rqhS+7+9
	d2RuZJ52J7RuEsCScL9GQs5bbEJl4mQwd4FKzoBHz+Jamhwl7WGdFsbSPtIQ8TKr
	YOMOioHE13eODk5lN5q3D7Hx0bH/LL1rOBg3e6Mb5IcsYJH6Q7sbEiZEEPrKQj6X
	MgDzmVglmHq6k58YoSPYqth3pbFOlv2PTSLd+ZYdykiPYbpLbln8oXVNscDudmNc
	p1n7RviYmWUbk0U13gESA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793893836; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VbPk7AvsQ40GUdKBSYHqb6cUMPLGnAtElUZhxYC5PG69vrG
	K/DF/wcjn6yGd1ALv9N0Zu+NomgBGLRd5BWqlDvEFACzlorEyKOe1cNZnmclRcFV
	OSP6X+fM6/FMmmvpiZh4A9VJjKMmoabmsscZoRPJpwsJYK+G/OXSB5rSzhkbJJKA
	b0I83JgE7O/5hIvCI2gczLb+bCmn1Nr4fIpTpLfW5C33I9AZhlx66kEAu3zGpYHh
	zg4MgF3/g5KhSkWQNIMgy72tYV7l2DSXsZqciF7BUNzOhO/VQc/qApr3ESxFlHZj
	MfgD6uX6OfHoyMSIbmHCvz3Cdv7iUmG51WUGb/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YFus3HutPXTLvZFoFGpqPzl3xKeJzNug8nJycK/gXBM=:RwtE1ERIc4WaoKgPKbvPbHAii5aWb9hJhqoJC/CVX0U=;
X-ME-Sender: <xms:y6Xsat29eO3y9O1K1DvuAa1GQW64tu32quiEgZMWzHw2ok0Tv4kHWQ>
    <xme:y6XsalmPWsqaLgMh9_xbnxoz_Y6H9P5Wn26A28tYiV6ijWJXE_qkKPbPehKgIR6vT
    FUREoG4EFwDPwa-mQcgUGt_d9bZfqAxKQlRAiQ9JM9VYJR9x9V31Cs>
X-ME-Received: <xmr:y6Xsat-7eg4PlVwUf6IyR-5CGCsrK6h0usnb4sn0X3dT38ROpBR1Bg4KKiAX6Q>
X-ME-Proxy-Cause: dmFkZTGanw37Gl7H+UY/qwa9sgu8ZldFdK0gFO7vrPMMnDhzvv+CR4Z5hCBoD9CiDxtN7+
    HIAaFfGuZlfoo5UCG7JE+CbDI2irM6kY7c1vZrgXfXPkJf5eUIXzfSrPuJdAzrSofyTOU4
    ALro7wZXyu1FKfDKNHv5IbmacSfi81DJ1K+O8o2VfOcuIIy7QyHyoGGQtkC7N4zRzYWHKG
    Cz2jCpaNwweDVvnFPV0W2MUgASr37JCtd5y52Z5PWAbFBmYpYgmQsO1purHJYgz93cwpGw
    NDgHSzKiV+cXs4b9C1Ss5AKAlkxNUV1OzzgYXPjl11xwHjY18H54X+r0zjENuffb59ButI
    a0cqgluvKe13xiUwCD+VpfiPzY74M6vUZxB5EIPGrWblRg/uiS7cEXMnGXdI8thpJdy78M
    mLV7dr76d3AJ4Pl+q9cHCz7IbELMcHgKBhI0qoetTh/qSz/QpjYxbKcaePsrWCuXV9Jkto
    hkRXz7RitSG5/ylRDDz2qugSIqAwxDGFAWtw2qckXSvdHGz4Xym/1A1KlRqMv/Hv8NEybt
    XJadHT2TMBqGjWh+iRlgmBUtdiHxvIDg943EUJl81uBU2VMVh8nllqR5kLi0LgP0H55owL
    zT2CbNOUiKkWzFhMCH5Nk79yG2AVdGRCdVKja2wvznbV9ZKoyh4l1DBaup3Q
X-ME-Proxy: <xmx:y6XsaqqxnAYp1TQ7huqZCb95bZFD1fMvK1aeB8OjYhMlEg_W3ObvZw>
    <xmx:y6XsammpRyOH1H2648T-7lQOOcoTtEjUjXuCfIGhnvgmxRm44XciHA>
    <xmx:y6Xsahi59Jm8iNN89pt546nQ6IyKDiVYBNnRyuLouALa6hhTe3lWeQ>
    <xmx:y6Xsaue5YSaZqaYRTDaO584u_5CQazyfMCgLqMzos0EUxP6gixEXbA>
    <xmx:zKXsav6FkWe6A4Bv5z1b3UuPGduz6to2vTmBoHo13igUxuDquhSq7diW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 10:50:35 -0500 (EST)
Date: Thu, 5 Nov 2026 08:50:32 -0700
From: Alex Williamson <alex@shazbot.org>
To: "=?UTF-8?B?UGnDs3Jrb3dza2ks?= Piotr" <piotr.piorkowski@intel.com>
Cc: <kvm@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 alex@shazbot.org, Manish Honap <mhonap@nvidia.com>
Subject: Re: [RFC PATCH 0/4] vfio/pci: Allow hiding BAR ranges from the VFIO
 user
Message-ID: <20261105085032.679881ff@shazbot.org>
In-Reply-To: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 16:37:34 +0100
"Pi=C3=B3rkowski, Piotr" <piotr.piorkowski@intel.com> wrote:

> From: Piotr Pi=C3=B3rkowski <piotr.piorkowski@intel.com>
>=20
> Some devices have BAR ranges which shouldn't be exposed to the VFIO
> user, but vfio-pci exposes the memory BARs as a whole, apart from the
> MSI-X table.
>=20
> This series lets the host hide ranges of the memory BARs. Reads of a
> hidden range return ones, writes to it are dropped, the pages containing
> it are never mapped (a sparse mmap capability advertises the rest of the
> BAR), and ioeventfds and dma-bufs covering it are rejected. The ranges
> are fixed while the device is bound and listed in
> /sys/.../vfio-dev/vfioX/hidden_bar_ranges.
>=20
> The ranges can be hidden by the driver, with
> vfio_pci_core_hide_bar_ranges(), and by the host administrator, through
> configfs (CONFIG_VFIO_PCI_CONFIGFS). Only drivers which access their
> BARs exclusively through vfio-pci-core can hide ranges; vfio-pci and
> xe-vfio-pci declare it.
>=20
> Patch 1 is a preparatory refactor, patch 2 adds the core mechanism,
> patch 3 the configfs interface and patch 4 per-device-ID defaults in
> xe-vfio-pci, with no ranges defined yet.
>=20
> Sent as RFC for feedback on the approach and the interfaces.

See Manish's proposal for a generic excluded range interface to
generalize MSI-X table read/write and disable all access to CXL HDM
decoders:

https://lore.kernel.org/all/20261016161839.2765592-9-mhonap@nvidia.com/

Granting users the ability to manipulate excluded ranges through
configfs seems like a terrible idea, frankly.  Thanks,

Alex

>=20
> Piotr Pi=C3=B3rkowski (4):
>   vfio/pci: Move the excluded range handling out of
>     vfio_pci_core_do_io_rw()
>   vfio/pci: Allow hiding BAR ranges from the VFIO user
>   vfio/pci: Allow configuring hidden BAR ranges through configfs
>   vfio/xe: Hide BAR ranges by default per device ID
>=20
>  Documentation/ABI/testing/configfs-vfio-pci   |  49 +++
>  .../ABI/testing/sysfs-devices-vfio-dev        |  13 +
>  drivers/vfio/pci/Kconfig                      |  13 +
>  drivers/vfio/pci/Makefile                     |   4 +-
>  drivers/vfio/pci/nvgrace-gpu/main.c           |   4 +-
>  drivers/vfio/pci/vfio_pci.c                   |   1 +
>  drivers/vfio/pci/vfio_pci_configfs.c          | 312 +++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c              |  42 ++-
>  drivers/vfio/pci/vfio_pci_dmabuf.c            |  11 +
>  drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c | 313 ++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_priv.h              |  53 +++
>  drivers/vfio/pci/vfio_pci_rdwr.c              | 156 +++++++--
>  drivers/vfio/pci/xe/main.c                    |  60 +++-
>  include/linux/vfio_pci_core.h                 |  36 +-
>  14 files changed, 1009 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/ABI/testing/configfs-vfio-pci
>  create mode 100644 drivers/vfio/pci/vfio_pci_configfs.c
>  create mode 100644 drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c
>=20

