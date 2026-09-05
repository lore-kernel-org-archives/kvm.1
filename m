Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7731716D
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569633; cv=none; b=qKK7PxTpm61eKrOW+4pWax0ks1e/aQzM4tKyy7aGKINE2T/2vWCVNUgwO5/xe/aT6vz6E3vJEveAxp66sXL+Tx3cQgwbIYhK2gDK/+ksKROeL6K2BqSeXBc++MD4pIhVmHcKtZzIX7SOSShDVe1RG9uBsUkttPt8/Sg/68tb7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569633; c=relaxed/simple;
	bh=e8jqJtfkEVvcqgBNqFyDYGIP1VGrPAEn6FM21bkFeGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sy5jNUwG31DfZsT6iT+MY5UGaNnz5OUtXWZZqXIKzFPg6VyofyMewQnTnCr1bNcXjo0It/4GloYx2QNflM6htAjtd7bTjS8/YTXQeax48ZzEFHTELI9F+z9ljjzLeAr9Ggrgf0f+3aXk9xvcJR1tVEiyzYg1rP4TIBZA49hyLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyQ2DFAT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyQ2DFAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5B01F00A3D;
	Sat,  5 Sep 2026 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569632;
	bh=/2sabfGDxhCNHtmMGvm/l7QtQ1ezEk/yjaAhGaAeLmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyQ2DFAT+5RJ4dE3z4lwJKCR1G7m8h2MZ8KcBSMsHzDhbM+qmrvLGnu9yOIQuy8hO
	 WiSg1mIk2qs8jJ0qlW8P757mmzmACEIpmjk8LvlvJ5tM0HfvkesSdaDWZwVPBpg/AQ
	 2yHdQqNQFv7XFtB/t0VKrpR5B8XtGV9tG2e/nfmUEsI8rT8ZXckoNHtN8TvJmvTyf2
	 4Qdls5+Sc2wdoDTEdEhnO2cLDVpcOYm1073e+y6PrsKYETN/WuUs08SotgakX/Kla/
	 qNQhVNzWlkWSCgWXv033Aa9ZSeGreD44aOo5R9NEkTgUzJFDqUIvMHJ0dQu3OIAOW1
	 vj+ABnZ8BbFVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904005240.502787-1-physicalmtea@gmail.com>
References: <20260904005240.502787-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:53:51 +0000
Message-Id: <20260905005352.1E5B01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Self-deadlock (AA deadlock) in vhost_scsi_send_evt when vhost_vq_w=
ork_queue fails.
--

commit c17fff972ec26b541af9ec7b514db052328d64e6
Author: Jia Jia <physicalmtea@gmail.com>

vhost-scsi: fix event queue iov out-of-bounds

This commit fixes an array-index-out-of-bounds issue in vhost_scsi_do_evt_w=
ork()
by ensuring there is at least one input descriptor before indexing the iov =
array.
It treats pure-output chains as missed events to prevent reading past the e=
nd
of the array.

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 7a1f39a327da6..5a0863d560a07 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -608,9 +608,10 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct=
 vhost_scsi_evt *evt)
>  		return;
>  	}
> =20
> -	if ((vq->iov[out].iov_len !=3D sizeof(struct virtio_scsi_event))) {
> +	if (!in ||
> +	    vq->iov[out].iov_len !=3D sizeof(struct virtio_scsi_event)) {

[Severity: High]
This is a pre-existing issue, but while reviewing this event handling code,=
 I
noticed a potential self-deadlock scenario.

If vhost_scsi_send_evt() is called from a path that already holds vq->mutex,
like vhost_scsi_evt_handle_kick():

vhost_scsi_evt_handle_kick()
    mutex_lock(&vq->mutex);
    ...
    if (vs->vs_events_missed)
        vhost_scsi_send_evt(...)

And vhost_scsi_send_evt() falls back to vhost_scsi_complete_events() because
vhost_vq_work_queue() returns false (for instance, if vq->worker is NULL):

vhost_scsi_send_evt()
    if (!vhost_vq_work_queue(vq, &vs->vs_event_work))
        vhost_scsi_complete_events(vs, true);

vhost_scsi_complete_events() then attempts to take the exact same mutex:

vhost_scsi_complete_events()
    mutex_lock(&vq->mutex);

Could this sequence cause a self-deadlock where the kernel thread hangs
indefinitely waiting on the non-recursive vq->mutex, potentially leading to=
 a
denial of service?

>  		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> -				vq->iov[out].iov_len);
> +		       in ? vq->iov[out].iov_len : 0);
>  		vs->vs_events_missed =3D true;
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904005240.5027=
87-1-physicalmtea@gmail.com?part=3D1
